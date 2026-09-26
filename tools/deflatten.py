"""De-flatten the luast state machines back into readable code (AST-based, recursive).

Model (verified on the artifact):
    local P = nil
    P = <init>                      -- entry pc
    while true do
        [P = <C> - P]               -- optional mirror (outer machines use it)
        <dispatcher: a decision tree over P>
    end

  * the dispatcher tests the *mirrored* value S = C - P when a mirror is present,
    otherwise the raw P; state ids below follow the tested value
  * a leaf executes code and ends with `P = <value>` (jump) or `break` (exit)
  * the loop head re-applies the mirror, so fall-through and `continue` both mean
    "next state = C - <value>" (mirrored) or "next state = <value>" (plain)
  * `P = if cond then A else B` is a conditional jump
  * machines nest: an outer machine's leaf may contain inner machines (inside `for`
    or `while` bodies), which are de-flattened recursively

Usage:
    python3 tools/deflatten.py "<artifact>" --slot 970
    python3 tools/deflatten.py "<artifact>" --name SetWenMob
    python3 tools/deflatten.py "<artifact>" --all --out out/deflattened
"""

import json
import os
import re
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaast  # noqa: E402
import luascan  # noqa: E402
import luaflat  # noqa: E402
from inline_constants import build_function_legend, build_maps, find_aliases  # noqa: E402

BIG = 10 ** 9


def as_number(text):
    text = text.strip().rstrip(";").strip()
    if re.fullmatch(r"-?\d+\.?\d*", text):
        f = float(text.rstrip("."))
        return int(f) if f == int(f) else f
    return None


def pretty(text):
    text = re.sub(r"\s+", " ", text).strip()
    text = re.sub(r"\s*\.\.\s*", " .. ", text)
    text = re.sub(r"(?<=[A-Za-z_])\s*\.\s*(?=[A-Za-z_])", ".", text)
    text = re.sub(r"\s*,\s*", ", ", text)
    text = re.sub(r"\s*;\s*", "; ", text)
    text = re.sub(r"\(\s+", "(", text)
    text = re.sub(r"\s+\)", ")", text)
    text = re.sub(r"\[\s+", "[", text)
    text = re.sub(r"\s+\]", "]", text)
    text = re.sub(r"\{\s+", "{", text)
    text = re.sub(r"\s+\}", "}", text)
    text = re.sub(r"\s*:\s*", ":", text)
    text = re.sub(r"\s*=\s*", " = ", text)
    text = re.sub(r" =  = ", " == ", text)
    text = re.sub(r"~ = ", " ~= ", text)
    text = re.sub(r"\s*\*\s*", "*", text)
    text = re.sub(r"\s*<\s*=", " <= ", text)
    text = re.sub(r"\s*>\s*=", " >= ", text)
    text = re.sub(r"\s*<\s*", " < ", text)
    text = re.sub(r"\s*>\s*", " > ", text)
    text = re.sub(r"(?<![\w.])(\d+)\.(?![\d.])", r"\1", text)   # 11957. -> 11957
    text = re.sub(r"\b(then|else|elseif)0", r"\1 0", text)
    text = re.sub(r"(?<=[\w\)])(then|else|elseif|do|end)\b", r" \1", text)
    text = re.sub(r"\b(then|else|elseif|do|end|in|and|or|not|return|function|while|until|repeat|local)(?=[\w(])", r"\1 ", text)
    return text


POOL = {}


def load_pool():
    """index -> value map of the artifact's constant pool (built by tools/pool_map.py)."""
    global POOL
    if POOL:
        return POOL
    path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..",
                        "data", "pool_index.json")
    try:
        with open(path, encoding="utf-8") as fh:
            POOL = json.load(fh)
    except OSError:
        POOL = {}
    return POOL


def pool_literal(index):
    """Lua source for a pool entry, or None when it should stay a pool reference."""
    value = load_pool().get(str(index))
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, (int, float)):
        text = repr(value)
        return text[:-2] if text.endswith(".0") else text
    if isinstance(value, str):
        return '"%s"' % value.replace("\\", "\\\\").replace('"', '\\"')
    if isinstance(value, dict):
        return "F%d" % index            # flattened closure: the F-slot legend names it
    return None


def flat(text):
    return re.sub(r"\s+", "", text)


class Leaf:
    def __init__(self, lo, hi, kind="code", block=None, note=""):
        self.lo, self.hi = lo, hi
        self.kind = kind                    # code | exit | return
        self.block = block
        self.code = ""
        self.succ = []                      # [(cond or None, state)]
        self.note = note
        self.folded = set()                 # switch variables consumed by folding
        self.if_verdicts = {}               # id(If node) -> constant verdict

    @property
    def label(self):
        if self.lo == self.hi - 1:
            return "S%s" % self.lo
        if self.lo <= -BIG:
            return "S<%s" % self.hi
        if self.hi >= BIG:
            return "S>=%s" % self.lo
        return "S%s..%s" % (self.lo, self.hi - 1)


class Machine:
    def __init__(self, name, pc, C, init, mirrored=True):
        self.name = name
        self.pc = pc
        self.C = C
        self.init = init
        self.mirrored = mirrored
        self.leaves = []
        self.entry = None if init is None else (C - init if mirrored else init)
        self.prelude = []

    def next_state(self, value):
        return self.C - value if self.mirrored else value


