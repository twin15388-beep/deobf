-- Isolated smoke test for Ro-Ghoul selected quest bytecode, not a Roblox test.
-- Usage: lua5.1 tests/test_roghoul_fragment.lua 'dobf scripts 1.0/Ro-Ghoul - Yoshimura Quest (partial).lua'
local file = assert(arg[1])
local calls = { task = 0, cash = 0, moved = 0, waits = {} }
local pos = {}
local progress = {
    Value = 3, Max = { Value = 5 },
    Changed = { connect = function(_, fn) calls.changed = fn end },
}
local complete = {
    FindFirstChild = function(self, name) return self[name] end,
    WaitForChild = function(self, name) return assert(self[name]) end,
}
local player = { PlayerFolder = { CurrentQuest = { Complete = complete } } }
local deps = {
    status = {},
    moveTo = function(cframe) assert(cframe == pos) calls.moved = calls.moved + 1 end,
    remotes = {
        Yoshimura = { Task = { InvokeServer = function() calls.task = calls.task + 1 end } },
        ReputationCashOut = { InvokeServer = function() calls.cash = calls.cash + 1 end },
    },
    player = player,
    questUI = { prefix = "Quest: ", label = {} },
}
local env = {
    workspace = { Anteiku = { Yoshimura = { HumanoidRootPart = { CFrame = pos } } } },
    wait = function(seconds) table.insert(calls.waits, seconds or 0) end,
    tick = function() return 7201 end,
}
local chunk = assert(loadfile(file))
setfenv(chunk, env)
local recovered = chunk()
assert(recovered.BossRequirements["Eto Yoshimura"].level == 1250)
assert(recovered.BossRequirements["Nishiki Nishio"].level == 250)
assert(recovered.SpawnGroups["Aogiri Members"] == "GhoulSpawns")
assert(recovered.needsAogiriQuest(player) == true)
complete["Aogiri Member"] = progress
assert(recovered.needsAogiriQuest(player) == false)
progress.Value = 5
assert(recovered.needsAogiriQuest(player) == true)
progress.Value = 3
recovered.yoshimuraAction(true, deps)
assert(calls.task == 2 and calls.cash == 0 and calls.moved == 1)
assert(calls.waits[1] == 1.5 and calls.waits[2] == 0)
assert(deps.status.Text == "Getting quest..." and deps.questUI.label.Text == "Quest: 3/5")
assert(type(calls.changed) == "function")
calls.changed(4)
assert(deps.questUI.label.Text == "Quest: 4/5")
recovered.yoshimuraAction(false, deps)
assert(calls.cash == 1 and calls.moved == 2 and deps.lastCashOut == 7201)
assert(deps.status.Text == "Withdrawing reputation")
print("OK: isolated Ro-Ghoul fragment smoke test (not a Roblox behavior test)")
