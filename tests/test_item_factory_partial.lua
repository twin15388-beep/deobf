-- Item Factory (MoonSec V3): offline smoke tests and optional DIFFERENTIAL tests
-- against selected, unmodified children of the static Lua 5.1 recovery.
-- NEVER load the protected input or its top-level recovered chunk here.
-- lua5.1 tests/test_item_factory_partial.lua <partial.lua> [extracted-dir]
local modulePath = assert(arg[1], "pass module path")
local protoDir = arg[2]
local mod = assert(loadfile(modulePath))()
local mockCases, differentialCases = 0, 0

local function compare(a, b, name)
    if type(a) == "table" and type(b) == "table" then
        for key, value in pairs(a) do
            compare(value, b[key], name .. "." .. tostring(key))
        end
        for key in pairs(b) do
            assert(a[key] ~= nil, name .. " missing key " .. tostring(key))
        end
    elseif type(a) == "number" and type(b) == "number" then
        assert(math.abs(a - b) < 1e-8, name .. ": " .. a .. " ~= " .. b)
    else
        assert(a == b, name .. ": " .. tostring(a) .. " ~= " .. tostring(b))
    end
end

local function runCase(name, run)
    local result = run(false)
    mockCases = mockCases + 1
    if protoDir then
        compare(result, run(true), name)
        differentialCases = differentialCases + 1
    end
end

