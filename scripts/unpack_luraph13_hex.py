#!/usr/bin/env python3
"""Offline RLE/hex container extraction for one Luraph v13.5.8 wrapper.

The result is an opaque encrypted/virtualized binary stream, *not Lua code*.
This intentionally never executes the input or accesses any URL/API.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

BANNER = "-- This file was generated using Luraph Obfuscator v13.5.8"
LITERAL = re.compile(r'local v,V="(LPH~[0-9A-FH]+)",nil;')
MAX_INPUT_BYTES = 8_000_000
MAX_OUTPUT_BYTES = 8_000_000


def unpack_hex_stream(source: str) -> tuple[bytes, int]:
    if not source.startswith(BANNER):
        raise ValueError("not this Luraph v13.5.8 wrapper")
    matches = LITERAL.findall(source)
    if len(matches) != 1 or source.count("LPH~") != 1:
        raise ValueError("expected one literal LPH~ hex/RLE block")
    # Verify the sample's actual decoding idiom and its marker position.
    if 'H(Lx,ja)==0X000048' not in source or 'v=u(N(v,0X00005),".."' not in source:
        raise ValueError("unknown LPH~ decoder; refusing to assume this encoding")
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
    parser.add_argument("input", type=Path, help="Luraph v13.5.8 Lua wrapper")
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
            "note": "opaque binary; Lua program not recovered",
        }, sort_keys=True), file=sys.stderr)
        return 0
    except (OSError, UnicodeError, ValueError) as exc:
        print(f"Luraph hex container unpack: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
