local players = game:GetService("Players")
local runService = game:GetService("RunService")
local virtualInputManager = game:GetService("VirtualInputManager")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local coreGui = game:GetService("CoreGui")
local novaUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pitaya-real/PitayaUI/refs/heads/main/NovaUI.lua"))()
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera

local v1 = {
  GOAL_DETECTION_DIST = 70,
  BALL_SAVE_DIST = 35,
  PREDICTION_TIME = 0.32,
  COOLDOWN = 1,
  LEFT_RIGHT_THRESHOLD = 2,
  HIGH_SHOT_THRESHOLD = 2.5,
  CATCH_RADIUS = 4.5,
  POSITIONING_DIST = 45,
  MIN_BALL_SPEED = 6,
  GRAVITY = 196.2,
  MAGNET_PULL_SPEED = 85,
  OWNER_SAFE_RADIUS = 2.8,
}

local v2 = false
local v3 = true
local v4 = false
local v5 = false
local v6 = true
local v7 = false
local v8 = false
local v9 = false
local v10 = false
local v11 = nil
local v12 = 0
local zero = Vector3.zero
local touchEnabled = userInputService.TouchEnabled and not userInputService.KeyboardEnabled

local window = novaUI:CreateWindow({
  Title = "Smart GK System",
  SubTitle = "PITAYA REAL | BETA",
  Logo = "73866843639743",
  FloatingIcon = "73866843639743",
  Size = UDim2.fromOffset(620, 420),
  Accent = Color3.fromRGB(167, 139, 250),
  MinimizeKey = Enum.KeyCode.RightControl,
  Acrylic = true,
})

local folder

if gethui then
  folder = gethui()
elseif syn and syn.protect_gui then
  folder = Instance.new("Folder")
  syn.protect_gui(folder)
  folder.Parent = coreGui
else
  do
    local v13
    v13, v220 = pcall(function() end)

    if v13 or false then
      folder = coreGui
    else
      folder = localPlayer:WaitForChild("PlayerGui")
    end
  end
end

local smartGKMobileControlsProtect = Instance.new("ScreenGui")
smartGKMobileControlsProtect.Name = "SmartGKMobileControls_Protect"
smartGKMobileControlsProtect.ResetOnSpawn = false
smartGKMobileControlsProtect.DisplayOrder = 9999
smartGKMobileControlsProtect.Parent = folder

if not touchEnabled or false then
  smartGKMobileControlsProtect.Enabled = false
end

local v14 = {}

local function f1(name, text, position, size, backgroundColor3, p1, onRelease)
  local frame = Instance.new("Frame")
  frame.Name = name
  frame.Size = size
  frame.Position = position
  frame.BackgroundColor3 = backgroundColor3
  frame.BackgroundTransparency = 0.3
  frame.ZIndex = 60
  frame.Parent = smartGKMobileControlsProtect

  local uiCorner = Instance.new("UICorner")
  uiCorner.CornerRadius = UDim.new(1, 0)
  uiCorner.Parent = frame

  local uiStroke = Instance.new("UIStroke")
  uiStroke.Color = Color3.fromRGB(255, 255, 255)
  uiStroke.Thickness = 2
  uiStroke.Transparency = 0.3
  uiStroke.Parent = frame

  local textLabel = Instance.new("TextLabel")
  textLabel.Size = UDim2.new(1, 0, 1, 0)
  textLabel.BackgroundTransparency = 1
  textLabel.Text = text
  textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  textLabel.TextSize = 13
  textLabel.Font = Enum.Font.SourceSansBold
  textLabel.ZIndex = 61
  textLabel.Parent = frame

  frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
      or input.UserInputType == Enum.UserInputType.MouseButton1 then
      v14[input] = { btn = frame, onRelease = onRelease }

      if p1 or false then
        p1(frame)
      end
    end
  end)

  return frame
end

