#!/usr/bin/env python3
"""Unpack the pinned, locally vendored pdeobf source and fix two typos.

No downloaded input or Lua script is run. This is required only for
reproducing the recovered game samples / running the post-pass tests.
"""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
import sys
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]
REPOSITORY = "prostone4/Prometheus-Deobfuscator"


def extract_and_patch(destination: Path) -> Path:
    manifest = json.loads((ROOT / "sources/manifest.json").read_text())
    source = next(entry for entry in manifest["sources"] if entry["repository"] == REPOSITORY)
    archive = ROOT / source["archive"]
    if hashlib.sha256(archive.read_bytes()).hexdigest() != source["sha256"]:
        raise ValueError("pinned deobfuscator ZIP has the wrong SHA-256")

    if destination.exists() and any(destination.iterdir()):
        raise ValueError(f"destination is not empty: {destination}")
    destination.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(archive) as zipped:
        paths = [Path(item.filename) for item in zipped.infolist()]
        if not paths or any(p.is_absolute() or ".." in p.parts for p in paths):
            raise ValueError("unsafe archive entries")
        if len({p.parts[0] for p in paths}) != 1:
            raise ValueError("archive does not have one source directory")
        zipped.extractall(destination)

    source_root = destination / paths[0].parts[0]
    changes = (
        ("src/lua/parser.js", "BLOCK_TERMINATORS.has(t.value)", "TERMINATORS.has(t.value)"),
        (
            "src/beautify/jumps.js",
            "const TAILS = 8;",
            "const TAILS = 8;\n// Conservative bounds for suffix duplication.\n"
            "const TAIL_STATEMENTS = TAILS;\nconst TAIL_NODES = TAILS * 16;",
        ),
    )
    for name, before, after in changes:
        file = source_root / name
        text = file.read_text(encoding="utf-8")
        if text.count(before) != 1:
            raise ValueError(f"unexpected upstream layout: {name}")
        file.write_text(text.replace(before, after), encoding="utf-8")
    return source_root


if __name__ == "__main__":
    if len(sys.argv) > 2:
        raise SystemExit("usage: python3 scripts/prepare_pdeobf.py [empty-directory]")
    target = Path(sys.argv[1]) if len(sys.argv) == 2 else Path(tempfile.mkdtemp(prefix="pdeobf-pinned-"))
    print(extract_and_patch(target))
