--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/Demonology/Demonology.lua
Source SHA-256: 30756c399b77accb1c4762b65b6796506ae526bb301af40e59f0bf66097f3b56
Recovery: edwindev-spec/MoonVeil@a948c4849a692f0af40d554708cac28b610c5115
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2025 Sealient

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

-- Reconstructed from MoonVeil Obfuscator v1.4.5.
-- Original local names and comments are not stored in the VM payload.
-- Stable R/U names below represent recovered registers and upvalues.

local ENV = getfenv()

local make_P0_4_0
local make_P0_23_0
local make_P0_23_1

make_P0_23_1 = function(upvalues)
    upvalues = upvalues or {}
    return function()
        upvalues[1].value.Text = upvalues[2].value
    end
end
make_P0_23_0 = function(upvalues)
    upvalues = upvalues or {}
    return function()
        local R0, R2
        R0 = upvalues[1].value
        R2 = upvalues[2].value
        R0:SetText(R2)
    end
end
make_P0_4_0 = function(upvalues)
    upvalues = upvalues or {}
    return function()
        local R0, R1, R2, R5
        R0 = upvalues[1].value
        if R0 then
            R0 = upvalues[2].value
            if R0 then
                R1 = upvalues[2].value
                R0 = R1.Parent
                if R0 then
                    upvalues[3].value.FillColor = upvalues[6].value
                    upvalues[3].value.OutlineColor = upvalues[7].value
                    if not upvalues[8].value then
                        return
                    end
                    for _, child5 in ENV.ipairs(upvalues[2].value:GetChildren()) do
                        R5 = child5:IsA("BasePart")
                        if not R5 then
                            continue
                        end
                        R5 = child5.Name
                        if R5 == "HumanoidRootPart" then
                            continue
                        end
                        R5 = child5.Transparency
                    end
                    return
                else
                    upvalues[3].value:Destroy()
                    R0 = upvalues[4].value
                    R1 = upvalues[2].value
                    R2 = nil
                    R0[R1] = R2
                    R0 = upvalues[5].value
                    R0:Disconnect()
                    return
                end
            else
                upvalues[3].value:Destroy()
                R0 = upvalues[4].value
                R1 = upvalues[2].value
                R2 = nil
                R0[R1] = R2
                R0 = upvalues[5].value
                R0:Disconnect()
                return
            end
        else
            upvalues[3].value:Destroy()
            R0 = upvalues[4].value
            R1 = upvalues[2].value
            R0[R1] = nil
            upvalues[5].value:Disconnect()
            return
        end
    end
end
local R0, workspace, players, runService, userInputService, tweenService, R6, R7, R8, R9, localPlayer, R14, R15, R18, R19, R20, R21, R24, R25, R26, R28, R29, R30, R31, R33, R34, R35, R36, R37, R38, R39, R40, R41, uiTab, R43, R44, R45, R47, R48, R49, R50, R51, R52
local R10 = {value = nil}
local R11 = {value = nil}
local R12 = {value = nil}
local R16 = {value = nil}
local R17 = {value = nil}
local R22 = {value = nil}
local R23 = {value = nil}
local R27 = {value = nil}
local R32 = {value = nil}
local R46 = {value = nil}
R7 = ENV.loadstring
R8 = ENV.game
R10.value = "https://raw.githubusercontent.com/Sealient/LuminxUI/main/LuminxUI.lua"
R7 = R7(R8:HttpGet(R10.value))
R7 = R7()
R0 = R7 or false
workspace = ENV.game:GetService("Workspace") or false
players = ENV.game:GetService("Players") or false
runService = ENV.game:GetService("RunService") or false
userInputService = ENV.game:GetService("UserInputService") or false
tweenService = ENV.game:GetService("TweenService") or false
R6 = ENV.game:GetService("Lighting")
R7 = R6.FogEnd
R10.value = "Atmosphere"
R8 = R6:FindFirstChildOfClass(R10.value)
if R8 then
    R9 = R8.Density
    if not R9 then
        R9 = 0
    end
else
    R9 = 0
end
R16.value = "Ghost"
R10.value = (workspace:FindFirstChild(R16.value)) or false
R16.value = "jneedse"
R11.value = (workspace:FindFirstChild(R16.value)) or false
R16.value = "Items"
R12.value = (workspace:FindFirstChild(R16.value)) or false
localPlayer = players.LocalPlayer
R17.value = localPlayer:GetMouse()
R14 = R17.value or false
R15 = workspace.CurrentCamera
R16.value = false
R17.value = ENV.task.spawn
do
    local captured_P0_0_4 = workspace
    local captured_P0_0_5 = players
    R18 = function()
        local R0, R2
        while true do
            R0 = R10.value
            if R0 then
                R0 = R11.value
                if not R0 then
                    R10.value = (captured_P0_0_4:FindFirstChild("Ghost"))
                    R0 = captured_P0_0_4:FindFirstChild("jneedse")
                    if not R0 then
                        R0 = captured_P0_0_5
                    end
                    R11.value = R0
                    R0 = captured_P0_0_4:FindFirstChild("Items")
                    R12.value = R0
                    ENV.task.wait(1)
                    continue
                end
                R0 = R12.value
                if not R0 then
                    R10.value = (captured_P0_0_4:FindFirstChild("Ghost"))
                    R0 = captured_P0_0_4:FindFirstChild("jneedse")
                    if not R0 then
                        R0 = captured_P0_0_5
                    end
                    R11.value = R0
                    R0 = captured_P0_0_4
                    R2 = "Items"
                    R0 = R0:FindFirstChild(R2)
                    R12.value = R0
                    ENV.task.wait(1)
                    continue
                end
                R16.value = true
                return
            else
                R10.value = (captured_P0_0_4:FindFirstChild("Ghost"))
                R0 = captured_P0_0_4:FindFirstChild("jneedse")
                if not R0 then
                    R0 = captured_P0_0_5
                end
                R11.value = R0
                R12.value = (captured_P0_0_4:FindFirstChild("Items"))
                ENV.task.wait(1)
                continue
            end
        end
    end
