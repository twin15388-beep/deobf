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
    entries = setmetatable({}, { __mode = "k" }),   -- bm0: входы блоков по трекам
    armed = setmetatable({}, { __mode = "k" }),     -- boX: взведённые треки
    watched = setmetatable({}, { __mode = "k" }),   -- cKb[50]: подписки по моделям
    blockEntry = nil,               -- bnl["blockEntry"]: вход, по которому идёт блок
    stats = { fired = 0, locked = 0, late = 0, missed = 0, cancelled = 0 },
    mitigate = true,
}
-- Опережающие объявления: на них ссылаются замыкания выше по файлу.
local TrackModel, RequestRelease, BeginBlock, BlockTick, BlockRelease, EntryWindow,
      OnAnimationPlayed, CombatCommand, LastHit, PresetFor,
      UnwatchModel, AcquireTargets

-- bnl == cKb[51]["BlockWork"]: в артефакте это одна и та же таблица.
-- Ссылку ставит сборка (tools/build_recon.py) после создания cKb[51].

-- bnl["in validate"] = F4744 (S2928): пересоздать набор целей блока.
parry["in validate"] = function()                  -- F4744 (S15950)
    parry.generation = parry.generation + 1        -- bnl["generation"] += 1
    table.clear(parry.entries)                     -- table.clear(bm0)
    for model in pairs(parry.watched) do           -- for x in pairs(cKb[50])
        UnwatchModel(model)                        -- cKb[14](x) — отписка (F4744)
    end
    RequestRelease()                               -- bpa()
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
-- Мелкие утилиты, которые использует вся подсистема
-- ---------------------------------------------------------------------------
-- cKb[122] в шапках копий — то строка, то функция; по всем местам применения
-- (`not cKb[122](x)` на числах Speed/момент/пинг) это проверка «валидное число».
-- Списки состояний (cKb[80] и boL; в двух сборках они поменяны местами —
-- канон второй: cKb[80] = {Stun, CombatStun} → держать блок,
-- boL = длинный список → бездействовать).
local BLOCK_STATES = { Stun = true, CombatStun = true }
local boL_STATES = {
    Strict_Stun = true, KnockedOut = true, Swapping = true, Training = true,
    ["Cancel"] = true, ["pause_gameplay"] = true, ["combatdisabled"] = true,
    PierceBlock = true,
}

-- bpo = F781 (копия 2: F3490): когда по модели последний раз попали
LastHit = function(model)                              -- bpo (F781)
    if not model then return nil end                 -- S5170/S5171/S5173
    local dmg = model:FindFirstChild("DMG")
    if not dmg then return nil end                   -- S5173/S5168
    return tonumber(dmg:GetAttribute("LastAttacked")) -- S5169
end

local function ValidNumber(value)                   -- cKb[122]
    return type(value) == "number" and value == value
       and value ~= math.huge and value ~= -math.huge
end

-- bol = F4578: сетевой пинг в секундах (Stats.Network.ServerStatsItem.Data Ping)
local function Ping()                               -- bol (F4578)
    local ok, ping = pcall(function()               -- S5375
        return game:GetService("Stats")["Network"]["ServerStatsItem"]["Data Ping"]:GetValue() / 1000
    end)
    if ok and ValidNumber(ping) then                -- S5376/S5373
        return ping
    end
    return CONFIG.defaultRtt                        -- S5377/S5374/S5388 (запас из конфига)
end

-- bmL = F1290: снять вход по треку; при countCancelled — зачесть отмену
local function WithdrawEntry(track, countCancelled)  -- bmL (F1290)
    if not parry.entries[track] then return end      -- S4432
    parry.entries[track] = nil                       -- S4434
    if countCancelled then                           -- S4434/S4433
        local stats = parry["stats"]
        stats["cancelled"] = stats["cancelled"] + 1
    end
end

