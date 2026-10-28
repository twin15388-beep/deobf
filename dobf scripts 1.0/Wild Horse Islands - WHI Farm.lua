local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local virtualUser = game:GetService("VirtualUser")
local virtualInputManager = game:GetService("VirtualInputManager")
local guiService = game:GetService("GuiService")
local userInputService = game:GetService("UserInputService")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
character:WaitForChild("Humanoid")
local rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local function f1(p1)
  local v1 = -math.huge

  for index, value in ipairs(p1:GetDescendants()) do
    if value:IsA("BasePart") then
      local v2 = value.Position.Y + value.Size.Y / 2

      if v2 > v1 then
        v1 = v2
      end
    end
  end

  return v1 == -math.huge and humanoidRootPart.Position.Y or v1
end

local function f2(p2, p3)
  if p2 then
    pcall(function() p2:Set(p3) end)
  end
end

local function f3(p4)
  if not (humanoidRootPart and humanoidRootPart.Parent) then
    return
  else
    local currentCamera = workspace.CurrentCamera

    if not currentCamera then
      return
    else
      local cframe = CFrame.lookAt(humanoidRootPart.Position, p4)
      local position = humanoidRootPart.Position
      local lookVector = cframe.LookVector
      local vector = Vector3.new(0, 1.7, 0)

      currentCamera.CameraType = Enum.CameraType.Fixed

      currentCamera.CFrame = CFrame.lookAt(
        position + lookVector * -3.5 + vector, p4 + Vector3.new(0, -0.3, 0)
      )

      return
    end
  end
end

local window = rayfield:CreateWindow({
  Name = "WHI Farm v9",
  LoadingTitle = "WHI Farm",
  LoadingSubtitle = "desbug em  training+ horse",
  ConfigurationSaving = { Enabled = false },
  Discord = { Enabled = false },
  KeySystem = false,
})

local v3 = false
local flySpeed = 50
local v4 = false
local v5, v6

local function f4()
  v4 = false

  if v6 then
    v6:Disconnect()
    v6 = nil
  end

  if v5 then
    v5:Destroy()
    v5 = nil
  end
end

local vector2 = Vector3.new(3595.69, 21, -6875.07)
local vector3 = Vector3.new(3636.73, 21, -6899.1)

local function f5()
  if not (humanoidRootPart and humanoidRootPart.Parent) then
    return
  end

  local parent = humanoidRootPart.Parent
  local humanoid = parent:FindFirstChildOfClass("Humanoid")

  pcall(function()
    humanoidRootPart.Anchored = true
    humanoidRootPart.AssemblyLinearVelocity = Vector3.new()
    humanoidRootPart.AssemblyAngularVelocity = Vector3.new()

    if humanoid then
      humanoid.PlatformStand = true
      humanoid.WalkSpeed = 0
      humanoid.JumpPower = 0
      humanoid.AutoRotate = false
    end

    for index2, value2 in ipairs(parent:GetDescendants()) do
      if value2:IsA("BasePart") then
        value2.CanCollide = false
      end
    end
  end)
end

local missaoDropdown = "Single Stake"
local v7 = false

local function f6(p5)
  local parent2 = p5.Parent

  if parent2 and parent2:IsA("ScrollingFrame") then
    parent2.CanvasPosition = Vector2.new(parent2.CanvasPosition.X, math.max(0, p5.AbsolutePosition.Y
          - parent2.AbsolutePosition.Y
        + parent2.CanvasPosition.Y
      - (parent2.AbsoluteSize.Y - p5.AbsoluteSize.Y) / 2))

    task.wait(0.4)
  end
end

local v8 = false

local function f7(title, content)
  rayfield:Notify({
    Title = title,
    Content = content,
    Duration = 3,
    Image = nil,
  })
end

local v9 = {
  cross = { nome = "Cross Country", pos = Vector3.new(3674.61, 21, -7141.42) },
  river = { nome = "Begin River Run", pos = Vector3.new(3708.41, 16.32, -6400.22) },
}

local function f8(p6)
  if p6.PrimaryPart then
    return p6.PrimaryPart
  else
    local v10 = nil
    local v11 = 0

    for index3, value3 in ipairs(p6:GetDescendants()) do
      if value3:IsA("BasePart") then
        local magnitude = value3.Size.Magnitude

        if magnitude > v11 then
          v11 = magnitude
          v10 = value3
        end
      end
    end

    return v10
  end
end

local v12 = false
Vector3.new(3678.48, 25.5, -7140.38)
local v13

local function f9()
  if v13 then
    v13:Disconnect()
    v13 = nil
  end

  v12 = false
end

Vector3.new(3706.19, 19.86, -6396.1)
local v14 = 0

local function f10(p7)
  if not v5 or not v5.Parent then
    return
  else
    local magnitude2 = (v5.Position - p7).Magnitude

    if magnitude2 < 1 then
      return
    else
      local create = tweenService:Create(v5, TweenInfo.new(
        magnitude2 / flySpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut
      ), { CFrame = CFrame.new(p7) })

      create:Play()
      create.Completed:Wait()

      return
    end
  end
end

local v15 = {
  Node = true,
  ShopInteractionPart = true,
  Bounds = true,
  CompetitiveRaceStaminaBoost = true,
  CompetitiveRaceSpeedBoost = true,
  Bound = true,
  SlidePart = true,
}

