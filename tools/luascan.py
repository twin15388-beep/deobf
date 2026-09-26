"""A keyword-aware Luau token scanner.

`luaflat.parse_table` mis-aligns on the artifact's 235k-token constant pool because
Luau prefix-ifs (`x = if c then 1 else 2`) have no `end`, so naive `if`/`end` counting
drifts. This module tracks if-ownership properly:

* a statement `if` pushes a block that is closed by `end`;
* a prefix-if is an expression: it is closed when its else-branch expression ends;
* an `if` whose previous token is `then`/`else` inherits the kind of the if-construct
  that owns that `then`/`else` (statement `else if` stays a statement, `else if ...`
  inside a prefix-if stays an expression).

The scanner is used to split the pool constructor into fields, so block depth can be
tracked without parsing the whole artifact.
"""

EXPR_START = {"=", "(", ",", "{", "[", "then", "else", "return", "and", "or", "not",
              "==", "~=", "<", ">", "<=", ">=", "+", "-", "*", "/", "//", "%", "^",
              "..", "..=", "?"}
# tokens that terminate a prefix-if expression sitting at the same depth
EXPR_STOP = {",", ";", ")", "]", "}", "end", "then", "else"}
BINARY = {"and", "or", "==", "~=", "<", ">", "<=", ">=", "+", "-", "*", "/", "//",
          "%", "^", "..", "..="}


class IfCtx:
    __slots__ = ("kind", "depth", "seen_then", "in_else")

    def __init__(self, kind, depth):
        self.kind = kind                  # "stmt" | "expr"
        self.depth = depth
        self.seen_then = False
        self.in_else = False


class Scanner:
    """Walks tokens keeping track of nesting depth and if-construct ownership."""

    def __init__(self, toks):
        self.toks = toks

    def prev_text(self, i):
        j = i - 1
        while j >= 0 and self.toks[j][0] in ("comment", "ws"):
            j -= 1
        return self.toks[j][1] if j >= 0 else ""

    def if_kind(self, i, stack, depth):
        """Whether the `if` at token i opens a statement block or an expression."""
        prev = self.prev_text(i)
        if prev in ("then", "else"):
            if stack and stack[-1].kind == "expr":
                return "expr"
            if stack and stack[-1].kind == "stmt":
                return "stmt"
            return "stmt"
        if prev in EXPR_START:
            return "expr"
        if self.toks[i - 1][0] == "sym" if i > 0 else False:
            prev_tok = self.toks[i - 1]
            if prev_tok[0] == "sym" and prev_tok[1] not in (")", "]", "}", ";"):
                return "expr"
        return "stmt"

    def skip_value(self, i):
        """Advance past one table field value; returns the index of its terminator."""
        toks = self.toks
        n = len(toks)
        parens = braces = brackets = 0
        block = 0
        stack = []                       # open if-constructs, innermost last
        expect_do = 0
        prev = ""
        while i < n:
            kind, text = toks[i][0], toks[i][1]
            if kind == "str":
                i += 1
                continue
            depth = parens + braces + brackets + block
            # a prefix-if is finished once its else-branch ends at its own depth
            while stack and stack[-1].kind == "expr" and stack[-1].depth >= depth \
                    and text in EXPR_STOP:
                top = stack[-1]
                if text == "then" and not top.seen_then:
                    break
                if text == "else" and top.seen_then and not top.in_else:
                    break
                stack.pop()
            if depth == 0 and text in (",", ";", "}"):
                return i
            if text == "(":
                parens += 1
            elif text == ")":
                if depth == 0:
                    return i
                parens -= 1
            elif text == "{":
                braces += 1
            elif text == "}":
                if braces == 0:
                    return i
                braces -= 1
            elif text == "[":
                brackets += 1
            elif text == "]":
                if depth == 0:
                    return i
                brackets -= 1
            elif text in ("while", "for"):
                block += 1
                expect_do += 1
            elif text == "do":
                if expect_do:
                    expect_do -= 1
                else:
                    block += 1
            elif text in ("function", "repeat"):
                block += 1
            elif text == "if":
                kind_if = self.if_kind(i, stack, depth)
                stack.append(IfCtx(kind_if, depth))
                if kind_if == "stmt":
                    block += 1
            elif text == "end":
                while stack and stack[-1].kind == "expr":
                    stack.pop()
                if stack and stack[-1].kind == "stmt":
                    stack.pop()
                block -= 1
                if block < 0:
                    return i
            elif text == "until":
                block -= 1
                if block < 0:
                    return i
            elif text == "then":
                if stack and stack[-1].kind == "expr" and not stack[-1].seen_then:
                    stack[-1].seen_then = True
            elif text == "else":
                if stack and stack[-1].kind == "expr" and stack[-1].seen_then \
                        and not stack[-1].in_else:
                    stack[-1].in_else = True
                elif stack and stack[-1].kind == "stmt":
                    stack[-1].in_else = True
            prev = text
            i += 1
        return i


def table_end(toks, start):
    """Index of the `}` that closes the table constructor opened at toks[start]."""
    depth = 0
    for i in range(start, len(toks)):
        text = toks[i][1]
        if text == "{":
            depth += 1
        elif text == "}":
            depth -= 1
            if depth == 0:
                return i
    return None


def scan_fields(toks, start, end=None):
    """Yield (key_text_or_None, value_text, value_start, value_end) for a table."""
    assert toks[start][1] == "{"
    scanner = Scanner(toks)
    if end is None:
        end = table_end(toks, start)
    i = start + 1
    n = end
    while i < n:
        text = toks[i][1]
        if text in (",", ";"):
            i += 1
            continue
        key = None
        if text == "[":
            depth = 0
            j = i
            while j < n:
                if toks[j][1] == "[":
                    depth += 1
                elif toks[j][1] == "]":
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            key = "".join(t[1] for t in toks[i + 1:j])
            i = j + 1
            if i < n and toks[i][1] == "=":
                i += 1
        elif toks[i][0] == "name" and i + 1 < n and toks[i + 1][1] == "=":
            key = toks[i][1]
            i += 2
        start_val = i
        stop = scanner.skip_value(i)
        if stop <= start_val:
            stop = start_val + 1
        yield key, "".join(t[1] for t in toks[start_val:stop]).strip(), start_val, stop
        i = stop
