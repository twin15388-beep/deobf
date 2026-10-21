--[[
Game source provenance | DEOBFUSCATED | NOT TESTED IN ROBLOX
Original: https://github.com/GreenicScripts/Nexus-Hub/blob/7b6c8172503bb418f9e45bd113d384bc4ee8bf2a/main.lua
Source SHA-256: 3d17a78ae7b5b15f6a818a4a9469ec2fe3efcfe0001b00d8fa1c959644642eba
Static recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2026 GreenicScripts

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
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local virtualInputManager = game:GetService("VirtualInputManager")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local stats = game:GetService("Stats")
local teleportService = game:GetService("TeleportService")
local coreGui = game:GetService("CoreGui")
local httpService = game:GetService("HttpService")

local touchEnabled, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, f17,
  f18, f19, f20, f21, f22, f23, localPlayer, currentCamera, waitForChild, v1, v2, v3, v4, v5,
  v6, v7, v8, v9, v10, v11, v12, walkSpeed, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22,
  v23, v24, v25, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36, connect, v37, v38, v39,
  f24, f25, f26, f27, f28, f29, f30, f31, v40, f32, f33, sound, v41, rayfield, parries0Label,
  fps60Label, ballSpeedLabel, label, statusWaitingLabel

if game.PlaceId ~= 13772394625 then
  local nexusRedirectGui = coreGui:FindFirstChild("NexusRedirectGui")

  if nexusRedirectGui then
    nexusRedirectGui:Destroy()
  end

  local nexusRedirectGui2 = Instance.new("ScreenGui")
  nexusRedirectGui2.Name = "NexusRedirectGui"
  nexusRedirectGui2.ResetOnSpawn = false
  nexusRedirectGui2.IgnoreGuiInset = true
  nexusRedirectGui2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  nexusRedirectGui2.Parent = coreGui

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(1, 0, 1, 0)
  frame.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
  frame.BorderSizePixel = 0
  frame.Parent = nexusRedirectGui2

  local frame2 = Instance.new("Frame")
  frame2.Size = UDim2.new(0, 380, 0, 200)
  frame2.Position = UDim2.new(0.5, -190, 0.6, -100)
  frame2.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
  frame2.BorderSizePixel = 0
  frame2.Parent = frame

  Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 14)

  local instance = Instance.new("UIStroke", frame2)
  instance.Color = Color3.fromRGB(108, 55, 245)
  instance.Thickness = 1.5

  local textLabel = Instance.new("TextLabel")
  textLabel.Text = "⚠"
  textLabel.Font = Enum.Font.GothamBold
  textLabel.TextSize = 36
  textLabel.TextColor3 = Color3.fromRGB(255, 180, 40)
  textLabel.BackgroundTransparency = 1
  textLabel.Size = UDim2.new(1, 0, 0, 44)
  textLabel.Position = UDim2.new(0, 0, 0, 12)
  textLabel.TextXAlignment = Enum.TextXAlignment.Center
  textLabel.Parent = frame2

  local textLabel2 = Instance.new("TextLabel")
  textLabel2.Text = "Sorry, You're in the Wrong Game"
  textLabel2.Font = Enum.Font.GothamBold
  textLabel2.TextSize = 17
  textLabel2.TextColor3 = Color3.fromRGB(235, 235, 245)
  textLabel2.BackgroundTransparency = 1
  textLabel2.Size = UDim2.new(1, -20, 0, 24)
  textLabel2.Position = UDim2.new(0, 10, 0, 58)
  textLabel2.TextXAlignment = Enum.TextXAlignment.Center
  textLabel2.Parent = frame2

  local textLabel3 = Instance.new("TextLabel")
  textLabel3.Text = "Redirecting you to Blade Ball..."
  textLabel3.Font = Enum.Font.Gotham
  textLabel3.TextSize = 13
  textLabel3.TextColor3 = Color3.fromRGB(140, 130, 200)
  textLabel3.BackgroundTransparency = 1
  textLabel3.Size = UDim2.new(1, -20, 0, 20)
  textLabel3.Position = UDim2.new(0, 10, 0, 88)
  textLabel3.TextXAlignment = Enum.TextXAlignment.Center
  textLabel3.Parent = frame2

  local textLabel4 = Instance.new("TextLabel")
  textLabel4.Text = "Joining in 3..."
  textLabel4.Font = Enum.Font.GothamBold
  textLabel4.TextSize = 22
  textLabel4.TextColor3 = Color3.fromRGB(108, 55, 245)
  textLabel4.BackgroundTransparency = 1
  textLabel4.Size = UDim2.new(1, -20, 0, 30)
  textLabel4.Position = UDim2.new(0, 10, 0, 116)
  textLabel4.TextXAlignment = Enum.TextXAlignment.Center
  textLabel4.Parent = frame2

  local frame3 = Instance.new("Frame")
  frame3.Size = UDim2.new(1, -40, 0, 4)
  frame3.Position = UDim2.new(0, 20, 1, -22)
  frame3.BackgroundColor3 = Color3.fromRGB(28, 26, 44)
  frame3.BorderSizePixel = 0
  frame3.Parent = frame2

  Instance.new("UICorner", frame3).CornerRadius = UDim.new(1, 0)

  local frame4 = Instance.new("Frame")
  frame4.Size = UDim2.new(0, 0, 1, 0)
  frame4.BackgroundColor3 = Color3.fromRGB(108, 55, 245)
  frame4.BorderSizePixel = 0
  frame4.Parent = frame3

  Instance.new("UICorner", frame4).CornerRadius = UDim.new(1, 0)

  local textLabel5 = Instance.new("TextLabel")
  textLabel5.Text = "⚡ Nexus Hub  •  Minh Scripts + Greenic Scripts"
  textLabel5.Font = Enum.Font.Gotham
  textLabel5.TextSize = 10
  textLabel5.TextColor3 = Color3.fromRGB(80, 75, 110)
  textLabel5.BackgroundTransparency = 1
  textLabel5.Size = UDim2.new(1, 0, 0, 18)
  textLabel5.Position = UDim2.new(0, 0, 1, -20)
  textLabel5.TextXAlignment = Enum.TextXAlignment.Center
  textLabel5.Parent = frame

  tweenService:Create(
    frame2, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Position = UDim2.new(0.5, -190, 0.5, -100) }
  ):Play()

  task.wait(0.45)

  for i = 3, 1, -1 do
    textLabel4.Text = "Joining in " .. i .. "..."

    tweenService:Create(frame4, TweenInfo.new(0.9, Enum.EasingStyle.Linear), {
      Size = UDim2.new((4 - i) / 3, 0, 1, 0),
    }):Play()

    task.wait(1)
  end

  textLabel4.Text = "Joining now! ✓"
  tweenService:Create(frame4, TweenInfo.new(0.2), { Size = UDim2.new(1, 0, 1, 0) }):Play()
  task.wait(0.35)

  tweenService:Create(frame, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()

  tweenService:Create(frame2, TweenInfo.new(0.3), {
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, -190, 0.42, -100),
  }):Play()

  task.wait(0.4)
  teleportService:Teleport(13772394625, players.LocalPlayer)
  return
