"""Synthetic offline tests: no protected third-party body is bundled or run."""

import contextlib
import io
import json
import lzma
import tempfile
import unittest
from pathlib import Path

from scripts.inspect_luraph_envelope import (
    FILTERS, MAX_INPUT, MAX_STAGE, ROOT, EnvelopeError,
    export_stages, inspect, main, unpack_blob,
)


def envelope(payload: bytes) -> bytes:
    packed = lzma.compress(payload, format=lzma.FORMAT_RAW, filters=FILTERS)
    packed += b"\x00" * (-len(packed) % 4)  # LPH stores 32-bit words.
    out = bytearray(b"LPH0")
    for offset in range(0, len(packed), 4):
        value = int.from_bytes(packed[offset:offset + 4], "big")
        digits = bytearray(5)
        for index in range(4, -1, -1):
            value, digit = divmod(value, 85)
            digits[index] = digit + 33
        out.extend(digits)
    return bytes(out)


def make_file(first: bytes, second: bytes) -> bytes:
    prefix = (b'local sdk = loadstring(game:HttpGet("'
              b'https://jnkie.com/sdk/library.lua?key=DO_NOT_ECHO"))()\n')
    return (prefix + b'-- This file was protected using Luraph Obfuscator v14.6 '
            b'[https://lura.ph/]\nreturn(function()\n'
            b'local vm = [==[' + envelope(first) + b']==]\n'
            b'local blob = [=[' + envelope(second) + b']=]\nend)()\n')


class LuraphEnvelopeTests(unittest.TestCase):
    def test_two_stages_are_unwrapped_not_decompiled(self):
        vm = b"local interpreter = 42\n"
        bytecode = b"\x00\xff\x01custom VM code"
        source = make_file(vm, bytecode)
        report, stages = inspect(source)
        self.assertEqual(stages, (vm, bytecode))
        self.assertGreater(report["clear_prefix_bytes"], 0)
        self.assertEqual([part["kind"] for part in report["stages"]],
                         ["vm_interpreter_candidate", "vm_bytecode_candidate"])
        self.assertTrue(report["envelope_unwrapped"])
        self.assertFalse(report["vm_decompiled"])
        self.assertFalse(report["game_source_recovered"])
        self.assertNotIn("DO_NOT_ECHO", json.dumps(report))
        with tempfile.TemporaryDirectory() as temp:
            path = Path(temp) / "private.lua"
            path.write_bytes(source)
            output = Path(temp) / "stages"
            with contextlib.redirect_stdout(io.StringIO()) as buffer:
                self.assertEqual(main([str(path), "--out-dir", str(output)]), 0)
            self.assertTrue(json.loads(buffer.getvalue())["stages_exported"])
            self.assertEqual((output / "stage1-vm-interpreter.lua").read_bytes(), vm)
            self.assertEqual((output / "stage2-custom-bytecode.bin").read_bytes(), bytecode)
            with self.assertRaises(EnvelopeError):
                export_stages(output, stages)  # exclusive, never overwrite
        with self.assertRaises(EnvelopeError):
            export_stages(ROOT / "scripts" / "Untrusted", stages)
        self.assertFalse((ROOT / "scripts" / "Untrusted").exists())

    def test_malformed_inputs_and_bounded_decompression(self):
        with self.assertRaises(EnvelopeError):
            inspect(b"X" * (MAX_INPUT + 1))
        with self.assertRaises(EnvelopeError):
            inspect(b"-- Luraph Obfuscator v14.6\n")
        with self.assertRaises(EnvelopeError):
            inspect(make_file(b"good", b"other").replace(b"v14.6", b"v14.7"))
        with self.assertRaises(EnvelopeError):
            inspect(make_file(b"good", b"other") + b"local third = [=[LPH0!!!!!]=]")
        with self.assertRaises(EnvelopeError):
            unpack_blob(b"LPH0uuuuu")  # out-of-range 32-bit word
        with self.assertRaises(EnvelopeError):
            unpack_blob(b"LPH0!!!!")  # truncated base85 word
        with self.assertRaises(EnvelopeError):
            unpack_blob(envelope(b"good")[:-1] + b"~")  # not in the base85 alphabet
        with self.assertRaises(EnvelopeError):
            unpack_blob(envelope(b"A" * (MAX_STAGE + 1000)))

    def test_static_only_does_not_run_lua(self):
        with tempfile.TemporaryDirectory() as temp:
            sentinel = Path(temp) / "must_not_exist"
            vm = f"local unused = os.execute('touch {sentinel}')\n".encode()
            report, stages = inspect(make_file(vm, b"not gameplay"))
            self.assertEqual(stages[0], vm)
            self.assertFalse(sentinel.exists())
            self.assertFalse(report["gameplay_verified"])


if __name__ == "__main__":
    unittest.main()
