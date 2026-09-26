"""Find the pool slots whose code references a given string/number constant.

Works by rendering each function slot with the constant pool inlined, then searching
the rendered text -- robust against the local pool aliases the obfuscator invents.

Usage:
    python3 tools/locate.py "ouroboros_ps2 (1).luau" Item_Equip "Combat_Service"
"""

import re
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from inline_constants import build_maps, find_aliases  # noqa: E402
from deflatten import slot_spans  # noqa: E402


def main(path, needles):
    src = open(path, encoding="utf-8", errors="replace").read()
    entries, values, kinds, toks = build_maps(src)
    aliases = find_aliases(toks)
    spans = slot_spans(toks)
    alias_alt = "|".join(re.escape(a) for a in aliases) if aliases else None

    def render_slot(s, e):
        text = " ".join(t[1] for t in toks[s:e])
        text = re.sub(r"cKb\s*\[\s*136\s*\]\s*\[\s*(\d+\.?\d*)\s*\]",
                      lambda m: entries[int(float(m.group(1))) - 1], text)
        if alias_alt:
            text = re.sub(r"\b(?:" + alias_alt + r")\s*\[\s*(\d+\.?\d*)\s*\]",
                          lambda m: entries[int(float(m.group(1))) - 1], text)
        return text

    for needle in needles:
        print("=== %s" % needle)
        found = 0
        for slot, (s, e) in sorted(spans.items()):
            if toks[s][1] != "function":
                continue
            text = render_slot(s, e)
            if needle in text:
                found += 1
                for m in list(re.finditer(re.escape(needle), text))[:2]:
                    ctx = text[max(0, m.start() - 130):m.end() + 90].replace("\n", " ")
                    print("   F%-5d %s" % (slot, re.sub(r"\s+", " ", ctx)))
                if found >= 8:
                    print("   ... (more)")
                    break
        if not found:
            print("   no function slot references it (maybe only in the UI tables)")


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2:])
