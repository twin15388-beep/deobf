--[[
Game-specific SRC | NOT DEOBFUSCATED | NOT TESTED IN ROBLOX
Game / variant: Pet Simulator X / Magma Hub module
Original: https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/2316994223.lua
Source SHA-256: 1467665e670ab3c57b5721b15ab069beb961bdaf411093fd131808a477c0c609
Snapshot: 5d7e2f84de039e65f909b50c3533b199fff9e9fd
Source status: MIT
Note: Static Lua source copy; no Roblox runtime test.
Upstream license notice:

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
]]

-- Pet Simulator X
local Page = MagmaHub:addPage("Pet Simulator X")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

-- Auto Collect Orbs
local AutoCollectOrbs = Page:addToggle("Auto Collect Orbs")

Threads:Add(function()
    while wait() do
        if AutoCollectOrbs:IsEnabeld() then
            for _, v in pairs(workspace["__THINGS"].Orbs:GetChildren()) do
                v.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

-- Auto Collect Lootbags
local AutoCollectLootbags = Page:addToggle("Auto Collect Lootbags")

Threads:Add(function()
    while wait() do
        if AutoCollectLootbags:IsEnabeld() then
            for _, v in pairs(workspace["__THINGS"].Lootbags:GetChildren()) do
                v.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

-- Auto Collect Gifts
local AutoCollectGifts = Page:addToggle("Auto Collect Gifts")

Threads:Add(function()
    while wait() do
        if AutoCollectGifts:IsEnabeld() then
            for _, v in pairs(ReplicatedStorage:GetChildren()) do
                if v.Name == "RemoteFunction" then
                    for i = 1, 12 do
                        pcall(function()
                            v:InvokeServer(i)
                        end)
                    end
                end
            end
            wait(1)
        end
    end
end)

-- Auto Farm
local AutoFarm = Page:addToggle("Auto Farm")
local Framework = require((ReplicatedStorage:WaitForChild("Framework")):WaitForChild("Library"))

local function FindNearestCoin()
    local found
    local last = math.huge

    for _, Coin in pairs(workspace["__THINGS"].Coins:GetChildren()) do
        local distance = LocalPlayer:DistanceFromCharacter(Coin.POS.Position)
        if distance < last then
            found = Coin
            last = distance
        end
    end
    return found
end

Threads:Add(function()
    while wait() do
        if AutoFarm:IsEnabeld() then
            local Coin = FindNearestCoin()
            local pets = tonumber(LocalPlayer.PlayerGui.Main.Bottom.Inventory.Equipped.Text:split("/")[1])

            for _ = 1, pets do
                Framework.Signal.Fire("Select Coin", Coin)
                wait(0.1)
            end

            while #Coin:GetChildren() ~= 0 and AutoFarm:IsEnabeld() do
                wait()
            end
        end
    end
end)
