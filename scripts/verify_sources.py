#!/usr/bin/env python3
"""Offline integrity and basic layout checks for the vendored source archives."""

import hashlib
import json
from pathlib import Path, PurePosixPath
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "sources" / "manifest.json"


def verify():
    sources = json.loads(MANIFEST.read_text(encoding="utf-8"))["sources"]
    if not sources:
        raise ValueError("Manifest is empty")

    seen = set()
    for source in sources:
        repo = source["repository"]
        archive_name = f"sources/{repo.replace('/', '--')}.zip"
        if repo in seen or source["archive"] != archive_name:
            raise ValueError(f"Duplicate or unexpected archive path: {repo}")
        seen.add(repo)
        archive = ROOT / archive_name
        digest = hashlib.sha256()
        with archive.open("rb") as stream:
            for chunk in iter(lambda: stream.read(1024 * 1024), b""):
                digest.update(chunk)
        if digest.hexdigest() != source["sha256"]:
            raise ValueError(f"SHA-256 mismatch: {archive_name}")

        prefix = f"{repo.replace('/', '--')}-{source['commit'][:12]}"
        licenses = []
        with zipfile.ZipFile(archive) as snapshot:
            files = [info for info in snapshot.infolist() if not info.is_dir()]
            if len(files) != source["files"] or snapshot.testzip() is not None:
                raise ValueError(f"Invalid ZIP or file count: {archive_name}")
            for info in files:
                parts = PurePosixPath(info.filename).parts
                if (len(parts) < 2 or parts[0] != prefix or
                        ".." in parts or info.filename.startswith("/")):
                    raise ValueError(f"Unsafe or unexpected ZIP entry: {info.filename}")
                if len(parts) == 2 and parts[1].lower().startswith("license"):
                    licenses.append(info.filename)
        if not licenses:
            raise ValueError(f"Missing upstream license: {archive_name}")
        print(f"OK  {repo}  ({len(files)} files)")

    print(f"Verified {len(sources)} source archives.")


if __name__ == "__main__":
    try:
        verify()
    except (OSError, ValueError, KeyError, zipfile.BadZipFile) as error:
        print(f"Archive verification failed: {error}", file=sys.stderr)
        sys.exit(1)
