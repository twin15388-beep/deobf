#!/usr/bin/env python3
"""Statically unwrap the TWO Luraph v14.6 envelope literals in a local Lua file.

The first decoded object is a VM-interpreter *candidate* and the second is
custom VM bytecode, NOT restored gameplay/source. The input may have a small
clear-text prefix such as a Jnkie SDK loader. This tool never fetches scripts,
runs Lua, checks keys, or decompiles VM bytecode. Only inspect material you are
authorized to possess; do not publish extracted proprietary stages.

Usage: python3 scripts/inspect_luraph_envelope.py local-results/authorized.lua
       python3 scripts/inspect_luraph_envelope.py local-results/authorized.lua \
           --out-dir local-results/envelope-stages
"""

from __future__ import annotations

import argparse
import hashlib
import json
import lzma
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PRIVATE_OUTPUT = (ROOT / "local-results").resolve()
MAX_INPUT = 4_000_000
MAX_PREFIX = 64_000
MAX_PACKED = 4_000_000
MAX_STAGE = 4_000_000
HEADER = re.compile(
    rb"(?m)^--[ \t]*This file was protected using Luraph Obfuscator v14\.6\b[^\r\n]*\r?\n"
)
LITERAL = re.compile(rb"\[(=+)\[([\s\S]*?)\]\1\]")
FILTERS = [{"id": lzma.FILTER_LZMA1, "dict_size": 1 << 23, "lc": 3, "lp": 0, "pb": 0}]
STAGES = (("vm_interpreter_candidate", "stage1-vm-interpreter.lua"),
          ("vm_bytecode_candidate", "stage2-custom-bytecode.bin"))


class EnvelopeError(ValueError):
    """An unrecognized, malformed, or oversized offline input."""


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def unpack_blob(blob: bytes) -> tuple[bytes, int]:
    """LPH magic + big-endian base85 words + raw LZMA1 (v14.6 envelope)."""
    if not blob.startswith(b"LPH") or len(blob) < 9:
        raise EnvelopeError("missing v14.6 LPH blob magic")
    encoded = blob[4:]
    packed = bytearray()
    group = bytearray()
    for ch in encoded:
        if ch == ord("z") and not group:
            packed.extend(b"\x00" * 4)
        elif 33 <= ch <= 117:
            group.append(ch)
            if len(group) == 5:
                value = 0
                for digit in group:
                    value = value * 85 + digit - 33
                if value >= 1 << 32:
                    raise EnvelopeError("invalid base85 word")
                packed.extend(value.to_bytes(4, "big"))
                group.clear()
        else:
            raise EnvelopeError("invalid base85 character/group")
        if len(packed) > MAX_PACKED:
            raise EnvelopeError("packed stage exceeds size limit")
    if group or not packed:
        raise EnvelopeError("truncated v14.6 base85 data")
    try:
        inflater = lzma.LZMADecompressor(format=lzma.FORMAT_RAW, filters=FILTERS)
        decoded = inflater.decompress(bytes(packed), max_length=MAX_STAGE + 1)
    except lzma.LZMAError as exc:
        raise EnvelopeError("invalid raw LZMA stage") from exc
    if len(decoded) > MAX_STAGE:
        raise EnvelopeError("decoded stage exceeds size limit")
    # LPH encodes four-byte words, so the LZMA stream can have <=3 pad bytes.
    if not inflater.eof or len(inflater.unused_data) > 3 or any(inflater.unused_data):
        raise EnvelopeError("incomplete or padded-with-data LZMA stage")
    return decoded, len(packed)


def inspect(source: bytes) -> tuple[dict, tuple[bytes, bytes]]:
    """Return redacted statistics and decoded stages; never execute them."""
    if len(source) > MAX_INPUT:
        raise EnvelopeError("local input exceeds size limit")
    header = HEADER.search(source)
    if header is None or header.start() > MAX_PREFIX:
        raise EnvelopeError("Luraph v14.6 header not found near start")
    body = source[header.start():]
    literals = list(LITERAL.finditer(body))
    if len(literals) != 2:
        raise EnvelopeError("expected exactly two v14.6 long-bracket literals")
    stages = []
    results = []
    for match, (kind, _) in zip(literals, STAGES):
        blob = match.group(2)
        decoded, packed_size = unpack_blob(blob)
        stages.append(decoded)
        results.append({"kind": kind, "encoded_bytes": len(blob),
                        "packed_bytes": packed_size, "decoded_bytes": len(decoded),
                        "sha256": sha256(decoded)})
    report = {
        "mode": "offline-static-only", "format": "Luraph v14.6 envelope",
        "input_bytes": len(source), "input_sha256": sha256(source),
        "clear_prefix_bytes": header.start(), "stages": results,
        "envelope_unwrapped": True, "vm_decompiled": False,
        "gameplay_verified": False, "game_source_recovered": False,
    }
    return report, (stages[0], stages[1])


def export_stages(directory: Path, stages: tuple[bytes, bytes]) -> None:
    target = directory.resolve()
    if (target == ROOT or ROOT in target.parents) and PRIVATE_OUTPUT != target \
            and PRIVATE_OUTPUT not in target.parents:
        raise EnvelopeError("repository output must be under ignored local-results/ (or outside the repo)")
    paths = [directory / filename for _, filename in STAGES]
    if any(path.exists() for path in paths):
        raise EnvelopeError("refusing to overwrite an extracted stage")
    directory.mkdir(parents=True, exist_ok=True)
    for path, data in zip(paths, stages):
        with path.open("xb") as output:
            output.write(data)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="local authorized Lua file (never a URL)")
    parser.add_argument("--out-dir", type=Path, help="private scratch directory for the two raw stages")
    args = parser.parse_args(argv)
    try:
        if args.input.stat().st_size > MAX_INPUT:
            raise EnvelopeError("local input exceeds size limit")
        report, stages = inspect(args.input.read_bytes())
        if args.out_dir is not None:
            export_stages(args.out_dir, stages)
        report["stages_exported"] = args.out_dir is not None
        print(json.dumps(report, ensure_ascii=False, indent=2))
        return 0
    except EnvelopeError as exc:
        print(f"offline Luraph envelope rejected: {exc}", file=sys.stderr)
        return 2
    except (OSError, UnicodeError) as exc:
        # Filesystem errors can contain private input path components.
        print(f"offline Luraph envelope rejected: {type(exc).__name__}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
