#!/usr/bin/env python3
"""collect3.py — третья партия результатов (4-я итерация).

Для каждого исходника:
  * определяет обфускатор (detect из pipeline.py);
  * для обычного/минифицированного Lua — токен-безопасная нормализация
    (lua_beautify.py) -> results/<game>/<sample>/script.lua;
  * собирает PARTS.md (extract_parts.py) и LOG.txt (что делали, чем, итог).

Запуск:
    python3 collect3.py <samples.json> <results_dir>
"""
import json
import os
import shutil
import subprocess
import sys

TOOLS = os.path.dirname(os.path.abspath(__file__))


def detect(path):
    sys.path.insert(0, TOOLS)
    from pipeline import detect as _detect  # noqa
    head = open(path, encoding="utf-8", errors="replace").read(4000)
    return _detect(head)


def count_lines(path):
    with open(path, "rb") as f:
        return f.read().count(b"\n") + 1


def main():
    samples_file, results = sys.argv[1], sys.argv[2]
    items = json.load(open(samples_file, encoding="utf-8"))
    rows = []
    for it in items:
        src = it["src"]
        game, sample = it["game"], it["sample"]
        out = os.path.join(results, game, sample)
        os.makedirs(out, exist_ok=True)
        kind = detect(src)
        dst = os.path.join(out, "script.lua")
        log = [f"source: {os.path.basename(src)}",
               f"size: {os.path.getsize(src)} B ({os.path.getsize(src)//1024} KB)",
               f"detected: {kind}",
               f"description: {it.get('desc','')}"]
        ok = False
        if it.get("method", "beautify") == "beautify":
            r = subprocess.run([sys.executable, os.path.join(TOOLS, "lua_beautify.py"),
                                src, "-o", dst], capture_output=True, text=True)
            log.append("method: lua_beautify.py (token-safe reindent, токены сверены)")
            log.append("beautify: " + (r.stdout.strip() or r.stderr.strip()))
            ok = r.returncode == 0 and os.path.exists(dst)
        if not ok:
            log.append("result: FAILED")
            open(os.path.join(out, "LOG.txt"), "w", encoding="utf-8").write("\n".join(log) + "\n")
            rows.append((game, sample, it.get("desc", ""), kind, 0, 0, "FAILED"))
            continue
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "extract_parts.py"),
                            dst, "-o", os.path.join(out, "PARTS.md"),
                            "--game", it.get("game_name", game)], capture_output=True, text=True)
        log.append("parts: " + (r.stdout.strip() or r.stderr.strip()))
        log.append(f"result: OK, {count_lines(dst)} строк, {os.path.getsize(dst)//1024} КБ")
        open(os.path.join(out, "LOG.txt"), "w", encoding="utf-8").write("\n".join(log) + "\n")
        rows.append((game, sample, it.get("desc", ""), kind, count_lines(dst),
                     os.path.getsize(dst) // 1024, "OK"))
        print(f"OK {game}/{sample}: {count_lines(dst)} строк")

    with open(os.path.join(results, "_batch3.md"), "w", encoding="utf-8") as f:
        f.write("| Игра | Сэмпл | Что это | Обфускатор | Строк | Размер | Статус |\n")
        f.write("|---|---|---|---|---|---|---|\n")
        for g, s, d, k, lines, kb, st in rows:
            f.write(f"| {g} | `{s}` | {d} | {k} | {lines} | {kb} КБ | {st} |\n")


if __name__ == "__main__":
    main()
