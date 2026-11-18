# WORKS — что реально работает (честный реестр, 2026-11-17; обновлён 2026-11-18)

Правило: **«работает» = измерено** (`loadfile` под Lua 5.1.1 на текущих файлах),
либо прямая цитата конструкции языка из файла. Roblox-рантайм нигде не
запускался — это запрещено правилами и здесь не делалось. «Открывается в
Roblox» из этого файла не следует ни для одного сэмпла.

## Как читать

- **OK (Lua 5.1.1)** — файл парсится стоковым интерпретатором. Для обычного
  plain Lua это и есть базовое «работает».
- **FAIL (Luau)** — `loadfile` падает на конструкциях, которых в Lua 5.1 нет,
  но которые есть в Roblox Luau: `continue`, `+=`, backtick-строки. Код такой же
  валидный для Roblox, как и любое Luau-тело. **С 2026-11-18 каждый файл
  дополнительно прогнан через `luau-ast` (Luau 0.744)** — статус «Luau AST OK/FAIL»
  в `COMBINED.md`. AST-OK ≠ запускается в Roblox (рантайм нигде не запускался).
- **FAIL (>200 locals)** — ограничение регистров Lua 5.1 (артефакт unluac:
  все локалы виртуальной машины сложены в одну функцию). В Roblox Luau тот же
  класс лимитов есть — эти файлы, скорее всего, **не заработают без
  реструктуризации**. Не делалось.
- **FAIL (too complex)** — артефакт unluac («function or expression too
  complex near L…_»). То же ограничение сложности выражения.
- **FAIL (lbl_/goto)** — MoonSec: `goto lbl_N`/метки; это Lua 5.2+/Luau-подобие,
  в Lua 5.1.1 не парсится.

## По приоритетным играм пользователя

### Grand Piece Online (приоритет 1)
| Сэмпл | Файл | Статус | Что это на самом деле |
|---|---|---|---|
| austina_ui | `gpo/austina_ui/script.combined.lua` (228 390 B) | **OK** | Извлечённая Austina UI-библиотека («не переписана»: комментарий автора в шапке; константы L_32/L_34/L_35 восстановлены автором из usage) |
| tempest_hub | `gpo/tempest_hub/script.combined.lua` (16 575 B) | **OK** | Лоадер Tempest Hub (GUI/Tween на `CFrameValue`), тянет LinoriaLib по сети |
| venomware | `gpo/venomware/script.combined.lua` (9 185 B) | **OK** | Лоадер VenomWare (тянет UI-lib и кнопки aimbot/ESP/tracer по сети) |
| a7dev_loader | `gpo/a7dev_loader/script.combined.lua` (48 117 B) | FAIL (Luau): `:456 'toastToken += 1'` | Premium-загрузчик A7DEV (Supabase-эндпоинт `a7dev-hub-secure`, key-flow). `+=` — конструкция Luau |

### Your Bizarre Adventure (приоритет 3)
| Сэмпл | Файл | Статус | Что это |
|---|---|---|---|
| azero_hub | `yba/azero_hub/script.combined.lua` (36 829 B) | **OK** | Azero Hub: табы, ESP, stand-цели; тянет YBA_UI по сети |
| aethelburg_v16 | `yba/aethelburg_v16/script.combined.lua` (33 200 B) | FAIL (Luau): `:423 'continue'` | AETHELBURG V16: ESP с кешем, glide/trajectory, real engine-логика. `continue` — конструкция Luau |
| kolgie | `yba/kolgie/script.combined.lua` (107 471 B) | FAIL (>200 locals) | Дамп вида `L0_1`/`L1_1` (self-assign, VM-подобно): НЕ рабочий скрипт; просто нарезанные unluac-локали |

### Shindo Life (приоритет 4) — лучший результат
| Сэмпл | Файл | Статус | Что это |
|---|---|---|---|
| dogehub_v2_shindo | `shindo_life/dogehub_v2_shindo/script.combined.lua` (516 265 B) | **OK** | **Финальный payload DogeHub V2 Shindo** — обычный читаемый Lua (14 298 строк). Раздел 2/2 — дословно публичный файл `Kasep6720/Secret@DogeHubV2:Games/ShindoLife`; в RECOVERY.md — цепочка, хэши, приватность (mod_userlogs вебхук, не вызывался) |

### King Legacy (приоритет 5)
Все 6 сэмплов **FAIL как-is** (реальные причины, не «лень»):

| Сэмпл | Причина (измерено) |
|---|---|
| KL_msv2_v13 (142 178 B) | `:537 main function has more than 200 local variables` |
| KL_msv3_v14_ZombieAttack (158 941 B) | `:143 function or expression too complex near 'L1_1'` |
| KL_msv3_v15_ZombieAttack (292 494 B) | `:967 function or expression too complex near 'L2_2'` |
| KL_psu40_BloxFruit (1 332 794 B) | `:657 function at line 656 has more than 200 local variables` |
| KL_psu40_Kingpiece (875 470 B) | `:778 function at line 777 has more than 200 local variables` |
| KL_psu45_ano (3 509 697 B) | `:85 main function has more than 200 local variables` |