userInputService.InputEnded:Connect(function(input2)
  if v14[input2] then
    do
      local v16 = v14[input2]

      if v16.onRelease then
        v16.onRelease(v16.btn)
      end
    end

    do
      v14[input2] = nil
    end
  end
end)

f1("ShiftBtn", "Shift", UDim2.new(0.58, 0, 0.68, 0), UDim2.new(0, 58, 0, 58), Color3.fromRGB(200, 100, 30), function(p2)
  do
    v10 = not v10
    p2.BackgroundColor3 = v10 and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 100, 30)
  end

  do
    virtualInputManager:SendKeyEvent(v10, Enum.KeyCode.LeftShift, false, game)
  end
end, nil)

f1(
  "JumpBtn", "Nhảy", UDim2.new(0.85, 0, 0.65, 0), UDim2.new(0, 68, 0, 68),
  Color3.fromRGB(40, 40, 40),
  function() virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game) end,
  function() virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game) end
)

f1(
  "DiveBtn", "Bay người", UDim2.new(0.72, 0, 0.68, 0), UDim2.new(0, 64, 0, 64),
  Color3.fromRGB(30, 30, 30),
  function() virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game) end,
  function() virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game) end
)

f1(
  "ShootBtn", "Sút", UDim2.new(0.74, 0, 0.45, 0), UDim2.new(0, 58, 0, 58),
  Color3.fromRGB(30, 30, 30),
  function() virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) end,
  function() virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0) end
)

f1(
  "PassBtn", "Chuyền", UDim2.new(0.85, 0, 0.42, 0), UDim2.new(0, 58, 0, 58),
  Color3.fromRGB(30, 30, 30),
  function() virtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0) end,
  function() virtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0) end
)

local zero2 = Vector2.zero
local v18 = nil

local joystickBase = Instance.new("ImageButton")
joystickBase.Name = "JoystickBase"
joystickBase.Size = UDim2.new(0, 130, 0, 130)
joystickBase.Position = UDim2.new(0.05, 0, 0.52, 0)
joystickBase.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
joystickBase.BackgroundTransparency = 0.5
joystickBase.ZIndex = 60
joystickBase.Active = true
joystickBase.Modal = true
joystickBase.AutoButtonColor = false
joystickBase.Image = ""
joystickBase.Parent = smartGKMobileControlsProtect

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(1, 0)
uiCorner2.Parent = joystickBase

local uiStroke2 = Instance.new("UIStroke")
uiStroke2.Color = Color3.fromRGB(255, 255, 255)
uiStroke2.Thickness = 2
uiStroke2.Transparency = 0.4
uiStroke2.Parent = joystickBase

local joystickThumb = Instance.new("Frame")
joystickThumb.Name = "JoystickThumb"
joystickThumb.Size = UDim2.new(0, 50, 0, 50)
joystickThumb.Position = UDim2.new(0.5, -25, 0.5, -25)
joystickThumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
joystickThumb.BackgroundTransparency = 0.2
joystickThumb.ZIndex = 61
joystickThumb.Parent = joystickBase

local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(1, 0)
uiCorner3.Parent = joystickThumb

local function f2()
  v18 = nil
  zero2 = Vector2.zero
  joystickThumb.Position = UDim2.new(0.5, -25, 0.5, -25)
end

joystickBase.InputBegan:Connect(function(input3)
  if (input3.UserInputType == Enum.UserInputType.Touch
      or input3.UserInputType == Enum.UserInputType.MouseButton1)
    and not v18 then
    v18 = input3
  end
end)

userInputService.InputChanged:Connect(function(input4)
  if v18 and (input4 == v18 or input4.UserInputType == Enum.UserInputType.MouseMovement) then
    local v19 = joystickBase.AbsolutePosition + joystickBase.AbsoluteSize / 2
    local v20 = Vector2.new(input4.Position.X, input4.Position.Y) - v19
    local v21 = joystickBase.AbsoluteSize.X / 2

    if v20.Magnitude > v21 or false then
      v20 = v20.Unit * v21
    end

    joystickThumb.Position = UDim2.new(0.5, v20.X - 25, 0.5, v20.Y - 25)
    zero2 = v20 / v21
  end
end)

