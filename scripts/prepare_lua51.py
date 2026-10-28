#!/usr/bin/env python3
"""Build a local Lua 5.1 interpreter from the pinned upstream tag.

The sandbox has no ``lua``/``luac``/``luau`` binary, so syntax checks of the
recovered game samples are performed with an interpreter compiled here from
the official ``lua/lua`` mirror tag ``v5.1.1``. The build is source only: no
Lua input is loaded, executed or downloaded by this script.

The tag ships ``lua.c`` (interpreter) but no ``luac.c``/``print.c``, so the
"compile but do not run" check is expressed through ``loadfile``, which is the
same front end (``lparser.c``/``llex.c``) that ``luac -p`` uses.

Usage:
    python3 scripts/prepare_lua51.py [destination-directory]

Prints the directory containing the ``lua5.1`` binary. Requires ``git``,
``gcc`` and ``make``-free plain compilation.
"""

from __future__ import annotations

import argparse
import hashlib
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

UPSTREAM = "https://github.com/lua/lua.git"
UPSTREAM_TAG = "v5.1.1"
UPSTREAM_COMMIT = "98194db4295726069137d13b8d24fca8cbf892b6"
# Library sources of the tag, minus the interpreter driver and the optional
# test driver (ltests.c) which needs a modified luaconf.h.
CORE_SOURCES = (
    "lapi.c lauxlib.c lbaselib.c lcode.c ldblib.c ldebug.c ldo.c ldump.c "
    "lfunc.c lgc.c linit.c liolib.c llex.c lmathlib.c lmem.c loadlib.c "
    "lobject.c lopcodes.c loslib.c lparser.c lstate.c lstring.c lstrlib.c "
    "ltable.c ltablib.c ltm.c lundump.c lvm.c lzio.c"
).split()


def run(command: list[str], cwd: Path | None = None) -> str:
    result = subprocess.run(command, cwd=cwd, capture_output=True, text=True)
    if result.returncode != 0:
        raise SystemExit(f"command failed ({result.returncode}): {' '.join(command)}\n"
                         f"{result.stdout}{result.stderr}")
    return result.stdout.strip()


def build(destination: Path) -> Path:
    for tool in ("git", "gcc"):
        if shutil.which(tool) is None:
            raise SystemExit(f"missing required tool: {tool}")
    if destination.exists() and any(destination.iterdir()):
        raise SystemExit(f"destination is not empty: {destination}")
    destination.mkdir(parents=True, exist_ok=True)

    source = destination / "lua-5.1.1-src"
    run(["git", "clone", "--quiet", "--depth", "1", "--branch", UPSTREAM_TAG,
         UPSTREAM, str(source)])
    commit = run(["git", "rev-parse", "HEAD"], cwd=source)
    if commit != UPSTREAM_COMMIT:
        raise SystemExit(f"unexpected upstream commit: {commit}")
    missing = [name for name in CORE_SOURCES if not (source / name).is_file()]
    if missing or not (source / "lua.c").is_file():
        raise SystemExit(f"unexpected upstream layout: missing {missing or ['lua.c']}")

    # LUA_USE_POSIX only; readline stays off so no extra system library is
    # needed and the interpreter cannot touch the terminal history.
    run(["gcc", "-O2", "-w", "-DLUA_USE_POSIX", "-o",
         str((destination / "lua5.1").resolve()), "lua.c", *CORE_SOURCES, "-lm"], cwd=source)

    # `lua -e` does not populate `arg`, so the compile-only check lives in a
    # script file next to the interpreter.
    (destination / "check_syntax.lua").write_text(
        "-- Compile each file without running it (loadfile only parses/compiles).\n"
        "local ok = true\n"
        "for index = 1, #arg do\n"
        "  local chunk, message = loadfile(arg[index])\n"
        "  if not chunk then\n"
        "    io.stderr:write(tostring(message), '\\n')\n"
        "    ok = false\n"
        "  else\n"
        "    io.write('OK ', arg[index], '\\n')\n"
        "  end\n"
        "end\n"
        "if not ok then os.exit(1) end\n",
        encoding="utf-8")

    binary = destination / "lua5.1"
    probe = subprocess.run([str(binary), "-v"], capture_output=True, text=True)
    version = f"{probe.stdout}{probe.stderr}".strip()  # lua -v writes to stderr
    if "Lua 5.1" not in version:
        raise SystemExit(f"built interpreter is not Lua 5.1: {version}")
    (destination / "UPSTREAM_COMMIT").write_text(f"{UPSTREAM_TAG} {commit}\n", encoding="utf-8")
    return destination


def syntax_check(directory: Path, targets: list[Path]) -> bool:
    """Compile each target without running it (loadfile only parses)."""
    if not targets:
        return True
    result = subprocess.run([str(directory / "lua5.1"),
                             str(directory / "check_syntax.lua"),
                             *[str(target) for target in targets]],
                            capture_output=True, text=True)
    sys.stdout.write(result.stdout)
    sys.stderr.write(result.stderr)
    return result.returncode == 0


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("destination", nargs="?", default=None,
                        help="empty directory to build into (default: temporary)")
    parser.add_argument("--check", action="append", default=[], metavar="FILE",
                        help="Lua file to compile (not run) after the build")
    args = parser.parse_args()

    destination = Path(args.destination) if args.destination else Path(
        tempfile.mkdtemp(prefix="lua51-"))
    directory = build(destination)
    digest = hashlib.sha256((directory / "lua5.1").read_bytes()).hexdigest()
    print(f"{directory}\t{digest}")
    ok = syntax_check(directory, [Path(name) for name in args.check])
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