class Flattener:
    fold_predicates = True

    def __init__(self, toks, entries, aliases):
        self.toks = toks
        self.entries = entries
        self.aliases = aliases

    # -- rendering ---------------------------------------------------------
    def raw(self, span):
        if hasattr(span, "start"):
            s, e = span.start, span.end
        elif isinstance(span, tuple):
            s, e = span
        else:
            s, e = span, span + 1
        return " ".join(t[1] for t in self.toks[s:e])

    def render(self, span, _skip_pool=False):
        text = self.raw(span)
        if not _skip_pool:
            text = self._inline(text)
        return pretty(text)

    def _inline(self, text):
        """Replace pool reads with the value they hold (exact index map)."""
        def lit(m):
            literal = pool_literal(int(float(m.group(1))))
            return literal if literal is not None else m.group(0)

        text = re.sub(r"cKb\s*\[\s*136\.?\s*\]\s*\[\s*(\d+\.?\d*)\s*\]", lit, text)
        if self.aliases:
            alt = "|".join(re.escape(a) for a in sorted(self.aliases, key=len, reverse=True))
            text = re.sub(r"(?<![A-Za-z0-9_.])(?:" + alt
                          + r")\s*\[\s*(\d+\.?\d*)\s*\]", lit, text)
        return text

    # -- machine discovery -------------------------------------------------
    def mirror_of(self, block):
        """`P = C - P` at the start of a loop body -> (pc, C); else None."""
        if isinstance(block, luaast.Block) and block.stmts:
            st = block.stmts[0]
            if isinstance(st, luaast.Assign) and len(st.targets) == 1:
                text = flat(self.render(st))
                m = re.fullmatch(r"(.+?)=(\d+\.?\d*)-(.+)", text)
                if m and m.group(1) == m.group(3):
                    return m.group(1), as_number(m.group(2))
        return None

    def dispatcher_of(self, block, pc):
        if not isinstance(block, luaast.Block) or not block.stmts:
            return None
        first = block.stmts[0]
        if isinstance(first, luaast.If) and self.mentions(first.cond, pc):
            return first
        return None

    @staticmethod
    def pc_pattern(pc):
        """Word-ish boundary that also works for pool slots like `cKb[73]`."""
        return r"(?<![A-Za-z0-9_])" + re.escape(pc) + r"(?![A-Za-z0-9_])"

    def mentions(self, span, name):
        return re.search(self.pc_pattern(name), flat(self.render(span))) is not None

    def pc_candidates(self, block, pc):
        """Loop body statements that follow the dispatcher (none expected)."""
        return []

    def build_machine(self, stmts, index, name):
        """Try to build a Machine starting at stmts[index]. Returns (machine, next_index)."""
        # find the `while true` that starts the machine
        w = None
        for k in range(index, min(index + 12, len(stmts))):
            st = stmts[k]
            if isinstance(st, luaast.While) and self.render(st.cond) == "true":
                w = (k, st)
                break
            if isinstance(st, (luaast.While, luaast.Repeat, luaast.Return)):
                break
        if w is None:
            return None
        k, while_node = w
        mirror = self.mirror_of(while_node.body)
        if mirror:
            pc, C, mirrored = mirror[0], mirror[1], True
        else:
            pc, C, mirrored = None, 0, False
        # pc + init from the statements just before the loop
        init = None
        for j in range(k - 1, max(-1, index - 13), -1):
            st = stmts[j]
            if isinstance(st, luaast.Assign) and len(st.targets) == 1 and st.values:
                target = flat(self.render(st.targets[0]))
                value = as_number(flat(self.render(st.values[0])))
                if pc is None:
                    pc = target
                    init = value
                elif target == pc and value is not None:
                    init = value
                if pc and init is not None:
                    break
            elif isinstance(st, luaast.Local) and st.names:
                if pc is None:
                    pc = st.names[0]
                elif st.names[0] == pc:
                    continue
                else:
                    break
        if pc is None:
            return None
        body = while_node.body
        if mirrored:
            rest = body.stmts[1:]
            dispatch = rest[0] if len(rest) == 1 else luaast.Block(
                body.stmts[1].start, body.stmts[-1].end, rest) if rest else None
            if isinstance(dispatch, luaast.Do):
                dispatch = dispatch.body
            elif dispatch is not None and not isinstance(dispatch, luaast.Block):
                dispatch = luaast.Block(dispatch.start, dispatch.end, rest)
        else:
            dispatch = body
        if dispatch is None or not dispatch.stmts:
            return None
        machine = Machine(name, pc, C, init, mirrored)
        self.walk(dispatch, -BIG, BIG, machine)
        self.resolve(machine)
        return machine, k + 1

    def walk(self, block, lo, hi, machine):
        node = self.dispatcher_of(block, machine.pc)
        if node is not None:
            self.walk_if(node, lo, hi, machine)
        else:
            self.add_leaf(block, lo, hi, machine)

    def walk_if(self, node, lo, hi, machine):
        cur = lo
        for cond, body in [(node.cond, node.then)] + list(node.elseifs):
            sub_lo, sub_hi = self.narrow(self.render(cond), cur, hi, machine.pc)
            if sub_lo >= sub_hi:
                sub_lo, sub_hi = cur, hi
            self.walk(body, sub_lo, sub_hi, machine)
            cur = sub_hi
            if cur >= hi:
                break
        if node.else_ is not None and cur < hi:
            self.walk(node.else_, cur, hi, machine)

    def narrow(self, cond, lo, hi, pc):
        cond = flat(cond)
        esc = re.escape(pc)
        m = re.fullmatch(esc + r"<(-?\d+\.?\d*)", cond)
        if m:
            return lo, min(hi, as_number(m.group(1)))
        m = re.fullmatch(esc + r"<=(-?\d+\.?\d*)", cond)
        if m:
            return lo, min(hi, as_number(m.group(1)) + 1)
        m = re.fullmatch(esc + r">(-?\d+\.?\d*)", cond)
        if m:
            return max(lo, as_number(m.group(1)) + 1), hi
        m = re.fullmatch(esc + r"==(-?\d+\.?\d*)", cond)
        if m:
            v = as_number(m.group(1))
            return v, v + 1
        return lo, hi

    def add_leaf(self, block, lo, hi, machine):
        machine.leaves.append(Leaf(lo, hi, block=block))

    # -- successors --------------------------------------------------------
    def resolve(self, machine):
        for leaf in machine.leaves:
            block = leaf.block
            if not isinstance(block, luaast.Block) or not block.stmts:
                leaf.kind = "exit"
                continue
            stmts = block.stmts
            i = len(stmts) - 1
            while i >= 0 and isinstance(stmts[i], luaast.Continue):
                i -= 1
            if i < 0:
                leaf.note = "bare continue"
                continue
            last = stmts[i]
            if isinstance(last, luaast.Assign) and len(last.targets) == 1 and last.values \
                    and flat(self.render(last.targets[0])) == machine.pc:
                verdicts, jump_value, folded, jump_cond = self.analyze_block(block, machine.pc)
                leaf.folded = folded
                if jump_value is not None:
                    leaf.succ = [(None, machine.next_state(jump_value))]
                    leaf.note = "opaque predicate folded (jump is unconditional)"
                    leaf.block = luaast.Block(block.start, block.end, stmts[:i])
                    leaf.if_verdicts = verdicts
                    continue
                if jump_cond is not None:
                    cond_text, vt, vf = jump_cond
                    leaf.succ = [(cond_text, machine.next_state(vt)),
                                 ("not (" + cond_text + ")", machine.next_state(vf))]
                    leaf.note = "opaque predicate reduced to its real condition"
                    leaf.block = luaast.Block(block.start, block.end, stmts[:i])
                    leaf.if_verdicts = verdicts
                    continue
                if self._jump_node(leaf, machine, last.values[-1], self.block_consts(block)):
                    leaf.block = luaast.Block(block.start, block.end, stmts[:i])
            elif isinstance(last, luaast.Break):
                leaf.kind = "exit"
                leaf.block = luaast.Block(block.start, block.end, stmts[:i])
            elif isinstance(last, luaast.Return):
                leaf.kind = "return"

    def _jump_node(self, leaf, machine, value, consts=None):
        """Interpret the value assigned to the pc variable (AST node)."""
        if isinstance(value, luaast.PrefixIf):
            verdict = self.fold_predicate(value.cond, consts or {}) if self.fold_predicates else None
            if verdict is not None:
                num = self.const_literal(value.then if verdict else value.else_)
                if num is not None:
                    leaf.succ = [(None, machine.next_state(num))]
                    leaf.note = "opaque predicate folded (always %s)" % ("true" if verdict else "false")
                    return True
            a = self.const_literal(value.then)
            b = self.const_literal(value.else_)
            c = self.render(value.cond).strip()
            if a is not None and b is not None:
                leaf.succ = [(c, machine.next_state(a)), ("not (" + c + ")", machine.next_state(b))]
                return True
            leaf.note = "conditional jump, unevaluated targets: %s" % self.render(value)
            return False
        num = self.const_literal(value)
        if num is not None:
            leaf.succ = [(None, machine.next_state(num))]
            return True
        leaf.note = "jump target not constant: " + self.render(value)
        return False

    # -- expression helpers ------------------------------------------------
    def pool_index(self, node):
        """Pool index if the node is `cKb[136][N]` or `<alias>[N]`, else None."""
        if not isinstance(node, luaast.Index) or not isinstance(node.key, luaast.Literal):
            return None
        n = as_number(node.key.text)
        if n is None:
            return None
        obj = node.obj
        if isinstance(obj, luaast.NameExpr) and self.aliases and obj.name in self.aliases:
            return int(n)
        if isinstance(obj, luaast.Index) and isinstance(obj.obj, luaast.NameExpr) \
                and obj.obj.name == "cKb" and isinstance(obj.key, luaast.Literal):
            if as_number(obj.key.text) == 136:
                return int(n)
        return None

    def const_literal(self, node):
        """Numeric value of a literal node (or of a constant-pool reference), else None."""
        if isinstance(node, luaast.Literal):
            return as_number(node.text)
        if isinstance(node, luaast.Paren):
            return self.const_literal(node.expr)
        if isinstance(node, luaast.UnOp) and node.op == "-":
            inner = self.const_literal(node.operand)
            return None if inner is None else -inner
        idx = self.pool_index(node)
        if idx is not None:
            value = load_pool().get(str(idx))
            if isinstance(value, (int, float)) and not isinstance(value, bool):
                return value
            return None
        # fall back to the rendered text: pool aliases declared in other scopes still inline
        text = flat(self.render(node))
        if re.fullmatch(r"-?\d+\.?\d*", text):
            return as_number(text)
        return None

    def const_candidates(self, node):
        """{literal} for `x = K`; {a,b} for `x = if c then a else b`; else None."""
        v = self.const_literal(node)
        if v is not None:
            return {v}
        if isinstance(node, luaast.PrefixIf):
            a, b = self.const_literal(node.then), self.const_literal(node.else_)
            if a is not None and b is not None:
                return {a, b}
        return None

    def block_consts(self, block):
        """Constant-candidate bindings declared in a block."""
        consts = {}
        if not isinstance(block, luaast.Block):
            return consts
        for st in block.stmts:
            value = None
            if isinstance(st, luaast.Assign) and len(st.values) == 1:
                value = st.values[0]
            elif isinstance(st, luaast.Local) and len(st.exprs) == 1:
                value = st.exprs[0]
            if value is None or isinstance(value, tuple):
                continue
            cands = self.const_candidates(value)
            if not cands:
                continue
            target = None
            if isinstance(st, luaast.Local) and st.names:
                target = st.names[0]
            elif isinstance(st, luaast.Assign) and len(st.targets) == 1:
                target = flat(self.render(st.targets[0]))
            if target and re.fullmatch(r"[A-Za-z_]\w*", target):
                consts[target] = cands
        return consts

    def collect_names(self, node, acc=None):
        acc = set() if acc is None else acc
        if isinstance(node, luaast.NameExpr):
            acc.add(node.name)
        elif isinstance(node, luaast.BinOp):
            self.collect_names(node.left, acc)
            self.collect_names(node.right, acc)
        elif isinstance(node, luaast.UnOp):
            self.collect_names(node.operand, acc)
        elif isinstance(node, luaast.Paren):
            self.collect_names(node.expr, acc)
        elif isinstance(node, luaast.Index):
            self.collect_names(node.obj, acc)
        return acc

    def eval_node(self, node, env):
        """Evaluate a numeric/bool expression with the given variable bindings."""
        if isinstance(node, luaast.Literal):
            n = as_number(node.text)
            if n is not None:
                return n
            if node.text == "true":
                return True
            if node.text == "false":
                return False
            return None
        if isinstance(node, luaast.NameExpr):
            return env.get(node.name)
        if isinstance(node, luaast.PrefixIf):
            cond = self.eval_node(node.cond, env)
            if cond is None:
                return None
            return self.eval_node(node.then if cond else node.else_, env)
        if isinstance(node, luaast.Paren):
            return self.eval_node(node.expr, env)
        if isinstance(node, luaast.UnOp):
            v = self.eval_node(node.operand, env)
            if v is None:
                return None
            try:
                if node.op == "-":
                    return -v
                if node.op == "not":
                    return not v
            except TypeError:
                return None
            return None
        lit = self.const_literal(node)
        if lit is not None:
            return lit
        if isinstance(node, luaast.BinOp):
            a = self.eval_node(node.left, env)
            b = self.eval_node(node.right, env)
            if a is None or b is None:
                return None
            try:
                if node.op == "+":
                    return a + b
                if node.op == "-":
                    return a - b
                if node.op == "*":
                    return a * b
                if node.op == "/":
                    return a / b
                if node.op == "//":
                    return a // b
                if node.op == "%":
                    return a % b
                if node.op == "^":
                    return a ** b
                if node.op == "==":
                    return a == b
                if node.op == "~=":
                    return a != b
                if node.op == "<":
                    return a < b
                if node.op == "<=":
                    return a <= b
                if node.op == ">":
                    return a > b
                if node.op == ">=":
                    return a >= b
                if node.op == "and":
                    return bool(a) and bool(b)
                if node.op == "or":
                    return bool(a) or bool(b)
            except (TypeError, ZeroDivisionError):
                return None
        return None

    def stmt_target_value(self, st):
        """(target_name, value_node) for a single-target Local/Assign, else (None, None)."""
        if isinstance(st, luaast.Local) and st.names and len(st.exprs) == 1:
            return st.names[0], st.exprs[0]
        if isinstance(st, luaast.Assign) and len(st.targets) == 1 and len(st.values) == 1:
            target = flat(self.render(st.targets[0]))
            if re.fullmatch(r"[A-Za-z_]\w*", target):
                return target, st.values[0]
        return None, None

    def analyze_block(self, block, pc):
        """Propagate constants across a block's switch variables and evaluate its conditions.

        The obfuscator builds predicates from variables that each hold one of two
        literals and from helpers derived from them. Simulating every combination of
        the switch variables shows whether a condition (or a jump) is constant, and
        which branch it always takes.

        Returns (if_verdicts, jump_value, folded_names).
        """
        if not isinstance(block, luaast.Block):
            return {}, None, set(), None
        import itertools
        stmts = block.stmts
        switches = {}
        for st in stmts:
            target, value = self.stmt_target_value(st)
            if target is None or isinstance(value, tuple) or target == pc:
                continue
            if isinstance(value, luaast.PrefixIf):
                cands = self.const_candidates(value)
                a, b = self.const_literal(value.then), self.const_literal(value.else_)
                if cands and len(cands) > 1 and a is not None and b is not None:
                    switches[target] = (tuple(sorted(cands)), self.render(value.cond), a, b)
        names = sorted(switches)
        if not names:
            return {}, None, set(), None
        combos = list(itertools.product(*[switches[n][0] for n in names]))
        if len(combos) > 64:
            return {}, None, set(), None

        jump_values = []
        jump_by_combo = {}
        if_results = {id(st): [] for st in stmts if isinstance(st, luaast.If)}
        for combo in combos:
            env = dict(zip(names, combo))
            for st in stmts:
                target, value = self.stmt_target_value(st)
                if isinstance(st, luaast.If):
                    v = self.eval_node(st.cond, env)
                    if v is None:
                        return {}, None, set(), None
                    if_results[id(st)].append(bool(v))
                    continue
                if target is None or value is None or isinstance(value, tuple):
                    continue
                if target == pc:
                    v = self.eval_node(value, env)
                    if v is None:
                        return {}, None, set(), None
                    jump_values.append(v)
                    jump_by_combo[combo] = v
                else:
                    v = self.eval_node(value, env)
                    if v is not None:
                        env[target] = v
        jump_value = jump_values[0] if jump_values and len(set(jump_values)) == 1 else None
        jump_cond = None
        if jump_value is None and jump_values and len(names) == 1:
            # the obfuscated predicate mirrors one switch variable: expose the real condition
            name = names[0]
            cands, cond_text, true_val, false_val = switches[name]
            by_candidate = {}
            for combo, target_value in jump_by_combo.items():
                by_candidate[combo[0]] = target_value
            if true_val in by_candidate and false_val in by_candidate:
                jump_cond = (cond_text, by_candidate[true_val], by_candidate[false_val])
        verdicts = {}
        for st in stmts:
            if isinstance(st, luaast.If):
                seen = set(if_results[id(st)])
                if len(seen) == 1 and if_results[id(st)]:
                    verdicts[id(st)] = seen.pop()
        folded = set()
        if jump_value is not None or verdicts or jump_cond:
            folded = set(names)
        return verdicts, jump_value, folded, jump_cond

    def fold_predicate(self, cond, consts, limit=4):
        """Return a constant verdict for the obfuscator's opaque predicates, else None.

        Such a predicate is built from variables that each hold one of two literals
        (`x = if c then K1 else K2`); evaluating every combination shows it is
        constant true or false.
        """
        names = self.collect_names(cond)
        if not names or len(names) > limit:
            return None
        domains = []
        for name in names:
            cands = consts.get(name)
            if not cands:
                return None
            domains.append(sorted(cands))
        import itertools
        verdict = None
        for combo in itertools.product(*domains):
            env = dict(zip(sorted(names), combo))
            value = self.eval_node(cond, env)
            if value is None:
                return None
            if verdict is None:
                verdict = bool(value)
            elif bool(value) != verdict:
                return None
        return verdict

    # -- statement rendering (expands nested machines, folds opaque predicates)
    def reparse_rhs(self, st):
        """Parse a statement's right-hand side on its own.

        Parsing the whole artifact in one pass drifts on very large blocks, which
        makes value nodes disagree with their own token span; a local re-parse from
        the `=` token is cheap and exact.
        """
        depth = 0
        for i in range(st.start, min(st.end, len(self.toks))):
            text = self.toks[i][1]
            if text in ("(", "[", "{"):
                depth += 1
            elif text in (")", "]", "}"):
                depth -= 1
            elif text == "=" and depth == 0:
                parser = luaast.ExprAstParser(self.toks)
                parser.i = i + 1
                for parse in (parser.parse_simple_expr, parser.parse_expr):
                    try:
                        return parse()
                    except Exception:                            # noqa: BLE001
                        continue
                return None
        return None

    def statement_value(self, st):
        """The single value expression of an Assign/Local statement."""
        if isinstance(st, luaast.Assign):
            if len(st.values) != 1:
                return None
            return self.reparse_rhs(st) or st.values[0]
        if isinstance(st, luaast.Local) and len(st.exprs) == 1:
            return self.reparse_rhs(st) or st.exprs[0]
        return None

    def render_call_expanded(self, call, indent, seen):
        """Render a call whose arguments include function literals, expanding bodies.

        `task.spawn(function() ... end)` and friends hide flattened machines inside
        call arguments; without this they would be printed as one unreadable line.
        """
        funcs = [a for a in call.args if isinstance(a, luaast.FunctionExpr)]
        if not funcs:
            return None
        if isinstance(call, luaast.MethodCall):
            head = "%s:%s" % (flat(self.render(call.obj)), call.method)
        else:
            head = flat(self.render(call.func))
        lines = ["%s%s(" % (indent, head)]
        for pos, arg in enumerate(call.args):
            comma = "," if pos + 1 < len(call.args) else ""
            if isinstance(arg, luaast.FunctionExpr):
                lines.append("%s    function(%s)" % (indent, ", ".join(arg.params)))
                lines.extend(self.render_stmts(arg.body, indent + "        ", seen))
                lines.append("%s    end%s" % (indent, comma))
            else:
                lines.append("%s    %s%s" % (indent, flat(self.render(arg)), comma))
        lines.append("%s)" % indent)
        return lines

    def render_stmts(self, block, indent, seen_machines=None, verdicts=None):
        if verdicts:
            self._verdicts = verdicts
        if not isinstance(block, luaast.Block):
            return [indent + self.render(block)]
        stmts = list(block.stmts)
        # pass 1: collect constant-candidate bindings for predicate folding
        consts = {}
        for st in stmts:
            value = self.statement_value(st)
            if value is None or not isinstance(st, (luaast.Assign, luaast.Local)):
                continue
            cands = self.const_candidates(value) if not isinstance(value, tuple) else None
            if cands:
                target = st.names[0] if isinstance(st, luaast.Local) and st.names else None
                if target is None and isinstance(st, luaast.Assign) and len(st.targets) == 1:
                    target = flat(self.render(st.targets[0]))
                if target and re.fullmatch(r"[A-Za-z_]\w*", target):
                    consts[target] = cands
        # pass 2: fold predicates, remember helpers that became dead
        folded, dead, i = dict(getattr(self, "_verdicts", {}) or {}), set(), 0
        while i < len(stmts):
            st = stmts[i]
            if isinstance(st, luaast.If):
                verdict = self.fold_predicate(st.cond, consts) if self.fold_predicates else None
                if verdict is not None:
                    folded[i] = verdict
                    for name in self.collect_names(st.cond):
                        dead.add(name)
            i += 1
        # general dead-helper pass: bindings that only exist to feed folded predicates.
        # Removal is transitive: a helper that is only used by other dropped helpers goes too.
        helper_stmts = {}
        helpers = set()
        for idx, st in enumerate(stmts):
            target, value = self.stmt_target_value(st)
            if target is None or value is None or isinstance(value, tuple):
                continue
            if isinstance(value, luaast.PrefixIf):
                cands = self.const_candidates(value)
                if cands and len(cands) > 1:
                    helper_stmts[idx] = target
                    helpers.add(target)
        grown = True
        while grown:
            grown = False
            for idx, st in enumerate(stmts):
                if idx in helper_stmts:
                    continue
                target, value = self.stmt_target_value(st)
                if target is None or value is None or isinstance(value, tuple):
                    continue
                if isinstance(value, (luaast.BinOp, luaast.UnOp, luaast.Paren)):
                    # pool aliases (`local cKq = cKb[136]`) are constants, not dependencies
                    names = self.collect_names(value) - set(self.aliases)
                    if names and names <= helpers:
                        helper_stmts[idx] = target
                        helpers.add(target)
                        grown = True
        drop = set(helper_stmts)
        changed = True
        while changed:
            changed = False
            for idx, name in list(helper_stmts.items()):
                if idx not in drop:
                    continue
                uses = 0
                for j, st in enumerate(stmts):
                    if j == idx:
                        continue
                    if not re.search(r"\b" + re.escape(name) + r"\b", self.render(st)):
                        continue
                    if j in drop:
                        continue          # referenced only by statements we are dropping
                    uses += 1
                if uses > 0:              # still needed somewhere -> keep it
                    drop.discard(idx)
                    changed = True
        dead |= {helper_stmts[i] for i in drop}
        droppable = drop

        # pass 3: render
        out, i = [], 0
        while i < len(stmts):
            st = stmts[i]
            if i in folded:
                out.append("%s-- [opaque predicate folded: always %s]"
                           % (indent, "true" if folded[i] else "false"))
                branch = st.then if folded[i] else st.else_
                if branch is not None and branch.stmts:
                    out.extend(self.render_stmts(branch, indent, seen_machines))
                i += 1
                continue
            if i in droppable:
                out.append("%s-- [dropped obfuscation helper: %s]" % (indent, self.render(st)))
                i += 1
                continue
            if isinstance(st, (luaast.Local, luaast.Assign)):
                target, value = self.stmt_target_value(st)
                if target and target in self.aliases and isinstance(value, luaast.Index) \
                        and flat(self.render(value)) == "cKb[136]":
                    out.append("%s-- (constant pool alias %s)" % (indent, target))
                    i += 1
                    continue
            if isinstance(st, (luaast.Assign, luaast.Local)):
                value = self.statement_value(st)
                target = (st.names[0] if isinstance(st, luaast.Local) and st.names else
                          flat(self.render(st.targets[0])) if isinstance(st, luaast.Assign) and len(st.targets) == 1 else None)
                if target and target in dead and isinstance(value, luaast.PrefixIf):
                    out.append("%s-- [dropped helper: %s]" % (indent, target))
                    i += 1
                    continue
                if isinstance(value, (luaast.Call, luaast.MethodCall)) \
                        and isinstance(getattr(value, "args", None), list) \
                        and any(isinstance(a, luaast.FunctionExpr) for a in value.args):
                    expanded = self.render_call_expanded(value, indent + "    ", seen_machines)
                    if expanded is not None:
                        text = flat(self.render(st))
                        head = text[:text.find("=") + 1] if "=" in text else ""
                        expanded[0] = "%s%s %s" % (indent, head,
                                                   expanded[0].strip() or "")
                        out.extend(expanded)
                        i += 1
                        continue
                if isinstance(value, luaast.FunctionExpr):
                    lhs = self.render(st)[:self.render(st).find("function")]
                    out.append("%s%send" % (indent, ""))
                    out[-1] = "%s%sfunction(%s)" % (indent, lhs, ", ".join(value.params))
                    out.extend(self.render_stmts(value.body, indent + "    ", seen_machines))
                    out.append(indent + "end")
                    i += 1
                    continue
            if isinstance(st, luaast.ExprStmt) and isinstance(st.expr, luaast.Call):
                expanded = self.render_call_expanded(st.expr, indent, seen_machines)
                if expanded is not None:
                    out.extend(expanded)
                    i += 1
                    continue
            built = self.build_machine(stmts, i, "nested%d" % i)
            if built and built[0] is not None:
                machine, nxt = built
                out.append("%s-- nested state machine (pc=%s, entry=%s)"
                           % (indent, machine.pc, machine.entry))
                out.extend(self.render_machine(machine, indent + "    "))
                i = nxt
                continue
            if isinstance(st, (luaast.NumericFor, luaast.GenericFor)):
                head = self.render(st)
                head = head[:head.find(" do ")] + " do" if " do " in head else head
                out.append(indent + head)
                out.extend(self.render_stmts(st.body, indent + "    ", seen_machines))
                out.append(indent + "end")
            elif isinstance(st, luaast.While):
                out.append(indent + "while %s do" % self.render(st.cond))
                out.extend(self.render_stmts(st.body, indent + "    ", seen_machines))
                out.append(indent + "end")
            elif isinstance(st, luaast.Repeat):
                out.append(indent + "repeat")
                out.extend(self.render_stmts(st.body, indent + "    ", seen_machines))
                out.append(indent + "until %s" % self.render(st.cond))
            elif isinstance(st, luaast.Do):
                out.append(indent + "do")
                out.extend(self.render_stmts(st.body, indent + "    ", seen_machines))
                out.append(indent + "end")
            elif isinstance(st, luaast.If):
                out.extend(self.render_if(st, indent, seen_machines))
            else:
                out.append(indent + self.render(st))
            i += 1
        return out

    def render_if(self, node, indent, seen_machines):
        out = []
        branches = [(node.cond, node.then, "if")] + [(c, b, "elseif") for c, b in node.elseifs]
        for cond, body, kw in branches:
            out.append("%s%s %s then" % (indent, kw, self.render(cond)))
            out.extend(self.render_stmts(body, indent + "    ", seen_machines))
        if node.else_ is not None:
            out.append(indent + "else")
            out.extend(self.render_stmts(node.else_, indent + "    ", seen_machines))
        out.append(indent + "end")
        return out

    def render_machine(self, machine, indent, states=None, unresolved=None):
        out = []
        if machine.prelude:
            out.append(indent + "-- locals: " + "; ".join(machine.prelude))
        leaves = machine.leaves if states is None else [l for l in machine.leaves
                                                        if l.lo in states]
        if states is not None:
            out.append("%s-- %d of %d states reachable from entry %s (junk states pruned)"
                       % (indent, len(leaves), len(machine.leaves), machine.entry))
        for leaf in sorted(leaves, key=lambda l: (l.lo, l.hi)):
            out.append("%s-- state %s" % (indent, leaf.label))
            if leaf.block is not None and leaf.block.stmts:
                self._verdicts = getattr(leaf, "if_verdicts", {}) or {}
                self._folded = getattr(leaf, "folded", set()) or set()
                out.extend(self.render_stmts(leaf.block, indent + "  ", set()))
                self._verdicts = {}
                self._folded = set()
            if leaf.kind == "exit":
                out.append("%s  --> EXIT" % indent)
            elif leaf.kind == "return":
                out.append("%s  --> RETURN" % indent)
            else:
                known = {l.lo for l in machine.leaves}
                for cond, target in leaf.succ:
                    extra = "" if target in known else "  (outside dispatcher -> EXIT)"
                    if unresolved is not None and (leaf.lo, target) in unresolved:
                        extra += "   [runtime-dependent]"
                    if cond:
                        out.append("%s  --> if %s then goto %s%s" % (indent, cond, target, extra))
                    else:
                        out.append("%s  --> goto %s%s" % (indent, target, extra))
                if leaf.note:
                    out.append("%s  -- %s" % (indent, leaf.note))
        return out


