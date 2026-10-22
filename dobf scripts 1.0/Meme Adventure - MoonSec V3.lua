--[[
Meme Adventure (Roblox PlaceId 9566949295) — STATIC MOONSEC V3 DEOBFUSCATION.
This is recovered game-specific Lua 5.1, NOT a guarantee that it works in Roblox.
Source: https://github.com/neowaree/free-version/blob/81dfc296449f332766b0ce22e24f0b751d67c319/CustomModules/9566949295.lua
Input SHA-256: 3c14a7868e8cba18ff447d59053425371cc9285ea635f57427afa567b4bb4d27 (107603 bytes).
Method: luaprojects/moonsec-js-deobf@7a4be80850f2b2a5ad20a02ef486d518f2164b27,
  with arithmetic-only Fengari key evaluation and NO Lua standard libraries;
  unluac-js@1.4.4 decompiled its validated 11609-byte Lua 5.1 chunk.
  Bytecode SHA-256: 2df2d2acc40f972c98d1128201ccbddeff3bdd32a026c3ef4a827c9e80fae8d6.
  Decompiled body SHA-256: d879107e15dde5ac462678f7ec82ca02bbee72c59eb236e573c443c902842b1c.
MPL-2.0: This Source Code Form is subject to the terms of the Mozilla Public
  License, v. 2.0. Original LICENSE preserved verbatim at
  reports/licenses/Neoware-MPL-2.0.txt in this repository.
  This readable decompilation is a modification of neoware's protected file.
  This provenance notice is OUR addition. The rN_*/pN_* names, proto# labels
  and initial four comments in the body are DECOMPILER OUTPUT, not names or
  comments recovered from the author's source.
CAUTIONS: no protected top-level or Roblox code was executed in recovery.
  Starting this file executes a MUTABLE third-party DrRay UI via HttpGet and
  loadstring; that external UI is neither included nor verified here.
  "Auto Farm Mobs" and "Teleport Loop" check for missing targets but do NOT
  attack or teleport to mobs in this recovered body. "Faster Fishing" sends
  Armor requests, NOT a fishing request. Armor toggles share _G.ez; the
  Auto Grab Tools toggle references an undefined autoGrabTools. No live
  server acceptance, game version compatibility, or full semantic
  equivalence with MoonSec's original VM has been established.
]]