end
R17.value(R18)
R17.value = true
R18 = {}
R19 = {}
R20 = {Entities = false, Players = false, Items = false}
R24 = ENV.Color3.fromRGB
R27.value = 200
R24 = R24(0, 255, R27.value)
R20.EntityColor = R24
R24 = ENV.Color3.fromRGB
R27.value = 255
R24 = R24(255, 255, R27.value)
R20.EntityOutline = R24
R24 = ENV.Color3.fromRGB
R27.value = 255
R24 = R24(0, 170, R27.value)
R20.PlayerColor = R24
R24 = ENV.Color3.fromRGB
R27.value = 255
R24 = R24(255, 255, R27.value)
R20.PlayerOutline = R24
R24 = ENV.Color3.fromRGB
R27.value = 0
R24 = R24(255, 215, R27.value)
R20.ItemColor = R24
R24 = ENV.Color3.fromRGB
R27.value = 255
R24 = R24(255, 255, R27.value)
R20.ItemOutline = R24
R20.UiToggleKey = ENV.Enum.KeyCode.F4
R20.MouseLockKey = ENV.Enum.KeyCode.LeftControl
R20.MouseUnlocked = false
R20.FillTransparency = 0.45
R20.ShowNames = false
R21 = {Distance = 15, MinDistance = 5, MaxDistance = 30, RotationX = 0, RotationY = 0, Sensitivity = 0.005, ActiveParts = {}}
R22.value = {}
R23.value = 0
R21.OccludedParts = {}
R21.OriginalTransparencies = {}
R24 = R6.Brightness
R25 = R6.Ambient
R26 = R6.OutdoorAmbient
R27.value = nil
do
    local captured_P0_1_1 = R18
    R28 = function(value)
        local R2
        R2 = captured_P0_1_1
        ENV.table.insert(R2, (value or false))
        return value
    end
end
R29 = ENV.Instance.new("ScreenGui")
R29.Name = "LuminxCustomCursorSystem"
R29.DisplayOrder = 999999
R29.ResetOnSpawn = false
R29.Enabled = false
R32.value = "PlayerGui"
R29.Parent = (localPlayer:WaitForChild(R32.value))
R30 = ENV.Instance.new("Frame")
R30.Name = "CursorCore"
R31 = ENV.UDim2.new
R32.value = 0
R31 = R31(R32.value, 8, 0, 8)
R30.Size = R31
R31 = ENV.Vector2.new
R32.value = 0.5
R31 = R31(R32.value, 0.5)
R30.AnchorPoint = R31
R31 = ENV.Color3.fromRGB
R32.value = 0
R31 = R31(R32.value, 170, 255)
R30.BackgroundColor3 = R31
R30.BorderSizePixel = 0
R30.ZIndex = 100
R31 = ENV.Instance.new
R32.value = "UICorner"
R31 = R31(R32.value, (R30 or false))
R32.value = ENV.UDim.new
R32.value = R32.value(1, 0)
R31.CornerRadius = R32.value
R31 = ENV.Instance.new
R32.value = "UIStroke"
R31 = R31(R32.value, (R30 or false))
R32.value = ENV.Color3.fromRGB
R32.value = R32.value(255, 255, 255)
R31.Color = R32.value
R32.value = 1.5
R31.Thickness = R32.value
R30.Parent = R29
R32.value = ENV.Vector2.new
R33 = R14.X
R34 = R14.Y
R32.value = R32.value(R33, R34)
do
    local captured_P0_2_1 = R29
    local captured_P0_2_2 = tweenService
    R33 = function(vector, vector2)
        local R2, R3, R4, R5, R6, R7, R8, R9, R10
        R2 = ((vector-vector2)).Magnitude
        R3 = 1.5
        if R2 < R3 then
            return
        else
            R3 = ENV.Instance.new("Frame")
            R3.BackgroundColor3 = ENV.Color3.fromRGB(0, 170, 255)
            R3.BorderSizePixel = 0
            R3.AnchorPoint = ENV.Vector2.new(0.5, 0.5)
            R3.Size = ENV.UDim2.new(0, 4, 0, ((R2+4)))
            R4 = ENV.UDim2.new
            R6 = (((vector.X+vector2.X))/2)
            R9 = (vector.Y+vector2.Y)
            R4 = R4(0, R6, 0, ((R9/2)))
            R3.Position = R4
            R7 = (vector.Y-vector2.Y)
            R8 = (vector.X-vector2.X)
            R6 = ENV.math.atan2(R7, R8)
            R3.Rotation = ((ENV.math.deg(R6)+90))
            ENV.Instance.new("UICorner", (R3 or false)).CornerRadius = ENV.UDim.new(1, 0)
            R3.Parent = captured_P0_2_1
            R4 = captured_P0_2_2
            R6 = R3 or false
            R7 = ENV.TweenInfo.new
            R9 = ENV.Enum.EasingStyle.Linear
            R10 = ENV.Enum.EasingDirection.Out
            R7 = R7(0.12, R9, R10)
            R8 = {Size = ENV.UDim2.new(0, 0, 0, (R2 or false)), BackgroundTransparency = 1}
            R4 = R4:Create(R6, R7, R8)
            R4:Play()
            R5 = R4.Completed
            do
                local captured_P0_2_0_1 = R3
                R7 = function()
                    captured_P0_2_0_1:Destroy()
                end
            end
            R5:Connect(R7)
            return
        end
    end
