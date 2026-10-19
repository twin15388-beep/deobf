local lighting = game:GetService("Lighting")
local replicatedStorage = game:GetService("ReplicatedStorage")
local debris = game:GetService("Debris")
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local starterGui = game:GetService("StarterGui")

getgenv().Rain = false
getgenv().Move5 = true
getgenv().Move6 = true
getgenv().Move7 = true

function info(p1, p2)
  local v1 = p2

  if v1 == nil then
    v1 = 2
  end

  spawn(function()
    local revit = Instance.new("ScreenGui")
    local mainFrame = Instance.new("Frame")
    local textLabel = Instance.new("TextLabel")
    task.wait(0.1)

    revit.Parent = game.CoreGui
    revit.ZIndexBehavior = Enum.ZIndexBehavior.Global
    revit.IgnoreGuiInset = true
    revit.ResetOnSpawn = false
    revit.Name = "Revit"

    mainFrame.Name = "MainFrame"
    mainFrame.Parent = revit
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)

    spawn(function()
      textLabel.Parent = revit
      textLabel.Font = Enum.Font.Arcade
      textLabel.TextColor3 = Color3.new(1, 1, 1)
      textLabel.Position = UDim2.new(0, 0, 0, 0)
      textLabel.TextSize = 35
      textLabel.Size = UDim2.new(1, 0, 0.1, 0)
      textLabel.Text = ""
      textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
      textLabel.BorderColor3 = Color3.fromRGB(255, 0, 0)
    end)

    function tw(p3, p4)
      local text = ""

      for i = 1, #p4 do
        local v3 = string.sub(p4, i, i)
        text = text .. v3
        p3.Text = text

        if v3 == "." then
          task.wait(0.6)
        elseif v3 == ";" then
          task.wait(0.3)
        elseif v3 == "," then
          task.wait(0.3)
        elseif v3 == "!" then
          task.wait(0.3)
        end

        task.wait(0.03)
      end
    end

    tw(textLabel, p1)

    task.wait(v1)
    revit:Destroy()
  end)
end

pcall(function()
  for j = 1, 6 do
    lighting:FindFirstChildWhichIsA("Atmosphere"):Destroy()
    lighting:FindFirstChildWhichIsA("BloomEffect"):Destroy()
  end
end)

lighting.ClockTime = 0
lighting.Ambient = Color3.fromRGB(108, 124, 144)
lighting.Brightness = 2.25
lighting.ColorShift_Bottom = Color3.fromRGB(0, 0, 0)
lighting.ColorShift_Top = Color3.fromRGB(215, 190, 135)
lighting.EnvironmentDiffuseScale = 0.2
lighting.EnvironmentSpecularScale = 0.2
lighting.GlobalShadows = true
lighting.OutdoorAmbient = Color3.fromRGB(106, 106, 106)
lighting.ShadowSoftness = 0.2
lighting.ExposureCompensation = 0.2

pcall(function() sethiddenproperty(lighting, "Technology", "ShadowMap") end)

local instance = Instance.new("Atmosphere", lighting)
instance.Density = 0.2
instance.Offset = 0.55599999427795
instance.Color = Color3.new(0.5, 0.3431375, 0.32549)
instance.Glare = 0.36000001430511
instance.Haze = 1.7200000286102
instance.Decay = Color3.new(0, 0, 0)

local bloomm = Instance.new("BloomEffect", lighting)
bloomm.Threshold = 0.50000001192093
bloomm.Intensity = 0.30000001192093
bloomm.Size = 10
bloomm.Name = "BLOOMM"

local services = replicatedStorage:WaitForChild("Knit"):WaitForChild("Knit"):WaitForChild("Services")
local re = replicatedStorage.Knit.Knit.Services.ChosoService.RE
pcall(function() game.ReplicatedStorage.Utils.Lindwurm:Destroy() end)

local lindwurm = game:GetObjects("rbxassetid://129742625273769")[1]
lindwurm.Parent = game.ReplicatedStorage.Utils
lindwurm.Name = "Lindwurm"

pcall(function() game.CoreGui.Rain:Destroy() end)

if getgenv().Rain == true then
  local rain = Instance.new("Sound")
  rain.Parent = game.CoreGui
  rain.SoundId = "rbxassetid://5911952995"
  rain.Pitch = 0.3
  rain.Volume = 3.8
  rain.Looped = true
  rain:play()
  rain.Name = "Rain"

  spawn(function()
    local humanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
    task.wait(0.5)

    for m = 1, 9999999 do
      if getgenv().Loop == true then
        break
      end

      spawn(function()
        local v4 = math.random(45, 155)

        local part = Instance.new("Part")

        part.CFrame = CFrame.new(
          humanoidRootPart.CFrame.X + math.random(-45, 45), 20 + v4,
          humanoidRootPart.CFrame.Z + math.random(-45, 45)
        )

        part.Material = Enum.Material.Neon
        part.Color = Color3.new(0.5, 0.5, 1)

        debris:AddItem(part, 3.7)

        part.Size = Vector3.new(1, 1, 1)
        part.Parent = workspace.Effects
        part.CanCollide = false
        part.Anchored = true

        local instance2 = Instance.new("SpecialMesh", part)
        instance2.MeshType = "Sphere"
        instance2.Scale = Vector3.new(0.5, 1, 0.5)

        local create = game.TweenService:Create(
          part, TweenInfo.new(0.7, Enum.EasingStyle.Back),
          { CFrame = part.CFrame * CFrame.new(0, -v4, 0) }
        )

        create:Play()

        game.TweenService:Create(instance2, TweenInfo.new(0.2), {
          Scale = Vector3.new(0.1, 2, 0.1),
        }):Play()

        task.wait(0.25)
        create:Pause()
        instance2.Scale = Vector3.new(0.5, 0.2, 0.5)
        local v5 = math.random(1, 5)
        part.CFrame = CFrame.new(part.CFrame.X, 20.3, part.CFrame.Z)
        local v6 = 1.7 + math.random(-45, 15) / 35

        game.TweenService:Create(instance2, TweenInfo.new(v6), {
          Scale = Vector3.new(2 + v5, 1, 2 + v5),
        }):Play()

        game.TweenService:Create(part, TweenInfo.new(v6), { Transparency = 1 }):Play()

        for n = 1, math.random(2, 4) do
          local part2 = Instance.new("Part")
          part2.CFrame = part.CFrame * CFrame.Angles(math.rad(math.random(-75, 75)), 0, 0)
          part2.Material = Enum.Material.Neon
          part2.Color = Color3.new(0.5, 0.5, 1)

          debris:AddItem(part2, 0.2)

          part2.Size = Vector3.new(0.5, 0.5, 0.5)
          part2.Parent = workspace.Effects
          part2.CanCollide = false
          part2.Anchored = true

          local instance3 = Instance.new("SpecialMesh", part2)
          instance3.MeshType = "Sphere"
          instance3.Scale = Vector3.new(1, 1, 1)

          game.TweenService:Create(part2, TweenInfo.new(0.2), {
            CFrame = part2.CFrame * CFrame.new(0, 3, 0),
            Transparency = 1,
          }):Play()

          game.TweenService:Create(instance3, TweenInfo.new(0.2), {
            Scale = Vector3.new(0.1, 2, 0.1),
          }):Play()

          for i6 = 1, math.random(2, 4) do
            local part3 = Instance.new("Part")

            part3.CFrame = part2.CFrame * CFrame.Angles(
              part2.Rotation.X + math.rad(35), part2.Rotation.Y, part2.Rotation.Z
            )

            part3.Material = Enum.Material.Neon
            part3.Color = Color3.new(0.5, 0.5, 1)

            debris:AddItem(part3, 0.5)

            part3.Size = Vector3.new(0.5, 0.5, 0.5)
            part3.Parent = workspace.Effects
            part3.CanCollide = false
            part3.Anchored = true

            local instance4 = Instance.new("SpecialMesh", part3)
            instance4.MeshType = "Sphere"
            instance4.Scale = Vector3.new(1, 1, 1)

            game.TweenService:Create(part3, TweenInfo.new(0.5), {
              CFrame = part2.CFrame * CFrame.new(math.random(-3, 3), -3, math.random(-3, 3)),
              Transparency = 1,
            }):Play()

            game.TweenService:Create(instance4, TweenInfo.new(0.5), {
              Scale = Vector3.new(0.1, 2, 0.1),
            }):Play()
          end
        end
      end)

      task.wait(0.1 + math.random(-5, 5) / 77)
    end
  end)
