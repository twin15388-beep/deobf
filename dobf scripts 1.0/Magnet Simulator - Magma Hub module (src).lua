--[[
Game-specific Luau: NOT DEOBFUSCATED / SRC / NOT TESTED IN ROBLOX
Source: https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/1237829262.lua
Source SHA-256: 00cc584e0dcea3922267685aa43e5fe443a48d7d30862f48bf80df815a2fc193
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

-- Magnet Simulator
local Page = MagmaHub:addPage("Magnet Simulator")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local LocalPlayer = Players.LocalPlayer

-- Auto Sell
local Sell = workspace:WaitForChild("Rings"):WaitForChild("Sellx2")
local pos = Sell.CFrame
local AutoSell = Page:addToggle("Auto Sell", nil, function()
    if firetouchinterest == nil then
        Sell.CanCollide = true
        Sell.CFrame = pos
    end
end)

Threads:Add(function()
    while task.wait() do
        if AutoSell:IsEnabeld() then
            if firetouchinterest == nil then
                Sell.CanCollide = false
                Sell.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, math.random(-1, 1), 0)
            else
                if LocalPlayer.Character ~= nil and LocalPlayer.Character.HumanoidRootPart ~= nil then
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Sell, 0)
                    task.wait()
                    firetouchinterest(LocalPlayer.Character.HumanoidRootPart, Sell, 1)
                end
            end
        end
    end
end)

LocalPlayer.PlayerGui.GameHUD.FullBackpack.Changed:Connect(function()
    if AutoSell:IsEnabeld() then
        LocalPlayer.PlayerGui.GameHUD.FullBackpack.Visible = false
    end
end)

-- Teleports
local Teleports = MagmaHub:addPage("Teleports")

-- Spawn
Teleports:addButton("Spawn", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(127, 14, -81)
end)

-- Magnet Island
Teleports:addButton("Magnet Island", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16, 580, -273)
end)

-- Auto Collect Coins
local AutoCollectCoins = Page:addToggle("Auto Collect Coins")

Threads:Add(function()
    while task.wait() do
        if AutoCollectCoins:IsEnabeld() then
            ReplicatedStorage.Events.MagnetEvents.requestGrab:FireServer("6080000000",
                ReplicatedStorage.Tools["Lucky Long Tri-Magnet"])
        end
    end
end)

-- Auto Rebirth
local AutoRebirth = MagmaHub:addPage("Auto Rebirth")

local Rebirths = {200000, 125000, 100000, 75000, 50000, 25000, 10000, 5000, 2500, 1000, 500, 250, 100, 50, 25, 5, 1}

local AutoRebirthCanAfford = AutoRebirth:addToggle("Auto Rebirth (Can Afford)")
Threads:Add(function()
    while task.wait() do
        if AutoRebirthCanAfford:IsEnabeld() then
            for _, v in pairs(Rebirths) do
                ReplicatedStorage.RebirthEvents.requestRebirth:InvokeServer(v)
            end
        end
    end
end)

for _, v in pairs(Btable.Reverse(Rebirths)) do
    local AutoRebirthButton = AutoRebirth:addToggle("Auto Rebirth " .. tostring(v))
    local Rebirth = v
    Threads:Add(function()
        while task.wait() do
            if AutoRebirthButton:IsEnabeld() then
                ReplicatedStorage.RebirthEvents.requestRebirth:InvokeServer(Rebirth)
            end
        end
    end)
end
