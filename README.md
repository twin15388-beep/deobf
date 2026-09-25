# deobf — Ouroboros / NZL Studio

Разбор и читаемая реконструкция скрипта **Ouroboros** для Roblox-игры Ouwland
(Project Slayers 2, Place ID `136406881576517`).

## Что здесь лежит

| Файл | Роль |
|---|---|
| `ouroboros_ps2 (1).luau` | оригинал, flatten-обфусцированный (luast v1.0.1); единый пул констант `cKb[136]` |
| `ouroboros_ps2_resolved.lua` | тот же код с подставленными константами (читаемая версия, генерируется) |
| `Текстовый документ (2).txt` | дамп констант рантайма оригинала (индексы несовместимы с .luau — сверять по значению) |
| `ouroboros_clean_source.lua` | читаемое реконструированное ядро (clean-0.25, 25 worker-контроллеров) |
| `ouwland_clean_main.lua` | standalone-сборка: Lumen UI + ядро + меню |
| `NZL ui.txt` | библиотека Lumen UI (копия внутри standalone) |
| `ouroboros_behavior_trace.lua` | рекордер вызовов сети/ввода для сверки протокола в игре |
| `ouroboros_deep_extract.lua` | дамп графа замыканий через `getgc` |
| `NZL_RECONSTRUCTION_STATUS.md`, `ouwland_recon_findings.md` | отчёт о реконструкции и recon-заметки по игре |
| `ouroboros_deflattened.txt` | **де-flattened функции оригинала**: 427 машин состояний в читаемом виде (генерируется) |
| `ouroboros_main_deflattened.txt` | главный движок (top-level state machine) целиком |
| `ouroboros_main_pruned.txt` | он же без junk-состояний: 1488 из 1761 состояний достижимы из входа |
| `data/pool_index.json` | **точная карта пула**: 6641 слот = индекс -> значение (0 расхождений) |
| `data/api_map.json`, `API_MAP.md` | **публичный API оригинала**: 575 настроек в 21 таблице -> F-слоты |
| `NZL_AUDIT.md` | **аудит: что подтверждено, чего не хватает, что делать дальше** |
| `tools/`, `data/` | парсер артефакта, разворот констант, индексы фич |

## Инструменты

```bash
python3 tools/luaflat.py "ouroboros_ps2 (1).luau"                    # парсер + пул констант
python3 tools/inline_constants.py "ouroboros_ps2 (1).luau" \
        ouroboros_ps2_resolved.lua data/pool.json                    # читаемая версия
python3 tools/feature_index.py "ouroboros_ps2 (1).luau" \
        data/feature_index.json ouroboros_ps2_resolved.lua           # имя фичи -> пул -> код

python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --slot 841       # одна функция
python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --name SetWenMob # по имени API
python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --all \
        --combined ouroboros_deflattened.txt                         # все машины

python3 tools/pool_map.py "ouroboros_ps2 (1).luau" data/pool_index.json  # пул: индекс -> значение
python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --main \
        ouroboros_main_deflattened.txt                               # главный движок
python3 tools/prune_junk.py "ouroboros_ps2 (1).luau" \
        --out ouroboros_main_pruned.txt                              # движок без junk-состояний
python3 tools/api_map.py ouroboros_main_pruned.txt data/api_map.json \
        --md API_MAP.md --compare ouwland_clean_main.lua             # публичный API -> F-слоты
python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --pool 1125      # функция из пула по индексу
```

Формат де-flattened вывода: каждый state — это значение, которое проверяет диспетчер;
`goto N` — переход в state N, `EXIT` — выход из функции, вложенные машины (внутри `for`/`while`)
развёрнуты на месте с отступом. Константы пула подставлены.

Начните с `NZL_AUDIT.md`.
