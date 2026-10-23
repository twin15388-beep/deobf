--[[
Game: Jujutsu Shenanigans | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Source: https://github.com/CelerityRBLX/Roblox/blob/5fe709f2a15f8b9e900529bc32d6badb78437607/Jujutsu%20Shenanigans/Sonic.lua
Source SHA-256: dd255706af4fddd62f16a0ce814c1b1da6c88f8e0ec8cf76ae5236b6e28d8b57
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a on the WeAreDevs/WAD v1.0.0 protected input; two runs produced byte-identical output.
The 1472-line Lua body below is the decoder output copied unchanged. Identifiers f1..f24, v1..v55 and p1..p14 are decoder-generated, NOT the author's names, and this provenance header is OUR addition, not a recovered author comment.
Game evidence is in the code, not only in the upstream folder name: localPlayer:GetAttribute("Moveset") == "Naoya", replicatedStorage.Knit.Knit.Services.CursoryImpactService.RE.Activated, replicatedStorage.Knit.Knit.Services.NaoyaService.RE.RightActivated, workspace.Characters target scan with Pin/GreenPin weighting, character Moveset children (Projection Breaker, Mach Breaker, Machshot, Bleedout, Strike Of The Wind, Crushing Wind, Decisive Strike, Sonic Wind, Supersonic, Cursory Impact, Extender), Info.InSkill/Info.Stun and PlayerGui.Main.Controls.Ultimate.
Content: client-side "Sonic" rework of the Naoya moveset - keybinds Space/T/Q/Y/C/1/2/3/4/L, skill remote calls, workspace.Gravity = 170, WalkSpeed 66/120/144 and JumpPower 60/80 state machine, Animator:LoadAnimation set, workspace.Effects VFX handling, chat/voice talk:FireServer(soundId) calls and GUI text overrides.
Risks: it changes workspace.Gravity and the local character scale for everyone on the client, rewrites GUI text, streams a mutable sound URL https://github.com/CelerityRBLX/Roblox/raw/refs/heads/main/wontstopjustgo.mp3 and several rbxassetid sounds/animations, and fires game remotes that the server may reject.
There is no PlaceId check in the code, it was never run in Roblox, and static recovery proves neither equivalence with the unobfuscated original nor that the current JJS build still exposes these Knit services.
Check reports/game-sources-2026-10-22-wad.md for handler parameters, limits and negative results.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2025 Celerity

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
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local debris = game:GetService("Debris")
local tweenService = game:GetService("TweenService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local starterGui = game:GetService("StarterGui")
local lighting = game:GetService("Lighting")
local textChatService = game:GetService("TextChatService")
local players = game:GetService("Players")
local stats = game:GetService("Stats")
local animations = replicatedStorage.Animations
warn("by celerity")

local cutsceneColorCorrection = Instance.new("ColorCorrectionEffect", replicatedStorage)
cutsceneColorCorrection.Name = "CutsceneColorCorrection"
cutsceneColorCorrection.Brightness = -0.02
cutsceneColorCorrection.Contrast = 0.1
cutsceneColorCorrection.Saturation = -0.02
cutsceneColorCorrection.TintColor = Color3.fromRGB(255, 250, 245)

local cutscene = Instance.new("ScreenGui", game.CoreGui)
cutscene.Name = "Cutscene"
cutscene.ResetOnSpawn = false
cutscene.IgnoreGuiInset = true

local instance = Instance.new("Frame", cutscene)
instance.Size = UDim2.new(1, 0, 0.15, 0)
instance.Position = UDim2.new(0, 0, -0.2, 0)
instance.BackgroundColor3 = Color3.fromRGB(6, 6, 5)

local instance2 = Instance.new("Frame", cutscene)
instance2.Size = UDim2.new(1, 0, 0.15, 0)
instance2.Position = UDim2.new(0, 0, 1, 0)
instance2.BackgroundColor3 = Color3.fromRGB(6, 6, 5)

local create = tweenService:Create(instance, TweenInfo.new(
  0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
), { Position = UDim2.new(0, 0, 0, 0) })

local create2 = tweenService:Create(instance2, TweenInfo.new(
  0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out
), { Position = UDim2.new(0, 0, 0.85, 0) })

local create3 = tweenService:Create(instance, TweenInfo.new(
  0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In
), { Position = UDim2.new(0, 0, -0.15, 0) })

local create4 = tweenService:Create(instance2, TweenInfo.new(
  0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In
), { Position = UDim2.new(0, 0, 1, 0) })

local function f1()
  cutsceneColorCorrection.Parent = replicatedStorage
  starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
  create3:Play()
  create4:Play()
end

local function f2()
  cutsceneColorCorrection.Parent = lighting
  starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
  create:Play()
  create2:Play()
end

local talk = replicatedStorage.Knit.Knit.Services.JoinService.RE.Talk

settings().Physics.AllowSleep = false
settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled

warn("dih")
textChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")
local currentCamera = workspace.CurrentCamera
local rush = animations.Itadori.Rush
local decisiveStrike = animations.Naoya.DecisiveStrike
local flicker = animations.Naoya.Flicker
local knockback2 = animations.Misc.Knockback2
local jacobLadderTarget = animations.Yuta.JacobLadderTarget
local cleave = animations.Heian.Cleave
local veilstepDive = animations.Yuta.VeilstepDive
local shortVoid = animations.Gojo.ShortVoid
local risingStar = animations.Yuki.RisingStar
local loop = animations.Misc.C.Check.Loop
local throw = animations.Yuta.Throw
local ultimate = animations.Yuki.Ultimate
local hit = animations.Misc.C.BloodyMary.Hit
local wideStrike = animations.Mahito.WideStrike
local worldSlash = animations.Megumi.Mahoraga.WorldSlash

local honored = Instance.new("Animation")
honored.Name = "Honored"
honored.AnimationId = "rbxassetid://135112510644537"
honored.Parent = replicatedStorage

local mahitoSprint = Instance.new("Animation")
mahitoSprint.Name = "Mahito Sprint"
mahitoSprint.AnimationId = "rbxassetid://85012092465916"
mahitoSprint.Parent = replicatedStorage

local heartbeat = runService.Heartbeat
local localPlayer = players.LocalPlayer

writefile(
  "wontstopjustgo.mp3",
  game:HttpGet("https://github.com/CelerityRBLX/Roblox/raw/refs/heads/main/wontstopjustgo.mp3")
)

local wontstopjustgoMp3 = getcustomasset("wontstopjustgo.mp3")

local wontStopJustGo = Instance.new("Sound")
wontStopJustGo.Name = "Wont Stop, Just Go!"
wontStopJustGo.SoundId = wontstopjustgoMp3
wontStopJustGo.Volume = 0.1

local sonicBoom = Instance.new("Sound")
sonicBoom.Name = "Sonic Boom"
sonicBoom.SoundId = "rbxassetid://128861420700668"
sonicBoom.Volume = 1

local sonicBoost = Instance.new("Sound")
sonicBoost.Name = "Sonic Boost"
sonicBoost.SoundId = "rbxassetid://118787708282878"
sonicBoost.Volume = 1

local sonicComeOn = Instance.new("Sound")
sonicComeOn.Name = "Sonic Come On"
sonicComeOn.SoundId = "rbxassetid://104114645873728"
sonicComeOn.Volume = 1

local sonicComeOnStepItUp = Instance.new("Sound")
sonicComeOnStepItUp.Name = "Sonic Come On Step It Up"
sonicComeOnStepItUp.SoundId = "rbxassetid://104775181654055"
sonicComeOnStepItUp.Volume = 1

local sonicNobodyIsFasterThanMe = Instance.new("Sound")
sonicNobodyIsFasterThanMe.Name = "Sonic Nobody Is Faster Than Me"
sonicNobodyIsFasterThanMe.SoundId = "rbxassetid://77288955150403"
sonicNobodyIsFasterThanMe.Volume = 1

local sonicIveHadEnough = Instance.new("Sound")
sonicIveHadEnough.Name = "Sonic Ive Had Enough"
sonicIveHadEnough.SoundId = "rbxassetid://105271147746394"
sonicIveHadEnough.Volume = 1

sonicBoom.Parent = workspace
sonicBoost.Parent = workspace
sonicComeOn.Parent = workspace
sonicComeOnStepItUp.Parent = workspace
sonicNobodyIsFasterThanMe.Parent = workspace
sonicIveHadEnough.Parent = workspace
wontStopJustGo.Parent = workspace
local v1 = vector
local magnitude = v1.magnitude
local normalize = v1.normalize
local zero = v1.zero
local dataPing = stats.Network.ServerStatsItem["Data Ping"]
local clock = os.clock

function Wait(p1)
  local v2 = clock()

  while clock() - v2 < p1 do
    heartbeat:Wait()
  end

  return clock() - v2
end

local create5 = v1.create
local random = math.random
local abs = math.abs

local function f3(text)
  starterGui:SetCore("SendNotification", { Title = "Debug", Text = text })
end

f3("hello")

local lookAt = CFrame.lookAt

local function f4(p2)
  local pin = p2:FindFirstChild("Pin") or p2:FindFirstChild("GreenPin")

  if pin then
    pin:Destroy()
  else
    local pin2 = Instance.new("Highlight")
    pin2.Name = "Pin"
    pin2.FillTransparency = 1
    pin2.OutlineColor = Color3.fromRGB(250, 50, 50)
    pin2.Parent = p2
  end
end

local function f5(p3)
  local pin3 = p3:FindFirstChild("Pin") or p3:FindFirstChild("GreenPin")

  if pin3 then
    pin3:Destroy()
  else
    local greenPin = Instance.new("Highlight")
    greenPin.FillTransparency = 1
    greenPin.OutlineColor = Color3.fromRGB(50, 250, 200)
    greenPin.Name = "GreenPin"
    greenPin.Parent = p3
  end
end

local function f6()
  local character = localPlayer.Character
  local humanoid, humanoidRootPart

  if character then
    humanoid = character:FindFirstChild("Humanoid")
    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
  end

  return character, humanoid, humanoidRootPart
end

local v3, v4, v5, v6, v7 = f6()
local v8 = v4
local v9 = v5
local v10 = v6
local v11 = v7

local function f7()
  return v11:WaitForChild("Projection Breaker", 0.5) or v11:WaitForChild("Mach Breaker", 0.5)
    or v11:WaitForChild("Machshot", 0.5), v11:WaitForChild("Bleedout", 0.5) or v11:WaitForChild("Strike Of The Wind", 0.5)
    or v11:WaitForChild("Crushing Wind", 0.5), v11:WaitForChild("Decisive Strike", 0.5) or v11:WaitForChild("Sonic Wind", 0.5)
    or v11:WaitForChild("Supersonic", 0.5), v11:WaitForChild("Cursory Impact", 0.5) or v11:WaitForChild("Extender", 0.5)
end

local function f8()
  return v11:FindFirstChild("Mach Breaker") or v11:FindFirstChild("Machshot")
    or v11:FindFirstChild("Projection Breaker"), v11:FindFirstChild("Strike Of The Wind") or v11:FindFirstChild("Crushing Wind")
    or v11:FindFirstChild("Bleedout"), v11:FindFirstChild("Sonic Wind") or v11:FindFirstChild("Supersonic")
    or v11:FindFirstChild("Decisive Strike"), v11:FindFirstChild("Extender") or v11:FindFirstChild("Cursory Impact")
end

local characters = workspace:WaitForChild("Characters")
local getMouse = localPlayer:GetMouse()

local function f9()
  local v12 = not v9 or not v9.Parent
  local parent

  if v12 then
    repeat
      heartbeat:Wait()
      parent = v9 and v9.Parent
    until parent
  end

  local v13 = 100

  local v14 = (v9.Position
      + normalize(v9.CFrame.LookVector + v9.AssemblyLinearVelocity
          + currentCamera.CFrame.LookVector)
        * 5
      + getMouse.Hit.Position)
    * 0.5

  local getChildren = characters:GetChildren()
  local v15

  for i = 1, #getChildren do
    local v16 = getChildren[i]

    if v16 ~= localPlayer.Character then
      local humanoid2 = v16:FindFirstChild("Humanoid")
      local humanoidRootPart2 = v16:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart2 and humanoid2 then
        if humanoid2.Health > 0 then
          local v17 = magnitude(v14 - humanoidRootPart2.Position)

          if v16:FindFirstChild("Pin") then
            v17 = v17 * 0.75
          end

          if v16:FindFirstChild("GreenPin") then
            v17 = v17 * 1.25
          end

          if v17 < v13 then
            v15 = v16
            v13 = v17
          end
        end
      end
    end
  end

  return v15
end

local v18 = create5(1, 0, 1)
local v19 = create5(0, 1, 0)

local function f10(p4)
  return normalize(p4 * v18)
end

local v20 = false
local v21 = 100
local v22 = zero
local v23 = zero
local v24 = zero
local position = zero
local v25 = create5(0, -196.2, 0)
local v26 = true
local v27

local function f11(p5, p6)
  local v28 = p5 * p5
  local position2 = p6 or v27.Position
  local v29 = 0.5 * v23 * v28 * create5(0.5, 1, 0.5)

  if v26 and v23.Y < -150 then
    local v30 = 0.5 * v25 * v28

    if abs(v29.Y) > abs(v29.X) + abs(v29.Z) then
      v29 = (v30 + v29) * 0.5
      warn("omg wow wow gravity wow!!!!")
    end
  end

  return position2 + v22 * p5 + v29
end

local v31 = dataPing:GetValue() * 0.001
local v32 = 0.06
local v33 = 0.1
local v34

task.spawn(function()
  while true do
    if not heartbeat:Wait() then
      break
    end

    if not v3 or not v3.Parent then
    else
      local v35 = v20 == false and f9() or v34

      local humanoidRootPart3 = v35
      humanoidRootPart3 = v35 and v35:FindFirstChild("HumanoidRootPart")

      local v36 = v35 ~= v34
      local v37 = humanoidRootPart3

      if v36 and v37 then
        v22 = zero
        v24 = zero
        v23 = zero
        position = v37.Position
      end

      if v37 then
        v34 = v35
        v27 = v37
        v21 = magnitude(f11(v31) - v9.Position)
        local v38 = v33
        v22 = (v37.Position - position) * (1 / v32)
        v23 = (v22 - v24) * (1 / v38)
        local v39 = clock()
        local position3 = v37.Position
        local v40 = v22

        task.spawn(function()
          v31 = (v31 + dataPing:GetValue() * 0.001) * 0.5

          repeat
            heartbeat:Wait()
          until clock() - v39 > 0.06

          v32 = clock() - v39
          position = position3

          repeat
            heartbeat:Wait()
          until clock() - v39 > 0.1

          v33 = clock() - v39
          v24 = v40
        end)
      end
    end
  end
end)

task.spawn(function()
  while Wait(0.1) do
    if v34 then
      local getChildren2 = v34:GetChildren()

      for j = 1, #getChildren2 do
        local v41 = getChildren2[j]

        if v41:IsA("BasePart") then
          v41.CanCollide = false
        end

        heartbeat:Wait()
      end
    end
  end
end)

local v42 = true

local function f12(parent2)
  local attachment = Instance.new("Attachment")
  attachment.Parent = parent2

  local linearVelocity = Instance.new("LinearVelocity")
  linearVelocity.MaxForce = math.huge
  linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
  linearVelocity.Attachment0 = attachment
  linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
  linearVelocity.Parent = v9

  return linearVelocity, attachment
end

local v43 = true
local v44 = 0

local function f13(parent3)
  local speedVFX = Instance.new("ParticleEmitter")
  speedVFX.Name = "Speed VFX"

  speedVFX.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 100, 250)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 250, 250)),
  })

  speedVFX.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1),
  })

  speedVFX.Squash = NumberSequence.new({
    NumberSequenceKeypoint.new(0, -10), NumberSequenceKeypoint.new(1, -10),
  })

  speedVFX.Orientation = Enum.ParticleOrientation.VelocityParallel
  speedVFX.EmissionDirection = Enum.NormalId.Back
  speedVFX.LightEmission = 0
  speedVFX.LightInfluence = 0.5
  speedVFX.Brightness = 10
  speedVFX.Rate = 700
  speedVFX.Lifetime = NumberRange.new(0.5, 1)
  speedVFX.Parent = parent3

  return speedVFX
