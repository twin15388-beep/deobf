# Дефект декодера: `goto` без метки — причина, детектор и процесс — 23 октября 2026

**Что случилось.** Закреплённый декодер WeAreDevs/WAD ([`prostone4/Prometheus-Deobfuscator@6ee3291e`](../sources/manifest.json), распаковывается через [`prepare_pdeobf.py`](../scripts/prepare_pdeobf.py)) в части выводов выдаёт `goto LNNN` **без** соответствующей метки `::LNNN::`. Такой файл не компилируется ни в Lua 5.1, ни в Luau. В этом проходе дефект встретился в **2 из 5** входов: `Prison Life` (строка 37, `goto L9209319`) и `Fling Things And People` (строка 35, `goto L10650638`) — оба из `volmaksDev/My-Scripts@231da028`. Декодер при этом **не печатает ни одного предупреждения**: прогон Prison Life дал 0 байт в stdout и 0 байт в stderr, так что на глаз вывод выглядит успешным.

**Причина (чтение кода закреплённой копии, `src/vm/structure.js`).**

1. `jumpTo()` (строки 124–129) для перехода, который не является ни заголовком цикла, ни его follow-блоком, добавляет цель в набор `labels` (строка 127) и возвращает `{kind: 'goto'}`.
2. В `emit()` для терминатора `goto` (строки 163–178) есть два исхода: если цель ещё **не** размещена и не относится к циклу из `ctx.loops`, метка удаляется (`labels.delete`, строка 172) и блок выдаётся inline; иначе `goto` **push-ится в вывод** (строка 176) — в том числе когда цель уже размещена (`placed.has(target)`).
3. Хвостовой цикл, который дописывает оставшиеся метки (строки 283–296), **пропускает размещённые блоки**: `if (!block || placed.has(block)) continue;` (строка 289).

Итог: если цель перехода уже была выдана inline (у нас — первый блок тела `repeat`, строящий URL), `goto` остаётся в выводе, а метка не появляется никогда. Предупреждение об этом не формируется: `warnings` получает только `missing-target`, `unstructured-loop` и `unplaced-block`.

**Почему мы не правим сам декодер.** Любая правка `src/vm/structure.js` изменила бы байты всех последующих выводов, и опубликованные `result_body_sha256` перестали бы воспроизводиться задокументированной командой. Поэтому vendored-копия остаётся нетронутой (в `prepare_pdeobf.py` по-прежнему только две правки опечаток парсера/терминаторов), а работа с дефектом вынесена в наши инструменты.

## Что добавлено вместо правки декодера

**1. Детектор и гейт публикации — [`scripts/check_decoder_output.py`](../scripts/check_decoder_output.py).** Офлайн, без исполнения Lua и без сети. Проверяет тело (заголовок `--[[ ... ]]` отбрасывается, иначе документация правки выглядит как дефект — ровно это ложное срабатывание он сначала и дал на опубликованном Prison Life) и возвращает:

- `dangling_gotos` — все `goto X` без `::X::`, с номерами строк;
- `paste_hosts` — paste.ee/pastefy/pastebin/paste.gg/hastebin/rentry/controlc/dpaste/ghostbin в теле (непубликуемо по правилам каталога);
- `external_hosts` — все хосты, которые тело может запросить (для сверки с `external_dependencies`);
- `classification` — `game_code` / `loader_only` / `vm_dump` / `ui_library` / `unclassified`, чтобы loader и дампы VM не попадали в счётчик игровых результатов;
- `publishable` и список `blockers`; CLI возвращает код 1, если хотя бы один файл не проходит.

Проверка на текущих данных:

```text
FAIL local-results/wad-out/prisonlife-raw.lua   game_code  remotes=0 workspace=4 lines=1091
     - 1 dangling goto(s): line 37 -> L9209319
OK   dobf scripts 1.0/Prison Life - volmaks ESP Freecam.lua   game_code remotes=0 workspace=4 lines=1090
OK   dobf scripts 1.0/Slap Battles - Tryhard AI Demo.lua      game_code remotes=3 workspace=2 lines=1149
OK   dobf scripts 1.0/Work at a Pizza Place - Order4.lua      game_code remotes=8 workspace=5 lines=1244
OK   dobf scripts 1.0/Your Bizarre Adventure - Revenge Hub.lua game_code remotes=2 workspace=2 lines=1353
OK   dobf scripts 1.0/Jujutsu Shenanigans - Sonic Moveset.lua  game_code remotes=9 workspace=1 lines=1472
```

Число строк совпадает с `body_lines` в манифестах, то есть гейт смотрит ровно на то тело, которое опубликовано.

**2. Правка по существующему соглашению — [`scripts/repair_prison_life_goto.py`](../scripts/repair_prison_life_goto.py).** Раньше строку `goto L9209319` удаляли вручную, без скрипта; теперь это узкая правка в стиле уже принятых `repair_violence_district_goto.py` / `repair_wild_horse_goto.py`: точное совпадение контекста, отказ при любом другом расположении (`layout differs`), отказ при любом дополнительном переходе или при наличии настоящей метки (`additional jumps require a separate audit`), плюс проверка, что удалено ровно 20 байт. Тест [`tests/test_game_goto_repairs.py`](../tests/test_game_goto_repairs.py) проверяет и синтетические случаи, и (когда сырой вывод лежит в игнорируемом `local-results/`) что `repair(raw) == опубликованное тело`.

