# Что не удалось деобфусцировать (4-я итерация)

Сэмплы из репозитория `hexahigh/Scripts` (6 132 Lua-файла). Для каждого перечислено, что именно пробовали.

| Файл | Игра/режим | Обфускатор | Размер | Что пробовали | Итог |
|---|---|---|---|---|---|
| `One Piece Millennium GUI.lua` | One Piece Millennium (GUI) | Synapse Xen 1.1.2 | 65 КБ | CASCADE, unprom, Luraph-v15 deob, unluac/salvage, extract_parts | VM не девиртуализирован, читаемого кода нет |
| `Vesteria Beta GUI.lua` | Vesteria (GUI) | Synapse Xen 1.1.2 | 67 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `Clone_Tycoon_2_1_Billion_Gems.lua` | Clone Tycoon 2 | IronBrew 2.7.2 | 10 КБ | CASCADE (output.luac 301 B), axomtools/ironbrew2-deobfuscator (luaparser-несовместимость), unluac/salvage | VM не девиртуализирован, читаемого кода нет |
| `Mega_Fun_Obby_Auto_Skip_Stages.lua` | Mega Fun Obby | IronBrew 2.7.2 | 19 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `Stackables_Inf_Money.lua` | Stackables | IronBrew 2.7.2 | 21 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `Blox Piece 232.lua` | Blox Piece (Blox Fruits) | IronBrew 2.7.0 | 204 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `Da Hood KILL ANY PLAYER GUI.lua` | Da Hood | Luraph 11.5 | 67 КБ | deob.js (только v15), unprom, salvage | VM не девиртуализирован, читаемого кода нет |
| `Loomian Legacy script.lua` | Loomian Legacy | Luraph 11.1 | 53 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `Ro-Ghoul Script.lua` | Ro-Ghoul | Luraph 6.0-beta1 | 96 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `PEPSI AIMBOT ALPHA.lua` | Arsenal / универсальный | неизвестный VM (Luraph-подобный десериализатор) | 260 КБ | detect→unknown, deob.js 0.00, unprom, beautify (только форматирование) | снят только внешний слой (конфиг/строки видны, тело — VM) |
| `Arsenal GUI Script.lua` | Arsenal | то же | 181 КБ | то же | VM не девиртуализирован, читаемого кода нет |
| `Arsenal Aimbot By Athoi21.lua` | Arsenal | IronBrew/Luraph-обёртка (по сигнатуре) | 313 КБ | detect→unknown, CASCADE, unprom | снят только внешний слой (конфиг/строки видны, тело — VM) |

## Почему

- **Synapse Xen 1.1.x** — VM с шифрованным байткодом и анти-tamper; публичного деобфускатора нет (проверено поиском по GitHub: `synapse+xen+deobfuscator`, `xen+deobf+lua`).
- **IronBrew 2.7.x** — `CASCADE` (MS/IBW) на этих сборках выдаёт 301-байтный `output.luac` (совпало <10 инструкций); `axomtools/ironbrew2-deobfuscator` рассчитан на другой вариант AST и падает на разборе (в текущей версии `luaparser` у `Index` другие поля).
- **Luraph 6/11.x** — `deob.js` умеет только v15 (на v11 определяет `generic 0.00`); `unprom` рассчитан на Prometheus и на Luraph-десериализатор не реагирует.
- **PEPSI/Arsenal** — тот же Luraph-подобный десериализатор (`local a=string.byte;local b=string.char;...`), готового инструмента нет.

Файлы не удалены: исходники лежат в `_work/new_samples/hexahigh/` (вне git) и в `hexahigh/Scripts` на GitHub.

## Пятая итерация (GPO / Illegal Soccer / Blox Strike / YBA)

