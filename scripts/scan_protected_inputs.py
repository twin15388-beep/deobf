#!/usr/bin/env python3
"""Classify a directory tree of Lua/Luau files by protection family.

Discovery step for a multi-game pass: point it at a folder of cloned
repositories and it prints one row per protected file, so the expensive work
(devirtualisation, behaviour tracing) starts from a ranked list instead of a
guess.  Nothing is executed and nothing is decoded here — this is triage only.

    python3 scripts/scan_protected_inputs.py local-results/scan
    python3 scripts/scan_protected_inputs.py local-results/scan --json out.json
    python3 scripts/scan_protected_inputs.py sample.lua --min-size 0

Families come from headers the obfuscators write themselves; a hit means the
banner was found, not that the file runs or that the payload is a game script.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

DEFAULT_EXTENSIONS = {"", ".lua", ".luau", ".txt"}
READ_BYTES = 8192

# (family, version-pattern) — ordered: the most specific banner wins.
SIGNATURES: list[tuple[str, re.Pattern[bytes]]] = [
    ("wad", re.compile(rb"wearedevs\.net/obfuscator")),
    ("mafy", re.compile(rb"Protected by Mafy Obfuscator|Mafy Obfuscator")),
    ("luraph", re.compile(rb"Luraph Obfuscator v\d+(?:\.\d+)*|protected using Luraph Obfuscator")),
    ("moonsec_v3", re.compile(rb"MoonSec V3|Protected_by_MoonSecV3|Protected with MoonSec V3")),
    ("moonsec_v2", re.compile(rb"Protected_by_MoonSecV2|MoonSecV2|MoonSec V2")),
    ("prometheus", re.compile(rb"Protected_by_Prometheus|Prometheus Obfuscator")),
    ("ironbrew", re.compile(rb"IronBrew")),
    ("luaobfuscator", re.compile(rb"luaobfuscator\.com")),
    ("luast", re.compile(rb"Luast|Obfuscated with Luast")),
    ("umbra", re.compile(rb"Umbra")),
    ("koralys", re.compile(rb"Koralys")),
    ("luaguard", re.compile(rb"LuaGuard|Lua Guard")),
    ("hercules", re.compile(rb"Hercules")),
    ("clyde", re.compile(rb"Clyde")),
    ("77fuscator", re.compile(rb"77fuscator")),
]

VERSION_RE = re.compile(rb"v(\d+(?:\.\d+)+)")


def classify(path: Path) -> tuple[str, str] | None:
    """Return (family, version) for a protected file, or None for plaintext."""
    try:
        head = path.open("rb").read(READ_BYTES)
    except OSError:
        return None
    for family, pattern in SIGNATURES:
        match = pattern.search(head)
        if not match:
            continue
        window = head[match.start():match.start() + 80]
        version = VERSION_RE.search(window)
        return family, version.group(1).decode() if version else ""
    return None


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def scan(root: Path, min_size: int = 3000, extensions: set[str] | None = None) -> list[dict]:
    extensions = DEFAULT_EXTENSIONS if extensions is None else extensions
    targets = [root] if root.is_file() else sorted(p for p in root.rglob("*") if p.is_file())
    rows: list[dict] = []
    for path in targets:
        if path.suffix.lower() not in extensions:
            continue
        try:
            size = path.stat().st_size
        except OSError:
            continue
        if size < min_size:
            continue
        found = classify(path)
        if found is None:
            continue
        family, version = found
        rows.append({"family": family, "version": version, "size": size,
                     "sha256": sha256(path), "path": str(path)})
    rows.sort(key=lambda row: -row["size"])
    return rows


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("paths", nargs="+", type=Path, help="files or directories to scan")
    parser.add_argument("--min-size", type=int, default=3000, help="skip files smaller than this (default 3000)")
    parser.add_argument("--json", type=Path, help="write the rows as JSON instead of printing TSV")
    args = parser.parse_args(argv)

    rows: list[dict] = []
    for path in args.paths:
        if not path.exists():
            parser.error(f"no such path: {path}")
        rows.extend(scan(path, min_size=args.min_size))
    rows.sort(key=lambda row: -row["size"])

    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(json.dumps(rows, indent=2) + "\n", encoding="utf-8")
        print(f"{len(rows)} protected files -> {args.json}", file=sys.stderr)
        return 0

    print("family\tversion\tsize\tsha256\tpath")
    for row in rows:
        print(f"{row['family']}\t{row['version'] or '-'}\t{row['size']}\t{row['sha256'][:16]}\t{row['path']}")
    print(f"# {len(rows)} protected files", file=sys.stderr)
    return 0


if __name__ == "__main__":
    sys.exit(main())
