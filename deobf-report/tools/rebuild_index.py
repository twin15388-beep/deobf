#!/usr/bin/env python3
"""rebuild_index.py — собрать results/INDEX.md прямо по каталогам.

(2026-11-17, после дедупа) В индекс попадают ТОЛЬКО те каталоги, где есть
`script.combined.lua` — единый файл: восстановленный код + PARTS.md как
Lua-комментарии (раздел 1/2). `script.lua`/`PARTS.md` в репозитории больше не
хранятся (байт-идентичная копия кода — в combined, раздел 2/2); история — в git.

    python3 rebuild_index.py [--results results] [-o results/INDEX.md]
"""
import argparse
import os
import re
import glob
import shutil
import subprocess

LUA_CANDIDATES = [
    "/home/user/deobf/work/lua51-src/lua",
    "/home/user/deobf/work/lua51/lua",
] + [shutil.which(n) for n in ("lua5.1", "lua51", "lua") if shutil.which(n)]

MECH_LINE = re.compile(r"^\s*--\s+-\s+\*\*(.+?)\*\*\s+—", re.M)


def find_lua():
    for p in LUA_CANDIDATES:
        if p and os.path.isfile(p) and os.access(p, os.X_OK):
            return p
    return None


def parse_status(path, lua):
    """Проверка loadfile (Lua 5.1.1): OK / артефакт / не проверено."""
    if not lua:
        return "не проверено"
    try:
        r = subprocess.run([lua, "-e", "local f,e=loadfile('%s'); print(f and 'OK' or e)" % path],
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


def read(p):
    try:
        return open(p, encoding="utf-8", errors="replace").read()
    except OSError:
        return ""


def sample_info(d, lua):
    combined = os.path.join(d, "script.combined.lua")
    text = read(combined)
    # строки кода = все строки минус заголовок combined и минус раздел 1/2 (комментарии PARTS)
    m_end = text.find("-- РАЗДЕЛ 2/2")
    code_lines = text[m_end:].count("\n") if m_end != -1 else text.count("\n")
    kb = max(1, os.path.getsize(combined) // 1024)
    mech = [m for m in MECH_LINE.findall(text)][:3]
    log = read(os.path.join(d, "LOG.txt"))
    obf = ""
    for ln in log.split("\n"):
        if ln.lower().startswith("detected:") or "обфускатор" in ln.lower():
            obf = ln.split(":", 1)[-1].strip()
            break
    return code_lines, kb, mech, obf, parse_status(combined, lua)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--results", default=os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "results"))
    ap.add_argument("-o", "--out", default=None)
    args = ap.parse_args()
    root = args.results
    out = args.out or os.path.join(root, "INDEX.md")
    lua = find_lua()
    combineds = glob.glob(os.path.join(root, "*", "*", "script.combined.lua")) + \
                glob.glob(os.path.join(root, "*", "*", "*", "script.combined.lua"))
    rows = []
    for cf in sorted(combineds):
        d = os.path.dirname(cf)
        rel = os.path.relpath(d, root).replace(os.sep, "/")
        parts = rel.split("/")
        game = parts[0]
        sample = "/".join(parts[1:])
        info = sample_info(d, lua)
        if info:
            rows.append((game, sample, *info))
    lines = [
        "# Результаты деобфускации",
        "",
        "В индекс попадает только то, что **реально удалось деобфусцировать**: в каждом каталоге есть "
        "`script.combined.lua` — единый файл: восстановленный код + `PARTS.md` (механики, API, имена "
        "функций, парты) как комментарии. Отдельных `script.lua`/`PARTS.md` в репозитории больше нет.",
        "",
        "Каталогов без кода здесь нет — неудачи и причины перечислены в `_failed.md`.",
        "",
        f"Всего: **{len(rows)} сэмплов**, **{len(set(r[0] for r in rows))} игр/режимов**.",
        "",
        "- `BEST.md` — что читается как исходник (и антирейтинг).",
        "- `COMBINED.md` — формат и проверка единых файлов.",
        "- `_failed.md` — что не получилось и почему.",
        "- `_batch6.md` — партия 6-й итерации (IronBrew через CASCADE).",
        "- `_corpus_prometheus/` — проверка `unprom` на эталонных сэмплах Prometheus.",
        "",
        "| Игра (каталог) | Сэмпл | Строк | Размер | Механики | Обфускатор | Парсится |",
        "|---|---|---:|---:|---|---|---|",
    ]
    for game, sample, ln, kb, mech, obf, status in rows:
        mech_s = "; ".join(mech) if mech else "—"
        lines.append(f"| {game} | `{sample}` | {ln} | {kb} КБ | {mech_s} | {obf or '—'} | {status} |")
    open(out, "w", encoding="utf-8").write("\n".join(lines) + "\n")
    print(f"INDEX.md: {len(rows)} сэмплов (lua={lua})")


if __name__ == "__main__":
    main()
