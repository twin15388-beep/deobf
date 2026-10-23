local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local lighting = game:GetService("Lighting")
local runService = game:GetService("RunService")
local localPlayer = players.LocalPlayer

local v1 = {
  ESP = true,
  Tracers = true,
  Speed = false,
  SpeedValue = 30,
  SuperJump = false,
  JumpPower = 100,
}

local v2 = {
  Murderer = Color3.fromRGB(255, 55, 55),
  Sheriff = Color3.fromRGB(70, 145, 255),
  Innocent = Color3.fromRGB(70, 255, 105),
  Unknown = Color3.fromRGB(255, 210, 70),
}

local v3 = { "knife", "faca", "blade", "dagger", "sword", "murder" }
local v4 = { "gun", "pistol", "revolver", "weapon", "rifle", "sheriff" }
local v5 = {}

local function f1(p1, p2, p3)
  local create = tweenService:Create(p1, p2, p3)
  create:Play()
  return create
end

local tweenInfo = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo4 = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function f2(parent, p4)
  local uiCorner = Instance.new("UICorner")
  corner = uiCorner

  uiCorner.CornerRadius = UDim.new(0, p4 or 10)
  uiCorner.Parent = parent

  return uiCorner
end

local function f3(p5)
  local shadow = Instance.new("ImageLabel")
  shadow.Name = "Shadow"
  shadow.BackgroundTransparency = 1
  shadow.Image = "rbxassetid://1316045217"
  shadow.ImageTransparency = 0.35
  shadow.ScaleType = Enum.ScaleType.Slice
  shadow.SliceCenter = Rect.new(10, 10, 118, 118)
  shadow.Size = UDim2.new(1, 30, 1, 30)
  shadow.Position = UDim2.fromOffset(-15, -15)
  shadow.ZIndex = math.max(p5.ZIndex - 1, 0)
  shadow.Parent = p5

  return shadow
end

local function f4(parent2, p6, p7, p8)
  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = p6 or Color3.fromRGB(140, 80, 220)
  uiStroke.Transparency = p7 or 0.5
  uiStroke.Thickness = p8 or 1
  uiStroke.Parent = parent2

  return uiStroke
end

local function f5(p9, backgroundColor3, backgroundColor32)
  p9.AutoButtonColor = false
  f2(p9, 10)
  f4(p9, Color3.fromRGB(160, 105, 230), 0.78, 1)
  local size = p9.Size
  local position = p9.Position

  p9.MouseEnter:Connect(function()
    f1(p9, tweenInfo, {
      BackgroundColor3 = backgroundColor32,
      Size = UDim2.new(size.X.Scale, size.X.Offset + 2, size.Y.Scale, size.Y.Offset + 2),
      Position = UDim2.new(
        position.X.Scale, position.X.Offset - 1, position.Y.Scale, position.Y.Offset - 1
      ),
    })
  end)

  p9.MouseLeave:Connect(function()
    f1(p9, tweenInfo, { BackgroundColor3 = backgroundColor3, Size = size, Position = position })
  end)

  p9.MouseButton1Down:Connect(function()
    f1(p9, tweenInfo, {
      Size = UDim2.new(size.X.Scale, size.X.Offset - 2, size.Y.Scale, size.Y.Offset - 2),
    })
  end)

  p9.MouseButton1Up:Connect(function() f1(p9, tweenInfo, { Size = size }) end)
end

local function f6(parent3, p10, p11, p12)
  local uiGradient = Instance.new("UIGradient")

  uiGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, p10), ColorSequenceKeypoint.new(1, p11),
  })

  uiGradient.Rotation = p12 or 90
  uiGradient.Parent = parent3

  return uiGradient
end

local function f7()
  local character = localPlayer.Character

  if not character then
    return nil, nil, nil
  end

  return character, character:FindFirstChildOfClass("Humanoid"), (character:FindFirstChild("HumanoidRootPart"))
end

local function f8(p13)
  local v6 = {}
  local character2 = p13.Character

  if character2 then
    for index, value in ipairs(character2:GetChildren()) do
      if value:IsA("Tool") then
        table.insert(v6, value)
      end
    end
  end

  local backpack = p13:FindFirstChild("Backpack")

  if backpack then
    for index2, value2 in ipairs(backpack:GetChildren()) do
      if value2:IsA("Tool") then
        table.insert(v6, value2)
      end
    end
  end

  return v6
end

local function f9(p14)
  local v7 = v5[p14]

  if not v7 then
    return
  end

  if v7.Highlight then
    v7.Highlight:Destroy()
  end

  if v7.Billboard then
    v7.Billboard:Destroy()
  end

  if v7.TargetAttachment then
    v7.TargetAttachment:Destroy()
  end

  if v7.Beam then
    v7.Beam:Destroy()
  end

  v5[p14] = nil
end

local f10

local function f11(p15)
  local v8 = f8(p15)

  if #v8 == 0 then
    return "Innocent"
  else
    local v9 = false
    local v10 = false

    for index3, value3 in ipairs(v8) do
      if f10(value3.Name, v3) then
        v9 = true
      end

      if f10(value3.Name, v4) then
        v10 = true
      end
    end

    if v10 then
      return "Sheriff"
    end

    if v9 then
      return "Murderer"
    end

    return "Unknown"
  end
