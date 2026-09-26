"""Канонический дифф функций между двумя сборками Ouroboros.

Сборки обфусцированы по-разному (21.09 — пул `cKb[136]` и обычные локальные имена;
26.09 — пул `fwe[164]` и «регистры» в `fwe[N]`), поэтому сравнивать текст нельзя.
Инструмент ищет функцию по строке-якорю (значение пула), приводит её к канону,
независимому от имён и индексов:

* чтения пула заменяются на ЗНАЧЕНИЕ: строка — как есть, число — как есть,
  функция — на хеш её же канона (рекурсивно), таблица — на `@T`;
* локальные переменные (параметры, `local`, переменные циклов) → `L1, L2, …`;
* всё остальное (глобалы старой сборки и «регистры» новой) → `U`;
* числа нормализуются (`3838.` → `3838`).

Одинаковый канон у двух сборок = одинаковый код.

Usage:
    python3 tools/canon_diff.py --summary
    python3 tools/canon_diff.py --anchor noRagdoll --anchor PARRY_GAP
    python3 tools/canon_diff.py --anchor "Sickles Levers" --old … --new … --old-pool … --new-pool …
"""

import difflib
import hashlib
import json
import re
import sys

sys.path.insert(0, __file__.rsplit("/", 1)[0])
import luaflat  # noqa: E402
import luascan  # noqa: E402

OLD_ART = "ouroboros_ps2 (1).luau"
NEW_ART = "artifacts/ps2_2026-09-26.luau"
OLD_POOL = "data/pool_index.json"
NEW_POOL = "data/pool_index_2026-09-26.json"

SUMMARY_ANCHORS = [
    "noRagdoll", "noStun", "noSlowdown", "noragdoll", "RagdollConstraints",
    "resourceTick", "PARRY_GAP", "CAST_GRACE", "windowNpc", "defaultRtt", "reachPad",
    "OuroborosOuwlandOwnership", "ReceiveAge", "SetEspOption", "CATEGORIES",
    "CombatPresets", "SetInstantKill", "killThreshold", "AntiAfk", "MuzanLairModel",
    "Sickles Levers", "Double_Jump", "alwaysRun",
]

KEYWORDS = {
    "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "if",
    "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until",
    "while", "goto", "continue",
}


def norm_num(text):
    if text.endswith("."):
        text = text[:-1]
    if len(text) > 1 and text[0] == "0" and text[1] not in ".eE":
        text = text.lstrip("0") or "0"
    return text


