"""Проверка строковых литералов в собранном файле.

Lua не допускает «сырых» переводов строки и управляющих символов внутри
коротких строк ("..."), а такие символы встречаются в строках пула артефакта
(например [3189]). Этот чекер токенизирует файл и падает, если внутри
строкового токена оказался символ < 0x20 (кроме табов в длинных строках [[ ]])
или незакрытая строка.

Usage: python3 tools/check_strings.py [file]
"""
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat  # noqa: E402


def main(path="ouroboros_recon.lua"):
    src = open(path, encoding="utf-8").read()
    bad = []
    for kind, text, start, end in luaflat.tokenize(src):
        if kind != "str":
            continue
        line = src.count("\n", 0, start) + 1
        if len(text) >= 2 and text[1] in "[":          # длинная строка [[ ]]
            continue
        for ch in text:
            if ord(ch) < 32:
                bad.append((line, hex(ord(ch))))
                break
        else:
            if not text.endswith(text[0]):
                bad.append((line, "не закрыта"))
    for line, what in bad[:20]:
        print("СТРОКА %d: %s" % (line, what))
    print("проверено %d строк-литералов, проблем: %d" % (
        sum(1 for k, *_ in luaflat.tokenize(src) if k == "str"), len(bad)))
    return 1 if bad else 0


if __name__ == "__main__":
    raise SystemExit(main(*sys.argv[1:]))
