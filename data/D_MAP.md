# Подсистема D — фарм: лут, сундуки, души, квесты, схематики
Карта построена **по артефакту** `ouroboros_ps2 (1).luau` (пруф-файл `ouroboros_main_pruned.txt`,
номера строк — по нему). Трейсы здесь не нужны: всё видно в исходнике.

## 0. Главный вывод — почему в трейсах «ничего не было»

Лут, сундуки, души и схематики подбираются **не сигналами**, а `ProximityPrompt`:

* `cKb[69]` — «дёрнуть промпт»: проверяет `h3:IsA("ProximityPrompt")`, `not bnB()`,
  умеет `fireproximityprompt` (строка 19540 и далее; вызовы: 2462, 4711, 4828, 5780,
  8511, 9523, 10086, 10260, 12938…).
* В UI есть отдельный тумблер **`InstantProximityPrompt`** («Instant ProximityPrompt»),
  строки 6843 / 33587.
* Поэтому рекордеры v2/v3, которые слушали `SignalEvent.ToServer`, не видели ни одного
  события подбора. В v4 добавлены хуки промптов.

Вывод: переписывать D можно целиком по артефакту; трейс нужен только как контроль.

## 1. Реестр контроллеров (живая таблица — `cKb[91]`, строки 34295–34317)

`cKb[56]` — вторая (легаси) копия того же реестра; сразу после живой ветки стоит
`cKb[56] = false`, а в коде 514 ссылок на `cKb[91]` против 88 на `cKb[56]`.
Рабочая таблица — **`cKb[91]`** (вопрос с «дублями» закрыт).

| Контроллер | Значения по умолчанию |
|---|---|
| LevelController | interval 0.05, priorityKey "AutoLevel" |
| QuestController | interval 0.05, quests {}, priorityKey "AutoQuest" |
| HuntController | interval 0.5, tiers {}, dropForeign false, priorityKey "AutoBossHunt" |
| DeliveryController | interval 0.5, priorityKey "AutoDelivery" |
| DemonController | interval 0.5, repMob "Mizunoto", drink true, dropForeign false, cursor 0, priorityKey "AutoDemon" |
| DungeonController | interval 0.05, range 250, priorityKey "AutoDungeon" |
| BringController | interval 0.1, range 2000 (без priorityKey) |
| CardController | interval 0.5, cards {}, priority {}, blockBareHands true, forceHeal false, healBelow 40 |
| WaveController | interval 0.25, voted false |
| MobController | interval 0.05, target "", priorityKey "AutoMob" |
| BossController | interval 2, bosses {}, current nil, waitName nil, dwell 0, skip {}, priorityKey "AutoBoss" |
| ChestController | interval 2, tiers {}, pending false, priorityKey "AutoChest" |
| BreathController | interval 2, breathing "", priorityKey "AutoBreathing" |
| TrainController | interval 1, codes {}, mode "Instantly", cursor 0, TextColor3 {}, priorityKey "AutoTraining" |
| SkillController | interval 5, nodes {}, unlockSkills false (без priorityKey) |
| EquipController | interval 20 (без priorityKey) |
| PotionController | interval 1, potion "", threshold 40, priorityKey "AutoPotion" |
| ShopController | interval 15, items {}, keep 1, priorityKey "AutoBuy" |
| FishController | interval 0.15, bait "None", buyBait false, priorityKey "AutoFish" |
| **LootController** | **interval 0.5, range 150, pending false, awaitUntil 0, priorityKey "AutoLoot"** |
| **SoulController** | **interval 0.5, range 250, priorityKey "AutoSoul"** |
| QueueController | interval 2, modes {}, ranked false, fill false, cursor 0, current nil |
| WorldController | interval 4, world "", privateOwner "" |
| CrystalController | interval 20, bundles 99, reserve 0, priorityKey "AutoBuyExp" |

Каждый контроллер ещё несёт `cancel = 0`. Общий список — `cKb[91]["controllers"]`.

## 2. Лента приоритетов фич (строка 16125)

`cKb[91]["features"] = { {key, controller, label, [moves=false]} … }`