-- cKb[128] = F853: дотягивается ли цель (плоская дистанция + запас, при strict —
-- ещё и «лицом ли» цель). Тело читается по S5779..S5795.
-- cKb[128] = F853(target, reach, pad, strict): дотягиваемся ли до цели.
--   Цель — модель: берётся её HumanoidRootPart (target:FindFirstChild); если у
--   цели нет Parent — сразу false. Дальше:
--     delta = мой корень (cKb[145]()) − их часть, обнуляем Y,
--     distance > reach + pad → false;
--     без strict → true (запас дистанции уже проверен);
--     distance < 0.1 → true (вплотную);
--     их LookVector по плоскости: Magnitude < 0.01 → true,
--     иначе look.Unit:Dot(delta.Unit) >= cKb[61]["facingMin"] — «цель смотрит
--     на нас» (facingMin = −0.35, то есть допускается и вбок/чуть в сторону).
local function InReach(target, reach, pad, strict)   -- cKb[128] (F853)
    if not target then return false end              -- S5781/S5787
    local part = nil
    if target["Parent"] then                         -- S5785/S5794
        part = target:FindFirstChild("HumanoidRootPart")
    end
    local root = cKb[145]()                          -- S5790
    if not part or not root then return false end    -- S5780/S5793/S5779

    local delta = root["Position"] - part["Position"]              -- S5791
    local flat = Vector3.new(delta.X, 0, delta.Z)
    local distance = flat["Magnitude"]
    if distance > reach + (pad or 0) then return false end         -- S5789
    if not strict then return true end                             -- S5792/S5784/S5788
    if distance < 0.1 then return true end                         -- S5783/S5788

    local look = part["CFrame"]["LookVector"]                      -- S5782
    local lookFlat = Vector3.new(look.X, 0, look.Z)
    if lookFlat["Magnitude"] < 0.01 then return true end           -- S5786
    return lookFlat["Unit"]:Dot(flat["Unit"]) >= CONFIG["facingMin"]  -- S5795/S5786
end

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
-- Таблица пресетов боя (cKb[34]) и выбор пресета по анимации
--   Пресеты строит cKb[17]() = F3460 (см. BuildPresets ниже): по детям папки
--   анимаций собираются записи { folder, preset, combo, running, swing, hit,
--   reach, runTrim } и складываются в cKb[34][<AnimationId без нецифр>] списком.
-- ---------------------------------------------------------------------------
local presets = {}                                   -- cKb[34]
parry.presets = presets

-- ---------------------------------------------------------------------------
-- Папка анимаций и конфиг пресетов (F3460)
--   S5151: bnm = cloneref(ReplicatedStorage) → :FindFirstChild("Assets")
--          → :FindFirstChild("Animations")
--   S26691: bno["CombatPresets"] = LoadModule(Global, {"Combat_presets"})
--   S22086: bno["Items"]         = LoadModule(Global, {"Collectibles","Items"})
-- ---------------------------------------------------------------------------
local function AnimationsFolder()                    -- S5151/S5149
    local replicated = game:GetService("ReplicatedStorage")
    local assets = replicated and replicated:FindFirstChild("Assets")
    if not assets then return nil end
    return assets:FindFirstChild("Animations")
end

local function PresetConfigs()                       -- S5152/S5144
    local module = bno["CombatPresets"]
    if type(module) ~= "table" then return nil end
    local list = module["Presets"]
    if type(list) ~= "table" then return nil end
    return list
end

-- Первое число из списка кандидатов (замена цепочек tonumber/«а если nil»)
local function FirstNumber(...)
    for i = 1, select("#", ...) do
        local value = tonumber((select(i, ...)))      -- скобки: только первый результат
        if value then return value end
    end
    return nil
end