end
R34 = runService.RenderStepped
do
    local captured_P0_3_2 = R20
    local captured_P0_3_3 = userInputService
    local captured_P0_3_4 = R29
    local captured_P0_3_5 = R14
    local captured_P0_3_6 = R30
    local captured_P0_3_7 = R33
    R36 = function()
        local R0, R1, R2, R3, R4, R6
        R0 = R17.value
        if R0 then
            R1 = captured_P0_3_2
            R0 = R1.MouseUnlocked
            if R0 then
                captured_P0_3_3.MouseBehavior = ENV.Enum.MouseBehavior.Default
                captured_P0_3_4.Enabled = true
                R0 = ENV.Vector2.new
                R1 = captured_P0_3_5.X
                R2 = captured_P0_3_5.Y
                R0 = R0(R1, R2)
                R1 = captured_P0_3_6
                R2 = ENV.UDim2.new
                R4 = R0.X
                R6 = R0.Y
                R2 = R2(0, R4, 0, R6)
                R1.Position = R2
                R1 = captured_P0_3_7
                R2 = R0 or false
                R3 = R32.value
                R1(R2, R3)
                R32.value = R0
                return
            else
                captured_P0_3_4.Enabled = false
                return
            end
        else
            return
        end
    end
end
R34 = R34:Connect(R36)
ENV.table.insert((R18 or false), (R34 or false))
do
    local captured_P0_4_1 = localPlayer
    local captured_P0_4_2 = {value = R19}
    local captured_P0_4_3 = R20
    local captured_P0_4_4 = runService
    local captured_P0_4_6 = R18
    R34 = function(player, value2, value3, value4)
        local R5, R7, R8, R9
        local R4 = {value = nil}
        local R6 = {value = nil}
        if (player) then
            R4.value = player or false
            R7 = "Player"
            R5 = player:IsA(R7)
            if R5 then
                R5 = captured_P0_4_1
                if player == R5 then
                    R4 = {value = R4.value}
                    R6 = {value = R6.value}
                    return
                else
                    R4.value = player.Character
                    if R4.value then
                        R6.value = captured_P0_4_2.value
                        R5 = R6.value[R4.value]
                        if R5 then
                            R4 = {value = R4.value}
                            R6 = {value = R6.value}
                            return
                        else
                            R5 = ENV.Instance.new
                            R6.value = "Highlight"
                            R5 = R5(R6.value)
                            R6.value = "LuminxEngineHighlight"
                            R5.Name = R6.value
                            R5.FillColor = value2
                            R6.value = captured_P0_4_3.FillTransparency
                            R5.FillTransparency = R6.value
                            R5.OutlineColor = value3
                            R6.value = 0
                            R5.OutlineTransparency = R6.value
                            R5.Adornee = R4.value
                            R5.Parent = R4.value
                            R6.value = nil
                            R7 = captured_P0_4_4.RenderStepped
                            R9 = make_P0_4_0({R17, R4, {value = R5}, captured_P0_4_2, R6, {value = value2}, {value = value3}, {value = value4}})
                            R7 = R7:Connect(R9)
                            R6.value = R7 or false
                            R8 = captured_P0_4_6
                            R9 = R6.value or false
                            ENV.table.insert(R8, R9)
                            R7 = captured_P0_4_2.value
                            R8 = {Highlight = R5, Connection = R6.value}
                            R7[R4.value] = R8
                            R4 = {value = R4.value}
                            R6 = {value = R6.value}
                            return
                        end
                    else
                        R4 = {value = R4.value}
                        R6 = {value = R6.value}
                        return
                    end
                end
            else
                if R4.value then
                    R6.value = captured_P0_4_2.value
                    R5 = R6.value[R4.value]
                    if R5 then
                        R4 = {value = R4.value}
                        R6 = {value = R6.value}
                        return
                    else
                        R5 = ENV.Instance.new
                        R6.value = "Highlight"
                        R5 = R5(R6.value)
                        R6.value = "LuminxEngineHighlight"
                        R5.Name = R6.value
                        R5.FillColor = value2
                        R6.value = captured_P0_4_3.FillTransparency
                        R5.FillTransparency = R6.value
                        R5.OutlineColor = value3
                        R6.value = 0
                        R5.OutlineTransparency = R6.value
                        R5.Adornee = R4.value
                        R5.Parent = R4.value
                        R6.value = nil
                        R7 = captured_P0_4_4.RenderStepped
                        R9 = make_P0_4_0({R17, R4, {value = R5}, captured_P0_4_2, R6, {value = value2}, {value = value3}, {value = value4}})
                        R7 = R7:Connect(R9)
                        R6.value = R7 or false
                        R8 = captured_P0_4_6
                        R9 = R6.value or false
                        ENV.table.insert(R8, R9)
                        captured_P0_4_2.value[R4.value] = {Highlight = R5, Connection = R6.value}
                        R4 = {value = R4.value}
                        R6 = {value = R6.value}
                        return
                    end
                else
                    R4 = {value = R4.value}
                    R6 = {value = R6.value}
                    return
                end
            end
        else
            return
        end
    end
end
do
    local captured_P0_5_1 = R19
    R35 = function(player)
        local R1, R2, R3, R4
        if (player) then
            R1 = player or false
            R4 = "Player"
            R2 = player:IsA(R4)
            if R2 then
                R1 = player.Character
            end
            if R1 then
                R3 = captured_P0_5_1
                R2 = R3[R1]
                if not R2 then
                    return
                end
                R3 = R2.Connection
                if R3 then
                    R3 = R2.Connection
                    R3:Disconnect()
                end
                R3 = R2.Highlight
                if R3 then
                    R3 = R2.Highlight
                    R3:Destroy()
                end
                captured_P0_5_1[R1] = nil
                return
            else
                return
            end
        else
            return
        end
    end
