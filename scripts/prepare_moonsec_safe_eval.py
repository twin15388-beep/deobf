#!/usr/bin/env python3
"""Harden the pinned, separately cloned MoonSec V3 JS tool for offline use.

The upstream JS tool evaluates *key expressions* in Fengari. On an unknown
input that is not safe by default. This narrow patch allows only arithmetic,
local numeric temporaries and control flow, and opens NO Lua standard library.
It does not run the protected top-level or turn a VM dump into game source.

Clone https://github.com/luaprojects/moonsec-js-deobf at PINNED_COMMIT into a
TEMP directory, then run this script with that directory as its only argument.
The GPL-3.0 third-party tool is not copied into this repository. Run the tool
with a process timeout, an empty credential environment and bounded memory.
"""

from __future__ import annotations

import argparse
import hashlib
import subprocess
from pathlib import Path

PINNED_COMMIT = "7a4be80850f2b2a5ad20a02ef486d518f2164b27"
ORIGINAL_SHA256 = "654622aeedf188402c3131ffda3c35d8cc1fc8449905b4509e6f41d7984b01ef"
PATCHED_SHA256 = "6eb525c9f57679f31d652a9b8c5d77f2ba16dbaccb7294b8d020310f826fc42f"
EVALUATOR_PATH = "src/deobf/lua-eval.js"

# Match tiny, unique statements, not a vendored copy of the GPL tool.
OPEN_LIBRARIES = "    lualib.luaL_openlibs(L);"
KEY_EXPRESSION = "        const code = `return (${PrettyPrinter.asString(node)})`;"
SANDBOX = """    // Arithmetic-only sandbox: do not open os, io, package, debug, etc.
    // In particular, key expressions from a protected script are NOT trusted.
    // The external process must also have a memory and wall-clock limit.
"""
VALIDATE_EXPRESSION = """        const expression = PrettyPrinter.asString(node);
        const identifiers = expression.match(/[A-Za-z_][A-Za-z_0-9]*/g) || [];
        const keywords = new Set([
            'and', 'or', 'not', 'function', 'end', 'return',
            'local', 'if', 'then', 'else', 'true', 'false'
        ]);
        if (expression.length > 4096
            || /[^0-9\\s.,()+*/%^\\-<=>A-Za-z_]/.test(expression)
            || identifiers.some(id => !/^_[0-9]+$/.test(id) && !keywords.has(id))) {
            throw new Error('unsafe MoonSec key expression rejected');
        }
        const code = `return (${expression})`;"""


def patch_text(source: str) -> str:
    """Fail closed if this is not the exact expected evaluator shape."""
    if source.count(OPEN_LIBRARIES) != 1 or source.count(KEY_EXPRESSION) != 1:
        raise ValueError("Unrecognized Lua evaluator; refusing to patch")
    source = source.replace(OPEN_LIBRARIES, SANDBOX.rstrip("\n"), 1)
    return source.replace(KEY_EXPRESSION, VALIDATE_EXPRESSION, 1)


def apply(root: Path) -> str:
    root = root.resolve(strict=True)
    result = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "HEAD"],
        capture_output=True, text=True, check=True,
    )
    if result.stdout.strip() != PINNED_COMMIT:
        raise ValueError("MoonSec tool commit differs from pinned, audited version")
    target = root / EVALUATOR_PATH
    if not target.is_file() or target.is_symlink():
        raise ValueError("Expected regular evaluator file")
    source_bytes = target.read_bytes()
    digest = hashlib.sha256(source_bytes).hexdigest()
    if digest == PATCHED_SHA256:
        return "already hardened"
    if digest != ORIGINAL_SHA256:
        raise ValueError("Evaluator differs from pinned original; refusing to patch")
    patched = patch_text(source_bytes.decode("utf-8")).encode("utf-8")
    if hashlib.sha256(patched).hexdigest() != PATCHED_SHA256:
        raise ValueError("Hardened evaluator checksum mismatch; no file changed")
    target.write_bytes(patched)
    return "hardened numeric key evaluation without standard Lua libraries"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("external_checkout", type=Path)
    args = parser.parse_args()
    print(apply(args.external_checkout))


if __name__ == "__main__":
    main()
