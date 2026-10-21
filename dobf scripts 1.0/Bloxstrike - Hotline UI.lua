--[[
Game source provenance | DEOBFUSCATED | NOT TESTED IN ROBLOX
Original: https://github.com/orjinalwasexd/bloxstrike/blob/7f1babe48727e63bea57b78526c921b2dc1d4722/bloxstrike.lua
Source SHA-256: 5f8a56ddbda201521d57d71f0823608c01b03f896631e8c934a514b99f04b05a
Static recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
SAFETY CHANGE: removed remote RScripts telemetry loader (one task.spawn block).
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2026 onyxinc

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

local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local coreGui = game:GetService("CoreGui")

local localPlayer = players.LocalPlayer

local v1 = {
  Background = Color3.fromRGB(12, 10, 8),
  SidebarBg = Color3.fromRGB(10, 8, 6),
  CardBg = Color3.fromRGB(22, 18, 10),
  ControlBg = Color3.fromRGB(32, 26, 12),
  BorderYellow = Color3.fromRGB(180, 130, 20),
  YellowPrimary = Color3.fromRGB(255, 215, 0),
  YellowAccent = Color3.fromRGB(255, 185, 15),
  YellowDark = Color3.fromRGB(60, 45, 5),
  YellowGlow = Color3.fromRGB(230, 160, 0),
  TextPrimary = Color3.fromRGB(255, 248, 220),
  TextMuted = Color3.fromRGB(160, 145, 90),
  TextSubtle = Color3.fromRGB(100, 90, 50),
  Divider = Color3.fromRGB(50, 40, 15),
  AccentRed = Color3.fromRGB(248, 113, 113),
  AccentBlue = Color3.fromRGB(96, 165, 250),
  AccentGreen = Color3.fromRGB(52, 211, 153),
}

getgenv().ParsaIntegratedSettings = {
  SilentEnabled = false,
  Wallbang = false,
  HitPart = "Head",
  ShowFov = false,
  FOVRadius = 130,
  FOVColor = Color3.fromRGB(255, 215, 0),
  ESP = false,
  ESPBoxes = false,
  ESPSkeletons = false,
  ESPNames = false,
  ESPHealth = false,
  ESPDistance = false,
  ESPMaxDistance = 2500,
  TeamCheck = true,
  BoxColor = Color3.fromRGB(255, 215, 0),
  OutlineColor = Color3.fromRGB(15, 15, 15),
  NameColor = Color3.fromRGB(255, 248, 220),
  DistanceColor = Color3.fromRGB(160, 145, 90),
}

getgenv().ParsaTeamColors = {
  Terrorists = Color3.fromRGB(255, 185, 15),
  ["Counter-Terrorists"] = Color3.fromRGB(96, 165, 250),
}

getgenv().ParsaSilentTarget = nil

local v2 = getgenv()

local function f1(p1)
  if not p1 then
    return nil
  else
    local v3, v4 = pcall(function() return p1.Team and p1.Team.Name or nil end)

    if v3 and (v4 == "Terrorists" or v4 == "Counter-Terrorists") then
      return v4
    else
      local character = p1.Character

      if character then
        local team = character:GetAttribute("Team")

        if team == "Terrorists" or team == "Counter-Terrorists" then
          return team
        else
          local name = character.Parent and character.Parent.Name

          if name == "Terrorists" or name == "Counter-Terrorists" then
            return name
          end

          return nil
        end
      else
        return nil
      end
    end
  end
end

local parsaIntegratedSettings = v2.ParsaIntegratedSettings
getgenv().ParsaGetTeam = f1

local hotlineUI = Instance.new("ScreenGui")
hotlineUI.Name = "HotlineUI"
hotlineUI.ResetOnSpawn = false
hotlineUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() hotlineUI.Parent = coreGui end)

if not hotlineUI.Parent then
  hotlineUI.Parent = localPlayer:WaitForChild("PlayerGui")
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 620, 0, 460)
mainFrame.Position = UDim2.new(0.5, -310, 0.5, -230)
mainFrame.BackgroundColor3 = v1.Background
mainFrame.BorderSizePixel = 0
mainFrame.Parent = hotlineUI

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = v1.BorderYellow
uiStroke.Thickness = 1.5
uiStroke.Parent = mainFrame

local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 0, 40)
frame.BackgroundColor3 = v1.SidebarBg
frame.BorderSizePixel = 0
frame.Parent = mainFrame

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(1, 0, 0, 12)
frame2.Position = UDim2.new(0, 0, 1, -12)
frame2.BackgroundColor3 = v1.SidebarBg
frame2.BorderSizePixel = 0
frame2.Parent = frame

local frame3 = Instance.new("Frame")
frame3.Size = UDim2.new(1, 0, 0, 1)
frame3.Position = UDim2.new(0, 0, 1, -1)
frame3.BackgroundColor3 = v1.Divider
frame3.BorderSizePixel = 0
frame3.Parent = frame

