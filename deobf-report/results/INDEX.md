# Результаты деобфускации

В каждом каталоге: `script.lua` — восстановленный Lua-код, `PARTS.md` — функционал, UI, URL и **названия партов/объектов**, `LOG.txt` — лог (чем определяли, чем деобфусцировали, что получилось).

Всего сэмплов: **36**, игр/режимов: **18**.

- `_failed.md` — что не удалось и почему (12 обфусцированных сэмплов 4-й итерации).
- `_batch3.md` — таблица третьей партии (4-я итерация).
- `_corpus_prometheus/` — проверка нового инструмента `unprom` на 6 эталонных сэмплах Prometheus / wearedevs / luaobfuscator.com.

| Игра (каталог) | Сэмпл | Обфускатор | Что это | Строк Lua | Размер |
|---|---|---|---|---|---|
| blox_fruits | `hub` | luraph_v15 | Blox Fruits: автофарм/квесты, ESP, телепорты (девиртуализация Luraph v15, читаемый исходник) | 6764 | 186 КБ |
| bloxburg | `autobuild` | moonsec_v3 | Bloxburg: автопостройка, телепорты, UI Krnl/Orion | 13315 | 432 КБ |
| close_quarters_combat | `gui` | — (минифицирован) | Close Quarters Combat: чит-меню | 1613 | 50 КБ |
| corpus | `aztupbrew` | AztupBrew (форк PSU) | бенчмарк-сэмпл | 6874 | 219 КБ |
| corpus | `psu_small` | PSU | бенчмарк-сэмпл | 1479 | 53 КБ |
| corpus | `wynfuscate` | wYnFuscate | бенчмарк-сэмпл | 324 | 96 КБ |
| counter_blox | `hub` | unprom | Counter Blox: чит-меню | 6915 | 296 КБ |
| gacha_online | `hub` | psu | Gacha Online: авто-роллы, фарм валюты | 10451 | 331 КБ |
| grow_a_garden | `hub` | luraph_v15 | Grow a Garden: автофарм, ESP 48 упоминаний, авто-продажа | 10450 | 296 КБ |
| jailbreak | `gui_2` | — (минифицирован) | Jailbreak: GUI-меню | 1834 | 75 КБ |
| jailbreak | `jailbreaker_v42` | — (минифицирован) | Jailbreak: Jailbreaker V4.2 | 909 | 31 КБ |
| jailbreak | `unjailbreak` | — (минифицирован) | Jailbreak: UNJAILBREAK — авто-ограбления, ESP | 4510 | 183 КБ |
| king_legacy | `KL_msv2_v13` | MoonSec V2 | Lightux v1.3 | 4207 | 133 КБ |
| king_legacy | `KL_msv3_v14_ZombieAttack` | MoonSec V3 | Lightux v1.4 (Zombie Attack) | 6765 | 149 КБ |
| king_legacy | `KL_msv3_v15_ZombieAttack` | MoonSec V3 | Lightux v1.5 (Zombie Attack) | 10423 | 279 КБ |
| king_legacy | `KL_psu40_BloxFruit` | PSU 4.0.A | Blox Fruits hub: автофарм, Aimbot Gun, 46 телепортов | 36695 | 1295 КБ |
| king_legacy | `KL_psu40_Kingpiece` | PSU 4.0.A | Kingpiece hub: автофарм NPC King Legacy / Blox Fruits | 26393 | 849 КБ |
| king_legacy | `KL_psu45_ano` | PSU 4.5.A | ano hub: King Legacy + key-система | 56150 | 3421 КБ |
| murder_mystery_2 | `full` | — (минифицирован) | Murder Mystery 2: полный скрипт (роли, ESP, авто-нож) | 1506 | 56 КБ |
| murder_mystery_2 | `ghost_hub` | moonsec_v2 | Murder Mystery 2: Ghost Hub | 7356 | 217 КБ |
| murder_mystery_2 | `gui` | — (минифицирован) | Murder Mystery 2: GUI | 1149 | 40 КБ |
| pet_simulator | `gui` | — (минифицирован) | Pet Simulator: GUI-автофарм | 1354 | 49 КБ |
| pet_simulator | `op_gui` | — (минифицирован) | Pet Simulator: OP GUI | 999 | 28 КБ |
| piggy | `hub` | psu | Piggy: хаб | 2881 | 56 КБ |
| prison_life | `cmd_gui` | unprom | Prison Life: GUI с чат-командами | 3477 | 130 КБ |
| prison_life | `gui` | — (минифицирован) | Prison Life: GUI с командами | 1228 | 45 КБ |
| prison_life | `main` | — (минифицирован) | Prison Life: большой мультитул-скрипт (килл-аура, ESP, телепорты) | 3659 | 158 КБ |
| prison_life | `simple_gui` | — (минифицирован) | Prison Life: простое GUI-меню | 2756 | 95 КБ |
| solara_hub | `orion` | moonsec_v3 | Solara Hub: Orion, мультиигровой хаб | 9449 | 275 КБ |
| the_wild_west | `coal_farm` | moonsec_v3 | The Wild West: фарм угля | 2417 | 112 КБ |
| the_wild_west | `hub` | psu | The Wild West: хаб с автофармом | 6612 | 154 КБ |
| the_wild_west | `new_farm` | moonsec_v3 | The Wild West: новый фарм (salvage) | 2355 | 109 КБ |
| the_wild_west | `no_coal` | moonsec_v3 | The Wild West: фарм без угля (функция-за-функцией salvage) | 2411 | 111 КБ |
| tower_defense_simulator | `autofarm` | Luraph 6.x-тип | Tower Defense Simulator: автофарм (частично: виден блок настроек, тело — VM Luraph v6-типа) | 11121 | 306 КБ |
| tower_of_hell | `auto_win` | ironbrew | Tower of Hell: авто-прохождение (снят только внешний слой IronBrew) | 295 | 287 КБ |
| yba | `kolgie` | psu | Your Bizarre Adventure: хаб, авто-квесты/фарм | 4350 | 99 КБ |

