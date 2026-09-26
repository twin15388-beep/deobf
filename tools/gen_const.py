"""Выгрузка литеральных констант cKb[141] из артефакта -> data/const_141.json.

Берём только «простые» значения (число, строка, таблица-литерал), потому что
ссылки на функции (F-слоты, пул-функции) в сборке заменяются заглушками.

Usage: python3 tools/gen_const.py
"""
import json
import re

SRC = "ouroboros_main_pruned.txt"
OUT = "data/const_141.json"

HEAD = re.compile(r'cKb \[141\] \["([A-Za-z_][A-Za-z0-9_]*)"\] = ')


def literal(text, start):
    """Возвращает (текст-литерала, конец) или (None, start)."""
    while start < len(text) and text[start] == " ":
        start += 1
    if start >= len(text):
        return None, start
    ch = text[start]
    if ch == "{":
        depth, j = 0, start
        while j < len(text):
            c = text[j]
            if c == "{":
                depth += 1
            elif c == "}":
                depth -= 1
                if depth == 0:
                    return text[start:j + 1], j + 1
            elif c == '"':
                j += 1
                while j < len(text) and text[j] != '"':
                    if text[j] == "\\":
                        j += 1
                    j += 1
            j += 1
        return None, start
    if ch == '"':
        j = start + 1
        while j < len(text) and text[j] != '"':
            if text[j] == "\\":
                j += 1
            j += 1
        return text[start:j + 1], j + 1
    m = re.match(r'-?[\d.]+([eE][-+]?\d+)?', text[start:])
    if m:
        return m.group(0), start + m.end()
    return None, start


def main():
    src = open(SRC, encoding="utf-8", errors="replace").read()
    found = {}
    for m in HEAD.finditer(src):
        value, end = literal(src, m.end())
        if value is None:
            continue
        # мусор от подстановки пула (например «bpe [...]»), оставляем только числа/строки/таблицы
        if value.startswith("{") and re.search(r'\bF\d+\b|\[\w+\]\[', value):
            continue
        found.setdefault(m.group(1), value)
    json.dump(found, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print("констант cKb[141]: %d -> %s" % (len(found), OUT))
    for key in sorted(found)[:40]:
        print("   %-24s %s" % (key, found[key][:80]))


if __name__ == "__main__":
    main()
