--[[ ============================================================================
  Ouroboros — подсистема СКИЛЛОВ (A): Auto Skills
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; номера строк — по ouroboros_main_pruned.txt.

  Наблюдения из трейсов (важно для сверки):
    * в трейсах виден ТОЛЬКО путь игрока: SkillController.Attempt_Hold("Dash","S")
      + StopHold("Dash") + сигналы Hold/UnHold/Cancel с мировыми координатами;
    * путь автокаста артефакта другой: asGameScript(SkillRunner.Attempt_Hold, имя, "")
      — второй аргумент пустая строка, а не клавиша. В трейсах он не встречался,
      потому что скиллы не были выбраны/на хотбаре.

  Константы (cKb[141]): CAST_MIN_GAP = 0.2, CAST_GRACE = 6
  Состояние: cKb[77] (таймеры/учёт), cKb[81] (модуль), bno["SkillRunner"] (игра).
============================================================================ ]]

local CAST_MIN_GAP = 0.2      -- cKb[141]["CAST_MIN_GAP"]
local CAST_GRACE   = 6        -- cKb[141]["CAST_GRACE"]

-- ---------------------------------------------------------------------------
-- Состояние подсистемы
-- ---------------------------------------------------------------------------
local skills = {                -- cKb[77] — наблюдаемые поля
    count = 0,                  -- сколько кастов сделано
    skills = nil,               -- список доступных скиллов
    skillsAt = 0,               -- когда список обновлялся
    stall = nil,                -- текст паузы (когда всё на кулдауне)
    stallUntil = 0,
    active = nil,               -- текущая запись каста (bDn)
    -- методы (объявлены ниже): backoff, remaining, held, owns, valid, retire,
    -- release, refused, claim, reset, busy, step
}
local module = { autoSkills = false }   -- cKb[81]

-- ---------------------------------------------------------------------------
-- НАСТРОЙКИ из меню (F-слоты)
-- ---------------------------------------------------------------------------
local function SetAutoSkills(value)                        -- F6333
    module["autoSkills"] = value == true
    skills["reset"]()                                      -- сбросить счётчики/паузы
    bpz["AutoSkillStatus"] = module["autoSkills"] and "Starting" or "Idle"
end

local function SetSkillSelection(selection)                -- F3620
    -- оригинал: cKb[81][<4782>] = boa(selection)
    module["selection"] = boa(selection)
end

local function SetSkillHold(name, value)                   -- F6286
    module["holds"] = module["holds"] or {}
    module["holds"][name] = value == true
end

local function HoldSkills()                                 -- F1669 (getter для UI)
    return module["holds"] or {}
end

local function SkillChoices()                              -- F544
    return bpz["SkillChoices"]
end

local function SetUnlockSkills(value)                      -- F5505
    module["unlockSkills"] = value == true
end

local function SetAutoSkillTree(value)                     -- F2053
    module["autoSkillTree"] = value == true
end

