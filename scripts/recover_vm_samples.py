#!/usr/bin/env python3
"""Inspect or lift pinned, never-executed AztupBrew-like Script-Dump samples.

Usage: python3 scripts/recover_vm_samples.py INPUT.lua --output /tmp/recovered.luac
       python3 scripts/recover_vm_samples.py INPUT.lua --inspect

An unrecognized SHA-256 or an incomplete VM opcode profile is a hard error.
Outputs are Lua 5.1 *bytecode*, not claims of recovered Lua source.  Decompile
and manually verify those outputs separately; do not run suspect Roblox code.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import sys

from vm_static.decode import DecodeError, walk
from vm_static.lift import LiftError, lift, read_profile


def main(argv: list[str] | None = None) -> int:
    cli = argparse.ArgumentParser(description=__doc__)
    cli.add_argument("input", type=Path, help="exact pinned upstream VM wrapper")
    cli.add_argument("--output", type=Path, help="where to write lifted Lua 5.1 bytecode")
    cli.add_argument("--inspect", action="store_true", help="inspect the decoded VM container only")
    args = cli.parse_args(argv)
    if args.inspect == bool(args.output):
        cli.error("choose exactly one of --inspect or --output")
    try:
        content = args.input.read_bytes()
        profile, prototype, blob = read_profile(content)
        parts = list(walk(prototype))
        print(f"Input: {profile.name} SHA-256={profile.sha256}")
        print(f"Decoded VM blob: {len(blob)} bytes; {len(parts)} prototypes; "
              f"{sum(len(p['ins']) for p in parts)} VM instructions")
        if args.inspect:
            for index, part in enumerate(parts):
                print(f"  prototype #{index}: depth={part['depth']} "
                      f"params={part['params']} instructions={len(part['ins'])}")
            if not profile.liftable:
                print("No complete opcode map: this is ONLY a decoded VM container.")
        else:
            if args.input.resolve() == args.output.resolve():
                raise LiftError("output cannot overwrite protected input")
            _, bytecode, stats = lift(content)
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_bytes(bytecode)
            print(f"Lifted: {args.output} ({len(bytecode)} bytes); "
                  "decompile AND verify before calling it source code.")
        return 0
    except (DecodeError, LiftError, OSError) as error:
        print(f"FAIL: {error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
