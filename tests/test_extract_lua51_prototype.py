"""No real protected bytes are included or executed in this unit test."""

import struct
import unittest

from scripts.extract_lua51_prototype import Reader, extract


HEADER = b"\x1bLua\x51\0\x01\x04\x08\x04\x08\0"
RETURN = struct.pack("<I", 30 | (1 << 23))  # Lua 5.1 RETURN R0, 0 values


def proto(children=(), upvalues=0):
    return (struct.pack("<Q", 5) + b"@src\0" + struct.pack("<II", 0, 0)
            + bytes([upvalues, 0, 0, 2])
            + struct.pack("<I", 1) + RETURN
            + struct.pack("<I", 0)  # constants
            + struct.pack("<I", len(children)) + b"".join(children)
            + struct.pack("<III", 0, 0, 0))  # lineinfo, locals, upvalue names


class ExtractLua51PrototypeTest(unittest.TestCase):
    def test_nested_child_is_detached(self):
        leaf = proto()
        data = HEADER + proto((proto(), proto((leaf,))))
        self.assertEqual(extract(data, "0_1_0"), HEADER + leaf)
        self.assertEqual(extract(data, "0"), data)
        self.assertEqual(len(Reader(data).prototype().children), 2)

    def test_invalid_paths_or_captured_upvalues_rejected(self):
        data = HEADER + proto((proto(upvalues=1),))
        for path in ("1", "0_2", "0_0", "0_x", "0_-1", "0_0_0"):
            with self.subTest(path=path), self.assertRaises(ValueError):
                extract(data, path)

    def test_truncated_or_bad_bytecode_rejected(self):
        data = HEADER + proto()
        for candidate in (data[:-1], data + b"junk", b"not bytecode",
                          data[:7] + b"\x08" + data[8:]):
            with self.subTest(candidate=candidate[:12]), self.assertRaises(ValueError):
                extract(candidate, "0")


if __name__ == "__main__":
    unittest.main()
