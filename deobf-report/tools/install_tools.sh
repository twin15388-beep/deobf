#!/usr/bin/env bash
# Idempotent toolchain installer for deobf-report/tools/pipeline.py.
# Everything lands in work/ (gitignored), so the repository stays clean.
# Re-running is safe: clones, npm installs and builds are skipped when present.
#
#   bash deobf-report/tools/install_tools.sh                 # tools only
#   bash deobf-report/tools/install_tools.sh --with-corpus   # + validation corpora
#
# Pinned revisions live in toolchain.json. If an upstream HEAD moves, this
# script fails loudly instead of silently installing an unmeasured version.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
TOOLS="$ROOT/deobf-report/tools"
WORK="$ROOT/work"
WITH_CORPUS=0
[ "${1:-}" = "--with-corpus" ] && WITH_CORPUS=1

echo "[*] root=$ROOT"
echo "[*] work=$WORK (gitignored)"
if [ "$ROOT" != "/home/user/deobf" ]; then
  echo "[!] build_luau.sh / build_ast.sh hardcode /home/user/deobf/work; symlink the checkout there"
fi
mkdir -p "$WORK/dl" "$WORK/jdk"

clone_head() {
  local url=$1 dir=$2 sha=$3
  if [ -d "$WORK/$dir/.git" ]; then
    local got; got=$(git -C "$WORK/$dir" rev-parse HEAD)
    if [ "$got" = "$sha" ]; then echo "[=] $dir @ ${sha:0:8}"; return; fi
    echo "[!] $dir HEAD=$got, pinned=$sha; removing and re-cloning"
    rm -rf "$WORK/$dir"
  fi
  git clone --depth 1 --quiet "$url" "$WORK/$dir"
  local got; got=$(git -C "$WORK/$dir" rev-parse HEAD)
  if [ "$got" != "$sha" ]; then
    echo "FAIL $dir: HEAD=$got, expected $sha. Update toolchain.json and re-run." >&2
    exit 1
  fi
  echo "[+] $dir @ ${sha:0:8}"
}

clone_tag() {
  local url=$1 dir=$2 tag=$3 sha=$4
  if [ -d "$WORK/$dir/.git" ]; then
    local got; got=$(git -C "$WORK/$dir" rev-parse HEAD)
    if [ "$got" = "$sha" ]; then echo "[=] $dir @ $tag"; return; fi
    rm -rf "$WORK/$dir"
  fi
  git clone --depth 1 --branch "$tag" --quiet "$url" "$WORK/$dir"
  local got; got=$(git -C "$WORK/$dir" rev-parse HEAD)
  [ "$got" = "$sha" ] || { echo "FAIL $dir: tag $tag = $got, expected $sha" >&2; exit 1; }
  echo "[+] $dir @ $tag (${sha:0:8})"
}

echo "=== 1. committed archives ==="
if [ ! -f "$WORK/luraph15/Deobfuscator-Luraph-V15-master/deob.js" ]; then
  unzip -q -o "$ROOT/deobf-report/tools/vendor/Deobfuscator-Luraph-V15-master.zip" -d "$WORK/luraph15"
fi
if [ ! -d "$WORK/luau-vmp-deobf-main/luauvmp" ]; then
  unzip -q -o "$ROOT/deobf-report/tools/vendor/luau-vmp-deobf-main.zip" -d "$WORK"
fi
cp "$TOOLS/luau_runner.cpp" "$WORK/luau_runner.cpp"
echo "[+] archives unpacked"

echo "=== 2. pinned tool clones ==="
clone_head https://github.com/memcpython/PSU-Deobfuscator.git PSU-Deobfuscator 7d955d4d8e3bc14b744dc4afd52118787fc2bda4
clone_head https://github.com/luaprojects/moonsec-js-deobf.git moonsec-js-deobf 7a4be80850f2b2a5ad20a02ef486d518f2164b27
clone_head https://github.com/neosnappp/moonsec-v2-deobfuscator.git moonsec-v2-deobfuscator b1caa0cd703dedb86b3a43078c40e3f3d045b742
clone_head https://github.com/disingeunity/CASCADE.git CASCADE c18d7e6ffd73d8d0a801d9f151476bfa9f76e274
clone_head https://github.com/yennylol/unprom.git unprom d37b9d97746160359fb68dbdbb5213317403e669
clone_head https://github.com/0x251/Prometheus-Deobfuscator.git prometheus-deobfuscator-by-axom 7d0582fc2d150713941f02f8988323629dd054e7
clone_head https://github.com/HansWessels/unluac.git unluac 1b2bfed6045eb719a27f026311744d7a674847f5
clone_head https://github.com/axomtools/ironbrew2-deobfuscator.git ironbrew2-deobfuscator dbd391e8c466dcbe7acf8611bad73ef5c6ad3122
clone_tag https://github.com/luau-lang/luau.git luau-src 0.744 32c28089305f488f901aaf1dbf3fd1cb65fa3d11
clone_tag https://github.com/lua/lua.git lua51 v5.1.1 98194db4295726069137d13b8d24fca8cbf892b6

