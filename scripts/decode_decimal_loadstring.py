#!/usr/bin/env python3
"""Extract complete decimal-escaped Lua literals from simple loadstring wrappers.

Only comments, whitespace and an optional literal wait(N) BETWEEN calls are
accepted outside the calls. No Lua is evaluated, fetched or executed. This is
not a VM deobfuscator: each output is one embedded Lua chunk, not proof that
it works in Roblox or that the outer file contains no other hidden payload.
"""

from __future__ import annotations

import argparse
import hashlib
import re
from dataclasses import dataclass
from pathlib import Path

# The backreference requires the same quote at both ends. Each byte must be
# represented by its own Lua decimal escape; arbitrary Lua expressions fail.
CALL = re.compile(
    rb"loadstring\s*\(\s*(?P<quote>['\"])(?P<body>(?:\\[0-9]{1,3})+)"
    rb"(?P=quote)\s*\)\s*\(\s*\)"
)
ESCAPE = re.compile(rb"\\([0-9]{1,3})")
WAIT = re.compile(rb"wait\s*\(\s*(?P<seconds>[0-9]+)\s*\)")
SAFE_NAME = re.compile(r"[A-Za-z0-9][A-Za-z0-9 ._-]*")
MAX_INPUT_BYTES = 5_000_000


@dataclass(frozen=True)
class Chunk:
    data: bytes
    wait_before_seconds: int | None = None


def _skip_trivia(source: bytes, pos: int) -> int:
    """Skip whitespace and Lua comments, never scanning inside comments."""
    while pos < len(source):
        if source[pos] in b" \r\n\t\v\f":
            pos += 1
        elif source.startswith(b"--[[", pos):
            end = source.find(b"]]", pos + 4)
            if end < 0:
                raise ValueError("unterminated long comment")
            pos = end + 2
        elif source.startswith(b"--[=", pos):
            raise ValueError("unsupported long comment delimiter")
        elif source.startswith(b"--", pos):
            end = source.find(b"\n", pos + 2)
            pos = len(source) if end < 0 else end + 1
        else:
            break
    return pos


def extract_chunks(source: bytes) -> list[Chunk]:
    """Require an entire simple wrapper, then return its exact embedded bytes.

    Chunks deliberately stay separate: independent loadstring calls have
    separate Lua local scopes. A wait before the next chunk is recorded, not
    silently removed or merged into a supposedly equivalent single program.
    """
    if len(source) > MAX_INPUT_BYTES:
        raise ValueError("input exceeds static-decoder size limit")
    chunks: list[Chunk] = []
    pos = 0
    pending_wait: int | None = None
    while True:
        pos = _skip_trivia(source, pos)
        if pos == len(source):
            break
        delay = WAIT.match(source, pos)
        if delay:
            if not chunks or pending_wait is not None:
                raise ValueError("wait is only allowed once between two chunks")
            pending_wait = int(delay.group("seconds"))
            pos = delay.end()
            continue
        call = CALL.match(source, pos)
        if not call:
            raise ValueError(f"unexpected content at input byte {pos}; refusing partial extraction")
        values = [int(m.group(1)) for m in ESCAPE.finditer(call.group("body"))]
        if any(value > 255 for value in values):
            raise ValueError("Lua decimal escape exceeds byte range")
        chunks.append(Chunk(bytes(values), pending_wait))
        pending_wait = None
        pos = call.end()
    if not chunks or pending_wait is not None:
        raise ValueError("no complete loadstring call or dangling wait")
    return chunks


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, help="original, pinned Lua wrapper")
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--name", required=True, help="safe game name used in output filenames")
    args = parser.parse_args()
    if not SAFE_NAME.fullmatch(args.name) or args.name.endswith("."):
        parser.error("--name must be a simple game name, not a path")
    original = args.input.read_bytes()
    chunks = extract_chunks(original)
    args.output_dir.mkdir(parents=True, exist_ok=True)
    print(f"input: {len(original)} bytes SHA-256 {hashlib.sha256(original).hexdigest()}")
    for index, chunk in enumerate(chunks, start=1):
        filename = (f"{args.name}.decoded.lua" if len(chunks) == 1
                    else f"{args.name}.part{index}.decoded.lua")
        path = args.output_dir / filename
        if path.exists() and path.read_bytes() != chunk.data:
            raise FileExistsError(f"refusing to overwrite different bytes: {path}")
        path.write_bytes(chunk.data)
        print(f"{filename}: {len(chunk.data)} bytes, SHA-256 "
              f"{hashlib.sha256(chunk.data).hexdigest()}, "
              f"wait before={chunk.wait_before_seconds}")


if __name__ == "__main__":
    main()
