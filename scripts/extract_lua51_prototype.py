#!/usr/bin/env python3
"""Extract one Lua 5.1 function prototype without running the parent chunk.

The root is path 0; children use the zero-based luadec notation 0_7, 0_10,
0_10_0, etc. Output is a new binary Lua 5.1 chunk (header + selected proto).
Only detached functions with zero upvalues can be safely extracted this way;
loaded chunks still must be run only in an isolated, mocked environment.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from pathlib import Path

MAX_BYTES = 16_000_000


@dataclass(frozen=True)
class Proto:
    start: int
    end: int
    upvalues: int
    children: tuple["Proto", ...]


class Reader:
    def __init__(self, data: bytes):
        if len(data) < 12 or len(data) > MAX_BYTES or data[:5] != b"\x1bLua\x51":
            raise ValueError("expected a bounded Lua 5.1 binary chunk")
        if data[5] != 0 or data[6] not in (0, 1):
            raise ValueError("unsupported Lua 5.1 bytecode layout")
        self.data = data
        self.order = "little" if data[6] == 1 else "big"
        self.int_size, self.size_t, self.instruction, self.number = data[7:11]
        if (self.int_size not in (4, 8) or self.size_t not in (4, 8)
                or self.instruction != 4 or self.number not in (4, 8)
                or data[11] not in (0, 1)):
            raise ValueError("unsupported Lua 5.1 architecture")
        self.offset = 12

    def read(self, count: int) -> bytes:
        if count < 0 or self.offset + count > len(self.data):
            raise ValueError("truncated or oversized Lua 5.1 chunk")
        value = self.data[self.offset:self.offset + count]
        self.offset += count
        return value

    def integer(self, size: int | None = None) -> int:
        return int.from_bytes(self.read(size or self.int_size), self.order)

    def counted_bytes(self, element_bytes: int) -> None:
        count = self.integer()
        self.read(count * element_bytes)

    def string(self) -> None:
        size = self.integer(self.size_t)
        raw = self.read(size)
        if size and not raw.endswith(b"\0"):
            raise ValueError("Lua string has no NUL terminator")

    def prototype(self, depth: int = 0) -> Proto:
        if depth > 80:
            raise ValueError("excessive prototype nesting")
        start = self.offset
        self.string()  # source name
        self.read(2 * self.int_size)  # lineDefined, lastLineDefined
        upvalues, _params, _vararg, slots = self.read(4)
        if not slots:
            raise ValueError("invalid Lua 5.1 stack size")
        self.counted_bytes(self.instruction)  # instructions
        constants = self.integer()
        for _ in range(constants):
            kind = self.integer(1)
            if kind == 0:  # nil
                pass
            elif kind == 1:  # boolean
                self.read(1)
            elif kind == 3:  # number
                self.read(self.number)
            elif kind == 4:  # string
                self.string()
            else:
                raise ValueError(f"unknown Lua 5.1 constant type: {kind}")
        children = tuple(self.prototype(depth + 1) for _ in range(self.integer()))
        self.counted_bytes(self.int_size)  # debug line numbers
        for _ in range(self.integer()):  # debug local variable names/ranges
            self.string()
            self.read(2 * self.int_size)
        for _ in range(self.integer()):  # debug upvalue names
            self.string()
        return Proto(start, self.offset, upvalues, children)


def extract(data: bytes, path: str) -> bytes:
    reader = Reader(data)
    root = reader.prototype()
    if reader.offset != len(data):
        raise ValueError("trailing bytes after root prototype")
    parts = path.split("_")
    if not parts or parts[0] != "0" or any(not part.isdecimal() for part in parts):
        raise ValueError("prototype path must be 0, 0_7, 0_10_0, etc.")
    chosen = root
    for part in parts[1:]:
        index = int(part)
        if index >= len(chosen.children):
            raise ValueError(f"prototype {path} is missing child {index}")
        chosen = chosen.children[index]
    if chosen.upvalues:
        raise ValueError("cannot detach a function that captures upvalues")
    return data[:12] + data[chosen.start:chosen.end]


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Lua 5.1 bytecode (not an obfuscated script)")
    parser.add_argument("path", help="zero-based proto path, e.g. 0_7")
    parser.add_argument("output", type=Path, help="new bytecode chunk")
    args = parser.parse_args()
    args.output.write_bytes(extract(args.input.read_bytes(), args.path))
    print(f"Extracted {args.path} to {args.output}; only run with trusted mocks")


if __name__ == "__main__":
    main()