end

local function f14(p7, vectorVelocity, p8)
  local v45, v46 = f12(p7)
  v45.VectorVelocity = vectorVelocity

  debris:AddItem(v45, p8)
  debris:AddItem(v46, p8)
end

local aura = replicatedStorage.Utils.Hakari.IdleDeath.Aura

for v47, v48 in aura:GetDescendants() do
  if v48:IsA("ParticleEmitter") then
    v48.Color = ColorSequence.new({
      ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 200, 250)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 150, 240)),
    })

    v48.Transparency = NumberSequence.new({
      NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 1),
      NumberSequenceKeypoint.new(1, 1),
    })
  end
end

local v49 = { sonicComeOn, sonicComeOnStepItUp, sonicNobodyIsFasterThanMe }
local v50 = 1
local v51 = false
local v52 = false
local loadAnimation, loadAnimation2, v53, loadAnimation3, loadAnimation4

userInputService.InputBegan:Connect(function(input, p9)
  if v44 == "Ultimate" then
    return
  end

  if localPlayer:GetAttribute("Moveset") ~= "Naoya" then
    return
  end

  local v54

  if not loadAnimation or not v53 then
    return
  elseif p9 == false then
    if v3 and v8 and v9 and v10 then
      v10:FindFirstChild("Stun")

      if input.KeyCode == Enum.KeyCode.Space and v8.FloorMaterial == Enum.Material.Air and v42 then
        v42 = false
        v8:ChangeState(Enum.HumanoidStateType.Jumping)
        v53:Play(0.1, 1, 2)
        Wait(0.5)
        v42 = true
        return
      end

      if input.KeyCode == Enum.KeyCode.T and v43 then
        v51 = true
        local v55 = v49[v50]
        v50 = v50 == #v49 and 1 or v50 + 1

        v55.PlaybackSpeed = 1 + random(-50, 50) * 0.0005
        v55:Play()

        if v55 == sonicComeOnStepItUp then
          sonicComeOnStepItUp.TimePosition = 0.7
        end

        warn("flash press")
        v43 = false

        local vfxpart = Instance.new("Part")
        vfxpart.Name = "VFXPART"
        vfxpart.CanQuery = false
        vfxpart.CanTouch = false
        vfxpart.CanCollide = false
        vfxpart.Anchored = true
        vfxpart.Size = create5(8, 8, 8)
        vfxpart.Transparency = 1

        local v56 = f13(vfxpart)
        vfxpart.Parent = v9

        loadAnimation:Play(0.2, 1.1, 1)
        loadAnimation.TimePosition = 0.32

        local v57 = clock()
        local v58 = 150
        sonicBoost:Play()

        repeat
          local wait = heartbeat:Wait()
          local v59 = f10(v9.CFrame.LookVector)

          local v60 = v9
          v60.CFrame = v60.CFrame + v59 * v58 * wait

          local v61 = v9
          v61.AssemblyLinearVelocity = v61.AssemblyLinearVelocity + v59

          v58 = v58 < 200 and v58 + 1 or v58
          v56.Acceleration = -v59
          vfxpart.CFrame = v9.CFrame
        until clock() - v57 > 0.6

        v51 = false
        v56.Enabled = false
        loadAnimation:Stop()
        Wait(0.5)
        vfxpart:Destroy()
        v43 = true
        return
      elseif input.KeyCode == Enum.KeyCode.Q then
        return
      elseif input.KeyCode == Enum.KeyCode.Y then
        if v34 then
          f4(v34)
        end
      elseif input.KeyCode == Enum.KeyCode.C then
        if v34 then
          f5(v34)
        end
      elseif input.KeyCode == Enum.KeyCode.One then
        v44 = 1
      elseif input.KeyCode == Enum.KeyCode.Two then
        v44 = 2
      elseif input.KeyCode == Enum.KeyCode.Three then
        v44 = 3
      elseif input.KeyCode == Enum.KeyCode.Four then
        v44 = 4
      elseif input.KeyCode == Enum.KeyCode.L and v34 and v52 == false then
        f2()
        wontStopJustGo:Stop()
        v20 = true
        v44 = "Ultimate"
        sonicIveHadEnough:Play()
        loadAnimation3:Play(0.1, 2, 1)
        local v62 = clock()
        talk:FireServer(13997948756)

        repeat
          currentCamera.CameraType = Enum.CameraType.Scriptable

          currentCamera.CFrame = lookAt(
            v9.Position + v9.CFrame.LookVector * 7 + v19 * 2, v9.Position + v19 * 2
          )

          v9.CFrame = lookAt(v9.Position, v27.Position * v18 + v9.Position * v19)

          if abs(v21 - 14) < 1 then
            v9.AssemblyLinearVelocity = zero
          elseif v21 < 14 then
            v9.AssemblyLinearVelocity = normalize(v9.Position - v27.Position) * 40
          else
            v9.AssemblyLinearVelocity = normalize(v27.Position - v9.Position) * 40
          end

          heartbeat:Wait()
        until clock() - v62 > 1.5

        local v63 = clock()

        repeat
          currentCamera.CameraType = Enum.CameraType.Scriptable
          local v64 = (v9.Position + v27.Position) * 0.5 + v19 * 2
          currentCamera.CFrame = lookAt(v64 + v9.CFrame.RightVector * 15, v64)
          v9.CFrame = lookAt(v9.Position, v27.Position * v18 + v9.Position * v19)

          if abs(v21 - 14) < 1 then
            v9.AssemblyLinearVelocity = zero
          elseif v21 < 14 then
            v9.AssemblyLinearVelocity = normalize(v9.Position - v27.Position) * 40
          else
            v9.AssemblyLinearVelocity = normalize(v27.Position - v9.Position) * 40
          end

          heartbeat:Wait()
        until clock() - v63 > 2.5

        wontStopJustGo:Play()
        loadAnimation3:Stop()
        loadAnimation4:Play(0.1, 2, 4)

        for v65, v66 in aura:GetChildren() do
          local findFirstChild = v3:FindFirstChild(v66.Name)
          local sonicaura = v66:Clone()
          local sonicaura2 = findFirstChild:FindFirstChild("sonicaura")

          if sonicaura2 then
            sonicaura2:Destroy()
          end

          sonicaura.Name = "sonicaura"
          sonicaura.Parent = findFirstChild
          sonicaura.Weld.Part1 = findFirstChild
          sonicaura.Aura.Enabled = true
          sonicaura.Sparks.Enabled = true
        end

        repeat
          local wait2 = heartbeat:Wait()
          currentCamera.CameraType = Enum.CameraType.Scriptable
          local v67 = normalize(v27.Position - v9.Position)

          currentCamera.CFrame = lookAt(
            v27.Position + v19 * 8 + v67 * 12, v9.Position + v19 * 2
          )

          v9.CFrame = lookAt(v9.Position, v27.Position * v18 + v9.Position * v19)

          if abs(v21 - 14) < 1 then
            v9.AssemblyLinearVelocity = zero
          elseif v21 < 14 then
            v9.AssemblyLinearVelocity = normalize(v9.Position - v27.Position) * 40
          else
            v9.AssemblyLinearVelocity = normalize(v27.Position - v9.Position) * 40
          end

          local v68 = v8
          v68.HipHeight = v68.HipHeight + 4 * wait2
        until not loadAnimation4.IsPlaying

        f1()
        talk:FireServer(134719689134070)

        loadAnimation2:Play(0.1, 2, 5)
        loadAnimation2.Looped = true

        task.delay(2, function() loadAnimation2.Looped = false end)
        v8.HipHeight = 0.05
        currentCamera.CameraType = Enum.CameraType.Custom
        v52 = true
        v44 = 0
        v20 = false
        local v69 = v3

        local machshot, crushingWind, supersonic = f8()
        machshot.Name = "Machshot"

        crushingWind.Name = "Crushing Wind"
        supersonic.Name = "Supersonic"

        repeat
          heartbeat:Wait()
          v54 = wontStopJustGo.Playing == false or not v69.Parent
        until v54

        v52 = false

        if v69.Parent then
          local machBreaker, strikeOfTheWind, sonicWind = f8()
          machBreaker.Name = "Mach Breaker"

          strikeOfTheWind.Name = "Strike Of The Wind"
          local getDescendants = v69.GetDescendants
          sonicWind.Name = "Sonic Wind"

          for v70, v71 in getDescendants(v69) do
            if v71.Name == "sonicaura" then
              v71:Destroy()
            end
          end
        end
      end
    else
      return
    end
  else
    return
  end
end)

