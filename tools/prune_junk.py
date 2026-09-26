"""Prune the junk-state maze of the flattened main machine.

The luast obfuscator flattens control flow into a dispatcher whose program counter is
often a pool slot (e.g. `cKb[73]`), and it sprinkles junk states guarded by conditions
over a throwaway counter variable (`cKb[21] = (cKb[21] + 39) % 56`) plus constant
arithmetic. Those conditions are decidable as soon as the counter value on entry is
known, so a small path simulation from the entry state marks the reachable states and
resolves every counter-only edge. Everything else is left flagged as ambiguous.

Usage:
    python3 tools/prune_junk.py "<artifact>" [--out FILE]
"""

import ast as pyast
import re
import sys
from collections import deque

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaast  # noqa: E402
import deflatten as D  # noqa: E402
from inline_constants import build_maps  # noqa: E402


ALLOWED_BINOPS = (pyast.Add, pyast.Sub, pyast.Mult, pyast.Div, pyast.FloorDiv,
                  pyast.Mod, pyast.Pow, pyast.BitAnd, pyast.BitOr, pyast.BitXor,
                  pyast.LShift, pyast.RShift)


def eval_numeric(text, env):
    """Evaluate a numeric Lua expression with a restricted Python evaluator."""
    text = re.sub(r"(?<![\w.])(\d+)\.(?![\d.])", r"\1", text.strip())
    text = text.replace("~=", "!=")
    if re.search(r"[^0-9A-Za-z_+\-*/%.()<>=!&|~, \t\n]", text):
        return None

    def check(node):
        if isinstance(node, pyast.Expression):
            return check(node.body)
        if isinstance(node, pyast.Constant):
            return isinstance(node.value, (int, float, bool))
        if isinstance(node, pyast.Name):
            return node.id in env
        if isinstance(node, pyast.BinOp):
            return isinstance(node.op, ALLOWED_BINOPS) and check(node.left) and check(node.right)
        if isinstance(node, pyast.UnaryOp):
            return isinstance(node.op, (pyast.USub, pyast.UAdd, pyast.Invert)) and check(node.operand)
        if isinstance(node, pyast.Compare):
            return check(node.left) and all(check(v) for v in node.comparators)
        if isinstance(node, pyast.BoolOp):
            return all(check(v) for v in node.values)
        return False

    try:
        tree = pyast.parse(text, mode="eval")
    except SyntaxError:
        return None
    if not check(tree):
        return None
    try:
        return eval(compile(tree, "<cond>", "eval"), {"__builtins__": {}}, env)  # noqa: S307
    except Exception:                                            # noqa: BLE001
        return None


class Edge:
    def __init__(self, cond, target, raw):
        self.cond, self.target, self.raw = cond, target, raw


class Simulator:
    def __init__(self, fl, machine, counter):
        self.fl, self.machine, self.counter = fl, machine, counter
        self.by_lo = {leaf.lo: leaf for leaf in machine.leaves}
        self.edges = {}          # state -> [Edge]
        self.updates = {}        # state -> (target, expr) or None
        self.ambiguous = set()
        self.reachable = {}

    # -- static extraction -------------------------------------------------
    def analyse(self):
        for leaf in self.machine.leaves:
            state = leaf.lo
            edges = []
            for cond, target in leaf.succ:
                edges.append(Edge(None if cond is None else D.flat(cond), target, cond))
            self.edges[state] = edges
            self.updates[state] = self.counter_update(leaf)
        return self

    def counter_update(self, leaf):
        """Detect `X = f(X)` or `X = const` at the end of a leaf for the counter X."""
        if leaf.block is None:
            return None
        for st in reversed(leaf.block.stmts):
            if not isinstance(st, luaast.Assign) or len(st.targets) != 1 or not st.values:
                continue
            target = D.flat(self.fl.render(st.targets[0]))
            if target != self.counter:
                continue
            value = D.flat(self.fl.render(st.values[0]))
            if self.counter in value or re.fullmatch(r"nil", value):
                return value
        return None

    # -- simulation --------------------------------------------------------
    def run(self, max_values=64):
        entry = self.machine.entry
        if entry is None:
            return False
        seen = {entry: {0}}          # counter starts unknown -> 0 placeholder
        queue = deque([(entry, 0)])
        while queue:
            state, counter = queue.popleft()
            env = {self.counter: counter}
            update = self.updates.get(state)
            next_counter = counter
            if update is not None:
                if update == "nil":
                    next_counter = 0
                else:
                    val = eval_numeric(self.counter_rewrite(update), env)
                    if val is None:
                        next_counter = None
                    else:
                        next_counter = val
            for edge in self.edges.get(state, []):
                if edge.cond is None:
                    targets = [edge.target]
                else:
                    text = self.counter_rewrite(edge.cond)
                    verdict = eval_numeric(text, env)
                    if verdict is None:
                        # runtime-dependent: flag it, but still follow the branch
                        self.ambiguous.add((state, edge.cond, edge.target))
                        targets = [edge.target]
                    else:
                        targets = [edge.target] if verdict else []
                for target in targets:
                    self.reachable.setdefault(state, set()).add(target)
                    if next_counter is None:
                        continue
                    bucket = seen.setdefault(target, set())
                    if len(bucket) >= max_values:
                        continue
                    if next_counter not in bucket:
                        bucket.add(next_counter)
                        queue.append((target, next_counter))
        return True

    def counter_rewrite(self, text):
        """`(cKb[21] + 39) % 56` -> a Python expression for the counter value."""
        return text.replace(self.counter, "x").replace("and", " and ").replace("or", " or ")


def find_counter(fl, machine):
    """The pool slot / local that behaves like the flattening counter."""
    counts = {}
    for leaf in machine.leaves:
        if leaf.block is None:
            continue
        for st in leaf.block.stmts:
            if not isinstance(st, luaast.Assign) or len(st.targets) != 1 or not st.values:
                continue
            target = D.flat(fl.render(st.targets[0]))
            value = D.flat(fl.render(st.values[0]))
            if target == value or target not in value:
                continue
            counts[target] = counts.get(target, 0) + 1
    if not counts:
        return None
    return max(counts, key=lambda k: counts[k])


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "ouroboros_ps2 (1).luau"
    src = open(path, encoding="utf-8", errors="replace").read()
    entries, values, kinds, toks = build_maps(src)
    fl, machines = D.build_main(src, toks, entries, D.find_aliases(toks))
    machine = machines[0]
    counter = find_counter(fl, machine)
    print("machines=%d states=%d counter=%s" % (len(machines), len(machine.leaves), counter))
    sim = Simulator(fl, machine, counter).analyse()
    sim.run()
    print("reachable states: %d of %d" % (len(sim.reachable), len(machine.leaves)))
    print("unresolved (runtime-dependent) edges: %d" % len(sim.ambiguous))
    out = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
    if out:
        states = set(sim.reachable)
        unresolved = {(st, tgt) for st, _cond, tgt in sim.ambiguous}
        rendered = "\n".join(fl.render_machine(machine, "", states=states,
                                               unresolved=unresolved))
        text = D.sub_pool(fl, rendered)
        open(out, "w").write(text)
        print("wrote %s (%d chars, %d states)" % (out, len(text), len(states)))


if __name__ == "__main__":
    main()
