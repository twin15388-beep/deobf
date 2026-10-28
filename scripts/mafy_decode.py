#!/usr/bin/env python3
"""Decode (and, for test fixtures, re-encode) the "Mafy Obfuscator" Lua loader.

Mafy wraps a plain-Lua payload in a short, fully static scheme: junk statements,
two shuffled hex blobs, three repeating XOR keys, a deterministic LCG shuffle and
a final `loadstring`.  Nothing has to be executed to recover the payload.

Layout produced by the obfuscator (line numbers from a real sample in
`local-results/scan/`):

    cVXGFYPcG  = {20 hex chunks}   -- blob A, stored out of order
    lg1qynhyCUt1pS = {20 integers}  -- put chunk i at position perm[i]
    lj2RbSuiTRIo3Qayl = {20 hex chunks}  -- blob B, same idea
    z2rHB4B5Y7qEFg = {20 integers}  -- permutation for blob B
    sg3Jg2xRtQ7Vw  = {24 integers}  -- XOR key for blob A
    meyevPYYDIki1  = {24 integers}  -- XOR key for blob B
    gzuowxxZMZcPUhzCD9 = <seed>     -- LCG seed for the shuffle
    lXjT1t5tXE7wF  = {24 integers}  -- XOR key applied after unshuffling

Decoding: reorder both blobs, hex-decode, XOR with their keys, interleave
(A[1], B[1], A[2], B[2], ...), undo the LCG shuffle (Fisher-Yates swaps, applied
in reverse), XOR with the third key, `string.char` -> Lua source.

The decoder below parses the sample by pattern rather than by the obfuscator's
random identifiers, so renamed variants decode too.  It never executes the Lua.
"""

from __future__ import annotations

import argparse
import re
import sys

LCG_A = 1664525
LCG_C = 1013904223
LCG_M = 1 << 32

HEADER = re.compile(r"^-{0,2}\s*(?:-{2}\s*)?Protected by Mafy Obfuscator", re.MULTILINE)


def _table(text: str, pattern: str) -> list:
    """Return the entries of the first Lua table whose body matches `pattern`."""
    for match in re.finditer(pattern, text, re.S):
        body = match.group(1)
        if '"' in body:
            chunks = re.findall(r'"([0-9a-fA-F]+)"', body)
            if chunks:
                return chunks
        numbers = [int(value) for value in re.findall(r"\d+", body)]
        if numbers:
            return numbers
    raise ValueError(f"table not found: {pattern}")


def parse(text: str) -> dict:
    """Pull the encoded pieces out of a Mafy file (identifier names ignored).

    The obfuscator emits its tables in a fixed order: hex blob A, its
    permutation, hex blob B, its permutation, the two XOR keys, the LCG seed and
    finally the third XOR key.  Junky scalar statements appear around them, so the
    parser walks every `local NAME = {...}` / `local NAME = <number>` assignment
    in source order and classifies the table bodies by content.
    """
    assignments = list(re.finditer(
        r"local\s+[A-Za-z_]\w*\s*=\s*(\{[^{}]*\}|\d+)\s*(?:\n|$)", text, re.S))
    if not assignments:
        raise ValueError("no assignments found")

    tables = []
    seed = None
    for match in assignments:
        body = match.group(1)
        if body.startswith("{"):
            if re.search(r'"[0-9a-fA-F]+"', body):
                tables.append(("hex", re.findall(r'"([0-9a-fA-F]+)"', body), match.start()))
            else:
                numbers = [int(value) for value in re.findall(r"\d+", body)]
                if not numbers:
                    continue  # scratch table such as `local buffer = {}`
                kind = "perm" if max(numbers) <= len(numbers) + 20 else "key"
                tables.append((kind, numbers, match.start()))
        elif seed is None and len(body) >= 6:
            seed = int(body)

    hexes = [entry for entry in tables if entry[0] == "hex"]
    if len(hexes) < 2:
        raise ValueError("expected two hex blobs")

    def following_perm(position: int) -> list:
        later = [entry for entry in tables if entry[0] == "perm" and entry[2] > position]
        if not later:
            raise ValueError("permutation array not found after its blob")
        return later[0][1]

    keys = [entry[1] for entry in tables if entry[0] == "key"]
    if len(keys) < 3:
        raise ValueError(f"expected three XOR keys, found {len(keys)}")
    if seed is None:
        raise ValueError("LCG seed not found")

    return {
        "blob_a": hexes[0][1],
        "blob_b": hexes[1][1],
        "perm_a": following_perm(hexes[0][2]),
        "perm_b": following_perm(hexes[1][2]),
        "key_a": keys[0],
        "key_b": keys[1],
        "key_c": keys[2],
        "seed": seed,
    }


