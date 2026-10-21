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