class Build:
    def __init__(self, path, pool_path, poolref):
        self.path = path
        self.src = open(path, encoding="utf-8", errors="replace").read()
        self.toks = list(luaflat.tokenize(self.src))
        self.poolref = "".join(c for c in poolref if not c.isspace())
        m = re.match(r"([A-Za-z_]\w*)\[(\d+)\.?\]", self.poolref)
        self.root, self.slot = m.group(1), m.group(2)
        self.pool = {}
        for k, v in json.load(open(pool_path, encoding="utf-8")).items():
            self.pool[str(k).rstrip(".").strip()] = v
        self.rev = {}
        for k, v in self.pool.items():
            if isinstance(v, str):
                self.rev.setdefault(v, []).append(k)
        self.rootal = {self.root}
        self.poolal = set()
        self._find_aliases()
        self._funcs = None
        self._hash_cache = {}
        self._pat_cache = {}

    # --- псевдонимы (внутри конкретного тела) ----------------------------
    def _local_aliases(self, toks, start, stop):
        """Имена, равные пулу, объявленные внутри этого тела: `local cTz = cKb[136]`."""
        out = set()
        for i in range(start, stop - 3):
            if toks[i][0] != "name":
                continue
            left = toks[i][1]
            if not (i + 1 < stop and toks[i + 1][1] == "="):
                continue
            if i > start and toks[i - 1][1] == "local":
                pass
            elif i > start and toks[i - 1][1] not in (",", "local"):
                continue
            j = i + 2
            if j + 1 < stop and toks[j][1] == self.root and toks[j + 1][1] == "[" \
                    and toks[j + 2][1].rstrip(".") == self.slot and toks[j + 3][1] == "]":
                out.add(left)
        return out

    def _find_aliases(self):
        """Псевдонимы пула.

        Обфускатор делает так: `local f38 = fwe` (или напрямую `local cTz = cKb[136]`),
        затем `local f39 = f38[164]`. Поэтому:

        * `X = <имя корня>` → X корневой псевдоним;
        * `X = <корневой псевдоним> [ slot ]` → X псевдоним пула.

        Обычные `X = alias[N]` (значения) за псевдонимы НЕ считаются — иначе в набор
        попадает половина файла и ссылки на константы ищутся не там.
        """
        toks = self.toks
        for _ in range(4):                      # цепочки короткие, хватает пары проходов
            changed = False
            for i in range(len(toks) - 3):
                if toks[i][0] != "name" or toks[i + 1][1] != "=":
                    continue
                if i >= 2 and toks[i - 2][1] in (".", ":"):
                    continue                    # obj.field = …
                left, nxt = toks[i][1], toks[i + 2][1]
                if i + 3 < len(toks) and toks[i + 3][1] == "[":
                    if nxt in self.rootal and i + 5 < len(toks) \
                            and toks[i + 4][1].rstrip(".") == self.slot and toks[i + 5][1] == "]":
                        if left not in self.poolal:
                            self.poolal.add(left)
                            changed = True
                elif nxt in self.rootal and left not in self.rootal:
                    self.rootal.add(left)
                    changed = True
            if not changed:
                break

    def pool_ref_pattern(self, idx):
        """Шаблон ссылки на константу: `cKb[136][N]`, `cTz[N]`, `f39[N]`, `fwe[164][N]`."""
        if idx in self._pat_cache:
            return self._pat_cache[idx]
        names = sorted(self.poolal, key=len, reverse=True)
        alts = [re.escape(n) for n in names]
        alts.append(r"%s\s*\[\s*%s\s*\]" % (re.escape(self.root), re.escape(self.slot)))
        pat = re.compile(r"(?:%s)\s*\[\s*%s\.?\s*\]" % ("|".join(alts), re.escape(idx)))
        self._pat_cache[idx] = pat
        return pat

    # --- значения пула ---------------------------------------------------
    def marker(self, key, depth=0):
        key = key.rstrip(".").strip()
        val = self.pool.get(key)
        if isinstance(val, str):
            return '"%s"' % val
        if isinstance(val, dict):
            body = val.get("function")
            if body and depth < 2:
                if key not in self._hash_cache:
                    self._hash_cache[key] = self.hash_text(body, depth + 1)
                return "@F" + self._hash_cache[key][:8]
            return "@T"
        if val is None:
            return "@?"
        return norm_num(str(val))

    def hash_text(self, body, depth=0):
        toks = list(luaflat.tokenize(body))
        return hashlib.md5(" ".join(self.canon(toks, 0, len(toks), depth)).encode()).hexdigest()

    def canon_src(self, text):
        toks = list(luaflat.tokenize(text))
        return self.canon(toks, 0, len(toks), 0)

    # --- канон -----------------------------------------------------------
    def _pool_read(self, toks, i, stop, aliases):
        """Если начиная с i идёт чтение константы пула — вернуть (длина, маркер)."""
        name = toks[i][1]
        # ALIAS [ N ]
        if name in aliases and i + 3 < stop and toks[i + 1][1] == "[" \
                and toks[i + 2][0] == "num" and toks[i + 3][1] == "]":
            return 4, self.marker(toks[i + 2][1], 0)
        if name == self.root:
            # ROOT [ slot ] [ N ]
            if i + 7 < stop and toks[i + 1][1] == "[" and toks[i + 2][1].rstrip(".") == self.slot \
                    and toks[i + 3][1] == "]" and toks[i + 4][1] == "[" \
                    and toks[i + 5][0] == "num" and toks[i + 6][1] == "]":
                return 7, self.marker(toks[i + 5][1], 0)
            # ROOT [ N ] — слот состояния (не константа)
            if i + 3 < stop and toks[i + 1][1] == "[" and toks[i + 2][0] == "num" \
                    and toks[i + 3][1] == "]":
                return 4, "U"
        return None

    def canon(self, toks, start, stop, depth=0):
        out = []
        locals_map = {}
        aliases = set(self.poolal) | self._local_aliases(toks, start, stop)

        def declare(name):
            if name not in locals_map:
                locals_map[name] = "L%d" % (len(locals_map) + 1)

        i = start
        while i < stop:
            kind, text = toks[i][0], toks[i][1]
            if kind in ("comment", "ws"):
                i += 1
                continue
            if kind == "name" and text in ("function", "for"):
                out.append(text)
                j = i + 1
                if text == "function" and j < stop and toks[j][1] == "(":
                    j += 1
                    while j < stop and toks[j][1] != ")":
                        if toks[j][0] == "name":
                            declare(toks[j][1])
                        j += 1
                elif text == "for":
                    while j < stop and toks[j][1] not in ("in", "=", "do"):
                        if toks[j][0] == "name":
                            declare(toks[j][1])
                        j += 1
                i += 1
                continue
            if kind == "name" and text == "local":
                j = i + 1
                if j < stop and toks[j][1] == "function":
                    if j + 1 < stop and toks[j + 1][0] == "name":
                        declare(toks[j + 1][1])
                    out.append("local")
                    i += 1
                    continue
                while j < stop and toks[j][1] not in ("=", ";"):
                    if toks[j][1] in ("function", "do", "if", "while", "repeat"):
                        break
                    if toks[j][0] == "name":
                        declare(toks[j][1])
                    j += 1
                out.append("local")
                i += 1
                continue
            if kind == "name":
                read = self._pool_read(toks, i, stop, aliases)
                if read:
                    length, marker = read
                    out.append(marker)
                    i += length
                    continue
                if text in KEYWORDS:
                    out.append(text)
                elif text in locals_map:
                    out.append(locals_map[text])
                else:
                    out.append("U")
                i += 1
                continue
            if kind == "num":
                # Номера состояний у сборок разные, поэтому значение не храним:
                # иначе одинаковый код никогда не совпадёт.
                out.append("#")
            elif kind == "string":
                out.append(text)
            else:
                out.append(text)
            i += 1
        return out

    # --- функции ---------------------------------------------------------
    def functions(self):
        if self._funcs is not None:
            return self._funcs
        sc = luascan.Scanner(self.toks)
        out = []
        for i, t in enumerate(self.toks):
            if t[1] != "function":
                continue
            stop = sc.skip_value(i)
            out.append((i, stop, t[2], self.toks[stop - 1][3]))
        out.sort(key=lambda x: x[2])
        self._funcs = out
        return out

    def innermost_at(self, offset):
        """Функция вокруг смещения; если смещение на верхнем уровне — окно ±2500."""
        best = None
        for span in self.functions():
            a, b = span[2], span[3]
            if a <= offset <= b and (best is None or a >= best[2]):
                best = span
        if best is not None:
            return best
        a = max(0, offset - 2500)
        b = min(len(self.src), offset + 2500)
        return (-1, -1, a, b, "фрагмент")

    def spans_for(self, value):
        """Функции, в коде которых встречается константа со значением value."""
        spans = []
        for key in self.rev.get(value, []):
            pat = self.pool_ref_pattern(key)
            for m in pat.finditer(self.src):
                span = self.innermost_at(m.start())
                if span and span not in spans:
                    spans.append(span)
        return spans

    @property
    def code_start(self):
        """Смещение, с которого начинается код (после таблицы пула)."""
        try:
            return self._code_start
        except AttributeError:
            text = "".join(t[1] for t in self.toks)
            want = self.poolref + "="
            pos = text.find(want)
            spans, acc = [], 0
            for t in self.toks:
                spans.append(acc)
                acc += len(t[1])
            idx = max(i for i, s in enumerate(spans) if s <= pos + len(want))
            end = luascan.table_end(self.toks, idx)
            self._code_start = self.toks[end][3]
            return self._code_start

    def canon_of(self, span):
        return self.canon_src(self.src[span[2]:span[3]])


