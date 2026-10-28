--[[
Game source provenance | SRC | NOT TESTED IN ROBLOX
Original: https://github.com/X3KT00/EmotesGUI/blob/81ce095ab406a044affdd78ad9a5ec60eb8fac29/Code.lua
Source SHA-256: 5f4d64d85b70bb0625055a5be485a64c557664dd8d17598ed476133eeb7dc05a
Open source (src); no deobfuscation claimed.
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2026 X3KT00

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

-- Services
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Player & Character
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:FindFirstChildOfClass("Humanoid")

-- Variables for target selection
local selectedPlayer = nil
local targetMode = "nickname" -- "nickname" or "random"
local targetNickname = ""

-- Emotes Folder
local assetsFolder = ReplicatedStorage:FindFirstChild("Assets")
local emotesFolder = assetsFolder and assetsFolder:FindFirstChild("Emotes")

local emotes = {}

if emotesFolder then
    for _, module in pairs(emotesFolder:GetChildren()) do
        if module:IsA("ModuleScript") then
            local success, emoteData = pcall(require, module)
            if success then
                if typeof(emoteData) == "table" then
                    local assetID = emoteData.AssetID
                    if assetID and typeof(assetID) == "string" then
                        emotes[module.Name] = emoteData
                        print("✅ Loaded emote:", module.Name, "| AssetID:", assetID, "| SFX:", emoteData.SFX or "None")
                    else
                        warn("⚠️ Invalid AssetID in:", module.Name, "| Found:", tostring(emoteData.AssetID))
                    end
                else
                    warn("❌ Emote module returned non-table data:", module.Name, "| Type:", typeof(emoteData))
                end
            else
                warn("❌ Failed to require module:", module.Name, "| Error:", emoteData)
            end
        end
    end
else
    warn("Emotes folder not found!")
end

-- Variables for tracking currently playing effects
local currentAnimations = {}
local currentSounds = {}
local currentClones = {}
local currentTargets = {}

-- Function to find player by nickname
local function findPlayerByNickname(nickname)
    if not nickname or nickname == "" then
        return nil
    end
    
    local lowerNickname = string.lower(nickname)
    for _, p in pairs(Players:GetPlayers()) do
        if string.lower(p.Name) == lowerNickname or string.lower(p.DisplayName) == lowerNickname then
            if p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
                return p
            end
        end
    end
    return nil
end

-- Function to get random player (excluding local player)
local function getRandomPlayer()
    local players = Players:GetPlayers()
    local validPlayers = {}
    
    for _, p in pairs(players) do
        if p ~= player and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
            table.insert(validPlayers, p)
        end
    end
    
    if #validPlayers > 0 then
        return validPlayers[math.random(1, #validPlayers)]
    end
    return nil
end

-- Function to update target based on current mode
local function updateTarget()
    if targetMode == "random" then
        selectedPlayer = getRandomPlayer()
        if selectedPlayer then
            TargetStatus.Text = "🎲 Random: " .. selectedPlayer.Name
            TargetStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            NicknameBox.Text = ""
            NicknameBox.PlaceholderText = "Random mode active"
            NicknameBox.TextColor3 = Color3.fromRGB(100, 100, 100)
        else
            TargetStatus.Text = "🎲 No players found"
            TargetStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    else
        if targetNickname and targetNickname ~= "" then
            selectedPlayer = findPlayerByNickname(targetNickname)
            if selectedPlayer then
                TargetStatus.Text = "👤 Target: " .. selectedPlayer.Name
                TargetStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            else
                TargetStatus.Text = "⚠️ Player not found: " .. targetNickname
                TargetStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
                selectedPlayer = nil
            end
        else
            TargetStatus.Text = "📝 Enter a player name"
            TargetStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
            selectedPlayer = nil
        end
    end
end

-- Function to get target character
local function getTargetCharacter()
    if selectedPlayer and selectedPlayer.Character then
        return selectedPlayer.Character
    end
    return nil
end

-- IMPROVED: Stop all effects for a specific target
local function stopAllEffects(targetChar)
    if not targetChar then return end
    
    local targetKey = tostring(targetChar)
    
    -- Stop animations for this target
    local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
    if targetHumanoid then
        local animator = targetHumanoid:FindFirstChildOfClass("Animator")
        if animator then
            local allTracks = animator:GetPlayingAnimationTracks()
            for _, track in pairs(allTracks) do
                track:Stop()
            end
        end
    end
    
    if currentAnimations[targetKey] then
        for _, animTrack in pairs(currentAnimations[targetKey]) do
            if animTrack and animTrack.Parent then
                animTrack:Stop()
            end
        end
        currentAnimations[targetKey] = nil
    end
    
    -- Stop sounds attached to target (now they will stop for everyone)
    if currentSounds[targetKey] then
        for _, sound in pairs(currentSounds[targetKey]) do
            if sound and sound.Parent then
                sound:Stop()
                sound:Destroy()
            end
        end
        currentSounds[targetKey] = nil
    end
    
    if currentClones[targetKey] then
        for _, entry in pairs(currentClones[targetKey]) do
            if entry.connection then 
                entry.connection:Disconnect() 
            end
            if entry.clone then 
                entry.clone:Destroy() 
            end
        end
        currentClones[targetKey] = nil
    end
    
    print("✅ Stopped all effects for:", targetChar.Parent and targetChar.Parent.Name or "Unknown")
end

-- Cancel emote for current target
local function cancelCurrentEmote()
    local targetChar = getTargetCharacter()
    
    if not targetChar then
        if targetMode == "random" then
            warn("No random player selected!")
            TargetStatus.Text = "⚠️ No target selected!"
            TargetStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            wait(1)
            updateTarget()
        elseif targetMode == "nickname" then
            warn("No target selected!")
            TargetStatus.Text = "⚠️ No target selected!"
            TargetStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            wait(1)
            if targetNickname ~= "" then
                updateTarget()
            else
                TargetStatus.Text = "📝 Enter a player name"
                TargetStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        return
    end
    
    stopAllEffects(targetChar)
    
    CancelButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    TweenService:Create(CancelButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
    
    local originalColor = TargetStatus.TextColor3
    TargetStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
    TargetStatus.Text = "✅ Emote cancelled on: " .. (targetChar.Parent and targetChar.Parent.Name or "Unknown")
    wait(1.5)
    if targetMode == "nickname" and targetNickname ~= "" then
        updateTarget()
    elseif targetMode == "random" then
        updateTarget()
    else
        TargetStatus.Text = "📝 Enter a player name"
        TargetStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end

-- UPDATED: Play audio for EVERYONE to hear (not just local)
local function playAudio(sfxData, parent, targetKey)
    if not sfxData then return end
    
    local selectedSfx = nil
    
    if typeof(sfxData) == "string" then
        selectedSfx = sfxData
    elseif typeof(sfxData) == "table" and #sfxData > 0 then
        local randomIndex = math.random(1, #sfxData)
        selectedSfx = sfxData[randomIndex]
    end
    
    if selectedSfx then
        local sound = Instance.new("Sound")
        sound.SoundId = selectedSfx
        sound.Parent = parent
        sound.Volume = 0.5
        sound.RollOffMode = Enum.RollOffMode.Linear  -- This makes the sound positional
        sound.MaxDistance = 50  -- How far the sound can be heard
        sound.MinDistance = 5    -- Minimum distance before volume starts decreasing
        
        -- IMPORTANT: Make sure the sound plays for everyone
        sound:Play()
        
        print("🔊 Playing sound for everyone on:", parent:IsA("BasePart") and parent.Name or "Unknown")
        
        if not currentSounds[targetKey] then
            currentSounds[targetKey] = {}
        end
        table.insert(currentSounds[targetKey], sound)
        
        sound.Ended:Connect(function()
            sound:Destroy()
            if currentSounds[targetKey] then
                for i, s in pairs(currentSounds[targetKey]) do
                    if s == sound then
                        table.remove(currentSounds[targetKey], i)
                        break
                    end
                end
            end
        end)
    end
end

-- Function to play special effects on target
local function playSpecialEffects(emoteName, data, targetChar, targetKey)
    if not targetChar then return end
    
    local rootPart = targetChar:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    if not currentClones[targetKey] then
        currentClones[targetKey] = {}
    end
    
    if emoteName == "Locked" and data.LockedEffect then
        local lockedClone = data.LockedEffect:Clone()
        lockedClone.Parent = rootPart
        
        for _, part in ipairs(lockedClone:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Anchored = true
            end
        end
        
        local connection = RunService.Heartbeat:Connect(function()
            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                if lockedClone.PrimaryPart then
                    lockedClone:SetPrimaryPartCFrame(targetChar.HumanoidRootPart.CFrame)
                else
                    for _, part in ipairs(lockedClone:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CFrame = targetChar.HumanoidRootPart.CFrame
                        end
                    end
                end
            else
                connection:Disconnect()
            end
        end)
        table.insert(currentClones[targetKey], {clone = lockedClone, connection = connection})
    end
    
    if emoteName == "MissTheQuiet" and data.EmoteLighting then
        local lightingPart = data.EmoteLighting:FindFirstChild("lighting")
        if lightingPart then
            local cloneLighting = lightingPart:Clone()
            cloneLighting.Parent = rootPart
            cloneLighting.CanCollide = false
            cloneLighting.Transparency = 1
            cloneLighting.Anchored = true
            cloneLighting.Position = rootPart.Position
            
            local connection = RunService.Heartbeat:Connect(function()
                if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                    cloneLighting.CFrame = targetChar.HumanoidRootPart.CFrame
                else
                    connection:Disconnect()
                end
            end)
            table.insert(currentClones[targetKey], {clone = cloneLighting, connection = connection})
        end
    end
    
    if emoteName == "HakariDance" and data.HakariBeamEffect then
        local cloneBeam = data.HakariBeamEffect:Clone()
        cloneBeam.Parent = rootPart
        cloneBeam.CanCollide = false
        cloneBeam.Transparency = 0
        cloneBeam.Anchored = true
        cloneBeam.Position = rootPart.Position
        
        local connection = RunService.Heartbeat:Connect(function()
            if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                cloneBeam.CFrame = targetChar.HumanoidRootPart.CFrame
            else
                connection:Disconnect()
            end
        end)
        table.insert(currentClones[targetKey], {clone = cloneBeam, connection = connection})
    end
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "CustomEmote"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = player:FindFirstChildOfClass("PlayerGui")

if not ScreenGui.Parent then
    warn("PlayerGui not found! UI won't show.")
end

-- Main Container Frame (on RIGHT side)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "CustomEmotesMenu"
MainFrame.Size = UDim2.new(0, 420, 0, 670)
MainFrame.Position = UDim2.new(1, -430, 0.5, -335)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Drop shadow effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = 0
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
Shadow.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Accent gradient bar at top
local AccentBar = Instance.new("Frame")
AccentBar.Name = "AccentBar"
AccentBar.Size = UDim2.new(1, 0, 0, 4)
AccentBar.BorderSizePixel = 0
AccentBar.Parent = MainFrame

local AccentGradient = Instance.new("UIGradient")
AccentGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
}
AccentGradient.Parent = AccentBar

-- Animate the gradient
spawn(function()
    while true do
        TweenService:Create(AccentGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Offset = Vector2.new(1, 0)
        }):Play()
        wait(3)
    end
end)

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 4)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "✨ EMOTES"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextYAlignment = Enum.TextYAlignment.Center
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
end)

-- Target Panel with TextBox
local TargetPanel = Instance.new("Frame")
TargetPanel.Name = "TargetPanel"
TargetPanel.Size = UDim2.new(1, -20, 0, 95)
TargetPanel.Position = UDim2.new(0, 10, 0, 70)
TargetPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TargetPanel.BorderSizePixel = 0
TargetPanel.Parent = MainFrame

local TargetCorner = Instance.new("UICorner")
TargetCorner.CornerRadius = UDim.new(0, 12)
TargetCorner.Parent = TargetPanel

-- Target icon
local TargetIcon = Instance.new("TextLabel")
TargetIcon.Size = UDim2.new(0, 40, 0, 40)
TargetIcon.Position = UDim2.new(0, 10, 0, 10)
TargetIcon.BackgroundTransparency = 1
TargetIcon.Text = "🎯"
TargetIcon.TextColor3 = Color3.fromRGB(138, 43, 226)
TargetIcon.Font = Enum.Font.GothamBold
TargetIcon.TextSize = 24
TargetIcon.Parent = TargetPanel

-- Target status text
local TargetStatus = Instance.new("TextLabel")
TargetStatus.Size = UDim2.new(1, -130, 0, 30)
TargetStatus.Position = UDim2.new(0, 55, 0, 10)
TargetStatus.BackgroundTransparency = 1
TargetStatus.Text = "📝 Enter a player name"
TargetStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
TargetStatus.Font = Enum.Font.GothamBold
TargetStatus.TextSize = 14
TargetStatus.TextXAlignment = Enum.TextXAlignment.Left
TargetStatus.TextYAlignment = Enum.TextYAlignment.Center
TargetStatus.Parent = TargetPanel

-- Nickname TextBox
local NicknameBox = Instance.new("TextBox")
NicknameBox.Name = "NicknameBox"
NicknameBox.Size = UDim2.new(1, -70, 0, 40)
NicknameBox.Position = UDim2.new(0, 55, 0, 45)
NicknameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
NicknameBox.PlaceholderText = "Enter player nickname..."
NicknameBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
NicknameBox.Text = ""
NicknameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NicknameBox.Font = Enum.Font.Gotham
NicknameBox.TextSize = 14
NicknameBox.TextXAlignment = Enum.TextXAlignment.Left
NicknameBox.ClearTextOnFocus = false
NicknameBox.Parent = TargetPanel

local NicknameCorner = Instance.new("UICorner")
NicknameCorner.CornerRadius = UDim.new(0, 8)
NicknameCorner.Parent = NicknameBox

-- Apply nickname button
local ApplyButton = Instance.new("TextButton")
ApplyButton.Size = UDim2.new(0, 60, 0, 40)
ApplyButton.Position = UDim2.new(1, -70, 0, 45)
ApplyButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
ApplyButton.Text = "Apply"
ApplyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ApplyButton.Font = Enum.Font.GothamBold
ApplyButton.TextSize = 14
ApplyButton.BorderSizePixel = 0
ApplyButton.Parent = TargetPanel

local ApplyCorner = Instance.new("UICorner")
ApplyCorner.CornerRadius = UDim.new(0, 8)
ApplyCorner.Parent = ApplyButton

-- Random mode toggle button
local RandomModeButton = Instance.new("TextButton")
RandomModeButton.Size = UDim2.new(0, 70, 0, 30)
RandomModeButton.Position = UDim2.new(1, -80, 0, 8)
RandomModeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
RandomModeButton.Text = "🎲 Random"
RandomModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RandomModeButton.Font = Enum.Font.GothamBold
RandomModeButton.TextSize = 12
RandomModeButton.BorderSizePixel = 0
RandomModeButton.Parent = TargetPanel

local RandomCorner = Instance.new("UICorner")
RandomCorner.CornerRadius = UDim.new(0, 6)
RandomCorner.Parent = RandomModeButton

-- Apply button hover effects
ApplyButton.MouseEnter:Connect(function()
    TweenService:Create(ApplyButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(158, 63, 246),
        Size = UDim2.new(0, 65, 0, 42)
    }):Play()
end)
ApplyButton.MouseLeave:Connect(function()
    TweenService:Create(ApplyButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(138, 43, 226),
        Size = UDim2.new(0, 60, 0, 40)
    }):Play()
end)

-- Apply nickname
ApplyButton.MouseButton1Click:Connect(function()
    targetMode = "nickname"
    RandomModeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    ApplyButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    targetNickname = NicknameBox.Text
    updateTarget()
end)

-- Random mode toggle
RandomModeButton.MouseButton1Click:Connect(function()
    targetMode = "random"
    RandomModeButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    ApplyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    updateTarget()
end)

-- Also apply when pressing Enter in the TextBox
NicknameBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        targetMode = "nickname"
        RandomModeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        ApplyButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        targetNickname = NicknameBox.Text
        updateTarget()
    end
end)

-- Refresh random player button
local RefreshButton = Instance.new("TextButton")
RefreshButton.Size = UDim2.new(0, 30, 0, 30)
RefreshButton.Position = UDim2.new(1, -115, 0, 8)
RefreshButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
RefreshButton.Text = "🔄"
RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshButton.Font = Enum.Font.GothamBold
RefreshButton.TextSize = 14
RefreshButton.BorderSizePixel = 0
RefreshButton.Visible = false
RefreshButton.Parent = TargetPanel

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 6)
RefreshCorner.Parent = RefreshButton

