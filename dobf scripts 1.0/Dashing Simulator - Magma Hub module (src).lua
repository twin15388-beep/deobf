--[[
Game-specific Luau: NOT DEOBFUSCATED / SRC / NOT TESTED IN ROBLOX
Source: https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/962480973.lua
Source SHA-256: c63f8514b1625f5fd6730ae283e0a36504cbcf153a8ec591c31118592db01424
Status: MIT source file, not a recovery.
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2021 Commandcracker

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

-- Dashing Simulator
local Page = MagmaHub:addPage("Dashing Simulator")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local LocalPlayer = Players.LocalPlayer

-- Add Speed
local AddSpeedButton = Page:addToggle("Add Speed")

Threads:Add(function()
    while wait() do
        if AddSpeedButton:IsEnabeld() then
            ReplicatedStorage.Events.AddSpeed:InvokeServer()
        end
    end
end)

-- Auto Rebirth
local AutoRebirthButton = Page:addToggle("Auto Rebirth")

Threads:Add(function()
    while wait() do
        if AutoRebirthButton:IsEnabeld() then
            ReplicatedStorage.Events.Rebirth:InvokeServer()
        end
    end
end)

-- Auto Collect Orbs
local AutoCollectOrbsButton = Page:addToggle("Auto Collect Orbs (Don't pick up orbs manually)")

Threads:Add(function()
    local CollectableOrbs = workspace.CollectableOrbs:GetChildren()

    while wait() do
        if AutoCollectOrbsButton:IsEnabeld() then
            for _, Orb in pairs(CollectableOrbs) do
                if Orb.Name == "35" and Orb.Small.Transparency == 0 then
                    if firetouchinterest == nil then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Orb.Small.CFrame
                    else
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Orb.Small, 0)
                        wait()
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Orb.Small, 1)
                    end
                    wait(2)
                    if AutoCollectOrbsButton:IsEnabeld() == false then
                        break
                    end
                end
            end
        end
    end
end)

-- Auto Collect Flowers
local AutoCollectFlowersButton = Page:addToggle("Auto Collect Flowers (Don't pick up flowers manually)")

Threads:Add(function()
    local Flowers = workspace.Flowers:GetChildren()

    while wait() do
        if AutoCollectFlowersButton:IsEnabeld() then
            for _, Flower in pairs(Flowers) do
                if Flower.Name == "30" and Flower.Main.Transparency == 0 then
                    if firetouchinterest == nil then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Flower.Main.CFrame
                    else
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Flower.Main, 0)
                        wait()
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Flower.Main, 1)
                    end
                    wait(2)
                    if AutoCollectFlowersButton:IsEnabeld() == false then
                        break
                    end
                end
            end
        end
    end
end)

-- Claim Chests
Page:addButton("Claim Chests", function()
    local Chests = workspace.Chests:GetChildren()
    local Pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame

    for _, Chest in pairs(Chests) do
        if firetouchinterest == nil then
            LocalPlayer.Character.HumanoidRootPart.CFrame = Chest.Toucher.CFrame
        else
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Chest.Toucher, 0)
            wait()
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Chest.Toucher, 1)
        end
        wait(.5)
    end

    if firetouchinterest == nil then
        LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
end)

-- Auto Accept Race
local AutoAcceptRace = Page:addToggle("Auto Accept Race")

Threads:Add(function()
    while wait() do
        if AutoAcceptRace:IsEnabeld() then
            if LocalPlayer.PlayerGui.RaceGUI.Offer.Visible == true then
                LocalPlayer.PlayerGui.RaceGUI.Offer.Visible = false
                ReplicatedStorage.Events.RaceRequest:FireServer()
            end
        end
    end
end)

-- Win Race
local WinRace = Page:addToggle("Win Race")

Threads:Add(function()
    while wait() do
        if WinRace:IsEnabeld() then
            local Track = workspace.RaceTrack:FindFirstChildOfClass("Model")

            if Track ~= nil and Track:FindFirstChild("Counter") ~= nil and Track.Counter:FindFirstChild("SurfaceGui") ~=
                nil and Track.Counter.SurfaceGui:FindFirstChild("TextLabel") ~= nil and
                Track.Counter.SurfaceGui.TextLabel.Text == "2" then
                wait(5)
                LocalPlayer.Character.HumanoidRootPart.CFrame = Track.Finish.CFrame
            end
        end
    end
end)

-- Discover Lands
Page:addButton("Discover Lands", function()
    local Discoveries = workspace.Discoveries:GetChildren()
    for _, Land in pairs(Discoveries) do
        ReplicatedStorage.Events.Discover:InvokeServer(Land.Name)
    end
end)

-- Teleports
local Teleports = MagmaHub:addPage("Teleports")

Teleports:addButton("Spawn", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(55, 6, -58)
end)

Teleports:addButton("Elite Island", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(252, 6, -3300)
end)

Teleports:addButton("Dessert Chest", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7870, 6, 39)
end)

Teleports:addButton("Golden Chest", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(471, 17, -27)
end)

Teleports:addButton("Cloud Land", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(442, 17, 2)
end)

Teleports:addButton("Ice Land", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3085, 6, -49)
end)

Teleports:addButton("Farm Ville", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1414, 6, -41)
end)

Teleports:addButton("Sand Land", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-7925, 6, -6)
end)

Teleports:addButton("Moon", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-322, 1879, 3217)
end)

Teleports:addButton("Magma", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1281, 1867, 7342)
end)

Teleports:addButton("100 Rebirths", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4664, 2221, 7802)
end)
