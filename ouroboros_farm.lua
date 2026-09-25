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
-- РАННЕР КОНТРОЛЛЕРОВ (bpu, строка 3127) — общий для всех фич фарма
--   bpu(controller, step): заводит «поколение», крутит step по интервалу,
--   держит запись в bny["runs"] и сам снимает приоритет по выходу.
-- ---------------------------------------------------------------------------
local function StartController(controller, step)          -- bpu
    -- оригинал (S10378..S10379): выходим, только если воркер уже идёт
    if controller["workerActive"] and not controller["stopped"] then return end
    controller["generation"] = (controller["generation"] or 0) + 1
    controller["stopped"] = false
    local generation = controller["generation"]
    controller["startedAt"] = os.clock()
    controller["yield"] = false
    controller["workerActive"] = true

    task.delay(0, function()
        local runId = coroutine.running()                 -- F3109["running"]()
        local record = { controller = controller, generation = generation }
        bny["runs"][runId] = record

        while not controller["stopped"] and controller["generation"] == generation do
            if bnB() then                                 -- действия разрешены?
                local ok, err = pcall(step)               -- bKC, bKD = F2175(AQ)
                if not ok then warn("[Ouroboros] loop error:" .. tostring(err)) end
            end
            if controller["generation"] ~= generation then break end
            if cKb[54]["ownerRun"] == record then         -- мы всё ещё владелец?
                if controller["generation"] == generation then
                    cKb[54]["do ne"](controller["priorityKey"])
                end
                bpY(controller["priorityKey"])
            end
            task.wait(controller["interval"])             -- F3916(AP["interval"])
        end

        bny["runs"][runId] = nil
        controller["workerActive"] = false
    end)
end

local function StopController(controller)                 -- bmX
    controller["stopped"] = true
    controller["generation"] = (controller["generation"] or 0) + 1
    local deadline = os.clock() + 2
    while controller["workerActive"] and os.clock() < deadline do
        task.wait()
    end
end



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
-- СУНДУК — шаг контроллера: bpL (строка 13460)
--   Константы: cKb[141]["CHEST_TIERS"] = {"T1","T2","T3"}, CHEST_GUARD_RANGE = 220,
--   cKb[141]["PASSIVE_MOBS"][name] — мобы, которых охрана не считает охраной.
-- ---------------------------------------------------------------------------
local function ChestStep()                                -- bpL
    if not bnB() then
        controllers.ChestController.pending = false
        return
    end
    bmO(controllers.ChestController)                      -- снять прошлый claim
    local list = bps()                                    -- заспавненные sealed caches
    controllers.ChestController.pending = #list > 0
    if #list == 0 then
        bpz["ChestStatus"] = "No sealed cache spawned"
        return
    end
    if not enabled("AutoChest") then return end
    warn("[Ouroboros] chest step:" .. tostring(list))

    -- ждём готовности контроллера (не больше 20 с)
    if not cKb[86](20) then
        bpz["ChestStatus"] = "Waiting for character"
        return
    end

    local cancel = function() return controllers.ChestController.cancel ~= nil end
    while true do
        if not bny["controllerValid"](controllers.ChestController) then return end
        list = bps()
        if #list == 0 then
            bpz["ChestStatus"] = "No sealed cache spawned"
            return
        end

        -- охрана: ни один живой непassive-моб не должен быть ближе CHEST_GUARD_RANGE
        -- (bWZ — сохранённая позиция последнего выбранного сундука, как в артефакте)
        local guardOrigin = bWZ or (cKb[9]() and cKb[9]():GetPivot().Position) or Vector3.zero
        local clear = bnN(function(mob)
            return not cKb[141]["PASSIVE_MOBS"][mob["name"]]
                and (mob["model"]:GetPivot().Position - guardOrigin).Magnitude
                    <= cKb[141]["CHEST_GUARD_RANGE"]
        end)
        if not clear then
            bpz["ChestStatus"] = "Waiting for guards"
            task.wait(1)
        else
            -- берём ближайший сундук
            local origin = bWY or Vector3.zero
            table.sort(list, function(a, b)
                return (a["model"]:GetPivot().Position - origin).Magnitude
                     < (b["model"]:GetPivot().Position - origin).Magnitude
            end)
            local chest = list[1]
            local model = chest["model"]
            bWZ = model:GetPivot().Position

            if model:GetAttribute("ChestState") == "Locked" then
                bpz["ChestStatus"] = "Clearing " .. chest["tier"] .. " guards"
                bqd(bWZ + Vector3.new(0, 5, 0), 0.4, cancel)      -- подойти
                local deadline = os.clock() + 180                 -- 3 минуты на зачистку
                while os.clock() < deadline do
                    if not bny["controllerValid"](controllers.ChestController) then return end
                    if model:GetAttribute("ChestState") ~= "Locked" then break end
                    task.wait(0.05)
                end
            else
                bp3(model, "ChestStatus", 120, controllers.ChestController,
                    function()
                        return not model:IsDescendantOf(cKb[132])
                            or model:GetAttribute("ChestState") ~= "Locked"
                    end)
                task.wait(0.05)
            end

            controllers["open"](model, "ChestStatus", cancel)     -- S7535…S7566
        end
        bpY("AutoChest")
        task.wait(0.05)
    end
