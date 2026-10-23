#!/usr/bin/env python3
"""Extract one Lua 5.1 function prototype without running the parent chunk.

The root is path 0; children use the zero-based luadec notation 0_7, 0_10,
0_10_0, etc. By default, output is a new bytecode chunk of the unchanged
selected proto; captured upvalues are rejected. --wrap-upvalues instead emits
a small *synthetic* parent that accepts explicitly supplied captured values
and returns the unchanged selected closure. Call loadfile(output)(mock_upvalue_1,
...) to bind them. Never run either kind of chunk except with isolated mocks.
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


def _with_explicit_upvalues(reader: Reader, proto: Proto) -> bytes:
    """Emit a minimal parent *only* to bind the original child's upvalues.

    Lua 5.1 CLOSURE consumes one MOVE instruction per captured stack value.
    No instruction in `proto` or its children is rewritten. The emitted parent
    has no constants, globals, calls, or side effects except returning a closure.
    """
    n = proto.upvalues
    if not 1 <= n <= 249:
        raise ValueError("unsupported number of captured upvalues")

    def integer(value: int, width: int = 0) -> bytes:
        return value.to_bytes(width or reader.int_size, reader.order)

    def abc(op: int, a: int, b: int) -> bytes:
        return integer(op | (a << 6) | (b << 23), reader.instruction)

    code = [integer(36 | (n << 6), reader.instruction)]  # CLOSURE R(n), child 0
    code += [abc(0, 0, index) for index in range(n)]  # MOVE capture each argument
    code += [abc(30, n, 2), abc(30, 0, 1)]  # RETURN closure; unreachable final return
    name = b"@isolated-prototype\0"
    return (reader.data[:12]
            + integer(len(name), reader.size_t) + name
            + integer(0) * 2  # definition lines
            + bytes((0, n, 0, n + 1))  # root upvalues, parameters, vararg, stack
            + integer(len(code)) + b"".join(code)
            + integer(0)  # no constants
            + integer(1) + reader.data[proto.start:proto.end]  # exact original child
            + integer(0) * 3)  # no debug line/local/upvalue entries


def extract(data: bytes, path: str, *, wrap_upvalues: bool = False) -> bytes:
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
        if not wrap_upvalues:
            raise ValueError("captured upvalues require --wrap-upvalues and explicit mocks")
        return _with_explicit_upvalues(reader, chosen)
    if wrap_upvalues:
        raise ValueError("--wrap-upvalues is only for functions with captured upvalues")
    return data[:12] + data[chosen.start:chosen.end]


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Lua 5.1 bytecode (not an obfuscated script)")
    parser.add_argument("path", help="zero-based proto path, e.g. 0_7")
    parser.add_argument("output", type=Path, help="new bytecode chunk")
    parser.add_argument("--wrap-upvalues", action="store_true",
                        help="return an unchanged selected closure bound to explicit mock arguments")
    args = parser.parse_args()
    args.output.write_bytes(extract(args.input.read_bytes(), args.path,
                                    wrap_upvalues=args.wrap_upvalues))
    print(f"Extracted {args.path} to {args.output}; only run with trusted mocks" +
          (" (call loadfile(output)(mock_upvalue_1, ...) for the function)"
           if args.wrap_upvalues else ""))


if __name__ == "__main__":
    main()
