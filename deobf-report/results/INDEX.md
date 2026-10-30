# Результаты деобфускации

В индекс попадает только то, что **реально удалось деобфусцировать**: в каждом каталоге есть `script.lua` (восстановленный код) и `PARTS.md` (что делает: механики, вызовы API, имена функций, парты/объекты, ссылки).

Каталогов без кода здесь нет — неудачи и причины перечислены в `_failed.md`.

Всего: **61 сэмплов**, **21 игр/режимов**.


- `BEST.md` — что читается как исходник (и антирейтинг).
- `_failed.md` — что не получилось и почему.
- `_batch6.md` — партия 6-й итерации (IronBrew через CASCADE).
- `_corpus_prometheus/` — проверка `unprom` на эталонных сэмплах Prometheus.


| Игра (каталог) | Сэмпл | Строк | Размер | Механики | Обфускатор | Парсится |
|---|---|---:|---:|---|---|---|
| IronBrew | `_script_hub` | 3932 | 111 КБ | сеть / загрузка кода; GUI / меню | — | Lua 5.2+ (goto) |
| IronBrew | `tower_of_hell_script` | 274 | 5 КБ | телепорт / движение; GUI / меню; анти-АФК / ввод | — | Lua 5.2+ (goto) |
| IronBrew | `tiny_tanks_gui` | 212 | 4 КБ | GUI / меню; аимбот / наведение | — | OK |
| IronBrew | `piggy_item_hub` | 166 | 3 КБ | GUI / меню; телепорт / движение; аимбот / наведение | — | OK |
| IronBrew | `prison_life_destroyer_hub` | 166 | 3 КБ | GUI / меню; телепорт / движение; аимбот / наведение | — | OK |
| IronBrew | `god_mode_any_game` | 142 | 2 КБ | телепорт / движение; анти-АФК / ввод | — | OK |
| IronBrew | `avatar_swastika` | 91 | 1 КБ | телепорт / движение; урон / убийство | — | OK |
| IronBrew | `ctrl_click_tp` | 77 | 1 КБ | телепорт / движение; анти-АФК / ввод | — | Lua 5.2+ (goto) |
| IronBrew | `fps_booster` | 37 | 1 КБ | — | — | OK |
| IronBrew | `anti_afk` | 34 | 1 КБ | анти-АФК / ввод; телепорт / движение | — | OK |
| IronBrew | `mega_fun_obby_auto_skip_stages` | 28 | 1 КБ | телепорт / движение; квесты / стадии | — | OK |
| IronBrew | `clone_tycoon_2_1_billion_gems` | 7 | 1 КБ | — | — | OK |
| blox_fruits | `hub` | 6764 | 186 КБ | инвентарь / предметы; сеть / загрузка кода; автофарм / авто-клик | — | Luau (continue) |
| blox_strike | `sigmaware` | 1406 | 55 КБ | GUI / меню; ESP / подсветка; телепорт / движение | unknown | Luau (continue) |
| blox_strike | `friezer_hub` | 1360 | 53 КБ | GUI / меню; ESP / подсветка; телепорт / движение | unknown | Luau (continue) |
| blox_strike | `twistedk1d` | 410 | 15 КБ | GUI / меню; телепорт / движение; сеть / загрузка кода | unknown | OK |
| blox_strike | `pps_hub` | 365 | 13 КБ | ESP / подсветка; GUI / меню; телепорт / движение | unknown | Luau (continue) |
| blox_strike | `d0inks_router` | 11 | 1 КБ | сеть / загрузка кода | unknown | OK |
| bloxburg | `autobuild` | 13315 | 432 КБ | GUI / меню; телепорт / движение; анти-АФК / ввод | moonsec_v3 | Lua 5.2+ (goto) |
| close_quarters_combat | `gui` | 1612 | 50 КБ | телепорт / движение; урон / убийство; анти-АФК / ввод | none (обычный Lua, минифицирован) | OK |
| corpus | `aztupbrew` | 6874 | 219 КБ | GUI / меню; телепорт / движение; аимбот / наведение | psu | артефакт unluac |
| corpus | `psu_small` | 1479 | 53 КБ | телепорт / движение; GUI / меню; инвентарь / предметы | psu | Lua 5.2+ (goto) |
| counter_blox | `hub` | 6915 | 296 КБ | GUI / меню; ESP / подсветка; аимбот / наведение | unknown (via unprom) | OK |
| gacha_online | `hub` | 10451 | 331 КБ | телепорт / движение; урон / убийство; GUI / меню | psu | Lua 5.2+ (goto) |
| gpo | `austina_ui` | 5282 | 217 КБ | GUI / меню; аимбот / наведение; сеть / загрузка кода | unknown | OK |
| gpo | `a7dev_loader` | 842 | 41 КБ | GUI / меню; сеть / загрузка кода; инвентарь / предметы | unknown | артефакт unluac |
| gpo | `tempest_hub` | 290 | 11 КБ | телепорт / движение; автофарм / авто-клик; ESP / подсветка | unknown | OK |
| gpo | `venomware` | 70 | 4 КБ | ESP / подсветка; сеть / загрузка кода; аимбот / наведение | unknown | OK |
| grow_a_garden | `hub` | 10450 | 296 КБ | GUI / меню; деньги / ресурсы; инвентарь / предметы | — | Luau (continue) |
| illegal_soccer | `polsec_loader` | 1580 | 71 КБ | GUI / меню; сеть / загрузка кода; ESP / подсветка | luraph_v15 | Luau (continue) |
| illegal_soccer | `maxlegends_loader` | 1131 | 47 КБ | GUI / меню; сеть / загрузка кода; деньги / ресурсы | unknown | OK |
| illegal_soccer | `super_futebol` | 398 | 14 КБ | телепорт / движение; аимбот / наведение; GUI / меню | unknown | артефакт unluac |
| illegal_soccer | `luarmor_router` | 66 | 7 КБ | сеть / загрузка кода; автофарм / авто-клик; деньги / ресурсы | unknown | OK |
| jailbreak | `unjailbreak` | 4509 | 183 КБ | телепорт / движение; урон / убийство; GUI / меню | none (обычный Lua, минифицирован) | OK |
| jailbreak | `gui_2` | 1833 | 75 КБ | телепорт / движение; GUI / меню; ESP / подсветка | none (обычный Lua, минифицирован) | OK |
| jailbreak | `jailbreaker_v42` | 908 | 31 КБ | телепорт / движение; GUI / меню; аимбот / наведение | none (обычный Lua, минифицирован) | OK |
| king_legacy | `KL_psu45_ano` | 56150 | 3421 КБ | GUI / меню; телепорт / движение; урон / убийство | psu | артефакт unluac |
| king_legacy | `KL_psu40_BloxFruit` | 36695 | 1295 КБ | GUI / меню; телепорт / движение; деньги / ресурсы | psu | артефакт unluac |
| king_legacy | `KL_psu40_Kingpiece` | 26393 | 849 КБ | GUI / меню; телепорт / движение; урон / убийство | psu | артефакт unluac |
| king_legacy | `KL_msv3_v15_ZombieAttack` | 10423 | 279 КБ | телепорт / движение; GUI / меню; анти-АФК / ввод | moonsec_v3 | артефакт unluac |
| king_legacy | `KL_msv3_v14_ZombieAttack` | 6765 | 149 КБ | телепорт / движение; GUI / меню; урон / убийство | moonsec_v3 | артефакт unluac |
| king_legacy | `KL_msv2_v13` | 4207 | 133 КБ | телепорт / движение; урон / убийство; GUI / меню | moonsec_v2 | Luau (continue) |
| murder_mystery_2 | `ghost_hub` | 7356 | 217 КБ | телепорт / движение; деньги / ресурсы; GUI / меню | moonsec_v2 | Luau (continue) |
| murder_mystery_2 | `full` | 1505 | 56 КБ | телепорт / движение; GUI / меню; ESP / подсветка | none (обычный Lua, минифицирован) | OK |
| murder_mystery_2 | `gui` | 1148 | 40 КБ | телепорт / движение; GUI / меню; урон / убийство | none (обычный Lua, минифицирован) | артефакт unluac |
| one_piece | `kaitun_nav` | 1107 | 34 КБ | GUI / меню; автофарм / авто-клик; телепорт / движение | unknown | OK |
| pet_simulator | `gui` | 1353 | 49 КБ | телепорт / движение; GUI / меню; деньги / ресурсы | none (обычный Lua, минифицирован) | OK |
| pet_simulator | `op_gui` | 998 | 28 КБ | телепорт / движение; деньги / ресурсы; GUI / меню | none (обычный Lua, минифицирован) | OK |
| piggy | `hub` | 2881 | 56 КБ | телепорт / движение; GUI / меню; сеть / загрузка кода | psu | Lua 5.2+ (goto) |
| prison_life | `main` | 3658 | 158 КБ | телепорт / движение; урон / убийство; GUI / меню | none (обычный Lua, минифицирован) | OK |
| prison_life | `cmd_gui` | 3477 | 130 КБ | телепорт / движение; урон / убийство; GUI / меню | unknown (via unprom) | OK |
| prison_life | `simple_gui` | 2755 | 95 КБ | телепорт / движение; урон / убийство; GUI / меню | none (обычный Lua, минифицирован) | OK |
| prison_life | `gui` | 1227 | 45 КБ | телепорт / движение; GUI / меню; аимбот / наведение | none (обычный Lua, минифицирован) | OK |
| solara_hub | `orion` | 9449 | 275 КБ | GUI / меню; аимбот / наведение; телепорт / движение | moonsec_v3 | Lua 5.2+ (goto) |
| the_wild_west | `hub` | 6612 | 154 КБ | телепорт / движение; сеть / загрузка кода; ESP / подсветка | psu | Lua 5.2+ (goto) |
| the_wild_west | `coal_farm` | 2417 | 112 КБ | телепорт / движение; автофарм / авто-клик; сеть / загрузка кода | moonsec_v3 | OK |
| the_wild_west | `no_coal` | 2411 | 111 КБ | телепорт / движение; автофарм / авто-клик; сеть / загрузка кода | moonsec_v3 | OK |
| the_wild_west | `new_farm` | 2355 | 109 КБ | телепорт / движение; автофарм / авто-клик; сеть / загрузка кода | moonsec_v3 | OK |
| yba | `kolgie` | 4350 | 99 КБ | телепорт / движение; GUI / меню; сеть / загрузка кода | psu | артефакт unluac |
| yba | `azero_hub` | 992 | 30 КБ | телепорт / движение; GUI / меню; инвентарь / предметы | unknown | OK |
| yba | `aethelburg_v16` | 681 | 27 КБ | GUI / меню; телепорт / движение; автофарм / авто-клик | unknown | Luau (continue) |

**Проверка `loadfile` в Lua 5.1.1:** OK — 33, артефакт unluac — 10, Lua 5.2+ (goto) — 9, Luau (continue) — 9.

**Колонка «Парсится»** — проверка `loadfile` в Lua 5.1.1. `Lua 5.2+ (goto)` и `Luau (continue)` — код корректный, но использует конструкции новее 5.1 (unluac иногда оставляет `goto lbl_N`, а часть скриптов изначально Luau). `артефакт unluac` — известный дефект генератора на больших функциях.