| key | label | контроллер |
|---|---|---|
| AutoBuy | Auto Buy | ShopController |
| AutoLevel | Auto Level | LevelController |
| AutoPotion | Auto Potion (`moves=false`) | PotionController |
| AutoSoul | Auto Soul | SoulController |
| AutoDelivery | Auto Delivery Quest | DeliveryController |
| AutoBoss | Auto Boss | BossController |
| **AutoLoot** | **Auto Loot** | LootController |
| **AutoChest** | **Sealed Cache** (!!) | ChestController |
| AutoTraining | Auto Training | TrainController |
| AutoBreathing | Auto Breathing | BreathController |
| AutoBuyExp | F2092 | CrystalController |
| AutoFish | Auto Fishing | FishController |
| … | | |

Это и есть арбитраж: конфликтующие фичи гасятся через `cKb[54].uncommit(key)` / `OnFarmClaim`.

## 3. Настройки D в `cKb[51]` (F-слоты)

| Настройка | Слот | | Настройка | Слот |
|---|---|---|---|---|
| SetAutoLoot | F5861 | | SetAutoChest | F3785 |
| SetLootRange | F2617 | | SetChestTiers | F2199 |
| SetAutoSoul | F2208 | | SetChestInstantKill | F2680 |
| SetSoulRange | F4068 | | SetChestKillThreshold | F6033 |
| SetAutoQuest | F5937 | | SetAutoBoss | F2450 |
| SetQuestSelection | F5050 | | SetBossSelection | F2510 |
| QuestChoices | F5127 | | SetAutoBossHunt | F3652 |
| RefreshQuestChoices | F498 | | SetHuntTiers | F1785 |
| AbandonQuest | F2125 | | SetHuntDropForeign | F541 |
| QuestSummary | F3729 | | SetAutoMob | F6089 |
| SetAutoDelivery | F275 | | SetMobTarget | F6262 |
| SetAutoDungeon | F4387 | | MobNames | F2177 |
| SetDungeonRange | F334 | | SetAutoBringEnemies | F4058 |
| SetAutoDemon | F6492 | | SetBringRange | F5674 |
| SetDemonMob / Drink / DropForeign | F5735 / F3996 / F4207 | | SetAutoTraining | F… (см. API_MAP.md) |
| SetTrainings / SetTrainingMode | F1931 / F4270 | | SetKillThreshold / SetInstantKill | F51 / F4760 |
| CollectSchematics | F3068 | | StopSchematics | F2545 |
| SetSchematicTargets | F1267 | | SetSchematicReturn | F2078 |
| SchematicNames | F1823 | | | |

## 4. Лут (LootController)

**Включение/выключение — `SetAutoLoot` = F5861:**
```
on :  bpz["LootStatus"] = "Waiting for loot"
      cKb[91]["LootController"]["running"] = true
      cKb[84](cKb[91]["LootController"], bpd)      -- cKb[84] = F3818 (старт)
off:  running = false; pending = false; awaitUntil = 0
      cKb[91]["HuntController"]["lootUntil"] = nil
      bmX(cKb[91]["LootController"])               -- bmX = F6310 (стоп)
      bpz["LootStatus"] = "Idle"
```

**Шаг подбора (строка ~14028, состояния S4165…S4180):**
```
cna = aBP:FindFirstChildWhichIsA("ProximityPrompt")   -- дроп = объект с промптом
cnc = "loot"
bpz["LootStatus"] = "Collecting " .. tostring(cnc)
   … проверки: cna["Enabled"], aBP:GetAttribute("DropClaimedBy") == cKb[126]["UserId"],
              not aBP:IsDescendantOf(cKb[132])
cm8 = cKb[91]["LootController"]["attempts"][aBP]
cm8["count"]   = cm8["count"] + 1
cm8["retryAt"] = os.clock() + 2 + math.min(2 ^ math.min(cm8["count"], 5), 30)
```
Строки-подписи, которые шлёт подсистема:
`"Collecting drops"` (S13999, ещё и BossStatus), `"Collecting "`, `"Looted"`,
`"Cannot claim "`, `"Drop disappeared; receipt unconfirmed: "`, `"Waiting for loot"`,
`"Idle"`. Счётчики — `cKb[35]["Catalog"].Overworld` (ключи `Items`, `Caches`
«Sealed Caches», `Levels` «Levels Gained», `Souls` «Souls Collected»).

