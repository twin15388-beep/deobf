
-- ---------------------------------------------------------------------------
-- Дымовой тест: Boot с фальшивой библиотекой UI + вызовы ключевых функций
-- ---------------------------------------------------------------------------
print("[smoke] сборка загружена без ошибок")
print("[probe] type(cKb)=", type(cKb), "type(bnB)=", type(bnB), "type(bno)=", type(bno),
      "type(bny)=", type(bny), "type(bn8)=", type(bn8))
print("[probe] Core.CanAct=", type(__RECON and nil), type(rawget(__RECON.Core, "CanAct")),
      "Core.bny=", type(rawget(__RECON.Core, "bny")), "Core.Signal=", type(rawget(__RECON.Core, "Signal")))
print("[probe] cKb[9]=", type(cKb[9]), "cKb[124]=", type(cKb[124]), "cKb[131]=", type(cKb[131]))
print("[smoke] слотов в cKb:", (function() local n = 0 for _ in pairs(cKb) do n = n + 1 end return n end)())

local M = __RECON

local fake_library = setmetatable({
    Toggles = { HideUiOnStart = { Value = false } },
    Values = {},
}, { __index = function(_, key)
        local child = LIBRARY_STUB[key]
        return child
    end })

local ok, result = pcall(function() return M.Boot({ library = fake_library }) end)
print("[smoke] Boot:", ok, tostring(result))

local ok2, err2 = pcall(function()
    return M.Farm.QuestStep()
end)
print("[smoke] Farm.QuestStep:", ok2, tostring(err2))

local ok3, err3 = pcall(function()
    return M.Combat.CombatTick()
end)
print("[smoke] Combat.CombatTick:", ok3, tostring(err3))

local ok4, err4 = pcall(function()
    return M.Skills.SkillStep()
end)
print("[smoke] Skills.SkillStep:", ok4, tostring(err4))

local ok5, err5 = pcall(function()
    return M.Equip.EquipStep()
end)
print("[smoke] Equip.EquipStep:", ok5, tostring(err5))

local ok6, err6 = pcall(function()
    return M.Parry.BlockTick()
end)
print("[smoke] Parry.BlockTick:", ok6, tostring(err6))

local ok7, err7 = pcall(function()
    return M.Move.Reach(Vector3.new(1, 2, 3), 0.1, function() return true end)
end)
print("[smoke] Move.Reach:", ok7, tostring(err7))

local ok8, err8 = pcall(function()
    return M.Config.Import("{ not json", services.HttpService, print, function() return false end,
                           function() end, function() end)
end)
print("[smoke] Config.Import(bad):", ok8, tostring(err8))

-- Планировщик парирования (cKb[65] = F3871) на одном поддельном входе
local ok9, err9 = pcall(function()
    local now = os.clock()
    M.Parry.state.entries["test"] = {
        due = now - 0.05, latest = now + 0.2, earliest = now - 0.2,
        protectUntil = now + 0.5, model = services.Workspace, phase = "boxFill",
        ["in fo"] = { reach = 5 },
    }
    M.Parry.state.on = true
    M.Parry.SchedulerTick()
end)
print("[smoke] Parry.SchedulerTick:", ok9, tostring(err9), "stats.fired=",
      M.Parry.state.stats.fired, "missed=", M.Parry.state.stats.missed)