Это дампы unluac с локалами от VM; до «рабочего» состояния нужна
реструктуризация функций (разбиение на прототипы) — не выполнялась и не
притворялась выполненной.

### Attack on Titan Revolution (приоритет 6) и VV Ultimatum (приоритет 2)
Результатов нет и не будет «из мусора»: AoTR — key-locked MoonVeil (не
девиртуализирован), VV Ultimatum — Centurion `route:"unknown"` (чужой билд,
публичного деобфускатора нет). См. `VALIDATION.md` §5.

## Новое 2026-11-18: «другие режимы», аудит завершён

### Новые сэмплы из публичных репозиториев (plain-код, взят как есть)

| Игра | Сэмпл | Размер combined | Lua 5.1 | Luau AST | Что это на самом деле |
|---|---|---|---|---|---|
| 99_nights_in_the_forest | `voidware_loader/script.combined.lua` | 34 117 B | FAIL (backtick-строки) | **OK** | Публичная ЦЕПОЧКА загрузчиков VoidWare под 99 Nights: точка входа с анти-debug/executor-проверками (`exploiters-scripts/99NightsInTheForest-Script` → «VoidWare», 9 495 B) → `VapeVoidware/VW-Add@main`: `loader.lua` → `loader2.lua` (реестр GameId → скрипт: Bedwars / Ink Game / Forsaken / 99 Nights, Obsidian UI, оркестрация) → `nightsintheforest.lua` → `nightsintheforest2.lua` (автовыбор «Pedrin Hub»/VoidWare). URL в комментариях разделов combined. Финальная полезная нагрузка (`newnightsintheforest.lua`, Luraph v14.7, 1.1 MB) НЕ деобфусцирована и в репозиторий НЕ кладётся |
| bedwars | `voidware_6872274481/script.combined.lua` | 406 311 B | FAIL (`continue`) | **OK** | `VapeVoidware/VWRewrite@main:games/6872274481.lua` — модуль под GameId `6872274481` (Bedwars). 12 262 строки читаемого кода: неприкосновенные функции Vape (`run`, cloneref), GUI/ESP-механики (Menu, chams/ESP, телепорты), FireServer-вызовы. Соседние plain-файлы того же репо (`MainScript.lua` 98 140 B, `games/universal.lua` 262 056 B, `libraries/vm.lua` — Fiu MIT, `guis/*`) в репозиторий НЕ скопированы целиком — адресуемы по тому же репо |

Lua 5.1 FAIL для обоих — диалект (backtick-строки / `continue`), в Roblox легален; синтаксис под Luau-AST парсится.
Попытка прогнать три Luraph v14-файла через vendored `Deobfuscator-Luraph-V15-master` (`bin/luau-ast` после сборки):
все три «recovered» результат — это Behaviour-трейсы/заголовки (`script error: attempt to index nil with 'Options'` /
`Main Failure with loading Library!`), **не рабочий код**; в репозиторий не кладём, в work/.
`vw_newforsaken.deobf.lua`/`vw_newinkgame.deobf.lua` содержат только 20 строк инициализации (VoidwareForsaken-флаг,
HTTP-запрос на VWUpdateLog, запись Voidware_InkGame_Library_Choice.txt, Obsidian Loader через raw.githubusercontent) —
частичные, НЕ полезная нагрузка.

### Инвентаризация остальных режимов (что лежит в `results/`)

