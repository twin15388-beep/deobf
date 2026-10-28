#!/bin/bash
set -e
SRC=/home/user/deobf/work/luau-src
OUT=/home/user/deobf/work/luau-build
BIN=/home/user/deobf/work/luraph15/Deobfuscator-Luraph-V15-master/bin
INC="-I$SRC -I$SRC/Common/include -I$SRC/Bytecode/include -I$SRC/Config/include -I$SRC/Ast/include -I$SRC/Compiler/include -I$SRC/Analysis/include -I$SRC/CodeGen/include -I$SRC/VM/include -I$SRC/VM/src -I$SRC/CLI/include -I$SRC/extern -I$SRC/extern/isocline/include"
FLAGS="-std=c++17 -O1 -g0 -DNDEBUG $INC"
mkdir -p "$OUT/astobj"
for f in "$SRC/Analysis/src/AstJsonEncoder.cpp" "$SRC/Analysis/src/ToString.cpp" "$SRC/Analysis/src/AstUtils.cpp" "$SRC/Analysis/src/AstQuery.cpp"; do
  o="$OUT/astobj/$(basename "$f" .cpp).o"
  [ -f "$o" ] || g++ $FLAGS -c "$f" -o "$o" &
done
wait
g++ $FLAGS -o "$BIN/luau-ast" "$SRC/CLI/src/Ast.cpp" "$SRC/CLI/src/FileUtils.cpp" "$SRC/CLI/src/Flags.cpp" \
   "$OUT"/astobj/*.o $(ls "$OUT"/obj/*.o | grep -v luau_runner) -lm -ldl -lpthread
echo built
"$BIN/luau-ast" /tmp/t.lua | head -5