echo "=== 3. JRE (jdk4py 25.0.5.0) + unluac.jar ==="
WHEEL="$WORK/dl/jdk4py-25.0.5.0-py3-none-manylinux_2_17_x86_64.whl"
[ -f "$WHEEL" ] || python3 -m pip download --no-deps --quiet -d "$WORK/dl" "jdk4py==25.0.5.0"
if [ ! -x "$WORK/jdk/jdk4py/java-runtime/bin/java" ]; then
  rm -rf "$WORK/jdk/jdk4py"
  python3 -m zipfile -e "$WHEEL" "$WORK/jdk/"
  chmod -R +x "$WORK/jdk/jdk4py/java-runtime/bin" "$WORK/jdk/jdk4py/java-runtime/lib" || true
fi
"$WORK/jdk/jdk4py/java-runtime/bin/java" -version 2>&1 | head -1
[ -f "$WORK/PSU-Deobfuscator/tools/unluac.jar" ] || { echo "FAIL unluac.jar missing" >&2; exit 1; }
"$WORK/jdk/jdk4py/java-runtime/bin/java" -jar "$WORK/PSU-Deobfuscator/tools/unluac.jar" --help 2>&1 | head -1

echo "=== 4. npm dependencies ==="
for d in moonsec-js-deobf CASCADE PSU-Deobfuscator; do
  (cd "$WORK/$d" && npm install --no-audit --no-fund --loglevel=error >/dev/null)
  echo "[+] $d npm deps"
done

echo "=== 5. Lua 5.1.1 interpreter (bytecode validation) ==="
if [ ! -x "$WORK/lua51/lua" ]; then
  (cd "$WORK/lua51" && gcc -O2 -w -DLUA_USE_POSIX -DLUA_USE_DLOPEN -o lua lua.c $(ls *.c | grep -v '^lua.c$') -lm -ldl)
fi
"$WORK/lua51/lua" -v 2>&1 | head -1

echo "=== 6. Luau 0.744: bin/luau + bin/luau-ast ==="
bash "$TOOLS/build_luau.sh"
bash "$TOOLS/build_ast.sh"

echo "=== 7. patches from PATCHES.md ==="
python3 "$TOOLS/apply_patches.py"
python3 -m py_compile "$WORK/luraph15/Deobfuscator-Luraph-V15-master/src/devirt_bridge.py"
node --check "$WORK/PSU-Deobfuscator/src/cli.js"
node --check "$WORK/CASCADE/obfuscators/ironbrew/devirtualize.js"
node --check "$WORK/CASCADE/utility/binary.js"

if [ "$WITH_CORPUS" = "1" ]; then
  echo "=== 8. validation corpora (optional) ==="
  fetch_corpus() {
    local repo=$1 dir=$2
    local tarball="$WORK/dl/$dir.tar.gz"
    [ -f "$tarball" ] || curl -sSL --max-time 300 -o "$tarball" "https://codeload.github.com/$repo/tar.gz/refs/heads/main"
    if [ ! -d "$WORK/corpus/$dir" ]; then
      mkdir -p "$WORK/corpus/$dir"
      tar -xzf "$tarball" -C "$WORK/corpus/$dir" --strip-components=1
    fi
    echo "[+] $dir: $(find "$WORK/corpus/$dir" -type f -iname '*.lua' | wc -l) lua files"
  }
  fetch_corpus hexahigh/Scripts hexahigh
  fetch_corpus hankiwastaken/Cracks hankiwastaken_Cracks
  fetch_corpus XxBoomer/script XxBoomer_script
fi

echo "=== 9. entry-point verification ==="
for p in \
  luraph15/Deobfuscator-Luraph-V15-master/deob.js \
  luraph15/Deobfuscator-Luraph-V15-master/bin/luau \
  luraph15/Deobfuscator-Luraph-V15-master/bin/luau-ast \
  PSU-Deobfuscator/src/cli.js PSU-Deobfuscator/tools/unluac.jar \
  moonsec-js-deobf/bin/moonsec.js moonsec-v2-deobfuscator/main.py \
  CASCADE/index.js unprom/unprom.py jdk/jdk4py/java-runtime/bin/java \
  lua51/lua; do
  [ -e "$WORK/$p" ] || { echo "FAIL missing $WORK/$p" >&2; exit 1; }
done
echo "[+] all pipeline entry points present"
echo "INSTALL_OK"
