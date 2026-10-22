#!/usr/bin/env python3
"""Extract the *binary container* from one Luraph v14.9 LPH? wrapper.

The matched wrapper expands the base85 zero shorthand (z -> !!!!!), decodes
five characters into an integer, and writes it with buffer.writeu32 (little
endian). This is deliberately not a Luau evaluator or VM decompiler. A script
with another decoder/fingerprint is rejected rather than guessed.
"""

from __future__ import annotations

import argparse
import base64
import hashlib
import json
import re
import sys
from pathlib import Path

BANNER = "-- This file was protected using Luraph Obfuscator v14.9"
LITERAL = re.compile(r"\[==\[(LPH\?.*?)\]==\]", re.DOTALL)
# These excerpts are from the *static* decoder adjacent to the literal in
# WINVOLST/gpo@399140e1d9fb:true_dupe. They bind the decoding to this variant.
DECODER_FINGERPRINT = (
    r'''m[11](k,'\u{7A}',"\z!\33!!!")''',
    "for l=5,f,0B101",
    "(m)[0X16]=J.writeu32",
)
MAX_INPUT_BYTES = 8_000_000
MAX_OUTPUT_BYTES = 8_000_000


def unpack_container(source: str, max_output: int = MAX_OUTPUT_BYTES) -> tuple[bytes, int]:
    """Return the decoder's exact byte order and the number of zero groups."""
    if not source.startswith(BANNER) or any(x not in source for x in DECODER_FINGERPRINT):
        raise ValueError("not the recognised Luraph v14.9 LPH? decoder")
    matches = LITERAL.findall(source)
    if len(matches) != 1 or source.count("LPH?") != 1:
        raise ValueError("expected exactly one LPH? base85 literal")
    encoded = matches[0][4:]
    if not encoded or any(not ("!" <= ch <= "u" or ch == "z") for ch in encoded):
        raise ValueError("unexpected base85 alphabet")
    zero_groups = encoded.count("z")
    groups, remainder = divmod(len(encoded) + 4 * zero_groups, 5)
    if remainder or groups * 4 > max_output:
        raise ValueError("incomplete or oversized base85 group sequence")
    try:
        # a85decode returns big-endian bytes for each group. The sample's
        # buffer.writeu32 instead stores the same integer little-endian.
        big_endian = base64.a85decode(encoded.encode("ascii"), adobe=False)
    except (ValueError, OverflowError) as exc:
        raise ValueError(f"base85 decoding failed: {exc}") from exc
    if len(big_endian) != groups * 4:
        raise ValueError("decoded group count does not match the Lua decoder")
    decoded = bytearray(len(big_endian))
    for pos in range(0, len(big_endian), 4):
        decoded[pos : pos + 4] = big_endian[pos : pos + 4][::-1]
    return bytes(decoded), zero_groups


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="pinned Luraph v14.9 source")
    parser.add_argument("-o", "--output", type=Path, required=True, help="opaque binary output")
    args = parser.parse_args(argv)
    try:
        original = args.input.read_bytes()
        if len(original) > MAX_INPUT_BYTES:
            raise ValueError("input exceeds the 8 MB analysis limit")
        result, zero_groups = unpack_container(original.decode("utf-8"))
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(result)
        print(json.dumps({
            "zero_groups": zero_groups,
            "output_bytes": len(result),
            "input_sha256": hashlib.sha256(original).hexdigest(),
            "output_sha256": hashlib.sha256(result).hexdigest(),
            "note": "opaque LPH? container, NOT recovered game code",
        }, sort_keys=True), file=sys.stderr)
        return 0
    except (OSError, UnicodeError, ValueError) as exc:
        print(f"Luraph v14.9 outer unpack: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
