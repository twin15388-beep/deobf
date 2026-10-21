"""Checks for the 2026-10-22 WeAreDevs/WAD recoveries (never executes Lua).

The Lua-level evidence lives in tests/test_yba_revenge_hub.lua (mock world) and
tests/test_jjs_sonic_static.lua (static body assertions). When a Lua 5.1
interpreter is available - `LUA51=/path/to/lua5.1` or lua5.1/lua on PATH, e.g.
built by scripts/prepare_lua51.py - those tests are executed here and the
assertion counts they print must match the published manifest. Without an
interpreter the two comparison tests are skipped, not silently passed.
"""

import contextlib
import hashlib
import io
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from scripts import verify_results

ROOT = Path(__file__).resolve().parents[1]
REPORT = ROOT / "reports/game-sources-2026-10-22-wad.json"
LUA_TESTS = {
    "dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua":
        ("tests/test_yba_revenge_hub.lua", "mock_game_assertions"),
    "dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua":
        ("tests/test_jjs_sonic_static.lua", "static_body_assertions"),
}


def lua_binary() -> str | None:
    candidate = os.environ.get("LUA51")
    if candidate:
        path = Path(candidate)
        if path.is_file():
            return str(path)
        return None
    return shutil.which("lua5.1") or shutil.which("lua")


def load_artifacts() -> dict[str, dict]:
    manifest = json.loads(REPORT.read_text(encoding="utf-8"))
    return {artifact["published_path"]: artifact
            for artifact in manifest["artifacts"]}


