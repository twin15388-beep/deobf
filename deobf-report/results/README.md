# Результаты: только деобфусцированный код

**Правило папки:** здесь лежит только то, что реально удалось деобфусцировать.
Никакого обфусцированного кода, дизасма и «псевдо-Lua» — если тело не поднялось,
каталога тут нет, а сэмпл с причиной лежит в `_failed.md`.

В каждом каталоге:

* `script.lua` — **восстановленный Lua-код** (не дизасм и не псевдо-Lua: настоящий Lua 5.1-байткод, прогнанный через декомпилятор `unluac`);
* `PARTS.md` — **что делает скрипт**: механики (с уликами), вызовы Roblox API, имена функций, парты/объекты, ссылки/webhooks.

Индекс — `INDEX.md`, «что читается лучше всего» — `BEST.md`, неудачи — `_failed.md`.

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

### Четвёртая партия (5-я итерация): GPO, Illegal Soccer, Blox Strike, YBA

Запрос был «GPO / King Legacy / Illegal Soccer / Blox Strike / YBA + популярные режимы».
Что нашлось и что с этим сделано:

| Режим | Сэмплы | Источник | Состояние |
|---|---|---|---|
| **Grand Piece Online** | `gpo/tempest_hub`, `gpo/a7dev_loader`, `gpo/venomware`, `gpo/austina_ui` | `TrilhaX/scriptexec` (`Games/gpo.lua`), `moa456811-prog/roblox-hubs`, `lenny2010/VenomWare-V1`, `Ic0u/achieved-scripts` (`seahub.lua`) | рабочего обфусцированного сэмпла GPO **в паблике нет** — все 4 файла открытые (Tempest Hub на Linoria: AutoFarm + 19 партов) |
| **King Legacy** | 6 сэмплов из прошлых партий (`king_legacy/*`) | `XxBoomer/script`, `hankiwastaken/Cracks` | **все 6 разобраны** (PSU 4.0/4.5, MoonSec V2/V3) — новых обфусцированных за итерацию не появилось |
| **Illegal Soccer** | `illegal_soccer/polsec_loader`, `maxlegends_loader`, `luarmor_router`, `super_futebol` | `s1mpl33222-glitch/lua-obfuscator-samples`, `arthurtrovoada21-arch/Super-Futebol-Proibido` | открытые лоадеры. В `polsec_loader` — таблица `GameList` на **81 игру** (PlaceId → scriptId), включая сам Illegal Soccer (`10155360168`). Сами читы отдаются по ключу с `api.polsec.net` / Luarmor — статически их не достать |
| **Blox Strike** | `blox_strike/*` — 5 сэмплов | `Friezer71/script`, `twistedk1d/BloxStrike`, `nathanathan69420-pixel/PPS`, `d0inks/moon.lua`, `brkapery/Sigmaware-Roblox-BloxStrike` | все 5 — открытый Lua (Rayfield/Obsidian-хабы, роутер `moon.lua`, дамп Sigmaware). Обфусцированные `mahmuthub_wearedevs` (wearedevs/Prometheus) и `moon_ext_doink` (doink v1) в результаты не попали: тело осталось VM → `_failed.md` |
| **YBA** | `yba/kolgie` (PSU), `azero_hub`, `aethelburg_v16` | `rorri-cm/yba-autofarm`, `thatguyscousin9/azero-hub`, `EYDB0812/YBA-SCR-PT` | `kolgie` — PSU, разобран полностью; два остальных — открытый Lua. **Luraph v14.4.2** (`ysf_luraph14`) поднят только частично (1 proto из VM) → `_failed.md` |
| Бонус | `one_piece/kaitun_nav` | `Spade324/SpadesHub` | открытый хаб One Piece Kaitun (Rayfield) |

Плюс к этому в этой итерации впервые заработал путь **Luraph v14** в `Deobfuscator-Luraph-V15`
(для этого пришлось собрать `bin/luau` и `bin/luau-ast` под Linux) и обновлён `lua_beautify.py`:
нашёлся класс ошибок, когда `a - -b` склеивалось в `--b` (комментарий) — теперь склейка, образующая
новый токен (`--`, `[[`, `]]`, `<<`, `==`, `..`), запрещена.

### Пятая партия (6-я итерация): IronBrew / AztupBrew через CASCADE

36 файлов с заголовком IronBrew из `hexahigh/Scripts`; **12 доведены до настоящего Lua**,
остальные 24 в `results/` не попали (тело не собралось) — их имена объектов и причины в `_failed.md`.

| Каталог | Игра/тема | Строк |
|---|---|---:|
| `ironbrew_cascade/_script_hub` | мультиигровой хаб (~100 игр, HttpGet + XOR-строки) | 3 932 |
| `ironbrew_cascade/tower_of_hell_script` | Tower of Hell (авто-прохождение) | 274 |
| `ironbrew_cascade/tiny_tanks_gui` | Tiny Tanks (GUI) | 212 |
| `ironbrew_cascade/piggy_item_hub` / `prison_life_destroyer_hub` | Piggy, Prison Life (один и тот же хаб) | 166 |
| `ironbrew_cascade/god_mode_any_game` | универсальный God Mode | 142 |
| `ironbrew_cascade/avatar_swastika` | скин персонажа (BodyForce) | 91 |
| `ironbrew_cascade/ctrl_click_tp` | телепорт по Ctrl+клик | 77 |
| `ironbrew_cascade/fps_booster` | настройки графики | 37 |
| `ironbrew_cascade/anti_afk` | анти-АФК (VirtualUser) | 34 |
| `ironbrew_cascade/mega_fun_obby_auto_skip_stages` | Mega Fun Obby | 28 |
| `ironbrew_cascade/clone_tycoon_2_1_billion_gems` | Clone Tycoon 2 | 7 |

## Как это получено

```bash
python3 deobf-report/tools/pipeline.py obfuscated.lua --out results/<игра>/<сэмпл> -v
```

Пайплайн сам: определяет обфускатор → запускает нужный девиртуализатор/лифтер →
**патчит битый Lua 5.1 байткод** (`lua51_repair.py`: `maxstacksize` + финальные `RETURN`) →
`unluac` → `extract_parts.py` → `PARTS.md` + `LOG.txt`.

## Важная оговорка

Обфусцированного кода и «псевдо-Lua» в папке больше нет: если файл не декомпилировался
в читаемый Lua, он переносится в `_failed.md`.

Часть файлов собрана в **salvage-режиме**: если unluac не может разобрать файл целиком из-за одной
плохой функции, чанк режется по прототипам, каждая функция декомпилируется отдельно, а нечитаемые
вставляются дизассемблером с пометкой `-- PSEUDO`. Такие файлы помечены в `LOG.txt`.

Код читаемый и синтаксически корректный, но **не всегда компилируется обратно** стоковым
Lua 5.1: `unluac` объявляет регистры виртуальной машины обычными локалями, и в самых больших
функциях выходит «more than 200 local variables» / «function or expression too complex».
Это ограничение генератора unluac, а не испорченный вывод: логика, строки, имена функций и
партов читаются полностью. Для запуска такой файл нужно либо прогонять через Luau-рантайм,
либо вручную схлопывать «простыни» локалей.