local frame4 = Instance.new("Frame")
frame4.Size = UDim2.new(0, 18, 0, 18)
frame4.Position = UDim2.new(0, 14, 0.5, -9)
frame4.BackgroundColor3 = v1.YellowPrimary
frame4.BorderSizePixel = 0
frame4.Parent = frame

Instance.new("UICorner", frame4).CornerRadius = UDim.new(1, 0)

local frame5 = Instance.new("Frame")
frame5.Size = UDim2.new(0, 14, 0, 14)
frame5.Position = UDim2.new(0, 5, 0, -3)
frame5.BackgroundColor3 = v1.SidebarBg
frame5.BorderSizePixel = 0
frame5.Parent = frame4

Instance.new("UICorner", frame5).CornerRadius = UDim.new(1, 0)

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 200, 1, 0)
textLabel.Position = UDim2.new(0, 42, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Font = Enum.Font.GothamBold
textLabel.Text = "HOTLINE"
textLabel.TextColor3 = v1.YellowPrimary
textLabel.TextSize = 16
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = frame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(0, 300, 1, 0)
textLabel2.Position = UDim2.new(0, 145, 0, 0)
textLabel2.BackgroundTransparency = 1
textLabel2.Font = Enum.Font.GothamBold
textLabel2.Text = "ony - orjinalwase   [K]"
textLabel2.TextColor3 = v1.TextMuted
textLabel2.TextSize = 11
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Parent = frame

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 26, 0, 26)
textButton.Position = UDim2.new(1, -36, 0.5, -13)
textButton.BackgroundColor3 = v1.ControlBg
textButton.BorderSizePixel = 0
textButton.Font = Enum.Font.GothamBold
textButton.Text = "X"
textButton.TextColor3 = v1.AccentRed
textButton.TextSize = 12
textButton.Parent = frame

Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 4)

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0, 26, 0, 26)
textButton2.Position = UDim2.new(1, -68, 0.5, -13)
textButton2.BackgroundColor3 = v1.ControlBg
textButton2.BorderSizePixel = 0
textButton2.Font = Enum.Font.GothamBold
textButton2.Text = "-"
textButton2.TextColor3 = v1.TextMuted
textButton2.TextSize = 14
textButton2.Parent = frame

Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 4)

local frame6 = Instance.new("Frame")
frame6.Size = UDim2.new(1, 0, 0, 34)
frame6.Position = UDim2.new(0, 0, 0, 40)
frame6.BackgroundColor3 = v1.SidebarBg
frame6.BorderSizePixel = 0
frame6.Parent = mainFrame

local frame7 = Instance.new("Frame")
frame7.Size = UDim2.new(1, 0, 0, 1)
frame7.Position = UDim2.new(0, 0, 1, -1)
frame7.BackgroundColor3 = v1.Divider
frame7.BorderSizePixel = 0
frame7.Parent = frame6

local frame8 = Instance.new("Frame")
frame8.Size = UDim2.new(1, -20, 1, -4)
frame8.Position = UDim2.new(0, 10, 0, 2)
frame8.BackgroundTransparency = 1
frame8.Parent = frame6

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.FillDirection = Enum.FillDirection.Horizontal
uiListLayout.Padding = UDim.new(0, 4)
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
uiListLayout.Parent = frame8

local frame9 = Instance.new("Frame")
frame9.Size = UDim2.new(1, 0, 1, -74)
frame9.Position = UDim2.new(0, 0, 0, 74)
frame9.BackgroundTransparency = 1
frame9.Parent = mainFrame

local function f2(p2, text, p3, p4)
  local frame10 = Instance.new("Frame")
  frame10.Size = UDim2.new(1, 0, 0, 40)
  frame10.BackgroundColor3 = v1.CardBg
  frame10.BorderSizePixel = 0
  frame10.Parent = p2.Scroll

  Instance.new("UICorner", frame10).CornerRadius = UDim.new(0, 6)
  Instance.new("UIStroke", frame10).Color = v1.Divider

  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Size = UDim2.new(1, -70, 1, 0)
  textLabel3.Position = UDim2.new(0, 12, 0, 0)
  textLabel3.BackgroundTransparency = 1
  textLabel3.Font = Enum.Font.GothamBold
  textLabel3.Text = text
  textLabel3.TextColor3 = v1.TextPrimary
  textLabel3.TextSize = 12
  textLabel3.TextXAlignment = Enum.TextXAlignment.Left
  textLabel3.Parent = frame10

  local textButton3 = Instance.new("TextButton")
  textButton3.Size = UDim2.new(0, 38, 0, 20)
  textButton3.Position = UDim2.new(1, -50, 0.5, -10)
  textButton3.BackgroundColor3 = p3 and v1.YellowAccent or v1.ControlBg
  textButton3.BorderSizePixel = 0
  textButton3.Text = ""
  textButton3.AutoButtonColor = false
  textButton3.Parent = frame10

  Instance.new("UICorner", textButton3).CornerRadius = UDim.new(1, 0)

  local frame11 = Instance.new("Frame")
  frame11.Size = UDim2.new(0, 16, 0, 16)
  frame11.Position = p3 and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
  frame11.BackgroundColor3 = v1.TextPrimary
  frame11.BorderSizePixel = 0
  frame11.Parent = textButton3

  Instance.new("UICorner", frame11).CornerRadius = UDim.new(1, 0)
  local v5 = p3

  local function f3(p5)
    v5 = p5

    tweenService:Create(textButton3, TweenInfo.new(0.15), {
      BackgroundColor3 = v5 and v1.YellowAccent or v1.ControlBg,
    }):Play()

    tweenService:Create(frame11, TweenInfo.new(0.15), {
      Position = v5 and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
    }):Play()

    if p4 then
      p4(v5)
    end
  end

  textButton3.MouseButton1Click:Connect(function() f3(not v5) end)
  return { Set = f3 }
