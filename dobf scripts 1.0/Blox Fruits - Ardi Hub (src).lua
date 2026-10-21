--[[
Game source provenance | SRC | NOT TESTED IN ROBLOX
Original: https://github.com/raizu25112005/ArdiHub/blob/e10421c58f87e89fbb3b8ef33cbc2b68cf28ae06/script.lua
Source SHA-256: 3d0a066e6cca14e909ac5668cc6f82c6c386b287a3b71710687014219b88b4b0
Open source (src); no deobfuscation claimed.
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2025 Ardi Hub

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
]]

--[[
    Ardi Hub - Blox Fruits
    Created by: Ardian
    Support All Executors
    Anti-Ban System Included
]]

-- Anti-Ban System & Protection
local AntiCheat = {
    ['WalkSpeed'] = true,
    ['JumpPower'] = true,
    ['Gravity'] = true,
    ['Teleport'] = true,
    ['ServerHop'] = true
}

local function setupAntiDetection()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then
            return wait(9e9)
        end
        return old(self, unpack(args))
    end)
    setreadonly(mt, true)
end

-- Main Configuration
local Config = {
    AutoFarm = false,
    SeaEvent = false,
    AutoQuest = false,
    AutoRaid = false,
    FastAttack = false,
    AutoHaki = true,
    AutoStats = false,
    ChestFarm = false,
    AutoBoss = false,
    SubmergeQuest = false,
    BossConfig = {
        ["Cursed Captain"] = false,
        ["Sea Beast"] = false,
        ["Cake Prince"] = false,
        ["Elite Hunter"] = false,
        ["Sweet Cookie"] = false
    }
}

-- UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Ardi Hub - Blox Fruits", "DarkTheme")

-- Main Tab
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Farming")

MainSection:NewToggle("Auto Farm Level", "Auto farms levels", function(state)
    Config.AutoFarm = state
    if state then
        AutoFarmLevel()
    end
end)

-- Auto Farm Function
function AutoFarmLevel()
    spawn(function()
        while Config.AutoFarm do
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                if character and character:FindFirstChild("Humanoid") and character:FindFirstChild("HumanoidRootPart") then
                    -- Find nearest mob
                    local nearestMob = getNearestMob()
                    if nearestMob then
                        -- Teleport to mob
                        character.HumanoidRootPart.CFrame = nearestMob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                        -- Attack mob
                        attackMob(nearestMob)
                    end
                end
            end)
            wait()
        end
    end)
end

-- Helper Functions
function getNearestMob()
    local nearest = nil
    local minDistance = math.huge
    local character = game.Players.LocalPlayer.Character
    if character then
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") and mob.Humanoid.Health > 0 then
                local distance = (character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).magnitude
                if distance < minDistance then
                    minDistance = distance
                    nearest = mob
                end
            end
        end
    end
    return nearest
end

function attackMob(mob)
    local args = {
        [1] = mob.HumanoidRootPart.Position
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Combat", unpack(args))
end

-- Sea Event Tab
local EventTab = Window:NewTab("Events")
local EventSection = EventTab:NewSection("Sea Events")

EventSection:NewToggle("Auto Sea Event", "Automatically participates in sea events", function(state)
    Config.SeaEvent = state
    if state then
        AutoSeaEvent()
    end
end)

-- Auto Raid Tab
local RaidTab = Window:NewTab("Raids")
local RaidSection = RaidTab:NewSection("Auto Raid")

RaidSection:NewToggle("Auto Raid", "Automatically does raids", function(state)
    Config.AutoRaid = state
    if state then
        AutoRaid()
    end
end)

-- Stats Tab
local StatsTab = Window:NewTab("Stats")
local StatsSection = StatsTab:NewSection("Auto Stats")

StatsSection:NewToggle("Auto Stats", "Automatically upgrades stats", function(state)
    Config.AutoStats = state
    if state then
        AutoUpgradeStats()
    end
end)

-- Boss Tab
local BossTab = Window:NewTab("Boss")
local BossSection = BossTab:NewSection("Auto Boss")

BossSection:NewToggle("Auto Boss", "Automatically hunts all bosses", function(state)
    Config.AutoBoss = state
    if state then
        AutoBoss()
    end
end)

BossSection:NewToggle("Cursed Captain", "Hunt Cursed Captain Boss", function(state)
    Config.BossConfig["Cursed Captain"] = state
end)

BossSection:NewToggle("Sea Beast", "Hunt Sea Beast", function(state)
    Config.BossConfig["Sea Beast"] = state
end)

BossSection:NewToggle("Cake Prince", "Hunt Cake Prince Boss", function(state)
    Config.BossConfig["Cake Prince"] = state
end)

BossSection:NewToggle("Elite Hunter", "Hunt Elite Hunter Boss", function(state)
    Config.BossConfig["Elite Hunter"] = state
end)

BossSection:NewToggle("Sweet Cookie", "Hunt Sweet Cookie Boss", function(state)
    Config.BossConfig["Sweet Cookie"] = state
end)

-- Submerge Island Tab
local SubmergeTab = Window:NewTab("Submerge Island")
local SubmergeSection = SubmergeTab:NewSection("Auto Quest")

SubmergeSection:NewToggle("Auto Submerge Quest", "Automatically does Submerge Island quest", function(state)
    Config.SubmergeQuest = state
    if state then
        AutoSubmergeQuest()
    end
end)

-- Settings Tab
local SettingsTab = Window:NewTab("Settings")
local SettingsSection = SettingsTab:NewSection("Settings")

SettingsSection:NewToggle("Fast Attack", "Enables fast attack", function(state)
    Config.FastAttack = state
end)

SettingsSection:NewToggle("Auto Haki", "Automatically uses Haki", function(state)
    Config.AutoHaki = state
end)

-- Initialize Anti-Ban
setupAntiDetection()

-- Auto Boss Function
function AutoBoss()
    spawn(function()
        while Config.AutoBoss do
            pcall(function()
                for bossName, enabled in pairs(Config.BossConfig) do
                    if enabled then
                        local boss = getBossLocation(bossName)
                        if boss then
                            -- Teleport to boss
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            -- Attack boss
                            attackBoss(boss)
                        end
                    end
                end
            end)
            wait(1)
        end
    end)
end

function getBossLocation(bossName)
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == bossName and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

function attackBoss(boss)
    local args = {
        [1] = boss.HumanoidRootPart.Position
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Combat", unpack(args))
end

-- Auto Submerge Quest Function
function AutoSubmergeQuest()
    spawn(function()
        while Config.SubmergeQuest do
            pcall(function()
                -- Check if player is in correct sea
                if not game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CheckIsIsland") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") -- Travel to correct sea
                end
                
                -- Start Submerge Quest
                if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "SubmergeQuest", 1)
                end
                
                -- Find and collect quest items
                for _, v in pairs(workspace:GetDescendants()) do
                    if v.Name == "SubmergeQuestItem" and v:FindFirstChild("Handle") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                        wait(1)
                        fireproximityprompt(v.Handle.ProximityPrompt)
                    end
                end
                
                -- Complete quest if possible
                if game:GetService("Players").LocalPlayer.Data.QuestProgress.Value >= 10 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CompleteQuest", "SubmergeQuest")
                end
            end)
            wait(1)
        end
    end)
end

-- Main Loop
spawn(function()
    while wait() do
        if Config.AutoHaki then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Ardi Hub",
    Text = "Script loaded successfully!",
    Duration = 5
})