-- file:
-- dialect: lua5.1
-- encoding: auto
-- decompiled by unluac-rs (https://github.com/x3zvawq/unluac-rs)

local r0_0 = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local r0_1 = r0_0:Load("neoware", "Default")
local r0_2 = r0_0.newTab("Main", "Why not")
r0_2.newLabel("Auto Farm Gifts")
r0_2.newToggle("Farm Gifts", "Now Go Afk", false, function(p9_0) -- proto#9 params=1 locals=0 upvalues=0 vararg=false source=
    _G.AutoGift = p9_0
    spawn(function() -- proto#10 params=0 locals=0 upvalues=0 vararg=false source=
        while task.wait(0.5) do
            pcall(function() -- proto#11 params=0 locals=12 upvalues=0 vararg=false source=
                if _G.AutoGift then
                    for r11_0, r11_1 in pairs(game.Workspace:GetDescendants()) do
                        if r11_1.Name == "Gift" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r11_1.CFrame
                            wait()
                            for r11_2, r11_3 in pairs(game.Workspace:GetDescendants()) do
                                if r11_3.Name == "ProximityPrompt" then
                                    fireproximityprompt(r11_3, 10)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
    spawn(function() -- proto#12 params=0 locals=0 upvalues=0 vararg=false source=
        while task.wait(0.5) do
            pcall(function() -- proto#13 params=0 locals=12 upvalues=0 vararg=false source=
                if _G.AutoGift then
                    for r13_0, r13_1 in pairs(game.Workspace:GetDescendants()) do
                        if r13_1.Name == "Unique Gift" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = r13_1.CFrame
                            wait()
                            for r13_2, r13_3 in pairs(game.Workspace:GetDescendants()) do
                                if r13_3.Name == "ProximityPrompt" then
                                    fireproximityprompt(r13_3, 10)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end)
r0_2.newLabel("Auto Farm Mob")
local r0_3 = {}
local r0_4 = {}
for r0_5, r0_6 in ipairs(workspace.Enemy:GetChildren()) do
    table.insert(r0_3, r0_6.Name)
    table.insert(r0_4, r0_6.Name)
end
local r0_7, r0_8 = nil, false

local function r0_9() -- proto#25 params=0 locals=0 upvalues=2 vararg=false source=
    while r0_8 do
        if not workspace.Enemy[r0_7] then
            print("Invalid morph selected!")
        end
        task.wait(1)
    end
end

local r0_10 = coroutine.wrap(r0_9)
r0_2.newToggle("Auto Farm Mobs", "Automatically farm selected morph", false, function(p16_0) -- proto#16 params=1 locals=0 upvalues=2 vararg=false source=
    r0_8 = p16_0
    if p16_0 then
        r0_10()
    end
end)
r0_2.newDropdown("Select Morph", "", r0_4, function(p8_0) -- proto#8 params=1 locals=0 upvalues=1 vararg=false source=
    r0_7 = p8_0
end)
r0_2.newLabel("Teleport Loop")
local r0_11 = { "Under", "Above", "Behind", "Infront" }
local r0_12 = nil
local r0_13 = false

local function r0_14() -- proto#19 params=0 locals=3 upvalues=3 vararg=false source=
    while r0_13 do
        local r19_0 = workspace.Enemy[r0_7]
        local r19_1 = game
        local r19_2 = r19_1:GetService("Players")
        r19_2 = r19_2.LocalPlayer.Character
        if not (r19_0 and r19_2) then
            print("Invalid morph or player not found!")
        end
        task.wait(1)
    end
end

local r0_15 = coroutine.wrap(r0_14)
r0_2.newToggle("Teleport Loop", "Teleport player to selected", false, function(p17_0) -- proto#17 params=1 locals=0 upvalues=2 vararg=false source=
    r0_13 = p17_0
    if p17_0 then
        r0_15()
    end
end)
r0_2.newLabel("Hold Weapon Loop")
local r0_16 = {}
local r0_17, r0_18 = nil, false

local function r0_19() -- proto#6 params=0 locals=5 upvalues=2 vararg=false source=
    while r0_18 do
        local r6_0 = game:GetService("Players").LocalPlayer
        local r6_1 = r6_0.Backpack
        local r6_2 = r6_1:FindFirstChild(r0_17)
        if r6_2 then
            r6_0.Character.Humanoid:EquipTool(r6_2)
        else
            print("Weapon not found in backpack!")
        end
        task.wait(0.1)
    end
end

local r0_20 = coroutine.wrap(r0_19)

local function r0_21() -- proto#14 params=0 locals=7 upvalues=1 vararg=false source=
    local r14_0 = game
    local r14_1 = r14_0:GetService("Players")
    r14_1 = r14_1.LocalPlayer
    local r14_2 = r14_1.Backpack
    r0_16 = {}
    if r14_2 then
        for r14_3, r14_4 in ipairs(r14_2:GetChildren()) do
            if r14_4:IsA("Tool") then
                table.insert(r0_16, r14_4.Name)
            end
        end
    end
end

r0_21()
r0_2.newDropdown("Select Weapon", "", r0_16, function(p2_0) -- proto#2 params=1 locals=0 upvalues=1 vararg=false source=
    r0_17 = p2_0
end)
r0_2.newToggle("Hold Weapon Loop", "Hold the selected weapon from inventory", false, function(p27_0) -- proto#27 params=1 locals=0 upvalues=3 vararg=false source=
    r0_18 = p27_0
    if p27_0 then
        r0_21()
        r0_20()
    end
end)
local r0_22 = r0_0.newTab("Auto Others")
r0_22.newLabel("Extra")
r0_22.newButton("Instant E Collect", "Set HoldDuration to 0 for chests , pray and fish", function() -- proto#21 params=0 locals=9 upvalues=0 vararg=false source=
    for r21_0, r21_1 in ipairs(workspace.Chest:GetChildren()) do
        local r21_2 = r21_1:FindFirstChild("ProximityPrompt")
        if r21_2 then
            r21_2.HoldDuration = 0
        end
    end
    workspace.Map.Snow.Pray.ProximityPrompt.HoldDuration = 0
    workspace.Map.Snow:GetChildren()[7].ProximityPrompt.HoldDuration = 0
    workspace.Map.Snow:GetChildren()[8].ProximityPrompt.HoldDuration = 0
    workspace:GetChildren()[21].ProximityPrompt.HoldDuration = 0
    workspace.FISH.Desert.Fishing1.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Desert.Fishing2.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Desert.Fishing3.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Desert.Fishing4.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Desert.Fishing5.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Volcano.Fishing1.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Volcano.Fishing2.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Volcano.Fishing3.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Volcano.Fishing4.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Volcano.Fishing5.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Snow.Fishing1.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Snow.Fishing2.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Snow.Fishing3.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Snow.Fishing4.ProximityPrompt.HoldDuration = 0
    workspace.FISH.Snow.Fishing5.ProximityPrompt.HoldDuration = 0
end)
local r0_23 = nil
r0_22.newToggle("Auto Grab Tools", "Bring all dropped tools to your character", false, function(p7_0) -- proto#7 params=1 locals=1 upvalues=1 vararg=false source=
    autoGrabEnabled = p7_0
    if p7_0 then
        r0_23 = coroutine.create(autoGrabTools)
        coroutine.resume(r0_23)
    elseif r0_23 then
        coroutine.yield(r0_23)
        r0_23 = nil
    end
end)
r0_22.newLabel("Auto Fish")
r0_22.newToggle("Faster Fishing", "(Lag ngl)", false, function(p5_0) -- proto#5 params=1 locals=10 upvalues=0 vararg=false source=
    _G.fast = p5_0
    while _G.fast do
        wait()
        local r5_0 = { [1] = "The World Head", [2] = "Armor" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r5_0))
        local r5_1 = { [1] = "Cosmic Orb", [2] = "Armor" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r5_1))
        local r5_2 = { [1] = "Skull Bike", [2] = "Armor" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r5_2))
    end
end)
r0_22.newLabel("Map Settings")
r0_22.newToggle("Infinite Max Zoom", "Set max zoom to infinity", false, function(p26_0) -- proto#26 params=1 locals=0 upvalues=0 vararg=false source=
    _G.infiniteMaxZoom = p26_0
    if p26_0 then
        game.Players.LocalPlayer.CameraMaxZoomDistance = 9000000000
    else
        game.Players.LocalPlayer.CameraMaxZoomDistance = 400
    end
end)
local r0_24 = r0_0.newTab("Armors/Helmets", "op")
r0_24.newToggle("Get Armors(8k HP) ", "(ใช้ไม่ได้ก็นั่นแหละ)", false, function(p4_0) -- proto#4 params=1 locals=19 upvalues=0 vararg=false source=
    _G.ez = p4_0
    while _G.ez do
        task.wait()
        local r4_0 = { [1] = "King Seal Armor", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r4_0))
        local r4_1 = { [1] = "Mumu Armor", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r4_1))
        local r4_2 = { [1] = "Hardened Armor", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r4_2))
        local r4_3 = { [1] = "X-Mas Armor", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r4_3))
        local r4_4 = { [1] = "Hellish Energy", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r4_4))
        local r4_5 = { [1] = "King Seal Armor", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r4_5))
    end
