"""Прочитать функцию артефакта: по смещению в файле или по номеру в пуле.

Поддерживает обе сборки:

* 2026-09-21 (`ouroboros_ps2 (1).luau`) — пул `cKb[136]`, состояния вложенных машин
  нумеруются в пределах функции;
* 2026-09-26 (`artifacts/ps2_2026-09-26.luau`) — пул `fwe[164]` (массив на 11 071
  значение), а «регистры»-переменные лежат в таблице `fwe`, поэтому в тексте кода
  видны `fwe[N]`, а не `local`.

Usage:
    python3 tools/read_fn.py --offset 1950332
    python3 tools/read_fn.py --pool 6 --poolref "fwe[164]" \
        --artifact artifacts/ps2_2026-09-26.luau --pooldata data/pool_index_2026-09-26.json --names

Опции:
    --offset N        смещение в файле: печатает функцию, которая его содержит
    --pool N          прочитать N-е поле пула (для массива — его индекс)
    --artifact FILE   файл артефакта (по умолчанию `ouroboros_ps2 (1).luau`)
    --poolref EXPR    выражение пула в исходнике (по умолчанию `cKb[136]`)
    --alias NAME      локальный псевдоним пула (например `cTz`), если он есть в функции
    --pooldata FILE   индекс пула (JSON) для --names
    --names           подставлять значения пула вместо `[N]`
    --raw             не выкидывать строки-заглушки состояний
"""

import json
import re
import subprocess
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat  # noqa: E402
import luascan  # noqa: E402


def enclosing_function(toks, offset):
    """(start, stop, a, b) самой вложенной функции, содержащей смещение."""
    sc = luascan.Scanner(toks)
    best = None
    for i, tok in enumerate(toks):
        if tok[1] != "function" or tok[2] > offset:
            continue
        stop = sc.skip_value(i)
        a, b = tok[2], toks[stop - 1][3]
        if a <= offset <= b and (best is None or a > best[0]):
            best = (i, stop, a, b)
    return best


def pool_fields(toks, poolref, src=None):
    """Поля таблицы пула: список (key, raw, start, end).

    `raw` — срез ИСХОДНИКА (с пробелами): склейка текстов токенов теряет пробелы
    и лепит ключевые слова к именам (`local cbI` -> `localcbI`), после чего код
    уже не разбирается.
    """
    text = "".join(t[1] for t in toks)
    want = "".join(c for c in poolref if not c.isspace()) + "="
    spans, acc = [], 0
    for t in toks:
        spans.append(acc)
        acc += len(t[1])
    pos = text.find(want)
    while pos >= 0:
        j = pos + len(want)
        if text[j:j + 1] == "{":
            idx = max(i for i, s in enumerate(spans) if s <= j)
            end = luascan.table_end(toks, idx)
            fields = []
            for key, raw, a, b in luascan.scan_fields(toks, idx, end):
                if src is not None:
                    raw = src[toks[a][2]:toks[b - 1][3]]
                fields.append((key, raw, a, b))
            return fields
        pos = text.find(want, pos + 1)
    return []


def lua_poolref_wrapper(poolref, body):
    """Обёртка «таблица с одним полем — наша функция» для deflatten --pool 1."""
    head = poolref.split("[")[0]
    return "%s = {}\n%s = {\n%s\n}\n" % (head, poolref, body)


def main(argv):
    art = "ouroboros_ps2 (1).luau"
    if "--artifact" in argv:
        art = argv[argv.index("--artifact") + 1]
    poolref = argv[argv.index("--poolref") + 1] if "--poolref" in argv else "cKb[136]"
    pooldata = argv[argv.index("--pooldata") + 1] if "--pooldata" in argv else "data/pool_index.json"
    alias = argv[argv.index("--alias") + 1] if "--alias" in argv else None

    src = open(art, encoding="utf-8", errors="replace").read()
    toks = list(luaflat.tokenize(src))

    label = ""
    if "--pool" in argv:
        idx = int(argv[argv.index("--pool") + 1])
        fields = pool_fields(toks, poolref, src)
        if idx > len(fields):
            sys.exit("в пуле только %d полей" % len(fields))
        _, raw, a, b = fields[idx - 1]
        label = "пул %s[%d]" % (poolref, idx)
    else:
        off = int(argv[argv.index("--offset") + 1]) if "--offset" in argv else None
        if off is None:
            sys.exit(__doc__)
        found = enclosing_function(toks, off)
        if not found:
            sys.exit("функция на смещении %d не найдена" % off)
        _, _, a, b = found
        raw = src[a:b]
        label = "функция @%d..%d" % (a, b)

    import deflatten as D

    btoks = list(luaflat.tokenize(raw))
    fl = D.Flattener(btoks, [], {})
    parser = D.luaast.ExprAstParser(btoks)
    parser.i = 0
    try:
        node = parser.parse_simple_expr()
    except Exception as exc:                                    # noqa: BLE001
        print("-- (не удалось разобрать: %s)" % exc)
        return
    lines = fl.render_stmts(node.body, "  ", set()) if hasattr(node, "body") else [fl.render(node)]
    text = "\n".join(lines)

    if "--names" in argv:
        pool = json.load(open(pooldata, encoding="utf-8"))

        def rep(m):
            key = m.group(1).rstrip(".")
            val = pool.get(key)
            if isinstance(val, str):
                return '"%s"' % val
            if isinstance(val, dict):
                return "%s/f%s/" % (val.get("expr") or ("fn" if val.get("function") else "table"), key)
            return "%s/%s/" % (val, key)

        # ссылка на пул: `cKb [136] [N]` / `fwe [164] [N]`
        head = poolref.replace("[", r"\s*\[\s*").replace("]", r"\s*\]\s*")
        text = re.sub(head + r"\[\s*(\d+\.?)\s*\]", rep, text)
        # локальные псевдонимы пула (`local cTz = cKb[136]`)
        if alias:
            for name in alias.split(","):
                text = re.sub(re.escape(name.strip()) + r"\s*\[\s*(\d+\.?)\s*\]", rep, text)

    if "--raw" not in argv:
        keep = []
        for line in text.split("\n"):
            s = line.strip()
            if not s or s.startswith("-- state") or s.startswith("-->") or s.startswith("-- ("):
                continue
            if re.fullmatch(r"(break|return|goto \d+|end|\})", s):
                continue
            keep.append(line)
        text = "\n".join(keep)
    print("-- %s: %s" % (art, label))
    print(text)


if __name__ == "__main__":
    main(sys.argv[1:])