def _reorder(chunks: list, perm: list) -> str:
    """Undo the `out[perm[i]] = chunks[i]` shuffle."""
    slots = [None] * (len(perm) + 1)
    for index, position in enumerate(perm, start=1):
        slots[position] = chunks[index - 1]
    return "".join(slot for slot in slots[1:] if slot is not None)


def _xor(hex_text: str, key: list) -> list:
    if len(hex_text) % 2:
        hex_text = hex_text[:-1]
    raw = bytes(int(hex_text[i:i + 2], 16) for i in range(0, len(hex_text), 2))
    return [byte ^ key[i % len(key)] for i, byte in enumerate(raw)]


def _swaps(seed: int, length: int) -> list:
    """Reproduce the obfuscator's LCG-driven Fisher-Yates swap list."""
    records = []
    value = seed
    for index in range(length - 1, 0, -1):
        value = (value * LCG_A + LCG_C) % LCG_M
        records.append((index + 1, value % (index + 1) + 1))
    return records


def decode(text: str) -> str:
    """Return the plaintext Lua source of one Mafy-protected file."""
    parts = parse(text)
    first = _xor(_reorder(parts["blob_a"], parts["perm_a"]), parts["key_a"])
    second = _xor(_reorder(parts["blob_b"], parts["perm_b"]), parts["key_b"])

    merged = []
    for index in range(max(len(first), len(second))):
        if index < len(first):
            merged.append(first[index])
        if index < len(second):
            merged.append(second[index])

    for left, right in reversed(_swaps(parts["seed"], len(merged))):
        merged[left - 1], merged[right - 1] = merged[right - 1], merged[left - 1]

    key_c = parts["key_c"]
    out = bytes((merged[i] ^ key_c[i % len(key_c)]) & 0xFF for i in range(len(merged)))
    return out.decode("latin1")


def encode(source: str, seed: int, key_a: list, key_b: list, key_c: list) -> str:
    """Build a Mafy-format file around `source` (inverse of `decode`).

    Used to create synthetic fixtures for the tests; the obfuscator's own keys
    are random per build, so any keys produce a valid file.
    """
    raw = source.encode("latin1")
    masked = [byte ^ key_c[i % len(key_c)] for i, byte in enumerate(raw)]

    # what decode() must see after it interleaves the two blobs
    for left, right in _swaps(seed, len(masked)):
        masked[left - 1], masked[right - 1] = masked[right - 1], masked[left - 1]

    first = masked[0::2]
    second = masked[1::2]
    hex_a = "".join(f"{byte ^ key_a[i % len(key_a)]:02x}" for i, byte in enumerate(first))
    hex_b = "".join(f"{byte ^ key_b[i % len(key_b)]:02x}" for i, byte in enumerate(second))

    def chunk(text: str, count: int, perm: list) -> list:
        size = max(1, -(-len(text) // count))
        pieces = [text[i:i + size] for i in range(0, len(text), size)]
        pieces += [pieces[-1]] * (count - len(pieces))  # keep every slot a real hex chunk
        return [pieces[position - 1] for position in perm]

    count_a = max(1, min(20, len(hex_a) // 2))
    count_b = max(1, min(20, len(hex_b) // 2))
    perm_a = list(range(1, count_a + 1))[::-1]
    perm_b = list(range(1, count_b + 1))[1:] + [1][:count_b]

    def lua_array(values: list) -> str:
        return "{" + ",".join(f'"{v}"' if isinstance(v, str) else str(v) for v in values) + "}"

    return (
        "-- Protected by Mafy Obfuscator | synthetic fixture\n"
        f"local blobA={lua_array(chunk(hex_a, len(perm_a), perm_a))}\n"
        f"local permA={lua_array(perm_a)}\n"
        f"local blobB={lua_array(chunk(hex_b, len(perm_b), perm_b))}\n"
        f"local permB={lua_array(perm_b)}\n"
        f"local keyA={lua_array(key_a)}\n"
        f"local keyB={lua_array(key_b)}\n"
        f"local seed={seed}\n"
        f"local keyC={lua_array(key_c)}\n"
        f"return loadstring(blobA) -- {len(raw)} bytes\n"
    )


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("source", help="Mafy-protected Lua file")
    parser.add_argument("destination", help="where to write the recovered source")
    parser.add_argument("--dump-parts", action="store_true",
                        help="print the parsed blobs/keys instead of decoding")
    options = parser.parse_args(argv)

    with open(options.source, "rb") as handle:
        text = handle.read().decode("latin1")

    if options.dump_parts:
        import json
        print(json.dumps(parse(text), indent=1)[:4000])
        return 0

    decoded = decode(text)
    with open(options.destination, "wb") as handle:
        handle.write(decoded.encode("latin1"))
    print(f"{len(decoded)} bytes -> {options.destination}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
