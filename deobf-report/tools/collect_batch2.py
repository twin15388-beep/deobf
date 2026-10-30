#!/usr/bin/env python3
"""Assemble _work/res2/* into deobf-report/results/ (second batch)."""
import os
import shutil
import sys

# src dir -> (game folder, sample name, one-line description)
MAP = {
    "TrixAde/BloxBurgAutoBuild": ("bloxburg", "autobuild", "автопостройка домов, MoonSec V3"),
    "TrixAde/GachaOnline": ("gacha_online", "hub", "Gacha Online: авто-роллы, фарм валюты"),
    "TrixAde/KolgieYba": ("yba", "kolgie", "Your Bizarre Adventure: хаб/автофарм"),
    "TrixAde/TheWildWest": ("the_wild_west", "hub", "The Wild West: хаб с автофармом"),
    "TrixAde/counterBlox": ("counter_blox", "hub", "Counter Blox: чит-меню"),
    "TrixAde/mm2GhostHub": ("murder_mystery_2", "ghost_hub", "Murder Mystery 2: Ghost Hub"),
    "TrixAde/piggy": ("piggy", "hub", "Piggy: хаб"),
    "TrixAde/prsionlife": ("prison_life", "cmd_gui", "Prison Life: GUI с командами"),
    "TrixAde/towerofhell": ("tower_of_hell", "auto_win", "Tower of Hell: авто-прохождение"),
    "TrixAde/Hatching-Simulator-Ultima": ("hatching_simulator", "ultima", "Hatching Simulator: Ultima"),
    "TrixAde/JailHack": ("jailbreak", "jailtabs", "Jailbreak: JailTabs 3.2"),
    "MoonSec/Nocoal": ("the_wild_west", "no_coal", "The Wild West: фарм без угля"),
    "MoonSec/newfarm": ("the_wild_west", "new_farm", "The Wild West: новый фарм"),
    "MoonSec/coalfarm": ("the_wild_west", "coal_farm", "The Wild West: фарм угля"),
    "MoonSec/Orion": ("solara_hub", "orion", "Solara Hub: Orion (мультиигровой хаб)"),
    "MoonSec/send": ("the_wild_west", "send", "The Wild West: обёртка-отправитель"),
    "Luraph/Blox_Fruit": ("blox_fruits", "hub", "Blox Fruits: автофарм/квесты"),
    "Luraph/Grow_a_Garden": ("grow_a_garden", "hub", "Grow a Garden: автофарм"),
}


def main():
    src_root, dst_root = sys.argv[1], sys.argv[2]
    rows = []
    for src, (game, sample, desc) in sorted(MAP.items()):
        sdir = os.path.join(src_root, src)
        lua = os.path.join(sdir, "deobfuscated.lua")
        if not os.path.exists(lua):
            continue
        lines = sum(1 for _ in open(lua, encoding="utf-8", errors="replace"))
        if lines < 60:                       # only the outer layer was removed
            continue
        out = os.path.join(dst_root, game, sample)
        os.makedirs(out, exist_ok=True)
        shutil.copy(lua, os.path.join(out, "script.lua"))
        for f in ("PARTS.md", "LOG.txt"):
            fp = os.path.join(sdir, f)
            if os.path.exists(fp):
                shutil.copy(fp, os.path.join(out, f))
        log = open(os.path.join(sdir, "LOG.txt"), encoding="utf-8", errors="replace").read() \
            if os.path.exists(os.path.join(sdir, "LOG.txt")) else ""
        obf = "?"
        for line in log.splitlines():
            if line.startswith("detected:"):
                obf = line.split(":", 1)[1].strip()
        rows.append((game, sample, desc, obf, lines, os.path.getsize(lua) // 1024))

    with open(os.path.join(dst_root, "_batch2.md"), "w", encoding="utf-8") as f:
        f.write("| Игра | Сэмпл | Что это | Обфускатор | Строк Lua | Размер |\n")
        f.write("|---|---|---|---|---|---|\n")
        for game, sample, desc, obf, lines, kb in rows:
            f.write("| %s | `%s` | %s | %s | %d | %d КБ |\n" % (game, sample, desc, obf, lines, kb))
    print("collected %d" % len(rows))


if __name__ == "__main__":
    main()
