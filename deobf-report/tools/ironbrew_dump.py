#!/usr/bin/env python3
"""Dump an 'IronBrew'/'Wander'-style Lua 5.1 VM bytecode payload (as embedded by
NoobieDoge's DogeHub ShindoLife / ElektroSploit / Luraph v1.6-family protectors).
Format (from the embedded VM reader K()):
  header: '\\x1bLua' + s()==0x51 + s() format + s() endian + s() intsize(a1) + s() sizet(a2) + H(3)==\\4\\8\\0
  proto : Name=H() (size_t-prefixed, trailing NUL stripped), FirstL=r(), LastL=r(),
          Upvals=s(), Args=s(), Vargs=s(), Stack=s(),
          Instr n=r(), each u() 4 bytes: enum=bits1-6, A=bits7-14(6b), B=bits15-23(9b),
                                       C=bits24-32(9b) or ABx, AsBx=ABx-131071; fmt via g[]/OpArg via f[]
          Const n=r(): T=s(): 1=bool(s()~=0) 3=double(A() = LE pair of u32) 4=string(H(),1,-2)
          Proto  n=r(): nested protos (same layout)
          Lines  n=r(): u() each
          Locals n=r(): H() u() u()
          Upnames n=r(): H() each
r() = int reader per a1 (4 or 8), H() = size_t-prefixed bytes (I=q(), 4 or 8).
Read-only; does not execute anything."""
import struct, sys, json

class R:
    def __init__(self, buf):
        self.b = buf; self.i = 0
    def raw(self, n):
        r = self.b[self.i:self.i+n]; assert len(r) == n, 'EOF at %d' % self.i
        self.i += n; return r
    def s(self): return self.raw(1)[0]
    def u(self): return struct.unpack('<I', self.raw(4))[0]

def parse_payload(path):
    buf = open(path, 'rb').read()
    r = R(buf)
    assert r.raw(4) == b'\x1bLua', 'bad signature'
    assert r.s() == 0x51
    r.s()  # format
    r.s()  # endianness
    a1 = r.s(); a2 = r.s()
    assert r.raw(3) == b'\x04\x08\x00'
    def ri():  # int per a1
        return struct.unpack('<I' if a1 == 4 else '<Q', r.raw(a1))[0]
    def sz():  # size_t per a2
        return struct.unpack('<I' if a2 == 4 else '<Q', r.raw(a2))[0]
    def H():
        n = sz()
        if n == 0: return None
        d = r.raw(n)
        return d[:-1] if d.endswith(b'\x00') else d
    def A():
        lo = r.u(); hi = r.u()
        return struct.unpack('<d', struct.pack('<Q', (hi << 32) | lo))[0]
    def load_proto(depth=0):
        name_b = H()
        name = name_b.decode('latin-1', 'replace') if name_b else None
        first_l, last_l = ri(), ri()
        upvals, args, vargs, stack = r.s(), r.s(), r.s(), r.s()
        ncode = ri()
        code = [r.u() for _ in range(ncode)]
        nconst = ri()
        consts = []
        for _ in range(nconst):
            T = r.s()
            if T == 1: consts.append(('bool', r.s() != 0))
            elif T == 3: consts.append(('number', A()))
            elif T == 4:
                sb = H()
                consts.append(('string', sb.decode('latin-1', 'replace') if sb is not None else None))
            elif T == 0: consts.append(('nil', None))
            else: raise ValueError('unknown const type %d at %d' % (T, r.i))
        nproto = ri()
        protos = [load_proto(depth+1) for _ in range(nproto)]
        nlines = ri(); lines = [r.u() for _ in range(nlines)]
        nloc = ri(); locs = []
        for _ in range(nloc):
            nm = H(); sp = ri(); ep = ri()
            locs.append((nm.decode('latin-1','replace') if nm else None, sp, ep))
        nupn = ri(); upnames = [((H() or b'').decode('latin-1','replace')) for _ in range(nupn)]
        return dict(name=name, first_l=first_l, last_l=last_l, upvals=upvals, args=args,
                    vargs=vargs, stack=stack, code=code, consts=consts, protos=protos,
                    lines=lines, locs=locs, upnames=upnames)
    root = load_proto()
    return r.i, len(buf), root

def main():
    done, total, root = parse_payload(sys.argv[1])
    print('consumed %d/%d bytes' % (done, total))
    if done != total: print('WARNING: %d trailing bytes' % (total - done))
    out = open(sys.argv[2], 'w', encoding='utf-8')
    def walk(p, path='main'):
        out.write('=' * 72 + '\n')
        out.write('proto %s  name=%s  lines %d-%d  args=%d upvals=%d vargs=%d stack=%d\n' % (
            path, p['name'], p['first_l'], p['last_l'], p['args'], p['upvals'], p['vargs'], p['stack']))
        out.write('code=%d consts=%d protos=%d upnames=%s\n' % (
            len(p['code']), len(p['consts']), len(p['protos']), p['upnames']))
        for i, (t, v) in enumerate(p['consts']):
            if t == 'string':
                out.write('  K%-4d %-6s %s\n' % (i, t, json.dumps(v, ensure_ascii=False)))
            elif t == 'number':
                out.write('  K%-4d %-6s %g\n' % (i, t, v))
            else:
                out.write('  K%-4d %-6s %s\n' % (i, t, v))
        if p['locs']:
            out.write('  locals: %s\n' % ', '.join('%s[%d-%d]' % l for l in p['locs']))
        for i, sub in enumerate(p['protos']):
            walk(sub, '%s/%d' % (path, i))
    walk(root)
    out.close()
    print('dump ->', sys.argv[2])

if __name__ == '__main__':
    main()