RefreshButton.MouseButton1Click:Connect(function()
    if targetMode == "random" then
        updateTarget()
    end
end)

-- Show/hide refresh button based on random mode
local function updateRefreshButton()
    RefreshButton.Visible = (targetMode == "random")
end

RandomModeButton.MouseButton1Click:Connect(updateRefreshButton)
ApplyButton.MouseButton1Click:Connect(updateRefreshButton)
updateRefreshButton()

-- CANCEL EMOTE BUTTON PANEL
local CancelPanel = Instance.new("Frame")
CancelPanel.Name = "CancelPanel"
CancelPanel.Size = UDim2.new(1, -20, 0, 50)
CancelPanel.Position = UDim2.new(0, 10, 0, 175)
CancelPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
CancelPanel.BorderSizePixel = 0
CancelPanel.Parent = MainFrame

local CancelCorner = Instance.new("UICorner")
CancelCorner.CornerRadius = UDim.new(0, 12)
CancelCorner.Parent = CancelPanel

local CancelIcon = Instance.new("TextLabel")
CancelIcon.Size = UDim2.new(0, 40, 1, 0)
CancelIcon.BackgroundTransparency = 1
CancelIcon.Text = "🛑"
CancelIcon.TextColor3 = Color3.fromRGB(220, 50, 50)
CancelIcon.Font = Enum.Font.GothamBold
CancelIcon.TextSize = 20
CancelIcon.Parent = CancelPanel

