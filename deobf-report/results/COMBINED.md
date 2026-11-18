# COMBINED — единые `script.combined.lua` (2026-11-18, дедуп + новые сэмплы)

Единственная форма результата: **один файл на проект** — `<игра>/<сэмпл>/script.combined.lua`.
Состав файла: шапка (игра, каталог, sha256 исходного кода) → `РАЗДЕЛ 1/2` (весь `PARTS.md`
построчно как комментарии: механики с уликами, вызовы Roblox API, имена функций, парты) →
`РАЗДЕЛ 2/2` — восстановленный код **дословно** (для shindo — финальный payload).

Отдельных `script.lua`/`PARTS.md` в репозитории нет: каждый побайтово входит в combined;
первоисточники — в git-истории. Генератор формата: `tools/build_combined.py` (исторический).

## Проверка синтаксиса (измерена на текущих файлах)

- Файлов: **65**
- Lua 5.1.1 `loadfile`: **34** OK / **31** FAIL
- Luau AST (`luau-ast`, Luau 0.744): **58** OK / **7** FAIL
- Оба OK: **34**

FAIL (Lua 5.1.1) бывает Luau-диалектом (`continue`, `+=`, backtick-строки — в Roblox валидно);
FAIL (Luau) — unluac-артефакты (`goto`/`lbl_*` не поддерживаются в Luau) и лимиты сложности.
Ни одной FAIL-файла за «рабочие» не выдаётся; Roblox-рантайм нигде не запускался.

## Файлы по играм

### 99_nights_in_the_forest (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `voidware_loader` | 34117 B | `f41fda250055…` | FAIL | OK |

### bedwars (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `voidware_6872274481` | 406311 B | `d242c87daae9…` | FAIL | OK |

### blox_fruits (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `hub` | 198174 B | `763d69182564…` | FAIL | OK |

### blox_strike (5)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `d0inks_router` | 4081 B | `e88cd3103006…` | OK | OK |
| `friezer_hub` | 60722 B | `4362e2893d28…` | FAIL | OK |
| `pps_hub` | 18035 B | `530010836359…` | FAIL | OK |
| `sigmaware` | 61122 B | `659f22d32492…` | FAIL | OK |
| `twistedk1d` | 20954 B | `84a5809ba66e…` | OK | OK |

### bloxburg (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `autobuild` | 448023 B | `e75bda7da957…` | FAIL | FAIL |

### close_quarters_combat (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `gui` | 56090 B | `097c68bddc7c…` | OK | OK |

### corpus (3)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `aztupbrew` | 228955 B | `f2ffd79c6dcb…` | FAIL | OK |
| `luraph_v15_rideapet` | 118336 B | `341f9c23c7f7…` | FAIL | OK |
| `psu_small` | 59404 B | `949ae97a1e75…` | FAIL | FAIL |

### counter_blox (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `hub` | 309402 B | `a28e7d13561d…` | OK | OK |

### gacha_online (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `hub` | 344898 B | `a0d804dfbec7…` | FAIL | FAIL |

### gpo (4)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `a7dev_loader` | 48117 B | `0e56e13f2b09…` | FAIL | OK |
| `austina_ui` | 228390 B | `664d797d1cc8…` | OK | OK |
| `tempest_hub` | 16575 B | `ae18062466cb…` | OK | OK |
| `venomware` | 9185 B | `7e5daba57a5a…` | OK | OK |

### grow_a_garden (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `hub` | 310916 B | `970449ee9d7a…` | FAIL | OK |

### illegal_soccer (4)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `luarmor_router` | 13535 B | `c3ba2c9cb296…` | OK | OK |
| `maxlegends_loader` | 53719 B | `243a08f3dbf0…` | OK | OK |
| `polsec_loader` | 78570 B | `50aa639c2084…` | FAIL | OK |
| `super_futebol` | 19445 B | `fd15efc24f50…` | FAIL | OK |

