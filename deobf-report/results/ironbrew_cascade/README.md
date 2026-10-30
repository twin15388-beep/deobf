# IronBrew / AztupBrew: девиртуализация через CASCADE (6-я итерация)

Корпус: **36 файлов** с заголовком IronBrew/AztupBrew из `hexahigh/Scripts` (все, что нашлись в этом репозитории).

Пайплайн:
```
CASCADE (devirtualize)  ->  output.luac  ->  luac_fix.py (maxstack/nups/vararg)
  ->  luac32to64.py  ->  проверка загрузки в Lua 5.1.1  ->  unluac  ->  lua_threeaddr.py
```

**Итог: 12 из 36 файлов дали загружаемый чанк и декомпилировались в настоящий Lua (5166 строк); остальные 24 — только `PARTS.md` (имена объектов).**


## Получилось: настоящий Lua

| файл | чанк, B | строк | «проблем» в чанке | примечание |
|---|---:|---:|---:|---|
| `_Script_Hub` | 29691 | 3932 | 0 | хаб на ~100 игр (HttpGet + XOR-строки) — самый крупный результат |
| `Tower_of_Hell_Script` | 4163 | 274 | 4 | есть `goto` (артефакт unluac) → синтаксис Lua 5.2+ |
| `Tiny_Tanks_GUI` | 3542 | 212 | 0 |  |
| `Piggy_Item_Hub` | 2124 | 166 | 0 | полный разбор GUI-хаба |
| `Prison_Life_Destroyer_Hub` | 2124 | 166 | 0 | тот же скрипт, что Piggy_Item_Hub (дубликат в корпусе) |
| `God_Mode_Any_Game` | 1805 | 142 | 1 | первый полностью проверенный: чанк грузится в Lua 5.1 |
| `Make_Your_Avatar_A_Swatstika` | 1149 | 91 | 1 |  |
| `Ctrl_Click_TP` | 926 | 77 | 0 | есть `goto` (артефакт unluac) |
| `FPS_Booster` | 1300 | 37 | 0 |  |
| `Anti_AFK` | 490 | 34 | 0 |  |
| `Mega_Fun_Obby_Auto_Skip_Stages` | 442 | 28 | 0 |  |
| `Clone_Tycoon_2_1_Billion_Gems` | 211 | 7 | 0 | крошечный скрипт |

## Не получилось (в каталогах только `PARTS.md`)