local CancelButton = Instance.new("TextButton")
CancelButton.Name = "CancelButton"
CancelButton.Size = UDim2.new(1, -50, 1, -10)
CancelButton.Position = UDim2.new(0, 45, 0, 5)
CancelButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CancelButton.Text = "❌ CANCEL CURRENT EMOTE"
CancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CancelButton.Font = Enum.Font.GothamBold
CancelButton.TextSize = 16
CancelButton.BorderSizePixel = 0
CancelButton.Parent = CancelPanel

local CancelButtonCorner = Instance.new("UICorner")
CancelButtonCorner.CornerRadius = UDim.new(0, 8)
CancelButtonCorner.Parent = CancelButton

-- Cancel button hover effects
CancelButton.MouseEnter:Connect(function()
    TweenService:Create(CancelButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(255, 50, 50),
        TextSize = 17
    }):Play()
end)

CancelButton.MouseLeave:Connect(function()
    TweenService:Create(CancelButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 50, 50),
        TextSize = 16
    }):Play()
end)

-- Cancel button click
CancelButton.MouseButton1Click:Connect(function()
    cancelCurrentEmote()
end)

-- Search Bar
local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Size = UDim2.new(1, -20, 0, 45)
SearchContainer.Position = UDim2.new(0, 10, 0, 235)
SearchContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SearchContainer.BorderSizePixel = 0
SearchContainer.Parent = MainFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 10)
SearchCorner.Parent = SearchContainer

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 40, 1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
SearchIcon.Font = Enum.Font.GothamBold
SearchIcon.TextSize = 18
SearchIcon.Parent = SearchContainer

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -90, 1, 0)
SearchBox.Position = UDim2.new(0, 40, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Search emotes..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 16
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = SearchContainer

-- Clear search button
local ClearSearchButton = Instance.new("TextButton")
ClearSearchButton.Name = "ClearSearchButton"
ClearSearchButton.Size = UDim2.new(0, 35, 0, 35)
ClearSearchButton.Position = UDim2.new(1, -40, 0.5, -17.5)
ClearSearchButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ClearSearchButton.Text = "✕"
ClearSearchButton.TextColor3 = Color3.fromRGB(150, 150, 150)
ClearSearchButton.Font = Enum.Font.GothamBold
ClearSearchButton.TextSize = 16
ClearSearchButton.BorderSizePixel = 0
ClearSearchButton.Visible = false
ClearSearchButton.Parent = SearchContainer

local ClearSearchCorner = Instance.new("UICorner")
ClearSearchCorner.CornerRadius = UDim.new(0, 8)
ClearSearchCorner.Parent = ClearSearchButton

ClearSearchButton.MouseButton1Click:Connect(function()
    SearchBox.Text = ""
end)

ClearSearchButton.MouseEnter:Connect(function()
    TweenService:Create(ClearSearchButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(60, 60, 65),
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)
ClearSearchButton.MouseLeave:Connect(function()
    TweenService:Create(ClearSearchButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 40, 45),
        TextColor3 = Color3.fromRGB(150, 150, 150)
    }):Play()
end)