end

function f10(p16, p17)
  local v11 = string.lower(p16)

  for index4, value4 in ipairs(p17) do
    if string.find(v11, value4, 1, true) then
      return true
    end
  end

  return false
end

local function f12()
  local v12, v13, v14 = f7()

  if not v14 then
    return nil
  else
    local ksTracerOrigin = v14:FindFirstChild("KS_TracerOrigin")

    if not ksTracerOrigin then
      ksTracerOrigin = Instance.new("Attachment")
      ksTracerOrigin.Name = "KS_TracerOrigin"
      ksTracerOrigin.Parent = v14
    end

    return ksTracerOrigin
  end
end

local f13

local function f14(p18)
  if p18 == localPlayer then
    return
  elseif not v1.ESP then
    f9(p18)
    return
  else
    local character3 = p18.Character

    if not character3 then
      f9(p18)
      return
    else
      local humanoidRootPart = character3:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart then
        f9(p18)
        return
      else
        local v15 = v5[p18]

        if not v15 or v15.Character ~= character3 or v15.Root ~= humanoidRootPart then
          f13(p18)
          return
        else
          local v16 = f11(p18)
          local unknown = v2[v16] or v2.Unknown
          v15.Role = v16

          if v15.Highlight then
            v15.Highlight.FillColor = unknown
            v15.Highlight.OutlineColor = unknown
          end

          if v15.Text then
            v15.Text.Text = p18.DisplayName .. "\n[" .. v16 .. "]"
            v15.Text.TextColor3 = unknown
          end

          if v1.Tracers and v15.Beam then
            v15.Beam.Enabled = true
            v15.Beam.Color = ColorSequence.new(unknown)
          elseif v15.Beam then
            v15.Beam.Enabled = false
          end

          return
        end
      end
    end
  end
end

function f13(p19)
  if p19 == localPlayer then
    return
  else
    local character4 = p19.Character

    if not character4 then
      return
    else
      local humanoidRootPart2 = character4:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart2 then
        return
      else
        f9(p19)
        local v17 = f11(p19)
        local unknown2 = v2[v17] or v2.Unknown

        local ksMurderESP = Instance.new("Highlight")
        ksMurderESP.Name = "KS_MurderESP"
        ksMurderESP.Adornee = character4
        ksMurderESP.FillColor = unknown2
        ksMurderESP.OutlineColor = unknown2
        ksMurderESP.FillTransparency = 0.5
        ksMurderESP.OutlineTransparency = 0
        ksMurderESP.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        ksMurderESP.Parent = character4

        local ksMurderESPName = Instance.new("BillboardGui")
        ksMurderESPName.Name = "KS_MurderESP_Name"
        ksMurderESPName.Adornee = humanoidRootPart2
        ksMurderESPName.Size = UDim2.fromOffset(200, 55)
        ksMurderESPName.StudsOffset = Vector3.new(0, 3.2, 0)
        ksMurderESPName.AlwaysOnTop = true
        ksMurderESPName.Parent = humanoidRootPart2

        local roleText = Instance.new("TextLabel")
        roleText.Name = "RoleText"
        roleText.Size = UDim2.fromScale(1, 1)
        roleText.BackgroundTransparency = 1
        roleText.Text = p19.DisplayName .. "\n[" .. v17 .. "]"
        roleText.TextColor3 = unknown2
        roleText.TextStrokeTransparency = 0
        roleText.TextScaled = true
        roleText.Font = Enum.Font.GothamBold
        roleText.Parent = ksMurderESPName

        local ksTracerTarget = nil

        if v1.Tracers then
          ksTracerTarget = Instance.new("Attachment")
          ksTracerTarget.Name = "KS_TracerTarget"
          ksTracerTarget.Parent = humanoidRootPart2
        end

        local ksPlayerTracer = nil

        if ksTracerTarget then
          local v18 = f12()

          if v18 then
            ksPlayerTracer = Instance.new("Beam")
            ksPlayerTracer.Name = "KS_PlayerTracer"
            ksPlayerTracer.Attachment0 = v18
            ksPlayerTracer.Attachment1 = ksTracerTarget
            ksPlayerTracer.Color = ColorSequence.new(unknown2)
            ksPlayerTracer.Width0 = 0.08
            ksPlayerTracer.Width1 = 0.08
            ksPlayerTracer.FaceCamera = true
            ksPlayerTracer.LightEmission = 1
            ksPlayerTracer.Transparency = NumberSequence.new(0.15)
            ksPlayerTracer.Segments = 12
            ksPlayerTracer.Parent = humanoidRootPart2
          end
        end

        v5[p19] = {
          Character = character4,
          Root = humanoidRootPart2,
          Role = v17,
          Highlight = ksMurderESP,
          Billboard = ksMurderESPName,
          Text = roleText,
          TargetAttachment = ksTracerTarget,
          Beam = ksPlayerTracer,
        }

        return
      end
    end
  end