-- cKb[17] = F3460: построить cKb[34] (таблицу пресетов) и вернуть её.
--   Возврат nil — когда нет папки Animations или нет bno["CombatPresets"].
local presetsBuilt = false
local function BuildPresets()                        -- cKb[17] (F3460)
    if presetsBuilt then return presets end          -- S5155/S5147
    local animations = AnimationsFolder()
    if not animations then return nil end            -- S5142/S5146
    local config = PresetConfigs()
    if type(config) ~= "table" then return nil end   -- S5153/S5146

    local items = bno["Items"]
    local built = {}
    for _, folder in ipairs(animations:GetChildren()) do          -- S5145
        -- S7: ключ конфига — короткое имя папки без суффикса _Combat_Anims
        -- (в записи folder — полное имя, чтобы PresetFor сравнивал его с
        --  animation.Parent.Name)
        local key = tostring(folder["Name"] or ""):match("^(.+)_Combat_Anims$")
        if key then
            -- S8/S9/S5: имя элемента Items; S4: пресет по ключу,
            -- S10: иначе пресет по Items[key].CombatPreset
            local item = (type(items) == "table") and items[key] or key
            local cfg = config[key]
            if not cfg and type(item) == "table" then
                cfg = config[item["CombatPreset"]]
            end
            if cfg then                              -- S13/S2
                for _, animation in ipairs(folder:GetChildren()) do
                    if animation:IsA("Animation") then            -- S33
                        local name = tostring(animation["Name"] or "")
                        local combo = tonumber(name:match("^Swing_(%d+)$"))   -- S21
                        local running = (name == "Run_Hit")
                        if combo or running then                 -- S1/S27
                            local index = combo or 1             -- S26
                            -- S20/S19/S37: боевой бег берёт задержки из
                            -- Presets.Combat, если у пресета включён CombatRunHit
                            local source = cfg
                            if running and cfg["CombatRunHit"] == true
                                    and type(config["Combat"]) == "table" then
                                source = config["Combat"]
                            end
                            local swings = source["delay_before_swing"]     -- S8
                            local hits = source["delay_before_hit"]         -- S41
                            local swing = FirstNumber(
                                type(swings) == "table" and swings[index],   -- S22
                                source["default_before_swing"],              -- S14
                                bno["CombatPresets"]["Default_Swing_Wait"])  -- S3
                                or 0                                          -- S30/S42
                            local hit = FirstNumber(
                                type(hits) == "table" and hits[index],       -- S16
                                source["default_before_hit"])                -- S15
                                or swing                                     -- S46/S2
                            local reaches = source["Reaches"]                -- S13
                            local reach = 4                                  -- S9
                            if type(reaches) == "table" then
                                reach = FirstNumber(reaches[index],          -- S10
                                                    reaches["Default"],      -- S25
                                                    reaches) or reach
                            else
                                reach = FirstNumber(reaches) or reach        -- S38
                            end
                            local runTrim = 0                                -- S7/S32
                            if running then
                                runTrim = tonumber(source["run_swing_remove_on_first"]) or 0
                            end
                            local record = {                                 -- S12
                                folder = folder["Name"], preset = source,
                                combo = index, running = running,
                                swing = swing, hit = hit,
                                reach = reach, runTrim = runTrim,
                            }
                            local id = tostring(animation["AnimationId"] or ""):match("%d+")
                            if id then                                   -- S12/S23
                                built[id] = built[id] or {}
                                table.insert(built[id], record)
                            end
                        end
                    end
                end
            end
        end
    end

    for id, list in pairs(built) do                   -- S5143 (cKb[34] = ceE)
        presets[id] = list
    end
    presetsBuilt = true
    return presets                                    -- S5148
end
parry.BuildPresets = BuildPresets                     -- cKb[17]

-- cKb[108] = F3490: по анимации найти запись пресета
local function PresetFor(animation)                  -- cKb[108] (F3490)
    if not animation then return nil end             -- S522/S527
    local id = tostring(animation["AnimationId"] or ""):match("%d+")   -- S524
    local list = id and presets[id] or nil           -- S525/S529
    if type(list) ~= "table" then return nil end     -- S530/S521
    local folder = animation["Parent"] and animation["Parent"]["Name"]  -- S523
    for _, item in ipairs(list) do                   -- S523 (поиск по папке)
        if item["folder"] == folder then return item end
    end
    return list[1]                                    -- S523 (иначе первая запись)
end

-- ---------------------------------------------------------------------------
-- Подписка на модель (cKb[14], S13307..S13324) + решение по анимации
--   cKb[14](model, isMob): находит Humanoid → Animator (или Animator из
--   Accessories/CustomRig/AnimController), помнит запись в cKb[50][model],
--   вешает AnimationPlayed и прогоняет уже играющие треки.
-- ---------------------------------------------------------------------------
TrackModel = function(model, isMob)                  -- cKb[14]
    if not model then return end                     -- S13310/S13315
    local humanoid = model:FindFirstChildOfClass("Humanoid")      -- S13310
    if not humanoid then return end                               -- S13312
    local animator = humanoid:FindFirstChildOfClass("Animator")   -- S13316

    local rig = model:FindFirstChild("Accessories")               -- S13312/S13324
    if rig then rig = rig:FindFirstChild("CustomRig") end         -- S13324
    if rig then rig = rig:FindFirstChild("AnimController") end    -- S13321
    if rig then                                                   -- S13307/S13325
        animator = rig:FindFirstChildOfClass("Animator")          -- S13325 (заменяет!)
    end

    local record = parry.watched[model]                           -- S13327
    if record then
        if record["animator"] == animator then return end          -- S13313/S13320: уже подписаны
        UnwatchModel(model)                                        -- S13319: cKb[14](model)
        record = nil
    end
    if not ValidNumber(humanoid and humanoid["Health"]) then return end  -- S13317/S13318
    if humanoid["Health"] <= 0 then return end                     -- S13326/S13311
    if not animator then return end                                -- S13325/S13315

    record = { animator = animator, stopped = {} }                 -- S13323
    parry.watched[model] = record                                  -- cKb[50][model]

    local onTrack = function(track)                                -- chu
        local ok, armed = pcall(OnAnimationPlayed, model, isMob, track, animator)  -- S15682
        if not ok then
            cKb[100]("auto parry:" .. tostring(armed))             -- S15685
            armed = nil
        end
        if armed and record["stopped"][track] == nil then           -- S15684/S15680
            record["stopped"][track] = track["Stopped"]:Connect(function()   -- S821
                WithdrawEntry(track, true)                          -- bmL(track, true)
                parry.armed[track] = nil
                local connection = record["stopped"][track]
                record["stopped"][track] = nil
                if connection then connection:Disconnect() end      -- S823
            end)
        end
    end

    record["played"] = animator["AnimationPlayed"]:Connect(onTrack)
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do   -- S13323 (хвост)
        onTrack(track)
    end
