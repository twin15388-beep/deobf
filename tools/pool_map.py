"""Extract the artifact's real constant pool: index -> value.

The luast artifact builds its constant pool as one huge table constructor,
e.g. `cKb[136] = { "fish", 841, [3912] = "noSlowdown", function() ... end, ... }`.
Positional entries and explicit `[k] = v` keys are mixed, so the runtime index of a
value is not its position in the listing -- the constructor has to be evaluated the
way Lua would.

The generic table parser in `luaflat` mis-aligns on a constructor this large, so this
module scans fields itself with a keyword-aware block-depth tracker.

Usage:
    python3 tools/pool_map.py "<artifact>" [out.json] [--alias cKb[136]|cTx]
"""

import json
import re
import sys

NUM = re.compile(r"^-?\d+\.?\d*(?:[eE][-+]?\d+)?$")
BLOCK_OPEN = {"function", "do", "while", "for", "repeat"}
BLOCK_CLOSE = {"end", "until"}
# Luau prefix-if (`x = if c then 1 else 2`) is an expression without `end`; an `if`
# right after one of these tokens opens no block.
EXPR_CONTEXT = {"=", "(", ",", "{", "[", "then", "else", "return", "and", "or", "not",
                "==", "~=", "<", ">", "<=", ">=", "+", "-", "*", "/", "//", "%", "^",
                "..", "..=", "?", "elseif"}


def opens_block(toks, i):
    """True when toks[i] is a statement `if` (prefix-ifs have no matching `end`)."""
    j = i - 1
    while j >= 0 and toks[j][0] == "comment":
        j -= 1
    if j < 0:
        return True
    prev = toks[j][1]
    if prev in EXPR_CONTEXT:
        return False
    if toks[j][0] == "sym" and prev not in (")", "]", "}", ";"):
        return False        # any other operator token -> expression context
    return True


def scan_fields(toks, start):
    """Yield (key_text_or_None, value_text) for the table at tokens[start] == '{'."""
    assert toks[start][1] == "{", toks[start]
    i = start + 1
    n = len(toks)
    while i < n:
        if toks[i][1] == "}":
            return
        if toks[i][1] in (",", ";"):
            i += 1
            continue
        key = None
        if toks[i][1] == "[":
            depth = 0
            j = i
            while j < n:
                if toks[j][1] == "[":
                    depth += 1
                elif toks[j][1] == "]":
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            key = "".join(t[1] for t in toks[i + 1:j])
            i = j + 1
            if i < n and toks[i][1] == "=":
                i += 1
        elif toks[i][0] == "name" and i + 1 < n and toks[i + 1][1] == "=":
            key = toks[i][1]
            i += 2
        start_val = i
        i = skip_value(toks, i)
        yield key, "".join(t[1] for t in toks[start_val:i]).strip(), start_val, i


def skip_value(toks, i):
    """Advance past one field value; stop at a top-level `,` or `}`."""
    n = len(toks)
    parens = braces = brackets = 0
    block = 0
    expect_do = 0
    while i < n:
        kind, text = toks[i][0], toks[i][1]
        if parens == 0 and braces == 0 and brackets == 0 and block == 0:
            if text in (",", "}", ";"):
                return i
        if kind == "str":
            i += 1
            continue
        if text in ("(",):
            parens += 1
        elif text in (")",):
            parens -= 1
        elif text == "{":
            braces += 1
        elif text == "}":
            if braces == 0 and block == 0 and parens == 0 and brackets == 0:
                return i
            braces -= 1
        elif text == "[":
            brackets += 1
        elif text == "]":
            brackets -= 1
        elif text in ("while", "for"):
            block += 1
            expect_do += 1
        elif text == "do":
            if expect_do:
                expect_do -= 1
            else:
                block += 1
        elif text == "if":
            if opens_block(toks, i):
                block += 1
        elif text in ("function", "repeat"):
            block += 1
        elif text in BLOCK_CLOSE:
            block -= 1
            if block < 0:
                return i
        i += 1
    return i


def literal(raw):
    text = raw.strip()
    if text in ("true", "false"):
        return text == "true"
    if text == "nil":
        return None
    if text.startswith('"') or text.startswith("'"):
        quote = text[0]
        if text.endswith(quote) and len(text) >= 2:
            body = text[1:-1]
            if quote == '"':
                body = (body.replace('\\"', '"').replace("\\n", "\n")
                            .replace("\\t", "\t").replace("\\\\", "\\"))
            return body
    if text.startswith("[["):
        return text[2:-2]
    if NUM.match(text):
        value = float(text)
        return int(value) if value.is_integer() else value
    return None


def find_constructors(toks, alias):
    """Token index of `{` for every `alias = { ... }` statement."""
    hits = []
    for i, (_kind, text, _s, _e) in enumerate(toks):
        if text != "=":
            continue
        left = "".join(t[1] for t in toks[max(0, i - 4):i])
        if left.endswith(alias) and i + 1 < len(toks) and toks[i + 1][1] == "{":
            hits.append(i + 1)
    return hits


def build_map(path, alias="cKb[136]"):
    import luaflat
    import luascan
    src = open(path, encoding="utf-8", errors="replace").read()
    toks = list(luaflat.tokenize(src))
    starts = find_constructors(toks, alias)
    if not starts:
        raise SystemExit("pool constructor not found for %s" % alias)
    mapping = {}
    counter = 0
    functions = 0
    fields = 0
    for start in starts:
        end = luascan.table_end(toks, start)
        for key, raw, _a, _b in luascan.scan_fields(toks, start, end):
            fields += 1
            if key is None:
                counter += 1
                index = counter
            else:
                k = literal(key)
                if k is None:
                    continue                     # name-keyed field, not a pool slot
                if isinstance(k, str):
                    continue
                index = int(k)
            value = literal(raw)
            if value is None and raw.lstrip().startswith("function"):
                value = {"function": raw}
                functions += 1
            if value is None:
                value = {"expr": raw}
            if index in mapping and isinstance(mapping[index], dict) \
                    and isinstance(value, dict):
                pass                             # later assignment wins, as in Lua
            mapping[index] = value
    return mapping, counter, functions, fields


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "ouroboros_ps2 (1).luau"
    rest = sys.argv[2:]
    alias = "cKb[136]"
    if "--alias" in rest:
        pos = rest.index("--alias")
        alias = rest[pos + 1]
        del rest[pos:pos + 2]
    out = rest[0] if rest else None
    mapping, counter, functions, fields = build_map(path, alias)
    print("pool %s: %d fields, %d positional slots, %d closures"
          % (alias, fields, counter, functions))
    for probe in ("466", "1355", "2770", "5349", "4089"):
        val = mapping.get(int(probe))
        if isinstance(val, dict):
            val = list(val.values())[0][:70]
        print("  [%s] = %r" % (probe, val))
    if out:
        with open(out, "w", encoding="utf-8") as fh:
            json.dump({str(k): v for k, v in mapping.items()}, fh,
                      ensure_ascii=False, indent=0)
        print("wrote", out)


if __name__ == "__main__":
    main()
