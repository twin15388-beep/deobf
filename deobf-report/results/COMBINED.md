# COMBINED — единые `script.combined.lua` (2026-11-17)

Требование: «к каждому деобф скрипту … делаешь 1 lua файл где все в 1 скрипт объединено».
Формат: вариант «A» (имя — `script.combined.lua`), валидный Lua-файл:

```
-- шапка: игра / сэмпл / каталог / состав / дата / sha256 скрипта / предупреждение
-- РАЗДЕЛ 1/2: PARTS.md — построчно как Lua-комментарии (механики, API, имена функций, парты)
-- РАЗДЕЛ 2/2: восстановленный код ДОСЛОВНО (script.lua; для shindo — recovered-payload)
```

Сгенерировано: `deobf-report/tools/build_combined.py` (детерминированно; self-check:
секция кода совпадает с исходником дословно). Shindo `dogehub_v2_shindo` — особый случай:
локального script.lua нет; в combined вшит `recovered/dogehub_v2_shindo_payload_remote_plaintext.lua`
(506 964 B, plain Lua) + пометки про цепочку и вебхук; подробности — `RECOVERY.md`.

## Итог проверки (Lua 5.1.1 `loadfile`)

- Всего combined-файлов: **63** (62 сэмпла с script.lua + 1 shindo особый случай)
- `loadfile` OK: **34**; FAIL: **29**
- Статус combined **полностью совпадает** со статусом исходного `script.lua` (расхождений: **0**)
- FAIL-файлы — это НЕ дефект объединения, а свойства восстановленного кода:
  диалект Luau / `goto` (MoonSec/Luraph, см. INDEX.md «Lua 5.2+ (goto)», «Luau (continue)»),
  `lbl_*`-метки unluac-артефактов, лимит Lua 5.1 «более 200 локальных переменных».
  На уровне Luau (`luau-ast`) эти файлы проверялись пайплайном (см. VALIDATION.md §2).
- Комментарии (раздел 1/2) на `loadfile` не влияют.

## Файлы по играм

### blox_fruits (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `hub` | `blox_fruits/hub/script.lua` (191163 B, sha256 `4863cc8547cd…`) | FAIL: deobf-report/results/blox_fruits/hub/script.lua:709: '=' expected near 'end' → FAIL: deobf-report/results/blox_fruits/hub/script.combined.lua:801: '=' expected near 'end' |

### blox_strike (5)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `d0inks_router` | `blox_strike/d0inks_router/script.lua` (756 B, sha256 `d05a87ac59bf…`) | OK → OK |
| `friezer_hub` | `blox_strike/friezer_hub/script.lua` (54971 B, sha256 `7b0f1f267e9d…`) | FAIL: deobf-report/results/blox_strike/friezer_hub/script.lua:736: '=' expected near 'end' → FAIL: deobf-report/results/blox_strike/friezer_hub/script.combined.lua:812: '=' expected near 'end' |
| `pps_hub` | `blox_strike/pps_hub/script.lua` (13548 B, sha256 `0b9f5c2c4740…`) | FAIL: deobf-report/results/blox_strike/pps_hub/script.lua:165: '=' expected near 'end' → FAIL: deobf-report/results/blox_strike/pps_hub/script.combined.lua:239: '=' expected near 'end' |
| `sigmaware` | `blox_strike/sigmaware/script.lua` (56322 B, sha256 `1f75549f5065…`) | FAIL: deobf-report/results/blox_strike/sigmaware/script.lua:405: ')' expected near ':' → FAIL: deobf-report/results/blox_strike/sigmaware/script.combined.lua:478: ')' expected near ':' |
| `twistedk1d` | `blox_strike/twistedk1d/script.lua` (16017 B, sha256 `7b819d06878d…`) | OK → OK |

### bloxburg (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `autobuild` | `bloxburg/autobuild/script.lua` (442381 B, sha256 `3b78e780f55e…`) | FAIL: deobf-report/results/bloxburg/autobuild/script.lua:275: '=' expected near 'lbl_17' → FAIL: deobf-report/results/bloxburg/autobuild/script.combined.lua:357: '=' expected near 'lbl_17' |

### close_quarters_combat (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `gui` | `close_quarters_combat/gui/script.lua` (51920 B, sha256 `eb1eadd1f412…`) | OK → OK |

