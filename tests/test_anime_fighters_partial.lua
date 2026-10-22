-- Offline-only tests for the reconstructed gameplay handlers. If protoDir is
-- provided, compare with *selected children of the CORRECTED static PSU lift*;
-- the protected top-level VM and Roblox are NEVER executed by these tests.
-- lua5.1 tests/test_anime_fighters_partial.lua <module.lua> [isolated-proto-dir]
local modulePath = assert(arg[1], "pass the reconstructed Lua module path")
local protoDir = arg[2]
local M = assert(loadfile(modulePath))()
local comparisons, scenarios = 0, 0

local function equal(a, b, where)
    if type(a) == "table" and type(b) == "table" then
        for key, value in pairs(a) do equal(value, b[key], where .. "." .. tostring(key)) end
        for key in pairs(b) do assert(a[key] ~= nil, where .. " missing " .. tostring(key)) end
    else
        assert(a == b, where .. ": " .. tostring(a) .. " ~= " .. tostring(b))
    end
end
local function compareScenario(a, b, name)
    scenarios = scenarios + 1
    if protoDir then equal(a, b, name); comparisons = comparisons + 1 end
end
local function original(path, env, captured)
    assert(protoDir, "no comparison directory supplied")
    local loader = assert(loadfile(protoDir .. "/" .. path .. ".luac"))
    setfenv(loader, env)
    if captured then return loader(captured) end
    return loader
end
local function find(names, value)
    for index, name in ipairs(names) do if name == value then return index end end
end
local function envFor(extras)
    local env = setmetatable(extras or {}, {__index = _G})
    env.table = setmetatable({find = find}, {__index = table})
    return env
