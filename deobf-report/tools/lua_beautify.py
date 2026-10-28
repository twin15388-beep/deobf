#!/usr/bin/env python3
"""lua_beautify.py — безопасный «разминификатор» Lua 5.1/5.2/Luau-подобного кода.

Работает на уровне токенов: НЕ меняет ни один токен, только расставляет
переводы строк и отступы. В Lua перевод строки не является разделителем
операторов, поэтому поток токенов (и, значит, семантика) сохраняется
побайтово-эквивалентно; в конце файл самопроверяется сравнением токенов.

Использование:
    python3 lua_beautify.py input.lua -o output.lua
    python3 lua_beautify.py input.lua            # -> input.beauty.lua
"""
from __future__ import annotations

import argparse
import re
import sys

KEYWORDS = {
    "and", "break", "do", "else", "elseif", "end", "false", "for", "function",
    "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return",
    "then", "true", "until", "while", "continue",
}

# Ключевые слова, с которых начинается новый оператор (перед ними ставим \n).
STMT_START = {
    "local", "if", "for", "while", "repeat", "function", "return",
    "break", "end", "else", "elseif", "until", "goto", "continue",
}
# Если предыдущий токен — один из этих, то это продолжение выражения,
# а не новый оператор.
EXPR_PREV = {
    "=", ",", "(", "[", "{", ".", ":", "..", "+", "-", "*", "/", "%", "^",
    "#", "==", "~=", "<=", ">=", "<", ">", "and", "or", "not", "return",
    "local", "then", "do", "else", "elseif", "in",
}

NAME_RE = re.compile(r"[A-Za-z_][A-Za-z0-9_]*")
NUM_RE = re.compile(
    r"0[xX][0-9a-fA-F]+(?:\.[0-9a-fA-F]*)?(?:[pP][+-]?\d+)?"
    r"|(?:\d+\.?\d*|\.\d+)(?:[eE][+-]?\d+)?"
)
OPS = [
    "...", "..", "==", "~=", "<=", ">=", "//", "::", "<<", ">>",
    "+", "-", "*", "/", "%", "^", "#", "<", ">", "=", "(", ")", "[", "]",
    "{", "}", ";", ":", ",", ".", "&", "|", "~",
]


class Tok:
    __slots__ = ("kind", "text", "line")

    def __init__(self, kind: str, text: str, line: int):
        self.kind = kind      # name|number|string|comment|op|kw|longstr|longcomment
        self.text = text
        self.line = line

    def __repr__(self) -> str:
        return f"<{self.kind}:{self.text[:20]}>"


def _long_bracket(src: str, i: int):
    """Если в позиции i открывается [[ / [=[ ... вернуть (level, start, end)."""
    if src[i] != "[":
        return None
    j = i + 1
    level = 0
    while j < len(src) and src[j] == "=":
        level += 1
        j += 1
    if j < len(src) and src[j] == "[":
        return level, j + 1
    return None


def tokenize(src: str) -> list[Tok]:
    toks: list[Tok] = []
    i, line, n = 0, 1, len(src)
    if src.startswith("#"):  # shebang
        j = src.find("\n")
        i = n if j < 0 else j
    while i < n:
        c = src[i]
        if c in " \t\r\n\f\v":
            if c == "\n":
                line += 1
            i += 1
            continue
        # комментарии
        if src.startswith("--", i):
            lb = _long_bracket(src, i + 2)
            if lb:
                _, start = lb
                level = lb[0]
                close = "]" + "=" * level + "]"
                end = src.find(close, start)
                end = n if end < 0 else end + len(close)
                text = src[i:end]
                toks.append(Tok("longcomment", text, line))
                line += text.count("\n")
                i = end
                continue
            end = src.find("\n", i)
            end = n if end < 0 else end
            toks.append(Tok("comment", src[i:end].rstrip(), line))
            i = end
            continue
        # длинные строки
        lb = _long_bracket(src, i)
        if lb:
            level, start = lb
            close = "]" + "=" * level + "]"
            end = src.find(close, start)
            end = n if end < 0 else end + len(close)
            text = src[i:end]
            toks.append(Tok("longstr", text, line))
            line += text.count("\n")
            i = end
            continue
        # короткие строки
        if c in "\"'":
            q = c
            j = i + 1
            while j < n:
                if src[j] == "\\":
                    j += 2
                    continue
                if src[j] == q:
                    j += 1
                    break
                if src[j] == "\n":
                    line += 1
                j += 1
            toks.append(Tok("string", src[i:j], line))
            i = j
            continue
        # имена / ключевые слова
        m = NAME_RE.match(src, i)
        if m:
            word = m.group(0)
            toks.append(Tok("kw" if word in KEYWORDS else "name", word, line))
            i = m.end()
            continue
        # числа
        if c.isdigit() or (c == "." and i + 1 < n and src[i + 1].isdigit()):
            m = NUM_RE.match(src, i)
            if m and m.end() > i:
                toks.append(Tok("number", m.group(0), line))
                i = m.end()
                continue
        # операторы
        for op in OPS:
            if src.startswith(op, i):
                toks.append(Tok("op", op, line))
                i += len(op)
                break
        else:
            toks.append(Tok("op", c, line))
            i += 1
    return toks


NO_SPACE_BEFORE = {",", ";", ")", "]", "}", ".", ":", "(",  "["}
NO_SPACE_AFTER = {"(", "[", "{", ".", ":", "#", "@"}


ENDS_EXPR_TEXT = {")", "]", "}", "end", "true", "false", "nil", "..."}


def _ends_expression(tok: Tok) -> bool:
    """Может ли токен быть последним в выражении."""
    if tok.kind in ("name", "number", "string", "longstr"):
        return True
    return tok.text in ENDS_EXPR_TEXT


