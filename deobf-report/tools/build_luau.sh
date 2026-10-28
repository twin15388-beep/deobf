#!/bin/bash
# Build a minimal luau runner + luau-ast from luau-src without cmake
set -e
SRC=/home/user/deobf/work/luau-src
OUT=/home/user/deobf/work/luau-build
BIN=/home/user/deobf/work/luraph15/Deobfuscator-Luraph-V15-master/bin
mkdir -p "$OUT/obj" "$BIN"
INC="-I$SRC -I$SRC/Common/include -I$SRC/Bytecode/include -I$SRC/Config/include -I$SRC/Inliner/include -I$SRC/Require/include -I$SRC/Ast/include -I$SRC/Compiler/include -I$SRC/Analysis/include -I$SRC/CodeGen/include -I$SRC/VM/include -I$SRC/VM/src -I$SRC/CLI/include -I$SRC/extern -I$SRC/extern/isocline/include"
FLAGS="-std=c++17 -O1 -g0 -DNDEBUG $INC"

CORE="$SRC/Common/src/*.cpp $SRC/Ast/src/*.cpp $SRC/Compiler/src/*.cpp $SRC/Bytecode/src/*.cpp $SRC/VM/src/*.cpp"

echo "[*] compiling core objects..."
n=0
for f in $CORE; do
  o="$OUT/obj/$(basename "$f" .cpp).o"
  if [ ! -f "$o" ]; then
    g++ $FLAGS -c "$f" -o "$o" &
    n=$((n+1))
    if [ $((n % 2)) -eq 0 ]; then wait; fi
  fi
done
wait
echo "[*] building luau runner..."
g++ $FLAGS -c /home/user/deobf/work/luau_runner.cpp -o "$OUT/obj/luau_runner.o"
g++ -o "$BIN/luau" "$OUT/obj/luau_runner.o" $(ls "$OUT"/obj/*.o | grep -v luau_runner) -lm -ldl -lpthread
echo "[*] building luau-ast..."
g++ $FLAGS -o "$BIN/luau-ast" "$SRC/CLI/src/Ast.cpp" "$SRC/CLI/src/FileUtils.cpp" "$SRC/CLI/src/Flags.cpp" "$OUT"/obj/*.o -lm -ldl -lpthread
echo "[+] done"
"$BIN/luau" --version || true