local v16 = {
  CompetitiveRaceItem = true,
  Billboard = true,
  ["Wind turbine"] = true,
  RewardPickupNodes = true,
}

local v17

local function f11(p8)
  if not p8 or not p8.Parent then
    return false
  elseif not p8:IsA("BasePart") then
    return false
  elseif not p8:FindFirstChildOfClass("TouchTransmitter") then
    return false
  else
    if v15[p8.Name] then
      return false
    end

    if p8.Parent and v16[p8.Parent.Name] then
      return false
    elseif v17[p8.Material] then
      return false
    else
      local lower = p8.Name:lower()

      if lower:find("bound") or lower:find("node") or lower:find("shop") or lower:find("boost")
        or lower:find("slide") then
        return false
      elseif p8.Parent then
        if p8.Parent.Name:lower():find("competitiverace") then
          return false
        end

        return true
      else
        return true
      end
    end
  end
end

v17 = { [Enum.Material.Glass] = true, [Enum.Material.ForceField] = true }
local v18

local function f12()
  if v18 then
    pcall(function() task.cancel(v18) end)
    v18 = nil
  end
end

local v19 = {}
local descendantAdded = workspace.DescendantAdded
local connect

local function f13()
  if connect then
    connect:Disconnect()
    connect = nil
  end
end

descendantAdded:Connect(function(p9)
  task.defer(function()
    if f11(p9) then
      v19[p9] = true
    end
  end)
end)

workspace.DescendantRemoving:Connect(function(descendant) v19[descendant] = nil end)

local function f14()
  for index4, value4 in ipairs(workspace:GetDescendants()) do
    if value4:IsA("Model") and value4 ~= character then
      if value4:FindFirstChild("Humanoid") and value4:FindFirstChild("RootPart") then
        if (value4.RootPart.Position - humanoidRootPart.Position).Magnitude < 15 then
          return value4.RootPart, value4
        end
      end
    end
  end

  return nil, nil
end

task.spawn(function()
  for index5, value5 in ipairs(workspace:GetDescendants()) do
    if f11(value5) then
      v19[value5] = true
    end
  end
end)

local function f15()
  local huge = math.huge
  local position2 = humanoidRootPart.Position
  local v20

  for key in pairs(v19) do
    if key and key.Parent then
      local magnitude3 = (position2 - key.Position).Magnitude

      if magnitude3 <= 700 and magnitude3 < huge then
        v20 = key
        huge = magnitude3
      end
    end
  end

  return v20
end

local function f16(p10)
  local huge2 = math.huge
  local position3 = humanoidRootPart.Position
  local v21

  for key2 in pairs(v19) do
    if key2 and key2.Parent then
      local magnitude4 = (position3 - key2.Position).Magnitude

      if magnitude4 <= p10 and magnitude4 < huge2 then
        huge2 = magnitude4
        v21 = key2
      end
    end
  end

  return v21
end

local connect2 = nil

local function f17()
  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end
end

local function f18()
  if connect2 then
    return
  end

  connect2 = localPlayer.Idled:Connect(function()
    local v22, v23 = pcall(function() return virtualUser end)

    if v22 and v23 then
      v23:CaptureController()
      v23:ClickButton2(Vector2.new())
    end
  end)
end

local function f19()
  local part = Instance.new("Part")
  part.Size = Vector3.new(2, 1, 2)
  part.Transparency = 1
  part.Anchored = true
  part.CanCollide = false
  part.CFrame = humanoidRootPart.CFrame
  part.Parent = workspace

  return part
end

local v24 = false
local v25, connect3

local function f20()
  v24 = false

  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  if v25 then
    v25:Destroy()
    v25 = nil
  end

  for index6, value6 in ipairs(humanoidRootPart:GetChildren()) do
    local v26 = value6

    if v26:IsA("BodyVelocity") or v26:IsA("BodyGyro") or v26:IsA("BodyPosition") then
      pcall(function() v26:Destroy() end)
    end
  end

  local humanoid2 = character:FindFirstChildOfClass("Humanoid")

  if humanoid2 then
    humanoid2.PlatformStand = false
  end
end

local function f21()
  if v24 then
    return
  else
    v24 = true
    v25 = f19()
    local humanoid3 = character:FindFirstChildOfClass("Humanoid")

    if humanoid3 then
      humanoid3.PlatformStand = true
    end

    if connect3 then
      pcall(function() connect3:Disconnect() end)
    end

    connect3 = runService.Heartbeat:Connect(function()
      if v25 and v25.Parent then
        humanoidRootPart.CFrame = v25.CFrame
      end
    end)

    f7("Fly", "FLY ATIVADO")
    return
  end
end

local function f22(p11)
  if not v25 or not v25.Parent then
    return
  else
    local magnitude5 = (v25.Position - p11).Magnitude

    if magnitude5 < 1 then
      return
    else
      local create2 = tweenService:Create(v25, TweenInfo.new(
        magnitude5 / flySpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut
      ), { CFrame = CFrame.new(p11) })

      create2:Play()
      create2.Completed:Wait()

      return
    end
  end
end

connect = nil

