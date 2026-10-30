#!/usr/bin/env python3
"""Split a Lua 5.1 chunk into one chunk per prototype ("function salvage").

Some chunks that devirtualizers emit make unluac abort on a single bad
prototype (`IllegalStateException: IfThenEndBlock`, `Implicit return must have
zero values`) even though every other function in the file is fine.  Each
prototype in a Lua 5.1 chunk is self-contained (constants, code, children), so
we can re-serialise it as the main prototype of its own chunk and decompile the
file function by function, keeping whatever succeeds.

Every prototype that owns upvalues is additionally wrapped in a synthetic main
prototype (`CLOSURE 0 0; RETURN 0 1`) that declares the same number of
upvalues, otherwise unluac aborts with
`NullPointerException: ... "func.parent" is null`.

usage:
  lua51_split.py in.luac OUTDIR [--wrap]
"""
import os
import struct
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from lua51_repair import Reader, setup   # noqa: E402


def scan(r, path, found):
    """Record (path, start, end) byte ranges of every prototype."""
    start = r.p
    r.string(); r.int(); r.int()                    # source / linedefined / lastline
    r.byte(); r.byte(); r.byte(); r.byte()          # nups/numparams/is_vararg/maxstack
    n = r.int()
    r.raw(4 * n)                                    # code
    for _ in range(r.int()):                        # constants
        t = r.byte()
        if t == 1:
            r.byte()
        elif t == 3:
            r.num()
        elif t == 4:
            r.string()
    for i in range(r.int()):                        # nested prototypes
        scan(r, "%s.p%d" % (path, i), found)
    for _ in range(r.int()):                        # debug: lines
        r.int()
    for _ in range(r.int()):                        # debug: locals
        r.string(); r.int(); r.int()
    for _ in range(r.int()):                        # debug: upvalues
        r.string()
    end = r.p
    found.append((path, start, end))
    return end


def nups_of(body, header):
    """Number of upvalues declared by a serialised prototype."""
    r = Reader(header + body)
    setup(r, header + body)
    r.string()
    r.int()
    r.int()
    return r.byte()


def sizes(header):
    """(int-format, size_t-format) declared by the chunk header."""
    endian = header[6]
    e = "<" if endian == 1 else ">"
    return e + "i", e + ("I" if header[5] == 4 else "Q")


def wrap_chunk(header, body):
    """header + synthetic main proto whose only child is `body`."""
    k = nups_of(body, header)
    ifmt, sfmt = sizes(header)
    def sint(v):
        return struct.pack(ifmt, v)
    def ssize(v):
        return struct.pack(sfmt, v)
    code = struct.pack("<2I",
                       (10 | (0 << 6)),                  # CLOSURE  r0 -> child 0
                       (30 | (0 << 6) | (1 << 23)))      # RETURN   r0 1
    out = bytearray(header)
    out += ssize(0)                                      # source = NULL
    out += sint(0) + sint(0)                             # linedefined / lastline
    out += bytes([0, 0, 0, 2])                           # nups, nparams, vararg, stack
    out += sint(2) + code                                # code
    out += sint(0)                                       # constants
    out += sint(1) + body                                # one nested prototype
    out += sint(0) * 3                                   # stripped debug info
    return bytes(out)


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        raise SystemExit(2)
    data = open(sys.argv[1], "rb").read()
    outdir = sys.argv[2]
    wrap = "--wrap" in sys.argv
    os.makedirs(outdir, exist_ok=True)
    r = Reader(data)
    setup(r, data)
    hdr = r.p
    found = []
    walk = Reader(data)
    setup(walk, data)
    found = []
    scan(walk, "main", found)
    written = 0
    for i, (path, start, end) in enumerate(found):
        body = data[start:end]
        dst = os.path.join(outdir, "f%03d.luac" % i)
        chunk = data[:hdr] + body
        if wrap:
            chunk = wrap_chunk(data[:hdr], body)
        with open(dst, "wb") as f:
            f.write(chunk)
        written += 1
    # keep the mapping so the merge step can label the functions
    with open(os.path.join(outdir, "MAP.txt"), "w") as f:
        for i, (path, start, end) in enumerate(found):
            f.write("f%03d\t%s\t%d\t%d\n" % (i, path, start, end))
    print("split %d prototypes -> %s" % (written, outdir))


if __name__ == "__main__":
    main()