def slot_spans(toks):
    import luaflat
    target = None
    for i in range(len(toks) - 5):
        if (toks[i][1] == "cKb" and toks[i + 1][1] == "[" and toks[i + 2][1] == "136"
                and toks[i + 3][1] == "]" and toks[i + 4][1] == "=" and toks[i + 5][1] == "{"):
            target = i + 5
            break
    p = luaflat.PoolParser(toks)
    p.i = target
    p.parse_table()
    return {n: (s, e) for n, (k, s, e) in enumerate(p.spans, 1)}


_SPAN_CACHE = {}


def build(src, toks, entries, aliases, slot):
    if "spans" not in _SPAN_CACHE:
        _SPAN_CACHE["spans"] = slot_spans(toks)
    spans = _SPAN_CACHE["spans"]
    if slot not in spans:
        return None, None
    s, e = spans[slot]
    if toks[s][1] != "function":
        return None, None
    fl = Flattener(toks, entries, aliases)
    p = luaast.ExprAstParser(toks)
    p.i = s + 1
    params, body = p.parse_body_after_keyword()
    built = fl.build_machine(body.stmts, 0, "F%d" % slot)
    machine = built[0] if built else None
    if machine:
        machine.params = params
        machine.prelude = [fl.render(st) for st in body.stmts
                           if isinstance(st, (luaast.Local, luaast.Assign))
                           and flat(fl.render(st)) != "%s=nil" % machine.pc]
    return fl, machine


