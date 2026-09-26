#!/usr/bin/env bash
# Проверка синтаксиса всех реконструкций настоящим компилятором Luau.
#
# Использование:
#   bash tools/check_lua.sh
#
# Если luau-analyze не найден, печатает инструкцию по сборке (сборка ~3 минуты).

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LUAU_DIR="${LUAU_DIR:-/home/user/tooling/luau}"

if [ ! -x "$LUAU_DIR/luau-analyze" ]; then
    cat <<'EOF'
luau-analyze не найден. Собрать так (нужны git, g++, make, cmake):

  python3 -m venv /tmp/luavenv && /tmp/luavenv/bin/pip install cmake
  git clone --depth 1 https://github.com/luau-lang/luau.git /tmp/luau
  /tmp/luavenv/bin/cmake -B /tmp/luau/build -S /tmp/luau -DCMAKE_BUILD_TYPE=Release
  make -C /tmp/luau/build -j"$(nproc)" Luau.Repl.CLI Luau.Analyze.CLI
  mkdir -p /home/user/tooling/luau
  cp /tmp/luau/build/luau /tmp/luau/build/luau-analyze /home/user/tooling/luau/
EOF
    exit 2
fi

export PATH="$LUAU_DIR:$PATH"
fail=0
# устаревшие/сгенерированные файлы, не входящие в реконструкцию
LEGACY="ouroboros_ps2_resolved.lua"

for f in "$ROOT"/ouroboros_*.lua; do
    case " $LEGACY " in *" $(basename "$f") "*) printf '%-34s пропущен (legacy)\n' "$(basename "$f")"; continue;; esac
    out="$(luau-analyze "$f" 2>&1)"
    if echo "$out" | grep -q 'SyntaxError'; then
        printf '%-34s ОШИБКА\n' "$(basename "$f")"
        echo "$out" | grep 'SyntaxError' | head -5
        fail=1
    else
        printf '%-34s синтаксис ок\n' "$(basename "$f")"
    fi
done
exit $fail