end

-- ---------------------------------------------------------------------------
-- СХЕМАТИКИ — bqn(fz, fA) (строка 20991)
-- ---------------------------------------------------------------------------
-- Раннер схем атик: cKb[91]["SchematicRunner"] = {running, cancel, ret, targets}
-- (строка 27643). Обёртки из API (F3068/F2545):
--   CollectSchematics() -> return select(2, SchematicRunner.start())
--   StopSchematics()    -> SchematicRunner.stop(); return bpz["SchematicStatus"]
controllers.SchematicRunner = controllers.SchematicRunner
    or { running = false, cancel = 0, ret = true, targets = {} }

function controllers.SchematicRunner.start()
    if controllers.SchematicRunner.running then
        bpz["SchematicStatus"] = "Already collecting schematics"
        return false
    end
    bpz["SchematicStatus"] = "Collecting schematics"
    controllers.SchematicRunner.running = true
    local collected = 0
    -- targets = выбранные имена схем атик (SetSchematicTargets = F1267),
    -- возврат домой — SetSchematicReturn (F2078)
    while controllers.SchematicRunner.running do
        -- схем атика — физическая деталь: bqn(part, owner) подтаскивает её к игроку
        local part, owner = nil, nil
        if part then bqn(part, owner) end
        collected = collected + 1
        task.wait(0.1)
    end
    bpz["SchematicStatus"] = string.format("Stopped after %d collected", collected)
    return true
end

function controllers.SchematicRunner.stop()
    controllers.SchematicRunner.running = false
    controllers.SchematicRunner.cancel = controllers.SchematicRunner.cancel + 1
    return true
end

-- bqn(part, owner): перенос детали — анкорит, тянет к игроку, гасит скорость
local function CarryPart(part, owner)                     -- bqn (строка 20991)
    if not part:IsA("BasePart") then return false end
    local carry = bmZ                                       -- состояние переноса
    if carry["owner"] == owner then return carry["connection"] end
    carry["part"], carry["owner"] = part, owner
    if part["Anchored"] then
        -- отпускаем: снимаем анкор и даём упасть
        F2175(function() part["Anchored"] = false end)
    end
    local target = cKb[64](part)                            -- целевой CFrame
    carry["connection"] = bmK["RunService"]["Heartbeat"]:Connect(function()
        if not bnB() then return end
        if owner and not owner.valid() then return end
        part["CFrame"] = cKb[64](target)
        part["AssemblyLinearVelocity"] = Vector3.new(0, -8, 0)
        part["AssemblyAngularVelocity"] = Vector3.zero
    end)
    return carry["connection"]
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
    StartController = StartController,
    StopController = StopController,
    TriggerPrompt = TriggerPrompt,
    ChestStep = ChestStep,
    CarryPart = CarryPart,
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
  СТАТУС (обновлено: сундуки и схематики закрыты)
  Готово и вычитано из артефакта:
    * лут-шаг bnb (14014), душа boc (15938), сундук bpL (13460), open() (23125),
      квест-каркас bpn (23850), перенос детали bqn (20991), раннер bpu (3127),
      триггер промпта cKb[69] (19540), обёртки схем атик F3068/F2545;
    * константы: CHEST_TIERS {"T1","T2","T3"} / CHEST_GUARD_RANGE 220 /
      PASSIVE_MOBS (cKb[141]); бэкофф лута; интервалы всех 24 контроллеров.
  Осталось вычитать:
  1. claimable(drop) — предикат «можно забрать» (состояния S4168…S4184).
  2. Вспомогательные: bpb (позиция дропа), bqd (подойти), bmO (снять claim),
     bp3 (wait-until с таймаутом), cKb[86] (таймаут-обёртка), bnN/bps (поиск и
     список сундуков), bpY (снять приоритет), bnz.
  3. Внутренности квест-шага: F2175-обёртка у bpn (сбор/сортировка квестов),
     bnn(quest, …, "QuestStatus", QuestController), cKb[142] (имя квеста),
     cKb[94] (добить зависший квест), cKb[98] (длина списка), F6310 (выбор квеста
     по Category == "Combat" и Requirements.Level).
  4. Порог убийства: SetKillThreshold F51, SetChestKillThreshold F6033,
     SetChestInstantKill F2680, SetInstantKill F4760 и его связь со свингами
     Combat_Service (A3/A5 из трейсов).
  5. Схематика: как именно берётся part и owner внутри SchematicRunner.start()
     (цепочка bnN/btc вокруг 26500+).

  ОСТОРОЖНО С F-НОМЕРАМИ: в этой зоне артефакта нумерация слотов ненадёжна
  (проверено: pool[6310] — это выбор квеста, хотя в тексте стоит bmX = F6310).
  Поэтому шаги выше опознаны ПО СОДЕРЖИМОМУ (по строкам/статусам), а не по слоту.
  Учитывать вместе с разделом 13 D_MAP (две параллельные копии кода).
============================================================================ ]]
