"""Показать окно исходника артефакта с подстановкой значений пула.

В обеих сборках код читает константы из общей таблицы-пула:
  * 2026-09-21 — `cKb[136][N]` (ключи, N — «номер» константы);
  * 2026-09-26 — `fwe[164][N]` (индекс в массиве, N — позиция, 1..11071).

Скрипт берёт `data/pool_index*.json` и печатает окно, заменяя обращения к пулу на
значения: строки — как есть, функция/таблица — пометкой.

Usage:
    python3 tools/read_region.py <start> <end> [alias] [--artifact FILE] [--pool FILE]

    python3 tools/read_region.py 1947331 1948600 cTz --artifact "ouroboros_ps2 (1).luau"
    python3 tools/read_region.py 3292571 3293500 fwe --artifact artifacts/ps2_2026-09-26.luau \
        --pool data/pool_index_2026-09-26.json
"""

import json
import re
import sys


def load_pool(path):
    data = json.load(open(path, encoding="utf-8"))
    out = {}
    for k, v in data.items():
        out[k.rstrip(".")] = v
    return out


def main(argv):
    start, end = int(argv[0]), int(argv[1])
    rest = argv[2:]
    alias = rest[0] if rest and not rest[0].startswith("--") else "cTz"
    pool_expr = argv[argv.index("--poolref") + 1] if "--poolref" in argv else "cKb[136]"
    art = "ouroboros_ps2 (1).luau"
    pool_path = "data/pool_index.json"
    if "--artifact" in argv:
        art = argv[argv.index("--artifact") + 1]
    if "--pool" in argv:
        pool_path = argv[argv.index("--pool") + 1]
    pool = load_pool(pool_path)
    src = open(art, encoding="utf-8", errors="replace").read()

    def sub(m):
        key = m.group(1).rstrip(".")
        val = pool.get(key)
        if isinstance(val, str):
            return '"%s"' % val
        if isinstance(val, dict):
            kind = val.get("expr") or ("fn" if val.get("function") else "table")
            return "%s/*F%s*/" % (kind, key)
        return "%s/*%s*/" % (val, key)

    text = src[start:end]
    # псевдонимы пула внутри окна: `local cTz = cKb[136]` (в склеенном тексте — `localcTz=…`)
    names = {alias}
    probe = re.sub(r"\blocal(?=[A-Za-z_])", "local ", text)
    for m in re.finditer(r"(?:^|[^A-Za-z0-9_])([A-Za-z_]\w*)\s*=\s*" + re.escape(pool_expr) + r"(?![0-9])", probe):
        names.add(m.group(1))
    # сам пул (в исходнике пишется как cKb[136])
    text = re.sub(re.escape(pool_expr).replace(r"\[", r"\s*\[\s*").replace(r"\]", r"\s*\]\s*")
                  + r"\s*\[\s*(\d+\.?)\s*\]", sub, text)
    for name in sorted(names, key=len, reverse=True):
        text = re.sub(r"(?<![\w.])" + re.escape(name) + r"\s*\[\s*(\d+\.?)\s*\]", sub, text)
    sys.stdout.write(text)
    if not text.endswith("\n"):
        sys.stdout.write("\n")


if __name__ == "__main__":
    main(sys.argv[1:])
