#!/usr/bin/env python3
"""chunk_parts.py — вытащить «имена партов» и прочие строковые константы из чанка Lua 5.1.

Работает даже с чанком, который не загружается в Lua (например, недоделанная
девиртуализация IronBrew): читаем константы прототипов напрямую.

Использование:
    python3 chunk_parts.py out.luac -o PARTS.md [--game "Blox Piece"] [--title "..."]
"""
import argparse
import collections
import re
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from luac_inspect import load_chunk  # noqa: E402

ROBLOX_CLASSES = {
    "Part", "MeshPart", "WedgePart", "TrussPart", "CornerWedgePart", "Seat",
    "VehicleSeat", "Model", "Folder", "ScreenGui", "Frame", "TextLabel",
    "TextButton", "TextBox", "ImageLabel", "ImageButton", "ScrollingFrame",
    "UIListLayout", "UIGridLayout", "UIPadding", "UICorner", "UIStroke",
    "UIGradient", "BillboardGui", "SurfaceGui", "Tool", "Humanoid", "Sound",
    "RemoteEvent", "RemoteFunction", "BindableEvent", "BindableFunction",
    "ClickDetector", "ProximityPrompt", "Camera", "Lighting", "Workspace",
    "Players", "RunService", "UserInputService", "TweenService", "StarterGui",
    "CollectionService", "PathfindingService", "HttpService", "Workspace",
    "Attachment", "Beam", "Trail", "ParticleEmitter", "Sparkles", "Highlight",
    "BodyVelocity", "BodyPosition", "BodyGyro", "RocketPropulsion", "Explosion",
    "Animation", "Animator", "Motor6D", "Weld", "WeldConstraint", "Accessory",
    "SpecialMesh", "Decal", "Texture", "NumberValue", "StringValue",
    "BoolValue", "ObjectValue", "IntValue", "Configuration", "ModuleScript",
}
SKIP_RE = re.compile(r"[\\%s]|^\s*$")


def walk(p, acc):
    for k in p.consts:
        if isinstance(k, bytes):
            s = k.rstrip(b"\x00").decode("utf-8", "replace")
            if s:
                acc.append(s)
    for sub in p.protos:
        walk(sub, acc)


def looks_like_part(s):
    if len(s) < 3 or len(s) > 60:
        return False
    if s in ROBLOX_CLASSES:
        return True
    if re.search(r"[\s\n\t]", s):
        return False
    if s.startswith(("http://", "https://", "rbxassetid", "rbxthumb")):
        return False
    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", s):
        # CamelCase / snake_case имена объектов и функций
        return bool(re.search(r"[A-Z]", s) or "_" in s)
    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chunk")
    ap.add_argument("-o", "--output")
    ap.add_argument("--game", default="")
    ap.add_argument("--title", default="")
    ap.add_argument("--limit", type=int, default=200)
    a = ap.parse_args()

    data = open(a.chunk, "rb").read()
    top, _ = load_chunk(data)
    strings = []
    walk(top, strings)
    cnt = collections.Counter(strings)

    parts = sorted({s for s in cnt if looks_like_part(s)})
    classes = sorted({s for s in cnt if s in ROBLOX_CLASSES})
    classes = classes  # noqa
    cls = [s for s in classes]
    urls = sorted({s for s in cnt if s.startswith(("http", "rbxassetid"))})

    nproto = 0
    stack = [top]
    while stack:
        p = stack.pop()
        nproto += 1
        stack.extend(p.protos)

    out = []
    out.append("# %s — имена объектов (из констант чанка)\n" % (a.title or a.chunk))
    if a.game:
        out.append("Игра: **%s**\n" % a.game)
    out.append("Источник: `%s` (%d B, %d прототипов, %d строковых констант)\n"
               % (a.chunk, len(data), nproto, len(cnt)))
    out.append("> Извлечено из строковых констант байткода. Порядок — алфавитный, "
               "в скобках — сколько раз строка встречается.\n")
    out.append("\n## Классы Roblox (%d)\n" % len(cls))
    out.append(", ".join("`%s`" % s for s in cls) if cls else "_нет_")
    out.append("\n\n## Имена объектов / партов (%d)\n" % len(parts))
    for s in parts[: a.limit]:
        out.append("- `%s`%s" % (s, " ×%d" % cnt[s] if cnt[s] > 1 else ""))
    if len(parts) > a.limit:
        out.append("- … ещё %d" % (len(parts) - a.limit))
    if urls:
        out.append("\n\n## Ссылки / ассеты (%d)\n" % len(urls))
        for s in urls[:40]:
            out.append("- `%s`" % (s if len(s) < 120 else s[:117] + "..."))

    text = "\n".join(out) + "\n"
    if a.output:
        open(a.output, "w", encoding="utf-8").write(text)
        print("[+] %s: классов %d, имён %d, ссылок %d -> %s"
              % (a.chunk, len(cls), len(parts), len(urls), a.output))
    else:
        print(text)


if __name__ == "__main__":
    main()
