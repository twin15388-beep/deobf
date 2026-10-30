#!/usr/bin/env python3
"""luac_inspect.py — разбор и диагностика чанка Lua 5.1 (32- или 64-битного).

Печатает дерево прототипов, инструкции в виде текста и отмечает проблемы,
которые ломают загрузчик Lua (`luaG_checkcode`) и unluac:
  * регистровые операнды >= maxstacksize;
  * операнд-константа вне диапазона sizek;
  * CALL с C==0, за которым нет "открывающей" инструкции (CALL/RETURN/SETLIST/TAILCALL с B==0);
  * прыжки за пределы кода;
  * GETUPVAL/SETUPVAL с B >= nups;
  * отсутствие RETURN в конце.

Использование:
    python3 luac_inspect.py chunk.luac [--code] [--all]
"""
import argparse
import struct
import sys

OPNAMES = ["MOVE", "LOADK", "LOADBOOL", "LOADNIL", "GETUPVAL", "GETGLOBAL",
           "GETTABLE", "SETGLOBAL", "SETUPVAL", "SETTABLE", "NEWTABLE", "SELF",
           "ADD", "SUB", "MUL", "DIV", "MOD", "POW", "UNM", "NOT", "LEN",
           "CONCAT", "JMP", "EQ", "LT", "LE", "TEST", "TESTSET", "CALL",
           "TAILCALL", "RETURN", "FORLOOP", "FORPREP", "TFORLOOP", "SETLIST",
           "CLOSE", "CLOSURE", "VARARG"]

# режимы операндов: (A,B,C) из lopcodes.c
MODES = {
    0: ("R", "R", "N"), 1: ("R", "K", "N"), 2: ("R", "U", "U"), 3: ("R", "R", "N"),
    4: ("R", "U", "N"), 5: ("R", "K", "N"), 6: ("R", "K", "K"), 7: ("K", "K", "N"),
    8: ("R", "U", "N"), 9: ("R", "K", "K"), 10: ("R", "U", "U"), 11: ("R", "K", "K"),
    12: ("R", "K", "K"), 13: ("R", "K", "K"), 14: ("R", "K", "K"), 15: ("R", "K", "K"),
    16: ("R", "K", "K"), 17: ("R", "K", "K"), 18: ("R", "R", "N"), 19: ("R", "R", "N"),
    20: ("R", "R", "N"), 21: ("R", "R", "R"), 22: ("R", "sBx", "N"), 23: ("R", "K", "K"),
    24: ("R", "K", "K"), 25: ("R", "K", "K"), 26: ("R", "N", "N"), 27: ("R", "R", "N"),
    28: ("R", "U", "U"), 29: ("R", "U", "U"), 30: ("R", "U", "N"), 31: ("R", "sBx", "N"),
    32: ("R", "sBx", "N"), 33: ("R", "N", "U"), 34: ("R", "U", "U"), 35: ("R", "N", "N"),
    36: ("R", "U", "N"), 37: ("R", "U", "N"),
}

OPEN_OPS = {28, 29, 30, 34}  # CALL, TAILCALL, RETURN, SETLIST


class Proto:
    def __init__(self):
        self.source = b""
        self.linedefined = 0
        self.lastlinedefined = 0
        self.nups = 0
        self.numparams = 0
        self.is_vararg = 0
        self.maxstack = 0
        self.code = []
        self.consts = []
        self.protos = []
        self.lineinfo = []
        self.locvars = []
        self.upvalnames = []


class R:
    def __init__(self, d):
        self.d = d
        self.p = 0

    def take(self, n):
        r = self.d[self.p:self.p + n]
        if len(r) != n:
            raise ValueError("EOF at %d" % self.p)
        self.p += n
        return r

    def i32(self):
        return struct.unpack("<i", self.take(4))[0]

    def sz(self):
        return struct.unpack("<I", self.take(4))[0]

    def b(self):
        return self.take(1)[0]

    def string(self):
        n = self.sz()
        return b"" if n == 0 else self.take(n)


def load_func(r, szbytes):
    f = Proto()
    f.source = r.string()
    f.linedefined = r.i32()
    f.lastlinedefined = r.i32()
    f.nups = r.b()
    f.numparams = r.b()
    f.is_vararg = r.b()
    f.maxstack = r.b()
    n = r.i32()
    f.code = list(struct.unpack("<%dI" % n, r.take(4 * n))) if n else []
    n = r.i32()
    for _ in range(n):
        t = r.b()
        if t == 0:
            f.consts.append(None)
        elif t == 1:
            f.consts.append(bool(r.b()))
        elif t == 3:
            f.consts.append(struct.unpack("<d", r.take(8))[0])
        elif t == 4:
            f.consts.append(r.string())
        else:
            raise ValueError("bad const type %d" % t)
    n = r.i32()
    for _ in range(n):
        f.protos.append(load_func(r, szbytes))
    n = r.i32()
    f.lineinfo = list(struct.unpack("<%di" % n, r.take(4 * n))) if n else []
    n = r.i32()
    for _ in range(n):
        f.locvars.append((r.string(), r.i32(), r.i32()))
    n = r.i32()
    for _ in range(n):
        f.upvalnames.append(r.string())
    return f


def load_chunk(data):
    if data[:4] != b"\x1bLua":
        raise ValueError("not a chunk")
    szsize = data[8]
    r = R(data)
    r.take(12)
    return load_func(r, szsize), r.p


