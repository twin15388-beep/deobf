#!/usr/bin/env bash
# Дымовой прогон собранного файла вне игры: заглушки Roblox + реальный Luau.
#   tools/smoke.sh [файл]        (по умолчанию ouroboros_recon.lua)
# Собранный тест остаётся в /tmp/smoke.lua — по нему видно номера строк.
set -euo pipefail
cd "$(dirname "$0")/.."
LUAU=${LUAU:-/home/user/tooling/luau/luau}
SRC=${1:-ouroboros_recon.lua}
OUT=${OUT:-/tmp/smoke.lua}
cat tools/smoke_stub.lua > "$OUT"
sed "$ s/^return M$/__RECON = M/" "$SRC" >> "$OUT"
cat tools/smoke_tail.lua >> "$OUT"
"$LUAU" "$OUT" || true
