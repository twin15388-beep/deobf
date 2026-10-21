--[[
Game: Fight Your Zombie | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Original: https://github.com/MomoHub007/Fight-Your-Zombie/blob/3af1c5938ef0b1c04505d1353d2cf4da1740f5f8/README.md
Source SHA-256: 5c7173796d6b8409f8b55aafb03c21e576484d3f24e602bd4447543fa78949f8
Recovery tool: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
The 522-line Lua body is the static decoder output, copied unchanged. This provenance comment is OUR addition, not a recovered author's comment. The upstream README.md contains the WAD v1.0.0 protected game script. This file includes the inline game handlers, not just a UI/loader; its external X2ZU UI framework still loads from a mutable GitHub branch at startup. No assertion of game/server functionality or byte-for-byte equivalence to the unobfuscated original is made.
This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0. The full upstream license is included unchanged in ../reports/licenses/MomoHub-MPL-2.0.txt (SHA-256: 3f3d9e0024b1921b067d6f7f88deb4a60cbe7a78e76c64e3f1d7fc3b779b9d04). Source of this modified form is the Lua in this repository.
]]

local httpService = game:GetService("HttpService")
local players = game:GetService("Players")
local virtualUser = game:GetService("VirtualUser")
local userInputService = game:GetService("UserInputService")
local virtualInputManager = game:GetService("VirtualInputManager")
local coreGui = game:GetService("CoreGui")
local replicatedStorage = game:GetService("ReplicatedStorage")

local v1 = {
  AutoLuckyBlock = false,
  AutoFarmWalking = false,
  FarmZombiePlot = false,
  KillAura = false,
  AutoCollectCoin = false,
  SelectedAxe = "No Axe Found",
  WalkSpeed = 16,
  JumpPower = 50,
  AntiAFK = false,
  AutoSave = true,
  AutoLoad = true,
}

local v2 = {}

if isfolder and not isfolder("MoMoHub_Data") then
  makefolder("MoMoHub_Data")
end

local function f1()
  if writefile then
    local v3, v4 = pcall(function() return httpService:JSONEncode(v2) end)

    if v3 then
      writefile("MoMoHub_Data/Settings.json", v4)
    end
  end
end

local function f2()
  if isfile and isfile("MoMoHub_Data/Settings.json") then
    local v5, v6 = pcall(function()
      return httpService:JSONDecode(readfile("MoMoHub_Data/Settings.json"))
    end)

    if v5 and type(v6) == "table" then
      for key, value in pairs(v1) do
        if v6[key] == nil then
          v6[key] = value
        end
      end

      return v6
    end

    return v1
  end

  return v1
end

local v7 = f2()

if v7.AutoLoad then
  v2 = v7
else
  v2 = v1
end

local function f3()
  if v2.AutoSave then
    f1()
  end
end

local localPlayer

local function f4()
  local v8 = localPlayer
  local v9 = {}
  local v10 = {}
  local axes = v8:FindFirstChild("Data") and localPlayer.Data:FindFirstChild("Axes")

  if axes then
    for key2, value2 in pairs(axes:GetChildren()) do
      local axeName = value2:FindFirstChild("AxeName")

      if axeName then
        local value3 = axeName.Value

        if not v10[value3] then
          table.insert(v9, value3 .. " (" .. value2.Name .. ")")
          v10[value3] = true
        end
      end
    end
  end

  return #v9 > 0 and v9 or { "No Axe Found" }
end

localPlayer = players.LocalPlayer

local function f5()
  local debris = workspace:FindFirstChild("Debris")
  local normal = debris and debris:FindFirstChild("Normal")
  local main = normal and normal:FindFirstChild("Main")

  if main and main:IsA("BasePart") then
    return main, (main:FindFirstChildWhichIsA("ProximityPrompt", true))
  end

  return nil, nil
end

local v11 = false
local v12 = false
local v13 = false

local function f6()
  local huge = math.huge

  local position = localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")
    and localPlayer.Character.HumanoidRootPart.Position

  if not position then
    return nil
  end

  local v14

  for key3, value4 in pairs(workspace.Plots:GetChildren()) do
    local v15 = value4

    pcall(function()
      local plotContents = v15:FindFirstChild("PlotContents")
      local treeSpawn = plotContents and plotContents:FindFirstChild("TreeSpawn")

      if treeSpawn then
        local position2 = treeSpawn:IsA("BasePart") and treeSpawn.Position
          or treeSpawn:IsA("Model") and treeSpawn:GetModelCFrame().Position

        if position2 then
          local magnitude = (position - position2).Magnitude

          if magnitude < huge then
            huge = magnitude
            v14 = position2
          end
        end
      end
    end)
  end

  return v14
end