### corpus (3)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `aztupbrew` | `corpus/aztupbrew/script.lua` (224466 B, sha256 `5beb96acd51f…`) | FAIL: deobf-report/results/corpus/aztupbrew/script.lua:139: function at line 138 has more than 200 local variables → FAIL: deobf-report/results/corpus/aztupbrew/script.combined.lua:212: function at line 211 has more than 200 local variables |
| `luraph_v15_rideapet` | `corpus/luraph_v15_rideapet/script.lua` (112939 B, sha256 `9053791151a4…`) | FAIL: deobf-report/results/corpus/luraph_v15_rideapet/script.lua:18: '=' expected near '+' → FAIL: deobf-report/results/corpus/luraph_v15_rideapet/script.combined.lua:181: '=' expected near '+' |
| `psu_small` | `corpus/psu_small/script.lua` (54749 B, sha256 `1496f2a43312…`) | FAIL: deobf-report/results/corpus/psu_small/script.lua:2: '=' expected near 'lbl_275' → FAIL: deobf-report/results/corpus/psu_small/script.combined.lua:76: '=' expected near 'lbl_275' |

### counter_blox (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `hub` | `counter_blox/hub/script.lua` (303604 B, sha256 `667aec1dc2e3…`) | OK → OK |

### gacha_online (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `hub` | `gacha_online/hub/script.lua` (339422 B, sha256 `7cb52e846079…`) | FAIL: deobf-report/results/gacha_online/hub/script.lua:974: '=' expected near 'lbl_63' → FAIL: deobf-report/results/gacha_online/hub/script.combined.lua:1055: '=' expected near 'lbl_63' |

### gpo (4)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `a7dev_loader` | `gpo/a7dev_loader/script.lua` (42959 B, sha256 `fbb02c950bbe…`) | FAIL: deobf-report/results/gpo/a7dev_loader/script.lua:381: '=' expected near '+' → FAIL: deobf-report/results/gpo/a7dev_loader/script.combined.lua:456: '=' expected near '+' |
| `austina_ui` | `gpo/austina_ui/script.lua` (223104 B, sha256 `36046bce2bca…`) | OK → OK |
| `tempest_hub` | `gpo/tempest_hub/script.lua` (11649 B, sha256 `7439beb864b3…`) | OK → OK |
| `venomware` | `gpo/venomware/script.lua` (4139 B, sha256 `8031387f5083…`) | OK → OK |

### grow_a_garden (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `hub` | `grow_a_garden/hub/script.lua` (303811 B, sha256 `8ffff96dd9fb…`) | FAIL: deobf-report/results/grow_a_garden/hub/script.lua:317: '=' expected near 'end' → FAIL: deobf-report/results/grow_a_garden/hub/script.combined.lua:405: '=' expected near 'end' |

### illegal_soccer (4)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `luarmor_router` | `illegal_soccer/luarmor_router/script.lua` (7861 B, sha256 `cd50c27357a7…`) | OK → OK |
| `maxlegends_loader` | `illegal_soccer/maxlegends_loader/script.lua` (48706 B, sha256 `36ba092213d2…`) | OK → OK |
| `polsec_loader` | `illegal_soccer/polsec_loader/script.lua` (72999 B, sha256 `6539f83c3608…`) | FAIL: deobf-report/results/illegal_soccer/polsec_loader/script.lua:469: '=' expected near 'end' → FAIL: deobf-report/results/illegal_soccer/polsec_loader/script.combined.lua:555: '=' expected near 'end' |
| `super_futebol` | `illegal_soccer/super_futebol/script.lua` (14983 B, sha256 `f66422346393…`) | FAIL: deobf-report/results/illegal_soccer/super_futebol/script.lua:238: '=' expected near '+' → FAIL: deobf-report/results/illegal_soccer/super_futebol/script.combined.lua:309: '=' expected near '+' |

### ironbrew_cascade (12)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `_script_hub` | `ironbrew_cascade/_script_hub/script.lua` (113697 B, sha256 `f8084bae064e…`) | FAIL: deobf-report/results/ironbrew_cascade/_script_hub/script.lua:72: '=' expected near 'lbl_97' → FAIL: deobf-report/results/ironbrew_cascade/_script_hub/script.combined.lua:138: '=' expected near 'lbl_97' |
| `anti_afk` | `ironbrew_cascade/anti_afk/script.lua` (682 B, sha256 `36f794e4ada0…`) | OK → OK |
| `avatar_swastika` | `ironbrew_cascade/avatar_swastika/script.lua` (1815 B, sha256 `651a484fae92…`) | OK → OK |
| `clone_tycoon_2_1_billion_gems` | `ironbrew_cascade/clone_tycoon_2_1_billion_gems/script.lua` (172 B, sha256 `8f5bf4fc48e8…`) | OK → OK |
| `ctrl_click_tp` | `ironbrew_cascade/ctrl_click_tp/script.lua` (1489 B, sha256 `aa5b316c6471…`) | FAIL: deobf-report/results/ironbrew_cascade/ctrl_click_tp/script.lua:66: '=' expected near 'lbl_26' → FAIL: deobf-report/results/ironbrew_cascade/ctrl_click_tp/script.combined.lua:115: '=' expected near 'lbl_26' |
| `fps_booster` | `ironbrew_cascade/fps_booster/script.lua` (927 B, sha256 `8a0ff18457ec…`) | OK → OK |
| `god_mode_any_game` | `ironbrew_cascade/god_mode_any_game/script.lua` (2574 B, sha256 `25b0dbaf0251…`) | OK → OK |
| `mega_fun_obby_auto_skip_stages` | `ironbrew_cascade/mega_fun_obby_auto_skip_stages/script.lua` (665 B, sha256 `cd64900e552e…`) | OK → OK |
| `piggy_item_hub` | `ironbrew_cascade/piggy_item_hub/script.lua` (3479 B, sha256 `9e6846146933…`) | OK → OK |
| `prison_life_destroyer_hub` | `ironbrew_cascade/prison_life_destroyer_hub/script.lua` (3479 B, sha256 `9e6846146933…`) | OK → OK |
| `tiny_tanks_gui` | `ironbrew_cascade/tiny_tanks_gui/script.lua` (4179 B, sha256 `8f14e296bc16…`) | OK → OK |
| `tower_of_hell_script` | `ironbrew_cascade/tower_of_hell_script/script.lua` (5623 B, sha256 `1d345f5c52e4…`) | FAIL: deobf-report/results/ironbrew_cascade/tower_of_hell_script/script.lua:192: '=' expected near 'lbl_20' → FAIL: ...report/results/ironbrew_cascade/tower_of_hell_script/script.combined.lua:249: '=' expected near 'lbl_20' |