userInputService.InputEnded:Connect(function(input5)
  if input5 == v18 or input5.UserInputType == Enum.UserInputType.MouseButton1 or false then
    f2()
  end
end)

local v22 = {
  GK = window:AddTab({ Title = "Smart GK", Icon = "⚽" }),
  Visual = window:AddTab({ Title = "Hiển Thị", Icon = "👁️" }),
  Controls = window:AddTab({ Title = "Điều Khiển", Icon = "🎮" }),
}

local options = novaUI.Options

v22.GK:AddSection("Tự Động Thủ Môn")
v22.GK:AddToggle("AutoSave", { Title = "Tự Động Bắt Bóng (Auto Save)", Default = false })

options.AutoSave:OnChanged(function(p3)
  do
    v2 = p3

    novaUI:Notify({
      Title = "Smart GK",
      Content = "Auto Save: " .. (p3 and "ĐÃ BẬT" or "ĐÃ TẮT"),
      Duration = 2,
    })
  end
end)

v22.GK:AddToggle("AutoMagnet", {
  Title = "Tự Động Hút Bóng Nguy Hiểm (Magnet)",
  Default = true,
})

options.AutoMagnet:OnChanged(function(p4)
  v3 = p4

  novaUI:Notify({
    Title = "Smart GK",
    Content = "Hút Bóng: " .. (p4 and "ĐÃ BẬT" or "ĐÃ TẮT"),
    Duration = 2,
  })
end)

v22.GK:AddToggle("AutoPosition", {
  Title = "Tự Động Khép Góc Khung Thành",
  Default = false,
})

options.AutoPosition:OnChanged(function(p5)
  do
    v5 = p5

    novaUI:Notify({
      Title = "Smart GK",
      Content = "Tự Khép Góc: " .. (p5 and "ĐÃ BẬT" or "ĐÃ TẮT"),
      Duration = 2,
    })
  end
end)

v22.GK:AddToggle("CameraTrack", {
  Title = "Khóa Camera Vào Bóng (Cam Lock)",
  Default = false,
})

options.CameraTrack:OnChanged(function(p6)
  v4 = p6

  novaUI:Notify({
    Title = "Smart GK",
    Content = "Cam Lock: " .. (p6 and "ĐÃ BẬT" or "ĐÃ TẮT"),
    Duration = 2,
  })
end)

v22.Visual:AddSection("ESP Tinh Gọn (Minimalist)")

v22.Visual:AddToggle("EspBall", {
  Title = "ESP Trái Bóng (Mini Ball Marker)",
  Default = false,
})

options.EspBall:OnChanged(function(p7)
  do
    v7 = p7

    novaUI:Notify({
      Title = "ESP",
      Content = "ESP Bóng: " .. (p7 and "ĐÃ BẬT" or "ĐÃ TẮT"),
      Duration = 2,
    })
  end
end)

v22.Visual:AddToggle("EspPlayers", {
  Title = "ESP Cầu Thủ (Leaderboard Team ESP)",
  Default = false,
})

options.EspPlayers:OnChanged(function(p8)
  do
    v8 = p8

    novaUI:Notify({
      Title = "ESP",
      Content = "ESP Cầu Thủ: " .. (p8 and "ĐÃ BẬT" or "ĐÃ TẮT"),
      Duration = 2,
    })
  end
end)

v22.Controls:AddSection("Phím Tắt Ảo Mobile")

v22.Controls:AddToggle("MobileControls", {
  Title = "Hiển Thị Nút Điều Khiển Mobile",
  Default = touchEnabled,
})

options.MobileControls:OnChanged(function(p9)
  v6 = p9
  smartGKMobileControlsProtect.Enabled = p9 and touchEnabled

  if not p9 then
    f2()
  end
end)