end

local function f15()
  for index5, value5 in ipairs(players:GetPlayers()) do
    if value5 ~= localPlayer then
      f14(value5)
    end
  end
end

local function f16(p20)
  if p20 == localPlayer then
    return
  end

  p20.CharacterAdded:Connect(function()
    task.wait(0.4)
    f14(p20)
  end)

  if p20.Character then
    task.defer(function() f14(p20) end)
  end
end

players.PlayerAdded:Connect(f16)
players.PlayerRemoving:Connect(function(player) f9(player) end)

for index6, value6 in ipairs(players:GetPlayers()) do
  f16(value6)
end

local function f17()
  local v19, v20 = f7()

  if not v20 then
    return
  end

  if v1.Speed then
    v20.WalkSpeed = v1.SpeedValue
  end
end

local function f18()
  local v21, v22 = f7()

  if not v22 then
    return
  end

  if v1.SuperJump then
    v22.UseJumpPower = true
    v22.JumpPower = v1.JumpPower
  end
end

local playerGui = localPlayer:WaitForChild("PlayerGui")
playerGui:FindFirstChild("KS_MurderHub")

local ksMurderHub = Instance.new("ScreenGui")
ksMurderHub.Name = "KS_MurderHub"
ksMurderHub.ResetOnSpawn = false
ksMurderHub.IgnoreGuiInset = true
ksMurderHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ksMurderHub.Parent = playerGui

local ksMurderHubBlur = Instance.new("BlurEffect")
ksMurderHubBlur.Name = "KS_MurderHub_Blur"
ksMurderHubBlur.Size = 0
ksMurderHubBlur.Parent = lighting

local loading = Instance.new("Frame")
loading.Name = "Loading"
loading.Size = UDim2.fromScale(1, 1)
loading.BackgroundColor3 = Color3.fromRGB(8, 6, 14)
loading.BorderSizePixel = 0
loading.ZIndex = 100
loading.Parent = ksMurderHub

f6(loading, Color3.fromRGB(16, 9, 27), Color3.fromRGB(7, 6, 12), 135)

local textLabel = Instance.new("TextLabel")
textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel.Position = UDim2.fromScale(0.5, 0.39)
textLabel.Size = UDim2.fromOffset(700, 70)
textLabel.BackgroundTransparency = 1
textLabel.Text = "KS HUB"
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextTransparency = 1
textLabel.TextSize = 48
textLabel.Font = Enum.Font.GothamBlack
textLabel.ZIndex = 101
textLabel.Parent = loading

local textLabel2 = Instance.new("TextLabel")
textLabel2.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel2.Position = UDim2.fromScale(0.5, 0.47)
textLabel2.Size = UDim2.fromOffset(700, 45)
textLabel2.BackgroundTransparency = 1
textLabel2.Text = "MURDER MYSTERY"
textLabel2.TextColor3 = Color3.fromRGB(181, 135, 245)
textLabel2.TextTransparency = 1
textLabel2.TextSize = 23
textLabel2.Font = Enum.Font.GothamBold
textLabel2.ZIndex = 101
textLabel2.Parent = loading

local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.55)
frame.Size = UDim2.fromOffset(0, 2)
frame.BackgroundColor3 = Color3.fromRGB(138, 74, 220)
frame.BorderSizePixel = 0
frame.ZIndex = 101
frame.Parent = loading

f4(frame, Color3.fromRGB(185, 130, 255), 0.35, 1)

local textLabel3 = Instance.new("TextLabel")
textLabel3.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel3.Position = UDim2.fromScale(0.5, 0.61)
textLabel3.Size = UDim2.fromOffset(400, 28)
textLabel3.BackgroundTransparency = 1
textLabel3.Text = "INITIALIZING..."
textLabel3.TextColor3 = Color3.fromRGB(185, 185, 195)
textLabel3.TextTransparency = 1
textLabel3.TextSize = 13
textLabel3.Font = Enum.Font.GothamMedium
textLabel3.ZIndex = 101
textLabel3.Parent = loading

local textLabel4 = Instance.new("TextLabel")
textLabel4.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel4.Position = UDim2.fromScale(0.5, 0.66)
textLabel4.Size = UDim2.fromOffset(500, 26)
textLabel4.BackgroundTransparency = 1
textLabel4.Text = "discord.gg/7Rkcbztcy8"
textLabel4.TextColor3 = Color3.fromRGB(145, 112, 200)
textLabel4.TextTransparency = 1
textLabel4.TextSize = 12
textLabel4.Font = Enum.Font.GothamMedium
textLabel4.ZIndex = 101
textLabel4.Parent = loading

local frame2 = Instance.new("Frame")
frame2.AnchorPoint = Vector2.new(0.5, 0.5)
frame2.Position = UDim2.fromScale(0.5, 0.72)
frame2.Size = UDim2.fromOffset(360, 5)
frame2.BackgroundColor3 = Color3.fromRGB(37, 28, 49)
frame2.BorderSizePixel = 0
frame2.ZIndex = 101
frame2.Parent = loading

f2(frame2, 10)