end

local function f4(p6, p7)
  local frame12 = Instance.new("Frame")
  frame12.Size = UDim2.new(1, 0, 0, 22)
  frame12.BackgroundTransparency = 1
  frame12.Parent = p6.Scroll

  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Size = UDim2.new(1, 0, 1, 0)
  textLabel4.BackgroundTransparency = 1
  textLabel4.Font = Enum.Font.GothamBold
  textLabel4.Text = string.upper(p7)
  textLabel4.TextColor3 = v1.YellowPrimary
  textLabel4.TextSize = 11
  textLabel4.TextXAlignment = Enum.TextXAlignment.Left
  textLabel4.Parent = frame12

  return frame12
end

local function f5(p8, text2, p9, p10, p11, p12)
  local frame13 = Instance.new("Frame")
  frame13.Size = UDim2.new(1, 0, 0, 48)
  frame13.BackgroundColor3 = v1.CardBg
  frame13.BorderSizePixel = 0
  frame13.Parent = p8.Scroll

  Instance.new("UICorner", frame13).CornerRadius = UDim.new(0, 6)
  Instance.new("UIStroke", frame13).Color = v1.Divider

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Size = UDim2.new(0.5, 0, 0, 18)
  textLabel5.Position = UDim2.new(0, 12, 0, 6)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Font = Enum.Font.GothamBold
  textLabel5.Text = text2
  textLabel5.TextColor3 = v1.TextPrimary
  textLabel5.TextSize = 12
  textLabel5.TextXAlignment = Enum.TextXAlignment.Left
  textLabel5.Parent = frame13

  local textLabel6 = Instance.new("TextLabel")
  textLabel6.Size = UDim2.new(0.5, -12, 0, 18)
  textLabel6.Position = UDim2.new(0.5, 0, 0, 6)
  textLabel6.BackgroundTransparency = 1
  textLabel6.Font = Enum.Font.GothamBold
  textLabel6.Text = tostring(p11)
  textLabel6.TextColor3 = v1.YellowPrimary
  textLabel6.TextSize = 11
  textLabel6.TextXAlignment = Enum.TextXAlignment.Right
  textLabel6.Parent = frame13

  local frame14 = Instance.new("Frame")
  frame14.Size = UDim2.new(1, -24, 0, 6)
  frame14.Position = UDim2.new(0, 12, 0, 32)
  frame14.BackgroundColor3 = v1.ControlBg
  frame14.BorderSizePixel = 0
  frame14.Parent = frame13

  Instance.new("UICorner", frame14).CornerRadius = UDim.new(1, 0)

  local frame15 = Instance.new("Frame")
  frame15.Size = UDim2.new((p11 - p9) / (p10 - p9), 0, 1, 0)
  frame15.BackgroundColor3 = v1.YellowAccent
  frame15.BorderSizePixel = 0
  frame15.Parent = frame14

  Instance.new("UICorner", frame15).CornerRadius = UDim.new(1, 0)
  local v6 = p11
  local v7 = false

  local function f6(p13)
    local v8 = math.clamp((p13 - frame14.AbsolutePosition.X) / frame14.AbsoluteSize.X, 0, 1)
    frame15.Size = UDim2.new(v8, 0, 1, 0)
    v6 = math.floor(p9 + v8 * (p10 - p9) + 0.5)
    textLabel6.Text = tostring(v6)

    if p12 then
      p12(v6)
    end
  end

  frame14.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
      v7 = true
      f6(input.Position.X)
    end
  end)

  userInputService.InputEnded:Connect(function(input2)
    if input2.UserInputType == Enum.UserInputType.MouseButton1 then
      v7 = false
    end
  end)

  userInputService.InputChanged:Connect(function(input3)
    if v7 and input3.UserInputType == Enum.UserInputType.MouseMovement then
      f6(input3.Position.X)
    end
  end)

  return {
    Set = function(p14)
      f6(frame14.AbsolutePosition.X + (p14 - p9) / (p10 - p9) * frame14.AbsoluteSize.X)
    end,
  }
end

local v9 = {}
local f7

local function f8()
  if f7 then
    f7()
  end
end

