#!/usr/bin/env python3
"""Offline audit of a decoded Roblox Lua body, before anything is published.

Nothing here executes Lua and nothing touches the network. The checks encode the
rules the catalog already follows, so a decoder run can be screened mechanically
instead of by eye:

* dangling jumps - the pinned WAD decoder can emit `goto LNNN` without the
  matching `::LNNN::` label (root cause: reports/decoder-goto-defect-2026-10-23.md).
  Such output does not compile and must not be published unrepaired;
* paste hosts - a body that loads code from a paste site is not publishable here;
* classification - loader/VM-dump/UI-library bodies are not game recoveries and
  must not be counted as one.

Exit status is 1 when any file fails a hard gate (dangling jump, paste host, or a
body that is not game code), 0 otherwise.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

# Hosts whose content cannot be reviewed from the repository. A body that fetches
# executable code from one of them is rejected, matching the catalog policy that
# kept the recovered "Fling Things And People" body unpublished.
PASTE_HOSTS = (
    "paste.ee",
    "pastefy.app",
    "pastebin.com",
    "paste.gg",
    "hastebin.com",
    "rentry.co",
    "controlc.com",
    "dpaste.org",
    "ghostbin.com",
)

GOTO = re.compile(r"\bgoto\s+([A-Za-z_][A-Za-z0-9_]*)")
LABEL = re.compile(r"::\s*([A-Za-z_][A-Za-z0-9_]*)\s*::")
URL = re.compile(r"https?://([A-Za-z0-9._-]+)")
WORKSPACE_PATH = re.compile(r"workspace[:.]([A-Za-z_][A-Za-z0-9_]*)")
REMOTE_CALL = re.compile(r":(FireServer|InvokeServer|Fire\w*Server)\s*\(")
GUI_CONSTRUCTOR = re.compile(r'Instance\.?new\(\s*"(Text|Image|Frame|Scrolling|UI|Screen)')
# workspace members that exist in every place and say nothing about the game.
GENERIC_WORKSPACE = {"CurrentCamera", "Terrain", "FindFirstChild", "WaitForChild",
                     "GetChildren", "GetDescendants", "Raycast", "ChildAdded",
                     "DescendantAdded", "Error"}


HEADER_END = "]]\n\n"


def strip_header(text: str) -> str:
    """Drop a leading `--[[ ... ]]` provenance header.

    Published files carry a header that deliberately *names* the removed jump and
    the external URLs, so auditing the whole file would report the documentation
    as a defect. Decoder output has no header and is returned unchanged.
    """
    if text.startswith("--[["):
        _, separator, body = text.partition(HEADER_END)
        if separator:
            return body
    return text


def dangling_gotos(text: str) -> list[tuple[int, str]]:
    """Return (line number, label) for every `goto` whose label is never defined."""
    labels = set(LABEL.findall(text))
    found = []
    for number, line in enumerate(text.splitlines(), start=1):
        for label in GOTO.findall(line):
            if label not in labels:
                found.append((number, label))
    return found


def paste_hosts(text: str) -> set[str]:
    lowered = text.lower()
    return {host for host in PASTE_HOSTS if host in lowered}


def external_hosts(text: str) -> set[str]:
    return {host.lower() for host in URL.findall(text)}


def game_signals(text: str) -> dict[str, object]:
    workspace = {name for name in WORKSPACE_PATH.findall(text)
                 if name not in GENERIC_WORKSPACE}
    return {
        "remote_calls": len(REMOTE_CALL.findall(text)),
        "workspace_paths": sorted(workspace),
        "workspace_path_count": len(workspace),
        "gui_constructors": len(GUI_CONSTRUCTOR.findall(text)),
        "getservice_count": text.count("GetService("),
        "loadstring_count": text.count("loadstring("),
        "httpget_count": text.count("HttpGet("),
        "digit_ratio": round(sum(ch.isdigit() for ch in text) / max(len(text), 1), 4),
        # Same convention as the manifests: a trailing newline ends a line.
        "lines": text.count("\n") + (0 if text.endswith("\n") else 1),
    }


def classify(text: str) -> str:
    """Best-effort label for a decoded body: is it game code at all?"""
    signals = game_signals(text)
    if signals["digit_ratio"] > 0.45:
        return "vm_dump"
    if signals["remote_calls"] > 0 or signals["workspace_path_count"] >= 3:
        return "game_code"
    if signals["loadstring_count"] > 0 or signals["httpget_count"] > 0:
        return "loader_only"
    if signals["gui_constructors"] >= 10:
        return "ui_library"
    return "unclassified"


def audit(text: str) -> dict[str, object]:
    """Full report plus the hard publish gates. The header is not audited."""
    text = strip_header(text)
    signals = game_signals(text)
    kind = classify(text)
    dangling = dangling_gotos(text)
    paste = sorted(paste_hosts(text))
    blockers = []
    if dangling:
        blockers.append(f"{len(dangling)} dangling goto(s): "
                        + ", ".join(f"line {n} -> {label}" for n, label in dangling[:5]))
    if paste:
        blockers.append("paste host(s) in body: " + ", ".join(paste))
    if kind != "game_code":
        blockers.append(f"body classifies as {kind}, not game_code")
    return {
        "classification": kind,
        "signals": signals,
        "dangling_gotos": dangling,
        "paste_hosts": paste,
        "external_hosts": sorted(external_hosts(text)),
        "blockers": blockers,
        "publishable": not blockers,
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("files", nargs="+", type=Path)
    parser.add_argument("--json", action="store_true", help="print machine-readable reports")
    options = parser.parse_args(argv)

    failures = 0
    reports = {}
    for path in options.files:
        text = path.read_bytes().decode("utf-8", errors="replace")
        report = audit(text)
        reports[str(path)] = report
        if not report["publishable"]:
            failures += 1
        if not options.json:
            print(f"{'OK  ' if report['publishable'] else 'FAIL'} {path}"
                  f"  {report['classification']}"
                  f"  remotes={report['signals']['remote_calls']}"
                  f"  workspace={report['signals']['workspace_path_count']}"
                  f"  lines={report['signals']['lines']}")
            for blocker in report["blockers"]:
                print(f"     - {blocker}")
    if options.json:
        print(json.dumps(reports, indent=2, ensure_ascii=False))
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
