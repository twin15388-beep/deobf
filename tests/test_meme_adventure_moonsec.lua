-- Compare ONLY isolated, already devirtualized MoonSec child prototypes with
-- exact callback fragments in the published source. Never load either root,
-- the protected script, the remote UI, or a real Roblox service.
-- Usage: lua5.1 tests/test_meme_adventure_moonsec.lua PUBLISHED.lua [EXTRACTED_DIR]

local published = assert(arg[1], "pass the published Lua file")
local isolated = arg[2]
local handle = assert(io.open(published, "rb"))
local body = assert(handle:read("*a"))
handle:close()
local count = 0

local function fragment(start, finish, keep)
    local first = assert(body:find(start, 1, true), "missing recovered prototype " .. start)
    local last = assert(body:find(finish, first, true), "missing prototype terminator")
    return body:sub(first, last + #keep - 1)
end

local function recoveredSource(case, env)
    local code = fragment(case.start, case.finish, case.keep)
    if case.place then
        code = "local r0_28, r0_31 = ...\nreturn " .. code
    else
        code = "return " .. code
    end
    local factory = assert(loadstring(code, "@isolated-source"))
    setfenv(factory, env)
    return case.place and factory(true, case.place) or factory()
end

local function recoveredBytecode(case, env)
    local fn = assert(loadfile(isolated .. "/" .. case.proto .. ".luac"))
    setfenv(fn, env) -- intentionally no io, os, debug, require, HttpGet or loadstring
    if case.place then
        fn = fn(true, case.place) -- synthetic parent binds just two explicit upvalues
        setfenv(fn, env)
    end
    return fn
end

local function remoteEnvironment(flag)
    local state = {calls = {}}
    local env = {_G = {ez = false, fast = false}, unpack = unpack}
    local tools = {FireServer = function(_, name, kind)
        state.calls[#state.calls + 1] = name .. ":" .. kind
    end}
    env.game = {GetService = function(_, service)
        assert(service == "ReplicatedStorage")
        return {OtherThing = {Tools = tools}}
    end}
    env.task = {wait = function()
        env._G.ez = false -- finish *after* one tick and its game calls
    end}
    env.wait = function()
        env._G.fast = false
        env._G.ez = false -- the Void Head callback uses wait(), not task.wait()
    end
    state.describe = function()
        return table.concat(state.calls, ",") .. "|" .. flag .. "=" .. tostring(env._G[flag])
    end
    return env, state
end

local function zoomEnvironment()
    local state = {}
    local player = {}
    local env = {_G = {}, game = {Players = {LocalPlayer = player}}}
    state.describe = function()
        return tostring(player.CameraMaxZoomDistance) .. ":" .. tostring(env._G.infiniteMaxZoom)
    end
    return env, state
end

local function promptEnvironment()
    local state, prompts = {}, {}
    local function makePrompt(label)
        local prompt = {Name = label, HoldDuration = 3}
        prompts[#prompts + 1] = prompt
        return prompt
    end
    local chest = {FindFirstChild = function(_, name)
        assert(name == "ProximityPrompt")
        return makePrompt("Chest")
    end}
    local snow = {Pray = {ProximityPrompt = makePrompt("Pray")}}
    local snowParts = {[7] = {ProximityPrompt = makePrompt("Snow7")},
                       [8] = {ProximityPrompt = makePrompt("Snow8")}}
    function snow:GetChildren() return snowParts end
    local mapPart = {ProximityPrompt = makePrompt("World21")}
    local world = {
        Chest = {GetChildren = function() return {chest} end},
        Map = {Snow = snow},
        FISH = {},
        GetChildren = function() return {[21] = mapPart} end,
    }
    for _, island in ipairs({"Desert", "Volcano", "Snow"}) do
        world.FISH[island] = {}
        for i = 1, 5 do
            world.FISH[island]["Fishing" .. i] = {
                ProximityPrompt = makePrompt(island .. i)
            }
        end
    end
    state.describe = function()
        local changed = 0
        for _, prompt in ipairs(prompts) do
            if prompt.HoldDuration == 0 then changed = changed + 1 end
        end
        return tostring(changed) .. "/" .. tostring(#prompts) .. " zero-duration prompts"
    end
    return {workspace = world, ipairs = ipairs}, state
end

local function giftEnvironment()
    local state = {calls = {}, waits = 0}
    local root = {CFrame = "original"}
    local descendants = {
        {Name = "Gift", CFrame = "gift-frame"},
        {Name = "Unique Gift", CFrame = "unique-frame"},
        {Name = "ProximityPrompt", id = "p1"},
        {Name = "ProximityPrompt", id = "p2"},
    }
    local env = {
        _G = {AutoGift = true}, pairs = pairs,
        game = {
            Workspace = {GetDescendants = function() return descendants end},
            Players = {LocalPlayer = {Character = {HumanoidRootPart = root}}},
        },
        wait = function() state.waits = state.waits + 1 end,
        fireproximityprompt = function(prompt, n)
            state.calls[#state.calls + 1] = prompt.id .. ":" .. tostring(n)
        end,
    }
    state.describe = function()
        return root.CFrame .. "|" .. table.concat(state.calls, ",") .. "|waits=" .. state.waits
    end
    return env, state
end

local function teleportEnvironment()
    local state = {newCalls = 0, root = {}}
    local character = {FindFirstChild = function(_, name)
        assert(name == "HumanoidRootPart")
        return state.root
    end}
    local env = {
        CFrame = {new = function(x, y, z)
            state.newCalls = state.newCalls + 1
            return {x = x, y = y, z = z}
        end},
        game = {GetService = function(_, service)
            assert(service == "Players")
            return {LocalPlayer = {Character = character}}
        end},
        wait = function(seconds)
            assert(seconds == 1)
            error("stopped after the first teleport tick")
        end,
        print = function() error("unexpected invalid location") end,
    }
    state.describe = function()
        local c = state.root.CFrame
        assert(c, "no location written")
        return ("%.3f,%.3f,%.3f|calls=%d"):format(c.x, c.y, c.z, state.newCalls)
    end
    return env, state
end

local cases = {
    {proto="0_3", start="function(p4_0) -- proto#4", finish="\nend)", keep="\nend",
     environment=function() return remoteEnvironment("ez") end, args={true},
     expected="King Seal Armor:Helmet,Mumu Armor:Helmet,Hardened Armor:Helmet,"
          .. "X-Mas Armor:Helmet,Hellish Energy:Helmet,King Seal Armor:Helmet|ez=false"},
    {proto="0_4", start="function(p5_0) -- proto#5", finish="\nend)", keep="\nend",
     environment=function() return remoteEnvironment("fast") end, args={true},
     expected="The World Head:Armor,Cosmic Orb:Armor,Skull Bike:Armor|fast=false"},
    {proto="0_10", start="function(p15_0) -- proto#15", finish="\nend)", keep="\nend",
     environment=function() return remoteEnvironment("ez") end, args={true},
     expected="Void Head:Helmet,Pumpkin Head:Helmet,Void Head:Helmet,"
          .. "Pumpkin Head:Helmet,Void Head:Helmet,Void Head:Helmet|ez=false"},
    {proto="0_21", start="function(p26_0) -- proto#26", finish="\nend)", keep="\nend",
     environment=zoomEnvironment, args={true}, expected="9000000000:true"},
    {proto="0_21", start="function(p26_0) -- proto#26", finish="\nend)", keep="\nend",
     environment=zoomEnvironment, args={false}, expected="400:false"},
    {proto="0_16", start="function() -- proto#21", finish="\nend)", keep="\nend",
     environment=promptEnvironment, args={}, expected="20/20 zero-duration prompts"},
    {proto="0_8_0_0", start="function() -- proto#11", finish="\n            end)",
     keep="\n            end", environment=giftEnvironment, args={},
     expected="gift-frame|p1:10,p2:10|waits=1"},
    {proto="0_8_1_0", start="function() -- proto#13", finish="\n            end)",
     keep="\n            end", environment=giftEnvironment, args={},
     expected="unique-frame|p1:10,p2:10|waits=1"},
    {proto="0_0", start="function() -- proto#1 params=0 locals=4 upvalues=2",
     finish="\n    end\nend\nfor r0_32", keep="\n    end",
     environment=teleportEnvironment, args={}, place="Chad Island", fails=true,
     expected="-747.610,16.686,286.831|calls=13"},
    {proto="0_0", start="function() -- proto#1 params=0 locals=4 upvalues=2",
     finish="\n    end\nend\nfor r0_32", keep="\n    end",
     environment=teleportEnvironment, args={}, place="Geto Boss", fails=true,
     expected="5636.919,2255.319,-4319.206|calls=13"},
}

for index, case in ipairs(cases) do
    local function run(bytecode)
        local env, state = case.environment()
        local fn = bytecode and recoveredBytecode(case, env) or recoveredSource(case, env)
        -- In addition to the mocked globals, cap instructions in unknown recovered code.
        debug.sethook(function() error("mock instruction limit") end, "", 200000)
        local ok, err = pcall(fn, unpack(case.args))
        debug.sethook()
        assert(ok == (not case.fails), "wrong callback exit: " .. tostring(err))
        if case.fails then
            assert(tostring(err):find("stopped after the first teleport tick", 1, true),
                   "unexpected teleport stop: " .. tostring(err))
        end
        return state.describe()
    end
    local actual = run(false)
    assert(actual == case.expected,
        "recovered source case " .. index .. ": " .. actual .. " ~= " .. case.expected)
    if isolated then
        local reference = run(true)
        assert(reference == actual,
            "isolated bytecode case " .. index .. ": " .. reference .. " ~= " .. actual)
    end
    count = count + 1
end
print(count .. (isolated and " isolated-prototype comparisons" or " source-only mock cases"))
