--[[
GAME: Item Factory | PARTIAL STATIC DEOBFUSCATION | NOT A COMPLETE HUB
Protected input: https://github.com/Xowie89/Roblox-Scripts/blob/b6d7f6a456750eaac26a7bbbdcaa8e77798c6e56/Item%20Factory.lua
Input SHA-256: c389d0183e2c68b2e72c92fe2bfce8d926f119ddbe42984ca9b5031d9611c73c
Recovery: luaprojects/moonsec-js-deobf@7a4be80850f2b2a5ad20a02ef486d518f2164b27 (MoonSec V3 -> Lua 5.1 bytecode); manually rewritten SELECTED children only. The recovered root chunk and four child chunks FAIL Lua 5.1 bytecode verification and are NOT published. This file is not that root, not an original source dump, and not evidence of equivalence to the whole protected input.
The module API names (some echo recovered global labels), default state, injected dependencies, shell, comments and UI-free wiring below are OUR additions, not recovered author comments or local names. The game's mutable UI download, Discord HTTP POST and top-level bootstrap are deliberately absent; neither protected top-level nor Roblox was executed (the tool evaluated only isolated decryption-key expressions). `getconnections` for upgrades is an executor-specific dependency. Operations can spend in-game money, teleport, attack or DROP ITEMS. Offline mock tests are not a live-game test. Candidate game title: Item Factory (not Item Factory 2); no PlaceId check was recovered.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2023 Xowie89

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

-- The suffix table was read from the recovered parent; helper child 0_8.
local suffixes = {"K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "O", "N", "D", "UnD", "DD", "TD", "QdD", "QnD", "SxD", "SpD", "OcD", "ND", "Vn", "UnVn", "DVn", "TVn", "QdVn", "QnVn", "SxVn", "SpVn", "OVn", "NVn", "Tri"}

function M.fromSuffixString(text)
    local firstLetter = string.find(text, "%a")
    if firstLetter then
        local prefix = string.sub(text, 1, firstLetter - 1)
        local suffix = string.sub(text, firstLetter, #text)
        local index = 0
        for i, value in ipairs(suffixes) do
            if value == suffix then index = i; break end
        end
        return tonumber(prefix) * math.pow(10, index * 3)
    end
    return tonumber(text)
end

-- The defaults correspond to the protected UI settings, not to recovered
-- original variable names. Set `lastUpgrade/lastRefresh/lastAttack` to tick()
-- before connecting a periodic callback if you want the original startup pace.
function M.defaultState()
    return {
        enabled = false, autoKill = false, autoSell = false, speedHack = false,
        busy = false, selectedMode = "PvE", currentMap = "Home",
        selectedTool = nil, rarityThreshold = 15, healthThreshold = 25,
        speedModifier = 38, lastUpgrade = 0, lastRefresh = 0, lastAttack = 0,
        upgradeMachines = {Conveyor = false, Molder = false, Upgrader = false,
            Enchanter = false, Appraiser = false},
    }
end

-- Children 0_18 / 0_11. The source looks at direct workspace children, NOT
-- Descendants. `false` (not nil) means no nearby non-player model with HP > 1.
function M.findClosest(deps)
    local closest, nearestDistance = false, 500
    for _, model in pairs(deps.workspace:GetChildren()) do
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        local root = model:FindFirstChild("HumanoidRootPart")
        if model:IsA("Model") and not deps.players:GetPlayerFromCharacter(model)
                and root and humanoid and humanoid.Health > 1 then
            local distance = deps.player:DistanceFromCharacter(root.Position)
            if distance < nearestDistance then
                nearestDistance = deps.player:DistanceFromCharacter(root.Position)
                closest = model
            end
        end
    end
    return closest
end

function M.onSelectedMap(state, deps)
    local mapName
    if state.selectedMode == "PvE" then mapName = "NormalMap"
    elseif state.selectedMode == "PvP" then mapName = "PVPMap"
    elseif state.selectedMode == "KOTH" then mapName = "KOTHMap" end
    local map = mapName and deps.workspace:FindFirstChild(mapName)
    local onMap = false
    if map then
        for _, part in pairs(map:GetDescendants()) do
            if part:IsA("Part") then
                if part.Shape == deps.Enum.PartType.Cylinder and part.CanCollide then
                    part.CanCollide = false
                end
                if deps.player:DistanceFromCharacter(part.Position) <= 150 then
                    onMap = true
                    state.currentMap = state.selectedMode
                end
            end
        end
    end
    return onMap
end

-- Child 0_27. AutoKill controls whether we equip the tool chosen at startup.
function M.equip(state, deps)
    if state.autoKill then
        local character = deps.player.Character
        local equipped = character:FindFirstChildOfClass("Tool")
        if equipped ~= state.selectedTool then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:EquipTool(state.selectedTool) end
        end
    end
end

-- Child 0_2. Only raises Speed.Value; never lowers it when toggled off.
function M.speed(state, deps)
    if not state.speedHack then return end
    local equipped = deps.player.Character:FindFirstChildOfClass("Tool")
    if equipped then
        local stats = equipped:FindFirstChild("WeaponStats")
        if stats and stats.Speed.Value < state.speedModifier then
            stats.Speed.Value = state.speedModifier
        end
    end
    for _, tool in pairs(deps.player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("WeaponStats") then
            local stats = tool:FindFirstChild("WeaponStats")
            if stats and stats.Speed.Value < state.speedModifier then
                stats.Speed.Value = state.speedModifier
            end
        end
    end
end

-- Child 0_16. DESTRUCTIVE: the low-rarity tool is reparented into workspace.
-- This does not check the UI toggle itself; called as the Auto Sell callback.
function M.dropBelowRarity(state, deps)
    local humanoid = deps.player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then humanoid:UnequipTools() end
    for _, tool in pairs(deps.player.Backpack:GetChildren()) do
        if tool:IsA("Tool") and tool.ItemInfo.Rarity.Value < state.rarityThreshold
                and tool ~= state.selectedTool then
            humanoid:EquipTool(tool)
            deps.wait(0.25)
            tool.Parent = deps.workspace
        end
    end
    state.busy = false
end

-- Child 0_10: a bag of >= 9 items, Auto Sell enabled and not already busy.
-- Relies on a movement helper to call the drop callback on arrival; the
-- MoveToFinished/spawn/watchdog implementation from child 0_21 is NOT here.
function M.dropTrash(state, deps)
    if #deps.player.Backpack:GetChildren() >= 9 and state.autoSell and not state.busy then
        state.busy = true
        repeat
            deps.replicatedStorage.Events.GoPlaces:FireServer("Home")
            state.currentMap = "Home"
            deps.wait(1)
        until deps.player:DistanceFromCharacter(
            deps.workspace.Islands[deps.player.Name .. " Island"].SellStation.MainTouch.Position) <= 200
        local humanoid = deps.player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            deps.moveTo(humanoid,
                deps.workspace.Islands[deps.player.Name .. " Island"].SellStation.MainTouch.Position,
                function() M.dropBelowRarity(state, deps) end)
        end
    end
end

-- Child 0_20. At or below % of max HP, teleports Home and blocks until
-- distance <= 200 and HP == MaxHealth. Without bounded mocks this can hang.
function M.retreatAtHealth(state, deps)
    local humanoid = deps.player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health <= humanoid.MaxHealth * (state.healthThreshold / 100)
            and not state.busy then
        state.busy = true
        repeat
            deps.replicatedStorage.Events.GoPlaces:FireServer("Home")
            state.currentMap = "Home"
            deps.wait(0.1)
        until deps.player:DistanceFromCharacter(
            deps.workspace.Islands[deps.player.Name .. " Island"].SellStation.MainTouch.Position) <= 200
        repeat deps.wait() until humanoid.Health == humanoid.MaxHealth
        state.busy = false
    end
end

-- Helper 0_12's bytecode is NOT valid Lua 5.1, so this separate wrapper is
-- reconstructed from its disassembly and smoke-tested only. Connection
-- objects and `getconnections` are executor-specific and must be injected.
function M.press(button, deps)
    for _, signal in ipairs({button.MouseButton1Click,
            button.MouseButton1Down, button.Activated}) do
        for _, connection in pairs(deps.getconnections(signal)) do
            connection:Fire()
        end
    end
end

-- Child 0_25. Finds green Upgrade descendants of enabled machines; ranking
-- (highest displayed level, then lowest price) retains the recovered logic,
-- including its odd reset of the price threshold on higher-level entries.
-- Pressing may SPEND GAME CURRENCY; the on-screen text format is required.
function M.upgrade(state, deps)
    local cheapestPrice, highestLevel, chosen = 1e200, 0, false
    local upgrades = deps.player.PlayerGui.MainGUI.Upgrades
    for _, button in pairs(upgrades:GetDescendants()) do
        if button.Name == "Upgrade" and button.BackgroundColor == deps.BrickColor.new("Bright green")
                and state.upgradeMachines[button.Parent.Name] then
            local text = button.Text
            local openBracket = string.find(text, "%[")
            local closeBracket = string.find(text, "%]")
            local price
            if openBracket and closeBracket then
                local level = M.fromSuffixString(string.sub(text, openBracket + 2, closeBracket - 1))
                price = M.fromSuffixString(string.sub(text,
                    string.find(text, "%(") + 2, string.find(text, "%)") - 1))
                if highestLevel < level then
                    highestLevel = level
                    chosen = button
                    if price < cheapestPrice then
                        cheapestPrice = price
                        chosen = button
                    end
                elseif level == highestLevel and price < cheapestPrice then
                    cheapestPrice = price
                    chosen = button
                end
            else
                price = M.fromSuffixString(string.sub(text,
                    string.find(text, "%(") + 2, string.find(text, "%)") - 1))
                if price < cheapestPrice then
                    cheapestPrice = price
                    chosen = button
                end
            end
        end
    end
    if chosen then
        if deps.press then deps.press(chosen) else M.press(chosen, deps) end
    end
end

-- Child 0_23: the recovered RunService.Stepped callback. Nothing is bound
-- automatically: call it explicitly, with state/deps and a moveTo helper.
-- The external UI, networking helpers and anti-tamper path are not included.
function M.farmTick(state, deps)
    if state.busy or not state.enabled then return end
    if deps.tick() - state.lastUpgrade >= 0.01 then
        state.lastUpgrade = deps.tick()
        M.upgrade(state, deps)
    end
    if deps.tick() - state.lastRefresh >= 1 then
        state.lastRefresh = deps.tick()
        M.dropTrash(state, deps)
        M.speed(state, deps)
        if not M.onSelectedMap(state, deps) and not state.busy and state.autoKill
                and state.currentMap ~= state.selectedMode then
            if state.currentMap ~= "Home" then
                deps.replicatedStorage.Events.GoPlaces:FireServer("Home")
                state.currentMap = "Home"
            else
                deps.replicatedStorage.Events.GoPlaces:FireServer(state.selectedMode)
            end
        end
    end
    local target = M.findClosest(deps)
    if target and not state.busy and state.autoKill then
        if deps.tick() - state.lastAttack >= 0.1 then
            state.lastAttack = deps.tick()
            M.equip(state, deps)
            deps.virtualUser:ClickButton1(deps.workspace.CurrentCamera.ViewportSize,
                deps.workspace.CurrentCamera.CFrame)
            local enemyHumanoid = target:FindFirstChildOfClass("Humanoid")
            local enemyRoot = target:FindFirstChild("HumanoidRootPart")
            local humanoid = deps.player.Character:FindFirstChildOfClass("Humanoid")
            if enemyRoot and enemyHumanoid and humanoid then
                if state.currentMap == "KOTH" then
                    local kingHill = deps.workspace.KOTHMap.KOTH
                    if not string.match(kingHill.KOTHGUI.HoldTime.Text, "locked") then
                        humanoid:MoveTo(kingHill.KOTHContested.Position)
                    end
                elseif enemyHumanoid.Health > 0 then
                    humanoid:MoveTo(enemyRoot.Position)
                end
            end
        end
        M.retreatAtHealth(state, deps)
    end
end

return M
