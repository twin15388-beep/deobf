#!/usr/bin/env python3
"""describe_lua.py — «что делает скрипт» из восстановленного Lua.

Делает раздел для PARTS.md: механики (с конкретными уликами — какие имена это выдали),
ключевые вызовы Roblox API, имена функций, подписи UI. Работает по тексту `script.lua`.

    python3 describe_lua.py path/to/script.lua [--title "..."] [-o out.md]
"""
import argparse
import collections
import re
import sys

CLASSES = {
    "Part", "MeshPart", "WedgePart", "Model", "Folder", "ScreenGui", "Frame",
    "TextLabel", "TextButton", "TextBox", "ImageLabel", "ImageButton",
    "ScrollingFrame", "UIListLayout", "UIGridLayout", "UICorner", "UIStroke",
    "BillboardGui", "SurfaceGui", "Tool", "Humanoid", "Sound", "RemoteEvent",
    "RemoteFunction", "BindableEvent", "ClickDetector", "ProximityPrompt",
    "Highlight", "Beam", "Trail", "ParticleEmitter", "BodyVelocity",
    "BodyForce", "BodyGyro", "Attachment", "Explosion", "Animation", "Animator",
    "Motor6D", "Weld", "WeldConstraint", "SpecialMesh", "Decal", "Texture",
    "NumberValue", "StringValue", "BoolValue", "ObjectValue", "Configuration",
    "ModuleScript", "Camera", "Lighting", "BlurEffect", "ColorCorrectionEffect",
}
SERVICES = {
    "Players", "RunService", "UserInputService", "TweenService", "Lighting",
    "ReplicatedStorage", "ReplicatedFirst", "ServerStorage", "ServerScriptService",
    "Workspace", "StarterGui", "StarterPlayer", "CoreGui", "HttpService",
    "CollectionService", "PathfindingService", "MarketplaceService", "Teams",
    "SoundService", "VirtualUser", "GuiService", "ContextActionService",
    "TextService", "Chat", "PhysicsService", "GroupService", "BadgeService",
}
MECHANICS = [
    ("автофарм / авто-клик", r"autofarm|auto farm|autoclick|auto click|\bfarm\b|grind|autogrind|auto.?collect"),
    ("телепорт / движение", r"teleport|\btp\b|moveto|tweenservice|hum anoidrootpart|humanoidrootpart|walkspeed|jumppower|cframe"),
    ("ESP / подсветка", r"\besp\b|highlight|nametag|chams|billboardgui|boxhandle|outline"),
    ("аимбот / наведение", r"aimbot|silent aim|aim assist|lockon|mousebutton|mousemove"),
    ("урон / убийство", r"\bkill\b|damage|hitbox|fling|noclip|godmode|god mode|invisible|breakjoints"),
    ("деньги / ресурсы", r"money|gems?\b|coins?\b|cash|reward|redeem|promocode|\bcode\b|infinite|\binf\b"),
    ("квесты / стадии", r"quest|daily|auto.?skip|skip.?stage|\bstage\b|completed"),
    ("инвентарь / предметы", r"\bitem\b|inventory|chest|drop|\bsell\b|trade"),
    ("GUI / меню", r"screengui|creategui|textbutton|textlabel|scrollingframe|toggle|slider|dropdown|\btab\b"),
    ("сеть / загрузка кода", r"httpget|httppost|loadstring|require|webhook|discord"),
    ("анти-АФК / ввод", r"idled|virtualuser|button2down|keydown|inputbegan"),
]
METHODS = ["GetService", "FindFirstChild", "WaitForChild", "GetChildren", "MoveTo",
           "FireServer", "InvokeServer", "Connect", "HttpGet", "HttpPost",
           "loadstring", "TweenService", "Create", "IsA", "Destroy", "Clone",
           "GetMouse", "GetPlayers", "SetPrimaryPartCFrame", "PivotTo"]

NOISE = set("""pcall xpcall pairs ipairs next type tostring tonumber select unpack setmetatable getmetatable rawget rawset require loadstring load assert error print warn math string table os io coroutine task game script workspace shared Enum Instance Vector2 Vector3 CFrame Color3 UDim2 UDim Rect TweenInfo Ray BrickColor Faces Axes Random DateTime tick wait spawn delay Connect Disconnect Destroy Clone FindFirstChild FindFirstChildWhichIsA FindFirstChildOfClass FindFirstAncestorOfClass GetChildren GetDescendants GetService WaitForChild IsA GetPlayers LocalPlayer Character Humanoid HumanoidRootPart MouseButton1Click MouseButton1Down MouseButton1Up Button2Down Button2Up Toggle Slider Dropdown KeyDown InputBegan InputEnded RenderStepped Heartbeat Stepped HttpGet HttpPost FireServer InvokeServer CreateWindow CreateTopbarButton Drawing""".split())

STR = re.compile("[\"']((?:[^\"'\\\\\\n]|\\\\.){2,60})[\"']")
IDENT = re.compile(r"[A-Za-z_]\w{2,}")
FUNC_DEF = re.compile(r"^\s*(?:local\s+)?function\s+([A-Za-z_]\w*)\s*\(")
FUNC_ASSIGN = re.compile(r"^\s*([A-Za-z_]\w*)\s*=\s*function\s*\(")
TEMP = re.compile(r"^(L\d+_\d+|arg\d*|A\d+_\d+|v\d+|p\d+)$")


