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
