"""AST layer over luaflat's validated Luau parser.

luaflat.Parser proves the grammar; this module turns the same parse into a tree of
statements with token spans, so tools can work on structure instead of scanning tokens
by hand (which breaks on Luau prefix-`if` expressions).

Nodes keep `start`/`end` token indices, so any node's original source is
`"".join(t[1] for t in toks[node.start:node.end])`.
"""

import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat  # noqa: E402


class Node:
    def __init__(self, start, end):
        self.start, self.end = start, end


class Block(Node):
    def __init__(self, start, end, stmts):
        super().__init__(start, end)
        self.stmts = stmts


class If(Node):
    """if <cond> then <block> {elseif <cond> then <block>} [else <block>] end"""

    def __init__(self, start, end, cond, then, elseifs, else_):
        super().__init__(start, end)
        self.cond = cond                  # (start, end) token span of the condition
        self.then = then
        self.elseifs = elseifs            # list of (cond_span, Block)
        self.else_ = else_


class While(Node):
    def __init__(self, start, end, cond, body):
        super().__init__(start, end)
        self.cond, self.body = cond, body


class Repeat(Node):
    def __init__(self, start, end, body, cond):
        super().__init__(start, end)
        self.body, self.cond = body, cond


class NumericFor(Node):
    def __init__(self, start, end, var, exprs, body):
        super().__init__(start, end)
        self.var, self.exprs, self.body = var, exprs, body


class GenericFor(Node):
    def __init__(self, start, end, vars_, exprs, body):
        super().__init__(start, end)
        self.vars, self.exprs, self.body = vars_, exprs, body


class Do(Node):
    def __init__(self, start, end, body):
        super().__init__(start, end)
        self.body = body


class Local(Node):
    def __init__(self, start, end, names, exprs):
        super().__init__(start, end)
        self.names, self.exprs = names, exprs


class LocalFunction(Node):
    def __init__(self, start, end, name, params, body):
        super().__init__(start, end)
        self.name, self.params, self.body = name, params, body


class FunctionStmt(Node):
    def __init__(self, start, end, target, params, body):
        super().__init__(start, end)
        self.target, self.params, self.body = target, params, body


class Assign(Node):
    def __init__(self, start, end, targets, values):
        super().__init__(start, end)
        self.targets, self.values = targets, values


class CompoundAssign(Node):
    def __init__(self, start, end, target, op, value):
        super().__init__(start, end)
        self.target, self.op, self.value = target, op, value


class Return(Node):
    def __init__(self, start, end, exprs):
        super().__init__(start, end)
        self.exprs = exprs


class Break(Node):
    pass


class Continue(Node):
    pass


class Goto(Node):
    pass


class Label(Node):
    pass


class ExprStmt(Node):
    def __init__(self, start, end, expr):
        super().__init__(start, end)
        self.expr = expr


