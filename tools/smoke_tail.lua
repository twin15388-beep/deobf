
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
    local model = {
        Parent = workspaceTable,
        Position = Vector3.new(0, 0, 0),
        CFrame = { LookVector = Vector3.new(0, 0, -1) },
        FindFirstChildOfClass = function() return humanoid end,
        FindFirstChild = function() return nil end,
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
