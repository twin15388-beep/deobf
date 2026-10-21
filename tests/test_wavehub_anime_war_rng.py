"""Offline tests for the pinned WaveHub static string decoder."""

import base64
import hashlib
from pathlib import Path
import unittest

from scripts.decode_wavehub_anime_war_rng import (
    COUNT, HEADER, INPUT_SHA256, decode_source, decode_value, quote_lua,
)


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "dobf scripts 1.0" / "Anime War RNG - WaveHub.lua"
STANDARD = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"


class WaveHubDecoderTests(unittest.TestCase):
    def test_byte_exact_luau_string_escaping(self):
        self.assertEqual(quote_lua(b'hi\\"\x00\xff\n8'), '"hi\\\\\\"\\000\\255\\n8"')
        self.assertEqual(quote_lua(b'\t\r123'), '"\\t\\r123"')

    def test_custom_alphabet_and_cipher_with_binary_data(self):
        alphabet = STANDARD[::-1]
        for index, key, plaintext in [(1, 0, b''), (7, 23, b'\x00a\n\xf0'),
                                      (COUNT, 255, b'utf8: \xe2\x80\xa2')]:
            ciphertext = bytes(
                (value + key + pos * 31 + (index * 17) % 251 + (pos * pos) % 127) % 256
                for pos, value in enumerate(plaintext, 1)
            )
            encoded = base64.b64encode(ciphertext).decode().rstrip('=').translate(
                str.maketrans(STANDARD, alphabet))
            self.assertEqual(decode_value(index, encoded, key, alphabet), plaintext)

    def test_refuses_bad_input_and_symbols(self):
        with self.assertRaisesRegex(ValueError, 'SHA-256'):
            decode_source(b'return loadstring("not the pinned source")()')
        with self.assertRaisesRegex(ValueError, 'symbol'):
            decode_value(1, '!aaa', 0, STANDARD)
        with self.assertRaises(ValueError):
            decode_value(1, 'a', 0, STANDARD)

    def test_published_output_is_actual_game_module_not_loader_only(self):
        body = OUTPUT.read_text(encoding='utf-8')
        self.assertIn(HEADER, body)
        self.assertIn(INPUT_SHA256, body)
        self.assertIn('local function BuildAnimeWarRNG(WaveHub)', body)
        self.assertIn('local function processInventorySync(payload)', body)
        self.assertIn('fire("RequestTraitReroll", {Guid = job.Guid})', body)
        self.assertIn('fire("RequestStatReroll", {Guid = job.Guid, Mode = job.Mode', body)
        self.assertIn('game.HttpGet', body)  # external WindUI remains an unexamined dependency
        for hidden in ('_MmmjvvlZHicC(', '_JBmfmFsdXbcx', '_vnIGVltJgej'):
            self.assertNotIn(hidden, body)
        # The manifest pins the exact published bytes; no input/source fixture is required.
        self.assertEqual(hashlib.sha256(body.encode()).hexdigest(), OUTPUT_SHA256)


OUTPUT_SHA256 = '92354aa770eaf8ff8a9c6db397b0af280b415ab22667af6bb2f3f98b11af3b96'


if __name__ == '__main__':
    unittest.main()
