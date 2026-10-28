--[[
Game: Murder Mystery 2 | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Source: https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/test.lua
Source SHA-256: 144d0c252f0246add56d0ae721d1d667e1365b41d61ee492416ac266dd60b7cf
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a on a WeAreDevs/WAD-style protected input WITHOUT the v1.0.0 banner (decoded with --force); two runs produced byte-identical output.
The 1931-line Lua body below is the decoder output copied unchanged. Identifiers f1..f30, v1..v61 and p1..p16 are decoder-generated, NOT the author's names, and this provenance header is OUR addition, not a recovered author comment.
Game handlers are inline, not a loader: the map is found through workspace models with GetAttribute("MapID") (f9), coins are collected from the CoinContainer child of a workspace child (f20) with the Coin Farm loop and its speed setting, gun drops get a "GunDropHighlight" (f12) and ESP for innocent/murderer/sheriff roles goes through CreateHighlight/UpdateHighlights, the aimbot picks its target by role (f15/f16, plus the camera-lock and spectate variants f17), Fling murderer/sheriff use miniFling(p9) and f18(p10, p11, p12), Auto grab gun runs f28/f30, and the MM2 remotes are read with getPlayerLevel:InvokeServer(lp), getProfileData:InvokeServer() and ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer().
Also recovered: Fly (PC + mobile) via startFly/stopFly with W/A/S/D/Space/LeftShift, Fullbright through f27/f26/_G.SetFullBright(p15) saving _G.NormalLightingSettings, Auto-rejoin, a Balance Monitor with "DM when the balance > $n", and workspace.Lobby detection (f2).
Risks: aimbot, role ESP and Fling target other players; the script can post a Discord webhook notification (Script.WebhookEnabled, Script.SavedWebhookUrl - empty and disabled by default, you supply the URL yourself); it edits workspace.Gravity and Lighting.
External dependencies, NOT included and NOT audited: WindUI is fetched from the mutable URL https://github.com/Footagesus/WindUI/releases/latest/download/main.lua and AdvancedUtils.lua from https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/AdvancedUtils.lua; without them the UI never builds.
The code contains no PlaceId check, was never executed in Roblox, and static recovery proves neither equivalence with the unobfuscated original nor server acceptance of these remotes.
Check reports/game-sources-2026-10-23-popular.md for handler parameters, limits and negative results.
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

local httpService = game:GetService("HttpService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local teleportService = game:GetService("TeleportService")
local v1 = pcall(function() Instance.new("Part"):InvalidMethod("a") end)

while v1 do
  task.spawn()
end

game:GetChildren(function()
  while true do
    ({})[nil] = true
  end
end)

local v2, v3 = pcall(function()
  return httpService:JSONDecode("[68, \"getgold.cc\", true, 123, false, [321, null, \"goldtm\"], null, [\"a\"]]")
end)

while not v2 do
  task()
end

_G.getgoldcc = "goldtm"

while getfenv().getgoldcc ~= nil do
  game()
end

_G.getgoldcc = nil
pcall(function() game() end)
local windUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/AdvancedUtils.lua"))().init()

local window = windUI:CreateWindow({
  Title = "Revenge Hub x Vex OP | MM2",
  Icon = "droplet",
  Author = "by volmaks.dev & Vex",
  Folder = "MM2",
  Size = UDim2.fromOffset(580, 400),
  Theme = "Dark",
})

local v4 = http and http.request or syn and syn.request or fluxus and fluxus.request or request
local localPlayer = Players.LocalPlayer
local touchEnabled = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local v5 = {}

getgenv().Script = {
  CoinFarm_Enabled = false,
  Aimbot_Enabled = false,
  AimbotTarget = "Murderer",
  AimbotSpectate_Enabled = false,
  MurderEsp_Enabled = false,
  SheriffEsp_Enabled = false,
  InnocentEsp_Enabled = false,
  GunDropEsp_Enabled = false,
  JumpBoost_Enabled = false,
  SpeedBoost_Enabled = false,
  GravityBoost_Enabled = false,
  SavedGravity = 196.2,
  SavedSpeed = 16,
  SavedJumpPower = 50,
  AutoGrabGun = false,
  SavedWebhookUrl = "",
  PingWhenCoins = 100000,
  WebhookEnabled = false,
  NoclipEnabled = false,
  CoinFarmSpeed = 20,
  SaveAfterFarm_Enabled = false,
  AutoRejoin_Enabled = false,
  InfJump_Enabled = false,
}

local v6 = {}
local v7 = {}
local v8 = false
local v9 = {}
local v10 = false
local v11 = false
local v12 = false
local getPlayerLevel = replicatedStorage.Remotes.Extras.GetPlayerLevel
local getProfileData = replicatedStorage.Remotes.Inventory.GetProfileData
local v13 = false
local v14 = false
localPlayer:FindFirstChild("PlayerGui"):FindFirstChild("MainGUI"):FindFirstChild("Game"):FindFirstChild("Emotes")
local currentCamera = workspace.CurrentCamera

_G.FullBrightExecuted = _G.FullBrightExecuted or false
_G.FullBrightEnabled = _G.FullBrightEnabled or false

local v15, humanoid, humanoidRootPart

local function f1(p1)
  v15 = p1
  humanoid = p1:WaitForChild("Humanoid")
  humanoidRootPart = p1:WaitForChild("HumanoidRootPart")
end

if localPlayer.Character then
  f1(localPlayer.Character)
end

localPlayer.CharacterAdded:Connect(f1)
local bodyGyro, bodyVelocity

function startFly()
  if v10 or not humanoidRootPart or not humanoid then
    return
  end

  v10 = true
  humanoid.PlatformStand = true

  bodyGyro = Instance.new("BodyGyro")
  bodyGyro.P = 90000
  bodyGyro.MaxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
  bodyGyro.CFrame = humanoidRootPart.CFrame
  bodyGyro.Parent = humanoidRootPart

  bodyVelocity = Instance.new("BodyVelocity")
  bodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
  bodyVelocity.Velocity = Vector3.zero
  bodyVelocity.Parent = humanoidRootPart

  if touchEnabled then
    ContextActionService:BindAction(
      "FlyUp", function(p2, p3) v11 = p3 == Enum.UserInputState.Begin end, true
    )

    ContextActionService:BindAction(
      "FlyDown", function(p4, p5) v12 = p5 == Enum.UserInputState.Begin end, true
    )

    ContextActionService:SetTitle("FlyUp", "Fly ↑")
    ContextActionService:SetTitle("FlyDown", "Fly ↓")
  end
end

local function f2()
  local lobby = workspace:FindFirstChild("Lobby")

  if not lobby then
    windUI:Notify({
      Title = "Error",
      Content = "Lobby not found!",
      Icon = "x-circle",
      Duration = 2,
    })

    return
  else
    local spawnPoint = lobby:FindFirstChild("SpawnPoint")
      or lobby:FindFirstChildOfClass("SpawnLocation")

    if not spawnPoint then
      spawnPoint = lobby:FindFirstChildWhichIsA("BasePart") or lobby
    end

    if v15 and v15:FindFirstChild("HumanoidRootPart") then
      v15.HumanoidRootPart.CFrame = CFrame.new(spawnPoint.Position + Vector3.new(0, 3, 0))

      windUI:Notify({
        Title = "Success :O",
        Content = "Teleported to Lobby!",
        Icon = "check-circle",
        Duration = 2,
      })
    end

    return
  end
end

function stopFly()
  v10 = false
  v11 = false
  v12 = false

  if humanoid then
    humanoid.PlatformStand = false
  end

  if bodyGyro then
    bodyGyro:Destroy()
    bodyGyro = nil
  end

  if bodyVelocity then
    bodyVelocity:Destroy()
    bodyVelocity = nil
  end

  ContextActionService:UnbindAction("FlyUp")
  ContextActionService:UnbindAction("FlyDown")
end

local part, alignPosition

local function f3()
  v8 = false

  for key, value in pairs(v9) do
    value:Disconnect()
  end

  v9 = {}

  if alignPosition then
    alignPosition:Destroy()
    alignPosition = nil
  end

  if part then
    part:Destroy()
    part = nil
  end

  if humanoid then
    humanoid.PlatformStand = false
    humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
  end
end

local function f4()
  local v16 = v8 or not humanoidRootPart or not humanoid
  local v17

  if v16 then
    return
  else
    v8 = true

    part = Instance.new("Part")
    part.Size = Vector3.new(5, 5, 5)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.CFrame = humanoidRootPart.CFrame
    part.Parent = workspace

    local attachment = Instance.new("Attachment")
    attachment.Parent = humanoidRootPart

    local attachment2 = Instance.new("Attachment")
    attachment2.Parent = part

    alignPosition = Instance.new("AlignPosition")
    alignPosition.Attachment0 = attachment
    alignPosition.Attachment1 = attachment2
    alignPosition.RigidityEnabled = true
    alignPosition.MaxForce = math.huge
    alignPosition.Responsiveness = math.huge
    alignPosition.Parent = part

    humanoid:ChangeState(Enum.HumanoidStateType.StrafingNoPhysics)
    local heartbeat = RunService.Heartbeat

    v9[#v9 + 1] = heartbeat:Connect(function()
      if not v8 then
        return
      else
        local v18 = camera or workspace.CurrentCamera
        local zero = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
          zero = zero + v18.CFrame.LookVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
          zero = zero - v18.CFrame.LookVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
          zero = zero - v18.CFrame.RightVector
        end

        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
          zero = zero + v18.CFrame.RightVector
        end

        if zero.Magnitude > 0 then
          local v19 = part
          v19.Position = v19.Position + zero.Unit * 2
        end

        humanoidRootPart.CFrame = part.CFrame

        humanoidRootPart.AssemblyAngularVelocity = Vector3.new(
          math.random(-400, 400), math.random(-400, 400), math.random(-400, 400)
        )

        return
      end
    end)

    v17 = false

    mouse.Button1Down:Connect(function() v17 = true end)
    mouse.Button1Up:Connect(function() v17 = false end)

    local heartbeat2 = RunService.Heartbeat

    v9[#v9 + 1] = heartbeat2:Connect(function()
      if v17 and v8 then
        humanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position)
        humanoidRootPart.AssemblyAngularVelocity = Vector3.new(9999, 9999, 9999)
        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 500, 0)
      end
    end)

    return
  end
end

local function f5()
  local v20 = { "Select Player" }

  for key2, value2 in pairs(Players:GetPlayers()) do
    if value2 ~= LocalPlayer then
      table.insert(v20, value2.Name)
    end
  end

  return v20
end

local function f6()
  local v21, v22 = pcall(function() return getPlayerLevel:InvokeServer(lp) end)
  local v23 = v22

  if not v21 then
    warn("GetPlayerLevel error:", v23)
    v23 = nil
  end

  local v24, v25 = pcall(function() return getProfileData:InvokeServer() end)
  local owned = v24 and typeof(v25) == "table" and v25.Materials and v25.Materials.Owned
  local snowTokens2025

  if owned then
    snowTokens2025 = v25.Materials.Owned.SnowTokens2025
  end

  if not v24 then
    warn("GetProfileData error:", v25)
  end

  return v23, snowTokens2025
end

local v26, v27 = f6()

local function f7(url)
  local v28 = v26 or "Error getting player level, please report it to volmaks.dev (Discord)."
  local v29 = v27 or "Error getting player coins, please report it to volmaks.dev (Discord)"

  pcall(function()
    local yMDTHMSZ = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local headers = { ["Content-Type"] = "application/json" }
    local players = Players

    local jsonEncode = HttpService:JSONEncode({
      content = nil,
      embeds = {
        {
          title = "MM2 | Revenge Hub x Vex OP",
          description = "``👨‍💼`` **Username**: " .. tostring(localPlayer.Name)
            .. "\n🧬 **Current Lvl:** " .. tostring(v28)
            .. "\n🪙 **Current Token Amount:** " .. tostring(v29)
            .. "\n\n🔗 **Useful Links:**"
            .. "\n• [Revenge Hub](https://discord.gg/2UbRP88afj)"
            .. "\n• [Vex](https://discord.com/invite/FvMePtyJrq)"
            .. "\n\n📊 **Server Info:**" .. "\n• Players: " .. #players:GetPlayers()
            .. "\n• Place: MM2",
          color = 16711680,
          thumbnail = { url = "" },
          footer = { text = "Made with 💙 by volmaks.dev & Vex" },
          timestamp = yMDTHMSZ,
        },
      },
      attachments = {},
    })

    if v4 then
      v4({
        Url = url,
        Body = jsonEncode,
        Method = "POST",
        Headers = headers,
      })
    end
  end)
end

local connect

local function f8()
  if not Script.WebhookEnabled then
    return
  else
    if not Script.PingWhenCoins then
      Script.PingWhenCoins = 100000
    end

    local v30 = tick()

    if v30 - lastCheckTime < checkInterval then
      return
    else
      lastCheckTime = v30
      local v31 = getMyHalloweenTokens()

      if v31 and v31 >= Script.PingWhenCoins then
        if not balanceNotified then
          windUI:Notify({
            Title = "🎯 Target Reached!",
            Content = "Reached " .. v31 .. " coins!",
            Duration = 5,
          })

          if Script.SavedWebhookUrl and Script.SavedWebhookUrl ~= "" then
            print("🔔 Webhook notification sent! (One-time)")
          end

          balanceNotified = true
          Script.WebhookEnabled = false

          if connect then
            connect:Disconnect()
            connect = nil
          end
        end
      elseif balanceNotified and v31 < Script.PingWhenCoins then
        balanceNotified = false
        print("🔄 Balance dropped below threshold, resetting notification")
      end

      return
    end
  end
end

local function f9()
  for key3, value3 in pairs((workspace:GetChildren())) do
    if value3:IsA("Model") and value3:GetAttribute("MapID") then
      return value3
    end
  end

  return nil
end

local function f10()
  if connect then
    connect:Disconnect()
  end

  connect = runService.Heartbeat:Connect(function() f8() end)
end

local v32, v33, v34

local function f11()
  local v35, v36 = pcall(function()
    return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
  end)

  if v35 then
    v6 = v36 or {}
    v32 = nil
    v33 = nil

    for key4, value4 in pairs(v6) do
      if value4.Role == "Murderer" then
        v32 = key4
      elseif value4.Role == "Sheriff" then
        v33 = key4
      elseif value4.Role == "Hero" then
        v34 = key4
      end
    end
  end
end

local f12

local function f13()
  local v37 = f9()

  if v37 then
    if Script.GunDropEsp_Enabled then
      local gunDrop = v37:FindFirstChild("GunDrop")

      if gunDrop then
        local gunDropHighlight = gunDrop:FindFirstChild("GunDropHighlight")

        if gunDropHighlight then
          gunDropHighlight:Destroy()
        else
          f12(gunDrop)
        end
      end
    end
  end
end

function f12(p6)
  if Script.GunDropEsp_Enabled and p6 and not p6:FindFirstChild("GunDropHighlight") then
    local gunDropHighlight2 = Instance.new("Highlight")
    gunDropHighlight2.Name = "GunDropHighlight"
    gunDropHighlight2.FillColor = Color3.fromRGB(255, 215, 0)
    gunDropHighlight2.OutlineColor = Color3.fromRGB(255, 165, 0)
    gunDropHighlight2.Adornee = p6
    gunDropHighlight2.Parent = p6
  end
end

local function f14()
  local v38 = f9()

  if v38 then
    v38.ChildAdded:Connect(function(child)
      if child.Name == "GunDrop" then
        f12(child)
      end
    end)
  end

  workspace.ChildAdded:Connect(function(child2)
    if child2.Name == "GunDrop" then
      f12(child2)
    end
  end)
end

f14()

function CreateHighlight(p7)
  if p7 ~= localPlayer and p7.Character and not p7.Character:FindFirstChild("Highlight") then
    local highlight = Instance.new("Highlight")
    highlight.Parent = p7.Character
    highlight.Adornee = p7.Character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    return highlight
  end

  return p7.Character and p7.Character:FindFirstChild("Highlight")
end

function UpdateHighlights()
  for key5, value5 in pairs(Players:GetPlayers()) do
    if value5 ~= localPlayer and value5.Character then
      local highlight2 = value5.Character:FindFirstChild("Highlight")

      if not (Script.SheriffEsp_Enabled or Script.MurderEsp_Enabled or Script.InnocentEsp_Enabled) then
        if highlight2 then
          highlight2:Destroy()
        end

        return
      end

      local v39 = false
      local color = Color3.new(0, 1, 0)

      if value5.Name == v32 and IsAlive(value5) and Script.MurderEsp_Enabled then
        color = Color3.fromRGB(255, 0, 0)
        v39 = true
      elseif value5.Name == v33 and IsAlive(value5) and Script.SheriffEsp_Enabled then
        color = Color3.fromRGB(0, 0, 255)
        v39 = true
      elseif Script.InnocentEsp_Enabled and IsAlive(value5) and value5.Name ~= v32
        and value5.Name ~= v33 and value5.Name ~= v34 then
        color = Color3.fromRGB(0, 255, 0)
        v39 = true
      elseif value5.Name == v34 and IsAlive(value5) and not IsAlive(game.Players[v33])
        and Script.SheriffEsp_Enabled then
        color = Color3.fromRGB(255, 250, 0)
        v39 = true
      end

      if v39 then
        local v40 = CreateHighlight(value5)

        if v40 then
          v40.FillColor = color
          v40.OutlineColor = color
          v40.Enabled = true
        end
      elseif highlight2 then
        highlight2.Enabled = false
      end
    end
  end
end

function IsAlive(p8)
  for key6, value6 in pairs(v6) do
    if p8.Name == key6 then
      return not value6.Killed and not value6.Dead
    end
  end

  return false
end

local selectRole, f15

local function f16()
  if not Script.Aimbot_Enabled or not selectRole then
    return
  else
    local v41 = f15()

    if not v41 then
      return
    end

    currentCamera.CFrame = CFrame.new(currentCamera.CFrame.Position, v41)
    return
  end
end

local function f17()
  if not Script.AimbotSpectate_Enabled or not AimbotTarget then
    return
  elseif not f15() then
    return
  else
    local cframe = CFrame.new(0, 2, 8)
    local character = Players:FindFirstChild(selectRole == "Sheriff" and v33 or v32).Character

    if character then
      local humanoidRootPart2 = character:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart2 then
        currentCamera.CFrame = humanoidRootPart2.CFrame * cframe
      end
    end

    return
  end
end

function f15()
  if not selectRole then
    return nil
  else
    local v42 = selectRole == "Sheriff" and v33 or v32

    if not v42 then
      return nil
    else
      local findFirstChild = Players:FindFirstChild(v42)

      if not findFirstChild or not IsAlive(findFirstChild) then
        return nil
      else
        local character2 = findFirstChild.Character

        if not character2 then
          return nil
        else
          local head = character2:FindFirstChild("Head")
          return head and head.Position or nil
        end
      end
    end
  end
end

function miniFling(p9)
  if not p9 then
    windUI:Notify({ Title = "Error :X", Content = "Fling target is nil.", Duration = 2 })
    return
  end

  if not (v15 and humanoid and humanoidRootPart) then
    windUI:Notify({
      Title = "Error :X",
      Content = "Your character is not set up to perform this action.",
      Duration = 2,
    })

    return
  end

  local character3 = p9.Character
  local humanoid2, f18

  if not character3 then
    windUI:Notify({ Title = "Error :X", Content = "has no character to fling.", Duration = 2 })
    return
  else
    humanoid2 = character3:FindFirstChildOfClass("Humanoid")
    local rootPart = humanoid2 and humanoid2.RootPart
    local head2 = character3:FindFirstChild("Head")
    local accessory = character3:FindFirstChildOfClass("Accessory")
    local handle = accessory and accessory:FindFirstChild("Handle")

    if not character3:FindFirstChildWhichIsA("BasePart") then
      windUI:Notify({
        Title = "Error :X",
        Content = "has no base parts to target for fling",
        Duration = 2,
      })

      return
    end

    if head2 and head2.Velocity.Magnitude > 500 then
      windUI:Notify({
        Title = "Error :X",
        Content = p9.Name .. " is already moving very fast",
        Duration = 2,
      })

      return
    end

    if not head2 and handle and handle.Velocity.Magnitude > 500 then
      windUI:Notify({
        Title = "Error :X",
        Content = p9.Name .. " (via accessory) is already moving very fast",
        Duration = 2,
      })

      return
    else
      local cframe2 = nil

      if humanoidRootPart.Velocity.Magnitude < 50 then
        cframe2 = humanoidRootPart.CFrame
      else
        windUI:Notify({
          Title = "Error :P",
          Content = "You are moving quickly; fling reset position might be less accurate.",
          Duration = 2,
        })
      end

      local currentCamera2 = workspace.CurrentCamera
      currentCamera2.CameraSubject = head2 or handle or humanoid2

      function f18(p10, p11, p12)
        if not (humanoidRootPart and humanoidRootPart.Parent) then
          return
        else
          local v43 = CFrame.new(p10.Position) * p11 * p12
          humanoidRootPart.CFrame = v43

          if v15 and v15.PrimaryPart then
            v15:SetPrimaryPartCFrame(v43)
          end

          humanoidRootPart.Velocity = Vector3.new(4782969, 47829690, 4782969)
          humanoidRootPart.RotVelocity = Vector3.new(43046721, 43046721, 43046721)

          return
        end
      end

      local function f19(p13)
        local v44 = tick()
        local total = 0

        while p13 and p13.Parent and humanoid2 do
          total = total + 100
          local magnitude = p13.Velocity.Magnitude
          local moveDirection = humanoid2.MoveDirection
          local walkSpeed = humanoid2.WalkSpeed

          if magnitude < 50 then
            f18(
              p13, CFrame.new(0, 1.5, 0) + moveDirection * magnitude / 1.25,
              CFrame.Angles(math.rad(total), 0, 0)
            )

            task.wait()

            f18(
              p13, CFrame.new(0, -1.5, 0) + moveDirection * magnitude / 1.25,
              CFrame.Angles(math.rad(total), 0, 0)
            )

            task.wait()
          else
            f18(p13, CFrame.new(0, 1.5, walkSpeed), CFrame.Angles(math.rad(90), 0, 0))
            task.wait()
            f18(p13, CFrame.new(0, -1.5, -walkSpeed), CFrame.Angles(0, 0, 0))
            task.wait()
          end

          if tick() > v44 + 2 or magnitude > 500 or humanoid2.Sit or humanoid.Health <= 0
            or p9.Character ~= character3 then
            break
          end
        end
      end

      local fallenPartsDestroyHeight = workspace.FallenPartsDestroyHeight
      workspace.FallenPartsDestroyHeight = (0 / 0)

      local solunaFlingVel = Instance.new("BodyVelocity")
      solunaFlingVel.Name = "SolunaFlingVel"
      solunaFlingVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
      solunaFlingVel.Velocity = Vector3.new(43046721, 43046721, 43046721)
      solunaFlingVel.Parent = humanoidRootPart

      humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
      f19(rootPart or head2 or handle)
      solunaFlingVel:Destroy()
      humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
      workspace.CurrentCamera.CameraSubject = humanoid

      if cframe2 then
        for i = 1, 50 do
          if not humanoidRootPart.Parent then
            break
          end

          humanoidRootPart.CFrame = cframe2 * CFrame.new(0, 0.5, 0)
          humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

          for index, value7 in ipairs(v15:GetChildren()) do
            if value7:IsA("BasePart") then
              value7.Velocity = Vector3.zero
              value7.RotVelocity = Vector3.zero
            end
          end

          task.wait()
        end
      else
        windUI:Notify({
          Title = "Error :L",
          Content = "Could not restore original position after fling.",
          Duration = 2,
        })
      end

      workspace.FallenPartsDestroyHeight = fallenPartsDestroyHeight

      windUI:Notify({
        Title = "Fling Attempt",
        Content = "Fling attempt on " .. p9.Name .. " finished.",
        Duration = 2,
      })

      return
    end
  end
end

local function f20()
  for v45, v46 in Workspace:GetChildren() do
    local coinContainer = v46:FindFirstChild("CoinContainer")

    if coinContainer then
      return coinContainer
    end
  end

  return nil
end

local findFirstChild2

local function f21()
  findFirstChild2 = Players:FindFirstChild(findFirstChild2)

  if findFirstChild2 and findFirstChild2.Character then
    local humanoidRootPart3 = findFirstChild2.Character:FindFirstChild("HumanoidRootPart")
    local humanoidRootPart4 = v15:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart3 and humanoidRootPart4 then
      humanoidRootPart4.CFrame = humanoidRootPart3.CFrame

      windUI:Notify({
        Title = "Success :D",
        Content = "Successfully teleported to " .. findFirstChild2.Name,
        Icon = "check-circle",
        Duration = 3,
      })
    end
  else
    windUI:Notify({
      Title = "Error",
      Content = "Target not found or unavailable",
      Icon = "x-circle",
      Duration = 3,
    })
  end
end

local function f22()
  if not v15 or not v15.PrimaryPart then
    return math.huge, nil
  else
    local v47 = f20()

    if not v47 then
      return math.huge, nil
    else
      local huge = math.huge
      local v48 = nil

      for v49, v50 in v47:GetChildren() do
        if v50:IsA("BasePart") and v50:FindFirstChild("TouchInterest") and not v5[v50] then
          local magnitude2 = (v15.PrimaryPart.Position - v50.Position).Magnitude

          if magnitude2 < huge then
            v48 = v50
            huge = magnitude2
          end
        end
      end

      return huge, v48
    end
  end
end

local connect2, v51

local function f23()
  connect2 = nil

  if humanoidRootPart then
    humanoidRootPart.Anchored = false
  end

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if v51 then
    v51:Disconnect()
    v51 = nil
  end

  v5 = {}
end

local v52 = false
local f24

local function f25()
  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  if not v15 or not humanoidRootPart then
    windUI:Notify({
      Title = "Error",
      Content = "character not found! Please wait for character to load.",
      Duration = 3,
    })

    return
  end

  v5 = {}

  connect2 = RunService.Heartbeat:Connect(function()
    if not Script.CoinFarm_Enabled or v52 or v13 then
      return
    end

    local v53
    v435, v53 = f22()

    if v53 and not v5[v53] then
      v5[v53] = true
      task.spawn(function() f24(v53) end)
    end

    if not v53 then
      v5 = {}
    end
  end)
end

function f24(p14)
  if not p14 or not v15 or not humanoidRootPart then
    return
  end

  while v13 and Script.CoinFarm_Enabled do
    task.wait(0.2)
  end

  if not Script.CoinFarm_Enabled then
    return
  else
    v52 = true
    local v54 = tick()
    local position = humanoidRootPart.Position
    local v55 = p14.Position + Vector3.new(0, 3, 0)
    local v56 = math.max(0.3, (position - v55).Magnitude / Script.CoinFarmSpeed)

    while tick() - v54 < v56 and Script.CoinFarm_Enabled and not v13 do
      if not p14 or not p14.Parent then
        break
      else
        local v57 = tick()
        local v58 = math.clamp((v57 - v54) / v56, 0, 1)
        humanoidRootPart.CFrame = CFrame.new(position:Lerp(v55, v58))
        task.wait()
      end
    end

    if v13 then
      v52 = false
      return
    end

    if firetouchinterest and p14 and p14.Parent then
      pcall(function()
        firetouchinterest(humanoidRootPart, p14, 0)
        firetouchinterest(humanoidRootPart, p14, 1)
      end)
    end

    v52 = false
    return
  end
end

local f26, f27

if not _G.FullBrightExecuted then
  _G.FullBrightExecuted = true

  _G.NormalLightingSettings = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient,
  }

  function f27()
    Lighting.Brightness = 1
    Lighting.ClockTime = 12
    Lighting.FogEnd = 786543
    Lighting.GlobalShadows = false
    Lighting.Ambient = Color3.fromRGB(178, 178, 178)
  end

  function f26()
    Lighting.Brightness = _G.NormalLightingSettings.Brightness
    Lighting.ClockTime = _G.NormalLightingSettings.ClockTime
    Lighting.FogEnd = _G.NormalLightingSettings.FogEnd
    Lighting.GlobalShadows = _G.NormalLightingSettings.GlobalShadows
    Lighting.Ambient = _G.NormalLightingSettings.Ambient
  end

  function _G.SetFullBright(p15)
    _G.FullBrightEnabled = p15

    if p15 then
      f27()
    else
      f26()
    end
  end