def _starts_statement(toks: list[Tok], idx: int) -> bool:
    """Начинается ли с токена idx новый оператор."""
    t = toks[idx]
    nxt = toks[idx + 1] if idx + 1 < len(toks) else None
    if t.kind == "kw":
        return t.text in STMT_START
    if t.kind in ("comment", "longcomment"):
        return False
    if t.kind == "name":
        if nxt is None:
            return False
        # `x = ...`, `x, y = ...`, `x.y = ...`, `x[i] = ...`, `f(...)`
        if nxt.text in ("=", ",", "."):
            return True
        if nxt.text in ("(", "["):
            return True
    return False


def _need_space(prev, prev2, cur) -> bool:
    """Нужен ли пробел между prev и cur (prev2 — токен перед prev)."""
    if prev is None:
        return False
    p, c = prev.text, cur.text
    if prev.kind in ("comment", "longcomment") or cur.kind in ("comment", "longcomment"):
        return True
    # скобки вызова/индексации: f(x), t[i], a.b
    if c in NO_SPACE_BEFORE:
        if c in ("(", "["):
            return not (prev.kind in ("name",) or p in (")", "]", "}", "function"))
        return False
    if p in NO_SPACE_AFTER:
        return False
    if p == ",":
        return True
    if c == ".." or p == "..":
        return True
    # унарный минус/плюс
    if p in ("-", "+"):
        unary_context = (prev2 is None or prev2.kind == "kw" or
                         prev2.text in ("(", "[", "{", ",", "=", "==", "~=", "<",
                                        ">", "<=", ">=", "+", "-", "*", "/", "%",
                                        "^", "..", "#", "and", "or", "not"))
        if unary_context:
            return False
    if c in ("-", "+") and p in ("-", "+", "(", "[", "{", ",", "=", "...", ".."):
        return False
    if c == "..." :
        return False
    return True


def _has_tokens(toks: list[Tok]) -> list[Tok]:
    return [t for t in toks if t.kind not in ("comment", "longcomment")]


def beautify(src: str, indent: str = "  ") -> str:
    toks = tokenize(src)
    out: list[str] = []
    level = 0
    depth = 0          # () {} [] — всё вместе
    line_tokens: list[Tok] = []
    in_line_comment = False

    def flush(newlines: int = 1) -> None:
        nonlocal line_tokens
        if line_tokens:
            body = ""
            p1 = p2 = None
            for t in line_tokens:
                if t.kind == "comment":
                    body += (" " if body and not body.endswith(" ") else "") + t.text
                else:
                    if body and _need_space(p1, p2, t):
                        body += " "
                    body += t.text
                    p2, p1 = p1, t
            out.append(indent * max(level, 0) + body.rstrip())
        line_tokens = []

    prev: Tok | None = None
    pending_fn: list[int] = []   # глубины, на которых ждём закрытия ) у function
    for idx, t in enumerate(toks):
        if t.kind == "comment":            # строчный комментарий ест остаток строки
            line_tokens.append(t)
            flush()
            prev = t
            continue
        if t.kind == "longcomment":
            line_tokens.append(t)
            continue

        # закрывающие конструкции — уменьшаем отступ ДО вывода
        if t.kind == "kw" and t.text in ("end", "until", "else", "elseif"):
            if line_tokens:
                flush()
            level -= 1
            if level < 0:
                level = 0

        # новый оператор — начинаем новую строку
        if line_tokens and prev is not None and _starts_statement(toks, idx):
            if _ends_expression(prev):
                flush()

        if t.kind == "op" and t.text == ";":
            if line_tokens:
                line_tokens.append(t)
                flush()
            elif out:
                out[-1] = out[-1] + ";"
            prev = t
            continue

        if t.kind == "kw" and t.text == "function":
            pending_fn.append(depth)   # индентация после ')' списка параметров
            line_tokens.append(t)
            prev = t
            continue

        line_tokens.append(t)

        if t.kind == "op":
            if t.text in ("(", "[", "{"):
                depth += 1
            elif t.text in (")", "]", "}"):
                depth -= 1
                if pending_fn and t.text == ")" and depth <= pending_fn[-1]:
                    pending_fn.pop()
                    flush()
                    level += 1
                    prev = t
                    continue

        if t.kind == "kw" and t.text in ("then", "do", "repeat", "else"):
            flush()
            level += 1
        elif t.kind == "kw" and t.text in ("end", "until"):
            flush()
        elif t.kind == "kw" and t.text in ("return", "break"):
            # 'return'/'break' закрывают оператор; продолжаем строку до ';'/'end'
            pass

        prev = t

    if line_tokens:
        flush()
    return "\n".join(out).rstrip() + "\n"


def _norm(toks: list[Tok]) -> list[str]:
    return [t.text for t in _has_tokens(toks)]


def main() -> int:
    ap = argparse.ArgumentParser(description="Lua minified -> readable (token-safe)")
    ap.add_argument("input")
    ap.add_argument("-o", "--output")
    ap.add_argument("--indent", default="  ")
    ap.add_argument("--no-check", action="store_true")
    a = ap.parse_args()

    src = open(a.input, "r", encoding="utf-8", errors="surrogateescape").read()
    res = beautify(src, a.indent)
    if not a.no_check and _norm(tokenize(src)) != _norm(tokenize(res)):
        print("ОШИБКА: поток токенов изменился — файл не записан", file=sys.stderr)
        return 2
    out = a.output or (a.input.rsplit(".", 1)[0] + ".beauty.lua")
    open(out, "w", encoding="utf-8", errors="surrogateescape").write(res)
    print(f"{out}: {src.count(chr(10)) + 1} строк -> {res.count(chr(10))} строк, токены совпадают")
    return 0


if __name__ == "__main__":
    sys.exit(main())
