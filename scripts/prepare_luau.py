#!/usr/bin/env python3
"""Build a local Luau CLI (``luau``, ``luau-analyze``, ``luau-compile``).

The sandbox has no ``luau``/``luau-compile`` binary and no system CMake, so
Luau is compiled here from the pinned upstream tag ``0.739`` (the tag the
vendored Luraph devirtualizer targets). The build is source-only: no Lua/Luau
input is loaded, executed or downloaded by this script.

What the resulting binaries are used for:

* ``luau`` — run ``tests/test_*.lua`` that are Luau-flavoured;
* ``luau-analyze`` — parse/type diagnostics without executing the file;
* ``luau-compile --text`` — compile (parse) only, which is the cheapest syntax
  gate, and ``luau-compile --binary`` — produce **native Luau bytecode** so the
  vendored Luau decompilers (``focatdev/Koralys``, ``Collafranca/Umbra``) can be
  exercised end-to-end on bytecode we compiled ourselves.

CMake is not part of the image. Either install a system CMake or fetch the
PyPI wheel into a local directory::

    pip3 install --target local-results/pylibs cmake
    PYTHONPATH=local-results/pylibs local-results/pylibs/bin/cmake --version

This script also looks for ``local-results/pylibs/bin/cmake`` automatically.

Usage::

    python3 scripts/prepare_luau.py [destination-directory] [--check FILE ...]

Prints the directory holding the binaries and their SHA-256. Requires ``git``,
``g++`` and CMake.
"""

from __future__ import annotations

import argparse
import hashlib
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parents[1]
UPSTREAM = "https://github.com/luau-lang/luau.git"
UPSTREAM_TAG = "0.739"
UPSTREAM_COMMIT = "a62362a53ddc9c629b0e29378a84abb4534d8b64"
# ``Luau.Analyze.CLI`` drags in the whole Analysis library and roughly triples
# the build time on two cores; it is only built when explicitly requested.
TARGETS = ("Luau.Repl.CLI", "Luau.Compile.CLI")
ANALYZE_TARGET = "Luau.Analyze.CLI"


def cmake() -> str:
    for candidate in (shutil.which("cmake"),
                      str(ROOT / "local-results" / "pylibs" / "bin" / "cmake")):
        if candidate and Path(candidate).is_file() and os.access(candidate, os.X_OK):
            return candidate
    raise SystemExit(
        "cmake not found; install it or run:\n"
        "  pip3 install --target local-results/pylibs cmake")


def run(command: list[str], cwd: Path | None = None) -> str:
    environment = dict(os.environ)
    local_libs = str(ROOT / "local-results" / "pylibs")
    if Path(local_libs).is_dir():
        environment["PYTHONPATH"] = os.pathsep.join(
            filter(None, [local_libs, environment.get("PYTHONPATH")]))
    result = subprocess.run(command, cwd=cwd, capture_output=True, text=True,
                            env=environment)
    if result.returncode != 0:
        raise SystemExit(f"command failed ({result.returncode}): {' '.join(command)}\n"
                         f"{result.stdout[-4000:]}{result.stderr[-4000:]}")
    return result.stdout.strip()


def build(destination: Path, with_analyze: bool = False) -> Path:
    for tool in ("git", "g++"):
        if shutil.which(tool) is None:
            raise SystemExit(f"missing required tool: {tool}")
    if destination.exists() and any(destination.iterdir()):
        raise SystemExit(f"destination is not empty: {destination}")
    destination.mkdir(parents=True, exist_ok=True)

    source = destination / f"luau-{UPSTREAM_TAG}-src"
    run(["git", "clone", "--quiet", "--depth", "1", "--branch", UPSTREAM_TAG,
         UPSTREAM, str(source)])
    commit = run(["git", "rev-parse", "HEAD"], cwd=source)
    if commit != UPSTREAM_COMMIT:
        raise SystemExit(f"unexpected upstream commit: {commit}")
    if (source / "CLI" / "Compile.cpp").is_file() is False:
        raise SystemExit("unexpected upstream layout: no CLI/Compile.cpp")

    build_dir = source / "build"
    run([cmake(), "-S", str(source), "-B", str(build_dir),
         "-DCMAKE_BUILD_TYPE=Release", "-DLUAU_BUILD_TESTS=OFF",
         "-DLUAU_BUILD_WEB=OFF"])
    run([cmake(), "--build", str(build_dir), "--target", *TARGETS, "--parallel", "2"])

    if with_analyze:
        run([cmake(), "--build", str(build_dir), "--target", ANALYZE_TARGET,
             "--parallel", "2"])
    produced = {}
    for name in ("luau", "luau-analyze", "luau-compile"):
        if name == "luau-analyze" and not with_analyze:
            continue
        matches = [path for path in build_dir.rglob(name) if path.is_file()]
        if not matches:
            raise SystemExit(f"build did not produce {name}")
        produced[name] = matches[0]
        shutil.copyfile(matches[0], destination / name)
        (destination / name).chmod(0o755)

    (destination / "UPSTREAM_COMMIT").write_text(
        f"{UPSTREAM_TAG} {commit}\n", encoding="utf-8")
    return destination


def compile_only(directory: Path, targets: list[Path]) -> bool:
    """Parse+compile each file without executing it."""
    ok = True
    for target in targets:
        result = subprocess.run([str(directory / "luau-compile"), "--text", str(target)],
                                capture_output=True, text=True)
        if result.returncode != 0:
            sys.stderr.write(result.stdout + result.stderr)
            ok = False
        else:
            print(f"OK {target}")
    return ok


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("destination", nargs="?", default=None,
                        help="empty directory to build into (default: temporary)")
    parser.add_argument("--check", action="append", default=[], metavar="FILE",
                        help="Luau file to compile (not run) after the build")
    parser.add_argument("--with-analyze", action="store_true",
                        help="also build luau-analyze (slow: whole Analysis library)")
    args = parser.parse_args()

    destination = Path(args.destination) if args.destination else Path(
        tempfile.mkdtemp(prefix="luau-"))
    directory = build(destination)
    digests = {name: hashlib.sha256((directory / name).read_bytes()).hexdigest()
               for name in ("luau", "luau-analyze", "luau-compile")}
    print(f"{directory}\t{digests['luau']}")
    ok = compile_only(directory, [Path(name) for name in args.check])
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
