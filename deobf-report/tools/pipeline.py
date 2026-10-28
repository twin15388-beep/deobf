#!/usr/bin/env python3
"""Full deobfuscation pipeline for Roblox Lua/Luau scripts.

Detects the obfuscator, runs the matching external deobfuscator, repairs the
emitted Lua 5.1 bytecode when needed, decompiles it back to readable Lua and
finally extracts the script's "parts" (features, UI library, remotes, webhooks).

usage:
  pipeline.py INPUT.lua --out RESULTS_DIR [--tools-root DIR] [-v]

Typical layout of --tools-root (all cloned/built by tools/install_tools.sh):
  luraph15/Deobfuscator-Luraph-V15-master/deob.js
  moonsec-js-deobf/bin/moonsec.js
  moonsec-v2-deobfuscator/main.py
  PSU-Deobfuscator/src/cli.js
  CASCADE/index.js                        (IronBrew 2.7 / MSVM)
  unprom.py                               (Prometheus / LuaObfuscator)
  jdk/jdk4py/java-runtime/bin/java
  PSU-Deobfuscator/tools/unluac.jar
"""
import argparse
import os
import re
import shutil
import subprocess
import sys

MARKERS = [
    ("luraph_v15", [r"Luraph Obfuscator v15", r"lura\.ph", r"LPH_ENCSTR", r"LPH_NO_VIRTUALIZE"]),
    ("luraph_v14", [r"Luraph Obfuscator v14", r"Luraph v14"]),
    ("moonsec_v2", [r"Protected_by_MoonSecV2", r"MoonSecV2", r"MoonSec V2"]),
    ("moonsec_v3", [r"Protected_by_MoonSecV3", r"MoonSec V3"]),
    ("psu", [r"PSU Obfuscator 4\.[05]", r"psu\.dev"]),
    ("prometheus", [r"Prometheus", r"VMify", r"prometheus"]),
    ("keyforge", [r"Keyforge", r"keyforge\.win", r"ForgeVM"]),
    ("ironbrew", [r"IronBrew", r"Ironbrew"]),
    ("boronide", [r"Boronide\u2122", r"Boronide Obfuscation"]),
    ("aztupbrew", [r"AztupBrew", r"AzTupBrew"]),
    ("wynfuscate", [r"wYnFuscate"]),
    ("moonveil", [r"MoonVeil"]),
    ("ironbrew1", [r"generated using ironbrew1"]),
    ("moonsec_v2", [r"Protected by Gerald32212", r"\b_0xG = \{"]),
    ("moonsec_v3", [r"_msec"]),

]


def detect(src):
    head = "\n".join(src.splitlines()[:80])
    for name, pats in MARKERS:
        for p in pats:
            if re.search(p, head, re.M):
                return name
    return "unknown"


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, text=True, **kw)