end

function MainEnv()
  local localPlayer = game.Players.LocalPlayer
  local character = localPlayer.Character
  local humanoidRootPart2 = character.HumanoidRootPart
  pcall(function() character.VFX:Destroy() end)

  local vfx = Instance.new("Folder", character)
  vfx.Name = "VFX"

  local clone = lindwurm.FacelessDagger:Clone()
  clone.Parent = vfx
  clone.FacelessDagger.Part0 = character["Right Arm"]

  local clone2 = lindwurm.RedEyes:Clone()
  clone2.Parent = vfx
  clone2.CanCollide = false
  clone2.CFrame = humanoidRootPart2.CFrame

  local weld = Instance.new("Weld")
  weld.Parent = character.Head
  weld.Part0 = clone2
  weld.Part1 = character.Head

  local clone3 = lindwurm.MetalArm:Clone()
  clone3.Parent = vfx
  clone3.CanCollide = false

  local weld2 = Instance.new("Weld")
  weld2.Parent = character["Right Arm"]
  weld2.Part0 = clone3
  weld2.Part1 = character["Right Arm"]

  local clone4 = lindwurm.MetalArmPlate:Clone()
  clone4.Parent = vfx
  clone4.CanCollide = false

  local weld3 = Instance.new("Weld")
  weld3.Parent = character.Torso
  weld3.Part0 = clone4
  weld3.Part1 = character.Torso

  function Skill(parent, p5)
    local clone5 = lindwurm.BaneEffect:Clone()
    clone5.Parent = parent
    clone5.LockedToPart = false
    clone5.Lifetime = NumberRange.new(0.5)

    task.delay(p5, function()
      clone5.Rate = 0
      task.wait(1.5)
      clone5:Destroy()
    end)
  end

  function _G.Use(p6)
    if p6 == "Front Dash" then
      re.Chase:FireServer()
      return
    end

    services[p6 .. "Service"].RE.Activated:FireServer(unpack({ [1] = false }))
  end

  function _G.PS(p7, volume, p8, p9)
    local v7 = p9
    local sound = Instance.new("Sound")
    task.delay(25, function() sound:Destroy() end)

    if v7 == nil then
      v7 = 1
    end

    if p8 == nil then
      sound.TimePosition = 0
    else
      sound.TimePosition = p8
    end

    sound.SoundId = "rbxassetid://" .. p7
    sound.Volume = volume
    sound.PlaybackSpeed = v7
    sound.Parent = game.CoreGui.HeadsetDisconnectedDialog
    sound:Play()
  end

  function randomstring()
    local v8 = {}

    for i7 = 1, math.random(140, 180) do
      table.insert(v8, #v8 + 1, utf8.char(math.random(1111, 1112)))
    end

    return table.concat(v8)
  end

  local v9 = getgenv()
  v9.connections = getgenv().connections or {}

  local function f1()
    for key, value in pairs(getgenv().connections) do
      if typeof(value) == "RBXScriptConnection" then
        warn("\nDUPLICATE FOUND!\nDisconnected! " .. key)
        value:Disconnect()
      end
    end
  end

  local function f2()
    if getgenv().connections then
      f1()
    else
      getgenv().connections = {}
    end
  end

  f2()

  getgenv().connections = nil

  local v10 = getgenv()
  v10.connections = getgenv().connections or {}

  local function f3(p10, p11)
    local v11 = randomstring()
    warn("CONNECTION ADDED! " .. p11 .. "\nUNIQUE CONNECTION ID: " .. v11)

    if getgenv().connections then
      local v12 = p11 .. v11
      local connections = getgenv().connections
      local v13 = v12 or #getgenv().connections + 1
      connections[v13] = p10
      return p10
    end
  end

  for index, value2 in ipairs((replicatedStorage.Utils.Choso:GetDescendants())) do
    if value2:IsA("ParticleEmitter") or value2:IsA("Beam") or value2:IsA("Trail") then
      value2.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(155, 155, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255)),
      })
    elseif value2:IsA("Part") or value2:IsA("UnionOperation") then
      value2.Color = Color3.new(0.5, 0.5, 1)
    end
  end

  fchar = character:Clone()
  fchar.Name = "SG_Clone"
  fchar.Parent = workspace.Logic

  _G.Clone = fchar
  local humanoidRootPart3 = fchar.HumanoidRootPart

  for index2, value3 in ipairs((fchar:GetDescendants())) do
    if value3:IsA("BasePart") then
      value3.CollisionGroup = "NoCollision"
    end
  end

  humanoidRootPart3.Anchored = true
  humanoidRootPart3.CFrame = CFrame.new(0, 10000000000, 0)

  f3(character.Humanoid.AnimationPlayed:Connect(function(p12)
    local loadAnimation, v14, bodyVelocity

    if p12.Animation.AnimationId == "rbxassetid://127171275866632" then
      local animation = Instance.new("Animation")
      animation.AnimationId = "rbxassetid://127374795448558"

      loadAnimation = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation)
      loadAnimation:Play(0.3)
      loadAnimation.Priority = Enum.AnimationPriority.Action2
      loadAnimation:AdjustSpeed(2.5)

      spawn(function()
        local huge = math.huge
        local characters = workspace.Characters
        local v15

        for key2, value4 in pairs(characters:GetChildren()) do
          if value4:IsA("Model") and value4:FindFirstChild("HumanoidRootPart")
            and value4 ~= character then
            local humanoidRootPart4 = value4.HumanoidRootPart
            local magnitude = (humanoidRootPart4.Position - humanoidRootPart2.Position).Magnitude

            if magnitude < huge then
              huge = magnitude
              v15 = humanoidRootPart4
            end
          end
        end

        local v16 = false

        for key3, value5 in pairs(fchar:GetDescendants()) do
          local v17 = value5

          if v17:IsA("BasePart") or v17:IsA("Decal") or v17:IsA("MeshPart") then
            task.spawn(function()
              if v17.Name:match("Hitbox") then
                return
              end

              if v17.Name:match("HumanoidR") then
                return
              end

              if v17.Parent.Name == "#NinjaKATANA" then
                return
              end

              if v17.Name:match("Sh") then
                return
              end

              local transparency = v17.Transparency
              v17.Transparency = 1

              spawn(function()
                local v18 = 0.1

                for i8 = 1, 35 do
                  v18 = v18 - 0.02
                  v17.Transparency = 1
                  task.wait(v18)
                  v17.Transparency = 0
                  task.wait(v18)
                end

                v17.Transparency = transparency
              end)
            end)
          end
        end

        spawn(function()
          local animation2 = Instance.new("Animation")
          animation2.AnimationId = "rbxassetid://127374795448558"

          local loadAnimation2 = fchar.Humanoid:LoadAnimation(animation2)
          loadAnimation2:Play(0.3)
          loadAnimation2.Priority = Enum.AnimationPriority.Action2
          loadAnimation2:AdjustSpeed(2.5)

          task.wait(1)
          loadAnimation2:AdjustSpeed(1)

          spawn(function()
            for i9 = 1, 155 do
              if v16 == true then
                return
              end

              loadAnimation2.TimePosition = 2.5 + i9 / 200
              task.wait()
            end

            loadAnimation2:AdjustSpeed(0.5)

            for i10 = 1, 999 do
              if v16 == true then
                return
              end

              loadAnimation2.TimePosition = 3.5 + math.random(-15, 15) / 255
              task.wait()
            end
          end)

          p12.Stopped:Wait()
          v16 = true
          loadAnimation2:Stop(0.4)
        end)

        local part4 = Instance.new("Part")
        part4.CFrame = humanoidRootPart2.CFrame * CFrame.new(0, 2, 0)

        workspace.CurrentCamera.CameraSubject = part4
        humanoidRootPart3.CFrame = humanoidRootPart2.CFrame
        workspace.Gravity = 0

        repeat
          task.wait()

          humanoidRootPart2.CFrame = v15.CFrame * CFrame.new(0, 15, 2)
            * CFrame.Angles(math.rad(-90), 0, 0)
        until v16 == true

        workspace.Gravity = 196.2
        part4:Destroy()
        workspace.CurrentCamera.CameraSubject = character

        humanoidRootPart2.CFrame = v15.CFrame
        humanoidRootPart2.Transparency = 1
      end)

      task.wait(1)
      loadAnimation:AdjustSpeed(1)
      v14 = false

      spawn(function()
        for i11 = 1, 155 do
          if v14 == true then
            return
          end

          loadAnimation.TimePosition = 2.5 + i11 / 200
          task.wait()
        end

        loadAnimation:AdjustSpeed(0.5)

        for i12 = 1, 999 do
          if v14 == true then
            return
          end

          loadAnimation.TimePosition = 3.5 + math.random(-15, 15) / 255
          task.wait()
        end
      end)

      p12.Stopped:Wait()
      v14 = true
      loadAnimation:Stop(0.4)

      bodyVelocity = Instance.new("BodyVelocity")
      bodyVelocity.MaxForce = Vector3.new(10000000000, 10000000000, 10000000000)
      bodyVelocity.Parent = humanoidRootPart2

      spawn(function()
        for i13 = 1, 150 do
          bodyVelocity.Velocity = Vector3.new(0, 15, 0)
            + humanoidRootPart2.CFrame.LookVector * 50

          task.wait(0.01)
        end
      end)

      task.delay(0.2, function() bodyVelocity:Destroy() end)
      humanoidRootPart3.CFrame = CFrame.new(0, 10000000000, 0)
    end
  end), "Move1")

  pcall(function() localPlayer.PlayerGui.Main.Moveset["Self Sacrifice"]:Destroy() end)
  local inCooldown, selfSacrifice

  if getgenv().Move5 == true then
    selfSacrifice = localPlayer.PlayerGui.Main.Moveset["Blood Edge"]:Clone()
    selfSacrifice.Parent = localPlayer.PlayerGui.Main.Moveset
    selfSacrifice.Name = "Self Sacrifice"

    inCooldown = Instance.new("StringValue", selfSacrifice)
    inCooldown.Name = "InCooldown"
    inCooldown.Value = "false"

    selfSacrifice.Key.Text = "5"
    selfSacrifice.ItemName.Text = "Self Sacrifice"
    selfSacrifice.Tip.Text = "SPECIAL"
    selfSacrifice.Tip.Visible = true
    selfSacrifice.Cooldown.Size = UDim2.new(1, 0, 1, 0)

    selfSacrifice.Cooldown.UIGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })

    selfSacrifice.Cooldown.BackgroundColor3 = Color3.new(0.3, 0, 0)

    function Five()
      if inCooldown.Value == "false" then
        inCooldown.Value = "true"
        selfSacrifice.Tip.Text = "ACTIVATED"

        for i14 = 1, 550 do
          pcall(function()
            players.LocalPlayer.Character:FindFirstChild("RemoteEvent"):FireServer(unpack({
              [1] = { [1] = game.Players.LocalPlayer.Character, [2] = workspace },
              [2] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame,
            }))
          end)

          task.wait(0.01)
        end
      end
    end

    f3(userInputService.InputBegan:Connect(function(input, p13)
      if p13 == true then
        return
      end

      if input.KeyCode == Enum.KeyCode.Five then
        spawn(function() Five() end)
      end
    end), "Move5 (Keybind)")

    f3(selfSacrifice.ItemName.MouseButton1Click:Connect(function()
      spawn(function() Five() end)
    end), "Move5 (Tap)")
  end

  local v19 = false
  local v20 = false
  local v21 = 0

  f3(character.Humanoid.AnimationPlayed:Connect(function(p14)
    local part5

    if p14.Animation.AnimationId == "rbxassetid://85569553424083" then
      if character.Humanoid.FloorMaterial == Enum.Material.Air then
        v21 = v21 + 1
        v20 = true

        if v19 == true then
          v2 = Instance.new("BodyGyro", character.HumanoidRootPart)
          v2.Name = "Client"
          v2.MaxTorque = Vector3.new(1, 1, 1) * 10000000000
          v2.D = 100
          v2.P = 19500

          v2.CFrame = character.HumanoidRootPart.CFrame
            * CFrame.Angles(math.rad(-100), math.rad(0), math.rad(0))

          task.wait(0.4)
          v2:Destroy()
        end

        if v19 == false then
          local bodyVelocity2 = Instance.new("BodyVelocity")
          bodyVelocity2.Parent = humanoidRootPart2
          bodyVelocity2.MaxForce = Vector3.new(10000000000, 10000000000, 10000000000)

          bodyVelocity2.Velocity = Vector3.new(0, 45, 0)
            + humanoidRootPart2.CFrame.LookVector * 5

          v2 = Instance.new("BodyGyro", character.HumanoidRootPart)
          v2.Name = "Client"
          v2.MaxTorque = Vector3.new(1, 1, 1) * 10000000000
          v2.D = 100
          v2.P = 19500

          v2.CFrame = character.HumanoidRootPart.CFrame
            * CFrame.Angles(math.rad(-100), math.rad(0), math.rad(0))

          task.wait(0.4)
          v2:Destroy()

          bodyVelocity2.MaxForce = Vector3.new(0, 10000000000, 0)
          bodyVelocity2.Velocity = Vector3.new(0, 0.2, 0)
        end

        v19 = true

        part5 = Instance.new("Part")
        part5.Parent = character.SetAssets
        part5.Material = Enum.Material.Neon
        part5.Size = Vector3.new(1, 1, 1)
        part5.Anchored = true
        part5.CanCollide = false

        local instance5 = Instance.new("SpecialMesh", part5)
        instance5.MeshType = "Sphere"

        part5.Color = Color3.new(0, 0, 1)
        instance5.Scale = Vector3.new(3, 1, 1)
        debris:AddItem(part5, 5)
        v20 = false
        local ultimate = players.LocalPlayer.PlayerGui.Main.Ultimate

        for i15 = 1, 5 do
          _G.PS(7455246815, 6)

          spawn(function()
            for i16 = 1, 30 do
              part5.CFrame = humanoidRootPart2.CFrame * CFrame.new(0, -18, 0) * CFrame.Angles(
                math.random(-360, 360), math.random(-360, 360), math.random(-360, 360)
              )

              task.wait(0.033333333333333)
            end
          end)

          ultimate.Bar.Ready.Ready.Text = tostring(6 - i15)

          for i17 = 1, 30 do
            if v20 == true then
              print("just")
              return
            end

            task.wait(0.033333333333333)
          end
        end

        _G.PS(7455246815, 6)
        v19 = false
        ultimate.Bar.Ready.Ready.Text = "PRESS G TO START INQUESTING IT"
        humanoidRootPart2:FindFirstChildWhichIsA("BodyVelocity", 1):Destroy()

        for i18 = 1, v21 do
          services.ChosoService.RE.RightActivated:FireServer(unpack({ [1] = true }))
        end

        v21 = 0
        return
      end

      return
    end
  end), "Move3 (Air Variant)")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p15)
    local bodyVelocity3, bodyPosition

    if p15.Animation.AnimationId == "rbxassetid://100446064103831" then
      if character.Humanoid.FloorMaterial == Enum.Material.Air then
        local bodyVelocity4 = Instance.new("BodyVelocity")
        bodyVelocity4.Parent = humanoidRootPart2
        bodyVelocity4.MaxForce = Vector3.new(0, 10000000000, 0)

        bodyVelocity4.Velocity = Vector3.new(0, 150, 0)
          + humanoidRootPart2.CFrame.LookVector * 35

        task.wait(0.4)
        bodyVelocity4:Destroy()
        return
      end

      spawn(function()
        selfSacrifice.Cooldown.Size = UDim2.new(1, 0, 0, 0)

        tweenService:Create(
          selfSacrifice.Cooldown, TweenInfo.new(1.5, Enum.EasingStyle.Linear),
          { Size = UDim2.new(1, 0, 1, 0) }
        ):Play()

        selfSacrifice.Cooldown.UIGradient.Color = ColorSequence.new({
          ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 255)),
        })

        selfSacrifice.Tip.Text = "USE NOW"

        CD.Value = "false"
        task.wait(1.5)

        selfSacrifice.Cooldown.UIGradient.Color = ColorSequence.new({
          ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
        })

        selfSacrifice.Cooldown.Size = UDim2.new(1, 0, 1, 0)
        selfSacrifice.Tip.Text = "SPECIAL"

        CD.Value = "true"
      end)

      for i19 = 1, 15 do
        task.wait(0.1)
      end

      if p15.IsPlaying == true and k.TimePosition <= 1 then
        local animation3 = Instance.new("Animation")
        animation3.AnimationId = "rbxassetid://108306129256457"

        local loadAnimation3 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation3)
        loadAnimation3:Play(0.3)
        loadAnimation3.Priority = Enum.AnimationPriority.Action2
        loadAnimation3:AdjustSpeed(0.5)

        bodyVelocity3 = Instance.new("BodyVelocity")
        bodyVelocity3.Parent = humanoidRootPart2
        bodyVelocity3.MaxForce = Vector3.new(10000000000, 0, 10000000000)

        spawn(function()
          for i20 = 1, 155 do
            bodyVelocity3.Velocity = humanoidRootPart2.CFrame.LookVector * (25 + i20)
            task.wait(0.03)
          end
        end)

        task.wait(3)
        loadAnimation3:Stop(0.4)
        bodyVelocity3:Destroy()

        game.TweenService:Create(humanoidRootPart2, TweenInfo.new(0.1), {
          CFrame = CFrame.lookAt(humanoidRootPart2.Position, CFrame.new(-10, 155, -344).p),
        }):Play()

        local animation4 = Instance.new("Animation")
        animation4.AnimationId = "rbxassetid://139937896533570"

        local loadAnimation4 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation4)
        loadAnimation4:Play(0.3)
        loadAnimation4.Priority = Enum.AnimationPriority.Action2
        loadAnimation4:AdjustSpeed(1)

        _G.PS(7094593247, 1, 0.2, 0.1)
        _G.PS(7455246815, 2)
        _G.PS(7455246815, 2, 0, 0.1)
        _G.PS(5563980633, 2)
        _G.PS(7094593247, 1, 0.2, 0.5)
        _G.PS(418302853, 0.2, 0.2, 1.5)

        task.delay(0.5, function()
          _G.PS(5563980633, 2, 0, 0.2)
          task.wait(0.7)

          _G.PS(7455246815, 5)
          _G.PS(9058297482, 5, 0, 3)
          _G.PS(7455246815, 5)
        end)

        task.wait(1.2)

        loadAnimation4:AdjustSpeed(0.04)
        loadAnimation4.TimePosition = 1.4

        bodyPosition = Instance.new("BodyPosition")
        bodyPosition.Parent = humanoidRootPart2
        bodyPosition.D = 100
        bodyPosition.P = 195

        spawn(function()
          for i21 = 1, 355 do
            game.TweenService:Create(humanoidRootPart2, TweenInfo.new(0.1), {
              CFrame = CFrame.lookAt(
                humanoidRootPart2.Position, CFrame.new(-10, 155 + i21, -344 + -i21 * 2).p
              ),
            }):Play()

            bodyPosition.Position = CFrame.new(-10, 155 + i21, -344 + -i21 * 2).p
            task.wait(0.01)
          end
        end)

        bodyPosition.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
        task.wait(5)
        workspace.Gravity = 0
        loadAnimation4:AdjustSpeed(1)
        task.wait(1)
        loadAnimation4:Stop()

        local animation5 = Instance.new("Animation")
        animation5.AnimationId = "rbxassetid://121718733604230"

        local loadAnimation5 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation5)
        loadAnimation5:Play(0.3)
        loadAnimation5.Priority = Enum.AnimationPriority.Action2
        loadAnimation5:AdjustSpeed(1)

        bodyPosition.P = 595

        _G.PS(7455246815, 2)
        _G.PS(7455246815, 2, 0, 0.1)
        _G.PS(5563980633, 2)
        _G.PS(7094593247, 1, 0.2, 0.5)
        _G.PS(418302853, 0.2, 0.2, 1.5)

        task.delay(0.5, function()
          _G.PS(5563980633, 2, 0, 2)
          task.wait(0.8)

          _G.PS(7455246815, 2)
          _G.PS(7455246815, 2, 0, 0.1)
          _G.PS(5563980633, 2)
          _G.PS(7094593247, 2, 0.2, 1.5)
          _G.PS(418302853, 2, 0.2, 1.5)
        end)

        task.wait(1.2)

        _G.PS(1691468753, 2, 0, 0.25)
        _G.PS(1691468753, 2, 0, 0.2)

        local v22 = 0

        for i22 = 1, 250 do
          local v23 = i22
          v22 = v22 + 1

          local part6 = Instance.new("Part")
          part6.Parent = character.SetAssets
          part6.Material = Enum.Material.Neon
          part6.Size = Vector3.new(1, 1, 1)
          part6.Anchored = true
          part6.CanCollide = false

          local instance6 = Instance.new("SpecialMesh", part6)
          instance6.MeshType = "Sphere"

          if v22 >= 15 then
            v22 = 0
          end

          if v22 >= 10 then
            part6.Color = Color3.new(1, 0, 1)
          elseif v22 >= 5 then
            part6.Color = Color3.new(1, 1, 0)
          else
            part6.Color = Color3.new(0, 0, 1)
          end

          instance6.Scale = Vector3.new(0, 15, 0)

          game.TweenService:Create(instance6, TweenInfo.new(9), {
            Scale = Vector3.new(1, 100, 1),
          }):Play()

          part6.CFrame = CFrame.new(
            humanoidRootPart2.CFrame.X + 0.3, humanoidRootPart2.CFrame.Y + 9 + v23 / 5,
            humanoidRootPart2.CFrame.Z
          ) * CFrame.Angles(0, v23, 0)

          debris:AddItem(part6, 26)

          spawn(function()
            game.TweenService:Create(part6, TweenInfo.new(1), {
              CFrame = part6.CFrame * CFrame.new(v23 / 15, -v23 * 3, 0),
            }):Play()

            task.wait(0.7)
            local cframe = part6.CFrame
            workspace.CurrentCamera.CameraType = "Scriptable"

            for i23 = 1, 255 do
              if v23 == 1 then
                workspace.CurrentCamera.CFrame = CFrame.new(
                  humanoidRootPart2.CFrame.X, -4 + humanoidRootPart2.CFrame.Y,
                  humanoidRootPart2.CFrame.Z
                ) * CFrame.Angles(math.rad(-90), 0, 0)
              end

              game.TweenService:Create(part6, TweenInfo.new(0.3), {
                CFrame = cframe * CFrame.Angles(0, 0, i23 / 15)
                  * CFrame.new(math.cos(i23 / 15) * 15, 0, math.sin(i23 / 15) * 15),
              }):Play()

              task.wait(0.01)
            end
          end)
        end

        task.wait(4)
        bodyPosition:Destroy()
        workspace.Gravity = 15.2
        task.wait(5)
        workspace.Gravity = 198.2
      end

      return
    end
  end), "Move4")

  pcall(function() localPlayer.PlayerGui.Main.Moveset.Disortion:Destroy() end)
  local inCooldown2, disortion

  if getgenv().Move6 == true then
    disortion = localPlayer.PlayerGui.Main.Moveset["Blood Edge"]:Clone()
    disortion.Parent = localPlayer.PlayerGui.Main.Moveset
    disortion.Name = "Disortion"

    inCooldown2 = Instance.new("StringValue", disortion)
    inCooldown2.Name = "InCooldown"
    inCooldown2.Value = "false"

    disortion.Key.Text = "6"
    disortion.ItemName.Text = "Disortion"
    disortion.Tip.Text = "CLOSE RANGE"
    disortion.Tip.Visible = true
    disortion.Cooldown.Size = UDim2.new(1, 0, 0, 0)

    disortion.Cooldown.UIGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })

    disortion.Cooldown.BackgroundColor3 = Color3.new(0.3, 0, 0)

    function Six()
      if character.Info:FindFirstChild("Stun") or character.Info:FindFirstChild("InSkill") then
        return
      end

      local connect

      if inCooldown2.Value == "false" then
        warn("go")
        disortion.Cooldown.Size = UDim2.new(1, 0, 0, 0)

        tweenService:Create(disortion.Cooldown, TweenInfo.new(8.2, Enum.EasingStyle.Linear), {
          Size = UDim2.new(1, 0, 1, 0),
        }):Play()

        task.delay(8.2, function() inCooldown2.Value = "false" end)

        connect = humanoidRootPart2.ChildAdded:Connect(function(child)
          if child:IsA("BodyVelocity") then
            child.MaxForce = Vector3.new(0, 0, 0)
          end
        end)

        task.delay(1.5, function() connect:Disconnect() end)

        for index3, value6 in ipairs((workspace.Characters:GetChildren())) do
          local v24 = value6

          if v24:IsA("Model") and v24 ~= character then
            v24.HumanoidRootPart.Size = Vector3.new(55, 55, 55)
            task.delay(3, function() v24.HumanoidRootPart.Size = Vector3.new(2, 2, 2) end)
          end
        end

        _G.Use("Front Dash")
      end
    end

    f3(userInputService.InputBegan:Connect(function(input2, p16)
      if p16 == true then
        return
      end

      if input2.KeyCode == Enum.KeyCode.Six then
        spawn(function() Six() end)
      end
    end), "Move6 (Keybind)")

    f3(
      disortion.ItemName.MouseButton1Click:Connect(function() spawn(function() Six() end) end),
      "Move6 (Tap)"
    )
  end

  local stringValue = Instance.new("StringValue")
  stringValue.Value = "false"

  f3(character.Humanoid.AnimationPlayed:Connect(function(p17)
    local loadAnimation6

    if p17.Animation.AnimationId == "rbxassetid://110978068388232" then
      stringValue.Value = "true"

      local animation6 = Instance.new("Animation")
      animation6.AnimationId = "rbxassetid://17818077320"

      loadAnimation6 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation6)
      loadAnimation6:Play(0.3)
      loadAnimation6.Priority = Enum.AnimationPriority.Action3
      loadAnimation6:AdjustSpeed(0)

      spawn(function()
        while p17.IsPlaying do
          loadAnimation6.TimePosition = 0.2 + p17.TimePosition / 3
          task.wait(0.01)
        end

        loadAnimation6:Stop(0.5)
      end)

      selfSacrifice.Cooldown.Size = UDim2.new(1, 0, 1, 0)

      tweenService:Create(selfSacrifice.Cooldown, TweenInfo.new(6, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 0, 0),
      }):Play()

      task.delay(6, function() stringValue.Value = "false" end)

      if stringValue.Value == "true" then
        p17:Stop()

        local animation7 = Instance.new("Animation")
        animation7.AnimationId = "rbxassetid://17588165564"

        local loadAnimation7 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation7)
        loadAnimation7:Play(0.3)
        loadAnimation7.Priority = Enum.AnimationPriority.Action2
        loadAnimation7:AdjustSpeed(1)
        loadAnimation7.TimePosition = 7

        local v25 = nil

        for i24 = 1, 15 do
          local v26 = 45

          for key4, value7 in pairs(workspace.Characters:GetChildren()) do
            if value7:IsA("Model") and value7:FindFirstChild("HumanoidRootPart")
              and value7 ~= character then
              local humanoidRootPart5 = value7.HumanoidRootPart
              local cframe2 = CFrame.new(0, 0, -7)

              local magnitude2 = (humanoidRootPart5.Position
                - (humanoidRootPart2.CFrame * cframe2).p).Magnitude

              if magnitude2 < v26 then
                v26 = magnitude2
                v25 = humanoidRootPart5
              end
            end
          end

          local highlight = Instance.new("Highlight")
          highlight.Parent = v25.Parent
          highlight.FillColor = Color3.new(1, 1, 1)

          game.TweenService:Create(highlight, TweenInfo.new(0.1), {
            FillColor = Color3.new(0.1, 0, 0),
          }):Play()

          highlight.OutlineColor = Color3.new(1, 0, 0)
          highlight.FillTransparency = 0
          highlight.DepthMode = "Occluded"

          task.delay(0.1, function() highlight:Destroy() end)
          task.wait(0.02)
        end

        workspace.CurrentCamera.CFrame = v25.CFrame * CFrame.new(0, 0, -17)
          * CFrame.Angles(-math.rad(40), 0, 0)

        for i25 = 1, 35 do
          humanoidRootPart2.CFrame = v25.CFrame * CFrame.new(0, 0, 14 + -i25 / 3.5)
          task.wait(0.01)
        end
      end
    end
  end), "Front Dash Special")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p18)
    if p18.Animation.AnimationId == "rbxassetid://75203303352791"
      or p18.Animation.AnimationId == "rbxassetid://117223862448096" then
      local clone6 = lindwurm.FacelessDash:Clone()
      clone6.Parent = workspace
      clone6.CFrame = humanoidRootPart2.CFrame

      for index4, value8 in ipairs((clone6:GetChildren())) do
        local v27 = value8

        if v27:IsA("ParticleEmitter") then
          local lifetime = v27.Lifetime

          v27.Lifetime = NumberRange.new(0.5)
          v27:Emit(15)

          task.delay(0.1, function() v27.Lifetime = lifetime end)
        end
      end

      for key5, value9 in pairs(character:GetDescendants()) do
        local v28 = value9

        if v28:IsA("BasePart") or v28:IsA("Decal") or v28:IsA("MeshPart") then
          task.spawn(function()
            if v28.Name:match("Hitbox") then
              return
            end

            if v28.Name:match("HumanoidR") then
              return
            end

            if v28.Parent.Name == "#NinjaKATANA" then
              return
            end

            if v28.Name:match("Sh") then
              return
            end

            local transparency2 = v28.Transparency
            v28.Transparency = 1

            spawn(function()
              task.wait(0.3)
              v28.Transparency = transparency2
            end)
          end)
        elseif v28:IsA("ParticleEmitter") then
          local rate = v28.Rate
          v28.Rate = 0

          spawn(function()
            task.wait(0.3)
            v28.Rate = rate
          end)
        elseif v28:IsA("Trail") then
          local transparency3 = v28.Transparency

          v28.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1),
          })

          spawn(function()
            task.wait(0.3)
            v28.Transparency = transparency3
          end)
        end
      end

      for i26 = 1, 15 do
        clone6.CFrame = humanoidRootPart2.CFrame
        task.wait(0.01)
      end

      for index5, value10 in ipairs((clone6:GetChildren())) do
        if value10:IsA("ParticleEmitter") then
          value10.Rate = 0
        end
      end

      task.wait(0.5)
      clone6:Destroy()
    end
  end), "Custom Dash")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p19)
    if p19.Animation.AnimationId == "rbxassetid://134581973800784" then
      humanoidRootPart2.Velocity = Vector3.new(
        humanoidRootPart2.Velocity.X * 45, humanoidRootPart2.Velocity.Y,
        humanoidRootPart2.Velocity.Z * 45
      )

      task.delay(0.1, function() humanoidRootPart2.Velocity = Vector3.new(0, 0, 0) end)

      local clone7 = lindwurm.FacelessDash:Clone()
      clone7.Parent = workspace
      clone7.CFrame = humanoidRootPart2.CFrame

      for index6, value11 in ipairs((clone7:GetChildren())) do
        local v29 = value11

        if v29:IsA("ParticleEmitter") then
          local lifetime2 = v29.Lifetime

          v29.Lifetime = NumberRange.new(0.5)
          v29:Emit(15)

          task.delay(0.1, function() v29.Lifetime = lifetime2 end)
        end
      end

      for key6, value12 in pairs(character:GetDescendants()) do
        local v30 = value12

        if v30:IsA("BasePart") or v30:IsA("Decal") or v30:IsA("MeshPart") then
          task.spawn(function()
            if v30.Name:match("Hitbox") then
              return
            end

            if v30.Name:match("HumanoidR") then
              return
            end

            if v30.Parent.Name == "#NinjaKATANA" then
              return
            end

            if v30.Name:match("Sh") then
              return
            end

            local transparency4 = v30.Transparency
            v30.Transparency = 1

            spawn(function()
              task.wait(0.3)
              v30.Transparency = transparency4
            end)
          end)
        elseif v30:IsA("ParticleEmitter") then
          local rate2 = v30.Rate
          v30.Rate = 0

          spawn(function()
            task.wait(0.3)
            v30.Rate = rate2
          end)
        elseif v30:IsA("Trail") then
          local transparency5 = v30.Transparency

          v30.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1),
          })

          spawn(function()
            task.wait(0.3)
            v30.Transparency = transparency5
          end)
        end
      end

      for i27 = 1, 15 do
        clone7.CFrame = humanoidRootPart2.CFrame
        task.wait(0.01)
      end

      for index7, value13 in ipairs((clone7:GetChildren())) do
        if value13:IsA("ParticleEmitter") then
          value13.Rate = 0
        end
      end

      task.wait(0.5)
      clone7:Destroy()
    end
  end), "BackDash Special")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p20)
    if p20.Animation.AnimationId == "rbxassetid://84039122607068" then
      humanoidRootPart2.CFrame = humanoidRootPart2.CFrame * CFrame.new(0, 0, -15)
      local v31 = false

      for i28 = 1, 150 do
        if p20.TimePosition >= 2 then
          v31 = true
          break
        end

        task.wait(0.01)
      end

      if v31 == true then
        local animation8 = Instance.new("Animation")
        animation8.AnimationId = "rbxassetid://140624814858590"

        local loadAnimation8 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation8)
        loadAnimation8:Play(0.3)
        loadAnimation8.Priority = Enum.AnimationPriority.Action2
        loadAnimation8:AdjustSpeed(1)

        task.wait(1)
        loadAnimation8:Stop()

        local animation9 = Instance.new("Animation")
        animation9.AnimationId = "rbxassetid://121611940539367"

        local loadAnimation9 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation9)
        loadAnimation9:Play(0.3)
        loadAnimation9.Priority = Enum.AnimationPriority.Action2
        loadAnimation9:AdjustSpeed(1.3)

        clone.FacelessDagger.C1 = CFrame.new(-0.8, 0, -1) * CFrame.Angles(0, math.rad(-90), 0)
        Skill(character["Right Arm"], 1)
        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1), { FieldOfView = 40 }):Play()

        local blurEffect = Instance.new("BlurEffect")
        blurEffect.Parent = game.Lighting

        game.TweenService:Create(blurEffect, TweenInfo.new(1), { Size = 15 }):Play()

        _G.PS("6835350802", 1)
        _G.PS("6835350802", 1, 0.8, 0.3)
        _G.PS("597948098", 1)

        task.wait(0.7)

        _G.PS("3313098116", 1, 0.3)
        _G.PS("3245334797", 0.3, 2.5)

        workspace.CurrentCamera.FieldOfView = 120

        game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1), { FieldOfView = 70 }):Play()
        game.TweenService:Create(blurEffect, TweenInfo.new(0.3), { Size = 0 }):Play()

        task.wait(0.6)
        clone.FacelessDagger.C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
        loadAnimation9:Stop(0.6)
        task.wait(1)
        blurEffect:Destroy()
      end
    end
  end), "Move2")

  pcall(function() localPlayer.PlayerGui.Main.Moveset.SideStep:Destroy() end)

  if getgenv().Move7 == true then
    local sideStep = localPlayer.PlayerGui.Main.Moveset["Blood Edge"]:Clone()
    sideStep.Parent = localPlayer.PlayerGui.Main.Moveset
    sideStep.Name = "SideStep"

    local inCooldown3 = Instance.new("StringValue", sideStep)
    inCooldown3.Name = "InCooldown"
    inCooldown3.Value = "false"

    sideStep.Key.Text = "7"
    sideStep.ItemName.Text = "SideStep"
    sideStep.Tip.Text = "TP MOVE"
    sideStep.Tip.Visible = true
    sideStep.Cooldown.Size = UDim2.new(1, 0, 0, 0)

    sideStep.Cooldown.UIGradient.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })

    sideStep.Cooldown.BackgroundColor3 = Color3.new(0.3, 0, 0)

    f3(userInputService.InputBegan:Connect(function(input3, p21)
      if p21 == true then
        return
      end

      if input3.KeyCode == Enum.KeyCode.Seven then
        spawn(function() Seven() end)
      end
    end), "Move7 (Keybind)")

    f3(
      sideStep.ItemName.MouseButton1Click:Connect(function() spawn(function() Seven() end) end),
      "Move7 (Tap)"
    )
  end

  local v32 = false

  f3(humanoidRootPart2.ChildAdded:Connect(function(child2)
    local v33 = child2.Name == "BlockHit" and v32 == true
    local text2, pname, text3

    if v33 then
      _G.PS("3816362502", 1, 0.3)

      local instance7 = Instance.new("ColorCorrectionEffect", game.Lighting)
      instance7.Brightness = 1

      workspace.CurrentCamera.FieldOfView = 90

      local highlight2 = Instance.new("Highlight")
      highlight2.FillColor = Color3.new(1, 1, 0)
      highlight2.FillTransparency = 0
      highlight2.Parent = character

      game.TweenService:Create(highlight2, TweenInfo.new(1), {
        FillTransparency = 1,
        OutlineTransparency = 1,
      }):Play()

      game.TweenService:Create(instance7, TweenInfo.new(1), { Brightness = 0 }):Play()
      game.TweenService:Create(workspace.CurrentCamera, TweenInfo.new(1), { FieldOfView = 70 }):Play()

      debris:AddItem(instance7, 1)
      debris:AddItem(highlight2, 1)

      text2 = Instance.new("BillboardGui")
      local frame = Instance.new("Frame")
      pname = Instance.new("TextLabel")

      text3 = Instance.new("Sound", game.CoreGui)
      text3.SoundId = "rbxassetid://5093601873"
      text3.Looped = false
      text3.Volume = 5
      text3.Name = "Text"

      pcall(function()
        game.Players.LocalPlayer.Character.Head.Text:Destroy()
        game.CoreGui.Text:Destroy()
      end)

      text2.Name = "Text"
      text2.Parent = game.Players.LocalPlayer.Character.Head
      text2.ExtentsOffset = Vector3.new(0, 1, 0)
      text2.Size = UDim2.new(4, 0, 2, 0)
      text2.ZIndexBehavior = Enum.ZIndexBehavior.Global

      frame.Parent = text2
      frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      frame.BackgroundTransparency = 1
      frame.Size = UDim2.new(1, 0, 1, 0)

      pname.Name = "PName"
      pname.Parent = frame
      pname.BackgroundTransparency = 1
      pname.Position = UDim2.new(-1.0919999976, 0, -0.800000012, 0)
      pname.Size = UDim2.new(3, 0, 1, 0)
      pname.Font = Enum.Font.SciFi
      pname.Text = ""
      pname.TextColor3 = Color3.new(0, 0, 0)
      pname.TextScaled = true
      pname.TextSize = 3
      pname.TextStrokeColor3 = Color3.new(1, 1, 0)
      pname.TextStrokeTransparency = 0
      pname.TextWrapped = true
      pname.TextYAlignment = Enum.TextYAlignment.Top

      frame.ZIndex = 15

      spawn(function()
        for i29 = 1, 60 do
          pname.Rotation = math.tan(i29 / 40) * 15

          text2.ExtentsOffset = Vector3.new(
            9 + -math.cos(i29 / 45) * 12, -9 + math.sin(i29 / 15) * 13, 0
          )

          task.wait(0.01)
        end

        pname.Rotation = 0
      end)

      function tw(p22)
        local text4 = ""

        for i30 = 1, #p22 do
          text3:Play()
          local v34 = string.sub(p22, i30, i30)
          text4 = text4 .. v34
          pname.Text = text4

          if v34 == "." then
            wait(0.6)
          elseif v34 == ";" then
            wait(0.3)
          elseif v34 == "," then
            wait(0.3)
          elseif v34 == "!" then
            wait(0.3)
          end

          wait(0.03)
        end
      end

      task.spawn(function() tw("PERFECT BLOCK!") end)
      local v35 = nil
      local huge2 = math.huge

      for key7, value14 in pairs(workspace.Characters:GetChildren()) do
        if value14:IsA("Model") and value14:FindFirstChild("HumanoidRootPart")
          and value14 ~= character then
          local humanoidRootPart6 = value14.HumanoidRootPart
          local magnitude3 = (humanoidRootPart6.Position - humanoidRootPart2.Position).Magnitude

          if magnitude3 < huge2 then
            huge2 = magnitude3
            v35 = humanoidRootPart6
          end
        end
      end

      workspace.CurrentCamera.CFrame = v35.CFrame * CFrame.Angles(math.rad(-60), 0, 0)

      for i31 = 1, 15 do
        humanoidRootPart2.CFrame = v35.CFrame * CFrame.new(0, 0, 20)
        task.wait(0.01)
      end

      _G.Use("RedScale")
      task.wait(0.2)
      humanoidRootPart2.CFrame = v35.CFrame * CFrame.new(0, 0, 4)
      task.wait(2)
      text2:Destroy()
      text3:Destroy()
    end
  end), "Perfect Block")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p23)
    local loadAnimation10, clone8

    if p23.Animation.AnimationId == "rbxassetid://9579763957" then
      character.Info:WaitForChild("Block"):Destroy()
      v32 = true
      task.delay(0.3, function() v32 = false end)
      _G.PS("588734767", 1)

      local animation10 = Instance.new("Animation")
      animation10.AnimationId = "rbxassetid://17791064680"

      loadAnimation10 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation10)
      loadAnimation10:Play(0.1)
      loadAnimation10.Priority = Enum.AnimationPriority.Action2
      loadAnimation10:AdjustSpeed(0)

      spawn(function()
        local count = 0

        while p23.IsPlaying and character.Humanoid.Health >= 0 do
          count = count + 1
          loadAnimation10.TimePosition = 0.3 + math.sin(count / 66) / 25
          task.wait(0.01)
        end
      end)

      clone8 = lindwurm.ManaShield:Clone()
      clone8.Parent = character
      clone8.CFrame = humanoidRootPart2.CFrame
      clone8.Part.CanCollide = false
      clone8.Part.CFrame = humanoidRootPart2.CFrame
      clone8.CanCollide = false
      clone8.Weld.Part1 = humanoidRootPart2

      local clone9 = clone8.Weld:Clone()
      clone9.Part1 = clone8.Part
      clone9.Parent = clone8

      game.TweenService:Create(clone8, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
        Size = Vector3.new(6, 6, 6),
      }):Play()

      game.TweenService:Create(clone8.Part, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
        Size = Vector3.new(6, 6, 6),
      }):Play()

      task.delay(0.7, function()
        if clone8.Parent == character then
          game.TweenService:Create(clone8, TweenInfo.new(
            5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true
          ), { Size = Vector3.new(7, 7, 7) }):Play()

          game.TweenService:Create(clone8.Part, TweenInfo.new(
            5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true
          ), { Size = Vector3.new(7, 7, 7) }):Play()
        end
      end)

      p23.Stopped:Wait()
      clone8:Destroy()
      loadAnimation10:Stop(0.3)
      _G.PS("588735437", 1)
    end
  end), "Blocking")

  character.Animate.walk.WalkAnim.AnimationId = "rbxassetid://17579003479"
  character.Animate.idle.Animation1.AnimationId = "rbxassetid://18456337058"
  character.Animate.idle.Animation2.AnimationId = "rbxassetid://18456337058"

  local v36 = false

  f3(character.Humanoid.AnimationPlayed:Connect(function(p24)
    if p24.Animation.AnimationId == "rbxassetid://18456337058" then
      if v36 == true then
        return
      end

      v36 = true

      p24:Play(0.3)
      p24:AdjustSpeed(0)
      p24.Priority = Enum.AnimationPriority.Idle

      spawn(function()
        for i32 = 1, 2222155 do
          if not p24.IsPlaying then
            break
          end

          p24.TimePosition = 1 + math.sin(i32 / 55) / 6
          task.wait(0.01)
        end
      end)

      task.wait()
      v36 = false
      return
    end
  end), "Walk")

  local v37 = false

  f3(character.Humanoid.AnimationPlayed:Connect(function(p25)
    if p25.Animation.AnimationId == "rbxassetid://17579003479" then
      if v37 == true then
        return
      end

      v37 = true

      p25:Play(0.3)
      p25:AdjustSpeed(0.7)

      task.wait()
      v37 = false
      return
    end
  end), "Run")

  f3(character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function(p26)
    local v38

    if character.Humanoid.WalkSpeed >= 20 then
      local animation11 = Instance.new("Animation")
      animation11.AnimationId = "rbxassetid://"

      local loadAnimation11 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation11)
      loadAnimation11:Play(0.3)
      loadAnimation11.Priority = Enum.AnimationPriority.Action2
      loadAnimation11:AdjustSpeed(0.7)
      loadAnimation11.TimePosition = 0.6

      repeat
        if loadAnimation11.TimePosition >= 1.5 then
          warn()
          loadAnimation11.TimePosition = 1
        end

        task.wait()
        v38 = character.Humanoid.WalkSpeed <= 20 or character.Humanoid.Health == 0
      until v38

      loadAnimation11:Stop()
    end
  end), "Run")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p27)
    if p27.Animation.AnimationId == "rbxassetid://119042572747325" then
      p27:Stop()
      Skill(humanoidRootPart2, 0.2)

      local animation12 = Instance.new("Animation")
      animation12.AnimationId = "rbxassetid://18334584217"

      local loadAnimation12 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation12)
      loadAnimation12:Play()
      loadAnimation12.Priority = Enum.AnimationPriority.Action
      loadAnimation12:AdjustSpeed(1)
      loadAnimation12.TimePosition = 0.5

      task.wait(0.6)
      loadAnimation12:Stop(0.3)
    end
  end), "M3")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p28)
    if p28.Animation.AnimationId == "rbxassetid://105287938257399" then
      p28:Stop()
      Skill(humanoidRootPart2, 0.2)

      local animation13 = Instance.new("Animation")
      animation13.AnimationId = "rbxassetid://18334584217"

      local loadAnimation13 = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation13)
      loadAnimation13:Play()
      loadAnimation13.Priority = Enum.AnimationPriority.Action3
      loadAnimation13:AdjustSpeed(1)
      loadAnimation13.TimePosition = 1.5

      task.wait(0.6)
      loadAnimation13:Stop(0.3)
    end
  end), "4")

  local bloodEdge = localPlayer.PlayerGui.Main.Moveset["Blood Edge"]
  bloodEdge.Tip.Text = "VARIANT"
  bloodEdge.Tip.Visible = true

  local supernova = localPlayer.PlayerGui.Main.Moveset.Supernova
  supernova.Tip.Text = "VARIANT"
  supernova.Tip.Visible = true

  local dialogue = replicatedStorage.Utils.Choso.Dialogue
  dialogue.Chat1.Sub.Text = "IM INQUESTING IT IT SO GOOD!"
  dialogue.Chat1.Sub.Size = UDim2.new(1, 0, 1, 0)
  dialogue.Chat1.Size = UDim2.new(0.3, 0, 0.4, 0)
  dialogue.Chat1.Position = UDim2.new(0.15, 0, 0.5, 0)
  dialogue.Text1.Text = "OH... IM INQUESTING IT!"

  local ultimate2 = players.LocalPlayer.PlayerGui.Main.Ultimate
  ultimate2.Bar.Fill.UIGradient.Rotation = 0
  ultimate2.Bar.Fill.BackgroundColor3 = Color3.fromRGB(150, 150, 255)
  ultimate2.Bar.Fill.BorderColor3 = Color3.fromRGB(0, 0, 255)
  ultimate2.Bar.Fill.BorderSizePixel = 2
  ultimate2.Bar.Ready.Ready.Text = "PRESS G TO START INQUESTING IT"
  ultimate2.Title.Text = "INQUESTING"

  spawn(function()
    task.wait(0.5)

    for i33 = 1, 9999999 do
      if getgenv().Loop == true then
        break
      end

      ultimate2.Bar.UIGradient.Rotation = i33
      task.wait(0.01)
    end
  end)

  f3(character.Humanoid.AnimationPlayed:Connect(function(p29)
    local dialogue2

    if p29.Animation.AnimationId == "rbxassetid://73953354465111" then
      p29:Stop()

      dialogue2 = character.Torso:WaitForChild("Dialogue")
      dialogue2.Chat1.BackgroundColor3 = Color3.new(1, 0, 0)

      task.delay(1, function()
        game.TweenService:Create(dialogue2.Chat1, TweenInfo.new(1), {
          BackgroundColor3 = Color3.new(1, 1, 1),
        }):Play()
      end)

      local animation14 = Instance.new("Animation")
      animation14.AnimationId = "rbxassetid://98934036433592"

      local loadAnimation14 = character.Humanoid:LoadAnimation(animation14)
      loadAnimation14:Play()
      loadAnimation14.Priority = Enum.AnimationPriority.Action2
      loadAnimation14:AdjustSpeed(0.5)
      loadAnimation14.TimePosition = 1.4

      task.wait(2)
      loadAnimation14:Stop(0.6)
    end
  end), "Ultimate")

  f3(character.Humanoid.AnimationPlayed:Connect(function(p30) end), "Template")
  f3(character.Humanoid.AnimationPlayed:Connect(function(p31) end), "Template2")

  starterGui:SetCore("SendNotification", {
    Title = "INQUESTER420",
    Text = "SCRIPT LOADED WITH NO ERROR. discord inquestor420",
    Duration = 5,
    Button1 = "hell yeah",
  })

  local v39 = { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" }

  for key8, value15 in pairs(localPlayer.Character:GetChildren()) do
    local v40 = value15

    if table.find(v39, v40.Name) then
      pcall(function() v40.GlowS:Destroy() end)
      pcall(function() v40._Lsmoke:Destroy() end)

      local lsmoke = Instance.new("ParticleEmitter", v40)
      lsmoke.LightEmission = 15
      lsmoke.LightInfluence = 1
      lsmoke.Size = NumberSequence.new(0, 1, 0)
      lsmoke.Name = "_Lsmoke"

      lsmoke.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 0.97),
        NumberSequenceKeypoint.new(1, 1),
      })

      lsmoke.Lifetime = NumberRange.new(0.1, 7)
      lsmoke:Emit(25)
      lsmoke.Rate = 55
      lsmoke.Speed = NumberRange.new(0.1)
      lsmoke.SpreadAngle = Vector2.new(30, 30)
      lsmoke.Rotation = NumberRange.new(-360, 360)
      lsmoke.RotSpeed = NumberRange.new(750)
      lsmoke.LockedToPart = true
      lsmoke.Texture = "rbxassetid://11789331771"
      lsmoke.Brightness = 1
      lsmoke.LightEmission = 10
      lsmoke.LightInfluence = 0
      lsmoke.ZOffset = 2

      local glowS = Instance.new("ParticleEmitter", v40)
      glowS.LightEmission = 15
      glowS.LightInfluence = 1
      glowS.Size = NumberSequence.new(3, 0, 3)
      glowS.Name = "GlowS"

      glowS.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1, 0.96),
        NumberSequenceKeypoint.new(1, 1),
      })

      glowS.Lifetime = NumberRange.new(2)

      glowS.Squash = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 15), NumberSequenceKeypoint.new(0.5, 15),
        NumberSequenceKeypoint.new(1, 0),
      })

      glowS:Emit(155)
      glowS.Rate = 15
      glowS.Speed = NumberRange.new(0.1)
      glowS.SpreadAngle = Vector2.new(30, 30)
      glowS.Rotation = NumberRange.new(-360, 360)
      glowS.RotSpeed = NumberRange.new(0)
      glowS.LockedToPart = true
      glowS.Texture = "rbxassetid://11751891032"
      glowS.Brightness = 1
      glowS.LightEmission = 10
      glowS.LightInfluence = 0
      glowS.ZOffset = 2
    end
  end
end

MainEnv()

local v41 = getgenv()

v41.pepe = game.Players.LocalPlayer.CharacterAdded:Connect(function(character2)
  if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
  end

  local humanoid

  repeat
    task.wait()
    local humanoidRootPart7 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    humanoid = humanoidRootPart7

    humanoid = humanoidRootPart7
      and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
  until humanoid

  task.wait(0.6)
  MainEnv()
end)