end
do
    local captured_P0_6_1 = R19
    local captured_P0_6_2 = R35
    local captured_P0_6_3 = R20
    local captured_P0_6_5 = R34
    R36 = function()
        local R0, R5, R6, R7, R8
        for key1 in ENV.pairs(captured_P0_6_1) do
            captured_P0_6_2((key1 or false))
        end
        for _, value2 in ENV.pairs(captured_P0_6_1) do
            R5 = value2.Highlight
            R7 = captured_P0_6_3
            R6 = R7.FillTransparency
            R5.FillTransparency = R6
        end
        R0 = captured_P0_6_3.Entities
        if R0 then
            R0 = R10.value
            if R0 then
                for _, child5 in ENV.ipairs(R10.value:GetChildren()) do
                    R5 = captured_P0_6_5
                    R6 = child5 or false
                    R7 = captured_P0_6_3.EntityColor
                    R8 = captured_P0_6_3.EntityOutline
                    R5(R6, R7, R8, true)
                end
            end
        end
        R0 = captured_P0_6_3.Players
        if R0 then
            R0 = R11.value
            if R0 then
                for _, child8 in ENV.ipairs(R11.value:GetChildren()) do
                    R5 = captured_P0_6_5
                    R6 = child8 or false
                    R7 = captured_P0_6_3.PlayerColor
                    R8 = captured_P0_6_3.PlayerOutline
                    R5(R6, R7, R8, false)
                end
            end
        end
        R0 = captured_P0_6_3.Items
        if not R0 then
            return
        end
        if not R12.value then
            return
        end
        for _, child11 in ENV.ipairs(R12.value:GetChildren()) do
            R5 = captured_P0_6_5
            R6 = child11 or false
            R7 = captured_P0_6_3.ItemColor
            R8 = captured_P0_6_3.ItemOutline
            R5(R6, R7, R8, false)
        end
    end
end
R37 = ENV.task.spawn
do
    local captured_P0_7_3 = {value = R20}
    local captured_P0_7_4 = {value = R34}
    local captured_P0_7_5 = R18
    local captured_P0_7_6 = R35
    R38 = function()
        local R0, R2
        while not (R16.value) do
            ENV.task.wait(0.5)
        end
        R0 = R10.value.ChildAdded
        R2 = function(value)
            local R1, R2, R3, R4
            R2 = captured_P0_7_3.value
            R1 = R2.Entities
            if not R1 then
                return
            end
            ENV.task.wait(0.2)
            R1 = captured_P0_7_4.value
            R2 = value or false
            R3 = captured_P0_7_3.value.EntityColor
            R4 = captured_P0_7_3.value.EntityOutline
            R1(R2, R3, R4, true)
        end
        R0 = R0:Connect(R2)
        R2 = captured_P0_7_5
        ENV.table.insert(R2, (R0 or false))
        R0 = R10.value.ChildRemoved
        R2 = captured_P0_7_6
        R0 = R0:Connect(R2)
        R2 = captured_P0_7_5
        ENV.table.insert(R2, (R0 or false))
        R0 = R11.value.ChildAdded
        R2 = function(value)
            local R1, R2, R3, R4
            R2 = captured_P0_7_3.value
            R1 = R2.Players
            if not R1 then
                return
            end
            ENV.task.wait(0.2)
            R1 = captured_P0_7_4.value
            R2 = value or false
            R3 = captured_P0_7_3.value.PlayerColor
            R4 = captured_P0_7_3.value.PlayerOutline
            R1(R2, R3, R4, false)
        end
        R0 = R0:Connect(R2)
        R2 = captured_P0_7_5
        ENV.table.insert(R2, (R0 or false))
        R0 = R11.value.ChildRemoved
        R2 = captured_P0_7_6
        R0 = R0:Connect(R2)
        R2 = captured_P0_7_5
        ENV.table.insert(R2, (R0 or false))
        R0 = R12.value.ChildAdded
        R2 = function(value)
            local R1, R2, R3, R4
            R2 = captured_P0_7_3.value
            R1 = R2.Items
            if not R1 then
                return
            end
            ENV.task.wait(0.2)
            R1 = captured_P0_7_4.value
            R2 = value or false
            R3 = captured_P0_7_3.value.ItemColor
            R4 = captured_P0_7_3.value.ItemOutline
            R1(R2, R3, R4, false)
        end
        R0 = R0:Connect(R2)
        R2 = captured_P0_7_5
        ENV.table.insert(R2, (R0 or false))
        R0 = R12.value.ChildRemoved
        R2 = captured_P0_7_6
        R0 = R0:Connect(R2)
        R2 = captured_P0_7_5
        ENV.table.insert(R2, (R0 or false))
    end
end
R37(R38)
do
    local captured_P0_8_1 = R21
    R37 = function()
        local R0, R3, R5
        R0 = ENV.pairs
        R3 = captured_P0_8_1
        for key1 in R0(R3.OccludedParts) do
            if not key1 then
                continue
            end
            R5 = key1:IsA("BasePart")
            if not R5 then
                continue
            end
            key1.LocalTransparencyModifier = 0
        end
        captured_P0_8_1.OccludedParts = {}
    end
end
R38 = function(value)
    local R1, R2, R3
    R3 = "OptimizedFlower"
    R1 = value:FindFirstChild(R3)
    if not R1 then
        R3 = "Pencil"
        R1 = value:FindFirstChild(R3)
    end
    if R1 then
        R2 = value:FindFirstChild("WorldPivot")
        if not R2 then
            R2 = ENV.Instance.new("Part") or false
            R2.Name = "WorldPivot"
            R2.Transparency = 1
            R3 = true
            R2.Anchored = R3
            R2.Parent = value
        end
        R2.CFrame = (value:GetPivot())
        return R2
    else
        return nil
    end
end
R39 = function()
    local R0, R6, R8, R9, R10
    R0 = {{Type = "Player", Target = nil}}
    if not R12.value then
        return R0
    end
    for _, child2 in ENV.ipairs(R12.value:GetChildren()) do
        R8 = "OptimizedFlower"
        R6 = child2:FindFirstChild(R8)
        if R6 then
            R8 = {}
            R10 = child2.Name
            if R10 == "1" then
                R9 = "FlowerPot"
            else
                R9 = "SpiritBook"
            end
            R8.Type = R9
            R8.Target = child2
            ENV.table.insert((R0 or false), R8)
        else
            R6 = child2:FindFirstChild("Pencil")
            if not R6 then
                continue
            end
            R8 = {}
            R10 = child2.Name
            if R10 == "1" then
                R9 = "FlowerPot"
            else
                R9 = "SpiritBook"
            end
            R8.Type = R9
            R8.Target = child2
            ENV.table.insert((R0 or false), R8)
        end
    end
    return R0