def dec(i):
    op = i & 0x3F
    a = (i >> 6) & 0xFF
    c = (i >> 14) & 0x1FF
    b = (i >> 23) & 0x1FF
    bx = (i >> 14) & 0x3FFFF
    sbx = bx - 131071
    return op, a, b, c, bx, sbx


def isk(x):
    return x >= 256


def irk(x):
    return x - 256


def fmt_const(k):
    if isinstance(k, bytes):
        s = k.decode("utf-8", "replace")
        return '"%s"' % (s if len(s) < 60 else s[:57] + "...")
    return repr(k)


def fmt_inst(i, p):
    op, a, b, c, bx, sbx = dec(i)
    name = OPNAMES[op] if op < len(OPNAMES) else "OP_%d?" % op
    ma, mb, mc = MODES.get(op, ("U", "U", "U"))

    def arg(v, mode):
        if mode == "K":
            return "K%d(%s)" % (irk(v), fmt_const(p.consts[irk(v)]) if irk(v) < len(p.consts) else "??") if isk(v) else "R%d" % v
        if mode == "R":
            return "R%d" % v
        if mode == "sBx":
            return "->%d" % (sbx + 1)
        return str(v)

    if op in (1, 5, 7, 36):
        return "%-10s R%d K%d(%s)" % (name, a, bx, fmt_const(p.consts[bx]) if bx < len(p.consts) else "??")
    if op in (22, 31, 32):
        return "%-10s ->%d (sBx=%d)" % (name, (sbx + 1 + (0 if op != 22 else 0)), sbx)
    return "%-10s R%d %s %s" % (name, a, arg(b, mb), arg(c, mc))


def check(p, path, problems, depth):
    where = "p%d" % depth
    if p.maxstack <= 0 or p.maxstack > 250:
        problems.append("%s maxstack=%d (invalid)" % (where, p.maxstack))
    if not p.code:
        problems.append("%s no code" % where)
        return
    if dec(p.code[-1])[0] != 30:
        problems.append("%s last op is %s, not RETURN" % (where, OPNAMES[dec(p.code[-1])[0]]))
    for pc, i in enumerate(p.code):
        op, a, b, c, bx, sbx = dec(i)
        if op >= len(OPNAMES):
            problems.append("%s pc%d unknown opcode %d" % (where, pc, op))
            continue
        name = OPNAMES[op]
        ma, mb, mc = MODES[op]
        for v, m, nm in ((a, ma, "A"), (b, mb, "B"), (c, mc, "C")):
            if m == "R" and v >= p.maxstack:
                problems.append("%s pc%d %s %s=%d >= maxstack %d" % (where, pc, name, nm, v, p.maxstack))
            if m == "K" and not isk(v) and v >= p.maxstack:
                problems.append("%s pc%d %s %s reg %d >= maxstack %d" % (where, pc, name, nm, v, p.maxstack))
            if m == "K" and isk(v) and irk(v) >= len(p.consts):
                problems.append("%s pc%d %s %s=K%d out of %d consts" % (where, pc, name, nm, irk(v), len(p.consts)))
        if op in (4, 8) and b >= p.nups and b < 256:
            problems.append("%s pc%d %s R%d but nups=%d" % (where, pc, name, b, p.nups))
        if op in (28, 29) and c == 0:
            if pc + 1 >= len(p.code):
                problems.append("%s pc%d %s open call at end of code" % (where, pc, name))
            else:
                nop, na, nb, nc, _, _ = dec(p.code[pc + 1])
                if not (nop in OPEN_OPS and nb == 0):
                    problems.append("%s pc%d %s C=0 (open) followed by %s B=%d" % (where, pc, name, OPNAMES[nop] if nop < 38 else nop, nb))
        if op in (22, 31, 32):
            dest = pc + 1 + sbx
            if not (0 <= dest < len(p.code)):
                problems.append("%s pc%d %s jump ->%d out of code" % (where, pc, name, dest))
    for i, sub in enumerate(p.protos):
        check(sub, path + [i], problems, depth + 1)


def dump(p, idx, out, show_code):
    out.append("%sproto p%d: params=%d vararg=%d nups=%d maxstack=%d code=%d consts=%d protos=%d"
               % ("  " * idx, idx, p.numparams, p.is_vararg, p.nups, p.maxstack,
                  len(p.code), len(p.consts), len(p.protos)))
    if show_code:
        for pc, i in enumerate(p.code):
            out.append("%s  %3d  %s" % ("  " * idx, pc, fmt_inst(i, p)))
    for j, sub in enumerate(p.protos):
        dump(sub, idx + 1, out, show_code)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("--code", action="store_true", help="печатать инструкции")
    ap.add_argument("--limit", type=int, default=10, help="сколько прототипов показать")
    a = ap.parse_args()
    data = open(a.input, "rb").read()
    top, used = load_chunk(data)
    print("[i] %d B, sizeof(size_t)=%d, разобрано %d B" % (len(data), data[8], used))
    out = []
    dump(top, 0, out, a.code)
    print("\n".join(out[:a.limit]))
    problems = []
    check(top, [], problems, 0)
    print("\n[!] проблем: %d" % len(problems))
    for s in problems[:60]:
        print("    " + s)


if __name__ == "__main__":
    main()
