--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/DogFireBattle/gakuran/blob/17bfd85455075a0908dd64c28a09505f2a98db6f/gakuranscript.lua
Source SHA-256: fb9490f58ebec4081a379d0287d3d9985a09bd4ed0f01bf1fab9632d921533a0
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2026 DogFireBattle

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

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local userInputService = game:GetService("UserInputService")
local virtualInputManager = game:GetService("VirtualInputManager")
local coreGui = game:GetService("CoreGui")
local g = type(getgenv) == "function" and getgenv() or _G
local v1 = {}
g.__DepHub = v1
local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
local v2 = {}

local function f1(p1)
  v2[#v2 + 1] = p1
  return p1
end

local v3 = {
  ESPEnabled = true,
  ShowHighlight = true,
  ShowName = true,
  ShowHP = true,
  ShowDistance = true,
  TeamCheck = false,
  PlayerColor = Color3.fromRGB(255, 0, 0),
  PlayerDeadColor = Color3.fromRGB(120, 0, 0),
  CrateEnabled = true,
  CrateColor = Color3.fromRGB(0, 255, 200),
  CrateNameMatch = "vought",
  HpBar = false,
  BoldText = false,
  TextSize = 13,
  MaxDistance = 0,
  UpdateInterval = 0.3,
  RescanInterval = 10,
  AimEnabled = false,
  AimPart = "Head",
  AimWallCheck = true,
  AimTeamCheck = true,
  AimFOV = 120,
  AimSmoothness = 6,
  AimPrediction = 0,
  AimShowFOV = true,
  AimAlwaysOn = false,
  AimSticky = false,
  Triggerbot = false,
  WalkSpeedOn = false,
  WalkSpeed = 16,
  JumpOn = false,
  JumpPower = 50,
  InfiniteJump = false,
  FlyOn = false,
  FlySpeed = 50,
  TpWalkOn = false,
  TpWalkSpeed = 60,
  Btools = false,
  AutoParry = false,
  HitboxESP = false,
  ParryRange = 14,
  ParryWindup = 490,
  ParryOffset = 120,
  ParryPingComp = true,
  ParryHold = 90,
  ParryBurst = 3,
  ParryBurstGap = 80,
  ParryDebug = false,
  RhythmBot = false,
  RhythmOffset = 0,
  RhythmHold = 60,
  PianoFile = "song.mid",
  PianoSpeed = 100,
  PianoTranspose = 24,
  AutoGreen = false,
  GreenOffset = 3,
}

local mouseButton2 = Enum.UserInputType.MouseButton2
local f = Enum.KeyCode.F

local function f2(p2)
  if p2:IsA("BasePart") then
    return p2.Position
  end

  if p2:IsA("Model") then
    local primaryPart = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart")
    return primaryPart and primaryPart.Position
  end

  return nil
end

local function f3()
  return v3.BoldText and Enum.Font.GothamBold or Enum.Font.Gotham
end

local v4 = {
  Head = { "Head" },
  Torso = { "UpperTorso", "Torso", "HumanoidRootPart" },
  ["Left Arm"] = { "LeftHand", "LeftLowerArm", "LeftUpperArm", "Left Arm" },
  ["Right Arm"] = { "RightHand", "RightLowerArm", "RightUpperArm", "Right Arm" },
  ["Left Leg"] = { "LeftFoot", "LeftLowerLeg", "LeftUpperLeg", "Left Leg" },
  ["Right Leg"] = { "RightFoot", "RightLowerLeg", "RightUpperLeg", "Right Leg" },
}

local function f4()
  local character = localPlayer.Character
  return character and (character.PrimaryPart or character:FindFirstChild("HumanoidRootPart"))
end

local function f5(p3)
  if not v3.TeamCheck then
    return true
  end

  if not p3.Team or not localPlayer.Team then
    return true
  end

  return p3.Team ~= localPlayer.Team
end

local function f6(p4)
  local v5 = f4()

  if v5 and p4 then
    return (v5.Position - p4).Magnitude
  end

  return nil
end

local function f7(p5)
  if p5 == localPlayer then
    return
  else
    local character2 = p5.Character
    local head = character2 and character2:FindFirstChild("Head")

    if not head or head:FindFirstChild("NameTag") then
      return
    else
      local nameTag = Instance.new("BillboardGui")
      nameTag.Name = "NameTag"
      nameTag.Adornee = head
      nameTag.Size = UDim2.new(0, 200, 0, 20)
      nameTag.StudsOffset = Vector3.new(0, 2.5, 0)
      nameTag.AlwaysOnTop = true
      nameTag.Parent = head

      local tagLabel = Instance.new("TextLabel")
      tagLabel.Name = "TagLabel"
      tagLabel.Size = UDim2.new(1, 0, 1, 0)
      tagLabel.BackgroundTransparency = 1
      tagLabel.TextColor3 = Color3.new(1, 1, 1)
      tagLabel.Font = f3()
      tagLabel.TextSize = v3.TextSize
      tagLabel.TextStrokeTransparency = 0.5
      tagLabel.Parent = nameTag

      return
    end
  end
end

local function f8(p6)
  if p6 == localPlayer then
    return
  else
    local character3 = p6.Character

    if not character3 or character3:FindFirstChild("ESPHighlight") then
      return
    else
      local espHighlight = Instance.new("Highlight")
      espHighlight.Name = "ESPHighlight"
      espHighlight.FillColor = v3.PlayerColor
      espHighlight.OutlineColor = Color3.new(1, 1, 1)
      espHighlight.FillTransparency = 0.6
      espHighlight.OutlineTransparency = 0
      espHighlight.Adornee = character3
      espHighlight.Parent = character3

      return
    end
  end
end

local function f9(p7)
  if p7 == localPlayer then
    return
  else
    local character4 = p7.Character

    if not character4 then
      return
    else
      f8(p7)
      f7(p7)
      local humanoid = character4:FindFirstChildOfClass("Humanoid")

      if not humanoid then
        return
      else
        local primaryPart2 = character4.PrimaryPart
          or character4:FindFirstChild("HumanoidRootPart")

        local v6 = primaryPart2 and f6(primaryPart2.Position) or 0
        local v7 = not v3.ESPEnabled or not f5(p7) or v3.MaxDistance > 0 and v6 > v3.MaxDistance
        local espHighlight2 = character4:FindFirstChild("ESPHighlight")

        if espHighlight2 then
          espHighlight2.Enabled = not v7 and v3.ShowHighlight
          espHighlight2.FillColor = humanoid.Health > 0 and v3.PlayerColor or v3.PlayerDeadColor
        end

        local head2 = character4:FindFirstChild("Head")
        local nameTag2 = head2 and head2:FindFirstChild("NameTag")

        if nameTag2 then
          local tagLabel2 = nameTag2:FindFirstChild("TagLabel")
          local showName = v3.ShowName or v3.ShowHP or v3.ShowDistance
          nameTag2.Enabled = not v7 and showName

          if tagLabel2 and nameTag2.Enabled then
            tagLabel2.Font = f3()
            tagLabel2.TextSize = v3.TextSize

            local v8 = {}

            if v3.ShowName then
              table.insert(v8, p7.Name)
            end

            if v3.ShowDistance then
              table.insert(v8, string.format("%.0fm", v6))
            end

            if v3.ShowHP then
              table.insert(v8, string.format("❤%d", math.floor(humanoid.Health)))
            end

            tagLabel2.Text = table.concat(v8, " | ")
          end
        end

        return
      end
    end
  end
end

local function f10(p8)
  if p8 == localPlayer then
    return
  end

  f1(p8.CharacterAdded:Connect(function()
    task.wait(0.1)
    f8(p8)
    f7(p8)
  end))

  if p8.Character then
    f8(p8)
    f7(p8)
  end
end

for index, value in ipairs(players:GetPlayers()) do
  f10(value)
end

local playerAdded = players.PlayerAdded

local function f11(p9, p10)
  local v9 = f2(p9)
  local v10 = v9 and f6(v9) or 0
  local v11 = not v3.CrateEnabled or v3.MaxDistance > 0 and v10 > v3.MaxDistance

  p10.Highlight.Enabled = not v11
  p10.Billboard.Enabled = not v11

  if v11 then
    return
  end

  p10.Highlight.FillColor = v3.CrateColor
  p10.Label.Font = f3()
  p10.Label.TextSize = v3.TextSize
  p10.Label.Text = string.format("🔴 VOUGHT CRATE | %.0fm", v10)
end

f1(playerAdded:Connect(f10))
local v12 = {}

local function f12(p11)
  return string.find(string.lower(p11.Name), v3.CrateNameMatch, 1, true) ~= nil
    and (p11:IsA("BasePart") or p11:IsA("Model"))
end

local function f13(p12)
  if not p12 or not f12(p12) or v12[p12] then
    return
  else
    if p12:IsA("Model") and not p12.PrimaryPart then
      local basePart = p12:FindFirstChildWhichIsA("BasePart")

      if not basePart then
        return
      end

      p12.PrimaryPart = basePart
    end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = v3.CrateColor
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = p12
    highlight.Parent = p12

    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 220, 0, 20)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Adornee = p12
    billboardGui.Parent = p12

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "🔴 VOUGHT CRATE"
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = f3()
    textLabel.TextSize = v3.TextSize
    textLabel.TextStrokeTransparency = 0.3
    textLabel.Parent = billboardGui

    v12[p12] = { Highlight = highlight, Billboard = billboardGui, Label = textLabel }
    return
  end
