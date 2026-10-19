"""Bounded, static reader for the *pinned* Script-Dump VM wrappers.

This module reads data; it never evaluates the input as Lua.  The format is
Base36 length-prefixed LZW, XOR with byte two of the decompressed stream, then
variant-specific VM constants, instructions and nested prototypes.
"""

from __future__ import annotations

import math
import re
import struct
from pathlib import Path


class DecodeError(ValueError):
    """An input does not have the expected, fully decoded VM format."""


LITERAL = re.compile(r"local [A-Za-z_]+\s*=\s*[A-Za-z_]+\('([0-9A-Z]+)'\);local")
MAX_INPUT = 2_000_000
MAX_BLOB = 4_000_000


def decompress_literal(text: str) -> bytes:
    match = LITERAL.search(text)
    if not match:
        raise DecodeError("Base36/LZW wrapper literal not found")
    encoded = match.group(1)
    if len(encoded) > MAX_INPUT:
        raise DecodeError("compressed literal too large")
    position = 0

    def read_code() -> int:
        nonlocal position
        if position >= len(encoded):
            raise DecodeError("truncated Base36/LZW code")
        digits = int(encoded[position], 36)
        position += 1
        if not 1 <= digits <= 8 or position + digits > len(encoded):
            raise DecodeError("invalid Base36/LZW code length")
        result = int(encoded[position:position + digits], 36)
        position += digits
        return result

    initial = read_code()
    if initial > 255:
        raise DecodeError("first LZW code must be a byte")
    previous = bytes([initial])
    output = bytearray(previous)
    dictionary = {i: bytes([i]) for i in range(256)}
    next_index = 256
    while position < len(encoded):
        code = read_code()
        if code in dictionary:
            entry = dictionary[code]
        elif code == next_index:
            entry = previous + previous[:1]
        else:
            raise DecodeError(f"invalid LZW index {code}")
        dictionary[next_index] = previous + entry[:1]
        next_index += 1
        output.extend(entry)
        if len(output) > MAX_BLOB or next_index > 500_000:
            raise DecodeError("decoded LZW stream too large")
        previous = entry
    if len(output) < 2:
        raise DecodeError("missing XOR key")
    key = output[1]
    return bytes(value ^ key for value in output)


class Reader:
    def __init__(self, blob: bytes, tags: tuple[int, int, int], layout: str):
        if len(set(tags)) != 3 or not set(tags).issubset(range(4)):
            raise DecodeError("expected three distinct bool/number/string tags")
        if sorted(layout) != ["a", "i", "p"]:
            raise DecodeError("invalid prototype section order")
        self.blob = blob
        self.offset = 0
        self.tags = tags
        self.layout = layout
        self.prototypes_seen = 0

    def take(self, amount: int) -> bytes:
        if amount < 0 or self.offset + amount > len(self.blob):
            raise DecodeError(f"truncated VM stream at {self.offset}/{len(self.blob)}")
        result = self.blob[self.offset:self.offset + amount]
        self.offset += amount
        return result

    def u8(self) -> int:
        return self.take(1)[0]

    def u16(self) -> int:
        return int.from_bytes(self.take(2), "little")

    def u32(self) -> int:
        return int.from_bytes(self.take(4), "little")

    def constant(self):
        tag = self.u8()
        if tag == self.tags[0]:
            value = self.u8()
            if value not in (0, 1):
                raise DecodeError("invalid Boolean")
            return bool(value)
        if tag == self.tags[1]:
            number = struct.unpack("<d", self.take(8))[0]
            if not math.isfinite(number):
                raise DecodeError("non-finite number")
            return number
        if tag == self.tags[2]:
            length = self.u32()
            if length > 1_000_000:
                raise DecodeError("oversized string")
            try:
                return self.take(length).decode("utf-8")
            except UnicodeDecodeError as error:
                raise DecodeError("non-UTF-8 constant") from error
        if tag in range(4):
            return None  # fourth, variant-specific tag: nil
        raise DecodeError(f"unknown constant tag {tag}")

    def prototype(self, depth: int = 0) -> dict:
        self.prototypes_seen += 1
        if depth > 80 or self.prototypes_seen > 1000:
            raise DecodeError("too many nested prototypes")
        constant_count = self.u32()
        if constant_count > 20_000:
            raise DecodeError("too many constants")
        constants = [None] + [self.constant() for _ in range(constant_count)]
        instructions, raw, children, params = [], [], [], None
        for section in self.layout:
            if section == "p":
                child_count = self.u32()
                if child_count > 1000:
                    raise DecodeError("too many child prototypes")
                children = [self.prototype(depth + 1) for _ in range(child_count)]
            elif section == "a":
                params = self.u8()
            elif section == "i":
                count = self.u32()
                if count > 1_000_000:
                    raise DecodeError("too many VM instructions")
                for index in range(1, count + 1):
                    flags = self.u8()
                    if flags & 1:  # VM-specific padding entry; has no operands
                        continue
                    mode, mask = (flags >> 1) & 3, (flags >> 3) & 7
                    numbers = [self.u16(), self.u16(), None, None]
                    if mode == 0:
                        numbers[2], numbers[3] = self.u16(), self.u16()
                    elif mode == 1:
                        numbers[2] = self.u32()
                    elif mode == 2:
                        numbers[2] = self.u32() - 65_536
                    else:
                        numbers[2], numbers[3] = self.u32() - 65_536, self.u16()
                    decoded = numbers[:]
                    for field, bit in ((1, 1), (2, 2), (3, 4)):
                        if mask & bit:
                            ref = numbers[field]
                            if not isinstance(ref, int) or not 0 <= ref < len(constants):
                                raise DecodeError(f"bad constant reference at depth {depth}, #{index}")
                            decoded[field] = constants[ref]
                    instructions.append(decoded)
                    raw.append({"nums": numbers, "mask": mask, "layout": mode})
        return {"params": params, "const": constants, "ins": instructions,
                "raw": raw, "protos": children, "depth": depth}


def parse_bytes(content: bytes, tags: tuple[int, int, int], layout: str) -> tuple[dict, bytes]:
    if len(content) > MAX_INPUT:
        raise DecodeError("protected file too large")
    try:
        text = content.decode("utf-8")
    except UnicodeDecodeError as error:
        raise DecodeError("protected wrapper must be UTF-8") from error
    blob = decompress_literal(text)
    reader = Reader(blob, tags, layout)
    prototype = reader.prototype()
    if reader.offset != len(blob):
        raise DecodeError(f"trailing VM data: {reader.offset}/{len(blob)}")
    return prototype, blob


def parse(path: Path, tags: tuple[int, int, int], layout: str) -> tuple[dict, bytes]:
    return parse_bytes(path.read_bytes(), tags, layout)


def walk(prototype: dict):
    yield prototype
    for child in prototype["protos"]:
        yield from walk(child)
