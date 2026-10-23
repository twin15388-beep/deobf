--[[
GAME: Zero Academia | PARTIAL STATIC DEOBFUSCATION | NOT AUTONOMOUS
Original: https://github.com/teppyboy/RbxScripts/blob/58a52a25dde88cd939d679ed74dc63542a2cacd2/ZeroScripts/ZeroAcademia/Script.lua
Source SHA-256: 0630d5d1c34ffe0ee1604c49cbc8c0dce83233cf638fb5b49a11f60fb309b4ad
Recovery: memcpython/PSU-Deobfuscator@7d955d4d8e3bc14b744dc4afd52118787fc2bda4; scripts/lift_psu_multireturn.mjs; selected Lua 5.1 prototypes.
Only the selected quest, farming, quirk, movement and combat handlers were manually rewritten. Names, explicit state/deps arguments and the return table are additions, NOT original source/comments. No protected top-level, authentication, UI, metatable hooks or remote library downloads are run here. In particular deps.getNPC and deps.useKey must be supplied; these two helpers were not recovered in this file. This is NOT a full hub or a claim that it works in a live game. Do not call the indefinite loops without a way to turn them off. Spins can spend in-game currency.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2020 TreTrauIT

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

-- Selected child #6: the original captured a Quests folder once at startup.
-- This explicit player parameter and lookup at call time are our adaptation.
local function questSnapshot(player)
    local folder = workspace.Quests[player.Name]:FindFirstChildWhichIsA("Folder")
    if folder == nil then
        return nil
    end
    return {
        Name = folder.Name,
        Progress = folder.AmountKilled.Value,
        Target = folder.AmountNeeded.Value,
    }
end

-- Selected child 0_32_0: state = {AutoQuest, QuestName}; deps supplies the
-- original GetQuest, Remotes.Quest and two UI labels. The historical loop
-- does NOT wait for a newly accepted quest when an old, differently named
-- quest was already present: it keeps showing the old snapshot in that case.
local function autoQuestLoop(state, deps)
    while state.AutoQuest and wait() do
        local quest = deps.getQuest()
        if quest == nil or quest.Name ~= state.QuestName then
            deps.remotes.Quest.CancelQuest:FireServer()
            wait()
            deps.remotes.Quest.AcceptQuest:FireServer(state.QuestName)
            while quest == nil do
                quest = deps.getQuest()
                wait()
            end
        end
        deps.nameLabel.Text = "Name: " .. quest.Name
        deps.progressLabel.Text = "Progress: " .. quest.Progress .. "/" .. quest.Target
        if quest.Progress == quest.Target then
            deps.remotes.Quest.CompleteQuest:FireServer(quest.Name)
            deps.progressLabel.Text = "Progress: Completed"
        end
    end
end

-- Selected child #11: only NPCs with both body parts and positive health.
local function npcAlive(npc)
    return npc ~= nil
        and npc:FindFirstChild("Humanoid") ~= nil
        and npc:FindFirstChild("HumanoidRootPart") ~= nil
        and npc.Humanoid.Health > 0
end

-- Selected child #18: two-stage movement toward an NPC. In the original
-- settings came from a captured AutoFarm table, deps supplied the player
-- root part and TweenService. Both tweens use fixed speed 150 studs/second.
local function tweenToNpc(npc, settings, deps)
    local destination = npc.HumanoidRootPart.Position + settings.Vector3
    local root = deps.character.HRP
    if (root.Position - destination).Y > 5 then
        local verticalTime = (root.Position - destination).Y / 150
        local verticalGoal = CFrame.new(Vector3.new(root.Position.X,
            destination.Y, root.Position.Z))
        local vertical = deps.tweenService:Create(root,
            TweenInfo.new(verticalTime, Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out, 0, false, 0), {CFrame = verticalGoal})
        vertical:Play()
        wait(verticalTime)
    end
    local travelTime = (destination - root.Position).Magnitude / 150
    local travelGoal = CFrame.new(destination)
        * CFrame.Angles(math.rad(settings.Rotation), 0, 0)
    local horizontal = deps.tweenService:Create(root,
        TweenInfo.new(travelTime, Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out, 0, false, 0), {CFrame = travelGoal})
    horizontal:Play()
    wait(travelTime)
end

-- Selected child #22: the real Zero Academia ability RemoteEvent lives in
-- workspace[player.Name][quirk][key]. Use only when playerReady and the
-- original KeyAvailable predicate both pass. key = Z/X/C/V/F/Q/E, etc.;
-- argument = optional game-specific CFrame/Vector3, not an arbitrary action.
local function pressKey(key, argument, deps)
    if not (deps.playerReady and deps.keyAvailable(key)) then
        return
    end
    local remote = workspace[deps.player.Name][deps.getQuirk()][key]
    if argument then
        remote:FireServer(argument)
    else
        remote:FireServer()
    end
end

-- Selected child #23: the game's ordinary attack; same readiness gate.
local function swing(argument, deps)
    if not (deps.playerReady and deps.swingAvailable()) then
        return
    end
    local remote = workspace[deps.player.Name].Main.Swing
    if argument then
        remote:FireServer(argument)
    else
        remote:FireServer()
    end
end

-- Selected child 0_38: original AutoFarm body, with seven upvalues made
-- explicit via deps. state.AutoFarm = {NameVerified, NPCs, Retries, Enabled};
-- state.Keys[key] = {key, enabled, argumentType, mode}. deps = {
--   statusLabel, character={Humanoid, HRP}, runService, getNPC(name),
--   npcValid(npc), tweenToModel(npc), useKey(key, optionalArgument) }.
-- The original UI started/stopped this coroutine, verified names separately,
-- handled respawns, emulated missing key args and supplied these dependencies.
-- This isolated handler alone does NOT constitute an autonomous farm.
local function autoFarm(state, deps)
    local settings = state.AutoFarm
    local status = deps.statusLabel
    local character = deps.character
    local services = deps.runService
    if not settings.NameVerified then
        status.Text = "Status: NPCs not verified!"
        return
    end
    for index, name in pairs(settings.NPCs) do
        local npc, attempts = nil, 0
        status.Text = string.format("Status: Testing NPC[%d]", index)
        while not npc and wait(0.01) and character.Humanoid.Health > 0 do
            if attempts < settings.Retries then
                attempts = attempts + 1
            else
                status.Text = string.format("Status: NPC[%d] not found", index)
                error("Retry exceeded (" .. tostring(settings.Retries)
                    .. string.format(") NPC[%d] not found", index))
            end
            npc = deps.getNPC(name)
        end
    end
    status.Text = "Status: Binding functions..."
    services:BindToRenderStep("hoax", 0, function()
        character.Humanoid:ChangeState(11)
    end)
    status.Text = "Status: Begin"
    while settings.Enabled and wait() and character.Humanoid.Health > 0 do
        local target = nil
        while not target do
            for index, name in pairs(settings.NPCs) do
                status.Text = string.format("Status: Finding NPC[%d]...", index)
                target = deps.getNPC(name)
                if target then
                    break
                end
            end
            wait(0.01)
        end
        status.Text = "Status: Teleporting..."
        local teleporting = false
        local stepConnection = services.Stepped:Connect(function()
            if deps.npcValid(target) and character.Humanoid.Health > 0 then
                teleporting = true
                deps.tweenToModel(target)
                teleporting = false
            end
        end)
        status.Text = "Status: Working..."
        while deps.npcValid(target) and character.Humanoid.Health > 0 and wait() do
            while teleporting do
                wait()
            end
            for _, binding in pairs(state.Keys) do
                if binding[2] and binding[4] == "AutoFarm++"
                    and character.Humanoid.Health > 0 and deps.npcValid(target) then
                    if binding[3] == "CFrame" then
                        deps.useKey(binding[1], target.HumanoidRootPart.CFrame)
                    elseif binding[3] == "Vector3" then
                        deps.useKey(binding[1], target.HumanoidRootPart.Position)
                    else
                        deps.useKey(binding[1])
                    end
                end
                wait()
            end
        end
        status.Text = "Status: Done"
        stepConnection:Disconnect()
        wait()
    end
    status.Text = "Status: nil"
    if character.Humanoid.Health == 0 then
        wait(5)
    end
    services:UnbindFromRenderStep("hoax")
end

-- Selected child 0_50_0: QuirkSpin.AutoSpin controls the loop. It fires
-- ReplicatedStorage.Remotes.Spin("CommonSpin") while Cash.Value > 5000,
-- waits for the quirk to change, then checks QuirkSpin.IDs against the comma-
-- separated requested names. No timeout if the quirk never changes.
-- deps supplies getPlayerStats, getQuirk, getQuirkAsName, getQuirkAsID,
-- split(text, ","), remotes and statusLabel (the original UI/cached helpers).
local function autoSpinLoop(state, deps)
    local names
    if string.match(state.QuirkSpin.QuirkNames, ",") then
        names = deps.split(state.QuirkSpin.QuirkNames, ",")
    else
        names = {state.QuirkSpin.QuirkNames}
    end
    -- The initial parsed names were assigned by the original, then the
    -- inner loop parsed QuirkNames again; keep that behavior.
    local found = false
    while state.QuirkSpin.AutoSpin and deps.getPlayerStats().Cash.Value > 5000 do
        deps.remotes.Spin:FireServer("CommonSpin")
        local previous = deps.getQuirk()
        while deps.getQuirk() == previous do
            wait(0.1)
        end
        deps.statusLabel.Text = "Spinning: " .. deps.getQuirkAsName()
        for id, name in pairs(state.QuirkSpin.IDs) do
            for _, wanted in pairs(deps.split(state.QuirkSpin.QuirkNames, ",")) do
                if name:lower() == wanted:lower() and id == deps.getQuirkAsID() then
                    found = true
                    break
                end
            end
            if found then
                break
            end
        end
        if found then
            break
        end
    end
    deps.statusLabel.Text = "Spinned: " .. deps.getQuirkAsName()
end

return {
    questSnapshot = questSnapshot,
    autoQuestLoop = autoQuestLoop,
    npcAlive = npcAlive,
    tweenToNpc = tweenToNpc,
    pressKey = pressKey,
    swing = swing,
    autoFarm = autoFarm,
    autoSpinLoop = autoSpinLoop,
}
