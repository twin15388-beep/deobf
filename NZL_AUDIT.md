# Аудит проекта deobf / NZL Studio — что подтверждено и что нужно делать

Дата: 2026-09-24. Ветка: `arena/01a0d367-deobf`.
Аудит статический: тулчейн Luau собран из исходников, файлы разобраны парсером, все цифры ниже воспроизводимы командами из раздела 8.

---

## 1. Инвентарь: что лежит в репозитории

| Файл | Что это на самом деле | Состояние |
|---|---|---|
| `ouroboros_ps2 (1).luau` | **Оригинал** Ouroboros, обработанный обфускатором luast v1.0.1. 2 268 423 символа, одна строка кода. Валидный Luau — **не** мусор и **не** «2.2-МБ ядро Luast», как записано в статус-доке, а flattened-исходник со всеми константами. | Разбирается парсером целиком: 757 930 токенов за 1.2 с |
| `Текстовый документ (2).txt` | Дамп констант оригинального рантайма: 5 895 записей пула, 8 `MATCH`-строк, 26 секций `FUNCTION/CONSTANTS`. Это результат работы резолвера (`__OUROBOROS_RUNTIME_RESOLVED`), не исходник. | Годен как источник строк/имён, **индексы несовместимы** (раздел 2.5) |
| `NZL ui.txt` | Библиотека Lumen UI (одним файлом) + demo-блок в конце. Полностью совпадает с копией, встроенной в standalone. | Синхронен (99.64 %, разница — только 53 строки примера) |
| `ouroboros_clean_source.lua` | Читаемое реконструированное ядро, `clean-0.25`, 1 379 строк, 25 worker-контроллеров, ~145 методов. | Синтаксически валиден, внутренне согласован |
| `ouwland_clean_main.lua` | Standalone-сборка: Lumen + ядро + меню (10 060 строк, 677 функций). | Синтаксически валиден, UI↔ядро согласованы |
| `ouroboros_behavior_trace.lua` | Инструмент №1: рекордер вызовов (хукает `SignalEvent/SignalFunction/InputHandler/Skill_Controller` + публичный API + движение). | Валиден |
| `ouroboros_deep_extract.lua` | Инструмент №2: дамп графа замыканий через `getgc` (методы, константы, upvalues, protos). | Валиден |
| `NZL_RECONSTRUCTION_STATUS.md` | Отчёт автора: 560 closures из 19 корней, извлечённые константы и модульная иерархия. | Полезен, но отстал от кода (в шапке 0.23, в ядре 0.25) |
| `ouwland_recon_findings.md` | Recon-заметки по игре (Place ID `136406881576517`): пути модулей, регионы, сигналы, что уже сдампили. | Актуален |

**Добавлено этим аудитом:** `tools/luaflat.py`, `tools/inline_constants.py`, `ouroboros_ps2_resolved.lua`, `data/pool.json`, `data/feature_index.json`.

---

## 2. Что подтверждено проверками

### 2.1 Все Lua-файлы компилируются
`luau-analyze` (собран из исходников Luau) не находит ни одной синтаксической ошибки ни в одном файле. Все замечания — только про Roblox/executor-глобалы (`Enum`, `task`, `game`, `fireproximityprompt`, `isnetworkowner`, `writefile`, `cloneref` и т. п.), то есть нормальный контекст исполнения исполнителя.

### 2.2 Оригинальный артефакт — не мусор
`ouroboros_ps2 (1).luau` успешно разбирается как Lua/Luau. Устройство: один **позиционный пул констант** `cKb[136] = { ... }`; в коде на него 10 001 ссылка `cKb[136][N]`, плюс локальный алиас `local cTz = cKb[136]` (ещё 8 958 ссылок `cTz[N]`). Каждая функция переписана в state machine (`while true do <PC> = ... if <PC> < ... then ...`), при этом **все строки и числа лежат в пуле в открытом виде**.