def evidence(canon_tokens):
    return [t for t in canon_tokens if t.startswith('"') or t.startswith("#")]


def strings(canon_tokens):
    return frozenset(t for t in canon_tokens if t.startswith('"'))


def similarity(a, b):
    """Схожесть по строковым константам: Жаккар."""
    if not a and not b:
        return 1.0
    return len(a & b) / len(a | b)


def compare(old, new, anchor, maxpairs=2):
    spans_old, spans_new = old.spans_for(anchor), new.spans_for(anchor)
    print("### %r — в старой %d, в новой %d" % (anchor, len(spans_old), len(spans_new)))
    if not spans_old or not spans_new:
        for tag, build, spans in (("старой", old, spans_old), ("новой", new, spans_new)):
            for s in spans[:4]:
                print("      только в %s: @%d..%d" % (tag, s[2], s[3]))
        print()
        return
    for so in spans_old[:maxpairs]:
        co = old.canon_of(so)
        ho = hashlib.md5(" ".join(co).encode()).hexdigest()
        bo, oo = strings(co), evidence(co)
        best = None
        for sn in spans_new[:12]:
            cn = new.canon_of(sn)
            hn = hashlib.md5(" ".join(cn).encode()).hexdigest()
            jac = similarity(bo, strings(cn))
            ratio = difflib.SequenceMatcher(None, co, cn).ratio()
            score = (1.0 if ho == hn else 0.0, jac, ratio)
            if best is None or score > best[0]:
                best = (score, hn, cn, sn, jac, ratio)
        _, hn, cn, sn, jac, ratio = best
        verdict = "ИДЕНТИЧНО" if ho == hn else "ИЗМЕНЕНО (строки %.0f%%, структура %.0f%%)" \
            % (jac * 100, ratio * 100)
        tag_o = "фрагмент" if len(so) > 4 else "функция"
        tag_n = "фрагмент" if len(sn) > 4 else "функция"
        print("    %s @%d..%d ↔ %s @%d..%d: %s"
              % (tag_o, so[2], so[3], tag_n, sn[2], sn[3], verdict))
        if ho != hn:
            eo, en = evidence(co), evidence(cn)
            gone = [x for x in eo if x not in en][:10]
            added = [x for x in en if x not in eo][:10]
            if gone:
                print("      только в старой: %s" % " ".join(gone))
            if added:
                print("      только в новой : %s" % " ".join(added))
    print()


def main(argv):
    def opt(name, default):
        return argv[argv.index(name) + 1] if name in argv else default

    old = Build(opt("--old", OLD_ART), opt("--old-pool", OLD_POOL), opt("--old-poolref", "cKb[136]"))
    new = Build(opt("--new", NEW_ART), opt("--new-pool", NEW_POOL), opt("--new-poolref", "fwe[164]"))
    anchors = [argv[i + 1] for i, a in enumerate(argv) if a == "--anchor"]
    if "--summary" in argv or not anchors:
        anchors = SUMMARY_ANCHORS
    print("старая сборка: %s — %d токенов; псевдонимы пула: %d (напр. %s)"
          % (old.path, len(old.toks), len(old.poolal), ", ".join(sorted(old.poolal)[:4])))
    print("новая сборка : %s — %d токенов; псевдонимы пула: %d (напр. %s)\n"
          % (new.path, len(new.toks), len(new.poolal), ", ".join(sorted(new.poolal)[:4])))
    for anchor in anchors:
        compare(old, new, anchor)


if __name__ == "__main__":
    main(sys.argv[1:])