local loadAnimation5, loadAnimation6, loadAnimation7, loadAnimation8, loadAnimation9,
  loadAnimation10

localPlayer.CharacterAppearanceLoaded:Connect(function(p10)
  v52 = false
  wontStopJustGo:Stop()

  if localPlayer:GetAttribute("Moveset") ~= "Naoya" then
    return
  else
    local humanoid3 = p10:WaitForChild("Humanoid")
    local humanoidRootPart4 = p10:WaitForChild("HumanoidRootPart")
    local info = p10:WaitForChild("Info")
    local moveset = p10:WaitForChild("Moveset")
    v3 = p10
    v8 = humanoid3
    v9 = humanoidRootPart4
    v10 = info
    v11 = moveset
    Wait(1)
    workspace.Gravity = 170

    local humanoid4 = p10:FindFirstChildOfClass("Humanoid")
    humanoid4.AutomaticScalingEnabled = false
    humanoid4.HipHeight = 0.05

    local animator = humanoid4:WaitForChild("Animator")
    loadAnimation = animator:LoadAnimation(rush)
    local loadAnimation11 = animator.LoadAnimation
    loadAnimation2 = animator:LoadAnimation(flicker)
    v53 = loadAnimation11(animator, knockback2)

    animator:LoadAnimation(jacobLadderTarget)
    animator:LoadAnimation(decisiveStrike)

    loadAnimation5 = animator:LoadAnimation(cleave)
    loadAnimation6 = animator:LoadAnimation(veilstepDive)
    loadAnimation7 = animator:LoadAnimation(shortVoid)
    loadAnimation8 = animator:LoadAnimation(mahitoSprint)
    animator:LoadAnimation(risingStar)
    loadAnimation3 = animator:LoadAnimation(loop)
    animator:LoadAnimation(throw)
    loadAnimation4 = animator:LoadAnimation(ultimate)
    animator:LoadAnimation(hit)
    loadAnimation9 = animator:LoadAnimation(wideStrike)
    loadAnimation10 = animator:LoadAnimation(worldSlash)

    local machBreaker2, strikeOfTheWind2, sonicWind2, extender = f7()
    machBreaker2.Name = "Mach Breaker"

    strikeOfTheWind2.Name = "Strike Of The Wind"
    sonicWind2.Name = "Sonic Wind"

    extender.Name = "Extender"
    extender:SetAttribute("Key", 9)
    extender:SetAttribute("Tip", "PASSIVE")

    local ultimate2 = localPlayer:WaitForChild("PlayerGui"):WaitForChild("Main").Controls.Ultimate
    ultimate2.Title.Text = "\"I've Had Enough\""
    ultimate2.Bar.Ready.Ready.Text = ""
    ultimate2.Evade.Visible = false
    ultimate2.Special.Visible = false

    ultimate2.Bar.Fill.UIGradient.Color = ColorSequence.new(
      Color3.fromRGB(30, 100, 250), Color3.fromRGB(15, 250, 250)
    )

    ultimate2.Bar.Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

    return
  end
end)

