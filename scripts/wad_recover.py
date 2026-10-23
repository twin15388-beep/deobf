#!/usr/bin/env python3
"""Repeatable, offline recovery pipeline for one protected WeAreDevs/WAD input.

This automates the steps that were previously done by hand for every published
recovery, so the same evidence is produced every time:

1. `extract_input`  - take the input out of a *pinned* local clone with `git show`
2. `require_license` - refuse a pinned commit that has no LICENSE (a game sample
   without redistribution rights is studied locally, never published)
3. `decode`          - run the pinned decoder twice and require byte-identical
   output, which is the reproducibility claim every report makes
4. `audit`           - screen the body with scripts/check_decoder_output.py
   (dangling jumps, paste hosts, loader/VM-dump/UI bodies that are not game code)
5. `draft_artifact`  - emit a manifest fragment with the real hashes filled in and
   the fields a human must still write (functions, limitations) left empty

It never executes the protected Lua (the pinned decoder statically interprets the
obfuscator VM; its Lua os/io/debug are JS stubs), never touches the network, and
never writes into `dobf scripts 1.0/` - publishing stays a reviewed manual step.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:  # allow `python3 scripts/wad_recover.py`
    sys.path.insert(0, str(ROOT))

from scripts.check_decoder_output import audit  # noqa: E402
CATALOG = "dobf scripts 1.0"
DEFAULT_TOOL = "local-results/pdeobf-pinned/prostone4--Prometheus-Deobfuscator-6ee3291ec83f"
NODE_MEMORY = "--max-old-space-size=6144"


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def _git(repo: Path, *args: str) -> bytes:
    completed = subprocess.run(["git", "-C", str(repo), *args],
                               capture_output=True, check=False)
    if completed.returncode != 0:
        raise ValueError(f"git {' '.join(args)} failed: "
                         f"{completed.stderr.decode(errors='replace').strip()}")
    return completed.stdout


def extract_input(repo: Path, commit: str, path: str, destination: Path) -> dict:
    """Copy one file out of a pinned commit and record its hashes."""
    if len(commit) != 40:
        raise ValueError("commit must be a full 40-character SHA-1")
    data = _git(repo, "show", f"{commit}:{path}")
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_bytes(data)
    return {"path": path, "commit": commit, "bytes": len(data), "sha256": sha256(data),
            "local": str(destination)}


def require_license(repo: Path, commit: str, name: str = "LICENSE") -> dict:
    """Return the license bytes of the pinned commit, or refuse."""
    data = _git(repo, "show", f"{commit}:{name}")
    if len(data.strip()) < 100:
        raise ValueError(f"{name} at {commit[:12]} is too short to be a license")
    return {"license_path": name, "license_bytes": len(data), "license_sha256": sha256(data)}


def decode(input_path: Path, output_path: Path, tool_dir: Path, runs: int = 2,
           force: bool = True) -> dict:
    """Decode `runs` times and require byte-identical output."""
    if runs < 2:
        raise ValueError("at least two runs are needed to claim reproducibility")
    output_path.parent.mkdir(parents=True, exist_ok=True)
    digests = []
    for index in range(runs):
        target = output_path.with_suffix(f".run{index}{output_path.suffix}")
        command = ["node", NODE_MEMORY, str(tool_dir / "bin" / "pdeobf.js"), str(input_path)]
        if force:
            command.append("--force")
        command += ["-o", str(target)]
        completed = subprocess.run(command, capture_output=True, text=True, check=False)
        if completed.returncode != 0 or not target.is_file():
            raise ValueError(f"decoder run {index} failed: "
                             f"{(completed.stderr or completed.stdout)[-400:]}")
        digests.append(sha256(target.read_bytes()))
    deterministic = len(set(digests)) == 1
    output_path.write_bytes(output_path.with_suffix(f".run0{output_path.suffix}").read_bytes())
    body = output_path.read_bytes()
    return {"decoder_runs": runs, "deterministic": deterministic, "run_sha256": digests,
            "result_body_sha256": sha256(body), "result_bytes": len(body),
            "result_lines": body.count(b"\n") + (0 if body.endswith(b"\n") else 1)}


def apply_repair(script: Path, text: str) -> str:
    """Apply one checked-in, exact-match repair script to the decoded body.

    The repair module must expose `repair(text) -> text` and must raise on any
    layout it has not audited (see scripts/repair_*_goto.py). Repairs are never
    invented here: this only runs a reviewed script and records what it changed.
    """
    import importlib.util

    spec = importlib.util.spec_from_file_location(script.stem, script)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    if not callable(getattr(module, "repair", None)):
        raise ValueError(f"{script} does not expose repair(text)")
    return module.repair(text)


def assert_not_catalog(destination: Path) -> None:
    """Publishing is a reviewed manual step; the pipeline must not do it."""
    resolved = (destination if destination.is_absolute() else ROOT / destination).resolve()
    if CATALOG in resolved.parts:
        raise ValueError(f"refusing to write into the catalog: {resolved}")


def draft_artifact(name: str, game: str, variant: str, source: dict, body: dict,
                   license_info: dict, static_assertions: int | None = None) -> dict:
    """Manifest fragment with real hashes and empty human-written fields."""
    verification = {
        "lua51_syntax": False,
        "lua51_method": ("scripts/prepare_lua51.py (lua/lua tag v5.1.1), loadfile "
                         "compile-only - set true after the check passed"),
        "repeat_decoder_output_identical": body["deterministic"],
        "protected_top_level_executed": False,
        "tested_in_roblox": False,
        "mock_game_assertions": 0,
    }
    if static_assertions:
        verification["static_body_assertions"] = static_assertions
    return {
        "published_path": f"{CATALOG}/{name}",
        "game": game,
        "variant": variant,
        "status": "deobfuscated",
        "mode": "static WeAreDevs/WAD decode: entire tool output plus provenance header",
        "bytes": 0,
        "sha256": "",
        "result_header_sha256": "",
        "result_body_sha256": body["result_body_sha256"],
        "body_lines": body["result_lines"],
        "recovery_tool": "prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a",
        "source": source | license_info,
        "game_markers": [],
        "functions": [],
        "limitations": ["TODO: honest limits, written after reading the recovered body"],
        "external_dependencies": ["TODO: every host the body can reach"],
        "modifications": [],
        "verification": verification,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--repo", required=True, type=Path)
    parser.add_argument("--commit", required=True)
    parser.add_argument("--path", required=True)
    parser.add_argument("--game", required=True)
    parser.add_argument("--variant", default="")
    parser.add_argument("--name", default="", help="published file name (not written)")
    parser.add_argument("--out-dir", default=Path("local-results/wad-out"), type=Path)
    parser.add_argument("--inputs-dir", default=Path("local-results/inputs"), type=Path)
    parser.add_argument("--tool-dir", default=Path(DEFAULT_TOOL), type=Path)
    parser.add_argument("--runs", type=int, default=2)
    parser.add_argument("--repair", type=Path, default=None,
                        help="checked-in repair script exposing repair(text)")
    parser.add_argument("--draft", type=Path, default=None, help="write manifest fragment")
    options = parser.parse_args(argv)

    assert_not_catalog(options.out_dir)
    assert_not_catalog(options.inputs_dir)

    stem = Path(options.path).stem or "input"
    input_path = options.inputs_dir / f"{stem}.lua"
    source = extract_input(options.repo, options.commit, options.path, input_path)
    print(f"input   {source['bytes']} bytes sha256 {source['sha256']}")

    license_info = require_license(options.repo, options.commit)
    print(f"license {license_info['license_path']} sha256 {license_info['license_sha256']}")

    output_path = options.out_dir / f"{stem}.decoded.lua"
    body = decode(input_path, output_path, options.tool_dir, runs=options.runs)
    print(f"decoded {body['result_bytes']} bytes / {body['result_lines']} lines "
          f"deterministic={body['deterministic']} sha256 {body['result_body_sha256']}")

    modifications = []
    if options.repair:
        raw_copy = output_path.with_suffix(".raw.lua")
        raw_copy.write_bytes(output_path.read_bytes())
        raw_text = raw_copy.read_bytes().decode("utf-8")
        repaired = apply_repair(options.repair, raw_text)
        output_path.write_bytes(repaired.encode("utf-8"))
        modifications.append(f"{options.repair.name}: {len(raw_text) - len(repaired)} bytes "
                             f"removed, raw kept at {raw_copy}")
        print(f"repair  {modifications[-1]}")

    report = audit(output_path.read_bytes().decode("utf-8", errors="replace"))
    print(f"audit   {report['classification']} publishable={report['publishable']}")
    for blocker in report["blockers"]:
        print(f"     - {blocker}")
    for host in report["external_hosts"]:
        print(f"     host {host}")

    if not body["deterministic"]:
        print("decoder output is not reproducible; do not publish", file=sys.stderr)
        return 1
    if not report["publishable"]:
        print("audit blocked publication; fix or record a negative result", file=sys.stderr)
        return 1

    draft = draft_artifact(options.name or f"{options.game} - {options.variant or stem}.lua",
                           options.game, options.variant, source, body, license_info)
    if modifications:
        draft["modifications"] = modifications
        body_text = output_path.read_bytes()
        draft["result_body_sha256"] = sha256(body_text)
        draft["body_lines"] = body_text.count(b"\n") + (0 if body_text.endswith(b"\n") else 1)
        draft["limitations"].append(
            "The decoder output needed a checked-in repair; see modifications.")
    print(json.dumps(draft, indent=2, ensure_ascii=False))
    if options.draft:
        assert_not_catalog(options.draft)
        options.draft.parent.mkdir(parents=True, exist_ok=True)
        options.draft.write_text(json.dumps(draft, indent=2, ensure_ascii=False) + "\n",
                                 encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
