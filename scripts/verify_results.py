#!/usr/bin/env python3
"""Verify published game-specific Lua against the pinned result manifests.

Checks inventory, size, SHA-256 and new source/deobfuscation labels; never
executes Lua or proves runtime behavior. Generic/weak results stay excluded.
"""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path, PurePosixPath

ROOT = Path(__file__).resolve().parents[1]
SOURCE_REPORTS = (
    "reports/game-sources-2026-10-21.json",
    "reports/game-sources-2026-10-21-additions.json",
    "reports/game-sources-2026-10-21-followup.json",
    "reports/game-sources-2026-10-21-extra.json",
    "reports/game-sources-2026-10-21-protected.json",
)
REPORTS = ("reports/game-recovery-2026-10-19.json", *SOURCE_REPORTS)
ADDITIONS = SOURCE_REPORTS[1]
FOLLOWUP = SOURCE_REPORTS[2]
EXTRA = SOURCE_REPORTS[3]
PROTECTED = SOURCE_REPORTS[4]


def verify() -> int:
    seen: set[str] = set()
    published: set[str] = set()
    total = 0
    for report_name in REPORTS:
        report = json.loads((ROOT / report_name).read_text(encoding="utf-8"))
        # The 2026-10-19 format groups outputs in cases, while the new
        # source/recovery report is a flat inventory. Both remain immutable
        # SHA-256 manifests for published files.
        items = []
        for case in [*report.get("cases", []), *report.get("excluded", [])]:
            for category in ("artifacts", "removed_artifacts"):
                items.extend((category, artifact) for artifact in case.get(category, []))
        items.extend(("artifacts", artifact) for artifact in report.get("artifacts", []))
        for category, artifact in items:
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
            # A filename is not sufficient evidence of a recovery. "src"
            # is mandatory for newly republished open-source code.
            if report_name in SOURCE_REPORTS:
                status = artifact.get("status")
                if status not in {"src", "deobfuscated"}:
                    raise ValueError(f"Unknown recovery/source status for {name}")
                if name.endswith(" (src).lua") != (status == "src"):
                    raise ValueError(f"Incorrect source label for {name}")
                data = path.read_bytes()
                header, separator, body = data.partition(b"]]\n\n")
                if not separator or not body or b"pastefy.app" in body.lower():
                    raise ValueError(f"Missing content or prohibited host in {name}")
                if report_name == ADDITIONS:
                    source = artifact["source"]
                    if status != "src" or b"NOT DEOBFUSCATED" not in header:
                        raise ValueError(f"Unlabeled open source in {name}")
                    if source["sha256"].encode() not in header:
                        raise ValueError(f"Missing pinned source hash in {name}")
                    if hashlib.sha256(body).hexdigest() != artifact["source_body_sha256"]:
                        raise ValueError(f"Altered source body in {name}")
                    if not all(marker.encode() in body for marker in artifact["game_markers"]):
                        raise ValueError(f"Missing game-specific code in {name}")
                    if source["license"] == "MIT":
                        if b"MIT License" not in header:
                            raise ValueError(f"Missing MIT notice in {name}")
                    elif source["license"] == "Apache-2.0":
                        license_path = ROOT / "reports/licenses/0x5A46-Apache-2.0.txt"
                        if (not license_path.is_file() or license_path.is_symlink()
                                or hashlib.sha256(license_path.read_bytes()).hexdigest()
                                != source["license_sha256"]
                                or b"Apache-2.0 license" not in header):
                            raise ValueError(f"Missing complete Apache-2.0 license for {name}")
                    elif not (b"No standard LICENSE" in header and b"no SPDX" in header):
                        raise ValueError(f"Missing source rights warning in {name}")
                    if name == "dobf scripts 1.0/Grand Piece Online - Aztup main (src).lua":
                        if (source["sha256"] == artifact["source_body_sha256"]
                                or any(term in body for term in (
                                    b"BanWebhook", b"FireWebhook", b"usedFeatures",
                                    b"function lib.Webhook.send"))):
                            raise ValueError("GPO automatic telemetry must stay removed")
                elif report_name == PROTECTED:
                    source = artifact["source"]
                    if (status != "deobfuscated"
                            or len(source["commit"]) != 40
                            or source["commit"] not in source["url"]
                            or not source["url"].startswith("https://github.com/")
                            or source["sha256"].encode() not in header
                            or source["url"].encode() not in header
                            or len(body) < 2000
                            or hashlib.sha256(body).hexdigest() != artifact["result_body_sha256"]
                            or hashlib.sha256(header + separator).hexdigest()
                            != artifact["result_header_sha256"]
                            or not all(marker.encode() in body for marker in artifact["game_markers"])):
                        raise ValueError(f"Unpinned or non-game-specific protected result: {name}")
                    verification = artifact["verification"]
                    if (verification["tested_in_roblox"] is not False
                            or verification["protected_top_level_executed"] is not False):
                        raise ValueError(f"Unsupported behavior claim: {name}")
                    if name.endswith(" (partial).lua"):
                        begin, end = b"MIT LICENSE BEGIN\n", b"MIT LICENSE END\n"
                        if (source["license"] != "MIT"
                                or b"PARTIAL STATIC DEOBFUSCATION" not in header
                                or b"manually rewritten" not in header
                                or begin not in header or end not in header
                                or verification["isolated_prototype_mock_cases"] != 28):
                            raise ValueError(f"Unlabeled manually reconstructed module: {name}")
                        license_bytes = header.split(begin, 1)[1].split(end, 1)[0]
                        if hashlib.sha256(license_bytes).hexdigest() != source["license_sha256"]:
                            raise ValueError(f"Altered upstream MIT license: {name}")
                    elif source["license"] == "MPL-2.0":
                        license_name = source["license_path"]
                        parts = PurePosixPath(license_name).parts
                        if (len(parts) != 3 or parts[:2] != ("reports", "licenses")
                                or ".." in parts):
                            raise ValueError(f"Unsafe license path: {name}")
                        license_path = ROOT / license_name
                        if (not license_path.is_file() or license_path.is_symlink()
                                or hashlib.sha256(license_path.read_bytes()).hexdigest()
                                != source["license_sha256"]
                                or b"Mozilla Public License, v. 2.0" not in header
                                or b"static recovery" not in header
                                or verification["repeat_decoder_output_identical"] is not True
                                or verification["mock_game_assertions"] != 17):
                            raise ValueError(f"Missing licensed decoder output: {name}")
                    else:
                        raise ValueError(f"Unsupported protected result license: {name}")
                elif report_name in (FOLLOWUP, EXTRA):
                    source = artifact["source"]
                    if (source["license"] != "MIT" or len(source["commit"]) != 40
                            or source["commit"] not in source["url"]
                            or not source["url"].startswith("https://github.com/")
                            or source["sha256"].encode() not in header):
                        raise ValueError(f"Missing pinned MIT source for {name}")
                    begin, end = b"MIT LICENSE BEGIN\n", b"MIT LICENSE END\n"
                    if begin not in header or end not in header:
                        raise ValueError(f"Missing complete license in {name}")
                    license_bytes = header.split(begin, 1)[1].split(end, 1)[0]
                    if (b"MIT License" not in license_bytes
                            or hashlib.sha256(license_bytes).hexdigest() != source["license_sha256"]):
                        raise ValueError(f"Altered upstream license in {name}")
                    if (len(body) < 2000
                            or hashlib.sha256(body).hexdigest() != artifact["result_body_sha256"]
                            or not all(marker.encode() in body for marker in artifact["game_markers"])):
                        raise ValueError(f"Altered or non-game-specific body in {name}")
                    if status == "src":
                        if b"NOT DEOBFUSCATED" not in header:
                            raise ValueError(f"Unlabeled open source in {name}")
                        if report_name == EXTRA:
                            if (artifact.get("sanitized") is not True
                                    or b"OPEN SOURCE (src)" not in header
                                    or source["sha256"] == artifact["result_body_sha256"]
                                    or b"Method = 'POST'" in body
                                    or b"submit-parry-timing" in body):
                                raise ValueError(f"Unsanitized Aztup source in {name}")
                        elif (source["sha256"] != artifact["result_body_sha256"]
                              or source["bytes"] != len(body)):
                            raise ValueError(f"Altered original source in {name}")
                    elif (b"DEOBFUSCATED (static recovery)" not in header
                          or (report_name == FOLLOWUP
                              and artifact["recovery_tool"].encode() not in header)
                          or source["sha256"] == artifact["result_body_sha256"]):
                        raise ValueError(f"Unlabeled or unverified recovery in {name}")
                    if report_name == EXTRA:
                        if (hashlib.sha256(header + separator).hexdigest()
                                != artifact["result_header_sha256"]):
                            raise ValueError(f"Altered result header: {name}")
                        if status == "deobfuscated" and (
                                any(marker in body for marker in (
                                    b"_MmmjvvlZHicC", b"_JBmfmFsdXbcx", b"_vnIGVltJgej"))
                                or artifact["recovery"]["constants"] != 607
                                or artifact["recovery"]["literal_uses"] != 1070):
                            raise ValueError(f"Incomplete WaveHub string-layer recovery: {name}")
                else:
                    if b"MIT License" not in header[:2500]:
                        raise ValueError(f"Missing license in {name}")
                    if name == "dobf scripts 1.0/Bloxstrike - Hotline UI.lua":
                        if b"HttpGet(" in body or b"loadstring(" in body:
                            raise ValueError("Bloxstrike telemetry loader must stay removed")
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
    print(f"Verified {total} published game files (not behavioral equivalence).")
    return total


if __name__ == "__main__":
    verify()
