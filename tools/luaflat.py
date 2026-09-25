"""Tools for the luast-flattened Ouroboros artifact (ouroboros_ps2 (1).luau).

Format recap (verified against the file):
  * `cKb[136] = { <literal>, <literal>, ... }` is a single positional constant pool.
    Everything the script needs (strings, numbers, instances, functions) lives there.
  * Code reads the pool positionally: `cKb[136][1856]`, and often aliases it first
    with `local cTz = cKb[136]` and then reads `cTz[1856]`.
  * `cKb[<n>]` slots other than 136 double as local variables / program counters.
  * Each original function was flattened into a state machine:
        local cq_ = nil; cq_ = 1
        while true do cq_ = 2315 - cq_; do if cq_ < 2313. then ... end end

This module tokenises the file, parses the pool, and can inline pool references so
the flattened code becomes readable again.
"""

import re
import json

NAME = re.compile(r"[A-Za-z_][A-Za-z0-9_]*")
NUMBER = re.compile(r"0[xX][0-9a-fA-F]+|\d+\.?\d*(?:[eE][-+]?\d+)?|\.\d+")
LONG_OPEN = re.compile(r"\[(=*)\[")

OPENERS = {"function", "if", "do", "repeat"}
CLOSERS = {"end", "until"}


def tokenize(s):
    """Yield (kind, text, start, end). kinds: str, longstr, num, name, sym."""
    i, n = 0, len(s)
    while i < n:
        c = s[i]
        if c in " \t\r\n":
            i += 1
            continue
        if c == "-" and s.startswith("--", i):
            m = LONG_OPEN.match(s, i + 2)
            if m:
                close = "]" + m.group(1) + "]"
                j = s.find(close, m.end())
                i = n if j < 0 else j + len(close)
            else:
                j = s.find("\n", i)
                i = n if j < 0 else j
            continue
        if c in "\"'":
            q, j = c, i + 1
            while j < n:
                if s[j] == "\\":
                    j += 2
                    continue
                if s[j] == q:
                    break
                j += 1
            yield ("str", s[i:j + 1], i, j + 1)
            i = j + 1
            continue
        if c == "[":
            m = LONG_OPEN.match(s, i)
            if m:
                close = "]" + m.group(1) + "]"
                j = s.find(close, m.end())
                j = n if j < 0 else j + len(close)
                yield ("longstr", s[i:j], i, j)
                i = j
                continue
        m = NUMBER.match(s, i)
        if m:
            yield ("num", m.group(0), i, m.end())
            i = m.end()
            continue
        m = NAME.match(s, i)
        if m:
            yield ("name", m.group(0), i, m.end())
            i = m.end()
            continue
        for op in ("...", "..=", "..", "==", "~=", "<=", ">=", "//", "+=", "-=", "*=", "/=", "%=", "^=", "::"):
            if s.startswith(op, i):
                yield ("sym", op, i, i + len(op))
                i += len(op)
                break
        else:
            yield ("sym", c, i, i + 1)
            i += 1


# Tokens after which an `if` starts an *expression* (Luau `if c then a else b`),
# not a statement block. Anything else means the `if` opens a block closed by `end`.
EXPR_POSITION = set("= ( [ { , ; return and or not + - * / % ^ .. < > <= >= == ~= # then else")


def _is_expression_if(toks, i):
    """True when toks[i] == 'if' is the Luau prefix-if *expression* (no matching `end`)."""
    j = i - 1
    while j >= 0 and toks[j][0] == "sym" and toks[j][1] in ("\n",):
        j -= 1
    if j < 0:
        return False
    prev = toks[j][1]
    return (prev in EXPR_POSITION) or (prev in ("return", "and", "or", "not", "then", "else"))


def _skip_function(toks, i):
    """toks[i] is 'function' (or 'do'/'if'/'repeat'); return index after matching closer."""
    depth = 0
    while i < len(toks):
        k, t = toks[i][0], toks[i][1]
        if k == "name":
            if t == "if" and _is_expression_if(toks, i):
                i += 1
                continue
            if t in OPENERS:
                depth += 1
            elif t in CLOSERS:
                depth -= 1
                if depth <= 0:
                    return i + 1
        i += 1
    return i


