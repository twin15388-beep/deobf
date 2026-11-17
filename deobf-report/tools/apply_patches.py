#!/usr/bin/env python3
"""Apply the Linux/sandbox patches documented in PATCHES.md to the cloned tools.

The tools live in ``work/`` (gitignored). Every patch is anchored on upstream
text and idempotent: a second run reports ``skip`` instead of patching twice.
Anchors come from the revisions recorded in toolchain.json.
"""
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
WORK = ROOT / "work"


def patch(rel, old, new, marker):
    path = WORK / rel
    if not path.is_file():
        raise SystemExit("FAIL missing file: %s" % rel)
    text = path.read_text(encoding="utf-8")
    if marker in text:
        print("skip  %s (already patched)" % rel)
        return
    if old not in text:
        raise SystemExit("FAIL anchor not found in %s" % rel)
    path.write_text(text.replace(old, new, 1), encoding="utf-8")
    print("patch %s" % rel)


def replace_all(rel, old, new, marker, expected):
    path = WORK / rel
    text = path.read_text(encoding="utf-8")
    if marker in text:
        print("skip  %s (already patched)" % rel)
        return
    count = text.count(old)
    if count != expected:
        raise SystemExit("FAIL %s: expected %d occurrences of anchor, found %d"
                         % (rel, expected, count))
    path.write_text(text.replace(old, new), encoding="utf-8")
    print("patch %s (%d sites)" % (rel, count))


# 1. Luraph v15 devirt bridge: JS passes optional args (keep_harness, studio),
#    an absent attribute must read as False instead of raising AttributeError.
patch(
    "luraph15/Deobfuscator-Luraph-V15-master/src/devirt_bridge.py",
    "    class DummyArgs:\n"
    "        def __init__(self, d):\n"
    "            for k, v in d.items():\n"
    "                setattr(self, k, v)\n",
    "    class DummyArgs:\n"
    "        def __init__(self, d):\n"
    "            for k, v in d.items():\n"
    "                setattr(self, k, v)\n"
    "\n"
    "        def __getattr__(self, name):\n"
    "            return False\n",
    "def __getattr__(self, name):",
)

# 2. PSU: keep the recovered Lua 5.1 bytecode even when the decompile step
#    fails (the pipeline repairs the chunk and runs unluac itself).
patch(
    "PSU-Deobfuscator/src/cli.js",
    "  const result = options.check\n"
    "    ? liftFile(options.input)\n"
    "    : deobfuscateFile(options.input, outputPath, options);\n",
    "  let result;\n"
    "  if (options.check) {\n"
    "    result = liftFile(options.input);\n"
    "  } else {\n"
    "    try {\n"
    "      result = deobfuscateFile(options.input, outputPath, options);\n"
    "    } catch (error) {\n"
    "      if (options.bytecode) {\n"
    "        result = liftFile(options.input);\n"
    "        console.error(\"decompile step failed (\" + (error?.message || error) + \"); bytecode only\");\n"
    "      } else {\n"
    "        throw error;\n"
    "      }\n"
    "    }\n"
    "  }\n",
    "decompile step failed",
)

# 3. CASCADE: an unmatched VM (sub)instruction must not abort the whole lift.
#    Skipping produces a partial chunk; lua51_repair/luac_fix validate it later.
replace_all(
    "CASCADE/obfuscators/ironbrew/devirtualize.js",
    '                                throw "ayo"\n',
    '                                console.log("[patched] unmatched sub-instruction; skipped")\n'
    '                                continue\n',
    "[patched] unmatched sub-instruction",
    1,
)
replace_all(
    "CASCADE/obfuscators/ironbrew/devirtualize.js",
    '                    throw "ayo"\n',
    '                    console.log("[patched] unmatched instruction; skipped")\n'
    '                    continue\n',
    "[patched] unmatched instruction;",
    1,
)

# 4. CASCADE: write the real upvalue count and a plain VARARG_ISVARARG flag.
#    Upstream hardcodes nups=0 and is_vararg=2/3, which luaG_checkcode rejects.
patch(
    "CASCADE/utility/binary.js",
    "    buffer.writeUInt32LE(0)\n"
    "    buffer.writeUInt32LE(0)\n"
    "    buffer.writeUInt8(0)\n"
    "    buffer.writeUInt8(chunk.Parameters)\n"
    "    buffer.writeUInt8(chunk.VarArg ? 3 : 2)\n",
    "    buffer.writeUInt32LE(0)\n"
    "    buffer.writeUInt32LE(0)\n"
    "    let upvalue_count = 0\n"
    "    for (let i = 0; i < chunk.Instructions.length; i++) {\n"
    "        const ins = chunk.Instructions[i]\n"
    "        if ((ins.OpCode === 4 || ins.OpCode === 8) && typeof ins.B === \"number\") {\n"
    "            upvalue_count = Math.max(upvalue_count, ins.B + 1)\n"
    "        }\n"
    "    }\n"
    "    buffer.writeUInt8(upvalue_count)\n"
    "    buffer.writeUInt8(chunk.Parameters)\n"
    "    buffer.writeUInt8(1)\n",
    "let upvalue_count = 0",
)

print("patches applied")
