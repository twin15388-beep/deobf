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
    stats = { fired = 0, locked = 0, late = 0, missed = 0, cancelled = 0 },
}

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
