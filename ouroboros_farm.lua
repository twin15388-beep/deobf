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
    -- cKb[118]: в этой копии артефакта — проверка type(x)=="function" (F5470);
    -- в другой копии тот же слот = F1959 «скрипт не выгружен». См. ouroboros_core.lua.
    if not cKb[118](fireproximityprompt) then
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
-- ПОДГОТОВКА ПОПЫТКИ — bmO/bp3 (слот F5074; эти два имени в артефакте
-- указывают на один слот, поэтому совмещены)
-- ---------------------------------------------------------------------------
local function BeginAttempt(controller)          -- bmO(controller) / bp3(controller)
    controller["claim"] = nil
    controller["attempt"] = (controller["attempt"] or 0) + 1
    local attempt = controller["attempt"]
    return function()
        return not controller["cancelled"]
           and controller["attempt"] == attempt
           and controller["running"] == true
    end
end

-- ---------------------------------------------------------------------------
-- ОЖИДАНИЕ ГОТОВНОСТИ — cKb[86](seconds)  (строка 3928)
--   Ждёт, пока скрипт загружен (bnB) и запуск контроллера валиден, но не
--   дольше seconds. Возвращает true, если дождались.
-- ---------------------------------------------------------------------------
--   Точная логика (состояния 5671…5679): deadline = os.clock() + (секунды или 20);
--   цикл: не ready() → false; время вышло → вернуть bpm() (Alive: есть Humanoid и
--   корневая часть); bpm() → true; иначе task.wait(0.2) и снова.
local function WaitReady(seconds)                 -- cKb[86]
    local record = bny["runs"][coroutine.running()]
    local function ready()
        if not bnB() then return false end
        if record and not bny["controllerValid"](record["controller"]) then
            return false
        end
        return true
    end
    local function alive()                       -- bpm = пул 796
        local humanoid = cKb[124]()
        if humanoid then return cKb[145]() ~= nil end
        return false
    end
    local deadline = os.clock() + (seconds or 20)
    while true do
        if not ready() then return false end
        if os.clock() >= deadline then return alive() end
        if alive() then return true end
        task.wait(0.2)
    end
end

-- ---------------------------------------------------------------------------
-- ГОТОВНОСТЬ ДРОПА К ЗАХВАТУ — cKb[138] = F2668 (строка 14011)
--   Атрибуты: "DropReservedFor" (строка) и "DropOwnerUserId" (число).
-- ---------------------------------------------------------------------------
local function ClaimReadiness(drop)               -- cKb[138]
    local reserved = drop:GetAttribute("DropReservedFor")
    if type(reserved) ~= "string" then return true end
    local owner = drop:GetAttribute("DropOwnerUserId")
    if type(owner) == "number" and owner ~= cKb[126]["UserId"] then
        return false
    end
    return true
end

-- ---------------------------------------------------------------------------
-- ПРЕДИКАТ «МОЖНО ЗАБИРАТЬ» — состояния S4168…S4184
--   cKb[132] = cloneref(LocalPlayer) => IsDescendantOf(cKb[132]) = «уже у нас».
-- ---------------------------------------------------------------------------
local function Claimable(drop)
    if drop:IsDescendantOf(cKb[132]) then return false end
    local claimedBy = drop:GetAttribute("DropClaimedBy")
    if claimedBy ~= nil and claimedBy ~= cKb[126]["UserId"] then return false end
    return ClaimReadiness(drop)
end

-- ---------------------------------------------------------------------------
-- ПОДОЙТИ К ТОЧКЕ — bqd(position, eps, cancel)  (строка 4018)
--   Композиция отмены вычитана дословно: прерываемся, если not bnB(), или
--   невалиден запуск контроллера, или сработал внешний cancel.
--   Перемещение выполняет арбитр движения bob (token/поколение).
-- ---------------------------------------------------------------------------
local function MoveToTarget(character, position)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid:MoveTo(position) end
end

