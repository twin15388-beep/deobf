#!/usr/bin/env python3
"""Statically inspect constants of the specific uwubfuscator/IB2-fork VM.

This is NOT a general IronBrew devirtualizer. It recognizes the particular
base36-LZW + XOR-193 serializer used by one published Roblox loader. It never
executes the protected script, makes HTTP calls or produces playable Lua.
Counts and marker presence are evidence, not a claim of complete recovery.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
from dataclasses import dataclass
from pathlib import Path

MAX_COMPRESSED = 2_000_000
MAX_DECODED = 8_000_000
MAX_ITEMS = 100_000
EXPECTED_HEADER = b"uwubfuscator ~~ custom vm ~~ ib2 fork"
STRING = re.compile(rb"\blocal r\s*=\s*F\('([0-9A-Z]+)'\)")


class UnsupportedVM(ValueError):
    """Input does not match this exact serializer, or is corrupt."""


def lzw_base36(code: bytes) -> bytes:
    """Decode only the F() length-prefixed base36 dictionary format."""
    if len(code) > MAX_COMPRESSED or not code:
        raise UnsupportedVM("empty or oversized base36-LZW input")
    text = code.decode("ascii")
    cursor = 0

    def number() -> int:
        nonlocal cursor
        if cursor >= len(text):
            raise UnsupportedVM("truncated base36-LZW token")
        width = int(text[cursor], 36)
        cursor += 1
        if width < 1 or cursor + width > len(text):
            raise UnsupportedVM("invalid base36-LZW token width")
        value = int(text[cursor:cursor + width], 36)
        cursor += width
        return value

    table = {i: bytes((i,)) for i in range(256)}
    initial = number()
    if initial > 255:
        raise UnsupportedVM("invalid first LZW code")
    previous = table[initial]
    chunks = [previous]
    size = 1
    next_code = 256
    while cursor < len(text):
        code_number = number()
        if code_number in table:
            entry = table[code_number]
        elif code_number == next_code:
            entry = previous + previous[:1]
        else:
            raise UnsupportedVM("unknown LZW code")
        table[next_code] = previous + entry[:1]
        next_code += 1
        previous = entry
        size += len(entry)
        if size > MAX_DECODED or next_code > MAX_ITEMS:
            raise UnsupportedVM("LZW expansion exceeds limit")
        chunks.append(entry)
    return b"".join(chunks)


@dataclass
class VMStats:
    prototypes: int = 0
    instructions: int = 0
    constants: int = 0
    string_constants: int = 0
    strings: tuple[bytes, ...] = ()


class VMReader:
    def __init__(self, data: bytes):
        if len(data) > MAX_DECODED:
            raise UnsupportedVM("VM byte stream too large")
        self.data = data
        self.pos = 0
        self.strings: list[bytes] = []
        self.prototypes = 0
        self.instructions = 0
        self.constants = 0

    def byte(self) -> int:
        if self.pos == len(self.data):
            raise UnsupportedVM("truncated VM byte stream")
        decoded = self.data[self.pos] ^ 193
        self.pos += 1
        return decoded

    def uint32(self) -> int:
        return sum(self.byte() << (8 * index) for index in range(4))

    def string(self) -> bytes:
        size = self.uint32()
        if size > MAX_ITEMS or size > len(self.data) - self.pos:
            raise UnsupportedVM("invalid VM string length")
        return bytes(self.byte() for _ in range(size))

    def proto(self, depth: int = 0) -> None:
        # The exact source parser recursively deserializes child prototypes,
        # then parameters, constants and 8-byte instructions in this order.
        if depth > 40 or self.prototypes >= MAX_ITEMS:
            raise UnsupportedVM("VM prototype recursion or count limit")
        self.prototypes += 1
        children = self.uint32()
        if children > MAX_ITEMS or children > (len(self.data) - self.pos) // 9:
            raise UnsupportedVM("invalid child count")
        for _ in range(children):
            self.proto(depth + 1)
        self.byte()  # numparams
        count = self.uint32()
        if count > MAX_ITEMS:
            raise UnsupportedVM("invalid constant count")
        self.constants += count
        for _ in range(count):
            tag = self.byte()
            if tag == 0:  # boolean
                self.byte()
            elif tag == 1:  # XOR-193 string
                self.strings.append(self.string())
            elif tag == 2:  # little-endian IEEE754 double
                for _ in range(8):
                    self.byte()
            elif tag != 3:  # nil; other tags are not supported by this parser
                raise UnsupportedVM("unknown constant tag")
        count = self.uint32()
        if count > MAX_ITEMS or count > (len(self.data) - self.pos) // 8:
            raise UnsupportedVM("invalid instruction count")
        self.instructions += count
        # The interpreter reads two XOR-193 u32 words per instruction.
        self.pos += count * 8

    def read(self) -> VMStats:
        self.proto()
        if self.pos != len(self.data):
            raise UnsupportedVM("trailing VM bytes (incompatible serializer)")
        return VMStats(self.prototypes, self.instructions, self.constants,
                       len(self.strings), tuple(self.strings))


def inspect(source: bytes) -> dict:
    if EXPECTED_HEADER not in source[:256]:
        raise UnsupportedVM("not the supported IB2-fork header")
    if b"l(a(r,o,o),193)" not in source or b"return X(S(),{},E())()" not in source:
        raise UnsupportedVM("not the supported XOR-193 VM serializer")
    match = STRING.search(source)
    if not match:
        raise UnsupportedVM("no literal base36-LZW VM stream")
    compressed = match.group(1)
    binary = lzw_base36(compressed)
    stats = VMReader(binary).read()
    lower = [value.lower() for value in stats.strings]
    markers = {
        # Count constants only, NOT dynamic calls or proof of program behavior.
        "lone_survival": b"lone survival",
        "lonesurvival": b"lonesurvival",
        "workspace": b"workspace",
        "fireserver": b"fireserver",
        "httpget": b"httpget",
        "swimhub": b"swimhub",
    }
    return {
        "mode": "offline-constant-scan-only",
        "source_bytes": len(source), "source_sha256": hashlib.sha256(source).hexdigest(),
        "lzw_bytes": len(compressed), "vm_bytes": len(binary),
        "vm_sha256": hashlib.sha256(binary).hexdigest(),
        "prototypes": stats.prototypes, "instructions": stats.instructions,
        "constants": stats.constants, "string_constants": stats.string_constants,
        "marker_string_counts": {name: sum(marker in value for value in lower)
                                 for name, marker in markers.items()},
        "gameplay_verified": False, "deobfuscated": False,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="local, authorized protected Lua")
    args = parser.parse_args()
    if args.input.stat().st_size > MAX_COMPRESSED * 2:
        parser.error("source file exceeds limit")
    try:
        report = inspect(args.input.read_bytes())
    except (UnsupportedVM, UnicodeError, ValueError) as exc:
        parser.error(str(exc))
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
