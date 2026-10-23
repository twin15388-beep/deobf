"""Offline inventory/rights/recovery checks for the 15-game follow-up.

Never executes any published Luau, untrusted input, or downloaded UI.
"""

import hashlib
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from scripts import verify_results


ROOT = Path(__file__).resolve().parents[1]
REPORT = "reports/game-sources-2026-10-21-followup.json"
EXPECTED = {
    "Gakuran - Dep Hub.lua",
    "SCP-3008 - Sealient UI.lua",
    "SCP-3008 - Abyssal Luminx.lua",
    "SCP-3008 - Abyssal Redux.lua",
    "Piggy - Sealient UI.lua",
    "Demonology - Luminx Ghost ESP.lua",
    "Prison Life - Vex Hub.lua",
    "Retail Tycoon 2 - Magma Hub module (src).lua",
    "Super Power Training Simulator - Magma Hub module (src).lua",
    "Prison Life - Magma Hub module (src).lua",
    "Vehicle Simulator - Magma Hub module (src).lua",
    "Magnet Simulator - Magma Hub module (src).lua",
    "Dashing Simulator - Magma Hub module (src).lua",
    "Anime Origins - Ultimate (src).lua",
    "SCP-096 - MaddHub module (src).lua",
}


class FollowupGameResultsTests(unittest.TestCase):
    def setUp(self):
        self.report = json.loads((ROOT / REPORT).read_text(encoding="utf-8"))

    def test_exactly_7_recoveries_and_8_sources_with_distinct_game_code(self):
        artifacts = self.report["artifacts"]
        self.assertEqual({Path(x["published_path"]).name for x in artifacts}, EXPECTED)
        self.assertEqual(len(artifacts), 15)
        self.assertEqual(sum(x["status"] == "deobfuscated" for x in artifacts), 7)
        self.assertEqual(sum(x["status"] == "src" for x in artifacts), 8)
        self.assertEqual(len({x["sha256"] for x in artifacts}), 15)
        self.assertEqual(len(self.report["unresolved"]), 6)
        for item in artifacts:
            with self.subTest(result=item["published_path"]):
                data = (ROOT / item["published_path"]).read_bytes()
                header, separator, body = data.partition(b"]]\n\n")
                self.assertTrue(separator and body)
                self.assertEqual(len(data), item["bytes"])
                self.assertEqual(hashlib.sha256(data).hexdigest(), item["sha256"])
                self.assertEqual(hashlib.sha256(body).hexdigest(), item["result_body_sha256"])
                self.assertEqual(item["status"] == "src", item["published_path"].endswith(" (src).lua"))
                self.assertEqual(item["luau_compiled"], True)
                self.assertIs(item["roblox_tested"], False)
                self.assertEqual(item["source"]["license"], "MIT")
                self.assertEqual(len(item["source"]["commit"]), 40)
                self.assertIn(item["source"]["commit"], item["source"]["url"])
                self.assertIn(item["source"]["sha256"].encode(), header)
                license_text = header.split(b"MIT LICENSE BEGIN\n", 1)[1].split(b"MIT LICENSE END\n", 1)[0]
                self.assertIn(b"MIT License", license_text)
                self.assertEqual(hashlib.sha256(license_text).hexdigest(), item["source"]["license_sha256"])
                self.assertGreater(len(body), 2000)
                self.assertGreaterEqual(len(item["functions"]), 3)
                self.assertTrue(all(f["name"] and f["purpose"] and isinstance(f["parameters"], list)
                                    for f in item["functions"]))
                self.assertTrue(item["limitations"])
                self.assertTrue(all(marker.encode() in body for marker in item["game_markers"]))
                self.assertNotIn(b"pastefy.app", data.lower())
                self.assertNotIn("Steal an Egg", item["game"])
                if item["status"] == "src":
                    self.assertIn(b"NOT DEOBFUSCATED", header)
                    self.assertEqual(item["source"]["bytes"], len(body))
                    self.assertEqual(item["source"]["sha256"], item["result_body_sha256"])
                else:
                    self.assertIn(b"DEOBFUSCATED (static recovery)", header)
                    self.assertNotEqual(item["source"]["sha256"], item["result_body_sha256"])
                    self.assertIn(item["recovery_tool"].encode(), header)

    def test_gakuran_history_wad_and_game_specific_integrations(self):
        gak = next(x for x in self.report["artifacts"] if x["game"] == "Gakuran")
        body = (ROOT / gak["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertEqual(gak["source"]["path"], "gakuranscript.lua")
        self.assertEqual(gak["source"]["commit"], "17bfd85455075a0908dd64c28a09505f2a98db6f")
        self.assertIn('workspace:WaitForChild("Hitboxes", 30)', body)
        self.assertIn('playerGui:FindFirstChild("RhythmServiceUI")', body)
        self.assertIn('FindFirstChild("BasketballShotMeterAttach")', body)
        self.assertNotIn("DEPEMOTES", body)
        self.assertEqual(gak["verification"]["equivalent"], None)

    def test_moonveil_is_not_moonsec_and_proxy_traces_are_not_roblox_tests(self):
        result = next(x for x in self.report["artifacts"] if x["game"] == "Demonology")
        ver = result["verification"]
        self.assertEqual(ver["profile"], "structured")
        self.assertEqual((ver["prototype_count"], ver["instruction_count"]), (41, 2991))
        self.assertEqual((ver["original_event_count"], ver["recovered_event_count"]), (305, 305))
        self.assertIs(ver["equivalent"], True)  # Only sandboxed proxy replay.
        self.assertIs(ver["protected_target_executed"], False)
        self.assertIs(result["roblox_tested"], False)
        self.assertIn("edwindev-spec/MoonVeil@", result["recovery_tool"])
        body = (ROOT / result["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertIn('FindFirstChild("Ghost")', body)
        self.assertIn('FindFirstChild("Items")', body)
        self.assertIn('"SpiritBook"', body)
        self.assertNotIn("MoonSec V3", body)

    def test_runtime_dependencies_and_uncertainties_disclosed(self):
        by_game = {x["game"]: x for x in self.report["artifacts"]}
        self.assertTrue(any("kocogi.lua" in x for x in by_game["Anime Origins"]["limitations"]))
        self.assertTrue(any("UserId" in x for x in by_game["Vehicle Simulator"]["limitations"]))
        self.assertTrue(any("Half-Broken" in x for x in next(
            x for x in self.report["artifacts"] if x["variant"] == "Vex Hub")["limitations"]))
        self.assertTrue(any("loadchar" in x for x in next(
            x for x in self.report["artifacts"] if x["game"] == "Prison Life" and x["status"] == "src")["limitations"]))
        self.assertTrue(any("Abyssal" in x for x in by_game["SCP-3008"]["limitations"]))

    def test_verifier_rejects_relabelled_src_even_if_manifest_and_sha_are_recomputed(self):
        item = next(x for x in self.report["artifacts"] if x["game"] == "Retail Tycoon 2")
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / item["published_path"]
            path.parent.mkdir(parents=True)
            path.write_bytes((ROOT / item["published_path"]).read_bytes())
            report = root / REPORT
            report.parent.mkdir(parents=True)
            altered = json.loads(json.dumps(item))
            altered["status"] = "deobfuscated"
            altered["recovery_tool"] = "invented/engine@" + "0" * 40
            report.write_text(json.dumps({"artifacts": [altered]}), encoding="utf-8")
            with patch.object(verify_results, "ROOT", root), patch.object(verify_results, "REPORTS", (REPORT,)):
                with self.assertRaisesRegex(ValueError, "source label"):
                    verify_results.verify()

    def test_verifier_catches_license_tamper_even_with_updated_file_hash(self):
        item = next(x for x in self.report["artifacts"] if x["game"] == "Gakuran")
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / item["published_path"]
            path.parent.mkdir(parents=True)
            data = (ROOT / item["published_path"]).read_bytes()
            self.assertIn(b"Copyright (c) 2026 DogFireBattle", data)
            tampered = data.replace(b"Copyright (c) 2026 DogFireBattle", b"Copyright (c) 2026 AlteredAuthor")
            path.write_bytes(tampered)
            report = root / REPORT
            report.parent.mkdir(parents=True)
            altered = json.loads(json.dumps(item))
            altered["bytes"] = len(tampered)
            altered["sha256"] = hashlib.sha256(tampered).hexdigest()
            report.write_text(json.dumps({"artifacts": [altered]}), encoding="utf-8")
            with patch.object(verify_results, "ROOT", root), patch.object(verify_results, "REPORTS", (REPORT,)):
                with self.assertRaisesRegex(ValueError, "Altered upstream license"):
                    verify_results.verify()


if __name__ == "__main__":
    unittest.main()
