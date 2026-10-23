--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/Piggy/Sealient%27s%20Piggy%20UI.lua
Source SHA-256: dac295e7e7f0b5a389a00913a52c632c5b47d0770ef6a168a69a2d41274ba1d0
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
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

local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local v1 = game:GetService("Workspace")
local httpService = game:GetService("HttpService")
local fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local interfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local window = fluent:CreateWindow({
  Title = "Piggy Cheat UI",
  SubTitle = "Fluent - Client Side Only",
  TabWidth = 160,
  Size = UDim2.fromOffset(580, 460),
  Acrylic = true,
  Theme = "Dark",
  MinimizeKey = Enum.KeyCode.LeftControl,
})

local v2 = {
  Player = window:AddTab({ Title = "Player", Icon = "user" }),
  Items = window:AddTab({ Title = "Items", Icon = "package" }),
  Visuals = window:AddTab({ Title = "Visuals", Icon = "eye" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local v3 = {}

function v3:InitGUIFolder()
  if not self.GUIFolder or not self.GUIFolder.Parent then
    local espManagerGuiFolder = coreGui:FindFirstChild("ESPManagerGuiFolder")

    if not espManagerGuiFolder then
      espManagerGuiFolder = Instance.new("ScreenGui")
      espManagerGuiFolder.Name = "ESPManagerGuiFolder"
      espManagerGuiFolder.ResetOnSpawn = false
      espManagerGuiFolder.Parent = coreGui
    end

    self.GUIFolder = espManagerGuiFolder
  end
end

v3:InitGUIFolder()

function v3:CreateInfoUI(p1)
  self:InitGUIFolder()
  local sealientUIInfo = self.GUIFolder:FindFirstChild("SealientUI_Info")
  local sealientUIInfo2, v4, v5, v6, connect

  if sealientUIInfo then
    return sealientUIInfo
  else
    sealientUIInfo2 = Instance.new("Frame")
    sealientUIInfo2.Name = "SealientUI_Info"
    sealientUIInfo2.AnchorPoint = Vector2.new(1, 0)
    sealientUIInfo2.Position = UDim2.new(1, -10, 0, 10)
    sealientUIInfo2.Size = UDim2.new(0, 200, 0, 90)
    sealientUIInfo2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    sealientUIInfo2.BackgroundTransparency = 0.5
    sealientUIInfo2.BorderSizePixel = 1
    sealientUIInfo2.BorderColor3 = Color3.fromRGB(0, 255, 0)
    sealientUIInfo2.Parent = self.GUIFolder

    local function f1(text, p2)
      local textLabel = Instance.new("TextLabel")
      textLabel.Size = UDim2.new(1, -10, 0, 25)
      textLabel.Position = UDim2.new(0, 5, 0, p2)
      textLabel.BackgroundTransparency = 1
      textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
      textLabel.TextStrokeTransparency = 0.7
      textLabel.Font = Enum.Font.SourceSansBold
      textLabel.TextSize = 18
      textLabel.TextXAlignment = Enum.TextXAlignment.Left
      textLabel.Text = text
      textLabel.Parent = sealientUIInfo2

      return textLabel
    end

    f1("Sealient's Piggy UI", 0)
    f1("Version: " .. (p1 or "Unknown"), 25)

    v4 = f1("FPS: 0", 50)
    v5 = tick()
    v6 = 0

    connect = nil

    connect = runService.RenderStepped:Connect(function()
      v6 = v6 + 1
      local v7 = tick()

      if v7 - v5 >= 1 then
        v4.Text = "FPS: " .. tostring(v6)
        v6 = 0
        v5 = v7
      end

      if not sealientUIInfo2.Parent then
        connect:Disconnect()
      end
    end)

    return sealientUIInfo2
  end
end

v3:CreateInfoUI("v1.2.0")

v2.Player:AddSlider("WalkSpeed", {
  Title = "Walk Speed",
  Description = "Adjust how fast you walk.",
  Min = 16,
  Max = 100,
  Default = 16,
  Rounding = 0,
  Callback = function(value)
    local character = game.Players.LocalPlayer.Character

    if character and character:FindFirstChildOfClass("Humanoid") then
      character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
  end,
})

v2.Player:AddSlider("JumpPower", {
  Title = "Jump Power",
  Description = "Adjust how high you jump.",
  Min = 50,
  Max = 200,
  Default = 50,
  Rounding = 0,
  Callback = function(value2)
    local character2 = game.Players.LocalPlayer.Character

    if character2 and character2:FindFirstChildOfClass("Humanoid") then
      character2:FindFirstChildOfClass("Humanoid").JumpPower = value2
    end
  end,
})

local connect2

v2.Player:AddToggle("NoclipToggle", {
  Title = "Noclip",
  Default = false,
  Callback = function(value3)
    if value3 then
      connect2 = runService.Stepped:Connect(function()
        local character3 = game.Players.LocalPlayer.Character

        if character3 then
          for key, value4 in pairs(character3:GetDescendants()) do
            if value4:IsA("BasePart") then
              value4.CanCollide = false
            end
          end
        end
      end)
    elseif connect2 then
      connect2:Disconnect()
    end
  end,
})

v2.Player:AddToggle("InfJump", {
  Title = "Infinite Jump",
  Default = false,
  Callback = function(value5)
    if value5 then
      _G.InfJump = true

      userInputService.JumpRequest:Connect(function()
        if _G.InfJump then
          local character4 = game.Players.LocalPlayer.Character

          if character4 and character4:FindFirstChildOfClass("Humanoid") then
            character4:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
          end
        end
      end)
    else
      _G.InfJump = false
    end
  end,
})

local localPlayer = players.LocalPlayer

local v8 = { GUIFolder = nil, itemESPInstances = {}, itemHighlights = {} }

function v8:Init()
  self.GUIFolder = coreGui:FindFirstChild("ItemESPFolder")

  if not self.GUIFolder then
    self.GUIFolder = Instance.new("Folder")
    self.GUIFolder.Name = "ItemESPFolder"
    self.GUIFolder.Parent = coreGui
  end
end

function v8:CreateItemESP(p3)
  local basePart = p3:IsA("BasePart") and p3 or p3:FindFirstChildWhichIsA("BasePart")

  if not basePart then
    return
  else
    local itemESP = Instance.new("BillboardGui")
    itemESP.Name = "ItemESP"
    itemESP.Adornee = basePart
    itemESP.AlwaysOnTop = true
    itemESP.Size = UDim2.new(0, 150, 0, 50)
    itemESP.StudsOffset = Vector3.new(0, 3, 0)
    itemESP.LightInfluence = 0
    itemESP.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.5
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
    frame.Parent = itemESP

    local textLabel2 = Instance.new("TextLabel")
    textLabel2.Size = UDim2.new(1, -10, 0, 25)
    textLabel2.Position = UDim2.new(0, 5, 0, 0)
    textLabel2.BackgroundTransparency = 1
    textLabel2.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel2.TextStrokeTransparency = 0.7
    textLabel2.Font = Enum.Font.SourceSansBold
    textLabel2.TextSize = 18
    textLabel2.TextXAlignment = Enum.TextXAlignment.Left
    textLabel2.Text = p3.Name
    textLabel2.Parent = frame

    local textLabel3 = Instance.new("TextLabel")
    textLabel3.Size = UDim2.new(1, -10, 0, 20)
    textLabel3.Position = UDim2.new(0, 5, 0, 25)
    textLabel3.BackgroundTransparency = 1
    textLabel3.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel3.TextStrokeTransparency = 0.7
    textLabel3.Font = Enum.Font.SourceSansItalic
    textLabel3.TextSize = 14
    textLabel3.TextXAlignment = Enum.TextXAlignment.Left
    textLabel3.Text = ""
    textLabel3.Parent = frame

    itemESP.Parent = self.GUIFolder

    local itemHighlight = Instance.new("Highlight")
    itemHighlight.Name = "ItemHighlight"
    itemHighlight.Adornee = p3
    itemHighlight.FillColor = Color3.fromRGB(0, 255, 0)
    itemHighlight.OutlineColor = Color3.fromRGB(0, 255, 0)
    itemHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    itemHighlight.Parent = p3

    self.itemESPInstances[p3] = { Gui = itemESP, DistLabel = textLabel3 }
    self.itemHighlights[p3] = itemHighlight

    return
  end
end

function v8:ClearAll()
  for key2, value6 in pairs(self.itemESPInstances) do
    if value6.Gui and value6.Gui.Parent then
      value6.Gui:Destroy()
    end
  end

  self.itemESPInstances = {}

  for key3, value7 in pairs(self.itemHighlights) do
    if value7 and value7.Parent then
      value7:Destroy()
    end
  end

  self.itemHighlights = {}
end

function v8:UpdateDistances()
  local character5 = localPlayer.Character

  if not character5 or not character5:FindFirstChild("HumanoidRootPart") then
    return
  else
    local humanoidRootPart = character5.HumanoidRootPart

    for key4, value8 in pairs(self.itemESPInstances) do
      if value8.DistLabel and key4 and key4:IsDescendantOf(game) then
        local getPivot = key4:GetPivot()

        value8.DistLabel.Text = string.format(
          "Distance: %.1f", (humanoidRootPart.Position - getPivot.Position).Magnitude
        )
      else
        if value8.Gui then
          value8.Gui:Destroy()
        end

        if self.itemHighlights[key4] then
          self.itemHighlights[key4]:Destroy()
        end

        self.itemESPInstances[key4] = nil
        self.itemHighlights[key4] = nil
      end
    end

    return
  end
end

v8:Init()

local function f2()
  for key5, value9 in pairs(workspace:GetChildren()) do
    if value9:IsA("Folder") and (value9.Name == "ItemFolder" or tonumber(value9.Name)) then
      return value9
    end
  end

  return nil
end

local connect3

v2.Items:AddToggle("ItemESP", {
  Title = "Item ESP",
  Description = "Highlights all visible items with labels and distance.",
  Default = false,
  Callback = function(value10)
    v8:ClearAll()

    if connect3 then
      connect3:Disconnect()
      connect3 = nil
    end

    if value10 then
      local v9 = f2()

      if not v9 then
        warn("No valid item folder found in workspace.")
        return
      end

      for key6, value11 in pairs(v9:GetChildren()) do
        if value11:IsA("Model") or value11:IsA("BasePart") then
          v8:CreateItemESP(value11)
        end
      end

      connect3 = runService.RenderStepped:Connect(function() v8:UpdateDistances() end)
      return
    end
  end,
})

function _G.ClearAllESPs()
  v8:ClearAll()
end

local localPlayer2 = players.LocalPlayer
v8 = v8 or {}
local v10 = v8
local guiFolder = v8.GUIFolder
local instance = guiFolder

if not guiFolder then
  local v11 = game
  instance = Instance.new("Folder", v11:GetService("CoreGui"))
end

v10.GUIFolder = instance

v8.GUIFolder.Name = "ESPFolder"
v8.piggyESPInstances = {}
v8.piggyHighlights = {}

function v8:CreatePiggyESP(p4)
  if self.piggyESPInstances[p4] then
    return
  else
    local primaryPart = p4.PrimaryPart or p4:FindFirstChildWhichIsA("BasePart")

    if not primaryPart then
      return
    else
      local color = Color3.fromRGB(255, 0, 0)

      local piggyESP = Instance.new("BillboardGui")
      piggyESP.Name = "PiggyESP"
      piggyESP.Adornee = primaryPart
      piggyESP.AlwaysOnTop = true
      piggyESP.Size = UDim2.new(0, 150, 0, 50)
      piggyESP.StudsOffset = Vector3.new(0, 3, 0)
      piggyESP.LightInfluence = 0
      piggyESP.ResetOnSpawn = false

      local frame2 = Instance.new("Frame")
      frame2.Size = UDim2.new(1, 0, 1, 0)
      frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
      frame2.BackgroundTransparency = 0.5
      frame2.BorderSizePixel = 1
      frame2.BorderColor3 = color
      frame2.Parent = piggyESP

      local textLabel4 = Instance.new("TextLabel")
      textLabel4.Size = UDim2.new(1, -10, 0, 25)
      textLabel4.Position = UDim2.new(0, 5, 0, 0)
      textLabel4.BackgroundTransparency = 1
      textLabel4.TextColor3 = color
      textLabel4.TextStrokeTransparency = 0.7
      textLabel4.Font = Enum.Font.SourceSansBold
      textLabel4.TextSize = 18
      textLabel4.TextXAlignment = Enum.TextXAlignment.Left
      textLabel4.Text = p4.Name
      textLabel4.Parent = frame2

      local textLabel5 = Instance.new("TextLabel")
      textLabel5.Size = UDim2.new(1, -10, 0, 20)
      textLabel5.Position = UDim2.new(0, 5, 0, 25)
      textLabel5.BackgroundTransparency = 1
      textLabel5.TextColor3 = color
      textLabel5.TextStrokeTransparency = 0.7
      textLabel5.Font = Enum.Font.SourceSansItalic
      textLabel5.TextSize = 14
      textLabel5.TextXAlignment = Enum.TextXAlignment.Left
      textLabel5.Text = ""
      textLabel5.Parent = frame2

      piggyESP.Parent = self.GUIFolder

      local piggyHighlight = Instance.new("Highlight")
      piggyHighlight.Name = "PiggyHighlight"
      piggyHighlight.Adornee = p4
      piggyHighlight.FillColor = color
      piggyHighlight.OutlineColor = color
      piggyHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      piggyHighlight.Parent = p4

      self.piggyESPInstances[p4] = { Gui = piggyESP, DistLabel = textLabel5 }
      self.piggyHighlights[p4] = piggyHighlight

      return
    end
  end
end

function v8:ClearPiggyESP()
  for key7, value12 in pairs(self.piggyESPInstances) do
    if value12.Gui then
      value12.Gui:Destroy()
    end
  end

  for key8, value13 in pairs(self.piggyHighlights) do
    if value13 then
      value13:Destroy()
    end
  end

  self.piggyESPInstances = {}
  self.piggyHighlights = {}
end

function v8:UpdatePiggyDistances()
  local humanoidRootPart2 = localPlayer2.Character
    and localPlayer2.Character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart2 then
    return
  end

  for key9, value14 in pairs(self.piggyESPInstances) do
    if key9 and key9:IsDescendantOf(v1) and value14.DistLabel then
      local primaryPart2 = key9.PrimaryPart

      local basePart2 = primaryPart2
      basePart2 = primaryPart2 or key9:FindFirstChildWhichIsA("BasePart")

      if basePart2 then
        value14.DistLabel.Text = string.format(
          "Distance: %.1f", (basePart2.Position - humanoidRootPart2.Position).Magnitude
        )
      end
    end
  end
end

local connect4

v2.Visuals:AddToggle("PiggyESP", {
  Title = "Piggy ESP",
  Description = "ESP for all NPC and player Piggies.",
  Default = false,
  Callback = function(value15)
    if connect4 then
      connect4:Disconnect()
    end

    v8:ClearPiggyESP()

    if not value15 then
      return
    end

    connect4 = runService.RenderStepped:Connect(function()
      local piggyNPC = v1:FindFirstChild("PiggyNPC")

      if piggyNPC then
        for index, value16 in ipairs(piggyNPC:GetChildren()) do
          if value16:IsA("Model") then
            v8:CreatePiggyESP(value16)
          end
        end
      end

      for index2, value17 in ipairs(players:GetPlayers()) do
        if value17 ~= localPlayer2 then
          local findFirstChild = v1:FindFirstChild(value17.Name)

          if findFirstChild and findFirstChild:FindFirstChild("Enemy") then
            v8:CreatePiggyESP(findFirstChild)
          end
        end
      end

      v8:UpdatePiggyDistances()
    end)
  end,
})

local clearAllESPs = _G.ClearAllESPs or function() end

function _G.ClearAllESPs()
  clearAllESPs()
  v8:ClearPiggyESP()
end

v8.playerESPInstances = {}
v8.playerHighlights = {}

function v8:CreatePlayerESP(p5)
  if p5 == players.LocalPlayer then
    return
  else
    local character6 = p5.Character

    if not character6 then
      return
    else
      local primaryPart3 = character6.PrimaryPart
        or character6:FindFirstChildWhichIsA("BasePart")

      if not primaryPart3 then
        return
      else
        local v12 = character6:FindFirstChild("Traitor") ~= nil
        local text2 = v12 and "Traitor" or "Normal"
        local color2 = v12 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)

        local playerESP = Instance.new("BillboardGui")
        playerESP.Name = "PlayerESP"
        playerESP.Adornee = primaryPart3
        playerESP.AlwaysOnTop = true
        playerESP.Size = UDim2.new(0, 170, 0, 70)
        playerESP.StudsOffset = Vector3.new(0, 3, 0)
        playerESP.LightInfluence = 0
        playerESP.ResetOnSpawn = false

        local frame3 = Instance.new("Frame")
        frame3.Size = UDim2.new(1, 0, 1, 0)
        frame3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame3.BackgroundTransparency = 0.5
        frame3.BorderSizePixel = 1
        frame3.BorderColor3 = color2
        frame3.Name = "Frame"
        frame3.Parent = playerESP

        local textLabel6 = Instance.new("TextLabel")
        textLabel6.Size = UDim2.new(1, -10, 0, 25)
        textLabel6.Position = UDim2.new(0, 5, 0, 0)
        textLabel6.BackgroundTransparency = 1
        textLabel6.TextColor3 = color2
        textLabel6.TextStrokeTransparency = 0.7
        textLabel6.Font = Enum.Font.SourceSansBold
        textLabel6.TextSize = 18
        textLabel6.TextXAlignment = Enum.TextXAlignment.Left
        textLabel6.Text = p5.Name
        textLabel6.Parent = frame3

        local textLabel7 = Instance.new("TextLabel")
        textLabel7.Size = UDim2.new(1, -10, 0, 20)
        textLabel7.Position = UDim2.new(0, 5, 0, 25)
        textLabel7.BackgroundTransparency = 1
        textLabel7.TextColor3 = color2
        textLabel7.TextStrokeTransparency = 0.7
        textLabel7.Font = Enum.Font.SourceSansItalic
        textLabel7.TextSize = 14
        textLabel7.TextXAlignment = Enum.TextXAlignment.Left
        textLabel7.Text = text2
        textLabel7.Parent = frame3

        local textLabel8 = Instance.new("TextLabel")
        textLabel8.Size = UDim2.new(1, -10, 0, 20)
        textLabel8.Position = UDim2.new(0, 5, 0, 45)
        textLabel8.BackgroundTransparency = 1
        textLabel8.TextColor3 = color2
        textLabel8.TextStrokeTransparency = 0.7
        textLabel8.Font = Enum.Font.SourceSansItalic
        textLabel8.TextSize = 14
        textLabel8.TextXAlignment = Enum.TextXAlignment.Left
        textLabel8.Text = ""
        textLabel8.Parent = frame3

        playerESP.Parent = self.GUIFolder

        local playerHighlight = Instance.new("Highlight")
        playerHighlight.Name = "PlayerHighlight"
        playerHighlight.Adornee = character6
        playerHighlight.FillColor = color2
        playerHighlight.OutlineColor = color2
        playerHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        playerHighlight.Parent = character6

        self.playerESPInstances[p5] = {
          Gui = playerESP,
          DistLabel = textLabel8,
          RoleLabel = textLabel7,
        }

        self.playerHighlights[p5] = playerHighlight

        return
      end
    end
  end
end

function v8:ClearPlayerESP()
  for key10, value18 in pairs(self.playerESPInstances) do
    if value18.Gui then
      value18.Gui:Destroy()
    end
  end

  for key11, value19 in pairs(self.playerHighlights) do
    if value19 then
      value19:Destroy()
    end
  end

  self.playerESPInstances = {}
  self.playerHighlights = {}
end

function v8:UpdatePlayerESP()
  local humanoidRootPart3 = players.LocalPlayer.Character
    and players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart3 then
    return
  end

  for key12, value20 in pairs(self.playerESPInstances) do
    local character7 = key12.Character

    if character7 and character7:IsDescendantOf(game)
      and character7:FindFirstChild("HumanoidRootPart") then
      value20.DistLabel.Text = string.format("Distance: %.1f", (humanoidRootPart3.Position
        - character7.HumanoidRootPart.Position).Magnitude)

      local v13 = character7:FindFirstChild("Traitor") ~= nil
      local v14 = v13 and "Traitor" or "Normal"

      local color3 = v13
      color3 = v13 and Color3.fromRGB(255, 0, 0)

      local color4 = color3
      color4 = color3 or Color3.fromRGB(0, 255, 0)

      if value20.RoleLabel.Text ~= v14 then
        value20.RoleLabel.Text = v14
        value20.RoleLabel.TextColor3 = color4
        value20.Gui.Frame.BorderColor3 = color4
      end

      local v15 = self.playerHighlights[key12]

      if v15 then
        v15.FillColor = color4
        v15.OutlineColor = color4
      end
    else
      if value20.Gui then
        value20.Gui:Destroy()
      end

      if self.playerHighlights[key12] then
        self.playerHighlights[key12]:Destroy()
      end

      self.playerESPInstances[key12] = nil
      self.playerHighlights[key12] = nil
    end
  end
end

local v16 = false
local connect5, connect6, connect7

v2.Visuals:AddToggle("PlayerESP", {
  Title = "Player ESP",
  Description = "Shows player names, roles (Traitor or Normal), and distances.",
  Default = false,
  Callback = function(value21)
    v16 = value21
    v8:ClearPlayerESP()

    if connect5 then
      connect5:Disconnect()
      connect5 = nil
    end

    if connect6 then
      connect6:Disconnect()
    end

    if connect7 then
      connect7:Disconnect()
    end

    if value21 then
      for key13, value22 in pairs(players:GetPlayers()) do
        if value22 ~= players.LocalPlayer and value22.Character then
          v8:CreatePlayerESP(value22)
        end
      end

      connect6 = players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function()
          if v16 then
            v8:CreatePlayerESP(player)
          end
        end)
      end)

      connect7 = players.PlayerRemoving:Connect(function(player2)
        if v8.playerESPInstances[player2] then
          if v8.playerESPInstances[player2].Gui then
            v8.playerESPInstances[player2].Gui:Destroy()
          end

          if v8.playerHighlights[player2] then
            v8.playerHighlights[player2]:Destroy()
          end

          v8.playerESPInstances[player2] = nil
          v8.playerHighlights[player2] = nil
        end
      end)

      connect5 = runService.RenderStepped:Connect(function() v8:UpdatePlayerESP() end)
    end
  end,
})