Извлечённый пул: **6 641 запись** — 3 283 строки, 2 746 чисел, 569 функций, остальное таблицы/выражения. Корректность индексации проверена на «очевидных» местах: `FindFirstChild("Debree"/"Regions"/"ActiveNpcs"/"Horse")`, `GetService("Stats"/"Players"/"UserGameSettings"/"VirtualInputManager")` — совпадает с recon-заметками.

### 2.3 UI ↔ ядро согласованы (мнимых «мёртвых» тумблеров нет)
Проверка по именам: 47 диспатч-имён из `call(...)`, 94 метода, 142 прямых `Core:X()` и 103 поля `Core.Options`. Результат: **все существуют**, внутренних вызовов `Core:X()` без определения — 0, чтений несуществующих полей `Options` — 0. Сеттеры вида `SetAutoMob` не описаны явно, а генерируются циклом (`setters` + `Core["Set"..method]`), поэтому наивный поиск «мёртвых» тумблеров даёт ложные срабатывания — учитывайте это при ревизии.

Таблица `setters` и `workerBodies` совпадают ровно: 25 авто-функций ↔ 25 worker-тел, у каждой есть флаг в `Options`.

### 2.4 Lumen синхронен
`NZL ui.txt` и встроенная в `ouwland_clean_main.lua` копия библиотеки отличаются только demo-блоком `--#region example` в конце файла. Рассинхрона нет.

### 2.5 Важно: индексы пула в дампе и в артефакте **разные**
Совпадает содержимое (2 825 общих строк), но нумерация различается:

| Строка | Индекс в `.luau` | Индекс в дампе `.txt` |
|---|---|---|
| `Auto Loot` | 5636 | 3270 |
| `AutoMob` | 318 | 5636 |
| `Keep Amount` | 2949 | 6496 |
| `Webhook URL` | 2976 | 4564 |

Разница в остальном — экранирование (`\\u{203A}` против реального символа). **Вывод: строки `MATCH X = [N]` из дампа нельзя переносить на артефакт; сопоставлять только по значению строки.**

### 2.6 Константы артефакта развёрнуты в читаемый файл
`ouroboros_ps2_resolved.lua` (1.75 МБ) — тот же код, но `cKb[136][N]`/`cTz[N]` заменены на литералы (19 529 строк, 18 230 чисел, 1 863 выражения). Пример «до/после»:

```lua
-- до:   cKb[91][36.][365] = boa(aLc)
-- после: cKb[91]["..."][365] = ...        (ключи уже читаемы)
-- до:   bQf = if (bQD*cKb[136][3379] + ...) % cKb[136][16777213] == cKb[136][3766938] then 9. else 3.
-- после: bQf = if (bQD*3379 + bQE*770 + bQD*bQE) % 16777213 == 3766938 then 9. else 3.
```

Функции занимают 569 слотов пула и помечены ярлыками `F<N>`; для **405 слотов** удалось установить имя прямо по местам регистрации таблиц: `F51 → SetKillThreshold`, `F127 → SetNoSunDamage`, `F177 → PriorityRows`, `F238 → SetWenMob`, `F84 → applySlowdown`, `F174 → PotionNames`, `F130 → rotatingShop`, `F138 → isOpened` и т. д. То есть по resolved-файлу уже можно находить конкретные реализации фич.

---

## 3. Чего у нас нет: 45 публичных методов оригинала

В дампе видно **127** имён вида `Set*`/`Teleport*`. У нас отсутствуют **45** (ещё 5 — `SetInstantKill`, `SetNoStun`, `SetNoRagdoll`, `SetNoAttackSlowdown`, `SetNotifyBosses` — генерируются циклом и на самом деле есть). Это не «переименования»: почти за каждым именем стоит отдельная подсистема, подтверждённая строками дампа.

### 3.1 Целые подсистемы, которых у нас нет вообще