**3. Повторяемый конвейер — [`scripts/wad_recover.py`](../scripts/wad_recover.py).** Один проход вместо ручных шагов: `git show` из закреплённого клона → проверка наличия LICENSE в этом коммите → два прогона декодера с требованием побайтового совпадения → гейт из п.1 → необязательная правка из п.2 → черновик записи манифеста с настоящими хешами и пустыми полями, которые человек обязан заполнить (`functions`, `limitations`, `external_dependencies`). Конвейер не исполняет защищённый Lua, не ходит в сеть и **отказывается писать в `dobf scripts 1.0/`** — публикация остаётся ручным проверяемым шагом.

Прогон на реальном входе (Prison Life) воспроизводит опубликованный артефакт:

```console
$ python3 scripts/wad_recover.py --repo local-results/volmaksDev_My-Scripts \
    --commit 231da028cc84a5e0dcd9ece97a0008aec47dc794 --path 'Prison Life' \
    --game 'Prison Life' --variant 'volmaks ESP Freecam' \
    --repair scripts/repair_prison_life_goto.py
input   250071 bytes sha256 ba3ecd9f3315cf751c7bef4d5825661704e7546285182f4bf1ba798d504ae547
license LICENSE sha256 24ba1203a72495d8537a3b1eabfa866255cb91e0f83b2e65694f5fe76d098af7
decoded 25780 bytes / 1091 lines deterministic=True sha256 fc6fce1cf894ca3d75846bff91172470b46fb65f88cf0db026691475d33df24e
repair  repair_prison_life_goto.py: 20 bytes removed, raw kept at .../Prison Life.decoded.raw.lua
audit   game_code publishable=True
```

Черновик даёт `result_body_sha256 = 386b65e3930a8c119b6f578050d7377e41687784621a1385fce35b8bf5f2c3f7` и `body_lines = 1090` — ровно значения опубликованного [Prison Life - volmaks ESP Freecam.lua](../dobf%20scripts%201.0/Prison%20Life%20-%20volmaks%20ESP%20Freecam.lua) в [манифесте](game-sources-2026-10-23-wad.json). Без `--repair` тот же прогон заканчивается кодом 1 и сообщением `1 dangling goto(s): line 37 -> L9209319`, то есть дефект больше нельзя пропустить.

## Тесты

- [`tests/test_decoder_output_checks.py`](../tests/test_decoder_output_checks.py) — 12 тестов: поиск `goto` без метки, отбрасывание заголовка (включая контрпример, когда документированная правка выглядит как дефект), классификация `game_code`/`loader_only`/`vm_dump`/`ui_library`, блокировка по paste-хосту и по неигровому телу, и регрессионный прогон по пяти опубликованным файлам.
- [`tests/test_wad_pipeline.py`](../tests/test_wad_pipeline.py) — 9 тестов на временном git-репозитории и Node-заглушке декодера (без сети): извлечение по закреплённому коммиту и отказ при коротком SHA, лицензионный гейт, запрет записи в каталог, состав черновика, требование `repair()` у правки, требование двух одинаковых прогонов, отметка недетерминированного декодера, отказ CLI публиковать неигровое тело и успешный прогон на игровом теле.
- [`tests/test_game_goto_repairs.py`](../tests/test_game_goto_repairs.py) — 4 теста (было 2), включая воспроизведение опубликованного тела из сырого вывода.

**Границы.** Детектор ищет только `goto` без метки; другие классы дефектов декодера (например пропущенные блоки, о которых он сообщает как `unplaced-block`) он не ловит. Классификация эвристическая: тело без remote и менее чем с тремя игровыми путями `workspace` не считается игровым, поэтому необычный, но настоящий игровой скрипт может потребовать ручного решения — гейт в таком случае надо обходить осознанно и с объяснением в отчёте, а не молча.

## Проверка всего каталога и постоянный гейт

Прогон детектора по всем **66** опубликованным `.lua`: **ни одного `goto` без метки**, то есть дефект декодера в каталог не попал (единственная затронутая публикация — Prison Life, уже исправленная узкой правкой). Проверка встроена в [`verify_results.py`](../scripts/verify_results.py) как постоянный регрессионный гейт: любой опубликованный файл с переходом без метки теперь отклоняется до сравнения с манифестом, а тест [`tests/test_decoder_output_checks.py`](../tests/test_decoder_output_checks.py) подтверждает и срабатывание (подделанный файл с согласованными хешами → `Dangling goto in published file ...`), и проход нетронутого.

**Побочная находка, требующая решения владельца каталога.** Тот же прогон показал, что в уже опубликованном [`Jujutsu Shenanigans - Pantheon Hub.lua`](../dobf%20scripts%201.0/Jujutsu%20Shenanigans%20-%20Pantheon%20Hub.lua) (строка 1065, зарегистрирован в [game-recovery-2026-10-19.json](game-recovery-2026-10-19.json), проход 19 октября) есть `loadstring(game:HttpGet("https://pastebin.com/raw/rQMS2B9R", true))()` — загрузка и исполнение кода с paste-хоста, то есть ровно тот класс, который новый гейт не пропускает. Файл **не изменялся и не удалялся**: это чужой опубликованный результат со своим манифестом, и решение о его судьбе выходит за рамки правки инструмента. Гейт по paste-хостам намеренно **не** добавлен в `verify_results.py`, чтобы не ломать существующий каталог задним числом; он работает в `check_decoder_output.py` для новых публикаций.