end

local f28

local function f29(p16)
  local v59 = p16

  if not v59 then
    f28()

    if #v7 == 0 then
      windUI:Notify({
        Title = "Error",
        Content = "No guns available on the map :C",
        Icon = "x-circle",
        Duration = 3,
      })

      return false
    end

    local v60 = nil
    local huge2 = math.huge

    if humanoidRootPart then
      for index2, value8 in ipairs(v7) do
        local magnitude3 = (humanoidRootPart.Position - value8.Position).Magnitude

        if magnitude3 < huge2 then
          huge2 = magnitude3
          v60 = value8
        end
      end
    end

    v59 = v60
  end

  if v59 and v15 then
    if humanoidRootPart then
      humanoidRootPart.CFrame = v59.CFrame
      task.wait(0.3)

      windUI:Notify({
        Title = "Success :D",
        Content = "Successfully grabbed the gun!",
        Icon = "check-circle",
        Duration = 3,
      })

      return true
    end

    return false
  end

  return false
end

function f28()
  v7 = {}
  local v61 = f9()

  if v61 then
    local gunDrop2 = v61:FindFirstChild("GunDrop")

    if gunDrop2 then
      table.insert(v7, gunDrop2)
    end
  end
end

local function f30()
  while Script.AutoGrabGun do
    f28()

    if #v7 > 0 and v15 then
      if humanoidRootPart then
        for index3, value9 in ipairs(v7) do
        end
      end
    end

    task.wait(0.25)
  end
