"""Offline guards for the pinned, sanitized Aztup Deepwoken (src) module."""

import hashlib
from pathlib import Path
import unittest

from scripts.sanitize_aztup_deepwoken import (
    HEADER, LICENSE, SOURCE_SHA256, drop_between, replace_once, sanitize,
)

ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / 'dobf scripts 1.0' / 'Deepwoken - Aztup main (src).lua'
EXPECTED_SHA256 = '969da5328b0211fa1067ad6964603566aed208ae8d47012accfe642b34745ea5'


class DeepwokenSourceTests(unittest.TestCase):
    def test_rejects_wrong_source_and_unexpected_edits(self):
        with self.assertRaisesRegex(ValueError, 'SHA-256'):
            sanitize(b'-- This source is not the pinned MIT file')
        with self.assertRaisesRegex(ValueError, 'exactly one'):
            replace_once('a\na\n', 'a', 'b')
        with self.assertRaisesRegex(ValueError, 'missing'):
            drop_between('start data end', 'start', 'end', '', ('POST',))

    def test_file_is_labeled_source_and_game_handlers_remain(self):
        body = OUTPUT.read_text(encoding='utf-8')
        self.assertTrue(body.startswith(HEADER))
        self.assertIn(f'Input SHA-256: {SOURCE_SHA256}', HEADER)
        self.assertIn('MIT LICENSE BEGIN\n' + LICENSE + 'MIT LICENSE END', HEADER)
        self.assertIn('function functions.autoParry(toggle)', body)
        self.assertIn('function functions.autoLoot(toggle)', body)
        self.assertIn('function functions.oresFarm(toggle)', body)
        self.assertIn('function functions.fishFarm(toggle)', body)
        self.assertIn("local moderatorIdsRequest = syn.request({", body)
        self.assertIn('Webhook.new(library.flags.oresFarmWebhookNotifier)', body)
        self.assertNotIn("Method = 'POST'", body)
        self.assertNotIn("Url = ''", body)
        self.assertNotIn('misc/submit-parry-timing', body)
        self.assertNotIn('task.spawn(syn.request', body)
        self.assertEqual(hashlib.sha256(body.encode()).hexdigest(), EXPECTED_SHA256)


if __name__ == '__main__':
    unittest.main()