local function f9(p15, text3, p16)
  local frame16 = Instance.new("Frame")
  frame16.Size = UDim2.new(1, 0, 0, 40)
  frame16.BackgroundColor3 = v1.CardBg
  frame16.BorderSizePixel = 0
  frame16.Parent = p15.Scroll

  Instance.new("UICorner", frame16).CornerRadius = UDim.new(0, 6)
  Instance.new("UIStroke", frame16).Color = v1.Divider

  local textButton4 = Instance.new("TextButton")
  textButton4.Size = UDim2.new(1, -24, 0, 28)
  textButton4.Position = UDim2.new(0, 12, 0.5, -14)
  textButton4.BackgroundColor3 = v1.YellowDark
  textButton4.BorderSizePixel = 0
  textButton4.Font = Enum.Font.GothamBold
  textButton4.Text = text3
  textButton4.TextColor3 = v1.YellowPrimary
  textButton4.TextSize = 12
  textButton4.Parent = frame16

  Instance.new("UICorner", textButton4).CornerRadius = UDim.new(0, 5)

  textButton4.MouseEnter:Connect(function()
    tweenService:Create(textButton4, TweenInfo.new(0.12), {
      BackgroundColor3 = v1.YellowGlow,
      TextColor3 = v1.Background,
    }):Play()
  end)

  textButton4.MouseLeave:Connect(function()
    tweenService:Create(textButton4, TweenInfo.new(0.12), {
      BackgroundColor3 = v1.YellowDark,
      TextColor3 = v1.YellowPrimary,
    }):Play()
  end)

  textButton4.MouseButton1Click:Connect(p16)

  return textButton4
end

local v10

local function f10(p17)
  local textButton5 = Instance.new("TextButton")
  textButton5.Size = UDim2.new(0, 120, 1, -4)
  textButton5.BackgroundColor3 = v1.SidebarBg
  textButton5.BorderSizePixel = 0
  textButton5.Font = Enum.Font.GothamBold
  textButton5.Text = p17
  textButton5.TextColor3 = v1.TextMuted
  textButton5.TextSize = 12
  textButton5.AutoButtonColor = false
  textButton5.Parent = frame8

  Instance.new("UICorner", textButton5).CornerRadius = UDim.new(0, 5)

  local scrollingFrame = Instance.new("ScrollingFrame")
  scrollingFrame.Size = UDim2.new(1, -16, 1, -12)
  scrollingFrame.Position = UDim2.new(0, 8, 0, 6)
  scrollingFrame.BackgroundTransparency = 1
  scrollingFrame.BorderSizePixel = 0
  scrollingFrame.ScrollBarThickness = 3
  scrollingFrame.ScrollBarImageColor3 = v1.YellowDark
  scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
  scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
  scrollingFrame.Visible = false
  scrollingFrame.Parent = frame9

  local uiListLayout2 = Instance.new("UIListLayout")
  uiListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
  uiListLayout2.Padding = UDim.new(0, 6)
  uiListLayout2.Parent = scrollingFrame

  local uiPadding = Instance.new("UIPadding")
  uiPadding.PaddingTop = UDim.new(0, 4)
  uiPadding.PaddingBottom = UDim.new(0, 8)
  uiPadding.PaddingLeft = UDim.new(0, 4)
  uiPadding.PaddingRight = UDim.new(0, 8)
  uiPadding.Parent = scrollingFrame

  local v11 = {
    Name = p17,
    Button = textButton5,
    Scroll = scrollingFrame,
    Layout = uiListLayout2,
  }

  v9[p17] = v11

  local function f11()
    for key, value in pairs(v9) do
      value.Scroll.Visible = key == p17

      local button = value.Button
      button.BackgroundColor3 = key == p17 and v1.YellowDark or v1.SidebarBg

      local button2 = value.Button
      button2.TextColor3 = key == p17 and v1.YellowPrimary or v1.TextMuted
    end

    v10 = p17
  end

  textButton5.MouseEnter:Connect(function()
    if v10 ~= p17 then
      tweenService:Create(textButton5, TweenInfo.new(0.12), {
        BackgroundColor3 = v1.ControlBg,
        TextColor3 = v1.TextPrimary,
      }):Play()
    end
  end)

  textButton5.MouseLeave:Connect(function()
    if v10 ~= p17 then
      tweenService:Create(textButton5, TweenInfo.new(0.12), {
        BackgroundColor3 = v1.SidebarBg,
        TextColor3 = v1.TextMuted,
      }):Play()
    end
  end)

  textButton5.MouseButton1Click:Connect(f11)

  if not v10 then
    f11()
  end

  return v11
end