end

-- cKb[14] = F5469: отписаться от модели (S8727..S8729).
--   Закрывает AnimationPlayed, все подписки на Stopped (и снимает boX[track]),
--   убирает запись cKb[50][model] и снимает входы bm0, чья модель — эта.
UnwatchModel = function(model)                        -- cKb[14] (F5469)
    local record = parry.watched[model]               -- S8727
    if not record then return end                     -- S8724
    record["played"]:Disconnect()                     -- S8729
    for track, connection in pairs(record["stopped"]) do
        connection:Disconnect()
        parry.armed[track] = nil                      -- boX[track] = nil
    end
    parry.watched[model] = nil                        -- cKb[50][model] = nil
    for track, entry in pairs(parry.entries) do        -- for … in pairs(bm0)
        if entry["model"] == model then               -- S>=4
            WithdrawEntry(track, true)                -- bmL(track, true)
        end
    end
end
parry.UnwatchModel = UnwatchModel

-- bom = F2783: собрать цели рядом и подписаться (S16209..S16210).
--   chI = «увиденные»: мобы (Workspace.Humanoids.Regions[*].ActiveNpcs) ближе
--   bnl["radius"] к нашему корню (cKb[145]()) → bpO(model, true);
--   игроки (Players:GetPlayers(), кроме cKb[126]) с Character.HumanoidRootPart
--   ближе радиуса → bpO(character, false). Затем по cKb[50]: кого не видели
--   или кто потерял Parent — cKb[14](model) (отписка).
AcquireTargets = function()                           -- bom (F2783)
    local root = cKb[145]()                           -- S16209
    local position = root and root["Position"] or nil -- S16204
    local seen = {}                                   -- chI

    if position and parry["npc"] then                 -- S16204/S16202
        local workspaceService = game:GetService("Workspace")
        local humanoids = workspaceService:FindFirstChild("Humanoids")   -- S16202
        local regions = humanoids and humanoids:FindFirstChild("Regions")-- S16207/S16199
        for _, region in ipairs(regions and regions:GetChildren() or {}) do
            local npcs = region:FindFirstChild("ActiveNpcs")             -- S3
            for _, model in ipairs(npcs and npcs:GetChildren() or {}) do
                local part = nil
                if model:IsA("Model") then                               -- S3/S6
                    part = model:FindFirstChild("HumanoidRootPart")
                end
                if part and (part["Position"] - position)["Magnitude"] <= parry["radius"] then
                    seen[model] = true                                   -- S4/S9
                    TrackModel(model, true)                              -- bpO(model, true)
                end
            end
        end
    end

    if position and parry["pvp"] then                 -- S16208/S16198
        local players = game:GetService("Players")
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= players["LocalPlayer"] then                 -- cOs[126] = cKb[126]
                local character = player["Character"]                -- S2/S1
                local part = character and character:FindFirstChild("HumanoidRootPart")
                if part and (part["Position"] - position)["Magnitude"] <= parry["radius"] then
                    seen[character] = true                           -- S4/S9
                    TrackModel(character, false)                     -- bpO(character, false)
                end
            end
        end
    end

    for model in pairs(parry.watched) do              -- S16210 (чистка)
        if not seen[model] or not model["Parent"] then
            UnwatchModel(model)                       -- cKb[14](model)
        end
    end
end
parry.AcquireTargets = AcquireTargets

