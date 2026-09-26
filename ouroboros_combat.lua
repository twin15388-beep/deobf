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
local tweaks = {                    -- точные дефолты артефакта (S37249)
    noStun = true,
    noRagdoll = false,
    [8562344] = false,              -- "noSlowdown" (пул 3912): возврат WalkSpeed
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
-- F5934: в артефакте это ключ-число 8562344 (в списке ключей он же "noSlowdown");
-- тик артефакта читает именно tweaks[8562344] (см. M.Tick) и возвращает
-- WalkSpeed = 16, если тот просел до slow_walk_speed.
local function SetNoAttackSlowdown(value)
    tweaks[8562344] = value == true                  -- F5934
    tweaks["noAttackSlowdown"] = value == true       -- удобный псевдоним
end
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
        and not cKb[141]["PASSIVE_MOBS"][entry["model"]["Name"]] then -- охрана, а не пассивка
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
-- КОНТЕЙНЕР: cKb[132] = cloneref(LocalPlayer)  (строка 8144 оригинала:
--   cKb[132] = bpZ(bmK[<"LocalPlayer">]), где bpZ = F5378 = cloneref)
-- Поэтому проверки вида obj:IsDescendantOf(cKb[132]) означают
-- «объект уже у нас / принадлежит локальному игроку».
-- ---------------------------------------------------------------------------
local LocalPlayerRef = cloneref and cloneref(game:GetService("Players").LocalPlayer)
                          or game:GetService("Players").LocalPlayer

-- ---------------------------------------------------------------------------
-- СПИСОК МОБОВ — boo() = F3280 (вторая копия; в первой F76 — та же идея,
-- но запутаннее и без полей name/region)
--   bxc[i] = { name = <имя папки>, region = <регион>, model = <Model>, humanoid = <Humanoid> }
-- ---------------------------------------------------------------------------
local function MobList()                                  -- boo (F3280)
    local found = {}
    for _, region in ipairs(cKb[59]()) do                 -- список регионов/папок
        for _, model in ipairs(region["folder"]:GetChildren()) do
            if model:IsA("Model") and model:GetAttribute("IsMob") then
                local humanoid = model:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid["Health"] > 0 then
                    found[#found + 1] = {
                        name = region["folder"]["Name"],      -- имя папки региона
                        region = region["region"],
                        model = model,
                        humanoid = humanoid,
                    }
                end
            end
        end
    end
    return found
end

-- ---------------------------------------------------------------------------
-- АНТИ-АФК — bon() = F2440: переключает RunHandler.Toggled, чтобы персонаж
-- не «засыпал». Флаг cKb[71] хранит состояние переключателя.
-- ---------------------------------------------------------------------------
local antiAfkFlag = false                                 -- cKb[71]
local function AntiAfk()                                  -- bon (F2440)
    if type(bno["RunHandler"]) ~= "table" then return end
    if antiAfkFlag then
        antiAfkFlag = false
        task.defer(function() bno["RunHandler"]["Toggled"] = false end)
    else
        if bno["RunHandler"]["Toggled"] ~= true then
            bno["RunHandler"]["Toggled"] = true
        end
        antiAfkFlag = true
    end
end

-- ---------------------------------------------------------------------------
-- ФИЛЬТР ИГРОВЫХ МЕТОК — cKb[135] (inline @1 937 241)
--   Имена из артефакта: boK = {Stun, Strict_Stun, CombatStun, KnockedOut, Cancel},
--   bqD = {RagDoll}. Если включён noStun и метка из boK — снять (pcall Destroy,
--   и на этом всё); иначе если включён noRagdoll и метка RagDoll — снять.
-- ---------------------------------------------------------------------------
local STUN_MARKS = { Stun = true, Strict_Stun = true, CombatStun = true,
                     KnockedOut = true, Cancel = true }   -- boK
local RAGDOLL_MARKS = { RagDoll = true }                  -- bqD

local function FilterValue(object)                        -- cKb[135]
    if type(object) ~= "table" then return end
    local name = object["Name"]
    if tweaks["noStun"] and STUN_MARKS[name] then          -- S1870/S1875/S1876
        pcall(function() object:Destroy() end)
        return
    end
    if tweaks["noRagdoll"] and RAGDOLL_MARKS[name] then    -- S1871/S1877/S1874
        pcall(function() object:Destroy() end)
    end
end

-- ---------------------------------------------------------------------------
-- «noragdoll» — cKb[88] = F4619 (S7167..S7173)
--   values = cKb[123].playerValues(); нет — выходим.
--   Прогоняем всех детей через cKb[135] (фильтр меток); затем, если включён
--   noRagdoll и в values нет BoolValue "noragdoll" — создаём его (Value = true).
-- ---------------------------------------------------------------------------
local function NoRagdollStep()                            -- cKb[88] (F4619)
    local api = cKb[123]
    local values = type(api) == "table" and api["playerValues"] and api["playerValues"]()
    if not values then return end                         -- S7167/S7170
    if type(values) == "table" and values.GetChildren then
        for _, child in ipairs(values:GetChildren()) do    -- S7173
            FilterValue(child)
        end
    end
    if tweaks["noRagdoll"] and values["FindFirstChild"]
            and values:FindFirstChild("noragdoll") == nil then   -- S7164/S7169
        local flag = Instance.new("BoolValue")
        flag["Name"] = "noragdoll"
        flag["Value"] = true
        flag["Parent"] = values
    end
end

-- ---------------------------------------------------------------------------
-- Обновление подписки ChildAdded — cKb[66] = F4120 (S16375..S16370)
--   Держит фильтр cKb[135] подключённым к АКТУАЛЬНЫМ playerValues: если таблица
--   сменилась — отключаем старую подписку (cKb[18]) и подключаемся к новой.
-- ---------------------------------------------------------------------------
local valueFilterConnection = nil                         -- cKb[18]
local valueFilterValues = nil                             -- bpM
local function RefreshValueFilter()                       -- cKb[66] (F4120)
    local api = cKb[123]
    local values = type(api) == "table" and api["playerValues"] and api["playerValues"]()
    if not values then return end                         -- S16375/S16376/S16371
    if values == valueFilterValues then return end        -- S16373
    if valueFilterConnection then
        valueFilterConnection:Disconnect()                -- S16369
    end
    valueFilterValues = values                            -- S16370
    if values["ChildAdded"] then
        valueFilterConnection = values["ChildAdded"]:Connect(FilterValue)
    end
end

-- ---------------------------------------------------------------------------
-- ОТПУСКАНИЕ РАГДОЛЛА — cKb[140] (inline @1 425 932, S4418..S4430)
--   1) RagDoll (BoolValue) у персонажа → Value = false (через task.defer);
--   2) RagdollConstraints: все Constraint-наследники запоминаются в bqe и
--      выключаются (Enabled = false) — их вернёт restoreRagdoll;
--   3) Humanoid.PlatformStand → false.
-- ---------------------------------------------------------------------------
local disabledConstraints = {}                            -- bqe
local function ReleaseRagdoll()                           -- cKb[140]
    local character = cKb[9]()                            -- S4424
    if not character then return end                      -- S4432
    local ragDoll = character:FindFirstChild("RagDoll")    -- S4423
    if ragDoll and ragDoll:IsA("BoolValue") and ragDoll["Value"] then  -- S4418/S4425/S4431
        task.defer(function() ragDoll["Value"] = false end)            -- S4427
    end
    local constraints = character:FindFirstChild("RagdollConstraints")  -- S4419
    if constraints then                                   -- S4426
        for _, descendant in ipairs(constraints:GetDescendants()) do
            if descendant:IsA("Constraint") then
                disabledConstraints[descendant] = true
                task.defer(function() descendant["Enabled"] = false end)
            end
        end
    end
    local humanoid = cKb[124]()                           -- S4421
    if humanoid and humanoid["PlatformStand"] then         -- S4422/S4420
        task.defer(function() humanoid["PlatformStand"] = false end)    -- S4428
    end
