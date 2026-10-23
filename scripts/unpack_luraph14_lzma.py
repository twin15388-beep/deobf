#!/usr/bin/env python3
"""Offline outer-layer unpack for the Luraph v14.4.1 ASCII85/LZMA wrapper.

Only the literal `LPH~` block is decoded. No protected Lua code is run, and
this does not recover the inner virtual machine's original program.
"""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import lzma
import re
import sys
from pathlib import Path

MAX_INPUT_BYTES = 8_000_000
MAX_OUTPUT_BYTES = 8_000_000
WRAPPER_PREFIX = "-- This file was protected using Luraph Obfuscator v14.4.1"
LITERAL = re.compile(r"d\(\[=\[(LPH~.*?)\]=\],z\)", re.DOTALL)
FILTER = {"id": lzma.FILTER_LZMA1, "dict_size": 1 << 24, "lc": 3, "lp": 0, "pb": 0}


def unpack_outer_layer(source: str, max_output: int = MAX_OUTPUT_BYTES) -> tuple[bytes, int]:
    if not source.startswith(WRAPPER_PREFIX):
        raise ValueError("not this Luraph v14.4.1 wrapper")
    literals = LITERAL.findall(source)
    if len(literals) != 1 or source.count("LPH~") != 1:
        raise ValueError("expected exactly one literal LPH~ ASCII85 block")
    encoded = literals[0][4:]
    if any(not ("!" <= ch <= "u" or ch == "z") for ch in encoded):
        raise ValueError("ASCII85 block has unexpected characters")
    if (len(encoded) + encoded.count("z") * 4) % 5:
        raise ValueError("incomplete ASCII85 group; refusing to guess padding")
    try:
        packed = base64.a85decode(encoded.encode("ascii"), adobe=False)
    except (ValueError, OverflowError) as exc:
        raise ValueError(f"ASCII85 decoding failed: {exc}") from exc
    try:
        decoder = lzma.LZMADecompressor(format=lzma.FORMAT_RAW, filters=[FILTER])
        output = decoder.decompress(packed, max_length=max_output + 1)
    except lzma.LZMAError as exc:
        raise ValueError(f"raw LZMA1 decoding failed: {exc}") from exc
    # ASCII85 stores four bytes per complete group. The observed packer pads
    # the final LZMA stream with up to three zero bytes; Lua stops at its EOF.
    padding = decoder.unused_data
    if (
        len(output) > max_output
        or not decoder.eof
        or len(padding) > 3
        or any(byte != 0 for byte in padding)
    ):
        raise ValueError("oversized, incomplete or unexpectedly padded compressed data")
    return output, len(packed)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="Luraph v14.4.1 Lua wrapper")
    parser.add_argument("-o", "--output", type=Path, required=True, help="inner Luau VM, not authored source")
    args = parser.parse_args(argv)
    try:
        original = args.input.read_bytes()
        if len(original) > MAX_INPUT_BYTES:
            raise ValueError("input exceeds the 8 MB analysis limit")
        result, compressed_size = unpack_outer_layer(original.decode("utf-8"))
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(result)
        print(json.dumps({
            "compressed_bytes": compressed_size,
            "output_bytes": len(result),
            "input_sha256": hashlib.sha256(original).hexdigest(),
            "output_sha256": hashlib.sha256(result).hexdigest(),
            "note": "inner virtualized Luau; not decompiled application source",
        }, sort_keys=True), file=sys.stderr)
        return 0
    except (OSError, UnicodeError, ValueError) as exc:
        print(f"Luraph outer unpack: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