local function f23()
  if connect then
    pcall(function() connect:Disconnect() end)
  end

  connect = runService.Heartbeat:Connect(function()
    if not v24 or not v25 or not v25.Parent then
      return
    else
      local v27 = f15()

      if not v27 or not v27.Parent then
        return
      else
        local unit = (v27.Position - v25.Position).Unit
        v25.CFrame = CFrame.new(v25.Position, v25.Position + unit)

        if v4 then
          local v28, v29 = f14()

          if v28 and v28.Parent and v5 and v5.Parent then
            v5.CFrame = CFrame.new(v5.Position, v5.Position + unit)
          end
        end

        return
      end
    end
  end)
end

local function f24(p12)
  local v30 = p12 or 30
  local v31 = workspace
  local v32

  for index7, value7 in ipairs(v31:GetDescendants()) do
    if value7:IsA("ProximityPrompt") and value7.Enabled then
      local parent3 = value7.Parent
      local position4 = nil

      if parent3 and parent3:IsA("BasePart") then
        position4 = parent3.Position
      elseif parent3 and parent3:IsA("Attachment") then
        position4 = parent3.WorldPosition
      end

      if position4 then
        local magnitude6 = (position4 - humanoidRootPart.Position).Magnitude

        if magnitude6 < v30 then
          v32 = value7
          v30 = magnitude6
        end
      end
    end
  end

  return v32
end

local playerGui = localPlayer:WaitForChild("PlayerGui")

local function f25(p13)
  if not (v25 and v25.Parent) then
    humanoidRootPart.CFrame = CFrame.new(p13)
    task.wait(0.2)
    return
  end

  if v7 then
    v25.CFrame = CFrame.new(p13)

    if v4 and v5 and v5.Parent then
      v5.CFrame = CFrame.new(p13 + Vector3.new(5, 0, 0))
    end

    task.wait(0.2)
  else
    f22(p13)

    if v4 and v5 and v5.Parent then
      f10(p13)
    end
  end
end

local function f26(p14, p15)
  local screenGui = Instance.new("ScreenGui")
  screenGui.IgnoreGuiInset = true
  screenGui.DisplayOrder = 1000
  screenGui.ResetOnSpawn = false
  screenGui.Parent = playerGui

  local frame = Instance.new("Frame")
  frame.Size = UDim2.fromOffset(16, 16)
  frame.Position = UDim2.fromOffset(p14 - 8, p15 - 8)
  frame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
  frame.Parent = screenGui

  Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
  task.delay(1.5, function() screenGui:Destroy() end)
end

local function f27(p16)
  local prompts = playerGui:FindFirstChild("Prompts")
  return prompts and prompts:FindFirstChild(p16, true) or playerGui:FindFirstChild(p16, true)
end

local function f28()
  local v33 = f24(30)
  local v34 = false

  if v33 and fireproximityprompt and true then
    pcall(fireproximityprompt, v33)
    v34 = true
  end

  if not v34 then
    local holdDuration = v33 and v33.HoldDuration or 0
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(math.max(holdDuration, 0) + 0.15)
    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
  end
end

local function f29(p17)
  local parent4 = p17

  while parent4 and parent4 ~= playerGui do
    if parent4:IsA("GuiObject") and not parent4.Visible then
      return false
    end

    if parent4:IsA("ScreenGui") and not parent4.Enabled then
      return false
    end

    parent4 = parent4.Parent
  end

  return p17.AbsoluteSize.X > 0
end

local function f30()
  if not (humanoidRootPart and humanoidRootPart.Parent) then
    return
  end

  local parent5 = humanoidRootPart.Parent
  local humanoid4 = parent5:FindFirstChildOfClass("Humanoid")

  pcall(function()
    humanoidRootPart.Anchored = false
    humanoidRootPart.AssemblyLinearVelocity = Vector3.new()
    humanoidRootPart.AssemblyAngularVelocity = Vector3.new()

    if humanoid4 then
      humanoid4.PlatformStand = false
      humanoid4.WalkSpeed = 16
      humanoid4.JumpPower = 50
      humanoid4.AutoRotate = true
    end

    for index8, value8 in ipairs(parent5:GetDescendants()) do
      if value8:IsA("BasePart") then
        value8.CanCollide = true
      end
    end
  end)
end

local function f31(p18, p19)
  local v35 = os.clock() + (p19 or 15)

  while os.clock() < v35 do
    local v36 = f27(p18)

    if v36 and f29(v36) then
      return v36
    end

    task.wait(0.25)
  end
end

local f32

local function f33(p20)
  local v37 = f31(p20, 15)

  if not v37 then
    return false
  else
    f6(v37)
    local v38 = v37.AbsolutePosition + v37.AbsoluteSize / 2
    local getGuiInset = guiService:GetGuiInset()
    task.wait(0.15)
    f32(v38.X + 0, v38.Y + getGuiInset.Y + 0)
    task.wait(0.15)
    return true
  end
end

function f32(p21, p22)
  f26(p21, p22)
  virtualInputManager:SendMouseMoveEvent(p21, p22, game)
  task.wait(0.1)
  virtualInputManager:SendMouseButtonEvent(p21, p22, 0, true, game, 0)
  task.wait(0.05)
  virtualInputManager:SendMouseButtonEvent(p21, p22, 0, false, game, 0)

  pcall(function()
    virtualInputManager:SendTouchEvent(1, 0, p21, p22)
    task.wait(0.08)
    virtualInputManager:SendTouchEvent(1, 2, p21, p22)
  end)
end