local activated = replicatedStorage.Knit.Knit.Services.CursoryImpactService.RE.Activated

local function f15()
  activated:FireServer(
    v11:FindFirstChild("Extender") or v11:FindFirstChild("Cursory Impact"), nil
  )
end

local function f16(p11, p12)
  local v72 = p12 or 250

  local raycastParams = RaycastParams.new()
  raycastParams.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams.FilterDescendantsInstances = { characters }

  local raycast = workspace:Raycast(p11.Position, p11.CFrame.LookVector * 20, raycastParams)

  if raycast and raycast.Instance.Anchored and raycast.Instance.CanCollide then
    v72 = (magnitude(p11.Position - raycast.Position) * v72 * 0.02 + v72 * 0.5) * 0.5
  end

  return v72
end

local rightActivated

local function f17(p13, p14)
  rightActivated:FireServer(p13, p14)
end

rightActivated = replicatedStorage.Knit.Knit.Services.NaoyaService.RE.RightActivated
local v73 = 66

heartbeat:Connect(function()
  if v10 and v8 and localPlayer:GetAttribute("Moveset") == "Naoya" then
    local stun = v10:FindFirstChild("Stun")
    local v74 = v21 < 15 and f16(v9, 120) or f16(v9, 144)

    local v75 = v8
    v75.WalkSpeed = v44 == "Ultimate" and 0 or v52 and v74 or stun and v73 * 0.5 or v73

    local v76 = v8
    v76.JumpPower = v44 == "Ultimate" and 0 or v52 and 80 or stun and 0 or 60

    if v8.MoveDirection ~= zero and v8.FloorMaterial ~= Enum.Material.Air and v51 ~= true
      and not v10:FindFirstChild("InSkill") then
      if not loadAnimation8.IsPlaying then
        loadAnimation8:Play(0.12, 1.5, v52 and 2.5 or 2)
      end
    else
      loadAnimation8:Stop()
    end
  end
end)

