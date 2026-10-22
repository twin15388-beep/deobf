--[[
Game source provenance | SRC | NOT TESTED IN ROBLOX
Original: https://github.com/GigaMechanicRear/blade_ball/blob/c9dc81c35fabeffaff1001334a8985efe4174643/blade_ball.lua
Source SHA-256: 7af6220ec0beac83d8b9978e5c5c7ef3a94302b434864202970caf77e481b249
Open source (src); no deobfuscation claimed.
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2026 GigaMechanicRear

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
    Blade Ball Hub | Rayfield UI
    Auto Parry / Ball ESP / Speed & Jump Boost / Auto Skill / Kill Aura
    Game ID: 13772394625
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "Blade Ball Hub",
    LoadingTitle = "NightmareHub",
    LoadingSubtitle = "Enjoy!",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
})

local State = {
    AutoParry = false,
    ParryDistance = 18,
    BallESP = false,
    SpeedBoost = false,
    SpeedValue = 30,
    JumpBoost = false,
    JumpValue = 60,
    AutoSkill = false,
    SkillDistance = 35,
    KillAura = false,
}

-- ================= Helpers =================
local function getCharacter()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getRoot()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

-- Find the active (real) ball among decoys
local function getBall()
    local balls = Workspace:FindFirstChild("Balls")
    if not balls then return nil end
    for _, ball in ipairs(balls:GetChildren()) do
        local realBall = ball:GetAttribute("realBall")
        if realBall == true or realBall == nil then
            return ball
        end
    end
    return balls:FindFirstChildWhichIsA("BasePart")
end

-- Is the ball currently targeting us?
local function ballTargetsMe(ball)
    local target = ball:GetAttribute("target")
    return target == LocalPlayer.Name or target == nil
end

local function pressParry()
    -- primary: game parry remote
    local fired = false
    pcall(function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if remotes then
            local parry = remotes:FindFirstChild("ParryButtonPress")
            if parry and parry:IsA("RemoteEvent") then
                parry:FireServer()
                fired = true
            end
        end
    end)
    -- fallback: simulate F key / click
    if not fired then
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            task.wait()
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end)
    end
end

local function useSkill()
    pcall(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
    end)
end

-- ================= Anti AFK =================
pcall(function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

-- ================= Tabs =================
local MainTab = Window:CreateTab("Main", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local CombatTab = Window:CreateTab("Combat", 4483362458)

-- ================= Auto Parry =================
MainTab:CreateSection("Auto Parry")

local lastParry = 0

MainTab:CreateToggle({
    Name = "Auto Parry",
    CurrentValue = false,
    Flag = "AutoParry",
    Callback = function(value)
        State.AutoParry = value
    end,
})

MainTab:CreateSlider({
    Name = "Parry Trigger Distance",
    Range = { 8, 40 },
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 18,
    Flag = "ParryDistance",
    Callback = function(value)
        State.ParryDistance = value
    end,
})

RunService.Heartbeat:Connect(function()
    if not State.AutoParry then return end
    pcall(function()
        local ball = getBall()
        local root = getRoot()
        if not ball or not root then return end
        if not ballTargetsMe(ball) then return end

        local distance = (ball.Position - root.Position).Magnitude
        local velocity = ball.AssemblyLinearVelocity.Magnitude
        -- dynamic window: fast ball -> parry earlier
        local threshold = State.ParryDistance + velocity * 0.08

        if distance <= threshold and tick() - lastParry > 0.35 then
            lastParry = tick()
            pressParry()
        end
    end)
end)

-- ================= Visuals =================
VisualsTab:CreateSection("Ball ESP")

local ballESPObjects = {}

local function clearBallESP()
    for _, obj in ipairs(ballESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    ballESPObjects = {}
end

VisualsTab:CreateToggle({
    Name = "Ball ESP (through walls)",
    CurrentValue = false,
    Flag = "BallESP",
    Callback = function(value)
        State.BallESP = value
        task.spawn(function()
            while State.BallESP do
                clearBallESP()
                pcall(function()
                    local ball = getBall()
                    if ball then
                        local highlight = Instance.new("Highlight")
                        highlight.FillColor = Color3.fromRGB(255, 60, 60)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.4
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = ball
                        table.insert(ballESPObjects, highlight)

                        local billboard = Instance.new("BillboardGui")
                        billboard.Size = UDim2.new(0, 100, 0, 26)
                        billboard.AlwaysOnTop = true
                        billboard.Adornee = ball
                        local label = Instance.new("TextLabel", billboard)
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.TextColor3 = Color3.fromRGB(255, 60, 60)
                        label.TextStrokeTransparency = 0.3
                        label.Text = "BALL"
                        billboard.Parent = ball
                        table.insert(ballESPObjects, billboard)
                    end
                end)
                task.wait(1)
            end
            clearBallESP()
        end)
    end,
})

-- ================= Player =================
PlayerTab:CreateSection("Movement")

PlayerTab:CreateToggle({
    Name = "Speed Boost",
    CurrentValue = false,
    Flag = "SpeedBoost",
    Callback = function(value)
        State.SpeedBoost = value
        task.spawn(function()
            while State.SpeedBoost do
                pcall(function()
                    local hum = getHumanoid()
                    if hum then
                        hum.WalkSpeed = State.SpeedValue
                    end
                end)
                task.wait(0.2)
            end
            pcall(function()
                local hum = getHumanoid()
                if hum then
                    hum.WalkSpeed = 16
                end
            end)
        end)
    end,
})

PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = { 16, 100 },
    Increment = 1,
    Suffix = "",
    CurrentValue = 30,
    Flag = "SpeedValue",
    Callback = function(value)
        State.SpeedValue = value
    end,
})

PlayerTab:CreateToggle({
    Name = "Jump Boost",
    CurrentValue = false,
    Flag = "JumpBoost",
    Callback = function(value)
        State.JumpBoost = value
        task.spawn(function()
            while State.JumpBoost do
                pcall(function()
                    local hum = getHumanoid()
                    if hum then
                        hum.UseJumpPower = true
                        hum.JumpPower = State.JumpValue
                    end
                end)
                task.wait(0.2)
            end
            pcall(function()
                local hum = getHumanoid()
                if hum then
                    hum.JumpPower = 50
                end
            end)
        end)
    end,
})

PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = { 50, 200 },
    Increment = 5,
    Suffix = "",
    CurrentValue = 60,
    Flag = "JumpValue",
    Callback = function(value)
        State.JumpValue = value
    end,
})

