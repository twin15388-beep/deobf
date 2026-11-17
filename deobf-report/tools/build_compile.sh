#!/bin/bash
# Build luau-compile (luau-src CLI/src/Compile.cpp) from source without cmake.
# Needed by MoonVeil/Centurion community deobfuscators that compile recovered
# Luau for verification. Mirrors build_ast.sh; reuses core objects from
# build_luau.sh ($WORK/luau-build/obj) and adds the CodeGen backend.
set -e
WORK=/home/user/deobf/work
SRC="$WORK/luau-src"
OUT="$WORK/luau-build"
BIN="$WORK/luraph15/Deobfuscator-Luraph-V15-master/bin"
INC="-I$SRC -I$SRC/Common/include -I$SRC/Bytecode/include -I$SRC/Config/include -I$SRC/Inliner/include -I$SRC/Require/include -I$SRC/Ast/include -I$SRC/Compiler/include -I$SRC/Analysis/include -I$SRC/CodeGen/include -I$SRC/VM/include -I$SRC/VM/src -I$SRC/CLI/include -I$SRC/extern -I$SRC/extern/isocline/include"
FLAGS="-std=c++17 -O1 -g0 -DNDEBUG $INC"
mkdir -p "$OUT/codegen-obj" "$BIN"
echo "[*] compiling CodeGen objects..."
n=0
for f in "$SRC"/CodeGen/src/*.cpp; do
  o="$OUT/codegen-obj/$(basename "$f" .cpp).o"
  if [ ! -f "$o" ]; then
    g++ $FLAGS -c "$f" -o "$o" &
    n=$((n+1))
    if [ $((n % 2)) -eq 0 ]; then wait; fi
  fi
done
wait
g++ $FLAGS -c "$SRC/CLI/src/Compile.cpp" -o "$OUT/codegen-obj/Compile.cli.o"
g++ $FLAGS -c "$SRC/CLI/src/FileUtils.cpp" -o "$OUT/codegen-obj/FileUtils.cli.o"
g++ $FLAGS -c "$SRC/CLI/src/Flags.cpp" -o "$OUT/codegen-obj/Flags.cli.o"
echo "[*] linking luau-compile..."
CORE_OBJS=$(ls "$OUT"/obj/*.o | grep -v luau_runner)
g++ -o "$BIN/luau-compile" "$OUT"/codegen-obj/*.o $CORE_OBJS -lm -ldl -lpthread
"$BIN/luau-compile" 2>&1 | head -2 || true
echo "[+] bin/luau-compile built"
