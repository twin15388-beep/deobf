# 6-я итерация: девиртуализация IronBrew / AztupBrew

Задача этой партии: довести IronBrew (самый частый обфускатор в собранном корпусе) до
читаемого Lua, а не до «внешнего слоя». Плюс проверить новые инструменты, найденные в 5-й итерации.

## Итог

| Метрика | Значение |
|---|---|
| Файлов IronBrew/AztupBrew в корпусе | 36 |
| Девиртуализовано CASCADE до чанка | 36 (было 0 — раньше падало на `throw "ayo"`) |
| Чанк грузится в Lua 5.1.1 | 12 |
| Декомпилировано в Lua (unluac) | 12 |
| Строк кода получено | 5166 |
| `PARTS.md` (имена объектов) | 36 |

## Что починили

1. **CASCADE падал** на несовпавших инструкциях (`throw "ayo"`) — заменено на skip+continue.
2. **CASCADE писал `nups = 0`** и `is_vararg = 2` для любого прототипа → `luaG_checkcode`
   отвечал `bad code`. Теперь `nups` считается по фактическим `GETUPVAL/SETUPVAL`.
3. **`maxstacksize = 250`** (жёстко) → unluac выдавал 250 пустых локалов и падал
   `Index 250 out of bounds`. Теперь `maxstack` пересчитывается честно (`luac_fix.py`):
   `God_Mode_Any_Game` 250 → 9, у остальных 3–12.
4. **Lua 5.1.1 собран** (32-битных сборок нет — чанки конвертируются `luac32to64.py`),
   плюс шим `bit.bxor` — без него не работали ни запуск чанка, ни Xen-инструмент.

## Таблица (36 файлов)

| Файл | Чанк, B | Статус | Строк | Skip instr/sub |
|---|---:|---|---:|---|
| `_Script_Hub` | 29691 | декомпилирован | 3932 | 0 / 0 |
| `OP_Finality_Character_Hub` | 123372 | только PARTS | — | 0 / 0 |
| `Troll_GUI` | 270406 | только PARTS | — | 0 / 0 |
| `Iron_Man_Sim_Script` | 28415 | только PARTS | — | 0 / 0 |
| `Tiny_Tanks_GUI` | 3542 | декомпилирован | 212 | 0 / 0 |
| `Piggy_Item_Hub` | 2124 | декомпилирован | 166 | 0 / 0 |
| `Prison_Life_Destroyer_Hub` | 2124 | декомпилирован | 166 | 0 / 0 |
| `Tower_of_Hell_Script` | 4163 | декомпилирован (goto) | 274 | 0 / 0 |
| `God_Mode_Any_Game` | 1805 | декомпилирован | 142 | 0 / 0 |
| `Make_Your_Avatar_A_Swatstika` | 1149 | декомпилирован | 91 | 0 / 0 |
| `Ctrl_Click_TP` | 926 | декомпилирован (goto) | 77 | 0 / 0 |
| `FPS_Booster` | 1300 | декомпилирован | 37 | 0 / 0 |
| `Anti_AFK` | 490 | декомпилирован | 34 | 0 / 0 |
| `Mega_Fun_Obby_Auto_Skip_Stages` | 442 | декомпилирован | 28 | 0 / 0 |
| `Clone_Tycoon_2_1_Billion_Gems` | 211 | декомпилирован | 7 | 0 / 0 |
| `JailBreak_NEW_BEST_GUI` | 22013 | только PARTS | — | 63 / 122 |
| `Mad_City_Gui_2` | 35311 | только PARTS | — | 104 / 235 |
| `Dungeon_Quest_Free_Autofarm_CRACKED` | 29288 | только PARTS | — | 139 / 117 |
| `Dungeon_Quest_Autofarm_Free__OUTDATED__` | 26858 | только PARTS | — | 105 / 88 |
| `Dungeon_Quest_Desert/King/Pirate/Winter` (4) | 26858–29288 | только PARTS | — | 0–139 / 0–117 |
| `Blox_Piece_232`, `Blox_Piece_1.9.5` | 25831 | только PARTS | — | 15 / 90 |
| `Jojo_Gui`, `JoJo_Blox_GUI`, `one_Piece_mellinuim` | 9046–28922 | только PARTS | — | 7–22 / 12–92 |
| `Bad_Business_SCRIPT_NEW_XDDD`, `..._NEW_ONE` | 13165 | только PARTS | — | 31 / 21 |
| `Heroes_Online…`, `Legends_of_Speed…`, `Magnet_Sim`, `Texting_Simulator…`, `Stackables_Inf_Money`, `FE_Invisible_Fling` | 2124–9788 | только PARTS | — | 5–229 / 8–14 |

Полная таблица с точными числами — `ironbrew_cascade/README.md`.

## Ключевое наблюдение

`Skip Instruction = 0` — необходимое условие успеха (все 12 успешных файлов такие),
но не достаточное: 12 файлов без пропусков всё равно дали битые чанки
(мусор в мелких служебных прототипах — `JMP` за пределы кода).

## Прочие инструменты, проверенные в этой итерации

* **`lovesyko/SynapseXenDeobfuscator`** — с собранным Lua и шимом `bit.bxor` он
  **доходит до распаковки payload** (ключ `DZTFR34V8I59TVCZ`, magic `Xen`, 3491 B),
  но байткод-лифтер выдаёт `v0(v248, v85)` вместо инструкций — таблица опкодов не
  соответствует Xen v1.1.2. Итог: полезен только как экстрактор payload.
* **`nguyenthaitrung/Lua-Deobfuscator`** (JS) — сам обфусцирован, падает
  `TypeError: PZ2bqX[...] is not a function`; опкод-таблицы внутри идентичны CASCADE.
* **`Gork3m/IronBrew2-Deobfuscator`** — C#/.NET, в песочнице нет dotnet — не запускался.