-- ================= Combat =================
CombatTab:CreateSection("Skills")

CombatTab:CreateToggle({
    Name = "Auto Skill (when ball is close)",
    CurrentValue = false,
    Flag = "AutoSkill",
    Callback = function(value)
        State.AutoSkill = value
        task.spawn(function()
            while State.AutoSkill do
                pcall(function()
                    local ball = getBall()
                    local root = getRoot()
                    if ball and root and ballTargetsMe(ball) then
                        local distance = (ball.Position - root.Position).Magnitude
                        if distance <= State.SkillDistance then
                            useSkill()
                            task.wait(1)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end,
})

CombatTab:CreateSlider({
    Name = "Skill Trigger Distance",
    Range = { 15, 80 },
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 35,
    Flag = "SkillDistance",
    Callback = function(value)
        State.SkillDistance = value
    end,
})

CombatTab:CreateSection("Kill Aura")

CombatTab:CreateToggle({
    Name = "Kill Aura (redirect to nearest)",
    CurrentValue = false,
    Flag = "KillAura",
    Callback = function(value)
        State.KillAura = value
        task.spawn(function()
            while State.KillAura do
                pcall(function()
                    local ball = getBall()
                    local root = getRoot()
                    if ball and root and ballTargetsMe(ball) then
                        local distance = (ball.Position - root.Position).Magnitude
                        if distance <= State.ParryDistance + 5 then
                            -- face nearest player before parrying so the ball redirects at them
                            local nearest, nearestDist = nil, math.huge
                            for _, plr in ipairs(Players:GetPlayers()) do
                                if plr ~= LocalPlayer and plr.Character then
                                    local part = plr.Character:FindFirstChild("HumanoidRootPart")
                                    local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                                    if part and hum and hum.Health > 0 then
                                        local d = (part.Position - root.Position).Magnitude
                                        if d < nearestDist then
                                            nearest, nearestDist = part, d
                                        end
                                    end
                                end
                            end
                            if nearest then
                                root.CFrame = CFrame.lookAt(
                                    root.Position,
                                    Vector3.new(nearest.Position.X, root.Position.Y, nearest.Position.Z)
                                )
                            end
                            pressParry()
                            task.wait(0.35)
                        end
                    end
                end)
                task.wait(0.05)
            end
        end)
    end,
})

Rayfield:Notify({
    Title = "Blade Ball Hub",
    Content = "Loaded successfully. Enjoy!",
    Duration = 5,
})