| файл | чанк, B | проблем | Skip instr/sub | первая ошибка (`luac_inspect`) |
|---|---:|---:|---:|---|
| `Stackables_Inf_Money` | 301 | 1 | 0 / 0 | `CALL C=0 (open) followed by CALL B=1` |
| `Heroes_Online_FREE_AUTOFARM_BY_BLAKE` | 2657 | 5 | 5 / 10 | `CALL C=0 (open) followed by TEST B=0` |
| `Legends_of_Speed_auto_farm_new` | 9788 | 5 | 0 / 14 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Magnet_Sim` | 8198 | 5 | 7 / 8 | `JMP jump ->44 out of code` |
| `Texting_Simulator_GUI_UPDATED` | 5368 | 6 | 6 / 13 | `CALL C=0 (open) followed by SELF B=4` |
| `FE_Invisible_Fling` | 5195 | 8 | 0 / 0 | `proto p2: params=0 vararg=1 nups=0 maxstack=4 code=12 consts` |
| `JoJo_Blox_GUI` | 9046 | 9 | 7 / 12 | `proto p2: params=0 vararg=1 nups=0 maxstack=8 code=12 consts` |
| `Blox_Piece_1.9.5` | 25831 | 13 | 0 / 0 | `proto p2: params=0 vararg=1 nups=0 maxstack=250 code=40 cons` |
| `Blox_Piece_232` | 25831 | 13 | 15 / 90 | `proto p2: params=0 vararg=1 nups=0 maxstack=250 code=40 cons` |
| `Jojo_Gui` | 18586 | 14 | 16 / 27 | `proto p2: params=0 vararg=1 nups=0 maxstack=8 code=12 consts` |
| `one_Piece_mellinuim` | 28922 | 17 | 22 / 92 | `proto p2: params=0 vararg=1 nups=4 maxstack=4 code=13 consts` |
| `Bad_Business_SCRIPT_NEW_XDDD` | 13165 | 23 | 31 / 21 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Bad_Business_Script_NEW_ONE` | 13165 | 23 | 31 / 21 | `CALL C=0 (open) followed by GETGLOBAL B=0` |
| `Mad_City_Gui_2` | 35311 | 28 | 104 / 235 | `proto p2: params=0 vararg=1 nups=1 maxstack=2 code=3 consts=` |
| `OP_Finality_Character_Hub` | 123372 | 28 | 0 / 0 | `CALL C=0 (open) followed by CALL B=420` |
| `Dungeon_Quest_Free_Autofarm_CRACKED` | 29288 | 36 | 139 / 117 | `proto p2: params=2 vararg=1 nups=2 maxstack=4 code=6 consts=` |
| `Dungeon_Quest_King` | 29288 | 36 | 0 / 0 | `proto p2: params=2 vararg=1 nups=2 maxstack=4 code=6 consts=` |
| `Dungeon_Quest_Pirate` | 29288 | 36 | 0 / 0 | `proto p2: params=2 vararg=1 nups=2 maxstack=4 code=6 consts=` |
| `Dungeon_Quest_Winter` | 29288 | 36 | 0 / 0 | `proto p2: params=2 vararg=1 nups=2 maxstack=4 code=6 consts=` |
| `Iron_Man_Sim_Script` | 28415 | 38 | 0 / 0 | `CALL C=0 (open) followed by CALL B=463` |
| `Dungeon_Quest_Autofarm_Free__OUTDATED` | 26858 | 39 | 105 / 88 | `proto p2: params=0 vararg=1 nups=0 maxstack=250 code=29 cons` |
| `Dungeon_Quest_Desert` | 26858 | 39 | 0 / 0 | `proto p2: params=0 vararg=1 nups=0 maxstack=250 code=29 cons` |
| `JailBreak_NEW_BEST_GUI` | 22013 | 41 | 63 / 122 | `proto p2: params=0 vararg=1 nups=4 maxstack=11 code=31 const` |
| `Troll_GUI` | 270406 | 65 | 0 / 0 | `proto p2: params=0 vararg=1 nups=1 maxstack=2 code=3 consts=` |

## Почему часть чанков не грузится

`luac_inspect.py` по всем 24 неудачам даёт две картины:

1. **`CALL` с `C=0` (multret), за которым нет «открывающей» инструкции** —
   в дампе видно `CALL R4 511 0`, `CALL R5 510 511`, `CALL R6 509 510`: операнды
   `B`/`C` съехали на соседние инструкции. Причина — CASCADE при девиртуализации
   **пропускает** инструкции (`Skip Instruction` / `Skip Sub-Instruction`), после
   чего выборка `Inst[OP_B]`/`Inst[OP_C]` уезжает на позицию.
2. **`JMP` за пределы кода** (`->450`, `->126`, `->-1`) в мелких вложенных
   прототипах: там лежат не настоящие Lua-функции, а служебные обёртки VM,
   которые лифтер собирает как обычный прототип.

Корреляция: **у всех 12 успешных файлов `Skip Instruction = 0`**, у всех файлов
с `Skip > 0` чанк не грузится. Обратное неверно — 12 файлов без пропусков тоже
упали (у них мусор в служебных прототипах).

## Что даёт `PARTS.md` даже без кода

Строковые константы (аргументы `Instance.new(...)`, `WaitForChild`, имена GUI,
URL) читаются из байткода напрямую и не зависят от корректности инструкций —
поэтому имена партов извлечены и для 24 неудачных файлов.

## Файлы

* `<файл>/script.lua` — декомпилированный Lua (только для 12 успешных);
* `<файл>/PARTS.md` — имена объектов/классы Roblox/ссылки из констант чанка;
* `god_mode_any_game/devirt.luac` — итоговый чанк (после `luac_fix.py`), грузится в Lua 5.1.1;
* `god_mode_any_game/devirt_unsigned.luac` — «сырой» чанк CASCADE (до починки), для сравнения.