local function f34()
  local humanoid5 = character:FindFirstChildOfClass("Humanoid")

  if humanoid5 then
    humanoid5.Jump = true
  end

  pcall(function()
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.05)
    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
  end)
end

local function f35()
  if v8 then
    return false
  else
    local v39, v40 = pcall(function()
      f7("Missão", "📜 Indo pegar a missão...")
      f25(vector2)
      task.wait(0.5)
      f28()
      task.wait(0.8)

      if not f33(missaoDropdown) then
        return false
      end

      task.wait(0.8)
      f25(vector3)
      task.wait(0.5)
      f28()
      task.wait(1.5)
      return true
    end)

    v8 = false

    if not v39 then
      return false
    end

    return v40
  end
end

local v41 = false
local v42 = false
local v43

local function f36()
  if v43 == "mine" then
    v41 = not v41
    f7("Mine/Collect", v41 and "Clique: Ativado" or "Clique: Pausado")
  elseif v43 == "collect" then
    v42 = not v42
    f7("Mine/Collect", v42 and "Tecla E: Ativado" or "Tecla E: Pausado")
  else
    f7("Mine/Collect", "Escolha um modo primeiro")
  end
end

local f37

local function f38(p23)
  local v44 = p23.Position + Vector3.new(0, 20, 0)
  f22(v44)

  if v4 and v5 and v5.Parent then
    f10(v44)
  end

  task.wait(0.2)
  local v45 = p23.Position + Vector3.new(0, 3, 0)
  f22(v45)

  if v4 and v5 and v5.Parent then
    f10(v45)
  end

  f37(p23)
  local v46 = tick()

  while p23.Parent and tick() - v46 < 2 do
    task.wait(0.03)
  end

  task.wait(0.3)
end

function f37(p24)
  if not p24 or not p24.Parent then
    return
  end

  if (humanoidRootPart.Position - p24.Position).Magnitude <= 10 and os.clock() - v14 >= 0.3 then
    v14 = os.clock()
    f34()
  end
end

local connect4

local function f39()
  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end
end

local v47

local function f40(p25)
  if not p25 or v12 or v8 then
    return false
  else
    v12 = true

    local v48 = pcall(function()
      f7("Corrida", p25.nome)

      if not v24 then
        f21()
      end

      f25(p25.pos)
      task.wait(0.5)
      f28()
      task.wait(1)
      local v49 = os.clock()
      local v50 = false
      local v51

      while v47 do
        local v52 = f16(2000)

        if v52 and v52.Parent then
          v51 = nil
          f38(v52)
          v50 = true
        else
          v51 = v51 or os.clock()
          local v53 = v50 and 3 or 10

          if os.clock() - v51 >= v53 then
            break
          end

          task.wait(0.2)
        end

        if os.clock() - v49 >= 240 then
          break
        end

        task.wait()
      end
    end)

    f9()
    return v48
  end
end

local v54

local function f41()
  v47 = nil

  if v54 then
    pcall(function() task.cancel(v54) end)
    v54 = nil
  end

  f9()
  f20()
  f4()
end

local v55 = false
local v56 = false
local v57 = false

local v58 = {
  "Strawberries", "Meshes/Hay", "Meshes/Wheat Plane", "Cotton Plant", "Meshes/Coconut",
  "Bounds", "Raspberries", "Meshes/Bush (1)",
}

local function f42(p26)
  return type(p26) == "string" and p26:lower():find("rock") ~= nil
end

local function f43(p27, p28)
  local lower2 = (p27.Name .. "|" .. (p27.Parent and p27.Parent.Name or "")):lower()
  local v59 = false

  for index9, value9 in ipairs(p28) do
    if lower2:find(value9, 1, true) then
      v59 = true
      break
    end
  end

  if not v59 then
    return false
  end

  if humanoidRootPart and humanoidRootPart.Parent then
    if (p27.Position - humanoidRootPart.Position).Magnitude <= 10 then
      return true
    end

    return false
  end

  return false
end

local function f44(p29)
  local currentCamera2 = workspace.CurrentCamera

  if not currentCamera2 then
    return nil
  else
    local v60, v61 = currentCamera2:WorldToViewportPoint(p29.Position
      + Vector3.new(0, p29.Size.Y / 2, 0))

    if v61 then
      return math.floor(v60.X + 0.5), math.floor(v60.Y + 0.5)
    else
      local viewportSize = currentCamera2.ViewportSize
      return math.floor(viewportSize.X / 2), math.floor(viewportSize.Y / 2)
    end
  end
end

local function f45(p30)
  local lower3 = (p30.Name .. "|" .. (p30.Parent and p30.Parent.Name or "")):lower()

  if not lower3:find("well", 1, true) then
    return false
  end

  if not (lower3:find("door", 1, true) or lower3:find("rock", 1, true)) then
    return false
  end

  if humanoidRootPart and humanoidRootPart.Parent then
    if (p30.Position - humanoidRootPart.Position).Magnitude <= 10 then
      return true
    end

    return false
  end

  return false
end

local vector4 = Vector3.new(600.65, 30.88, -350.68)

