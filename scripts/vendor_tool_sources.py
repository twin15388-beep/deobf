#!/usr/bin/env python3
"""Create reproducible source-only ZIP snapshots of licensed deobfuscator tools.

The repository keeps one ZIP per upstream project under ``sources/`` with the
layout ``<owner>--<repo>-<commit12>/...`` (see ``scripts/verify_sources.py``).
This helper rebuilds such a snapshot from a public GitHub project at a pinned
commit and prints the manifest entry that has to be added to
``sources/manifest.json``.

Only sources are kept: build outputs, bundled native binaries, ``node_modules``
and third-party protected/game sample payloads are dropped, because the
repository publishes tool sources, not other people's obfuscated scripts.

Usage::

    python3 scripts/vendor_tool_sources.py --repo ServerDeadd/Luraph-v15.1-Deobfuscator \\
        --family "Luraph v15" --kind devirtualizer --language Python/JS \\
        --license MIT --exclude bin --exclude samples_v15.1_deobfuscated

Nothing is pushed anywhere; the script only clones, filters and zips.
"""

import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]
SOURCES = ROOT / "sources"

SKIP_DIRS = {".git", "node_modules", "__pycache__", ".venv", "venv", ".github"}
SKIP_SUFFIXES = {
    ".exe", ".dll", ".pdb", ".so", ".dylib", ".bin", ".o", ".a", ".lib",
    ".class", ".jar", ".pyc", ".luac", ".zip", ".7z", ".rar", ".png", ".jpg",
    ".jpeg", ".gif", ".ico", ".webp", ".mp4", ".mp3",
}
KEEP_PNG = set()  # no banner images are kept


def run(cmd, cwd=None):
    return subprocess.run(cmd, cwd=cwd, check=True, text=True,
                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT).stdout


def clone(repo, tmp):
    dest = Path(tmp) / "work"
    run(["git", "clone", "--quiet", f"https://github.com/{repo}.git", str(dest)])
    commit = run(["git", "-C", str(dest), "rev-parse", "HEAD"]).strip()
    return dest, commit


def excluded(relative, excludes):
    parts = Path(relative).parts
    if any(part in SKIP_DIRS for part in parts):
        return True
    if Path(relative).suffix.lower() in SKIP_SUFFIXES:
        return True
    for rule in excludes:
        rule = rule.strip("/")
        if relative == rule or relative.startswith(rule + "/"):
            return True
        if Path(relative).name == rule:
            return True
    return False


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", required=True, help="owner/name")
    parser.add_argument("--family", required=True)
    parser.add_argument("--kind", required=True)
    parser.add_argument("--language", required=True)
    parser.add_argument("--license", required=True)
    parser.add_argument("--exclude", action="append", default=[],
                        help="path prefix, file name or directory to drop")
    parser.add_argument("--notes", default="")
    parser.add_argument("--write", action="store_true",
                        help="write sources/<owner>--<name>.zip")
    args = parser.parse_args()

    owner, name = args.repo.split("/", 1)
    prefix = f"{owner}--{name}"
    with tempfile.TemporaryDirectory() as tmp:
        work, commit = clone(args.repo, tmp)
        archive_path = SOURCES / f"{prefix}.zip"
        files = []
        tmp_zip = Path(tmp) / "snapshot.zip"
        with zipfile.ZipFile(tmp_zip, "w", zipfile.ZIP_DEFLATED) as snapshot:
            for path in sorted(work.rglob("*")):
                if not path.is_file():
                    continue
                relative = path.relative_to(work).as_posix()
                if excluded(relative, args.exclude):
                    continue
                arcname = f"{prefix}-{commit[:12]}/{relative}"
                snapshot.write(path, arcname)
                files.append(arcname)

        candidates = [p for p in work.rglob("*")
                      if p.is_file() and not any(part in SKIP_DIRS
                                                 for part in p.relative_to(work).parts)]
        data = tmp_zip.read_bytes()
        digest = hashlib.sha256(data).hexdigest()
        entry = {
            "repository": args.repo,
            "url": f"https://github.com/{args.repo}",
            "commit": commit,
            "license": args.license,
            "family": args.family,
            "language": args.language,
            "kind": args.kind,
            "archive": f"sources/{prefix}.zip",
            "sha256": digest,
            "files": len(files),
            "omitted_files": len(candidates) - len(files),
        }
        if args.notes:
            entry["notes"] = args.notes
        if args.write:
            shutil.copyfile(tmp_zip, archive_path)
            print(f"wrote {archive_path.name} ({len(files)} files, {len(data)} bytes)",
                  file=sys.stderr)
        else:
            print("dry run; rerun with --write", file=sys.stderr)
        print(json.dumps(entry, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
