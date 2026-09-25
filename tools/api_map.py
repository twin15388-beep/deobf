"""Extract the script's public API surface (feature name -> implementation slot).

The artifact stores every user-facing setting as a closure in the constant pool and
publishes it through a table (`cKb[51]["SetSkillHold"] = F6286`). This tool reads the
de-flattened engine and lists that mapping, so a reconstruction can be compared
against the original 1:1.

Usage:
    python3 tools/api_map.py ouroboros_main_pruned.txt data/api_map.json
"""

import json
import re
import sys
from collections import OrderedDict

ASSIGN = re.compile(r'cKb \[\s*(\d+)\s*\]\s*\[\s*"([^"]+)"\s*\]\s*=\s*F(\d+)')
TRACK = re.compile(r'cKb \[\s*(\d+)\s*\]\s*\[\s*"([^"]+)"\s*\]\s*\(')


def main():
    src_path = sys.argv[1] if len(sys.argv) > 1 else "ouroboros_main_pruned.txt"
    out_path = sys.argv[2] if len(sys.argv) > 2 else None
    text = open(src_path, encoding="utf-8", errors="replace").read()
    api = OrderedDict()
    for table, name, slot in ASSIGN.findall(text):
        api.setdefault(table, {})[name] = int(slot)
    scripts = OrderedDict()
    for table, name in TRACK.findall(text):
        scripts.setdefault(table, set()).add(name)

    md_path = None
    compare_path = None
    rest = sys.argv[3:]
    if "--md" in rest:
        md_path = rest[rest.index("--md") + 1]
    if "--compare" in rest:
        compare_path = rest[rest.index("--compare") + 1]

    names = {}
    try:
        pool = json.load(open("data/pool.json"))
        for slot, labels in pool.get("function_names", {}).items():
            names[int(slot)] = labels
    except OSError:
        pass

    total = sum(len(v) for v in api.values())
    print("%s: %d setting closures in %d tables, %d tracked script keys"
          % (src_path, total, len(api), sum(len(v) for v in scripts.values())))
    for table, entries in api.items():
        named = sum(1 for slot in entries.values() if slot in names)
        print("  cKb[%s]: %d entries (%d with known names)" % (table, len(entries), named))
        for name, slot in sorted(entries.items()):
            print("    %-28s -> F%-6d %s" % (name, slot, ", ".join(names.get(slot, []))))
    if md_path:
        lines = ["# Public API surface of the original artifact", "",
                 "Extracted 1:1 from the de-flattened engine "
                 "(`cKb[<table>][\"name\"] = F<slot>`).", ""]
        for table, entries in api.items():
            lines.append("## `cKb[%s]` (%d entries)" % (table, len(entries)))
            lines.append("")
            lines.append("| setting | slot | closure |")
            lines.append("|---|---|---|")
            for name, slot in sorted(entries.items()):
                lines.append("| `%s` | F%d | %s |"
                             % (name, slot, ", ".join(names.get(slot, [])) or "-"))
            lines.append("")
        with open(md_path, "w", encoding="utf-8") as fh:
            fh.write("\n".join(lines))
        print("wrote", md_path)

    if compare_path:
        text_rec = open(compare_path, encoding="utf-8", errors="replace").read()
        have = set()
        for table in api.values():
            for name in table:
                if re.search(r"(?<![A-Za-z0-9_])" + re.escape(name)
                             + r"(?![A-Za-z0-9_])", text_rec):
                    have.add(name)
        missing = sorted(set().union(*[set(t) for t in api.values()]) - have)
        print("reconstruction coverage: %d of %d API names present (%d missing)"
              % (len(have), total, len(missing)))
        for name in missing[:40]:
            print("   missing:", name)

    if out_path:
        with open(out_path, "w", encoding="utf-8") as fh:
            json.dump({"settings": api,
                       "script_keys": {k: sorted(v) for k, v in scripts.items()},
                       "slot_names": names}, fh, ensure_ascii=False, indent=1)
        print("wrote", out_path)


if __name__ == "__main__":
    main()
