"""Small independent fixtures for the published-output manifest verifier."""

import contextlib
import hashlib
import io
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from scripts import verify_results


class PublishedResultVerifierTests(unittest.TestCase):
    def test_size_hash_and_duplicate_detection(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            output = root / "dobf scripts 1.0" / "Sample mode - Synthetic output.lua"
            output.parent.mkdir()
            data = b"-- static synthetic output\n"
            output.write_bytes(data)
            artifact = {
                "path": "dobf scripts 1.0/Sample mode - Synthetic output.lua",
                "bytes": len(data),
                "sha256": hashlib.sha256(data).hexdigest(),
            }
            report = root / "report.json"
            report.write_text(json.dumps({"cases": [{"artifacts": [artifact]}]}))
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("report.json",)
            ), contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(verify_results.verify(), 1)
                output.write_bytes(b"corrupted")
                with self.assertRaisesRegex(ValueError, "mismatch"):
                    verify_results.verify()
                output.write_bytes(data)
                report.write_text(json.dumps({"cases": [{"artifacts": [artifact, artifact]}]}))
                with self.assertRaisesRegex(ValueError, "duplicate"):
                    verify_results.verify()

    def test_unlisted_files_are_not_silently_accepted(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            output = root / "dobf scripts 1.0"
            output.mkdir()
            (root / "report.json").write_text(json.dumps({"cases": []}))
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("report.json",)
            ), contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(verify_results.verify(), 0)
                (output / "stray.bin").write_bytes(b"not Lua")
                with self.assertRaisesRegex(ValueError, "Unlisted"):
                    verify_results.verify()

    def test_historical_removed_files_must_stay_absent(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            old = root / "dobf scripts 1.0" / "Old binary.container.bin"
            old.parent.mkdir()
            old_artifact = {
                "path": "dobf scripts 1.0/Old binary.container.bin",
                "bytes": 4,
                "sha256": hashlib.sha256(b"test").hexdigest(),
            }
            report = root / "report.json"
            report.write_text(json.dumps({"cases": [{
                "artifacts": [], "removed_artifacts": [old_artifact]
            }]}))
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("report.json",)
            ), contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(verify_results.verify(), 0)
                old.write_bytes(b"test")
                with self.assertRaisesRegex(ValueError, "unexpectedly published"):
                    verify_results.verify()
                report.write_text(json.dumps({"cases": [{
                    "artifacts": [old_artifact], "removed_artifacts": [old_artifact]
                }]}))
                with self.assertRaisesRegex(ValueError, "duplicate"):
                    verify_results.verify()

    def test_protected_moonsec_partial_rejects_false_recovery_claims(self):
        """File integrity alone must not bless an invalid root or fake license."""
        source_root = verify_results.ROOT
        report_path = source_root / verify_results.PROTECTED
        item = next(x for x in json.loads(report_path.read_text())["artifacts"]
                    if x["game"] == "Item Factory")
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            target = root / item["published_path"]
            target.parent.mkdir(parents=True)
            target.write_bytes((source_root / item["published_path"]).read_bytes())
            out_report = root / verify_results.PROTECTED
            out_report.parent.mkdir(parents=True)

            def check(current):
                out_report.write_text(json.dumps({"artifacts": [current]}))
                with patch.object(verify_results, "ROOT", root), patch.object(
                    verify_results, "REPORTS", (verify_results.PROTECTED,)
                ), contextlib.redirect_stdout(io.StringIO()):
                    return verify_results.verify()

            self.assertEqual(check(item), 1)
            altered = json.loads(json.dumps(item))
            altered["recovery"]["root_lua51_valid"] = True
            with self.assertRaisesRegex(ValueError, "Incomplete or unsafe"):
                check(altered)
            altered = json.loads(json.dumps(item))
            altered["source"]["license_sha256"] = "0" * 64
            with self.assertRaisesRegex(ValueError, "MIT license"):
                check(altered)
            altered = json.loads(json.dumps(item))
            altered["verification"]["isolated_prototype_mock_cases"] = 28
            with self.assertRaisesRegex(ValueError, "Unlabeled"):
                check(altered)

    def test_full_moonsec_game_requires_real_handlers_and_mpl(self):
        """Rehashing a loader or changing provenance cannot create game source."""
        source_root = verify_results.ROOT
        item = json.loads((source_root / verify_results.MOONSEC_GAME).read_text())[
            "artifacts"][0]
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for name in (item["published_path"], item["source"]["license_path"]):
                destination = root / name
                destination.parent.mkdir(parents=True, exist_ok=True)
                destination.write_bytes((source_root / name).read_bytes())
            manifest = root / verify_results.MOONSEC_GAME
            manifest.parent.mkdir(parents=True, exist_ok=True)

            def check(artifact):
                manifest.write_text(json.dumps({"artifacts": [artifact]}))
                with patch.object(verify_results, "ROOT", root), patch.object(
                    verify_results, "REPORTS", (verify_results.MOONSEC_GAME,)
                ), contextlib.redirect_stdout(io.StringIO()):
                    return verify_results.verify()

            self.assertEqual(check(item), 1)
            modified = json.loads(json.dumps(item))
            modified["verification"]["decoded_root_executed"] = True
            with self.assertRaisesRegex(ValueError, "Incomplete or unlicensed"):
                check(modified)
            modified = json.loads(json.dumps(item))
            modified["source"]["license_sha256"] = "0" * 64
            with self.assertRaisesRegex(ValueError, "Incomplete or unlicensed"):
                check(modified)
            path = root / item["published_path"]
            header, separator, _ = path.read_bytes().partition(b"]]\n\n")
            loader = b"-- only an unrelated UI loader\nloadstring(game:HttpGet('https://example.com'))()\n"
            path.write_bytes(header + separator + loader * 250)
            modified = json.loads(json.dumps(item))
            modified["bytes"] = path.stat().st_size
            modified["sha256"] = hashlib.sha256(path.read_bytes()).hexdigest()
            modified["result_body_sha256"] = hashlib.sha256(loader * 250).hexdigest()
            modified["body_lines"] = (loader * 250).count(b"\n")
            with self.assertRaisesRegex(ValueError, "Incomplete or unlicensed"):
                check(modified)

    def test_rejects_paths_outside_results_directory(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "report.json").write_text(json.dumps({
                "cases": [{"artifacts": [{
                    "path": "../outside.lua", "bytes": 0, "sha256": "0" * 64
                }]}]
            }))
            with patch.object(verify_results, "ROOT", root), patch.object(
                verify_results, "REPORTS", ("report.json",)
            ):
                with self.assertRaisesRegex(ValueError, "Invalid"):
                    verify_results.verify()