-- ScrollingFrame for emotes
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, -20, 1, -295)
ScrollFrame.Position = UDim2.new(0, 10, 0, 290)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ScrollFrame

-- Create emote buttons
for emoteName, data in pairs(emotes) do
    local EmoteButton = Instance.new("Frame")
    EmoteButton.Name = emoteName
    EmoteButton.Size = UDim2.new(1, -12, 0, 70)
    EmoteButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    EmoteButton.BorderSizePixel = 0
    EmoteButton.Parent = ScrollFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = EmoteButton
    
    local Highlight = Instance.new("Frame")
    Highlight.Name = "Highlight"
    Highlight.Size = UDim2.new(1, 0, 1, 0)
    Highlight.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    Highlight.BackgroundTransparency = 0.95
    Highlight.BorderSizePixel = 0
    Highlight.Parent = EmoteButton
    
    local HighlightCorner = Instance.new("UICorner")
    HighlightCorner.CornerRadius = UDim.new(0, 12)
    HighlightCorner.Parent = Highlight
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 60, 0, 60)
    Icon.Position = UDim2.new(0, 5, 0.5, -30)
    Icon.BackgroundTransparency = 1
    Icon.Image = data.RenderImage or "rbxassetid://0"
    Icon.ScaleType = Enum.ScaleType.Fit
    Icon.Parent = EmoteButton
    
    local IconCorner = Instance.new("UICorner")
    IconCorner.CornerRadius = UDim.new(0, 10)
    IconCorner.Parent = Icon
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "NameLabel"
    NameLabel.Size = UDim2.new(1, -75, 1, 0)
    NameLabel.Position = UDim2.new(0, 70, 0, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = data.DisplayName or emoteName
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextSize = 18
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.TextYAlignment = Enum.TextYAlignment.Center
    NameLabel.Parent = EmoteButton
    
    local ClickButton = Instance.new("TextButton")
    ClickButton.Name = "ClickButton"
    ClickButton.Size = UDim2.new(1, 0, 1, 0)
    ClickButton.BackgroundTransparency = 1
    ClickButton.Text = ""
    ClickButton.Parent = EmoteButton
    
    ClickButton.MouseEnter:Connect(function()
        TweenService:Create(Highlight, TweenInfo.new(0.2), {BackgroundTransparency = 0.85}):Play()
        TweenService:Create(EmoteButton, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, 72)}):Play()
        TweenService:Create(NameLabel, TweenInfo.new(0.2), {TextSize = 19}):Play()
    end)
    
    ClickButton.MouseLeave:Connect(function()
        TweenService:Create(Highlight, TweenInfo.new(0.2), {BackgroundTransparency = 0.95}):Play()
        TweenService:Create(EmoteButton, TweenInfo.new(0.2), {Size = UDim2.new(1, -12, 0, 70)}):Play()
        TweenService:Create(NameLabel, TweenInfo.new(0.2), {TextSize = 18}):Play()
    end)
    
    ClickButton.MouseButton1Click:Connect(function()
        local targetChar = getTargetCharacter()
        
        if not targetChar then
            if targetMode == "random" then
                warn("No valid random player found!")
                updateTarget()
            elseif targetMode == "nickname" then
                warn("Target player not found!")
                TargetStatus.Text = "⚠️ Player not online: " .. targetNickname
                TargetStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
            end
            return
        end
        
        local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")
        if not targetHumanoid then
            warn("Target humanoid not found!")
            return
        end
        
        local targetKey = tostring(targetChar)
        
        -- Stop previous effects on this target
        stopAllEffects(targetChar)
        
        -- Play animation on target
        local animator = targetHumanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator")
            animator.Parent = targetHumanoid
        end
        
        local animation = Instance.new("Animation")
        animation.AnimationId = data.AssetID
        local animTrack = animator:LoadAnimation(animation)
        animTrack:Play()
        
        if not currentAnimations[targetKey] then
            currentAnimations[targetKey] = {}
        end
        table.insert(currentAnimations[targetKey], animTrack)
        
        print("🎬 Playing animation on:", targetChar.Parent.Name, "| Emote:", emoteName)
        
        -- Play audio on target's HumanoidRootPart (so it's positional and everyone can hear)
        local rootPart = targetChar:FindFirstChild("HumanoidRootPart")
        if rootPart and data.SFX then
            playAudio(data.SFX, rootPart, targetKey)
        end
        
        -- Play special effects on target
        playSpecialEffects(emoteName, data, targetChar, targetKey)
        
        -- Flash effect on button
        TweenService:Create(Highlight, TweenInfo.new(0.1), {BackgroundTransparency = 0.7}):Play()
        wait(0.1)
        TweenService:Create(Highlight, TweenInfo.new(0.3), {BackgroundTransparency = 0.95}):Play()
        
        -- Update status
        TargetStatus.Text = "🎬 Playing: " .. (data.DisplayName or emoteName) .. " on " .. targetChar.Parent.Name
        TargetStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(2)
        if targetMode == "nickname" and targetNickname ~= "" then
            updateTarget()
        elseif targetMode == "random" then
            updateTarget()
        end
    end)