v22.Controls:AddButton({
  Title = "Reset Vị Trí Joystick",
  ButtonText = "Reset",
  Callback = function()
    f2()

    novaUI:Notify({
      Title = "Hệ Thống",
      Content = "Đã đặt lại Joystick!",
      Duration = 2,
    })
  end,
})

window:SelectTab(1)

task.spawn(function()
  local playerGui
  local v24

  do
    playerGui = localPlayer:WaitForChild("PlayerGui")
    v24 = nil
  end

  do
    function v24()
      for index, value in ipairs(playerGui:GetChildren()) do
        if value:IsA("ScreenGui") and not value.Name:find("Protect") and value.Name ~= "NovaUI" then
          for index2, value2 in ipairs(value:GetDescendants()) do
            if value2:IsA("GuiObject") then
              local lower = value2.Name:lower()

              if lower:find("key") or lower:find("bind") or lower:find("pc")
                or lower:find("control") then
                value2.Visible = false
              end
            end
          end
        end
      end
    end

    v24()
  end

  do
    playerGui.ChildAdded:Connect(function()
      task.wait(0.3)
      v24()
    end)
  end
end)

local function f3(p10)
  do
    if not p10 then
      return nil
    end

    if p10:IsA("BasePart") then
      return p10.Position
    elseif p10:IsA("Model") or false then
      return p10.PrimaryPart and p10.PrimaryPart.Position or p10:GetPivot().Position
    end
  end

  do
    return nil
  end
end

local function f4(p11)
  do
    if not p11 then
      return nil
    end

    if p11:IsA("BasePart") then
      return p11
    end
  end

  do
    if p11:IsA("Model") then
      return p11.PrimaryPart or p11:FindFirstChildWhichIsA("BasePart") or p11
    end

    return nil
  end
end

local function f5()
  local misc = workspace:FindFirstChild("Misc")

  if misc then
    do
      local visuals = misc:FindFirstChild("Visuals")

      if visuals then
        local clientBallMainMatch = visuals:FindFirstChild("ClientBall_MainMatch")

        if clientBallMainMatch then
          return clientBallMainMatch
        end

        return visuals:FindFirstChildWhichIsA("BasePart")
      end
    end
  end

  return nil
end

local function f6(p12)
  do
    if not p12 then
      return false
    end

    for index3, value3 in ipairs(players:GetPlayers()) do
      if value3 ~= localPlayer and value3.Character then
        do
          local humanoidRootPart = value3.Character:FindFirstChild("HumanoidRootPart")
            or value3.Character:FindFirstChild("Right Foot")
            or value3.Character:FindFirstChild("Left Foot")

          if humanoidRootPart then
            do
              if (p12 - humanoidRootPart.Position).Magnitude <= v1.OWNER_SAFE_RADIUS then
                return false
              end
            end
          end
        end
      end
    end
  end

  do
    return true
  end
end

local function f7(p13, p14, p15)
  local v29

  do
    v29 = f4(p13)

    if not v29 then
      return
    end
  end

  do
    if v29:IsA("BasePart") then
      local v31

      do
        v31 = p14 - v29.Position
      end

      do
        local magnitude = v31.Magnitude

        if magnitude > 0.5 or false then
          v29.AssemblyLinearVelocity = v31.Unit * math.min(magnitude * 25, v1.MAGNET_PULL_SPEED)
        end
      end
    end
  end
end

local function f8(p16)
  do
    if not p16 then
      return nil
    end

    if p16.Team then
      return p16.Team.Name
    end
  end

  do
    local leaderstats = p16:FindFirstChild("leaderstats")

    if leaderstats or false then
      do
        local team = leaderstats:FindFirstChild("Team") or leaderstats:FindFirstChild("Đội")

        if team or false then
          return tostring(team.Value)
        end
      end
    end
  end

  do
    local teamValue = p16:FindFirstChild("TeamValue") or p16:FindFirstChild("TeamName")

    if teamValue then
      return tostring(teamValue.Value)
    end
  end

  do
    return "NoTeam"
  end
