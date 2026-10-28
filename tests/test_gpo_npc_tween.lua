-- Isolated GPO NPC positioning smoke + optional real-bytecode differential.
-- Usage: lua5.1 tests/test_gpo_npc_tween.lua <partial module>
--   [<detached calculatetime 0_7> <wrapped tween-to-NPC 0_16>]
-- The wrapper binds the original upvalue (LocalPlayer) explicitly. No top-level
-- protected Lua, Roblox host/network or spawned stabilization loop is executed.
local modulePath = assert(arg[1], "pass the partial GPO module")
assert((arg[2] == nil) == (arg[3] == nil), "pass both bytecode paths or neither")

local function vector(x, y, z)
    return setmetatable({X = x, Y = y, Z = z,
        Magnitude = math.sqrt(x*x + y*y + z*z),
    }, {
        __sub = function(a, b) return vector(a.X-b.X, a.Y-b.Y, a.Z-b.Z) end,
        __mul = function(a, b)
            assert(type(b) == "number")
            return vector(a.X*b, a.Y*b, a.Z*b)
        end,
    })
end

-- In Roblox, CFrame passes the original type(x) == "userdata" branch.
-- Lua 5.1 newproxy lets the mock exercise precisely that branch, not a table shortcut.
local frames = setmetatable({}, {__mode = "k"})
local function frame(x, y, z, look)
    local value = newproxy(true)
    frames[value] = {X = x, Y = y, Z = z, lookVector = look or vector(0, 0, 1)}
    local meta = getmetatable(value)
    meta.__index = function(self, key) return frames[self][key] end
    meta.__add = function(self, offset)
        local old = frames[self]
        return frame(old.X + offset.X, old.Y + offset.Y, old.Z + offset.Z,
            old.lookVector)
    end
    return value
end

local function setup(start, npcRoot, head, facing, speed)
    local calls = {}
    local root = {Position = vector(start[1], start[2], start[3])}
    local player = {Character = {HumanoidRootPart = root}}
    local target = {Name = "Bandit", Head = {CFrame = frame(head[1], head[2], head[3])},
        HumanoidRootPart = {CFrame = frame(npcRoot[1], npcRoot[2], npcRoot[3],
            vector(facing[1], facing[2], facing[3]))}}
    local tweenService = {}
    function tweenService:Create(part, info, goal)
        assert(part == root and type(goal.CFrame) == "userdata")
        local destination = frames[goal.CFrame]
        calls[#calls+1] = {"Create", destination.X, destination.Y, destination.Z,
            info.seconds, info.argCount}
        local tween = {goal = goal}
        function tween:Play() calls[#calls+1] = {"Play"} end
        tween.Completed = {Wait = function() calls[#calls+1] = {"Wait"} end}
        return tween
    end
    local game = {Players = {LocalPlayer = player}}
    function game:GetService(name)
        assert(name == "TweenService")
        return tweenService
    end
    local env = {
        CFrame = {new = frame},
        Vector3 = {new = vector},
        TweenInfo = {new = function(...)
            return {seconds = (...), argCount = select("#", ...)}
        end},
        game = game,
        _G = {speed = speed, teleporting = false},
        spawn = function(callback)
            assert(type(callback) == "function")
            calls[#calls+1] = {"spawn-deferred"}
        end,
        wait = function() error("spawned loop must not run in this test") end,
        type = type, tostring = tostring, math = math,
        error = error,
    }
    return env, calls, player, target
end

local function compare(a, b, label)
    if type(a) == "number" and type(b) == "number" then
        assert(math.abs(a - b) < 1e-9, label .. " differs")
    elseif type(a) == "table" and type(b) == "table" then
        assert(#a == #b, label .. " length differs")
        for i = 1, #a do compare(a[i], b[i], label .. "/" .. i) end
    else
        assert(a == b, label .. " differs")
    end
end

local function runCase(case, bytecode)
    local env, events, player, target = setup(case.start, case.npcRoot,
        case.head, case.facing, case.speed)
    local chunk = assert(loadfile(modulePath))
    setfenv(chunk, env)
    local module = chunk()
    local originalCalc
    local action = module.tweenAboveNpc
    if bytecode then
        originalCalc = assert(loadfile(arg[2]))
        setfenv(originalCalc, env)
        env.calculatetime = originalCalc
        local wrapper = assert(loadfile(arg[3]))
        setfenv(wrapper, env)
        action = wrapper(player) -- explicit original upvalue, without running GPO main
        setfenv(action, env)
    end
    local cf = target.HumanoidRootPart.CFrame
    local duration = module.calculateTime(cf)
    compare(duration, case.duration, "userdata timing")
    if originalCalc then
        compare(duration, originalCalc(cf), "userdata timing/bytecode")
    end
    local tween = action(target)
    assert(env._G.teleporting == false and type(tween.goal.CFrame) == "userdata")
    compare(events, {{"spawn-deferred"},
        {"Create", case.expected[1], case.expected[2], case.expected[3],
            case.duration, 1}, {"Play"}, {"Wait"}}, "expected NPC tween")
    return events
end

local cases = {
    {start = {0, 0, 0}, npcRoot = {5, 8, 15}, head = {5, 10, 15},
        facing = {0, 0, 1}, speed = 5, expected = {5, 13, 10},
        duration = math.sqrt(25 + 64 + 225) / 5},
    {start = {5, 2, 4}, npcRoot = {8, 2, 4}, head = {8, 3, 4},
        facing = {1, 0, 0}, speed = 3, expected = {3, 6, 4}, duration = 1},
}
for index, case in ipairs(cases) do
    local reconstructed = runCase(case, false)
    if arg[2] then
        local original = runCase(case, true)
        compare(reconstructed, original, "case " .. index .. " bytecode trace")
    end
end
print("OK: isolated GPO NPC positioning" ..
    (arg[2] and " matches unchanged captured-upvalue bytecode" or " smoke"))