end

-- Update canvas size
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)

-- Search functionality
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = SearchBox.Text:lower()
    ClearSearchButton.Visible = SearchBox.Text ~= ""
    
    for _, emoteButton in pairs(ScrollFrame:GetChildren()) do
        if emoteButton:IsA("Frame") and emoteButton.Name ~= "UIListLayout" then
            local emoteName = emoteButton.Name:lower()
            local displayName = ""
            
            local nameLabel = emoteButton:FindFirstChild("NameLabel")
            if nameLabel then
                displayName = nameLabel.Text:lower()
            end
            
            if searchText == "" or emoteName:find(searchText, 1, true) or displayName:find(searchText, 1, true) then
                emoteButton.Visible = true
            else
                emoteButton.Visible = false
            end
        end
    end
end)

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    SearchBox.Text = ""
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1, 50, 0.5, -335)
    }):Play()
    wait(0.3)
    MainFrame.Visible = false
    MainFrame.Position = UDim2.new(1, -430, 0.5, -335)
end)

-- Reopen button on right edge
local ReopenButton = Instance.new("TextButton")
ReopenButton.Name = "ReopenButton"
ReopenButton.Size = UDim2.new(0, 50, 0, 50)
ReopenButton.Position = UDim2.new(1, -60, 0.5, -25)
ReopenButton.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
ReopenButton.Text = "📋"
ReopenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ReopenButton.Font = Enum.Font.GothamBold
ReopenButton.TextSize = 24
ReopenButton.BorderSizePixel = 0
ReopenButton.Visible = false
ReopenButton.Parent = ScreenGui