else
  localPlayer = players.LocalPlayer
  currentCamera = workspace.CurrentCamera
  waitForChild = workspace:WaitForChild("Balls", 9000000000)
  touchEnabled = userInputService.TouchEnabled and not userInputService.MouseEnabled
  v1 = {}
  v2 = false
  v3 = 0
  v4 = false
  v5 = false
  v6 = false
  v7 = nil
  v8 = false
  v9 = 0
  v10 = tick()
  v11 = tick()
  v12 = false
  walkSpeed = 36
  v13 = 1.1
  v14 = 1.1
  v15 = 2.5
  v16 = "Camera"

  function f1()
    if v1.Triggerbot then
      v1.Triggerbot:Disconnect()
      v1.Triggerbot = nil
    end
  end

  v17 = false
  v18 = false
  v19 = false
  v20 = false
  v21 = false
  v22 = false
  v23 = false
  v24 = false
  v25 = false
  v26 = false
  v27 = false
  v28 = false
  v29 = 0
  v30 = 60
  v31 = "—"

  function f2()
    virtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    virtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
  end

  v32 = 0
  v33 = "Waiting..."
  v34 = false
  v35 = "Default"
  v36 = nil
  connect = nil
  v37 = {}
  v38 = { "Default" }

  function f3()
    if v1.LobbyAP then
      v1.LobbyAP:Disconnect()
      v1.LobbyAP = nil
    end
  end

  v39 = {
    pX = 0,
    pY = 0,
    pZ = 0,
    rX = 0,
    rY = 0,
    rZ = 0,
  }

  function f4(p1)
    if not p1 then
      return nil
    end

    for index, value in ipairs(p1:GetChildren()) do
      if (value:IsA("Accessory") or value:IsA("Model") or value:IsA("Tool"))
        and not value.Name:match("^Fake_") then
        local lower = value.Name:lower()

        if lower:match("sword") or lower:match("blade") or lower:match("weapon")
          or lower:match("katana") or lower:match("scythe") then
          return value
        end
      end
    end

    return nil
  end

  function f5(p2)
    if not (p2:IsA("Model") or p2:IsA("Accessory") or p2:IsA("Tool")) then
      return false
    end

    if p2:FindFirstChildWhichIsA("Humanoid", true) then
      return false
    end

    if p2.Name:match("^Fake_") then
      return false
    else
      local lower2 = p2.Name:lower()

      for index2, value2 in ipairs({
        "head", "torso", "arm", "leg", "hand", "foot", "humanoid", "root", "fake", "aura",
        "shield", "effect",
      }) do
        if lower2:match(value2) then
          return false
        end
      end

      if p2:IsA("Accessory") then
        local handle = p2:FindFirstChild("Handle")

        if handle then
          for index3, value3 in ipairs(handle:GetChildren()) do
            if value3:IsA("Attachment") then
              local name = value3.Name

              if not name:match("Weapon") and not name:match("Grip") then
                if name:match("Hair") or name:match("Hat") or name:match("Face")
                  or name:match("Neck") or name:match("Shoulder") or name:match("Waist")
                  or name:match("Body") then
                  return false
                end
              end
            end
          end
        end

        for index4, value4 in ipairs(p2:GetDescendants()) do
          if value4:IsA("MeshPart") or value4:IsA("UnionOperation")
            or value4:FindFirstChildWhichIsA("DataModelMesh")
            or value4:IsA("BasePart") and value4.Transparency < 1 then
            return true
          end
        end

        return false
      end

      for index5, value5 in ipairs(p2:GetDescendants()) do
        if value5:IsA("MeshPart") or value5:IsA("UnionOperation")
          or value5:FindFirstChildWhichIsA("DataModelMesh")
          or value5:IsA("BasePart") and value5.Transparency < 1 then
          return true
        end
      end

      return false
    end
  end

  function f6(p3)
    for index6, value6 in ipairs(p3:GetChildren()) do
      if value6:IsA("StringValue") then
        local lower3 = value6.Name:lower()

        if lower3 == "displayname" or lower3 == "realname" or lower3 == "title" then
          if value6.Value and value6.Value ~= "" then
            return f24(value6.Value)
          end
        end
      end
    end

    local displayName = p3:GetAttribute("DisplayName")

    local realName = displayName
    realName = displayName or p3:GetAttribute("RealName")

    if realName and type(realName) == "string" and realName ~= "" then
      return f24(realName)
    end

    return f24(p3.Name)
  end

  function f24(p4)
    return p4:gsub("ShowRoom", ""):gsub("Showcase", ""):gsub("Model", ""):gsub("_", " "):match("^%s*(.-)%s*$")
  end

  function f25(p5)
    if not f5(p5) then
      return false
    else
      local v42 = f6(p5)

      if not v37[v42] then
        v37[v42] = p5
        table.insert(v38, v42)
        return true
      end

      return false
    end
  end

  function f20()
    for index7, value7 in ipairs(players:GetPlayers()) do
      if value7.Character then
        for index8, value8 in ipairs(value7.Character:GetChildren()) do
          f25(value8)
        end
      end

      local backpack = value7:FindFirstChild("Backpack")

      if backpack then
        for index9, value9 in ipairs(backpack:GetChildren()) do
          f25(value9)
        end
      end
    end

    table.sort(v38, function(p6, p7)
      if p6 == "Default" then
        return true
      end

      if p7 == "Default" then
        return false
      end

      return p6 < p7
    end)
  end

  function f7()
    if not v36 then
      return
    else
      local mainWeld = v36:FindFirstChild("MainWeld")

      if mainWeld and mainWeld:IsA("Weld") then
        mainWeld.C1 = CFrame.new(v39.pX, v39.pY, v39.pZ)
          * CFrame.Angles(math.rad(v39.rX), math.rad(v39.rY), math.rad(v39.rZ))
      end

      return
    end
  end

  function f8()
    if connect then
      return
    end

    connect = runService.RenderStepped:Connect(function()
      local character = localPlayer.Character

      if not character then
        return
      else
        f26()
        local v43 = f4(character)

        if v43 then
          if v34 and v35 ~= "Default" then
            for index10, value10 in ipairs(v43:GetDescendants()) do
              if value10:IsA("BasePart") or value10:IsA("MeshPart") or value10:IsA("Decal")
                or value10:IsA("Texture") then
                value10.Transparency = 1
              elseif value10:IsA("ParticleEmitter") or value10:IsA("Trail") then
                value10.Enabled = false
              end
            end
          else
            for index11, value11 in ipairs(v43:GetDescendants()) do
              if value11:IsA("BasePart") or value11:IsA("MeshPart") or value11:IsA("Decal")
                or value11:IsA("Texture") then
                value11.Transparency = 0
              elseif value11:IsA("ParticleEmitter") or value11:IsA("Trail") then
                value11.Enabled = true
              end
            end
          end
        end

        return
      end
    end)
  end

  function f26()
    local character2 = localPlayer.Character

    if not character2 then
      return
    else
      local v44 = not v34
      local v45 = f4(character2)

      if v44 or v35 == "Default" or not v45 then
        if v36 then
          v36:Destroy()
          v36 = nil
        end

        if v45 then
          for index12, value12 in ipairs(v45:GetDescendants()) do
            if value12:IsA("BasePart") or value12:IsA("MeshPart") or value12:IsA("Decal")
              or value12:IsA("Texture") then
              value12.Transparency = 0
            elseif value12:IsA("ParticleEmitter") or value12:IsA("Trail") then
              value12.Enabled = true
            end
          end
        end

        return
      else
        local v46 = v37[v35]

        if not v46 then
          return
        end

        if v36 and v36.Name == "Fake_" .. v35 then
          return
        else
          if v36 then
            v36:Destroy()
            v36 = nil
          end

          local clone = v46:Clone()
          local handle2 = clone:FindFirstChild("Handle")

          if not handle2 then
            for index13, value13 in ipairs(clone:GetDescendants()) do
              if value13:IsA("BasePart") and value13.Name:lower() == "handle" then
                handle2 = value13
                break
              end
            end
          end

          if not handle2 then
            handle2 = clone.PrimaryPart or clone:FindFirstChildWhichIsA("BasePart", true)
          end

          if not handle2 then
            clone:Destroy()
            return
          else
            for index14, value14 in ipairs(clone:GetDescendants()) do
              if value14:IsA("BasePart") then
                value14.CanCollide = false
                value14.Massless = true
                value14.Anchored = false

                local lower4 = value14.Name:lower()

                if lower4:match("hitbox") or lower4:match("bounding")
                  or lower4:match("collision") then
                  value14.Transparency = 1
                end

                if value14 ~= handle2 and value14.Parent ~= nil then
                  local weldConstraint = Instance.new("WeldConstraint")
                  weldConstraint.Part0 = handle2
                  weldConstraint.Part1 = value14
                  weldConstraint.Parent = handle2
                end
              end
            end

            clone.Name = "Fake_" .. v35
            clone.Parent = character2

            local handle3 = v45:FindFirstChild("Handle")

            local findFirstChildWhichIsA = handle3
            findFirstChildWhichIsA = handle3 or v45:FindFirstChildWhichIsA("BasePart", true)

            if findFirstChildWhichIsA then
              handle2.CFrame = findFirstChildWhichIsA.CFrame

              local mainWeld2 = Instance.new("Weld")
              mainWeld2.Name = "MainWeld"
              mainWeld2.Part0 = findFirstChildWhichIsA
              mainWeld2.Part1 = handle2

              mainWeld2.C1 = CFrame.new(v39.pX, v39.pY, v39.pZ)
                * CFrame.Angles(math.rad(v39.rX), math.rad(v39.rY), math.rad(v39.rZ))

              mainWeld2.Parent = clone
            end

            v36 = clone
            return
          end
        end
      end
    end
  end

  function f27()
    if connect then
      connect:Disconnect()
      connect = nil
    end

    if v36 then
      v36:Destroy()
      v36 = nil
    end

    local character3 = localPlayer.Character

    if character3 then
      local v47 = f4(character3)

      if v47 then
        for index15, value15 in ipairs(v47:GetDescendants()) do
          if value15:IsA("BasePart") or value15:IsA("MeshPart") or value15:IsA("Decal")
            or value15:IsA("Texture") then
            value15.Transparency = 0
          elseif value15:IsA("ParticleEmitter") or value15:IsA("Trail") then
            value15.Enabled = true
          end
        end
      end
    end
  end

  localPlayer.CharacterAdded:Connect(function()
    v36 = nil
    task.wait(1.5)

    if v34 then
      f26()
    end
  end)

  f20()

  function f21()
    local v48, v49 = pcall(function()
      return stats.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)

    return v48 and v49 or 50
  end

  function f9()
    local trainingBalls = workspace:FindFirstChild("TrainingBalls")

    if not trainingBalls then
      return nil
    end

    for index16, value16 in ipairs(trainingBalls:GetChildren()) do
      if value16:GetAttribute("realBall") then
        return value16
      end
    end

    return nil
  end

  function f10()
    local character4 = localPlayer.Character

    if character4 then
      local humanoidRootPart = character4:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        return humanoidRootPart.Position
      end

      return currentCamera.CFrame.Position
    end

    return currentCamera.CFrame.Position
  end

  function f22()
    for index17, value17 in ipairs(waitForChild:GetChildren()) do
      if value17:GetAttribute("realBall") then
        value17.CanCollide = false
        return value17
      end
    end

    return nil
  end

  function f23()
    local v50 = {}

    for index18, value18 in ipairs(waitForChild:GetChildren()) do
      if value18:GetAttribute("realBall") then
        value18.CanCollide = false
        table.insert(v50, value18)
      end
    end

    return v50
  end

  function f11(p8, p9)
    local v51 = f21()
    local v52 = math.clamp(v51 / 10 / 10, 5, 17)
    local v53 = math.max(p8 - 9.5, 0)
    local v54 = math.min(v53, 650)
    return v52 + math.max(p8 / ((2.4 + v54 * 0.002) * p9), 9.5)
  end

  function f28()
    local huge = math.huge
    local alive = workspace:FindFirstChild("Alive")

    if not alive then
      return nil
    end

    local v55

    for index19, value19 in ipairs(alive:GetChildren()) do
      if tostring(value19) ~= tostring(localPlayer) and value19.PrimaryPart then
        local distanceFromCharacter = localPlayer:DistanceFromCharacter(value19.PrimaryPart.Position)

        if distanceFromCharacter < huge then
          v55 = value19
          huge = distanceFromCharacter
        end
      end
    end

    v7 = v55
    return v55
  end

  function f12()
    local v56 = f22()

    if not v56 then
      return false
    else
      local zoomies = v56:FindFirstChild("zoomies")

      if not zoomies then
        return false
      else
        local vectorVelocity = zoomies.VectorVelocity
        local magnitude = vectorVelocity.Magnitude

        if magnitude < 0.001 then
          return false
        else
          local v57 = f10()
          local unit = (v57 - v56.Position).Unit
          local dot = unit:Dot(vectorVelocity.Unit)
          local magnitude2 = (v57 - v56.Position).Magnitude
          local v58 = f21()
          local v59 = magnitude2 / magnitude - v58 / 1000
          local v60 = math.min(magnitude / 100, 40)
          local v61 = magnitude > 100
          local v62 = 15 - math.min(magnitude2 / 1000, 15) + v60

          if v61 and v59 > v58 / 10 then
            v62 = math.max(v62 - 15, 15)
          end

          if magnitude2 < v62 then
            return false
          else
            local v63 = 0.5 - v58 / 1000

            if dot - unit:Dot((vectorVelocity.Unit - vectorVelocity).Unit) < v63 then
              return true
            end

            v9 = v9 + (math.rad(math.asin(math.clamp(dot, -1, 1))) - v9) * 0.8

            if v9 < 0.018 then
              v10 = tick()
            end

            if tick() - v10 < v59 / 1.5 then
              return true
            end

            if tick() - v11 < v59 / 1.5 then
              return true
            end

            return dot < v63
          end
        end
      end
    end
  end

  function f29()
    virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
  end

  function f30(p10)
    if p10 then
      f2()
    else
      f29()
    end
  end

  function f13(p11, p12)
    if not v6 then
      f30(p12)
      v6 = true
    else
      f31(p11)
      f30(p12)
    end

    if v3 >= 7 then
      return
    end

    v3 = v3 + 1

    task.delay(0.5, function()
      if v3 > 0 then
        v3 = v3 - 1
      end
    end)
  end

  function f31(p13)
    f28()
    local v64 = {}
    local v65

    if touchEnabled then
      v65 = { currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2 }
    else
      local getMouseLocation = userInputService:GetMouseLocation()
      v65 = { getMouseLocation.X, getMouseLocation.Y }
    end

    local alive2 = workspace:FindFirstChild("Alive")

    if alive2 then
      for index20, value20 in ipairs(alive2:GetChildren()) do
        if value20 ~= localPlayer.Character and value20.PrimaryPart then
          local v66, v67 = currentCamera:WorldToScreenPoint(value20.PrimaryPart.Position)

          if v67 then
            v64[tostring(value20)] = v66
          end
        end
      end
    end

    local position = currentCamera.CFrame.Position

    if p13 == "Camera" then
      return { 0, currentCamera.CFrame, v64, v65 }
    elseif p13 == "Backwards" then
      local v68 = currentCamera.CFrame.LookVector * -10000
      return { 0, CFrame.new(position, position + Vector3.new(v68.X, 0, v68.Z)), v64, v65 }
    elseif p13 == "High" then
      return {
        0, CFrame.new(position, position + currentCamera.CFrame.UpVector * 10000), v64, v65,
      }
    elseif p13 == "Left" then
      return {
        0, CFrame.new(position, position - currentCamera.CFrame.RightVector * 10000), v64, v65,
      }
    elseif p13 == "Right" then
      return {
        0, CFrame.new(position, position + currentCamera.CFrame.RightVector * 10000), v64, v65,
      }
    elseif p13 == "Random" then
      return {
        0,
        CFrame.new(position, Vector3.new(
          math.random(-4000, 4000), math.random(-4000, 4000), math.random(-4000, 4000)
        )),
        v64, v65,
      }
    elseif p13 == "Straight" then
      if v7 and v7.PrimaryPart then
        return { 0, CFrame.new(f10(), v7.PrimaryPart.Position), v64, v65 }
      end

      return { 0, currentCamera.CFrame, v64, v65 }
    else
      return { 0, currentCamera.CFrame, v64, v65 }
    end
  end

  v40 = {}

  runService.Heartbeat:Connect(function(delta)
    v40[#v40 + 1] = delta

    if #v40 > 20 then
      table.remove(v40, 1)
    end

    local total = 0

    for index21, value21 in ipairs(v40) do
      total = total + value21
    end

    v30 = math.round(#v40 / total)
    v32 = math.round(f21())
  end)

  waitForChild.ChildAdded:Connect(function(child)
    if not child:GetAttribute("realBall") then
      return
    end

    local position2 = child.Position
    local v69 = tick()

    child:GetPropertyChangedSignal("Position"):Connect(function()
      local v70 = tick()
      local v71 = v70 - v69

      if v71 >= 0.016666666666667 then
        v31 = math.round((child.Position - position2).Magnitude / v71) .. " st/s"
        position2 = child.Position
        v69 = v70
      end
    end)
  end)

  function f14()
    if v1.LobbyAP then
      return
    end

    v1.LobbyAP = runService.Heartbeat:Connect(function()
      local v72 = f9()
      local v73

      if not v72 then
        return
      else
        local zoomies2 = v72:FindFirstChild("zoomies")

        if not zoomies2 then
          return
        end

        v72:GetAttributeChangedSignal("target"):Once(function() v4 = false end)

        if v4 then
          return
        else
          local target = v72:GetAttribute("target")
          local magnitude3 = zoomies2.VectorVelocity.Magnitude
          local distanceFromCharacter2 = localPlayer:DistanceFromCharacter(v72.Position)

          local v74 = f11(
            magnitude3, v18 and 0.7 + (math.random(1, 100) - 1) * 0.0035353535353535 or v14
          )

          if target == tostring(localPlayer) and distanceFromCharacter2 <= v74 then
            f13(v16, v25)
            v4 = true
          end

          local v75 = tick()

          if not (tick() - v75 >= 1) then
          end

          repeat
            runService.PreSimulation:Wait()
            v73 = tick() - v75 >= 1 or not v4
          until v73

          v4 = false
          return
        end
      end
    end)
  end

  localPlayer.Idled:Connect(function()
    virtualInputManager:SendKeyEvent(true, "W", false, game)
    task.wait(0.1)
    virtualInputManager:SendKeyEvent(false, "W", false, game)
  end)

  pcall(function()
    replicatedStorage.Remotes.InfinityBall.OnClientEvent:Connect(function(p14, p15)
      v8 = p15 == true
    end)
  end)

  pcall(function()
    replicatedStorage.Remotes.Phantom.OnClientEvent:Connect(function(p16, p17)
      local v76 = p17 ~= nil and p17.Name == tostring(localPlayer)
    end)
  end)

  pcall(function()
    replicatedStorage.Remotes.ParrySuccess.OnClientEvent:Connect(function()
      if v28 and _G.NexusHitSound then
        _G.NexusHitSound:Play()
      end
    end)
  end)

  waitForChild.ChildAdded:Connect(function() v2 = false end)

  function f15()
    if v1.ManualSpam then
      v1.ManualSpam:Disconnect()
      v1.ManualSpam = nil
    end
  end

  local childRemoved = waitForChild.ChildRemoved

  function f16()
    if v1.SpamParry then
      return
    end

    v1.SpamParry = runService.PreSimulation:Connect(function()
      local v77 = f22()

      if not v77 then
        return
      else
        local zoomies3 = v77:FindFirstChild("zoomies")

        if not zoomies3 then
          return
        end

        f28()

        if not v7 or not v7.PrimaryPart then
          return
        else
          local v78 = f21()
          local v79 = math.clamp(v78 / 10, 1, 16)
          local distanceFromCharacter3 = localPlayer:DistanceFromCharacter(v77.Position)
          local distanceFromCharacter4 = localPlayer:DistanceFromCharacter(v7.PrimaryPart.Position)
          local v80 = v79 + math.min(zoomies3.VectorVelocity.Magnitude / 6, 95)

          if distanceFromCharacter3 > v80 or distanceFromCharacter4 > v80 then
            return
          else
            local character5 = localPlayer.Character

            if character5 and character5:GetAttribute("Pulsed") then
              return
            end

            if v77:GetAttribute("target") == tostring(localPlayer)
              and distanceFromCharacter4 > 30 and distanceFromCharacter3 > 30 then
              return
            end

            if distanceFromCharacter3 <= v80 and v3 > v15 then
              f13(v16, v22)
              v33 = "Spam Parrying..."
            end

            return
          end
        end
      end
    end)
  end

  childRemoved:Connect(function()
    v3 = 0
    v2 = false
  end)

  function f32()
    if v1.AutoParry then
      return
    end

    v1.AutoParry = runService.PreSimulation:Connect(function()
      local v81

      for index22, value22 in ipairs(f23()) do
        local zoomies4 = value22:FindFirstChild("zoomies")

        if not zoomies4 then
        else
          value22:GetAttributeChangedSignal("target"):Once(function() v2 = false end)

          if v2 then
          else
            local target2 = value22:GetAttribute("target")
            local magnitude4 = zoomies4.VectorVelocity.Magnitude
            local magnitude5 = (f10() - value22.Position).Magnitude
            local v82 = v17 and 0.7 + (math.random(1, 100) - 1) * 0.0035353535353535 or v13
            local v83 = v19
            local v84 = f11(magnitude4, v82)

            if v83 and v8 then
            elseif value22:FindFirstChild("ComboCounter") then
            else
              local character6 = localPlayer.Character

              if character6 and character6.PrimaryPart
                and character6.PrimaryPart:FindFirstChild("SingularityCape") then
              else
                if target2 == tostring(localPlayer) and magnitude5 <= v84 and not f12() then
                  f13(v16, v21)
                  v2 = true
                  v29 = v29 + 1
                  v33 = "Parried #" .. v29
                end

                local v85 = tick()

                if not (tick() - v85 >= 1) then
                end

                repeat
                  runService.PreSimulation:Wait()
                  v81 = tick() - v85 >= 1 or not v2
                until v81

                v2 = false
              end
            end
          end
        end
      end
    end)
  end

  function f17()
    if v1.ManualSpam then
      return
    end

    v1.ManualSpam = runService.PreSimulation:Connect(function()
      f13(v16, v23)
      v33 = "Manual Spam..."
    end)
  end

  function f18()
    if v1.Triggerbot then
      return
    end

    v1.Triggerbot = runService.PreSimulation:Connect(function()
      local v86

      for index23, value23 in ipairs(f23()) do
        value23:GetAttributeChangedSignal("target"):Once(function() v5 = false end)

        if v5 then
        elseif v20 and v8 then
        else
          local character7 = localPlayer.Character

          if character7 and character7.PrimaryPart
            and character7.PrimaryPart:FindFirstChild("SingularityCape") then
          else
            if value23:GetAttribute("target") == tostring(localPlayer) then
              f13(v16, v24)
              v5 = true
            end

            local v87 = tick()

            if not (tick() - v87 >= 1) then
            end

            repeat
              runService.PreSimulation:Wait()
              v86 = tick() - v87 >= 1 or not v5
            until v86

            v5 = false
          end
        end
      end
    end)
  end

  function f19()
    if v1.SpamParry then
      v1.SpamParry:Disconnect()
      v1.SpamParry = nil
    end
  end

  function f33()
    if v1.AutoParry then
      v1.AutoParry:Disconnect()
      v1.AutoParry = nil
    end
  end

  local nexusAudio = Instance.new("Folder")
  nexusAudio.Name = "NexusAudio"
  nexusAudio.Parent = workspace

  sound = Instance.new("Sound")
  sound.Volume = 6
  sound.Parent = nexusAudio

  _G.NexusHitSound = sound

  v41 = {
    Medal = "rbxassetid://6607336718",
    Fatality = "rbxassetid://6607113255",
    Skeet = "rbxassetid://6607204501",
    Switches = "rbxassetid://6607173363",
    ["Rust Headshot"] = "rbxassetid://138750331387064",
    Neverlose = "rbxassetid://110168723447153",
    Bubble = "rbxassetid://6534947588",
    Laser = "rbxassetid://7837461331",
    Steve = "rbxassetid://4965083997",
    ["Call of Duty"] = "rbxassetid://5952120301",
    Bat = "rbxassetid://3333907347",
    ["TF2 Critical"] = "rbxassetid://296102734",
    Saber = "rbxassetid://8415678813",
    Bameware = "rbxassetid://3124331820",
  }

  rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

  local window = rayfield:CreateWindow({
    Name = "Nexus Hub  •  v1.1",
    Icon = 0,
    LoadingTitle = "Nexus Hub",
    LoadingSubtitle = "by Minh Scripts",
    Theme = "Default",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = true,
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
  })

  local blatantTab = window:CreateTab("Blatant", 4483362458)
  blatantTab:CreateSection("Auto Parry")

  blatantTab:CreateToggle({
    Name = "Auto Parry",
    CurrentValue = false,
    Flag = "AutoParry",
    Callback = function(value24)
      if value24 then
        f32()
      else
        f33()
      end
    end,
  })

  blatantTab:CreateSlider({
    Name = "Parry Accuracy",
    Range = { 1, 100 },
    Increment = 1,
    Suffix = "%",
    CurrentValue = 100,
    Flag = "ParryAccuracy",
    Callback = function(value25) v13 = 0.7 + (value25 - 1) * 0.0035353535353535 end,
  })

  blatantTab:CreateDropdown({
    Name = "Curve Type",
    Options = { "Camera", "Backwards", "Straight", "High", "Left", "Right", "Random" },
    CurrentOption = { "Camera" },
    Flag = "CurveType",
    Callback = function(value26) v16 = value26[1] or "Camera" end,
  })

  blatantTab:CreateToggle({
    Name = "Random Parry Accuracy",
    CurrentValue = false,
    Flag = "RandomAccuracy",
    Callback = function(value27) v17 = value27 end,
  })

  blatantTab:CreateToggle({
    Name = "Infinity Detection",
    CurrentValue = false,
    Flag = "InfinityDetect",
    Callback = function(value28) v19 = value28 end,
  })

  blatantTab:CreateToggle({
    Name = "Phantom Detection",
    CurrentValue = false,
    Flag = "PhantomDetect",
    Callback = function(value29) end,
  })

  blatantTab:CreateToggle({
    Name = "Keypress (F Key)",
    CurrentValue = false,
    Flag = "KeypressParry",
    Callback = function(value30) v21 = value30 end,
  })

  blatantTab:CreateSection("Auto Spam Parry")

  blatantTab:CreateToggle({
    Name = "Auto Spam Parry",
    CurrentValue = false,
    Flag = "AutoSpam",
    Callback = function(value31)
      if value31 then
        f16()
      else
        f19()
      end
    end,
  })

  blatantTab:CreateSlider({
    Name = "Parry Threshold",
    Range = { 1, 3 },
    Increment = 0.5,
    Suffix = "",
    CurrentValue = 2.5,
    Flag = "ParryThreshold",
    Callback = function(value32) v15 = value32 end,
  })

  blatantTab:CreateToggle({
    Name = "Keypress (F Key)",
    CurrentValue = false,
    Flag = "KeypressSpam",
    Callback = function(value33) v22 = value33 end,
  })

  blatantTab:CreateSection("Manual Spam")

  blatantTab:CreateToggle({
    Name = "Manual Spam",
    CurrentValue = false,
    Flag = "ManualSpam",
    Callback = function(value34)
      if value34 then
        f17()
      else
        f15()
      end
    end,
  })

  blatantTab:CreateToggle({
    Name = "Keypress (F Key)",
    CurrentValue = false,
    Flag = "KeypressManual",
    Callback = function(value35) v23 = value35 end,
  })

  blatantTab:CreateSection("Triggerbot")

  blatantTab:CreateToggle({
    Name = "Triggerbot",
    CurrentValue = false,
    Flag = "Triggerbot",
    Callback = function(value36)
      if value36 then
        f18()
      else
        f1()
      end
    end,
  })

  blatantTab:CreateToggle({
    Name = "Infinity Detection",
    CurrentValue = false,
    Flag = "TrigInfinity",
    Callback = function(value37) v20 = value37 end,
  })

  blatantTab:CreateToggle({
    Name = "Keypress (F Key)",
    CurrentValue = false,
    Flag = "KeypressTrigger",
    Callback = function(value38) v24 = value38 end,
  })

  blatantTab:CreateSection("Lobby Auto Parry")

  blatantTab:CreateToggle({
    Name = "Lobby Auto Parry",
    CurrentValue = false,
    Flag = "LobbyAP",
    Callback = function(value39)
      if value39 then
        f14()
      else
        f3()
      end
    end,
  })

  blatantTab:CreateSlider({
    Name = "Parry Accuracy",
    Range = { 1, 100 },
    Increment = 1,
    Suffix = "%",
    CurrentValue = 100,
    Flag = "LobbyAPAccuracy",
    Callback = function(value40) v14 = 0.7 + (value40 - 1) * 0.0035353535353535 end,
  })

  blatantTab:CreateToggle({
    Name = "Random Parry Accuracy",
    CurrentValue = false,
    Flag = "LobbyAPRandom",
    Callback = function(value41) v18 = value41 end,
  })

  blatantTab:CreateToggle({
    Name = "Keypress (F Key)",
    CurrentValue = false,
    Flag = "KeypressLobbyAP",
    Callback = function(value42) v25 = value42 end,
  })

  blatantTab:CreateSection("Live Stats")

  parries0Label = blatantTab:CreateLabel("Parries: 0")
  fps60Label = blatantTab:CreateLabel("FPS: 60")
  ballSpeedLabel = blatantTab:CreateLabel("Ball Speed: —")
  label = blatantTab:CreateLabel("Ping: 0 ms")
  statusWaitingLabel = blatantTab:CreateLabel("Status: Waiting...")

  runService.Heartbeat:Connect(function()
    pcall(function()
      parries0Label:Set("Parries: " .. v29)
      fps60Label:Set("FPS: " .. v30)
      ballSpeedLabel:Set("Ball Speed: " .. v31)
      label:Set("Ping: " .. v32 .. " ms")
      statusWaitingLabel:Set("Status: " .. v33)
    end)
  end)

  local playerTab = window:CreateTab("Player", 4483362458)
  playerTab:CreateSection("Movement")

  playerTab:CreateToggle({
    Name = "Strafe",
    CurrentValue = false,
    Flag = "Strafe",
    Callback = function(value43)
      if value43 then
        v1.Strafe = runService.PreSimulation:Connect(function()
          local character8 = localPlayer.Character

          if character8 and character8:FindFirstChild("Humanoid") then
            character8.Humanoid.WalkSpeed = walkSpeed
          end
        end)
      else
        if v1.Strafe then
          v1.Strafe:Disconnect()
          v1.Strafe = nil
        end

        local character9 = localPlayer.Character

        if character9 and character9:FindFirstChild("Humanoid") then
          character9.Humanoid.WalkSpeed = 36
        end
      end
    end,
  })

  playerTab:CreateSlider({
    Name = "Walk Speed",
    Range = { 36, 250 },
    Increment = 1,
    Suffix = " st/s",
    CurrentValue = 36,
    Flag = "StrafeSpeed",
    Callback = function(value44) walkSpeed = value44 end,
  })

  playerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "Fly",
    Callback = function(value45)
      v27 = value45
      local bodyGyro, bodyVelocity

      if value45 then
        local character10 = localPlayer.Character

        if not character10 then
          return
        else
          local humanoidRootPart2 = character10:FindFirstChild("HumanoidRootPart")
          local v88 = not humanoidRootPart2
          local humanoid = character10:FindFirstChild("Humanoid")

          if v88 or not humanoid then
            return
          end

          bodyGyro = Instance.new("BodyGyro")
          bodyGyro.P = 90000
          bodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
          bodyGyro.Parent = humanoidRootPart2

          bodyVelocity = Instance.new("BodyVelocity")
          bodyVelocity.Velocity = Vector3.zero
          bodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
          bodyVelocity.Parent = humanoidRootPart2

          humanoid.PlatformStand = true

          v1.Fly = runService.RenderStepped:Connect(function()
            if not v27 then
              return
            else
              local cframe = currentCamera.CFrame
              local zero = Vector3.zero

              if userInputService:IsKeyDown(Enum.KeyCode.W) then
                zero = zero + cframe.LookVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.S) then
                zero = zero - cframe.LookVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.A) then
                zero = zero - cframe.RightVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.D) then
                zero = zero + cframe.RightVector
              end

              if userInputService:IsKeyDown(Enum.KeyCode.E) then
                zero = zero + Vector3.new(0, 1, 0)
              end

              if userInputService:IsKeyDown(Enum.KeyCode.Q) then
                zero = zero - Vector3.new(0, 1, 0)
              end

              bodyVelocity.Velocity = (zero.Magnitude > 0 and zero.Unit or zero)
                * (getgenv().FlySpeed or 50)

              bodyGyro.CFrame = cframe
              return
            end
          end)

          return
        end
      else
        if v1.Fly then
          v1.Fly:Disconnect()
          v1.Fly = nil
        end

        local character11 = localPlayer.Character

        if character11 then
          local humanoid2 = character11:FindFirstChild("Humanoid")

          if humanoid2 then
            humanoid2.PlatformStand = false
          end

          local humanoidRootPart3 = character11:FindFirstChild("HumanoidRootPart")

          if humanoidRootPart3 then
            for index24, value46 in ipairs(humanoidRootPart3:GetChildren()) do
              if value46:IsA("BodyGyro") or value46:IsA("BodyVelocity") then
                value46:Destroy()
              end
            end
          end
        end

        return
      end
    end,
  })

  playerTab:CreateSlider({
    Name = "Fly Speed",
    Range = { 10, 200 },
    Increment = 5,
    Suffix = " st/s",
    CurrentValue = 50,
    Flag = "FlySpeed",
    Callback = function(value47) getgenv().FlySpeed = value47 end,
  })

  playerTab:CreateSection("Visuals")

  playerTab:CreateToggle({
    Name = "Spinbot",
    CurrentValue = false,
    Flag = "Spinbot",
    Callback = function(value48)
      getgenv().spin = value48

      if value48 then
        task.spawn(function()
          while getgenv().spin do
            runService.Heartbeat:Wait()
            local character12 = localPlayer.Character

            local humanoidRootPart4 = character12
              and character12:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart4 then
              humanoidRootPart4.CFrame = humanoidRootPart4.CFrame
                * CFrame.Angles(0, getgenv().spinSpeed or math.rad(5), 0)
            end
          end
        end)
      end
    end,
  })

  playerTab:CreateSlider({
    Name = "Spin Speed",
    Range = { 1, 100 },
    Increment = 1,
    Suffix = "°",
    CurrentValue = 5,
    Flag = "SpinSpeed",
    Callback = function(value49) getgenv().spinSpeed = math.rad(value49) end,
  })

  playerTab:CreateToggle({
    Name = "Field of View",
    CurrentValue = false,
    Flag = "FOV",
    Callback = function(value50)
      v26 = value50

      if not value50 then
        workspace.CurrentCamera.FieldOfView = 70

        if v1.FOV then
          v1.FOV:Disconnect()
          v1.FOV = nil
        end
      else
        v1.FOV = runService.RenderStepped:Connect(function()
          workspace.CurrentCamera.FieldOfView = getgenv().CameraFOV or 70
        end)
      end
    end,
  })

  playerTab:CreateSlider({
    Name = "FOV Value",
    Range = { 50, 150 },
    Increment = 1,
    Suffix = "°",
    CurrentValue = 70,
    Flag = "FOVValue",
    Callback = function(value51)
      getgenv().CameraFOV = value51

      if v26 then
        workspace.CurrentCamera.FieldOfView = value51
      end
    end,
  })

  playerTab:CreateSection("Cosmetics")

  playerTab:CreateToggle({
    Name = "Player Cosmetics (Headless + Korblox)",
    CurrentValue = false,
    Flag = "PlayerCosmetics",
    Callback = function(value52)
      v12 = value52
      local f34

      if value52 then
        function f34(p18)
          if not p18 then
            return
          else
            local head = p18:FindFirstChild("Head")

            if head then
              head.Transparency = 1
            end

            local rightLeg = p18:FindFirstChild("RightLeg") or p18:FindFirstChild("Right Leg")

            if rightLeg then
              for index25, value53 in ipairs(rightLeg:GetChildren()) do
                if value53:IsA("SpecialMesh") then
                  value53:Destroy()
                end
              end

              local specialMesh = Instance.new("SpecialMesh")
              specialMesh.MeshId = "rbxassetid://101851696"
              specialMesh.TextureId = "rbxassetid://115727863"
              specialMesh.Scale = Vector3.new(1, 1, 1)
              specialMesh.Parent = rightLeg
            end

            return
          end
        end

        if localPlayer.Character then
          f34(localPlayer.Character)
        end

        v1.Cosmetics = localPlayer.CharacterAdded:Connect(function(character13)
          task.wait(0.5)
          f34(character13)
        end)

        task.spawn(function()
          while v12 do
            task.wait(0.1)
            local character14 = localPlayer.Character

            if character14 then
              local head2 = character14:FindFirstChild("Head")

              if head2 then
                head2.Transparency = 1
                local decal = head2:FindFirstChildOfClass("Decal")

                if decal then
                  decal:Destroy()
                end
              end
            end
          end
        end)
      else
        if v1.Cosmetics then
          v1.Cosmetics:Disconnect()
          v1.Cosmetics = nil
        end

        local character15 = localPlayer.Character

        if character15 then
          local head3 = character15:FindFirstChild("Head")

          if head3 then
            head3.Transparency = 0
          end
        end
      end
    end,
  })

  local skinChangerTab = window:CreateTab("Skin Changer", 4483362458)
  skinChangerTab:CreateSection("Sword Skin Changer")

  skinChangerTab:CreateToggle({
    Name = "Enable Skin Changer",
    CurrentValue = false,
    Flag = "SkinChangerOn",
    Callback = function(value54)
      v34 = value54

      if value54 then
        f8()
      else
        f27()
      end
    end,
  })

  skinChangerTab:CreateButton({
    Name = "Refresh Swords (Scan All Players)",
    Callback = function()
      v37 = {}
      v38 = { "Default" }
      f20()

      rayfield:Notify({
        Title = "Skin Changer",
        Content = "Found " .. #v38 - 1 .. " swords!",
        Duration = 3,
      })
    end,
  })

  skinChangerTab:CreateSection("Select Sword")

  skinChangerTab:CreateDropdown({
    Name = "Sword",
    Options = v38,
    CurrentOption = { "Default" },
    Flag = "SwordSkin",
    Callback = function(value55)
      v35 = value55[1] or "Default"

      if v36 then
        v36:Destroy()
        v36 = nil
      end

      if v34 then
        f26()
      end
    end,
  })

  skinChangerTab:CreateSection("Position / Rotation Offset")

  skinChangerTab:CreateSlider({
    Name = "Position X",
    Range = { -3, 3 },
    Increment = 0.1,
    Suffix = " st",
    CurrentValue = 0,
    Flag = "SC_PX",
    Callback = function(value56)
      v39.pX = value56
      f7()
    end,
  })

  skinChangerTab:CreateSlider({
    Name = "Position Y",
    Range = { -3, 3 },
    Increment = 0.1,
    Suffix = " st",
    CurrentValue = 0,
    Flag = "SC_PY",
    Callback = function(value57)
      v39.pY = value57
      f7()
    end,
  })

  skinChangerTab:CreateSlider({
    Name = "Position Z",
    Range = { -3, 3 },
    Increment = 0.1,
    Suffix = " st",
    CurrentValue = 0,
    Flag = "SC_PZ",
    Callback = function(value58)
      v39.pZ = value58
      f7()
    end,
  })

  skinChangerTab:CreateSlider({
    Name = "Rotation X",
    Range = { -180, 180 },
    Increment = 5,
    Suffix = "°",
    CurrentValue = 0,
    Flag = "SC_RX",
    Callback = function(value59)
      v39.rX = value59
      f7()
    end,
  })

  skinChangerTab:CreateSlider({
    Name = "Rotation Y",
    Range = { -180, 180 },
    Increment = 5,
    Suffix = "°",
    CurrentValue = 0,
    Flag = "SC_RY",
    Callback = function(value60)
      v39.rY = value60
      f7()
    end,
  })

  skinChangerTab:CreateSlider({
    Name = "Rotation Z",
    Range = { -180, 180 },
    Increment = 5,
    Suffix = "°",
    CurrentValue = 0,
    Flag = "SC_RZ",
    Callback = function(value61)
      v39.rZ = value61
      f7()
    end,
  })

  skinChangerTab:CreateButton({
    Name = "Reset Position & Rotation",
    Callback = function()
      v39 = {
        pX = 0,
        pY = 0,
        pZ = 0,
        rX = 0,
        rY = 0,
        rZ = 0,
      }

      f7()
    end,
  })

  local worldTab = window:CreateTab("World", 4483362458)
  worldTab:CreateSection("World")
  worldTab:CreateLabel("World features coming soon.")

  local farmTab = window:CreateTab("Farm", 4483362458)
  farmTab:CreateSection("Farm")
  farmTab:CreateLabel("Farm features coming soon.")

  local miscTab = window:CreateTab("Misc", 4483362458)
  miscTab:CreateSection("Hit Sounds")

  miscTab:CreateToggle({
    Name = "Hit Sounds",
    CurrentValue = false,
    Flag = "HitSounds",
    Callback = function(value62) v28 = value62 end,
  })

  miscTab:CreateSlider({
    Name = "Hit Sound Volume",
    Range = { 0, 10 },
    Increment = 1,
    Suffix = "",
    CurrentValue = 6,
    Flag = "HitSoundVolume",
    Callback = function(value63) sound.Volume = value63 end,
  })

  miscTab:CreateDropdown({
    Name = "Hit Sound",
    Options = {
      "Medal", "Fatality", "Skeet", "Switches", "Rust Headshot", "Neverlose", "Bubble", "Laser",
      "Steve", "Call of Duty", "Bat", "TF2 Critical", "Saber", "Bameware",
    },
    CurrentOption = { "Medal" },
    Flag = "HitSoundType",
    Callback = function(value64)
      local v89 = v41[value64[1]]

      if v89 then
        sound.SoundId = v89
      end
    end,
  })

  miscTab:CreateSection("Anti-AFK")
  miscTab:CreateLabel("Anti-AFK is always active.")
  miscTab:CreateSection("About")
  miscTab:CreateLabel("Nexus Hub v1.1")
  miscTab:CreateLabel("Made by Minh Scripts + Greenic Scripts")
  miscTab:CreateLabel("Skin Changer method by Mur4Scripts")
  miscTab:CreateLabel("All executors supported  •  Rayfield UI")

  rayfield:Notify({
    Title = "Nexus Hub v1.1  ✓",
    Content = "Made by Minh Scripts + Greenic Scripts",
    Duration = 6,
    Image = 4483362458,
  })

  task.wait(1.5)

  rayfield:Notify({
    Title = "v1.2 Coming Soon",
    Content = "HUGE UPDATE dropping soon — stay tuned!",
    Duration = 7,
    Image = 4483362458,
  })

  print("[Nexus Hub v1.1 — Minh Scripts + Greenic Scripts] Loaded.")
  return
end