### jailbreak (3)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `gui_2` | `jailbreak/gui_2/script.lua` (77370 B, sha256 `ac70c5c7bac8…`) | OK → OK |
| `jailbreaker_v42` | `jailbreak/jailbreaker_v42/script.lua` (31983 B, sha256 `5c5cb2aac7e4…`) | OK → OK |
| `unjailbreak` | `jailbreak/unjailbreak/script.lua` (188010 B, sha256 `45edf9d38fd7…`) | OK → OK |

### king_legacy (6)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `KL_msv2_v13` | `king_legacy/KL_msv2_v13/script.lua` (137181 B, sha256 `34f68134fbd8…`) | FAIL: deobf-report/results/king_legacy/KL_msv2_v13/script.lua:459: main function has more than 200 local variables → FAIL: deobf-report/results/king_legacy/KL_msv2_v13/script.combined.lua:537: main function has more than 200 local variables |
| `KL_msv3_v14_ZombieAttack` | `king_legacy/KL_msv3_v14_ZombieAttack/script.lua` (153410 B, sha256 `70df705de55f…`) | FAIL: deobf-report/results/king_legacy/KL_msv3_v14_ZombieAttack/script.lua:58: function or expression too complex near 'L1_1' → FAIL: ...-report/results/king_legacy/KL_msv3_v14_ZombieAttack/script.combined.lua:143: function or expression too complex near 'L1_1' |
| `KL_msv3_v15_ZombieAttack` | `king_legacy/KL_msv3_v15_ZombieAttack/script.lua` (286462 B, sha256 `72d6477e1dfb…`) | FAIL: deobf-report/results/king_legacy/KL_msv3_v15_ZombieAttack/script.lua:877: function or expression too complex near 'L2_2' → FAIL: ...-report/results/king_legacy/KL_msv3_v15_ZombieAttack/script.combined.lua:967: function or expression too complex near 'L2_2' |
| `KL_psu40_BloxFruit` | `king_legacy/KL_psu40_BloxFruit/script.lua` (1326986 B, sha256 `28546cbea033…`) | FAIL: deobf-report/results/king_legacy/KL_psu40_BloxFruit/script.lua:574: function at line 573 has more than 200 local variables → FAIL: deobf-report/results/king_legacy/KL_psu40_BloxFruit/script.combined.lua:657: function at line 656 has more than 200 local variables |
| `KL_psu40_Kingpiece` | `king_legacy/KL_psu40_Kingpiece/script.lua` (869682 B, sha256 `8acece9099f5…`) | FAIL: deobf-report/results/king_legacy/KL_psu40_Kingpiece/script.lua:695: function at line 694 has more than 200 local variables → FAIL: deobf-report/results/king_legacy/KL_psu40_Kingpiece/script.combined.lua:778: function at line 777 has more than 200 local variables |
| `KL_psu45_ano` | `king_legacy/KL_psu45_ano/script.lua` (3503821 B, sha256 `44b27bd62de0…`) | FAIL: deobf-report/results/king_legacy/KL_psu45_ano/script.lua:1: main function has more than 200 local variables → FAIL: deobf-report/results/king_legacy/KL_psu45_ano/script.combined.lua:85: main function has more than 200 local variables |