local function f7()
  local huge2 = math.huge
  local character = localPlayer.Character
  local v16 = not character
  local v17

  if v16 or not character:FindFirstChild("HumanoidRootPart") then
    return nil
  else
    local walkingZombies = workspace:FindFirstChild("WalkingZombies")

    if walkingZombies then
      for key4, value5 in pairs(walkingZombies:GetChildren()) do
        local rootPart = value5:FindFirstChild("RootPart")

        if rootPart then
          local magnitude2 = (character.HumanoidRootPart.Position - rootPart.Position).Magnitude

          if magnitude2 < huge2 then
            v17 = value5
            huge2 = magnitude2
          end
        end
      end
    end

    return v17
  end
end

local window = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))():Window({
  Title = "MoMoHub",
  Desc = "Welcome to the best script hub",
  Icon = "badge-check",
  Theme = "Amethyst",
  Color = Color3.fromRGB(170, 0, 255),
  Config = { Keybind = Enum.KeyCode.LeftControl, Size = UDim2.new(0, 520, 0, 480) },
  CloseUIButton = { Enabled = false, Text = "" },
})

local v18 = gethui and gethui() or coreGui or localPlayer:WaitForChild("PlayerGui")

local moMoHubToggleUI = Instance.new("ScreenGui")
moMoHubToggleUI.Name = "MoMoHubToggleUI"
moMoHubToggleUI.ResetOnSpawn = false
moMoHubToggleUI.Parent = v18

local moMoHubToggle = Instance.new("ImageButton")
moMoHubToggle.Name = "MoMoHubToggle"
moMoHubToggle.Parent = moMoHubToggleUI
moMoHubToggle.Position = UDim2.new(0, 300, 0.5, -200)
moMoHubToggle.Size = UDim2.new(0, 50, 0, 50)
moMoHubToggle.BackgroundTransparency = 1
moMoHubToggle.Image = "rbxthumb://type=Asset&id=82100122245666&w=150&h=150"

local v19, position3, position4

moMoHubToggle.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
    v19 = true
    position3 = input.Position
    position4 = moMoHubToggle.Position
  end
end)

moMoHubToggle.InputEnded:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseButton1
    or input2.UserInputType == Enum.UserInputType.Touch then
    v19 = false

    if (input2.Position - position3).Magnitude < 5 then
      pcall(function()
        virtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
        task.wait(0.05)
        virtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
      end)
    end
  end
end)

userInputService.InputChanged:Connect(function(input3)
  if v19
    and (input3.UserInputType == Enum.UserInputType.MouseMovement
      or input3.UserInputType == Enum.UserInputType.Touch) then
    local v20 = input3.Position - position3

    moMoHubToggle.Position = UDim2.new(
      position4.X.Scale, position4.X.Offset + v20.X, position4.Y.Scale,
      position4.Y.Offset + v20.Y
    )
  end
end)

local dashboardTab = window:Tab({ Title = "Dashboard", Icon = "layout" })
dashboardTab:Section({ Title = "Priority Farming" })

dashboardTab:Toggle({
  Title = "[P1] Auto Lucky Block",
  Desc = "High priority teleport to Lucky Blocks",
  Value = v2.AutoLuckyBlock,
  Callback = function(value6)
    v2.AutoLuckyBlock = value6
    f3()
  end,
})

dashboardTab:Toggle({
  Title = "[P2] Auto Walking Zombie",
  Desc = "Teleport behind walking zombies",
  Value = v2.AutoFarmWalking,
  Callback = function(value7)
    v2.AutoFarmWalking = value7
    f3()
  end,
})

local position5

dashboardTab:Toggle({
  Title = "[P3] Auto Plot Farm",
  Desc = "Teleport to tree spawns in plots",
  Value = v2.FarmZombiePlot,
  Callback = function(value8)
    if value8 and position5 == nil then
      v11 = true
      window:Notify({ Title = "Setup", Desc = "Recording spawn... Please wait.", Time = 5 })

      if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
        localPlayer.Character.Humanoid.Health = 0
      end

      localPlayer.CharacterAdded:Wait()
      task.wait(1.5)
      local waitForChild = localPlayer.Character:WaitForChild("HumanoidRootPart", 10)

      if waitForChild then
        position5 = waitForChild.Position
      end

      v11 = false
      window:Notify({ Title = "Success", Desc = "Position Saved!", Time = 3 })
    end

    v2.FarmZombiePlot = value8
    f3()
  end,
})

local combatTab = window:Tab({ Title = "Combat", Icon = "swords" })
combatTab:Section({ Title = "Weapon & Aura" })

local selectWeaponDropdown = combatTab:Dropdown({
  Title = "Select Weapon",
  Desc = "Choose which axe to equip",
  List = f4(),
  Value = v2.SelectedAxe,
  Callback = function(value9)
    v2.SelectedAxe = value9
    f3()
  end,
})