class AstParser(luaflat.Parser):
    def _expr(self):
        start = self.i
        node = self.parse_expr()
        return node if node is not None else (start, self.i)

    def parse_block(self):
        start = self.i
        stmts = []
        while True:
            v = self.val()
            if v in luaflat.BLOCK_END or self.kind() == "eof":
                break
            if v == ";":
                self.next()
                continue
            stmts.append(self.parse_statement())
        return Block(start, self.i, stmts)

    def parse_statement(self):
        t = self.t
        start = self.i
        v = self.val()

        if v == "local":
            self.next()
            if self.accept("function"):
                name = self.val()
                self.next()
                params, body = self.parse_body_after_keyword()
                return LocalFunction(start, self.i, name, params, body)
            names = [self.val()]
            self.next()
            while self.accept(","):
                names.append(self.val())
                self.next()
            exprs = []
            if self.accept("="):
                while True:
                    exprs.append(self._expr())
                    if not self.accept(","):
                        break
            return Local(start, self.i, names, exprs)

        if v == "if":
            self.next()
            cond = self.span_of_condition()
            self.expect("then")
            then = self.parse_block()
            elseifs = []
            while self.val() == "elseif":
                self.next()
                c = self.span_of_condition()
                self.expect("then")
                elseifs.append((c, self.parse_block()))
            else_ = None
            if self.accept("else"):
                else_ = self.parse_block()
            self.expect("end")
            return If(start, self.i, cond, then, elseifs, else_)

        if v == "while":
            self.next()
            c0 = self.i
            self.parse_expr()
            cond = (c0, self.i)
            self.expect("do")
            body = self.parse_block()
            self.expect("end")
            return While(start, self.i, cond, body)

        if v == "repeat":
            self.next()
            body = self.parse_block()
            self.expect("until")
            c0 = self.i
            self.parse_expr()
            return Repeat(start, self.i, body, (c0, self.i))

        if v == "for":
            self.next()
            first = self.val()
            self.next()
            if self.val() == "=":
                self.next()
                exprs = []
                while True:
                    exprs.append(self._expr())
                    if not self.accept(","):
                        break
                self.expect("do")
                body = self.parse_block()
                self.expect("end")
                return NumericFor(start, self.i, first, exprs, body)
            vars_ = [first]
            while self.accept(","):
                vars_.append(self.val())
                self.next()
            self.expect("in")
            exprs = []
            while True:
                exprs.append(self._expr())
                if not self.accept(","):
                    break
            self.expect("do")
            body = self.parse_block()
            self.expect("end")
            return GenericFor(start, self.i, vars_, exprs, body)

        if v == "do":
            self.next()
            body = self.parse_block()
            self.expect("end")
            return Do(start, self.i, body)

        if v == "function":
            self.next()
            t0 = self.i
            self.next()
            while self.accept("."):
                self.next()
            if self.accept(":"):
                self.next()
            target = (t0, self.i)
            params, body = self.parse_body_after_keyword()
            return FunctionStmt(start, self.i, target, params, body)

        if v == "return":
            self.next()
            exprs = []
            if self.val() not in luaflat.BLOCK_END and self.val() != ";" and self.kind() != "eof":
                while True:
                    exprs.append(self._expr())
                    if not self.accept(","):
                        break
            self.accept(";")
            return Return(start, self.i, exprs)

        if v == "break":
            self.next()
            return Break(start, self.i)

        if v == "continue":
            self.next()
            return Continue(start, self.i)

        if v == "goto":
            self.next()
            self.next()
            return Goto(start, self.i)

        if v == "::":
            self.next()
            self.next()
            self.expect("::")
            return Label(start, self.i)

        # expression statement / assignment / compound assignment
        s0 = self.i
        expr0 = None
        try:                                 # keep the expression node for call rewriting
            expr0 = self.parse_simple_expr()
        except Exception:                    # noqa: BLE001 -- fall back to the skipper
            self.i = s0
            self.parse_simple()
        if self.val() in luaflat.COMPOUND:
            op = self.val()
            self.next()
            value = self._expr()
            return CompoundAssign(start, self.i, (s0, self.i), op, value)
        if self.val() in (",", "="):
            targets = [(s0, self.i)]
            while self.accept(","):
                s = self.i
                self.parse_simple()
                targets.append((s, self.i))
            self.expect("=")
            values = []
            while True:
                values.append(self._expr())
                if not self.accept(","):
                    break
            return Assign(start, self.i, targets, values)
        node = ExprStmt(start, self.i, expr0)
        # a call may be followed by a method/index chain that parse_simple already ate
        return node

    def span_of_condition(self):
        start = self.i
        self.parse_expr()
        return (start, self.i)

    def parse_body_after_keyword(self):
        """Overrides the base helper so callers can build nodes (params + Block)."""
        params = []
        if self.accept("("):
            while self.val() != ")":
                params.append(self.val())
                self.next()
                if self.accept(":"):
                    self.next()
                if not self.accept(","):
                    break
            self.expect(")")
        body = self.parse_block()
        self.expect("end")
        return params, body


def parse(src):
    toks = list(luaflat.tokenize(src))
    p = AstParser(toks)
    node = p.parse_block()
    if p.kind() != "eof":
        raise luaflat.ParseError("trailing tokens at %d" % p.peek()[2])
    return node, toks


def text(toks, node):
    return "".join(t[1] for t in toks[node[0]:node[1]]) if isinstance(node, tuple) \
        else "".join(t[1] for t in toks[node.start:node.end])


# ---------------------------------------------------------------------------
# Expression-level nodes (needed to expand function literals and to fold the
# obfuscator's opaque predicates).
# ---------------------------------------------------------------------------

class Expr(Node):
    pass


class Literal(Expr):
    def __init__(self, start, end, text):
        super().__init__(start, end)
        self.text = text


class NameExpr(Expr):
    def __init__(self, start, end, name):
        super().__init__(start, end)
        self.name = name


class Index(Expr):
    def __init__(self, start, end, obj, key, dot):
        super().__init__(start, end)
        self.obj, self.key, self.dot = obj, key, dot


class Call(Expr):
    def __init__(self, start, end, func, args, method=None):
        super().__init__(start, end)
        self.func, self.args, self.method = func, args, method


class MethodCall(Expr):
    def __init__(self, start, end, obj, method, args):
        super().__init__(start, end)
        self.obj, self.method, self.args = obj, method, args


class BinOp(Expr):
    def __init__(self, start, end, op, left, right):
        super().__init__(start, end)
        self.op, self.left, self.right = op, left, right


class UnOp(Expr):
    def __init__(self, start, end, op, operand):
        super().__init__(start, end)
        self.op, self.operand = op, operand