| Сэмпл | Фактическое содержимое (по раздел 1/2 combined) |
|---|---|
| the_wild_west `coal_farm` / `new_farm` / `no_coal` | moonsec_v3 → salvage unluac (функции 2417/2355/2411 строк): autofarm/grind, телепорты (`walkspeed`/`teleport`), discord `HttpGet`, автоклик. Синтаксически парсится в Lua 5.1 (OK), но это **нарезка отдельных функций**, не цельный скрипт |
| jailbreak `gui_2` / `jailbreaker_v42` / `unjailbreak` | Обычный минифицированный Lua (74/32/165 KB): TP/CFrame, TweenService, GUI (Screengui/TextButton/Toggle), ESP/BillboardGui, a7dev-«vape»-подобные UI, noclip/godmode-ключевые слова. OK; целиком валидный код, механика видна |
| prison_life `gui` / `main` / `simple_gui` / `cmd_gui` | Обычный минифицированный Lua: телепорт, GodMode/noclip, fling, aimbot (GetMouse), FireServer×9/4, InvokeServer, Teams/ReplicatedStorage. OK. `cmd_gui` — самый полный (3477 строк, Quest/Item/Tycoon API) |
| murder_mystery_2 `full` | Aimbot+ESP+TP, BillboardGui, coins, Fallback GetService, 1505 строк. OK |
| one_piece `kaitun_nav` | GUI (tab/slider/dropdown), auto farm (collect/farm), chest, TP. OK. Unluac-salvage |
| pet_simulator `gui` / `op_gui` | coin farm, chest, TP, VirtualUser anti-AFK (`gui` 1353 строк) / minimal GUI (`op_gui`, 998 строк InvokeServer×4). OK |
| illegal_soccer `luarmor_router` / `maxlegends_loader` / `polsec_loader` / `super_futebol` | Загрузчики/роутеры: d0inks-подобные, MaxLegends (discord, Inf/Code, auto farm, outline ESP), polsec (highlight/outline, tabs), super_futebol (aimbot+TP минифицированный, 398 строк). luarmor_router/maxlegends_loader OK |
| blox_strike `d0inks_router` / `twistedk1d` | `d0inks_router` — 11 строк чистого роутера (`HttpGet`→`loadstring`×3, OK). `twistedk1d` — 410 строк: GUI (tabs/toggles), TP через tween, `Dropped`-механика. OK |
| counter_blox `hub` | 6915 строк, эталон читаемого кода (unprom): ESP (chams/boxhandle), silent aim/aimbot, hits, cash/infinite, chest. OK |
| close_quarters_combat `gui` | 1612 строк, Chat/Players/Workspace, TP cframe, `breakjoints`, keydown. OK |
| ironbrew_cascade `anti_afk` | 34 строки: VirtualUser/Idled + Button2Down, точный anti-AFK. OK — минимальный, целый |
| ironbrew_cascade `avatar_swastika` / `god_mode_any_game` / `mega_fun_obby_auto_skip_stages` / `tiny_tanks_gui` / `piggy_item_hub` / `prison_life_destroyer_hub` / `tower_of_hell_script` / `ctrl_click_tp` | IronBrew → salvage unluac: TP, godmode-подобные, stage+1 skip, GUI, Ctrl+Click TP. OK синтаксически, функции нарезаны по одной, они **не целые клиенты** |
| ironbrew_cascade `clone_tycoon_2_1_billion_gems` | 7 строк, Workspace-упоминание, `GetService`. **Смысл не восстановлен** (пустой) |
| ironbrew_cascade `fps_booster` | 37 строк, `GetService`×1 — макро-минимум, читаемый, но функционально почти пуст |

**Итого:** все «OK» выше — только синтаксис/парс и честный инвентарь механик;
в Roblox ни один файл не исполнялся. Ни один из этих файлов не является
подтверждённо работающей в игре сборкой.

## Что точно OK по Lua 5.1.1 — полный список (34 файла, из 65 сэмплов)

```
blox_strike/d0inks_router                 illegal_soccer/luarmor_router        pet_simulator/op_gui
blox_strike/twistedk1d                    illegal_soccer/maxlegends_loader     prison_life/cmd_gui
close_quarters_combat/gui                 ironbrew_cascade/anti_afk            prison_life/gui
counter_blox/hub                          ironbrew_cascade/avatar_swastika     prison_life/main
gpo/austina_ui                            ironbrew_cascade/clone_tycoon_2_1_billion_gems
gpo/tempest_hub                           ironbrew_cascade/fps_booster         prison_life/simple_gui
gpo/venomware                             ironbrew_cascade/god_mode_any_game
yba/azero_hub                             ironbrew_cascade/mega_fun_obby_auto_skip_stages
shindo_life/dogehub_v2_shindo             ironbrew_cascade/piggy_item_hub
the_wild_west/coal_farm                   ironbrew_cascade/prison_life_destroyer_hub
the_wild_west/new_farm                    ironbrew_cascade/tiny_tanks_gui
the_wild_west/no_coal                     jailbreak/gui_2
                                          jailbreak/jailbreaker_v42
                                          jailbreak/unjailbreak
                                          murder_mystery_2/full
                                          one_piece/kaitun_nav
                                          pet_simulator/gui
```

Остальные 31 — FAIL под Lua 5.1.1 ( Luau AST при этом OK для 58/65; полный статус: `deobf-report/results/COMBINED.md`).
**Синтаксически рабочих файлов — 34 из 65; для приоритетных игр из них — GPO ×3, YBA ×1, Shindo ×1.**
Файлы FAIL за рабочие не выдаются.

Список «что дать пользователю первым»: `shindo_life/dogehub_v2_shindo/script.combined.lua`
→ `gpo/austina_ui` → `yba/azero_hub` → `gpo/tempest_hub` → `gpo/venomware`.

## Честные ограничения

1. Ни один файл не исполнялся в Roblox; проверочную среду негде развернуть.
2. Luau-синтаксис (`continue`, `+=`) для Roblox валидн, но не перепроверялся.
3. unluac-артефакты (200 locals, too complex, lbl_/goto) — не рабочие;
   реструктуризация = отдельная работа, не делалась.
4. Отдельных script.lua/PARTS.md в репозитории нет; их содержимое — разделы
   1/2 и 2/2 combined; первоисточники — в git-истории.
