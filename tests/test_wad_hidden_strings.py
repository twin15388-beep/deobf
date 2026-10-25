"""Checks for the independent WAD v1.0.0 hidden-string decoder."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.wad_hidden_strings import KNOWN, decode, lua_bytes, rewrite  # noqa: E402


class KnownPairsTest(unittest.TestCase):
    def test_pairs_match_the_pinned_deobfuscator(self) -> None:
        for cipher, key, expected in KNOWN:
            with self.subTest(key=key):
                self.assertEqual(decode(lua_bytes(cipher), key), expected)

    def test_key_only_seeds_the_stream(self) -> None:
        # the same key with a different cipher must not reuse plaintext
        first = decode(lua_bytes(r"\177I\4"), 10104580887137)
        second = decode(lua_bytes(r"\177I\5"), 10104580887137)
        self.assertNotEqual(first, second)


class LuaStringTest(unittest.TestCase):
    def test_decimal_and_named_escapes(self) -> None:
        self.assertEqual(lua_bytes(r"\190\18A"), bytes([190, 18, 65]))
        self.assertEqual(lua_bytes(r"a\nb"), b"a\nb")
        self.assertEqual(lua_bytes(r"\\"), b"\\")

    def test_rewrite_replaces_lookups(self) -> None:
        source = 'local x = u40[(u41("\\177I\\4", 10104580887137))]\n'
        rewritten, count = rewrite(source)
        self.assertEqual(count, 1)
        self.assertEqual(rewritten, 'local x = "ESP"\n')

    def test_rewrite_is_idempotent_on_plain_text(self) -> None:
        rewritten, count = rewrite('print("ESP")\n')
        self.assertEqual((rewritten, count), ('print("ESP")\n', 0))


if __name__ == "__main__":
    unittest.main()
