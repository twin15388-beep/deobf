--[[ ============================================================================
  Ouroboros — БОЕВЫЕ ТВИКИ и ПОРОГИ УБИЙСТВА (пересечение B/C/D)
  ----------------------------------------------------------------------------
  Источник: ouroboros_ps2 (1).luau; строки — по ouroboros_main_pruned.txt.

  ГЛАВНЫЙ ОТВЕТ ПРО СВИНГИ:
    Сигнала "Combat_Service" в артефакте НЕТ НИ ОДНОГО (проверено: 0 вхождений
    в оригинале и 0 в пуле). Значит строки Combat_Service/Combat с A3=1..5 и
    A5=0.13/0.04 из трейсов — это САМА ИГРА (её собственный ремоут), а не
    Ouroboros. Рекордер видел их, потому что хукал SignalEvent.ToServer целиком.
    Ouroboros же в бой влезает иначе: пишет в игровые таблицы
    CombatInputs / SkillWork / BlockWork и читает bno["CombatPresets"],
    bno["CombatSkills"].
============================================================================ ]]

-- ---------------------------------------------------------------------------
-- Таблица твиков (cKb[99]["tweaks"], строка 37249) с точными дефолтами
-- ---------------------------------------------------------------------------
local tweaks = {
    noStun = true,
    noRagdoll = false,
    instantKill = false,
    killThreshold = 10,
    chestKill = false,
    chestKillThreshold = 10,
    infStamina = false,
    infClimb = false,
    infHorse = false,
    noDrown = false,
    noDashCd = false,
    noSun = false,
    alwaysRun = false,
    ownership = false,
    ownershipRange = 250,
    [8562344] = false,          -- ещё один безымянный флаг (в артефакте — число)
}
-- В коде ниже таблица встречается как cKb[72] (строка 32666: cKb[72] = cKb[99]["tweaks"])
-- и как bop (строка 23692).

-- ---------------------------------------------------------------------------
-- Настройки из меню (F-слоты) — все пишут в ту же таблицу
-- ---------------------------------------------------------------------------
local function SetKillThreshold(value)          -- F51
    tweaks["killThreshold"] = math.clamp(tonumber(value) or 10, 0, 100)
end

local function SetChestKillThreshold(value)     -- F6033
    tweaks["chestKillThreshold"] = math.clamp(tonumber(value) or 10, 0, 100)
end

local function SetInstantKill(value)            -- F4760
    tweaks["instantKill"] = value == true
end

local function SetChestInstantKill(value)       -- F2680
    tweaks["chestKill"] = value == true
end

local function SetNoStun(value)       tweaks["noStun"] = value == true end        -- F5991
local function SetNoRagdoll(value)    tweaks["noRagdoll"] = value == true end     -- F6168
local function SetNoAttackSlowdown(value) tweaks["noAttackSlowdown"] = value == true end -- F5934
local function SetNoDashCooldown(value)   tweaks["noDashCd"] = value == true end  -- F734
local function SetNoDrown(value)      tweaks["noDrown"] = value == true end       -- F5927
local function SetInfiniteStamina(value)  tweaks["infStamina"] = value == true end-- F4483
local function SetInfiniteClimb(value)    tweaks["infClimb"] = value == true end  -- F2327
local function SetInfiniteHorseStamina(value) tweaks["infHorse"] = value == true end -- F787
local function SetAlwaysRun(value)    tweaks["alwaysRun"] = value == true end     -- F2206
local function SetDisableShiftLock(value) tweaks["shiftLock"] = value == true end -- F4303
local function SetNoSunDamage(value)  tweaks["noSun"] = value == true end         -- F127
local function SetPrivateOwner(value) tweaks["privateOwner"] = value end          -- F944

local function SetOwnershipRange(value)         -- F841
    tweaks["ownershipRange"] = math.clamp(tonumber(value) or 250, 50, 2000)
end

local function SetOwnershipViewer(value)        -- F3137
    tweaks["viewer"] = value
end

-- ---------------------------------------------------------------------------
-- META-ПОРОГ: 1 - порог/100. 10% -> 0.9, 0% -> 1.0, 100% -> 0
-- Убиваем, когда Health <= MaxHealth * meta.
-- То есть слайдер = «сколько процентов здоровья должно быть снято до казни»:
--   0   -> убивает сразу (Health <= MaxHealth),
--   10  -> когда снято 10% (по умолчанию),
--   100 -> уже мёртвых (по факту никогда).
-- ---------------------------------------------------------------------------
local function MetaFor(threshold)
    return 1 - math.clamp(threshold or 0, 0, 100) / 100
end

-- ---------------------------------------------------------------------------
-- INSTANT KILL — bpX (строка 733), вызывается из анти-АФК тика
-- ---------------------------------------------------------------------------
local function InstantKillStep(mobs)                  -- bpX
    if not tweaks["instantKill"] then return end      -- S5529
    local meta = MetaFor(tweaks["killThreshold"])     -- cbM
    for _, entry in ipairs(mobs()) do                 -- boo() — список мобов
        local model = entry["model"]
        local humanoid = entry["humanoid"]
        if humanoid and humanoid["Serpent"] > 0                  -- MaxHealth в атрибуте Serpent
        and humanoid["Health"] <= humanoid["Serpent"] * meta
        and (model:FindFirstChild("HumanoidRootPart") or model["PrimaryPart"])
        and model[1] and model["ReceiveAge"] == 0 then           -- только что появившийся
            task.defer(function() humanoid["Health"] = 0 end)    -- F2175(...)
            break
        end
    end
end

