#!/usr/bin/env python3
"""Extract the "parts" of a deobfuscated Roblox script: named features, UI
library, remotes/services, webhooks/URLs and chat commands.

usage: extract_parts.py script.lua -o PARTS.md [--game "King Legacy"]
"""
import argparse
import re
from collections import OrderedDict

FEATURES = OrderedDict([
    ("AutoFarm", [r"[Aa]uto\s?[Ff]arm", r"AutoFarm", r"autofarm"]),
    ("AutoQuest", [r"Auto\s?Quest"]),
    ("AutoStats", [r"Auto\s?Stat", r"UpStats"]),
    ("AutoSell", [r"Auto\s?Sell", r"SellAll"]),
    ("AutoFish", [r"Auto\s?Fish"]),
    ("AutoChest", [r"Auto\s?Chest", r"ChestFarm"]),
    ("AutoRaid/Boss", [r"Auto\s?(Raid|Boss|Dungeon)", r"BossFarm"]),
    ("Kill Aura", [r"Kill\s?Aura", r"KillAura"]),
    ("Aimbot", [r"[Aa]im\s?[Bb]ot", r"SilentAim", r"Aimbot"]),
    ("ESP", [r"\bESP\b", r"ESPBox", r"HighLight"]),
    ("Fly/Noclip", [r"Fly(?!er)", r"Noclip", r"NoClip"]),
    ("Speed/Jump", [r"WalkSpeed", r"JumpPower", r"SpeedHack"]),
    ("Teleport", [r"[Tt]eleport", r"ClickTP", r"\bTP\b"]),
    ("Anti-AFK", [r"Anti[\s-]?AFK", r"antiafk"]),
    ("Auto Rejoin", [r"Auto\s?Rejoin", r"Rejoin"]),
    ("Anti-Ban/Detection", [r"Anti[\s-]?Ban", r"Anti[\s-]?Cheat", r"Anti[\s-]?Kick"]),
    ("Key system", [r"[Kk]ey\s?[Ss]ystem", r"key_?check", r"#key channel"]),
    ("Discord check (IsInGroup)", [r"IsInGroup", r"GetRankInGroup"]),
    ("Config / Save settings", [r"SaveConfig", r"Config", r"Settings"]),
    ("Inventory / Item ESP", [r"[Ii]nventory", r"[Ii]temList"]),
    ("Admin commands", [r"[Cc]mds", r"admin", r":ban", r":kick"]),
])

UI_LIBS = ["Rayfield", "Orion", "Fluent", "Kavo", "Magma", "Iris", "Mona", "Venyx",
           "Hydra", "Solara", "Vision", "Rain", "Crescent", "Akali", "Linoria",
           "WindUI", "Obsidian", "Nebula", "Rift", "Nova", "Krnl"]

SERVICES = ["Players", "ReplicatedStorage", "ReplicatedFirst", "ServerStorage",
            "ServerScriptService", "Workspace", "Lighting", "TweenService",
            "RunService", "UserInputService", "VirtualUser", "HttpService",
            "MarketplaceService", "TeleportService", "StarterGui", "CoreGui"]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("-o", "--output", required=True)
    ap.add_argument("--game", default="")
    a = ap.parse_args()

    text = open(a.input, encoding="utf-8", errors="replace").read()
    lines = text.splitlines()
    out = []
    out.append("# Разбор частей скрипта\n")
    out.append("- файл: `%s`\n- размер: %d КБ, %d строк\n" %
               (a.input.rsplit("/", 1)[-1], len(text) // 1024, len(lines)))

    out.append("\n## Части (функционал)\n")
    found_any = False
    for name, pats in FEATURES.items():
        hits = 0
        for p in pats:
            hits += len(re.findall(p, text))
        if hits:
            found_any = True
            out.append("- **%s** — %d упоминаний\n" % (name, hits))
    if not found_any:
        out.append("- явных функциональных блоков не найдено (скрипт-загрузчик или VM)\n")

    libs = [u for u in UI_LIBS if u.lower() in text.lower()]
    out.append("\n## UI-библиотека\n")
    out.append("- " + (", ".join(libs) if libs else "не определена") + "\n")

    urls = sorted(set(re.findall(r"https?://[^\s\"'\)\]]+", text)))
    out.append("\n## URL / webhook-и (%d)\n" % len(urls))
    for u in urls[:40]:
        out.append("- `%s`\n" % u)
    if len(urls) > 40:
        out.append("- … ещё %d\n" % (len(urls) - 40))

    services = [s for s in SERVICES if re.search(r'["\']%s["\']' % s, text)]
    out.append("\n## Сервисы / remotes\n")
    out.append("- сервисы: " + (", ".join(services) if services else "—") + "\n")
    remotes = sorted(set(re.findall(r'WaitForChild\(\s*["\']([^"\']{3,60})["\']', text)))[:30]
    if remotes:
        out.append("- WaitForChild: " + ", ".join("`%s`" % r for r in remotes) + "\n")
    remotes2 = sorted(set(re.findall(r'(?:InvokeServer|FireServer|OnClientEvent|OnServerEvent)\s*\(', text)))
    if remotes2:
        out.append("- remote-вызовы: " + ", ".join(sorted(set(remotes2))) + "\n")

    cmds = sorted(set(re.findall(r'["\'](:[a-zA-Z]{2,15}\s?\.?)["\']', text)))
    if cmds:
        out.append("\n## Чат-команды\n")
        out.append("- " + ", ".join("`%s`" % c for c in cmds[:40]) + "\n")

    # game objects: the names the script actually looks up or creates
    objs = []
    for pat in (r'FindFirstChild\(\s*"([^"]{2,50})"', r'WaitForChild\(\s*"([^"]{2,50})"',
                r'Instance\.new\(\s*"([^"]{2,50})"', r'\["([A-Z][\w ]{2,40})"\]'):
        objs += re.findall(pat, text)
    counts = {}
    for o in objs:
        counts[o] = counts.get(o, 0) + 1
    top = sorted(counts.items(), key=lambda kv: -kv[1])[:60]
    if top:
        out.append("\n## Названия партов / объектов в игре (%d уникальных)\n" % len(counts))
        for name, n in top:
            out.append("- `%s` (%d)\n" % (name, n))

    strings = sorted({s for s in re.findall(r'"([^"\\\n]{4,60})"', text)})
    ui_labels = [s for s in strings if re.match(
        r"^[A-ZА-Я][\w \-/()]{2,40}$", s) and not s.startswith("http")]
    if ui_labels:
        out.append("\n## Подписи UI / названия функций (первые 60)\n")
        for s in ui_labels[:60]:
            out.append("- %s\n" % s)

    if a.game:
        out.insert(0, "\nИгра: **%s**\n" % a.game)
    open(a.output, "w", encoding="utf-8").write("".join(out))
    print("parts -> %s (%d labels)" % (a.output, len(ui_labels)))


if __name__ == "__main__":
    main()