def uniq(seq, n=60):
    seen, out = set(), []
    for x in seq:
        if x in seen:
            continue
        seen.add(x)
        out.append(x)
        if len(out) >= n:
            break
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("script")
    ap.add_argument("--title", default="")
    ap.add_argument("-o", "--output")
    a = ap.parse_args()

    text = open(a.script, encoding="utf-8", errors="replace").read()
    low = text.lower()
    strings = STR.findall(text)
    idents = set(IDENT.findall(text))
    tokens = set(strings) | idents

    serv = sorted({s for s in strings if s in SERVICES} | {s for s in idents if s in SERVICES})
    dyn_cls = set(re.findall(r'Instance\.new\s*\(\s*["\']([A-Za-z]+)["\']', text))
    dyn_cls |= set(re.findall(r'(?:IsA|FindFirstChildOfClass|FindFirstChildWhichIsA)\s*\(\s*["\']([A-Za-z]+)["\']', text))
    cls = sorted({s for s in tokens if s in CLASSES} | dyn_cls)
    methods = collections.Counter({m: text.count(m) for m in METHODS if text.count(m)})

    funcs = []
    for ln in text.split("\n"):
        m = FUNC_DEF.match(ln) or FUNC_ASSIGN.match(ln)
        if m:
            name = m.group(1)
            if not TEMP.match(name) and name not in funcs:
                funcs.append(name)

    mech, evidence = [], {}
    for label, pat in MECHANICS:
        hits = sorted({m.group(0) for m in re.finditer(pat, low)})
        if hits:
            mech.append((label, len(hits)))
            evidence[label] = hits[:6]

    ui = [s for s in strings
          if re.search(r"[A-Za-z]", s) and 2 < len(s) <= 30
          and "\\" not in s
          and not s.startswith(("http", "rbxasset", "%"))
          and s not in CLASSES and s not in SERVICES and s not in NOISE and s not in dyn_cls
          and not re.fullmatch(r"[a-z_]+", s)]
    ui_cnt = collections.Counter(ui).most_common(15)

    out = []
    out.append("## Что делает (по восстановленному коду)\n")
    if mech:
        for label, _ in sorted(mech, key=lambda x: -x[1]):
            out.append("- **%s** — улики: %s" % (
                label, ", ".join("`%s`" % e for e in evidence[label])))
    else:
        out.append("- явных механик по ключевым словам не найдено")
    out.append("\n## Вызовы API\n")
    if serv:
        out.append("- Сервисы: " + ", ".join("`%s`" % s for s in serv))
    if cls:
        out.append("- Классы/объекты: " + ", ".join("`%s`" % s for s in cls[:20]))
    if methods:
        out.append("- Методы: " + ", ".join("`%s`×%d" % (k, v) for k, v in methods.most_common(12)))
    out.append("\n## Имена функций (%d)\n" % len(funcs))
    if funcs:
        out.append(", ".join("`%s`" % f for f in funcs[:40]))
    else:
        out.append("_имена не сохранились — функции пронумерованы лифтом (`L2_1` и т.п.), "
                   "смысл восстанавливается по вызовам выше_")
    # парты / объекты: имена из WaitForChild/FindFirstChild + CamelCase-идентификаторы
    wc = collections.Counter(re.findall(r'(?:WaitForChild|FindFirstChild)\s*\(\s*["\']([^"\']{2,40})["\']', text))
    parts = sorted({s for s in tokens
                    if re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]{2,40}", s)
                    and not TEMP.match(s)
                    and not re.fullmatch(r"[a-z_]+", s)
                    and s not in CLASSES and s not in SERVICES})
    if ui_cnt:
        out.append("\n## Строковые константы (UI, подписи)\n")
        for s, n in ui_cnt:
            out.append("- `%s`%s" % (s, " ×%d" % n if n > 1 else ""))

    urls = sorted({s for s in strings if s.startswith(("http://", "https://"))})
    urls += sorted({m.group(0) for m in re.finditer(r'https?://[^\s"\')]+', text)})[:40]
    urls = uniq(urls)
    out.append("\n## Ссылки / webhooks / ассеты (%d)\n" % len(urls))
    if urls:
        for u in urls[:25]:
            out.append("- `%s`" % (u if len(u) < 120 else u[:117] + "..."))
    else:
        out.append("_нет_")

    out.append("\n## Парты / объекты (%d)\n" % (len(parts) + len(wc)))
    if wc:
        out.append("- через `WaitForChild`/`FindFirstChild`: " +
                   ", ".join("`%s`" % k for k, _ in wc.most_common(25)))
    if parts:
        out.append("- идентификаторы в коде: " + ", ".join("`%s`" % p for p in parts[:40]))
    if not wc and not parts:
        out.append("_имён объектов не сохранилось_")

    md = "\n".join(out) + "\n"
    if a.output:
        open(a.output, "w", encoding="utf-8").write(md)
        print("[+] %s -> %s" % (a.script, a.output))
    else:
        sys.stdout.write(md)


if __name__ == "__main__":
    main()
