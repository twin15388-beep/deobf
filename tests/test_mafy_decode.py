"""Checks for the Mafy Obfuscator decoder (scripts/mafy_decode.py)."""

from __future__ import annotations

import sys
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from scripts.mafy_decode import decode, encode, parse  # noqa: E402

SEED = 273369312
KEY_A = [153, 129, 202, 48, 172, 198, 48, 185, 102, 40, 75, 112, 60, 189, 167, 30, 218, 159, 93, 155, 243, 173, 152, 63]
KEY_B = [175, 98, 155, 191, 19, 251, 145, 70, 33, 147, 12, 17, 118, 160, 243, 186, 109, 168, 73, 222, 138, 99, 60, 198]
KEY_C = [82, 222, 36, 149, 215, 81, 191, 132, 172, 151, 251, 234, 132, 104, 35, 164, 65, 137, 81, 10, 137, 146, 218, 17]


class RoundTripTest(unittest.TestCase):
    def test_short_payload(self) -> None:
        source = 'print("hello from mafy")\n'
        self.assertEqual(decode(encode(source, SEED, KEY_A, KEY_B, KEY_C)), source)

    def test_payload_longer_than_the_keys(self) -> None:
        source = "\n".join(f"local value{i} = {i} -- padding line" for i in range(120)) + "\n"
        self.assertEqual(decode(encode(source, SEED, KEY_A, KEY_B, KEY_C)), source)

    def test_odd_length_payload(self) -> None:
        source = "return 1"  # 8 bytes; and 9 bytes below to exercise the odd split
        self.assertEqual(decode(encode(source, SEED, KEY_A, KEY_B, KEY_C)), source)
        self.assertEqual(decode(encode(source + "!", SEED, KEY_A, KEY_B, KEY_C)), source + "!")

    def test_other_keys_still_round_trip(self) -> None:
        source = "local x = 1\n"
        other = ([200, 91, 14, 255, 66, 3, 128, 47, 172, 9, 231, 88],
                 [17, 240, 5, 199, 76, 33, 158, 220, 61, 104, 12, 187],
                 [99, 5, 144, 61, 208, 77, 31, 166, 250, 8, 119, 63])
        self.assertEqual(decode(encode(source, 123456789, *other)), source)


class ParseTest(unittest.TestCase):
    def test_parse_reads_the_generated_structure(self) -> None:
        text = encode("print(1)\n", SEED, KEY_A, KEY_B, KEY_C)
        parts = parse(text)
        self.assertEqual(parts["seed"], SEED)
        self.assertEqual(parts["key_c"], KEY_C)
        self.assertEqual(len(parts["perm_a"]), len(parts["blob_a"]))

    def test_rejects_a_file_without_blobs(self) -> None:
        with self.assertRaises(ValueError):
            parse('-- Protected by Mafy Obfuscator\nlocal x = 1\n')


if __name__ == "__main__":
    unittest.main()
