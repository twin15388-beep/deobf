#!/usr/bin/env bash
# postprocess_ib.sh — починка и декомпиляция чанков, полученных CASCADE (IronBrew).
# Для каждого каталога _work/res6/ib/<name>/ с out.luac:
#   luac_fix (maxstack/nups/vararg) -> luac32to64 -> проверка загрузки в Lua 5.1.1
#   -> unluac -> script.lua ; + PARTS.md из строковых констант
set -u
ROOT=/home/user/deobf/_work/res6/ib
TOOLS=/home/user/deobf/deobf-report/tools
JAVA=$(python3 -c "import jdk4py;print(jdk4py.JAVA_HOME)")/bin/java
UNLUAC=/home/user/deobf/_work/tools/psu/tools/unluac.jar
LUA=/home/user/deobf/_work/tools/lua51dbg/lua
SUMMARY=$ROOT/_summary.tsv
: > "$SUMMARY"

for d in "$ROOT"/*/; do
  [ -s "$d/out.luac" ] || continue
  name=$(basename "$d")
  python3 "$TOOLS/luac_fix.py" "$d/out.luac" -o "$d/fixed.luac" -q >/dev/null 2>&1
  python3 "$TOOLS/luac_inspect.py" "$d/fixed.luac" > "$d/inspect_fixed.txt" 2>&1
  python3 "$TOOLS/luac32to64.py" "$d/fixed.luac" -o "$d/fixed64.luac" >/dev/null 2>&1
  load=$("$LUA" -e "local f=loadfile('$d/fixed64.luac'); print(f and 'LOAD_OK' or 'LOAD_FAIL')" 2>/dev/null)
  probs=$(grep -c '^    p' "$d/inspect_fixed.txt" 2>/dev/null || true)
  probs=${probs:-0}
  status=""
  if [ "$load" = "LOAD_OK" ]; then
    if "$JAVA" -jar "$UNLUAC" "$d/fixed.luac" > "$d/script.lua" 2>"$d/unluac.err"; then
      status="DECOMPILED"
      python3 "$TOOLS/lua_beautify.py" "$d/script.lua" -o "$d/script.lua" >/dev/null 2>&1 || true
      python3 "$TOOLS/chunk_parts.py" "$d/fixed.luac" -o "$d/PARTS.md" --title "$name (IronBrew/CASCADE)" >/dev/null 2>&1
      lines=$(wc -l < "$d/script.lua")
    else
      status="UNLUAC_FAIL"; lines=0
    fi
  else
    status="LOAD_FAIL"; lines=0
    python3 "$TOOLS/chunk_parts.py" "$d/fixed.luac" -o "$d/PARTS.md" --title "$name (IronBrew/CASCADE, код не собран)" >/dev/null 2>&1
  fi
  printf "%s\t%s\t%s\t%s\t%s\n" "$name" "$(stat -c%s "$d/out.luac")" "$status" "$lines" "$probs" >> "$SUMMARY"
  echo -e "$name\t$status\t$lines строк\tпроблем: $probs"
done
