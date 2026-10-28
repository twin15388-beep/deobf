-- GPO Normal Barrel BUY/SELL callback: mock smoke plus optional *corrected*
-- PSU-lift differential. Protected top-level is never loaded/executed.
-- Usage: lua5.1 tests/test_gpo_barrels.lua <partial module>
--   [<isolated calculatefromto 0_9> <wrapped barrel 0_56>
--    [<isolated calculatetime 0_7> <isolated teleport 0_10>]]
-- The second option requires scripts/lift_psu_multireturn.mjs on the pinned
-- original input. The untouched PSU lift discards a required call result.
local modulePath = assert(arg[1], "pass partial GPO module")
assert((arg[2] == nil) == (arg[3] == nil), "pass both corrected bytecode paths or neither")
assert((arg[4] == nil) == (arg[5] == nil), "pass both movement bytecode paths or neither")
assert(not arg[4] or arg[2], "barrel callback bytecode required for end-to-end comparison")

local function vector(x, y, z)
    return setmetatable({X = x, Y = y, Z = z,
        Magnitude = math.sqrt(x*x + y*y + z*z)}, {
        __sub = function(a, b) return vector(a.X-b.X, a.Y-b.Y, a.Z-b.Z) end,
    })
end

local frames = setmetatable({}, {__mode = "k"})
local function frame(x, y, z)
    local value = newproxy(true)
    frames[value] = {X=x, Y=y, Z=z}
    getmetatable(value).__index = function(self, key) return frames[self][key] end
    return value
end

local buy = {-561.834045, 11.9474373, -4466.64453,
    0.0234939456, -5.12754212e-8, -0.999723971,
    -3.6866743e-9, 1, -5.13762188e-8,
    0.999723971, 4.8926867e-9, 0.0234939456}
local sell = {-4497.41309, 5.98184872, -2668.52979,
    -0.181074247, -2.66281965e-8, 0.983469486,
    2.14637765e-8, 1, 3.10276356e-8,
    -0.983469486, 2.67272782e-8, -0.181074247}

