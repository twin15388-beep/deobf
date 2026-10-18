#!/usr/bin/env python3
"""Verify published derived files against all pinned result manifests.

Removed artifacts remain in historical manifests but MUST NOT be on disk in the
published folder. This does NOT validate third-party inputs, semantic
equivalence, or run any Lua/Roblox code.
"""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path, PurePosixPath

ROOT = Path(__file__).resolve().parents[1]
REPORTS = (
    "reports/roblox-batch-2026-10-18.json",
    "reports/gpo-followup-2026-10-18.json",
    "reports/roblox-sources-2026-10-18.json",
)


def verify() -> int:
    seen: set[str] = set()
    published: set[str] = set()
    total = 0
    for report_name in REPORTS:
        report = json.loads((ROOT / report_name).read_text(encoding="utf-8"))
        for case in [*report["cases"], *report.get("excluded", [])]:
            for category in ("artifacts", "removed_artifacts"):
                for artifact in case.get(category, []):
                    name = artifact.get("published_path", artifact.get("path"))
                    if not isinstance(name, str):
                        raise ValueError(f"Invalid output path: {name}")
                    parts = PurePosixPath(name).parts
                    if (len(parts) != 2 or parts[0] != "dobf scripts 1.0"
                            or name in seen or ".." in parts or name.startswith("/")):
                        raise ValueError(f"Invalid or duplicate output path: {name}")
                    seen.add(name)
                    path = ROOT / name
                    if category == "removed_artifacts":
                        if path.exists() or path.is_symlink():
                            raise ValueError(f"Removed diagnostic unexpectedly published: {name}")
                        if (not isinstance(artifact.get("bytes"), int)
                                or artifact["bytes"] < 0
                                or not isinstance(artifact.get("sha256"), str)
                                or re.fullmatch(r"[0-9a-f]{64}", artifact["sha256"]) is None):
                            raise ValueError(f"Incomplete historical metadata: {name}")
                        continue
                    if not path.is_file() or path.is_symlink():
                        raise ValueError(f"Missing output or unexpected symlink: {name}")
                    published.add(name)
                    digest = hashlib.sha256()
                    with path.open("rb") as stream:
                        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
                            digest.update(chunk)
                    if path.stat().st_size != artifact["bytes"] or digest.hexdigest() != artifact["sha256"]:
                        raise ValueError(f"Size or SHA-256 mismatch: {name}")
                    total += 1
        print(f"OK  {report_name}")
    output_dir = ROOT / "dobf scripts 1.0"
    if not output_dir.is_dir() or output_dir.is_symlink():
        raise ValueError("Missing published results directory")
    for file in output_dir.iterdir():
        if file.name == "README.md":
            if not file.is_file() or file.is_symlink():
                raise ValueError("Unexpected README symlink or directory")
            continue
        if not file.is_file() or file.is_symlink() or f"dobf scripts 1.0/{file.name}" not in published:
            raise ValueError(f"Unlisted output in results directory: {file}")
    print(f"Verified {total} published derived files (not behavioral equivalence).")
    return total


if __name__ == "__main__":
    verify()
