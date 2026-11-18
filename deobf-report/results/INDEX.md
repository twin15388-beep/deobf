# Результаты деобфускации

В индекс попадает только то, что **реально удалось деобфусцировать**: в каждом каталоге есть `script.combined.lua` — единый файл: восстановленный код + `PARTS.md` (механики, API, имена функций, парты) как комментарии. Отдельных `script.lua`/`PARTS.md` в репозитории больше нет.

Каталогов без кода здесь нет — неудачи и причины перечислены в `_failed.md`.

Всего: **63 сэмплов**, **22 игр/режимов**.

- `BEST.md` — что читается как исходник (и антирейтинг).
- `COMBINED.md` — формат и проверка единых файлов.
- `_failed.md` — что не получилось и почему.
- `_batch6.md` — партия 6-й итерации (IronBrew через CASCADE).
- `_corpus_prometheus/` — проверка `unprom` на эталонных сэмплах Prometheus.

| Игра (каталог) | Сэмпл | Строк | Размер | Механики | Обфускатор | Парсится |
|---|---|---:|---:|---|---|---|
| blox_fruits | `hub` | 6766 | 193 КБ | инвентарь / предметы; сеть / загрузка кода; автофарм / авто-клик | — | Luau (continue) |
| blox_strike | `d0inks_router` | 13 | 3 КБ | сеть / загрузка кода | unknown | OK |
| blox_strike | `friezer_hub` | 1362 | 59 КБ | GUI / меню; ESP / подсветка; телепорт / движение | unknown | Luau (continue) |
| blox_strike | `pps_hub` | 367 | 17 КБ | ESP / подсветка; GUI / меню; телепорт / движение | unknown | Luau (continue) |
| blox_strike | `sigmaware` | 1408 | 59 КБ | GUI / меню; ESP / подсветка; телепорт / движение | unknown | Luau (continue) |
| blox_strike | `twistedk1d` | 412 | 20 КБ | GUI / меню; телепорт / движение; сеть / загрузка кода | unknown | OK |
| bloxburg | `autobuild` | 13317 | 437 КБ | GUI / меню; телепорт / движение; анти-АФК / ввод | moonsec_v3 | Lua 5.2+ (goto) |
| close_quarters_combat | `gui` | 1614 | 54 КБ | телепорт / движение; урон / убийство; анти-АФК / ввод | none (обычный Lua, минифицирован) | OK |
| corpus | `aztupbrew` | 6876 | 223 КБ | GUI / меню; телепорт / движение; аимбот / наведение | psu | артефакт unluac |
| corpus | `luraph_v15_rideapet` | 5172 | 115 КБ | ESP; Fly/Noclip; Teleport | luraph_v15 | Luau (continue) |
| corpus | `psu_small` | 1481 | 58 КБ | телепорт / движение; GUI / меню; инвентарь / предметы | psu | Lua 5.2+ (goto) |
| counter_blox | `hub` | 6917 | 302 КБ | GUI / меню; ESP / подсветка; аимбот / наведение | unknown (via unprom) | OK |
| gacha_online | `hub` | 10453 | 336 КБ | телепорт / движение; урон / убийство; GUI / меню | psu | Lua 5.2+ (goto) |
| gpo | `a7dev_loader` | 844 | 46 КБ | GUI / меню; сеть / загрузка кода; инвентарь / предметы | unknown | артефакт unluac |
| gpo | `austina_ui` | 5284 | 223 КБ | GUI / меню; аимбот / наведение; сеть / загрузка кода | unknown | OK |
| gpo | `tempest_hub` | 292 | 16 КБ | телепорт / движение; автофарм / авто-клик; ESP / подсветка | unknown | OK |
| gpo | `venomware` | 72 | 8 КБ | ESP / подсветка; сеть / загрузка кода; аимбот / наведение | unknown | OK |
| grow_a_garden | `hub` | 10452 | 303 КБ | GUI / меню; деньги / ресурсы; инвентарь / предметы | — | Luau (continue) |
| illegal_soccer | `luarmor_router` | 68 | 13 КБ | сеть / загрузка кода; автофарм / авто-клик; деньги / ресурсы | unknown | OK |
| illegal_soccer | `maxlegends_loader` | 1133 | 52 КБ | GUI / меню; сеть / загрузка кода; деньги / ресурсы | unknown | OK |
| illegal_soccer | `polsec_loader` | 1582 | 76 КБ | GUI / меню; сеть / загрузка кода; ESP / подсветка | luraph_v15 | Luau (continue) |
| illegal_soccer | `super_futebol` | 400 | 18 КБ | телепорт / движение; аимбот / наведение; GUI / меню | unknown | артефакт unluac |
| ironbrew_cascade | `_script_hub` | 3934 | 114 КБ | сеть / загрузка кода; GUI / меню | — | Lua 5.2+ (goto) |
| ironbrew_cascade | `anti_afk` | 36 | 3 КБ | анти-АФК / ввод; телепорт / движение | — | OK |
| ironbrew_cascade | `avatar_swastika` | 93 | 5 КБ | телепорт / движение; урон / убийство | — | OK |
| ironbrew_cascade | `clone_tycoon_2_1_billion_gems` | 9 | 3 КБ | — | — | OK |
| ironbrew_cascade | `ctrl_click_tp` | 79 | 4 КБ | телепорт / движение; анти-АФК / ввод | — | Lua 5.2+ (goto) |
| ironbrew_cascade | `fps_booster` | 39 | 4 КБ | — | — | OK |
| ironbrew_cascade | `god_mode_any_game` | 144 | 5 КБ | телепорт / движение; анти-АФК / ввод | — | OK |
| ironbrew_cascade | `mega_fun_obby_auto_skip_stages` | 30 | 3 КБ | телепорт / движение; квесты / стадии | — | OK |
| ironbrew_cascade | `piggy_item_hub` | 168 | 6 КБ | GUI / меню; телепорт / движение; аимбот / наведение | — | OK |
| ironbrew_cascade | `prison_life_destroyer_hub` | 168 | 6 КБ | GUI / меню; телепорт / движение; аимбот / наведение | — | OK |
| ironbrew_cascade | `tiny_tanks_gui` | 214 | 7 КБ | GUI / меню; аимбот / наведение | — | OK |
| ironbrew_cascade | `tower_of_hell_script` | 276 | 9 КБ | телепорт / движение; GUI / меню; анти-АФК / ввод | — | Lua 5.2+ (goto) |
| jailbreak | `gui_2` | 1835 | 80 КБ | телепорт / движение; GUI / меню; ESP / подсветка | none (обычный Lua, минифицирован) | OK |
| jailbreak | `jailbreaker_v42` | 910 | 35 КБ | телепорт / движение; GUI / меню; аимбот / наведение | none (обычный Lua, минифицирован) | OK |
| jailbreak | `unjailbreak` | 4511 | 188 КБ | телепорт / движение; урон / убийство; GUI / меню | none (обычный Lua, минифицирован) | OK |
| king_legacy | `KL_msv2_v13` | 4209 | 138 КБ | телепорт / движение; урон / убийство; GUI / меню | moonsec_v2 | Luau (continue) |
| king_legacy | `KL_msv3_v14_ZombieAttack` | 6767 | 155 КБ | телепорт / движение; GUI / меню; урон / убийство | moonsec_v3 | артефакт unluac |
| king_legacy | `KL_msv3_v15_ZombieAttack` | 10425 | 285 КБ | телепорт / движение; GUI / меню; анти-АФК / ввод | moonsec_v3 | артефакт unluac |
| king_legacy | `KL_psu40_BloxFruit` | 36697 | 1301 КБ | GUI / меню; телепорт / движение; деньги / ресурсы | psu | артефакт unluac |
| king_legacy | `KL_psu40_Kingpiece` | 26395 | 854 КБ | GUI / меню; телепорт / движение; урон / убийство | psu | артефакт unluac |
| king_legacy | `KL_psu45_ano` | 56152 | 3427 КБ | GUI / меню; телепорт / движение; урон / убийство | psu | артефакт unluac |
| murder_mystery_2 | `full` | 1507 | 61 КБ | телепорт / движение; GUI / меню; ESP / подсветка | none (обычный Lua, минифицирован) | OK |
| murder_mystery_2 | `ghost_hub` | 7358 | 222 КБ | телепорт / движение; деньги / ресурсы; GUI / меню | moonsec_v2 | Luau (continue) |
| murder_mystery_2 | `gui` | 1150 | 45 КБ | телепорт / движение; GUI / меню; урон / убийство | none (обычный Lua, минифицирован) | артефакт unluac |
| one_piece | `kaitun_nav` | 1109 | 39 КБ | GUI / меню; автофарм / авто-клик; телепорт / движение | unknown | OK |
| pet_simulator | `gui` | 1355 | 53 КБ | телепорт / движение; GUI / меню; деньги / ресурсы | none (обычный Lua, минифицирован) | OK |
| pet_simulator | `op_gui` | 1000 | 32 КБ | телепорт / движение; деньги / ресурсы; GUI / меню | none (обычный Lua, минифицирован) | OK |
| piggy | `hub` | 2883 | 61 КБ | телепорт / движение; GUI / меню; сеть / загрузка кода | psu | Lua 5.2+ (goto) |
| prison_life | `cmd_gui` | 3479 | 135 КБ | телепорт / движение; урон / убийство; GUI / меню | unknown (via unprom) | OK |
| prison_life | `gui` | 1229 | 49 КБ | телепорт / движение; GUI / меню; аимбот / наведение | none (обычный Lua, минифицирован) | OK |
| prison_life | `main` | 3660 | 163 КБ | телепорт / движение; урон / убийство; GUI / меню | none (обычный Lua, минифицирован) | OK |
| prison_life | `simple_gui` | 2757 | 100 КБ | телепорт / движение; урон / убийство; GUI / меню | none (обычный Lua, минифицирован) | OK |
| shindo_life | `dogehub_v2_shindo` | 14300 | 503 КБ | — | — | OK |
| solara_hub | `orion` | 9451 | 280 КБ | GUI / меню; аимбот / наведение; телепорт / движение | moonsec_v3 | Lua 5.2+ (goto) |
| the_wild_west | `coal_farm` | 2419 | 116 КБ | телепорт / движение; автофарм / авто-клик; сеть / загрузка кода | moonsec_v3 | OK |
| the_wild_west | `hub` | 6614 | 159 КБ | телепорт / движение; сеть / загрузка кода; ESP / подсветка | psu | Lua 5.2+ (goto) |
| the_wild_west | `new_farm` | 2357 | 113 КБ | телепорт / движение; автофарм / авто-клик; сеть / загрузка кода | moonsec_v3 | OK |
| the_wild_west | `no_coal` | 2413 | 116 КБ | телепорт / движение; автофарм / авто-клик; сеть / загрузка кода | moonsec_v3 | OK |
| yba | `aethelburg_v16` | 683 | 32 КБ | GUI / меню; телепорт / движение; автофарм / авто-клик | unknown | Luau (continue) |
| yba | `azero_hub` | 994 | 35 КБ | телепорт / движение; GUI / меню; инвентарь / предметы | unknown | OK |
| yba | `kolgie` | 4352 | 104 КБ | телепорт / движение; GUI / меню; сеть / загрузка кода | psu | артефакт unluac |
