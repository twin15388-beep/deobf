#!/usr/bin/env python3
"""Repair the one fallthrough label in the recovered WHI Farm loop.

The jump follows f38(v99) and targets only `task.wait()` in the other arm.
Duplicate that wait at the jump site. The original game's Lua is not run.
The exact-match guard prevents applying this to unrelated control flow.
"""

from pathlib import Path
import sys


def repair(source: str) -> str:
    label = "      ::L13094772::\n      task.wait()"
    jump = "        f38(v99)\n        goto L13094772"
    if source.count(label) != 1 or source.count(jump) != 1:
        raise ValueError("WHI Farm loop layout differs from the audited input")
    if source.count("goto ") != 1 or source.count("::L") != 1:
        raise ValueError("additional jumps require a separate audit")
    return source.replace(label, "      task.wait()").replace(
        jump, "        f38(v99)\n        task.wait()"
    )


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("usage: python3 scripts/repair_wild_horse_goto.py in.lua out.lua")
    source, target = map(Path, sys.argv[1:])
    target.write_bytes(repair(source.read_bytes().decode("utf-8")).encode("utf-8"))