end
do
    local captured_P0_11_1 = localPlayer
    local captured_P0_11_2 = R21
    R40 = function(value1, value2)
        local R2, R3, R4, R5, R6, R7, R8, R9, R10
        R2 = ENV.RaycastParams.new()
        R2.FilterType = ENV.Enum.RaycastFilterType.Exclude
        R3 = {}
        R4 = captured_P0_11_1.Character
        R5 = value1 or false
        R3[1] = R4
        R3[2] = R5
        R2.FilterDescendantsInstances = R3
        R3 = 0
        R4 = value2 or false
        R6 = (((value1:GetPivot()).Position)-R4)
        while R3 < 5 do
            R7 = ENV.workspace:Raycast((R4 or false), (R6 or false), (R2 or false))
            if not R7 then
                break
            end
            R8 = R7.Instance:IsA("BasePart")
            if not R8 then
                break
            end
            R7.Instance.LocalTransparencyModifier = 0.5
            R9 = captured_P0_11_2.ActiveParts
            R10 = R7.Instance
            ENV.table.insert(R9, R10)
            R4 = (R7.Position+((R6.Unit*0.1)))
            R3 = (R3+1)
        end
    end
end
R41 = userInputService.InputChanged
do
    local captured_P0_12_1 = R21
    R43 = function(object, value2)
        local R2, R3, R4, R5, R6
        if (value2) then
            return
        else
            R2 = object.UserInputType
            R3 = ENV.Enum.UserInputType.MouseWheel
            if not (R2 == R3) then
                return
            end
            R2 = captured_P0_12_1
            R4 = (captured_P0_12_1.Distance-((object.Position.Z*2)))
            R5 = captured_P0_12_1.MinDistance
            R6 = captured_P0_12_1.MaxDistance
            R2.Distance = ENV.math.clamp(R4, R5, R6)
            return
        end
    end
end
R41 = R41:Connect(R43)
ENV.table.insert((R18 or false), (R41 or false))
R41 = runService.RenderStepped
do
    local captured_P0_13_1 = workspace
    local captured_P0_13_4 = userInputService
    local captured_P0_13_5 = R21
    local captured_P0_13_6 = localPlayer
    R43 = function()
        local R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R14
        R0 = captured_P0_13_1.CurrentCamera
        R2 = R22.value
        R4 = R23.value
        R3 = (R4+1)
        R1 = R2[R3]
        if R1 then
            R2 = R1.Type
            if R2 == "Player" then
                R2 = ENV.pairs
                R5 = captured_P0_13_5
                for key2 in R2(R5.OccludedParts) do
                    R7 = 0
                    key2.LocalTransparencyModifier = R7
                end
                captured_P0_13_5.OccludedParts = {}
                R2 = R0.CameraType
                R3 = ENV.Enum.CameraType.Custom
                if R2 == R3 then
                    return
                end
                R0.CameraType = ENV.Enum.CameraType.Custom
                R2 = captured_P0_13_4
                R2.MouseBehavior = ENV.Enum.MouseBehavior.Default
                return
            else
                R2 = R1.Target
                if R2 then
                    R2 = R0.CameraType
                    R3 = ENV.Enum.CameraType.Scriptable
                    if not (R2 == R3) then
                        R2 = ENV.Enum.CameraType.Scriptable
                        R0.CameraType = R2
                    end
                    R2 = captured_P0_13_4.MouseBehavior
                    R3 = ENV.Enum.MouseBehavior.LockCenter
                    if not (R2 == R3) then
                        R2 = captured_P0_13_4
                        R3 = ENV.Enum.MouseBehavior.LockCenter
                        R2.MouseBehavior = R3
                    end
                    R2 = (R1.Target:GetPivot()) or false
                    R3 = captured_P0_13_4:GetMouseDelta()
                    R4 = R3.Magnitude
                    R5 = 0
                    if R5 < R4 then
                        R4 = captured_P0_13_5
                        R4.RotationX = ((R4.RotationX-((R3.X*captured_P0_13_5.Sensitivity))))
                        R4 = captured_P0_13_5
                        R7 = captured_P0_13_5.RotationY
                        R9 = R3.Y
                        R11 = captured_P0_13_5
                        R10 = R11.Sensitivity
                        R6 = (R7-((R9*R10)))
                        R7 = -1.4
                        R8 = 1.4
                        R5 = ENV.math.clamp(R6, R7, R8)
                        R4.RotationY = R5
                    end
                    R4 = ENV.CFrame.fromEulerAnglesYXZ
                    R5 = captured_P0_13_5.RotationY
                    R6 = captured_P0_13_5.RotationX
                    R4 = R4(R5, R6, 0)
                    R6 = ENV.CFrame.new
                    R7 = R2.Position
                    R6 = R6(R7)
                    R8 = ENV.CFrame.new
                    R11 = captured_P0_13_5.Distance
                    R8 = R8(0, 0, R11)
                    R0.CFrame = ((R6*((R4*R8))))
                    R5 = ENV.Instance.new("Part")
                    R6 = ENV.Vector3.new
                    R9 = ((R0.CFrame.Position-R2.Position)).Magnitude
                    R6 = R6(10, 10, R9)
                    R5.Size = R6
                    R7 = ENV.CFrame.new
                    R8 = R0.CFrame.Position
                    R9 = R2.Position
                    R7 = R7(R8, R9)
                    R8 = ENV.CFrame.new
                    R14 = R5.Size
                    R12 = (-R14.Z)
                    R8 = R8(0, 0, ((R12/2)))
                    R5.CFrame = ((R7*R8))
                    R6 = ENV.OverlapParams.new()
                    R7 = {}
                    R8 = captured_P0_13_6.Character
                    R9 = R1.Target
                    R10 = R1.Target.Parent
                    R7[1] = R8
                    R7[2] = R9
                    R7[3] = R10
                    R6.FilterDescendantsInstances = R7
                    R6.FilterType = ENV.Enum.RaycastFilterType.Exclude
                    R7 = ENV.workspace:GetPartsInPart((R5 or false), (R6 or false))
                    R5:Destroy()
                    R8 = {}
                    for _, item4 in ENV.ipairs((R7 or false)) do
                        R14 = item4:IsA("BasePart")
                        if not R14 then
                            continue
                        end
                        item4.LocalTransparencyModifier = 0.8
                        R8[item4] = true
                    end
                    R9 = ENV.pairs
                    R12 = captured_P0_13_5
                    for key5 in R9(R12.OccludedParts) do
                        R14 = R8[key5]
                        if R14 then
                            continue
                        end
                        key5.LocalTransparencyModifier = 0
                    end
                    captured_P0_13_5.OccludedParts = R8
                    return
                else
                    R2 = ENV.pairs
                    R5 = captured_P0_13_5
                    for key6 in R2(R5.OccludedParts) do
                        R7 = 0
                        key6.LocalTransparencyModifier = R7
                    end
                    captured_P0_13_5.OccludedParts = {}
                    R2 = R0.CameraType
                    R3 = ENV.Enum.CameraType.Custom
                    if R2 == R3 then
                        return
                    end
                    R0.CameraType = ENV.Enum.CameraType.Custom
                    R2 = captured_P0_13_4
                    R3 = ENV.Enum.MouseBehavior.Default
                    R2.MouseBehavior = R3
                    return
                end
            end
        else
            R2 = ENV.pairs
            R5 = captured_P0_13_5
            for key7 in R2(R5.OccludedParts) do
                key7.LocalTransparencyModifier = 0
            end
            captured_P0_13_5.OccludedParts = {}
            R2 = R0.CameraType
            R3 = ENV.Enum.CameraType.Custom
            if R2 == R3 then
                return
            end
            R0.CameraType = ENV.Enum.CameraType.Custom
            captured_P0_13_4.MouseBehavior = ENV.Enum.MouseBehavior.Default
            return
        end
    end
