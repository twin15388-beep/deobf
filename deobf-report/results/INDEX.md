# Результаты деобфускации

В каждом каталоге: `script.lua` — восстановленный/нормализованный Lua-код, `PARTS.md` — функционал, UI, URL и **названия партов/объектов**, `LOG.txt` — чем определяли, чем деобфусцировали, что вышло.

Всего сэмплов: **67**, игр/режимов: **29** (55 из прошлых итераций + 12 новых из IronBrew-корпуса, см. `ironbrew_cascade/`).

- `_failed.md` — что не удалось и почему.
- `_batch5.md` — таблица последней партии (GPO / Illegal Soccer / Blox Strike / YBA).
- `_corpus_prometheus/` — проверка `unprom` на эталонных сэмплах Prometheus.
- `_batch6.md` — таблица 6-й итерации (девиртуализация IronBrew через CASCADE).
- `ironbrew_cascade/` — **36 IronBrew/AztupBrew-скриптов**: 12 декомпилированы в настоящий Lua,
  для остальных 24 — только `PARTS.md` (имена объектов). Подробности — `ironbrew_cascade/README.md`.

| Игра (каталог) | Сэмпл | Обфускатор | Что это | Строк Lua | Размер |
|---|---|---|---|---|---|
| blox_fruits | `hub` | luraph_v15 | Blox Fruits: автофарм/квесты, ESP, телепорты (девиртуализация Luraph v15, читаемый исходник) | 6765 | 186 КБ |
| blox_strike | `d0inks_router` | — | Blox Strike: роутер moon.lua (PlaceId → ext/bloxstrike.lua) | 12 | 0 КБ |
| blox_strike | `friezer_hub` | — | Blox Strike: хаб на Rayfield | 1361 | 53 КБ |
| blox_strike | `mahmuthub_wearedevs` | wearedevs / Prometheus (de-flatten) | MahmutHub для Blox Strike: wearedevs/Prometheus VM | 7185 | 155 КБ |
| blox_strike | `moon_ext_doink` | — | Blox Strike: ext/bloxstrike.lua от d0inks, обфускатор doink v1 (после unprom) | 1712 | 87 КБ |
| blox_strike | `pps_hub` | — | Blox Strike: PPS-скрипт (UI-библиотека из репозитория deividcomson) | 366 | 13 КБ |
| blox_strike | `sigmaware` | — | Blox Strike: Sigmaware (дамп инстансов/модулей) | 1407 | 55 КБ |
| blox_strike | `twistedk1d` | — | Blox Strike: скрипт twistedk1d | 411 | 15 КБ |
| bloxburg | `autobuild` | moonsec_v3 | Bloxburg: автопостройка, телепорты, UI Krnl/Orion | 13316 | 432 КБ |
| close_quarters_combat | `gui` | — (минифицирован) | Close Quarters Combat: чит-меню | 1613 | 50 КБ |
| corpus | `aztupbrew` | psu | бенчмарк-сэмпл | 6875 | 219 КБ |
| corpus | `psu_small` | psu | бенчмарк-сэмпл | 1480 | 53 КБ |
| corpus | `wynfuscate` | wynfuscate (via unprom) | бенчмарк-сэмпл | 325 | 96 КБ |
| counter_blox | `hub` | unknown (via unprom) | Counter Blox: чит-меню | 6916 | 296 КБ |
| gacha_online | `hub` | psu | Gacha Online: авто-роллы, фарм валюты | 10452 | 331 КБ |
| gpo | `a7dev_loader` | — | Grand Piece Online: A7DEV Hub — премиум-загрузчик (key-system, Supabase-эндпоинт) | 843 | 41 КБ |
| gpo | `austina_ui` | — | Grand Piece Online: UI-библиотека Austina, вытащенная из декомпила SeaHub | 5283 | 217 КБ |
| gpo | `tempest_hub` | — | Grand Piece Online: Tempest Hub — автофарм/ESP, UI Linoria | 291 | 11 КБ |
| gpo | `venomware` | — | Grand Piece Online: VenomWare — лоадер с UI-библиотекой | 71 | 4 КБ |
| grow_a_garden | `hub` | luraph_v15 | Grow a Garden: автофарм, ESP 48 упоминаний, авто-продажа | 10451 | 296 КБ |
| illegal_soccer | `luarmor_router` | — | Illegal Soccer: Luarmor-роутер (PlaceId → URL лоадера), запись для Illegal Soccer | 67 | 7 КБ |
| illegal_soccer | `maxlegends_loader` | — | Illegal Soccer: MAXLEGENDS master-loader (ключи в Cloudflare KV) | 1132 | 47 КБ |
| illegal_soccer | `polsec_loader` | luraph_v15 | Illegal Soccer: лоадер sportsclub на api.polsec.net (key-system, SDK, LoadGame по PlaceId) | 1581 | 71 КБ |
| illegal_soccer | `super_futebol` | — | Футбольный режим: Super Futebol Proibido v1.0 (аналог Illegal Soccer) | 399 | 14 КБ |
| jailbreak | `gui_2` | — (минифицирован) | Jailbreak: GUI-меню | 1834 | 75 КБ |
| jailbreak | `jailbreaker_v42` | — (минифицирован) | Jailbreak: Jailbreaker V4.2 | 909 | 31 КБ |
| jailbreak | `unjailbreak` | — (минифицирован) | Jailbreak: UNJAILBREAK — авто-ограбления, ESP | 4510 | 183 КБ |
| king_legacy | `KL_msv2_v13` | moonsec_v2 | Lightux v1.3 | 4208 | 133 КБ |
| king_legacy | `KL_msv3_v14_ZombieAttack` | moonsec_v3 | Lightux v1.4 (Zombie Attack) | 6766 | 149 КБ |
| king_legacy | `KL_msv3_v15_ZombieAttack` | moonsec_v3 | Lightux v1.5 (Zombie Attack) | 10424 | 279 КБ |
| king_legacy | `KL_psu40_BloxFruit` | psu | Blox Fruits hub: автофарм, Aimbot Gun, 46 телепортов | 36696 | 1295 КБ |
| king_legacy | `KL_psu40_Kingpiece` | psu | Kingpiece hub: автофарм NPC King Legacy / Blox Fruits | 26394 | 849 КБ |
| king_legacy | `KL_psu45_ano` | psu | ano hub: King Legacy + key-система | 56151 | 3421 КБ |
| murder_mystery_2 | `full` | — (минифицирован) | Murder Mystery 2: полный скрипт (роли, ESP, авто-нож) | 1506 | 56 КБ |
| murder_mystery_2 | `ghost_hub` | moonsec_v2 | Murder Mystery 2: Ghost Hub | 7357 | 217 КБ |
| murder_mystery_2 | `gui` | — (минифицирован) | Murder Mystery 2: GUI | 1149 | 40 КБ |
| one_piece | `kaitun_nav` | — | One Piece Kaitun: Nav v2.1 (Rayfield, travel_to, авто-покупки) | 1108 | 34 КБ |
| pet_simulator | `gui` | — (минифицирован) | Pet Simulator: GUI-автофарм | 1354 | 49 КБ |
| pet_simulator | `op_gui` | — (минифицирован) | Pet Simulator: OP GUI | 999 | 28 КБ |
| piggy | `hub` | psu | Piggy: хаб | 2882 | 56 КБ |
| prison_life | `cmd_gui` | unknown (via unprom) | Prison Life: GUI с чат-командами | 3478 | 130 КБ |
| prison_life | `gui` | — (минифицирован) | Prison Life: GUI с командами | 1228 | 45 КБ |
| prison_life | `main` | — (минифицирован) | Prison Life: большой мультитул-скрипт (килл-аура, ESP, телепорты) | 3659 | 158 КБ |
| prison_life | `simple_gui` | — (минифицирован) | Prison Life: простое GUI-меню | 2756 | 95 КБ |
| solara_hub | `orion` | moonsec_v3 | Solara Hub: Orion, мультиигровой хаб | 9450 | 275 КБ |
| the_wild_west | `coal_farm` | moonsec_v3 | The Wild West: фарм угля | 2418 | 112 КБ |
| the_wild_west | `hub` | psu | The Wild West: хаб с автофармом | 6613 | 154 КБ |
| the_wild_west | `new_farm` | moonsec_v3 | The Wild West: новый фарм (salvage) | 2356 | 109 КБ |
| the_wild_west | `no_coal` | moonsec_v3 | The Wild West: фарм без угля (функция-за-функцией salvage) | 2412 | 111 КБ |
| tower_defense_simulator | `autofarm` | — (минифицирован) | Tower Defense Simulator: автофарм (частично: виден блок настроек, тело — VM Luraph v6-типа) | 11121 | 306 КБ |
| tower_of_hell | `auto_win` | ironbrew (via unprom) | Tower of Hell: авто-прохождение (снят только внешний слой IronBrew) | 296 | 287 КБ |
| yba | `aethelburg_v16` | — | YBA: Aethelburg V16 (автофарм/ESP) | 682 | 27 КБ |
| yba | `azero_hub` | — | YBA: Azero Hub | 993 | 30 КБ |
| yba | `kolgie` | psu | Your Bizarre Adventure: хаб, авто-квесты/фарм | 4351 | 99 КБ |
| yba | `ysf_luraph14` | luraph_v14 (0.50, "Luraph Obfuscator v14.4.2") | YSF Protected для YBA: Luraph v14.4.2 | 173 | 47 КБ |