def sub_pool(fl, text):
    """Replace `cKb[136][N]` / `<alias>[N]` reads with the pool value they hold."""
    def full(m):
        literal = pool_literal(int(m.group(1)))
        return literal if literal is not None else m.group(0)

    text = re.sub(r"cKb\s*\[\s*136\.?\s*\]\s*\[\s*(\d+)\.?\s*\]", full, text)
    if fl.aliases:
        names = "|".join(re.escape(a) for a in sorted(fl.aliases, key=len, reverse=True))
        pattern = re.compile(r"(?<![A-Za-z0-9_.])(?:%s)\s*\[\s*(\d+)\.?\s*\]" % names)

        def alias(m):
            literal = pool_literal(int(m.group(1)))
            return literal if literal is not None else m.group(0)

        text = pattern.sub(alias, text)
    return text


def render_full(fl, machine):
    head = "-- %s(params: %s)  states=%d  pc=%s  %s  entry=%s" % (
        machine.name, ", ".join(machine.params) or "-", len(machine.leaves), machine.pc,
        ("C=%s" % machine.C) if machine.mirrored else "not mirrored", machine.entry)
    return sub_pool(fl, "\n".join([head] + fl.render_machine(machine, "")))


def build_main(src, toks, entries, aliases):
    """De-flatten the top-level state machine(s) of the script (the engine)."""
    import luaast as _ast
    root, _ = _ast.parse_exprs(src)
    fl = Flattener(toks, entries, aliases)
    machines = []
    i = 0
    stmts = root.stmts
    while i < len(stmts):
        built = fl.build_machine(stmts, i, "MAIN%d" % (len(machines) + 1))
        if built and built[0] is not None:
            m, nxt = built
            m.params = ["top-level chunk"]
            machines.append(m)
            i = nxt
            continue
        i += 1
    return fl, machines


