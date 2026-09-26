"""Build data/feature_index.json: map public API / feature names to pool indices.

Usage:
    python3 tools/feature_index.py "ouroboros_ps2 (1).luau" data/feature_index.json
"""

import json
import re
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat  # noqa: E402

INTERESTING = re.compile(r"^(Set|Teleport|Auto|Get|Is)[A-Z]")


def main():
    src_path = sys.argv[1] if len(sys.argv) > 1 else "ouroboros_ps2 (1).luau"
    out_path = sys.argv[2] if len(sys.argv) > 2 else "data/feature_index.json"
    src = open(src_path, encoding="utf-8", errors="replace").read()
    resolved_path = sys.argv[3] if len(sys.argv) > 3 else None
    resolved = open(resolved_path, encoding="utf-8", errors="replace").read() if resolved_path else ""

    entries, _ = luaflat.extract_pool(src)
    index = {}
    for i, e in enumerate(entries, 1):
        if e.startswith('"') and e.endswith('"'):
            name = e[1:-1]
            if INTERESTING.match(name):
                index.setdefault(name, []).append(i)

    report = {}
    for name, idxs in sorted(index.items()):
        anchors = []
        if resolved:
            anchors = [m.start() for m in re.finditer(re.escape('"' + name + '"'), resolved)][:5]
        report[name] = {"pool": idxs, "anchors": anchors}

    json.dump(report, open(out_path, "w"), ensure_ascii=False, indent=1)
    print("features:", len(report), "->", out_path)


if __name__ == "__main__":
    main()