-- ---------------------------------------------------------------------------
-- Решение по играющей анимации (boh = F324, S3756..S3779)
--   Если трек ещё не взведён, анимация знакома (cKb[108]), цель в пределах
--   дистанции (cKb[128], closingPad) и проходит фильтр npc/pvp — заводим вход
--   bm0[track] и помечаем boX[track].
-- ---------------------------------------------------------------------------
OnAnimationPlayed = function(model, isMob, track, animator)          -- boh (F324)
    if parry.armed[track] ~= nil then return end         -- S3777/S3765
    if not bnB() then return end                         -- S3762/S3771
    if not parry["on"] then return end
    if not track["IsPlaying"] then return end            -- S3763/S3761

    -- S3756..S3774: фильтр «моб ↔ bnl.npc», «игрок ↔ bnl.pvp»
    -- (в рендере развилка свёрнута непрозрачным предикатом — сверено по смыслу)
    local allowed = (isMob and parry["npc"]) or ((not isMob) and parry["pvp"])
    if not allowed then return end

    local info = cKb[108](track["Animation"])            -- S3759: описание замаха
    if not info then return end                          -- S3776/S3775
    if not InReach(model, info["reach"] or 0, CONFIG["closingPad"], false) then
        return end                                       -- S3760/S3776
    parry.armed[track] = true                            -- S3764
    parry.entries[track] = {                             -- bm0[ate]
        model = model, isMob = isMob, ["in fo"] = info, track = track,
        animator = animator, owner = cKb[9](), generation = parry.generation,
    }
    return true                                          -- S3769
end

-- ---------------------------------------------------------------------------
-- Окно блока по треку (bmN = F2590, S658..S680)
--   Считает момент удара, окно (моб — windowNpc, игрок — windowPvp с поправкой
--   на скорость атаки), пинг (bol) и пишет в вход: earliest/latest/due/
--   protectUntil/window. Возвращает false, если трек ещё не пригоден.
-- ---------------------------------------------------------------------------
EntryWindow = function(entry, now)                       -- bmN (F2590)
    local info, track = entry["in fo"], entry["track"]   -- S658
    if not info or not track then return false end
    local invalid = not ValidNumber(track["Speed"])      -- S658/S672
    if not invalid then invalid = track["Speed"] <= 0 end -- S673
    if invalid then return false end                     -- S660

    local swingStart = track["TimePosition"] / track["Speed"]   -- S661
    local moment = info["hit"]

    if not entry["isMob"] then                           -- S661 → S656 (игрок)
        local speedOf = bno["CombatPresets"] and bno["CombatPresets"]["attackSpeedMult"]
        if not cKb[118](speedOf) then return false end   -- S656/S670
        local ok, speed = cKb[119](speedOf, entry["model"])       -- S662
        if (not ok) or (not ValidNumber(speed)) or speed <= 0 then
            return false end                             -- S674/S659/S665/S671
        moment = info["swing"]
               + math.max(0, info["hit"] - info["runTrim"] - info["swing"]) / speed  -- S678
    end

    if not (ValidNumber(swingStart) and ValidNumber(moment)) then
        return false end                                 -- S655/S679/S660

    local rtt = Ping()                                   -- S668: cgo = bol()
    local window = entry["isMob"] and CONFIG["windowNpc"] or CONFIG["windowPvp"]  -- S675/S663
    local base = now + moment - swingStart - rtt         -- S669

    entry["earliest"] = base - window + CONFIG["margin"]
    entry["latest"] = base - CONFIG["margin"]
    entry["due"] = math.clamp(base - window * CONFIG["bias"] + (parry["lead"] or 0),
                              entry["earliest"], entry["latest"])
    entry["protectUntil"] = base + rtt + 0.03
    entry["window"] = window

    if now > entry["due"] then                           -- S669/S666
        local stats = parry["stats"]
        stats["late"] = stats["late"] + 1
    end
    return true                                          -- S680
end

