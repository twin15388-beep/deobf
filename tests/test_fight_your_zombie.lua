-- Offline mock test of the RECOVERED WAD output, never its protected README.
-- No real HttpGet/loadstring, Roblox services, file APIs, or external UI execute.
-- Lua 5.1: lua tests/test_fight_your_zombie.lua 'dobf scripts 1.0/Fight Your Zombie - MoMoHub.lua'
local path = assert(arg[1], "pass the recovered Lua file")
local events, controls, loops = {}, {}, {}
local function record(kind, value)
    events[#events + 1] = {kind, value}
end
local function count(kind)
    local n = 0
    for _, event in ipairs(events) do
        if event[1] == kind then n = n + 1 end
    end
    return n
end
local function last(kind)
    for i = #events, 1, -1 do
        if events[i][1] == kind then return events[i][2] end
    end
end
local function node(values)
    function values:FindFirstChild(name) return rawget(self, name) end
    function values:GetChildren() return self.children or {} end
    return values
end
local vecMt = {}
local function vec(x, y, z)
    return setmetatable({X = x, Y = y, Z = z}, vecMt)
end
vecMt.__index = function(self, key)
    if key == "Magnitude" then
        return math.sqrt(self.X ^ 2 + self.Y ^ 2 + self.Z ^ 2)
    end
end
vecMt.__add = function(a, b)
    return vec(a.X + b.X, a.Y + b.Y, a.Z + b.Z)
end
vecMt.__sub = function(a, b)
    return vec(a.X - b.X, a.Y - b.Y, a.Z - b.Z)
end
local cfMt = {}
local function cf(position)
    return setmetatable({Position = position}, cfMt)
end
cfMt.__mul = function(a, b)
    return cf(a.Position or b.Position)
end
local root = node({Position = vec(0, 0, 0)})
local character = node({HumanoidRootPart = root, Humanoid = {Health = 100, WalkSpeed = 16}})
function character:WaitForChild(key)
    return assert(self[key])
end
local player = node({Character = character, Data = node({Axes = node({children = {
    node({Name = "23", AxeName = {Value = "Bronze"}}),
}})})})
player.CharacterAdded = {Wait = function() return character end}
player.Idled = {Connect = function() error("Anti-AFK was not enabled") end}
local block = node({CFrame = cf(vec(8, 0, 0))})
function block:IsA(class) return class == "BasePart" end
function block:FindFirstChildWhichIsA(class)
    assert(class == "ProximityPrompt")
    return "lucky-block-prompt"
end
local nearTree = node({Position = vec(4, 0, 0)})
function nearTree:IsA(class) return class == "BasePart" end
local farTree = node({Position = vec(100, 0, 0)})
function farTree:IsA(class) return class == "BasePart" end
local nearZombie = node({RootPart = node({Position = vec(2, 0, 0), CFrame = cf(vec(2, 0, 0))})})
local farZombie = node({RootPart = node({Position = vec(40, 0, 0), CFrame = cf(vec(40, 0, 0))})})
local hitbox = {Size = nil, CanCollide = true}
local workspace = node({
    Debris = node({Normal = node({Main = block})}),
    WalkingZombies = node({children = {farZombie, nearZombie}}),
    Plots = node({children = {
        node({PlotContents = node({TreeSpawn = farTree})}),
        node({PlotContents = node({TreeSpawn = nearTree})}),
    }}),
    Orbs = node({children = {node({Name = "Coin", HitBox = hitbox})}}),
})
local remotes = {
    EquipAxe = {FireServer = function(_, id) record("equip", id) end},
    AxeSwing = {FireServer = function() record("swing", true) end},
}
local services = {
    Players = {LocalPlayer = player}, VirtualUser = {},
    UserInputService = {InputChanged = {Connect = function() end}},
    VirtualInputManager = {}, CoreGui = {}, ReplicatedStorage = {Remotes = remotes},
    HttpService = {},
}
local game = {GetService = function(_, name) return assert(services[name], name) end}
function game:HttpGet(url)
    -- Only the UI framework may be requested; no real network access.
    assert(url:find("https://raw.githubusercontent.com/x2zu/", 1, true) == 1)
    assert(url:find("/Framework.luau", 1, true))
    record("UI URL", url)
    return "MOCK UI -- no remote Lua fetched"
end
local function widget(_, spec)
    if spec.Callback then controls[spec.Title] = spec.Callback end
    return {Refresh = function() end}
end
local tab = {Section = function() end, Toggle = widget,
    Dropdown = widget, Slider = widget, Button = widget}
local window = {Tab = function() return tab end, Notify = function() end}
local framework = {Window = function() return window end}
local frame = {
    new = function(a, b, c)
        if type(a) == "table" then return cf(a) end
        return cf(vec(a, b, c))
    end,
}
local tickLimit
local task = {
    spawn = function(fn) loops[#loops + 1] = fn end,
    wait = function()
        if tickLimit then
            tickLimit = tickLimit - 1
            return tickLimit >= 0
        end
        return true
    end,
}
local sandbox = {
    game = game, workspace = workspace, task = task,
    -- Inject ONLY a fake UI framework. Never evaluate HttpGet's return value.
    loadstring = function(payload)
        assert(payload == "MOCK UI -- no remote Lua fetched")
        return function() return framework end
    end,
    fireproximityprompt = function(prompt) record("prompt", prompt) end,
    Instance = {new = function(class)
        return {Name = class, InputBegan = {Connect = function() end},
            InputEnded = {Connect = function() end}}
    end},
    Color3 = {fromRGB = function() return {} end},
    UDim2 = {new = function() return {} end},
    Vector3 = {new = vec}, CFrame = frame,
    Enum = {KeyCode = {LeftControl = "LeftControl"}, UserInputType = {
        MouseButton1 = "MouseButton1", Touch = "Touch", MouseMovement = "MouseMovement"}},
    pairs = pairs, ipairs = ipairs, assert = assert, error = error,
    tonumber = tonumber, tostring = tostring, type = type,
    pcall = pcall, math = math, table = table, string = string,
    setmetatable = setmetatable,
}
sandbox._G = sandbox
setfenv(assert(loadfile(path)), sandbox)()
assert(count("UI URL") == 1 and #loops == 4)
assert(count("prompt") == 0 and count("equip") == 0) -- no loop started yet
local function run(index)
    tickLimit = 1 -- one while iteration; do not allow unbounded recovered loops
    loops[index]()
    tickLimit = nil
end
controls["[P1] Auto Lucky Block"](true)
run(1)
assert(last("prompt") == "lucky-block-prompt")
assert(root.CFrame.Position.X == 8)
controls["[P2] Auto Walking Zombie"](true)
run(2) -- Lucky Block takes priority; v13 blocks zombie farm
assert(root.CFrame.Position.X == 8)
controls["[P3] Auto Plot Farm"](true)
assert(character.Humanoid.Health == 0, "upstream plot setup must kill character")
character.Humanoid.Health = 100 -- simulated respawn
run(3) -- priority flags still prevent plot farming
assert(root.CFrame.Position.X == 8)
controls["[P1] Auto Lucky Block"](false)
run(1)
run(2)
assert(root.CFrame.Position.X == 8, "BUG: disabling Lucky Block retains v13")
-- Only losing the block *while its toggle is enabled* resets v13.
controls["[P1] Auto Lucky Block"](true)
workspace.Debris.Normal.Main = nil
run(1)
controls["[P1] Auto Lucky Block"](false)
run(1)
run(2)
assert(root.CFrame.Position.X == 2, "should select nearest walking zombie")
run(3)
assert(root.CFrame.Position.X == 2, "walking zombie has priority over plot")
controls["[P2] Auto Walking Zombie"](false)
run(2)
run(3)
assert(root.CFrame.Position.X == 2, "BUG: disabling zombie farm retains v12")
-- Again: clear the cached priority by losing the target while enabled.
controls["[P2] Auto Walking Zombie"](true)
workspace.WalkingZombies = nil
run(2)
controls["[P2] Auto Walking Zombie"](false)
run(2)
run(3)
assert(root.CFrame.Position.X == 4, "should select nearest TreeSpawn")
controls["Kill Aura"](true)
run(4)
assert(count("equip") == 0 and count("swing") == 0, "no axe selected")
controls["Select Weapon"]("Bronze (23)")
controls["Auto Collect Coin"](true)
run(4)
assert(last("equip") == "23" and count("swing") == 1)
assert(hitbox.Size.X == 50 and hitbox.Size.Y == 50 and hitbox.Size.Z == 50)
assert(hitbox.CanCollide == false)
controls["WalkSpeed"](120)
assert(character.Humanoid.WalkSpeed == 120)
print("OK Fight Your Zombie: 17 post-load offline assertions; UI/network/files stubbed, no Roblox")