end

local f14

local function f15()
  local v13 = {}

  for index2, value2 in ipairs(workspace:GetDescendants()) do
    if f12(value2) then
      v13[value2] = true
    end
  end

  for key in pairs(v12) do
    if not v13[key] or not key.Parent then
      f14(key)
    end
  end

  for key2 in pairs(v13) do
    if not v12[key2] then
      f13(key2)
    end
  end
end

function f14(p13)
  local v14 = v12[p13]

  if v14 then
    if v14.Highlight then
      v14.Highlight:Destroy()
    end

    if v14.Billboard then
      v14.Billboard:Destroy()
    end

    v12[p13] = nil
  end
end

f1(workspace.DescendantAdded:Connect(function(descendant)
  if f12(descendant) then
    f13(descendant)
  end
end))

f1(workspace.DescendantRemoving:Connect(function(descendant2) f14(descendant2) end))

task.spawn(function()
  task.wait(1)
  f15()
end)

local v15 = false

local function f16(p14, p15)
  local position = currentCamera.CFrame.Position

  local raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams.FilterDescendantsInstances = { localPlayer.Character }

  local raycast = workspace:Raycast(position, p14.Position - position, raycastParams)

  if not raycast then
    return true
  end

  return raycast.Instance:IsDescendantOf(p15)
end

local function f17(p16)
  for index3, value3 in ipairs(v4[v3.AimPart] or {}) do
    local findFirstChild = p16:FindFirstChild(value3)

    if findFirstChild and findFirstChild:IsA("BasePart") then
      return findFirstChild
    end
  end

  return p16:FindFirstChild("HumanoidRootPart") or p16.PrimaryPart
end

local function f18(p17)
  if p17 == localPlayer then
    return false
  else
    local character5 = p17.Character

    if not character5 then
      return false
    else
      local humanoid2 = character5:FindFirstChildOfClass("Humanoid")

      if not humanoid2 or humanoid2.Health <= 0 then
        return false
      end

      if v3.AimTeamCheck and p17.Team and localPlayer.Team and p17.Team == localPlayer.Team then
        return false
      end

      return true
    end
  end
end

local function f19()
  return Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
end

local function f20()
  local v16 = f19()
  local v17, v18

  for index4, value4 in ipairs(players:GetPlayers()) do
    if f18(value4) then
      local character6 = value4.Character
      local v19 = f17(character6)

      if v19 then
        local v20, v21 = currentCamera:WorldToViewportPoint(v19.Position)

        if v21 then
          local magnitude = (Vector2.new(v20.X, v20.Y) - v16).Magnitude

          if magnitude <= v3.AimFOV and (not v18 or magnitude < v18) then
            if not v3.AimWallCheck or f16(v19, character6) then
              v17 = v19
              v18 = magnitude
            end
          end
        end
      end
    end
  end

  return v17
end

local v22, f21

local function f22()
  if v3.AimSticky and f21(v22) then
    return v22
  else
    local v23 = f20()
    v22 = v23
    return v23
  end
end

function f21(p18)
  if not p18 or not p18.Parent then
    return false
  else
    local model = p18:FindFirstAncestorWhichIsA("Model")

    if not model then
      return false
    else
      local humanoid3 = model:FindFirstChildOfClass("Humanoid")

      if not humanoid3 or humanoid3.Health <= 0 then
        return false
      else
        local v24, v25 = currentCamera:WorldToViewportPoint(p18.Position)

        if not v25 then
          return false
        elseif (Vector2.new(v24.X, v24.Y) - f19()).Magnitude > v3.AimFOV then
          return false
        else
          if v3.AimWallCheck and not f16(p18, model) then
            return false
          end

          return true
        end
      end
    end
  end
end

local aimKeyKeybind, v26

f1(runService.RenderStepped:Connect(function()
  if aimKeyKeybind then
    local v27 = aimKeyKeybind.getValue()

    if v27 then
      mouseButton2 = v27
    end
  end

  if v26 then
    v26.Visible = v3.AimEnabled and v3.AimShowFOV
    v26.Radius = v3.AimFOV
    v26.Position = f19()
  end

  if not v3.AimEnabled or not (v15 or v3.AimAlwaysOn) then
    v22 = nil
    return
  else
    local v28 = f22()

    if not v28 then
      return
    else
      local position2 = v28.Position
      local v29 = v3.AimPrediction / 100

      if v29 > 0 then
        position2 = position2 + v28.AssemblyLinearVelocity * v29
      end

      local cframe = CFrame.new(currentCamera.CFrame.Position, position2)
      local v30 = math.max(v3.AimSmoothness, 1)
      local v31 = math.clamp(1 / v30, 0, 1)
      currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, v31)
      return
    end
  end
end))

local function f23(p19)
  return p19.UserInputType == mouseButton2 or p19.KeyCode == mouseButton2
end

f1(userInputService.InputBegan:Connect(function(input)
  if f23(input) then
    v15 = true
  end
end))

f1(userInputService.InputEnded:Connect(function(input2)
  if f23(input2) then
    v15 = false
  end
end))

local v32 = 0