local function f12(p18, text4, p19, p20, p21)
  local frame17 = Instance.new("Frame")
  frame17.Size = UDim2.new(1, 0, 0, 44)
  frame17.BackgroundColor3 = v1.CardBg
  frame17.BorderSizePixel = 0
  frame17.Parent = p18.Scroll

  Instance.new("UICorner", frame17).CornerRadius = UDim.new(0, 6)
  Instance.new("UIStroke", frame17).Color = v1.Divider

  local textLabel7 = Instance.new("TextLabel")
  textLabel7.Size = UDim2.new(1, -140, 1, 0)
  textLabel7.Position = UDim2.new(0, 12, 0, 0)
  textLabel7.BackgroundTransparency = 1
  textLabel7.Font = Enum.Font.GothamBold
  textLabel7.Text = text4
  textLabel7.TextColor3 = v1.TextPrimary
  textLabel7.TextSize = 12
  textLabel7.TextXAlignment = Enum.TextXAlignment.Left
  textLabel7.Parent = frame17

  local textButton6 = Instance.new("TextButton")
  textButton6.Size = UDim2.new(0, 110, 0, 26)
  textButton6.Position = UDim2.new(1, -122, 0.5, -13)
  textButton6.BackgroundColor3 = v1.ControlBg
  textButton6.BorderSizePixel = 0
  textButton6.Font = Enum.Font.GothamBold
  textButton6.Text = tostring(p20) .. "  v"
  textButton6.TextColor3 = v1.YellowPrimary
  textButton6.TextSize = 11
  textButton6.Parent = frame17

  Instance.new("UICorner", textButton6).CornerRadius = UDim.new(0, 4)
  Instance.new("UIStroke", textButton6).Color = v1.Divider

  local v12 = p20
  local v13 = 1

  for index, value2 in ipairs(p19) do
    if value2 == p20 then
      v13 = index
      break
    end
  end

  textButton6.MouseButton1Click:Connect(function()
    v13 = v13 + 1

    if v13 > #p19 then
      v13 = 1
    end

    v12 = p19[v13]
    textButton6.Text = tostring(v12) .. "  v"

    if p21 then
      p21(v12)
    end
  end)

  return {
    Set = function(p22)
      for index2, value3 in ipairs(p19) do
        if value3 == p22 then
          v13 = index2
          break
        end
      end

      v12 = p22
      textButton6.Text = tostring(v12) .. "  v"
    end,
  }
end

getgenv().HotlineRefreshESP = f8
local main = f10("MAIN")
local visuals = f10("VISUALS")
local misc = f10("MISC")
f4(main, "Combat")

f2(main, "Silent Aim", parsaIntegratedSettings.SilentEnabled, function(silentEnabled)
  parsaIntegratedSettings.SilentEnabled = silentEnabled
end)

f2(main, "Wallbang", parsaIntegratedSettings.Wallbang, function(wallbang)
  parsaIntegratedSettings.Wallbang = wallbang
end)

f12(
  main, "Target Hitpart", { "Head", "UpperTorso", "LowerTorso" },
  parsaIntegratedSettings.HitPart,
  function(hitPart) parsaIntegratedSettings.HitPart = hitPart end
)

f2(main, "Show FOV", parsaIntegratedSettings.ShowFov, function(showFov)
  parsaIntegratedSettings.ShowFov = showFov
end)

f5(main, "FOV Radius", 10, 500, parsaIntegratedSettings.FOVRadius, function(fovRadius)
  parsaIntegratedSettings.FOVRadius = fovRadius
end)

f4(visuals, "ESP")

f2(visuals, "ESP Master", parsaIntegratedSettings.ESP, function(esp)
  parsaIntegratedSettings.ESP = esp
end)

f2(visuals, "Team Check", parsaIntegratedSettings.TeamCheck, function(teamCheck)
  parsaIntegratedSettings.TeamCheck = teamCheck
end)

f2(visuals, "Draw Boxes", parsaIntegratedSettings.ESPBoxes, function(espBoxes)
  parsaIntegratedSettings.ESPBoxes = espBoxes
end)

f2(visuals, "Draw Skeletons", parsaIntegratedSettings.ESPSkeletons, function(espSkeletons)
  parsaIntegratedSettings.ESPSkeletons = espSkeletons
end)

f2(visuals, "Display Names", parsaIntegratedSettings.ESPNames, function(espNames)
  parsaIntegratedSettings.ESPNames = espNames
end)

f2(visuals, "Display Health", parsaIntegratedSettings.ESPHealth, function(espHealth)
  parsaIntegratedSettings.ESPHealth = espHealth
end)

f2(visuals, "Display Distance", parsaIntegratedSettings.ESPDistance, function(espDistance)
  parsaIntegratedSettings.ESPDistance = espDistance
end)

f5(visuals, "Max Distance", 100, 5000, parsaIntegratedSettings.ESPMaxDistance, function(espMaxDistance)
  parsaIntegratedSettings.ESPMaxDistance = espMaxDistance
end)

f4(misc, "Utility")

f9(misc, "Refresh ESP", function() f8() end)
f9(misc, "Unload UI", function() hotlineUI:Destroy() end)

local v14 = false
local position, position2

frame.InputBegan:Connect(function(input4)
  if input4.UserInputType == Enum.UserInputType.MouseButton1 then
    v14 = true
    position = input4.Position
    position2 = mainFrame.Position

    input4.Changed:Connect(function()
      if input4.UserInputState == Enum.UserInputState.End then
        v14 = false
      end
    end)
  end
end)

frame.InputChanged:Connect(function(input5)
  if input5.UserInputType == Enum.UserInputType.MouseMovement and v14 then
    local v15 = input5.Position - position

    mainFrame.Position = UDim2.new(
      position2.X.Scale, position2.X.Offset + v15.X, position2.Y.Scale,
      position2.Y.Offset + v15.Y
    )
  end
end)

