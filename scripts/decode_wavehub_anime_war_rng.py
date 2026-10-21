#!/usr/bin/env python3
"""Statically inline WaveHub Anime War RNG's pinned custom string table.

Does not run any input Luau, fetch URLs, or reconstruct unobfuscated code that
was never in this file. Output remains a third-party-client-dependent module.

Reproduction (after cloning the pinned MIT repository):
    python -m scripts.decode_wavehub_anime_war_rng \
        /path/to/WaveHub/games/anime-war-rng.lua /tmp/anime-war-rng-decoded.lua
"""

from __future__ import annotations

from dataclasses import dataclass
import hashlib
from pathlib import Path
import re
import sys

INPUT_SHA256 = "7377afb9d1b8cc7d6390b504080a4f8cddb5f04bb2373c7179dbca4397f4f643"
COUNT = 607
SOURCE_REVISION = "198b5d26877c44b0533b6c3f1826a87515d59faf"
HEADER = f"""--[[
WaveHub / Anime War RNG: DEOBFUSCATED (static recovery), NOT an open src mirror.
Source: https://github.com/wavechayakon/WaveHub/blob/{SOURCE_REVISION}/games/anime-war-rng.lua
Input SHA-256: {INPUT_SHA256}
Method: replace the 607 decoded strings at 1,070 literal call sites. No gameplay was executed.
Scope: the game module is present, but external WindUI code is not included.

MIT LICENSE BEGIN
MIT License

Copyright (c) 2026 WaveHub

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
MIT LICENSE END
]]

"""
CALL_RE = re.compile(r"_MmmjvvlZHicC\((\d+)\)")
ALPHABET_RE = re.compile(r'^local _oytXFndQY="([^"\n]+)"\n')
STRING_ROW = re.compile(r'^\s*\[(\d+)\]="([^"\n]*)",?$', re.M)
SEED_ROW = re.compile(r"^\s*\[(\d+)\]=(\d+),?$", re.M)


@dataclass(frozen=True)
class Recovery:
    body: str
    constants: dict[int, bytes]
    references: int


def extract_table(source: str, name: str, row: re.Pattern[str]) -> dict[int, str]:
    start = source.index(f"local {name}={{\n") + len(f"local {name}={{\n")
    end = source.index("\n}\n", start)
    table = source[start:end]
    entries: dict[int, str] = {}
    for line in table.splitlines():
        m = row.fullmatch(line)
        if not m or int(m[1]) in entries:
            raise ValueError(f"Unexpected or duplicate {name} entry: {line[:80]!r}")
        entries[int(m[1])] = m[2]
    if set(entries) != set(range(1, COUNT + 1)):
        raise ValueError(f"Incomplete {name} table")
    return entries


def decode_value(index: int, encoded: str, key: int, alphabet: str) -> bytes:
    """Pure-Python equivalent of the pinned Lua helper's base64+keystream loop."""
    lookup = {char: position for position, char in enumerate(alphabet)}
    if len(alphabet) != 64 or len(lookup) != 64 or len(encoded) % 4 == 1:
        raise ValueError("Malformed alphabet or encoded string")
    raw = bytearray()
    for offset in range(0, len(encoded), 4):
        chars = encoded[offset:offset + 4]
        try:
            digits = [lookup[char] for char in chars]
        except KeyError as exc:
            raise ValueError(f"Invalid encoded symbol at constant {index}") from exc
        if len(digits) < 2:
            raise ValueError("Truncated encoded quartet")
        a, b, c, d = (digits + [0, 0])[:4]
        value = (a << 18) + (b << 12) + (c << 6) + d
        raw.append((value >> 16) & 0xff)
        if len(digits) >= 3:
            raw.append((value >> 8) & 0xff)
        if len(digits) == 4:
            raw.append(value & 0xff)
    return bytes(
        (value - (key + position * 31 + (index * 17) % 251
                  + (position * position) % 127) % 256) % 256
        for position, value in enumerate(raw, start=1)
    )


def quote_lua(data: bytes) -> str:
    result = ['"']
    for byte in data:
        if byte in (ord('"'), ord('\\')):
            result.append('\\' + chr(byte))
        elif byte == 10:
            result.append(r"\n")
        elif byte == 13:
            result.append(r"\r")
        elif byte == 9:
            result.append(r"\t")
        elif 32 <= byte <= 126:
            result.append(chr(byte))
        else:
            result.append(f"\\{byte:03d}")
    return ''.join(result) + '"'


def decode_source(data: bytes) -> Recovery:
    if hashlib.sha256(data).hexdigest() != INPUT_SHA256:
        raise ValueError("Unexpected upstream input SHA-256; inspect before decoding")
    source = data.decode("utf-8")
    alphabet = ALPHABET_RE.match(source)
    if alphabet is None:
        raise ValueError("Expected WaveHub alphabet at file start")
    strings = extract_table(source, "_JBmfmFsdXbcx", STRING_ROW)
    seeds = extract_table(source, "_vnIGVltJgej", SEED_ROW)
    helper_start = source.index("local _iXEYSLRlPYyo={}")
    helper_end = source.index("\npcall(function()", helper_start) + 1
    helper = source[helper_start:helper_end]
    # Refuse a changed decoder rather than substituting constants under an
    # unverified cipher. This is intentionally pinned to this particular file.
    for marker in (
        "local function _MmmjvvlZHicC(_wIlolaeBI)",
        "local function emit(v)",
        "local k=_vnIGVltJgej[_wIlolaeBI]",
        "local q=(k+n*31+((_wIlolaeBI*17)%251)+(n*n)%127)%256",
        "string.char((v-q+256)%256)",
        "return _uMPhsMUQDKY\nend\n\n",
    ):
        if marker not in helper:
            raise ValueError(f"Changed upstream helper: {marker}")
    if helper.count("local function ") != 2:
        raise ValueError("Unexpected helper code")
    constants = {
        index: decode_value(index, strings[index], int(seeds[index]), alphabet[1])
        for index in range(1, COUNT + 1)
    }
    # The published Luau must not contain the encoded table or its runtime
    # decryptor. The gameplay after the helper is otherwise byte-preserved.
    original_body = source[helper_end:]
    if "_JBmfmFsdXbcx" in original_body or "_vnIGVltJgej" in original_body:
        raise ValueError("String table is used outside the helper")
    references = len(CALL_RE.findall(original_body))
    if references != 1070 or original_body.count("_MmmjvvlZHicC(") != references:
        raise ValueError(f"Unexpected dynamic/nonliteral calls: {references}")
    body = CALL_RE.sub(lambda m: quote_lua(constants[int(m[1])]), original_body)
    if "_MmmjvvlZHicC" in body:
        raise ValueError("Unresolved string decode call")
    return Recovery(body=body, constants=constants, references=references)


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print(f"usage: {argv[0]} pinned-anime-war-rng.lua output.lua", file=sys.stderr)
        return 2
    recovered = decode_source(Path(argv[1]).read_bytes())
    output = Path(argv[2])
    output.write_text(HEADER + recovered.body, encoding="utf-8")
    print(f"Recovered {len(recovered.constants)} strings, inlined {recovered.references} uses; "
          f"{len((HEADER + recovered.body).splitlines())} lines written to {output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
