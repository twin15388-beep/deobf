#!/usr/bin/env python3
"""Minimal Lua 5.1 luac dump parser - dumps protos/constants/strings.
Does NOT execute the bytecode; read-only structural parse."""
import struct, sys, json

class R:
    def __init__(self, buf):
        self.b = buf; self.i = 0
    def take(self, n):
        r = self.b[self.i:self.i+n]; self.i += n; return r
    def byte(self): return self.take(1)[0]
    def int32(self): return struct.unpack('<i', self.take(4))[0]
    def size_t(self): return struct.unpack('<I', self.take(4))[0]
    def number(self): return struct.unpack('<d', self.take(8))[0]
    def string(self):
        n = self.size_t()
        if n == 0: return None
        d = self.take(n)
        return d[:-1].decode('latin-1') if d.endswith(b'\x00') else d.decode('latin-1')

class Proto: pass

def load_proto(r, depth=0):
    p = Proto()
    p.source = r.string()
    p.linedefined = r.int32(); p.lastlinedefined = r.int32()
    p.nups = r.byte(); p.numparams = r.byte(); p.is_vararg = r.byte(); p.maxstack = r.byte()
    ncode = r.int32(); p.code = [r.int32() for _ in range(ncode)]
    nconst = r.int32(); p.consts = []
    for _ in range(nconst):
        t = r.byte()
        if t == 0: p.consts.append(('nil', None))
        elif t == 1: p.consts.append(('bool', bool(r.byte())))
        elif t == 3: p.consts.append(('number', r.number()))
        elif t == 4: p.consts.append(('string', r.string()))
        else: p.consts.append(('?'+str(t), None)); print('!! unknown const type', t); raise SystemExit(1)
    ups = r.int32(); p.upvalues = [(r.string(), r.byte(), r.byte()) for _ in range(ups)]
    nproto = r.int32(); p.protos = [load_proto(r, depth+1) for _ in range(nproto)]
    # debug
    nlines = r.int32(); p.debuglines = [r.int32() for _ in range(nlines)]
    nlocs = r.int32(); p.locals = []
    for _ in range(nlocs):
        name = r.string(); startpc = r.int32(); endpc = r.int32()
        p.locals.append((name, startpc, endpc))
    nnames = r.int32(); p.upnames = [r.string() for _ in range(nnames)]
    return p

def main():
    buf = open(sys.argv[1], 'rb').read()
    r = R(buf)
    sig = r.take(5); assert sig == b'\x1bLuaQ', sig
    fmt = r.byte(); endian = r.byte(); isize = r.byte(); ssz = r.byte(); ins = r.byte(); num = r.byte(); integral = r.byte()
    print('header format=%d endian=%d int=%d size_t=%d instr=%d number=%d integral=%d' % (fmt, endian, isize, ssz, ins, num, integral))
    main_proto = load_proto(r)
    print('consumed %d/%d bytes' % (r.i, len(buf)))
    if r.i != len(buf):
        print('WARNING: trailing %d bytes' % (len(buf) - r.i))
    out = open(sys.argv[2], 'w', encoding='utf-8')
    def walk(p, path='main'):
        out.write('=' * 70 + '\nproto %s  src=%s  lines %d-%d  params=%d vararg=%d maxstack=%d nups=%d code=%d consts=%d protos=%d\n' % (
            path, p.source, p.linedefined, p.lastlinedefined, p.numparams, p.is_vararg, p.maxstack, p.nups, len(p.code), len(p.consts), len(p.protos)))
        for i, (t, v) in enumerate(p.consts):
            if t == 'string':
                out.write('  K%-4d %-6s %s\n' % (i, t, json.dumps(v, ensure_ascii=False)))
            elif t == 'number':
                out.write('  K%-4d %-6s %g\n' % (i, t, v))
            else:
                out.write('  K%-4d %-6s %s\n' % (i, t, v))
        if p.locals:
            out.write('  locals: %s\n' % ', '.join('%s[%d-%d]' % l for l in p.locals))
        if p.upnames:
            out.write('  upvalue names: %s\n' % ', '.join(str(n) for n in p.upnames))
        for i, sub in enumerate(p.protos):
            walk(sub, '%s/%d' % (path, i))
    walk(main_proto)
    out.close()
    print('dump written to', sys.argv[2])

if __name__ == '__main__':
    main()