local frame3 = Instance.new("Frame")
frame3.Size = UDim2.new(0, 0, 1, 0)
frame3.BackgroundColor3 = Color3.fromRGB(152, 86, 233)
frame3.BorderSizePixel = 0
frame3.ZIndex = 102
frame3.Parent = frame2

f2(frame3, 10)
f6(frame3, Color3.fromRGB(110, 60, 190), Color3.fromRGB(196, 120, 255), 0)

local textLabel5 = Instance.new("TextLabel")
textLabel5.AnchorPoint = Vector2.new(0.5, 0.5)
textLabel5.Position = UDim2.fromScale(0.5, 0.77)
textLabel5.Size = UDim2.fromOffset(500, 30)
textLabel5.BackgroundTransparency = 1
textLabel5.Text = "COMPLETED"
textLabel5.TextColor3 = Color3.fromRGB(125, 255, 180)
textLabel5.TextTransparency = 1
textLabel5.TextSize = 13
textLabel5.Font = Enum.Font.GothamBold
textLabel5.ZIndex = 101
textLabel5.Parent = loading

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(530, 425)
main.Position = UDim2.new(0.5, -265, 0.5, -212)
main.BackgroundColor3 = Color3.fromRGB(10, 6, 16)
main.BackgroundTransparency = 1
main.BorderSizePixel = 0
main.Visible = false
main.ZIndex = 10
main.Parent = ksMurderHub

f2(main, 16)
local v23 = f4(main, Color3.fromRGB(167, 73, 255), 0.06, 2)
f3(main).ImageTransparency = 0.42

local frame4 = Instance.new("Frame")
frame4.Position = UDim2.fromOffset(18, 0)
frame4.Size = UDim2.new(1, -36, 0, 2)
frame4.BackgroundColor3 = Color3.fromRGB(172, 65, 255)
frame4.BorderSizePixel = 0
frame4.ZIndex = 20
frame4.Parent = main

f2(frame4, 4)

local frame5 = Instance.new("Frame")
frame5.Size = UDim2.new(1, 0, 0, 66)
frame5.BackgroundColor3 = Color3.fromRGB(78, 24, 145)
frame5.BorderSizePixel = 0
frame5.ZIndex = 11
frame5.Parent = main

f2(frame5, 16)

local frame6 = Instance.new("Frame")
frame6.Position = UDim2.fromOffset(0, 47)
frame6.Size = UDim2.new(1, 0, 0, 19)
frame6.BackgroundColor3 = Color3.fromRGB(66, 20, 122)
frame6.BorderSizePixel = 0
frame6.ZIndex = 11
frame6.Parent = frame5

local frame7 = Instance.new("Frame")
frame7.Position = UDim2.fromOffset(18, 65)
frame7.Size = UDim2.new(1, -36, 0, 1)
frame7.BackgroundColor3 = Color3.fromRGB(214, 176, 255)
frame7.BackgroundTransparency = 0.68
frame7.BorderSizePixel = 0
frame7.ZIndex = 12
frame7.Parent = frame5

local textLabel6 = Instance.new("TextLabel")
textLabel6.Position = UDim2.fromOffset(22, 7)
textLabel6.Size = UDim2.fromOffset(400, 31)
textLabel6.BackgroundTransparency = 1
textLabel6.Text = "KS HUB"
textLabel6.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel6.TextSize = 22
textLabel6.Font = Enum.Font.GothamBlack
textLabel6.TextXAlignment = Enum.TextXAlignment.Left
textLabel6.ZIndex = 12
textLabel6.Parent = frame5

local textLabel7 = Instance.new("TextLabel")
textLabel7.Position = UDim2.fromOffset(23, 37)
textLabel7.Size = UDim2.fromOffset(400, 18)
textLabel7.BackgroundTransparency = 1
textLabel7.Text = "MURDER MYSTERY"
textLabel7.TextColor3 = Color3.fromRGB(164, 124, 218)
textLabel7.TextSize = 10
textLabel7.Font = Enum.Font.GothamBold
textLabel7.TextXAlignment = Enum.TextXAlignment.Left
textLabel7.ZIndex = 12
textLabel7.Parent = frame5

local frame8 = Instance.new("Frame")
frame8.Position = UDim2.fromOffset(157, 43)
frame8.Size = UDim2.fromOffset(6, 6)
frame8.BackgroundColor3 = Color3.fromRGB(105, 255, 161)
frame8.BorderSizePixel = 0
frame8.ZIndex = 12
frame8.Parent = frame5

f2(frame8, 8)

local textButton = Instance.new("TextButton")
textButton.AnchorPoint = Vector2.new(1, 0.5)
textButton.Position = UDim2.new(1, -16, 0.5, 0)
textButton.Size = UDim2.fromOffset(96, 34)
textButton.BackgroundColor3 = Color3.fromRGB(94, 34, 157)
textButton.Text = "CREDITS"
textButton.TextColor3 = Color3.fromRGB(235, 229, 242)
textButton.TextSize = 10
textButton.Font = Enum.Font.GothamBold
textButton.BorderSizePixel = 0
textButton.ZIndex = 12
textButton.Parent = frame5