task.spawn(function()
  while true do
    if not heartbeat:Wait() then
      break
    end

    for v77, v78 in localPlayer:WaitForChild("PlayerGui"):GetDescendants() do
      if v78:IsA("TextLabel") then
        if v78.Text == "Head of the Hei" then
          v78.Text = "The Blue Blur"
          v78.TextColor3 = Color3.fromRGB(30, 200, 250)
        end
      end
    end
  end
end)

local effects = workspace:WaitForChild("Effects")

effects.ChildAdded:Connect(function(child)
  if localPlayer:GetAttribute("Moveset") ~= "Naoya" then
    return
  end

  local v79

  if child:IsA("BasePart") and v9 then
    heartbeat:Wait()

    if magnitude(v9.Position - child.Position) > 15 or v44 == 0 then
      return
    end

    repeat
      for v80, v81 in child:GetDescendants() do
        if v81:IsA("ParticleEmitter") then
          v81.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 100, 250)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 250, 250)),
          })
        elseif v81:IsA("Trail") then
          v81.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 100, 250)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 250, 250)),
          })
        end
      end

      heartbeat:Wait()
      v79 = not child or not child.Parent
    until v79

    return
  end
end)

task.spawn(function()
  while true do
    if not heartbeat:Wait() then
      break
    end

    local getChildren3 = effects:GetChildren()

    if not v9 then
    else
      for k = 1, #getChildren3 do
        local v82 = getChildren3[k]

        if not v82 or not v82.Parent then
        elseif v82.Name == "_" then
        elseif v82.Name == "CombatTrail" and magnitude(v9.Position - v82.Position) < 6 then
          v82.Color = Color3.fromRGB(30, 200, 250)
        end
      end
    end
  end
end)

