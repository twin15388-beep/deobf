#!/usr/bin/env python3
"""Repair the one dangling jump in the recovered Prison Life follow-check loop.

The pinned WAD decoder emitted `goto L9209319` but never emitted the label
`::L9209319::`, so its raw output does not compile; the root cause is recorded in
reports/decoder-goto-defect-2026-10-23.md (src/vm/structure.js skips labels whose
block was already placed). The jump is the last statement of the `repeat` body and
`until not nextPageCursor` follows it immediately, so falling through to the loop
test is equivalent to taking the jump.

The original game's Lua is not run. The exact-match guards prevent applying this
to unrelated control flow: only the audited layout is accepted, and a source with
any other jump or with a real label is rejected instead of being edited.
"""

from pathlib import Path
import sys

BEFORE = (
    "      nextPageCursor = jsonDecode.nextPageCursor\n"
    "      goto L9209319\n"
    "    end\n"
    "  until not nextPageCursor\n"
)
AFTER = (
    "      nextPageCursor = jsonDecode.nextPageCursor\n"
    "    end\n"
    "  until not nextPageCursor\n"
)
REMOVED = "      goto L9209319\n"


def repair(source: str) -> str:
    if source.count(BEFORE) != 1:
        raise ValueError("Prison Life follow-check layout differs from the audited input")
    if source.count("goto ") != 1 or source.count("::L") != 0:
        raise ValueError("additional jumps require a separate audit")
    repaired = source.replace(BEFORE, AFTER)
    if len(source) - len(repaired) != len(REMOVED):
        raise ValueError("repair removed more than the audited jump")
    return repaired


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("usage: python3 scripts/repair_prison_life_goto.py in.lua out.lua")
    source, target = map(Path, sys.argv[1:])
    target.write_bytes(repair(source.read_bytes().decode("utf-8")).encode("utf-8"))
