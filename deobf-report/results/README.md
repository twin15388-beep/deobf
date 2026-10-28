# Результаты: рабочий код + названия партов

Каждый подкаталог — один сэмпл:

* `script.lua` — **восстановленный Lua-код** (не дизасм и не псевдо-Lua: настоящий Lua 5.1-байткод, прогнанный через декомпилятор `unluac`);
* `PARTS.md` — «части» скрипта: функциональные блоки, UI-библиотека, URL/webhook-и, сервисы, подписи UI и **названия партов/фич**;
* `LOG.txt` — лог пайплайна: чем определён обфускатор, что запускалось, что вернуло.

Индекс с размерами — `INDEX.md`.

Всего **24 сэмпла**, 12 игр/режимов, 7 разных обфускаторов (Luraph v15, MoonSec V3, MoonSec V2,
PSU 4.0/4.5, AztupBrew, wYnFuscate, самописные XOR-загрузчики). Полная таблица — `INDEX.md`.

## Что внутри (кратко)

### King Legacy / тестовый корпус (первая партия)

| Каталог | Обфускатор | Что это за скрипт |
|---|---|---|
| `king_legacy/KL_psu40_Kingpiece` | PSU 4.0.A | Хаб Kingpiece: автофарм NPC (King Samurai, King of Sand, Sea King, Shadow Master, Boss Dragon), авто-райд, ESP, телепорты, UI на Magma. |
| `king_legacy/KL_psu40_BloxFruit` | PSU 4.0.A | Хаб под Blox Fruits: автофарм/квесты, покупка дьявольских фруктов, Aimbot Gun, инвентарь-ESP, 46 телепортов, UI Magma/Vision/Rain. |
| `king_legacy/KL_psu45_ano` | PSU 4.5.A | Хаб `ano`: King Legacy-фичи + key-система (`Hidden Key`, «join discord → #key channel → word.ink»), кастомные предметы (`BlackSpikeyCape`). |
| `king_legacy/KL_msv3_v14_ZombieAttack` | MoonSec V3 | Lightux v1.4 (Zombie Attack): автолевелинг, проверка `IsInGroup(16527976)`, команды `:ban/:kick/:freeze/:fling`. |
| `king_legacy/KL_msv3_v15_ZombieAttack` | MoonSec V3 | Lightux v1.5 — то же, но новее и в 1.5 раза больше кода. |
| `king_legacy/KL_msv2_v13` | MoonSec V2 | Lightux v1.3: читаемый Lua с `game.HttpGet`, `loadstring`, анти-tamper `__secureeq`. |
| `corpus/psu_small`, `corpus/aztupbrew`, `corpus/wynfuscate` | PSU / AztupBrew / wYnFuscate | Тестовые сэмплы обфускаторов из `vyxonq-dev/obfuscator-samples` (не игровые) — доказательство, что пайплайн работает не только на King Legacy. |

### Вторая партия: 12 игр, 15 новых сэмплов

| Каталог | Обфускатор | Что это за скрипт |
|---|---|---|
| `blox_fruits/hub` | **Luraph v15** | Blox Fruits: автофарм/квесты, ESP, телепорты, 188 уникальных партов (`KitsuneIsland`, `EmberTemplate`, `Frozen Dimension`, `Mirage Island`, `SeaBeast1`). Полная девиртуализация — читаемый исходник с настоящими именами. |
| `grow_a_garden/hub` | **Luraph v15** | Grow a Garden: автофарм, ESP (48 упоминаний), авто-продажа, телепорты. |
| `bloxburg/autobuild` | MoonSec V3 | Bloxburg: автопостройка домов, 43 телепорта, UI Krnl/Orion. |
| `gacha_online/hub` | PSU 4.0 | Gacha Online: авто-роллы, фарм валюты. |
| `yba/kolgie` | PSU 4.0 | **Your Bizarre Adventure**: хаб, авто-квесты (43), автофарм (38), Aimbot. |
| `the_wild_west/hub` | PSU 4.0 | The Wild West: хаб с автофармом. |
| `the_wild_west/no_coal`, `new_farm`, `coal_farm` | MoonSec V3 | The Wild West: три фермы (без угля / новая / уголь) — восстановлены функционально (salvage-режим). |
| `the_wild_west/send` | MoonSec V3 | Маленькая обёртка-отправитель. |
| `solara_hub/orion` | MoonSec V3 | Solara Hub: Orion, мультиигровой хаб, UI Orion/Solara. |
| `counter_blox/hub` | unprom | Counter Blox: чит-меню. |
| `murder_mystery_2/ghost_hub` | MoonSec V2 | Murder Mystery 2: Ghost Hub. |
| `piggy/hub` | PSU 4.0 | Piggy: хаб. |
| `prison_life/cmd_gui` | unprom | Prison Life: GUI с чат-командами. |
| `tower_of_hell/auto_win` | IronBrew | Tower of Hell: снят только внешний слой (VM остался). |
| `jailbreak/jailtabs` | самописный | Jailbreak: JailTabs 3.2, XOR-загрузчик снят, внутри компактный исходник. |

## Как это получено

```bash
python3 deobf-report/tools/pipeline.py obfuscated.lua --out results/<игра>/<сэмпл> -v
```

Пайплайн сам: определяет обфускатор → запускает нужный девиртуализатор/лифтер →
**патчит битый Lua 5.1 байткод** (`lua51_repair.py`: `maxstacksize` + финальные `RETURN`) →
`unluac` → `extract_parts.py` → `PARTS.md` + `LOG.txt`.

## Важная оговорка

Часть файлов собрана в **salvage-режиме**: если unluac не может разобрать файл целиком из-за одной
плохой функции, чанк режется по прототипам, каждая функция декомпилируется отдельно, а нечитаемые
вставляются дизассемблером с пометкой `-- PSEUDO`. Такие файлы помечены в `LOG.txt`.

Код читаемый и синтаксически корректный, но **не всегда компилируется обратно** стоковым
Lua 5.1: `unluac` объявляет регистры виртуальной машины обычными локалями, и в самых больших
функциях выходит «more than 200 local variables» / «function or expression too complex».
Это ограничение генератора unluac, а не испорченный вывод: логика, строки, имена функций и
партов читаются полностью. Для запуска такой файл нужно либо прогонять через Luau-рантайм,
либо вручную схлопывать «простыни» локалей.