end

local function f9()
  local character = localPlayer.Character

  if not character or false then
    return nil
  end

  local v33 = f3(character:FindFirstChild("HumanoidRootPart"))

  if not v33 then
    return nil
  end

  local map = workspace:FindFirstChild("Map")

  if not map or not map:FindFirstChild("Data") then
    return nil
  end

  local v34 = nil
  local goalDETECTIONDIST = v1.GOAL_DETECTION_DIST

  for index4, value4 in ipairs({ "Team1", "Team2" }) do
    do
      local findFirstChild = map.Data:FindFirstChild(value4)

      if findFirstChild or false then
        do
          local goalMesh = findFirstChild:FindFirstChild("GoalMesh")
            or findFirstChild:FindFirstChild("Goal")
            or findFirstChild:FindFirstChild("Goalkeeper")

          if goalMesh then
            do
              local v35 = f3(goalMesh)

              if v35 then
                do
                  local magnitude2 = (v33 - v35).Magnitude

                  if magnitude2 < goalDETECTIONDIST then
                    do
                      goalDETECTIONDIST = magnitude2
                      v34 = goalMesh
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  return v34
end

local function f10(p17, p18, p19, p20, p21)
  if v9 then
    return
  end

  v9 = true

  task.spawn(function()
    local character2 = localPlayer.Character
    local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart2 then
      humanoidRootPart2.CFrame = CFrame.new(humanoidRootPart2.Position, Vector3.new(
        p17.X, humanoidRootPart2.Position.Y, p17.Z
      ))
    end

    if p21 then
      if p20 then
        do
          virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
          task.wait(0.03)
        end

        do
          virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end
      end

      virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
      task.wait(0.05)
      virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
      task.wait(0.4)
      v9 = false
      return
    end

    if p20 then
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
      task.wait(0.03)
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
      task.wait(0.03)
    end

    local a = nil

    if p18 then
      a = Enum.KeyCode.A
    elseif p19 or false then
      a = Enum.KeyCode.D
    end

    if a or false then
      virtualInputManager:SendKeyEvent(true, a, false, game)
      task.wait(0.02)
    end

    virtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
    task.wait(0.05)
    virtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)

    if a then
      do
        task.wait(0.03)
        virtualInputManager:SendKeyEvent(false, a, false, game)
      end
    end

    task.wait(v1.COOLDOWN)
    v9 = false
  end)
end

local function f11(p22)
  local cleanPlayerESP = Instance.new("BillboardGui")
  cleanPlayerESP.Name = "CleanPlayerESP"
  cleanPlayerESP.AlwaysOnTop = true
  cleanPlayerESP.Size = UDim2.new(0, 100, 0, 24)
  cleanPlayerESP.ExtentsOffset = Vector3.new(0, 2.5, 0)

  local espLabel = Instance.new("TextLabel")
  espLabel.Name = "ESPLabel"
  espLabel.Size = UDim2.new(1, 0, 1, 0)
  espLabel.BackgroundTransparency = 1
  espLabel.Text = p22.DisplayName .. "\n[0m]"
  espLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  espLabel.Font = Enum.Font.GothamBold
  espLabel.TextSize = 10
  espLabel.TextStrokeTransparency = 0.2
  espLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
  espLabel.Parent = cleanPlayerESP

  return cleanPlayerESP
end