local v83 = create5(1, 2, 1)

local function f18(p15)
  local cframe = p15.CFrame
  local position4 = v9.Position
  local position5 = p15.Position
  local v84 = cframe.LookVector * -1
  local v85 = { v84, cframe.RightVector, cframe.RightVector * -1 }
  local v86 = 1024
  local v87 = #v85
  local v88 = v84

  for m = 1, v87 do
    local v89 = v85[m]
    local v90 = magnitude(position4 - (position5 + v89))

    if v89 == v84 then
      v90 = v90 * 0.95
    end

    if v90 < v86 then
      v86 = v90
      v88 = v89
    end
  end

  return v88
end

local function f19()
  local v91 = loadAnimation7
  local v92 = clock()
  v91:Play(0.12, 30, 1)
  loadAnimation7.TimePosition = 8.2
  local count = 0
  local v93 = v19 * 15

  if not v10:FindFirstChild("InSkill") then
  end

  local v94

  repeat
    local wait3 = heartbeat:Wait()

    if clock() - v92 > 0.25 + v31 then
      v93 = zero
    end

    local v95 = f10(v27.CFrame.LookVector)
    local v96 = f11(v31 * 0.9)
    local v97 = f11(v31)
    local v98 = normalize(v96 + v93 - v9.Position)

    if v21 > 5 then
      v9.CFrame = lookAt(v9.Position + v98 * wait3 * 128 * v83, v97)
      v9.AssemblyLinearVelocity = normalize(v98 - v9.Position)
    else
      v9.CFrame = lookAt(v96 - v95 * 2.5, v97)
      v9.AssemblyLinearVelocity = normalize(v98 - v9.Position)
    end

    local firstCounter = v10:FindFirstChild("Counter")

    if firstCounter then
      if count == 1 then
        break
      end

      count = count + 1
      firstCounter.Name = "FirstCounter"
    end

    local v99 = not v10:FindFirstChild("InSkill")

    v94 = v99
    v94 = v99 and clock() - v92 > 0.3
  until v94

  local v100 = 144
  v10:FindFirstChild("Counter")
  local v101

  repeat
    local wait4 = heartbeat:Wait()
    local v102 = f16(v9, v100)
    local v103 = v9
    v100 = v100 + wait4
    v103.CFrame = v103.CFrame + v9.CFrame.LookVector * wait4 * v102
    v101 = v10
  until not v101:FindFirstChild("Counter")

  loadAnimation7:Stop()
end

local function f20()
  local v104 = clock()
  loadAnimation5:Play(0.15, 30, 2)
  local v105 = 120
  local v106 = 15
  currentCamera.CameraType = Enum.CameraType.Scriptable
  talk:FireServer(6743603446)
  f2()

  if not v10:FindFirstChild("InSkill") then
  end

  local v107

  repeat
    local wait5 = heartbeat:Wait()

    if clock() - v104 > 0.22 + v31 then
      v106 = 0
    end

    local v108 = f11(v31)
    local v109 = f11(v31 + 0.01) + v27.CFrame.LookVector * (v106 + 2.5)
    local v110 = normalize(v109 - v9.Position)

    currentCamera.CFrame = currentCamera.CFrame:Lerp(lookAt(v9.Position - v9.CFrame.LookVector * 5
        - v9.CFrame.RightVector * 5
      + v19 * 3, v27.Position), 0.5)

    if magnitude(v9.Position - v109) > 5 then
      v9.CFrame = lookAt(v9.Position + v110 * wait5 * v105 * v83, v108)
      v9.AssemblyLinearVelocity = normalize(v110 - v9.Position) + v19
    else
      v9.CFrame = lookAt(v109 - v19 * 0.5, v108)
      v9.AssemblyLinearVelocity = normalize(v110 - v9.Position) + v19
    end

    v105 = v105 + 400 * wait5
    local v111 = not v10:FindFirstChild("InSkill")

    v107 = v111
    v107 = v111 and clock() - v104 > 0.3
  until v107

  f1()
  currentCamera.CameraType = Enum.CameraType.Custom
  loadAnimation5:Stop(0.15, 1.5, 2)
