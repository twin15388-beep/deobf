#!/bin/bash
# Build bin/luau-ast (JSON AST dumper) from Luau 0.744 without cmake.
# Requires the core objects produced by build_luau.sh.
set -e
ROOT=/home/user/deobf
SRC=$ROOT/work/luau-src
OUT=$ROOT/work/luau-build
BIN=$ROOT/work/luraph15/Deobfuscator-Luraph-V15-master/bin
INC="-I$SRC -I$SRC/Common/include -I$SRC/Bytecode/include -I$SRC/Config/include -I$SRC/Ast/include -I$SRC/Compiler/include -I$SRC/Analysis/include -I$SRC/CodeGen/include -I$SRC/VM/include -I$SRC/VM/src -I$SRC/CLI/include -I$SRC/Inliner/include -I$SRC/Require/include -I$SRC/extern -I$SRC/extern/isocline/include"
FLAGS="-std=c++17 -O1 -g0 -DNDEBUG $INC"

mkdir -p "$OUT/obj" "$BIN"
if ! ls "$OUT"/obj/*.o >/dev/null 2>&1; then
  bash "$(dirname "$0")/build_luau.sh"
fi

# AstJsonEncoder.cpp declares the fast flag externally; CLI/src/Ast.cpp calls
# Luau::toString(Location, int, bool), which is not in the core objects.
cat > "$OUT/flags_stub.cpp" <<'EOF'
#include "Luau/Common.h"
LUAU_FASTFLAGVARIABLE(LuauExperimentalIfLocalAnalysis)
EOF
cat > "$OUT/locstub.cpp" <<'EOF'
#include <string>
#include "Luau/Location.h"
namespace Luau { std::string toString(const Location&, int, bool) { return std::string(); } }
EOF

OBJS=$(ls "$OUT"/obj/*.o | grep -v luau_runner)
g++ $FLAGS -o "$BIN/luau-ast" \
   "$SRC/CLI/src/Ast.cpp" "$SRC/CLI/src/FileUtils.cpp" "$SRC/CLI/src/Flags.cpp" \
   "$SRC/Analysis/src/AstJsonEncoder.cpp" "$OUT/flags_stub.cpp" "$OUT/locstub.cpp" \
   $OBJS -lm -ldl -lpthread

printf 'local a = 1\nprint(a)\n' > "$OUT/ast_smoke.lua"
"$BIN/luau-ast" "$OUT/ast_smoke.lua" | head -c 120
echo
echo "built $BIN/luau-ast"
