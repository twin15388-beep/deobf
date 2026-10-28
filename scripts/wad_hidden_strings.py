#!/usr/bin/env python3
"""Decode the hidden-string scheme of a WeAreDevs (WAD) v1.0.0 payload.

WAD hides every literal behind a lookup of the form ``u40[u41("<cipher>", KEY)]``
(or, after lifting, ``t[f("<cipher>", KEY)]``).  The pinned deobfuscator resolves
most of these itself; when a step drops a whole region (see
reports/wad-bloxstrike-maingame-2026-10-25.md) this module lets us decode the
remaining literals from an intermediate stage without executing the payload.

The scheme, as read from the lifted decoder (`u42`, `u45`, `u46`, `u56`, `v66`):

* per string the state is seeded from the key: ``u42 = K % 255 + 2`` and
  ``u45 = K % 2**45``;
* the byte stream advances ``u45 = (u45 * 213 + 27552854471197) % 2**45`` and
  ``u42 = u42 * 201 % 257`` (repeated while it lands on 1), then splits one
  32-bit value into four bytes that are consumed from the end of a stack;
* the plaintext is ``state = 204`` then ``state = (cipher_byte + next() + state) % 256``
  for every byte, and the decoder's alphabet table is ``chr(i - 1)`` (a shuffled
  identity, so no table is needed);
* the key itself is never mixed into the plaintext, it only seeds the stream.

Pure integer arithmetic: nothing from the payload is executed and there is no
network or file-system access beyond reading the file you name.
"""

from __future__ import annotations

import argparse
import math
import re
import sys

MASK45 = (1 << 45) - 1
MASK32 = (1 << 32) - 1
SEED_MUL = 213
SEED_ADD = 27552854471197
STATE_MUL = 201
SEED_MOD = 255      # the seed uses 255, the advance uses 257
STATE_MOD = 257
INITIAL_STATE = 204

LUA_ESCAPES = {"a": 7, "b": 8, "f": 12, "n": 10, "r": 13, "t": 9, "v": 11,
               "\\": 92, '"': 34, "'": 39, "\n": 10}

# A few pairs verified against the pinned deobfuscator's own resolution.
KNOWN = [
    (r"\190\18\191^\189(\173", 22126428612671, "Players"),
    (r"\177I\4", 10104580887137, "ESP"),
    (r"\195\216\169\16\230", 21890541529041, "Frame"),
    (r"\23\1907\0120", 1526263153350, "users"),
]


class Stream:
    """The payload's deterministic byte generator, seeded by one string key."""

    def __init__(self, key: int) -> None:
        self.state = key % SEED_MOD + 2
        self.counter = key % (1 << 45)
        self.buffer: list[int] = []

    def next_byte(self) -> int:
        if not self.buffer:
            self.counter = (self.counter * SEED_MUL + SEED_ADD) % (1 << 45)
            while True:
                self.state = self.state * STATE_MUL % STATE_MOD
                if self.state != 1:
                    break
            low = self.state % 32
            raw = (math.floor(self.counter / 2 ** (13 - (self.state - low) // 32)) % (1 << 32)) / 2 ** low
            whole = math.floor((raw % 1) * (1 << 32)) + math.floor(raw)
            low16 = whole % 65536
            high16 = (whole - low16) // 65536
            self.buffer = [low16 % 256, (low16 - low16 % 256) // 256,
                           high16 % 256, (high16 - high16 % 256) // 256]
        return self.buffer.pop()


def decode(cipher: bytes, key: int) -> str:
    """Return the plaintext of one cipher/key pair."""
    stream = Stream(key)
    state = INITIAL_STATE
    out = bytearray()
    for byte in cipher:
        state = (byte + stream.next_byte() + state) % 256
        out.append(state)
    return out.decode("latin1")


def lua_bytes(literal: str) -> bytes:
    """Turn the body of a Lua short string into raw bytes."""
    out = bytearray()
    index = 0
    while index < len(literal):
        char = literal[index]
        if char != "\\":
            out.append(ord(char) & 0xFF)
            index += 1
            continue
        index += 1
        if index >= len(literal):
            break
        nxt = literal[index]
        if nxt.isdigit():
            end = index
            while end < len(literal) and end < index + 3 and literal[end].isdigit():
                end += 1
            out.append(int(literal[index:end]) & 0xFF)
            index = end
        else:
            out.append(LUA_ESCAPES.get(nxt, ord(nxt)))
            index += 1
    return bytes(out)


def lua_quote(text: str) -> str:
    parts = ['"']
    for char in text:
        code = ord(char)
        if char == '"':
            parts.append('\\"')
        elif char == "\\":
            parts.append("\\\\")
        elif char == "\n":
            parts.append("\\n")
        elif 32 <= code < 127:
            parts.append(char)
        else:
            parts.append("\\%d" % code)
    parts.append('"')
    return "".join(parts)


INDEX_PATTERN = re.compile(
    r'([A-Za-z_]\w*)\[\s*\(?\s*([A-Za-z_]\w*)\(\s*"((?:[^"\\]|\\.)*)"'
    r'\s*,\s*(\d+)\s*\)\s*\)?\s*\]')
CALL_PATTERN = re.compile(r'([A-Za-z_]\w*)\(\s*"((?:[^"\\]|\\.)*)"\s*,\s*(\d+)\s*\)')


def rewrite(text: str) -> tuple[str, int]:
    """Replace every hidden-string lookup in `text` with its literal."""
    count = 0

    def by_index(match: re.Match[str]) -> str:
        nonlocal count
        count += 1
        return lua_quote(decode(lua_bytes(match.group(3)), int(match.group(4))))

    def by_call(match: re.Match[str]) -> str:
        nonlocal count
        count += 1
        return lua_quote(decode(lua_bytes(match.group(2)), int(match.group(3))))

    text = INDEX_PATTERN.sub(by_index, text)
    text = CALL_PATTERN.sub(by_call, text)
    return text, count


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)

    one = sub.add_parser("decode", help="decode one escaped cipher/key pair")
    one.add_argument("cipher", help=r'Lua-escaped cipher, e.g. "\177I\4" (quotes optional)')
    one.add_argument("key", type=int)

    many = sub.add_parser("rewrite", help="rewrite hidden-string lookups in a Lua file")
    many.add_argument("source")
    many.add_argument("destination")

    verify = sub.add_parser("selftest", help="check the known pairs")
    options = parser.parse_args(argv)

    if options.command == "decode":
        cipher = options.cipher
        if len(cipher) >= 2 and cipher[0] == '"' and cipher[-1] == '"':
            cipher = cipher[1:-1]
        sys.stdout.buffer.write(decode(lua_bytes(cipher), options.key).encode("latin1") + b"\n")
        return 0

    if options.command == "selftest":
        bad = 0
        for cipher, key, expected in KNOWN:
            got = decode(lua_bytes(cipher), key)
            status = "ok" if got == expected else "FAIL"
            if got != expected:
                bad += 1
            print(f"{status} {key} -> {got!r} (expected {expected!r})")
        return 1 if bad else 0

    with open(options.source, "rb") as handle:
        text = handle.read().decode("latin1")
    rewritten, count = rewrite(text)
    with open(options.destination, "wb") as handle:
        handle.write(rewritten.encode("latin1"))
    print(f"decoded {count} hidden string(s) -> {options.destination}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