f5(textButton, Color3.fromRGB(94, 34, 157), Color3.fromRGB(126, 49, 205))

local function f19(p21, p22)
  local frame9 = Instance.new("Frame")
  frame9.Position = UDim2.fromOffset(18, p21)
  frame9.Size = UDim2.new(1, -36, 0, p22)
  frame9.BackgroundColor3 = Color3.fromRGB(15, 9, 23)
  frame9.BorderSizePixel = 0
  frame9.ZIndex = 11
  frame9.Parent = main

  f2(frame9, 12)
  f4(frame9, Color3.fromRGB(171, 87, 255), 0.52, 1)
  return frame9
end

local v24 = f19(82, 112)
local v25 = f19(206, 140)

local function f20(parent4, text)
  local textLabel8 = Instance.new("TextLabel")
  textLabel8.Position = UDim2.fromOffset(14, 10)
  textLabel8.Size = UDim2.new(1, -28, 0, 22)
  textLabel8.BackgroundTransparency = 1
  textLabel8.Text = text
  textLabel8.TextColor3 = Color3.fromRGB(220, 220, 224)
  textLabel8.TextSize = 11
  textLabel8.Font = Enum.Font.GothamBold
  textLabel8.TextXAlignment = Enum.TextXAlignment.Left
  textLabel8.ZIndex = 12
  textLabel8.Parent = parent4

  return textLabel8
end

f20(v24, "VISUAL")
f20(v25, "MOVEMENT")

local function f21(parent5, p23, p24, p25, p26, p27, fn)
  local textButton2 = Instance.new("TextButton")
  textButton2.Position = UDim2.fromOffset(p23, p24)
  textButton2.Size = UDim2.fromOffset(p25, 38)

  textButton2.BackgroundColor3 = p27 and Color3.fromRGB(108, 39, 177)
    or Color3.fromRGB(30, 25, 36)

  textButton2.BorderSizePixel = 0
  textButton2.TextColor3 = Color3.fromRGB(247, 247, 249)
  textButton2.TextSize = 11
  textButton2.Font = Enum.Font.GothamBold
  textButton2.AutoButtonColor = false
  textButton2.ZIndex = 12
  textButton2.Parent = parent5

  f2(textButton2, 9)

  local v26 = f4(
    textButton2, p27 and Color3.fromRGB(203, 119, 255) or Color3.fromRGB(255, 255, 255),
    p27 and 0.3 or 0.84, 1
  )

  local frame10 = Instance.new("Frame")
  frame10.AnchorPoint = Vector2.new(1, 0.5)
  frame10.Position = UDim2.new(1, -10, 0.5, 0)
  frame10.Size = UDim2.fromOffset(7, 7)

  frame10.BackgroundColor3 = p27 and Color3.fromRGB(100, 255, 165)
    or Color3.fromRGB(140, 140, 148)

  frame10.BorderSizePixel = 0
  frame10.ZIndex = 13
  frame10.Parent = textButton2

  f2(frame10, 10)
  local v27 = p27

  local function f22(p28)
    v27 = p28
    textButton2.Text = p26 .. "     " .. (p28 and "ON" or "OFF")

    f1(textButton2, tweenInfo, {
      BackgroundColor3 = p28 and Color3.fromRGB(108, 39, 177) or Color3.fromRGB(30, 25, 36),
    })

    f1(frame10, tweenInfo, {
      BackgroundColor3 = p28 and Color3.fromRGB(100, 255, 165) or Color3.fromRGB(140, 140, 148),
    })

    v26.Color = p28 and Color3.fromRGB(203, 119, 255) or Color3.fromRGB(255, 255, 255)
    v26.Transparency = p28 and 0.3 or 0.84
  end

  textButton2.MouseEnter:Connect(function()
    f1(textButton2, tweenInfo, {
      BackgroundColor3 = v27 and Color3.fromRGB(130, 48, 211) or Color3.fromRGB(43, 35, 51),
    })
  end)

  textButton2.MouseLeave:Connect(function() f22(v27) end)

  textButton2.MouseButton1Click:Connect(function()
    v27 = not v27
    f22(v27)
    fn(v27)
  end)

  f22(v27)
  return textButton2
end

f21(v24, 14, 42, 210, "PLAYER ESP", v1.ESP, function(esp)
  v1.ESP = esp
  f15()
end)

f21(v24, 238, 42, 210, "TRACERS", v1.Tracers, function(tracers)
  v1.Tracers = tracers

  for key in pairs(v5) do
    f9(key)
  end

  f15()
end)

local textLabel9 = Instance.new("TextLabel")
textLabel9.Position = UDim2.fromOffset(14, 86)
textLabel9.Size = UDim2.new(1, -28, 0, 18)
textLabel9.BackgroundTransparency = 1
textLabel9.Text = "● Murderer     ● Sheriff     ● Innocent"
textLabel9.TextColor3 = Color3.fromRGB(183, 183, 188)
textLabel9.TextSize = 10
textLabel9.Font = Enum.Font.GothamMedium
textLabel9.TextXAlignment = Enum.TextXAlignment.Left
textLabel9.ZIndex = 12
textLabel9.Parent = v24

