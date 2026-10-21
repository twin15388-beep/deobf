-- Isolated smoke and optional *bytecode differential* test for GPO's numeric teleport.
-- arg[1]: published partial module. Optional arg[2]/arg[3]/arg[4]: extracted
-- Lua 5.1 prototypes 0_7 (calculatetime), 0_10 (teleport), and 0_20
-- (takeQuest) from PSU-lifted GPO.luac.
-- This never loads or executes the protected top-level game script; it uses
-- mock Vector3/TweenService and defers spawned callbacks. NOT a Roblox test.
local source = assert(arg[1], "pass the published partial GPO module")
assert((arg[2] == nil) == (arg[3] == nil), "pass both original movement prototypes or neither")
assert(not arg[4] or arg[2], "pass movement bytecode for quest comparison")

local function vector(x, y, z)
    return setmetatable({ X = x, Y = y, Z = z,
        Magnitude = math.sqrt(x * x + y * y + z * z),
    }, {
        __sub = function(a, b)
            return vector(a.X - b.X, a.Y - b.Y, a.Z - b.Z)
        end,
    })
end

local function setup(initial, speed)
    local events = {}
    local callbacks = {}
    local humanoid = { ChangeState = function() end }
    local root = { Position = vector(initial[1], initial[2], initial[3]),
        Parent = { Humanoid = humanoid },
    }
    local tweenService = {}
    function tweenService:Create(target, info, goal)
        assert(target == root)
        local kind = goal.Position and "Position" or "CFrame"
        local value = assert(goal[kind])
        events[#events + 1] = { "Create", kind, value.X, value.Y, value.Z,
            info.seconds, info.style, info.direction, value.arguments or 0 }
        local tween = { goal = goal }
        function tween:Play()
            events[#events + 1] = { "Play", kind }
            root.Position = vector(value.X, value.Y, value.Z)
        end
        tween.Completed = {
            Wait = function()
                events[#events + 1] = { "Wait", kind }
            end,
            wait = function()
                events[#events + 1] = { "wait", kind }
            end,
        }
        return tween
    end
    local game = { Players = { LocalPlayer = {
        Character = { HumanoidRootPart = root, Humanoid = humanoid },
    } } }
    local replicated = { Events = { Quest = {
        InvokeServer = function(_, payload)
            events[#events + 1] = { "Quest", payload[1], payload[2], #payload }
        end,
    } } }
    function game:GetService(name)
        if name == "ReplicatedStorage" then return replicated end
        assert(name == "TweenService")
        return tweenService
    end
    local mockGlobal = { speed = speed }
    local env = {
        game = game, _G = mockGlobal,
        Vector3 = { new = vector },
        CFrame = { new = function(...)
            local x, y, z = ...
            return { X = x, Y = y, Z = z, arguments = select("#", ...) }
        end },
        TweenInfo = { new = function(seconds, style, direction)
            return { seconds = seconds, style = style, direction = direction }
        end },
        Enum = { EasingStyle = { Linear = "Linear" },
            EasingDirection = { InOut = "InOut" } },
        getgenv = function() return { noclip = false } end,
        spawn = function(callback)
            callbacks[#callbacks + 1] = callback -- NEVER run an infinite movement loop
            events[#events + 1] = { "spawn" }
        end,
        wait = function() error("unexpected wait in deferred callback") end,
        math = math, type = type, tostring = tostring, error = error,
    }
    return env, events, root, callbacks
end

local function loadModule(env)
    local chunk = assert(loadfile(source))
    setfenv(chunk, env)
    return chunk()
end

local function evaluate(initial, target, speed, useOriginal)
    local env, events, root, callbacks = setup(initial, speed)
    local func
    if useOriginal then
        local calc = assert(loadfile(arg[2]))
        local original = assert(loadfile(arg[3]))
        setfenv(calc, env)
        setfenv(original, env)
        env.calculatetime = calc
        func = original
    else
        func = loadModule(env).teleportNumeric
    end
    -- Some original callbacks pass 12 CFrame components. The extracted Lua
    -- prototype declares only x/y/z; compare whether extras actually matter.
    local tween, duration = func(unpack(target))
    assert(tween.goal.CFrame.X == target[1])
    assert(env._G.teleporting == false and #callbacks == 1)
    assert(#events >= 4)
    return duration, events, root
end

local function equal(a, b, context)
    if type(a) == "number" and type(b) == "number" then
        assert(math.abs(a - b) < 1e-9, context .. ": numbers differ")
    elseif type(a) == "table" and type(b) == "table" then
        assert(#a == #b, context .. ": table lengths differ")
        for i = 1, #a do
            equal(a[i], b[i], context .. "/" .. i)
        end
    else
        assert(a == b, context .. ": values differ")
    end
end

local buyBarrelCFrame = {-561.834045, 11.9474373, -4466.64453,
    0.0234939456, -5.12754212e-8, -0.999723971,
    -3.6866743e-9, 1, -5.13762188e-8,
    0.999723971, 4.8926867e-9, 0.0234939456}
local sellBarrelCFrame = {-4497.41309, 5.98184872, -2668.52979,
    -0.181074247, -2.66281965e-8, 0.983469486,
    2.14637765e-8, 1, 3.10276356e-8,
    -0.983469486, 2.67272782e-8, -0.181074247}
local cases = {
    { {0, 0, 0}, {3, 0, 4}, 2, 1, 2.5 },
    { {0, 20, 0}, {1100, 20, 0}, 100, 2, 11 },
    { {0, 10, 0}, {1100, 10, 0}, 100, 1, 11 },
    { {0, 11, 0}, {1000, 11, 0}, 100, 1, 10 },
    { {0, 11, 0}, {1001, 11, 0}, 100, 2, 10.01 },
    -- The barrel callback supplies nine orientation components too; original
    -- teleport declares only three params and ignores those extra values.
    { {0, 0, 0}, buyBarrelCFrame, 175, 1,
        math.sqrt((-561.834045)^2 + 11.9474373^2 + (-4466.64453)^2) / 175 },
    { {-561.834045, 11.9474373, -4466.64453}, sellBarrelCFrame, 175, 2,
        math.sqrt((-4497.41309+561.834045)^2
            + (5.98184872-11.9474373)^2
            + (-2668.52979+4466.64453)^2) / 175 },
}
for index, case in ipairs(cases) do
    local duration, events, root = evaluate(case[1], case[2], case[3], false)
    equal(duration, case[5], "case " .. index .. " duration")
    local creates = 0
    for _, event in ipairs(events) do
        if event[1] == "Create" then
            creates = creates + 1
        end
    end
    assert(creates == case[4] and root.Position.X == case[2][1])
    if arg[2] then
        local originalDuration, originalEvents = evaluate(case[1], case[2], case[3], true)
        equal(duration, originalDuration, "case " .. index .. " time/bytecode")
        equal(events, originalEvents, "case " .. index .. " event trace/bytecode")
    end
end

-- Optional end-to-end check of the *detached quest handler*, not the game script.
-- Compare real bytecode #31 + real bytecode #9/#12 to the partial module.
if arg[4] then
    local function evaluateQuest(key, original)
        local env, events = setup({0, 0, 0}, 175)
        local module = loadModule(env)
        local func = module.takeQuest
        if original then
            local calc = assert(loadfile(arg[2]))
            local move = assert(loadfile(arg[3]))
            func = assert(loadfile(arg[4]))
            for _, item in ipairs({ calc, move, func }) do setfenv(item, env) end
            env.calculatetime = calc
            env.teleport = move
            env.Quest = module.Quest
            env.QuestPos = module.QuestPos
        end
        local ok = pcall(func, key)
        return ok, events, env._G.teleporting
    end
    for _, key in ipairs({ "None", "Bandit", "Bandit Boss" }) do
        local okModule, moduleEvents, moduleState = evaluateQuest(key, false)
        local okBytecode, bytecodeEvents, bytecodeState = evaluateQuest(key, true)
        assert(okModule == okBytecode, "quest outcomes differ for " .. key)
        equal(moduleEvents, bytecodeEvents, "quest trace/bytecode " .. key)
        assert(moduleState == bytecodeState, "quest teleporting state differs")
        if key == "Bandit" then
            assert(moduleEvents[#moduleEvents][1] == "Quest")
            assert(moduleEvents[#moduleEvents][2] == "takequest")
            assert(moduleEvents[#moduleEvents][3] == "Help Raphtalia")
        end
    end
end

local env = setup({0, 0, 0}, 175)
local module = loadModule(env)
local allowed = pcall(module.teleportNumeric, { X = 1 }, 2, 3)
assert(not allowed, "userdata is explicitly unsupported")
allowed = pcall(function()
    env.getgenv = function() return { noclip = true } end
    module.teleportNumeric(1, 2, 3)
end)
assert(not allowed, "noclip is explicitly unsupported")
print("OK: isolated GPO numeric tween" .. (arg[2] and " matches extracted bytecode" or " smoke")
    .. (arg[4] and "; quest handler matches extracted bytecode" or ""))
