"""Static checks for the 2026-10-21 game-source collection (never run Lua)."""

import contextlib
import hashlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from scripts import verify_results
from scripts.sanitize_aztup_gpo import strip_telemetry


ROOT = Path(__file__).resolve().parents[1]
REPORT = ROOT / "reports/game-sources-2026-10-21.json"
GAME_MARKERS = {
    "Bloxstrike - Hotline UI.lua": ("Counter-Terrorists", "_performRaycast"),
    "Bloxstrike - Memesense (src).lua": ("getTrueSpread", "BloxStrike_GdcScopeCrosshair"),
    "Blade Ball - Nexus Hub.lua": ("13772394625", "ParrySuccess"),
    "Blade Ball - Nightmare Hub (src).lua": ("ParryButtonPress", '"Balls"'),
    "Forsaken - Forsaken Plus (src).lua": ("AutoGeneratorPuzzle", '"PuzzleUI"'),
    "Forsaken - Emotes GUI (src).lua": ('"Emotes"', "AssetID"),
    "Blue Lock Rivals - Denzel Dribble (src).lua": ("BallService.RE.Dribble", '"Football"'),
    "Tower Defense X - TDX Autofarm (src).lua": ("TowerUpgradeRequest", "DifficultyVoteReady"),
    "Vesteria - Cheater Soul (src).lua": ("playerRequest_damageEntity", '"abilities"'),
    "Blox Fruits - Ardi Hub (src).lua": ("CommF_", '"SubmergeQuest"'),
    "Swordburst 2 - Magma Hub module (src).lua": ('"Swordburst 2"', '"Equipment"'),
    "Swordburst 2 - Aztup module (src).lua": ("workspace.Mobs", "'Combat'"),
    "Arcane Odyssey - Aztup module (src).lua": ("FishClock", "fishClock:FireServer"),
    "Voxl Blade - Aztup module (src).lua": ("mobAutoFarm", "dungeonAutoFarm"),
    "Adventure Tales - Aztup module (src).lua": ("MeleeAttack", "MassSell"),
}


class GameSourceInventoryTests(unittest.TestCase):
    def test_real_game_code_not_only_names_and_loaders(self):
        report = json.loads(REPORT.read_text(encoding="utf-8"))
        items = report["artifacts"]
        self.assertEqual(len(items), 15)
        self.assertEqual(sum(item["status"] == "src" for item in items), 13)
        self.assertEqual(sum(item["status"] == "deobfuscated" for item in items), 2)
        self.assertEqual(len(report["unresolved"]), 12)
        self.assertEqual(set(GAME_MARKERS), {
            item["published_path"].removeprefix("dobf scripts 1.0/") for item in items
        })
        for item in items:
            name = item["published_path"].removeprefix("dobf scripts 1.0/")
            with self.subTest(name=name):
                text = (ROOT / item["published_path"]).read_text(encoding="utf-8")
                body = text.partition("]]\n\n")[2]
                self.assertTrue(body)
                self.assertGreater(len(body), 3000)
                for marker in GAME_MARKERS[name]:
                    self.assertIn(marker, body)
                self.assertEqual(name.endswith(" (src).lua"), item["status"] == "src")
                self.assertIn(item["source"]["sha256"], text[:1800])
                self.assertIn(item["source"]["commit"], text[:1200])
                self.assertIn("MIT License", text[:1800])
                self.assertGreaterEqual(len(item["functions"]), 2)
                self.assertTrue(all(
                    isinstance(f["parameters"], list) and f["purpose"]
                    for f in item["functions"]
                ))
                self.assertFalse(item["roblox_tested"])
                self.assertTrue(item["limitations"])
                self.assertNotIn("pastefy.app", body.lower())
        hotline = (ROOT / "dobf scripts 1.0/Bloxstrike - Hotline UI.lua").read_text()
        self.assertNotIn("HttpGet(", hotline.partition("]]\n\n")[2])
        self.assertNotIn("loadstring(", hotline.partition("]]\n\n")[2])

    def test_verifier_rejects_src_mislabel_and_restored_telemetry(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            results = root / "dobf scripts 1.0"
            results.mkdir()
            name = "Bloxstrike - Hotline UI.lua"
            output = results / name
            data = "--[[\nMIT License\n]]\n\nlocal team = 'Terrorists'\n"
            output.write_text(data)
            artifact = {
                "published_path": f"dobf scripts 1.0/{name}",
                "status": "deobfuscated",
                "bytes": len(data.encode()),
                "sha256": hashlib.sha256(data.encode()).hexdigest(),
            }
            manifest = root / "reports/game-sources-2026-10-21.json"
            manifest.parent.mkdir()
            manifest.write_text(json.dumps({"artifacts": [artifact]}))
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("reports/game-sources-2026-10-21.json",)
            ), contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(verify_results.verify(), 1)
                artifact["status"] = "src"
                manifest.write_text(json.dumps({"artifacts": [artifact]}))
                with self.assertRaisesRegex(ValueError, "source label"):
                    verify_results.verify()
                artifact["status"] = "deobfuscated"
                data += 'loadstring(game:HttpGet("https://rscripts.net/api/telemetry/client.lua"))()\n'
                output.write_text(data)
                artifact["bytes"] = len(data.encode())
                artifact["sha256"] = hashlib.sha256(data.encode()).hexdigest()
                manifest.write_text(json.dumps({"artifacts": [artifact]}))
                with self.assertRaisesRegex(ValueError, "telemetry loader"):
                    verify_results.verify()


