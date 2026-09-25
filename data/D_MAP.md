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
                     running = true; cKb[84](cKb[91]["ChestController"], cKb[22])  -- cKb[22] = F6635
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