local ReopenCorner = Instance.new("UICorner")
ReopenCorner.CornerRadius = UDim.new(0, 12)
ReopenCorner.Parent = ReopenButton

ReopenButton.MouseEnter:Connect(function()
    TweenService:Create(ReopenButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 55, 0, 55),
        Position = UDim2.new(1, -62.5, 0.5, -27.5),
        BackgroundColor3 = Color3.fromRGB(158, 63, 246)
    }):Play()
end)
ReopenButton.MouseLeave:Connect(function()
    TweenService:Create(ReopenButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(1, -60, 0.5, -25),
        BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    }):Play()
end)

MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
    ReopenButton.Visible = not MainFrame.Visible
end)

ReopenButton.MouseButton1Click:Connect(function()
    player = Players.LocalPlayer
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:FindFirstChildOfClass("Humanoid")
    MainFrame.Position = UDim2.new(1, 50, 0.5, -335)
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -430, 0.5, -335)
    }):Play()
end)

-- Update random player when players join/leave
Players.PlayerAdded:Connect(function()
    if targetMode == "random" then
        updateTarget()
    end
end)

Players.PlayerRemoving:Connect(function()
    if targetMode == "random" then
        updateTarget()
    end
end)

-- Keyboard shortcut (press 'C' to cancel emote)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.C then
        cancelCurrentEmote()
    end

	if input.KeyCode == Enum.KeyCode.Slash then
	ScreenGui:Destroy()
	end
end)

print("✅ Emote UI loaded!")