end)
r0_24.newToggle("Get Void Head ", "(ของดี)", false, function(p15_0) -- proto#15 params=1 locals=19 upvalues=0 vararg=false source=
    _G.ez = p15_0
    while _G.ez do
        wait()
        local r15_0 = { [1] = "Void Head", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r15_0))
        local r15_1 = { [1] = "Pumpkin Head", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r15_1))
        local r15_2 = { [1] = "Void Head", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r15_2))
        local r15_3 = { [1] = "Pumpkin Head", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r15_3))
        local r15_4 = { [1] = "Void Head", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r15_4))
        local r15_5 = { [1] = "Void Head", [2] = "Helmet" }
        game:GetService("ReplicatedStorage").OtherThing.Tools:FireServer(unpack(r15_5))
    end
end)
local r0_25 = r0_0.newTab("Teleport")
r0_25.newLabel("Teleport")
local r0_26 = {
    "Chad Island", "Mage Island", "Desert Island", "Volcano Island", "Magma Raid", "Magma Fishing",
    "Snow Island", "Snow Fishing", "Pray", "Railgun City", "Geto Boss", "Borzoi Boss", "Dagon Boss"
}
local r0_27 = nil
local r0_28 = false
local r0_29 = {}
for r0_30, r0_31 in ipairs(r0_26) do
    r0_29[r0_31] = function() -- proto#1 params=0 locals=4 upvalues=2 vararg=false source=
        while r0_28 do
            local r1_0 = {
                ["Chad Island"] = CFrame.new(-747.6099853515625, 16.68632698059082, 286.83099365234375),
                ["Mage Island"] = CFrame.new(563.7796020507813, 16.722782135009766, 279.4247741699219),
                ["Desert Island"] = CFrame.new(-324.5555114746094, 8.647589683532715, -984.8331298828125),
                ["Volcano Island"] = CFrame.new(2201.567138671875, 16.17937660217285, -366.5261535644531),
                ["Magma Raid"] = CFrame.new(3484.11865234375, 16.179386138916016, -1064.087646484375),
                ["Magma Fishing"] = CFrame.new(3886.9130859375, 30.105972290039063, 504.547119140625),
                ["Snow Island"] = CFrame.new(-2437.4990234375, 11.51285171508789, -381.1087341308594),
                ["Snow Fishing"] = CFrame.new(-3082.89697265625, 23.305198669433594, 289.44512939453125),
                Pray = CFrame.new(-3532.363525390625, 392.9266357421875, -647.7099609375),
                ["Railgun City"] = CFrame.new(-3613.112548828125, 1253.1580810546875, 10244.693359375),
                ["Geto Boss"] = CFrame.new(5636.91943359375, 2255.31884765625, -4319.2060546875),
                ["Borzoi Boss"] = CFrame.new(8975.34765625, 1751.3592529296875, -3167.20263671875),
                ["Dagon Boss"] = CFrame.new(1448.4842529296875, 21988.79296875, 59846.109375)
            }
            local r1_1 = game:GetService("Players").LocalPlayer
            local r1_2 = r1_1.Character
            local r1_3 = r1_2 and r1_2:FindFirstChild("HumanoidRootPart")
            if r1_0[r0_31] and r1_3 then
                r1_3.CFrame = r1_0[r0_31]
            else
                print("Invalid place selected or player not found!")
            end
            wait(1)
        end
    end
