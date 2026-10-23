"""A synthetic serializer fixture: no protected game code is checked in."""

import unittest

from scripts.inspect_ib2_fork_constants import (
    UnsupportedVM, VMReader, inspect, lzw_base36,
)


DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"


def base36(n):
    value = ""
    while n:
        value = DIGITS[n % 36] + value
        n //= 36
    return value or "0"


def token(n):
    digits = base36(n)
    return (base36(len(digits)) + digits).encode()


def encode_vm_byte(value):
    return bytes((value ^ 193,))


def encode_uint32(value):
    return b"".join(encode_vm_byte((value >> 8 * index) & 0xFF)
                    for index in range(4))


def encode_string(value):
    return encode_uint32(len(value)) + b"".join(encode_vm_byte(v) for v in value)


def proto(children=(), constants=(), instructions=0):
    body = encode_uint32(len(children)) + b"".join(children) + encode_vm_byte(0)
    body += encode_uint32(len(constants))
    for tag, value in constants:
        body += encode_vm_byte(tag)
        if tag == 1:
            body += encode_string(value)
        elif tag == 0:
            body += encode_vm_byte(value)
        elif tag == 2:
            body += b"".join(encode_vm_byte(i) for i in range(8))
    return body + encode_uint32(instructions) + b"\x00" * (instructions * 8)


def synth_source(serialized):
    # Input every byte as a literal dictionary code. This exercises LZW
    # expansion and parsing, with no real VM interpreter or Roblox API.
    code = b"".join(token(byte) for byte in serialized)
    return (b"--[[uwubfuscator ~~ custom vm ~~ ib2 fork]]\n"
            b"local r=F('" + code + b"')\n"
            b"-- l(a(r,o,o),193)\n-- return X(S(),{},E())()")


class IB2ForkTests(unittest.TestCase):
    def test_lzw_regular_and_special_next_code(self):
        self.assertEqual(lzw_base36(token(65) + token(66) + token(67)), b"ABC")
        self.assertEqual(lzw_base36(token(65) + token(256)), b"AAA")

    def test_recursive_children_constants_and_markers(self):
        child = proto(constants=((1, b"workspace"), (0, 1)), instructions=2)
        serialized = proto(children=(child,), constants=(
            (1, b"swimhub"), (1, b"lonesurvival"), (2, None), (3, None),
        ), instructions=3)
        result = inspect(synth_source(serialized))
        self.assertEqual(result["vm_bytes"], len(serialized))
        self.assertEqual(result["prototypes"], 2)
        self.assertEqual(result["instructions"], 5)
        self.assertEqual(result["constants"], 6)
        self.assertEqual(result["string_constants"], 3)
        self.assertEqual(result["marker_string_counts"]["workspace"], 1)
        self.assertEqual(result["marker_string_counts"]["lonesurvival"], 1)
        self.assertEqual(result["marker_string_counts"]["swimhub"], 1)
        self.assertFalse(result["deobfuscated"])
        self.assertFalse(result["gameplay_verified"])

    def test_refuse_wrong_header_and_bad_stream(self):
        with self.assertRaisesRegex(UnsupportedVM, "header"):
            inspect(b"local r=F('21T')")
        with self.assertRaises(UnsupportedVM):
            lzw_base36(token(256))
        with self.assertRaises(UnsupportedVM):
            lzw_base36(token(65) + token(5000))
        with self.assertRaisesRegex(UnsupportedVM, "truncated"):
            VMReader(encode_uint32(0)[:-1]).read()
        with self.assertRaises(UnsupportedVM):
            inspect(synth_source(proto(instructions=1)[:-2]))


if __name__ == "__main__":
    unittest.main()
