"""Checks for the protection-family triage scanner (scripts/scan_protected_inputs.py)."""

from __future__ import annotations

import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.scan_protected_inputs import classify, scan  # noqa: E402

BANNERS = {
    "wad": b"--[[ v1.0.0 https://wearedevs.net/obfuscator ]] return(function(...) end)",
    "luraph": b"-- This file was protected using Luraph Obfuscator v14.8 [https://lura.ph/]\nreturn({})",
    "mafy": b"-- Protected by Mafy Obfuscator | Public Enemy\nlocal x=1",
    "moonsec_v3": b"([[This file was protected with MoonSec V3]]):gsub('.+', ...)",
    "moonsec_v2": b"_, Protected_by_MoonSecV2, Discord = 'discord.gg/gQEH2uZxUk'\n\n\n,nil,nil;(function()",
    "prometheus": b"-- Protected_by_Prometheus\nreturn 1",
    "ironbrew": b"-- IronBrew2 protected\nreturn 1",
}


class ClassifyTest(unittest.TestCase):
    def test_families_are_recognised(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            for family, banner in BANNERS.items():
                path = Path(tmp) / f"{family}.lua"
                path.write_bytes(banner + b"\n" + b"-- padding\n" * 10)
                found = classify(path)
                self.assertIsNotNone(found, family)
                self.assertEqual(found[0], family)

    def test_luraph_version_is_extracted(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "sample.lua"
            path.write_bytes(BANNERS["luraph"])
            self.assertEqual(classify(path), ("luraph", "14.8"))

    def test_plaintext_is_not_flagged(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            path = Path(tmp) / "plain.lua"
            path.write_bytes(b'local Players = game:GetService("Players")\nprint("hi")\n')
            self.assertIsNone(classify(path))

    def test_missing_file_returns_none(self) -> None:
        self.assertIsNone(classify(Path("/nonexistent/sample.lua")))


class ScanTest(unittest.TestCase):
    def test_scan_filters_by_size_and_extension(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "nested").mkdir()
            (root / "nested" / "big.lua").write_bytes(BANNERS["wad"] + b"x" * 100)
            (root / "nested" / "tiny.lua").write_bytes(b"wearedevs.net/obfuscator")
            (root / "nested" / "notes.bin").write_bytes(BANNERS["wad"] + b"x" * 100)
            rows = scan(root, min_size=50)
            self.assertEqual([Path(row["path"]).name for row in rows], ["big.lua"])
            self.assertEqual(rows[0]["family"], "wad")
            self.assertEqual(len(rows[0]["sha256"]), 64)

    def test_rows_are_sorted_by_size(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "small.lua").write_bytes(BANNERS["mafy"] + b"x" * 10)
            (root / "large.lua").write_bytes(BANNERS["wad"] + b"x" * 500)
            rows = scan(root, min_size=0)
            self.assertEqual([row["size"] for row in rows], [rows[0]["size"], rows[1]["size"]])
            self.assertGreaterEqual(rows[0]["size"], rows[1]["size"])

    def test_cli_json_output(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "a.lua").write_bytes(BANNERS["luraph"] + b"x" * 20)
            out = root / "rows.json"
            result = subprocess.run(
                [sys.executable, str(ROOT / "scripts" / "scan_protected_inputs.py"),
                 str(root), "--min-size", "0", "--json", str(out)],
                capture_output=True, text=True, check=False)
            self.assertEqual(result.returncode, 0, result.stderr)
            rows = json.loads(out.read_text())
            self.assertEqual(len(rows), 1)
            self.assertEqual(rows[0]["family"], "luraph")
            self.assertEqual(rows[0]["version"], "14.8")


if __name__ == "__main__":
    unittest.main()