local v16 = false

textButton2.MouseButton1Click:Connect(function()
  v16 = not v16
  frame6.Visible = not v16
  frame9.Visible = not v16
  mainFrame.Size = v16 and UDim2.new(0, 620, 0, 40) or UDim2.new(0, 620, 0, 460)
  textButton2.Text = v16 and "+" or "-"
end)

textButton.MouseButton1Click:Connect(function() hotlineUI.Enabled = false end)

userInputService.InputBegan:Connect(function(input6, p23)
  if p23 then
    return
  end

  if input6.KeyCode == Enum.KeyCode.K then
    hotlineUI.Enabled = not hotlineUI.Enabled
  end
end)

local currentCamera = workspace.CurrentCamera

local v17 = getgenv()
v17.ParsaEspInstances = getgenv().ParsaEspInstances or {}

local parsaEspInstances = getgenv().ParsaEspInstances

local v18 = {
  { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" }, { "UpperTorso", "LeftUpperArm" },
  { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
  { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" },
  { "RightLowerArm", "RightHand" }, { "LowerTorso", "LeftUpperLeg" },
  { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
  { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" },
  { "RightLowerLeg", "RightFoot" },
}

local function f13(p24)
  if parsaEspInstances[p24] then
    return
  else
    local v19 = {
      BoxOutline = Drawing.new("Square"),
      Box = Drawing.new("Square"),
      Name = Drawing.new("Text"),
      Distance = Drawing.new("Text"),
      HealthOutline = Drawing.new("Square"),
      Health = Drawing.new("Square"),
      Bones = {},
    }

    v19.BoxOutline.Thickness = 2
    v19.BoxOutline.Filled = false
    v19.BoxOutline.Transparency = 0.5
    v19.BoxOutline.Color = parsaIntegratedSettings.OutlineColor
    v19.Box.Thickness = 1
    v19.Box.Filled = false
    v19.Box.Transparency = 1
    v19.Name.Center = true
    v19.Name.Outline = true
    v19.Name.Font = 2
    v19.Name.Size = 13
    v19.Name.Color = parsaIntegratedSettings.NameColor
    v19.Distance.Center = true
    v19.Distance.Outline = true
    v19.Distance.Font = 2
    v19.Distance.Size = 12
    v19.Distance.Color = parsaIntegratedSettings.DistanceColor
    v19.HealthOutline.Thickness = 1
    v19.HealthOutline.Filled = true
    v19.HealthOutline.Transparency = 0.5
    v19.HealthOutline.Color = parsaIntegratedSettings.OutlineColor
    v19.Health.Filled = true
    v19.Health.Transparency = 1

    for i = 1, 15 do
      local line = Drawing.new("Line")
      line.Thickness = 1
      line.Transparency = 1
      line.Visible = false

      table.insert(v19.Bones, line)
    end

    parsaEspInstances[p24] = v19
    return
  end
end

local v20 = {
  { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
  { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
}

local function f14(p25)
  local v21 = parsaEspInstances[p25]

  if v21 then
    for key2, value4 in pairs(v21) do
      if type(value4) == "table" then
        for key3, value5 in pairs(value4) do
          value5:Remove()
        end
      else
        value4:Remove()
      end
    end

    parsaEspInstances[p25] = nil
  end
end

getgenv().ParsaRemoveEsp = f14

function f7()
  for key4, value6 in pairs(parsaEspInstances) do
    f14(key4)
  end

  parsaEspInstances = {}
  getgenv().ParsaEspInstances = parsaEspInstances
end

runService.RenderStepped:Connect(function()
  currentCamera = workspace.CurrentCamera

  if not currentCamera then
    return
  else
    local v22 = f1(localPlayer)
    local position3 = currentCamera.CFrame.Position
    local v23, v24 = players:GetPlayers()

    for key5, value7 in next, v23, v24 do
      local v25 = parsaEspInstances[value7]

      if value7 == localPlayer then
        if v25 then
          f14(value7)
        end
      else
        local character2 = value7.Character

        local humanoid = character2
        humanoid = character2 and character2:FindFirstChildOfClass("Humanoid")

        local humanoidRootPart = character2
          and (character2:FindFirstChild("HumanoidRootPart")
            or character2:FindFirstChild("UpperTorso") or character2.PrimaryPart)

        local v26 = character2
          and (character2:GetAttribute("Dead") == true or humanoid and humanoid.Health <= 0)

        local v27 = f1(value7)
        local v28 = v22 ~= nil

        local v29 = v28
        v29 = v28 and v27 ~= nil and v22 == v27

        local esp2 = parsaIntegratedSettings.ESP and character2 and humanoidRootPart and not v26

        if esp2 and parsaIntegratedSettings.TeamCheck and v29 then
          esp2 = false
        end

        if esp2
          and (position3 - humanoidRootPart.Position).Magnitude
            > parsaIntegratedSettings.ESPMaxDistance then
          esp2 = false
        end

        if not esp2 then
          if v25 then
            for key6, value8 in pairs(v25) do
              if type(value8) ~= "table" then
                value8.Visible = false
              end
            end

            for key7, value9 in pairs(v25.Bones) do
              value9.Visible = false
            end
          end
        else
          if not v25 then
            f13(value7)
            v25 = parsaEspInstances[value7]
          end

          local boxColor = parsaIntegratedSettings.BoxColor
          local v30 = getgenv().ParsaTeamColors[v27 or ""]

          if v30 then
            boxColor = v30
          end

          local v31, v32 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)

          if v32 then
            local head = character2:FindFirstChild("Head")

            local worldToViewportPoint = head
            worldToViewportPoint = head and currentCamera:WorldToViewportPoint(head.Position)

            local worldToViewportPoint2 = worldToViewportPoint

            worldToViewportPoint2 = worldToViewportPoint
              or currentCamera:WorldToViewportPoint(humanoidRootPart.Position
                + Vector3.new(0, 2, 0))

            local v33 = currentCamera
            local vector = Vector3.new(0, 3, 0)

            local worldToViewportPoint3 = v33:WorldToViewportPoint(humanoidRootPart.Position
              - vector)

            local v34 = math.abs(worldToViewportPoint2.Y - worldToViewportPoint3.Y)
            local v35 = v34 / 1.6
            local v36 = v31.X - v35 / 2
            local y = worldToViewportPoint2.Y

            v25.Box.Visible = parsaIntegratedSettings.ESPBoxes
            v25.BoxOutline.Visible = parsaIntegratedSettings.ESPBoxes

            if parsaIntegratedSettings.ESPBoxes then
              local vector2 = Vector2.new(v35, v34)
              local vector3 = Vector2.new(v36, y)

              v25.Box.Size = vector2
              v25.Box.Position = vector3
              v25.Box.Color = boxColor
              v25.BoxOutline.Size = vector2
              v25.BoxOutline.Position = vector3
            end

            local v37 = character2:FindFirstChild("UpperTorso") ~= nil and v18 or v20

            for index3, value10 in ipairs(v25.Bones) do
              local v38 = v37[index3]

              if parsaIntegratedSettings.ESPSkeletons and v38 then
                local findFirstChild = character2:FindFirstChild(v38[1])
                local findFirstChild2 = character2:FindFirstChild(v38[2])

                if findFirstChild and findFirstChild2 then
                  local v39, v40 = currentCamera:WorldToViewportPoint(findFirstChild.Position)
                  local v41, v42 = currentCamera:WorldToViewportPoint(findFirstChild2.Position)

                  if v40 and v42 then
                    value10.From = Vector2.new(v39.X, v39.Y)
                    value10.To = Vector2.new(v41.X, v41.Y)
                    value10.Color = boxColor
                    value10.Visible = true
                  else
                    value10.Visible = false
                  end
                else
                  value10.Visible = false
                end
              else
                value10.Visible = false
              end
            end

            if parsaIntegratedSettings.ESPNames then
              v25.Name.Text = value7.Name
              v25.Name.Position = Vector2.new(v31.X, y - 15)
              v25.Name.Visible = true
            else
              v25.Name.Visible = false
            end

            if parsaIntegratedSettings.ESPDistance then
              local v43 = math.floor((position3 - humanoidRootPart.Position).Magnitude)

              v25.Distance.Text = tostring(v43) .. "m"
              v25.Distance.Position = Vector2.new(v31.X, y + v34 + 2)
              v25.Distance.Visible = true
            else
              v25.Distance.Visible = false
            end

            if parsaIntegratedSettings.ESPHealth and humanoid then
              local v44 = v36 - 4 - 2
              local v45 = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
              local v46 = v34 * v45
              local ffd700 = Color3.fromHex("#FFD700")

              v25.Health.Color = ffd700:Lerp(Color3.fromHex("#FF0000"), 1 - v45)
              v25.HealthOutline.Position = Vector2.new(v44 - 1, y - 1)
              v25.HealthOutline.Size = Vector2.new(4, v34 + 2)
              v25.Health.Position = Vector2.new(v44, y + (v34 - v46))
              v25.Health.Size = Vector2.new(2, v46)
              v25.Health.Visible = true
              v25.HealthOutline.Visible = true
            else
              v25.Health.Visible = false
              v25.HealthOutline.Visible = false
            end
          else
            for key8, value11 in pairs(v25) do
              if type(value11) ~= "table" then
                value11.Visible = false
              end
            end

            for key9, value12 in pairs(v25.Bones) do
              value12.Visible = false
            end
          end
        end
      end
    end

    return
  end
end)

players.PlayerRemoving:Connect(f14)

localPlayer.CharacterAdded:Connect(function()
  task.wait(1)
  f8()
end)

local circle = Drawing.new("Circle")
circle.Filled = false
circle.Thickness = 1.5
circle.NumSides = 64
circle.Color = parsaIntegratedSettings.FOVColor

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.IgnoreWater = true

local function f15(p26)
  if parsaIntegratedSettings.Wallbang then
    return true
  end

  if not p26 or not p26.Parent or not currentCamera then
    return false
  else
    raycastParams.FilterDescendantsInstances = localPlayer.Character
        and { localPlayer.Character }
      or {}

    local position4 = currentCamera.CFrame.Position
    local raycast = workspace:Raycast(position4, p26.Position - position4, raycastParams)

    if not raycast then
      return true
    else
      local model = raycast.Instance and raycast.Instance:FindFirstAncestorOfClass("Model")
      return model and players:GetPlayerFromCharacter(model) ~= nil
    end
  end
end

local function f16()
  if not parsaIntegratedSettings.SilentEnabled or not currentCamera or not localPlayer.Character then
    getgenv().ParsaSilentTarget = nil
    return
  else
    local v47 = f1(localPlayer)
    local v48 = currentCamera.ViewportSize / 2
    local huge = math.huge
    local parsaSilentTarget = nil
    local v49, v50 = players:GetPlayers()

    for key10, value13 in next, v49, v50 do
      if value13 == localPlayer then
      else
        local character3 = value13.Character

        if not character3 or character3:GetAttribute("Dead")
          or character3:GetAttribute("Invincible") then
        elseif character3.Parent and character3.Parent.Name == "Debris" then
        else
          local v51 = f1(value13)

          if v51 and v47 == v51 then
          else
            local findFirstChild3 = character3:FindFirstChild(parsaIntegratedSettings.HitPart)
              or character3:FindFirstChild("Head") or character3.PrimaryPart

            if not findFirstChild3 then
            else
              local v52, v53 = currentCamera:WorldToViewportPoint(findFirstChild3.Position)

              if v53 then
                local magnitude = (Vector2.new(v52.X, v52.Y) - v48).Magnitude

                if magnitude
                    <= (parsaIntegratedSettings.ShowFov and parsaIntegratedSettings.FOVRadius
                      or math.huge)
                  and magnitude < huge then
                  if parsaIntegratedSettings.Wallbang or f15(findFirstChild3) then
                    huge = magnitude
                    parsaSilentTarget = findFirstChild3
                  end
                end
              end
            end
          end
        end
      end
    end

    getgenv().ParsaSilentTarget = parsaSilentTarget
    return
  end
end

runService.RenderStepped:Connect(function()
  currentCamera = workspace.CurrentCamera

  if not currentCamera then
    circle.Visible = false
    return
  end

  circle.Visible = parsaIntegratedSettings.ShowFov

  if circle.Visible then
    circle.Position = currentCamera.ViewportSize / 2
    circle.Radius = parsaIntegratedSettings.FOVRadius
    circle.Color = parsaIntegratedSettings.FOVColor
  end

  f16()
end)

task.spawn(function()
  local v54 = typeof(hookfunction) ~= "function" or typeof(getgc) ~= "function"
  local v55

  if v54 then
    return
  else
    local v56 = nil
    local count = 0

    while true do
      count = 1 + count

      if not (count <= 45) then
        break
      end

      local v57, v58 = getgc(true)

      for key11, value14 in next, v57, v58 do
        if type(value14) == "table" and typeof(rawget(value14, "_performRaycast")) == "function"
          and rawget(value14, "getTrueSpread") ~= nil then
          v56 = value14
          break
        end
      end

      if v56 then
        break
      end

      task.wait(0.5)
    end

    if v56 then
      v55 = nil

      v55 = hookfunction(v56._performRaycast, function(...)
        local v59 = table.pack(v55(...))
        local v60 = v59[1]
        local parsaSilentTarget2 = getgenv().ParsaSilentTarget

        if parsaIntegratedSettings.SilentEnabled and parsaSilentTarget2 and type(v60) == "table" then
          pcall(function()
            local v61 = rawget(v60, "Hits")

            if type(v61) ~= "table" or not parsaSilentTarget2.Parent then
              return
            else
              local position5 = parsaSilentTarget2.Position
              local v62 = nil

              for key12, value15 in pairs(v61) do
                if type(value15) == "table" then
                  if v62 == nil or key12 > v62 then
                    v62 = key12
                  end
                end
              end

              local v63 = v62 and v61[v62]

              if type(v63) ~= "table" then
                return
              else
                v63.Instance = parsaSilentTarget2
                v63.Position = position5

                if v63.Exit ~= nil then
                  v63.Exit = false
                end

                local v64 = rawget(v60, "Origin")

                if typeof(v64) == "Vector3" then
                  local v65 = position5 - v64
                  local magnitude2 = v65.Magnitude

                  if magnitude2 > 0.001 then
                    v60.Distance = magnitude2
                    v60.Direction = v65.Unit

                    local unit = v65.Unit

                    for key13, value16 in pairs(v61) do
                      if key13 ~= v62 and type(value16) == "table"
                        and typeof(value16.Position) == "Vector3" then
                        if (value16.Position - v64):Dot(unit) > magnitude2 then
                          value16.Position = v64 + unit * (magnitude2 * 0.5)
                        end
                      end
                    end
                  end
                end

                return
              end
            end
          end)
        end

        return table.unpack(v59, 1, v59.n)
      end)
    end

    return
  end
end)
