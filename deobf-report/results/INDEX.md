# Результаты деобфускации
В каждом каталоге: `script.lua` — восстановленный Lua, `PARTS.md` — что за фичи/парты, `LOG.txt` — лог пайплайна.

| Игра | Сэмпл | Что это | Обфускатор | Строк Lua | Размер |
|---|---|---|---|---|---|
| corpus | `aztupbrew` | aztupbrew | psu | 6874 | 219 КБ |
| corpus | `psu_small` | psu_small | psu | 1479 | 53 КБ |
| corpus | `wynfuscate` | wynfuscate | wynfuscate (via unprom) | 324 | 96 КБ |
| king_legacy | `KL_msv2_v13` | Lightux v1.3 | moonsec_v2 | 4207 | 133 КБ |
| king_legacy | `KL_msv3_v14_ZombieAttack` | Lightux v1.4 (Zombie Attack) | moonsec_v3 | 6765 | 149 КБ |
| king_legacy | `KL_msv3_v15_ZombieAttack` | Lightux v1.5 (Zombie Attack) | moonsec_v3 | 10423 | 279 КБ |
| king_legacy | `KL_psu40_BloxFruit` | Blox Fruits hub | psu | 36695 | 1295 КБ |
| king_legacy | `KL_psu40_Kingpiece` | Kingpiece hub (King Legacy / Blox Fruits) | psu | 26393 | 849 КБ |
| king_legacy | `KL_psu45_ano` | ano hub (King Legacy) | psu | 56150 | 3421 КБ |

Отброшены как неинформативные (< 60 строк, снят только внешний слой):
- `luaobfuscator` — 15 строк
- `msv2_small` — 14 строк
- `prom_small` — 42 строк