class WadManifestTests(unittest.TestCase):
    def setUp(self):
        self.artifacts = load_artifacts()
        self.assertEqual(len(self.artifacts), 2)

    def test_pinned_mit_sources_and_verbatim_decoder_bodies(self):
        for name, artifact in self.artifacts.items():
            with self.subTest(name):
                data = (ROOT / name).read_bytes()
                header, separator, body = data.partition(b"]]\n\n")
                self.assertTrue(separator and body)
                source = artifact["source"]
                self.assertEqual(len(source["commit"]), 40)
                self.assertIn(source["commit"], source["url"])
                self.assertTrue(source["url"].startswith("https://github.com/"))
                self.assertIn(source["sha256"].encode(), header)
                self.assertIn(source["url"].encode(), header)
                self.assertEqual(hashlib.sha256(data).hexdigest(), artifact["sha256"])
                self.assertEqual(len(data), artifact["bytes"])
                self.assertEqual(hashlib.sha256(body).hexdigest(),
                                 artifact["result_body_sha256"])
                self.assertEqual(hashlib.sha256(header + separator).hexdigest(),
                                 artifact["result_header_sha256"])
                self.assertEqual(body.count(b"\n")
                                 + (0 if body.endswith(b"\n") else 1),
                                 artifact["body_lines"])
                # Full recoveries: the decoder body is the bulk of the file.
                self.assertGreater(len(body), 30000)
                self.assertNotEqual(source["sha256"], artifact["result_body_sha256"])
                self.assertNotIn(b"pastefy.app", body.lower())
                for marker in artifact["game_markers"]:
                    self.assertIn(marker.encode(), body)

    def test_upstream_mit_license_is_included_unchanged(self):
        for name, artifact in self.artifacts.items():
            with self.subTest(name):
                header = (ROOT / name).read_bytes().partition(b"]]\n\n")[0]
                license_bytes = header.split(b"MIT LICENSE BEGIN\n", 1)[1] \
                                      .split(b"MIT LICENSE END\n", 1)[0]
                self.assertIn(b"MIT License", license_bytes)
                self.assertIn(b"Copyright (c) 2025", license_bytes)
                self.assertEqual(hashlib.sha256(license_bytes).hexdigest(),
                                 artifact["source"]["license_sha256"])

    def test_honest_verification_fields(self):
        for name, artifact in self.artifacts.items():
            with self.subTest(name):
                verification = artifact["verification"]
                self.assertIs(verification["tested_in_roblox"], False)
                self.assertIs(verification["protected_top_level_executed"], False)
                self.assertIs(verification["repeat_decoder_output_identical"], True)
                self.assertIs(verification["lua51_syntax"], True)
                self.assertTrue(artifact["limitations"])
                self.assertTrue(artifact["external_dependencies"])
                self.assertTrue(any("WindUI" in item or "mp3" in item
                                    for item in artifact["external_dependencies"]))

    def test_verifier_rejects_altered_evidence_or_license(self):
        artifacts = load_artifacts()
        name = "dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua"
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "dobf scripts 1.0").mkdir(parents=True)
            published = root / name
            published.write_bytes((ROOT / name).read_bytes())
            report = root / "report.json"

            def write(manifest_artifact):
                report.write_text(json.dumps({"artifacts": [manifest_artifact]}),
                                  encoding="utf-8")

            def run():
                with patch.object(verify_results, "ROOT", root), patch.object(
                    verify_results, "REPORTS", ("report.json",)
                ), patch.object(verify_results, "SOURCE_REPORTS", ("report.json",)), \
                        patch.object(verify_results, "WAD", "report.json"), \
                        contextlib.redirect_stdout(io.StringIO()):
                    return verify_results.verify()

            original = json.loads(json.dumps(artifacts[name]))
            write(original)
            self.assertEqual(run(), 1)

            inflated = json.loads(json.dumps(original))
            inflated["verification"]["mock_game_assertions"] = 999
            write(inflated)
            with self.assertRaisesRegex(ValueError, "Mock evidence"):
                run()

            unlicensed = json.loads(json.dumps(original))
            unlicensed["source"]["license_sha256"] = "0" * 64
            write(unlicensed)
            with self.assertRaisesRegex(ValueError, "Altered upstream MIT license"):
                run()

            republished_source = json.loads(json.dumps(original))
            republished_source["source"]["sha256"] = original["result_body_sha256"]
            write(republished_source)
            with self.assertRaisesRegex(ValueError, "Unpinned or non-game-specific"):
                run()

    def test_verifier_rejects_unregistered_wad_file(self):
        artifacts = load_artifacts()
        name = "dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua"
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "dobf scripts 1.0").mkdir(parents=True)
            (root / name).write_bytes((ROOT / name).read_bytes())
            report = root / "report.json"
            stray = json.loads(json.dumps(artifacts[name]))
            stray["published_path"] = "dobf scripts 1.0/Jujutsu Shenanigans - Other.lua"
            (root / stray["published_path"]).write_bytes((ROOT / name).read_bytes())
            report.write_text(json.dumps({"artifacts": [stray]}), encoding="utf-8")
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("report.json",)
            ), patch.object(verify_results, "SOURCE_REPORTS", ("report.json",)), \
                    patch.object(verify_results, "WAD", "report.json"), \
                    contextlib.redirect_stdout(io.StringIO()):
                with self.assertRaisesRegex(ValueError, "Unregistered WAD result"):
                    verify_results.verify()


@unittest.skipIf(lua_binary() is None,
                 "no Lua 5.1 interpreter; build one with scripts/prepare_lua51.py")
class WadLuaEvidenceTests(unittest.TestCase):
    def test_lua_tests_pass_and_report_manifest_counts(self):
        for name, (test_path, field) in LUA_TESTS.items():
            with self.subTest(name):
                result = subprocess.run(
                    [lua_binary(), str(ROOT / test_path), str(ROOT / name)],
                    capture_output=True, text=True, timeout=300)
                self.assertEqual(result.returncode, 0, result.stderr)
                match = re.search(r"OK .*?: (\d+) ", result.stdout)
                self.assertIsNotNone(match, result.stdout)
                self.assertEqual(int(match.group(1)),
                                 load_artifacts()[name]["verification"][field])


if __name__ == "__main__":
    unittest.main()