local function f12()
  local cleanBallESP
  local ballLabel

  do
    cleanBallESP = Instance.new("BillboardGui")
    cleanBallESP.Name = "CleanBallESP"
    cleanBallESP.AlwaysOnTop = true
  end

  do
    cleanBallESP.Size = UDim2.new(0, 80, 0, 20)
    cleanBallESP.ExtentsOffset = Vector3.new(0, 1.8, 0)
    ballLabel = Instance.new("TextLabel")
  end

  do
    ballLabel.Name = "BallLabel"
    ballLabel.Size = UDim2.new(1, 0, 1, 0)
    ballLabel.BackgroundTransparency = 1
  end

  do
    ballLabel.Text = "⚽ BÓNG [0m]"
    ballLabel.TextColor3 = Color3.fromRGB(255, 220, 50)
    ballLabel.Font = Enum.Font.GothamBold
  end

  do
    ballLabel.TextSize = 11
    ballLabel.TextStrokeTransparency = 0.2
    ballLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
  end

  do
    ballLabel.Parent = cleanBallESP
    return cleanBallESP
  end
end

runService.Heartbeat:Connect(function()
  local character3 = localPlayer.Character
  local humanoidRootPart3 = character3 and character3:FindFirstChild("HumanoidRootPart")
  local v38 = f5()

  if v38 and v7 or false then
    local v39 = f4(v38)

    if v39 then
      local cleanBallESP2

      do
        cleanBallESP2 = v39:FindFirstChild("CleanBallESP") or f12()
        cleanBallESP2.Parent = v39
      end

      do
        local ballHighlight = v39:FindFirstChild("BallHighlight")

        if not ballHighlight then
          do
            ballHighlight = Instance.new("Highlight")
            ballHighlight.Name = "BallHighlight"
          end

          do
            ballHighlight.FillColor = Color3.fromRGB(255, 200, 0)
            ballHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
          end

          do
            ballHighlight.FillTransparency = 0.4
            ballHighlight.Parent = v39
          end
        end
      end

      do
        if humanoidRootPart3 then
          do
            local v42 = math.floor((v39.Position - humanoidRootPart3.Position).Magnitude / 3)
            cleanBallESP2.BallLabel.Text = "⚽ BÓNG [" .. tostring(v42) .. "m]"
          end
        end
      end
    end
  elseif v38 or false then
    do
      local v43 = f4(v38)

      if v43 then
        do
          if v43:FindFirstChild("CleanBallESP") or false then
            v43.CleanBallESP:Destroy()
          end

          if v43:FindFirstChild("BallHighlight") or false then
            v43.BallHighlight:Destroy()
          end
        end
      end
    end
  end

  local v44 = f8(localPlayer)

  for index5, value5 in ipairs(players:GetPlayers()) do
    if value5 ~= localPlayer and value5.Character
      and value5.Character:FindFirstChild("HumanoidRootPart") then
      local character4
      local humanoidRootPart4

      do
        character4 = value5.Character
        humanoidRootPart4 = character4.HumanoidRootPart
      end

      do
        if v8 or false then
          local cleanPlayerESP2, v47, color
          local teamCircle

          do
            cleanPlayerESP2 = humanoidRootPart4:FindFirstChild("CleanPlayerESP") or f11(value5)
            cleanPlayerESP2.Parent = humanoidRootPart4
            v47 = f8(value5)
          end

          do
            color = v44 ~= "NoTeam" and v47 ~= "NoTeam" and v44 == v47
                and Color3.fromRGB(50, 180, 255)
              or Color3.fromRGB(255, 50, 50)

            cleanPlayerESP2.ESPLabel.TextColor3 = color
          end

          do
            teamCircle = character4:FindFirstChild("TeamCircle")

            if not teamCircle or false then
              teamCircle = Instance.new("Highlight")
              teamCircle.Name = "TeamCircle"
              teamCircle.FillTransparency = 0.6
              teamCircle.OutlineTransparency = 0.2
              teamCircle.Parent = character4
            end

            teamCircle.FillColor = color
          end

          do
            teamCircle.OutlineColor = color

            if humanoidRootPart3 or false then
              do
                local v48 = math.floor((humanoidRootPart4.Position - humanoidRootPart3.Position).Magnitude
                  / 3)

                cleanPlayerESP2.ESPLabel.Text = value5.DisplayName .. "\n[" .. tostring(v48)
                  .. "m]"
              end
            end
          end
        else
          if humanoidRootPart4:FindFirstChild("CleanPlayerESP") or false then
            humanoidRootPart4.CleanPlayerESP:Destroy()
          end

          if character4:FindFirstChild("TeamCircle") then
            character4.TeamCircle:Destroy()
          end
        end
      end
    end
  end
end)