def _skip_expression(toks, i):
    """Skip one expression (function call, index chain, table, ...) until , or } at depth 0."""
    depth = 0
    while i < len(toks):
        k, t = toks[i][0], toks[i][1]
        if k == "name" and t in OPENERS:
            i = _skip_function(toks, i)
            continue
        if t in "([{":
            depth += 1
        elif t in ")]}":
            if depth == 0:
                return i
            depth -= 1
        elif t == "," and depth == 0:
            return i
        elif k == "name" and t in CLOSERS and depth == 0:
            return i
        i += 1
    return i


def parse_table(toks, i):
    """toks[i] must be '{'. Returns (entries, next_index). entries: list of (key_or_None, raw_text)."""
    assert toks[i][1] == "{", toks[i]
    i += 1
    entries = []
    while i < len(toks):
        k, t = toks[i][0], toks[i][1]
        if t == "}":
            return entries, i + 1
        if t == ",":
            i += 1
            continue
        key = None
        if k == "name" and i + 1 < len(toks) and toks[i + 1][1] == "=":
            key = t
            i += 2
        elif t == "[":
            close = i
            depth = 0
            while close < len(toks):
                if toks[close][1] == "[":
                    depth += 1
                elif toks[close][1] == "]":
                    depth -= 1
                    if depth == 0:
                        break
                close += 1
            key = "".join(x[1] for x in toks[i:close + 1])
            i = close + 1
            if i < len(toks) and toks[i][1] == "=":
                i += 1
        start = i
        end = _skip_expression(toks, i)
        if end <= start:          # defensive: never let the cursor stall
            end = start + 1
        raw = "".join(x[1] for x in toks[start:end])
        entries.append((key, raw.strip()))
        i = end
    return entries, i


def find_assignments(s, targets):
    """Find `name = {` and `name[key] = {` assignments.

    Returns (tokens, {(name, key_or_None): brace_token_index}).
    """
    toks = list(tokenize(s))
    found = {}
    i = 0
    while i < len(toks) - 2:
        k, t = toks[i][0], toks[i][1]
        if k == "name" and t in targets:
            if toks[i + 1][1] == "=" and toks[i + 2][1] == "{":
                found[(t, None)] = i + 2
                i += 3
                continue
            if toks[i + 1][1] == "[":
                j, depth = i + 1, 0
                while j < len(toks):
                    if toks[j][1] == "[":
                        depth += 1
                    elif toks[j][1] == "]":
                        depth -= 1
                        if depth == 0:
                            break
                    j += 1
                if j + 2 < len(toks) and toks[j + 1][1] == "=" and toks[j + 2][1] == "{":
                    key = "".join(x[1] for x in toks[i + 2:j])
                    found[(t, key)] = j + 2
                    i = j + 3
                    continue
        i += 1
    return toks, found


if __name__ == "__main__":
    import sys

    path = sys.argv[1] if len(sys.argv) > 1 else "ouroboros_ps2 (1).luau"
    src = open(path, encoding="utf-8", errors="replace").read()
    toks, found = find_assignments(src, {"cKb"})
    keys = [(k, v) for k, v in found.items() if k[0] == "cKb"]
    print("cKb table assignments:", len(keys))
    pool_entries = None
    idx = found.get(("cKb", "136"))
    if idx is not None:
        pool_entries, after = parse_table(toks, idx)
        print("pool entries:", len(pool_entries))
    if pool_entries:
        literals = sum(1 for _, v in pool_entries if v.startswith('"'))
        numbers = sum(1 for _, v in pool_entries if re.fullmatch(NUMBER, v))
        print("string literals:", literals, "numbers:", numbers)
        for i in (1, 2, 3, 10, 100, 5425, 5429, 5636, 6629):
            if i <= len(pool_entries):
                print(f"  [{i}] = {pool_entries[i-1][1][:90]}")


# ---------------------------------------------------------------------------
# Recursive-descent parser (subset of Luau sufficient for the flattened artifact)
# ---------------------------------------------------------------------------

BINOP = {
    "or": (1, "left"), "and": (2, "left"),
    "<": (3, "left"), ">": (3, "left"), "<=": (3, "left"), ">=": (3, "left"),
    "~=": (3, "left"), "==": (3, "left"),
    "..": (4, "right"),
    "+": (5, "left"), "-": (5, "left"),
    "*": (6, "left"), "/": (6, "left"), "//": (6, "left"), "%": (6, "left"),
    "^": (8, "right"),
}
UNOP = {"not", "-", "#"}
COMPOUND = {"+=", "-=", "*=", "/=", "%=", "^=", "..="}
BLOCK_END = {"end", "else", "elseif", "until"}