local function f46(p31)
  if not p31 then
    return false
  end

  local v62

  if not (humanoidRootPart and humanoidRootPart.Parent) then
    return false
  else
    local lower4 = (p31.Name .. "|" .. (p31.Parent and p31.Parent.Name or "")):lower()
    local magnitude7 = (p31.Position - humanoidRootPart.Position).Magnitude
    v62 = false

    pcall(function()
      if typeof(p31.Material) == "EnumItem" and p31.Material == Enum.Material.Slate then
        v62 = true
      end
    end)

    if (v62 or lower4:find("door", 1, true)) and magnitude7 <= 20 then
      return true
    end

    if (lower4:find("river rock pillar", 1, true) or lower4:find("buildable", 1, true))
      and magnitude7 <= 20 then
      return true
    end

    if lower4:find("tools", 1, true) and magnitude7 <= 25 then
      return true
    end

    if (p31.Name == "Model" or p31.Name == "Lantern"
        or p31.Parent and (p31.Parent.Name == "Model" or p31.Parent.Name == "Lantern"))
      and magnitude7 <= 12 then
      return true
    elseif (p31.Position - vector4).Magnitude <= 12 then
      return true
    else
      if f45(p31) then
        return true
      end

      return false
    end
  end
end

local function f47(p32)
  local parent6 = p32
  local count = 0

  while parent6 and count < 10 do
    if (parent6.Name or ""):match("^{[%x%-]+}$") then
      return parent6
    end

    count = count + 1
    parent6 = parent6.Parent
  end

  return nil
end

local function f48(p33)
  return f47(p33) ~= nil
end

local f49

local function f50(p34)
  local v63 = math.huge
  local position5 = humanoidRootPart.Position
  local v64

  local function f51(p35)
    for index10, value10 in ipairs(p35:GetDescendants()) do
      if f49(value10, p34) then
        local magnitude8 = (value10.Position - position5).Magnitude

        if magnitude8 < v63 then
          v63 = magnitude8
          v64 = value10
        end
      end
    end
  end

  if v64 == nil then
    pcall(function()
      for index11, value11 in ipairs(workspace:GetDescendants()) do
        if value11:IsA("Folder") and value11.Name:match("^{[%x%-]+}$") then
          f51(value11)
        end
      end
    end)
  end

  return v64
end

function f49(p36, p37)
  if not p36 or not p36.Parent then
    return false
  elseif not p36:IsA("BasePart") then
    return false
  elseif not f48(p36) then
    return false
  elseif f46(p36) then
    return false
  elseif p37 == "mine" then
    if not f42(p36.Name) then
      return false
    end

    if f45(p36) then
      return false
    end

    return true
  elseif f43(p36, { "wood", "decor" }) then
    return false
  elseif f45(p36) then
    return false
  else
    local lower5 = p36.Name:lower()
    local lower6 = p36.Parent and p36.Parent.Name:lower() or ""

    for index12, value12 in ipairs(v58) do
      local lower7 = value12:lower()

      if lower5:find(lower7, 1, true) or lower6:find(lower7, 1, true) then
        return true
      end
    end

    return false
  end
end

local v65

local function f52()
  if not (v65 and v65.Parent) then
    return
  end

  local v66, v67 = f44(v65)

  if not v66 then
    return
  end

  pcall(function()
    virtualInputManager:SendMouseButtonEvent(v66, v67, 0, true, game, 1)
    task.wait(0.05)
    virtualInputManager:SendMouseButtonEvent(v66, v67, 0, false, game, 1)
  end)
end

local f53

local function f54(p38)
  if v55 and v43 == p38 then
    f7("Mine/Collect", "Desativado: " .. (p38 == "mine" and "MINE" or "COLLECT"))
    return
  else
    v43 = p38

    if p38 == "mine" then
      v41 = true
      v42 = false
    else
      v42 = true
      v41 = false
    end

    local v68 = f50(p38)

    if not v68 then
      f7("Mine/Collect", "Nada encontrado por perto")
      return
    end

    if not (humanoidRootPart and humanoidRootPart.Parent) then
      return
    end

    v55 = true
    v65 = v68
    f7("Mine/Collect", (p38 == "mine" and "MINE" or "COLLECT") .. " iniciado")
    f53(v68)
    return
  end
end

local v69

function f53(p39)
  if v57 then
    return
  end

  v57 = true
  v56 = false
  local cframe2, v70

  if not (humanoidRootPart and humanoidRootPart.Parent) then
    v57 = false
    return
  else
    f5()
    local v71 = p39.Position + Vector3.new(0, v43 == "mine" and 1.5 or 1, 0)
    cframe2 = CFrame.lookAt(v71, p39.Position)
    v70 = math.max((v71 - humanoidRootPart.Position).Magnitude / 70, 0.3)

    local function f55()
      pcall(function()
        humanoidRootPart.CFrame = cframe2
        humanoidRootPart.AssemblyLinearVelocity = Vector3.new()
        humanoidRootPart.AssemblyAngularVelocity = Vector3.new()

        f3(p39.Position)
      end)

      v57 = false
      v56 = true
    end

    local v72, v73 = pcall(function()
      return tweenService:Create(humanoidRootPart, TweenInfo.new(
        v70, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
      ), { CFrame = cframe2 })
    end)

    if not v72 or not v73 then
      pcall(function() humanoidRootPart.CFrame = cframe2 end)
      f55()
      return
    end

    v69 = v73

    v73:Play()
    v73.Completed:Connect(f55)

    return
  end
end