local textLabel10 = Instance.new("TextLabel")
textLabel10.Position = UDim2.fromOffset(14, 86)
textLabel10.Size = UDim2.fromOffset(86, 18)
textLabel10.BackgroundTransparency = 1
textLabel10.Text = "● Murderer"
textLabel10.TextColor3 = v2.Murderer
textLabel10.TextSize = 10
textLabel10.Font = Enum.Font.GothamMedium
textLabel10.TextXAlignment = Enum.TextXAlignment.Left
textLabel10.ZIndex = 13
textLabel10.Parent = v24

local textLabel11 = Instance.new("TextLabel")
textLabel11.Position = UDim2.fromOffset(101, 86)
textLabel11.Size = UDim2.fromOffset(80, 18)
textLabel11.BackgroundTransparency = 1
textLabel11.Text = "● Sheriff"
textLabel11.TextColor3 = v2.Sheriff
textLabel11.TextSize = 10
textLabel11.Font = Enum.Font.GothamMedium
textLabel11.TextXAlignment = Enum.TextXAlignment.Left
textLabel11.ZIndex = 13
textLabel11.Parent = v24

local textLabel12 = Instance.new("TextLabel")
textLabel12.Position = UDim2.fromOffset(183, 86)
textLabel12.Size = UDim2.fromOffset(100, 18)
textLabel12.BackgroundTransparency = 1
textLabel12.Text = "● Innocent"
textLabel12.TextColor3 = v2.Innocent
textLabel12.TextSize = 10
textLabel12.Font = Enum.Font.GothamMedium
textLabel12.TextXAlignment = Enum.TextXAlignment.Left
textLabel12.ZIndex = 13
textLabel12.Parent = v24

textLabel9.Visible = false

local function f23(parent6, p29, p30, text2, p31)
  local textLabel13 = Instance.new("TextLabel")
  textLabel13.Position = UDim2.fromOffset(p29, p30 + 1)
  textLabel13.Size = UDim2.fromOffset(48, 34)
  textLabel13.BackgroundTransparency = 1
  textLabel13.Text = text2
  textLabel13.TextColor3 = Color3.fromRGB(178, 178, 185)
  textLabel13.TextSize = 10
  textLabel13.Font = Enum.Font.GothamBold
  textLabel13.TextXAlignment = Enum.TextXAlignment.Right
  textLabel13.ZIndex = 12
  textLabel13.Parent = parent6

  local textBox = Instance.new("TextBox")
  textBox.Position = UDim2.fromOffset(p29 + 58, p30)
  textBox.Size = UDim2.fromOffset(82, 36)
  textBox.BackgroundColor3 = Color3.fromRGB(22, 14, 31)
  textBox.BorderSizePixel = 0
  textBox.Text = tostring(p31)
  textBox.TextColor3 = Color3.fromRGB(248, 248, 250)
  textBox.TextSize = 12
  textBox.Font = Enum.Font.GothamBold
  textBox.ClearTextOnFocus = false
  textBox.ZIndex = 12
  textBox.Parent = parent6

  f2(textBox, 9)
  local v28 = f4(textBox, Color3.fromRGB(194, 113, 255), 0.62, 1)

  textBox.Focused:Connect(function()
    f1(textBox, tweenInfo, { BackgroundColor3 = Color3.fromRGB(37, 22, 51) })
    v28.Transparency = 0.26
  end)

  textBox.FocusLost:Connect(function()
    f1(textBox, tweenInfo, { BackgroundColor3 = Color3.fromRGB(22, 14, 31) })
    v28.Transparency = 0.62
  end)

  return textBox
end

f21(v25, 14, 42, 210, "SPEED", v1.Speed, function(speed)
  v1.Speed = speed

  if v1.Speed then
    f17()
  else
    local v29, v30 = f7()

    if v30 then
      v30.WalkSpeed = 16
    end
  end
end)

local v31 = f23(v25, 276, 43, "Value", 30)

v31.FocusLost:Connect(function()
  local v32 = tonumber(v31.Text)

  if v32 then
    v1.SpeedValue = math.clamp(v32, 0, 250)
    v31.Text = tostring(v1.SpeedValue)

    if v1.Speed then
      f17()
    end
  else
    v31.Text = tostring(v1.SpeedValue)
  end
end)

f21(v25, 14, 92, 210, "SUPER JUMP", v1.SuperJump, function(superJump)
  v1.SuperJump = superJump

  if v1.SuperJump then
    f18()
  else
    local v33, v34 = f7()

    if v34 then
      v34.UseJumpPower = true
      v34.JumpPower = 50
    end
  end
end)

local v35 = f23(v25, 276, 93, "Power", 100)

v35.FocusLost:Connect(function()
  local v36 = tonumber(v35.Text)

  if v36 then
    v1.JumpPower = math.clamp(v36, 50, 300)
    v35.Text = tostring(v1.JumpPower)

    if v1.SuperJump then
      f18()
    end
  else
    v35.Text = tostring(v1.JumpPower)
  end
end)

