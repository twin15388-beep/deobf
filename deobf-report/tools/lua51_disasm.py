#!/usr/bin/env python3
"""Minimal Lua 5.1 bytecode disassembler / pseudo-decompiler.

Used to make the output of Lua-5.1-bytecode devirtualizers (MoonSec V3, PSU)
readable without a JVM (unluac needs Java).
"""
import struct
import sys

OPS = ["MOVE", "LOADK", "LOADBOOL", "LOADNIL", "GETUPVAL", "GETGLOBAL", "GETTABLE",
       "SETGLOBAL", "SETUPVAL", "SETTABLE", "NEWTABLE", "SELF", "ADD", "SUB", "MUL",
       "DIV", "MOD", "POW", "UNM", "NOT", "LEN", "CONCAT", "JMP", "EQ", "LT", "LE",
       "TEST", "TESTSET", "CALL", "TAILCALL", "RETURN", "FORLOOP", "FORPREP",
       "TFORLOOP", "SETLIST", "CLOSE", "CLOSURE", "VARARG"]

BIN_OPS = {12: "+", 13: "-", 14: "*", 15: "/", 16: "%", 17: "^"}


class Reader:
    def __init__(self, data):
        self.d = data
        self.p = 0

    def byte(self):
        v = self.d[self.p]
        self.p += 1
        return v

    def raw(self, n):
        v = self.d[self.p:self.p + n]
        self.p += n
        return v

    def int(self):
        return struct.unpack(self.int_fmt, self.raw(self.intlen))[0]

    def size(self):
        v = struct.unpack(self.sz, self.raw(self.szlen))[0]
        return v

    def num(self):
        if self.integral:
            return struct.unpack(self.int_fmt, self.raw(self.intlen))[0]
        return struct.unpack(self.num_fmt, self.raw(self.numlen))[0]

    def string(self):
        n = self.size()
        if n == 0:
            return None
        return self.raw(n)[:-1].decode("latin-1")


def parse(data):
    r = Reader(data)
    assert data[0] == 0x1B and data[1:4] == b"Lua", "not a Lua chunk"
    r.p = 4
    version = r.byte()
    r.byte()  # format
    endian = r.byte()
    r.intlen = r.byte()
    r.szlen = r.byte()
    r.instlen = r.byte()  # unused, always 4
    r.numlen = r.byte()
    r.integral = r.byte()
    e = "<" if endian == 1 else ">"
    r.sz = e + ("I" if r.szlen == 4 else "Q")
    r.int_fmt = e + "i"
    r.num_fmt = e + ("f" if r.numlen == 4 else "d")
    if version != 0x51:
        raise SystemExit("only Lua 5.1 chunks are supported (got 0x%02x)" % version)
    main = parse_function(r)
    return main


def parse_function(r):
    f = {"_start": r.p}
    f["source"] = r.string()
    f["linedefined"] = r.int()
    f["lastlinedefined"] = r.int()
    f["nups"] = r.byte()
    f["numparams"] = r.byte()
    f["is_vararg"] = r.byte()
    f["maxstack"] = r.byte()
    n = r.int()
    f["code"] = list(struct.unpack("<%dI" % n, r.raw(4 * n)))
    n = r.int()
    consts = []
    for _ in range(n):
        t = r.byte()
        if t == 0:
            consts.append(("nil", None))
        elif t == 1:
            consts.append(("bool", r.byte()))
        elif t == 3:
            consts.append(("num", r.num()))
        elif t == 4:
            consts.append(("str", r.string()))
        else:
            raise SystemExit("bad constant type %d" % t)
    f["consts"] = consts
    n = r.int()
    f["protos"] = [parse_function(r) for _ in range(n)]
    n = r.int()  # lineinfo
    f["lines"] = list(struct.unpack("<%di" % n, r.raw(4 * n))) if n else []
    n = r.int()
    for _ in range(n):
        r.string(); r.int(); r.int()
    n = r.int()
    for _ in range(n):
        r.string()
    f["_end"] = r.p
    return f


def kval(f, i):
    if i < 0 or i >= len(f["consts"]):
        return "?"
    t, v = f["consts"][i]
    if t == "str":
        return repr(v)
    if t == "num":
        if isinstance(v, float) and v.is_integer():
            return str(int(v))
        return repr(v)
    if t == "bool":
        return "true" if v else "false"
    return "nil"


def rk(f, x):
    """RK operand: register or constant."""
    if x < 256:
        return "R%d" % x
    return kval(f, x - 256)