-- ---------------------------------------------------------------------------
-- ЗАПИСЬ КАСТА (строка 16263) и вход в каст
-- ---------------------------------------------------------------------------
local function CastSkill(name, hold, session)              -- начало шага, S16246…
    -- гарды
    if type(bno["SkillRunner"]) ~= "table" then
        bpz["AutoSkillStatus"] = "Skill controller unavailable"
        return false
    end
    if not cKb[118](bno["SkillRunner"]["Attempt_Hold"]) then
        bpz["AutoSkillStatus"] = "Skill controller unavailable"
        return false
    end

    local character = cKb[9]()                              -- bDp
    if not character then return false end
    local lastPerformed = character:GetAttribute("last_performed") or 0   -- bDo

    local record = {                                       -- bDn
        name = name,                                       -- p8
        hold = hold,                                       -- p9
        session = session,                                 -- qa
        character = character,
        expires = os.clock()
                + math.max(hold, lastPerformed)
                + CAST_GRACE,                              -- cKb[141]["CAST_GRACE"]
    }

    skills["active"] = record
    cKb[51]["SkillWork"]["entry"] = record
    bpz["AutoSkillStatus"] = "Casting " .. name

    -- наблюдатель SHC: запоминает контейнер и отпечаток последнего каста
    local function watch()                                 -- bDm
        local shc = record["character"]:FindFirstChild("SHC") or record["character"]
        if not shc then return end
        record["shc"] = shc
        record["stamp"] = shc:GetAttribute("last_performed")
    end
    watch()

    -- РАБОЧИЙ КАСТА (F3374 spawn)
    task.spawn(function()
        local message, code, flag = skills["refused"](name)       -- bDb, bDc, bC9
        local deadline = nil                                       -- bC7
        while true do
            if skills["valid"](record) then
                task.wait(0.05)
            else
                if not skills["owns"](record) then
                    skills["retire"](record)
                    return
                end
                if not skills["claim"](record) then
                    skills["release"](record)
                    return
                end

                skills["count"] = skills["count"] + 1
                skills["backoff"](name, math.max(skills["remaining"](name), CAST_MIN_GAP))

                bpz["AutoSkillStatus"] = "Holding " .. name
                deadline = os.clock() + hold                   -- bC7 = os.clock() + p9

                -- ВОТ ОН, автокаст: второй аргумент — пустая строка
                local ok, err = cKb[123]["asGameScript"](
                    bno["SkillRunner"]["Attempt_Hold"], name, "")
                record["return ed"] = true
                watch()

                if not skills["valid"](record) then
                    skills["release"](record)
                    return
                end
                if not ok then
                    bpz["AutoSkillStatus"] = "Cast error:" .. tostring(err)
                    skills["release"](record)
                    return
                end
            end
        end
    end)

    -- СТОРОЖ ТАЙМАУТА (второй F3374 spawn)
    task.spawn(function()
        while true do
            if cKb[51]["SkillWork"]["entry"] ~= record then
                if not skills["valid"](record) then
                    record["cancelled"] = true
                    skills["release"](record)
                end
                return
            end
            if os.clock() < record["expires"] then
                task.wait(0.05)
            else
                record["cancelled"] = true
                skills["release"](record)
                if bnB() then
                    bpz["AutoSkillStatus"] = "Waiting for unresolved skill " .. name
                end
                return
            end
        end
    end)

    return true
end

-- ---------------------------------------------------------------------------
-- ОСВОБОЖДЕНИЕ СКИЛЛА (cKb[77]["release"], строка 969) — до 3 попыток
-- ---------------------------------------------------------------------------
function skills["release"](record)                          -- cKb[77].release
    if not record then return end
    if record["releasing"] then return end
    if not record["return ed"] then return end
    record["releasing"] = true

    task.spawn(function()
        for attempt = 1, 3 do
            if skills["owns"](record) then
                record["releaseFailed"] = true
                if bnB() then
                    bpz["AutoSkillStatus"] = "Skill release unresolved"
                    return
                end
            end

            local entry = cKb[51]["SkillWork"]["entry"]
            if not skills["owns"](record) then
                if entry == record and cKb[9]() == record["character"] then
                    if bno["SkillRunner"]["HeldSkill"] == record["name"] then
                        bno["SkillRunner"]["HeldSkill"] = nil
                        bno["SkillRunner"]["CurrentMax"] = nil
                    end
                    skills["retire"](record)
                    -- подтверждение: изменился ли last_performed
                    if record["shc"]
                    and record["shc"]:GetAttribute("last_performed") == record["stamp"] then
                        skills["retire"](record)
                    end
                    return
                end
                if cKb[118](bno["SkillRunner"]["StopHold"]) then
                    cKb[123]["asGameScript"](bno["SkillRunner"]["StopHold"], record["name"])
                end
                if not skills["owns"](record) then
                    if cKb[118](bno["SkillRunner"]["ForceCancel"]) then
                        cKb[123]["asGameScript"](bno["SkillRunner"]["ForceCancel"], record["name"])
                    end
                end
            else
                if cKb[118](bno["SkillRunner"]["ForceCancel"]) then
                    cKb[123]["asGameScript"](bno["SkillRunner"]["ForceCancel"], record["name"])
                end
                if not skills["owns"](record) then
                    task.wait(0.1)
                else
                    skills["retire"](record)
                    return
                end
            end
        end
    end)