| Файл | Игра | Обфускатор | Что пробовали | Итог |
|---|---|---|---|---|
| `rorri-cm/yba-autofarm` — `YSF PROTECTED.lua` | YBA | **Luraph v14.4.2** | `deob.js` (v14-путь, собран `luau`/`luau-ast`), бюджеты 180/420 с | **частично**: 1 корневой proto → 172 строки, остальное VM |
| `d0inks/moon.lua` — `ext/bloxstrike.lua` | Blox Strike | **doink obfuscator v1** | `unprom` (deflatten/lift), `deob.js`, CASCADE | **частично**: свернуто 1 176 выражений, VM не поднята |
| `4raff/MahmutHub` — `BloxStrike/production/main.lua` | Blox Strike | wearedevs / Prometheus | `unprom` (`vm_lift` → `RecursionError` на 531 блоке) | **частично**: de-flatten 7 184 строки |
| GPO: `TrilhaX/scriptexec`, `moa456811-prog/roblox-hubs`, `lenny2010/VenomWare-V1`, `Ic0u/achieved-scripts` | GPO | — | поиск обфусцированных сэмплов: `search/code` по `"Grand Piece Online" PSU`, `"GPO" IronBrew`, `search/repositories` | **обфусцированных нет**, все 4 файла — открытый Lua |
| Illegal Soccer: `api.polsec.net`, Luarmor, `loader.sportsclub.fun`, MAXLEGENDS (Cloudflare KV) | Illegal Soccer | Luarmor/key-system | попытка достать полезную нагрузку: всё отдаётся по ключу после проверки PlaceId | **недостижимо статически**: публичных обфусцированных файлов нет |

Отдельно: `s1mpl33222-glitch/lua-obfuscator-samples` содержит `.lua`, который на деле является
HTML-страницей (`<!DOCTYPE html>` — AirFlow) — проверять содержимое перед прогоном.

## Шестая итерация (IronBrew через CASCADE)

