#!/usr/bin/env python3
"""Offline hex/RLE container extraction for two observed Luraph v13 wrappers.

The v13.5.8 decoder's pair/RLE idiom is checked in the source. For v13.6.7,
the same grammar is inferred from its LPH# literal and adjacent call, *not*
fully proved against the heavily obfuscated Lua reader: that output is only a
candidate. Both results are opaque binary, NOT recovered Lua. No Lua or URL
is ever executed or accessed.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

BANNER = "-- This file was generated using Luraph Obfuscator v13.5.8"
BANNER_136 = "-- This file was generated using Luraph Obfuscator v13.6.7"
LITERAL = re.compile(r'local v,V="(LPH~[0-9A-FH]+)",nil;')
LITERAL_136 = re.compile(r'"(LPH#[0-9A-FH]+)",0X1,string\.char')
MAX_INPUT_BYTES = 8_000_000
MAX_OUTPUT_BYTES = 8_000_000


def unpack_hex_stream(source: str) -> tuple[bytes, int]:
    if source.startswith(BANNER):
        matches = LITERAL.findall(source)
        if len(matches) != 1 or source.count("LPH~") != 1:
            raise ValueError("expected one literal LPH~ hex/RLE block")
        # Verify the v13.5.8 sample's actual decoding idiom.
        if 'H(Lx,ja)==0X000048' not in source or 'v=u(N(v,0X00005),".."' not in source:
            raise ValueError("unknown LPH~ decoder; refusing to assume this encoding")
    elif source.startswith(BANNER_136):
        matches = LITERAL_136.findall(source)
        if len(matches) != 1 or source.count("LPH#") != 1:
            raise ValueError("expected one LPH# literal passed to the v13.6.7 reader")
        # The RLE grammar fits, but the obfuscated v13.6.7 reader was NOT
        # formally lifted. CLI and reports must label these bytes a candidate.
    else:
        raise ValueError("not a recognised Luraph v13 hex wrapper")
    encoded = matches[0][4:]
    if len(encoded) % 2:
        raise ValueError("incomplete hex/RLE pair")
    result = bytearray()
    repeat: int | None = None
    marker_count = 0
    for index in range(0, len(encoded), 2):
        pair = encoded[index : index + 2]
        if pair[1] == "H":
            if repeat is not None or not ("0" <= pair[0] <= "9"):
                raise ValueError("invalid run-length marker")
            repeat = int(pair[0])
            marker_count += 1
        else:
            if not re.fullmatch("[0-9A-F]{2}", pair):
                raise ValueError("invalid byte in hex stream")
            result.extend(bytes([int(pair, 16)]) * (repeat if repeat is not None else 1))
            repeat = None
        if len(result) > MAX_OUTPUT_BYTES:
            raise ValueError("decoded stream exceeds analysis limit")
    if repeat is not None:
        raise ValueError("run-length marker with no following byte")
    return bytes(result), marker_count


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Luraph v13.5.8 or experimental v13.6.7 wrapper")
    parser.add_argument("-o", "--output", type=Path, required=True, help="opaque binary stream")
    args = parser.parse_args(argv)
    try:
        original = args.input.read_bytes()
        if len(original) > MAX_INPUT_BYTES:
            raise ValueError("input exceeds analysis limit")
        decoded, markers = unpack_hex_stream(original.decode("utf-8"))
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(decoded)
        print(json.dumps({
            "rle_markers": markers,
            "output_bytes": len(decoded),
            "input_sha256": hashlib.sha256(original).hexdigest(),
            "output_sha256": hashlib.sha256(decoded).hexdigest(),
            "note": (
                "experimental LPH# RLE candidate; reader semantics not verified; NOT Lua"
                if original.startswith(BANNER_136.encode("utf-8"))
                else "opaque binary; Lua program not recovered"
            ),
        }, sort_keys=True), file=sys.stderr)
        return 0
    except (OSError, UnicodeError, ValueError) as exc:
        print(f"Luraph hex container unpack: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
