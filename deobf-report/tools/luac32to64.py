#!/usr/bin/env python3
"""luac32to64.py — конвертер байткода Lua 5.1 из 32-битного формата в 64-битный.

Зачем: CASCADE/IronBrew-девиртуализаторы пишут чанки в формате 32-битной сборки
Lua (sizeof(size_t)=4). Наш Lua 5.1.1 собран 64-битным (sizeof(size_t)=8),
поэтому `loadfile` падает "bad header in precompiled chunk".

Меняется только префикс длины у строк (size_t 4 -> 8 байт); int-поля (код,
счётчики) в Lua 5.1 всегда 4 байта. Instruction = 4, lua_Number = 8.

Использование:
    python3 luac32to64.py input.luac -o output.luac [--inplace]
"""
import argparse
import struct
import sys

INT = 4


class Reader:
    def __init__(self, data):
        self.d = data
        self.p = 0

    def take(self, n):
        if self.p + n > len(self.d):
            raise ValueError("unexpected EOF at %d (need %d)" % (self.p, n))
        r = self.d[self.p:self.p + n]
        self.p += n
        return r

    def int(self):
        (v,) = struct.unpack("<i", self.take(INT))
        return v

    def sz(self):
        (v,) = struct.unpack("<I", self.take(4))
        return v

    def byte(self):
        return self.take(1)[0]

    def string(self):
        n = self.sz()
        if n == 0:
            return b""
        return self.take(n)


class Writer:
    def __init__(self):
        self.out = bytearray()

    def raw(self, b):
        self.out += b

    def int(self, v):
        self.out += struct.pack("<i", v)

    def sz(self, v):
        self.out += struct.pack("<Q", v)

    def byte(self, v):
        self.out += bytes([v & 0xFF])

    def string(self, s):
        if not s:
            self.sz(0)
        else:
            self.sz(len(s))
            self.raw(s)


def convert_func(r, w):
    w.string(r.string())                 # source
    w.int(r.int())                       # linedefined
    w.int(r.int())                       # lastlinedefined
    w.byte(r.byte())                     # nups
    w.byte(r.byte())                     # numparams
    w.byte(r.byte())                     # is_vararg
    w.byte(r.byte())                     # maxstacksize

    n = r.int()                          # code
    w.int(n)
    w.raw(r.take(4 * n))

    n = r.int()                          # constants
    w.int(n)
    for _ in range(n):
        t = r.byte()
        w.byte(t)
        if t == 0:                       # nil
            pass
        elif t == 1:                     # boolean
            w.byte(r.byte())
        elif t == 3:                     # number
            w.raw(r.take(8))
        elif t == 4:                     # string
            w.string(r.string())
        else:
            raise ValueError("bad constant type %d at %d" % (t, r.p))

    n = r.int()                          # protos
    w.int(n)
    for _ in range(n):
        convert_func(r, w)

    n = r.int()                          # lineinfo
    w.int(n)
    w.raw(r.take(4 * n))

    n = r.int()                          # locvars
    w.int(n)
    for _ in range(n):
        w.string(r.string())
        w.int(r.int())
        w.int(r.int())

    n = r.int()                          # upvalue names
    w.int(n)
    for _ in range(n):
        w.string(r.string())

    return w


def convert(data):
    if data[:4] != b"\x1bLua":
        raise ValueError("not a Lua chunk")
    if data[4] != 0x51:
        raise ValueError("not Lua 5.1 (version byte 0x%02x)" % data[4])
    ss = data[8]                         # sizeof(size_t) in header
    if ss == 8:
        return data                      # уже 64-бит
    if ss != 4:
        raise ValueError("unsupported sizeof(size_t) = %d" % ss)

    r = Reader(data)
    head = bytearray(r.take(12))
    head[8] = 8                          # sizeof(size_t)
    w = Writer()
    w.raw(bytes(head))
    convert_func(r, w)
    if r.p != len(data):
        sys.stderr.write("[!] остаток %d байт не разобран\n" % (len(data) - r.p))
    return bytes(w.out)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("-o", "--output")
    ap.add_argument("--inplace", action="store_true")
    a = ap.parse_args()
    data = open(a.input, "rb").read()
    out = convert(data)
    dst = a.output or (a.input if a.inplace else a.input + ".64")
    open(dst, "wb").write(out)
    print("[+] %s: %d B -> %d B (%s)" % (a.input, len(data), len(out), dst))


if __name__ == "__main__":
    main()