**Арбитр `bpd` = F744:** если активен/гасится `cKb[54]`, обходит `bp0`, у чужих
контроллеров ставит `running=false`, `bmX(controller)`, статус `"Idle"`, затем
зовёт `cKb[51]["OnFarmClaim"](aIu)`.

## 5. Сундуки (ChestController, в UI — «Sealed Cache»)

```
SetAutoChest(true):  cKb[130]("AutoChest"); bpz["ChestStatus"] = "Starting"
                     running = true; cKb[84](ChestController, <шаг>)
SetAutoChest(false): running = false; pending = false; bmX(controller); ChestStatus = "Idle"
```
Конец шага (строка 23514):
```
bnp["opened"][Og] = true
bpz["Chests"] = bpz["Chests"] + 1
bpz[Oh] = "Chest opened"
return true
```
Константы `CHEST_TIERS` (6836, 19702, 25850, 33580) и `CHEST_GUARD_RANGE` (901, 13502…).
Связка с убийством: `SetChestInstantKill` F2680, `SetChestKillThreshold` F6033,
`SetKillThreshold` F51, `SetInstantKill` F4760.

## 6. Души (SoulController)

`SetAutoSoul` F2208 (priorityKey "AutoSoul"), `SetSoulRange` F4068 (по умолчанию 250,
подсказка «How far to travel for a soul, 0 collects at any distance»).
Подписи: `"Auto Claim Souls"`, `"Souls Collected"`, `"No souls nearby"`, key `AutoSoul`,
label `"Auto Soul"`. Подбор — тоже через промпт (`cKb[69]`).

## 7. Квесты (QuestController)

`SetAutoQuest` F5937 → `QuestController{running, quests}` (queue из выбранных),
`SetQuestSelection` F5050, `QuestChoices` F5127, `RefreshQuestChoices` F498,
`AbandonQuest` F2125, `QuestSummary` F3729.

Постановка квеста в игре — сигнал:
```
bn8("AddQuest", wq)      -- строки 12024 и 37837
```
Подписи: `"[Ouroboros] quest step: "`, `"Waiting for the quest to load"`,
`"No permit quest in this place"`, `Quests.CanAddQuest` (игровой модуль),
`QuestStatus`, `QuestSummary`.

## 8. Схематики (ветка того же лут-механизма)

`CollectSchematics` F3068 / `StopSchematics` F2545 / `SetSchematicTargets` F1267 /
`SetSchematicReturn` F2078 / `SchematicNames` F1823.
Подписи: `"Collecting schematics"`, `"Already collecting schematics"`,
`"Stopped after %d collected"`, `"Schematics To Collect"`.

## 9. Что из этого уже проверено трейсами

| Факт из артефакта | Что показал трейс |
|---|---|
| Лут/сундуки — через промпты, не сигналы | AutoLoot 16 с ON → **0 сигналов** (v2/v3 промптов не видели) ✔ |
| `SetAutoChest`/`SetAutoLoot`/`SetAutoQuest` — те же слоты | В трейсах ровно эти имена в API.wrapper ✔ |
| `Item_Equip` идёт от игры (наградой), не от фарма | `Item_Equip 0/2` сразу после телепорт-петли AutoChest ✔ |
| Auto Training (`training_signaler`) — отдельный контроллер | `training_signaler/"Stop"/true` ×4 ✔ |

## 10. Следующие шаги по D

1. `SetAutoLoot`/`SetAutoChest`/`SetAutoSoul` + контроллеры — оформить в `ouroboros_farm.lua`
   (по образцу `ouroboros_equip.lua` и `ouroboros_parry.lua`).
2. Дорисовать тела шагов: лут-шаг (S4165…S4180 целиком, включая
   `attempts`/`retryAt`/`IsDescendantOf(cKb[132])`), шаг сундука (S7542),
   шаг души, шаг квеста (`[Ouroboros] quest step: `).
3. Схематики — отдельная пара `CollectSchematics`/`StopSchematics` (F3068/F2545).

