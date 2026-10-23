--[[
Game: Work at a Pizza Place | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Source: https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/Additional/Orders/Order4.lua
Source SHA-256: 796bb79caa7a4f6007ad692376ed9f93eff233204943fb77ed62976d1bd0d3c3
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a on the WeAreDevs/WAD v1.0.0 protected input (banner present); two runs produced byte-identical output.
The 1244-line Lua body below is the decoder output copied unchanged. Identifiers f1..f7, v1..v67 and p1..p10 are decoder-generated, NOT the author's names, and this provenance header is OUR addition, not a recovered author comment.
Game handlers are inline, not a loader: replicatedStorage.ManagerChannel:FireServer("GiveBonus", v56) and FireServer("EmployeeOfTheDay", v56) after reading counters through v15:SendData("GetCounters", "ManagerChannel", 2, game.Players.LocalPlayer), FireServer("OrderComplete", v67, "I'll take your order and then I'll eat your food") for the steal loop, GetVehicle() scanning workspace.Cars for an empty "Driver" seat with a "HoodSeat", GetCurrentVehicle() via Humanoid.SeatPart, GetManager() = Teams.Manager:GetPlayers()[1], FindFirstCustomer() over workspace.Customers children that have a Head, team switching in f6(p10) through Teams:FindFirstChild(name) (Manager and the Cashier Area / Delivery Area / Boxing Area stations), TP(p4, cframe) teleports, startFly/stopFly, f2() re-applying Script.WalkSpeed/Script.JumpPower, and workspace.Ovens / ManagerChair / Capsule Machines / CheesePizza / PepperoniPizza / SausagePizza handling.
UI toggles recovered verbatim: "Auto bonus", "Auto employee of the day", "Auto claim manager role", "Auto claim fire extinguisher", "Auto steal items" (StealAllBoxes -> Script.AutoStealItems), "Enable Fling", "Enable Gravity", "Enable JumpPower", "Enable Noclip", "Enable WalkSpeed" and a fly-speed slider; keybinds are the fly controls W/A/S/D/Space/LeftShift.
Risks: it claims in-game rewards on your behalf (GiveBonus, EmployeeOfTheDay), completes other players' orders for you, steals boxed orders, and its Fling/Gravity/Noclip toggles move your character and can push other players.
External dependencies, NOT included and NOT audited: Linoria.lua, ThemeManager.lua and SaveManager.lua are fetched and executed at startup from mutable URLs under https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/Additional/; without them the UI never builds.
The code contains no PlaceId check, was never executed in Roblox, and static recovery proves neither equivalence with the unobfuscated original nor server acceptance of these remotes.
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

local httpService = game:GetService("HttpService")
local teleportService = game:GetService("TeleportService")
local coreGui = game:GetService("CoreGui")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local contextActionService = game:GetService("ContextActionService")
local v1 = game:GetService("Workspace")
local starterGui = game:GetService("StarterGui")
local v2 = game:GetService("Teams")
local replicatedStorage = game:GetService("ReplicatedStorage")
local linoria = loadstring(game:HttpGet("https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/Additional/Linoria.lua"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/Additional/ThemeManager.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/volmaksDev/My-Scripts/refs/heads/main/Additional/SaveManager.lua"))()

linoria.ShowToggleFrameInKeybinds = true
linoria.ShowCustomCursor = false
linoria.NotifySide = "Right"

local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
teams = { "On Break", "Supplier", "Delivery", "Pizza Boxer", "Cook", "Cashier" }
local v3 = {}

local window = linoria:CreateWindow({
  Title = "Work at a pizza place | Revenge Hub",
  Center = true,
  AutoShow = true,
  Resizable = true,
  ShowCustomCursor = true,
  UnlockMouseWhileOpen = true,
  NotifySide = "Right",
  TabPadding = 14,
  MenuFadeTime = 0.2,
})

local v4 = { Main = window:AddTab("Main"), Teleport = window:AddTab("Teleport") }
local addLeftTabbox = v4.Main:AddLeftTabbox()
local addRightTabbox = v4.Main:AddRightTabbox()
local addRightTabbox2 = v4.Main:AddRightTabbox()
local server = addLeftTabbox:AddTab("Server")
local troll = addRightTabbox:AddTab("Troll")
local player = addRightTabbox2:AddTab("Player")
local addLeftTabbox2 = v4.Teleport:AddLeftTabbox()
local addRightTabbox3 = v4.Teleport:AddRightTabbox()
local addLeftTabbox3 = v4.Teleport:AddLeftTabbox()
local islands = addLeftTabbox2:AddTab("Islands")
local pizzaPlace = addRightTabbox3:AddTab("Pizza Place")
local other = addLeftTabbox3:AddTab("Other")
local v5 = {}
local v6 = {}
local getMouse = localPlayer:GetMouse()
local gravity = workspace.Gravity
local v7 = false
local v8 = false
local v9 = {}
local v10 = false
local v11 = 60
local v12 = false
local v13 = false
local findFirstChild = game.FindFirstChild

local values = {
  "Spawn Area", "Cashier Area", "Cook Area", "Boxing Area", "Delivery Area", "Supply Area",
  "Unloading Area", "Manager Office", "Parking Lot", "Hideout",
}

local values2 = { "Treasure Island", "Pirate Island", "Jordan's Island" }

local values3 = {
  "Skeleton Cave", "The Dump", "The Dock", "Pet Shop", "Mulberry Hideout", "Treasure Chest",
  "Manager Chair", "Present Table", "Supplier Top",
}

local v14 = {
  PizzaPlace = {
    ["Spawn Area"] = { Location = CFrame.new(49, 3, 196) },
    ["Cashier Area"] = { Location = CFrame.new(48, 4, 80) },
    ["Cook Area"] = { Location = CFrame.new(38, 4, 61) },
    ["Boxing Area"] = { Location = CFrame.new(53, 4, 13) },
    ["Delivery Area"] = { Location = CFrame.new(64, 4, -18) },
    ["Supply Area"] = { Location = CFrame.new(7, 13, -1033) },
    ["Unloading Area"] = { Location = CFrame.new(20, 9, -20) },
    ["Manager Office"] = { Location = CFrame.new(38, 4, 7) },
    ["Kick Manager"] = { Location = CFrame.new(16, 4, 21) },
    ["Parking Lot"] = { Location = CFrame.new(62, 3, -85) },
    Hideout = { Location = CFrame.new(75, 9, 66) },
  },
  Islands = {
    ["Treasure Island"] = { Location = CFrame.new(-1675, -1, -1152) },
    ["Pirate Island"] = { Location = CFrame.new(-1065, 40, 706) },
    ["Jordan's Island"] = { Location = CFrame.new(1525, -1, 1362) },
  },
  Other = {
    ["Skeleton Cave"] = { Location = CFrame.new(-251, -23, -950) },
    ["The Dump"] = { Location = CFrame.new(34, 3, -182) },
    ["Party Island"] = { Location = CFrame.new(81, 3, -276) },
    ["The Dock"] = { Location = CFrame.new(-448, 3, -355) },
    ["Krusty Krab"] = { Location = CFrame.new(-499, -26, -543) },
    ["Pet Shop"] = { Location = CFrame.new(57, 4, -242) },
    ["Mulberry Hideout"] = { Location = CFrame.new(-1755, 2, -1266) },
    ["Treasure Chest"] = { Location = CFrame.new(-1765, 6, -1275) },
    ["Manager Chair"] = { Location = CFrame.new(24, 4, 6) },
    ["Present Table"] = { Location = CFrame.new(32, 4, 25) },
    ["Capsule Machines"] = { Location = CFrame.new(27, 4, 97) },
    ["Pizza Place Top"] = { Location = CFrame.new(46, 21, 47) },
    ["Supplier Top"] = { Location = CFrame.new(8, 37, -1026) },
  },
}

local v15 = require(replicatedStorage.LibraryFolder.Utilities.Utility)

local v16

v16 = hookfunction(v15.SendData, function(...)
  local v17 = { ... }

  if table.find(v17, 192800) then
    return
  end

  return v16(unpack(v17))
end)

for index, value in ipairs(workspace.Ovens:GetChildren()) do
  local detector = value:FindFirstChild("Door"):FindFirstChild("ClickDetector"):FindFirstChild("Detector")
  table.insert(v5, detector)
end

for index2, value2 in ipairs(workspace:GetChildren()) do
  local touchInterest = value2:FindFirstChild("TouchInterest")
  table.insert(v6, touchInterest)
end

for index3, value3 in ipairs(players:GetPlayers()) do
  table.insert(v3, value3.Name)
end

local v18 = (getreg or debug.getregistry)()
local v19

for i = 1, #v18 do
  local v20 = v18[i]

  if type(v20) == "function" then
    local v21, v22 = pcall(getupvalues, v20)

    if v21 and v22 then
      for key, value4 in next, v22, nil do
        if typeof(value4) == "Instance" then
          if value4.Name == "CashOut" or value4.Name == "Claim" then
            pcall(setupvalue, v20, key, {
              MouseButton1Click = { wait = function() end, Wait = function() end },
            })
          elseif value4.Name == "ExploitList" then
            pcall(setupvalue, v20, key, { ExploitList = nil, Row = nil })
          elseif value4.Name == "ExploiterWarning" then
            pcall(setupvalue, v20, key, { ExploiterWarning = nil })
          end
        end
      end
    end

    local v23, v24 = pcall(getfenv, v20)

    if v23 and v24 and tostring(v24.script) == "Music" then
      local v25 = false

      for key2, value5 in next, getconstants(v20), nil do
        if value5 == "location changed" then
          v25 = true
        elseif v25 and value5 == "SendData" then
          pcall(setconstant, v20, key2, "ExplodeString")
          break
        end
      end
    end
  elseif type(v20) == "table" and rawget(v20, "FireServer")
    and rawget(v20, "BindEvents") then
    v19 = v20
  end
end

getgenv().Script = {
  SelectedTeam = "Cashier",
  AutoClaimManager = false,
  AutoClaimFireExtinguisher = false,
  PoltergeistMode = false,
  AutoStealItems = false,
  WalkSpeed_Enabled = false,
  JumpPower_Enabled = false,
  Gravity_Enabled = false,
  WalkSpeed = 16,
  JumpPower = 16,
  Gravity = 16,
  Ruin = false,
  LoopBringAllItems = false,
}

local humanoidRootPart

local function f1(p1, p2)
  if not p1 or not p2 then
    return
  elseif not v14[p1] then
    return
  else
    if not v14[p1][p2] then
      return
    end

    humanoidRootPart.CFrame = v14[p1][p2].Location
    return
  end
end

local humanoid

local function f2()
  if humanoid then
    local v26 = humanoid
    v26.WalkSpeed = Script.WalkSpeedEnabled and Script.WalkSpeed or 16

    local v27 = humanoid
    v27.JumpPower = Script.JumpPowerEnabled and Script.JumpPower or 50
  end

  local v28 = workspace
  v28.Gravity = Script.GravityEnabled and Script.Gravity or gravity
end

function GetVehicle()
  local v29 = {}

  for key3, value6 in pairs(v1.Cars:GetDescendants()) do
    if value6.Name == "Driver" and value6.Occupant == nil
      and value6.Parent:FindFirstChild("HoodSeat") and value6.Parent:FindFirstChild("Owner")
      and value6.Parent:FindFirstChild("Owner").Value == nil then
      table.insert(v29, value6)
    end
  end

  return v29[math.random(1, #v29)]
end

local function f3(p3)
  humanoid = p3:WaitForChild("Humanoid")
  humanoidRootPart = p3:WaitForChild("HumanoidRootPart")
  f2()
end

function GetCurrentVehicle()
  return localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid")
    and localPlayer.Character.Humanoid.SeatPart
    and localPlayer.Character.Humanoid.SeatPart.Parent
end

function TP(p4, cframe)
  p4.CFrame = cframe
end

local connect

local function f4(p5)
  v7 = p5

  if connect then
    connect:Disconnect()
    connect = nil
  end

  if p5 then
    connect = runService.Stepped:Connect(function()
      local character = localPlayer.Character

      if character then
        for index4, value7 in ipairs(character:GetDescendants()) do
          if value7:IsA("BasePart") then
            value7.CanCollide = false
          end
        end
      end
    end)
  else
    local character2 = localPlayer.Character

    if character2 then
      for index5, value8 in ipairs(character2:GetDescendants()) do
        if value8:IsA("BasePart") then
          value8.CanCollide = true
        end
      end
    end
  end
end

function GetManager()
  return v2.Manager:GetPlayers()[1]
end

function FindFirstCustomer()
  local getChildren = workspace.Customers:GetChildren()

  for j = 1, #getChildren do
    local v30 = getChildren[j]

    if findFirstChild(v30, "Head")
      and findFirstChild(v30, "Humanoid")
      and v30.Head.CFrame.Z < 1000
      and findFirstChild(v30.Head, "Dialog")
      and findFirstChild(v30.Head.Dialog, "Correct")
      and (v30.Humanoid.SeatPart and v30.Humanoid.SeatPart.Anchored
        or v30.Humanoid.SeatPart == nil and (v30.Head.Velocity.Z ^ 2) ^ 0.5 < 0.0001) then
      local responseDialog = v30.Head.Dialog.Correct.ResponseDialog or ""
      local v31 = "MountainDew"

      if responseDialog:sub(-8) == "instead." then
        responseDialog = responseDialog:sub(-30)
      end

      if responseDialog:find("pepperoni", 1, true) then
        v31 = "PepperoniPizza"
      elseif responseDialog:find("sausage", 1, true) then
        v31 = "SausagePizza"
      elseif responseDialog:find("cheese", 1, true) then
        v31 = "CheesePizza"
      end

      return v30, v31
    end
  end
end

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

  if isMobile then
    contextActionService:BindAction(
      "FlyUp", function(p6, p7) v12 = p7 == Enum.UserInputState.Begin end, true
    )

    contextActionService:BindAction(
      "FlyDown", function(p8, p9) v13 = p9 == Enum.UserInputState.Begin end, true
    )

    contextActionService:SetTitle("FlyUp", "Fly ↑")
    contextActionService:SetTitle("FlyDown", "Fly ↓")
  end
end

local part, alignPosition

local function f5()
  local v32 = v8 or not humanoidRootPart or not humanoid
  local v33

  if v32 then
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
    local heartbeat = runService.Heartbeat

    v9[#v9 + 1] = heartbeat:Connect(function()
      if not v8 then
        return
      else
        local currentCamera2 = currentCamera or workspace.CurrentCamera
        local zero = Vector3.zero

        if userInputService:IsKeyDown(Enum.KeyCode.W) then
          zero = zero + currentCamera2.CFrame.LookVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.S) then
          zero = zero - currentCamera2.CFrame.LookVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.A) then
          zero = zero - currentCamera2.CFrame.RightVector
        end

        if userInputService:IsKeyDown(Enum.KeyCode.D) then
          zero = zero + currentCamera2.CFrame.RightVector
        end

        if zero.Magnitude > 0 then
          local v34 = part
          v34.Position = v34.Position + zero.Unit * 2
        end

        humanoidRootPart.CFrame = part.CFrame

        humanoidRootPart.AssemblyAngularVelocity = Vector3.new(
          math.random(-400, 400), math.random(-400, 400), math.random(-400, 400)
        )

        return
      end
    end)

    v33 = false

    getMouse.Button1Down:Connect(function() v33 = true end)
    getMouse.Button1Up:Connect(function() v33 = false end)

    local heartbeat2 = runService.Heartbeat

    v9[#v9 + 1] = heartbeat2:Connect(function()
      if v33 and v8 then
        humanoidRootPart.CFrame = CFrame.new(getMouse.Hit.Position)
        humanoidRootPart.AssemblyAngularVelocity = Vector3.new(9999, 9999, 9999)
        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 500, 0)
      end
    end)

    return
  end
end

function stopFly()
  v10 = false
  v12 = false
  v13 = false

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

  contextActionService:UnbindAction("FlyUp")
  contextActionService:UnbindAction("FlyDown")
end

local function f6(p10)
  local v35 = p10 or "Manager"
  local findFirstChild2 = v2:FindFirstChild(v35)

  if not findFirstChild2 then
    warn("Team '" .. v35 .. "' not found!")
    return false
  end

  return #findFirstChild2:GetPlayers() == 0
end

local function f7()
  v8 = false

  for key4, value9 in pairs(v9) do
    value9:Disconnect()
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

if localPlayer.Character then
  f3(localPlayer.Character)
end

localPlayer.CharacterAdded:Connect(function(character3)
  stopFly()
  f7()
  f3(character3)

  if v7 then
    f4(v7)
  end
end)

players.PlayerAdded:Connect(function(player2)
  table.clear(v3)

  for index6, value10 in ipairs(players:GetPlayers()) do
    table.insert(v3, value10.Name)
  end
end)

players.PlayerRemoving:Connect(function(player3)
  table.clear(v3)

  for index7, value11 in ipairs(players:GetPlayers()) do
    table.insert(v3, value11.Name)
  end
end)

server:AddDropdown("JobSelectorDropdown", {
  Values = teams,
  Default = 1,
  Multi = false,
  Text = "Select Any Team to join",
  Tooltip = "choose any",
  DisabledTooltip = "I am disabled!",
  Searchable = false,
  Callback = function(value12) Script.SelectedTeam = tostring(value12) end,
  Disabled = false,
  Visible = true,
})

server:AddButton({
  Text = "Change team",
  Func = function()
    local v36 = { "ChangeJob", tostring(Script.SelectedTeam) }
    replicatedStorage:WaitForChild("PlayerChannel"):FireServer(unpack(v36))
  end,
  DoubleClick = false,
  Tooltip = "select team above",
  DisabledTooltip = "I am disabled!",
  Disabled = false,
})

server:AddToggle("AutoClaimManagerToggle", {
  Text = "Auto claim manager role",
  Tooltip = "",
  Default = false,
  Disabled = false,
  Visible = true,
  Risky = false,
  Callback = function(value13) Script.AutoClaimManager = value13 end,
})

server:AddToggle("AutoClaimFireExtinguisherToggle", {
  Text = "Auto claim fire extinguisher",
  Tooltip = "",
  Default = false,
  Disabled = false,
  Visible = true,
  Risky = false,
  Callback = function(value14) Script.AutoClaimFireExtinguisher = value14 end,
})

server:AddDivider()

server:AddToggle("FlyToggle", {
  Text = "Fly (PC + Mobile)",
  Default = false,
  Callback = function(value15)
    if value15 then
      startFly()
    else
      stopFly()
    end
  end,
})

server:AddSlider("FlySpeedSlider", {
  Text = "Fly Speed",
  Default = 60,
  Min = 10,
  Max = 300,
  Rounding = 1,
  Callback = function(value16) v11 = value16 end,
})

server:AddButton({ Text = "Reset Fly Speed", Func = function() v11 = 60 end })

server:AddToggle("Fling_Enable", {
  Text = "Enable Fling",
  Default = false,
  Callback = function(value17)
    if value17 then
      f5()
    else
      f7()
    end
  end,
})

server:AddToggle("Noclip_Enable", {
  Text = "Enable Noclip",
  Default = false,
  Callback = function(value18) f4(value18) end,
})

server:AddDivider()

server:AddButton({
  Text = "Unlock all emotes",
  Func = function()
    local playerGui = game.Players.LocalPlayer.PlayerGui
    local v37 = game
    local v38 = require(playerGui:WaitForChild("GuiManager"))
    local v39 = game
    local v40 = game

    local registerListView = v38:RegisterListView(
      v37:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions,
      v39:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions.ScrollingFrame.List
    )

    local v41 = game

    registerListView:UpdateData(
      AllEmotes, v40:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions.Template,
      getsenv(v41:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions.Emotions).ListDisplayFunction
    )
  end,
})

server:AddButton({
  Text = "Remove Manager",
  Func = function()
    Player_S = GetManager()
    local v42 = not Player_S or players.LocalPlayer.Team.Name == "Manager"
    local v43, v44

    if v42 then
      return
    elseif Player_S.Character.Humanoid.Sit then
      linoria:Notify("Failed to Remove " .. Player_S.DisplayName .. " @" .. Player_S.Name
        .. " is currently sitting.")

      return
    else
      v44 = GetVehicle()
      v260 = players.LocalPlayer.Character.HumanoidRootPart.Position

      if v44.Occupant ~= nil then
        v44 = GetVehicle()
      end

      local v45 = game

      if not (v44.Occupant == v45:GetService("Players").LocalPlayer.Character.Humanoid) then
        v263 = players.LocalPlayer.Character.HumanoidRootPart
      end

      repeat
        wait()
        v44.ClickDetector.Detector:FireServer()
        local v46 = game
        local v47 = v44.Occupant == v46:GetService("Players").LocalPlayer.Character.Humanoid

        v43 = v47
        v43 = v47 or players.LocalPlayer.Character.HumanoidRootPart == nil
      until v43

      wait(0.15)

      task.spawn(function()
        if not (v44.Parent:FindFirstChild("HoodSeat").Occupant == Player_S.Character.Humanoid) then
          v273 = players.LocalPlayer.Character.HumanoidRootPart
        end

        local v48

        repeat
          wait()
          local v49 = GetCurrentVehicle()
          local character4 = Player_S.Character

          TP(v49.PrimaryPart, CFrame.new(character4:FindFirstChild("HumanoidRootPart").Position
            + Vector3.new(0, -2, 5)))

          local v50 = v44.Parent:FindFirstChild("HoodSeat").Occupant
            == Player_S.Character.Humanoid

          v48 = v50
          v48 = v50 or players.LocalPlayer.Character.HumanoidRootPart == nil
        until v48

        if GetManager() then
          if not not GetCurrentVehicle() then
            v281 = not players.LocalPlayer.Character.HumanoidRootPart
          end
        end

        local v51

        repeat
          wait()
          local v52 = game

          TP(GetCurrentVehicle().PrimaryPart, CFrame.new(v52:GetService("Workspace")["Remove Manager"].Head.Position
            + Vector3.new(0, -4, 5)))

          local v53 = not GetManager()

          v51 = v53

          v51 = v53 or not GetCurrentVehicle()
            or not players.LocalPlayer.Character.HumanoidRootPart
        until v51

        wait(0.35)

        local v54 = game
        v54:GetService("Players").LocalPlayer.Character.Humanoid.Jump = true

        wait(0.5)
        local v55

        repeat
          wait()
          workspace.ManagerChair:FindFirstChildOfClass("Seat"):Sit(players.LocalPlayer.Character.Humanoid)
          v55 = game
        until v55:GetService("Players").LocalPlayer.Character.Humanoid.Sit

        linoria:Notify("Removed " .. Player_S.DisplayName .. " @" .. Player_S.Name
          .. " from being manager.")
      end)

      return
    end
  end,
})

server:AddDivider()

local v56

server:AddDropdown("PlayerSelectorDropdown", {
  Values = v3,
  Default = 1,
  Multi = false,
  Text = "Select any player",
  Tooltip = "choose any",
  DisabledTooltip = "I am disabled!",
  Searchable = false,
  Callback = function(value19) v56 = value19 end,
  Disabled = false,
  Visible = true,
})

server:AddToggle("AutoBonusToggle", {
  Text = "Auto bonus",
  Default = false,
  Callback = function(value20)
    AutoPaycheck = value20

    while AutoPaycheck do
      task.wait()
      local v57 = AutoPaycheck == true
      local v58 = v57

      if v57 then
        local v59 = v56 ~= nil
        local v60 = v59

        if v59 then
          local manager = v2.Manager
          local v61 = game

          v60 = manager:GetPlayers()[1] == v61:GetService("Players").LocalPlayer
            and v15:SendData("GetCounters", "ManagerChannel", 2, game.Players.LocalPlayer).GiveBonus
              <= 0
        end

        v58 = v60
      end

      if v58 then
        replicatedStorage.ManagerChannel:FireServer("GiveBonus", v56)
        task.wait(600)
      end
    end
  end,
})

server:AddToggle("AutoEmployeeToggle", {
  Text = "Auto employee of the day",
  Default = false,
  Callback = function(value21)
    AutoPaycheck = value21

    while AutoPaycheck do
      task.wait()
      local v62 = AutoPaycheck == true
      local v63 = v62

      if v62 then
        local v64 = v56
        local v65 = v64

        if v64 then
          local manager2 = v2.Manager
          local v66 = game

          v65 = manager2:GetPlayers()[1] == v66:GetService("Players").LocalPlayer
            and v15:SendData("GetCounters", "ManagerChannel", 2, game.Players.LocalPlayer).EmployeeOfTheDay
              <= 0
        end

        v63 = v65
      end

      if v63 then
        replicatedStorage.ManagerChannel:FireServer("EmployeeOfTheDay", v56)
        task.wait(900)
      end
    end
  end,
})

troll:AddToggle("PoltergeistModeToggle", {
  Text = "Poltergeist Mode",
  Tooltip = "",
  Default = false,
  Disabled = false,
  Visible = true,
  Risky = false,
  Callback = function(value22) Script.PoltergeistMode = value22 end,
})

troll:AddToggle("StealAllBoxes", {
  Text = "Auto steal items",
  Tooltip = "",
  Default = false,
  Disabled = false,
  Visible = true,
  Risky = false,
  Callback = function(value23) Script.AutoStealItems = value23 end,
})

troll:AddToggle("BreakGameToggle", {
  Text = "Break game",
  Default = false,
  Risky = true,
  Callback = function(value24)
    Script.Ruin = value24

    if Script.Ruin then
      while Script.Ruin do
        task.wait()

        for k = 1, 3 do
          local v67, v68 = FindFirstCustomer()

          if v67 and v68 then
            v19:FireServer(
              "OrderComplete", v67, "I'll take your order and then I'll eat your food",
              workspace["Register" .. k]
            )

            task.wait(1.3)
          end
        end
      end
    end
  end,
})

troll:AddToggle("UnanchorTrees", {
  Text = "Unanchor trees",
  Default = false,
  Risky = false,
  Callback = function(value25)
    while value25 == true do
      task.wait()

      for key5, value26 in pairs(game.Workspace.Trees:GetChildren()) do
        if value26.Name == "Tree" or value26.Name == "DeadTree" and value25 == true then
          workspace.Main.UprootTree:FireServer(value26)
        end
      end

      for key6, value27 in pairs(v1.Houses:GetChildren()) do
        if value27:IsA("Model") and value27:FindFirstChild("Mailbox") then
          workspace.Main.KnockMailbox:FireServer(value27)
        end
      end
    end
  end,
})

troll:AddToggle("LoopBringAllItemsToggle", {
  Text = "Loop bring all items",
  Tooltip = "Unanchor trees plz",
  Default = false,
  Disabled = false,
  Visible = true,
  Risky = false,
  Callback = function(value28)
    Script.LoopBringAllItems = value28

    while Script.LoopBringAllItems == true do
      local v69 = {}

      for key7, value29 in pairs(workspace:GetDescendants()) do
        local v70 = Script.LoopBringAllItems == true
        local v71 = v70

        if v70 then
          local head = players.LocalPlayer.Character:FindFirstChild("Head")
          local v72 = head

          if head then
            local basePart = value29:IsA("BasePart")
            local v73 = basePart

            if basePart then
              local v74 = value29.Anchored == false

              local v75 = v74 and not value29:IsDescendantOf(players.LocalPlayer.Character)
                and value29.Name == "Torso" == false and value29.Name == "Head" == false
                and value29.Name == "Right Arm" == false and value29.Name == "Left Arm" == false
                and value29.Name == "Right Leg" == false and value29.Name == "Left Leg" == false
                and value29.Name == "HumanoidRootPart" == false

              v73 = v75
            end

            v72 = v73
          end

          v71 = v72
        end

        if v71 then
          for key8, value30 in pairs(value29:GetChildren()) do
            if value30:IsA("BodyPosition") or value30:IsA("BodyGyro") then
              value30:Destroy()
            end
          end

          local bodyPosition = Instance.new("BodyPosition")
          bodyPosition.Parent = value29
          bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

          table.insert(v69, bodyPosition)
        end
      end

      for key9, value31 in pairs(v69) do
        value31.Position = players.LocalPlayer.Character.Head.Position
      end

      task.wait(2.5)
    end
  end,
})

player:AddToggle("WS_Enable", {
  Text = "Enable WalkSpeed",
  Default = false,
  Callback = function(value32)
    Script.WalkSpeedEnabled = value32
    f2()
  end,
})

player:AddSlider("WS_Slider", {
  Text = "WalkSpeed",
  Default = 16,
  Min = 0,
  Max = 200,
  Rounding = 1,
  Callback = function(value33)
    Script.WalkSpeed = value33
    f2()
  end,
})

player:AddButton({
  Text = "Reset WalkSpeed",
  Func = function()
    Script.WalkSpeed = 16
    Script.WalkSpeedEnabled = false
    f2()
  end,
})

player:AddDivider()

player:AddToggle("JP_Enable", {
  Text = "Enable JumpPower",
  Default = false,
  Callback = function(value34)
    Script.JumpPowerEnabled = value34
    f2()
  end,
})

player:AddSlider("JP_Slider", {
  Text = "JumpPower",
  Default = 50,
  Min = 0,
  Max = 300,
  Rounding = 1,
  Callback = function(value35)
    Script.JumpPower = value35
    f2()
  end,
})

player:AddButton({
  Text = "Reset JumpPower",
  Func = function()
    Script.JumpPower = 50
    Script.JumpPowerEnabled = false
    f2()
  end,
})

player:AddDivider()

player:AddToggle("GR_Enable", {
  Text = "Enable Gravity",
  Default = false,
  Callback = function(value36)
    Script.GravityEnabled = value36
    f2()
  end,
})

player:AddSlider("GR_Slider", {
  Text = "Gravity",
  Default = 196,
  Min = 0,
  Max = 500,
  Rounding = 1,
  Callback = function(value37)
    Script.Gravity = value37
    f2()
  end,
})

player:AddButton({
  Text = "Reset Gravity",
  Func = function()
    Script.Gravity = gravity
    Script.GravityEnabled = false
    f2()
  end,
})

islands:AddDropdown("IslandsDropdown", {
  Values = values,
  Default = 1,
  Multi = false,
  Text = "Select any island to tp",
  Tooltip = "choose any",
  DisabledTooltip = "I am disabled!",
  Searchable = false,
  Callback = function(value38) f1("PizzaPlace", value38) end,
  Disabled = false,
  Visible = true,
})

pizzaPlace:AddDropdown("PizzaPlaceDropdown", {
  Values = values2,
  Default = 1,
  Multi = false,
  Text = "Select any place to tp",
  Tooltip = "choose any",
  DisabledTooltip = "I am disabled!",
  Searchable = false,
  Callback = function(value39) f1("Islands", value39) end,
  Disabled = false,
  Visible = true,
})

other:AddDropdown("OtherPlaceDropdown", {
  Values = values3,
  Default = 1,
  Multi = false,
  Text = "Select any place to tp",
  Tooltip = "choose any",
  DisabledTooltip = "I am disabled!",
  Searchable = false,
  Callback = function(value40) f1("Other", value40) end,
  Disabled = false,
  Visible = true,
})

runService.RenderStepped:Connect(function()
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

  if isMobile then
    zero2 = zero2 + humanoid.MoveDirection

    if v12 then
      zero2 = zero2 + Vector3.new(0, 1, 0)
    end

    if v13 then
      zero2 = zero2 - Vector3.new(0, 1, 0)
    end
  else
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

    if userInputService:IsKeyDown(Enum.KeyCode.Space) then
      zero2 = zero2 + Vector3.new(0, 1, 0)
    end

    if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
      zero2 = zero2 - Vector3.new(0, 1, 0)
    end
  end

  local v76 = bodyVelocity
  v76.Velocity = zero2.Magnitude > 0 and zero2.Unit * v11 or Vector3.zero
end)

task.spawn(function()
  while true do
    local cframe2 = humanoidRootPart.CFrame

    if Script.AutoClaimManager then
      if f6("Manager") then
        humanoidRootPart.CFrame = workspace.ManagerChair:FindFirstChildWhichIsA("Seat").CFrame
        task.wait(1)
        humanoidRootPart.CFrame = cframe2
      end
    end

    if Script.AutoClaimFireExtinguisher then
      local extinguisher = workspace:FindFirstChild("Extinguisher")

      if extinguisher and extinguisher:FindFirstChild("Extinguisher")
        and extinguisher.Extinguisher:FindFirstChild("ClickDetector") then
        local clickDetector = extinguisher.Extinguisher.ClickDetector

        if clickDetector:FindFirstChild("Detector") then
          pcall(function() clickDetector.Detector:FireServer() end)
        end
      end
    end

    if Script.PoltergeistMode then
      if #v5 > 0 then
        wait(0.2)
      end

      for key10, value41 in pairs(v6) do
        if value41:IsA("TouchInterest") then
          firetouchinterest(value41)
        end
      end
    end

    if Script.AutoStealItems then
      local cframe3 = humanoidRootPart.CFrame

      for index8, value42 in ipairs(workspace:GetChildren()) do
        if value42:IsA("Tool") then
          local handle = value42:FindFirstChild("Handle")
          value42:FindFirstChildWhichIsA("ClickDetector")

          if handle then
            humanoidRootPart.CFrame = handle.CFrame + Vector3.new(0, 3, 0)
            task.wait(0.01)
            humanoidRootPart.CFrame = cframe3
          end
        end
      end
    end

    task.wait(0.1)
  end
end)
