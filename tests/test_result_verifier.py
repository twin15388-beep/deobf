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
            output = root / "dobf scripts 1.0" / "Grand Piece Online.partial.lua"
            output.parent.mkdir()
            data = b"-- static synthetic output\n"
            output.write_bytes(data)
            artifact = {
                "path": "dobf scripts 1.0/Grand Piece Online.partial.lua",
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
