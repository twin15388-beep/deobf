"""Synthetic static VM fixtures; never execute a protected Roblox script."""

from __future__ import annotations

from dataclasses import replace
import hashlib
import json
import os
from pathlib import Path
import shutil
import struct
import subprocess
import tempfile
import unittest

from scripts.vm_static.decode import DecodeError, Reader, decompress_literal
from scripts.vm_static.lift import (
    GOG, GOG_V3, NERF_MONEY, NERF_TDM, PRIOR, LiftError,
    actions, instruction, lift, lift_proto, read_profile,
)


def base36(number: int) -> str:
    digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    result = ""
    while number:
        number, residue = divmod(number, 36)
        result = digits[residue] + result
    return result or "0"


class StaticVmTests(unittest.TestCase):
    def test_small_base36_lzw_and_xor(self):
        encoded = "".join(base36(len(base36(n))) + base36(n) for n in (65, 23, 90))
        text = "local x=q('" + encoded + "');local after=1"
        self.assertEqual(decompress_literal(text), bytes((65 ^ 23, 0, 90 ^ 23)))
        for bad in ("not a wrapper", "local x=q('00');local after=1",
                    "local x=q('1Z');local after=1"):
            with self.assertRaises(DecodeError):
                decompress_literal(bad)

    def test_minimal_prototype_and_return(self):
        # Zero constants; root (aip); a single [RETURN0, R0] VM instruction.
        blob = (struct.pack("<I", 0) + b"\x00" + struct.pack("<I", 1)
                + b"\x00" + struct.pack("<HHHH", 26, 0, 0, 0)
                + struct.pack("<I", 0))
        reader = Reader(blob, GOG.tags, GOG.layout)
        root = reader.prototype()
        self.assertEqual(reader.offset, len(blob))
        self.assertEqual(root["ins"], [[26, 0, 0, 0]])
        self.assertEqual(lift_proto(root, GOG)[0], [["RETURN", 0, 1, 0]])
        self.assertEqual(instruction(["RETURN", 0, 1, 0]), struct.pack("<I", 30 | 1 << 23))
        with self.assertRaises(DecodeError):
            Reader(blob[:-1], GOG.tags, GOG.layout).prototype()

    def test_branch_polarities_are_not_interchangeable(self):
        # Same operands, different VM predicates.  Regression of the God of
        # Glory StreamingEnabled polarity would flip the Lua EQ A operand.
        proto = {"const": [None, "yes"], "depth": 0,
                 "protos": [], "params": 0,
                 "ins": [[9, 0, 1, "yes"], [26, 0, 0, 0], [26, 0, 0, 0]],
                 "raw": [
                     {"nums": [9, 0, 1, 1], "mask": 4, "layout": 3},
                     {"nums": [26, 0, 0, 0], "mask": 0, "layout": 0},
                     {"nums": [26, 0, 0, 0], "mask": 0, "layout": 0},
                 ]}
        for action, expected in (("EQ_JMPNE", 0), ("EQ_NEJMP", 1)):
            profile = replace(GOG, superops={}, simple={9: action, 26: "RETURN0"})
            result, meanings = lift_proto(proto, profile)
            self.assertEqual(result[0], ["EQ", expected, 0, 256])
            self.assertEqual(meanings[1], action)
        with self.assertRaises(LiftError):
            actions(proto, replace(GOG, superops={}, simple={26: "RETURN0"}))

    def test_refuses_unknown_bytes_and_unmapped_version(self):
        with self.assertRaisesRegex(LiftError, "unknown input SHA-256"):
            read_profile(b"return print('not a pinned VM wrapper')")
        self.assertFalse(GOG_V3.liftable)
        self.assertNotEqual((GOG.tags, GOG.layout), (PRIOR.tags, PRIOR.layout))
        self.assertNotEqual((NERF_MONEY.tags, NERF_MONEY.layout),
                            (NERF_TDM.tags, NERF_TDM.layout))

    def test_pinned_samples_if_supplied_locally(self):
        """Optional full regression: export VM_SAMPLE_DIR (no network/API use)."""
        source_dir = os.getenv("VM_SAMPLE_DIR")
        if not source_dir:
            self.skipTest("set VM_SAMPLE_DIR to locally cloned pinned inputs")
        root = Path(__file__).resolve().parents[1]
        report = json.loads((root / "reports/vm-recovery-2026-10-19.json").read_text())
        records = {case["input"]["path"]: case for case in report["cases"]}
        checker = os.getenv("LUA51_LUAC") or shutil.which("luac5.1")
        for profile in (GOG, PRIOR, NERF_MONEY, NERF_TDM):
            with self.subTest(profile=profile.name):
                content = (Path(source_dir) / profile.name).read_bytes()
                identified, bytecode, statistics = lift(content)
                self.assertEqual(identified.name, profile.name)
                self.assertEqual(statistics["prototypes"], profile.expected_protos)
                self.assertEqual(statistics["vm_instructions"], profile.expected_ins)
                pinned = records[profile.name]["lifted_lua51"]
                self.assertEqual(len(bytecode), pinned["bytes"])
                self.assertEqual(hashlib.sha256(bytecode).hexdigest(), pinned["sha256"])
                if checker:
                    with tempfile.NamedTemporaryFile(suffix=".luac") as output:
                        output.write(bytecode)
                        output.flush()
                        subprocess.run([checker, "-p", output.name], check=True)
        content = (Path(source_dir) / GOG_V3.name).read_bytes()
        self.assertEqual(read_profile(content)[0].name, GOG_V3.name)
        with self.assertRaisesRegex(LiftError, "opcode map is incomplete"):
            lift(content)


if __name__ == "__main__":
    unittest.main()