end

-- ---------------------------------------------------------------------------
-- ШАГ КОНТРОЛЛЕРА СКИЛЛОВ (F434) — что делает Auto Skills каждый интервал (5 с)
-- ---------------------------------------------------------------------------
local function SkillStep(caster)                            -- cKb[77]["step"]
    if skills["busy"]() then
        bnO(caster)
        return true
    end

    if skills["stall"] then
        if os.clock() < skills["stallUntil"] then
            bpz["AutoSkillStatus"] = skills["stall"]
        else
            skills["stall"] = nil
            bpz["AutoSkillStatus"] = string.format(
                "%d cast, all on cooldown", skills["count"])
        end
    end

    if not module["autoSkills"] then return false end

    -- не мешать авто-парированию (пересечение с подсистемой C!)
    local values = cKb[123]["playerValues"]()
    if values and values:FindFirstChild("Blocking") then
        bpz["AutoSkillStatus"] = "Holding off for auto parry"
        return false
    end

    if not skills["skills"] or os.clock() >= skills["skillsAt"] then
        skills["skills"] = cKb[106]()                       -- обновить список скиллов
        skills["skillsAt"] = os.clock() + 0.5
    end

    if #skills["skills"] == 0 then
        bpz["AutoSkillStatus"] = "Waiting for the current skill"
        return true
    end

    -- выбор скилла и запуск CastSkill(...) — см. «не дочитано»
    bnO(caster)
    return true
end

-- ---------------------------------------------------------------------------
-- СБРОС (cKb[77]["reset"], F215) — вспомогательная заглушка под реконструкцию
-- ---------------------------------------------------------------------------
function skills["reset"]()
    skills["count"] = 0
    skills["stall"] = nil
    skills["stallUntil"] = 0
    skills["skills"] = nil
    skills["active"] = nil
end

return {
    state = skills,             -- cKb[77]
    module = module,            -- cKb[81]
    CAST_MIN_GAP = CAST_MIN_GAP,
    CAST_GRACE = CAST_GRACE,
    CastSkill = CastSkill,
    SkillStep = SkillStep,
    SetAutoSkills = SetAutoSkills,
    SetSkillSelection = SetSkillSelection,
    SetSkillHold = SetSkillHold,
    SetUnlockSkills = SetUnlockSkills,
    SetAutoSkillTree = SetAutoSkillTree,
    HoldSkills = HoldSkills,
    SkillChoices = SkillChoices,
}

--[[ ============================================================================
  НЕ ДОЧИТАНО (A):
  1. cKb[77]["valid"] / ["owns"] / ["claim"] / ["refused"] / ["retire"] /
     ["remaining"] / ["backoff"] / ["held"] / ["busy"] — тела (слоты в артефакте
     определены как F-функции, см. строки 964-968 и 3320-3326).
  2. Выбор конкретного скилла внутри SkillStep: cKb[106]() даёт список,
     дальше фильтр по hold-настройкам (SetSkillHold F6286), приоритет и
     bnO(q9)/bny["timing"](q9) — временная логика перед кастом.
  3. Ветка «всё на кулдауне»: cKb[77]["stall"] + stallUntil, взаимодействие
     с bno["CombatPresets"]["slow_walk_duration"].
  4. SkillTree: SetAutoSkillTree F2053, SetSkillNodes F6271, SkillNodes F4215,
     UnlockSkills F5505, RefreshSkillNodes F708 — отдельная ветка (не каст).
  5. Связка с C: скиллы уступают парированию («Holding off for auto parry»),
     а парирование считает окна по свингам Combat_Service (A3/A5 из трейсов).

  Сверка с трейсами: путь автокаста (Attempt_Hold с "" и записью release) в трейсах
  НЕ наблюдался ни разу — только действия игрока (Dash + клавиша). Чтобы поймать
  автокаст, нужен прогон с выбранными скиллами на хотбаре.
============================================================================ ]]