end
R41 = R41:Connect(R43)
ENV.table.insert((R18 or false), (R41 or false))
R41 = userInputService.InputBegan
do
    local captured_P0_14_2 = R39
    local captured_P0_14_4 = workspace
    local captured_P0_14_5 = userInputService
    local captured_P0_14_6 = R0
    R43 = function(inputObject, value2)
        local R2, R3, R4, R5, R7
        if (value2) then
            return
        else
            R2 = inputObject.KeyCode
            R3 = ENV.Enum.KeyCode.C
            if not (R2 == R3) then
                return
            end
            R22.value = captured_P0_14_2()
            R23.value = ((((R23.value+1))%(#R22.value)))
            R4 = R22.value
            R5 = (R23.value+1)
            R2 = R4[R5]
            R3 = captured_P0_14_4.CurrentCamera
            R4 = R2.Type
            if R4 == "Player" then
                R3.CameraType = ENV.Enum.CameraType.Custom
                captured_P0_14_5.MouseBehavior = ENV.Enum.MouseBehavior.Default
            else
                R3.CameraType = ENV.Enum.CameraType.Scriptable
                R4 = captured_P0_14_5
                R4.MouseBehavior = ENV.Enum.MouseBehavior.LockCenter
            end
            R4 = captured_P0_14_6
            R7 = ("Mode: "..R2.Type)
            R4:Notify("Camera", R7, 2, "info")
            return
        end
    end
end
R41 = R41:Connect(R43)
ENV.table.insert((R18 or false), (R41 or false))
R41 = R0:CreateWindow("Demonology V2")
uiTab = R41:CreateTab("Visuals")
uiTab:CreateLabel("Bypass Highlight Matrix")
R46.value = false
do
    local captured_P0_15_1 = R20
    local captured_P0_15_2 = R36
    R47 = function(argument1)
        captured_P0_15_1.Entities = argument1
        captured_P0_15_2()
    end
end
uiTab:CreateToggle("Ghost Highlight ESP", R46.value, R47)
R46.value = false
do
    local captured_P0_16_1 = R20
    local captured_P0_16_2 = R36
    R47 = function(argument1)
        captured_P0_16_1.Players = argument1
        captured_P0_16_2()
    end
end
uiTab:CreateToggle("Player Highlight ESP", R46.value, R47)
R46.value = false
do
    local captured_P0_17_1 = R20
    local captured_P0_17_2 = R36
    R47 = function(argument1)
        captured_P0_17_1.Items = argument1
        captured_P0_17_2()
    end
end
uiTab:CreateToggle("Item/Tool ESP", R46.value, R47)
R46.value = 0
R48 = (R20.FillTransparency*100)
do
    local captured_P0_18_1 = R20
    local captured_P0_18_2 = R36
    R49 = function(argument1)
        captured_P0_18_1.FillTransparency = ((argument1/100))
        captured_P0_18_2()
    end
end
uiTab:CreateSlider("ESP Fill Transparency", R46.value, 100, R48, R49)
uiTab:CreateDivider()
uiTab:CreateLabel("Color Management Panel")
R46.value = R20.EntityColor
do
    local captured_P0_19_1 = R20
    local captured_P0_19_2 = R36
    R47 = function(argument1)
        captured_P0_19_1.EntityColor = argument1
        captured_P0_19_2()
    end
end
uiTab:CreateColorPicker("Ghost ESP Color", R46.value, R47)
R46.value = R20.PlayerColor
do
    local captured_P0_20_1 = R20
    local captured_P0_20_2 = R36
    R47 = function(argument1)
        captured_P0_20_1.PlayerColor = argument1
        captured_P0_20_2()
    end
end
uiTab:CreateColorPicker("Player ESP Color", R46.value, R47)
R46.value = R20.ItemColor
do
    local captured_P0_21_1 = R20
    local captured_P0_21_2 = R36
    R47 = function(argument1)
        captured_P0_21_1.ItemColor = argument1
        captured_P0_21_2()
    end
end
uiTab:CreateColorPicker("Item ESP Color", R46.value, R47)
R43 = R41:CreateTab("Misc")
R46.value = "Menu Controls"
R43:CreateLabel(R46.value)
R46.value = "Toggle UI Menu"
R47 = R20.UiToggleKey
do
    local captured_P0_22_1 = R0
    R48 = function()
        local R0, R1
        R1 = captured_P0_22_1
        R0 = R1.MainGui
        if not R0 then
            return
        end
        captured_P0_22_1.MainGui.Enabled = (not captured_P0_22_1.MainGui.Enabled)
    end
end
R43:CreateKeybind(R46.value, R47, R48)
R43:CreateDivider()
R46.value = "Mouse Controls"
R43:CreateLabel(R46.value)
R46.value = "Current Unlock Key: LeftControl"
R44 = R43:CreateLabel(R46.value)
do
    local captured_P0_23_1 = {value = R44}
    R45 = function(value)
        local R1, R2, R3, R4, R6, R7, R8, R9
        R1 = captured_P0_23_1.value
        if R1 then
            R2 = captured_P0_23_1.value
            R1 = ENV.typeof(R2)
            if R1 == "Instance" then
                R1 = captured_P0_23_1.value
                R3 = "TextLabel"
                R1 = R1:IsA(R3)
                if R1 then
                    captured_P0_23_1.value.Text = value
                    return
                else
                    R2 = captured_P0_23_1.value
                    R1 = ENV["type"](R2)
                    if R1 == "table" then
                        R2 = captured_P0_23_1.value
                        R1 = R2.SetText
                        if R1 then
                            R1 = ENV.pcall
                            R2 = make_P0_23_0({captured_P0_23_1, {value = value}})
                            R1(R2)
                        end
                        R2 = captured_P0_23_1.value
                        R1 = R2.Text
                        if R1 then
                            R1 = ENV.pcall
                            R2 = make_P0_23_1({captured_P0_23_1, {value = value}})
                            R1(R2)
                        end
                        for _, value5 in ENV.pairs(captured_P0_23_1.value) do
                            R7 = value5 or false
                            R6 = ENV.typeof(R7)
                            if not (R6 == "Instance") then
                                continue
                            end
                            R8 = "TextLabel"
                            R6 = value5:IsA(R8)
                            if R6 then
                                value5.Text = value
                            else
                                R8 = "TextLabel"
                                R9 = true
                                R6 = value5:FindFirstChildWhichIsA(R8, R9)
                                if not R6 then
                                    continue
                                end
                                R6.Text = value
                            end
                        end
                    end
                    R2 = captured_P0_23_1.value
                    R1 = ENV.typeof(R2)
                    if not (R1 == "Instance") then
                        return
                    end
                    R1 = captured_P0_23_1.value
                    R3 = "TextLabel"
                    R4 = true
                    R1 = R1:FindFirstChildWhichIsA(R3, R4)
                    if not R1 then
                        return
                    end
                    R1.Text = value
                    return
                end
            else
                R2 = captured_P0_23_1.value
                R1 = ENV["type"](R2)
                if R1 == "table" then
                    R2 = captured_P0_23_1.value
                    R1 = R2.SetText
                    if R1 then
                        R1 = ENV.pcall
                        R2 = make_P0_23_0({captured_P0_23_1, {value = value}})
                        R1(R2)
                    end
                    R2 = captured_P0_23_1.value
                    R1 = R2.Text
                    if R1 then
                        R1 = ENV.pcall
                        R2 = make_P0_23_1({captured_P0_23_1, {value = value}})
                        R1(R2)
                    end
                    for _, value9 in ENV.pairs(captured_P0_23_1.value) do
                        R6 = ENV.typeof((value9 or false))
                        if not (R6 == "Instance") then
                            continue
                        end
                        R8 = "TextLabel"
                        R6 = value9:IsA(R8)
                        if R6 then
                            value9.Text = value
                        else
                            R6 = value9:FindFirstChildWhichIsA("TextLabel", true)
                            if not R6 then
                                continue
                            end
                            R6.Text = value
                        end
                    end
                end
                R2 = captured_P0_23_1.value
                R1 = ENV.typeof(R2)
                if not (R1 == "Instance") then
                    return
                end
                R1 = captured_P0_23_1.value:FindFirstChildWhichIsA("TextLabel", true)
                if not R1 then
                    return
                end
                R1.Text = value
                return
            end
        else
            return
        end
    end
end
R46.value = false
do
    local captured_P0_24_2 = {value = R45}
    local captured_P0_24_3 = userInputService
    local captured_P0_24_4 = {value = R20}
    local captured_P0_24_5 = {value = R0}
    R50 = function()
        local R1, R3
        local R0 = {value = nil}
        R0.value = R46.value
        if R0.value then
            return
        else
            R0.value = true
            R46.value = R0.value
            R0.value = captured_P0_24_2.value
            R0.value("Current Unlock Key: [ PRESS ANY KEY ]")
            R0.value = nil
            R1 = captured_P0_24_3.InputBegan
            R3 = function(inputObject)
                local R1, R2, R4
                R1 = inputObject.UserInputType
                R2 = ENV.Enum.UserInputType.Keyboard
                if not (R1 == R2) then
                    return
                end
                captured_P0_24_4.value.MouseLockKey = inputObject.KeyCode
                R46.value = false
                R1 = captured_P0_24_2.value
                R2 = ("Current Unlock Key: "..inputObject.KeyCode.Name)
                R1(R2)
                R1 = captured_P0_24_5.value
                R4 = ("Active Unlock Key is now: "..inputObject.KeyCode.Name)
                R1:Notify("Keybind Swapped", R4, 3, "info")
                R0.value:Disconnect()
            end
            R1 = R1:Connect(R3)
            R0.value = R1 or false
            R0 = {value = R0.value}
            return
        end
    end
end
R43:CreateButton("Click to Change Unlock Key", R50)
R43:CreateDivider()
R43:CreateLabel("Camera System Info")
R43:CreateLabel("Press 'C' to cycle through targets.")
R43:CreateLabel("Use Mouse to orbit in Camera mode.")
R47 = userInputService.InputBegan
do
    local captured_P0_25_3 = R20
    local captured_P0_25_4 = R0
    R49 = function(inputObject, value2)
        local R2, R3, R4, R5, R6, R7
        R2 = R17.value
        if R2 then
            R2 = R46.value
            if R2 then
                return
            else
                R2 = inputObject.KeyCode
                R4 = captured_P0_25_3
                R3 = R4.MouseLockKey
                if not (R2 == R3) then
                    return
                end
                R2 = captured_P0_25_3
                R5 = captured_P0_25_3
                R4 = R5.MouseUnlocked
                R2.MouseUnlocked = (not R4)
                R3 = captured_P0_25_4
                R2 = R3.MainGui
                if R2 then
                    R3 = captured_P0_25_4
                    R2 = R3.MainGui
                    R4 = "MainFrame"
                    R2 = R2:FindFirstChild(R4)
                    if R2 then
                        R4 = captured_P0_25_4
                        R2 = R4.MainGui.MainFrame
                        R5 = "Frame"
                        R3 = R2:IsA(R5)
                        if R3 then
                            R3 = R2:FindFirstChild("ModalForcer")
                            if not R3 then
                                R3 = ENV.Instance.new("TextButton") or false
                                R3.Name = "ModalForcer"
                                R3.BackgroundTransparency = 1
                                R3.Size = ENV.UDim2.new(0, 0, 0, 0)
                                R4 = ""
                                R3.Text = R4
                                R3.Parent = R2
                            end
                            R5 = captured_P0_25_3
                            R4 = R5.MouseUnlocked
                            R3.Modal = R4
                        end
                    end
                end
                R2 = captured_P0_25_4
                R4 = "Mouse Core"
                R6 = "First-Person Bypass: "
                if (captured_P0_25_3.MouseUnlocked) then
                    R7 = "ENABLED"
                else
                    R7 = "DISABLED"
                end
                R5 = (R6..R7)
                R2:Notify(R4, R5, 2, "info")
                return
            end
        else
            return
        end
    end
end
R47 = R47:Connect(R49)
ENV.table.insert((R18 or false), (R47 or false))
R47 = R41:CreateTab("World")
do
    local captured_P0_26_1 = R6
    local captured_P0_26_2 = R8
    local captured_P0_26_3 = R7
    local captured_P0_26_4 = R9
    R52 = function(argument1)
        local R1, R2
        if (argument1) then
            R1 = captured_P0_26_1
            R2 = 100000
            R1.FogEnd = R2
            R1 = captured_P0_26_2
            if R1 then
                R1 = captured_P0_26_2
                R2 = 0
                R1.Density = R2
                return
            else
                return
            end
        else
            R1 = captured_P0_26_1
            R2 = captured_P0_26_3
            R1.FogEnd = R2
            R1 = captured_P0_26_2
            if not R1 then
                return
            end
            captured_P0_26_2.Density = captured_P0_26_4
            return
        end
    end
end
R47:CreateToggle("Clear Fog & Atmosphere", false, R52)
do
    local captured_P0_27_1 = R6
    local captured_P0_27_2 = R24
    local captured_P0_27_3 = R25
    local captured_P0_27_4 = R26
    R52 = function(argument1)
        if (argument1) then
            captured_P0_27_1.Brightness = 2
            captured_P0_27_1.Ambient = ENV.Color3.fromRGB(255, 255, 255)
            captured_P0_27_1.OutdoorAmbient = ENV.Color3.fromRGB(255, 255, 255)
            return
        else
            captured_P0_27_1.Brightness = captured_P0_27_2
            captured_P0_27_1.Ambient = captured_P0_27_3
            captured_P0_27_1.OutdoorAmbient = captured_P0_27_4
            return
        end
    end
end
R47:CreateToggle("Full Bright", false, R52)
R50 = "Player NoClip"
R51 = false
do
    local captured_P0_28_2 = runService
    local captured_P0_28_3 = {value = localPlayer}
    R52 = function(argument1)
        local R1, R3
        if (argument1) then
            R1 = captured_P0_28_2.Stepped
            R3 = function()
                local R5
                if not captured_P0_28_3.value.Character then
                    return
                end
                for _, descendant2 in ENV.ipairs(captured_P0_28_3.value.Character:GetDescendants()) do
                    R5 = descendant2:IsA("BasePart")
                    if not R5 then
                        continue
                    end
                    R5 = descendant2.CanCollide
                    if not R5 then
                        continue
                    end
                    descendant2.CanCollide = false
                end
            end
            R1 = R1:Connect(R3)
            R27.value = R1
            return
        else
            R1 = R27.value
            if not R1 then
                return
            end
            R27.value:Disconnect()
            return
        end
    end
end
R47:CreateToggle(R50, R51, R52)
do
    local captured_P0_29_2 = R18
    local captured_P0_29_3 = R29
    local captured_P0_29_4 = R19
    local captured_P0_29_5 = R35
    local captured_P0_29_6 = userInputService
    R48 = function()
        local R0
        R17.value = false
        for _, item1 in ENV.ipairs(captured_P0_29_2) do
            if not item1 then
                continue
            end
            item1:Disconnect()
        end
        R0 = captured_P0_29_3
        if R0 then
            R0 = captured_P0_29_3
            R0:Destroy()
        end
        for key3 in ENV.pairs(captured_P0_29_4) do
            captured_P0_29_5((key3 or false))
        end
        captured_P0_29_6.MouseBehavior = ENV.Enum.MouseBehavior.Default
    end
end
R49 = R0.MainGui
if R49 then
    R49 = R0.MainGui.AncestryChanged
    do
        local captured_P0_30_1 = R48
        R51 = function(value1, value2)
            if (value2) then
                return
            end
            captured_P0_30_1()
        end
    end
    R49 = R49:Connect(R51)
    ENV.table.insert((R18 or false), (R49 or false))
end
R10 = {value = R10.value}
R11 = {value = R11.value}
R12 = {value = R12.value}
R16 = {value = R16.value}
R17 = {value = R17.value}
R22 = {value = R22.value}
R23 = {value = R23.value}
R27 = {value = R27.value}
R32 = {value = R32.value}
R46 = {value = R46.value}