combatTab:Button({
  Title = "Refresh Weapons",
  Desc = "Update the weapon list",
  Callback = function()
    selectWeaponDropdown:Refresh(f4())
    window:Notify({ Title = "System", Desc = "Inventory Refreshed", Time = 2 })
  end,
})

combatTab:Toggle({
  Title = "Kill Aura",
  Desc = "Auto swing and equip weapon",
  Value = v2.KillAura,
  Callback = function(value10)
    v2.KillAura = value10
    f3()
  end,
})

combatTab:Section({ Title = "Utilities" })

combatTab:Toggle({
  Title = "Auto Collect Coin",
  Desc = "Increase coin hitbox size",
  Value = v2.AutoCollectCoin,
  Callback = function(value11)
    v2.AutoCollectCoin = value11
    f3()
  end,
})

local settingsTab = window:Tab({ Title = "Settings", Icon = "wrench" })
settingsTab:Section({ Title = "Local Player" })

settingsTab:Slider({
  Title = "WalkSpeed",
  Min = 16,
  Max = 250,
  Rounding = 0,
  Value = v2.WalkSpeed,
  Callback = function(value12)
    v2.WalkSpeed = value12

    if localPlayer.Character:FindFirstChild("Humanoid") then
      localPlayer.Character.Humanoid.WalkSpeed = value12
    end

    f3()
  end,
})

settingsTab:Toggle({
  Title = "Anti-AFK",
  Desc = "Prevent idle disconnect",
  Value = v2.AntiAFK,
  Callback = function(value13)
    v2.AntiAFK = value13
    f3()

    if value13 then
      _G.AntiAfk = localPlayer.Idled:Connect(function()
        virtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        virtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
      end)
    elseif _G.AntiAfk then
      _G.AntiAfk:Disconnect()
    end
  end,
})

settingsTab:Section({ Title = "Config Management" })

settingsTab:Toggle({
  Title = "Auto Save",
  Value = v2.AutoSave,
  Callback = function(value14)
    v2.AutoSave = value14
    f1()
  end,
})

settingsTab:Toggle({
  Title = "Auto Load",
  Value = v2.AutoLoad,
  Callback = function(value15)
    v2.AutoLoad = value15
    f1()
  end,
})

settingsTab:Button({
  Title = "Save Config Now",
  Callback = function()
    f1()
    window:Notify({ Title = "Config", Desc = "Saved!", Time = 2 })
  end,
})

settingsTab:Button({
  Title = "Copy Discord Link",
  Desc = "Join our community",
  Callback = function()
    if setclipboard then
      setclipboard("https://discord.gg/k2wdyy8QMN")
      window:Notify({ Title = "Discord", Desc = "Link Copied!", Time = 3 })
    end
  end,
})

task.spawn(function()
  while task.wait(0.1) do
    if not v11 and v2.AutoLuckyBlock then
      local v21, v22 = f5()

      if v21 and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        v13 = true
        localPlayer.Character.HumanoidRootPart.CFrame = v21.CFrame * CFrame.new(0, 0, 3)

        if v22 then
          fireproximityprompt(v22)
        end
      else
        if v13 and position5 then
          localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position5
            + Vector3.new(0, 3, 0))

          task.wait(0.3)
        end

        v13 = false
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.01) do
    if not v11 and v2.AutoFarmWalking and not v13 then
      local v23 = f7()

      if v23 and v23:FindFirstChild("RootPart")
        and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        v12 = true

        localPlayer.Character.HumanoidRootPart.CFrame = v23.RootPart.CFrame
          * CFrame.new(0, 0, 3)
      else
        if v12 and position5 then
          localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(position5
            + Vector3.new(0, 3, 0))

          task.wait(0.3)
        end

        v12 = false
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if not v11 and v2.FarmZombiePlot then
      if not v13 and not v12 then
        local v24 = f6()

        if v24 and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
          localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v24 + Vector3.new(0, 3, 0))
        end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.1) do
    if not v11 and v2.KillAura then
      pcall(function()
        local d = v2.SelectedAxe:match("%((%d+)%)")

        if d then
          replicatedStorage.Remotes.EquipAxe:FireServer(d)
          replicatedStorage.Remotes.AxeSwing:FireServer()
        end
      end)
    end

    if v2.AutoCollectCoin then
      pcall(function()
        for key5, value16 in pairs(workspace.Orbs:GetChildren()) do
          if value16.Name == "Coin" and value16:FindFirstChild("HitBox") then
            value16.HitBox.Size = Vector3.new(50, 50, 50)
            value16.HitBox.CanCollide = false
          end
        end
      end)
    end
  end
end)

window:Notify({ Title = "MoMoHub", Desc = "Successfully Loaded!", Time = 4 })