local function compare(a, b, where)
    if type(a) == "number" and type(b) == "number" then
        assert(math.abs(a - b) < 1e-8, where .. " differs")
    elseif type(a) == "table" and type(b) == "table" then
        assert(#a == #b, where .. " length differs")
        for i = 1, #a do compare(a[i], b[i], where .. "/" .. i) end
    else
        assert(a == b, where .. " differs: " .. tostring(a) .. " / " .. tostring(b))
    end
end

local function setup(case)
    local events, state = {}, {ON = false, good = case.good, noclip = false}
    local root = {CFrame = frame(unpack(case.start)), Position = vector(unpack(case.start))}
    local player = {Character = {HumanoidRootPart = root}}
    local remote = {FireServer = function(_, payload)
        assert(payload.action == "Buy" or payload.action == "Sell")
        events[#events+1] = {"FireServer", payload.action, payload.barrelType}
    end}
    local game = {Players = {LocalPlayer = player}}
    local tweenService = {}
    function tweenService:Create(part, info, goal)
        assert(part == root)
        local kind = goal.Position and "Position" or "CFrame"
        local position = goal[kind]
        events[#events+1] = {"Tween", kind, position.X, position.Y, position.Z,
            info.seconds, info.style, info.direction}
        local tween = {}
        function tween:Play()
            events[#events+1] = {"Play", kind}
            root.Position = vector(position.X, position.Y, position.Z)
        end
        tween.Completed = {
            Wait = function() events[#events+1] = {"Wait", kind} end,
            wait = function() events[#events+1] = {"wait", kind} end,
        }
        return tween
    end
    function game:GetService(name)
        if name == "ReplicatedStorage" then return {Events = {Barrel = remote}} end
        assert(name == "TweenService")
        return tweenService
    end
    local moves = 0
    local function move(...)
        moves = moves + 1
        assert(select("#", ...) == 12)
        events[#events+1] = {"teleport", select("#", ...), ...}
        return {}, (moves == 1 and 2 or 3)
    end
    local function banner(info)
        events[#events+1] = {"Banner", info.Text}
    end
    local env = {
        CFrame = {new = frame}, Vector3 = {new = vector}, game = game,
        TweenInfo = {new = function(seconds, style, direction)
            return {seconds = seconds, style = style, direction = direction}
        end},
        Enum = {EasingStyle = {Linear = "Linear"}, EasingDirection = {InOut = "InOut"}},
        _G = {speed = case.speed}, getgenv = function() return state end,
        spawn = function(callback)
            assert(type(callback) == "function")
            events[#events+1] = {"spawn-deferred"}
        end,
        wait = function(t)
            events[#events+1] = {"wait", t or "no-argument"}
            if t == nil then state.ON = false end -- exactly one loop iteration
        end,
        warn = function(s) events[#events+1] = {"warn", s} end,
        math = math, type = type, tostring = tostring,
    }
    return env, events, state, root, move, banner
end

local function runCase(case, bytecode)
    local env, events, state, root, move, banner = setup(case)
    local loadModule = assert(loadfile(modulePath)); setfenv(loadModule, env)
    local module = loadModule()
    local action = function() module.normalBarrelLoop(case.enabled,
        {teleport = move, banner = banner}) end
    if bytecode then
        local wrapper = assert(loadfile(arg[3])); setfenv(wrapper, env)
        local original = wrapper({Banner = banner}) -- the original UI upvalue
        setfenv(original, env)
        env.calculatefromto = assert(loadfile(arg[2]))
        setfenv(env.calculatefromto, env)
        env.teleport = move
        action = function() original(case.enabled) end
    end
    action()

    local expected = {}
    if case.enabled then
        local first = math.floor(module.calculateFromTo(root.CFrame, 0, 0,
            buy[1], buy[2], buy[3]))
        local second = math.floor(module.calculateFromTo(buy[1], buy[2], buy[3],
            sell[1], sell[2], sell[3]))
        expected[#expected+1] = {"Banner", ("It will take %s seconds to purchase and sell 1 barrel.")
            :format(math.floor(first + second))}
        expected[#expected+1] = {"wait", "no-argument"}
        if case.good == false then
            expected[#expected+1] = {"teleport", 12, unpack(buy)}
            expected[#expected+1] = {"wait", 2}
            expected[#expected+1] = {"wait", 1}
            expected[#expected+1] = {"FireServer", "Buy", "Normal"}
            expected[#expected+1] = {"teleport", 12, unpack(sell)}
            expected[#expected+1] = {"wait", 3}
            expected[#expected+1] = {"wait", 1}
            expected[#expected+1] = {"warn", "soldd"}
            expected[#expected+1] = {"FireServer", "Sell", "Normal"}
        end
    end
    compare(events, expected, "barrel event trace")
    assert(state.ON == false)
    assert(state.good == (case.good == false and false or case.good))
    return events
end

local cases = {
    {enabled = true, good = false, start = {0, 0, 0}, speed = 175},
    {enabled = true, good = true, start = {2, 15, 20}, speed = 115},
    {enabled = false, good = false, start = {3, 7, -8}, speed = 200},
}
for index, case in ipairs(cases) do
    local reconstructed = runCase(case, false)
    if arg[2] then
        compare(reconstructed, runCase(case, true), "original callback " .. index)
    end
end

-- When deps.teleport is absent, the partial module uses its previously
-- verified numeric/no-noclip teleport. Compare the two *linked* prototypes
-- against the corrected original barrel callback + extracted original move.
do
    local function runLinked(original)
        local env, events, _, _, _, banner = setup(cases[1])
        local loadModule = assert(loadfile(modulePath)); setfenv(loadModule, env)
        local module = loadModule()
        if original then
            env.calculatefromto = assert(loadfile(arg[2]))
            env.calculatetime = assert(loadfile(arg[4]))
            env.teleport = assert(loadfile(arg[5]))
            for _, fn in ipairs({env.calculatefromto, env.calculatetime, env.teleport}) do
                setfenv(fn, env)
            end
            local wrapper = assert(loadfile(arg[3])); setfenv(wrapper, env)
            local callback = wrapper({Banner = banner}); setfenv(callback, env)
            callback(true)
        else
            module.normalBarrelLoop(true, {banner = banner})
        end
        return events
    end
    local moduleEvents = runLinked(false)
    if arg[4] then
        compare(moduleEvents, runLinked(true), "linked barrel/movement bytecode")
    end
    local fires = 0
    for _, event in ipairs(moduleEvents) do
        if event[1] == "FireServer" then fires = fires + 1 end
    end
    assert(fires == 2, "linked route must Buy and Sell exactly once")
end

if arg[2] then
    local env = setup(cases[1]) -- separate userdata + numeric cases for proto #11
    local loadModule = assert(loadfile(modulePath)); setfenv(loadModule, env)
    local reconstructed = loadModule().calculateFromTo
    local original = assert(loadfile(arg[2])); setfenv(original, env)
    local points = {
        {frame(1, 2, 3), 0, 0, 10, 7, 4},
        {2, 3, 4, frame(10, 11, 12), 0, 0},
        {-1, 15, -7, 0, 0, 0},
    }
    for index, p in ipairs(points) do
        compare(reconstructed(unpack(p)), original(unpack(p)),
            "calculateFromTo bytecode " .. index)
    end
end
print("OK: isolated GPO Normal barrel" ..
    (arg[2] and " matches corrected lifted bytecode" or " smoke"))