end
local function record(events, ...)
    events[#events + 1] = {...}
end
local function copy(a)
    local result = {}
    for i, v in ipairs(a) do result[i] = v end
    return result
end

-- Five separate callbacks bind the SAME parent-created list. Test duplicates,
-- false removing one instance per matching pet and nil changing only the flag.
local rarities = {"Common", "Rare", "Epic", "Legendary", "Mythical"}
local fixturePets = {
    {Rarity="Common", DisplayName="Ash"}, {Rarity="Rare", DisplayName="Brook"},
    {Rarity="Epic", DisplayName="Cora"}, {Rarity="Legendary", DisplayName="Duke"},
    {Rarity="Mythical", DisplayName="Elara"}, {Rarity="Common", DisplayName="Ash"},
}
local function rarityCase(rarity, index, bytecode)
    local events = {}
    local modules = {{id="first", data={fixturePets[1], fixturePets[2], fixturePets[3]}},
                     {id="second", data={fixturePets[4], fixturePets[5], fixturePets[6]}}}
    local stats = {}
    function stats:GetChildren() record(events, "GetChildren"); return modules end
    local game = {}
    function game:GetService(name)
        assert(name == "ReplicatedStorage")
        return {ModuleScripts={PetStats=stats}}
    end
    local requireMock = function(item)
        record(events, "require", item.id)
        return item.data
    end
    local state = M.defaultState()
    state.selectedNames = {"Initial"}
    local env = envFor({game=game, require=requireMock})
    local callback = bytecode and original("0_" .. (21 + index), env, state.selectedNames)
    local snapshots = {}
    for step=1,5 do
        local enabled = ({true, true, false})[step]
        if step == 5 then enabled = false end
        if bytecode then callback(enabled) else
            M.setRarity(state, {game=game, require=requireMock}, rarity, enabled)
        end
        local flag
        if bytecode then flag = env["SellFighter" .. index]
        else flag = state.sell[rarity] end
        snapshots[#snapshots+1] = {flag=flag, names=copy(state.selectedNames)}
    end
    return {steps=snapshots, events=events}
end
for index, rarity in ipairs(rarities) do
    local ours = rarityCase(rarity, index, false)
    compareScenario(ours, protoDir and rarityCase(rarity, index, true), "rarity " .. rarity)
    assert(#ours.steps[2].names >= #ours.steps[3].names)
    assert(ours.steps[4].flag == nil)
end

local function sellCase(flags, names, bytecode)
    local events, ticks = {}, 0
    local state = M.defaultState()
    state.selectedNames = copy(names)
    local env = envFor()
    local scroll = {}
    local children = {}
    for index, name in ipairs({"Ash", "Brook", "Cora", "Ash"}) do
        local entry = {ClassName="ImageButton", PetName={Text=name}, UID={Value=index * 10}}
        function entry:FindFirstChild(key) return self[key] end
        children[#children + 1] = entry
    end
    children[#children + 1] = {ClassName="TextLabel"}
    children[#children + 1] = {ClassName="ImageButton", FindFirstChild=function() return nil end}
    function scroll:GetChildren() return children end
    local remote = {}
    function remote:FireServer(ids)
        assert(self == remote and #ids == 1)
        record(events, "MassSell", ids[1])
    end
    local game = {Players={LocalPlayer={PlayerGui={MainGui={Pets={Main={Scroll=scroll}}}}}}}
    function game:GetService(name)
        assert(name == "ReplicatedStorage")
        return {Remote={MassSell=remote}}
    end
    for index, rarity in ipairs(rarities) do
        state.sell[rarity] = flags[index]
        env["SellFighter" .. index] = flags[index]
    end
    local function waitMock(seconds)
        assert(seconds == 1)
        ticks = ticks + 1
        record(events, "wait", seconds)
        return ticks == 1 -- controlled exit on second iteration
    end
    env.game, env.wait = game, waitMock
    if bytecode then original("0_27", env, state.selectedNames)()
    else M.massSellLoop(state, {game=game, wait=waitMock}) end
    return {events=events, ticks=ticks}
end
for _, case in ipairs({
    {{true,false,false,false,false}, {"Ash", "Cora"}},
    {{false,true,false,false,false}, {"Brook"}},
    {{false,false,true,false,false}, {"Cora"}},
    {{false,false,false,true,false}, {"Ash"}},
    {{false,false,false,false,true}, {"Brook"}},
    {{false,false,false,false,false}, {"Ash"}},
    {{true,false,false,false,false}, {}},
}) do
    local ours = sellCase(case[1], case[2], false)
    compareScenario(ours, protoDir and sellCase(case[1], case[2], true), "mass sell")
    assert(ours.ticks == 2)
end

local function clickCase(loop, enabled, turnOffAtWait, bytecode)
    local events = {}
    local state = M.defaultState()
    state.clickEnabled = enabled
    local env = envFor({acggca=enabled})
    local click = {FakeDown={}, FakeUp={}}
    local remote = {}
    function remote:FireServer()
        assert(self == remote)
        record(events, "ClickerDamage")
    end
    function click.FakeDown:Fire()
        assert(self == click.FakeDown)
        record(events, "FakeDown")
    end
    function click.FakeUp:Fire()
        assert(self == click.FakeUp)
        record(events, "FakeUp")
        if not turnOffAtWait then state.clickEnabled, env.acggca = false, false end
    end
    local game = {}
    function game:GetService(name)
        if name == "ReplicatedStorage" then return {Remote={ClickerDamage=remote}} end
        assert(name == "Players")
        return {LocalPlayer={PlayerGui={MainGui={ClickFrame={Click=click}}}}}
    end
    local function waitMock(seconds)
        record(events, "wait", seconds)
        if turnOffAtWait and seconds == 1 then state.clickEnabled, env.acggca = false, false end
    end
    env.game, env.wait = game, waitMock
    if bytecode then original(loop and "0_17" or "0_15_0", env)()
    else
        if loop then M.autoClickDamageLoop(state, {game=game, wait=waitMock})
        else M.clickDamageOnce({game=game, wait=waitMock}) end
    end
    return events
end
for _, case in ipairs({{false,false,false}, {true,false,false},
        {true,true,false}, {true,true,true}}) do
    local ours = clickCase(case[1], case[2], case[3], false)
    compareScenario(ours, protoDir and clickCase(case[1], case[2], case[3], true),
        "click loop=" .. tostring(case[1]) .. " enabled=" .. tostring(case[2]))
    if case[1] and not case[2] then assert(#ours == 0) end
end

-- World-scanning callback: remove previous options, visit each Part spawner,
-- restore the character, then deduplicate Mob DisplayName values in UI.
local function frame(y)
    return setmetatable({Y=y}, {__add=function(a,b) return frame(a.Y+b.Y) end,
                                __sub=function(a,b) return frame(a.Y-b.Y) end})
end
local function worldCase(kind, bytecode)
    local events = {}
    local state = M.defaultState()
    state.selectedWorld, state.mobNames = "DBZ", {"Previous", "Old"}
    local env = envFor({SelectedWorld="DBZ", MobsNames=copy(state.mobNames)})
    local currentFrame = frame(10)
    local root = setmetatable({}, {
        __index=function(_, key) if key == "CFrame" then return currentFrame end end,
        __newindex=function(_, key, value)
            assert(key == "CFrame")
            currentFrame = value
            record(events, "root.CFrame", value.Y)
        end,
    })
    local player = {Character={HumanoidRootPart=root}}
    local world = {}
    local spawners = {
        {ClassName="Part", CFrame=frame(100)},
        {ClassName="Folder", CFrame=frame(150)},
        {ClassName="Part", CFrame=frame(200)},
    }
    if kind == "empty" then spawners = {} end
    world.EnemySpawners = {GetDescendants=function() return spawners end}
    local mobs = {}
    for _, desc in ipairs({{"Enemies", "Dragon"}, {"Enemies", "Goblin"},
            {"Enemies", "Dragon"}, {"Other", "Ignored"}}) do
        mobs[#mobs+1] = {Parent={Name=desc[1]}, DisplayName={Value=desc[2]}}
    end
    if kind == "empty" then mobs = {} end
    function world:GetDescendants() return mobs end
    local game = {Players={LocalPlayer=player}}
    function game:GetService(name)
        if name == "Players" then return self.Players end
        assert(name == "Workspace")
        return {Worlds={DBZ=world}}
    end
    local dropdown = {}
    function dropdown:RemoveOption(name) assert(self == dropdown); record(events, "RemoveOption", name) end
    function dropdown:AddOption(name) assert(self == dropdown); record(events, "AddOption", name) end
    local function waitMock(seconds) record(events, "wait", seconds or "none") end
    local vector = {new=function(x, y, z) assert(x==0 and z==0); return {Y=y} end}
    env.game, env.Game = game, game -- original bytecode mixes both spellings
    env.SATFW, env.Vector3, env.wait = dropdown, vector, waitMock
    if bytecode then original("0_7", env)()
    else M.refreshMobOptions(state, {game=game, targetDropdown=dropdown,
                                      Vector3=vector, wait=waitMock}) end
    return {events=events, mobNames=copy(bytecode and env.MobsNames or state.mobNames),
            rootY=currentFrame.Y}
end
for _, kind in ipairs({"normal", "empty"}) do
    local ours = worldCase(kind, false)
    compareScenario(ours, protoDir and worldCase(kind, true), "mob options " .. kind)
    assert(ours.rootY == 10)
end

local function travelCase(worldName, bytecode)
    local events = {}
    local state = M.defaultState()
    state.selectedWorld = worldName
    local currentFrame = frame(0)
    local root = setmetatable({}, {
        __index=function(_, key) if key == "CFrame" then return currentFrame end end,
        __newindex=function(_, key, value)
            assert(key == "CFrame"); currentFrame = value
            record(events, "root.CFrame", value.Y)
        end,
    })
    local remote = {}
    function remote:InvokeServer(...)
        assert(self == remote)
        local count = select("#", ...)
        assert(count == 1)
        record(events, "AttemptTravel", ...)
    end
    local worlds = {[worldName]={Spawns={SpawnLocation={CFrame=frame(25)}}}}
    local game = {}
    function game:GetService(name)
        if name == "Players" then return {LocalPlayer={Character={HumanoidRootPart=root}}} end
        if name == "Workspace" then return {Worlds=worlds} end
        assert(name == "ReplicatedStorage")
        return {Remote={AttemptTravel=remote}}
    end
    local vector = {new=function(x,y,z) assert(x==0 and y==10 and z==0); return {Y=y} end}
    local env = envFor({game=game, Game=game, Vector3=vector, SAWorld=worldName})
    if bytecode then original("0_29", env)("ignored callback parameter")
    else M.travelToWorld(state, {game=game, Vector3=vector}) end
    return {events=events, rootY=currentFrame.Y}
end
for _, name in ipairs({"DBZ", "Jojo"}) do
    local ours = travelCase(name, false)
    compareScenario(ours, protoDir and travelCase(name, true), "travel " .. name)
    assert(ours.rootY == 35)
end

print(string.format("Anime Fighters: %d offline scenarios; %d comparisons with corrected selected bytecode children", scenarios, comparisons))