## 11. Тела шагов — имена и адреса (первая копия артефакта)

| Шаг | Функция | Строка | Состояния |
|---|---|---|---|
| Лут (дроп) | `bnb(aBP, aBQ)` | 14014 | S4162…S4214 |
| Душа | `boc(aDC)` | 15938 | S13715…S13740 |
| Сундук | `cKb[91]["open"](chest, statusKey, cancel)` | ~23208 | S7535…S7566 |
| Схематики | `bqn(fz, fA)` | 20991 | — |
| Квесты | `bpn()` | 23850 | S14057…S14065 |
| Триггер промпта | `cKb[69](prompt)` | 19540 | S2052…S2059 |

Вспомогательные (для шагов): `bpb(drop)` — позиция, `bqd(pos, eps, cancel)` — подойти,
`bmO(controller)` = F5074 — снять claim/отметить неудачу, `cKb[13](fn, timeout, cancel)` —
wait-until, `F4803(a,b,c)` = Vector3, `F3022` = Vector3, `bnZ` = F892 — найти промпт.

### Сундук: тело открытия
```
if chest:GetAttribute("ChestState") == "Locked" → false
if not chest:IsDescendantOf(cKb[132])          → false
if not isOpened(chest):
     status = "Waiting for chest to unlock"
     wait-until(not descendant and ChestState ~= "Locked", 4) → если отмена: false
status = "Opening chest"
bqd(chest:GetPivot().Position + Vector3(0,3,0), 0.3, cancel)  -- подойти
wait-until(IsOpen == true или деревом удалён, 3)
opened[chest] = true; bpz["Chests"] += 1; status = "Chest opened"; true
```
`isOpened` = F138, `opened`/`retryAt` — weak-таблицы (`__mode = "k"`).

### Душа: тело (boc)
```
part = target:IsA("BasePart") and target or target:FindFirstChildWhichIsA("BasePart", true)
if part:IsDescendantOf(cKb[132]) → false
prompt = bnZ(target)  →  если есть: cKb[69](prompt)
иначе если есть firetouchinterest:
      firetouchinterest(part, target, 0); wait(0.1); firetouchinterest(part, target, 1)
wait-until(not target:IsDescendantOf(cKb[132]), 2)
status = "Collecting " .. aDC["label"]
если не подошли (bqd(aDC["point"] + Vector3(0,3,0), 0.2, …)) → false
bpz["Souls"] += 1; status = "Collected " .. label; true
иначе                                 status = "Cannot take " .. label; false
```

### Квесты: каркас шага (bpn)
```
if cKb[98](QuestController.quests) == 0 → выход
cKb[54]["commit"]("AutoQuest")
if not cKb[38]("AutoQuest") → выход
warn("[Ouroboros] quest step:" .. tostring(...))
… сбор/сортировка квестов, bnn(quest, …, "QuestStatus", QuestController),
  "Dropping stuck " .. cKb[142](quest)   -- добить зависший квест
```

## 12. Арбитр приоритетов (cKb[54]) — наблюдаемые операции

`commit(key)`, `do ne(key)`, `turn(key)`, `blocked(key)`, `label(key)`, `uncommit(key)`,
а также поля `active`, `settling`, `byKey`, `ownerRun`, `holder`, `lastClaim`,
`movementEpoch`. Статусы в UI: `PriorityStatus = "Running " .. label(key)`,
`"… waiting on " .. label(other)`, `PriorityHolder = label(key)`.
При старте бегуна: `cKb[54][2330] = {thread = F5473(), key = z8, run = bKi}`;
`cKb[56] = true` при захвате (флаг «идёт арбитраж»).

## 13. ВАЖНО про сам артефакт: в нём ДВЕ параллельные копии кода

Сдвиг ~5.5 тыс. строк: `bnb` 14014 ↔ 17679-ветка, `boc` 15938 ↔ ~21500,
«Chest opened» 23514 ↔ 34473, `cKb[38]` 23125 ↔ `cKb[142]` 34021,
`bqn` 20991 ↔ 26500-ветка. Логика одинаковая, отличаются имена временных
переменных. При сверке «дублей слотов» (cKb[104], bnY, cKb[107], bo_/boA) —
учитывать это: большинство «дублей» это как раз вторая копия.