class Paren(Expr):
    def __init__(self, start, end, expr):
        super().__init__(start, end)
        self.expr = expr


class TableExpr(Expr):
    def __init__(self, start, end, entries):
        super().__init__(start, end)
        self.entries = entries        # list of (key_expr_or_None, value_expr)


class FunctionExpr(Expr):
    def __init__(self, start, end, params, body):
        super().__init__(start, end)
        self.params, self.body = params, body


class PrefixIf(Expr):
    def __init__(self, start, end, cond, then, else_):
        super().__init__(start, end)
        self.cond, self.then, self.else_ = cond, then, else_


class ExprAstParser(AstParser):
    """AstParser that also builds expression nodes."""

    def parse_expr(self, min_prec=1):
        start = self.i
        if self.val() in luaflat.UNOP:
            op = self.val()
            self.next()
            operand = self.parse_expr(7)
            left = UnOp(start, self.i, op, operand)
        else:
            left = self.parse_simple_expr()
        while True:
            op = self.val()
            if op not in luaflat.BINOP:
                break
            prec, assoc = luaflat.BINOP[op]
            if prec < min_prec:
                break
            self.next()
            right = self.parse_expr(prec + (1 if assoc == "left" else 0))
            left = BinOp(start, self.i, op, left, right)
        return left

    def parse_simple_expr(self):
        start = self.i
        k, v = self.kind(), self.val()
        if k in ("str", "longstr", "num"):
            self.next()
            return self.parse_suffixes_expr(start, Literal(start, self.i, v))
        if v in ("nil", "true", "false", "..."):
            self.next()
            return Literal(start, self.i, v)
        if v == "function":
            self.next()
            params, body = self.parse_body_after_keyword()
            return self.parse_suffixes_expr(start, FunctionExpr(start, self.i, params, body))
        if v == "{":
            entries = self.parse_table_expr()
            return self.parse_suffixes_expr(start, TableExpr(start, self.i, entries))
        if v == "if":                      # Luau prefix-if expression
            self.next()
            cond = self.parse_expr()
            self.expect("then")
            then = self.parse_expr()
            self.expect("else")
            else_ = self.parse_expr()
            return PrefixIf(start, self.i, cond, then, else_)
        if v == "(":
            self.next()
            inner = self.parse_expr()
            self.expect(")")
            return self.parse_suffixes_expr(start, Paren(start, self.i, inner))
        if k == "name":
            self.next()
            return self.parse_suffixes_expr(start, NameExpr(start, self.i, v))
        raise luaflat.ParseError("unexpected token %r at %d" % (v, self.peek()[2]))

    def parse_suffixes_expr(self, start, base):
        while True:
            v = self.val()
            if v == ".":
                self.next()
                key = self.val()
                self.next()
                base = Index(start, self.i, base, Literal(self.i - 1, self.i, key), True)
            elif v == "[":
                self.next()
                key = self.parse_expr()
                self.expect("]")
                base = Index(start, self.i, base, key, False)
            elif v == ":":
                self.next()
                method = self.val()
                self.next()
                args = self.parse_args_expr()
                base = MethodCall(start, self.i, base, method, args)
            elif v in ("(", "{") or self.kind() in ("str", "longstr"):
                args = self.parse_args_expr()
                base = Call(start, self.i, base, args)
            else:
                break
        return base

    def parse_args_expr(self):
        if self.val() == "(":
            self.next()
            args = []
            if self.val() != ")":
                while True:
                    args.append(self.parse_expr())
                    if not self.accept(","):
                        break
            self.expect(")")
            return args
        if self.val() == "{":
            return [TableExpr(self.i, self.i, self.parse_table_expr())]
        if self.kind() in ("str", "longstr"):
            tok = self.next()
            return [Literal(tok[2], tok[3], tok[1])]
        raise luaflat.ParseError("bad call args %r" % self.val())

    def parse_table_expr(self):
        self.expect("{")
        entries = []
        while self.val() != "}":
            if self.val() == "[":
                self.next()
                key = self.parse_expr()
                self.expect("]")
                self.expect("=")
                value = self.parse_expr()
                entries.append((key, value))
            elif self.kind() == "name" and self.val(1) == "=":
                key = Literal(self.i, self.i + 1, self.val())
                self.next()
                self.next()
                entries.append((key, self.parse_expr()))
            else:
                entries.append((None, self.parse_expr()))
            if not self.accept(",") and not self.accept(";"):
                break
        self.expect("}")
        return entries


def parse_exprs(src):
    """Parse with expression nodes available."""
    toks = list(luaflat.tokenize(src))
    p = ExprAstParser(toks)
    node = p.parse_block()
    if p.kind() != "eof":
        raise luaflat.ParseError("trailing tokens at %d" % p.peek()[2])
    return node, toks
