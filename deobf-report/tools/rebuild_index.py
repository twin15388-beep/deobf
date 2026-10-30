#!/usr/bin/env python3
"""rebuild_index.py — собрать results/INDEX.md прямо по каталогам.

В индекс попадают ТОЛЬКО те каталоги, где есть деобфусцированный `script.lua`.
Каталоги без кода (если такие остались) в индекс не попадают — их место в `_failed.md`.

    python3 rebuild_index.py [--results results] [-o results/INDEX.md]
"""
import argparse
import os
import re
import glob
import subprocess

LUA = "/home/user/deobf/_work/tools/lua51/lua"


def parse_status(path):
    """Проверка loadfile в Lua 5.1.1: OK / Luau-goto / Luau-continue / артефакт unluac."""
    try:
        r = subprocess.run([LUA, "-e", "local f,e=loadfile('%s'); print(f and 'OK' or e)" % path],
                           capture_output=True, text=True, timeout=60)
        out = (r.stdout or "").strip().split("\n")[-1]
    except Exception:
        return "не проверено"
    if out == "OK":
        return "OK"
    txt = read(path)
    if re.search(r"^\s*continue\s*$", txt, re.M):
        return "Luau (continue)"
    if "lbl_" in out or "goto" in out:
        return "Lua 5.2+ (goto)"
    return "артефакт unluac"

MECH_LINE = re.compile(r"^- \*\*(.+?)\*\* —", re.M)


def read(p):
    try:
        return open(p, encoding="utf-8", errors="replace").read()
    except OSError:
        return ""


def sample_info(d):
    script = os.path.join(d, "script.lua")
    lines = read(script).count("\n")
    kb = max(1, os.path.getsize(script) // 1024)
    parts = read(os.path.join(d, "PARTS.md"))
    mech = [m for m in MECH_LINE.findall(parts)][:3]
    log = read(os.path.join(d, "LOG.txt"))
    obf = ""
    for ln in log.split("\n"):
        if ln.lower().startswith("detected:") or "обфускатор" in ln.lower():
            obf = ln.split(":", 1)[-1].strip()
            break
    return lines, kb, mech, obf


def sample_info2(d):
    lines, kb, mech, obf = sample_info(d)
    return lines, kb, mech, obf, parse_status(os.path.join(d, "script.lua"))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--results", default=os.path.join(os.path.dirname(__file__), "..", "results"))
    ap.add_argument("-o", "--output")
    a = ap.parse_args()
    root = os.path.abspath(a.results)
    out_path = a.output or os.path.join(root, "INDEX.md")

    rows = []
    for script in glob.glob(os.path.join(root, "*", "*", "script.lua")) + \
            glob.glob(os.path.join(root, "*", "*", "*", "script.lua")):
        d = os.path.dirname(script)
        rel = os.path.relpath(d, root).split(os.sep)
        game, sample = rel[0], "/".join(rel[1:])
        if game == "ironbrew_cascade":
            game = "IronBrew"
        lines, kb, mech, obf, status = sample_info2(d)
        rows.append((game, sample, lines, kb, mech, obf, status))

    rows.sort(key=lambda r: (r[0], -r[2]))
    games = sorted({r[0] for r in rows})

    out = []
    out.append("# Результаты деобфускации\n")
    out.append("В индекс попадает только то, что **реально удалось деобфусцировать**: "
               "в каждом каталоге есть `script.lua` (восстановленный код) и `PARTS.md` "
               "(что делает: механики, вызовы API, имена функций, парты/объекты, ссылки).\n")
    out.append("Каталогов без кода здесь нет — неудачи и причины перечислены в `_failed.md`.\n")
    out.append("Всего: **%d сэмплов**, **%d игр/режимов**.\n" % (len(rows), len(games)))
    out.append("\n- `BEST.md` — что читается как исходник (и антирейтинг).\n"
               "- `_failed.md` — что не получилось и почему.\n"
               "- `_batch6.md` — партия 6-й итерации (IronBrew через CASCADE).\n"
               "- `_corpus_prometheus/` — проверка `unprom` на эталонных сэмплах Prometheus.\n")
    out.append("\n| Игра (каталог) | Сэмпл | Строк | Размер | Механики | Обфускатор | Парсится |")
    out.append("|---|---|---:|---:|---|---|---|")
    for game, sample, lines, kb, mech, obf, status in rows:
        out.append("| %s | `%s` | %d | %d КБ | %s | %s | %s |" % (
            game, sample, lines, kb, "; ".join(mech) or "—", obf or "—", status))
    from collections import Counter
    cnt = Counter(r[6] for r in rows)
    out.append("\n**Проверка `loadfile` в Lua 5.1.1:** " +
               ", ".join("%s — %d" % (k, v) for k, v in cnt.most_common()) + ".")
    out.append("\n**Колонка «Парсится»** — проверка `loadfile` в Lua 5.1.1. `Lua 5.2+ (goto)` и "
               "`Luau (continue)` — код корректный, но использует конструкции новее 5.1 "
               "(unluac иногда оставляет `goto lbl_N`, а часть скриптов изначально Luau). "
               "`артефакт unluac` — известный дефект генератора на больших функциях.")
    open(out_path, "w", encoding="utf-8").write("\n".join(out) + "\n")
    print("[+] %s: %d сэмплов, %d игр" % (out_path, len(rows), len(games)))


if __name__ == "__main__":
    main()