def disasm(f, out, path="main", depth=0):
    ind = "  " * depth
    out.append("%s-- function %s  params=%d nups=%d lines=%d..%d" %
               (ind, path, f["numparams"], f["nups"], f["linedefined"], f["lastlinedefined"]))
    code = f["code"]
    # map jump targets to labels
    targets = {}
    for pc, ins in enumerate(code):
        op = ins & 0x3F
        if op in (22, 23, 24, 25, 26, 27, 31, 32, 33):
            sbx = ((ins >> 14) & 0x1FF) | (((ins >> 23) & 0x1FF) << 9)
            if sbx >= 512:
                sbx -= 1024
            tgt = pc + 1 + sbx
            targets.setdefault(tgt, "L%d" % tgt)
    for pc, ins in enumerate(code):
        if pc in targets:
            out.append("%s::%s::" % (ind, targets[pc]))
        op = ins & 0x3F
        a = (ins >> 6) & 0xFF
        c = (ins >> 14) & 0x1FF
        b = (ins >> 23) & 0x1FF
        bxx = (ins >> 14) & 0x3FFFF
        sbx = bxx - 131071
        name = OPS[op] if op < len(OPS) else "OP%d" % op
        line = f["lines"][pc] if pc < len(f["lines"]) else -1
        text = "%sR%d" % (ind, a)
        if op == 1:
            text += " = %s" % kval(f, bxx)
        elif op == 0:
            text += " = R%d" % b
        elif op == 2:
            text += " = " + ("true" if b else "false") + ("  (jump +1)" if c else "")
        elif op == 3:
            text += "..R%d = nil" % (a + b - 1) if b else " = nil"
        elif op == 4:
            text += " = U%d" % b
        elif op == 5:
            text += " = _ENV[%s]" % kval(f, bxx)
        elif op == 6:
            text += " = %s[%s]" % (rk(f, b), rk(f, c))
        elif op == 7:
            out.append("%s_ENV[%s] = R%d" % (ind, kval(f, bxx), a))
            continue
        elif op == 8:
            out.append("%sU%d = R%d" % (ind, b, a))
            continue
        elif op == 9:
            out.append("%s%s[%s] = R%d" % (ind, "R%d" % a, rk(f, b), a + 1))
            continue
        elif op == 10:
            text += " = {} size:array=%d hash=%d" % (c, b)
        elif op == 11:
            text += " = %s[%s]; R%d = %s" % (rk(f, b), rk(f, c), a + 1, rk(f, b))
        elif op in BIN_OPS:
            text += " = %s %s %s" % (rk(f, b), BIN_OPS[op], rk(f, c))
        elif op == 18:
            text += " = -R%d" % b
        elif op == 19:
            text += " = not R%d" % b
        elif op == 20:
            text += " = #R%d" % b
        elif op == 21:
            text += " = concat(R%d..R%d)" % (b, c)
        elif op == 22:
            out.append("%sgoto %s  (jump %+d)" % (ind, targets.get(pc + 1 + sbx, "L%d" % (pc + 1 + sbx)), sbx))
            continue
        elif op in (23, 24, 25):
            cond = {23: "==", 24: "<", 25: "<="}[op]
            text = "if (%s %s %s) ~= %s then goto next+1" % (rk(f, b), cond, rk(f, c),
                "true" if a else "false")
        elif op == 26:
            text = "if R%d == %s then goto next+1" % (a, "true" if c else "false")
        elif op == 27:
            text = "if R%d == %s then R%d = R%d else goto next+1" % (b, "true" if c else "false", a, b)
        elif op == 28:
            text = "R%d..R%d = R%d(%s)" % (a, a + c - 1 if c else -1, a,
                                           ", ".join("R%d" % i for i in range(a + 1, a + b)) if b else "")
        elif op == 29:
            text = "return R%d(%s)" % (a, ", ".join("R%d" % i for i in range(a + 1, a + b)) if b else "")
        elif op == 30:
            text = "return " + ("... " if b else "") + ", ".join("R%d" % i for i in range(a, a + b - 1))
        elif op == 31:
            text = "R%d += R%d ; if R%d < R%d then goto %s" % (a, c, a, b, targets.get(pc + 1 + sbx, "?"))
        elif op == 32:
            text = "for prep R%d (limit R%d step R%d) goto %s" % (a, a + 1, a + 2, targets.get(pc + 1 + sbx, "?"))
        elif op == 33:
            text = "for-in R%d (n=%d) goto %s" % (a, c, targets.get(pc + 1 + sbx, "?"))
        elif op == 34:
            out.append("%sR%d[%s..%s] = %s" % (ind, a, "R%d" % c if c else "R0", "R%d" % (c + b - 1) if c else "R%d" % (b - 1),
                                               "top" if b == 0 else "R%d" % (a + 1)))
            continue
        elif op == 35:
            out.append("%sclose upvalues >= R%d" % (ind, a))
            continue
        elif op == 36:
            text = "R%d = closure(proto %d)" % (a, bxx)
        elif op == 37:
            text = "R%d..R%d = vararg" % (a, a + b - 1 if b else -1)
        out.append("%s[%4d] %-42s -- line %d" % (ind, pc + 1, text, line))
    for i, p in enumerate(f["protos"]):
        out.append("")
        disasm(p, out, "%s.p%d" % (path, i), depth + 1)


def main():
    if len(sys.argv) < 3:
        print("usage: lua51_disasm.py input.luac output.txt")
        raise SystemExit(2)
    data = open(sys.argv[1], "rb").read()
    f = parse(data)
    out = []
    strings = sorted({v for t, v in all_consts(f) if t == "str" and v and len(v) > 3})
    out.append("-- constants: %d strings" % len(strings))
    out.append("")
    disasm(f, out)
    out.append("")
    out.append("-- ===== string constants =====")
    for s in strings:
        out.append("--   %r" % s)
    open(sys.argv[2], "w", encoding="utf-8").write("\n".join(out) + "\n")
    print("wrote %s (%d lines, %d strings)" % (sys.argv[2], len(out), len(strings)))


def all_consts(f):
    for c in f["consts"]:
        yield c
    for p in f["protos"]:
        for c in all_consts(p):
            yield c


if __name__ == "__main__":
    main()
