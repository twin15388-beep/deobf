# Результаты: рабочий код + названия партов

Каждый подкаталог — один сэмпл:

* `script.lua` — **восстановленный Lua-код** (не дизасм и не псевдо-Lua: настоящий Lua 5.1-байткод, прогнанный через декомпилятор `unluac`);
* `PARTS.md` — «части» скрипта: функциональные блоки, UI-библиотека, URL/webhook-и, сервисы, подписи UI и **названия партов/фич**;
* `LOG.txt` — лог пайплайна: чем определён обфускатор, что запускалось, что вернуло.

Индекс с размерами — `INDEX.md`.

Всего **36 сэмплов**, 18 игр/режимов, 9 разных обфускаторов (Luraph v15, MoonSec V3, MoonSec V2,
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

### Третья партия (4-я итерация): ещё 7 игр/режимов, 12 сэмплов

Источник — репозиторий `hexahigh/Scripts` (6 132 Lua-файла; сканировали все, отобрали
файлы с читаемым Lua и типовые обфусцированные). Для этой партии код **не был обфусцирован VM**,
но был **минифицирован в одну строку** — поэтому использован новый инструмент
`tools/lua_beautify.py`: он не меняет ни одного токена, только расставляет переводы строк и
отступы, и в конце сам сверяет поток токенов (гарантия, что код остался тем же).

| Каталог | Что это | Строк | Статус |
|---|---|---|---|
| `jailbreak/unjailbreak` | Jailbreak: авто-ограбления, ESP, aimbot, 71 телепорт, UI Rain | 4 510 | функциональный код |
| `jailbreak/gui_2` | Jailbreak: GUI-меню | 1 834 | функциональный код |
| `jailbreak/jailbreaker_v42` | Jailbreak: Jailbreaker V4.2 | 909 | функциональный код |
| `prison_life/main` | Prison Life: мультитул (килл-аура, ESP, телепорты, админ-команды) | 3 659 | функциональный код |
| `prison_life/simple_gui` | Prison Life: простое GUI | 2 756 | функциональный код |
| `prison_life/gui` | Prison Life: GUI с командами | 1 228 | функциональный код |
| `murder_mystery_2/full` | Murder Mystery 2: роли, ESP, авто-нож | 1 506 | функциональный код |
| `murder_mystery_2/gui` | Murder Mystery 2: GUI | 1 149 | функциональный код |
| `close_quarters_combat/gui` | Close Quarters Combat: чит-меню | 1 613 | функциональный код |
| `pet_simulator/gui` | Pet Simulator: GUI-автофарм, UI Hydra/Rain | 1 354 | функциональный код |
| `pet_simulator/op_gui` | Pet Simulator: OP GUI | 999 | функциональный код |
| `tower_defense_simulator/autofarm` | Tower Defense Simulator: автофарм | 11 121 | **частично** (виден блок настроек `_G.*`, тело — VM Luraph v6-типа) |

Плюс:

* `_failed.md` — 12 обфусцированных файлов из того же репозитория (Synapse Xen 1.1.2, IronBrew 2.7.0/2.7.2,
  Luraph 6.0-beta1 / 11.1 / 11.5, неизвестный Luraph-подобный VM) — с перечнем того, что именно пробовали;
* `_corpus_prometheus/` — новый инструмент `unprom` на 6 эталонных сэмплах Prometheus / wearedevs v1.0 /
  luaobfuscator.com: 6 из 6 разобраны (девиртуализация в плоский CFG + расшифровка строк и ConstantArray).

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
