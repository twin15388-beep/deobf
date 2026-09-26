"""Turn a recorder trace into a protocol report.

Takes the text produced by `ouroboros_behavior_trace.lua` (the COPY TRACE button)
and summarises it: which remotes were called, with which argument shapes, which API
toggles were flipped and in what order, and which arguments line up with the
constant-pool names in the artifact.

Usage:
    python3 tools/trace_report.py trace.txt [--pool data/pool_index.json]
"""

import json
import re
import sys
from collections import Counter, OrderedDict

LINE = re.compile(r"^\[(?P<t>\s*[\d.]+)\]\s*(?P<kind>[A-Za-z_.]+)(?P<rest>.*)$")
ARG = re.compile(r"A(\d+)=(?P<value>.*)$")


def parse(text):
    events = []
    for raw in text.split("\n\n"):
        block = [ln for ln in raw.split("\n") if ln.strip()]
        if not block:
            continue
        head = LINE.match(block[0])
        if not head:
            continue
        args = OrderedDict()
        for ln in block[1:]:
            m = ARG.search(ln.strip())
            if m:
                args[int(ARG.search(ln.strip()).group(1))] = m.group("value")
        events.append({"time": float(head.group("t")), "kind": head.group("kind"),
                       "args": args})
    return events


def shape(value):
    """Coarse type of a recorded argument, for a signature listing."""
    if value is None:
        return "?"
    if value.startswith('"'):
        return "string"
    if value in ("true", "false"):
        return "bool"
    if value == "nil":
        return "nil"
    if value.startswith("{"):
        return "table"
    if value.startswith("INSTANCE"):
        return "Instance"
    if value.startswith("Vector3"):
        return "Vector3"
    if value.startswith("CFrame"):
        return "CFrame"
    if re.match(r"^-?\d", value):
        return "number"
    return "?"


def pool_names(pool_path):
    try:
        pool = json.load(open(pool_path))
    except OSError:
        return {}
    return {str(v): k for k, v in pool.items() if isinstance(v, str)}


def report(events, names):
    calls = Counter(e["kind"] for e in events)
    print("=== %d events ===" % len(events))
    for kind, count in calls.most_common():
        print("  %-42s %d" % (kind, count))

    print("\n=== call signatures ===")
    sigs = OrderedDict()
    for e in events:
        sig = (e["kind"], tuple(shape(v) for v in e["args"].values()))
        sigs.setdefault(sig, []).append(e)
    for (kind, sig), items in sigs.items():
        sample = items[0]
        print("  %-38s (%s)  x%d" % (kind, ", ".join(sig), len(items)))
        for key, value in sample["args"].items():
            note = ""
            if isinstance(value, str) and value.startswith('"'):
                plain = value.strip('"')
                if plain in names:
                    pass
            print("      A%d = %s" % (key, value[:90]))

    print("\n=== API toggles in order ===")
    for e in events:
        if e["kind"].startswith("API.") and "RETURN" not in e["kind"]:
            args = ", ".join(e["args"].values())
            print("  [%7.2f] %-34s %s" % (e["time"], e["kind"], args[:70]))

    print("\n=== remote calls in order (first 40) ===")
    shown = 0
    for e in events:
        if e["kind"].startswith(("SignalEvent", "SignalFunction", "InputHandler",
                                 "SkillController")) and "RETURN" not in e["kind"]:
            print("  [%7.2f] %-34s %s"
                  % (e["time"], e["kind"],
                     "  ".join(e["args"].values())[:80]))
            shown += 1
            if shown >= 40:
                print("  ...")
                break


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "trace.txt"
    text = open(path, encoding="utf-8", errors="replace").read()
    names = pool_names("data/pool_index.json")
    events = parse(text)
    if not events:
        print("no events parsed -- is this a NZL_BehaviorTrace dump?")
        return
    report(events, names)


if __name__ == "__main__":
    main()
