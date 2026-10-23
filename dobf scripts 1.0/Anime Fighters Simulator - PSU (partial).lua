--[[
GAME: Anime Fighters Simulator | PARTIAL STATIC DEOBFUSCATION, NOT A COMPLETE HUB
Protected input: https://github.com/Luciquad/robloxscripts/blob/21735be73af9db5d6c3f9df4c532f08e9ddf7980/animefighterssimulator
Input SHA-256: f48e4db9cf568deba2c51e29940d57c65ce5eb678556870d08421e4270124f77
Recovery: memcpython/PSU-Deobfuscator@7d955d4d8e3bc14b744dc4afd52118787fc2bda4 + scripts/lift_psu_fixed_calls.mjs (PSU -> Lua 5.1 bytecode).
THREE narrow CALL-handler corrections; selected children 0_7, 0_15_0, 0_17,
0_22..0_27 and 0_29 were manually rewritten. This is NOT a verbatim dump.
The protected top level, remote UI library and farm/auto-buy children are NOT
present or verified. Its recovered root displays "Wrong Script" for PlaceId
4042427666 (the DIFFERENT Anime Fighting Simulator); it does not prove a
match with the current Anime Fighters Simulator place 6299805723. An
uncorrected decompiler mangles CALL arguments and control flow; do not treat
its printed source as authoritative.

The state/deps API, function names, Lua comments, one-tick extraction and
normalization of original global Game/game to deps.game are OUR additions.
The original global flags, mob/rarity data paths, timing, and remote names
were recovered from those children. Offline tests compare only with selected
children of the CORRECTED static lift, never the protected VM or a live Roblox
session. Executor APIs, world UI hierarchy and remotes may have changed.
MassSell is DESTRUCTIVE; AttemptTravel can travel; rarity names refer to pets/
fighters in the game's own PetStats modules. Neither this module nor tests
execute the protected top level, download an external UI or contact a server.

This is the license file of the source repository, reproduced verbatim:
MIT LICENSE BEGIN
MIT License

Copyright (c) 2021 Luciquad

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
MIT LICENSE END
]]

local M = {}
local rarityFlag = {
    Common = "SellFighter1", Rare = "SellFighter2", Epic = "SellFighter3",
    Legendary = "SellFighter4", Mythical = "SellFighter5",
}

local function findName(names, value)
    for index, name in ipairs(names) do
        if name == value then return index end
    end
end

-- OUR state object replaces globals and a shared upvalue in the protected UI.
function M.defaultState()
    return {
        selectedWorld = nil, mobNames = {}, selectedNames = {},
        sell = {Common = false, Rare = false, Epic = false,
                Legendary = false, Mythical = false},
        clickEnabled = false,
    }
end

-- Children 0_22..0_26: one checkbox per rarity, sharing selectedNames.
-- Repeated true APPENDS duplicates; false removes only one occurrence per
-- matching PetStats entry. We deliberately do not silently deduplicate.
-- deps.require is Roblox's require for PetStats ModuleScripts.
function M.setRarity(state, deps, rarity, enabled)
    assert(rarityFlag[rarity], "expected Common/Rare/Epic/Legendary/Mythical")
    state.sell[rarity] = enabled
    if enabled ~= true and enabled ~= false then return end
    local petStats = deps.game:GetService("ReplicatedStorage").ModuleScripts.PetStats
    for _, script in pairs(petStats:GetChildren()) do
        for _, pet in pairs(deps.require(script)) do
            if pet.Rarity == rarity then
                if enabled == true then
                    table.insert(state.selectedNames, pet.DisplayName)
                else
                    local index = findName(state.selectedNames, pet.DisplayName)
                    if index then table.remove(state.selectedNames, index) end
                end
            end
        end
    end
end

-- Child 0_27. Sell only UI entries whose visible PetName.Text occurs in the
-- shared list; one MassSell call per matching ImageButton with its UID.
-- The game also checks that at least one of the five checkbox flags is true.
-- Calling this CAN irreversibly sell fighters. No lock/rarity check occurs here.
function M.massSellTick(state, deps)
    local active = false
    for rarity in pairs(rarityFlag) do
        if state.sell[rarity] == true then active = true; break end
    end
    if not active then return end
    local scroll = deps.game.Players.LocalPlayer.PlayerGui.MainGui.Pets.Main.Scroll
    for _, entry in pairs(scroll:GetChildren()) do
        if entry.ClassName == "ImageButton" and entry:FindFirstChild("PetName")
                and findName(state.selectedNames, entry.PetName.Text) then
            deps.game:GetService("ReplicatedStorage").Remote.MassSell:FireServer({entry.UID.Value})
        end
    end
end

-- The source's spawned child loops while wait(1) returns a truthy value.
-- Roblox wait() normally stays truthy, so run this asynchronously if used;
-- an injected wait that returns false ends it for offline tests.
function M.massSellLoop(state, deps)
    while deps.wait(1) do M.massSellTick(state, deps) end
end

-- Child 0_15_0: gameplay damage remote and matching UI click animation.
function M.clickDamageOnce(deps)
    deps.game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
    local click = deps.game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ClickFrame.Click
    click.FakeDown:Fire()
    deps.wait(0.02)
    click = deps.game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ClickFrame.Click
    click.FakeUp:Fire()
end

-- Child 0_17 checks the flag at the top, NOT again after wait(1).
function M.autoClickDamageLoop(state, deps)
    while state.clickEnabled do
        deps.wait(1)
        deps.game:GetService("ReplicatedStorage").Remote.ClickerDamage:FireServer()
        local click = deps.game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ClickFrame.Click
        click.FakeDown:Fire()
        deps.wait(0.05)
        click = deps.game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ClickFrame.Click
        click.FakeUp:Fire()
    end
end

-- Child 0_7. The spawner scan briefly MOVES the character, then returns it
-- to its saved CFrame; this is not a passive list query. The targetDropdown
-- (original global SATFW) has AddOption/RemoveOption. Game/game in the bytecode
-- were inconsistent case; our deps.game supplies both uses.
function M.refreshMobOptions(state, deps)
    local root = deps.game.Players.LocalPlayer.Character.HumanoidRootPart
    local savedFrame = root.CFrame
    for _, name in next, state.mobNames do
        deps.targetDropdown:RemoveOption(name)
    end
    deps.wait()
    state.mobNames = {}
    local world = deps.game:GetService("Workspace").Worlds[state.selectedWorld]
    for _, spawner in pairs(world.EnemySpawners:GetDescendants()) do
        if spawner.ClassName == "Part" then
            deps.game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
                spawner.CFrame - deps.Vector3.new(0, 10, 0)
            deps.wait(0.05)
        end
    end
    deps.wait(0.05)
    root.CFrame = savedFrame
    deps.wait(0.1)
    for _, node in pairs(world:GetDescendants()) do
        if node.Parent.Name == "Enemies"
                and not findName(state.mobNames, node.DisplayName.Value) then
            deps.targetDropdown:AddOption(node.DisplayName.Value)
            table.insert(state.mobNames, node.DisplayName.Value)
        end
    end
end

-- Child 0_29. Teleports 10 studs above world spawn before invoking AttemptTravel
-- with the selected world. Its callback parameter is ignored in the bytecode.
function M.travelToWorld(state, deps)
    local root = deps.game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local world = deps.game:GetService("Workspace").Worlds[state.selectedWorld]
    root.CFrame = world.Spawns.SpawnLocation.CFrame + deps.Vector3.new(0, 10, 0)
    deps.game:GetService("ReplicatedStorage").Remote.AttemptTravel
        :InvokeServer(unpack({state.selectedWorld}))
end

return M