-- ---------------------------------------------------------------------------
-- Открытие блока: ждём подтверждения сервера и держим, пока нужно  [S1852..]
-- ---------------------------------------------------------------------------
BeginBlock = function(protectUntil)                   -- cKb[143] (S1839..S1857)
    if not bnB() then return false end                          -- S1839/S1840
    if not parry["on"] then return false end                     -- S1844/S1847/S1845
    if not cKb[17]() then                                        -- S1847 → S1842/S1843
        bpz["ParryStatus"] = "Combat presets unavailable"
        return false
    end

    local values = cKb[123]["playerValues"]()                    -- S1837
    if not values then return false end                          -- S1853
    local character = cKb[126]                                   -- S1838
    if not character then return false end                       -- S1857
    if not character:FindFirstChild("Blocking") then return false end   -- S1852/S1853/S1846

    local now = os.clock()
    local entry = {                                              -- S1854
        character = character,
        phase = "awaiting",
        keep = parry["hold"],
        lastHit = nil,
        releaseAt = nil,
        deadline = now + CONFIG["acknowledgement"],
        releaseRequested = false,
    }
    parry["blockEntry"] = entry
    cKb[51]["BlockWork"]["entry"] = entry

    entry["poll"] = function()                                   -- S1854 (хвост)
        return BlockTick(entry)                                  -- boA(cfX)
    end
    entry["connection"] = game:GetService("RunService").Heartbeat:Connect(function()
        BlockRelease(entry, true)                                -- bo_(cfX, true)
        if bnB() then
            local ok, err = pcall(BlockTick, entry)              -- F2175(boA, cfX)
            if not ok then
                cKb[100]("auto parry release:" .. tostring(err))
            end
        end
    end)

    local acknowledged = Signal("server_skill_controller_signaler", "Blocking",
                                "Hold", Vector3.zero)            -- прим. к S1854
    if not acknowledged then
        return true                                              -- сервер не принял
    end

    -- если включён hold — держим ровно 1.5 с (подтверждено трейсом: 1.501..1.510)
    if parry["hold"] then
        entry["releaseAt"] = now + 1.5                           -- cf2 = cfZ + 1.5
    end
    return true
end

-- ---------------------------------------------------------------------------
-- bpa = F1572: попросить отпустить текущий блок (перезагрузка настроек)
--   Если активный вход существует и совпадает с bnl["blockEntry"] —
--   ставим releaseRequested и сразу опрашиваем.
-- ---------------------------------------------------------------------------
RequestRelease = function()                            -- bpa (F1572)
    local entry = cKb[51]["BlockWork"]["entry"]
    if entry and entry == parry["blockEntry"] then               -- S8812/S8809
        entry["releaseRequested"] = true                         -- S8810
        BlockTick(entry)                                         -- boA(cfR)
    end
end

-- ---------------------------------------------------------------------------
-- boA = F5058 (в копии 1 — cKb[41]): «что делать по цели» → "block"/"none"/"parry"
--   Восстановлено по S14886..S14907. Аргумент — модель/персонаж (в артефакте
--   вызов идёт из poll каждого входа: boA(cfX)); принимаем и вход, и модель.
--   Списки состояний: cKb[80] (в копии 2 = {Stun, CombatStun}) → держать блок;
--   boL (KnockedOut, Swapping, Training, Cancel, pause_gameplay, combatdisabled,
--   PierceBlock, Strict_Stun) → не делать ничего.
-- ---------------------------------------------------------------------------
CombatCommand = function(subject)                      -- boA (F5058)
    local model = subject
    if type(model) == "table" and model["model"] ~= nil then model = model["model"] end
    if not model then return "none" end

    local character = cKb[9]()                         -- S14896
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")  -- S14892
    if not humanoid or not ValidNumber(humanoid["Health"]) then return "none" end  -- S14901/S14887
    if humanoid["Health"] <= 0 then return "none" end  -- S14895

    for tag in pairs(boL_STATES) do                    -- S14900
        if model:FindFirstChild(tag) then return "none" end
    end

    local blocking = model:FindFirstChild("Blocking")  -- S14900 (хвост)
    if not blocking then blocking = cKb[126] and cKb[126]:FindFirstChild("Blocking") end  -- S14886
    if not blocking then return "none" end             -- S14906/S14899/S14904
    if not ValidNumber(blocking["Value"]) then return "none" end
    if blocking["Value"] <= 0 then return "none" end    -- S14890

    for tag in pairs(BLOCK_STATES) do                  -- S14897
        if model:FindFirstChild(tag) then return "block" end
    end

    local lastHit = LastHit(model)                     -- bpo(model)
    if not lastHit then return "parry" end             -- S14897 → S14902
    local ok, tick = pcall(function()                  -- S14889
        return bno["Utility"] and bno["Utility"]["Tick"] and bno["Utility"]["Tick"]()
    end)
    if not ok or not ValidNumber(tick) then return "block" end      -- S14893
    if tick - lastHit < CONFIG["relock"] then return "block" end    -- S14894/S14905
    return "parry"                                     -- S14907/S14902
end
BlockTick = CombatCommand                              -- имя из Heartbeat-обвязки

