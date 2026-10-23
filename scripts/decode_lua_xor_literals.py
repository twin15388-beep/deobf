#!/usr/bin/env python3
"""Statically replace the literal v7(data, key) XOR calls in one GPO obfuscator.

This is deliberately specific to the v7 decoder in dilleron964/Grand-Piece-Online.
It reads Lua as text, never evaluates Lua, and leaves all nonliteral calls intact.
The output is a *partial* deobfuscation: control flow and names are untouched.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

EXPECTED_PREFIX = (
    "local v0=string.char;local v1=string.byte;local v2=string.sub;"
    "local v3=bit32 or bit ;local v4=v3.bxor;"
)
LONG_OPEN = re.compile(r"\[(=*)\[")
DECIMAL = re.compile(r"[0-9]{1,3}")
SIMPLE_ESCAPES = {
    "a": 7, "b": 8, "f": 12, "n": 10, "r": 13, "t": 9, "v": 11,
    "\\": 92, '"': 34, "'": 39,
}


def quoted_end(text: str, start: int) -> int:
    """Find the end of a Lua quoted string; return position after its quote."""
    quote = text[start]
    if quote not in ('"', "'"):
        raise ValueError("quoted_end needs a quote")
    pos = start + 1
    while pos < len(text):
        if text[pos] == "\\":
            pos += 2
        elif text[pos] == quote:
            return pos + 1
        else:
            pos += 1
    raise ValueError("unterminated Lua string")


def literal_bytes(contents: str) -> bytes:
    """Parse Lua string contents without evaluating code or expanding identifiers."""
    output = bytearray()
    pos = 0
    while pos < len(contents):
        ch = contents[pos]
        if ch != "\\":
            output.extend(ch.encode("utf-8"))
            pos += 1
            continue
        pos += 1
        if pos >= len(contents):
            raise ValueError("trailing backslash in Lua string")
        ch = contents[pos]
        if "0" <= ch <= "9":
            match = DECIMAL.match(contents, pos)
            assert match is not None
            value = int(match.group())
            if value > 255:
                raise ValueError("Lua decimal escape out of byte range")
            output.append(value)
            pos = match.end()
        elif ch in SIMPLE_ESCAPES:
            output.append(SIMPLE_ESCAPES[ch])
            pos += 1
        elif ch == "x":
            digits = contents[pos + 1 : pos + 3]
            if len(digits) != 2 or not re.fullmatch("[0-9a-fA-F]{2}", digits):
                raise ValueError("invalid Lua hex escape")
            output.append(int(digits, 16))
            pos += 3
        elif ch == "z":
            pos += 1
            while pos < len(contents) and contents[pos].isspace():
                pos += 1
        elif ch in ("\n", "\r"):
            if ch == "\r" and pos + 1 < len(contents) and contents[pos + 1] == "\n":
                pos += 1
            output.append(10)
            pos += 1
        else:
            raise ValueError(f"unsupported Lua escape \\{ch} (refusing to guess)")
    return bytes(output)


def lua_quote(data: bytes) -> str:
    """Emit the exact bytes as an ASCII-only Lua double-quoted literal."""
    parts = ['"']
    for byte in data:
        if byte == 34:
            parts.append('\\"')
        elif byte == 92:
            parts.append("\\\\")
        elif 32 <= byte <= 126:
            parts.append(chr(byte))
        else:
            # Always emit three digits so an adjacent numeric byte is unambiguous.
            parts.append(f"\\{byte:03d}")
    parts.append('"')
    return "".join(parts)


def _skip_space(text: str, pos: int) -> int:
    while pos < len(text) and text[pos].isspace():
        pos += 1
    return pos


def constant_call(text: str, start: int) -> tuple[int, bytes] | None:
    """Parse v7("data", "key") at start; return (end, decoded bytes)."""
    match = re.match(r"v7\s*\(", text[start:])
    if not match:
        return None
    pos = _skip_space(text, start + match.end())
    if pos >= len(text) or text[pos] != '"':
        return None
    first_end = quoted_end(text, pos)
    raw_data = text[pos + 1 : first_end - 1]
    pos = _skip_space(text, first_end)
    if pos >= len(text) or text[pos] != ",":
        return None
    pos = _skip_space(text, pos + 1)
    if pos >= len(text) or text[pos] != '"':
        return None
    second_end = quoted_end(text, pos)
    raw_key = text[pos + 1 : second_end - 1]
    pos = _skip_space(text, second_end)
    if pos >= len(text) or text[pos] != ")":
        return None
    data, key = literal_bytes(raw_data), literal_bytes(raw_key)
    if not key:
        raise ValueError("zero-length XOR key")
    # Lua loops from 1 to #data and indexes key at 1 + (index % #key).
    return pos + 1, bytes(byte ^ key[(index + 1) % len(key)] for index, byte in enumerate(data))


def replace_literal_calls(text: str) -> tuple[str, dict[str, int]]:
    """Scan Lua lexical contexts, replacing only v7 calls in code."""
    parts: list[str] = []
    previous = 0
    pos = 0
    count = 0
    unmatched = 0
    unique: set[bytes] = set()
    while pos < len(text):
        if text.startswith("--", pos):
            after_dashes = pos + 2
            opener = LONG_OPEN.match(text, after_dashes)
            if opener:
                end = text.find("]" + opener.group(1) + "]", opener.end())
                pos = len(text) if end == -1 else end + len(opener.group(0))
            else:
                end = text.find("\n", pos)
                pos = len(text) if end == -1 else end + 1
            continue
        if text[pos] in ('"', "'"):
            pos = quoted_end(text, pos)
            continue
        if text[pos] == "[":
            opener = LONG_OPEN.match(text, pos)
            if opener:
                end = text.find("]" + opener.group(1) + "]", opener.end())
                pos = len(text) if end == -1 else end + len(opener.group(0))
                continue
        if (
            text.startswith("v7", pos)
            and (pos == 0 or not (text[pos - 1].isalnum() or text[pos - 1] == "_"))
            and re.match(r"v7\s*\(", text[pos:])
        ):
            replacement = constant_call(text, pos)
            if replacement is not None:
                end, decoded = replacement
                parts.extend((text[previous:pos], lua_quote(decoded)))
                previous = end
                pos = end
                count += 1
                unique.add(decoded)
                continue
            unmatched += 1
        pos += 1
    parts.append(text[previous:])
    return "".join(parts), {"replaced": count, "unique_strings": len(unique), "nonliteral_calls": unmatched}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="original Lua source")
    parser.add_argument("-o", "--output", type=Path, required=True, help="partial Lua output")
    args = parser.parse_args(argv)
    try:
        original = args.input.read_bytes()
        source = original.decode("utf-8")
        if (
            not source.startswith(EXPECTED_PREFIX)
            or not re.search(r"local function v7\(v\d+,v\d+\)", source[:400])
            or "1 + (v" not in source[:400]
        ):
            raise ValueError("this is not the expected v7 XOR decoder; no output written")
        result, stats = replace_literal_calls(source)
        if stats["replaced"] == 0:
            raise ValueError("no literal calls matched; no output written")
        encoded = result.encode("utf-8")
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(encoded)
        print(json.dumps({
            **stats,
            "input_sha256": hashlib.sha256(original).hexdigest(),
            "output_sha256": hashlib.sha256(encoded).hexdigest(),
            "output_bytes": len(encoded),
        }, sort_keys=True), file=sys.stderr)
        return 0
    except (OSError, UnicodeError, ValueError) as exc:
        print(f"static XOR decoder: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