f1(runService.Heartbeat:Connect(function()
  if not v3.Triggerbot then
    return
  elseif tick() - v32 < 0.12 then
    return
  else
    local position3 = currentCamera.CFrame.Position

    local raycastParams2 = RaycastParams.new()
    raycastParams2.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams2.FilterDescendantsInstances = { localPlayer.Character }

    local raycast2 = workspace:Raycast(
      position3, currentCamera.CFrame.LookVector * 2000, raycastParams2
    )

    if not raycast2 then
      return
    else
      local model2 = raycast2.Instance:FindFirstAncestorWhichIsA("Model")
      local getPlayerFromCharacter = model2 and players:GetPlayerFromCharacter(model2)

      if not getPlayerFromCharacter then
        return
      else
        local humanoid4 = model2:FindFirstChildOfClass("Humanoid")

        if humanoid4 and humanoid4.Health > 0 and f18(getPlayerFromCharacter) then
          v32 = tick()
        end

        return
      end
    end
  end
end))

local bodyGyro = nil
local f24
local bodyVelocity

local function f25()
  local v33 = f4()

  if not v33 then
    return
  end

  f24()

  bodyVelocity = Instance.new("BodyVelocity")
  bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
  bodyVelocity.Velocity = Vector3.zero
  bodyVelocity.Parent = v33

  bodyGyro = Instance.new("BodyGyro")
  bodyGyro.MaxTorque = Vector3.new(100000, 100000, 100000)
  bodyGyro.P = 10000
  bodyGyro.Parent = v33
end

function f24()
  if bodyVelocity then
    bodyVelocity:Destroy()
    bodyVelocity = nil
  end

  if bodyGyro then
    bodyGyro:Destroy()
    bodyGyro = nil
  end
end

f1(userInputService.JumpRequest:Connect(function()
  if not v3.InfiniteJump then
    return
  else
    local character7 = localPlayer.Character
    local humanoid5 = character7 and character7:FindFirstChildOfClass("Humanoid")

    if humanoid5 then
      humanoid5:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    return
  end
end))

f1(runService.RenderStepped:Connect(function()
  if v3.FlyOn then
    if not bodyVelocity then
      f25()
    end

    if bodyVelocity and f4() then
      local cframe2 = currentCamera.CFrame
      local zero = Vector3.zero

      if userInputService:IsKeyDown(Enum.KeyCode.W) then
        zero = zero + cframe2.LookVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.S) then
        zero = zero - cframe2.LookVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.A) then
        zero = zero - cframe2.RightVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.D) then
        zero = zero + cframe2.RightVector
      end

      if userInputService:IsKeyDown(Enum.KeyCode.Space) then
        zero = zero + Vector3.new(0, 1, 0)
      end

      if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        zero = zero - Vector3.new(0, 1, 0)
      end

      local v34 = bodyVelocity
      v34.Velocity = (zero.Magnitude > 0 and zero.Unit or Vector3.zero) * v3.FlySpeed

      bodyGyro.CFrame = cframe2
    end
  elseif bodyVelocity then
    f24()
  end
end))

f1(runService.RenderStepped:Connect(function(delta)
  if not v3.TpWalkOn or v3.FlyOn then
    return
  else
    local character8 = localPlayer.Character
    local humanoidRootPart = character8 and character8:FindFirstChild("HumanoidRootPart")
    local humanoid6 = character8 and character8:FindFirstChildOfClass("Humanoid")

    if humanoidRootPart and humanoid6 and humanoid6.MoveDirection.Magnitude > 0 then
      humanoidRootPart.CFrame = humanoidRootPart.CFrame
        + humanoid6.MoveDirection * (v3.TpWalkSpeed * delta)
    end

    return
  end
end))

local getMouse = localPlayer:GetMouse()
local btoolsToggle

local function f26()
  if not v3.Btools then
    return
  end

  v3.Btools = false

  if btoolsToggle and btoolsToggle.setValue then
    pcall(function() btoolsToggle.setValue(false) end)
  end
end

f1(getMouse.Button1Down:Connect(function()
  if not v3.Btools then
    return
  end

  local target = getMouse.Target

  if target and target:IsA("BasePart") then
    pcall(function() target:Destroy() end)
  end
end))

local function f27(p20)
  local humanoid7 = p20:FindFirstChildOfClass("Humanoid") or p20:WaitForChild("Humanoid", 5)

  if humanoid7 then
    f1(humanoid7.Died:Connect(f26))
  end
end

if localPlayer.Character then
  f27(localPlayer.Character)
end

f1(localPlayer.CharacterAdded:Connect(function(character9)
  f26()
  f27(character9)
end))

f1(localPlayer.CharacterRemoving:Connect(f26))

local function f28(p21)
  local v35

  for index5, value5 in ipairs(players:GetPlayers()) do
    if value5 ~= localPlayer then
      local character10 = value5.Character

      local humanoidRootPart2 = character10
      humanoidRootPart2 = character10 and value5.Character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart2 then
        local magnitude2 = (humanoidRootPart2.Position - p21).Magnitude

        if not v35 or magnitude2 < v35 then
          v35 = magnitude2
        end
      end
    end
  end

  return v35 or 999
end

local function f29(p22)
  local v36, v37

  for index6, value6 in ipairs(players:GetPlayers()) do
    local character11 = value6.Character

    local humanoidRootPart3 = character11
    humanoidRootPart3 = character11 and value6.Character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart3 then
      local magnitude3 = (humanoidRootPart3.Position - p22).Magnitude

      if not v37 or magnitude3 < v37 then
        v37 = magnitude3
        v36 = value6
      end
    end
  end

  return v36 == localPlayer
end

local function f30(p23)
  local value7 = typeof(p23) == "EnumItem" and p23.Value or p23

  if pcall(function() virtualInputManager:SendKeyEvent(true, p23, false, game) end) then
    return "VirtualInputManager"
  end

  if keypress and pcall(function() keypress(value7) end) then
    return "keypress"
  end

  return nil
end

local f31

local function f32(p24, p25)
  local v38 = f30(p24)

  if not v38 then
    return nil
  end

  task.wait(p25)
  f31(p24)
  return v38
end

function f31(p26)
  local value8 = typeof(p26) == "EnumItem" and p26.Value or p26

  if not pcall(function() virtualInputManager:SendKeyEvent(false, p26, false, game) end) then
    if keyrelease then
      pcall(function() keyrelease(value8) end)
    end
  end
end

local parryKeyKeybind

local function f33()
  local v39 = parryKeyKeybind and parryKeyKeybind.getValue() or f
  local v40 = math.max(1, v3.ParryBurst)

  task.spawn(function()
    local v41

    for i = 1, v40 do
      v41 = f32(v39, v3.ParryHold / 1000) or v41

      if i < v40 then
        task.wait(v3.ParryBurstGap / 1000)
      end
    end

    if v3.ParryDebug then
      print(("[Parry] жму %s x%d | метод=%s"):format(tostring(v39 and v39.Name), v40, tostring(v41
        or "НЕТ (ввод недоступен)")))
    end
  end)
end