local creditsOverlay = Instance.new("Frame")
creditsOverlay.Name = "CreditsOverlay"
creditsOverlay.Size = UDim2.fromScale(1, 1)
creditsOverlay.BackgroundColor3 = Color3.fromRGB(7, 3, 15)
creditsOverlay.BackgroundTransparency = 1
creditsOverlay.Visible = false
creditsOverlay.ZIndex = 50
creditsOverlay.Parent = ksMurderHub

local frame11 = Instance.new("Frame")
frame11.AnchorPoint = Vector2.new(0.5, 0.5)
frame11.Position = UDim2.fromScale(0.5, 0.53)
frame11.Size = UDim2.fromOffset(390, 250)
frame11.BackgroundColor3 = Color3.fromRGB(22, 10, 36)
frame11.BorderSizePixel = 0
frame11.ZIndex = 51
frame11.Parent = creditsOverlay

f2(frame11, 16)
f4(frame11, Color3.fromRGB(197, 93, 255), 0.15, 2)
f3(frame11)
f6(frame11, Color3.fromRGB(53, 18, 86), Color3.fromRGB(17, 7, 27), 135)

local textLabel14 = Instance.new("TextLabel")
textLabel14.Position = UDim2.fromOffset(22, 20)
textLabel14.Size = UDim2.new(1, -44, 0, 28)
textLabel14.BackgroundTransparency = 1
textLabel14.Text = "KS HUB"
textLabel14.TextColor3 = Color3.new(1, 1, 1)
textLabel14.TextSize = 23
textLabel14.Font = Enum.Font.GothamBlack
textLabel14.TextXAlignment = Enum.TextXAlignment.Left
textLabel14.ZIndex = 52
textLabel14.Parent = frame11

local textLabel15 = Instance.new("TextLabel")
textLabel15.Position = UDim2.fromOffset(22, 49)
textLabel15.Size = UDim2.new(1, -44, 0, 20)
textLabel15.BackgroundTransparency = 1
textLabel15.Text = "Created by Kalebzin Studio"
textLabel15.TextColor3 = Color3.fromRGB(224, 187, 255)
textLabel15.TextSize = 12
textLabel15.Font = Enum.Font.GothamMedium
textLabel15.TextXAlignment = Enum.TextXAlignment.Left
textLabel15.ZIndex = 52
textLabel15.Parent = frame11

local frame12 = Instance.new("Frame")
frame12.Position = UDim2.fromOffset(22, 82)
frame12.Size = UDim2.new(1, -44, 0, 1)
frame12.BackgroundColor3 = Color3.fromRGB(139, 64, 198)
frame12.BorderSizePixel = 0
frame12.ZIndex = 52
frame12.Parent = frame11

local textLabel16 = Instance.new("TextLabel")
textLabel16.Position = UDim2.fromOffset(22, 100)
textLabel16.Size = UDim2.new(1, -44, 0, 20)
textLabel16.BackgroundTransparency = 1
textLabel16.Text = "DISCORD"
textLabel16.TextColor3 = Color3.fromRGB(210, 166, 246)
textLabel16.TextSize = 11
textLabel16.Font = Enum.Font.GothamBold
textLabel16.TextXAlignment = Enum.TextXAlignment.Left
textLabel16.ZIndex = 52
textLabel16.Parent = frame11

local textBox2 = Instance.new("TextBox")
textBox2.Position = UDim2.fromOffset(22, 127)
textBox2.Size = UDim2.new(1, -44, 0, 40)
textBox2.BackgroundColor3 = Color3.fromRGB(31, 12, 47)
textBox2.BorderSizePixel = 0
textBox2.Text = "discord.gg/7Rkcbztcy8"
textBox2.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox2.TextSize = 12
textBox2.Font = Enum.Font.GothamBold
textBox2.ClearTextOnFocus = false
textBox2.TextEditable = false
textBox2.ZIndex = 52
textBox2.Parent = frame11

f2(textBox2, 9)
f4(textBox2, Color3.fromRGB(173, 83, 239), 0.32, 1)

local textButton3 = Instance.new("TextButton")
textButton3.Position = UDim2.fromOffset(22, 178)
textButton3.Size = UDim2.fromOffset(160, 42)
textButton3.BackgroundColor3 = Color3.fromRGB(116, 39, 191)
textButton3.BorderSizePixel = 0
textButton3.Text = "COPY DISCORD"
textButton3.TextColor3 = Color3.new(1, 1, 1)
textButton3.TextSize = 12
textButton3.Font = Enum.Font.GothamBold
textButton3.ZIndex = 52
textButton3.Parent = frame11

f5(textButton3, Color3.fromRGB(116, 39, 191), Color3.fromRGB(154, 59, 238))

local textButton4 = Instance.new("TextButton")
textButton4.Position = UDim2.fromOffset(192, 178)
textButton4.Size = UDim2.fromOffset(160, 42)
textButton4.BackgroundColor3 = Color3.fromRGB(42, 20, 55)
textButton4.BorderSizePixel = 0
textButton4.Text = "CLOSE"
textButton4.TextColor3 = Color3.fromRGB(235, 230, 240)
textButton4.TextSize = 12
textButton4.Font = Enum.Font.GothamBold
textButton4.ZIndex = 52
textButton4.Parent = frame11