end

-- bqe-восстановление: cKb[51]["restoreRagdoll"] (S3769/S3770)
local function RestoreRagdoll()
    for object in pairs(disabledConstraints) do
        if object["Parent"] then
            pcall(function() object["Enabled"] = true end)
        end
    end
    table.clear(disabledConstraints)
end

-- ---------------------------------------------------------------------------
-- ТИКЕР: bon(); bpX(); boZ() — хвост тика артефакта (см. M.Tick)
--   Своего гейта у прохода нет: bpX/boZ проверяют свои твики изнутри,
--   bon() просто переключает RunHandler.Toggled (анти-АФК).
-- ---------------------------------------------------------------------------
local function CombatTick()                               -- bon(); bpX(); boZ()
    AntiAfk()                                             -- bon (F2440)
    InstantKillStep(MobList)                              -- bpX
    ChestKillStep(MobList, bps)                           -- boZ
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
    MobList = MobList,
    AntiAfk = AntiAfk,
    FilterValue = FilterValue,                 -- cKb[135]
    NoRagdollStep = NoRagdollStep,             -- cKb[88] (F4619)
    RefreshValueFilter = RefreshValueFilter,   -- cKb[66] (F4120)
    ReleaseRagdoll = ReleaseRagdoll,           -- cKb[140]
    RestoreRagdoll = RestoreRagdoll,           -- cKb[51]["restoreRagdoll"]
    LocalPlayerRef = LocalPlayerRef,
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
  ЗАКРЫТО в этом заходе:
    MobList (boo = F3280: обход cKb[59](), фильтр Model + атрибут "IsMob" +
    живой Humanoid, запись {name=имя папки, region, model, humanoid});
    AntiAfk (bon = F2440: переключатель RunHandler.Toggled);
    cKb[132] = cloneref(LocalPlayer) — значит IsDescendantOf(cKb[132]) читается
    как «уже у нас».

  cKb[59]() = пул-функция 1319 (привязка в заголовке второй сборки @1 963 167;
  там же слот 87 @2 262 903) — прочитана целиком:
    local out = {}
    local base = cKb[63]()               -- контейнер со «сценами»/регионами
    if not base then return out end
    for _, scene in ipairs(base:GetChildren()) do
        local npcs = scene:FindFirstChild("ActiveNpcs")
        if npcs then
            for _, folder in ipairs(npcs:GetChildren()) do
                out[#out + 1] = { region = scene["Name"], folder = folder }
            end
        end
    end
    return out
  (записи — {region = имя ребёнка контейнера, folder = папка из его ActiveNpcs}).

  ЧТО ЗДЕСЬ ЕЩЁ НЕ ДОЧИТАНО:
  1. cKb[63]() — сам контейнер регионов: в сборках слот 63 привязан к РАЗНЫМ
     телам (пул 5333 @1 462 355 и пул 2112 @1 527 155 в первой сборке; inline
     @1 714 392 во второй — но там это уже не контейнер, а хелпер промпта с
     параметром). Какое тело действует в момент вызова cKb[59](), зависит от
     выбранной карты слотов (см. ROADMAP, «Известные ловушки»).
  3. Точный тик: цикл запускается через F2175(function() … end) и гейтится
     cKb[72]["AntiAfk"]; внутри — пошаговая машина состояний (per-frame).
  4. Патч "instant kill is patched": в UI есть подпись, что мгновенное убийство
     заблокировано игрой, но всё ещё работает — потому что мы ставим Health = 0
     через task.defer, а не бьём свингом. Свинги (Combat_Service) — игра сама.
============================================================================ ]]
