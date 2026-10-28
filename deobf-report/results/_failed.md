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
