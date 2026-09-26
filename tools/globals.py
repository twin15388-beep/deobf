"""List free globals per module (comments/strings stripped, locals respected).

Usage: python3 tools/globals.py [file ...]
"""
import re
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat  # noqa: E402

BUILTIN = set("""_G _VERSION and break do else elseif end false for function if in local nil not or
repeat return then true until while game workspace script task os math string table pcall xpcall ipairs
pairs next typeof type tostring tonumber warn error assert select require setmetatable getmetatable rawget
rawset rawequal unpack coroutine bit32 Enum Instance Vector3 Vector2 CFrame Color3 UDim UDim2 TweenInfo Ray
Region3 Random DateTime cloneref fireproximityprompt setclipboard toclipboard getgenv getrenv loadstring
load tick time print buffer utf8 self""".split())

KEYWORDS = {"and", "do", "else", "elseif", "end", "false", "for", "function", "if", "in", "local",
            "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "break"}


def analyse(path):
    src = open(path, encoding="utf-8").read()
    toks = [(k, t, s) for k, t, s, _ in luaflat.tokenize(src)]
    names = [t for k, t, _ in toks if k == "name"]
    local_decl = set()
    i = 0
    while i < len(toks):
        if toks[i][1] == "local" and i + 1 < len(toks):
            j = i + 1
            while j < len(toks) and toks[j][1] not in ("=", ";"):
                if toks[j][0] == "name":
                    local_decl.add(toks[j][1])
                j += 1
        i += 1
    # fields after `.`/`:` are not globals; approximate by removing names preceded by . or :
    free = []
    for idx, (k, t, s) in enumerate(toks):
        if k != "name" or t in KEYWORDS or t in local_decl or t in BUILTIN:
            continue
        prev = src[:s].rstrip()
        if prev.endswith(".") or prev.endswith(":"):
            continue
        nxt = src[s + len(t):].lstrip()
        if nxt.startswith("=") and not nxt.startswith("=="):
            continue          # assignment target (global definition)
        free.append(t)
    return sorted(set(free))


def main():
    for path in (sys.argv[1:] or ["ouroboros_farm.lua"]):
        print("##", path)
        print("   ", ", ".join(analyse(path)))


if __name__ == "__main__":
    main()