-- Воркер-раннер (cKb[84] = F3818): прогоняем один виток цикла вручную.
-- task.delay в стабе складывает тело в STUB_DELAYED; task.wait дёргает STUB_ON_WAIT.
local steps = 0
local controller = { interval = 0.05, priorityKey = "AutoLoot" }
local ok10, err10 = pcall(function()
    M.Farm.StartController(controller, function() steps = steps + 1 end)
    local body = STUB_DELAYED[#STUB_DELAYED]
    STUB_ON_WAIT = function() controller["stopped"] = true end
    body()                                        -- виток: шаг -> task.wait -> стоп
end)
print("[smoke] Farm.StartController:", ok10, tostring(err10),
      "шагов:", steps, "workerActive:", tostring(controller["workerActive"]),
      "записей в bny.runs:", (function()
          local n = 0 for _ in pairs(M.Core.bny["runs"]) do n = n + 1 end return n end)())

-- Полный путь парирования: модель → Animator → играющий трек → вход → окно
local ok11, err11 = pcall(function()
    local workspaceTable = {
        Position = Vector3.new(0, 0, 0),
        CFrame = { LookVector = Vector3.new(0, 0, -1) },
        FindFirstChild = function() return nil end,
    }
    services.Workspace = workspaceTable
    local animation = { Name = "attack", }
    local track = {
        Animation = animation,
        IsPlaying = true,
        Speed = 1,
        TimePosition = 0.3,
        Stopped = services.RunService.Heartbeat,        -- заглушка «события»
    }
    local animator = {
        AnimationPlayed = services.RunService.Heartbeat,
        GetPlayingAnimationTracks = function() return { track } end,
    }
    local humanoid = { Health = 100, FindFirstChildOfClass = function() return animator end }
    -- цель InReach (F853) — модель с HumanoidRootPart: cKb[128] ищет именно его
    local mobRoot = {
        Position = Vector3.new(0, 0, 0),
        CFrame = { LookVector = Vector3.new(0, 0, -1) },
    }
    local model = {
        Parent = workspaceTable,
        Position = Vector3.new(0, 0, 0),
        CFrame = { LookVector = Vector3.new(0, 0, -1) },
        FindFirstChildOfClass = function() return humanoid end,
        FindFirstChild = function(_, name)
            return name == "HumanoidRootPart" and mobRoot or nil
        end,
    }
    animation.AnimationId = "rbxassetid://123456789"
    cKb[34]["123456789"] = { { folder = "folder", preset = {}, combo = 1, running = false,
                              swing = 0.2, hit = 0.5, reach = 10, runTrim = 0.05 } }
    -- персонаж игрока с корнем (нужен InReach → cKb[145])
    local root = { Position = Vector3.new(3, 0, 0), IsA = function() return true end }
    local character = {
        Position = Vector3.new(3, 0, 0),
        IsA = function() return true end,
        FindFirstChild = function(_, name) return name == "HumanoidRootPart" and root or nil end,
        FindFirstChildOfClass = function() return { Health = 100 } end,
    }
    services.Players.LocalPlayer.Character = character
    M.Core.Services.LocalPlayer = services.Players.LocalPlayer   -- ядро берёт игрока отсюда

    M.Parry.state.on = true
    M.Parry.state.npc = true
    M.Parry.TrackModel(model, true)
    local n = 0
    for _ in pairs(M.Parry.state.entries) do n = n + 1 end
    print("[smoke] Parry.TrackModel: входов =", n,
          "по этому треку =", tostring(M.Parry.state.entries[track] ~= nil),
          "записей cKb[50] =", (function()
              local c = 0 for _ in pairs(M.Core and cKb[50] or {}) do c = c + 1 end return c end)())

    -- окно блока по этому входу (bmN = F2590)
    local entry = M.Parry.state.entries[track]
    if entry then
        entry["in fo"] = { reach = 10, hit = 0.5, swing = 0.2, runTrim = 0.05 }
        local okw = M.Parry.EntryWindow(entry, os.clock())
        print("[smoke] Parry.EntryValid:", M.Parry.EntryValid(entry))
        print("[smoke] Parry.EntryWindow:", okw, "due/earliest/latest =",
              entry["due"], entry["earliest"], entry["latest"], "window =", entry["window"])
    end
end)
print("[smoke] Parry.TrackModel:", ok11, tostring(err11))

-- Ownership/ESP (cKb[78] = F4034, cKb[112], bpp["clear"] = F1060), проход F3841
local ok12, err12 = pcall(function()
    local mobPart = setmetatable({ Position = Vector3.new(5, 0, 0), ReceiveAge = 0,
                                   IsA = function() return true end }, {})
    local humanoid = { Health = 100 }
    local mob = {
        Name = "Mob", Parent = services.Workspace,
        IsA = function(_, class) return class == "Model" end,
        GetAttribute = function(_, name) return name == "IsMob" and true or nil end,
        FindFirstChildOfClass = function() return humanoid end,
        FindFirstChild = function(_, name) return name == "HumanoidRootPart" and mobPart or nil end,
    }
    local folder = { Name = "Region1", GetChildren = function() return { mob } end }
    cKb[59] = function() return { { folder = folder, region = "Region1" } } end

    local tweaks = M.ESP.container["tweaks"]          -- cKb[99]["tweaks"]
    tweaks["ownership"] = true
    tweaks["ownershipRange"] = 250
    local keep = M.ESP.OwnershipPass()
    local marks = 0
    for _ in pairs(M.ESP.viewer["marks"]) do marks = marks + 1 end
    local mark = M.ESP.viewer["marks"][mob]
    print("[smoke] ESP.OwnershipPass:", keep, "меток =", marks,
          "цвет задан =", tostring(mark ~= nil and mark["FillColor"] ~= nil),
          "имя =", tostring(mark and mark["Name"]), "Parent =", tostring(mark and mark["Parent"] == mob))

    -- второй проход: та же модель, метка переиспользуется (не пересоздаётся)
    local again = M.ESP.OwnershipPass()
    print("[smoke] ESP повторный проход:", again, "та же метка =",
          tostring(M.ESP.viewer["marks"][mob] == mark))

    -- «чужой» моб: ReceiveAge > 0 → красный
    mobPart.ReceiveAge = 0.4
    M.ESP.OwnershipPass()
    print("[smoke] ESP ReceiveAge ~= 0 → цвет bo9 =",
          tostring(M.ESP.viewer["marks"][mob]["FillColor"] == M.ESP.COLORS["other"]))

    -- выключили ownership → все метки сняты
    tweaks["ownership"] = false
    M.ESP.OwnershipPass()
    local left = 0
    for _ in pairs(M.ESP.viewer["marks"]) do left = left + 1 end
    print("[smoke] ESP выключен, осталось меток =", left,
          "clear =", type(M.ESP.viewer["clear"]), "cKb[78]/cKb[112] =",
          type(cKb[78]), type(cKb[112]))
end)
print("[smoke] ESP:", ok12, tostring(err12))

-- Построение пресетов боя (cKb[17] = F3460) из папки анимаций и Global.Combat_presets
local ok13, err13 = pcall(function()
    local function animation(name, id)
        return { Name = name, AnimationId = id, Parent = nil,
                 IsA = function(_, class) return class == "Animation" end }
    end
    local folder = { Name = "Sword_Combat_Anims", Children = {
        animation("Swing_1", "rbxassetid://111111"),
        animation("Swing_2", "rbxassetid://222222"),
        animation("Run_Hit", "rbxassetid://333333"),
        animation("Idle", "rbxassetid://444444"),
    } }
    for _, child in ipairs(folder.Children) do child.Parent = folder end
    folder.GetChildren = function() return folder.Children end
    local assets = { Name = "Assets", GetChildren = function()
        return { folder, { Name = "NotACombatFolder", GetChildren = function() return {} end } }
    end }
    assets.FindFirstChild = function(_, name) return name == "Animations" and assets or nil end
    local replicated = {
        Name = "ReplicatedStorage",
        FindFirstChild = function(_, name) return name == "Assets" and assets or nil end,
    }
    services.ReplicatedStorage = replicated

    M.Core.bno["CombatPresets"] = {
        Default_Swing_Wait = "0.7",
        Presets = {
            Sword = {                                -- ключ = имя папки без _Combat_Anims
                delay_before_swing = { [1] = "0.15", [2] = 0.25 },
                default_before_swing = "0.3",
                delay_before_hit = { [1] = "0.4" },
                Default_before_hit = 0.5,
                Reaches = { [1] = 9, Default = 7 },
                CombatRunHit = true,
                run_swing_remove_on_first = "0.05",
            },
            Combat = { delay_before_swing = { [1] = 0.11 }, delay_before_hit = { [1] = 0.22 },
                       Reaches = { Default = 6 } },
        },
    }
    local built = M.Parry.BuildPresets()
    local one = built and built["111111"] and built["111111"][1]
    print("[smoke] Parry.BuildPresets:", type(built), "записей id 111111 =",
          one and #built["111111"] or 0)
    print("[smoke]   запись 1:", one and one.folder, "combo=", one and one.combo,
          "swing=", one and one.swing, "hit=", one and one.hit,
          "reach=", one and one.reach, "running=", tostring(one and one.running),
          "runTrim=", one and one.runTrim)
    local two = built and built["222222"] and built["222222"][1]
    print("[smoke]   запись 2: combo=", two and two.combo, "swing=", two and two.swing,
          "hit=", two and two.hit, "reach=", two and two.reach)
    local run = built and built["333333"] and built["333333"][1]
    print("[smoke]   Run_Hit: combo=", run and run.combo, "swing=", run and run.swing,
          "hit=", run and run.hit, "reach=", run and run.reach,
          "running=", tostring(run and run.running), "runTrim=", run and run.runTrim,
          "источник = Presets.Combat:", tostring(run and run.preset ==
              M.Core.bno["CombatPresets"]["Presets"]["Combat"]))
    print("[smoke]   Idle пропущен:", tostring(built and built["444444"] == nil))
end)
print("[smoke] Parry.BuildPresets:", ok13, tostring(err13))

-- Сбор целей (bom = F2783) и отписка (cKb[14] = F5469)
local ok14, err14 = pcall(function()
    local function animation(name, id)
        return { Name = name, AnimationId = id, IsPlaying = true, Speed = 1, TimePosition = 0.1,
                 Stopped = services.RunService.Heartbeat,
                 IsA = function(_, class) return class == "Animation" end }
    end
    local track = animation("Swing_1", "rbxassetid://777")
    local animator = { AnimationPlayed = services.RunService.Heartbeat,
                       GetPlayingAnimationTracks = function() return { track } end }
    local humanoid = { Health = 100, FindFirstChildOfClass = function() return animator end }
    local function mob(name, position)
        local part = { Position = position, CFrame = { LookVector = Vector3.new(0, 0, -1) } }
        local model = {
            Name = name, Parent = services.Workspace,
            IsA = function(_, class) return class == "Model" end,
            FindFirstChildOfClass = function() return humanoid end,
            FindFirstChild = function(_, child)
                return child == "HumanoidRootPart" and part or nil
            end,
        }
        return model
    end
    local near, far = mob("Near", Vector3.new(5, 0, 0)), mob("Far", Vector3.new(900, 0, 0))
    local npcs = { GetChildren = function() return { near, far } end }
    local region = { Name = "R1", FindFirstChild = function() return npcs end }
    local regions = { GetChildren = function() return { region } end }
    local humanoids = { FindFirstChild = function() return regions end }
    services.Workspace.FindFirstChild = function(_, name)
        return name == "Humanoids" and humanoids or nil
    end
    services.Players.GetPlayers = function() return { services.Players.LocalPlayer } end

    M.Parry.state.generation = 0
    M.Parry.state["radius"] = 40
    M.Parry.state["npc"] = true
    M.Parry.state["pvp"] = true
    M.Parry.state["on"] = true
    M.Parry.AcquireTargets()
    local watched = 0
    for _ in pairs(M.Parry.state.watched) do watched = watched + 1 end
    print("[smoke] Parry.AcquireTargets: подписок =", watched,
          "ближний подписан =", tostring(M.Parry.state.watched[near] ~= nil),
          "дальний пропущен =", tostring(M.Parry.state.watched[far] == nil))

    -- отписка (cKb[14]): запись уходит, входы по этой модели снимаются
    M.Parry.state.entries[track] = { model = near, track = track }
    M.Parry.UnwatchModel(near)
    print("[smoke] Parry.UnwatchModel: запись убрана =",
          tostring(M.Parry.state.watched[near] == nil),
          "вход снят =", tostring(M.Parry.state.entries[track] == nil),
          "cKb[14] это отписка =", tostring(cKb[14] == M.Parry.UnwatchModel),
          "bpO это подписка =", tostring(bpO == M.Parry.TrackModel))

    -- шаг блока (bnl["step"] = F288): без входа и без проблем — только статус
    M.Parry.state["blockEntry"] = nil
    M.Parry.BlockWorkStep()
    print("[smoke] Parry.BlockWorkStep: статус =", tostring(M.Core.bpz["ParryStatus"]))
    M.Parry.state["on"] = false
    M.Parry.BlockWorkStep()
    print("[smoke] Parry.BlockWorkStep (off): статус =", tostring(M.Core.bpz["ParryStatus"]))
end)
print("[smoke] Parry.AcquireTargets/step:", ok14, tostring(err14))

-- Тик артефакта (M.Tick = pcall(тело) + task.wait(0.15))
local ok15, err15 = pcall(function()
    local okTick, errTick = pcall(M.Tick)
    print("[smoke] M.Tick:", okTick, tostring(errTick))
    -- ветка «медленной ходьбы»: tweaks[8562344] + WalkSpeed <= slow_walk_speed
    M.Combat.tweaks[8562344] = true
    M.Core.bno["CombatPresets"] = { Presets = {}, slow_walk_speed = "9" }
    local fakeCharacter = { WalkSpeed = 6 }
    cKb[124] = function() return fakeCharacter end
    M.Tick()
    print("[smoke] M.Tick walkspeed:", fakeCharacter["WalkSpeed"], "(ожидается 16)")
    M.Combat.tweaks[8562344] = nil
    M.Combat.tweaks["noStun"] = true
    M.Combat.tweaks["noRagdoll"] = true
    local okTick2 = pcall(M.Tick)
    print("[smoke] M.Tick (noStun/noRagdoll):", okTick2)
    M.Combat.tweaks["noStun"] = false
    M.Combat.tweaks["noRagdoll"] = false
    print("[smoke] cKb[51].BlockWork == cKb[99].parry =",
          tostring(M.Parry.state == cKb[51]["BlockWork"]), "bnl =", tostring(bnl == M.Parry.state))
end)
print("[smoke] M.Tick:", ok15, tostring(err15))