function f56()
  v55 = false
  v65 = nil
  v56 = false
  v43 = nil
  v41 = false
  v42 = false

  if v69 then
    pcall(function() v69:Cancel() end)
  end

  v69 = nil
  f30()

  pcall(function()
    local currentCamera3 = workspace.CurrentCamera

    if currentCamera3 then
      currentCamera3.CameraType = Enum.CameraType.Custom
    end
  end)
end

task.spawn(function()
  while true do
    task.wait(0.16)

    pcall(function()
      if v55 and v56 and v41 and v43 == "mine" and v65 and v65.Parent then
        f52()
      end
    end)
  end
end)

task.spawn(function()
  while true do
    task.wait(0.25)
  end
end)

task.spawn(function()
  while true do
    task.wait(0.1)

    pcall(function()
      if not (v55 and v56 and v65 and v65.Parent) then
        return
      end

      if not (humanoidRootPart and humanoidRootPart.Parent) then
        return
      end

      local v74 = v65.Position + Vector3.new(0, v43 == "mine" and 1.5 or 1, 0)

      if (humanoidRootPart.Position - v74).Magnitude > 0.75 then
        f5()

        pcall(function()
          humanoidRootPart.CFrame = CFrame.lookAt(v74, v65.Position)
          humanoidRootPart.AssemblyLinearVelocity = Vector3.new()
          humanoidRootPart.AssemblyAngularVelocity = Vector3.new()
        end)
      end

      f3(v65.Position)
    end)
  end
end)

runService.RenderStepped:Connect(function()
  pcall(function()
    if v55 and v56 and v65 and v65.Parent then
      f3(v65.Position)
    end
  end)
end)

task.spawn(function()
  while true do
    task.wait(0.4)

    pcall(function()
      if v55 and v56 and v65 then
        if not v65.Parent then
          v65 = nil
          local v75 = f50(v43)

          if v75 then
            v65 = v75
            f53(v75)
          else
            f7("Mine/Collect", "Tudo coletado!")
          end
        end
      end
    end)
  end
end)

userInputService.InputBegan:Connect(function(input, p40)
  if p40 then
    return
  end

  pcall(function()
    if input.KeyCode == Enum.KeyCode.C then
      f36()
    end
  end)
end)

local v76 = {}
local v77 = { "wild", "selvagem", "salvaje" }

local function f59(p41)
  if p41:IsA("BillboardGui") then
    v76[p41] = true
  end
end

workspace.DescendantAdded:Connect(f59)
workspace.DescendantRemoving:Connect(function(descendant2) v76[descendant2] = nil end)

task.spawn(function()
  for index13, value13 in ipairs(workspace:GetDescendants()) do
    f59(value13)
  end
end)

