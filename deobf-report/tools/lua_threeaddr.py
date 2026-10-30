#!/usr/bin/env python3
"""lua_threeaddr.py — «схлопывание» трёхадресного кода после unluac.

Девиртуализованный IronBrew-чанк состоит из однотипных присваиваний
(`arg = Instance`, `arg = arg.new`, `L1_1 = "ScreenGui"`, `arg = arg(L1_1)`,
`L1_1 = arg`). Формально это верный Lua, но читать невозможно.

Алгоритм — локальное копирование-распространение внутри «блока» (подряд идущие
присваивания с одинаковым отступом). Временная переменная (arg / L<n>_<m>)
подставляется только в своё последнее использование внутри блока и только если
присваивание стоит ВЫШЕ. За границы блоков (if/for/end/вызовы) не выходим, поэтому
семантика не меняется: подстановка допустима только при единственном чтении.

    python3 lua_threeaddr.py in.lua -o out.lua
"""
import argparse
import re

ASSIGN = re.compile(r"^(\s*)([A-Za-z_]\w*(?:\[[^\]]*\])?(?:\.[A-Za-z_]\w*)*)\s*=\s*(.+?)\s*$")
TEMP = re.compile(r"^L\d+_\d+$")
TOKEN = re.compile(r"[A-Za-z_]\w*")
KEYWORD = re.compile(r"^\s*(local|if|else|elseif|for|while|repeat|until|end|function|return|do)\b")


def is_temp(name):
    return bool(TEMP.match(name)) or name == "arg"


def process_block(chunk, out):
    """chunk: [(indent, lhs, rhs)] — подряд идущие присваивания с равным отступом"""
    uses = {}
    for _, _, rhs in chunk:
        for t in TOKEN.findall(rhs):
            uses[t] = uses.get(t, 0) + 1

    live = []          # [(name, indent, expr)]
    live_by_name = {}

    def drop(name):
        nonlocal live
        live = [x for x in live if x[0] != name]
        live_by_name.pop(name, None)

    for indent, lhs, rhs in chunk:
        # ВНИМАНИЕ: межпеременная подстановка по «единственному использованию»
        # отключена — unluac переиспользует имена локальных, и такая подстановка
        # даёт неверный код. Оставлена только склейка цепочки X = X.f / X = X(...).
        for name in ([] if True else sorted([n for n in live_by_name if re.search(r"\b%s\b" % re.escape(n), rhs)],
                           key=len, reverse=True)):
            e = live_by_name[name][2]
            used_here = len(re.findall(r"\b%s\b" % re.escape(name), rhs))
            uses[name] -= used_here
            if uses[name] <= 0:
                if re.fullmatch(r"[\w.\"'\[\]]+", e):
                    rhs = re.sub(r"\b%s\b" % re.escape(name), e, rhs)
                else:
                    rhs = re.sub(r"\b%s\b" % re.escape(name), "(%s)" % e, rhs)
                drop(name)
        # аргументы, которые были израсходованы, но остались живы, не подставляем

        base = lhs.split("[")[0].split(".")[0]

        # любое чтение «отложенного» имени, кроме склейки собственной цепочки,
        # требует сначала материализовать присваивание (иначе прочитаем старое значение)
        for name in [n for n in live_by_name if n != base and re.search(r"\b%s\b" % re.escape(n), rhs)]:
            e = live_by_name[name]
            out.append("%s%s = %s" % (e[1], name, e[2]))
            drop(name)

        if base in live_by_name and re.search(r"\b%s\b" % re.escape(base), rhs):
            # цепочка X = X.f / X = X(...): старое значение читается только здесь
            e = live_by_name[base][2]
            if re.fullmatch(r"[\w.\"'\[\]]+", e):
                rhs = re.sub(r"\b%s\b" % re.escape(base), e, rhs)
            else:
                rhs = re.sub(r"\b%s\b" % re.escape(base), "(%s)" % e, rhs)
            uses[base] -= len(re.findall(r"\b%s\b" % re.escape(base), rhs))
            drop(base)

        if is_temp(base):
            drop(base)
            live.append((base, indent, rhs))
            live_by_name[base] = (base, indent, rhs)
            if lhs != base:
                # запись в индекс/поле: материализуем объект отдельно
                pass
        else:
            out.append("%s%s = %s" % (indent, lhs, rhs))

    for name, indent, expr in live:
        out.append("%s%s = %s" % (indent, name, expr))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("-o", "--output")
    a = ap.parse_args()

    lines = open(a.input, encoding="utf-8").read().split("\n")
    out = []
    chunk = []
    chunk_indent = None

    for ln in lines:
        m = None if KEYWORD.match(ln) else ASSIGN.match(ln)
        if m:
            indent = m.group(1)
            if chunk and indent != chunk_indent:
                process_block(chunk, out)
                chunk = []
            chunk_indent = indent
            chunk.append((indent, m.group(2), m.group(3)))
        else:
            if chunk:
                process_block(chunk, out)
                chunk = []
            chunk_indent = None
            out.append(ln)

    if chunk:
        process_block(chunk, out)

    text = re.sub(r"\n{3,}", "\n\n", "\n".join(out))
    if a.output:
        open(a.output, "w", encoding="utf-8").write(text)
        print("[+] %s -> %s (%d -> %d строк)" % (a.input, a.output, len(lines), len(out)))
    else:
        print(text)


if __name__ == "__main__":
    main()
