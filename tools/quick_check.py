import re, sys, glob
from luaparser import ast
def prep(src):
    # Luau -> Lua 5.3: составные присваивания и continue
    src = re.sub(r'^(\s*)([\w\.\[\]"\']+)\s*\+=\s*(.+)$', r'\1\2 = \2 + (\3)', src, flags=re.M)
    src = re.sub(r'^(\s*)([\w\.\[\]"\']+)\s*-=\s*(.+)$', r'\1\2 = \2 - (\3)', src, flags=re.M)
    src = re.sub(r'^(\s*)([\w\.\[\]"\']+)\s*\*=\s*(.+)$', r'\1\2 = \2 * (\3)', src, flags=re.M)
    src = re.sub(r'^(\s*)([\w\.\[\]"\']+)\s*/=\s*(.+)$', r'\1\2 = \2 / (\3)', src, flags=re.M)
    src = re.sub(r'\bcontinue\b', '--[[continue]]', src)
    return src
bad = 0
for f in sorted(glob.glob('/home/user/deobf/ouroboros_*.lua')):
    if 'ps2_resolved' in f: continue
    try:
        ast.parse(prep(open(f, encoding='utf-8').read()))
        print(f'{f.split("/")[-1]:34} ок')
    except Exception as e:
        bad += 1
        print(f'{f.split("/")[-1]:34} ОШИБКА: {str(e)[:150]}')
sys.exit(1 if bad else 0)