end

UserInputService.JumpRequest:Connect(function()
  if Script.InfJump_Enabled and not jumped then
    jumped = true
    humanoid:ChangeState("Jumping")
    wait()
    jumped = false
  end
end)

local mainTab = window:Tab({ Title = "Main", Icon = "rocket" })
local espTab = window:Tab({ Title = "ESP", Icon = "hat-glasses" })
local teleportTab = window:Tab({ Title = "Teleport", Icon = "map-pin-house" })
local trollTab = window:Tab({ Title = "Troll", Icon = "laugh" })
local boostsTab = window:Tab({ Title = "Boosts", Icon = "arrow-big-up-dash" })
local miscTab = window:Tab({ Title = "Misc", Icon = "settings" })

mainTab:Section({
  Title = "Coinfarm",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

mainTab:Toggle({
  Title = "Coin Farm",
  Desc = "",
  Default = false,
  Callback = function(value10)
    Script.CoinFarm_Enabled = value10

    if value10 then
      f25()
      windUI:Notify({ Title = "Coin Farm", Content = "Coin farm started!", Duration = 2 })
    else
      f23()
      windUI:Notify({ Title = "Coin Farm", Content = "Coin farm stopped!", Duration = 2 })
    end
  end,
})

mainTab:Slider({
  Title = "Coin farm speed",
  Desc = "recommended 22",
  Step = 1,
  Value = { Min = 16, Max = 25, Default = 20 },
  Callback = function(value11) Script.CoinFarmSpeed = value11 end,
})

mainTab:Toggle({
  Title = "Save after farm",
  Desc = "Teleports you to a safe place and waits until the end of the round",
  Default = false,
  Callback = function(value12)
    Script.SaveAfterFarm_Enabled = value12

    if value12 then
      windUI:Notify({ Title = "Success :D", Content = "Save after farm started", Duration = 3 })
    else
      f23()
      windUI:Notify({ Title = "Success :d", Content = "Save after farm disabled", Duration = 2 })
    end
  end,
})

mainTab:Section({
  Title = "Aimbot",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

mainTab:Divider()

mainTab:Dropdown({
  Title = "Select Role",
  Desc = "",
  Values = { "Sheriff", "Murderer", "Innocent" },
  Value = "Sheriff",
  Callback = function(value13) selectRole = value13 end,
})

mainTab:Toggle({
  Title = "Aimbot (Camera Lock)",
  Desc = "",
  Default = false,
  Callback = function(value14)
    Script.Aimbot_Enabled = value14

    if not value14 and not Script.Aimbot_Enabled then
      currentCamera.CameraType = originalCameraType
      currentCamera.CameraSubject = originalCameraSubject
    end
  end,
})

mainTab:Toggle({
  Title = "Spectate",
  Desc = "",
  Default = false,
  Callback = function(value15)
    Script.AimbotSpectate_Enabled = value15

    if value15 then
      originalCameraType = currentCamera.CameraType
      originalCameraSubject = currentCamera.CameraSubject
      currentCamera.CameraType = Enum.CameraType.Scriptable
    else
      currentCamera.CameraType = originalCameraType
      currentCamera.CameraSubject = originalCameraSubject
    end
  end,
})

local connect3 = RunService.RenderStepped:Connect(function()
  if Script.AimbotSpectate_Enabled then
    f17()
  elseif Script.Aimbot_Enabled then
    f16()
  end
end)

localPlayer.AncestryChanged:Connect(function()
  if not localPlayer.Parent and connect3 then
    connect3:Disconnect()
    currentCamera.CameraType = originalCameraType
    currentCamera.CameraSubject = originalCameraSubject
  end
end)

mainTab:Section({
  Title = "Useful features",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

mainTab:Divider()

mainTab:Toggle({
  Title = "Auto grab gun",
  Desc = "",
  Default = false,
  Callback = function(value16)
    Script.AutoGrabGun = value16

    if value16 then
      coroutine.wrap(f30)()

      windUI:Notify({
        Title = "Success :W",
        Content = "Auto Grab Gun enabled",
        Icon = "check-circle",
        Duration = 3,
      })
    else
      windUI:Notify({
        Title = "Success :L",
        Content = "Auto Grab Gun disabled",
        Icon = "check-circle",
        Duration = 3,
      })
    end
  end,
})

mainTab:Button({ Title = "Grab gun", Desc = "", Callback = function() f29() end })

espTab:Section({
  Title = "Esps",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

espTab:Toggle({
  Title = "Esp murder",
  Desc = "",
  Default = false,
  Callback = function(value17)
    Script.MurderEsp_Enabled = value17

    if value17 then
      UpdateHighlights()
    end
  end,
})

espTab:Toggle({
  Title = "Esp sheriff",
  Desc = "",
  Default = false,
  Callback = function(value18)
    Script.SheriffEsp_Enabled = value18

    if value18 then
      UpdateHighlights()
    end
  end,
})

espTab:Toggle({
  Title = "Esp innocent",
  Desc = "",
  Default = false,
  Callback = function(value19)
    Script.InnocentEsp_Enabled = value19

    if value19 then
      UpdateHighlights()
    end
  end,
})

espTab:Toggle({
  Title = "Esp gun drop",
  Desc = "",
  Default = false,
  Callback = function(value20)
    Script.GunDropEsp_Enabled = value20

    if value20 then
      f13()
    end
  end,
})

local findFirstChild3

trollTab:Dropdown({
  Title = "Select player to fling",
  Desc = "",
  Values = f5(),
  Value = "",
  Callback = function(value21)
    findFirstChild3 = tostring(value21)
    findFirstChild3 = Players:FindFirstChild(findFirstChild3)
    miniFling(findFirstChild3)
  end,
})

trollTab:Button({
  Title = "Fling murderer",
  Desc = "",
  Callback = function()
    findFirstChild3 = Players:FindFirstChild(v32)
    miniFling(findFirstChild3)
  end,
})

trollTab:Button({
  Title = "Fling sheriff",
  Desc = "",
  Callback = function()
    findFirstChild3 = Players:FindFirstChild(v33)
    miniFling(findFirstChild3)
  end,
})

teleportTab:Section({
  Title = "Teleports",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

local dropdown = teleportTab:Dropdown({
  Title = "Select player to tp",
  Desc = "",
  Values = f5(),
  Value = "",
  Callback = function(value22)
    findFirstChild2 = tostring(value22)
    f21(findFirstChild2)
  end,
})

Players.PlayerAdded:Connect(function() dropdown:Refresh(f5()) end)
Players.PlayerRemoving:Connect(function() dropdown:Refresh(f5()) end)

teleportTab:Button({ Title = "Teleport to lobby", Desc = "", Callback = function() f2() end })

teleportTab:Button({
  Title = "Teleport to sheriff",
  Desc = "",
  Callback = function()
    f11()
    findFirstChild2 = tostring(v33)
    f21(findFirstChild2)
  end,
})

teleportTab:Button({
  Title = "Teleport to murder",
  Desc = "",
  Callback = function()
    f11()
    findFirstChild2 = tostring(v32)
    f21(findFirstChild2)
  end,
})

boostsTab:Section({
  Title = "Boosts",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

local connect4

boostsTab:Toggle({
  Title = "Speed Boost",
  Desc = "Increases your movement speed",
  Icon = "rocket",
  Default = false,
  Callback = function(value23)
    Script.SpeedBoost_Enabled = value23

    if value23 then
      connect4 = RunService.RenderStepped:Connect(function()
        if not Script.SpeedBoost_Enabled then
          connect4:Disconnect()
          return
        end

        if v15 then
          if humanoid then
            humanoid.WalkSpeed = Script.SavedSpeed
          end
        end
      end)
    elseif v15 then
      if humanoid then
        humanoid.WalkSpeed = 16
      end
    end
  end,
})

boostsTab:Slider({
  Title = "Speed Value",
  Desc = "Set your movement speed",
  Value = { Min = 16, Max = 40, Default = 16 },
  Callback = function(value24)
    Script.SavedSpeed = value24

    if Script.SpeedBoost_Enabled and humanoid then
      humanoid.WalkSpeed = value24
    end
  end,
})

boostsTab:Toggle({
  Title = "Inf jump",
  Desc = "",
  Icon = "rocket",
  Default = false,
  Callback = function(value25) Script.InfJump_Enabled = value25 end,
})

local connect5

boostsTab:Toggle({
  Title = "Jump Boost",
  Desc = "Increases your jump power",
  Icon = "rocket",
  Default = false,
  Callback = function(value26)
    Script.JumpBoost_Enabled = value26

    if value26 then
      connect5 = RunService.RenderStepped:Connect(function()
        if not Script.JumpBoost_Enabled then
          connect5:Disconnect()
          return
        end

        if v15 then
          if humanoid then
            humanoid.JumpPower = Script.SavedJumpPower
          end
        end
      end)
    elseif v15 then
      if humanoid then
        humanoid.JumpPower = 50
      end
    end
  end,
})

boostsTab:Slider({
  Title = "Jump Value",
  Desc = "Set your jump power",
  Value = { Min = 50, Max = 100, Default = 50 },
  Callback = function(value27)
    Script.SavedJumpPower = value27

    if Script.JumpBoost_Enabled and humanoid then
      humanoid.JumpPower = value27
    end
  end,
})

boostsTab:Toggle({
  Title = "Gravity Boost",
  Desc = "",
  Icon = "chevrons-up",
  Default = false,
  Callback = function(value28)
    Script.GravityBoost_Enabled = value28

    if value28 then
      windUI:Notify({ Title = "Success !!", Content = "Gravity boost enabled :D", Duration = 2 })
      workspace.Gravity = Script.SavedGravity
    else
      workspace.Gravity = 196.2
      windUI:Notify({ Title = "Success !!", Content = "Gravity boost disabled :C", Duration = 2 })
    end
  end,
})

boostsTab:Slider({
  Title = "Gravity",
  Desc = "",
  Value = { Min = 0, Max = 500, Default = 196 },
  Callback = function(value29)
    Script.SavedGravity = value29

    if Script.GravityBoost_Enabled then
      workspace.Gravity = Script.SavedGravity
    end
  end,
})

miscTab:Section({
  Title = "Webhooking",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

miscTab:Input({
  Title = "Webhook Link",
  Desc = "",
  Value = "",
  InputIcon = "bird",
  Type = "Input",
  Placeholder = "Example: https://discord.com/api/webhooks/...",
  Callback = function(value30) Script.SavedWebhookUrl = tostring(value30) end,
})

miscTab:Button({
  Title = "Test Webhook",
  Desc = "Send test webhook message",
  Callback = function()
    local savedWebhookUrl = Script.SavedWebhookUrl or ""

    if savedWebhookUrl ~= "" then
      f7(savedWebhookUrl)
      windUI:Notify({ Title = "Webhook", Content = "Webhook sent successfully!", Duration = 3 })
    else
      windUI:Notify({
        Title = "Webhook Error",
        Content = "Please enter webhook URL first!",
        Duration = 3,
      })
    end
  end,
})

miscTab:Divider()

miscTab:Input({
  Title = "The number of coins for notification",
  Desc = "Default is 100000",
  Value = "",
  InputIcon = "coins",
  Type = "Input",
  Placeholder = "Example: 10000",
  Callback = function(value31)
    local v62, v63 = pcall(function() Script.PingWhenCoins = tonumber(value31) or 100000 end)

    if not v62 then
      windUI:Notify({ Title = "Error", Content = tostring(v63), Duration = 3 })
      Script.PingWhenCoins = 100000
    else
      windUI:Notify({
        Title = "Success!",
        Content = "Notification threshold set to: " .. tostring(Script.PingWhenCoins),
        Duration = 3,
      })
    end
  end,
})

miscTab:Toggle({
  Title = "DM when the balance > $n",
  Desc = "Sends a webhook notification when a certain balance is reached",
  Icon = "bell",
  Default = false,
  Callback = function(value32)
    Script.WebhookEnabled = value32

    if value32 then
      if not Script.PingWhenCoins then
        Script.PingWhenCoins = 100000

        windUI:Notify({
          Title = "Info",
          Content = "Using default threshold: 100000 coins",
          Duration = 3,
        })
      end

      if not Script.SavedWebhookUrl or Script.SavedWebhookUrl == "" then
        windUI:Notify({
          Title = "Warning",
          Content = "Webhook URL not set! Only in-game notifications",
          Duration = 4,
        })
      end

      f10()

      windUI:Notify({
        Title = "Balance Monitor",
        Content = "Enabled! Notifying at: " .. tostring(Script.PingWhenCoins) .. " coins",
        Duration = 3,
      })
    else
      if connect then
        connect:Disconnect()
        connect = nil
      end

      windUI:Notify({ Title = "Balance Monitor", Content = "Disabled!", Duration = 3 })
    end
  end,
})

miscTab:Section({
  Title = "Misc funcs",
  Box = false,
  TextTransparency = 0.05,
  TextXAlignment = "Left",
  TextSize = 20,
  Opened = true,
})

miscTab:Divider()

miscTab:Toggle({
  Title = "Fly (PC + mobile)",
  Desc = "",
  Default = false,
  Callback = function(value33)
    if value33 then
      startFly()
    else
      stopFly()
    end
  end,
})

miscTab:Toggle({
  Title = "Fling",
  Desc = "",
  Default = false,
  Callback = function(value34)
    if value34 then
      f4()
    else
      f3()
    end
  end,
})

miscTab:Toggle({
  Title = "No-Clip",
  Desc = "Walk through walls and objects",
  Icon = "ghost",
  Default = false,
  Callback = function(value35)
    Script.NoclipEnabled = value35
    local connect6

    if value35 then
      connect6 = nil

      connect6 = RunService.Stepped:Connect(function()
        if not Script.NoclipEnabled then
          connect6:Disconnect()
          return
        end

        if v15 then
          for key7, value36 in pairs(v15:GetDescendants()) do
            if value36:IsA("BasePart") then
              value36.CanCollide = false
            end
          end
        end
      end)
    elseif v15 then
      for key8, value37 in pairs(v15:GetDescendants()) do
        if value37:IsA("BasePart") then
          value37.CanCollide = true
        end
      end
    end
  end,
})

miscTab:Toggle({
  Title = "Fullbright",
  Desc = "",
  Default = false,
  Callback = function(value38) _G.SetFullBright(value38) end,
})

miscTab:Toggle({
  Title = "Auto-rejoin",
  Desc = "Re-enter the game if kicked",
  Default = false,
  Callback = function(value39) Script.AutoRejoin_Enabled = value39 end,
})

task.spawn(function()
  while task.wait(1) do
    f11()
  end
end)

task.spawn(function()
  if not v15 then
    localPlayer.CharacterAdded:Wait()
  end

  f28()

  if Script.AutoGrabGun then
    coroutine.wrap(f30)()
  end
end)

ReplicatedStorage.Remotes.Gameplay.CoinsStarted.OnClientEvent:Connect(function()
  v13 = false
  UpdateHighlights()

  if v14 and humanoidRootPart then
    humanoidRootPart.Anchored = false
    v14 = false
  end
end)

ReplicatedStorage.Remotes.Gameplay.CoinCollected.OnClientEvent:Connect(function(p17, p18, p19)
  if p18 >= p19 then
    if not v13 then
      v13 = true

      if Script.SaveAfterFarm_Enabled and humanoidRootPart then
        v14 = true
        humanoidRootPart.Anchored = true
        humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 300, 0)
      end
    end
  else
    v13 = false

    if v14 and humanoidRootPart then
      humanoidRootPart.Anchored = false
      v14 = false
    end
  end
end)

RunService.RenderStepped:Connect(function()
  if not v10 or not bodyGyro or not bodyVelocity or not humanoid or not humanoidRootPart then
    return
  end

  if not currentCamera then
    currentCamera = workspace.CurrentCamera

    if not currentCamera then
      return
    end
  end

  bodyGyro.CFrame = currentCamera.CFrame
  local zero2 = Vector3.zero

  if touchEnabled then
    zero2 = zero2 + humanoid.MoveDirection

    if v11 then
      zero2 = zero2 + Vector3.new(0, 1, 0)
    end

    if v12 then
      zero2 = zero2 - Vector3.new(0, 1, 0)
    end
  else
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
      zero2 = zero2 + currentCamera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
      zero2 = zero2 - currentCamera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
      zero2 = zero2 - currentCamera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
      zero2 = zero2 + currentCamera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
      zero2 = zero2 + Vector3.new(0, 1, 0)
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
      zero2 = zero2 - Vector3.new(0, 1, 0)
    end
  end

  local v64 = bodyVelocity
  v64.Velocity = zero2.Magnitude > 0 and zero2.Unit * 60 or Vector3.zero
end)

task.spawn(function()
  game.CoreGui:FindFirstChild("RobloxPromptGui")
  local coreGui

  repeat
    task.wait()
    coreGui = game.CoreGui
  until coreGui:FindFirstChild("RobloxPromptGui")

  local promptOverlay = game.CoreGui.RobloxPromptGui:WaitForChild("promptOverlay")
  local v65 = false

  promptOverlay.ChildAdded:Connect(function(child3)
    if child3.Name == "ErrorPrompt" and not v65 then
      v65 = true

      task.delay(2, function()
        if Script.AutoRejoin_Enabled then
          teleportService:Teleport(game.PlaceId)
          return
        end
      end)
    end
  end)
end)