-- ---------------------------------------------------------------------------
-- bo_ = F2854: отпускание блока (state machine S10402..S10435)
--   force=true (вызов из Heartbeat) — «попросить отпустить»: ставим
--   releaseRequested, чтобы следующий виток отправил UnHold.
-- ---------------------------------------------------------------------------
BlockRelease = function(entry, force)                  -- bo_ (F2854)
    if type(entry) ~= "table" then return false end
    if force then                                      -- S10402 (вызов bo_(cfX,true))
        entry["releaseRequested"] = true               -- S10434/S10405
        return true
    end
    if cKb[51]["BlockWork"]["entry"] ~= entry then     -- S10411
        return true                                    -- S10433 → S10406: bo_(arX,false)
    end
    if cKb[9]() ~= entry["character"] then return true end          -- S10415/S10433

    local now = os.clock()                             -- S10435
    local values = cKb[123]["playerValues"]()
    local blocking = values and values:FindFirstChild("Blocking")   -- S10421
    local previous = blocking                          -- S10427 (cfM)

    if entry["phase"] == "awaiting" then               -- S10427/S10428
        entry["block"] = blocking                      -- S10403
        entry["phase"] = "holding"
    elseif entry["block"] ~= previous then             -- S10431/S10422
        if entry["block"] == nil                          -- S10426/S10409/S10407
        or entry["block"]["Parent"] == nil
        or entry["block"]["Parent"] == cKb[126] then
            return true                                -- S10418 → S10430: bo_(arX,false)
        end
    end

    if entry["phase"] == "boxFill" then return false end            -- S10404/S10423
    local wanted
    if not entry["keep"] then                          -- S10414/S10416
        wanted = LastHit(entry["model"]) ~= entry["lastHit"]        -- S10417
    end
    if wanted or (now >= (entry["releaseAt"] or math.huge)) then    -- S10416/S10424
        entry["releaseRequested"] = true               -- S10405/S10434
    end
    if entry["releaseRequested"] and entry["phase"] == "holding" then   -- S10425/S10429
        entry["phase"] = "releasing"                   -- S10408
        entry["deadline"] = now + CONFIG["acknowledgement"]
        Signal("server_skill_controller_signaler", "Blocking", "UnHold", Vector3.zero)
        return true
    end
    if now >= (entry["deadline"] or math.huge) then    -- S10413/S10402
        return true                                    -- bo_(arX, true) → просьба отпустить
    end
    return false                                       -- S10420/S10432
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
        AcquireTargets()                             -- S9508: bom() — собрать цели рядом
        entry = work["entry"]                        -- перечитать: вход мог появиться
        if not entry then
            if parry["blockEntry"] then              -- S9482/S9506
                bpz["ParryStatus"] = "Waiting for previous block release"  -- S9505
            else
                local s = parry["stats"]             -- S9480/S9488/S9496
                bpz["ParryStatus"] = string.format(
                    "%d attempts, %d blocks, %d missed, %d cancelled",
                    s["fired"], s["locked"], s["missed"], s["cancelled"])
            end
            return
        end
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
-- cKb[65] = F3871: планировщик блоков (перебор bm0 = parry.entries)
--   Восстановлено по состояниям S360..S386 и вложенным машинам (entry=21,
--   entry=7, entry=0). Две ветви, которые рендер свернул в непрозрачные
--   предикаты, читаются по смыслу (взведение/снятие входа, S13/S3/S18) —
--   отмечено ниже.
--     * первый проход: выбрать САМЫЙ СРОЧНЫЙ вход (cgJ):
--         - негодный (cKb[58])  → bmL(вход, true) — «перевзвести»;
--         - окно не посчитано (bmN(вход, now)) → bmL(вход, true);
--         - просрочен (now > entry.latest) → stats.missed += 1, bmL(вход, false);
--         - в окне (now >= due) и дотягивается (cKb[128](model, info.reach,
--           cKb[61].reachPad, true)) → кандидат; берём с наименьшим latest;
--     * если кандидата нет и нет активного входа (cKb[51].BlockWork.entry) — выход;
--     * cKb[123].playerValues() → cKb[41](values) даёт «block» / «none»;
--       «none» → выход; «block» при выключенном mitigate → выход;
--     * повторные проверки кандидата (cKb[58], latest) — выход, если протух;
--     * собрать группу входов в окне + максимум protectUntil,
--       и если cKb[143](protectUntil) разрешает — зачесть stats (fired, а для
--       «block» — locked) и снять группу: bmL(вход, false).
-- ---------------------------------------------------------------------------
local function ParryScheduler()                      -- cKb[65] (F3871)
    if not bnB() then return end                     -- S373
    if not parry["on"] then return end               -- S385

    local now = os.clock()                           -- S376
    local target = nil                               -- cgJ: самый срочный вход
    for track, entry in pairs(parry.entries) do
        if not EntryValid(entry) then                -- S21/S13
            WithdrawEntry(track, true)               -- bmL(track, true)
        elseif (not entry["due"]) and (not EntryWindow(entry, now)) then   -- S6/S19/S18
            WithdrawEntry(track, true)               -- bmL(track, true)
        elseif not EntryValid(entry) then            -- S9/S3
            WithdrawEntry(track, true)               -- bmL(track, true)
        elseif now > entry["latest"] then            -- S5
            local stats = parry["stats"]
            stats["missed"] = stats["missed"] + 1    -- S8
            WithdrawEntry(track, false)              -- bmL(track, false) — S8
        elseif now >= entry["due"] then              -- S20/S23
            local reach = entry["in fo"] and entry["in fo"]["reach"]
            if InReach(entry["model"], reach, CONFIG["reachPad"], true) then
                if not target or entry["latest"] < target["latest"] then
                    target = entry                   -- S4/S22/S7
                end
            end
        end
    end

    if not target and not cKb[51]["BlockWork"]["entry"] then return end  -- S381/S362/S364

    local values = cKb[123]["playerValues"]()        -- S380
    if not values then return end                    -- S369
    local command = cKb[41](values)                  -- S377
    if command == "none" then return end             -- S386
    if command == "block" and not parry["mitigate"] then return end   -- S383/S374
    if not EntryValid(target) then return end        -- S366
    if os.clock() > target["latest"] then return end -- S371

    -- S378: группа входов в окне + максимум protectUntil
    local group, protectUntil = {}, target["protectUntil"]
    for track, entry in pairs(parry.entries) do
        local earliest = entry["earliest"]
        if earliest and now >= earliest and now <= entry["latest"] then
            group[#group + 1] = track
            protectUntil = math.max(protectUntil or 0, entry["protectUntil"] or 0)
        end
    end

    if BeginBlock(protectUntil) then                 -- cKb[143](protectUntil) — S378
        local stats = parry["stats"]
        if command == "block" then
            stats["locked"] = stats["locked"] + 1    -- S382
        else
            stats["fired"] = stats["fired"] + 1      -- S372
        end
        for _, track in ipairs(group) do             -- S367
            WithdrawEntry(track, false)              -- bmL(track, false)
        end
    end
end

-- bnl, cKb[58] = F4381 (S8959..S8947): годен ли вход блока.
--   Порядок проверок — как в артефакте:
--     bnB() → bnl["on"] → entry.generation == bnl.generation →
--     entry.owner == cKb[9]() (наш персонаж) →
--     аниматор записи cKb[50][model] тот же (cgz.animator == entry.animator) →
--     трек ещё играет (track.IsPlaying) → модель жива
--     (Parent есть, Humanoid есть, Humanoid.Health > 0) →
--     фильтр по isMob: моб → bnl["npc"], игрок → bnl["pvp"]; возвращается
--     именно значение этого флага.
function EntryValid(entry)
    if type(entry) ~= "table" then return false end
    local model, track = entry["model"], entry["track"]
    local record = model and parry.watched[model] or nil      -- cgz = cKb[50][model]
    local humanoid = nil
    if model and model["Parent"] then                          -- S8959 → S8933/S8952
        humanoid = model:FindFirstChildOfClass("Humanoid")
    end
    local ok = bnB()                                           -- S8952
        and parry["on"]                                        -- S8962
        and entry["generation"] == parry.generation            -- S8946
        and entry["owner"] == cKb[9]()                         -- S8941
        and (record == nil or record["animator"] == entry["animator"])   -- S8954
        and (track == nil or track["IsPlaying"])               -- S8943
        and humanoid ~= nil                                    -- S8948/S8934
        and humanoid["Health"] > 0                             -- S8958
    if not ok then return false end                            -- S8956/S8947
    if entry["isMob"] then return parry["npc"] end             -- S8939/S8935
    return parry["pvp"]                                        -- S8936/S8944
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
    ValidNumber = ValidNumber,
    CombatCommand = CombatCommand,
    PresetFor = PresetFor,
    LastHit = LastHit,
    Ping = Ping,
    InReach = InReach,
    WithdrawEntry = WithdrawEntry,
    TrackModel = TrackModel,
    BuildPresets = BuildPresets,                     -- cKb[17] = F3460
    TrackModel = TrackModel,                         -- bpO (подписка)
    UnwatchModel = UnwatchModel,                     -- cKb[14] = F5469 (отписка)
    AcquireTargets = AcquireTargets,                 -- bom = F2783
    EntryWindow = EntryWindow,
    RequestRelease = RequestRelease,
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