local function Reach(position, eps, cancel)       -- bqd
    local record = bny["runs"][coroutine.running()]
    local function aborted()
        if not bnB() then return true end
        if record and not bny["controllerValid"](record["controller"]) then return true end
        return cancel and cancel() or false
    end
    local character = cKb[9]()
    if not character then return false end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return false end

    local deadline = os.clock() + 10
    while os.clock() < deadline do
        if aborted() then return false end
        if (root["Position"] - position)["Magnitude"] <= (eps or 0.2) + 0.5 then
            return true
        end
        MoveToTarget(character, position)
        task.wait(0.05)
    end
    return false
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

    -- S4169/S4184: проверка «можно ли забирать»
    if not Claimable(drop) then
        -- S4213: подойти к дропу (смещение вверх на 3)
        local base = drop:IsA("BasePart") and drop
                  or drop:FindFirstChildWhichIsA("BasePart", true)
        if not base then return false end
        if not Reach(base["Position"] + Vector3.new(0, 3, 0), 0.2, cancel) then
            return false                                               -- S4198
        end
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
function controllers.open(chest, statusKey, cancel)
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
-- КВЕСТЫ — шаг QuestController: bpn
--   В копии B — inline (смещение 1 660 803), в копии A слот bpn = пул-функция
--   6279. Рендер: ouroboros_main_pruned.txt, строка 23850.
-- ---------------------------------------------------------------------------
-- Управляющая машина (вход pc=14066, зеркало bMR = 14066 - bMR), 1:1:
--   14066  bMP = not bnB()                     -- модуль выгружен?
--   14060  if bMP -> return
--   14061  bMP = cKb[98](quests) == 0          -- квестов нет -> return
--   14062  cKb[54]["commit"]("AutoQuest"); if not cKb[38]("AutoQuest") -> return
--   14065  bMP, bMQ = pcall(<тело>); bpY("AutoQuest")
--          if not bMP -> warn("[Ouroboros] quest step: " .. tostring(bMQ))
-- Тело pcall (вход pc=3512, зеркало bMx = 3518 - bMx):
--   3512  if not cKb[86](20) -> bpz["QuestStatus"] = "Waiting for character"; return
--   3511  bMq = {}; for D4 in pairs(quests) do bMq[#bMq+1] = D4 end
--         table.sort(bMq); bMr = <аксессор имени>; bMs = cKb[137]()
--         for Ed, Ee in ipairs(bMq) do <машина bMFA, вход 7>; if bMG then break end end
--         bMs = cKb[52]();  bMs -> 3514, иначе 3518
--   3514  bMt = cKb[110](bMs); bpz["QuestStatus"] = "Clearing quest slot"
--         cKb[94](bMr(bMt, bMs)); return
--   3518  bMr = boW();  bMr > 0 -> 3516, иначе 3517
--   3516  cKb[54]["uncommit"]("AutoQuest")
--         bpz["QuestStatus"] = string.format("Quest cooldown %ds", math.ceil(bMr)); return
--   3517  <машина bMFB, вход 4>; cKb[54]["uncommit"]("AutoQuest")
--         bpz["QuestStatus"] = "Cannot take a selected quest"
--
-- Машина bMFA — первая петля по квестам (вход 7), состояния 1:1:
--   7  QuestController.stopped -> 3 (return)
--   18 bMt = cKb[110](bMK); bMp = bMr(bMt, bMK); bMu = bMs
--   10 bMu = bMs:FindFirstChild(bMp)
--   11 bMu -> 20, иначе 13 (пустой квест — дальше)
--   20 bMu, bMw, bMv = bnq(bMK, "QuestStatus", QuestController)
--      bMv (квест снят) -> 2;  bMw (пора сдавать) -> 14;  иначе 17
--   2  bpz["QuestStatus"] = "Dropping stuck " .. cKb[142](bMK); cKb[94](bMp); return
--   14 bpz["QuestStatus"] = "Handing in " .. cKb[142](bMK)
--      bMu = cKb[13](<ждём, пока Holder:FindFirstChild(имя) == nil>, 6)
--      bMu -> 12, иначе 0
--   12 bMt = bMu;  bMt -> 4, иначе 19
--   4  bpz["Quests"] = bpz["Quests"] + 1; bpz["QuestStatus"] = "Finished " .. cKb[142](bMK)
--   5  -> 17 (return)
--   0  bMu = bnn(bMt, bMp, "QuestStatus", QuestController) -> 12
--   19 bMt = not QuestController["yield"];  bMt -> 8, иначе 15
--   8  bMt = not QuestController["stopped"]; -> 15
--   15 bMt -> 16, иначе 21
--   16 cKb[54]["uncommit"]("AutoQuest") -> 21
--   21 bpz["QuestStatus"] = "Cannot hand in " .. cKb[142](bMK); -> 5 (return)
--   13 (пусто -> 9) и 9 — конец итерации;  1 bMG = true (break внешней петли)
--
-- Машина bMFB — петля «взять квест» (вход 4):
--   4  QuestController.stopped -> 6 (return), иначе 8
--   8  bMq = cKb[110](bMO); bMr = bMq;  bMr -> 7, иначе 3
--   7  bMr = bp9(bMq) -> 3
--   3  bMr -> 1, иначе 9 (дальше)
--   1  bpz["QuestStatus"] = "Accepting " .. cKb[142](bMO)
--      bpQ(bMO, QuestController, "QuestStatus") -> 10 (return), иначе 0 -> 9
--   9  -> 2 (конец петли);  5 bMG = true;  2 break;  6/10 return
-- После петли: cKb[54]["uncommit"]("AutoQuest"); "Cannot take a selected quest".
--
-- Константы (проверены по пулу): 4656="QuestStatus", 868="QuestController",
-- 4265="quests", 3464="stopped", 4610="yield", 3287="Quests", 3546="AutoQuest",
-- 5499="Dropping stuck ", 6229="Finished ", 6062="Handing in ",
-- 2414="Cannot hand in ", 4554="Accepting ", 150="Cannot take a selected quest",
-- 3142="Waiting for character", 3184="Clearing quest slot",
-- 5289="Quest cooldown %ds", 6259="[Ouroboros] quest step: ".
-- ---------------------------------------------------------------------------

-- ВАЖНО про слот-карты (проверено 26.09): в артефакте несколько карт слотов.
-- Одна и та же строка кода встречается дважды с ОДИНАКОВЫМИ номерами слотов
-- (сверено: копия @1 192 023 `cKb[8] = function()` и копия @1 660 803 `bpn`),
-- но заголовки сборок привязывают слоты к РАЗНЫМ пул-функциям. Канонической
-- (самосогласованной для этого кода) является карта из заголовка второй сборки:
--   98 → пул 1968 (счётчик), 110 → пул 615 (запись квеста),
--   137 → пул 931 (Quests.Holder), 142 → пул 774 (имя/tostring),
--   94 → пул 2280 (RemoveQuest + 0.5 c), 52 → пул 429 (questString),
--   13 → пул 4633/4512, 86 → ожидание готовности.
-- В первой сборке те же слоты местами указывают на другое (98 → пул 363 —
-- это НЕ счётчик, а отмена контроллера: Ba["cancel"], Ba["generation"],
-- cKb[54]["do ne"]/["uncommit"]). Поэтому реализации ниже выписаны по
-- канонической карте; см. также out/pool_perm.json (перестановка пула) и
-- ROADMAP «Известные ловушки».

-- Счётчик элементов таблицы: cKb[98] = пул 1968 (каноническая карта):
--   local n = 0; for _ in pairs(t) do n = n + 1 end; return n
local function count(container)
    local n = 0
    for _ in pairs(container) do n = n + 1 end
    return n
end

-- Запись квеста: cKb[110] = пул 615 (коп. B) / 5-арг. inline (смещение 2 114 855)
--   bno["Quests"]["Holder"][id]; при отсутствии bno["Quests"] или .Holder
--   вызывается cKb[100]("Quests.Holder") и возвращается nil.
local function QuestData(questId)                     -- cKb[110]
    if type(bno["Quests"]) ~= "table" then
        cKb[100]("Quests.Holder")
        return nil
    end
    if type(bno["Quests"]["Holder"]) ~= "table" then
        cKb[100]("Quests.Holder")
        return nil
    end
    return bno["Quests"]["Holder"][questId]
end

-- Имя квеста или tostring: cKb[142] = пул 774 (коп. B) / 5-арг. inline (2 119 745).
-- Вычитано дословно: bFg = cKb[110](ut); если type(bFg)=="table" и
-- typeof(bFg["QuestInstance"])=="Instance" -> bFg["QuestInstance"]["Name"],
-- иначе tostring(ut).
local function QuestName(questId)                     -- cKb[142]
    local data = QuestData(questId)
    if type(data) == "table" and typeof(data["QuestInstance"]) == "Instance" then
        return data["QuestInstance"]["Name"]
    end
    return tostring(questId)
end

-- Аксессор имени с запасным значением — bMr (состояния 15077…15084):
--   D6 — запись квеста, D7 — запасное имя. D6["QuestInstance"]["Name"] если
--   typeof(...)=="Instance", иначе D7.
local function QuestNameOr(data, fallback)            -- bMr
    if type(data) == "table" and typeof(data["QuestInstance"]) == "Instance" then
        return data["QuestInstance"]["Name"]
    end
    return fallback
end

-- Держатель квестов: cKb[137] = пул 931 (коп. A; в коп. A позже перепривязан
-- к пулу 4555 = LocalPlayer.Character — см. заметку ниже).
-- Пул 931: btr = cKb[131]() -> :FindFirstChild("Quests") -> :FindFirstChild("Holder"),
-- с проверками на nil на каждом шаге.
local function QuestHolder()                          -- cKb[137]
    local node = cKb[131]()                           -- Utility.GetData(LocalPlayer)
    if not node then return nil end
    local quests = node:FindFirstChild("Quests")
    if not quests then return nil end
    return quests:FindFirstChild("Holder")
end

-- Снять квест: cKb[94] = пул 2280 (коп. B; в коп. A — inline, смещение 1 124 747).
-- Вычитано дословно: bn8(пул[1299], name); task.wait(0.5).
--   пул[1299] — строка "RemoveQuest" ПОСЛЕ перестановки пула (до неё — 527),
--   bn8 = отправка сигнала на сервер (см. ouroboros_core.lua).
local function QuestRemove(playerQuestName)           -- cKb[94]
    bn8("RemoveQuest", playerQuestName)
    task.wait(0.5)
end

-- Кулдаун квестов — boW = пул 1412 (состояния 14757…14778). Вычитано дословно:
--   если type(bno["Quests"]) ~= "table" -> 0
--   bLz = cKb[131]() (Utility.GetData(LocalPlayer)); нет -> 0
--   bLz = bLz:FindFirstChild("Quests"); нет -> 0
--   bLz = bLz:FindFirstChild("LastTime"); нет -> 0
--   если type(bno["Utility"]) ~= "table" -> 0
--   если cKb[118](bno["Utility"]["Tick"]) == false -> 0
--   ok, tick = cKb[119](bno["Utility"]["Tick"]); если not ok -> 0
--   если not tonumber(tick) -> 0
--   cd = tonumber(bno["Quests"]["QuestCD"]) или 30
--   return math.max(0, cd - (tick - LastTime.Value))
local function QuestCooldown()                        -- boW
    if type(bno["Quests"]) ~= "table" then return 0 end
    local node = cKb[131]()
    if not node then return 0 end
    node = node:FindFirstChild("Quests")
    if not node then return 0 end
    local stamp = node:FindFirstChild("LastTime")
    if not stamp then return 0 end
    if type(bno["Utility"]) ~= "table" then return 0 end
    if not cKb[118](bno["Utility"]["Tick"]) then return 0 end
    local ok, tick = cKb[119](bno["Utility"]["Tick"])
    if not ok or not tonumber(tick) then return 0 end
    local cooldown = tonumber(bno["Quests"]["QuestCD"]) or 30
    return math.max(0, cooldown - (tick - stamp["Value"]))
end

-- Квест, лежащий в слоте — cKb[52] = пул 429 (коп. B; в коп. A — inline, 1 278 022).
-- Вычитано дословно: bFM = cKb[3](); bFN = bFM[1]; если nil -> nil;
-- иначе bFN[1]["questString"].
local function QuestSlotBusy()                        -- cKb[52]
    local list = cKb[3]()
    local first = list and list[1]
    if not first then return nil end
    return first[1]["questString"]
end

-- Ожидание условия с таймаутом — cKb[13] = пул 4633 (коп. A) / пул 4512 (коп. B).
-- Контракт вычитан из вызова: cKb[13](function() ... end, 6) -> истина, если
-- условие выполнилось до истечения таймаута (тело пула не читано).
local function WaitFor(condition, seconds)            -- cKb[13]
    return cKb[13](condition, seconds)
end

-- Проверка «квест можно взять» — bp9. В артефакте два разных тела на один слот:
--   коп. A: bp9 = F6275 (строка 11469 рендера) — перебирает vs:GetChildren(),
--           берёт код задачи через cKb[76], требует наличие "Code"."Value"
--           у каждой задачи; nil, если хоть одна не готова.
--   коп. B: bp9 = F5388 (строка 37281) — требования по уровню/расе:
--           bFQ = cKb[48]() (уровень), tonumber(bFP["Level"]), bFP["MaxLevel"],
--           type(bFP["Race"]) == "table".
-- Какое тело действует в момент вызова, решает порядок перепривязки слотов в
-- машине артефакта; поэтому вызов оставлен слоту (не дочитано до конца).
local function QuestAcceptable(data)                  -- bp9
    return bp9(data)
end

-- Пробежка по задачам квеста — bnq (коп. A, смещение 1 445 494) / bpV (коп. B,
-- смещение 1 678 198) — возвращает три значения: (ok, wantHandIn, dropped).
-- Тело — отдельная подсистема «выполнение задания», здесь не читано.
local function QuestRunTask(questId, statusKey, controller)   -- bnq / bpV
    return bnq(questId, statusKey, controller)
end

-- Взять квест — bpQ (смещение 2 239 797 в коп. B). Возвращает истину, если квест
-- принят (тело не читано).
local function QuestTake(questId, controller, statusKey)      -- bpQ
    return bpQ(questId, controller, statusKey)
end

-- Ожидание статуса квеста — bnn(a, b, "QuestStatus", controller) (см. заметку
-- про уровень-ветку: bpz["LevelStatus"] = "Waiting for %d points").
local function QuestStatusWait(alive, name, statusKey, controller)   -- bnn
    return bnn(alive, name, statusKey, controller)
end

-- Шаг квеста: bpn()
local function QuestStep()
    -- 14066 / 14060 / 14061
    if not bnB() then return end                                   -- выгружен?
    if count(controllers.QuestController["quests"]) == 0 then return end
    -- 14062
    priority.commit("AutoQuest")
    if not enabled("AutoQuest") then return end
    -- 14065
    local ok, err = pcall(function()
        -- 3512
        if not WaitReady(20) then                                  -- cKb[86](20)
            bpz["QuestStatus"] = "Waiting for character"
            return
        end
        -- 3511
        local list = {}
        for _, quest in pairs(controllers.QuestController["quests"]) do
            list[#list + 1] = quest
        end
        table.sort(list)
        local holder = QuestHolder()                               -- cKb[137]()

        local stop = false
        for _, quest in ipairs(list) do
            -- машина bMFA (вход 7)
            if not controllers.QuestController["stopped"] then     -- 7
                local data = QuestData(quest)                      -- 18
                local name = QuestNameOr(data, quest)
                local present = holder and holder:FindFirstChild(name) or nil  -- 10/11
                if present then                                    -- 20
                    if not controllers.QuestController["yield"] then -- 19
                        local _, wantHandIn, dropped = QuestRunTask(quest, "QuestStatus",
                                                                    controllers.QuestController)
                        if dropped then                            -- 2
                            bpz["QuestStatus"] = "Dropping stuck " .. QuestName(quest)
                            QuestRemove(name)
                            return
                        end
                        if wantHandIn then                         -- 14
                            bpz["QuestStatus"] = "Handing in " .. QuestName(quest)
                            local gone = WaitFor(function()        -- 4278-замыкание
                                local holderNow = QuestHolder()
                                return holderNow == nil
                                    or holderNow:FindFirstChild(name) == nil
                            end, 6)
                            if gone then                           -- 12 -> 4
                                bpz["Quests"] = bpz["Quests"] + 1
                                bpz["QuestStatus"] = "Finished " .. QuestName(quest)
                                return                             -- 5 -> 17
                            end
                            -- 0 -> 12: ждём статус, если не сдался
                            QuestStatusWait(false, name, "QuestStatus",
                                            controllers.QuestController)
                            -- 19/8/15/16/21
                            if not controllers.QuestController["stopped"] then
                                priority.uncommit("AutoQuest")     -- 16
                            end
                            bpz["QuestStatus"] = "Cannot hand in " .. QuestName(quest)
                            return
                        end
                        return                                     -- 17 (нечего делать)
                    end
                end
                -- 13 -> 9: пустой слот, идём к следующему квесту
            end
            if stop then break end
        end

        -- 3511 (хвост): слот занят?
        local busy = QuestSlotBusy()                               -- cKb[52]()
        if busy then                                               -- 3514
            local data = QuestData(busy)
            bpz["QuestStatus"] = "Clearing quest slot"
            QuestRemove(QuestNameOr(data, busy))
            return
        end
        -- 3518
        local cooldown = QuestCooldown()                           -- boW()
        if cooldown > 0 then                                       -- 3516
            priority.uncommit("AutoQuest")
            bpz["QuestStatus"] = string.format("Quest cooldown %ds", math.ceil(cooldown))
            return
        end
        -- 3517: пробуем взять квест
        for _, quest in ipairs(list) do
            local data = QuestData(quest)                          -- 8
            if data and QuestAcceptable(data) then                 -- 7/3
                bpz["QuestStatus"] = "Accepting " .. QuestName(quest)  -- 1
                if QuestTake(quest, controllers.QuestController, "QuestStatus") then
                    return                                         -- 10
                end
            end
        end
        priority.uncommit("AutoQuest")
        bpz["QuestStatus"] = "Cannot take a selected quest"
    end)
    bpY("AutoQuest")                                               -- снять заявку
    if not ok then
        warn("[Ouroboros] quest step: " .. tostring(err))
    end
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
    -- квест-хелперы (используются единой сборкой и тестами)
    Count = count,
    BeginAttempt = BeginAttempt,
    ClaimReadiness = ClaimReadiness,
    Claimable = Claimable,
    Reach = Reach,
    MoveToTarget = MoveToTarget,
    QuestData = QuestData,
    QuestName = QuestName,
    QuestNameOr = QuestNameOr,
    QuestHolder = QuestHolder,
    QuestRemove = QuestRemove,
    QuestCooldown = QuestCooldown,
    QuestSlotBusy = QuestSlotBusy,
    QuestReady = QuestReady,
    QuestRunTask = QuestRunTask,
    QuestTake = QuestTake,
    QuestStatusSync = QuestStatusSync,
    WaitReady = WaitReady,
    SetAutoLoot = SetAutoLoot,
    SetAutoChest = SetAutoChest,
    SetAutoSoul = SetAutoSoul,
    SetLootRange = SetLootRange,
    SetSoulRange = SetSoulRange,
}

--[[ ============================================================================
  СТАТУС: лут-шаг больше не содержит заглушек.

  ЗАКРЫТО (вычитано из артефакта):
    ClaimReadiness — F2668: атрибуты "DropReservedFor" (строка) и
      "DropOwnerUserId" (число); чужой владелец → нельзя.
    Claimable — S4168…S4184: не «уже у нас» + DropClaimedBy пустой или наш.
    WaitReady — cKb[86](секунды), строка 3928.
    BeginAttempt — bmO/bp3 = слот F5074 (снять прошлый claim + предикат).
    Reach — bqd(position, eps, cancel), строка 4018 (композиция отмены дословно).
    cKb[145](arg) — переключатель CanCollide (проход сквозь препятствия) с
      восстановлением прежних значений.

  ЗАКРЫТО ПО КВЕСТАМ (шаг bpn, рендер строка 23850; коп. B — inline 1 660 803,
  коп. A — пул-функция 6279):
    Управляющая машина 14066→14060→14061→14062→14065 (выгружен / пустой список /
    commit+enabled / pcall+bpY+warn) — расписана в шапке квест-секции.
    Тело pcall 3512→3511→3514/3518→3516/3517: ожидание персонажа cKb[86](20),
    сбор квестов (pairs → bMq, table.sort), cKb[137]() = Quests.Holder, две
    вложенные машины bMF (вход 7 — сопровождение квеста; вход 4 — взятие).
    Хелперы вычитаны дословно: count (пул 363/1968), QuestData (пул 615),
    QuestName/QuestNameOr (пул 774 / состояния 15077…15084),
    QuestHolder (пул 931), QuestRemove (пул 2280: bn8("RemoveQuest", имя) +
    task.wait(0.5); пул[1299] — после перестановки пула), QuestCooldown
    (пул 1412: math.max(0, QuestCD∨30 − (Tick − LastTime.Value))),
    QuestSlotBusy (пул 429: cKb[3]()[1][1]["questString"]).

  ОСТАЛОСЬ (движок перемещения, не фарм):
    * bob — арбитр движения (token/поколение), целиком не вычитан;
    * трасса ходьбы/твина (MovementMode, TweenSpeed) — отдельная подсистема;
    * cKb[59]() — источник списка регионов (для MobList в ouroboros_combat.lua).
    * квест-хелперы bnq/bpV (тело «выполнения задания»), bpQ (взятие квеста) и
      cKb[13] (пул 4633/4512, ожидание условия с таймаутом) — оставлены вызовами
      слота: их тела целиком не читаны;
    * bp9 — на один слот два разных тела (F6275 задачи-готовность / F5388
      требования по уровню-расе); какой действует в момент вызова, зависит от
      порядка перепривязки слотов в машине артефакта.

  ПРО КОПИИ: bmO/bp3 в двух копиях артефакта указывают на РАЗНЫЕ функции;
  везде используется первая копия, как и в остальных модулях.
============================================================================ ]]
