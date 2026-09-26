# История сборок Ouroboros (Ouwland) и как их доставать

Лоадер, на который ссылается `loadstring(...)` в исполнителе:

```lua
-- discord.gg/synapsex
loadstring(game:HttpGet("https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua"))()
```

`loader.lua` (репозиторий `joustingmatch/Ouroboros`) сам скрипт не содержит. Он выбирает файл
по игре:

```lua
local BASE = 'https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/games/'
local games  = { [<CreatorId>] = '<файл>.luau', ... }
local places = { [<PlaceId>]   = '<файл>.luau', ... }
local file = places[game.PlaceId] or games[game.CreatorId]
if file then
    loadstring(game:HttpGet(BASE .. 'donation.lua'))()   -- pcall
    loadstring(game:HttpGet(BASE .. file))()
end
```

Так что «лоадер поменялся» = поменялся только способ доставки и адрес файла; сам скрипт —
это отдельный файл в `games/`. Оувленд обслуживается файлом **`games/ps2.luau`**
(совпадает с именем присланного артефакта `ouroboros_ps2 (1).luau`, и в файле есть те же
строки: `OuroborosOuwlandOwnership`, `MuzanLairModel`, `Sickles Levers`, `SetEspOption`).

В лоадере есть и жёсткая проверка исполнителя: `Solara` и `Xeno` получают `Kick`.

## Как перекачать свежую сборку

```bash
python3 tools/fetch_build.py                 # games/ps2.luau -> artifacts/ps2_<дата>.luau
python3 tools/fetch_build.py --list          # последние 15 коммитов файла
```

Скрипт пишет рядом `<файл>.json` (коммит, дата, размер, md5, ссылка) и собирает пул
констант текущей сборки в `data/pool_index_<дата>.json`.

## Уже известные точки

| Дата (UTC) | Коммит | Размер | Файл | Что это |
|---|---|---|---|---|
| 2026-09-26 16:45 | `4d0c53af` | 4 084 210 | `artifacts/ps2_2026-09-26.luau` | текущая сборка (пул `fwe[164]`, 11 071 констант) |
| 2026-09-21 11:40 | `7f41e381` | 2 268 423 | `ouroboros_ps2 (1).luau` | **наш исходник истины** (md5 `5480ca80…`, отличается от нынешней на 80 %) |
| 2026-09-19 04:01 | `515100aa` | 708 804 | — | самая старая из доступных ревизий файла |

Проверка совпадения делается так:

```bash
gh api repos/joustingmatch/Ouroboros/contents/games/ps2.luau?ref=<commit> --jq '.sha' \
  | xargs -I{} gh api repos/joustingmatch/Ouroboros/git/blobs/{} --jq '.content' \
  | tr -d '\n' | base64 -d | md5sum      # сверяем с md5 исходника
```

Файл переписывается несколько раз в день (за 26 сентября — 10 коммитов), поэтому при каждой
сверке клона его надо перекачивать заново.

## Чем отличаются сборки (26.09 против 21.09)

* **Пул:** стало 11 071 константа вместо 6641, и он позиционный массив
  (`fwe[164][N]`, N — позиция), а не таблица со смешанными ключами, как `cKb[136]`.
* **Регистры:** локальные переменные превратились в ячейки той же таблицы `fwe`
  (`fwe[N] = …`), поэтому текст вырос вдвое. Локальные псевдонимы пула теперь выглядят
  как `local f39 = fwe[164]`.
* **Функции:** те же подсистемы (noStun, noRagdoll, RagdollConstraints, MuzanLairModel,
  Sickles Levers, SetEspOption, ownershipRange, ReceiveAge, Double_Jump, resourceTick,
  InstantKill, killThreshold, AntiAfk) — ядро и бой не переписаны.
* **Твики:** «магический» числовой ключ `tweaks[8562344]` заменён на имя —
  `tweaks["noSlowdown"]` (индекс 8410 в новом пуле).
* **UI:** тумблеров `AddToggle` стало 298 против 164 — добавлены новые функции и вкладки
  (напр. расписание/квесты: «does isao's whole rod questline», «at the tower crystal»,
  «bring enemies is hit or miss…»), часть текстов переписана (77 длинных подсказок
  убрано, 101 новая).
* **Тексты, которых больше нет:** `%d attempts, %d blocks, %d missed, %d cancelled`,
  `auto parry scheduler`, `Block When Parry Is Locked Out`, `BOSS_DWELL` и др.

### Публичный API

Настроек `Set*`/`Get*` было 128, стало 276: **163 новых** имени и **15 исчезли**
(часть переименована — так, вместо `SetParryHold`/`SetParryLead`/`SetParryMitigate`/
`SetParryNpcs` появились `SetParryRadius`, `SetParryPlayers`, `GetParryDiagnostics`).
Полные списки — `data/API_DELTA_2026-09-26.md`. Новое в основном про фарм:
кэш-хопы (`SetCacheHop*`), карты в Ouwigahara (`SetCardReroll*`, `SetCardPriorityList`,
`SetCardBlocks`), боссы (`SetBossHop*`, `SetBossOrder*`), продажа и рынок
(`SetAutoSell`, `SetAutoBuyMarket`, `SetAutoTradeCoins`), профессии
(`SetAnglerQuest`, `SetAutoYeti`), ассист прицела (`SetAimAssist*`).

## Как читать обе сборки одним инструментом

```bash
# 21.09 (cKb[136])
python3 tools/read_fn.py --pool 2440 --names
# 26.09 (fwe[164])
python3 tools/read_fn.py --pool 6 --poolref "fwe[164]" \
    --artifact artifacts/ps2_2026-09-26.luau \
    --pooldata data/pool_index_2026-09-26.json --names
```

`tools/read_fn.py` умеет читать функцию и по смещению в файле (`--offset 1 950 332`),
и по номеру в пуле (`--pool N`), и подставлять значения пула (`--names`). Внутри он режет
исходник по смещениям токенов — важно именно резать текст, а не склеивать токены: склейка
теряет пробелы и превращает `local cbI` в `localcbI`, после чего код не разбирается.