local function f34(p27)
  if not p27:IsA("BasePart") then
    return
  end

  if v3.HitboxESP then
    local v42 = f4()
    local v43 = v42 and (p27.Position - v42.Position).Magnitude <= p27.Size.Magnitude / 2 + 4

    local depHitboxBox = Instance.new("SelectionBox")
    depHitboxBox.Name = "DepHitboxBox"
    depHitboxBox.Adornee = p27
    depHitboxBox.Color3 = v43 and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(255, 200, 0)
    depHitboxBox.SurfaceColor3 = depHitboxBox.Color3
    depHitboxBox.SurfaceTransparency = 0.85
    depHitboxBox.LineThickness = 0.06
    depHitboxBox.Parent = p27
  end

  if v3.AutoParry then
    task.wait()
    local v44 = f4()

    if not v44 or not p27.Parent then
      return
    elseif f29(p27.Position) then
      return
    elseif (p27.Position - v44.Position).Magnitude > p27.Size.Magnitude / 2 + 7 then
      return
    else
      if f28(p27.Position) > v3.ParryRange then
        return
      end

      local v45 = 0

      if v3.ParryPingComp then
        local v46, v47 = pcall(function() return localPlayer:GetNetworkPing() end)
        v45 = v46 and v47 or 0
      end

      local v48 = (v3.ParryWindup - v3.ParryOffset) / 1000 - v45

      if v3.ParryDebug then
        print(("[Parry] входящий удар '%s' | парри через %.3fс"):format(p27.Name, math.max(
          v48, 0
        )))
      end

      task.delay(math.max(v48, 0), f33)
      return
    end
  else
    return
  end
end

task.spawn(function()
  local waitForChild = workspace:WaitForChild("Hitboxes", 30)

  if not waitForChild then
    warn("[Dep Hub] Workspace.Hitboxes не найдена — AutoParry/Hitbox ESP выключены.")
    return
  end

  f1(waitForChild.ChildAdded:Connect(f34))
end)

local playerGui = localPlayer:WaitForChild("PlayerGui")

