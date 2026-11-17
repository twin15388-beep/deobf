#!/usr/bin/env python3
"""Disassembler for this family's Lua 5.1-style bytecode (IronBrew/Luraph v1.6 VM).
Bits (stock 5.1 layout): op=bits0-5, A=bits6-13, C=bits14-22, B=bits23-31.
ABx = bits14-31 (Bias 131071 for AsBx). Enum maps 1:1 to standard 5.1 opcodes."""
import struct, sys
sys.path.insert(0, '/home/user/deobf/work/tools')
from ironbrew_dump import parse_payload

OPS = ['MOVE','LOADK','LOADBOOL','LOADNIL','GETUPVAL','GETGLOBAL','GETTABLE','SETGLOBAL',
       'SETUPVAL','SETTABLE','NEWTABLE','SELF','ADD','SUB','MUL','DIV','MOD','POW','UNM',
       'NOT','LEN','CONCAT','JMP','EQ','LT','LE','TEST','TESTSET','CALL','TAILCALL','RETURN',
       'FORLOOP','FORPREP','TFORLOOP','SETLIST','CLOSE','CLOSURE','VARARG']
FMT = ['ABC','ABx','ABC','ABC','ABC','ABx','ABC','ABx','ABC','ABC','ABC','ABC','ABC','ABC',
       'ABC','ABC','ABC','ABC','ABC','ABC','ABC','ABC','AsBx','ABC','ABC','ABC','ABC','ABC',
       'ABC','ABC','ABC','AsBx','AsBx','ABC','ABC','ABC','ABx','ABC']

def dis(p, path, show_consts=False):
    out = []
    if show_consts:
        out.append('constants:')
        for i, (t, v) in enumerate(p['consts']):
            out.append('  K%-3d %-6s %s' % (i, t, v if t != 'string' else repr(v)))
    for pc, R in enumerate(p['code']):
        op = R & 0x3F
        A = (R >> 6) & 0xFF
        C = (R >> 14) & 0x1FF
        B = (R >> 23) & 0x1FF
        Bx = (R >> 14) & 0x3FFFF
        AsBx = Bx - 131071
        fmt = FMT[op] if op < len(FMT) else 'ABC'
        name = OPS[op] if op < len(OPS) else 'OP%d' % op
        if fmt == 'ABC':
            args = 'A=%d B=%d C=%d' % (A, B, C)
            if name == 'LOADBOOL':
                out.append('%4d  LOADBOOL A=%d B=%d C=%d%s' % (pc, A, B, C, ' (skip next)' if C else ''))
            elif op in (23, 24, 25):  # EQ LT LE
                out.append('%4d  %-8s A=%d B=%d C=%d%s' % (pc, name + ('*' if A else ''), A, B, C, '' if pc == 0 else ''))
            elif name == 'TEST':
                out.append('%4d  TEST     A=%d C=%d' % (pc, A, C))
            elif name == 'TESTSET':
                out.append('%4d  TESTSET  A=%d B=%d C=%d' % (pc, A, B, C))
            else:
                out.append('%4d  %-8s %s' % (pc, name, args))
        elif fmt == 'ABx':
            out.append('%4d  %-8s A=%d Bx=%d' % (pc, name, A, Bx))
        else:
            out.append('%4d  %-8s A=%d sBx=%d (-> %d)' % (pc, name, A, AsBx, pc + 1 + AsBx))
    return '\n'.join(out)

def walk(p, path, want, fh):
    if want is None or path == want or (want and path.startswith(want + '/')):
        fh.write('=' * 60 + '\nproto %s (code=%d consts=%d protos=%d)\n' % (path, len(p['code']), len(p['consts']), len(p['protos'])))
        fh.write(dis(p, path, True) + '\n')
    for i, sub in enumerate(p['protos']):
        walk(sub, '%s/%d' % (path, i), want, fh)

def main():
    done, total, root = parse_payload(sys.argv[1])
    out = sys.stdout if len(sys.argv) < 4 or sys.argv[3] == '-' else open(sys.argv[3], 'w')
    proto = sys.argv[2] if len(sys.argv) > 2 and sys.argv[2] != 'all' else None
    walk(root, 'main', proto, out)
    if out is not sys.stdout: out.close()

if __name__ == '__main__':
    main()