1. **Discord-вебхуки и отчёты** (8 методов: `SetWebhookUrl/Enabled/Events/Interval/Ping/PingId/SkipQuiet/...`)
   Строки: `WebhookChannels`, `WebhookEventLabels`, `WebhookItemCategories`, `WebhookStatus`, `SendWebhookReport`, `WebhookSent/WebhookFailed`, `Report Every`, `Skip Empty Reports`, `Ping Me`, `Your Discord ID`, `Enter a valid Discord webhook URL`, `Copy Discord Invite`, `Ouroboros Hub`, regex `^https://[%w%-%.]*discord[%w%-%.]*%.com/api/webhooks/%d+/[%w%-_]+$`, `This executor has no HTTP request function`, `You are a demon` (шаблон отчёта).
2. **Сбор схем (Schematic)** — `SetSchematicTargets`, `SetSchematicReturn`
   Строки: `SchematicRunner`, `SchematicNames`, `Schematics To Collect`, `Collect Schematics`, `StopSchematics`, `Collecting schematics`, `Already collecting schematics`, `No schematics selected`, тултип «Teleports to each schematic you picked that you don't have yet and studies it».
3. **Ownership Viewer** — `SetOwnershipViewer`, `SetOwnershipRange`
   Строки: `OwnershipViewer`, `ownershipRange`, тег `OuroborosOuwlandOwnership`, «Kills any NPC your client has network ownership of», `Executor has no isnetworkowner`.
4. **Планировщик приоритетов как фича** — `SetPriorityMode`, `SetPriorityOrder`, `SetPriorityPreempt`
   Строки: `Priority Scheduling`, `PriorityLabels`, `PriorityRows`, `ResetPriorityOrder`, `Saved Order`, `Interrupt Lower Priority`, `SettlePriority`, `BeginPriorityLoad`, `PREEMPT_COOLDOWN`, «Comma separated feature keys, highest priority first. Auto Loot stays first. Saved with the config».
   У нас приоритеты движения есть внутри ядра, но нет пользовательского интерфейса и preempt-режима.
5. **Мир и время суток** — `SetWorld`, `SetAutoWorld`
   Строки: `WorldController`, `Worlds module`, `WorldNames`, `WorldStatus/WorldTarget`, `DayAndNightHandler module`, `IsNight/IskNight`, `OnlyAtNight`, «Waiting for night (%ds)», «Waiting for night to find Muzan», «Muzan is out in …», `The overworld to teleport into`, `Already in a world`, `Join World`, `Unknown world`, `Pick a world`.
   (Muzan-логика у нас есть, ожидания ночи и перехода по мирам — нет.)
6. **Лошади** — `SetInfiniteHorseStamina` (+ `EspHorse`, `EspHorseColour`)
   Строки: `Horse`, `Wild Horse`, `Wild Horse ESP`, «Stops every horse speed mode draining stamina, so Run never times out».
7. **Фарм Wen** — `SetWenMob`
   Строки: `Wen Farm Mob`, `Farming Wen %d/%d`, `Wen Earned`, `%d Wen (have %d)`, `WenCostOnAccept`, `The permit costs %d Wen`.
8. **Фильтры дропа и инвентарь** — `SetLevelDropForeign`, `SetHuntDropForeign`, `SetDemonDropForeign`, `SetKeepAmount`, `SetItemCategories`
   Строки: `LevelDropForeign`, `HuntDropForeign`, `DemonDropForeign`, `Keep Amount`, `Name Drops From`, `Instant Kill Cache Guards`, `DropClaimedBy`, `DropItemId`, `DropOwnerUserId`, `DropReservedFor`, `Drop disappeared; receipt unconfirmed`, `Dropping stuck`, `WebhookItemCategories`.
9. **Докупки в магазине** — `SetAutoBuyExp`, `SetAutoBuyBait`, `SetExpBundles`
   Строки: `EXP_BUNDLE_POINTS`, `EXP_MAX_BUNDLES`, `EXP_PER_BUNDLE`, `EXP_LISTING`, `BAIT_RESTOCK`, `Bought %d exp for %d points`, `Bundles Per Trip`, `Tailor Restocks`.
