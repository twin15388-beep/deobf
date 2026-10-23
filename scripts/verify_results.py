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
    "reports/game-sources-2026-10-22-wad.json",
    "reports/game-sources-2026-10-23-wad.json",
)
REPORTS = ("reports/game-recovery-2026-10-19.json", *SOURCE_REPORTS)
ADDITIONS = SOURCE_REPORTS[1]
FOLLOWUP = SOURCE_REPORTS[2]
EXTRA = SOURCE_REPORTS[3]
PROTECTED = SOURCE_REPORTS[4]
WAD = SOURCE_REPORTS[5]
WAD2 = SOURCE_REPORTS[6]
# Both reports share the same shape: verbatim (or minimally repaired) decoder
# bodies from MIT-pinned WeAreDevs/WAD inputs.
WAD_REPORTS = (WAD, WAD2)
PROTECTED_PARTIAL_CASES = {
    "dobf scripts 1.0/Zero Academia - ZeroScripts (partial).lua": 28,
    "dobf scripts 1.0/Item Factory - MoonSec V3 (partial).lua": 44,
    "dobf scripts 1.0/Anime Fighters Simulator - PSU (partial).lua": 20,
}
# Offline evidence required from each WAD recovery. A mock count of 0 is only
# accepted together with a static-body assertion count, so an untested file can
# never be published silently.
WAD_EVIDENCE = {
    "dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua": {
        "mock_game_assertions": 36,
        "static_body_assertions": None,
        "body_contains": (
            b"github.com/Footagesus/WindUI/releases/latest/download/main.lua",
            b'"PurchaseShopItem", { ItemName = "1x Lucky Arrow" }',
            b'NPC = "Merchant"',
        ),
        "body_excludes": (b"loadstring(game:HttpGet(\"https://pastebin",),
    },
    "dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua": {
        "mock_game_assertions": 0,
        "static_body_assertions": 35,
        "body_contains": (
            b"Knit.Knit.Services.CursoryImpactService.RE.Activated",
            b"Knit.Knit.Services.NaoyaService.RE.RightActivated",
            b'GetAttribute("Moveset") ~= "Naoya"',
        ),
        "body_excludes": (b"loadstring(",),
    },
    "dobf scripts 1.0/Slap Battles - Tryhard AI Demo.lua": {
        "mock_game_assertions": 0,
        "static_body_assertions": 14,
        "body_contains": (
            b'b:FireServer(humanoidRootPart)',
            b'replicatedStorage.GeneralHit',
            b'tick() < 1763809636.9279',
        ),
        "body_excludes": (b"HttpGet", b"loadstring(", b"goto "),
    },
    "dobf scripts 1.0/Prison Life - volmaks ESP Freecam.lua": {
        "mock_game_assertions": 0,
        "static_body_assertions": 15,
        "body_contains": (
            b"https://friends.roproxy.com/v1/users/",
            b"workspace.Prison_ITEMS",
            b'"FC_KEYS"',
        ),
        "body_excludes": (b"FireServer(", b"InvokeServer(", b"goto "),
    },
    "dobf scripts 1.0/Work at a Pizza Place - Order4.lua": {
        "mock_game_assertions": 0,
        "static_body_assertions": 14,
        "body_contains": (
            b'replicatedStorage.ManagerChannel:FireServer("GiveBonus"',
            b'"Auto steal items"',
            b"Additional/Linoria.lua",
        ),
        "body_excludes": (b"goto ", b"pastefy"),
    },
}


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
                                or verification["isolated_prototype_mock_cases"]
                                != PROTECTED_PARTIAL_CASES.get(name)):
                            raise ValueError(f"Unlabeled manually reconstructed module: {name}")
                        license_bytes = header.split(begin, 1)[1].split(end, 1)[0]
                        if hashlib.sha256(license_bytes).hexdigest() != source["license_sha256"]:
                            raise ValueError(f"Altered upstream MIT license: {name}")
                        if name == "dobf scripts 1.0/Anime Fighters Simulator - PSU (partial).lua":
                            recovery = artifact["recovery"]
                            if (artifact["recovery_tool"].encode() not in header
                                    or b"4042427666" not in header
                                    or b"6299805723" not in header
                                    or recovery["bytecode_bytes"] != 40696
                                    or recovery["lua51_valid"] is not True
                                    or recovery["child_prototypes"] != 55
                                    or recovery["selected_children"] != [
                                        "0_7", "0_15_0", "0_17", "0_22", "0_23",
                                        "0_24", "0_25", "0_26", "0_27", "0_29"]
                                    or recovery["corrected_call_handlers"] != {
                                        "fixed_one_arg": 104,
                                        "one_arg_multi_result": 39,
                                        "other_multireturn": 3,
                                    }
                                    or recovery["protected_vm_executed"] is not False
                                    or verification["bytecode_corrected_before_comparison"] is not True
                                    or artifact["candidate_place_id"] != 6299805723
                                    or artifact["excluded_place_id"] != 4042427666
                                    or any(token in body.lower() for token in
                                           (b"https://", b"httpget(", b"loadstring("))):
                                raise ValueError(f"Incomplete or unsafe partial PSU recovery: {name}")
                        if name == "dobf scripts 1.0/Item Factory - MoonSec V3 (partial).lua":
                            recovery = artifact["recovery"]
                            if (artifact["recovery_tool"].encode() not in header
                                    or b"FAIL Lua 5.1 bytecode verification" not in header
                                    or recovery["root_lua51_valid"] is not False
                                    or recovery["child_prototypes"] != 29
                                    or recovery["valid_children"] != 25
                                    or recovery["invalid_children"] != [12, 14, 19, 21]
                                    or recovery["selected_children"]
                                    != [2, 8, 10, 11, 16, 18, 20, 23, 25, 27]
                                    or verification["repeat_decoder_output_identical"] is not True
                                    or verification["root_lua51_valid"] is not False
                                    or verification["mock_game_cases"] != 45
                                    or any(host in body.lower() for host in
                                           (b"https://", b"httpget(", b"loadstring("))):
                                raise ValueError(f"Incomplete or unsafe partial MoonSec recovery: {name}")
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
                elif report_name in WAD_REPORTS:
                    # Full static WeAreDevs/WAD recoveries: verbatim decoder body,
                    # pinned MIT source, and honest offline evidence per file.
                    source = artifact["source"]
                    evidence = WAD_EVIDENCE.get(name)
                    if evidence is None:
                        raise ValueError(f"Unregistered WAD result: {name}")
                    if (status != "deobfuscated"
                            or source["license"] != "MIT"
                            or len(source["commit"]) != 40
                            or source["commit"] not in source["url"]
                            or not source["url"].startswith("https://github.com/")
                            or source["sha256"].encode() not in header
                            or source["url"].encode() not in header
                            or artifact["recovery_tool"].encode() not in header
                            or b"DEOBFUSCATED (static recovery)" not in header
                            or b"NOT TESTED IN ROBLOX" not in header
                            or len(body) < 2000
                            or source["sha256"] == artifact["result_body_sha256"]
                            or hashlib.sha256(body).hexdigest() != artifact["result_body_sha256"]
                            or hashlib.sha256(header + separator).hexdigest()
                            != artifact["result_header_sha256"]
                            or not all(marker.encode() in body
                                       for marker in artifact["game_markers"])):
                        raise ValueError(f"Unpinned or non-game-specific WAD recovery: {name}")
                    begin, end = b"MIT LICENSE BEGIN\n", b"MIT LICENSE END\n"
                    if begin not in header or end not in header:
                        raise ValueError(f"Missing complete license in {name}")
                    license_bytes = header.split(begin, 1)[1].split(end, 1)[0]
                    if (b"MIT License" not in license_bytes
                            or hashlib.sha256(license_bytes).hexdigest()
                            != source["license_sha256"]):
                        raise ValueError(f"Altered upstream MIT license in {name}")
                    verification = artifact["verification"]
                    if (verification["tested_in_roblox"] is not False
                            or verification["protected_top_level_executed"] is not False
                            or verification["repeat_decoder_output_identical"] is not True
                            or verification["lua51_syntax"] is not True):
                        raise ValueError(f"Unsupported verification claim: {name}")
                    if (verification["mock_game_assertions"]
                            != evidence["mock_game_assertions"]):
                        raise ValueError(f"Mock evidence changed without update: {name}")
                    if evidence["static_body_assertions"] is None:
                        if "static_body_assertions" in verification:
                            raise ValueError(f"Unexpected static-only claim: {name}")
                    elif (verification.get("static_body_assertions")
                            != evidence["static_body_assertions"]):
                        raise ValueError(f"Static evidence changed without update: {name}")
                    if (not all(token in body for token in evidence["body_contains"])
                            or any(token in body for token in evidence["body_excludes"])):
                        raise ValueError(f"Recovered body no longer matches its report: {name}")
                    if not artifact["limitations"] or not artifact["external_dependencies"]:
                        raise ValueError(f"Missing limits or dependencies for {name}")
                    # A body that was edited after decoding must say so.
                    if b"goto " in body and not artifact["modifications"]:
                        raise ValueError(f"Undocumented decoder repair in {name}")
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
