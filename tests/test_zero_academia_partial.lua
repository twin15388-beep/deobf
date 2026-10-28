-- Static-recovery smoke and, when supplied, differential comparison with
-- unchanged selected children of a *corrected* PSU -> Lua 5.1 lift.
-- The protected script and its top-level bootstrap are NEVER executed.
-- lua5.1 tests/test_zero_academia_partial.lua <module.lua> [extracted-proto-dir]
local modulePath = assert(arg[1], "pass module path")
local protoDir = arg[2]

local function compare(a, b, where)
    if type(a) == "table" and type(b) == "table" then
        for key, value in pairs(a) do
            compare(value, b[key], where .. "." .. tostring(key))
        end
        for key in pairs(b) do
            assert(a[key] ~= nil, where .. " missing key " .. tostring(key))
        end
    elseif type(a) == "number" and type(b) == "number" then
        assert(math.abs(a - b) < 1e-9, where .. " numeric mismatch")
    else
        assert(a == b, where .. ": " .. tostring(a) .. " ~= " .. tostring(b))
    end
end

local function setup()
    local env = setmetatable({}, {__index = _G})
    local f = assert(loadfile(modulePath))
    setfenv(f, env)
    local module = f()
    local function original(name, ...)
        assert(protoDir, "pass extracted-proto-dir to run originals")
        local wrapper = assert(loadfile(protoDir .. "/" .. name .. ".luac"))
        setfenv(wrapper, env)
        if name == "npc_alive" then return wrapper end -- no captured upvalues
        return wrapper(...)
    end
    return env, module, original
end

