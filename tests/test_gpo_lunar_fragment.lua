-- Isolated smoke test for the *manually selected* recovered GPO fragments.
-- Never loads the protected input, never connects to Roblox or the network.
-- Usage: lua5.1 tests/test_gpo_lunar_fragment.lua 'dobf scripts 1.0/Grand Piece Online - Lunar Hub (partial).lua'
local source = assert(arg[1], "pass the partial GPO Lua module path")
local calls = { quest = {}, damage = {}, teleports = {}, ice = 0, deleted = 0 }

local mockCFrame = {
    new = function(x, y, z)
        return { X = x, Y = y, Z = z }
    end,
}
local function pos(x, y, z)
    return setmetatable({ X = x, Y = y, Z = z }, {
        __sub = function(a, b)
            return { Magnitude = math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2) }
        end,
    })
end
local npcNear = {
    Name = "Bandit", HumanoidRootPart = { Position = pos(3, 0, 0) },
    FindFirstChildWhichIsA = function(_, kind) return kind == "Humanoid" end,
}
local npcFar = {
    Name = "Bandit Boss", HumanoidRootPart = { Position = pos(8, 0, 0) },
    FindFirstChildWhichIsA = function(_, kind) return kind == "Humanoid" end,
}
local questRemote = {
    InvokeServer = function(_, payload) table.insert(calls.quest, payload) end,
}
local damageRemote = {
    InvokeServer = function(_, payload) table.insert(calls.damage, payload) end,
}
local ice = {
    Size = { X = 1, Y = 2, Z = 3 },
    sm2 = { Destroy = function() calls.deleted = calls.deleted + 1 end },
    sm3 = { Destroy = function() calls.deleted = calls.deleted + 1 end },
}
local game = {
    Players = {
        LocalPlayer = {
            Character = { HumanoidRootPart = { Position = pos(0, 0, 0) } },
            Backpack = {
                FindFirstChild = function(_, name)
                    assert(name == "WaterLogia")
                    return { ["Hie-Hie"] = { floor = { Clone = function() return ice end } } }
                end,
            },
        },
    },
    Debris = { AddItem = function(_, value, seconds)
        assert(value == ice and seconds == 5)
        calls.ice = calls.ice + 1
    end },
}
local replicated = { Events = { Quest = questRemote, CombatRegister = damageRemote } }
function game:GetService(name)
    assert(name == "ReplicatedStorage")
    return replicated
end

local env = {
    CFrame = mockCFrame,
    game = game,
    workspace = {
        NPCs = { GetChildren = function() return { npcFar, npcNear } end },
        Effects = { Water = { Position = { Y = 4 } } },
    },
    Vector3 = { new = function(x, y, z) return { X = x, Y = y, Z = z } end },
    teleport = function(x, y, z) table.insert(calls.teleports, {x, y, z}) end,
    spawn = function(callback) callback() end,
    wait = function(value) assert(value == 0.5) end,
    math = math,
    next = next,
    _G = { WalkOnWater = nil },
}
local chunk = assert(loadfile(source))
setfenv(chunk, env)
local result = chunk()
assert(result.Quest.Bandit == "Help Raphtalia")
assert(result.QuestPos["Bandit Boss"] == nil)
assert(result.nearestNpc("Bandit") == npcNear)
assert(result.nearestNpc("Nonexistent") == nil)
assert(result.nearestNpcExcept("Bandit", "Bandit") == npcFar)
assert(result.nearestNpcExcept("Bandit", "Bandit Boss") == npcNear)
result.takeQuest("None")
assert(#calls.quest == 0)
result.takeQuest("Bandit")
assert(#calls.teleports == 1 and calls.teleports[1][1] == 1014.99664)
assert(#calls.quest == 1 and calls.quest[1][1] == "takequest"
    and calls.quest[1][2] == "Help Raphtalia")
-- The missing QuestPos entries are a known limitation, not a working quest path.
local bossOkay = pcall(result.takeQuest, "Bandit Boss")
assert(not bossOkay and #calls.quest == 1 and #calls.teleports == 1)
result.damageNpc(npcNear, "Black Leg")
assert(#calls.damage == 5)
for strike = 1, 5 do
    local payload = calls.damage[strike]
    assert(payload[1] == "damage" and payload[2] == npcNear.HumanoidRootPart)
    assert(payload[3] == "BlackLeg" and payload[4][1] == strike)
    assert(payload[4][2] == "Ground" and payload[4][3] == "BlackLeg")
end
for _, choice in ipairs({ {"Katana", "Sword"}, {"Kiribachi", "Sword"}, {"Melee", "Melee"} }) do
    local start = #calls.damage
    result.damageNpc(npcNear, choice[1])
    assert(#calls.damage == start + 5)
    for i = 1, 5 do
        assert(calls.damage[start + i][3] == choice[2]
            and calls.damage[start + i][4][1] == i)
    end
end
result.hieWaterTouch({ Name = "LeftFoot", Position = pos(7, 9, 8) })
assert(calls.ice == 0)
env._G.WalkOnWater = "Hie-Hie"
result.hieWaterTouch({ Name = "NotAFoot", Position = pos(7, 9, 8) })
assert(calls.ice == 0)
result.hieWaterTouch({ Name = "LeftFoot", Position = pos(7, 9, 8) })
assert(calls.ice == 1 and calls.deleted == 2)
assert(ice.Position.X == 7 and ice.Position.Y == 2.5 and ice.Position.Z == 8)
assert(ice.Size.X == 1 and ice.Size.Y == 7 and ice.Size.Z == 3)
print("OK: isolated GPO fragment smoke test (not a Roblox behavior test)")