class ParseError(Exception):
    pass


class Parser:
    def __init__(self, toks):
        self.t = toks
        self.i = 0

    # -- token helpers ----------------------------------------------------
    def peek(self, k=0):
        return self.t[self.i + k] if self.i + k < len(self.t) else ("eof", "", 0, 0)

    def val(self, k=0):
        return self.peek(k)[1]

    def kind(self, k=0):
        return self.peek(k)[0]

    def next(self):
        tok = self.peek()
        self.i += 1
        return tok

    def accept(self, v):
        if self.val() == v:
            self.i += 1
            return True
        return False

    def expect(self, v):
        if not self.accept(v):
            raise ParseError(f"expected {v!r} got {self.val()!r} at {self.peek()[2]}")

    # -- expressions ------------------------------------------------------
    def parse_expr(self, min_prec=1):
        if self.val() in UNOP:                 # not / - / #  (unary)
            self.next()
            self.parse_expr(7)
        else:
            self.parse_simple()
        while True:
            op = self.val()
            if op not in BINOP:
                break
            prec, assoc = BINOP[op]
            if prec < min_prec:
                break
            self.next()
            self.parse_expr(prec + (1 if assoc == "left" else 0))

    def parse_simple(self):
        k, v = self.kind(), self.val()
        if k in ("str", "longstr", "num"):
            self.next()
            return
        if v in ("nil", "true", "false", "..."):
            self.next()
            return
        if v == "function":
            self.parse_function_body()
            return
        if v == "{":
            self.parse_table()
            return
        if v == "if":                      # Luau prefix-if expression
            self.next()
            self.parse_expr()
            self.expect("then")
            self.parse_expr()
            self.expect("else")
            self.parse_expr()
            return
        if v == "(":
            self.next()
            self.parse_expr()
            self.expect(")")
            self.parse_suffixes()
            return
        if k == "name":
            self.next()
            self.parse_suffixes()
            return
        raise ParseError(f"unexpected token {v!r} at {self.peek()[2]}")

    def parse_suffixes(self):
        while True:
            v = self.val()
            if v == ".":
                self.next(); self.next()
            elif v == "[":
                self.next(); self.parse_expr(); self.expect("]")
            elif v == ":":
                self.next(); self.next(); self.parse_args()
            elif v in ("(", "{"):
                self.parse_args()
            elif self.kind() in ("str", "longstr"):
                self.next()                    # f"string" call sugar
            else:
                break

    def parse_args(self):
        if self.val() == "(":
            self.next()
            if self.val() != ")":
                while True:
                    self.parse_expr()
                    if not self.accept(","):
                        break
            self.expect(")")
        elif self.val() == "{":
            self.parse_table()
        elif self.kind() in ("str", "longstr"):
            self.next()
        else:
            raise ParseError(f"bad call args {self.val()!r} at {self.peek()[2]}")

    def parse_table(self):
        self.expect("{")
        while self.val() != "}":
            v = self.val()
            if v == "[":
                self.next(); self.parse_expr(); self.expect("]"); self.expect("="); self.parse_expr()
            elif self.kind() == "name" and self.val(1) == "=":
                self.next(); self.next(); self.parse_expr()
            else:
                self.parse_expr()
            if not self.accept(",") and not self.accept(";"):
                break
        self.expect("}")

    def parse_function_body(self):
        self.expect("function")
        self.parse_body_after_keyword()

    def parse_body_after_keyword(self):
        if self.accept("("):
            while self.val() != ")":
                self.next()                    # name or ...
                if self.accept(":"):
                    self.next()                # type annotation (name) - ignore types crudely
                if not self.accept(","):
                    break
            self.expect(")")
        self.parse_block()
        self.expect("end")

    # -- statements -------------------------------------------------------
    def parse_block(self):
        while True:
            v = self.val()
            if v in BLOCK_END or self.kind() == "eof":
                return
            if v == ";":
                self.next()
                continue
            self.parse_statement()

    def parse_statement(self):
        v = self.val()
        if v == "local":
            self.next()
            if self.accept("function"):
                self.next()                     # function name
                self.parse_body_after_keyword()
                return
            self.next()                         # first name
            while self.accept(","):
                self.next()
            if self.accept("="):
                while True:
                    self.parse_expr()
                    if not self.accept(","):
                        break
            return
        if v == "if":
            self.next()
            self.parse_expr(); self.expect("then"); self.parse_block()
            while self.val() == "elseif":
                self.next(); self.parse_expr(); self.expect("then"); self.parse_block()
            if self.accept("else"):
                self.parse_block()
            self.expect("end")
            return
        if v == "while":
            self.next(); self.parse_expr(); self.expect("do"); self.parse_block(); self.expect("end")
            return
        if v == "repeat":
            self.next(); self.parse_block(); self.expect("until"); self.parse_expr()
            return
        if v == "for":
            self.next()
            self.next()                        # first variable
            if self.val() == "=":              # numeric for
                self.next()
                self.parse_expr(); self.expect(","); self.parse_expr()
                if self.accept(","):
                    self.parse_expr()
            else:                              # generic for: names in explist
                while self.accept(","):
                    self.next()
                self.expect("in")
                while True:
                    self.parse_expr()
                    if not self.accept(","):
                        break
            self.expect("do"); self.parse_block(); self.expect("end")
            return
        if v == "do":
            self.next(); self.parse_block(); self.expect("end")
            return
        if v == "function":
            self.next()
            self.next()                        # name
            while self.accept("."):
                self.next()
            if self.accept(":"):
                self.next()
            self.parse_body_after_keyword()
            return
        if v == "return":
            self.next()
            if self.val() not in BLOCK_END and self.val() != ";" and self.kind() != "eof":
                while True:
                    self.parse_expr()
                    if not self.accept(","):
                        break
            self.accept(";")
            return
        if v in ("break", "continue"):
            self.next()
            return
        if v == "goto":
            self.next(); self.next()
            return
        if v == "::":
            self.next(); self.next(); self.expect("::")
            return
        # assignment or call
        self.parse_simple()
        if self.val() in COMPOUND:
            self.next()
            self.parse_expr()
            return
        if self.val() in (",", "="):
            while self.accept(","):
                self.parse_simple()
            self.expect("=")
            while True:
                self.parse_expr()
                if not self.accept(","):
                    break