end
for r0_32, r0_33 in ipairs(r0_26) do
    r0_25.newToggle(r0_33, "Teleport to " .. r0_33, false, function(p22_0) -- proto#22 params=1 locals=0 upvalues=3 vararg=false source=
        r0_28 = p22_0
        if p22_0 then
            r0_29[r0_33]()
        end
    end)
end
local r0_34 = r0_0.newTab("Credits", " ")
r0_34.newButton("Discord", "Contact Us Here!", function() -- proto#23 params=0 locals=0 upvalues=0 vararg=false source=
    setclipboard("https://discord.gg/JbZq4sBzT3")
end)
r0_34.newButton("Rick Astley", "Founder", function() -- proto#18 params=0 locals=0 upvalues=0 vararg=false source=

end)
r0_34.newButton("Epik", "Co-Owner & Main Developer", function() -- proto#20 params=0 locals=0 upvalues=0 vararg=false source=

end)
r0_34.newButton("Clipz", "Staff-Manager & Side Developer", function() -- proto#24 params=0 locals=0 upvalues=0 vararg=false source=

end)
r0_34.newButton("karthathenx2802", "Social Manager", function() -- proto#28 params=0 locals=0 upvalues=0 vararg=false source=

end)
r0_34.newButton("zuwy_", "Staff", function() -- proto#3 params=0 locals=0 upvalues=0 vararg=false source=

end)
print("Player closed the GUI.")