end

local function f21()
  local v112 = loadAnimation7
  local v113 = clock()
  v112:Play(0.12, 30, 1)
  loadAnimation7.TimePosition = 8.2
  local count2 = 0
  local v114 = v19 * 15

  local raycastParams2 = RaycastParams.new()
  raycastParams2.FilterType = Enum.RaycastFilterType.Exclude
  raycastParams2.FilterDescendantsInstances = { characters }

  if not v10:FindFirstChild("InSkill") then
  end

  local v115

  repeat
    local wait6 = heartbeat:Wait()

    if clock() - v113 > 0.25 + v31 then
      v114 = zero
    end

    local v116 = f10(v27.CFrame.LookVector)
    local v117 = f11(v31 * 0.9)
    local v118 = f11(v31)
    local v119 = normalize(v117 + v114 - v9.Position)

    if v21 > 8 then
      v9.CFrame = lookAt(v9.Position + v119 * wait6 * 128 * v83, v118)
      v9.AssemblyLinearVelocity = normalize(v119 - v9.Position)
    else
      v9.CFrame = lookAt(v117 - v116 * 2.5, v118)
      v9.AssemblyLinearVelocity = normalize(v119 - v9.Position)
    end

    local firstCounter2 = v10:FindFirstChild("Counter")

    if firstCounter2 then
      if count2 == 1 then
        break
      end

      count2 = count2 + 1
      firstCounter2.Name = "FirstCounter"
    end

    local v120 = not v10:FindFirstChild("InSkill")

    v115 = v120
    v115 = v120 and clock() - v113 > 0.3
  until v115

  loadAnimation7:Stop()

  loadAnimation9:Play(0.12, 30, 1)
  loadAnimation9.TimePosition = 4.5

  if v10:FindFirstChild("InSkill") then
    talk:FireServer(96326653225562)
  end

  local v121 = 144
  v10:FindFirstChild("Counter")
  local v122

  repeat
    local wait7 = heartbeat:Wait()
    local raycast2 = workspace:Raycast(v9.Position, v19 * 10, raycastParams2)
    local v123 = f16(v9, v121)
    local v124 = v9
    v121 = v121 + wait7 * 10
    local v125 = raycast2 and 0
    local v126 = v9.CFrame.LookVector * wait7 * v123
    local v127 = v125 or wait7 * 100
    v124.CFrame = v124.CFrame + (v126 + v19 * v127)
    v9.AssemblyLinearVelocity = v9.CFrame.LookVector + v19
    v122 = v10
  until not v122:FindFirstChild("Counter")

  loadAnimation9:Stop()
end

local function f22()
  local v128 = loadAnimation10
  local v129 = clock()
  v128:Play(0.12, 60, 3)
  local v130 = 80
  local v131 = v19 * 15
  f2()

  if not not v10:FindFirstChild("InSkill") then
    v10:FindFirstChild("Counter")
  end

  local v132

  repeat
    local wait8 = heartbeat:Wait()

    if clock() - v129 > 0.1 + v31 then
      v131 = zero
    end

    local v133 = f11(v31 + 0.01) + v131 + v27.CFrame.LookVector * 2.5
    local v134 = f11(v31)
    local v135 = normalize(v133 - v9.Position)

    if magnitude(v9.Position - v133) < 10 then
      v9.CFrame = lookAt(v133, v134)
      v9.AssemblyLinearVelocity = normalize(v135 - v9.Position)
    else
      v9.CFrame = lookAt(v9.Position + v135 * wait8 * v130 * v83, v134)
      v9.AssemblyLinearVelocity = normalize(v135 - v9.Position)
    end

    v130 = v130 + 500 * wait8
    local v136 = not v10:FindFirstChild("InSkill")

    local counter = v136
    counter = v136 or v10:FindFirstChild("Counter")

    v132 = counter
    v132 = counter and clock() - v129 > 0.3
  until v132

  currentCamera.CameraType = Enum.CameraType.Scriptable
  v10:FindFirstChild("Counter")
  local v137

  repeat
    local v138 = (v9.Position + v27.Position) * 0.5
    currentCamera.CFrame = lookAt(v138 + v9.CFrame.RightVector * -8 + v19 * 3, v138 + v19 * 2)
    heartbeat:Wait()
    v137 = v10
  until not v137:FindFirstChild("Counter")

  f1()
  currentCamera.CameraType = Enum.CameraType.Custom
end

local function f23()
  local v139 = loadAnimation5
  local v140 = clock()
  v139:Play(0.15, 30, 2)
  local v141 = 50
  local v142 = 100
  local v143 = v10
  local v144 = v19 * 15

  if not v143:FindFirstChild("InSkill") then
  end

  local v145

  repeat
    local wait9 = heartbeat:Wait()

    if clock() - v140 > 0.1 + v31 then
      v144 = zero
    end

    local v146 = f11(v31 * 0.8)
    local v147 = f11(v31)
    local v148 = normalize(v146 + v144 + (v19 * 2 + f18(v27) * 3) * v141 - v9.Position)

    if v21 > 5 then
      v9.CFrame = lookAt(v9.Position + v148 * wait9 * v142 * v83, v147)
      v9.AssemblyLinearVelocity = normalize(v148 - v9.Position) + v19
    else
      v9.CFrame = lookAt(v9.Position + v148 * wait9 * 40 * v83, v147)
      v9.AssemblyLinearVelocity = normalize(v148 - v9.Position) + v19
    end

    v141 = v141 <= 1 and 1 or v141 - 120 * wait9
    v142 = v142 + 240 * wait9
    local v149 = not v10:FindFirstChild("InSkill")

    v145 = v149
    v145 = v149 and clock() - v140 > 0.3
  until v145

  loadAnimation5:Stop(0.15, 1.5, 2)