class Pipe:
    def __init__(self, args):
        self.a = args
        self.root = args.tools_root
        self.java = os.path.join(self.root, "jdk/jdk4py/java-runtime/bin/java")
        self.unluac = os.path.join(self.root, "PSU-Deobfuscator/tools/unluac.jar")
        self.log = []

    @staticmethod
    def plausible(path):
        """cheap sanity check that a decompiled file actually contains script code"""
        try:
            txt = open(path, encoding="utf-8", errors="replace").read()
        except OSError:
            return False
        if len(txt.splitlines()) < 5:
            return False
        return any(k in txt for k in ("game", "HttpGet", "Instance", "Players",
                                      "print", "loadstring", "workspace"))

    def note(self, msg):
        self.log.append(msg)
        if self.a.verbose:
            print("   " + msg, file=sys.stderr)

    # ---------- bytecode -> readable Lua ----------
    def decompile(self, luac_path, out_lua):
        here = os.path.dirname(os.path.abspath(__file__))
        fixed = luac_path + ".fixed"
        r = run([sys.executable, os.path.join(here, "lua51_repair.py"), luac_path, fixed])
        if r.returncode != 0:
            self.note("repair failed: " + r.stderr.strip()[:200])
            shutil.copy(luac_path, fixed)
        if not os.path.exists(self.java):
            self.note("no JVM (%s): falling back to the built-in disassembler" % self.java)
            run([sys.executable, os.path.join(here, "lua51_disasm.py"), fixed, out_lua + ".dis.txt"])
            return False
        r = run([self.java, "-jar", self.unluac, fixed, "--output", out_lua])
        if r.returncode != 0 or not os.path.exists(out_lua):
            self.note("unluac failed: " + (r.stderr.strip().splitlines() or [""])[0][:160])
            run([sys.executable, os.path.join(here, "lua51_disasm.py"), fixed, out_lua + ".dis.txt"])
            return False
        self.note("unluac: %d lines" % len(open(out_lua, encoding="utf-8", errors="replace").readlines()))
        return True

    # ---------- individual obfuscators ----------
    def do_luraph(self, src_path, outdir, kind):
        deob = os.path.join(self.root, "luraph15/Deobfuscator-Luraph-V15-master/deob.js")
        if not os.path.exists(deob):
            self.note("luraph deobfuscator not installed")
            return None
        out = os.path.join(outdir, "deobfuscated.lua")
        r = run(["node", deob, src_path, "-o", out, "--timeout", "600"], cwd=os.path.dirname(deob))
        self.note("luraph15 exit=%d %s" % (r.returncode, (r.stdout or "").strip().splitlines()[-1:]))
        return out if os.path.exists(out) else None

    def do_psu(self, src_path, outdir):
        cli = os.path.join(self.root, "PSU-Deobfuscator/src/cli.js")
        luac = os.path.join(outdir, "extracted.luac")
        r = run(["node", cli, os.path.abspath(src_path), "--bytecode", os.path.abspath(luac)])
        self.note("psu exit=%d %s" % (r.returncode, (r.stdout or "").strip().splitlines()[-1:]))
        return luac if os.path.exists(luac) else None

    def do_moonsec_v3(self, src_path, outdir):
        cli = os.path.join(self.root, "moonsec-js-deobf/bin/moonsec.js")
        luac = os.path.join(outdir, "extracted.luac")
        r = run(["node", cli, "-dev", "-i", src_path, "-o", luac])
        self.note("moonsec-v3 exit=%d %s" % (r.returncode, (r.stdout or "").strip()[-80:]))
        return luac if os.path.exists(luac) else None

    def do_moonsec_v2(self, src_path, outdir):
        main = os.path.join(self.root, "moonsec-v2-deobfuscator/main.py")
        out = os.path.join(outdir, "deobfuscated.lua")
        tmp = os.path.join(outdir, "msv2")
        os.makedirs(tmp, exist_ok=True)
        r = run([sys.executable, main, src_path], cwd=tmp)
        produced = os.path.join(tmp, "out.lua")
        if not os.path.exists(produced):
            produced = os.path.join(tmp, "output.lua")
        if os.path.exists(produced):
            shutil.copy(produced, out)
            self.note("moonsec-v2 ok (%d bytes)" % os.path.getsize(out))
            return out
        self.note("moonsec-v2 exit=%d %s" % (r.returncode, (r.stderr or "").strip()[-120:]))
        return None

    def do_cascade(self, src_path, outdir):
        d = os.path.join(self.root, "CASCADE")
        if not os.path.exists(os.path.join(d, "index.js")):
            self.note("CASCADE not installed")
            return None
        shutil.copy(src_path, os.path.join(d, "input.lua"))
        luac = os.path.join(d, "output.luac")
        if os.path.exists(luac):
            os.remove(luac)
        r = run(["node", "index.js"], cwd=d)
        out = (r.stdout or "") + (r.stderr or "")
        if "No Matched Instruction" in out:
            self.note("CASCADE could not match all instructions (unsupported superinstruction)")
            return None
        if os.path.exists(luac):
            dst = os.path.join(outdir, "extracted.luac")
            shutil.copy(luac, dst)
            self.note("CASCADE ok %s" % (r.stdout or "").strip().splitlines()[-1:])
            return dst
        self.note("CASCADE failed: %s" % (r.stdout or r.stderr).strip()[-120:])
        return None

    def do_promaxom(self, src_path, outdir):
        cli = os.path.join(self.root, "prometheus-deobfuscator-by-axom/cli.py")
        if not os.path.exists(cli):
            self.note("prometheus-axom not installed")
            return None
        out = os.path.join(outdir, "deobfuscated.axom.lua")
        r = run([sys.executable, cli, src_path, "-o", out], cwd=os.path.dirname(cli))
        self.note("prometheus-axom exit=%d" % r.returncode)
        return out if os.path.exists(out) else None

    def do_unprom(self, src_path, outdir):
        tool = os.path.join(self.root, "unprom/unprom.py")
        if not os.path.exists(tool):
            self.note("unprom not installed")
            return None
        out = os.path.join(outdir, "deobfuscated.lua")
        r = run([sys.executable, tool, src_path, "-o", out])
        self.note("unprom exit=%d %s" % (r.returncode, (r.stdout or r.stderr).strip()[-90:]))
        return out if os.path.exists(out) else None

    # ---------- driver ----------
    def process(self, src_path, outdir):
        src_path = os.path.abspath(src_path)
        outdir = os.path.abspath(outdir)
        src = open(src_path, encoding="utf-8", errors="replace").read()
        kind = detect(src)
        os.makedirs(outdir, exist_ok=True)
        self.note("detected: %s" % kind)

        # stale outputs from a previous run must not be mistaken for success
        for f in ("deobfuscated.lua", "extracted.luac"):
            fp = os.path.join(outdir, f)
            if os.path.exists(fp):
                os.remove(fp)

        result = None
        CHAIN = {
            "psu": self.do_psu,
            "moonsec_v3": self.do_moonsec_v3,
            "ironbrew": self.do_cascade,
            "ironbrew1": self.do_cascade,
            "keyforge": self.do_cascade,
        }

        def via_bytecode(fn):
            luac = fn(src_path, outdir)
            if not luac or os.path.getsize(luac) < 200:
                return None
            out = os.path.join(outdir, "deobfuscated.lua")
            return out if self.decompile(luac, out) else None

        if kind in ("luraph_v15", "luraph_v14"):
            result = self.do_luraph(src_path, outdir, kind)
            if result and os.path.getsize(result) < 4000:
                self.note("luraph: output is a staged loader (small file)")
        elif kind == "psu":
            result = via_bytecode(self.do_psu)
        elif kind == "moonsec_v3":
            result = via_bytecode(self.do_moonsec_v3)
        elif kind == "moonsec_v2":
            result = self.do_moonsec_v2(src_path, outdir)
            if not result:
                result = via_bytecode(self.do_psu)
        elif kind in ("ironbrew", "ironbrew1", "keyforge"):
            result = via_bytecode(self.do_cascade)
        elif kind == "prometheus":
            a = self.do_unprom(src_path, outdir)
            b = self.do_promaxom(src_path, outdir)
            cands = [c for c in (a, b) if c]
            result = max(cands, key=lambda p: os.path.getsize(p)) if cands else None
            if result and result.endswith(".axom.lua"):
                shutil.copy(result, os.path.join(outdir, "deobfuscated.lua"))
                result = os.path.join(outdir, "deobfuscated.lua")
        elif kind == "unknown":
            self.note("obfuscator not recognised; trying every bytecode producer")
            for name in ("psu", "moonsec_v3", "ironbrew"):
                out = via_bytecode(CHAIN[name])
                if out and self.plausible(out):
                    self.note("fallback chain: %s produced plausible output" % name)
                    kind = name + " (via fallback)"
                    result = out
                    break
            if not result:
                self.note("fallback chain exhausted")
        else:
            self.note("no dedicated static deobfuscator for %s" % kind)

        # generic last resort: Prometheus-style constant unfolding
        if not result and kind not in ("luraph_v15", "luraph_v14"):
            out = self.do_unprom(src_path, outdir)
            if out and self.plausible(out):
                kind = kind + " (via unprom)"
                result = out
            elif out and os.path.exists(out):
                os.remove(out)

        if result and os.path.exists(result):
            r = run([sys.executable, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                                  "extract_parts.py"), result,
                     "-o", os.path.join(outdir, "PARTS.md")])
            if r.returncode != 0:
                self.note("extract_parts failed: " + r.stderr[-160:])
        return kind, result


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("input")
    ap.add_argument("--out", required=True, help="output directory (one per script)")
    ap.add_argument("--tools-root", default=os.path.dirname(os.path.abspath(__file__)))
    ap.add_argument("-v", "--verbose", action="store_true")
    a = ap.parse_args()

    p = Pipe(a)
    kind, result = p.process(a.input, a.out)
    shutil.copy(a.input, os.path.join(a.out, "source.original.lua"))
    with open(os.path.join(a.out, "LOG.txt"), "w", encoding="utf-8") as f:
        f.write("input: %s\ndetected: %s\nresult: %s\n\n" % (a.input, kind, result))
        f.write("\n".join(p.log) + "\n")
    print("%-12s -> %s" % (kind, result or "FAILED"))


if __name__ == "__main__":
    main()
