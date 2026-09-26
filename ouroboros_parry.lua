--[[ ============================================================================
  Ouroboros — подсистема ЗАЩИТЫ (Auto Parry V3), реконструкция 1:1
  ----------------------------------------------------------------------------
  Источник:      ouroboros_ps2 (1).luau, пул cKb[136]
  Инструменты:   tools/deflatten.py --pool N, tools/prune_junk.py
  Трейсы-эталоны: data/traces/2026-09-25-autolevel-loot-parry.txt
                  data/traces/2026-09-25-parry-skills-digest.txt

  Подтверждено трейсами:
    * сигнал парирования — bn8("server_skill_controller_signaler", "Blocking",
                               "Hold", Vector3.zero)      (F3022 = Vector3)
      в трейсе A4 = Vector3(0.00,0.00,0.00) — совпадает;
    * "Keep Blocking After A Parry" (bnl["hold"]) меняет удержание с ~0.19 с
      на ровно 1.5 с:  cf2 = cfZ + 1.5  (в трейсе 14 пар по 1.501..1.510 с).

  Константы (cKb[61], строка 35139):
    windowNpc = 0.25   окно идеального блока по мобу
    windowPvp = 0.1    окно по игроку
    bias      = 0.25   сдвиг раннего нажатия
    relock    = 1      пауза после блока
    defaultRtt= 0.09   запас на пинг
    reachPad  = 8      запас дистанции
    closingPad= 14
    facingMin = -0.35  минимальная «лицом к цели»
    margin    = 0.005
    acknowledgement = 2   сколько ждать подтверждения от сервера
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Отправка сигналов (общий с ouroboros_equip.lua; оригинал bn8 = F651)
-- ---------------------------------------------------------------------------
local function Signal(name, ...)
    if type(bno["SignalEvent"]) ~= "table"
            or not cKb[118](bno["SignalEvent"]["ToServer"]) then
        cKb[100]("SignalEvent.ToServer")
        return false
    end
    return pcall(bno["SignalEvent"]["ToServer"], name, ...)
end

-- ---------------------------------------------------------------------------
-- Состояние подсистемы (bnl, строка 38242)
-- ---------------------------------------------------------------------------
local parry = {
    on = false, npc = true, pvp = true, mitigate = true, hold = false,
    lead = 0, radius = 40, generation = 0,
    entries = {},                   -- bm0: входы блоков (пары «инфо → состояние»)
    blockEntry = nil,               -- bnl["blockEntry"]: вход, по которому идёт блок
    stats = { fired = 0, locked = 0, late = 0, missed = 0, cancelled = 0 },
}
-- bnl == cKb[51]["BlockWork"]: в артефакте это одна и та же таблица.
-- Ссылку ставит сборка (tools/build_recon.py) после создания cKb[51].

-- bnl["in validate"] = F4744 (S2928): пересоздать набор целей блока.
parry["in validate"] = function()
    parry.generation = parry.generation + 1        -- bnl["generation"] += 1
    table.clear(parry.entries)                     -- table.clear(bm0)
    -- TODO(F4744): хвост «for x in pairs(cKb[50]) do cKb[14](x) end» не вычитан
end

-- bnl["reset"] = F6287 (S2928): обнулить счётчики блока
parry["reset"] = function()
    parry["stats"] = { fired = 0, locked = 0, late = 0, missed = 0, cancelled = 0 }
end

local CONFIG = {
    windowNpc = 0.25, windowPvp = 0.1, bias = 0.25, relock = 1,
    defaultRtt = 0.09, reachPad = 8, closingPad = 14, facingMin = -0.35,
    margin = 0.005, acknowledgement = 2,
}

-- ---------------------------------------------------------------------------
-- Настройки из меню                                             [F3938 и др.]
-- ---------------------------------------------------------------------------
local function SetAutoParry(value)                  -- F3938
    if parry.on == (value == true) then return end
    parry["in validate"]()                          -- перечитать значения слайдеров
    parry.on = value == true
    if not parry.on then
        bpz["ParryStatus"] = "Off"
    end
end

local function SetParryHold(value)                  -- F6034
    if not parry then return end
    parry["in validate"]()
    parry.hold = value == true
end

local function SetParryLead(value)                  -- F2812
    if not parry then return end
    parry["in validate"]()
    parry.lead = math.clamp(tonumber(value), -120, 120) / 1000    -- мс -> с
end

local function SetParryRadius(value)                -- F1736
    if not parry then return end
    parry["in validate"]()
    parry.radius = math.clamp(tonumber(value) or 40, 10, 150)
end

-- ---------------------------------------------------------------------------
-- Гейт: можно ли сейчас вообще действовать (bnB = F1959)
-- ---------------------------------------------------------------------------
-- local function CanAct() return bnB() end

-- ---------------------------------------------------------------------------
-- Открытие блока: ждём подтверждения сервера и держим, пока нужно  [S1852..]
-- ---------------------------------------------------------------------------
local function BeginBlock(target)                   -- entry-машина вокруг S1854
    local character = cKb[9]()                      -- локальный персонаж
    local blocking = target and target:FindFirstChild("Blocking")
    if not blocking then return false end           -- S1853 -> S1846

    local entry = {                                  -- cfX (S1854)
        character = character,
        phase = "awaiting",
        keep = parry.hold,
        lastHit = nil,
        releaseAt = nil,
        deadline = os.clock() + CONFIG.acknowledgement,
        releaseRequested = false,
    }
    parry["blockEntry"] = entry
    cKb[51]["BlockWork"]["entry"] = entry

    -- опрос входа на каждом кадре: boA = F5058, bo_ = F2854
    entry["poll"] = function()
        return BlockTick(entry)                     -- boA(entry)
    end
    entry["connection"] = game:GetService("RunService").Heartbeat:Connect(function()
        BlockRelease(entry, true)                   -- bo_(entry, true)
        if bnB() then
            local ok, err = pcall(BlockTick, entry)
            if not ok then
                cKb[100]("auto parry release:" .. tostring(err))
            end
        end
    end)

    local acknowledged = Signal("server_skill_controller_signaler", "Blocking",
                                "Hold", Vector3.zero)
    if not acknowledged then
        -- сервер не подтвердил: вход не создаём
        return false
    end

    -- если включён hold — держим ровно 1.5 с (подтверждено трейсом: 1.501..1.510)
    if parry.hold then
        entry.releaseAt = os.clock() + 1.5          -- cf2 = cfZ + 1.5
    end
    return true
end

-- ---------------------------------------------------------------------------
-- Один тик блока (boA = F5058): здоровье, значение Blocking, relock   [S14886..]
-- ---------------------------------------------------------------------------
function BlockTick(entry)                           -- F5058
    local character = cKb[9]()
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return "block" end         -- S14892/S14893

    local blocking = cKb[126]:FindFirstChild("Blocking")   -- S14886
    if not blocking then return "block" end

    if blocking["Value"] <= 0 then                  -- S14890
        return "block"
    end
    if humanoid["Health"] <= 0 then                 -- S14895
        return "block"
    end

    local last, now = entry.lastRelease, os.clock()
    if last and now - last < CONFIG.relock then     -- S14894
        return "locked"
    end

    -- S14889: опрос игровой утилиты Tick() под pcall
    local ok, tick = pcall(function() return bno["Utility"]["Tick"]() end)
    if ok and not cKb[122](tick) then
        return tick["Value"] and "block" or nil
    end
    return nil
end

-- ---------------------------------------------------------------------------
-- Отпускание блока (bo_ = F2854): UnHold (+ Cancel, если просили)     [S1845..]
-- ---------------------------------------------------------------------------
function BlockRelease(entry, force)
    if entry.phase == "done" then return true end
    if force then
        entry.releaseRequested = true               -- S1850
        return entry.phase == "awaiting"
    end
    if not bnB() then return false end              -- S1848

    Signal("server_skill_controller_signaler", "Blocking", "UnHold", Vector3.zero)
    local keep = entry.keep
    if entry.releaseRequested then
        -- S1857: если удерживать больше не нужно — снять и отменить
        Signal("server_skill_controller_signaler", "Blocking", "Cancel", Vector3.zero)
    end
    entry.phase = "done"
    return true
end

-- ---------------------------------------------------------------------------
-- bnl["step"] = F288, строка 38250: надзор за активным входом блока
--   Порядок ветвей восстановлен по состояниям S9478..S9513 (entry=9479).
--   Тексты bpz["ParryStatus"] — дословно из артефакта.
--   TODO(F288): вызов bom() в S9508 и точные переходы двух «непрозрачных»
--   развилок (рендер свернул их в константы) — уточнить сырым телом пула.
-- ---------------------------------------------------------------------------
local function BlockWorkStep()                       -- F288
    local work = cKb[51]["BlockWork"]
    local entry = work["entry"]

    if entry and cKb[118](entry["poll"]) then        -- S9479 -> S9494
        entry["poll"]()                              -- S9511: опрос входа
        entry = work["entry"]                        -- S9508: перечитать
    end

    if entry and entry["character"] ~= cKb[9]() then -- S9501: вход от другого персонажа
        if entry["connection"] then                  -- S9493
            entry["connection"]:Disconnect()         -- S9485
        end
        if work["entry"] == entry then               -- S9509
            work["entry"] = nil                      -- S9484
        end
        entry = work["entry"]
    end

    if not entry then                                -- S9504
        if not parry["on"] then
            bpz["ParryStatus"] = "Off"               -- S9497
            return
        end
        if not cKb[17]() then                        -- S9487: боевые пресеты доступны?
            bpz["ParryStatus"] = "Combat presets unavailable"   -- S9491
            return
        end
        return                                       -- входа нет — докладывать нечего
    end

    if entry["phase"] == "boxFill" then              -- S9490
        bpz["ParryStatus"] = "Block acknowledgement unresolved"          -- S9481
    elseif entry ~= parry["blockEntry"] then         -- S9486
        bpz["ParryStatus"] = "Waiting for previous block release"        -- S9505
    elseif entry["phase"] == "releasing" then        -- S9478
        bpz["ParryStatus"] = "Waiting for block release"                 -- S9483
    else
        local s = parry["stats"]                     -- S9496
        bpz["ParryStatus"] = string.format(
            "%d attempts, %d blocks, %d missed, %d cancelled",
            s["fired"], s["locked"], s["missed"], s["cancelled"])
    end
end
parry["step"] = BlockWorkStep

-- ---------------------------------------------------------------------------
-- cKb[65] = F3871, строка ~17280: планировщик блоков (перебор bm0)
--   Известное: перебор pairs(bm0); пропуск невалидных; счётчики
--     bnl["stats"]["missed"] (просрочен latest), ["fired"] (ставим блок),
--     ["locked"] (mitigate), через bmL(entry, bool); проверки
--     cKb[58](entry), cKb[128](model, reach, cKb[61]["reachPad"], true),
--     cKb[41](model) -> "block"/"none", cKb[143](protectUntil).
--   Здесь — каркас: опрос всех входов; сами окна доделываются в следующем заходе.
-- ---------------------------------------------------------------------------
local function ParryScheduler()                      -- cKb[65] (F3871)
    if not bnB() then return end                     -- S373/S361/S385 (bnl["on"])
    if not parry["on"] then return end

    local now = os.clock()
    for _, entry in pairs(parry.entries) do
        if cKb[118](entry["poll"]) then
            entry["poll"]()
        end
        local latest = entry["latest"]
        if latest and now > latest then              -- S371/S378: просрочен
            local stats = parry["stats"]
            stats["missed"] = stats["missed"] + 1    -- S372/S382
            entry["poll"] = entry["poll"] or function() end
        end
    end
end

-- bnl, cKb[58] = F4381: годен ли вход блока (есть модель с Humanoid и т.п.)
-- TODO(F4381): точное тело (cgx:FindFirstChildOfClass(...) + проверки модели)
function EntryValid(entry)
    if type(entry) ~= "table" then return false end
    local model = entry["model"]
    if typeof(model) ~= "Instance" then return false end
    return model:FindFirstChildOfClass("Humanoid") ~= nil
end

-- bnl-обёртка Heartbeat: F4910 (S2928). Флаг bn9 — защита от повторного входа.
local schedulerReentrant = false                     -- bn9
local function ParrySchedulerTick()                  -- F4910
    if schedulerReentrant then return end            -- S792
    schedulerReentrant = true
    local ok, err = pcall(ParryScheduler)            -- F2175(cKb[65])
    schedulerReentrant = false                       -- S787
    if not ok and bnB() then                         -- S787/S789/S793
        cKb[100]("auto parry scheduler:" .. tostring(err))   -- S788
    end
end

local schedulerConnection = nil
local function StartParryScheduler()                 -- S2928
    if schedulerConnection then return schedulerConnection end
    parry["in validate"] = parry["in validate"] or function() end
    schedulerConnection = game:GetService("RunService").Heartbeat:Connect(ParrySchedulerTick)
    return schedulerConnection
end

-- ---------------------------------------------------------------------------
-- Кнопка «Reset Counters»                                        [F5094]
-- ---------------------------------------------------------------------------
local function ResetParryStats()                    -- F5094
    for key in pairs(parry.stats) do parry.stats[key] = 0 end
end

return {
    SetAutoParry = SetAutoParry,
    SetParryHold = SetParryHold,
    SetParryLead = SetParryLead,
    SetParryRadius = SetParryRadius,
    BeginBlock = BeginBlock,
    BlockTick = BlockTick,
    BlockRelease = BlockRelease,
    ResetParryStats = ResetParryStats,
    BlockWorkStep = BlockWorkStep,
    EntryValid = EntryValid,
    Scheduler = ParryScheduler,
    SchedulerTick = ParrySchedulerTick,
    StartScheduler = StartParryScheduler,
    state = parry,
    CONFIG = CONFIG,
}

--[[ ============================================================================
  ЕЩЁ НЕ ДОЧИТАНО В АРТЕФАКТЕ (следующий заход):
    * выбор цели: радиус parry.radius, facingMin, reachPad/closingPad, отбор по
      bnl["npc"] / bnl["pvp"] (мобы против игроков);
    * собственно расчёт момента: windowNpc/windowPvp + bias + defaultRtt + lead;
    * ветка mitigate (ставить обычный блок, когда окно недоступно) и relock;
    * счётчики stats (fired/locked/late/missed/cancelled) и вывод ParryStatus;
    * обработка входящего свинга Combat_Service (A3=1, A5=0.13 — замах).
  Пока это помечено как «не дочитано» — не выдаю за готовое.
============================================================================ ]]