def main(path, argv):
    src = open(path, encoding="utf-8", errors="replace").read()
    pool_expr = argv[argv.index("--poolref") + 1] if "--poolref" in argv else None
    entries, values, kinds, toks = build_maps(src, pool_expr=pool_expr)

    aliases = find_aliases(toks)
    folded_count = [0]

    def build_slot(slot):
        return build(src, toks, entries, aliases, slot)

    if "--main" in argv:
        aliases = find_aliases(toks)
        fl, machines = build_main(src, toks, entries, aliases)
        legend = {}
        if os.path.exists("data/pool.json"):
            import json
            raw = json.load(open("data/pool.json"))
            legend = {int(k): v for k, v in raw.get("function_names", {}).items()}
        out = ["-- Top-level (engine) state machines of %s" % path,
               "-- %d machine(s); state ids are the values the dispatcher tests" % len(machines), ""]
        if legend:
            out.append("-- FUNCTION LEGEND (pool slot -> names)")
            for slot in sorted(legend):
                out.append("--   F%s -> %s" % (slot, ", ".join(legend[slot])[:100]))
            out.append("")
        for m in machines:
            out.extend(sub_pool(fl, "\n".join(fl.render_machine(m, ""))).split("\n"))
            out.append("")
        text = "\n".join(out)
        target = argv[argv.index("--main") + 1] if len(argv) > argv.index("--main") + 1 \
            and not argv[argv.index("--main") + 1].startswith("--") else None
        folded = sum(1 for m in machines for l in m.leaves if "opaque predicate" in (l.note or ""))
        if target:
            open(target, "w").write(text)
            print("wrote %s (%d chars, %d machines, %d opaque predicates folded)"
                  % (target, len(text), len(machines), folded))
        else:
            print(text)
        return
    if "--pool" in argv:
        slot = int(argv[argv.index("--pool") + 1])
        toks = list(luaflat.tokenize(src))
        alias = pool_expr or "cKb[136]"
        if len(argv) > argv.index("--pool") + 2 and not argv[argv.index("--pool") + 2].startswith("--"):
            alias = argv[argv.index("--pool") + 2]
        starts = [i + 1 for i in range(len(toks))
                  if toks[i][1] == "="
                  and "".join(t[1] for t in toks[max(0, i - 4):i]).endswith(alias)
                  and i + 1 < len(toks) and toks[i + 1][1] == "{"]
        fields = []
        for start in starts:
            end = luascan.table_end(toks, start)
            fields.extend(luascan.scan_fields(toks, start, end))
        if slot > len(fields):
            print("pool has only %d fields" % len(fields))
            return
        key, raw, a, b = fields[slot - 1]
        print("-- pool [%d] = %s" % (slot, raw[:120].replace("\n", " ")))
        fl = Flattener(toks, entries, aliases)
        parser = luaast.ExprAstParser(toks)
        parser.i = a
        try:
            node = parser.parse_simple_expr()
        except Exception as exc:                                 # noqa: BLE001
            print("-- (could not parse: %s)" % exc)
            return
        if isinstance(node, luaast.FunctionExpr):
            if node.params:
                print("function(%s)" % ", ".join(node.params))
            print("\n".join(fl.render_stmts(node.body, "  ", set())))
        else:
            print(fl.render(node))
        return
    if "--slot" in argv:
        slot = int(argv[argv.index("--slot") + 1])
        fl, machine = build_slot(slot)
        print(render_full(fl, machine) if machine else "slot %s is not a state machine" % slot)
        return
    if "--name" in argv:
        want = argv[argv.index("--name") + 1]
        legend = build_function_legend(open("ouroboros_ps2_resolved.lua", encoding="utf-8",
                                            errors="replace").read()) \
            if os.path.exists("ouroboros_ps2_resolved.lua") else {}
        hits = [(slot, names) for slot, names in legend.items() if want in names]
        if not hits:
            print("no slot registered under %r" % want)
            return
        for slot, names in hits:
            fl, machine = build_slot(slot)
            print("/* %s */" % ", ".join(names))
            print(render_full(fl, machine) if machine else "slot %s is not a state machine" % slot)
        return
    combined = argv[argv.index("--combined") + 1] if "--combined" in argv else None
    out_dir = argv[argv.index("--out") + 1] if "--out" in argv else "out/deflattened"
    if not combined:
        os.makedirs(out_dir, exist_ok=True)
    spans = _SPAN_CACHE.get("spans") or slot_spans(toks)
    index, ok, plain, chunks = [], 0, 0, []
    for slot, (s, e) in sorted(spans.items()):
        if toks[s][1] != "function":
            continue
        try:
            fl, machine = build_slot(slot)
        except Exception as exc:                      # noqa: BLE001
            index.append("%d\tFAILED\t%s" % (slot, exc))
            continue
        if not machine:
            plain += 1
            continue
        ok += 1
        folded_count[0] += sum(1 for l in machine.leaves
                               if "opaque predicate" in (l.note or ""))
        text = render_full(fl, machine)
        if combined:
            chunks.append(text)
        else:
            open(os.path.join(out_dir, "F%d.txt" % slot), "w").write(text)
        index.append("%d\t%d states" % (slot, len(machine.leaves)))
    if combined:
        with open(combined, "w") as fh:
            fh.write("-- De-flattened Ouroboros state machines\n"
                     "-- generated by tools/deflatten.py from %s\n"
                     "-- %d machines; pool functions that are already plain are skipped\n"
                     "-- state ids are the values the dispatcher tests; `goto N` jumps to state N\n\n"
                     % (path, ok))
            fh.write("-- INDEX\n-- " + "\n-- ".join(index) + "\n\n")
            fh.write("\n\n".join(chunks))
        print("wrote %s" % combined)
        return
    open(os.path.join(out_dir, "INDEX.txt"), "w").write("\n".join(index))
    print("de-flattened %d machines -> %s (%d pool functions are plain, not flattened; "
          "%d opaque predicates folded)" % (ok, out_dir, plain, folded_count[0]))


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "ouroboros_ps2 (1).luau", sys.argv)
