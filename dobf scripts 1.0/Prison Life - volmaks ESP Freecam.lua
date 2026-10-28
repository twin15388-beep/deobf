--[[
Game: Prison Life | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Source: https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/Prison%20Life
Source SHA-256: ba3ecd9f3315cf751c7bef4d5825661704e7546285182f4bf1ba798d504ae547
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a on a WeAreDevs/WAD-style protected input WITHOUT the v1.0.0 banner (decoded with --force); two runs produced byte-identical output.
The 1090-line Lua body below is the decoder output with ONE documented exception: we deleted the single line "      goto L9209319" (line 37 of the raw output, 20 bytes). The decoder emitted that continue-jump without its label, so the file did not compile; it was the last statement of the follow-check loop body before "until not nextPageCursor", so removing it is a fall-through to the loop test and changes no behaviour. Identifiers f1..f17, v1..v43 and p1..p30 are decoder-generated, NOT the author's names, and this provenance header is OUR addition, not a recovered author comment.
Game handlers are inline, not a loader: Drawing-library ESP (v7:createComponents builds Box "Square", Tracer "Line", HP "Line" and Name "Text" per player, with skeleton lines resolved from the R6/R15 limb names Torso/UpperTorso/Left Arm/LeftUpperLeg ...), team colouring from player.Team in f15 (Guards = RGB 0,0,255), world-to-screen projection in f9, a camera RaycastParams visibility check in f10, ESP for workspace.CellDoors, workspace.Doors, workspace.Prison_Fences and workspace.Prison_ITEMS, a freecam (StartFreecam/StopFreecam with ContextActionService "FC_KEYS"/"FC_MOUSE"/"FC_WHEEL", W/A/S/D/E/Q plus LeftShift, speed clamped to 0.05..4 in v22.Vel), a damped-spring smoother (v14.new(f, p2)/v14:Update(p3, p4)/v14:Reset(p6)), camera save/restore (v26.Push/v26.Pop), a fullbright lighting toggle f4(p7) (Brightness 3, ClockTime 12, FogEnd 1000000000) and setfpscap(0)/setfpscap(60) switching in f6(p19).
The body makes NO remote call at all (no FireServer/InvokeServer): it is client-side visual only, so it spends no currency and deletes no items.
Risks: the startup gate f1(p1) pages https://friends.roproxy.com/v1/users/<userId>/followings?limit=100 through game:HttpGet and only continues if user id 583171793 is followed - it leaks your followings list to a third-party proxy; ESP and freecam are typically bannable.
External dependencies, NOT included and NOT audited: AdvancedUtils.lua is fetched and executed from the mutable URL https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/AdvancedUtils.lua (its init() is called) and WindUI from https://github.com/Footagesus/WindUI/releases/latest/download/main.lua; executor APIs Drawing and setfpscap are required.
The code contains no PlaceId check, was never executed in Roblox, and static recovery proves neither equivalence with the unobfuscated original nor that Prison Life still uses these instance names.
Check reports/game-sources-2026-10-23-wad.md for handler parameters, limits and negative results.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2025 UnnamedDeveloperFromUA

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
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local lighting = game:GetService("Lighting")
local contextActionService = game:GetService("ContextActionService")
local starterGui = game:GetService("StarterGui")
local v1 = game:GetService("Workspace")
local localPlayer = players.LocalPlayer

local function f1(p1)
  local nextPageCursor

  repeat
    local v2 = "https://friends.roproxy.com/v1/users/" .. p1 .. "/followings?limit=100"

    if nextPageCursor then
      v2 = v2 .. "&cursor=" .. nextPageCursor
    end

    local httpGet
    local v3, v4 = pcall(function() httpGet = game:HttpGet(v2) end)

    if not v3 then
      warn("[FollowCheck] HTTP error:", v4)
      return false
    else
      local jsonDecode = httpService:JSONDecode(httpGet)

      for index, value in ipairs(jsonDecode.data or {}) do
        if value.id == 583171793 then
          return true
        end
      end

      nextPageCursor = jsonDecode.nextPageCursor
    end
  until not nextPageCursor

  return false
end

task.spawn(function()
  task.wait(2)

  if not f1(localPlayer.UserId) then
    localPlayer:Kick("please, follow @volmaks (volmaks_dev) to use this script")
  end
end)

local localPlayer2 = players.LocalPlayer
local character = localPlayer2.Character or localPlayer2.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
character:WaitForChild("HumanoidRootPart")
loadstring(game:HttpGet("https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/AdvancedUtils.lua"))().init()
local windUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local ignoreFriends = false
local teamIgnore = false
identifyexecutor()

if not workspace:FindFirstChild("RVF") then
  local rvf = Instance.new("Folder")
  rvf.Name = "RVF"
  rvf.Parent = workspace
end

local currentCamera = workspace.CurrentCamera
local v5 = false
local clickTeleport = false
local v6 = false
local speedBoost = 50
local jumpBoost = 100
local esp = false
local tracer = false
local box = false
local hpBar = false
local name = false

local v7 = {}
v7.__index = v7

local v8 = {}
local skeletonESP = false
local v9 = { Color = Color3.fromRGB(0, 255, 0), Thickness = 2, Transparency = 1 }

local v10 = {
  Brightness = lighting.Brightness,
  ClockTime = lighting.ClockTime,
  FogEnd = lighting.FogEnd,
  GlobalShadows = lighting.GlobalShadows,
}

local clamp = math.clamp
local exp = math.exp
local rad = math.rad
local pi = math.pi
local v11 = Vector3.new(1, 1, 1) * 64
local v12 = Vector2.new(0.75, 1) * 8
local v13 = rad(90)

local v14 = {}
v14.__index = v14

local function f2(title, content, duration)
  windUI:Notify({
    Title = title,
    Content = content,
    Duration = duration,
    icon = "message-circle",
  })
end

function v14.new(f, p2)
  return setmetatable({ f = f, p = p2, v = p2 * 0 }, v14)
end

function v14:Update(p3, p4)
  local v15 = self.f * 2 * pi
  local v = self.v
  local v16 = p4 - self.p
  local v17 = exp(-v15 * p3)
  local v18 = p4 + (v * p3 - v16 * (v15 * p3 + 1)) * v17

  self.p = v18
  self.v = (v15 * p3 * (v16 * v15 - v) + v) * v17

  return v18
end

local function f3(p5)
  for key, value2 in pairs(p5) do
    value2:Remove()
  end
end

function v14:Reset(p6)
  self.p = p6
  self.v = p6 * 0
end

local zero = Vector3.zero
local zero2 = Vector2.zero
local fieldOfView = 70
local v19 = v14.new(1.5, Vector3.zero)
local v20 = v14.new(1, Vector2.zero)
local v21 = v14.new(4, 0)
local v22 = {}

local v23 = {
  W = 0,
  A = 0,
  S = 0,
  D = 0,
  E = 0,
  Q = 0,
  Up = 0,
  Down = 0,
}

local v24 = { Delta = Vector2.zero, Wheel = 0 }

local function f4(p7)
  if p7 then
    lighting.Brightness = 3
    lighting.ClockTime = 12
    lighting.FogEnd = 1000000000
    lighting.GlobalShadows = false
  else
    for key2, value3 in pairs(v10) do
      lighting[key2] = value3
    end
  end
end

local v25 = 1

function v22.Vel(p8)
  v25 = clamp(v25 + p8 * (v23.Up - v23.Down) * 0.75, 0.05, 4)
  local isKeyDown = userInputService:IsKeyDown(Enum.KeyCode.LeftShift)

  return Vector3.new(v23.D - v23.A, v23.E - v23.Q, v23.S - v23.W) * (isKeyDown and 0.25 or 1)
    * v25
end

function v22.Pan()
  local delta = v24.Delta
  v24.Delta = Vector2.zero
  return Vector2.new(-delta.Y, -delta.X) * 0.05
end

function v22.Fov()
  local wheel = v24.Wheel
  v24.Wheel = 0
  return wheel
end

function v22.Start()
  contextActionService:BindAction("FC_KEYS", function(p9, p10, p11)
    v23[p11.KeyCode.Name] = p10 == Enum.UserInputState.Begin and 1 or 0
    return Enum.ContextActionResult.Sink
  end, false, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.E, Enum.KeyCode.Q, Enum.KeyCode.Up, Enum.KeyCode.Down)

  contextActionService:BindAction("FC_MOUSE", function(p12, p13, p14)
    v24.Delta = p14.Delta
    return Enum.ContextActionResult.Sink
  end, false, Enum.UserInputType.MouseMovement)

  contextActionService:BindAction("FC_WHEEL", function(p15, p16, p17)
    v24.Wheel = -p17.Position.Z
    return Enum.ContextActionResult.Sink
  end, false, Enum.UserInputType.MouseWheel)
end

function v22.Stop()
  contextActionService:UnbindAction("FC_KEYS")
  contextActionService:UnbindAction("FC_MOUSE")
  contextActionService:UnbindAction("FC_WHEEL")

  v23 = {
    W = 0,
    A = 0,
    S = 0,
    D = 0,
    E = 0,
    Q = 0,
    Up = 0,
    Down = 0,
  }
end

local v26 = {}
local v27 = {}

function v26.Push()
  v27.cf = currentCamera.CFrame
  v27.fov = currentCamera.FieldOfView
  v27.type = currentCamera.CameraType
  v27.mouse = userInputService.MouseBehavior

  userInputService.MouseBehavior = Enum.MouseBehavior.Default
  currentCamera.CameraType = Enum.CameraType.Custom
end

function v26.Pop()
  currentCamera.CFrame = v27.cf
  currentCamera.FieldOfView = v27.fov
  currentCamera.CameraType = v27.type

  userInputService.MouseBehavior = v27.mouse
end

local function f5(p18)
  local update = v19:Update(p18, v22.Vel(p18))
  local update2 = v20:Update(p18, v22.Pan())
  fieldOfView = clamp(fieldOfView + v21:Update(p18, v22.Fov()) * 300 * p18, 30, 120)

  zero2 = zero2 + update2 * v12 * p18
  zero2 = Vector2.new(clamp(zero2.X, -v13, v13), zero2.Y)

  local v28 = CFrame.new(zero) * CFrame.fromOrientation(zero2.X, zero2.Y, 0)
    * CFrame.new(update * v11 * p18)

  zero = v28.Position

  currentCamera.CFrame = v28
  currentCamera.FieldOfView = fieldOfView
end

FreecamEnabled = false

function StartFreecam()
  if FreecamEnabled then
    return
  else
    FreecamEnabled = true
    local cframe = currentCamera.CFrame
    zero = cframe.Position
    zero2 = Vector2.new(cframe:ToEulerAnglesYXZ())
    fieldOfView = currentCamera.FieldOfView
    v19:Reset(Vector3.zero)
    v20:Reset(Vector2.zero)
    v21:Reset(0)
    v26.Push()
    v22.Start()
    runService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, f5)
    return
  end
end

function StopFreecam()
  if not FreecamEnabled then
    return
  end

  FreecamEnabled = false
  v22.Stop()
  runService:UnbindFromRenderStep("Freecam")
  v26.Pop()
end

local function f6(p19)
  if setfpscap then
    if p19 then
      setfpscap(0)
    else
      setfpscap(60)
    end
  else
    warn("Executor does not support setfpscap")
    f2("Errpr :X", "Executor does not support setfpscap", 3)
  end
end

function v7.new()
  local v29 = setmetatable({}, v7)
  v29.espCache = {}
  return v29
end

function v7:createDrawing(p20, p21)
  local drawing = Drawing.new(p20)

  for key3, value4 in pairs(p21) do
    drawing[key3] = value4
  end

  return drawing
end

function v7:createComponents()
  return {
    Box = self:createDrawing("Square", {
      Thickness = 1,
      Transparency = 1,
      Color = Color3.fromRGB(255, 255, 255),
      Filled = false,
    }),
    Tracer = self:createDrawing("Line", {
      Thickness = 1,
      Transparency = 1,
      Color = Color3.fromRGB(255, 255, 255),
    }),
    HP = self:createDrawing("Line", {
      Thickness = 2,
      Transparency = 1,
      Color = Color3.fromRGB(0, 255, 0),
    }),
    Name = self:createDrawing("Text", {
      Size = 18,
      Center = true,
      Outline = true,
      Color = Color3.fromRGB(255, 255, 255),
      OutlineColor = Color3.fromRGB(0, 0, 0),
    }),
  }
end

function v7:hideComponents(p22)
  for key4, value5 in pairs(p22) do
    value5.Visible = false
  end
end

local function f7()
  return (Drawing.new("Line"))
end

function v7:removeEsp(p23)
  local v30 = self.espCache[p23]

  if v30 then
    for key5, value6 in pairs(v30) do
      value6:Remove()
    end

    self.espCache[p23] = nil
  end
end

local function f8(p24)
  if not p24 or not p24.Team then
    return "Unknown"
  else
    local name2 = p24.Team.Name

    if name2 == "Inmates" then
      return "Inmates"
    elseif name2 == "Guards" then
      return "Guards"
    else
      if name2 == "Criminals" then
        return "Criminals"
      end

      return "Unknown"
    end
  end
end

local connect, v31

local function f9(p25)
  local localPlayer3 = players.LocalPlayer
  local currentCamera2 = workspace.CurrentCamera

  local vector = Vector2.new(
    currentCamera2.ViewportSize.X / 2, currentCamera2.ViewportSize.Y / 2
  )

  if connect then
    connect:Disconnect()
    connect = nil
  end

  local f10

  if p25 then
    function f10()
      local position = currentCamera2.CFrame.Position
      local lookVector = currentCamera2.CFrame.LookVector

      local raycastParams = RaycastParams.new()
      raycastParams.FilterDescendantsInstances = { localPlayer3.Character }
      raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

      local raycast = workspace:Raycast(position, lookVector * 1000, raycastParams)

      if raycast then
        local model = raycast.Instance:FindFirstAncestorOfClass("Model")

        if model and model ~= localPlayer3.Character then
          local humanoid2 = model:FindFirstChildOfClass("Humanoid")
          local head = model:FindFirstChild("Head")
          local getPlayerFromCharacter = players:GetPlayerFromCharacter(model)

          if humanoid2 and head and getPlayerFromCharacter then
            if ignoreFriends and localPlayer3:IsFriendsWith(getPlayerFromCharacter.UserId) then
              return nil
            end

            if teamIgnore then
              local v32 = f8(localPlayer3)
              local v33 = f8(getPlayerFromCharacter)

              if v32 == "Inmates" or v32 == "Criminals" then
                if v33 == "Inmates" or v33 == "Criminals" then
                  return nil
                end
              end

              if v32 == "Guards" then
                if v33 == "Guards" then
                  return nil
                end
              end

              return { Head = head, Humanoid = humanoid2, Name = model.Name }
            end

            return { Head = head, Humanoid = humanoid2, Name = model.Name }
          end

          return nil
        end

        return nil
      end

      return nil
    end

    v5 = true

    connect = runService.RenderStepped:Connect(function()
      if not v5 then
        return
      elseif v31 then
        local v34 = { currentCamera2:WorldToViewportPoint(v31.Head.Position) }

        if v34[2] then
          if (userInputService:GetMouseLocation() - vector).Magnitude > 75 then
            v31 = nil
            return
          end

          if v31.Humanoid and v31.Humanoid.Health > 0 then
            currentCamera2.CFrame = CFrame.new(
              currentCamera2.CFrame.Position, v31.Head.Position
            )
          else
            v31 = nil
          end

          return
        end

        v31 = nil
        return
      else
        local v35 = f10()

        if v35 then
          v31 = v35
        end

        return
      end
    end)
  else
    v5 = false
    v31 = nil
  end
end

local function f11()
  return localPlayer2.Character
end

local function f12()
  local v36 = f11()
  return v36 and v36:FindFirstChild("HumanoidRootPart")
end

local function f13()
  local v37 = f11()
  return v37 and v37:FindFirstChildOfClass("Humanoid")
end

local function f14(p26, p27, p28)
  local v38 = p27
  v38 = v38 or 10

  local v39 = f12()
  local v40 = f13()

  if not v39 or not v40 then
    return
  end

  local unit = p26 - v39.Position

  if unit.Magnitude <= 0 then
    return
  end

  unit = unit.Unit

  v40.Sit = true
  v40.PlatformStand = false

  local connect2 = nil

  connect2 = runService.Heartbeat:Connect(function()
    if not v39 or not v40 or v40.Health <= 0 then
      if connect2 then
        connect2:Disconnect()
      end

      return
    else
      local position2 = v39.Position
      local magnitude = (p26 - position2).Magnitude

      if magnitude <= v38 then
        v39.CFrame = CFrame.new(p26)
        v40.Sit = false

        if connect2 then
          connect2:Disconnect()
        end

        return
      else
        local v41 = math.min(v38, magnitude)
        v39.CFrame = CFrame.new(position2 + unit * v41)
        return
      end
    end
  end)

  task.delay(5, function()
    if connect2 then
      connect2:Disconnect()
    end

    if v40 then
      v40.Sit = false
    end
  end)
end

local function f15(p29)
  local v42 = f8(p29)

  if v42 == "Guards" then
    return Color3.fromRGB(0, 0, 255)
  elseif v42 == "Inmates" then
    return Color3.fromRGB(255, 0, 0)
  else
    if v42 == "Criminals" then
      return Color3.fromRGB(255, 165, 0)
    end

    return Color3.fromRGB(255, 255, 255)
  end
end

local function f16(p30)
  local v43 = {}
  v8[p30] = v43

  local function f17()
    if not skeletonESP or not esp then
      for key6, value7 in pairs(v43) do
        value7.Visible = false
      end

      return
    end

    local v44, v45

    if not p30.Character or not p30.Character:FindFirstChild("HumanoidRootPart") then
      for key7, value8 in pairs(v43) do
        value8.Visible = false
      end

      return
    else
      local character2 = p30.Character
      local humanoid3 = character2:FindFirstChild("Humanoid")

      if not humanoid3 then
        return
      end

      if humanoid3.RigType == Enum.HumanoidRigType.R15 then
        v44 = {
          Head = character2:FindFirstChild("Head"),
          UpperTorso = character2:FindFirstChild("UpperTorso"),
          LowerTorso = character2:FindFirstChild("LowerTorso"),
          LeftUpperArm = character2:FindFirstChild("LeftUpperArm"),
          LeftLowerArm = character2:FindFirstChild("LeftLowerArm"),
          LeftHand = character2:FindFirstChild("LeftHand"),
          RightUpperArm = character2:FindFirstChild("RightUpperArm"),
          RightLowerArm = character2:FindFirstChild("RightLowerArm"),
          RightHand = character2:FindFirstChild("RightHand"),
          LeftUpperLeg = character2:FindFirstChild("LeftUpperLeg"),
          LeftLowerLeg = character2:FindFirstChild("LeftLowerLeg"),
          LeftFoot = character2:FindFirstChild("LeftFoot"),
          RightUpperLeg = character2:FindFirstChild("RightUpperLeg"),
          RightLowerLeg = character2:FindFirstChild("RightLowerLeg"),
          RightFoot = character2:FindFirstChild("RightFoot"),
        }

        v45 = {
          { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
          { "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" },
          { "LeftLowerLeg", "LeftFoot" }, { "LowerTorso", "RightUpperLeg" },
          { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
          { "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" },
          { "LeftLowerArm", "LeftHand" }, { "UpperTorso", "RightUpperArm" },
          { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
        }
      else
        v44 = {
          Head = character2:FindFirstChild("Head"),
          Torso = character2:FindFirstChild("Torso"),
          LeftArm = character2:FindFirstChild("Left Arm"),
          RightArm = character2:FindFirstChild("Right Arm"),
          LeftLeg = character2:FindFirstChild("Left Leg"),
          RightLeg = character2:FindFirstChild("Right Leg"),
        }

        v45 = {
          { "Head", "Torso" }, { "Torso", "LeftArm" }, { "Torso", "RightArm" },
          { "Torso", "LeftLeg" }, { "Torso", "RightLeg" },
        }
      end

      for index2, value9 in ipairs(v45) do
        local v46 = v44[value9[1]]
        local v47 = v44[value9[2]]

        if v46 and v47 then
          local v48, v49 = currentCamera:WorldToViewportPoint(v46.Position)
          local v50, v51 = currentCamera:WorldToViewportPoint(v47.Position)
          local v52 = v43[index2]

          local v53 = v52
          v53 = v52 or f7()

          v43[index2] = v53

          v53.Color = v9.Color
          v53.Thickness = v9.Thickness
          v53.Transparency = v9.Transparency

          if v49 and v51 then
            v53.From = Vector2.new(v48.X, v48.Y)
            v53.To = Vector2.new(v50.X, v50.Y)
            v53.Visible = true
          else
            v53.Visible = false
          end
        elseif v43[index2] then
          v43[index2].Visible = false
        end
      end

      return
    end
  end

  runService.RenderStepped:Connect(function()
    if p30 and p30.Parent then
      f17()
    else
      f3(v43)
    end
  end)
end

for index3, value10 in ipairs(players:GetPlayers()) do
  if value10 ~= localPlayer2 then
    f16(value10)
  end
end

players.PlayerAdded:Connect(function(player)
  if player ~= localPlayer2 then
    f16(player)
  end
end)

players.PlayerRemoving:Connect(function(player2)
  if v8[player2] then
    f3(v8[player2])
    v8[player2] = nil
  end
end)

localPlayer2.CharacterAdded:Connect(function(character3)
  character = character3
  humanoid = character3:WaitForChild("Humanoid")
  character3:WaitForChild("HumanoidRootPart")
end)

local window = windUI:CreateWindow({
  Title = "Revenge Hub | Prison Life",
  Icon = "door-open",
  Author = "by volmaks.dev",
  Folder = "Revenge Hub",
  Size = UDim2.fromOffset(580, 460),
  MinSize = Vector2.new(560, 350),
  MaxSize = Vector2.new(850, 560),
  Transparent = true,
  Theme = "Dark",
  Resizable = true,
  SideBarWidth = 200,
  BackgroundImageTransparency = 0.42,
  HideSearchBar = true,
  ScrollBarEnabled = false,
  User = {
    Enabled = true,
    Anonymous = false,
    Callback = function()
      f2("???", [[
That's you 

 volmaks.dev was here)]], 3)
    end,
  },
})

local mainTab = window:Tab({ Title = "Main", Icon = "bird", Locked = false })
mainTab:Section({ Title = "Aim Assist" })
mainTab:Divider()

mainTab:Toggle({
  Title = "Aim Assist",
  Desc = "First person view only",
  Icon = "crosshair",
  Default = false,
  Callback = function(value11) f9(value11) end,
})

mainTab:Toggle({
  Title = "Ignore Friends",
  Icon = "crosshair",
  Default = false,
  Callback = function(value12) ignoreFriends = value12 end,
})

mainTab:Toggle({
  Title = "Team Ignore",
  Icon = "crosshair",
  Default = false,
  Callback = function(value13) teamIgnore = value13 end,
})

mainTab:Divider()
mainTab:Section({ Title = "Player" })
mainTab:Divider()

local connect3

mainTab:Toggle({
  Title = "SpeedBoost",
  CurrentValue = false,
  Flag = "speedBoostToggle",
  Callback = function(value14)
    if connect3 then
      connect3:Disconnect()
      connect3 = nil
    end

    if value14 then
      connect3 = runService.RenderStepped:Connect(function() humanoid.WalkSpeed = speedBoost end)
    end
  end,
})

mainTab:Slider({
  Title = "Speed boost",
  Step = 1,
  Value = { Min = 16, Max = 40, Default = 16 },
  Callback = function(value15) speedBoost = value15 end,
})

mainTab:Toggle({
  Title = "Jumpboost",
  CurrentValue = false,
  Flag = "jumpBoostToggle",
  Callback = function(value16)
    if value16 then
      if humanoid then
        humanoid.UseJumpPower = true
        humanoid.JumpPower = jumpBoost
      end
    else
      humanoid.UseJumpPower = false
    end
  end,
})

mainTab:Slider({
  Title = "Jump boost",
  Step = 1,
  Value = { Min = 50, Max = 150, Default = 100 },
  Callback = function(value17) jumpBoost = value17 end,
})

local espTab = window:Tab({ Title = "Esp", Icon = "hat-glasses", Locked = false })

espTab:Toggle({
  Title = "ESP",
  Icon = "eye",
  Default = false,
  Callback = function(value18) esp = value18 end,
})

espTab:Toggle({
  Title = "Skeleton ESP",
  Icon = "activity",
  Default = false,
  Callback = function(value19)
    skeletonESP = value19

    if not value19 then
      for key8, value20 in pairs(v8) do
        for key9, value21 in pairs(value20) do
          value21.Visible = false
        end
      end
    end
  end,
})

espTab:Toggle({
  Title = "Tracer",
  Icon = "move",
  Default = true,
  Callback = function(value22) tracer = value22 end,
})

espTab:Toggle({
  Title = "Box",
  Icon = "square",
  Default = true,
  Callback = function(value23) box = value23 end,
})

espTab:Toggle({
  Title = "HP Bar",
  Icon = "activity",
  Default = true,
  Callback = function(value24) hpBar = value24 end,
})

espTab:Toggle({
  Title = "Name",
  Icon = "user",
  Default = true,
  Callback = function(value25) name = value25 end,
})

local teleportTab = window:Tab({ Title = "Teleport", Icon = "bird", Locked = false })

teleportTab:Toggle({
  Title = "Click Teleport",
  Icon = "mouse-pointer",
  Default = false,
  Callback = function(value26)
    clickTeleport = value26
    f2("Click TP", value26 and "ClickTP enabled (LMB)" or "ClickTP disabled", 2)
  end,
})

teleportTab:Button({
  Title = "TP to Crimbase",
  Desc = "",
  Locked = false,
  Callback = function()
    character.PrimaryPart.CFrame = workspace.Prison_ITEMS.clothes.Mafia.ITEMPICKUP.CFrame
    f2("Success", "", 2)
  end,
})

teleportTab:Button({
  Title = "TP to Armory Room",
  Desc = "",
  Locked = false,
  Callback = function()
    character.PrimaryPart.CFrame = workspace.Prison_ITEMS.clothes["Riot Police"].vest.CFrame
    f2("Success", "", 2)
  end,
})

local miscTab = window:Tab({ Title = "Misc", Icon = "bird", Locked = false })

miscTab:Button({
  Title = "Remove All fences",
  Desc = "",
  Locked = false,
  Callback = function()
    for index4, value27 in ipairs(workspace.Prison_Fences:GetChildren()) do
      value27:Destroy()
    end

    f2("Success", "All fences have been successfully destroyed", 2)
  end,
})

miscTab:Button({
  Title = "Remove All Doors",
  Desc = "",
  Locked = false,
  Callback = function()
    workspace.CellDoors:Destroy()
    workspace.Doors:Destroy()
    f2("Success", "All cell doors have been successfully destroyed", 2)
  end,
})

miscTab:Toggle({
  Title = "Freecam",
  Icon = "camera",
  Default = false,
  Callback = function(value28)
    if value28 then
      StartFreecam()
    else
      StopFreecam()
    end

    f2("Freecam", value28 and "Enabled" or "Disabled", 2)
  end,
})

miscTab:Toggle({
  Title = "Full Bright",
  Icon = "sun",
  Default = false,
  Callback = function(value29) f4(value29) end,
})

miscTab:Toggle({
  Title = "FPS Unlocker",
  Icon = "zap",
  Default = false,
  Callback = function(value30)
    f6(value30)
    f2("FPS Unlocker", value30 and "FPS unlocked" or "FPS capped to 60", 2)
  end,
})

local getMouse = localPlayer2:GetMouse()

userInputService.InputBegan:Connect(function(input, p31)
  local v54

  if p31 then
    return
  elseif not clickTeleport then
    return
  else
    if v6 then
      return
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
      if getMouse.Hit then
        v6 = true
        v54 = getMouse.Hit.Position + Vector3.new(0, 3, 0)

        task.spawn(function()
          f14(v54, 15, 0.04)
          task.wait(0.3)
          v6 = false
        end)
      end
    end

    return
  end
end)

local v55 = v7.new()

runService.RenderStepped:Connect(function()
  for index5, value31 in ipairs(players:GetPlayers()) do
    if value31 ~= LocalPlayer and value31.Character
      and value31.Character:FindFirstChild("HumanoidRootPart") then
      if not v55.espCache[value31] then
        v55.espCache[value31] = v55:createComponents()
      end

      local v56 = v55.espCache[value31]
      local character4 = value31.Character
      local humanoidRootPart = character4:FindFirstChild("HumanoidRootPart")
      local humanoid4 = character4:FindFirstChild("Humanoid")
      local v57, v58 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)

      if v58 and esp then
        if box then
          v56.Box.Size = Vector2.new(35, 50)
          v56.Box.Position = Vector2.new(v57.X - 17.5, v57.Y - 25)
          v56.Box.Visible = true
        else
          v56.Box.Visible = false
        end

        if tracer then
          v56.Tracer.From = Vector2.new(
            currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y
          )

          v56.Tracer.To = Vector2.new(v57.X, v57.Y)
          v56.Tracer.Visible = true
        else
          v56.Tracer.Visible = false
        end

        if hpBar then
          local v59 = math.clamp(humanoid4.Health / humanoid4.MaxHealth, 0, 1)

          v56.HP.From = Vector2.new(v57.X - 17.5 - 6, v57.Y + 25)
          v56.HP.To = Vector2.new(v57.X - 17.5 - 6, v57.Y + 25 - 50 * v59)
          v56.HP.Visible = true
        else
          v56.HP.Visible = false
        end

        if name then
          v56.Name.Position = Vector2.new(v57.X, v57.Y - 25 - 14)
          v56.Name.Text = value31.Name
          v56.Name.Color = f15(value31)
          v56.Name.Visible = true
        else
          v56.Name.Visible = false
        end
      else
        v55:hideComponents(v56)
      end
    end
  end
end)

players.PlayerRemoving:Connect(function(player3) v55:removeEsp(player3) end)