10. **Мелкие, но реальные** — `SetDisableShiftLock` («Turns the game's Left Alt shift lock back off whenever it comes on»), `SetBlockBareHands` («Nothing chosen, Bare Hands blocked», `BARE_HANDS_CARD`), `SetUnlockSkills`, `SetWeapon`, `SetBreathing`, `SetMovementMode`, `SetPositionType`, `SetLookAtEnemy`, `SetTrainings`, `SetNotifyWarn`, `SetNotification`, `SetPrivateOwner`, `SetPointReserve`, `TeleportToNotification`, `SetFeature`, и **другая форма ESP-API**: `SetEsp`, `SetEspCategory`, `SetEspOption`, `SetEspDistance`, `SetEspColour` (у нас `SetEspMobs/Bosses/Chest/Players/Npcs/Loot/Muzan`).

### 3.2 Возможности оригинала, которых нет даже в наших Options

Из строк дампа: импорт/экспорт конфига в буфер (`Export Config to Clipboard`, `Import Config from Clipboard Text`, «That config is too large», `Imported %d setting%s`), статистика сессии и UI-дашборд (`Levels Gained`, `Wen Earned`, `Floors Cleared`, `Cards Picked`, `Items Obtained`, `Shop Purchases`, `Run Points`, `Fish Caught`, `Hearts Lost`, `Player Info`, `Level / Race / Clan`), доставка-эскорт (`Escorting Dr. Higoshima %d/%d`), permit-квест, `Biwa Bell`, `Block When Parry Is Locked Out`, `Keep Blocking After A Parry`, `Wall Climb`, `Double Jump`, `High Jump`, `Jump Power`, `FPS Boost`, `Disable 3D Rendering`, `Hide UI On Start`, `Instant ProximityPrompt`, `No Gameplay Paused`, `Sealed Cache` (+Tiers), мини-игры (`Boulder Push`, `Boulder Split`, `Cup Game`, `Target Shooting`), `Spider Lily ESP`, `Lever ESP`, `Muzan ESP` (у нас есть), `Auto Sealed Cache`, `Auto Claim Souls` (у нас `AutoSoul`).

Итого оригинал заметно больше реконструкции: 572 строки-подписи против 38 флагов и 8 страниц меню у нас.

---

## 4. Протокол: что подтверждено, а что у нас расходится

| Действие | В дампе | У нас | Вердикт |
|---|---|---|---|
| `Combat_Service` («Combat», combo, runHit, hitDelay, airCombo, swing) | нет (подтверждено трейсом) | есть | ок, 5-hit тайминги `{.39,.26,.26,.32,1.47}`, delay `.13/.04`, сброс через 2.2 с — совпадает с трейсом |
| `InputHandler.VirtualPress/Release("Combat")` | есть | только фолбэк | приемлемо |
| `AddQuest`, `NpcTalking/"Ended"`, `EndNpcTalk` | `AddQuest`/`NpcTalking` есть | есть | ок |
| `Item_Equip` | **есть** | **нет** | ❌ единственный реально наблюдавшийся маршрут экипировки (`SignalEvent.ToServer("Item_Equip", slot)`), у нас `EquipWeapon`/`Item`/`EquipBait` — нужно перевести экипировку на `Item_Equip` с фолбэком |
| `server_skill_controller_signaler` | есть | нет (косвенно) | ⚠️ используем `Skill_Controller.Attempt_Hold/StopHold` — как в трейсе, но `Attempt_Hold(skill, skill)` передаёт вторым аргументом **имя вместо key**; нужны реальные биндинги или `nil` |
| `UnlockSkillTreeNode` (SignalFunction) | есть | есть | ок |
| `RedeemCode` | есть | есть | у нас есть запасной `Codes` |
| `PurchaseFromShop`, `PurchaseSelection` | `PurchaseFromShop` есть | оба есть | `PurchaseSelection` подтверждён декомпиляцией диалогов |
| `BossHuntsRequest/"Request"`, `OuwigaharaRequest`, `SkipFloor`, `MuzanLairAssign`, `MuzanGiveBell`, `EquipBait`, `EquipWeapon`, `Codes`, `Item` | есть | есть | ок |
| `VisitRegion`, `Dash_Handler.Perform` | нет | нет | были в трейсе/recon, в коде не используются — решить, нужно ли |
| `getframework`/wrappers `SignalEvent.ToServer`, `SignalFunction.ToServer` | есть | есть | ок |

---

## 5. Что стоит починить/учесть (статически видно, рантаймом не проверено)

1. **Производительность защит.** В обработчике `RunService.Stepped` при включённых `No Stun`/`No Ragdoll`/`No Attack Slowdown`/`Noclip`/`Fly` выполняется **до 6 полных обходов `GetDescendants()`** по персонажу каждый кадр (три отдельных цикла по маркерам + цикл по `ValueBase` по двум корням + цикл по `BasePart`). На живом сервере это просадка FPS. Нужен один проход + кэш потомков/тегов вместо пяти.
2. **Экипировка (см. 4).** `EquipBestTool` вызывает `humanoid:EquipTool(best)` и затем remote `EquipWeapon`; наблюдавшийся оригинал отправлял `Item_Equip` с номером слота.
3. **`Attempt_Hold(name, key)`.** Второй аргумент — key, у нас передаётся имя скилла. Для `Blocking` уже правильно (`"Blocking","F"`).
4. **`AutoReconnect`** дёргает `TeleportToPlaceInstance(game.PlaceId, game.JobId, ...)` без проверки, что `JobId` не пустой — в Studio/приватном сервере это тихий no-op.
5. **Статус-док рассинхронизирован с кодом**: шапка говорит `clean-0.23`, в ядре `Version="clean-0.25"`, число методов 142 против фактических ~145.
6. **Ни одна сетевая сигнатура и ни один формат квестов не проверены в игре** — это признано в статус-доке и остаётся главным риском (в разделе 6 это P1).

Замечание: «мёртвых» тумблеров в UI **нет** (проверено), как и вызовов несуществующих методов ядра.

---

## 6. Что нам нужно — план

**P0. Точность протокола (до любых новых фич)**
1. Перевести экипировку на `Item_Equip(slot)` с фолбэком на текущий путь.
2. Починить второй аргумент `Attempt_Hold` (реальные биндинги из `Skill_Controller`/`Skills_Module` или `nil`).
3. Решить по `VisitRegion`/`Dash_Handler`: использовать или явно задокументировать, что не используем.
4. Оптимизировать обработчик защит (один проход вместо шести).

**P1. Рантайм-проверка (исполнитель + целевая игра)**
Прогнать `ouroboros_behavior_trace.lua` (V2) на каждой фиче по одной и сверить фактические аргументы с нашим кодом; прогнать `ouroboros_deep_extract.lua` и сохранить граф (в статус-доке уже есть 560 closures — нужен повторный прогон на актуальной версии игры). Без этого раунда любые правки протокола — угадывание.

**P2. Восстановление отсутствующих подсистем из артефакта**
Теперь это возможно почти напрямую: есть разобранный артефакт, извлечённый пул и карта «фича → индекс пула → место в коде» (`data/feature_index.json`). Следующий шаг — **де-flattening**: у каждой бывшей функции есть собственный PC и диапазон состояний (`bsX`, `cf4`, `cq_`), поэтому функции режутся механически, затем восстанавливается структура (`if/else`, циклы) и генератор выдаёт читаемый Lua. Это даст точные реализации вместо догадок.
Порядок внедрения по ценности: вебхуки/отчёты → world/ночь → схемы → фильтры дропа + `Keep Amount` → ownership viewer → лошади/Wen → UI приоритетов → `Auto Buy Exp/Bait`.

**P3. Гигиена проекта**
Обновить `NZL_RECONSTRUCTION_STATUS.md` (версия, число методов, добавить раздел «чего нет»), держать сгенерированные файлы отдельно от исходников, не пересылать повторно уже сданмпленное (список в `ouwland_recon_findings.md`).

**Открытый вопрос к автору проекта:** цель — 1:1 повторить оригинал (тогда P2 обязателен и мы идём в де-flattening) или сделать свою читаемую реализацию с тем же функционалом (тогда P2 нужен только как справочник, а приоритет — P1 и P3)? От ответа зависит порядок работ.

---

## 6a. Де-flattening: первый результат

Инструмент `tools/deflatten.py` разбирает state machine обратно в читаемый вид. Модель, проверенная на артефакте:

```
local P = nil; P = <init>
while true do
    P = <C> - P            -- mirror (у вложенных машин его может не быть)
    <диспетчер: дерево условий над P>
end
```
* диспетчер проверяет **отражённое** значение `S = C - P`, поэтому id состояний — это S;
* лист либо заканчивается `P = <значение>` (переход), либо `break` (выход), либо `return`;
* `continue` и обычное падение в конец цикла эквивалентны: следующее состояние = `C - <значение>`;
* `P = if cond then A else B` — условный переход.

Итог: **427 машин** разобрано (остальные 142 функции пула — обычные, не flattened), включая
**вложенные** машины внутри `for`/`while`. Результат: `ouroboros_deflattened.txt` (689 КБ, с индексом).

Пример — в оригинале это `SetOwnershipRange` (F841):

```lua
-- state S10266            -- ветка "аргумент не число"
  czA = 250                --   -> подставляем 250
  --> goto 10265
-- state S10265
  czy["ownershipRange"] = math.clamp(czA, 50, 2000)
```

То есть оригинал: `tweaks.ownershipRange = math.clamp(tonumber(arg) or 250, 50, 2000)`, где `tweaks` — это `cKb[99]["tweaks"]`.

Второе наблюдение: obfuscator вставляет **opaque predicates** вида
`if (a*3579 + b*3158 + a*b) % 16777213 == 4167650 then ... else ...` — это всегда-истинные/ложные
условия, они не несут логики (в F238 `SetWenMob` такая проверка оборачивает обычное
`BreathController.wenMob = type(v) == "string" and v or ""`). Их нужно сворачивать при чтении.

## 7. Артефакты этого аудита

| Файл | Назначение |
|---|---|
| `tools/luaflat.py` | Токенизатор + рекурсивный парсер Luau + извлечение позиционного пула. Разбирает 2.27 МБ артефакт за ~1.2 с (`python3 tools/luaflat.py "ouroboros_ps2 (1).luau"`). |
| `tools/inline_constants.py` | Разворачивает `cKb[136][N]`/`cTz[N]` в литералы, помечает слоты функций, собирает карту «функция → имя». |
| `ouroboros_ps2_resolved.lua` | 1.75 МБ читаемого кода (константы подставлены). Пересобирается одной командой. |
| `data/pool.json` | Пул: значения, типы, имена функций. |
| `tools/feature_index.py` | Строит карту «имя фичи → индекс пула → смещения в resolved-файле». |
| `data/feature_index.json` | Готовая карта: 174 имени с индексами пула и якорями в коде. |
| `tools/deflatten.py` | Де-flattener: `--slot N`, `--name X`, `--all [--combined FILE]`; разворачивает машины состояний (в т.ч. вложенные) в читаемый вид. |
| `ouroboros_deflattened.txt` | 427 разобранных функций с индексом — основной материал для 1:1 переноса. |

---

## 8. Воспроизведение

```bash
# парсер и пул
python3 tools/luaflat.py "ouroboros_ps2 (1).luau"

# читаемая версия артефакта + индексы (arg2 = .lua, arg3 = .json)
python3 tools/inline_constants.py "ouroboros_ps2 (1).luau" ouroboros_ps2_resolved.lua data/pool.json
python3 tools/feature_index.py "ouroboros_ps2 (1).luau" data/feature_index.json ouroboros_ps2_resolved.lua

# проверка синтаксиса (нужен собранный Luau CLI)
# cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build -j
luau-analyze ouroboros_clean_source.lua
luau-analyze ouwland_clean_main.lua
```

Ключевые цифры для сверки: пул 6 641 запись (3 283 строки / 2 746 чисел / 569 функций); 10 001 ссылка `cKb[136][N]` + 8 958 `cTz[N]`; развёрнуто 19 529 строк и 18 230 чисел; 405 слотов функций подписаны именами; 127 публичных методов оригинала, 45 отсутствуют; 25 worker-контроллеров и 103 флага `Options` в ядре; 47 диспатч-имён UI, все реализованы.

## Update: constant pool decoded exactly (2026-09-25)

The artifact builds its whole constant pool as one table constructor
(`cKb[136] = { "fish", 841, ..., function() ... end }`, tokens 1183-236334). Naive
scanners mis-align on it because Luau prefix-ifs (`x = if c then 1 else 2`) have no
`end`, so `if`/`end` counting drifts and index/count bookkeeping goes wrong.

Fixed by `tools/luascan.py` (if-ownership stack: a statement `if` pushes a block closed
by `end`, a prefix-if is closed when its else-branch expression ends at its own depth;
an `if` after `then`/`else` inherits the owning construct's kind).

Result: **6641 fields, 0 mismatches** against `data/pool.json["values"]`, and 405/405
named slots resolve to closures. The pool is fully positional, so the Lua key equals
the listing index -- i.e. the pool index *is* the F-slot id used by the de-flattener.

Validated spot checks: `[466] = 0`, `[6629] = 1`, `[1355] = 3`, `[4093] = 4`,
`[2770] = "Item_Equip"`, `[5349] = "BuyExpNow"`, `[2441] = "SchematicStatus"`.
These match the opaque-predicate patterns (`x*1 + y*(1-x)`) seen in the source.

`tools/pool_map.py` writes `data/pool_index.json`; `tools/deflatten.py` substitutes
pool reads (`cKb[136][N]` and `<alias>[N]`) with the literal they hold, and renders
pool closures as `F<index>` (the F-legend names them).

### New rendering pipeline

1. `python3 tools/pool_map.py "ouroboros_ps2 (1).luau" data/pool_index.json`
2. `python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --all --combined ouroboros_deflattened.txt`
3. `python3 tools/deflatten.py "ouroboros_ps2 (1).luau" --main ouroboros_main_deflattened.txt`
4. `python3 tools/prune_junk.py "ouroboros_ps2 (1).luau" --out ouroboros_main_pruned.txt`

`prune_junk.py` simulates the flattened dispatcher from its entry state with a
restricted numeric evaluator over the junk counter (`cKb[21] = (cKb[21] + 39) % 56`),
marks reachable states (1488 of 1761) and resolves counter-only edges; edges that
depend on real runtime values stay marked `[runtime-dependent]`.

### Equipment (`Item_Equip`) path

Fully readable inside the pruned engine (`ouroboros_main_pruned.txt:15035`):

```lua
cKb [27] = function(ml, mm)
    -- state S4899: if bz7 then goto 4903
    -- state S4900: if bz6["Value"] == ml then goto 4911
    -- state S4901: return (pcall(function() bz6["Value"] = ml end))
    -- state S4902: bz7 = ml > #cKb[141]["SLOT_NAMES"]
    -- state S4903: return false
    -- state S4904: bn8("Item_Equip", ml); goto 4905
    -- state S4905: return true
end
```