### murder_mystery_2 (3)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `full` | `murder_mystery_2/full/script.lua` (58322 B, sha256 `1244a8092576…`) | OK → OK |
| `ghost_hub` | `murder_mystery_2/ghost_hub/script.lua` (223026 B, sha256 `f414c90abf57…`) | FAIL: deobf-report/results/murder_mystery_2/ghost_hub/script.lua:64: '=' expected near 'else' → FAIL: deobf-report/results/murder_mystery_2/ghost_hub/script.combined.lua:144: '=' expected near 'else' |
| `gui` | `murder_mystery_2/gui/script.lua` (41687 B, sha256 `2353fc0a122e…`) | FAIL: deobf-report/results/murder_mystery_2/gui/script.lua:312: '=' expected near 'Grinestroy' → FAIL: deobf-report/results/murder_mystery_2/gui/script.combined.lua:387: '=' expected near 'Grinestroy' |

### one_piece (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `kaitun_nav` | `one_piece/kaitun_nav/script.lua` (34977 B, sha256 `e5f8896993fd…`) | OK → OK |

### pet_simulator (2)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `gui` | `pet_simulator/gui/script.lua` (50654 B, sha256 `a7d67e2872fe…`) | OK → OK |
| `op_gui` | `pet_simulator/op_gui/script.lua` (29068 B, sha256 `52b2949740cf…`) | OK → OK |

### piggy (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `hub` | `piggy/hub/script.lua` (57918 B, sha256 `98fe47bd6a85…`) | FAIL: deobf-report/results/piggy/hub/script.lua:843: '=' expected near 'lbl_20' → FAIL: deobf-report/results/piggy/hub/script.combined.lua:922: '=' expected near 'lbl_20' |

### prison_life (4)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `cmd_gui` | `prison_life/cmd_gui/script.lua` (133175 B, sha256 `6f45ffb97ad8…`) | OK → OK |
| `gui` | `prison_life/gui/script.lua` (46533 B, sha256 `42f9d9a2b203…`) | OK → OK |
| `main` | `prison_life/main/script.lua` (162204 B, sha256 `6693facaea4d…`) | OK → OK |
| `simple_gui` | `prison_life/simple_gui/script.lua` (98037 B, sha256 `d1baca810dba…`) | OK → OK |

### shindo_life (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `dogehub_v2_shindo` | `shindo_life/dogehub_v2_shindo/recovered/dogehub_v2_shindo_payload_remote_plaintext.lua` (506964 B, sha256 `64df436148bd…`) | OK → OK |

### solara_hub (1)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `orion` | `solara_hub/orion/script.lua` (282426 B, sha256 `f16a5094b829…`) | FAIL: deobf-report/results/solara_hub/orion/script.lua:263: '=' expected near 'lbl_26' → FAIL: deobf-report/results/solara_hub/orion/script.combined.lua:336: '=' expected near 'lbl_26' |

### the_wild_west (4)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `coal_farm` | `the_wild_west/coal_farm/script.lua` (114717 B, sha256 `ee5c4ef3d289…`) | OK → OK |
| `hub` | `the_wild_west/hub/script.lua` (158289 B, sha256 `d1daf4abb298…`) | FAIL: deobf-report/results/the_wild_west/hub/script.lua:5230: '=' expected near 'lbl_40' → FAIL: deobf-report/results/the_wild_west/hub/script.combined.lua:5310: '=' expected near 'lbl_40' |
| `new_farm` | `the_wild_west/new_farm/script.lua` (111881 B, sha256 `493fc818125a…`) | OK → OK |
| `no_coal` | `the_wild_west/no_coal/script.lua` (114395 B, sha256 `bd5148767065…`) | OK → OK |

### yba (3)

| Сэмпл | Источник кода | loadfile (src → combined) |
|---|---|---|
| `aethelburg_v16` | `yba/aethelburg_v16/script.lua` (28289 B, sha256 `486f8189dc56…`) | FAIL: deobf-report/results/yba/aethelburg_v16/script.lua:349: '=' expected near 'end' → FAIL: deobf-report/results/yba/aethelburg_v16/script.combined.lua:423: '=' expected near 'end' |
| `azero_hub` | `yba/azero_hub/script.lua` (31100 B, sha256 `fad3af398d3a…`) | OK → OK |
| `kolgie` | `yba/kolgie/script.lua` (102096 B, sha256 `a29bb20c20ae…`) | FAIL: deobf-report/results/yba/kolgie/script.lua:1848: function at line 1847 has more than 200 local variables → FAIL: deobf-report/results/yba/kolgie/script.combined.lua:1926: function at line 1925 has more than 200 local variables |

## Правила использования

- `script.combined.lua` — самодостаточный единичный артефакт: читается как обычный `.lua`.
- `script.lua` и `PARTS.md` не удалены: combined — надмножество (те же байты кода + комментарии).
- Код чужой; запускать его без понимания и без прав не нужно. Ничего в Roblox не запускалось.
