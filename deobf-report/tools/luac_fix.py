#!/usr/bin/env python3
"""luac_fix.py — «починка» чанка Lua 5.1, восстановленного CASCADE из IronBrew.

Что делает (правит байты на месте, размер не меняется):
  1. maxstacksize — пересчитывает из кода по реальным правилам Lua 5.1
     (A/B/C только там, где операнд действительно регистр; плюс диапазоны
     для CALL/RETURN/SETLIST/TFORLOOP/FORPREP/LOADNIL/CONCAT);
  2. nups — по максимальному B у GETUPVAL/SETUPVAL;
  3. is_vararg — ставит VARARG_ISVARARG (1), если в коде есть OP_VARARG.

CASCADE писал maxstack=250 «на глаз» → unluac выдавал 250 пустых локалов
в каждой функции и падал на индексе 250, а Lua ругался "bad code".

    python3 luac_fix.py in.luac [-o out.luac] [--inplace]
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

# 'R' — всегда регистр, 'K' — RK (регистр, если < 256), 'N' — не регистр
ARGS = {
    0: ("R", "R", "N"), 1: ("R", "N", "N"), 2: ("R", "N", "N"), 3: ("R", "R", "N"),
    4: ("R", "N", "N"), 5: ("R", "N", "N"), 6: ("R", "R", "K"), 7: ("R", "N", "N"),
    8: ("R", "N", "N"), 9: ("R", "K", "K"), 10: ("R", "N", "N"), 11: ("R", "R", "K"),
    12: ("R", "K", "K"), 13: ("R", "K", "K"), 14: ("R", "K", "K"), 15: ("R", "K", "K"),
    16: ("R", "K", "K"), 17: ("R", "K", "K"), 18: ("R", "R", "N"), 19: ("R", "R", "N"),
    20: ("R", "R", "N"), 21: ("R", "R", "R"), 22: ("R", "N", "N"), 23: ("N", "K", "K"),
    24: ("N", "K", "K"), 25: ("N", "K", "K"), 26: ("R", "N", "N"), 27: ("R", "R", "N"),
    28: ("R", "N", "N"), 29: ("R", "N", "N"), 30: ("R", "N", "N"), 31: ("R", "N", "N"),
    32: ("R", "N", "N"), 33: ("R", "N", "N"), 34: ("R", "N", "N"), 35: ("R", "N", "N"),
    36: ("R", "N", "N"), 37: ("R", "N", "N"),
}


def dec(i):
    return (i & 0x3F, (i >> 6) & 0xFF, (i >> 23) & 0x1FF, (i >> 14) & 0x1FF)


def needed(code, numparams, nups, children):
    top = max(numparams, 0)
    for pc, ins in enumerate(code):
        op, a, b, c = dec(ins)
        modes = ARGS.get(op)
        if modes is None:
            top = max(top, a + 1)
            continue
        if modes[0] == "R":
            top = max(top, a + 1)
        for v, m in ((b, modes[1]), (c, modes[2])):
            if m == "R":
                top = max(top, v + 1)
            elif m == "K" and v < 256:
                top = max(top, v + 1)
        if op in (28, 29):                      # CALL / TAILCALL
            if b > 0:
                top = max(top, a + b + 1)
            if c > 0:
                top = max(top, a + c)
        elif op == 30:                          # RETURN
            if b > 0:
                top = max(top, a + b)
        elif op == 34:                          # SETLIST
            if b > 0:
                top = max(top, a + b + 1)
        elif op == 33:                          # TFORLOOP
            if c > 0:
                top = max(top, a + 2 + c + 1)
        elif op in (31, 32):                    # FORLOOP / FORPREP
            top = max(top, a + 4)
        elif op == 21:                          # CONCAT
            top = max(top, c + 1)
        elif op == 3:                           # LOADNIL
            top = max(top, b + 1)
        elif op == 11:                          # SELF
            top = max(top, a + 2)
    return min(max(top, 2), 250)


class Fixer:
    def __init__(self, data):
        self.d = bytearray(data)
        self.rep = []

    def fix_func(self, pos):
        d = self.d

        def u32(p):
            return struct.unpack("<I", d[p:p + 4])[0]

        def i32(p):
            return struct.unpack("<i", d[p:p + 4])[0]

        p = pos
        n = u32(p)
        p += 4 + (n if n else 0)                # source
        p += 4 + 4                              # linedefined, lastlinedefined
        nups_pos = p
        nups = d[p]
        numparams = d[p + 1]
        vararg_pos = p + 2
        maxstack_pos = p + 3
        p += 4
        ncode = i32(p)
        p += 4
        code = list(struct.unpack("<%dI" % ncode, d[p:p + 4 * ncode])) if ncode else []
        p += 4 * ncode
        nk = i32(p)
        p += 4
        for _ in range(nk):
            t = d[p]
            p += 1
            if t == 1:
                p += 1
            elif t == 3:
                p += 8
            elif t == 4:
                ln = u32(p)
                p += 4 + ln
        nprotos = i32(p)
        p += 4
        children = []
        for _ in range(nprotos):
            child_nups, child_pos = self.fix_func(p)
            children.append(child_nups)
            p = child_pos
        # хвост (lineinfo / locvars / upvalues) не нужен — только пройти дальше
        n = i32(p)
        p += 4 + 4 * n
        n = i32(p)
        p += 4
        for _ in range(n):
            ln = u32(p)
            p += 4 + ln + 8
        n = i32(p)
        p += 4
        for _ in range(n):
            ln = u32(p)
            p += 4 + ln

        real_nups = 0
        for ins in code:
            op, a, b, c = dec(ins)
            if op in (4, 8) and b >= real_nups:
                real_nups = b + 1
        new_nups = min(real_nups, 255)
        new_ms = needed(code, numparams, new_nups, children)
        has_vararg = any(dec(i)[0] == 37 for i in code)
        new_va = 1 if (has_vararg or d[vararg_pos] & 1) else 0

        if d[maxstack_pos] != new_ms or d[nups_pos] != new_nups or d[vararg_pos] != new_va:
            self.rep.append((nups_pos, nups, new_nups, maxstack_pos, d[maxstack_pos], new_ms,
                             d[vararg_pos], new_va))
        d[nups_pos] = new_nups
        d[maxstack_pos] = new_ms
        d[vararg_pos] = new_va
        return new_nups, p


def fix(data):
    f = Fixer(data)
    f.fix_func(12)
    return bytes(f.d), f.rep


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("-o", "--output")
    ap.add_argument("--inplace", action="store_true")
    ap.add_argument("-q", "--quiet", action="store_true")
    a = ap.parse_args()
    data = open(a.input, "rb").read()
    out, rep = fix(data)
    dst = a.input if a.inplace else (a.output or a.input + ".fixed")
    open(dst, "wb").write(out)
    if not a.quiet:
        for r in rep:
            print("[fix] proto: nups %d->%d, maxstack %d->%d, vararg %d->%d"
                  % (r[1], r[2], r[4], r[5], r[6], r[7]))
    print("[+] %s -> %s (%d прототипов исправлено)" % (a.input, dst, len(rep)))


if __name__ == "__main__":
    main()