f5(textButton4, Color3.fromRGB(42, 20, 55), Color3.fromRGB(67, 31, 84))
local v37 = typeof(setclipboard) == "function"

textButton3.MouseButton1Click:Connect(function()
  local text3 = textButton3.Text
  textButton3.Text = v37 and "COPIED ✓" or "SELECT DISCORD"

  task.delay(1.35, function()
    if textButton3 and textButton3.Parent then
      textButton3.Text = text3
    end
  end)
end)

textButton.MouseButton1Click:Connect(function()
  creditsOverlay.Visible = true

  frame11.Size = UDim2.fromOffset(360, 225)
  frame11.Position = UDim2.fromScale(0.5, 0.55)

  f1(creditsOverlay, tweenInfo4, { BackgroundTransparency = 0.12 })

  f1(frame11, tweenInfo3, {
    Size = UDim2.fromOffset(390, 250),
    Position = UDim2.fromScale(0.5, 0.5),
  })
end)

textButton4.MouseButton1Click:Connect(function()
  f1(creditsOverlay, tweenInfo4, { BackgroundTransparency = 1 })

  f1(frame11, tweenInfo, {
    Size = UDim2.fromOffset(360, 225),
    Position = UDim2.fromScale(0.5, 0.55),
  })

  task.delay(0.18, function()
    if creditsOverlay and creditsOverlay.Parent then
      creditsOverlay.Visible = false
    end
  end)
end)

local v38 = { v23 }
local v39 = { frame4 }
local uiStroke2 = frame11:FindFirstChildOfClass("UIStroke")

if uiStroke2 then
  table.insert(v38, uiStroke2)
end

local total = 0

runService.RenderStepped:Connect(function(delta)
  total = total + delta * 0.55
  local v40 = (0.76 + math.sin(total) * 0.09) % 1
  local color = Color3.fromHSV(v40, 0.78, 1)
  local color2 = Color3.fromHSV((v40 + 0.1) % 1, 0.78, 1)

  for index7, value7 in ipairs(v38) do
    if value7 and value7.Parent then
      value7.Color = color
      value7.Transparency = 0.12 + (math.sin(total * 1.7) + 1) * 0.08
    end
  end

  for index8, value8 in ipairs(v39) do
    if value8 and value8.Parent then
      value8.BackgroundColor3 = color2
    end
  end
end)

local v41 = false
local position2, position3

frame5.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
    v41 = true
    position2 = input.Position
    position3 = main.Position
  end
end)

frame5.InputEnded:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseButton1 then
    v41 = false
  end
end)

userInputService.InputChanged:Connect(function(input3)
  if v41 and input3.UserInputType == Enum.UserInputType.MouseMovement then
    local v42 = input3.Position - position2

    main.Position = UDim2.new(
      position3.X.Scale, position3.X.Offset + v42.X, position3.Y.Scale,
      position3.Y.Offset + v42.Y
    )
  end
end)

localPlayer.CharacterAdded:Connect(function()
  task.wait(0.7)
  f17()
  f18()
  task.defer(f15)
end)

task.spawn(function()
  f1(ksMurderHubBlur, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = 16,
  })

  f1(textLabel, tweenInfo2, { TextTransparency = 0 })

  task.wait(0.12)
  f1(textLabel2, tweenInfo2, { TextTransparency = 0 })
  task.wait(0.1)

  f1(textLabel3, tweenInfo2, { TextTransparency = 0 })
  f1(textLabel4, tweenInfo2, { TextTransparency = 0 })

  f1(frame, TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(300, 2),
  })

  local v43 = {
    "INITIALIZING...", "LOADING PLAYER ESP...", "LOADING TRACERS...", "LOADING MOVEMENT...",
    "FINALIZING...",
  }

  for index9, value9 in ipairs(v43) do
    textLabel3.Text = value9

    f1(frame3, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
      Size = UDim2.new(index9 / #v43, 0, 1, 0),
    })

    task.wait(0.65)
  end

  textLabel3.Text = "READY"
  f1(textLabel5, tweenInfo2, { TextTransparency = 0 })
  task.wait(0.55)

  main.Visible = true
  main.Position = UDim2.new(0.5, -265, 0.52, -212)

  f1(main, tweenInfo3, {
    Position = UDim2.new(0.5, -265, 0.5, -212),
    BackgroundTransparency = 0,
  })

  task.wait(0.18)

  f1(loading, tweenInfo4, { BackgroundTransparency = 1 })

  f1(ksMurderHubBlur, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = 0,
  })

  task.wait(0.45)
  loading.Visible = false

  if ksMurderHubBlur and ksMurderHubBlur.Parent then
    ksMurderHubBlur:Destroy()
  end
end)

task.spawn(function()
  while ksMurderHub.Parent do
    task.wait(0.3)
    f15()
  end
end)

print("[KS HUB] Murder Mystery carregado.")