## 6-я итерация: IronBrew / AztupBrew (каталог `ironbrew_cascade/`)

36 файлов с заголовком IronBrew/AztupBrew из `hexahigh/Scripts` прогнаны через CASCADE
с починенным рантаймом (свой Lua 5.1.1 + конвертер чанка 32→64 бита + пересчёт `maxstack`).

**Декомпилировано в настоящий Lua — 12 из 36:**

| Каталог | Игра/тема | Строк | Что внутри |
|---|---|---:|---|
| `_script_hub` | мультиигровой хаб (~100 игр) | 3932 | список игр, HttpGet + XOR-декодер строк, кнопки GUI |
| `tiny_tanks_gui` | Tiny Tanks | 212 | GUI, Color3/UDim2, обработчики кнопок |
| `piggy_item_hub` / `prison_life_destroyer_hub` | Piggy, Prison Life | 166 | хаб предметов (дубликаты одного скрипта) |
| `tower_of_hell_script` | Tower of Hell | 274 | авто-прохождение, `goto` в выводе (Lua 5.2+) |
| `god_mode_any_game` | универсальный | 142 | MoveTo/Tween к персонажу, UserInputService |
| `avatar_swastika` | скин персонажа | 91 | BodyForce, HumanoidRootPart |
| `ctrl_click_tp` | универсальный | 77 | телепорт по Ctrl+клик |
| `fps_booster` | универсальный | 37 | очистка эффектов/Lighting |
| `anti_afk` | универсальный | 34 | VirtualUser/Idled |
| `mega_fun_obby_auto_skip_stages` | Mega Fun Obby | 28 | авто-скип стадий |
| `clone_tycoon_2_1_billion_gems` | Clone Tycoon 2 | 7 | минимальный скрипт |

**Остальные 24** — чанк не грузится (`CALL C=0` со съехавшими операндами / `JMP` за пределы
кода в служебных прототипах); в каталогах лежат `PARTS.md` с именами объектов и классов.
