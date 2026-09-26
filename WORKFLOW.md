# Как работать в этом репозитории (памятка по инструментам и песочнице)

## Первым делом после сброса песочницы

Быстро: `bash tools/restore_env.sh` — вернёт ветку сессии, venv и Luau, прогонит проверки
(см. ниже, что именно ломается).

Песочница может пересоздать репозиторий: тогда локальная история обрежется до `main`
(«Add files via upload»), а рабочие файлы останутся. Лечение:

```bash
cd /home/user/deobf
git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'   # иначе видно только main
git fetch origin
git reset --hard origin/arena/01a0d367-deobf
```

Работаем только в ветке `arena/01a0d367-deobf`; всё незакоммиченное исчезает при сбросе.

Интерпретатор Luau лежит в `/home/user/tooling/luau/{luau,luau-analyze}`. Если его нет —
пересобрать (ассеты GitHub-релизов в песочнице недоступны, только сборка из исходников):

```bash
git clone --depth 1 https://github.com/luau-lang/luau /tmp/luau
python3 -m venv /tmp/luavenv && /tmp/luavenv/bin/pip install cmake
/tmp/luavenv/bin/cmake -B /tmp/luau/build -DCMAKE_BUILD_TYPE=Release
/tmp/luavenv/bin/cmake --build /tmp/luau/build -j4 --target Luau.Repl.CLI Luau.Analyze.CLI
cp /tmp/luau/build/luau /tmp/luau/build/luau-analyze /home/user/tooling/luau/
```

## Проверки перед коммитом

```bash
/tmp/lvenv/bin/python tools/build_recon.py   # пересобрать ouroboros_recon.lua
./tools/smoke.sh                             # прогон под stub-Roblox: должно быть 0 падений
python3 tools/check_strings.py               # сверка строк-литералов с артефактом
python3 tools/check_bundle.py                # целостность модулей сборки
```

`/tmp/lvenv` (luaparser) после сброса пересоздаётся так:
`python3 -m venv /tmp/lvenv && /tmp/lvenv/bin/pip install luaparser`.

## Артефакты и чтение кода

| Файл | Что это |
|---|---|
| `ouroboros_ps2 (1).luau` | исходник истины: сборка 2026-09-21, пул `cKb[136]` |
| `artifacts/ps2_<дата>.luau` | текущая сборка с лоадера (пул `fwe[164]`, позиционный) |
| `data/pool_index.json` | индекс пула 21.09 (6641 запись) |
| `data/pool_index_<дата>.json` | индекс пула текущей сборки (11 071 запись) |
| `data/UI_MAP.md`, `data/D_MAP.md`, `data/TICK_MAP.md`, `data/ESP_MAP.md`, `data/BUILD_MAP.md`, `data/BUILD_HISTORY.md` | карты подсистем и история сборок |
| `data/BUILD_DELTA_2026-09-26.md`, `data/API_DELTA_2026-09-26.md`, `data/canon_summary_2026-09-26.txt` | дифф 21.09 → 26.09: код, API, сырой вывод |

Инструменты чтения (см. `--help`-описания в шапках файлов):

* `tools/fetch_build.py` — перекачать текущую сборку с лоадера + собрать её пул;
* `tools/read_fn.py` — прочитать функцию по `--offset` или `--pool N`, с `--names`
  (подстановка значений пула) и `--poolref`/`--alias` для любой сборки;
* `tools/read_region.py` — окно исходника с подстановкой значений пула;
* `tools/deflatten.py` — основной деобфускатор: `--pool N`, `--slot N`, `--main FILE`;
* `tools/pool_map.py "<артефакт>" out.json --alias "fwe[164]"` — собрать пул вручную;
* `tools/canon_diff.py --summary` — канонический дифф кода двух сборок (имена и индексы
  абстрагируются): вердикты «ИДЕНТИЧНО/ИЗМЕНЕНО» по строке-якорю, ~2.5 мин на полный
  прогон; отчёт по текущему сравнению — `data/BUILD_DELTA_2026-09-26.md`.

Важно: тексты функций в `data/pool_index*.json` хранятся без пробелов (склейка токенов),
поэтому для разбора их надо резать из исходника по смещениям — это уже делают
`read_fn.py` и `pool_map.py`.