local function f60(p42)
  local v78 = {}

  for index14, value14 in ipairs(p42:GetDescendants()) do
    if value14:IsA("TextLabel") or value14:IsA("TextButton") or value14:IsA("TextBox") then
      local contentText = value14.ContentText

      if contentText == nil or contentText == "" then
        contentText = value14.Text
      end

      if contentText ~= "" then
        v78[#v78 + 1] = contentText
      end
    end
  end

  return table.concat(v78, " ")
end

local function f61(p43)
  if p43.Name == "CaptureProgress" then
    return true
  else
    local lower8 = f60(p43):lower()

    if lower8 == "" then
      return false
    end

    for index15, value15 in ipairs(v77) do
      if lower8:find(value15, 1, true) then
        return true
      end
    end

    return false
  end
end

local function f62()
  task.wait(0.2)
  virtualInputManager:SendKeyEvent(true, Enum.KeyCode.Two, false, game)
  task.wait(0.1)
  virtualInputManager:SendKeyEvent(false, Enum.KeyCode.Two, false, game)
  task.wait(0.3)
end

local function f63(p44)
  local adornee = p44.Adornee or p44.Parent
  local count2 = 0
  local parent7 = adornee

  while parent7 and parent7 ~= workspace and count2 < 12 do
    if parent7:IsA("Model") and parent7:FindFirstChildOfClass("Humanoid") then
      return parent7
    end

    parent7 = parent7.Parent
    count2 = count2 + 1
  end

  return nil
end

local v79 = false
local v80 = false

local function f64(p45)
  if not p45 or not p45.Parent then
    return false
  end

  if p45 == character then
    return false
  end

  for key3 in pairs(v76) do
    if key3.Parent and f61(key3) and f63(key3) == p45 then
      return true
    end
  end

  return false
end

connect4 = nil
local horseflyspeedwhi = 70
local v81 = 0
local v82 = 0

local function f65()
  local v83 = {}
  local v84 = {}
  local position6 = humanoidRootPart.Position

  for key4 in pairs(v76) do
    if key4.Parent and f61(key4) then
      local v85 = f63(key4)

      if v85 and not v84[v85] and v85 ~= character and not players:GetPlayerFromCharacter(v85) then
        v84[v85] = true
        local v86 = f8(v85)

        if v86 then
          local magnitude9 = (v86.Position - position6).Magnitude

          if magnitude9 <= 2694 then
            table.insert(v83, { model = v85, dist = magnitude9, texto = f60(key4) })
          end
        end
      end
    end
  end

  table.sort(v83, function(p46, p47) return p46.dist < p47.dist end)
  return v83
end

local model, bodyPosition, bodyGyro

local function f66()
  if not v80 then
    return
  else
    v80 = false
    f39()
    local humanoid6 = character:FindFirstChildOfClass("Humanoid")

    if humanoid6 then
      humanoid6.PlatformStand = false
    end

    if bodyPosition then
      bodyPosition:Destroy()
      bodyPosition = nil
    end

    if bodyGyro then
      bodyGyro:Destroy()
      bodyGyro = nil
    end

    model = nil
    return
  end
end

local function f67(p48)
  f39()

  connect4 = runService.Heartbeat:Connect(function()
    if not v80 or not bodyPosition then
      return
    end

    if not p48 or not p48.Parent then
      f39()
      return
    else
      local v87 = f8(p48)

      if not v87 then
        return
      else
        local v88 = f1(p48)
        local vector5 = Vector3.new(v87.Position.X, v88 + 5, v87.Position.Z)
        bodyPosition.Position = bodyPosition.Position:Lerp(vector5, 0.15)
        return
      end
    end
  end)
end

local function f68()
  if v80 then
    return
  else
    v80 = true
    local humanoid7 = character:FindFirstChildOfClass("Humanoid")

    if humanoid7 then
      humanoid7.PlatformStand = true
    end

    bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyPosition.P = 7500
    bodyPosition.D = 500
    bodyPosition.Position = humanoidRootPart.Position
    bodyPosition.Parent = humanoidRootPart

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 10000
    bodyGyro.D = 500
    bodyGyro.CFrame = humanoidRootPart.CFrame
    bodyGyro.Parent = humanoidRootPart

    return
  end
end

local function f69(p49, p50)
  local v89 = f8(p49)

  if not v89 then
    return false
  else
    local vector6 = Vector3.new(v89.Position.X, f1(p49) + 5, v89.Position.Z)
    local magnitude10 = (humanoidRootPart.Position - vector6).Magnitude

    if magnitude10 < 2 then
      return true
    else
      local v90 = math.max(magnitude10 / p50, 0.1)

      if bodyPosition then
        bodyPosition.Parent = nil
      end

      local create3 = tweenService:Create(humanoidRootPart, TweenInfo.new(
        v90, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut
      ), { CFrame = CFrame.new(vector6) })

      create3:Play()
      create3.Completed:Wait()

      if bodyPosition then
        bodyPosition.Parent = humanoidRootPart
      end

      return true
    end
  end
end

local function f70(p51)
  local v91 = f8(p51)

  if not v91 then
    return
  end

  f69(p51, horseflyspeedwhi)

  if bodyPosition then
    bodyPosition.Position = Vector3.new(v91.Position.X, f1(p51) + 5, v91.Position.Z)
  end

  f67(p51)
end

local connect5, f71

local function f72()
  if connect5 then
    return
  end

  v79 = true
  v81 = 0
  task.spawn(function() f71() end)

  connect5 = runService.Heartbeat:Connect(function()
    if not v79 then
      return
    else
      local v92 = tick()

      if model then
        if v92 - v82 >= 0.5 then
          v82 = v92

          if not f64(model) then
            model = nil
          end
        end

        if model then
          return
        end

        f39()
        model = nil

        if v92 - v81 >= 1.5 then
          v81 = v92

          if not f71() then
            f66()
          end
        end

        return
      end

      f39()
      model = nil

      if v92 - v81 >= 1.5 then
        v81 = v92

        if not f71() then
          f66()
        end
      end

      return
    end
  end)
end

local function f73()
  v79 = false

  if connect5 then
    connect5:Disconnect()
    connect5 = nil
  end

  f66()
end

function f71()
  local v93 = f65()

  if #v93 > 0 then
    model = v93[1].model
    v82 = tick()
    f68()
    f70(model)
    return true
  end

  return false
end

local v94 = false

task.spawn(function()
  while true do
    task.wait(1)

    if v94 then
      pcall(function()
        local currentCamera4 = workspace.CurrentCamera

        if not currentCamera4 then
          return
        else
          local viewportSize2 = currentCamera4.ViewportSize
          local v95 = math.floor(viewportSize2.X / 2)
          local v96 = math.floor(viewportSize2.Y / 2)

          virtualInputManager:SendMouseMoveEvent(v95, v96, game)
          virtualInputManager:SendMouseButtonEvent(v95, v96, 0, true, game, 0)

          task.wait(0.05)
          virtualInputManager:SendMouseButtonEvent(v95, v96, 0, false, game, 0)
          return
        end
      end)
    end
  end
end)

local toggle

local function f74()
  f73()
  f17()
  f20()
  v94 = false

  if toggle then
    pcall(function() toggle:Set(false) end)
  end

  f7("Shutdown", "Tudo parado")
end

function f57()
  f73()
  f20()
end

local v97 = nil
local statusOffLabel, f75

local function f76()
  task.wait(0.1)
  v3 = true
  f21()
  f23()
  f2(statusOffLabel, "Status: On")
  v97 = task.spawn(f75)
  f7("Farm", "Farm Iniciado")
end

function f58()
  v3 = false

  if v97 then
    pcall(function() task.cancel(v97) end)
    v97 = nil
  end

  v8 = false
  f41()
  f12()
  f20()
  f4()
  f13()
  f2(statusOffLabel, "Status: Off")
end

function f75()
  local v98 = os.clock() - 3

  while v3 do
    local v99 = f15()

    if not v99 then
      v98 = v98 or os.clock()

      if os.clock() - v98 >= 3 then
        if v24 and v25 and v25.Parent then
          f35()
        end

        v98 = nil
      else
        task.wait(0.5)
      end

      task.wait()
    else
      v98 = nil

      if not v24 or not v25 or not v25.Parent then
        task.wait(0.1)
      else
        f38(v99)
        task.wait()
      end
    end
  end
end

local function f77(p52)
  task.wait(0.1)
  v47 = p52
  f2(statusOffLabel, "Status: " .. v9[p52].nome)
  f7("Corrida", v9[p52].nome .. " (pley")
  f21()

  v54 = task.spawn(function()
    while v47 == p52 do
      f40(v9[p52])

      if v47 ~= p52 then
        break
      end

      task.wait(1)
    end
  end)
end

local statusTab = window:CreateTab("Status", nil)
statusTab:CreateSection("Real-Time Info")

statusOffLabel = statusTab:CreateLabel("Status: Off")
local createLabel = statusTab.CreateLabel
statusTab:CreateLabel("Points in radius: 0")
createLabel(statusTab, "Anti-AFK: Off")
statusTab:CreateLabel("Horse: Off")

task.spawn(function()
  while true do
    task.wait(2)
  end
end)

local farmTab = window:CreateTab("Farm", nil)

farmTab:CreateButton({
  Name = "INICIAR FLY FARM",
  Callback = function()
    if v3 then
      f7("Farm", "Farm parado")
    else
      f76()
    end
  end,
})

farmTab:CreateSection("Missão Automática")

farmTab:CreateDropdown({
  Name = "Missão para clicar",
  Options = { "Single Stake", "Big T" },
  CurrentOption = { "Single Stake" },
  MultipleOptions = false,
  Flag = "missaoDropdown",
  Callback = function(value16)
    local v100 = type(value16) == "table" and value16[1] or value16

    if v100 then
      missaoDropdown = v100
    end
  end,
})

farmTab:CreateToggle({
  Name = "Teleportar até as coordenadas",
  CurrentValue = false,
  Flag = "teleporteMissaoToggle",
  Callback = function(value17) v7 = value17 end,
})

farmTab:CreateSection("Corridas")

local toggle2

local crossCountryToggle = farmTab:CreateToggle({
  Name = "Cross Country",
  CurrentValue = false,
  Flag = "crossLoopToggle",
  Callback = function(value18)
    if not value18 then
      if v47 == "cross" then
        f41()
        f2(statusOffLabel, "Status: Off")
        f7("Corrida", "Cross Country parada")
      end

      return
    end

    if toggle2 then
      pcall(function() toggle2:Set(false) end)
    end

    f77("cross")
  end,
})

toggle2 = farmTab:CreateToggle({
  Name = "Begin River Run",
  CurrentValue = false,
  Flag = "riverLoopToggle",
  Callback = function(value19)
    if not value19 then
      if v47 == "river" then
        f41()
        f2(statusOffLabel, "Status: Off")
        f7("Corrida", "Begin River Run parada")
      end

      return
    end

    if crossCountryToggle then
      pcall(function() crossCountryToggle:Set(false) end)
    end

    f77("river")
  end,
})

farmTab:CreateSection("Configurações")

farmTab:CreateSlider({
  Name = "Fly Speed",
  Range = { 5, 300 },
  Increment = 5,
  CurrentValue = 50,
  Flag = "speedSlider",
  Callback = function(value20) flySpeed = value20 end,
})

local mineCollectTab = window:CreateTab("Mine/Collect", nil)
mineCollectTab:CreateSection("Auto Mine + Auto Collect")
mineCollectTab:CreateButton({ Name = "AUTO MINE", Callback = function() f54("mine") end })
mineCollectTab:CreateButton({ Name = "AUTO COLLECT", Callback = function() f54("collect") end })

mineCollectTab:CreateButton({
  Name = "PARAR",
  Callback = function() f7("Mine/Collect", "Parado") end,
})

local horsesTab = window:CreateTab("Horses", nil)

horsesTab:CreateToggle({
  Name = "Voar ate Wild Horse",
  CurrentValue = false,
  Flag = "cavalowhi",
  Callback = function(value21)
    if value21 then
      f62()
      f72()
    else
      f73()
    end
  end,
})

horsesTab:CreateSlider({
  Name = "Speed (voar ate o cavalo)",
  Range = { 70, 300 },
  Increment = 5,
  CurrentValue = 70,
  Flag = "horseflyspeedwhi",
  Callback = function(value22) horseflyspeedwhi = value22 end,
})

toggle = horsesTab:CreateToggle({
  Name = "Auto Click (1s)",
  CurrentValue = false,
  Flag = "autoClickToggle",
  Callback = function(value23) v94 = value23 end,
})

local utilsTab = window:CreateTab("Utils", nil)

utilsTab:CreateToggle({
  Name = "Anti-AFK",
  CurrentValue = false,
  Flag = "afkToggle",
  Callback = function(value24)
    if value24 then
      f18()
    else
      f17()
    end
  end,
})

utilsTab:CreateButton({ Name = "PARAR TUDO", Callback = function() f74() end })

localPlayer.CharacterAdded:Connect(function(character2)
  character = character2
  humanoidRootPart = character2:WaitForChild("HumanoidRootPart")
  character2:WaitForChild("Humanoid")
  f73()
end)

f7("WHI Farm v9", "Painel simplificado | Horses + training")