local suffixes = {"K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "O", "N", "D", "UnD", "DD", "TD", "QdD", "QnD", "SxD", "SpD", "OcD", "ND", "Vn", "UnVn", "DVn", "TVn", "QdVn", "QnVn", "SxVn", "SpVn", "OVn", "NVn", "Tri"}

local function world(opts)
    opts = opts or {}
    local events = {}
    local function record(...)
        events[#events + 1] = {...}
    end
    local function tool(name, kind, rarity, speed)
        local object = {Name = name, ItemInfo = {Rarity = {Value = rarity or 1}},
            WeaponStats = speed and {Speed = {Value = speed}} or nil}
        function object:IsA(class) return kind == class end
        function object:FindFirstChild(child) return self[child] end
        return setmetatable(object, {__newindex = function(self, key, value)
            if key == "Parent" then record("drop", name, value.Name) end
            rawset(self, key, value)
        end})
    end
    local bag = {}
    if opts.bag then
        for _, spec in ipairs(opts.bag) do
            bag[#bag + 1] = tool(spec[1], spec[2] or "Tool", spec[3], spec[4])
        end
    end
    local equipped = opts.equipped and tool(unpack(opts.equipped)) or nil
    local humanoid = {Health = opts.health or 100, MaxHealth = opts.maxHealth or 100}
    if opts.noHumanoid then humanoid = nil end
    if humanoid then
        function humanoid:EquipTool(value) record("equip", value and value.Name or "nil") end
        function humanoid:UnequipTools() record("unequip") end
        function humanoid:MoveTo(value) record("move", value) end
    end
    local character = {}
    function character:FindFirstChildOfClass(class)
        if class == "Tool" then return equipped end
        if class == "Humanoid" then return humanoid end
    end
    local player = {Name = "Tester", Character = character}
    local backpack = {}
    function backpack:GetChildren() return bag end
    player.Backpack = backpack
    player.PlayerGui = {MainGUI = {Upgrades = {GetDescendants = function()
        return opts.upgrades or {}
    end}}}
    local distanceReads = 0
    function player:DistanceFromCharacter(position)
        record("distance", position)
        distanceReads = distanceReads + 1
        if opts.distanceSequence then
            return opts.distanceSequence[math.min(distanceReads, #opts.distanceSequence)]
        end
        return position
    end
    local workspace = {Name = "Workspace", CurrentCamera = {
        ViewportSize = "view-size", CFrame = "camera-frame",
    }, Islands = { ["Tester Island"] = {
        SellStation = {MainTouch = {Position = 1234}}
    }}}
    function workspace:GetChildren() return opts.targets or {} end
    function workspace:FindFirstChild(mapName) return opts.maps and opts.maps[mapName] end
    local players = {GetPlayerFromCharacter = function(_, model)
        return model.Player and {Name = "Another Player"} or nil
    end}
    local remote = {FireServer = function(_, map)
        record("GoPlaces", map)
    end}
    local replicatedStorage = {Events = {GoPlaces = remote}}
    local game = {Players = players}
    function game:GetService(service)
        assert(service == "ReplicatedStorage" or service == "Workspace")
        return service == "Workspace" and workspace or replicatedStorage
    end
    local enum = {PartType = {Cylinder = "Cylinder"}}
    local brickColor = {new = function(label) return label end}
    local clock = opts.clock or 10
    local function wait(seconds)
        record("wait", seconds or "without argument")
        if seconds == nil and opts.healOnWait then humanoid.Health = humanoid.MaxHealth end
    end
    local virtualUser = {ClickButton1 = function(_, size, frame)
        record("click", size, frame)
    end}
    local deps = {player = player, workspace = workspace, players = players,
        Enum = enum, BrickColor = brickColor, replicatedStorage = replicatedStorage,
        virtualUser = virtualUser, wait = wait, tick = function() return clock end,
        moveTo = function(_, position, callback)
            record("moveTo helper", position)
            if opts.callOnArrival then callback() end
        end,
        press = function(button) record("Press", button.Text) end,
        getconnections = function(signal)
            return {{Fire = function() record("connection", signal) end}}
        end,
    }
    local env = setmetatable({workspace = workspace, game = game,
        Enum = enum, BrickColor = brickColor, wait = wait, tick = deps.tick,
        Press = deps.press, moveTo = deps.moveTo, getconnections = deps.getconnections,
        table = setmetatable({find = function(array, value)
            for i, element in ipairs(array) do if element == value then return i end end
        end}, {__index = table})}, {__index = _G})
    local function original(index, ...)
        assert(protoDir, "provide selected bytecode chunks for a differential run")
        local path = protoDir .. "/0_" .. index .. ".luac"
        local file = assert(loadfile(path), "bytecode child " .. index .. " missing")
        setfenv(file, env)
        if index == 12 or index == 21 or index == 22 or index == 0 then
            error("original child is invalid or intentionally excluded: " .. index)
        end
        if index == 25 or index == 8 or index == 18 or index == 11
                or index == 2 or index == 10 or index == 16
                or index == 20 or index == 23 or index == 27 then
            return file(...)
        end
        error("unexpected child " .. index)
    end
    return {events = events, record = record, tool = tool, bag = bag,
        player = player, humanoid = humanoid, workspace = workspace,
        deps = deps, env = env, original = original}
end

local function model(name, distance, health, isPlayer, isModel)
    local object = {Name = name, Humanoid = {Health = health},
        HumanoidRootPart = {Position = distance}, Player = isPlayer}
    function object:FindFirstChildOfClass(class)
        if class == "Humanoid" then return self.Humanoid end
    end
    function object:FindFirstChild(child) return self[child] end
    function object:IsA(class) return isModel ~= false and class == "Model" end
    return object
end

local near = model("near-npc", 200, 5)
local far = model("far-npc", 550, 8)
local dead = model("dead-npc", 100, 1)
local playerModel = model("player", 10, 100, true)
local further = model("further-npc", 350, 80)
local nonModel = model("part", 4, 9, nil, false)
for _, scenario in ipairs({
    {name = "empty", targets = {}},
    {name = "far", targets = {far}},
    {name = "filter", targets = {playerModel, dead, nonModel}},
    {name = "nearest", targets = {further, near, far}},
    {name = "boundary", targets = {model("at-500", 500, 2), near}},
}) do
    runCase("FindClosest " .. scenario.name, function(bytecode)
        local w = world({targets = scenario.targets})
        local target
        if bytecode then target = w.original(18, w.player)()
        else target = mod.findClosest(w.deps) end
        return {name = target and target.Name or false, events = w.events}
    end)
end

for _, selectedMode in ipairs({"PvE", "PvP", "KOTH", "wrong"}) do
    runCase("onSelectedMap " .. selectedMode, function(bytecode)
        local w = world()
        local function part(name, position, shape, collide, isPart)
            local obj = {Name = name, Position = position, Shape = shape,
                CanCollide = collide}
            function obj:IsA(class) return isPart ~= false and class == "Part" end
            return obj
        end
        local nearPart = part("near", 90, "Cylinder", true)
        local farPart = part("far", 151, "Cylinder", true)
        local other = part("other", 30, "Sphere", true, false)
        local map = {GetDescendants = function() return {nearPart, farPart, other} end}
        w.workspace.FindFirstChild = function(_, name)
            if (selectedMode == "PvE" and name == "NormalMap")
                    or (selectedMode == "PvP" and name == "PVPMap")
                    or (selectedMode == "KOTH" and name == "KOTHMap") then
                return map
            end
        end
        local state = mod.defaultState()
        state.selectedMode = selectedMode
        local outcome
        if bytecode then outcome = w.original(11, selectedMode, w.player, "Home")()
        else outcome = mod.onSelectedMap(state, w.deps) end
        if not bytecode then
            assert(state.currentMap == (outcome and selectedMode or "Home"))
        end
        return {onMap = outcome, near = nearPart.CanCollide,
            far = farPart.CanCollide, other = other.CanCollide, events = w.events}
    end)
end

for _, config in ipairs({
    {name = "disabled", autoKill = false, equipped = {"sword", "Tool", 2, 12}},
    {name = "already selected", autoKill = true,
        equipped = {"sword", "Tool", 2, 12}, same = true},
    {name = "choose", autoKill = true, equipped = {"sword", "Tool", 2, 12}},
    {name = "missing humanoid", autoKill = true, noHumanoid = true},
}) do
    runCase("Equip " .. config.name, function(bytecode)
        local w = world(config)
        local selected = config.same and w.player.Character:FindFirstChildOfClass("Tool")
            or w.tool("selected", "Tool", 10, 25)
        local state = mod.defaultState()
        state.autoKill = config.autoKill
        state.selectedTool = selected
        if bytecode then w.original(27, config.autoKill, w.player, selected)()
        else mod.equip(state, w.deps) end
        return w.events
    end)
end

for _, config in ipairs({
    {name = "disabled", speedHack = false},
    {name = "raise", speedHack = true, speedModifier = 38},
    {name = "low target", speedHack = true, speedModifier = 10},
}) do
    runCase("Speed " .. config.name, function(bytecode)
        local w = world({equipped = {"in-hand", "Tool", 6, 12},
            bag = {{"bag-low", "Tool", 5, 20}, {"bag-high", "Tool", 5, 50},
                {"other", "Decoration", 8, 1}}})
        local state = mod.defaultState()
        state.speedHack = config.speedHack
        state.speedModifier = config.speedModifier or 38
        if bytecode then w.original(2, config.speedHack, w.player, state.speedModifier)()
        else mod.speed(state, w.deps) end
        return {events = w.events, equipped = w.player.Character:FindFirstChildOfClass("Tool").WeaponStats.Speed.Value,
            low = w.bag[1].WeaponStats.Speed.Value,
            high = w.bag[2].WeaponStats.Speed.Value, other = w.bag[3].WeaponStats.Speed.Value}
    end)
end

for _, config in ipairs({
    {name = "drop", rarityThreshold = 15},
    {name = "keep", rarityThreshold = 2},
    {name = "no humanoid safe", rarityThreshold = 2, noHumanoid = true},
}) do
    runCase("dropBelowRarity " .. config.name, function(bytecode)
        local w = world({bag = {{"trash", "Tool", 3}, {"rare", "Tool", 18},
            {"selected", "Tool", 2}, {"not tool", "Decoration", 1}},
            noHumanoid = config.noHumanoid})
        local state = mod.defaultState()
        state.rarityThreshold, state.selectedTool = config.rarityThreshold, w.bag[3]
        state.busy = true
        if bytecode then w.original(16, w.player, state.rarityThreshold, w.bag[3], true)()
        else mod.dropBelowRarity(state, w.deps) end
        if not bytecode then assert(state.busy == false) end
        return w.events
    end)
end

for _, config in ipairs({
    {name = "auto sell off", bagCount = 9, autoSell = false},
    {name = "too few", bagCount = 8, autoSell = true},
    {name = "busy", bagCount = 9, autoSell = true, busy = true},
    {name = "travel twice", bagCount = 9, autoSell = true,
        distanceSequence = {500, 175}, callOnArrival = true},
}) do
    runCase("dropTrash " .. config.name, function(bytecode)
        local bag = {}
        for i = 1, config.bagCount do bag[i] = {"tool" .. i, "Tool", 22} end
        local w = world({bag = bag, distanceSequence = config.distanceSequence,
            callOnArrival = config.callOnArrival})
        local state = mod.defaultState()
        state.autoSell = config.autoSell
        state.busy = config.busy or false
        state.selectedTool = w.bag[1]
        if bytecode then
            local callback = w.original(16, w.player, state.rarityThreshold, w.bag[1], false)
            w.original(10, w.player, config.autoSell, state.busy, "Home", callback)()
        else mod.dropTrash(state, w.deps) end
        return w.events
    end)
end

for _, config in ipairs({
    {name = "healthy", health = 85, threshold = 25},
    {name = "already busy", health = 10, busy = true},
    {name = "heal", health = 25, threshold = 25,
        distanceSequence = {220, 50}, healOnWait = true},
}) do
    runCase("retreatAtHealth " .. config.name, function(bytecode)
        local w = world(config)
        local state = mod.defaultState()
        state.healthThreshold = config.threshold or 25
        state.busy = config.busy or false
        if bytecode then
            w.original(20, w.player, state.healthThreshold, state.busy, "PvE")()
        else
            mod.retreatAtHealth(state, w.deps)
            if config.name == "heal" then
                assert(state.busy == false and state.currentMap == "Home")
            end
        end
        return w.events
    end)
end

for _, text in ipairs({"123", "12K", "2.5M", "1B", "0Qd", "3Tri", "8Oops"}) do
    runCase("fromSuffixString " .. text, function(bytecode)
        local w = world()
        local value = bytecode and w.original(8, suffixes)(text)
            or mod.fromSuffixString(text)
        return {result = value}
    end)
end

local function button(text, machine, color)
    return {Name = "Upgrade", Text = text, BackgroundColor = color or "Bright green",
        Parent = {Name = machine or "Conveyor"}}
end
for _, config in ipairs({
    {name = "none", buttons = {}},
    {name = "levels", buttons = {button("Lvl [ 2] ( 10K)"),
        button("Lvl [ 2] ( 5K)"), button("Lvl [ 3] ( 1M)")}},
    {name = "plain", buttons = {button("Cost ( 8K)"), button("Cost ( 4K)")}},
    {name = "filtered", buttons = {button("Cost ( 8K)", "Molder"),
        button("Cost ( 4K)", "Conveyor", "Bright red")}},
}) do
    runCase("upgrade " .. config.name, function(bytecode)
        local w = world({upgrades = config.buttons})
        local state = mod.defaultState()
        state.upgradeMachines.Conveyor = true
        if bytecode then
            w.env.fromSuffixString = w.original(8, suffixes)
            w.original(25, w.player, state.upgradeMachines)()
        else mod.upgrade(state, w.deps) end
        return w.events
    end)
end

-- Child 0_12 cannot be loaded by Lua 5.1; this helper is smoke-tested only.
do
    local w = world()
    mod.press({MouseButton1Click = "click", MouseButton1Down = "down",
        Activated = "activated"}, w.deps)
    compare(w.events, {{"connection", "click"}, {"connection", "down"},
        {"connection", "activated"}}, "press helper smoke")
    mockCases = mockCases + 1
end

for _, config in ipairs({
    {name = "busy", busy = true, enabled = true},
    {name = "disabled", enabled = false},
    {name = "no kill", enabled = true, target = true},
    {name = "travel selected", enabled = true, autoKill = true,
        currentMap = "Home"},
    {name = "travel home", enabled = true, autoKill = true,
        currentMap = "PvP"},
    {name = "attack", enabled = true, autoKill = true,
        onMap = true, target = true, currentMap = "PvE"},
    {name = "attack KOTH", enabled = true, autoKill = true,
        onMap = true, target = true, currentMap = "KOTH"},
}) do
    runCase("farmTick " .. config.name, function(bytecode)
        local w = world()
        local target = config.target and model("farm-npc", 80, 12) or false
        local state = mod.defaultState()
        state.enabled, state.busy, state.autoKill = config.enabled or false,
            config.busy or false, config.autoKill or false
        state.currentMap = config.currentMap or "Home"
        state.selectedMode = config.name == "attack KOTH" and "KOTH" or "PvE"
        local mocks = {}
        for _, name in ipairs({"upgrade", "dropTrash", "speed", "onSelectedMap",
                "findClosest", "equip", "retreatAtHealth"}) do
            mocks[name] = mod[name]
            mod[name] = function()
                w.record(name)
                if name == "onSelectedMap" then return config.onMap or false end
                if name == "findClosest" then return target end
            end
        end
        local env = w.env
        env.upgrade = function() w.record("upgrade") end
        env.DropTrash = function() w.record("dropTrash") end
        env.Speed = function() w.record("speed") end
        env.onSelectedMap = function()
            w.record("onSelectedMap")
            return config.onMap or false
        end
        env.FindClosest = function() w.record("findClosest"); return target end
        env.Equip = function() w.record("equip") end
        env.OhNoes = function() w.record("retreatAtHealth") end
        w.workspace.KOTHMap = {KOTH = {KOTHGUI = {HoldTime = {Text = "safe"}},
            KOTHContested = {Position = "hill-position"}}}
        local err = nil
        if bytecode then
            local original = w.original(23, state.busy, state.enabled,
                0, 0, state.autoKill, state.currentMap, state.selectedMode,
                0, w.deps.virtualUser, w.player)
            local success, message = pcall(original)
            if not success then err = tostring(message) end
        else
            local success, message = pcall(mod.farmTick, state, w.deps)
            if not success then err = tostring(message) end
        end
        for name, fn in pairs(mocks) do mod[name] = fn end
        assert(not err, "farmTick " .. config.name .. ": " .. tostring(err))
        return w.events
    end)
end

assert(mockCases == 45 and (protoDir == nil or differentialCases == 44),
    "expected 44 differential scenarios plus 1 press smoke")
print("Item Factory: " .. mockCases .. " offline mock cases, " .. differentialCases ..
    " comparisons to isolated recovered prototypes (never the protected top-level)")