local function f35()
  local rhythmServiceUI = playerGui:FindFirstChild("RhythmServiceUI")
  local v49 = {}

  if not rhythmServiceUI then
    return v49
  end

  for index7, value9 in ipairs(rhythmServiceUI:GetDescendants()) do
    if value9:IsA("Frame") and value9.Name:sub(1, 8) == "Receptor"
      and not value9.Name:find("Glow") then
      local findFirstChild2 = value9:FindFirstChild("KeyHint", true)

      local text = findFirstChild2 and findFirstChild2:IsA("TextLabel") and findFirstChild2.Text
        or "?"

      v49[#v49 + 1] = value9.Name .. "=" .. text
    end
  end

  return v49
end

local v50 = {
  ["0"] = Enum.KeyCode.Zero,
  ["1"] = Enum.KeyCode.One,
  ["2"] = Enum.KeyCode.Two,
  ["3"] = Enum.KeyCode.Three,
  ["4"] = Enum.KeyCode.Four,
  ["5"] = Enum.KeyCode.Five,
  ["6"] = Enum.KeyCode.Six,
  ["7"] = Enum.KeyCode.Seven,
  ["8"] = Enum.KeyCode.Eight,
  ["9"] = Enum.KeyCode.Nine,
}

local function f36(p28)
  if not p28 or p28 == "" then
    return nil
  end

  local w = p28:match("%w")

  if not w then
    return nil
  elseif v50[w] then
    return v50[w]
  else
    local v51, v52 = pcall(function() return Enum.KeyCode[w:upper()] end)

    if v51 and v52 then
      return v52
    end

    return nil
  end
end

local function f37(p29)
  local tail = p29:FindFirstChild("Tail")
  local head3 = p29:FindFirstChild("Head")

  if not tail then
    return false
  else
    local y = head3 and head3.AbsoluteSize.Y or 80
    return tail.AbsoluteSize.Y > y * 1.5
  end
end

local function f38(p30)
  local findFirstChild3 = p30:FindFirstChild("KeyHint", true)
  return f36(findFirstChild3 and findFirstChild3:IsA("TextLabel") and findFirstChild3.Text)
end

local v53 = {}

local function f39(p31)
  local v54 = v53[p31]

  if v54 then
    f31(v54.key)
    v53[p31] = nil
  end
end

local v55 = {}

local function f40(p32)
  local y2 = p32.AbsolutePosition.Y
  local tail2 = p32:FindFirstChild("Tail")

  if tail2 then
    y2 = math.min(y2, tail2.AbsolutePosition.Y)
  end

  return y2
end

local v56 = {}

f1(runService.RenderStepped:Connect(function()
  if not v3.RhythmBot then
    return
  else
    local rhythmServiceUI2 = playerGui:FindFirstChild("RhythmServiceUI")

    if not rhythmServiceUI2 then
      return
    else
      local v57 = {}
      local v58 = {}

      for index8, value10 in ipairs(rhythmServiceUI2:GetDescendants()) do
        if value10:IsA("Frame") then
          local name = value10.Name

          if name == "NoteTemplate" and value10.Visible then
            v57[#v57 + 1] = value10
          elseif name:sub(1, 8) == "Receptor" and not name:find("Glow") then
            v58[#v58 + 1] = value10
          end
        end
      end

      if #v58 == 0 then
        return
      end

      for index9, value11 in ipairs(v57) do
        local head4 = value11:FindFirstChild("Head") or value11
        local v59 = head4.AbsolutePosition + head4.AbsoluteSize / 2

        if v59.Y > -3000 then
          local v60 = nil
          local v61 = nil

          for index10, value12 in ipairs(v58) do
            local v62 = math.abs(v59.X - (value12.AbsolutePosition + value12.AbsoluteSize / 2).X)

            if not v60 or v62 < v60 then
              v61 = value12
              v60 = v62
            end
          end

          if v61 and v60 <= v61.AbsoluteSize.X then
            local v63 = v61.AbsolutePosition.Y + v61.AbsoluteSize.Y / 2 - v3.RhythmOffset
            local v64 = v55[value11]

            if v53[value11] then
              if f40(value11) >= v63 or tick() - v53[value11].start > 6 then
                f39(value11)
                v56[value11] = true
              end
            elseif v64 and not v56[value11] then
              if v64 < v63 and v59.Y >= v63 or v64 > v63 and v59.Y <= v63 then
                local v65 = f38(v61)

                if v65 then
                  if f37(value11) then
                    if f30(v65) then
                      v53[value11] = { key = v65, start = tick() }
                    end
                  else
                    v56[value11] = true
                    task.spawn(function() f32(v65, v3.RhythmHold / 1000) end)
                  end
                end
              end
            end

            v55[value11] = v59.Y
          end
        end
      end

      for key3 in pairs(v55) do
        if not key3.Parent or not key3.Visible then
          if v53[key3] then
            f39(key3)
          end

          v55[key3] = nil
          v56[key3] = nil
        end
      end

      return
    end
  end
end))

local v66 = {}

local v67 = {
  [2] = true,
  [4] = true,
  [7] = true,
  [9] = true,
  [11] = true,
}

local count = 0
local sub = "1"

for j = 1, 61 do
  if v67[(j - 1) % 12 + 1] then
    v66[j] = { char = sub, shift = true }
  else
    count = count + 1
    sub = ("1234567890qwertyuiopasdfghjklzxcvbnm"):sub(count, count)
    v66[j] = { char = sub, shift = false }
  end
end

local function f41(p33)
  local v68 = type(p33) ~= "string" or p33:sub(1, 4) ~= "MThd"
  local v69, f42, v70, v71

  if v68 then
    return nil, "не MIDI-файл (нет заголовка MThd)"
  else
    v69 = 1

    function f42()
      local byte = p33:byte(v69)
      v69 = v69 + 1
      return byte
    end

    local function f43()
      local v72, v73 = p33:byte(v69, v69 + 1)
      v69 = v69 + 2
      return v72 * 256 + v73
    end

    local function f44()
      local v74, v75, v76, v77 = p33:byte(v69, v69 + 3)
      v69 = v69 + 4
      return ((v74 * 256 + v75) * 256 + v76) * 256 + v77
    end

    local function f45()
      local v78 = 0

      while true do
        local v79 = f42()
        v78 = v78 * 128 + v79 % 128

        if v79 < 128 then
          break
        end
      end

      return v78
    end

    v69 = 5
    f44()
    f43()
    local v80 = f43()
    v70 = f43()

    if v70 >= 32768 then
      return nil, "SMPTE-тайминг не поддерживается"
    else
      v71 = {}
      local v81 = {}

      for k = 1, v80 do
        if p33:sub(v69, v69 + 3) ~= "MTrk" then
          break
        else
          v69 = v69 + 4
          local v82 = v69 + f44()
          local v83 = nil
          local total = 0

          while v69 < v82 do
            total = total + f45()
            local byte2 = p33:byte(v69)

            if byte2 < 128 then
              byte2 = v83
            else
              v69 = v69 + 1
              v83 = byte2
            end

            if not byte2 then
              break
            else
              local v84 = math.floor(byte2 / 16)

              if v84 == 9 then
                local note = f42()
                local v85 = f42()
                v81[#v81 + 1] = { tick = total, note = note, on = v85 > 0 }
              elseif v84 == 8 then
                f42()
                f42()
              elseif v84 == 10 or v84 == 11 or v84 == 14 then
                v69 = v69 + 2
              elseif v84 == 12 or v84 == 13 then
                v69 = v69 + 1
              elseif byte2 == 255 then
                local v86 = f42()
                local v87 = f45()

                if v86 == 81 and v87 == 3 then
                  local v88, v89, v90 = p33:byte(v69, v69 + 2)
                  v71[#v71 + 1] = { tick = total, uspq = (v88 * 256 + v89) * 256 + v90 }
                end

                v69 = v69 + v87
              elseif byte2 == 240 or byte2 == 247 then
                v69 = v69 + f45()
              else
                break
              end
            end
          end

          v69 = v82
        end
      end

      table.sort(v81, function(p34, p35) return p34.tick < p35.tick end)
      table.sort(v71, function(p36, p37) return p36.tick < p37.tick end)

      local v91 = {}

      local function f46(p38)
        local uspq = 500000
        local v92 = 0
        local total2 = 0

        for index11, value13 in ipairs(v71) do
          if value13.tick >= p38 then
            break
          end

          total2 = total2 + (value13.tick - v92) / v70 * (uspq / 1000000)
          v92 = value13.tick
          uspq = value13.uspq
        end

        return total2 + (p38 - v92) / v70 * (uspq / 1000000)
      end

      for index12, value14 in ipairs(v81) do
        if value14.on then
          v91[#v91 + 1] = { time = f46(value14.tick), note = value14.note }
        end
      end

      return v91
    end
  end
end

local function f47(p39)
  if p39 == "" then
    return nil
  elseif v50[p39] then
    return v50[p39]
  else
    local v93, v94 = pcall(function() return Enum.KeyCode[p39:upper()] end)

    if v93 and v94 then
      return v94
    end

    return nil
  end
end

local function f48()
  local character12 = localPlayer.Character
  local humanoidRootPart4 = character12 and character12:FindFirstChild("HumanoidRootPart")

  local basketballShotMeterAttach = humanoidRootPart4
    and humanoidRootPart4:FindFirstChild("BasketballShotMeterAttach")

  local basketballShotBillboard = basketballShotMeterAttach
    and basketballShotMeterAttach:FindFirstChild("BasketballShotBillboard")

  return basketballShotBillboard and basketballShotBillboard:FindFirstChild("Meter", true)
end

local v95 = { notes = nil, playing = false }

local function f49(p40)
  return p40.G > 0.75 and p40.R < 0.4 and p40.B < 0.6
end

local function f50(p41)
  local v96 = v66[p41 - 36 + 1 + (v3.PianoTranspose - 24)]

  if not v96 then
    return
  end

  local v97 = f47(v96.char)

  if not v97 then
    return
  end

  task.spawn(function()
    if v96.shift then
      f30(Enum.KeyCode.LeftShift)
    end

    f30(v97)
    task.wait(0.03)
    f31(v97)

    if v96.shift then
      f31(Enum.KeyCode.LeftShift)
    end
  end)
end

local f51

local function f52()
  if not v95.notes or #v95.notes == 0 or v95.playing then
    return
  end

  v95.playing = true

  task.spawn(function()
    local v98 = os.clock()

    for index13, value15 in ipairs(v95.notes) do
      if not v95.playing then
        break
      else
        local v99 = value15.time / (v3.PianoSpeed / 100) - (os.clock() - v98)

        if v99 > 0 then
          task.wait(v99)
        end

        if not v95.playing then
          break
        end

        f50(value15.note)
      end
    end

    f51()
  end)
end

function f51()
  v95.playing = false
  f31(Enum.KeyCode.LeftShift)
end

local function f53(p42)
  if type(readfile) ~= "function" then
    return nil, "readfile недоступен в этом эксплойте"
  else
    local v100, v101 = pcall(readfile, p42)

    if not v100 or not v101 then
      return nil, "файл не найден: " .. tostring(p42)
        .. " (положи .mid в папку workspace эксплойта)"
    end

    return f41(v101)
  end
end

local v102 = false

f1(runService.RenderStepped:Connect(function()
  if not v3.AutoGreen then
    return
  else
    local v103 = f48()

    if not v103 or not v103.Visible then
      v102 = false
      return
    else
      local findFirstChild4 = v103:FindFirstChild("Needle", true)

      if not findFirstChild4 then
        return
      else
        local v104 = findFirstChild4.AbsolutePosition.Y + findFirstChild4.AbsoluteSize.Y / 2

        for index14, value16 in ipairs(v103:GetChildren()) do
          if value16:IsA("Frame") and value16 ~= findFirstChild4
            and f49(value16.BackgroundColor3) then
            if v104 >= value16.AbsolutePosition.Y - v3.GreenOffset
              and v104 <= value16.AbsolutePosition.Y + value16.AbsoluteSize.Y + v3.GreenOffset then
              if not v102 then
                v102 = true
                task.spawn(function() f31(Enum.KeyCode.F) end)
              end

              break
            end
          end
        end

        return
      end
    end
  end
end))

local depHpBar = Instance.new("ScreenGui")
depHpBar.Name = "DepHpBar"
depHpBar.ResetOnSpawn = false
depHpBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
depHpBar.DisplayOrder = 999
depHpBar.Enabled = false

depHpBar.Parent = gethui and gethui()
  or runService:IsStudio() and localPlayer:WaitForChild("PlayerGui") or coreGui

local bar = Instance.new("Frame")
bar.Name = "Bar"
bar.Size = UDim2.new(0, 260, 0, 26)
bar.Position = UDim2.new(0.5, -130, 0.85, 0)
bar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
bar.BorderSizePixel = 0
bar.Active = true
bar.Parent = depHpBar

Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 6)

local fill = Instance.new("Frame")
fill.Name = "Fill"
fill.AnchorPoint = Vector2.new(0, 0.5)
fill.Position = UDim2.new(0, 0, 0.5, 0)
fill.Size = UDim2.new(1, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 255, 80)
fill.BorderSizePixel = 0
fill.Parent = bar

Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 6)

local text2 = Instance.new("TextLabel")
text2.Name = "Text"
text2.Size = UDim2.new(1, 0, 1, 0)
text2.BackgroundTransparency = 1
text2.Font = Enum.Font.GothamBold
text2.TextScaled = true
text2.TextColor3 = Color3.new(1, 1, 1)
text2.TextStrokeTransparency = 0.4
text2.ZIndex = 2
text2.Text = "100 / 100"
text2.Parent = bar

local v105, position4, position5

bar.InputBegan:Connect(function(input3)
  if input3.UserInputType == Enum.UserInputType.MouseButton1
    or input3.UserInputType == Enum.UserInputType.Touch then
    v105 = true
    position4 = input3.Position
    position5 = bar.Position

    input3.Changed:Connect(function()
      if input3.UserInputState == Enum.UserInputState.End then
        v105 = false
      end
    end)
  end
end)

f1(userInputService.InputChanged:Connect(function(input4)
  if v105
    and (input4.UserInputType == Enum.UserInputType.MouseMovement
      or input4.UserInputType == Enum.UserInputType.Touch) then
    local v106 = input4.Position - position4

    bar.Position = UDim2.new(
      position5.X.Scale, position5.X.Offset + v106.X, position5.Y.Scale,
      position5.Y.Offset + v106.Y
    )
  end
end))

f1(runService.Heartbeat:Connect(function()
  depHpBar.Enabled = v3.HpBar

  if not v3.HpBar then
    return
  else
    local character13 = localPlayer.Character
    local humanoid8 = character13 and character13:FindFirstChildOfClass("Humanoid")

    if not humanoid8 then
      return
    else
      local v107 = math.clamp(humanoid8.Health / math.max(humanoid8.MaxHealth, 1), 0, 1)

      fill.Size = UDim2.new(v107, 0, 1, 0)
      fill.BackgroundColor3 = Color3.fromRGB(255, 60, 60):Lerp(Color3.fromRGB(0, 255, 80), v107)

      text2.Text = string.format(
        "%d / %d", math.floor(humanoid8.Health), math.floor(humanoid8.MaxHealth)
      )

      return
    end
  end
end))

local v108 = 0

f1(runService.Heartbeat:Connect(function(delta2)
  local character14 = localPlayer.Character
  local humanoid9 = character14 and character14:FindFirstChildOfClass("Humanoid")

  if humanoid9 then
    if v3.WalkSpeedOn then
      humanoid9.WalkSpeed = v3.WalkSpeed
    end

    if v3.JumpOn then
      humanoid9.UseJumpPower = true
      humanoid9.JumpPower = v3.JumpPower
    end
  end

  v108 = v108 + delta2

  if v108 < v3.UpdateInterval then
    return
  end

  v108 = 0

  for index15, value17 in ipairs(players:GetPlayers()) do
    if value17 ~= localPlayer then
      f9(value17)
    end
  end

  for key4, value18 in pairs(v12) do
    if key4.Parent then
      f11(key4, value18)
    else
      f14(key4)
    end
  end
end))

local v109 = loadstring(game:HttpGet("https://raw.githubusercontent.com/HSp4m/roblox-ui-libs/main/src/libs/Hydra%20Lib/source.lua"))().new(
  "Dep Hub", localPlayer.UserId, "User"
)

local parent = v109.MainUI and v109.MainUI.Parent

local button = v109:Category("ESP", "http://www.roblox.com/asset/?id=8395621517"):Button(
  "Visuals", "http://www.roblox.com/asset/?id=8395747586"
)

local section = button:Section("Players", "Left")

section:Toggle({ Title = "ESP Enabled", Default = v3.ESPEnabled }, function(espEnabled)
  v3.ESPEnabled = espEnabled
end)

section:Toggle({ Title = "Highlight (box)", Default = v3.ShowHighlight }, function(showHighlight)
  v3.ShowHighlight = showHighlight
end)

section:Toggle({ Title = "Name", Default = v3.ShowName }, function(showName2)
  v3.ShowName = showName2
end)

section:Toggle({ Title = "Health", Default = v3.ShowHP }, function(showHP)
  v3.ShowHP = showHP
end)

section:Toggle({ Title = "Distance", Default = v3.ShowDistance }, function(showDistance)
  v3.ShowDistance = showDistance
end)

section:Toggle({
  Title = "Team Check",
  Description = "Скрывать союзников",
  Default = v3.TeamCheck,
}, function(teamCheck) v3.TeamCheck = teamCheck end)

section:ColorPicker({ Title = "Player Color", Default = v3.PlayerColor }, function(playerColor)
  v3.PlayerColor = playerColor
end)

local section2 = button:Section("Text & Crates", "Right")

section2:Toggle({
  Title = "Bold Text",
  Description = "Толстый / тонкий шрифт",
  Default = v3.BoldText,
}, function(boldText) v3.BoldText = boldText end)

section2:Slider({
  Title = "Text Size",
  Default = v3.TextSize,
  Min = 8,
  Max = 30,
}, function(textSize) v3.TextSize = textSize end)

section2:Slider({
  Title = "Max Distance (0=off)",
  Default = v3.MaxDistance,
  Min = 0,
  Max = 5000,
}, function(maxDistance) v3.MaxDistance = maxDistance end)

section2:Toggle({ Title = "Crate ESP", Default = v3.CrateEnabled }, function(crateEnabled)
  v3.CrateEnabled = crateEnabled
end)

section2:ColorPicker({ Title = "Crate Color", Default = v3.CrateColor }, function(crateColor)
  v3.CrateColor = crateColor
end)

section2:Toggle({
  Title = "HP Bar",
  Description = "Своя полоска HP (перетаскивай)",
  Default = v3.HpBar,
}, function(hpBar) v3.HpBar = hpBar end)

local button2 = v109:Category("Aimbot", "http://www.roblox.com/asset/?id=8395621517"):Button(
  "Aim", "http://www.roblox.com/asset/?id=8395747586"
)

local section3 = button2:Section("Main", "Left")

section3:Toggle({ Title = "Aimbot Enabled", Default = v3.AimEnabled }, function(aimEnabled)
  v3.AimEnabled = aimEnabled
end)

aimKeyKeybind = section3:Keybind({
  Title = "Aim Key",
  Description = "Клик, затем нажми клавишу или мышь",
  Default = mouseButton2,
}, function() end)

section3:Toggle({
  Title = "Wall Check",
  Description = "Только видимых (не через стены)",
  Default = v3.AimWallCheck,
}, function(aimWallCheck) v3.AimWallCheck = aimWallCheck end)

section3:Toggle({ Title = "Team Check", Default = v3.AimTeamCheck }, function(aimTeamCheck)
  v3.AimTeamCheck = aimTeamCheck
end)

local section4 = button2:Section("Target Part", "Right")
local v110 = {}
local v111 = false

local function f54(p43)
  v3.AimPart = p43
  v111 = true

  for key5, value19 in pairs(v110) do
    value19.setValue(key5 == p43)
  end

  v111 = false
end

for index16, value20 in ipairs({
  "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg",
}) do
  local v112 = value20

  v110[v112] = section4:Toggle({ Title = v112, Default = v112 == v3.AimPart }, function(p44)
    if v111 then
      return
    end

    if p44 then
      f54(v112)
    elseif v3.AimPart == v112 then
      v111 = true
      v110[v112].setValue(true)
      v111 = false
    end
  end)
end

local section5 = button2:Section("Tuning", "Left")

section5:Slider({
  Title = "FOV (px)",
  Default = v3.AimFOV,
  Min = 10,
  Max = 600,
}, function(aimFOV) v3.AimFOV = aimFOV end)

section5:Slider({
  Title = "Smoothness",
  Description = "1 = мгновенно",
  Default = v3.AimSmoothness,
  Min = 1,
  Max = 30,
}, function(aimSmoothness) v3.AimSmoothness = aimSmoothness end)

section5:Slider({
  Title = "Prediction (x0.01)",
  Default = v3.AimPrediction,
  Min = 0,
  Max = 50,
}, function(aimPrediction) v3.AimPrediction = aimPrediction end)

section5:Toggle({ Title = "Show FOV Circle", Default = v3.AimShowFOV }, function(aimShowFOV)
  v3.AimShowFOV = aimShowFOV
end)

local button3 = v109:Category("Movement", "http://www.roblox.com/asset/?id=8395621517"):Button(
  "Movement", "http://www.roblox.com/asset/?id=8395747586"
)

local section6 = button3:Section("Speed & Jump", "Left")

section6:Toggle({ Title = "WalkSpeed", Default = v3.WalkSpeedOn }, function(walkSpeedOn)
  v3.WalkSpeedOn = walkSpeedOn
end)

section6:Slider({
  Title = "WalkSpeed Value",
  Default = v3.WalkSpeed,
  Min = 16,
  Max = 300,
}, function(walkSpeed) v3.WalkSpeed = walkSpeed end)

section6:Toggle({ Title = "JumpPower", Default = v3.JumpOn }, function(jumpOn)
  v3.JumpOn = jumpOn
end)

section6:Slider({
  Title = "JumpPower Value",
  Default = v3.JumpPower,
  Min = 50,
  Max = 500,
}, function(jumpPower) v3.JumpPower = jumpPower end)

section6:Toggle({ Title = "Infinite Jump", Default = v3.InfiniteJump }, function(infiniteJump)
  v3.InfiniteJump = infiniteJump
end)

local section7 = button3:Section("Fly", "Right")

section7:Toggle({ Title = "Fly", Description = "WASD + Space/Ctrl", Default = v3.FlyOn }, function(flyOn)
  v3.FlyOn = flyOn
end)

section7:Slider({
  Title = "Fly Speed",
  Default = v3.FlySpeed,
  Min = 10,
  Max = 400,
}, function(flySpeed) v3.FlySpeed = flySpeed end)

section7:Toggle({
  Title = "TP Walk",
  Description = "Обход серверного WalkSpeed",
  Default = v3.TpWalkOn,
}, function(tpWalkOn) v3.TpWalkOn = tpWalkOn end)

section7:Slider({
  Title = "TP Walk Speed (x0.01)",
  Default = math.floor(v3.TpWalkSpeed * 100),
  Min = 1,
  Max = 56000,
}, function(p45) v3.TpWalkSpeed = p45 / 100 end)

btoolsToggle = section7:Toggle({
  Title = "Btools",
  Description = "Клик ЛКМ удаляет деталь под курсором",
  Default = v3.Btools,
}, function(btools) v3.Btools = btools end)

local button4 = v109:Category("Parry", "http://www.roblox.com/asset/?id=8395621517"):Button(
  "AutoParry", "http://www.roblox.com/asset/?id=8395747586"
)

local section8 = button4:Section("Main", "Left")

section8:Toggle({
  Title = "AutoParry",
  Description = "Парри по хитбоксу удара",
  Default = v3.AutoParry,
}, function(autoParry) v3.AutoParry = autoParry end)

parryKeyKeybind = section8:Keybind({
  Title = "Parry Key",
  Description = "Клик, затем нажми клавишу",
  Default = f,
}, function() end)

section8:Toggle({
  Title = "Ping Compensation",
  Description = "Парировать раньше на величину пинга",
  Default = v3.ParryPingComp,
}, function(parryPingComp) v3.ParryPingComp = parryPingComp end)

section8:Toggle({
  Title = "Hitbox ESP",
  Description = "Обводить хитбоксы ударов",
  Default = v3.HitboxESP,
}, function(hitboxESP) v3.HitboxESP = hitboxESP end)

section8:Toggle({
  Title = "Debug Log",
  Description = "Печатать срабатывания в консоль (F9)",
  Default = v3.ParryDebug,
}, function(parryDebug) v3.ParryDebug = parryDebug end)

section8:Button({
  Title = "Test Parry",
  ButtonName = "TEST",
  Description = "Проверить нажатие клавиши сейчас",
}, function()
  local v113 = parryKeyKeybind and parryKeyKeybind.getValue() or f
  local v114 = f32(v113, v3.ParryHold / 1000)

  v109:Notification({
    Title = "Test Parry",
    Desc = "Метод ввода: " .. tostring(v114 or "НЕ СРАБОТАЛ"),
  })

  print("[Parry][TEST] key=" .. tostring(v113 and v113.Name) .. " метод="
    .. tostring(v114 or "НЕТ"))
end)

local section9 = button4:Section("Timing", "Right")

section9:Slider({
  Title = "Hit Windup (ms)",
  Description = "От хитбокса до удара (~410)",
  Default = v3.ParryWindup,
  Min = 100,
  Max = 800,
}, function(parryWindup) v3.ParryWindup = parryWindup end)

section9:Slider({
  Title = "Parry Offset (ms)",
  Description = "Насколько раньше удара",
  Default = v3.ParryOffset,
  Min = 0,
  Max = 400,
}, function(parryOffset) v3.ParryOffset = parryOffset end)

section9:Slider({
  Title = "Parry Hold (ms)",
  Description = "Сколько держать клавишу",
  Default = v3.ParryHold,
  Min = 20,
  Max = 400,
}, function(parryHold) v3.ParryHold = parryHold end)

section9:Slider({
  Title = "Parry Burst",
  Description = "Кол-во нажатий (покрыть разброс тайминга)",
  Default = v3.ParryBurst,
  Min = 1,
  Max = 5,
}, function(parryBurst) v3.ParryBurst = parryBurst end)

section9:Slider({
  Title = "Burst Gap (ms)",
  Description = "Пауза между нажатиями бёрста",
  Default = v3.ParryBurstGap,
  Min = 30,
  Max = 150,
}, function(parryBurstGap) v3.ParryBurstGap = parryBurstGap end)

section9:Slider({
  Title = "Range",
  Description = "Радиус врага",
  Default = v3.ParryRange,
  Min = 5,
  Max = 40,
}, function(parryRange) v3.ParryRange = parryRange end)

local category = v109:Category("Rhythm", "http://www.roblox.com/asset/?id=8395621517")
local button5 = category:Button("AutoPlay", "http://www.roblox.com/asset/?id=8395747586")

local section10 = button5:Section("Main", "Left")

section10:Toggle({
  Title = "Auto-Rhythm",
  Description = "Сам жмёт ноты (клавиши читаются из игры)",
  Default = v3.RhythmBot,
}, function(rhythmBot) v3.RhythmBot = rhythmBot end)

section10:Button({
  Title = "Show Keys",
  ButtonName = "SHOW",
  Description = "Показать найденные клавиши дорожек",
}, function()
  local v115 = f35()

  local v116 = #v115 > 0 and table.concat(v115, "  ")
    or "не найдено (запусти во время игры)"

  v109:Notification({ Title = "Lane Keys", Desc = v116 })
  print("[Rhythm] дорожки: " .. v116)
end)

local section11 = button5:Section("Timing", "Right")

section11:Slider({
  Title = "Timing Offset (px)",
  Description = ">0 = жать раньше",
  Default = v3.RhythmOffset,
  Min = 0,
  Max = 200,
}, function(rhythmOffset) v3.RhythmOffset = rhythmOffset end)

section11:Slider({
  Title = "Key Hold (ms)",
  Description = "Сколько держать клавишу ноты",
  Default = v3.RhythmHold,
  Min = 20,
  Max = 200,
}, function(rhythmHold) v3.RhythmHold = rhythmHold end)

local button6 = category:Button("AutoPiano", "http://www.roblox.com/asset/?id=8395747586")

local section12 = button6:Section("MIDI", "Left")

section12:Textbox({
  Title = "MIDI File",
  Description = "Имя .mid в папке workspace",
  Default = v3.PianoFile,
}, function(p46)
  if p46 and p46 ~= "" then
    v3.PianoFile = p46
  end
end)

section12:Button({
  Title = "Load MIDI",
  ButtonName = "LOAD",
  Description = "Прочитать и распарсить файл",
}, function()
  local v117, v118 = f53(v3.PianoFile)

  if v117 then
    v95.notes = v117

    v109:Notification({
      Title = "MIDI загружен",
      Desc = ("Нот: %d | %s"):format(#v117, v3.PianoFile),
    })

    print("[Piano] загружено нот: " .. #v117)
  else
    v95.notes = nil
    v109:Notification({ Title = "Ошибка MIDI", Desc = tostring(v118) })
    print("[Piano] ошибка: " .. tostring(v118))
  end
end)

section12:Button({
  Title = "Play",
  ButtonName = "PLAY",
  Description = "Проиграть загруженный MIDI",
}, function()
  if not v95.notes then
    v109:Notification({ Title = "Piano", Desc = "Сначала Load MIDI" })
    return
  end

  f52()
end)

section12:Button({ Title = "Stop", ButtonName = "STOP", Description = "Остановить" }, function()
  f51()
end)

local section13 = button6:Section("Tuning", "Right")

section13:Slider({
  Title = "Speed %",
  Default = v3.PianoSpeed,
  Min = 25,
  Max = 400,
}, function(pianoSpeed) v3.PianoSpeed = pianoSpeed end)

section13:Slider({
  Title = "Transpose",
  Description = "24 = без сдвига (октавы/полутоны)",
  Default = v3.PianoTranspose,
  Min = 0,
  Max = 48,
}, function(pianoTranspose) v3.PianoTranspose = pianoTranspose end)

local section14 = category:Button("Basket", "http://www.roblox.com/asset/?id=8395747586"):Section(
  "AutoGreen", "Left"
)

section14:Toggle({
  Title = "AutoGreenBasket",
  Description = "Держи F — сам отпустит в зелёном",
  Default = v3.AutoGreen,
}, function(autoGreen) v3.AutoGreen = autoGreen end)

section14:Slider({
  Title = "Green Offset (px)",
  Description = ">0 = отпускать чуть раньше",
  Default = v3.GreenOffset,
  Min = 0,
  Max = 20,
}, function(greenOffset) v3.GreenOffset = greenOffset end)

local section15 = v109:Category("Settings", "http://www.roblox.com/asset/?id=8395621517"):Button(
  "Config", "http://www.roblox.com/asset/?id=8395747586"
):Section(
  "Menu", "Left"
)

section15:Slider({
  Title = "Menu Anim Speed",
  Default = 100,
  Min = 25,
  Max = 300,
}, function(p47) v109:setAnimSpeed(p47) end)

section15:Button({
  Title = "Menu Key",
  ButtonName = "Insert",
  Description = "Открыть/закрыть меню — Insert",
}, function() end)

section15:Button({
  Title = "Unload",
  ButtonName = "UNLOAD",
  Description = "Полностью выгрузить скрипт",
}, function()
  if v1.unload then
    v1.unload()
  end
end)

pcall(function()
  local mainUI = v109.MainUI and v109.MainUI:FindFirstChild("MainUI")
  local sidebar = mainUI and mainUI:FindFirstChild("Sidebar")
  local contentHolder = sidebar and sidebar:FindFirstChild("ContentHolder")
  local cheats = contentHolder and contentHolder:FindFirstChild("Cheats")
  local cheatHolder = cheats and cheats:FindFirstChild("CheatHolder")

  if not cheatHolder then
    return
  else
    local v119 = {}

    for index17, value21 in ipairs(cheatHolder:GetChildren()) do
      if value21:IsA("GuiObject") then
        v119[#v119 + 1] = value21
      end
    end

    local v120 = #v119

    if v120 > 4 then
      local v121 = 1 / v120

      for index18, value22 in ipairs(v119) do
        value22.Size = UDim2.new(1, 0, v121, 0)
      end
    end

    return
  end
end)

f1(userInputService.InputBegan:Connect(function(input5, p48)
  if p48 then
    return
  end

  if input5.KeyCode == Enum.KeyCode.Insert and parent then
    parent.Enabled = not parent.Enabled
  end
end))

function v1.unload()
  for index19, value23 in ipairs(v2) do
    local v122 = value23
    pcall(function() v122:Disconnect() end)
  end

  f24()
  f51()

  if depHpBar then
    pcall(function() depHpBar:Destroy() end)
  end

  for key6 in pairs(v53) do
    f39(key6)
  end

  if v26 then
    pcall(function() v26:Remove() end)
  end

  for index20, value24 in ipairs(players:GetPlayers()) do
    local character15 = value24.Character

    if character15 then
      local espHighlight3 = character15:FindFirstChild("ESPHighlight")

      if espHighlight3 then
        espHighlight3:Destroy()
      end

      local head5 = character15:FindFirstChild("Head")
      local nameTag3 = head5 and head5:FindFirstChild("NameTag")

      if nameTag3 then
        nameTag3:Destroy()
      end
    end
  end

  for key7 in pairs(v12) do
    f14(key7)
  end

  local hitboxes = workspace:FindFirstChild("Hitboxes")

  if hitboxes then
    for index21, value25 in ipairs(hitboxes:GetDescendants()) do
      if value25.Name == "DepHitboxBox" then
        value25:Destroy()
      end
    end
  end

  if parent then
    pcall(function() parent:Destroy() end)
  end

  g.__DepHub = nil
end

v109:Notification({ Title = "Загружено", Desc = "Dep Hub готов. Меню: Insert" })
print("[Dep Hub] Меню загружено.")