end

local function f24()
  local v150 = clock()
  loadAnimation6:Play(0.12, 40, 1.1)
  local v151 = 80
  local v152 = v19 * 15
  local v153 = v10
  local v154 = v152

  if not not v153:FindFirstChild("InSkill") then
    v10:FindFirstChild("Counter")
  end

  local v155

  repeat
    local wait10 = heartbeat:Wait()

    if clock() - v150 > 0.1 + v31 then
      v154 = zero
    end

    local v156 = f11(v31 + 0.1)
    local v157 = f11(v31)
    local v158 = normalize(v156 + v154 + v27.CFrame.LookVector * 2 - v9.Position)

    if v21 > 5 then
      v9.CFrame = lookAt(v9.Position + v158 * wait10 * v151 * v83, v157)
      v9.AssemblyLinearVelocity = normalize(v158 - v9.Position)
    else
      v9.CFrame = lookAt(v9.Position + v158 * wait10 * 25 * v83, v157)
      v9.AssemblyLinearVelocity = normalize(v158 - v9.Position)
    end

    v151 = v151 + 300 * wait10
    local v159 = not v10:FindFirstChild("InSkill")

    local counter2 = v159
    counter2 = v159 or v10:FindFirstChild("Counter")

    v155 = counter2
    v155 = counter2 and clock() - v150 > 0.3
  until v155

  v10:FindFirstChild("Counter")
  local v160

  repeat
    heartbeat:Wait()
    v160 = v10
  until not v160:FindFirstChild("Counter")
end

task.spawn(function()
  local v161

  while true do
    if not heartbeat:Wait() then
      break
    end

    if localPlayer:GetAttribute("Moveset") ~= "Naoya" then
      Wait(1)
    end

    if v3 and v8 and v9 and v10 and v11 then
      if v9.Position.Y < -90 then
        v9.AssemblyLinearVelocity = v19 * 200
      end

      v10:FindFirstChild("Stun")
      local humanoid5 = v34 and v34:FindFirstChild("Humanoid")
      local info2 = v34 and v34:FindFirstChild("Info")
      local naoyaFrame = info2 and info2:FindFirstChild("NaoyaFrame")
      v633 = info2 and info2:FindFirstChild("InSkill")
      v634 = info2 and info2:FindFirstChild("Counter")
      local v162 = v10
      local v163 = v10
      local inSkill = v162:FindFirstChild("InSkill")
      local knockback = v163:FindFirstChild("Knockback")
      local knockback3 = info2 and info2:FindFirstChild("Knockback")
      v641 = info2 and info2:FindFirstChild("Block")

      if v44 == 1 and v27 then
        v20 = true

        if v52 then
          f20()
        else
          f23()
        end

        f14(v9, v9.CFrame.LookVector * -30, 0.2)
        v44 = v44 == 1 and 0 or v44
        v20 = false
      elseif v44 == 2 and v27 then
        v20 = true

        if v52 then
          f22()
        else
          f24()
        end

        f14(v9, v19 * 30, 0.1)
        v44 = v44 == 2 and 0 or v44
        v20 = false
      elseif v44 == 3 and v27 then
        v20 = true

        if v52 then
          f21()
        else
          f19()
        end

        if v52 and humanoid5.Health > 0 then
          f15()
          local v164 = clock()
          local v165 = 190
          currentCamera.CameraType = Enum.CameraType.Scriptable
          talk:FireServer(18319797565)
          f2()

          if clock() - v164 > 0.3 then
            v10:FindFirstChild("InSkill")
          end

          repeat
            local wait11 = heartbeat:Wait()
            local v166 = f11(v31 * 2)
            local v167 = f11(v31)
            local v168 = normalize(v166 - v9.Position)

            if magnitude(v166 - v167) > 0.15 then
              if magnitude(v9.Position - v166) < 12 then
                v9.CFrame = lookAt(v166, v167)
              else
                v9.CFrame = lookAt(v9.Position + v168 * wait11 * v165, v167)
              end
            end

            local v169 = (v27.Position + v9.Position) * 0.5
            currentCamera.CFrame = lookAt(v169 + v19 * 20 + v18 * 5, v169)
            v165 = v165 + wait11 * 15

            if v21 < 5 then
              task.spawn(f15)
            end

            local v170 = clock() - v164 > 0.3

            v161 = v170
            v161 = v170 and not v10:FindFirstChild("InSkill")
          until v161

          f1()
          currentCamera.CameraType = Enum.CameraType.Custom
          v8:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        v44 = v44 == 3 and 0 or v44
        v20 = false
      end

      if knockback3 and v21 < 25 then
        talk:FireServer(128755610900620)
      elseif knockback then
        talk:FireServer(97871211303571)
      end

      if knockback and v9.Position.Y > -90 then
        local v171 = v9
        v171.AssemblyLinearVelocity = v171.AssemblyLinearVelocity - v19 * 60
      end

      if v27 and inSkill then
        local v172 = f11(v31)

        local block = info2
        block = info2 and info2:FindFirstChild("Block")

        local v173 = v51
        local v174 = v172 * v18 + v9.Position * v19
        local v175 = v174

        if v173 or block then
          v175 = v175 + f18(v27) * 0.5
        end

        v9.CFrame = lookAt(v9.Position, v175)

        if v21 < 25 and naoyaFrame then
          f17(v175, v34)
          warn("special")
        end

        if v174.Y - v9.Position.Y > 1 then
          local v176 = v9
          v176.AssemblyLinearVelocity = v176.AssemblyLinearVelocity + v19 * 50
        end
      end
    end
  end
end)
