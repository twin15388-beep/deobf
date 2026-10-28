#!/usr/bin/env python3
"""Collect pipeline outputs into deobf-report/results/ and build INDEX.md.

usage: collect_results.py SRC_ROOT DEST_ROOT
SRC_ROOT layout: SRC_ROOT/<group>/<sample>/{deobfuscated.lua,PARTS.md,LOG.txt}
"""
import os
import re
import shutil
import sys

GAME = {
    "KL_psu40_Kingpiece": ("king_legacy", "Kingpiece hub (King Legacy / Blox Fruits)"),
    "KL_psu40_BloxFruit": ("king_legacy", "Blox Fruits hub"),
    "KL_psu45_ano": ("king_legacy", "ano hub (King Legacy)"),
    "KL_msv3_v14_ZombieAttack": ("king_legacy", "Lightux v1.4 (Zombie Attack)"),
    "KL_msv3_v15_ZombieAttack": ("king_legacy", "Lightux v1.5 (Zombie Attack)"),
    "KL_msv2_v13": ("king_legacy", "Lightux v1.3"),
}


def main():
    src_root, dst_root = sys.argv[1], sys.argv[2]
    rows = []
    skipped = []
    for group in sorted(os.listdir(src_root)):
        gdir = os.path.join(src_root, group)
        if not os.path.isdir(gdir):
            continue
        for sample in sorted(os.listdir(gdir)):
            sdir = os.path.join(gdir, sample)
            lua = os.path.join(sdir, "deobfuscated.lua")
            if not os.path.exists(lua):
                continue
            game, desc = GAME.get(sample, (group, sample))
            out = os.path.join(dst_root, game, sample)
            os.makedirs(out, exist_ok=True)
            shutil.copy(lua, os.path.join(out, "script.lua"))
            for f in ("PARTS.md", "LOG.txt"):
                fp = os.path.join(sdir, f)
                if os.path.exists(fp):
                    shutil.copy(fp, os.path.join(out, f))
            lines = sum(1 for _ in open(lua, encoding="utf-8", errors="replace"))
            if lines < 60:            # only a stub / one unpacked layer, not worth shipping
                skipped.append((sample, lines))
                shutil.rmtree(out, ignore_errors=True)
                continue
            log = open(os.path.join(sdir, "LOG.txt"), encoding="utf-8", errors="replace").read() \
                if os.path.exists(os.path.join(sdir, "LOG.txt")) else ""
            m = re.search(r"detected: (.+)", log)
            obf = m.group(1).strip() if m else "?"
            budget = os.path.getsize(lua) // 1024
            rows.append((game, sample, desc, obf, lines, budget))

    rows.sort()
    idx = ["# Результаты деобфускации\n",
           "В каждом каталоге: `script.lua` — восстановленный Lua, `PARTS.md` — что за фичи/парты,"
           " `LOG.txt` — лог пайплайна.\n\n",
           "| Игра | Сэмпл | Что это | Обфускатор | Строк Lua | Размер |\n",
           "|---|---|---|---|---|---|\n"]
    for game, sample, desc, obf, lines, kb in rows:
        idx.append("| %s | `%s` | %s | %s | %d | %d КБ |\n"
                   % (game, sample, desc, obf, lines, kb))
    if skipped:
        idx.append("\nОтброшены как неинформативные (< 60 строк, снят только внешний слой):\n")
        for sample, lines in skipped:
            idx.append("- `%s` — %d строк\n" % (sample, lines))
    open(os.path.join(dst_root, "INDEX.md"), "w", encoding="utf-8").write("".join(idx))
    print("collected %d results, %d tables -> %s" % (len(rows), len(rows), dst_root))


if __name__ == "__main__":
    main()