### ironbrew_cascade (12)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `_script_hub` | 117330 B | `1c13cc738ee0…` | FAIL | FAIL |
| `anti_afk` | 3711 B | `cfae20a2b978…` | OK | OK |
| `avatar_swastika` | 5137 B | `b3493a2367a7…` | OK | OK |
| `clone_tycoon_2_1_billion_gems` | 3223 B | `bd9407879178…` | OK | OK |
| `ctrl_click_tp` | 4641 B | `fd4e6722d021…` | FAIL | OK |
| `fps_booster` | 4320 B | `c9474775e482…` | OK | OK |
| `god_mode_any_game` | 5951 B | `5a0e69b7a663…` | OK | OK |
| `mega_fun_obby_auto_skip_stages` | 3743 B | `49afe442768d…` | OK | OK |
| `piggy_item_hub` | 6993 B | `7712c090d6e2…` | OK | OK |
| `prison_life_destroyer_hub` | 7026 B | `75d0324565f0…` | OK | OK |
| `tiny_tanks_gui` | 7417 B | `6c2c5657f7bc…` | OK | OK |
| `tower_of_hell_script` | 9553 B | `9d77e8e798cd…` | FAIL | OK |

### jailbreak (3)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `gui_2` | 82396 B | `1521d3912a81…` | OK | OK |
| `jailbreaker_v42` | 36535 B | `2a8b6c1ffd8d…` | OK | OK |
| `unjailbreak` | 193233 B | `ab4aca02ffd9…` | OK | OK |

### king_legacy (6)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `KL_msv2_v13` | 142178 B | `835f3f482348…` | FAIL | OK |
| `KL_msv3_v14_ZombieAttack` | 158941 B | `fcb31f941846…` | FAIL | OK |
| `KL_msv3_v15_ZombieAttack` | 292494 B | `5f839c0264d0…` | FAIL | OK |
| `KL_psu40_BloxFruit` | 1332794 B | `34161b7df401…` | FAIL | FAIL |
| `KL_psu40_Kingpiece` | 875470 B | `4d70bc8f9173…` | FAIL | FAIL |
| `KL_psu45_ano` | 3509697 B | `8b1f8c6df678…` | FAIL | FAIL |

### murder_mystery_2 (3)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `full` | 62908 B | `fb3da0ffd7df…` | OK | OK |
| `ghost_hub` | 228321 B | `27cccc16dbe2…` | FAIL | OK |
| `gui` | 46302 B | `8cb6f4d0129b…` | FAIL | OK |

### one_piece (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `kaitun_nav` | 39989 B | `f9036386c705…` | OK | OK |

### pet_simulator (2)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `gui` | 55133 B | `ec5554aca0f3…` | OK | OK |
| `op_gui` | 33298 B | `a82184e450ae…` | OK | OK |

### piggy (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `hub` | 63378 B | `b1cac97fa8d2…` | FAIL | OK |

### prison_life (4)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `cmd_gui` | 138708 B | `153bbacecf83…` | OK | OK |
| `gui` | 51074 B | `026bc33e90a2…` | OK | OK |
| `main` | 167203 B | `755235af5bd9…` | OK | OK |
| `simple_gui` | 102468 B | `27728bfeb7b4…` | OK | OK |

### shindo_life (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `dogehub_v2_shindo` | 516265 B | `ad07fbb4697e…` | OK | OK |

### solara_hub (1)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `orion` | 287075 B | `3dbf6bb89aec…` | FAIL | OK |

### the_wild_west (4)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `coal_farm` | 119317 B | `7ffd787a8a34…` | OK | OK |
| `hub` | 163724 B | `7032a3cb10ca…` | FAIL | OK |
| `new_farm` | 116487 B | `f6acb9562c56…` | OK | OK |
| `no_coal` | 118989 B | `69f290badcf9…` | OK | OK |

### yba (3)

| Сэмпл | Размер combined | Приставка sha256 | Lua 5.1 | Luau AST |
|---|---:|---|---|---|
| `aethelburg_v16` | 33200 B | `06bd51cbb978…` | FAIL | OK |
| `azero_hub` | 36829 B | `b1b708623f9f…` | OK | OK |
| `kolgie` | 107471 B | `08abbaee66e4…` | FAIL | OK |

## Правила использования

- Файл читается как обычный `.lua`; раздел 1/2 — комментарии, раздел 2/2 — код.
- Восстановить исходные файлы: `git show <commit до дедупа>:deobf-report/results/<игра>/<сэмпл>/script.lua`.
- Код чужой; ничего в Roblox не запускалось. Запускать без понимания не нужно.
