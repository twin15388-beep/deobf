#!/usr/bin/env python3
"""Best-effort decompilation of a Lua 5.1 chunk that unluac cannot finish.

unluac is all-or-nothing: one bad prototype (`IllegalStateException:
IfThenEndBlock`, `Implicit return must have zero values`, ...) aborts the whole
file, and the partial output stops mid-function.  This tool salvages such
chunks:

  1. repair the chunk (`lua51_repair.py`) and try a full decompile;
  2. if that fails, keep whatever unluac printed (`*.partial.lua`);
  3. split the chunk into one chunk per prototype (`lua51_split.py`) and
     decompile each prototype on its own, merging the results into
     `*.salvage.lua`; prototypes that still fail are embedded as pseudo-Lua
     from `lua51_disasm.py`, clearly marked.

usage:
  decompile_salvage.py in.luac out.lua [--java PATH] [--unluac JAR] [-q]
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import lua51_disasm as disasm          # noqa: E402
import lua51_repair                    # noqa: E402
import lua51_split                     # noqa: E402


def sh(cmd, cwd=None):
    return subprocess.run(cmd, capture_output=True, text=True, cwd=cwd)


def decompile(java, jar, chunk, out):
    r = sh([java, "-jar", jar, chunk, "--output", out])
    ok = r.returncode == 0 and os.path.exists(out) and os.path.getsize(out) > 0
    return ok, (r.stderr or "").strip().splitlines()[:1]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("output")
    ap.add_argument("--java", default=os.path.join(HERE, "jdk/jdk4py/java-runtime/bin/java"))
    ap.add_argument("--unluac", default=os.path.join(HERE, "PSU-Deobfuscator/tools/unluac.jar"))
    ap.add_argument("-q", "--quiet", action="store_true")
    a = ap.parse_args()

    def say(*m):
        if not a.quiet:
            print(*m)

    tmp = tempfile.mkdtemp(prefix="salvage_")
    fixed = os.path.join(tmp, "fixed.luac")
    lua51_repair.main.__globals__["sys"].argv = ["lua51_repair", a.input, fixed]
    lua51_repair.main()

    # 1. plain decompile
    ok, err = decompile(a.java, a.unluac, fixed, a.output)
    if ok:
        say("[+] full decompile: %s (%d lines)" %
            (a.output, sum(1 for _ in open(a.output, encoding="utf-8", errors="replace"))))
        shutil.rmtree(tmp, ignore_errors=True)
        return 0

    partial = a.output + ".partial.lua"
    decompile(a.java, a.unluac, fixed, partial)
    plines = sum(1 for _ in open(partial, encoding="utf-8", errors="replace")) if os.path.exists(partial) else 0
    say("[!] unluac aborted: %s (partial output: %d lines)" % (err[0] if err else "?", plines))

    # 2. prototype-by-prototype salvage
    spdir = os.path.join(tmp, "split")
    # plain (unwrapped) prototypes: unluac can decompile those that own no
    # upvalues; wrapping them in a synthetic parent only yields stubs.
    lua51_split.main.__globals__["sys"].argv = ["lua51_split", fixed, spdir]
    lua51_split.main()
    order = [l.split("\t") for l in open(os.path.join(spdir, "MAP.txt")).read().splitlines()]

    merged = ["-- %s\n" % os.path.basename(a.output),
              "-- ВНИМАНИЕ: восстановлено по функциям (unluac не смог разобрать файл целиком).\n"
              "-- Функции, помеченные PSEUDO, даны в виде дизассемблера и не являются исходным Lua.\n"]
    good = bad = 0
    for idx, path, _s, _e in order:
        chunk = os.path.join(spdir, idx + ".luac")
        out = os.path.join(spdir, idx + ".lua")
        ok, _ = decompile(a.java, a.unluac, chunk, out)
        body = None
        if ok:
            text = open(out, encoding="utf-8", errors="replace").read()
            if text.count("\n") > 2:
                body = text
                good += 1
        if body is None:
            pseudo = out + ".pseudo"
            disasm.main.__globals__["sys"].argv = ["lua51_disasm", chunk, pseudo]
            try:
                disasm.main()
                body = "-- PSEUDO (дизассемблер):\n" + \
                    "".join("-- " + l for l in open(pseudo, encoding="utf-8", errors="replace"))
            except SystemExit:
                body = "-- PSEUDO: prototype could not be parsed\n"
            bad += 1
        merged.append("\n-- ══════════ %s ══════════\n" % path)
        merged.append(body if body.endswith("\n") else body + "\n")

    with open(a.output, "w", encoding="utf-8") as f:
        f.write("".join(merged))
    say("[+] salvage: %d prototypes decompiled, %d as pseudo-Lua -> %s" % (good, bad, a.output))
    shutil.rmtree(tmp, ignore_errors=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
