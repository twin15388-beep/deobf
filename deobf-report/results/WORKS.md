# WORKS — что реально работает (честный реестр, 2026-11-17)

Правило: **«работает» = измерено** (`loadfile` под Lua 5.1.1 на текущих файлах),
либо прямая цитата конструкции языка из файла. Roblox-рантайм нигде не
запускался — это запрещено правилами и здесь не делалось. «Открывается в
Roblox» из этого файла не следует ни для одного сэмпла.

## Как читать

- **OK (Lua 5.1.1)** — файл парсится стоковым интерпретатором. Для обычного
  plain Lua это и есть базовое «работает».
- **FAIL (Luau)** — `loadfile` падает на конструкциях, которых в Lua 5.1 нет,
  но которые есть в Roblox Luau: `continue`, `+=` и т.п. Код такой же валидный
  для Roblox, как и любое Luau-тело, но **luau-ast на текущих файлах не
  перезапускался** — это не проверено, статуса «работает в Roblox» тут нет.
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

## Что точно OK по Lua 5.1.1 — полный список (34 файла)

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

Остальные 29 — FAIL (точный статус и причина каждого: `deobf-report/results/COMBINED.md`).
**Синтаксически рабочих файлов — 34 из 63; для приоритетных игр из них — GPO ×3, YBA ×1, Shindo ×1.**
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