def parse_file(src):
    toks = list(tokenize(src))
    p = Parser(toks)
    p.parse_block()
    if p.kind() != "eof":
        raise ParseError(f"trailing tokens at {p.peek()[2]}: {p.val()!r}")
    return toks


class PoolParser(Parser):
    """Parser that records the token span of every top-level table entry."""

    def __init__(self, toks):
        super().__init__(toks)
        self.spans = []          # (key, start_tok, end_tok) of top-level entries only
        self.depth = 0

    def parse_table(self):
        self.depth += 1
        top = self.depth == 1
        self.expect("{")
        while self.val() != "}":
            key = None
            start = self.i
            if self.val() == "[":
                self.next(); self.parse_expr(); self.expect("]"); self.expect("=")
                key = "".join(t[1] for t in self.t[start:self.i])
            elif self.kind() == "name" and self.val(1) == "=":
                key = self.val()
                self.next(); self.next()
            self.parse_expr()
            if top:
                self.spans.append((key, start, self.i))
            if not self.accept(",") and not self.accept(";"):
                break
        self.expect("}")
        self.depth -= 1


def extract_pool(src, pool_key="136"):
    """Return (list of entry texts, token list) for `cKb[pool_key] = { ... }`."""
    toks = list(tokenize(src))
    target = None
    for i in range(len(toks) - 5):
        if (toks[i][0] == "name" and toks[i][1] == "cKb" and toks[i + 1][1] == "["
                and toks[i + 2][1] == str(pool_key) and toks[i + 3][1] == "]"
                and toks[i + 4][1] == "=" and toks[i + 5][1] == "{"):
            target = i + 5
            break
    if target is None:
        raise ValueError("pool table not found")
    p = PoolParser(toks)
    p.i = target
    p.parse_table()
    return [("".join(t[1] for t in toks[s:e])) for _, s, e in p.spans], toks
