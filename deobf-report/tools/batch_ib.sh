#!/usr/bin/env bash
# batch_ib.sh — прогон CASCADE по корпусу IronBrew/AztupBrew.
# Для каждого файла: девиртуализация -> конвертация 32->64 бит -> разбор/диагностика.
set -u
CORPUS=/home/user/deobf/_work/repos/hex/Scripts-main/SCRIPTS
OUT=/home/user/deobf/_work/res6/ib
CASCADE=/home/user/deobf/_work/tools/CASCADE
TOOLS=/home/user/deobf/deobf-report/tools
mkdir -p "$OUT"

LIST="$OUT/list.txt"
if [ ! -s "$LIST" ]; then
  grep -l -r -E "AztupBrew|IronBrew" "$CORPUS" --include=*.lua > "$LIST" 2>/dev/null
fi

N=0
while IFS= read -r f; do
  N=$((N+1))
  base=$(basename "$f" .lua | tr -c 'A-Za-z0-9._-' '_')
  d="$OUT/$base"
  mkdir -p "$d"
  [ -s "$d/report.txt" ] && continue
  cp "$f" "$CASCADE/input.lua"
  ( cd "$CASCADE" && timeout 900 node index.js > "$d/devirt.log" 2>&1 )
  if [ -s "$CASCADE/output.luac" ]; then
    cp "$CASCADE/output.luac" "$d/out.luac"
    python3 "$TOOLS/luac_inspect.py" "$d/out.luac" > "$d/inspect.txt" 2>&1
    python3 "$TOOLS/luac32to64.py" "$d/out.luac" -o "$d/out64.luac" >> "$d/inspect.txt" 2>&1
    load=$("/home/user/deobf/_work/tools/lua51dbg/lua" -e "local f,e=loadfile('$d/out64.luac'); print(f and 'LOAD_OK' or 'LOAD_FAIL')" 2>/tmp/dbg.$$)
    probs=$(grep -c '^    p' "$d/inspect.txt" 2>/dev/null || echo 0)
    echo "$base|$(stat -c%s "$d/out.luac")|$load|$probs" > "$d/report.txt"
    cp /tmp/dbg.$$ "$d/checkcode.txt" 2>/dev/null
  else
    echo "$base|0|NO_CHUNK|0" > "$d/report.txt"
  fi
  rm -f /tmp/dbg.$$
  tail -1 "$d/report.txt"
done < "$LIST"