| Что | Итог | Почему |
|---|---|---|
| 24 из 36 IronBrew-файлов | чанк не грузится → только `PARTS.md` | `CALL C=0` со съехавшими `B`/`C` (следствие пропущенных инструкций) и `JMP` за пределы кода в мелких служебных прототипах |
| `Troll_GUI.lua` (1.30 МБ), `OP_Finality_Character_Hub.lua` (1.52 МБ) | 270 КБ / 123 КБ чанка, не грузится | те же две причины, но ошибок больше (65 и 28) |
| `SynapseXenDeobfuscator` (lovesyko) | payload распаковывается, код — мусор | таблица опкодов не от Xen v1.1.2: вместо `Instance.new(...)` выводятся `v0(v248, v85)` |
| 62 Xen-скрипта корпуса | массово не прогонялись | нет смысла, пока лифтер Xen не даёт инструкций |
| `Lua-Deobfuscator` (nguyenthaitrung) | не работает | сам обфусцирован, `TypeError: PZ2bqX[...] is not a function` на 8-й строке `index.js` |
| `IronBrew2-Deobfuscator` (Gork3m, C#) | не проверен | нет dotnet в песочнице, nuget недоступен |
| Lua 5.1.5 | не собрать | тега 5.1.5 на GitHub нет, `make linux` в 5.1.1 отсутствует; собрана 5.1.1 с `-DLUA_USE_POSIX` |
| `goto lbl_N` в выводе unluac (3 файла) | синтаксис Lua 5.2+ | unluac не смог свернуть некоторые прыжки в структуры; чанк при этом грузится в 5.1 |

## Переехало из `results/` при переходе на «только деобфнутое»

Раньше в `results/` лежали сэмплы, где снят только внешний слой, а тело осталось
обфусцированным (VM/диспетчер). По новому правилу такие каталоги в результатах не держим —
**код, который не деобфусцирован до читаемого исходника, в `results/` не попадает**.

| Было в results | Игра | Что внутри было | Почему убрано | Что успели вытащить |
|---|---|---|---|---|
| `tower_of_hell/auto_win` | Tower of Hell | 296 строк, 289 КБ в одну строку | это не код, а `IronBrew`-байткод (снята только обёртка `unprom`) | ничего читаемого |
| `tower_defense_simulator/autofarm` | Tower Defense Simulator | 11 121 строка | блок настроек сверху, тело — VM Luraph v6-типа | `_G.troopName`, `_G.placeTroop`, `_G.waitDelay`, `_G.joinDelay` |
| `corpus/wynfuscate` | бенчмарк | 325 строк | `enhanced-vm-compress` лоадер, строки зашифрованы | — |
| `blox_strike/moon_ext_doink` | Blox Strike | 1 712 строк | doink obfuscator v1: `bit32.bxor` + CFG-flatten, VM не поднята | черновые имена `GH_R`, `GPrQa` |
| `blox_strike/mahmuthub_wearedevs` | Blox Strike | 7 184 строки | де-flatten **диспетчера** (`while X do if X == 0 ... X = 405`), не исходник | интерфейс GUI-библиотеки: `CreateWindow`, `CreateTopbarButton`, `AddTheme`, `CreateConfig`, `Dropdown`, `Detected` |
| `yba/ysf_luraph14` | YBA | 173 строки | Luraph v14.4.2, поднят 1 прототип из VM | `LPH_NO_UPVALUES`, `LPH_OBFUSCATED` (маркеры Luraph) |

Исходники этих файлов не удалены — лежат вне git в `_work/` и в исходных репозиториях;
если для них появится рабочий деобфускатор, они вернутся в `results/` уже как код.

### Полный список 24 IronBrew-файлов, которые не собрались

| Файл | Чанк, B | Проблем в чанке | Skip instr/sub | Первая ошибка `luac_inspect` |
|---|---:|---:|---:|---|
| `Bad_Business_SCRIPT_NEW_XDDD.lua` | 13165 | 23 | 31 / 21 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Bad_Business_Script_NEW_ONE.lua` | 13165 | 23 | 31 / 21 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Blox_Piece_1.9.5.lua` | 25831 | 13 | 0 / 0 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Blox_Piece_232.lua` | 25831 | 13 | 15 / 90 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Dungeon_Quest_Autofarm_Free__OUTDATED.lua` | 26858 | 39 | 105 / 88 | `JMP jump ->-1 out of code` |
| `Dungeon_Quest_Desert.lua` | 26858 | 39 | 0 / 0 | `JMP jump ->-1 out of code` |
| `Dungeon_Quest_Free_Autofarm_CRACKED.lua` | 29288 | 36 | 139 / 117 | `JMP jump ->-1 out of code` |
| `Dungeon_Quest_King.lua` | 29288 | 36 | 0 / 0 | `JMP jump ->-1 out of code` |
| `Dungeon_Quest_Pirate.lua` | 29288 | 36 | 0 / 0 | `JMP jump ->-1 out of code` |
| `Dungeon_Quest_Winter.lua` | 29288 | 36 | 0 / 0 | `JMP jump ->-1 out of code` |
| `FE_Invisible_Fling.lua` | 5195 | 8 | 0 / 0 | `CALL C=0 (open) followed by CALL B=504` |
| `Heroes_Online_FREE_AUTOFARM_BY_BLAKE.lua` | 2657 | 5 | 5 / 10 | `CALL C=0 (open) followed by TEST B=0` |
| `Iron_Man_Sim_Script.lua` | 28415 | 38 | 0 / 0 | `CALL C=0 (open) followed by CALL B=463` |
| `JailBreak_NEW_BEST_GUI.lua` | 22013 | 41 | 63 / 122 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `JoJo_Blox_GUI.lua` | 9046 | 9 | 7 / 12 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Jojo_Gui.lua` | 18586 | 14 | 16 / 27 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Legends_of_Speed_auto_farm_new.lua` | 9788 | 5 | 0 / 14 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Mad_City_Gui_2.lua` | 35311 | 28 | 104 / 235 | `EQ C reg 251 >= maxstack 250` |
| `Magnet_Sim.lua` | 8198 | 5 | 7 / 8 | `JMP jump ->44 out of code` |
| `OP_Finality_Character_Hub.lua` | 123372 | 28 | 0 / 0 | `CALL C=0 (open) followed by CALL B=420` |
| `Stackables_Inf_Money.lua` | 301 | 1 | 0 / 0 | `CALL C=0 (open) followed by CALL B=1` |
| `Texting_Simulator_GUI_UPDATED.lua` | 5368 | 6 | 6 / 13 | `CALL C=0 (open) followed by SELF B=4` |
| `Troll_GUI.lua` | 270406 | 65 | 0 / 0 | `CALL C=0 (open) followed by CALL B=510` |
| `one_Piece_mellinuim.lua` | 28922 | 17 | 22 / 92 | `CALL C=0 (open) followed by MOVE B=4` |

Имена объектов из этих файлов остались в рабочей копии (`_work/res6/ib/<файл>/PARTS.md`); в git они не выкладываются, потому что кода там нет — в `results/` попадает только деобфнутое.
