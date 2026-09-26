#!/usr/bin/env bash
# Восстановление рабочего окружения после сброса песочницы.
#
# Что ломается при сбросе:
#   1) git-история обрезается до main, а ветка сессии становится недоступной, потому
#      что в конфиге remote ограничен refspec `+refs/heads/main:...`;
#   2) пропадает собранный Luau (/home/user/tooling/luau) и venv для build_recon.py
#      (/tmp/lvenv), потому что /tmp и часть /home/user живут вне снапшота.
#
# Запуск:  bash tools/restore_env.sh [--no-luau]
set -euo pipefail

cd "$(dirname "$0")/.."
BRANCH=arena/01a0d367-deobf

echo "== git: возвращаю refspec и ветку сессии"
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
git fetch -q origin
if git rev-parse --verify -q "origin/$BRANCH" >/dev/null; then
    git checkout -q "$BRANCH" 2>/dev/null || git checkout -q -B "$BRANCH" "origin/$BRANCH"
    git reset --hard -q "origin/$BRANCH"
    echo "   ветка $BRANCH -> $(git log --oneline -1)"
else
    echo "   ветки origin/$BRANCH нет — остаёмся на $(git rev-parse --abbrev-ref HEAD)"
fi

echo "== python: venv для tools/build_recon.py"
if [ ! -x /tmp/lvenv/bin/python ]; then
    python3 -m venv /tmp/lvenv
fi
/tmp/lvenv/bin/pip -q install luaparser

if [ "${1:-}" = "--no-luau" ]; then
    echo "== Luau: пропускаю (--no-luau)"
    exit 0
fi

echo "== Luau: интерпретатор для tools/smoke.sh"
if [ -x /home/user/tooling/luau/luau ]; then
    echo "   уже собран: $(/home/user/tooling/luau/luau --version 2>&1 | head -1 || true)"
else
    [ -d /tmp/luau2 ] || git clone -q --depth 1 https://github.com/luau-lang/luau /tmp/luau2
    if [ ! -x /tmp/luavenv/bin/cmake ]; then
        python3 -m venv /tmp/luavenv
        /tmp/luavenv/bin/pip -q install cmake
    fi
    /tmp/luavenv/bin/cmake -S /tmp/luau2 -B /tmp/luau2/build -DCMAKE_BUILD_TYPE=Release >/tmp/luau_cmake.log 2>&1
    /tmp/luavenv/bin/cmake --build /tmp/luau2/build -j4 --target Luau.Repl.CLI Luau.Analyze.CLI >/tmp/luau_make.log 2>&1
    mkdir -p /home/user/tooling/luau
    cp /tmp/luau2/build/luau /tmp/luau2/build/luau-analyze /home/user/tooling/luau/
    echo "   собрано"
fi

echo "== проверки"
/tmp/lvenv/bin/python tools/build_recon.py >/dev/null && echo "   build_recon: ок"
./tools/smoke.sh 2>&1 | tail -1
python3 tools/check_strings.py | tail -1
python3 tools/check_bundle.py | tail -1