-- ---------------------------------------------------------------------------
-- CHEST KILL — boZ (строка 813), тоже из анти-АФК тика
--   Работает только когда идёт авто-открытие сундуков и есть ЗАПЕРТЫЕ сундуки;
--   валит охрану рядом с ними (CHEST_GUARD_RANGE = 220) по своему порогу.
-- ---------------------------------------------------------------------------
local function ChestKillStep(mobs, chestList)         -- boZ
    if not tweaks["chestKill"] then return end                  -- S7381
    if not cKb[91]["ChestController"]["running"] then return end-- S7387
    if cKb[91]["ChestController"]["stopped"] then return end    -- S7388

    local locked = {}                                            -- cbX
    for _, chest in ipairs(chestList()) do                       -- bps() — sealed caches
        if chest["model"]:GetAttribute("ChestState") == "Locked" then
            locked[#locked + 1] = chest["model"]:GetPivot().Position
        end
    end
    if #locked == 0 then return end

    local meta = MetaFor(tweaks["chestKillThreshold"])           -- cbY
    for _, entry in ipairs(mobs()) do
        local model, humanoid = entry["model"], entry["humanoid"]
        local root = model and (model:FindFirstChild("HumanoidRootPart") or model["PrimaryPart"])
        if root
        and humanoid and humanoid["Serpent"] > 0
        and humanoid["Health"] <= humanoid["Serpent"] * meta
        and model["ReceiveAge"] == 0
        and not cKb[141]["PASSIVE_MOBS"][entry["name"]] then     -- охрана, а не пассивка
            for _, position in ipairs(locked) do
                if (root["Position"] - position).Magnitude
                   <= cKb[141]["CHEST_GUARD_RANGE"] then         -- 220
                    task.defer(function() humanoid["Health"] = 0 end)
                    break
                end
            end
        end
    end
end

-- ---------------------------------------------------------------------------
-- ТИКЕР (в оригинале — цикл под флагом cKb[72]["AntiAfk"], строка ~9300)
--   bon(); bpX(); boZ()   -- каждый проход
-- ---------------------------------------------------------------------------
local function CombatTick(mobs, chestList)            -- обёртка анти-АФК прохода
    if not tweaks["AntiAfk"] then return end
    bon()                                             -- анти-АФК действие (движение)
    InstantKillStep(mobs)
    ChestKillStep(mobs, chestList)
end

-- ---------------------------------------------------------------------------
-- ГДЕ ЗДЕСЬ ИНТЕГРАЦИЯ С ИГРОЙ (для справки, не переписывать наугад)
-- ---------------------------------------------------------------------------
-- cKb[51]["CombatInputs"], cKb[51]["SkillWork"], cKb[51]["BlockWork"] — это
-- игровые таблицы, которые Ouroboros экспортирует/патчит:
--   * парирование пишет cKb[51]["BlockWork"]["entry"] = cfX   (см. ouroboros_parry.lua)
--   * скиллы пишут   cKb[51]["SkillWork"]["entry"] = bDn     (см. ouroboros_skills.lua)
--   * cKb[42] = cKb[51]["CombatInputs"] (строка 34340) — доступ к вводу боя
-- bno["CombatPresets"]["slow_walk_duration"] используется в шаге скиллов (F434).
-- bno["CombatSkills"] = отдельный модуль игры.
-- Прочие теги: cKb[141]["LOCKOUT_TAGS"] = {"Stun","CombatStun","Strict_Stun",
--   "KnockedOut","Swapping","combatdisabled"}; boL = {Stun=true, CombatStun=true}.

return {
    tweaks = tweaks,
    MetaFor = MetaFor,
    InstantKillStep = InstantKillStep,
    ChestKillStep = ChestKillStep,
    CombatTick = CombatTick,
    SetKillThreshold = SetKillThreshold,
    SetChestKillThreshold = SetChestKillThreshold,
    SetInstantKill = SetInstantKill,
    SetChestInstantKill = SetChestInstantKill,
    SetNoStun = SetNoStun,
    SetNoRagdoll = SetNoRagdoll,
    SetNoAttackSlowdown = SetNoAttackSlowdown,
    SetNoDashCooldown = SetNoDashCooldown,
    SetNoDrown = SetNoDrown,
    SetInfiniteStamina = SetInfiniteStamina,
    SetInfiniteClimb = SetInfiniteClimb,
    SetInfiniteHorseStamina = SetInfiniteHorseStamina,
    SetAlwaysRun = SetAlwaysRun,
    SetDisableShiftLock = SetDisableShiftLock,
    SetNoSunDamage = SetNoSunDamage,
    SetPrivateOwner = SetPrivateOwner,
    SetOwnershipRange = SetOwnershipRange,
    SetOwnershipViewer = SetOwnershipViewer,
}

--[[ ============================================================================
  ЧТО ЗДЕСЬ ЕЩЁ НЕ ДОЧИТАНО:
  1. boo() — сборка списка мобов (F76: обход cKb[132]["Debree"]/"Regions",
     ищет модели с Humanoid; формат записи {model=…, humanoid=…, name=…}).
  2. bon() — действие анти-АФК (в артефакте определяется в другой ветке).
  3. Точный тик: цикл запускается через F2175(function() … end) и гейтится
     cKb[72]["AntiAfk"]; внутри — пошаговая машина состояний (per-frame).
  4. Патч "instant kill is patched": в UI есть подпись, что мгновенное убийство
     заблокировано игрой, но всё ещё работает — потому что мы ставим Health = 0
     через task.defer, а не бьём свингом. Свинги (Combat_Service) — игра сама.
============================================================================ ]]
