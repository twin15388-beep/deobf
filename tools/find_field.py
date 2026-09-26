"""Найти поле пула, содержащее смещение в файле артефакта.

usage: python3 tools/find_field.py <offset> [--artifact FILE] [--poolref EXPR]
Печатает номер поля (его можно скормить `tools/read_fn.py --pool N`),
имя ключа (если поле именованное) и первые 80 символов тела.
"""
import sys, importlib.util
sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat

def main(argv):
    off = int(argv[0])
    art = argv[argv.index("--artifact") + 1] if "--artifact" in argv else "ouroboros_ps2 (1).luau"
    ref = argv[argv.index("--poolref") + 1] if "--poolref" in argv else "cKb[136]"
    src = open(art, encoding="utf-8", errors="replace").read()
    toks = list(luaflat.tokenize(src))
    spec = importlib.util.spec_from_file_location("rf", __file__.rsplit("/", 1)[0] + "/read_fn.py")
    rf = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(rf)
    fields = rf.pool_fields(toks, ref, src)
    for n, (key, raw, a, b) in enumerate(fields, 1):
        if a <= off <= b:
            print("поле #%d  ключ=%r  %d..%d  %s" % (n, key, a, b, raw[:80].replace("\n", " ")))
            return
    print("смещение %d не внутри пула" % off)

if __name__ == "__main__":
    main(sys.argv[1:])
