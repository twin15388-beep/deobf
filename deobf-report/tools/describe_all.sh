#!/usr/bin/env bash
# describe_all.sh — обновить PARTS.md по ВСЕМ деобфусцированным script.lua.
# В results/ больше нет каталогов без кода: если код не получился — в results/ ничего не кладём.
set -u
RES=/home/user/deobf/deobf-report/results
TOOLS=/home/user/deobf/deobf-report/tools
count=0
for f in "$RES"/*/*/script.lua "$RES"/*/*/*/script.lua; do
  [ -f "$f" ] || continue
  d=$(dirname "$f")
  name=$(basename "$d")
  parts="$d/PARTS.md"
  game=$(basename "$(dirname "$d")")
  tmp=$(mktemp)
  python3 "$TOOLS/describe_lua.py" "$f" > "$tmp" 2>/dev/null || { rm -f "$tmp"; continue; }
  {
    printf '# `%s` — функционал и механики\n\n' "$name"
    printf 'Игра/тема: **%s** · восстановленный код: `script.lua` (%s строк)\n\n' "$game" "$(wc -l < "$f")"
    cat "$tmp"
  } > "$parts"
  rm -f "$tmp"
  count=$((count+1))
done
echo "обновлено PARTS.md: $count"