Готовый читаемый порт: `ouroboros_farm.lua`.

## 14. Уточнения после вычитки тел (важно)

### Шаг сундука — это `bpL` (строка 13460), а НЕ слот `cKb[22]`
Прежняя пометка «cKb[22] = F6635 = шаг сундука» — неверна: F6635 ищет квест
(«Ill learn <X> Breathing»). Настоящий шаг сундука:

```
if not bnB() → pending = false; return
bmO(ChestController)                      -- снять прошлый claim
list = bps()                              -- заспавненные sealed caches
ChestController.pending = #list > 0
if #list == 0 → "No sealed cache spawned"; return
if not cKb[38]("AutoChest") → return
warn("[Ouroboros] chest step:" .. tostring(...))
ждём готовности контроллера: если не cKb[86](20) → "Waiting for character"; return
цикл:
  if not bny["controllerValid"](ChestController) → return
  list = bps(); if пусто → "No sealed cache spawned"; return
  охрана: bnN(function(mob)
            return not cKb[141]["PASSIVE_MOBS"][mob["name"]]
               and (mob["model"]:GetPivot().Position - bWZ).Magnitude
                   <= cKb[141]["CHEST_GUARD_RANGE"] end)          -- 220
  если не пусто → "Waiting for guards"; wait(1)
  иначе: sort(list) по расстоянию до позиции игрока; берём [1]
         bWX = chest["model"]; bWZ = bWX:GetPivot().Position
         если ChestState == "Locked":
             "Clearing " .. chest["tier"] .. " guards"
             bqd(bWZ + Vector3(0,5,0), 0.4, cancel); deadline = os.clock() + 180
         иначе: bp3(model, "ChestStatus", 120, controller, cond); wait(0.05)
         controllers["open"](bWX, "ChestStatus")
  в конце: bpY("AutoChest")
```
Константы: `cKb[141]["CHEST_TIERS"] = {"T1","T2","T3"}`, `CHEST_GUARD_RANGE = 220`,
`PASSIVE_MOBS` — таблица имён. Во второй копии артефакта (25850) тот же набор
записан в обратном порядке: `{"T3","T2","T1"}` — порядок в UI/приоритете, не логика.

### Раннер контроллеров — `bpu(controller, step)` (строка 3127), не слот
```
если controller["workerActive"] и not controller["stopped"] → выход
generation = (generation or 0) + 1; stopped = false; startedAt = os.clock(); yield = false
workerActive = true
task.delay(0, function()
    runId = coroutine.running(); bny["runs"][runId] = {controller=…, generation=…}
    while not stopped and generation совпадает:
        если bnB() → pcall(step); при ошибке warn("[Ouroboros] loop error:" .. err)
        если generation сменилась → выход
        если cKb[54]["ownerRun"] == record → cKb[54]["do ne"](priorityKey); bpY(priorityKey)
        task.wait(controller["interval"])
    bny["runs"][runId] = nil; workerActive = false
end)
```
`bmX` (стоп) ставит `stopped = true`, поднимает generation и ждёт снятия workerActive.

### Схематики
`cKb[91]["SchematicRunner"] = {running=false, cancel=0, ret=true, targets={}}` (27643).
Обёртки API: `CollectSchematics` F3068 = `return select(2, SchematicRunner.start())`;
`StopSchematics` F2545 = `SchematicRunner.stop(); return bpz["SchematicStatus"]`.
`bqn(part, owner)` (20991) — перенос физической детали: анкор/снятие анкора, ведение по
`cKb[64](part)` на Heartbeat, `AssemblyLinearVelocity = Vector3(0,-8,0)`,
`AssemblyAngularVelocity = Vector3.zero`.

### Осторожно с F-номерами в этой зоне
Проверено: `pool[6310]` — функция выбора квеста (`Category == "Combat"`,
`Requirements.Level`, `Quests.CanAddQuest`), хотя в тексте рядом стоит `bmX = F6310`.
Поэтому шаги выше опознаны **по содержимому**, а слоты считать черновыми.

## 15. Пороги убийства и боевые твики (закрыто)

