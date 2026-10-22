"""The test uses synthetic evaluator text; no protected input is executed."""

import hashlib
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from scripts import prepare_moonsec_safe_eval as safe


class SafeMoonsecEvalTest(unittest.TestCase):
    def setUp(self):
        self.original = ("'use strict';\n"
                         + safe.OPEN_LIBRARIES + "\n"
                         + "    try {\n" + safe.KEY_EXPRESSION + "\n    }\n")

    def test_patch_removes_libraries_and_guards_expression(self):
        result = safe.patch_text(self.original)
        self.assertNotIn(safe.OPEN_LIBRARIES, result)
        self.assertNotIn(safe.KEY_EXPRESSION, result)
        self.assertIn("unsafe MoonSec key expression rejected", result)
        self.assertIn("expression.length > 4096", result)
        self.assertIn("!/^_[0-9]+$/.test(id)", result)
        self.assertIn("const code = `return (${expression})`", result)

    def test_unknown_or_already_patched_source_fails_closed(self):
        for text in (self.original + safe.OPEN_LIBRARIES,
                     self.original + safe.KEY_EXPRESSION,
                     safe.patch_text(self.original)):
            with self.subTest(text=text[-30:]), self.assertRaises(ValueError):
                safe.patch_text(text)

    def test_pinned_commit_hashes_and_idempotence(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            path = root / safe.EVALUATOR_PATH
            path.parent.mkdir(parents=True)
            path.write_text(self.original)
            orig_sha = hashlib.sha256(path.read_bytes()).hexdigest()
            new_sha = hashlib.sha256(safe.patch_text(self.original).encode()).hexdigest()
            completed = type("GitResult", (), {"stdout": safe.PINNED_COMMIT + "\n"})()
            with (patch.object(safe, "ORIGINAL_SHA256", orig_sha),
                  patch.object(safe, "PATCHED_SHA256", new_sha),
                  patch.object(safe.subprocess, "run", return_value=completed)):
                self.assertIn("hardened", safe.apply(root))
                self.assertEqual(path.read_bytes(), safe.patch_text(self.original).encode())
                self.assertEqual(safe.apply(root), "already hardened")
                path.write_bytes(b"unrecognized code")
                with self.assertRaisesRegex(ValueError, "differs from pinned"):
                    safe.apply(root)
                self.assertEqual(path.read_bytes(), b"unrecognized code")
                path.unlink()
                path.symlink_to(root / "outside.js")
                with self.assertRaisesRegex(ValueError, "regular evaluator"):
                    safe.apply(root)

    def test_wrong_checkout_refused_before_reading_file(self):
        with tempfile.TemporaryDirectory() as tmp:
            completed = type("GitResult", (), {"stdout": "1" * 40})()
            with patch.object(safe.subprocess, "run", return_value=completed):
                with self.assertRaisesRegex(ValueError, "commit differs"):
                    safe.apply(Path(tmp))


if __name__ == "__main__":
    unittest.main()