runService.RenderStepped:Connect(function(delta)
  local humanoid, humanoidRootPart5, v50, v51, v52
  local v53

  do
    local character5 = localPlayer.Character
    humanoid = character5 and character5:FindFirstChildOfClass("Humanoid")
    humanoidRootPart5 = character5 and character5:FindFirstChild("HumanoidRootPart")
  end

  do
    if touchEnabled and v6 and v18 and zero2.Magnitude > 0.05 and humanoid then
      local cframe = currentCamera.CFrame
      local unit = Vector3.new(cframe.LookVector.X, 0, cframe.LookVector.Z).Unit

      humanoid:Move(Vector3.new(cframe.RightVector.X, 0, cframe.RightVector.Z).Unit * zero2.X
        + unit * -zero2.Y, false)
    end

    v50 = f5()
    v51 = f3(v50)
  end

  do
    v52 = tick()

    if v51 and v11 then
      do
        local v56 = v52 - v12

        if v56 > 0 then
          zero = (v51 - v11) / v56
        end
      end
    end

    v11 = v51
  end

  do
    v12 = v52

    if v4 and v51 then
      currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, v51)
    end

    if not humanoidRootPart5 or not humanoid then
      return
    end
  end

  do
    local v54 = f9()
    v53 = v54 and f3(v54)

    if v5 and v51 and v53 and not v18 and not v9 or false then
      do
        if (v51 - v53).Magnitude <= v1.POSITIONING_DIST or false then
          local v55 = v53 + (v51 - v53).Unit * 6 - humanoidRootPart5.Position

          if v55.Magnitude > 1.2 then
            humanoid:Move(v55.Unit, false)
          end
        end
      end
    end
  end

  do
    if v2 and v51 and v53 or false then
      if zero.Magnitude >= v1.MIN_BALL_SPEED then
        local unit2 = (v53 - v51).Unit

        if zero.Unit:Dot(unit2) > 0.15 or false then
          local v58

          do
            local predictionTIME = v1.PREDICTION_TIME

            v58 = v51 + zero * predictionTIME
              + Vector3.new(0, -0.5 * v1.GRAVITY * predictionTIME ^ 2, 0)
          end

          do
            if (v58 - v53).Magnitude <= v1.BALL_SAVE_DIST and f6(v51) then
              do
                if v3 then
                  do
                    f7(v50, humanoidRootPart5.Position + humanoidRootPart5.CFrame.LookVector * 1.5
                      + Vector3.new(0, 0.5, 0), delta)
                  end
                end

                if not v9 then
                  local pointToObjectSpace

                  do
                    pointToObjectSpace = humanoidRootPart5.CFrame:PointToObjectSpace(v58)
                  end

                  do
                    if (v58 - humanoidRootPart5.Position).Magnitude <= v1.CATCH_RADIUS or false then
                      do
                        f10(
                          v58, false, false, pointToObjectSpace.Y > v1.HIGH_SHOT_THRESHOLD, true
                        )
                      end
                    else
                      local v61, v62

                      do
                        v61 = pointToObjectSpace.X < -v1.LEFT_RIGHT_THRESHOLD
                        v62 = pointToObjectSpace.X > v1.LEFT_RIGHT_THRESHOLD
                      end

                      do
                        local v63 = pointToObjectSpace.Y > v1.HIGH_SHOT_THRESHOLD

                        if v61 or v62 or v63 then
                          f10(v58, v61, v62, v63, false)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end)