**`Combat_Service` в артефакте НЕТ** (0 вхождений и в оригинале, и в пуле).
Строки `Combat_Service/Combat` с `A3=1..5`, `A5=0.13/0.04` в трейсах — это
собственный ремоут игры; рекордер видел его, потому что хукал `SignalEvent.ToServer`
целиком. Ouroboros свингов не шлёт вообще.

Влезает Ouroboros в бой через игровые таблицы:
`cKb[51]["CombatInputs"]` (строка 34340: `cKb[42] = cKb[51]["CombatInputs"]`),
`cKb[51]["SkillWork"]["entry"]`, `cKb[51]["BlockWork"]["entry"]`,
`bno["CombatPresets"]["slow_walk_duration"]`, `bno["CombatSkills"]`.

### Таблица твиков `cKb[99]["tweaks"]` (строка 37249), дефолты 1:1
```
noStun=true, noRagdoll=false, instantKill=false, killThreshold=10,
chestKill=false, chestKillThreshold=10, infStamina=false, infClimb=false,
infHorse=false, noDrown=false, noDashCd=false, noSun=false, alwaysRun=false,
ownership=false, ownershipRange=250, [8562344]=false
```
Алиасы: `cKb[72] = cKb[99]["tweaks"]` (32666), `bop = cKb[99]["tweaks"]` (23692).

### Сеттеры (F-слоты)
| | | | |
|---|---|---|---|
| SetKillThreshold F51 (clamp 0..100, деф. 10) | SetChestKillThreshold F6033 | SetInstantKill F4760 | SetChestInstantKill F2680 |
| SetNoStun F5991 | SetNoRagdoll F6168 | SetNoAttackSlowdown F5934 | SetNoDashCooldown F734 |
| SetNoDrown F5927 | SetInfiniteStamina F4483 | SetInfiniteClimb F2327 | SetInfiniteHorseStamina F787 |
| SetAlwaysRun F2206 | SetDisableShiftLock F4303 | SetNoSunDamage F127 | SetOwnershipRange F841 (clamp 50..2000) |

### Семантика порога
`meta = 1 - clamp(threshold,0,100)/100`; убиваем при `Health <= MaxHealth * meta`.
То есть слайдер = «сколько % здоровья должно быть снято до казни»: 0 → сразу,
10 → после 10% урона (дефолт), 100 → фактически никогда.
MaxHealth лежит в **атрибуте `humanoid["Serpent"]`** (проверка `Serpent > 0`).

### `bpX` — Instant Kill (строка 733)
```
если not tweaks["instantKill"] → выход
meta = 1 - killThreshold/100
для каждой записи mobs() (boo() = F76: обход cKb[132]["Debree"]/["Regions"],
        модели с Humanoid):
    если humanoid.Serpent > 0
       и humanoid.Health <= humanoid.Serpent * meta
       и (model:FindFirstChild("HumanoidRootPart") или model.PrimaryPart)
       и model.ReceiveAge == 0:
           task.defer(function() humanoid.Health = 0 end); break
```
Убийство делается **установкой Health = 0 в task.defer**, а не свингом — поэтому
UI и пишет, что «instant kill пропатчен, но всё ещё работает».

### `boZ` — Chest Kill (строка 813)
```
если not tweaks["chestKill"] → выход
если not ChestController.running или ChestController.stopped → выход
locked = позиции sealed-сундуков с ChestState == "Locked" (из bps()); пусто → выход
meta = 1 - chestKillThreshold/100
для каждого моба:
    если Serpent > 0 и Health <= Serpent*meta и ReceiveAge == 0
       и не PASSIVE_MOBS[name]
       и (root.Position - любая locked-позиция).Magnitude <= CHEST_GUARD_RANGE (220):
           task.defer(function() humanoid.Health = 0 end)
```

### Тикер
`bon(); bpX(); boZ()` — внутри цикла под флагом `cKb[72]["AntiAfk"]` (пул: 2557 = "AntiAfk"),
цикл запускается через `F2175(function() … end)`. То есть казнь и зачистка охраны
идут каждый проход анти-АФК тика.

Готовый читаемый порт: `ouroboros_combat.lua`.
