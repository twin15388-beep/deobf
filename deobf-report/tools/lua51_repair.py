#!/usr/bin/env python3
"""Repair Lua 5.1 chunks emitted by Lua-bytecode devirtualizers.

Obfuscator lifters (MoonSec V3, PSU, ...) sometimes emit chunks that Lua's own
loader rejects or that make unluac crash:

  * `maxstacksize` is one or two registers too small
    -> Lua: "bad code in precompiled chunk", unluac: ArrayIndexOutOfBounds
  * a prototype ends with `RETURN a, b` where b != 1 while unluac requires an
    implicit `RETURN a, 1`
    -> unluac: "Implicit return must have zero values"

Both fields live at fixed offsets, so the chunk is patched in place (no
re-serialisation, nothing else in the file changes).

usage:
  lua51_repair.py in.luac out.luac [-v]
"""
import struct
import sys

# register operands per Lua 5.1 opcode: which of a/b/c are registers
def touched(op, a, b, c):
    if op == 0:            # MOVE
        return [a, b]
    if op == 1 or op == 2 or op == 10 or op == 35 or op == 36:
        return [a]         # LOADK LOADBOOL NEWTABLE CLOSE CLOSURE
    if op == 3:            # LOADNIL a..a+b-1
        return [a + b - 1]
    if op in (4, 5, 7, 8): # GETUPVAL GETGLOBAL SETGLOBAL SETUPVAL
        return [a]
    if op == 6:            # GETTABLE
        return [a, b] + ([c] if c < 256 else [])
    if op == 9:            # SETTABLE a, b, c
        return [a, a + 1] + ([b] if b < 256 else []) + ([c] if c < 256 else [])
    if op == 11:           # SELF
        return [a, a + 1, b] + ([c] if c < 256 else [])
    if 12 <= op <= 17:     # arith
        return [a, b] + ([c] if c < 256 else [])
    if op in (18, 19, 20): # UNM NOT LEN
        return [a, b]
    if op == 21:           # CONCAT
        return [a, b, c]
    if op in (23, 24, 25): # EQ LT LE
        return [b] + ([c] if c < 256 else [])
    if op == 26:           # TEST
        return [a]
    if op == 27:           # TESTSET
        return [a, b]
    if op == 28 or op == 29:   # CALL TAILCALL
        return [a + (b if b else 2) - 1]
    if op == 30:           # RETURN
        return [a + (b - 2 if b else 0)]
    if op in (31, 32, 33): # FORLOOP FORPREP TFORLOOP
        return [a, a + 1, a + 2]
    if op == 34:           # SETLIST
        return [a + (b if b else 1)]
    if op == 37:           # VARARG
        return [a + (b - 1 if b else 1)]
    return [a]


def needed_regs(numparams, is_vararg, code):
    need = numparams + (1 if is_vararg else 0)
    for ins in code:
        op = ins & 0x3F
        a = (ins >> 6) & 0xFF
        c = (ins >> 14) & 0x1FF
        b = (ins >> 23) & 0x1FF
        for r in touched(op, a, b, c):
            if r + 1 > need:
                need = r + 1
    return need


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
        return struct.unpack(self.sz, self.raw(self.szlen))[0]

    def num(self):
        return struct.unpack(self.num_fmt, self.raw(self.numlen))[0]

    def string(self):
        n = self.size()
        if n == 0:
            return None
        return self.raw(n)[:-1].decode("latin-1")


def setup(r, data):
    r.p = 4
    if r.byte() != 0x51:
        raise SystemExit("only Lua 5.1 chunks are supported")
    r.byte()
    endian = r.byte()
    r.intlen = r.byte()
    r.szlen = r.byte()
    r.byte()
    r.numlen = r.byte()
    r.integral = r.byte()
    e = "<" if endian == 1 else ">"
    r.sz = e + ("I" if r.szlen == 4 else "Q")
    r.int_fmt = e + "i"
    r.num_fmt = e + ("f" if r.numlen == 4 else "d")


def walk(r, out, report, path):
    r.string()
    r.int()
    r.int()
    r.byte()
    numparams = r.byte()
    is_vararg = r.byte()
    ms_ofs = r.p
    maxstack = r.byte()
    n = r.int()
    code_ofs = r.p
    code = list(struct.unpack("<%dI" % n, r.raw(4 * n)))
    for _ in range(r.int()):
        t = r.byte()
        if t == 1:
            r.byte()
        elif t == 3:
            r.num()
        elif t == 4:
            r.string()
    for i in range(r.int()):
        walk(r, out, report, "%s.p%d" % (path, i))
    for _ in range(r.int()):
        r.int()
    for _ in range(r.int()):
        r.string(); r.int(); r.int()
    for _ in range(r.int()):
        r.string()

    need = needed_regs(numparams, is_vararg, code)
    if need > maxstack:
        new = min(need, 255)
        out[ms_ofs] = new
        report.append(("maxstack", path, maxstack, new))
    if code:
        last = code[-1]
        if (last & 0x3F) == 30 and ((last >> 23) & 0x1FF) != 1:
            fixed = (last & 0x7FFFFF) | (1 << 23)
            struct.pack_into("<I", out, code_ofs + 4 * (n - 1), fixed)
            report.append(("return", path, (last >> 23) & 0x1FF, 1))


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        raise SystemExit(2)
    data = bytearray(open(sys.argv[1], "rb").read())
    r = Reader(bytes(data))
    setup(r, bytes(data))
    out = bytearray(data)
    report = []
    walk(r, out, report, "main")
    open(sys.argv[2], "wb").write(bytes(out))
    if "-v" in sys.argv:
        for kind, path, old, new in report:
            print("  %-16s %-8s %s -> %s" % (path, kind, old, new))
    print("patched %d fields -> %s" % (len(report), sys.argv[2]))


if __name__ == "__main__":
    main()
