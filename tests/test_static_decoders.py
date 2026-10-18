"""Synthetic inputs only: third-party game scripts are not test fixtures."""

from __future__ import annotations

import base64
import lzma
import unittest

from scripts.decode_lua_xor_literals import literal_bytes, lua_quote, replace_literal_calls
from scripts.unpack_luraph13_hex import BANNER, unpack_hex_stream
from scripts.unpack_luraph14_lzma import FILTER, unpack_outer_layer


class XorLiteralTests(unittest.TestCase):
    def test_rotated_key_and_all_literal_calls(self):
        original = b'Players'
        key = bytes([19, 47, 91])
        encrypted = bytes(b ^ key[(i + 1) % len(key)] for i, b in enumerate(original))
        data_arg = '"' + ''.join(f'\\{b:03d}' for b in encrypted) + '"'
        key_arg = '"' + ''.join(f'\\{b:03d}' for b in key) + '"'
        text = f'game:GetService(v7({data_arg},{key_arg}));'
        result, stats = replace_literal_calls(text)
        self.assertEqual(result, 'game:GetService("Players");')
        self.assertEqual(stats, {"replaced": 1, "unique_strings": 1, "nonliteral_calls": 0})

    def test_does_not_change_comments_or_string_literals(self):
        text = (
            '-- v7("\\065","\\001")\n'
            'local example = [[v7("\\065","\\001")]]; '
            'local quoted = "v7(\\"a\\",\\"b\\")"; '
            'return v7(dynamic, "key"), v70("a","b")'
        )
        result, stats = replace_literal_calls(text)
        self.assertEqual(result, text)
        self.assertEqual(stats["replaced"], 0)
        self.assertEqual(stats["nonliteral_calls"], 1)

    def test_binary_literal_and_unsupported_escapes(self):
        for value in [b'abc\x00\xff"\\', b"", bytes(range(256))]:
            quoted = lua_quote(value)
            self.assertEqual(literal_bytes(quoted[1:-1]), value)
        with self.assertRaises(ValueError):
            literal_bytes("\\unknown")
        with self.assertRaises(ValueError):
            literal_bytes("\\256")
        with self.assertRaises(ValueError):
            replace_literal_calls('return v7("a", "")')


class Luraph13HexTests(unittest.TestCase):
    def test_hex_with_runs(self):
        source = (
            BANNER + '\nlocal v,V="LPH~41422H433H00",nil; '
            'v=u(N(v,0X00005),"..",function(Lx) '
            'if H(Lx,ja)==0X000048 then return "" end end)'
        )
        decoded, markers = unpack_hex_stream(source)
        self.assertEqual(decoded, b'ABCC\x00\x00\x00')
        self.assertEqual(markers, 2)
        with self.assertRaises(ValueError):
            unpack_hex_stream(source.replace('3H00', '3H'))
        with self.assertRaises(ValueError):
            unpack_hex_stream(source.replace('2H43', 'AH43'))


class LuraphWrapperTests(unittest.TestCase):
    def test_ascii85_raw_lzma_round_trip(self):
        prefix = b'return({foo=function() return "hello" end})\n' * 100
        # The observed wrapper uses complete 5-character groups (4 input
        # bytes per group). Find a synthetic compressed size with that shape.
        for suffix_length in range(64):
            expected = prefix + bytes(range(suffix_length))
            packed = lzma.compress(expected, format=lzma.FORMAT_RAW, filters=[FILTER])
            if len(packed) % 4 == 0:
                break
        else:
            self.fail('unable to construct an aligned synthetic LZMA stream')
        encoded = base64.a85encode(packed, adobe=False).decode('ascii')
        wrapper = (
            '-- This file was protected using Luraph Obfuscator v14.4.1\n'
            'local M=d([=[LPH~' + encoded + ']=],z)'
        )
        restored, packed_bytes = unpack_outer_layer(wrapper)
        self.assertEqual(restored, expected)
        self.assertEqual(packed_bytes, len(packed))
        with self.assertRaises(ValueError):
            unpack_outer_layer(wrapper, max_output=50)

    def test_one_zero_byte_ascii85_padding(self):
        prefix = b'print("synthetic")\n' * 100
        for suffix_length in range(64):
            expected = prefix + bytes(range(suffix_length))
            packed = lzma.compress(expected, format=lzma.FORMAT_RAW, filters=[FILTER])
            if len(packed) % 4 == 3:
                break
        else:
            self.fail('unable to construct a stream needing one padding byte')
        header = '-- This file was protected using Luraph Obfuscator v14.4.1\n'
        encoded = base64.a85encode(packed + b'\x00', adobe=False).decode('ascii')
        decoded, _ = unpack_outer_layer(header + 'local M=d([=[LPH~' + encoded + ']=],z)')
        self.assertEqual(decoded, expected)
        corrupted = base64.a85encode(packed + b'\x01', adobe=False).decode('ascii')
        with self.assertRaises(ValueError):
            unpack_outer_layer(header + 'local M=d([=[LPH~' + corrupted + ']=],z)')

    def test_rejects_other_versions_and_corrupt_blocks(self):
        with self.assertRaises(ValueError):
            unpack_outer_layer('-- Luraph v15\nlocal M=d([=[LPH~!!!!!]=],z)')
        with self.assertRaises(ValueError):
            unpack_outer_layer('-- This file was protected using Luraph Obfuscator v14.4.1\n'
                               'local M=d([=[LPH~not-ascii85]=],z)')


if __name__ == '__main__':
    unittest.main()
