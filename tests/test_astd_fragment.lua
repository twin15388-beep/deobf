-- Isolated smoke test for the selected ASTD bytecode fragments, not a Roblox test.
-- Usage: lua5.1 tests/test_astd_fragment.lua 'dobf scripts 1.0/All Star Tower Defense - Assasine03 Autofarm (partial).lua'
local file = assert(arg[1])
local calls = { remote = {}, waited = {} }
local localPlayer = { PlayerGui = { HUD = { NextWaveVote = { Visible = true } } } }
local otherPlayer = {}
local function unit(owner, upgrade, maximum)
    return {
        Owner = { Value = owner },
        UpgradeTag = { Value = upgrade }, MaxUpgradeTag = { Value = maximum },
        FindFirstChild = function(self, name) return self[name] end,
    }
end
local mine = unit(localPlayer, 2, 9)
local theirs = unit(otherPlayer, 2, 9)
local storage = {
    WaveValue = { Value = 9 },
    Remotes = { Input = {
        FireServer = function(_, action, payload)
            table.insert(calls.remote, { action, payload })
        end,
    } },
}
local env = {
    game = {
        Players = { LocalPlayer = localPlayer },
        GetService = function(_, name)
            local services = {
                ReplicatedStorage = storage, Players = { LocalPlayer = localPlayer },
                Workspace = { Unit = { GetChildren = function() return { mine, theirs } end } },
            }
            return assert(services[name], name)
        end,
    },
    CFrame = { new = function(x, y, z) return { X = x, Y = y, Z = z } end },
    wait = function(seconds) table.insert(calls.waited, seconds) end,
    pairs = pairs, tonumber = tonumber,
}
local chunk = assert(loadfile(file))
setfenv(chunk, env)
local recovered = chunk()
recovered.summonAt("", nil)
assert(#calls.remote == 0)
recovered.summonAt("Unit A", { X = 3, Y = 5, Z = 8 })
assert(calls.remote[1][1] == "Summon" and calls.remote[1][2].Unit == "Unit A")
assert(calls.remote[1][2].Rotation == 0 and calls.remote[1][2].cframe.Z == 8)
recovered.sellAtWave(true, "10")
recovered.sellAtWave(false, "9")
assert(#calls.remote == 1)
recovered.sellAtWave(true, "9")
assert(#calls.remote == 3 and calls.remote[2][1] == "Sell"
    and calls.remote[2][2] == mine and calls.remote[3][2] == theirs)
recovered.upgradeOwnedUnit(true, theirs, "5")
recovered.upgradeOwnedUnit(true, mine, "2")
assert(#calls.remote == 3)
recovered.upgradeOwnedUnit(true, mine, "5")
assert(#calls.remote == 4 and calls.remote[4][1] == "Upgrade" and calls.remote[4][2] == mine)
assert(calls.waited[1] == 0.25 and calls.waited[2] == 0.25)
recovered.confirmNextWave(true)
assert(#calls.remote == 5 and calls.remote[5][1] == "VoteWaveConfirm"
    and localPlayer.PlayerGui.HUD.NextWaveVote.Visible == false)
assert(calls.waited[3] == 1 and calls.waited[4] == 1)
recovered.confirmNextWave(true)
recovered.confirmNextWave(false)
assert(#calls.remote == 5)
print("OK: isolated ASTD fragment smoke test (not a Roblox behavior test)")