local clearAllESPs2 = _G.ClearAllESPs or function() end

function _G.ClearAllESPs()
  clearAllESPs2()
  v8:ClearPlayerESP()
end

local localPlayer3 = players.LocalPlayer
;(localPlayer3.Character or localPlayer3.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
local itemFolder = workspace:FindFirstChild("ItemFolder") or nil

if not itemFolder then
  for index3, value23 in ipairs(workspace:GetChildren()) do
    if tonumber(value23.Name) then
      itemFolder = value23
      break
    end
  end
end

local addDropdown = v2.Items:AddDropdown("ItemSelector", {
  Title = "Select Item",
  Values = {},
  Default = nil,
  Multi = false,
  Description = "Select an item to teleport to.",
})

local v17
addDropdown:OnChanged(function(p6) v17 = p6 end)

local function f3()
  local v18 = {}

  if not itemFolder then
    return
  end

  for index4, value24 in ipairs(itemFolder:GetChildren()) do
    if value24:IsA("BasePart") or value24:FindFirstChildWhichIsA("BasePart") then
      table.insert(v18, value24.Name)
    end
  end

  addDropdown:SetValues(v18)
end

local cframe

v2.Items:AddButton({
  Title = "Teleport To Item",
  Description = "Teleport to the selected item.",
  Callback = function()
    if not v17 then
      fluent:Notify({ Title = "Error", Content = "Please select an item first.", Duration = 3 })
      return
    else
      local findFirstChild2 = itemFolder:FindFirstChild(v17)

      if not findFirstChild2 then
        fluent:Notify({ Title = "Error", Content = "Selected item not found.", Duration = 3 })
        return
      else
        local basePart3 = findFirstChild2:IsA("BasePart") and findFirstChild2
          or findFirstChild2:FindFirstChildWhichIsA("BasePart")

        if not basePart3 then
          fluent:Notify({
            Title = "Error",
            Content = "Selected item has no valid part.",
            Duration = 3,
          })

          return
        end

        if not cframe then
          local humanoidRootPart4 = localPlayer3.Character
            and localPlayer3.Character:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart4 then
            cframe = humanoidRootPart4.CFrame
          end
        end

        if localPlayer3.Character and localPlayer3.Character:FindFirstChild("HumanoidRootPart") then
          localPlayer3.Character.HumanoidRootPart.CFrame = basePart3.CFrame
            + Vector3.new(0, 3, 0)

          fluent:Notify({ Title = "Teleported", Content = "Teleported to " .. v17, Duration = 4 })
        end

        return
      end
    end
  end,
})

v2.Items:AddButton({
  Title = "Teleport Back",
  Description = "Return to original position.",
  Callback = function()
    if cframe and localPlayer3.Character
      and localPlayer3.Character:FindFirstChild("HumanoidRootPart") then
      localPlayer3.Character.HumanoidRootPart.CFrame = cframe

      fluent:Notify({
        Title = "Teleported",
        Content = "Returned to original position.",
        Duration = 4,
      })

      cframe = nil
    else
      fluent:Notify({
        Title = "Error",
        Content = "No saved position to return to.",
        Duration = 3,
      })
    end
  end,
})

f3()

task.spawn(function()
  while true do
    task.wait(10)
    f3()
  end
end)

v2.Settings:AddButton({
  Title = "Check for Updates",
  Description = "Check if a new version of the UI is available.",
  Callback = function()
    local v19, v20 = pcall(function()
      return game:HttpGet("https://raw.githubusercontent.com/Sealient/Sealients-Roblox-Scripts/refs/heads/main/Piggy/Sealient%27s%20Piggy%20Ui%20Version.lua")
    end)

    if not v19 then
      window:Dialog({
        Title = "Error",
        Content = [[
Could not fetch version info.
Check your internet connection or the URL.]],
        Buttons = { { Title = "OK" } },
      })

      return
    else
      local returnS = v20:match("return%s+\"([^\"]+)\"")

      if not returnS then
        window:Dialog({
          Title = "Error",
          Content = "Failed to parse the latest version from server.",
          Buttons = { { Title = "OK" } },
        })

        return
      end

      if returnS == "v1.2.0" then
        window:Dialog({
          Title = "Up to Date",
          Content = [[
You're already on the latest version.
Version: v1.2.0]],
          Buttons = { { Title = "OK" } },
        })
      else
        window:Dialog({
          Title = "Update Available",
          Content = string.format([[
Current: %s
Latest: %s
Update now?]], "v1.2.0", returnS),
          Buttons = {
            {
              Title = "Update",
              Callback = function()
                if _G.ClearAllESPs then
                  _G.ClearAllESPs()
                end

                local espManagerGuiFolder2 = coreGui:FindFirstChild("ESPManagerGuiFolder")

                local sealientUIInfo3 = espManagerGuiFolder2
                  and espManagerGuiFolder2:FindFirstChild("SealientUI_Info")

                if sealientUIInfo3 then
                  sealientUIInfo3:Destroy()
                end

                if window and typeof(window.Destroy) == "function" then
                  window:Destroy()
                end

                local v21, v22 = pcall(function()
                  loadstring((game:HttpGet("https://raw.githubusercontent.com/Sealient/Sealients-Roblox-Scripts/refs/heads/main/Piggy/Sealient%27s%20Piggy%20UI.lua")))()
                end)

                if not v21 then
                  warn("[Update Error] Failed to load updated script:", v22)

                  window:Dialog({
                    Title = "Update Failed",
                    Content = [[
Failed to load the updated script.
Check the console for details.]],
                    Buttons = { { Title = "OK" } },
                  })
                end
              end,
            },
            { Title = "Cancel" },
          },
        })
      end

      return
    end
  end,
})

saveManager:SetLibrary(fluent)
interfaceManager:SetLibrary(fluent)

saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({})

interfaceManager:SetFolder("PiggyCheatUI")
saveManager:SetFolder("PiggyCheatUI/configs")
interfaceManager:BuildInterfaceSection(v2.Settings)
saveManager:BuildConfigSection(v2.Settings)
window:SelectTab(1)

fluent:Notify({
  Title = "Piggy Cheat Menu",
  Content = "Base UI loaded. Tabs are ready.",
  Duration = 6,
})

saveManager:LoadAutoloadConfig()
