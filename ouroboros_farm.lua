--[[ ============================================================================
  Ouroboros — подсистема ФАРМА (D): лут, сундуки, души, схематики, квесты
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau (пул cKb[136]); номера строк — по
  ouroboros_main_pruned.txt. Полная карта: data/D_MAP.md

  Стиль: поведенческая реконструкция 1:1. Порядок проверок восстановлен по
  состояниям S4165…S4214 (лут), S13715…S13740 (душа), S7535…S7566 (сундук),
  S14057…S14065 (квест). Всё, что не дочитано, помечено в конце файла.

  ВАЖНО (проверено трейсами): подбор идёт через ProximityPrompt, а не через
  SignalEvent — поэтому в трейсах v2/v3 при включённом AutoLoot не было ни
  одного события. Триггер промпта — cKb[69] ("fireproximityprompt").
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Общий каркас: реестр контроллеров (cKb[91], строки 34295..34317)
-- Рабочая таблица — cKb[91]; cKb[56] — легаси-двойник, сразу после
-- инициализации гасится: cKb[56] = false.
-- ---------------------------------------------------------------------------
local controllers = {
    LevelController    = { interval = 0.05, cancel = 0, priorityKey = "AutoLevel" },
    QuestController    = { interval = 0.05, quests = {}, cancel = 0, priorityKey = "AutoQuest" },
    HuntController     = { interval = 0.5,  tiers = {}, dropForeign = false, cancel = 0, priorityKey = "AutoBossHunt" },
    DeliveryController = { interval = 0.5,  cancel = 0, priorityKey = "AutoDelivery" },
    DemonController    = { interval = 0.5,  repMob = "Mizunoto", drink = true, dropForeign = false, cursor = 0, cancel = 0, priorityKey = "AutoDemon" },
    DungeonController  = { interval = 0.05, range = 250, cancel = 0, priorityKey = "AutoDungeon" },
    BringController    = { interval = 0.1,  range = 2000, cancel = 0 },
    CardController     = { interval = 0.5,  cards = {}, priority = {}, blockBareHands = true, forceHeal = false, healBelow = 40, cancel = 0 },
    WaveController     = { interval = 0.25, voted = false, cancel = 0 },
    MobController      = { interval = 0.05, target = "", cancel = 0, priorityKey = "AutoMob" },
    BossController     = { interval = 2,    bosses = {}, current = nil, waitName = nil, dwell = 0, skip = {}, cancel = 0, priorityKey = "AutoBoss" },
    ChestController    = { interval = 2,    tiers = {}, pending = false, cancel = 0, priorityKey = "AutoChest" },
    BreathController   = { interval = 2,    breathing = "", cancel = 0, priorityKey = "AutoBreathing" },
    TrainController    = { interval = 1,    codes = {}, mode = "Instantly", cursor = 0, TextColor3 = {}, cancel = 0, priorityKey = "AutoTraining" },
    SkillController    = { interval = 5,    nodes = {}, unlockSkills = false, cancel = 0 },
    EquipController    = { interval = 20,   cancel = 0 },
    PotionController   = { interval = 1,    potion = "", threshold = 40, cancel = 0, priorityKey = "AutoPotion" },
    ShopController     = { interval = 15,   items = {}, keep = 1, cancel = 0, priorityKey = "AutoBuy" },
    FishController     = { interval = 0.15, bait = "None", buyBait = false, cancel = 0, priorityKey = "AutoFish" },
    LootController     = { interval = 0.5,  range = 150, pending = false, awaitUntil = 0, cancel = 0, priorityKey = "AutoLoot" },
    SoulController     = { interval = 0.5,  range = 250, cancel = 0, priorityKey = "AutoSoul" },
    QueueController    = { interval = 2,    modes = {}, ranked = false, fill = false, cursor = 0, current = nil, cancel = 0 },
    WorldController    = { interval = 4,    world = "", privateOwner = "", cancel = 0 },
    CrystalController  = { interval = 20,   bundles = 99, reserve = 0, cancel = 0, priorityKey = "AutoBuyExp" },
}
controllers.controllers = controllers          -- cKb[91]["controllers"] = {все по списку}
controllers.opened  = setmetatable({}, { __mode = "k" })   -- что уже открыто
controllers.retryAt = setmetatable({}, { __mode = "k" })   -- кулдаун повторов
controllers.isOpened = function(part) return bn_ and bn_(part) end
controllers.SchematicRunner = { running = false }

-- ---------------------------------------------------------------------------
-- Лента приоритетов (cKb[91]["features"], строка 16125)
-- key / label / controller. Конфликтующие фичи гасятся арбитром.
-- ---------------------------------------------------------------------------
local FEATURES = {
    { key = "AutoBuy",      label = "Auto Buy",           controller = controllers.ShopController },
    { key = "AutoLevel",    label = "Auto Level",         controller = controllers.LevelController },
    { key = "AutoPotion",   label = "Auto Potion",        controller = controllers.PotionController, moves = false },
    { key = "AutoSoul",     label = "Auto Soul",          controller = controllers.SoulController },
    { key = "AutoDelivery", label = "Auto Delivery Quest",controller = controllers.DeliveryController },
    { key = "AutoBoss",     label = "Auto Boss",          controller = controllers.BossController },
    { key = "AutoLoot",     label = "Auto Loot",          controller = controllers.LootController },
    { key = "AutoChest",    label = "Sealed Cache",       controller = controllers.ChestController },
    { key = "AutoTraining", label = "Auto Training",      controller = controllers.TrainController },
    { key = "AutoBreathing",label = "Auto Breathing",     controller = controllers.BreathController },
    { key = "AutoBuyExp",   label = F2092,                controller = controllers.CrystalController },
    { key = "AutoFish",     label = "Auto Fishing",       controller = controllers.FishController },
}

-- ---------------------------------------------------------------------------
-- Арбитр приоритетов (cKb[54]): доступные операции, встречаются в шагах
-- ---------------------------------------------------------------------------
local priority = {
    commit  = function(key) return cKb[54]["commit"](key) end,          -- заявить фичу
    done    = function(key) return cKb[54]["do ne"](key) end,           -- закончить
    turn    = function(key) return cKb[54]["turn"](key) end,
    blocked = function(key) return cKb[54]["blocked"](key) end,
    label   = function(key) return cKb[54]["label"](key) end,
    uncommit= function(key) return cKb[54]["uncommit"](key) end,
}
-- cKb[54]["active"], ["settling"], ["byKey"], ["ownerRun"], ["holder"],
-- ["lastClaim"], ["movementEpoch"], ["PriorityStatus"], ["PriorityHolder"]

local function enabled(key) return cKb[38](key) end       -- фича включена?

-- ---------------------------------------------------------------------------
-- Триггер промпта (cKb[69], строка 19540) — им берётся и лут, и сундуки, и души
-- ---------------------------------------------------------------------------
local function TriggerPrompt(prompt)                 -- cKb[69]
    if not cKb[118](fireproximityprompt) then        -- функция доступна?
        cKb[100]("fireproximityprompt")
        return false
    end
    if not bnB() then return false end               -- действия разрешены?
    if not prompt:IsA("ProximityPrompt") then
        prompt = prompt:FindFirstChildWhichIsA("ProximityPrompt", true)
        if not prompt then return false end
    end
    if not prompt.Enabled then return false end
    return pcall(fireproximityprompt, prompt)
end

-- ---------------------------------------------------------------------------
-- ЛУТ — шаг LootController: bnb(aBP, aBQ)  (строка 14014, состояния S4162…S4214)
--   aBP = объект дропа, aBQ = функция отмены/признак "ждать"
-- ---------------------------------------------------------------------------
local function LootStep(drop, cancel)
    local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt")      -- S4165
    if not prompt then return false end                                -- S4200

    local itemId = drop:GetAttribute("DropItemId")                     -- S4196
    local label = itemId or "loot"                                     -- S4166
    bpz["LootStatus"] = "Collecting " .. tostring(label)               -- S4167
    if not prompt.Enabled then                                         -- S4167 → S4199
        bpz["LootStatus"] = "Waiting for pickup readiness"
        return false
    end

    -- S4169: проверка «можно ли забирать»
    if not claimable(drop) then
        -- S4213: подойти к дропу (смещение вверх на 3)
        local ok = bqd(bpb(drop) + Vector3.new(0, 3, 0), 0.2, cancel)
        if not ok then return false end                                -- S4198
    end

    -- S4193/S4214: уважать retryAt записи попытки
    local record = controllers.LootController.attempts[drop]
    if record and record.retryAt and os.clock() < record.retryAt then
        return false
    end

    -- S4176/S4177: провал попытки → счётчик растёт, кулдаун по бэкоффу
    if not cKb[138](drop) then                                         -- cKb[138] = F2668
        record = record or { count = 0 }
        controllers.LootController.attempts[drop] = record
        record.count = record.count + 1
        record.retryAt = os.clock() + 2 + math.min(2 ^ math.min(record.count, 5), 30)
        return false
    end

    -- S4181..S4183: создать запись первой попытки
    record = controllers.LootController.attempts[drop] or { count = 0 }
    controllers.LootController.attempts[drop] = record

    -- S4184: дождаться, пока дроп либо отмечен забранным, либо исчез
    local waited = cKb[13](function()                                   -- wait-until, таймаут 2
        return drop:GetAttribute("DropClaimedBy") ~= nil
            or not drop:IsDescendantOf(cKb[132])
    end, 2, cancel)

    if drop:GetAttribute("DropClaimedBy") == cKb[126]["UserId"] then   -- S4171
        bpz["Looted"] = bpz["Looted"] + 1                              -- S4211
        bpz["LootStatus"] = "Collected " .. tostring(label)            -- S4209
        return true
    end

    if waited then                                                     -- S4173
        return false
    end

    if TriggerPrompt(prompt) then                                      -- S4186/S4189
        bpz["LootStatus"] = "Collected " .. tostring(label)
        return true
    end

    bpz["LootStatus"] = "Cannot take " .. tostring(label)              -- S4185
    return false
end

-- ---------------------------------------------------------------------------
-- ДУША — шаг SoulController: boc(aDC)  (строка 15938, состояния S13715…S13740)
--   aDC = { label = "...", point = Vector3, part = <Instance> }
-- ---------------------------------------------------------------------------
local function SoulStep(soul)
    local target = soul.part
    local part = target:IsA("BasePart") and target                        -- S13715
              or target:FindFirstChildWhichIsA("BasePart", true)          -- S13736
    if not part then return false end                                     -- S13719
    if part:IsDescendantOf(cKb[132]) then return false end                -- S13718/S13730

    local prompt = bnZ(target)                                            -- S13720 (bnZ = F892)
    if prompt then
        TriggerPrompt(prompt)                                             -- S13734 → S13729
    elseif cKb[118](firetouchinterest) then                               -- S13726/S13735
        F2175(firetouchinterest, part, target, 0)
        task.wait(0.1)                                                    -- F3916(0.1)
        F2175(firetouchinterest, part, target, 1)
    end

    -- S13729: подождать, пока цель не окажется «своей»
    local ok = cKb[13](function() return not target:IsDescendantOf(cKb[132]) end, 2, part)
    if ok then                                                            -- S13721
        return false
    end

    bpz["SoulStatus"] = "Collecting " .. soul["label"]                    -- S13731/S13733
    if not bqd(soul["point"] + Vector3.new(0, 3, 0), 0.2, part) then      -- S13724
        return false
    end

    bpz["Souls"] = bpz["Souls"] + 1                                       -- S13723
    bpz["SoulStatus"] = "Collected " .. soul["label"]
    return true
    -- иначе (S13722): bpz["SoulStatus"] = "Cannot take " .. soul["label"]; return false
end

-- ---------------------------------------------------------------------------
-- СУНДУК — controllers["open"](chest, statusKey, cancel)
--   (состояния S7535…S7566, строка 23125-ветка)
-- ---------------------------------------------------------------------------
function controllers["open"](chest, statusKey, cancel)
    if chest:GetAttribute("ChestState") == "Locked" then                  -- S7536
        return false
    end
    if not chest:IsDescendantOf(cKb[132]) then return false end           -- S7535

    if not controllers.isOpened(chest) then                               -- S7539
        bpz[statusKey] = "Waiting for chest to unlock"
        cKb[13](function()                                                -- таймаут 4
            return not chest:IsDescendantOf(cKb[132])
                and chest:GetAttribute("ChestState") ~= "Locked"
        end, 4, cancel)
        if cancel() then return false end
    end

    bpz[statusKey] = "Opening chest"                                      -- S7561
    if not bqd(chest:GetPivot().Position + Vector3.new(0, 3, 0), 0.3, cancel) then
        -- S7547/S7563: не смогли подойти
        return false
    end

    cKb[13](function()                                                    -- таймаут 3
        return chest:GetAttribute("IsOpen") == true
            or not chest:IsDescendantOf(cKb[132])
    end, 3, cancel)

    if chest:GetAttribute("IsOpen") == true or not chest:IsDescendantOf(cKb[132]) then
        controllers.opened[chest] = true                                  -- S7542
        bpz["Chests"] = bpz["Chests"] + 1
        bpz[statusKey] = "Chest opened"
        return true
    end
    return false
end

-- ---------------------------------------------------------------------------
-- СХЕМАТИКИ — bqn(fz, fA) (строка 20991)
-- ---------------------------------------------------------------------------
local function SchematicStep(what, cancel)
    -- статусы: "Collecting schematics" / "Already collecting schematics"
    --          "Stopped after %d collected" / "Schematics To Collect"
    bpz["SchematicStatus"] = "Collecting schematics"
    -- …см. раздел «не дочитано»
    return false
end

-- ---------------------------------------------------------------------------
-- КВЕСТЫ — шаг QuestController: bpn() (строка 23850)
-- ---------------------------------------------------------------------------
local function QuestStep()
    if cKb[98](controllers.QuestController.quests) == 0 then return end    -- пусто → выходим
    priority.commit("AutoQuest")                                          -- cKb[54]["commit"]
    if not enabled("AutoQuest") then return end                           -- cKb[38]("AutoQuest")
    warn("[Ouroboros] quest step:" .. tostring(bMQ))                      -- отладка
    -- далее: сбор квестов, сортировка, bnn(quest, …, "QuestStatus", QuestController),
    -- «Dropping stuck » .. cKb[142](quest) — см. «не дочитано»
end

-- ---------------------------------------------------------------------------
-- Настройки из меню (F-слоты) — 1:1
-- ---------------------------------------------------------------------------
local function SetAutoLoot(value)                    -- F5861
    if value then
        bpz["LootStatus"] = "Waiting for loot"
        controllers.LootController.running = true
        cKb[84](controllers.LootController, bpd)
    else
        controllers.LootController.running = false
        controllers.LootController.pending = false
        controllers.LootController.awaitUntil = 0
        controllers.HuntController.lootUntil = nil
        bmX(controllers.LootController)
        bpz["LootStatus"] = "Idle"
    end
end

local function SetAutoChest(value)                   -- F3785
    if value then
        cKb[130]("AutoChest")
        bpz["ChestStatus"] = "Starting"
        controllers.ChestController.running = true
        cKb[84](controllers.ChestController, cKb[22])
    else
        controllers.ChestController.running = false
        controllers.ChestController.pending = false
        bmX(controllers.ChestController)
        bpz["ChestStatus"] = "Idle"
    end
end

local function SetAutoSoul(value)                    -- F2208
    if value then
        bpz["SoulStatus"] = "Waiting for souls"
        controllers.SoulController.running = true
        cKb[84](controllers.SoulController, cKb[111])
    else
        controllers.SoulController.running = false
        bmX(controllers.SoulController)
        bpz["SoulStatus"] = "Idle"
    end
end

local function SetLootRange(value)                   -- F2617
    controllers.LootController.range = math.clamp(tonumber(value) or 150, 0, 2000)
    bnc(controllers.LootController)                  -- пересобрать список целей
end

local function SetSoulRange(value)                   -- F4068
    controllers.SoulController.range = math.clamp(tonumber(value) or 250, 0, 2000)
end

return {
    controllers = controllers,
    FEATURES = FEATURES,
    priority = priority,
    TriggerPrompt = TriggerPrompt,
    LootStep = LootStep,
    SoulStep = SoulStep,
    SchematicStep = SchematicStep,
    QuestStep = QuestStep,
    SetAutoLoot = SetAutoLoot,
    SetAutoChest = SetAutoChest,
    SetAutoSoul = SetAutoSoul,
    SetLootRange = SetLootRange,
    SetSoulRange = SetSoulRange,
}

--[[ ============================================================================
  НЕ ДОЧИТАНО (следующий заход) — не выдавать за готовое:
  1. claimable(drop) (состояния S4168…S4184): функция, которую собирает
     cKb[13](fn, 2, cm9); внутри — DropClaimedBy и IsDescendantOf(cKb[132]).
  2. bpb(drop) — позиция дропа; bqd(pos, 0.2, cancel) — «подойти/дотянуться»;
     bmO(controller) (F5074) — «отметить неудачную попытку и снять claim».
  3. Шаг сундука целиком (что выбирает сам сундук: tiers, CHEST_GUARD_RANGE,
     retryAt), начало функции — в ветке cKb[38]/cKb[142].
  4. Схематики bqn(fz, fA) — целиком (F3068 CollectSchematics, F2545 StopSchematics).
  5. Квесты: внутренности F2175(...) у bpn — сбор/сортировка/запуск bnn(...).
  6. Убийство и порог: SetKillThreshold F51, SetChestKillThreshold F6033,
     SetChestInstantKill F2680, SetInstantKill F4760 — как связаны со свингами
     Combat_Service (A3/A5 из трейса).
  ЗАМЕЧАНИЕ ПО ИСХОДНИКУ: в артефакте две параллельные копии этого кода
  (сдвиг ~5.5 тыс. строк: 14014 ↔ 17679, 15938 ↔ ~21500, 23125 ↔ ~33870).
  Логика в них одна, отличаются только имена временных переменных.
============================================================================ ]]
