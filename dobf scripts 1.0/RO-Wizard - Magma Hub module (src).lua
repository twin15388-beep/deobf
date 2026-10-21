--[[
Game-specific SRC | NOT DEOBFUSCATED | NOT TESTED IN ROBLOX
Game / variant: RO-Wizard / Magma Hub module
Original: https://github.com/Commandcracker/Magma-Hub/blob/5d7e2f84de039e65f909b50c3533b199fff9e9fd/games/1111920082.lua
Source SHA-256: ab4310d15d3c72a726f379ea2017a7136b4aa33884ffe920a6cb5078a946f012
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

-- RO-Wizard
local Page = MagmaHub:addPage("RO-Wizard")

-- Variables
local A_1 = "TogglePrompter"
local Event = game:GetService("ReplicatedStorage").Modules.Network.RemoteEvent

-- Functions
local function UsePrompter(Prompter)
    wait(.1)
    Event:FireServer(A_1, "Down", Prompter)
    wait(.1)
    Event:FireServer(A_1, "Up", Prompter)
end

-- Unlock All Spells
Page:addButton("Unlock All Spells", function()
    local BookStands = game:GetService("Workspace").BookStands:GetChildren()

    for _, BookStand in pairs(BookStands) do
        if BookStand:IsA("Model") then
            local Hitbox = BookStand:FindFirstChild("Hitbox")
            if Hitbox ~= nil then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Hitbox.CFrame
                UsePrompter(BookStand.Prompter)
                wait(.5)
            end
        end
    end
end)

-- Unlock All Books
Page:addButton("Unlock All Books", function()
    local Books = game:GetService("Workspace").Books:GetChildren()

    for _, Book in pairs(Books) do
        if Book:IsA("Model") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Book.Book.Main.CFrame
            UsePrompter(Book.Prompter)
            wait(.5)
        end
    end
end)

-- Teleports
local Teleports = MagmaHub:addPage("Teleports")

-- Badgers
Teleports:addButton("Badgers", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Spawns.Badgers.CFrame
end)

-- Lions
Teleports:addButton("Lions", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Spawns.Lions.CFrame
end)

-- Serpents
Teleports:addButton("Serpents", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Spawns.Serpents.CFrame
end)

-- Ravens
Teleports:addButton("Ravens", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Spawns.Ravens.CFrame
end)

-- Collect All Ingredients
Page:addButton("Collect All Ingredients", function()
    local Ingredients = game:GetService("Workspace").Ingredients:GetChildren()
    local done = {}

    for _, Ingredient in pairs(Ingredients) do
        if Btable.Contains(done, Ingredient.Name) == false then
            table.insert(done, Ingredient.Name)

            local Prompter = Ingredient:FindFirstChild("Prompter", true)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Prompter.PrompterPart.CFrame

            for _ = 1, 5 do
                UsePrompter(Prompter)
            end
        end
    end
end)