ADDITIONAL_REPORT = ROOT / "reports/game-sources-2026-10-21-additions.json"
EXPECTED_ADDITIONS = {
    "Grand Piece Online - Aztup main (src).lua",
    "Grand Piece Online - Aztup Perfect Block (src).lua",
    "Ro-Ghoul - Aztup module (src).lua",
    "Project Mugetsu - Aztup module (src).lua",
    "Deepwoken - Aztup Race Changer (src).lua",
    "Ride a Pet - 0x5A46 Eggs (src).lua",
    "All Star Tower Defense - KarmaPanda (src).lua",
    "A Universal Time - Hyper Zoro (src).lua",
    "RO-Wizard - Magma Hub module (src).lua",
    "Pet Simulator X - Magma Hub module (src).lua",
    "Bloodlines - Aztup module (src).lua",
    "Doors - Abysall Lobby (src).lua",
    "Doors - Abysall Main (src).lua",
}


class AdditionalGameSourceTests(unittest.TestCase):
    def test_game_specific_source_inventory_and_rights(self):
        report = json.loads(ADDITIONAL_REPORT.read_text(encoding="utf-8"))
        self.assertEqual(len(report["artifacts"]), 13)
        self.assertEqual({Path(a["published_path"]).name for a in report["artifacts"]},
                         EXPECTED_ADDITIONS)
        self.assertEqual([a["source"]["license"] for a in report["artifacts"]].count("MIT"), 10)
        self.assertEqual(sum(a["source"]["license"] == "Apache-2.0"
                             for a in report["artifacts"]), 1)
        for item in report["artifacts"]:
            with self.subTest(game=item["game"], variant=item["variant"]):
                data = (ROOT / item["published_path"]).read_bytes()
                header, separator, body = data.partition(b"]]\n\n")
                self.assertTrue(separator and body)
                self.assertEqual(item["status"], "src")
                self.assertIn(b"NOT DEOBFUSCATED", header)
                self.assertIn(item["source"]["sha256"].encode(), header)
                self.assertEqual(hashlib.sha256(body).hexdigest(), item["source_body_sha256"])
                self.assertEqual(hashlib.sha256(data).hexdigest(), item["sha256"])
                self.assertEqual(len(data), item["bytes"])
                for marker in item["game_markers"]:
                    self.assertIn(marker.encode(), body)
                self.assertGreaterEqual(len(item["functions"]), 3)
                self.assertTrue(all(f["name"] and f["purpose"]
                                    and isinstance(f["parameters"], list)
                                    for f in item["functions"]))
                self.assertTrue(item["limitations"])
                self.assertFalse(item["roblox_tested"])
                self.assertTrue(item["luau_compiled"])
                self.assertNotIn(b"pastefy.app", body.lower())
                self.assertNotIn("Steal an Egg", item["game"])
                if item["source"]["repository"]:
                    self.assertEqual(len(item["source"]["commit"]), 40)
                    self.assertIn(item["source"]["commit"], item["source"]["url"])
                else:
                    self.assertIn("scriptblox.com", item["source"]["card_url"])

    def test_apache_license_and_uncertain_rights_are_not_mislabeled(self):
        report = json.loads(ADDITIONAL_REPORT.read_text(encoding="utf-8"))
        license_path = ROOT / "reports/licenses/0x5A46-Apache-2.0.txt"
        license_text = license_path.read_text(encoding="utf-8")
        self.assertIn("Apache License", license_text)
        self.assertIn("Version 2.0", license_text)
        self.assertGreater(len(license_text), 10000)
        for item in report["artifacts"]:
            if item["source"]["license"] == "Apache-2.0":
                self.assertEqual(hashlib.sha256(license_path.read_bytes()).hexdigest(),
                                 item["source"]["license_sha256"])
            elif item["source"]["license"] != "MIT":
                header = (ROOT / item["published_path"]).read_bytes().partition(b"]]\n\n")[0]
                self.assertIn(b"No standard LICENSE", header)
                self.assertNotIn(b"MIT License", header)

    def test_gpo_outbound_telemetry_removed_but_optional_notifier_and_stub_disclosed(self):
        report = json.loads(ADDITIONAL_REPORT.read_text(encoding="utf-8"))
        item = next(a for a in report["artifacts"] if a["variant"] == "Aztup main")
        body = (ROOT / item["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertNotEqual(item["source"]["sha256"], item["source_body_sha256"])
        for term in ("FireWebhook", "BanWebhook", "usedFeatures", "addUsedFeature(",
                     "prettyPrint(", "rscripts.net/api/telemetry"):
            self.assertNotIn(term, body)
        self.assertIn("Webhook.new(webhookLink)", body)
        self.assertIn("return {await = function() end}", body)
        self.assertTrue(any("ЗАГЛУШКА" in limit for limit in item["limitations"]))
        with self.assertRaisesRegex(ValueError, "SHA-256 mismatch"):
            strip_telemetry(b"not the pinned upstream snapshot")

    def test_dynamic_dependencies_disclosed_without_bundling_loaders(self):
        report = json.loads(ADDITIONAL_REPORT.read_text(encoding="utf-8"))
        items = {a["variant"]: a for a in report["artifacts"]}
        main = items["Abysall Main"]
        body = (ROOT / main["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertIn('Globals.STX = loadstring(game:HttpGet(', body)
        self.assertNotIn("abysall.wispbyte.org", body)
        self.assertTrue(any("автоматически" in limit and "STX" in limit
                            for limit in main["limitations"]))
        karma = items["KarmaPanda"]
        body = (ROOT / karma["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertIn('webhook_url = ""', body)
        self.assertIn("loadstring(game:HttpGet(", body)
        self.assertTrue(any("api.irisapp.ca" in limit for limit in karma["limitations"]))
        aut = items["Hyper Zoro"]
        body = (ROOT / aut["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertIn("Heartbeat", body)
        self.assertIn("PickedUpSword", body)
        self.assertIn("AscendAbility", body)
        bloodlines = next(a for a in report["artifacts"] if a["game"] == "Bloodlines")
        body = (ROOT / bloodlines["published_path"]).read_text().partition("]]\n\n")[2]
        self.assertIn("dataEvent:FireServer('PickUp', obj.ID.Value)", body)
        self.assertIn("string.rep('\\0', 10e6)", body)
        self.assertIn("aztupscripts.xyz", body)
        self.assertTrue(any("dataloss" in limit for limit in bloodlines["limitations"]))

    def test_verifier_catches_added_source_body_tampering_even_with_rehashed_file(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            results = root / "dobf scripts 1.0"
            results.mkdir()
            name = "Specific Game - example (src).lua"
            header = "--[[\nNOT DEOBFUSCATED\nMIT License\nSource SHA-256: " + "0" * 64 + "\n]]\n\n"
            body = "game.ReplicatedStorage.Example:FireServer()\n"
            data = (header + body).encode()
            file = results / name
            file.write_bytes(data)
            artifact = {"published_path": f"dobf scripts 1.0/{name}", "status": "src",
                        "bytes": len(data), "sha256": hashlib.sha256(data).hexdigest(),
                        "source_body_sha256": hashlib.sha256(body.encode()).hexdigest(),
                        "source": {"sha256": "0" * 64, "license": "MIT"},
                        "game_markers": ["Example:FireServer"]}
            manifest = root / "reports/game-sources-2026-10-21-additions.json"
            manifest.parent.mkdir()
            manifest.write_text(json.dumps({"artifacts": [artifact]}))
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("reports/game-sources-2026-10-21-additions.json",)
            ), contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(verify_results.verify(), 1)
                altered = data + b"-- stealthy injection\n"
                file.write_bytes(altered)
                artifact["sha256"] = hashlib.sha256(altered).hexdigest()
                artifact["bytes"] = len(altered)
                manifest.write_text(json.dumps({"artifacts": [artifact]}))
                with self.assertRaisesRegex(ValueError, "Altered source body"):
                    verify_results.verify()