local function record(events, ...)
    events[#events + 1] = {...}
end

local function label(events, name)
    local text
    return setmetatable({}, {
        __index = function(_, key) if key == "Text" then return text end end,
        __newindex = function(_, key, value)
            assert(key == "Text")
            text = value
            record(events, name, value)
        end,
    })
end

local function questSnapshotCase(folder, bytecode)
    local env, module, original = setup()
    local player = {Name = "Player"}
    local quests = {FindFirstChildWhichIsA = function(_, kind)
        assert(kind == "Folder")
        return folder
    end}
    env.workspace = {Quests = {Player = quests}}
    local result
    if bytecode then
        result = original("quest_snapshot", {Quests = quests})()
    else
        result = module.questSnapshot(player)
    end
    if folder then
        compare(result, {Name = folder.Name, Progress = folder.AmountKilled.Value,
            Target = folder.AmountNeeded.Value}, "questSnapshot")
    else
        assert(result == nil)
    end
    return result
end

local snapshot = {Name = "Help Hero", AmountKilled = {Value = 4},
    AmountNeeded = {Value = 7}}
compare(questSnapshotCase(snapshot, false),
    questSnapshotCase(snapshot, protoDir ~= nil), "questSnapshot differential")
compare(questSnapshotCase(nil, false),
    questSnapshotCase(nil, protoDir ~= nil), "questSnapshot missing")

local function npcCase(health, hasRoot, bytecode)
    local _, module, original = setup()
    local npc = health and {
        Humanoid = {Health = health},
        HumanoidRootPart = hasRoot and {} or nil,
        FindFirstChild = function(self, key) return self[key] end,
    } or nil
    if bytecode then return original("npc_alive")(npc) end
    return module.npcAlive(npc)
end
for _, case in ipairs({{nil, false}, {0, true}, {-1, true}, {1, false}, {20, true}}) do
    local a = npcCase(case[1], case[2], false)
    local b = npcCase(case[1], case[2], protoDir ~= nil)
    compare(a, b, "npcAlive")
    assert(a == (case[1] ~= nil and case[1] > 0 and case[2] == true))
end

local function questCase(kind, bytecode)
    local env, module, original = setup()
    local events = {}
    local state = {AutoQuest = kind ~= "disabled", QuestName = "Wanted Quest"}
    local data = {
        pending = {Name = "Wanted Quest", Progress = 1, Target = 4},
        completed = {Name = "Wanted Quest", Progress = 4, Target = 4},
        stale = {Name = "Other Quest", Progress = 2, Target = 3},
    }
    local reads = 0
    local function getQuest()
        reads = reads + 1
        record(events, "GetQuest", reads)
        if kind == "new" and reads == 1 then return nil end
        return data[kind == "new" and "pending" or kind]
    end
    local function remote(name)
        return {FireServer = function(_, value)
            record(events, name, value or "no-argument")
        end}
    end
    local remotes = {Quest = {
        CancelQuest = remote("CancelQuest"),
        AcceptQuest = remote("AcceptQuest"),
        CompleteQuest = remote("CompleteQuest"),
    }}
    local nameLabel = label(events, "nameLabel")
    local progressLabel = label(events, "progressLabel")
    env.wait = function(seconds)
        record(events, "wait", seconds or "no-argument")
        -- Allow exactly one iteration. Even when the flag becomes false here,
        -- the current loop iteration must finish as in the selected bytecode.
        state.AutoQuest = false
        return true
    end
    local deps = {getQuest = getQuest, remotes = remotes,
        nameLabel = nameLabel, progressLabel = progressLabel}
    if bytecode then
        original("auto_quest", state, {GetQuest = getQuest},
            {Remotes = remotes}, nameLabel, progressLabel)()
    else
        module.autoQuestLoop(state, deps)
    end
    return events
end
for _, kind in ipairs({"disabled", "pending", "completed", "new", "stale"}) do
    local a = questCase(kind, false)
    if protoDir then compare(a, questCase(kind, true), "autoQuest " .. kind) end
    if kind == "completed" then
        assert(a[#a - 1][1] == "CompleteQuest")
        assert(a[#a][3] == nil and a[#a][2] == "Progress: Completed")
    end
    if kind == "stale" then
        assert(a[#a][2] == "Progress: 2/3", "preserve old-quest behavior")
    end
end

local function vector(x, y, z)
    local value = {X = x, Y = y, Z = z, Magnitude = math.sqrt(x*x+y*y+z*z)}
    return setmetatable(value, {
        __add = function(a, b) return vector(a.X+b.X, a.Y+b.Y, a.Z+b.Z) end,
        __sub = function(a, b) return vector(a.X-b.X, a.Y-b.Y, a.Z-b.Z) end,
    })
end
local function frame(position, rotation)
    return setmetatable({Position = position, Rotation = rotation or 0}, {
        __mul = function(a, b) return frame(a.Position, a.Rotation + b.Rotation) end,
    })
end
local function tweenCase(rootY, bytecode)
    local env, module, original = setup()
    local events = {}
    local root = {Position = vector(0, rootY, 0)}
    local character = {HRP = root}
    local settings = {Vector3 = vector(5, 0, -2), Rotation = 90}
    local target = {HumanoidRootPart = {Position = vector(30, 2, 11)}}
    env.Vector3 = {new = vector}
    env.CFrame = {
        new = function(v) return frame(v) end,
        Angles = function(x) return frame(nil, x) end,
    }
    env.TweenInfo = {new = function(t, style, direction, repeatCount, reverses, delay)
        assert(style == "Linear" and direction == "Out")
        assert(repeatCount == 0 and reverses == false and delay == 0)
        return {time = t}
    end}
    env.Enum = {EasingStyle = {Linear = "Linear"}, EasingDirection = {Out = "Out"}}
    env.wait = function(seconds) record(events, "wait", seconds) end
    local tweenService = {}
    function tweenService:Create(subject, info, goal)
        assert(subject == root)
        local pos, angle = goal.CFrame.Position, goal.CFrame.Rotation
        record(events, "Tween", info.time, pos.X, pos.Y, pos.Z, angle)
        return {Play = function()
            record(events, "Play")
            root.Position = pos
        end}
    end
    if bytecode then
        original("tween_to_npc", {AutoFarm = settings}, character,
            {TS = tweenService})(target)
    else
        module.tweenToNpc(target, settings, {
            character = character, tweenService = tweenService,
        })
    end
    return events
end
for _, y in ipairs({-1, 30}) do
    local a = tweenCase(y, false)
    if protoDir then compare(a, tweenCase(y, true), "tween " .. y) end
    assert(#a == (y > 5 and 6 or 3))
end

local function attackCase(kind, ready, available, argument, bytecode)
    local env, module, original = setup()
    local events = {}
    local player = {Name = "Player"}
    local function remote(labelName)
        return {FireServer = function(_, value)
            record(events, labelName, value or "no-argument")
        end}
    end
    local root = {Quirk3 = {Z = remote("Z")}, Main = {Swing = remote("Swing")}}
    env.workspace = {Player = root}
    local ability = {KeyAvailable = function(key)
        record(events, "KeyAvailable", key)
        return available
    end, SwingAvailable = function()
        record(events, "SwingAvailable")
        return available
    end}
    local quirk = {GetQuirk = function()
        record(events, "GetQuirk")
        return "Quirk3"
    end}
    if bytecode then
        if kind == "key" then
            original("press_key", {PlayerReady = ready}, ability,
                {Player = player}, quirk)("Z", argument)
        else
            original("swing", {PlayerReady = ready}, ability,
                {Player = player})(argument)
        end
    elseif kind == "key" then
        module.pressKey("Z", argument, {
            playerReady = ready, keyAvailable = ability.KeyAvailable,
            player = player, getQuirk = quirk.GetQuirk,
        })
    else
        module.swing(argument, {
            playerReady = ready, swingAvailable = ability.SwingAvailable,
            player = player,
        })
    end
    return events
end
for _, kind in ipairs({"key", "swing"}) do
    for _, scenario in ipairs({{true, true, false}, {true, true, true},
            {true, false, true}, {false, true, false}}) do
        local argument = scenario[3] and "sample-frame" or nil
        local a = attackCase(kind, scenario[1], scenario[2], argument, false)
        if protoDir then
            compare(a, attackCase(kind, scenario[1], scenario[2], argument, true),
                "combat " .. kind)
        end
    end
end

local function spinCase(kind, bytecode)
    local env, module, original = setup()
    local events = {}
    local state = {QuirkSpin = {
        QuirkNames = kind == "matched" and "Explosion,Engine" or "Explosion",
        IDs = {[1] = "Engine", [2] = "Explosion"},
        AutoSpin = kind ~= "disabled",
    }}
    local labelValue = label(events, "spinLabel")
    local cash = kind == "no-cash" and 5000 or 6000
    local quirkCalls, spins = 0, 0
    local function split(text, sep)
        record(events, "Split", text, sep)
        local list = {}
        for name in (text .. sep):gmatch("(.-)" .. sep) do list[#list+1] = name end
        return list
    end
    local remotes = {Spin = {FireServer = function(_, action)
        record(events, "Spin", action)
        spins = spins + 1
        if kind == "not-matched" then cash = 5000 end
    end}}
    local methods = {
        GetPlayerStats = function()
            record(events, "GetPlayerStats")
            return {Cash = {Value = cash}}
        end,
        GetQuirk = function()
            quirkCalls = quirkCalls + 1
            record(events, "GetQuirk", quirkCalls)
            return quirkCalls < 3 and "Quirk1" or "Quirk2"
        end,
        GetQuirkAsName = function()
            record(events, "GetQuirkAsName")
            return "Explosion"
        end,
        GetQuirkAsID = function()
            record(events, "GetQuirkAsID")
            return kind == "not-matched" and 3 or 2
        end,
    }
    env.wait = function(seconds) record(events, "wait", seconds) end
    if bytecode then
        original("auto_spin", state, {Split = split}, methods,
            {Remotes = remotes}, labelValue)()
    else
        module.autoSpinLoop(state, {split = split, remotes = remotes,
            statusLabel = labelValue, getPlayerStats = methods.GetPlayerStats,
            getQuirk = methods.GetQuirk,
            getQuirkAsName = methods.GetQuirkAsName,
            getQuirkAsID = methods.GetQuirkAsID})
    end
    assert(spins == ((kind == "disabled" or kind == "no-cash") and 0 or 1))
    return events
end
for _, kind in ipairs({"disabled", "no-cash", "matched", "not-matched"}) do
    local a = spinCase(kind, false)
    if protoDir then compare(a, spinCase(kind, true), "autoSpin " .. kind) end
end

local function farmCase(kind, bytecode)
    local env, module, original = setup()
    local events = {}
    local character = {Humanoid = {Health = 20}}
    character.Humanoid.ChangeState = function(_, newState)
        record(events, "ChangeState", newState)
    end
    local npc = {Humanoid = {Health = 10},
        HumanoidRootPart = {CFrame = "target-frame", Position = "target-vector"}}
    npc.FindFirstChild = function(self, name) return self[name] end
    local state = {
        AutoFarm = {NameVerified = kind ~= "unverified",
            NPCs = {"Earth Beast"}, Retries = 2, Enabled = kind == "working"},
        Keys = {{"Z", true, "CFrame", "AutoFarm++"},
            {"X", true, "Vector3", "AutoFarm++"},
            {"Swing", true, nil, "AutoFarm++"}},
    }
    local statusLabel = label(events, "status")
    env.wait = function(seconds)
        record(events, "wait", seconds or "no-argument")
        return true
    end
    local runService = {Stepped = {Connect = function(_, callback)
        record(events, "Connect", "Stepped")
        callback() -- isolated callback, no RenderStepped/live Roblox
        return {Disconnect = function() record(events, "Disconnect") end}
    end}}
    function runService:BindToRenderStep(name, priority, callback)
        record(events, "Bind", name, priority)
        callback()
    end
    function runService:UnbindFromRenderStep(name)
        record(events, "Unbind", name)
    end
    local function getNPC(name)
        record(events, "GetNPC", name)
        if kind == "missing" then return nil end
        return npc
    end
    local function valid(target)
        record(events, "NPCMetReq", target == npc)
        return module.npcAlive(target)
    end
    local function tween(target)
        assert(target == npc)
        record(events, "TweenToModel")
    end
    local presses = 0
    local function useKey(key, value)
        presses = presses + 1
        record(events, "EzKeyPress", key, value or "no-argument")
        if presses == 3 then
            npc.Humanoid.Health = 0
            state.AutoFarm.Enabled = false
        end
    end
    local deps = {statusLabel = statusLabel, character = character,
        runService = runService, getNPC = getNPC, npcValid = valid,
        tweenToModel = tween, useKey = useKey}
    local success, err
    if bytecode then
        success, err = pcall(function()
            original("auto_farm", state, statusLabel, character,
                {GetNPC = getNPC, NPCMetReq = valid},
                {RunService = runService}, {TweenToModel = tween},
                {EzKeyPress = useKey})()
        end)
    else
        success, err = pcall(module.autoFarm, state, deps)
    end
    if kind == "missing" then
        assert(not success and err:find("Retry exceeded %(2%) NPC%[1%] not found"),
            tostring(err))
    else
        assert(success, tostring(err))
    end
    return events
end
for _, kind in ipairs({"unverified", "ready", "working", "missing"}) do
    local a = farmCase(kind, false)
    if protoDir then compare(a, farmCase(kind, true), "autoFarm " .. kind) end
end
print("OK Zero Academia: quest (5), NPC (5), movement (2), combat (8), spin (4), farm (4); "
    .. (protoDir and "differential vs corrected selected prototypes" or "mock smoke only"))
