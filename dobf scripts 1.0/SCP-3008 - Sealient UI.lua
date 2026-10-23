--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/Sealient%27s%203008%20UI.lua
Source SHA-256: 2add113c086034788b03f4d67e494d91b60b5398977b0fb74818ef0a537fcb1f
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2025 Sealient

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
local starterGui = game:GetService("StarterGui")
local lighting = game:GetService("Lighting")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local v1 = game:GetService("Workspace")
local fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local interfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local localPlayer = players.LocalPlayer

if localPlayer.Character then
  localPlayer.Character:FindFirstChildOfClass("Humanoid")
end

local window = fluent:CreateWindow({
  Title = "Sealient's 3008 UI",
  SubTitle = "Made By Sealient.",
  TabWidth = 160,
  Size = UDim2.fromOffset(580, 460),
  Acrylic = true,
  Theme = "Amethyst",
  MinimizeKey = Enum.KeyCode.RightControl,
})

local v2 = {
  Player = window:AddTab({ Title = "Player", Icon = "user" }),
  Visual = window:AddTab({ Title = "Visual", Icon = "eye" }),
  World = window:AddTab({ Title = "World", Icon = "cloud" }),
  Utility = window:AddTab({ Title = "Utility", Icon = "axe" }),
  Settings = window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local localPlayer2 = players.LocalPlayer
local currentCamera = workspace.CurrentCamera

local function f1()
  return (localPlayer2.Character or localPlayer2.CharacterAdded:Wait()):FindFirstChildOfClass("Humanoid")
end

v2.Player:AddSlider("WalkSpeed", {
  Title = "WalkSpeed",
  Min = 16,
  Max = 200,
  Default = 16,
  Rounding = 0,
  Callback = function(value)
    local v3 = f1()

    if v3 then
      v3.WalkSpeed = value
    end
  end,
})

v2.Player:AddSlider("JumpPower", {
  Title = "Jump Height",
  Min = 50,
  Max = 300,
  Default = 50,
  Rounding = 0,
  Callback = function(value2)
    local v4 = f1()

    if v4 then
      v4.JumpPower = value2
    end
  end,
})

v2.Visual:AddToggle("ThirdPerson", {
  Title = "Third-Person Unlocker",
  Description = "Unlocks zoom and disables shift lock restrictions",
  Default = false,
  Callback = function(value3)
    if value3 then
      localPlayer2.CameraMode = Enum.CameraMode.Classic
      localPlayer2.CameraMaxZoomDistance = 1000
    else
      localPlayer2.CameraMaxZoomDistance = 128
    end
  end,
})

local connect = nil

local function f2(p1)
  if connect then
    connect:Disconnect()
  end

  if p1 then
    connect = runService.Stepped:Connect(function()
      local character = localPlayer2.Character

      if character then
        for index, value4 in ipairs(character:GetDescendants()) do
          if value4:IsA("BasePart") and value4.CanCollide then
            value4.CanCollide = false
          end
        end
      end
    end)
  end
end

v2.Player:AddToggle("NoclipToggle", { Title = "Noclip", Default = false }):OnChanged(function(p2)
  f2(p2)
end)

local connect2

local function f3(p3)
  if connect2 then
    connect2:Disconnect()
  end

  if p3 then
    connect2 = userInputService.JumpRequest:Connect(function()
      if localPlayer2.Character and localPlayer2.Character:FindFirstChild("Humanoid") then
        localPlayer2.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
      end
    end)
  end
end

v2.Player:AddToggle("InfJumpToggle", { Title = "Infinite Jump", Default = false }):OnChanged(function(p4)
  f3(p4)
end)

v2.Visual:AddSlider("FOVSlider", {
  Title = "FOV Changer",
  Description = "Adjust camera FOV",
  Default = workspace.CurrentCamera.FieldOfView,
  Min = 40,
  Max = 120,
  Rounding = 0,
  Callback = function(value5) workspace.CurrentCamera.FieldOfView = value5 end,
})

local sealientUIInfo = Instance.new("ScreenGui")
sealientUIInfo.Name = "SealientUI_Info"
sealientUIInfo.ResetOnSpawn = false
sealientUIInfo.IgnoreGuiInset = true
sealientUIInfo.Parent = coreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 60)
frame.Position = UDim2.new(1, -230, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.5
frame.BorderSizePixel = 1
frame.BorderColor3 = Color3.fromRGB(0, 255, 0)
frame.Parent = sealientUIInfo

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -10, 0, 25)
textLabel.Position = UDim2.new(0, 5, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel.TextStrokeTransparency = 0.7
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 18
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Text = "Sealient's 3008 UI"
textLabel.Parent = frame

local textLabel2 = Instance.new("TextLabel")
textLabel2.Size = UDim2.new(1, -10, 0, 20)
textLabel2.Position = UDim2.new(0, 5, 0, 25)
textLabel2.BackgroundTransparency = 1
textLabel2.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel2.TextStrokeTransparency = 0.7
textLabel2.Font = Enum.Font.SourceSansItalic
textLabel2.TextSize = 14
textLabel2.TextXAlignment = Enum.TextXAlignment.Left
textLabel2.Text = "FPS: ..."
textLabel2.Parent = frame

_G.Sealient_UI_Version = "v1.2.0"
local v5 = tick()
local v6 = 0

runService.RenderStepped:Connect(function()
  v6 = v6 + 1
  local v7 = tick()

  if v7 - v5 >= 1 then
    textLabel2.Text = string.format(
      "FPS: %d   Version: %s", v6, tostring(_G.Sealient_UI_Version or "Unknown")
    )

    v6 = 0
    v5 = v7
  end
end)

v2.Settings:AddButton({
  Title = "Check Version",
  Description = "Check for new updates",
  Callback = function()
    local sealientUIVersion = _G.Sealient_UI_Version or "Unknown"

    local v8, v9 = pcall(function()
      return game:HttpGet("https://raw.githubusercontent.com/Sealient/Sealients-Roblox-Scripts/refs/heads/main/Sealient's%203008%20UI%20Version.lua")
    end)

    if not v8 or not v9 then
      window:Dialog({
        Title = "Error",
        Content = "Failed to check version from server.",
        Buttons = { { Title = "OK", Callback = function() end } },
      })

      return
    else
      local sS = v9:match("^%s*(.-)%s*$")

      if sS == sealientUIVersion then
        window:Dialog({
          Title = "Up to Date",
          Content = "You are already on the latest version.",
          Buttons = { { Title = "OK", Callback = function() end } },
        })

        return
      end

      window:Dialog({
        Title = "Update Available",
        Content = string.format([[
Current: %s
Latest: %s
Update now?]], sealientUIVersion, sS),
        Buttons = {
          {
            Title = "Update",
            Callback = function()
              if itemESPInstances then
                for key, value6 in pairs(itemESPInstances) do
                  if typeof(value6) == "Instance" and value6:IsA("GuiBase") then
                    value6:Destroy()
                  end
                end

                itemESPInstances = {}
              end

              if itemRenderConnections then
                for key2, value7 in pairs(itemRenderConnections) do
                  if typeof(value7) == "RBXScriptConnection" then
                    value7:Disconnect()
                  end
                end

                itemRenderConnections = {}
              end

              local sealientUIInfo2 = coreGui:FindFirstChild("SealientUI_Info")

              if sealientUIInfo2 then
                sealientUIInfo2:Destroy()
              end

              local coordDisplay = coreGui:FindFirstChild("CoordDisplay")

              if coordDisplay then
                coordDisplay:Destroy()
              end

              if window and typeof(window.Destroy) == "function" then
                window:Destroy()
              end

              local v10, v11 = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Sealient/Sealients-Roblox-Scripts/refs/heads/main/Sealient's%203008%20UI.lua"))()
              end)

              if not v10 then
                warn("Failed to load updated script:", v11)
              end
            end,
          },
          { Title = "Cancel", Callback = function() end },
        },
      })

      return
    end
  end,
})

local coordDisplay2 = Instance.new("ScreenGui")
coordDisplay2.Name = "CoordDisplay"
coordDisplay2.ResetOnSpawn = false
coordDisplay2.Parent = coreGui

local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(0, 160, 0, 50)
frame2.Position = UDim2.new(0, 10, 1, -70)
frame2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame2.BackgroundTransparency = 0.5
frame2.BorderSizePixel = 1
frame2.BorderColor3 = Color3.fromRGB(0, 255, 0)
frame2.Parent = coordDisplay2

local textLabel3 = Instance.new("TextLabel")
textLabel3.Size = UDim2.new(1, -10, 0, 25)
textLabel3.Position = UDim2.new(0, 5, 0, 0)
textLabel3.BackgroundTransparency = 1
textLabel3.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel3.TextStrokeTransparency = 0.7
textLabel3.Font = Enum.Font.SourceSansBold
textLabel3.TextSize = 18
textLabel3.TextXAlignment = Enum.TextXAlignment.Left
textLabel3.Text = "Coordinates"
textLabel3.Parent = frame2

local textLabel4 = Instance.new("TextLabel")
textLabel4.Size = UDim2.new(1, -10, 0, 20)
textLabel4.Position = UDim2.new(0, 5, 0, 25)
textLabel4.BackgroundTransparency = 1
textLabel4.TextColor3 = Color3.fromRGB(0, 255, 0)
textLabel4.TextStrokeTransparency = 0.7
textLabel4.Font = Enum.Font.SourceSansItalic
textLabel4.TextSize = 14
textLabel4.TextXAlignment = Enum.TextXAlignment.Left
textLabel4.Text = ""
textLabel4.Parent = frame2

runService.RenderStepped:Connect(function()
  local humanoidRootPart = localPlayer2.Character
    and localPlayer2.Character:FindFirstChild("HumanoidRootPart")

  if humanoidRootPart then
    local position = humanoidRootPart.Position

    textLabel4.Text = string.format(
      "X: %.1f  Y: %.1f  Z: %.1f", position.X, position.Y, position.Z
    )
  else
    textLabel4.Text = "X: --  Y: --  Z: --"
  end
end)

v2.World:AddSlider("TimeOverride", {
  Title = "Time of Day Override",
  Description = "Only changes how the world looks to you.",
  Min = 0,
  Max = 24,
  Rounding = 1,
  Default = 14,
  Callback = function(value8) lighting.ClockTime = value8 end,
})

v2.World:AddButton({
  Title = "Reset Visual Settings",
  Description = "Resets FOV and lighting to default.",
  Callback = function()
    currentCamera.FieldOfView = 70
    lighting.ClockTime = 14
    fluent:Notify({ Title = "Visuals Reset", Content = "FOV and ClockTime reset.", Duration = 5 })
  end,
})

local fogStart = lighting.FogStart
local fogEnd = lighting.FogEnd
local fogColor = lighting.FogColor

v2.World:AddToggle("NoFog", {
  Title = "No Fog",
  Description = "Disables all fog for better visibility.",
  Default = false,
  Callback = function(value9)
    if value9 then
      lighting.FogStart = 1000000000
      lighting.FogEnd = 10000000000
    else
      lighting.FogStart = fogStart
      lighting.FogEnd = fogEnd
      lighting.FogColor = fogColor
    end
  end,
})

local localPlayer3 = players.LocalPlayer
local floor = v1:WaitForChild("GameObjects"):WaitForChild("Physical"):WaitForChild("Map"):WaitForChild("Floor")
local v12 = 50

local v13 = {
  ["2 litre Dr. Bob"] = true,
  Apple = true,
  Banana = true,
  Beans = true,
  ["Bloxy Soda"] = true,
  Burger = true,
  Meatballs = true,
  Chips = true,
  Hotdog = true,
  Lemon = true,
  Pizza = true,
  ["Striped Donut"] = true,
  Water = true,
  Medkit = true,
  ["Dr. Bob Soda"] = true,
  ["Ice Cream"] = true,
  Cookie = true,
  ["Lemon Slice"] = true,
  ["Fish Crackers"] = true,
}

local v14 = {}
local cframe, f4

local function f5(p5)
  local v15 = f4()

  if not v15 then
    return
  else
    if not cframe then
      cframe = v15.CFrame
    end

    local position2 = nil

    if p5:IsA("BasePart") then
      position2 = p5.Position
    elseif p5:IsA("Model") then
      local primaryPart = p5.PrimaryPart

      local basePart = primaryPart
      basePart = primaryPart or p5:FindFirstChildWhichIsA("BasePart")

      if basePart then
        position2 = basePart.Position
      else
        position2 = p5:GetBoundingBox().Position
      end
    end

    if position2 then
      v15.CFrame = CFrame.new(position2 + Vector3.new(0, 5, 0))
    else
      warn("[Teleport] Could not determine item position.")
    end

    return
  end
end

local function f6()
  v14 = {}
  local v16 = f4()

  if not v16 then
    return
  end

  for v17, v18 in floor:GetChildren() do
    if v18:IsA("Model") then
      local items = v18:FindFirstChild("Items")

      if items then
        for v19, v20 in items:GetChildren() do
          if v13[v20.Name] then
            local basePart2 = v20:IsA("BasePart") and v20

            local basePart3 = basePart2
            basePart3 = basePart2 or v20:FindFirstChildWhichIsA("BasePart")

            if basePart3 then
              local magnitude = (basePart3.Position - v16.Position).Magnitude

              if magnitude <= v12 then
                v14[string.format("%s (%.0f studs)", v20.Name, magnitude)] = v20
              end
            end
          end
        end
      end
    end
  end
end

function f4()
  local character2 = localPlayer3.Character
  return character2 and character2:FindFirstChild("HumanoidRootPart")
end

v2.Utility:AddSlider("ItemSearchRadius", {
  Title = "Item Search Radius",
  Description = "Max distance to find valid items",
  Default = 50,
  Min = 10,
  Max = 200,
  Rounding = 0,
  Callback = function(value10) v12 = value10 end,
})

local addDropdown

v2.Utility:AddButton({
  Name = "RefreshNearbyItems",
  Title = "🔄 Refresh Nearby Items",
  Description = "Scan for items within range",
  Callback = function()
    f6()
    local v21 = {}

    for key3 in pairs(v14) do
      table.insert(v21, key3)
    end

    table.sort(v21)

    if addDropdown then
      addDropdown:SetValues(v21)
    else
      addDropdown = v2.Utility:AddDropdown("ItemTPDropdown", {
        Title = "Teleport to Item",
        Description = "Select a nearby item to teleport to.",
        Values = v21,
        Multi = false,
        Callback = function(value11)
          local v22 = v14[value11]

          if v22 then
            f5(v22)
          end
        end,
      })
    end
  end,
})

v2.Utility:AddButton({
  Title = "↩ Return to Original Position",
  Description = "Teleport back to where you were before item teleport",
  Callback = function()
    local v23 = f4()

    if v23 and cframe then
      v23.CFrame = cframe
      cframe = nil
    end
  end,
})

local employees = Workspace:WaitForChild("GameObjects"):WaitForChild("Physical"):WaitForChild("Employees")
local v24 = 1000
local v25 = {}
local v26 = {}

local function f7(p6)
  if v26[p6] then
    v26[p6]:Disconnect()
    v26[p6] = nil
  end

  if v25[p6] then
    v25[p6]:Destroy()
    v25[p6] = nil
  end
end

local employeeESP = false

local function f8(p7)
  local employeeESP2, textLabel5

  if v25[p7] then
    return
  else
    local humanoid = p7:FindFirstChildOfClass("Humanoid")

    local humanoidRootPart2 = p7:FindFirstChild("HumanoidRootPart")
      or p7:FindFirstChildWhichIsA("BasePart")

    if not humanoid or not humanoidRootPart2 then
      return
    else
      employeeESP2 = Instance.new("BillboardGui")
      employeeESP2.Name = "EmployeeESP"
      employeeESP2.Adornee = humanoidRootPart2
      employeeESP2.AlwaysOnTop = true
      employeeESP2.Size = UDim2.new(0, 150, 0, 50)
      employeeESP2.StudsOffset = Vector3.new(0, 3, 0)
      employeeESP2.LightInfluence = 0
      employeeESP2.ResetOnSpawn = false

      local frame3 = Instance.new("Frame")
      frame3.Size = UDim2.new(1, 0, 1, 0)
      frame3.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
      frame3.BackgroundTransparency = 0.5
      frame3.BorderSizePixel = 1
      frame3.BorderColor3 = Color3.fromRGB(255, 0, 0)
      frame3.Parent = employeeESP2

      local textLabel6 = Instance.new("TextLabel")
      textLabel6.Size = UDim2.new(1, -10, 0, 25)
      textLabel6.Position = UDim2.new(0, 5, 0, 0)
      textLabel6.BackgroundTransparency = 1
      textLabel6.TextColor3 = Color3.fromRGB(255, 0, 0)
      textLabel6.TextStrokeTransparency = 0.7
      textLabel6.Font = Enum.Font.SourceSansBold
      textLabel6.TextSize = 18
      textLabel6.TextXAlignment = Enum.TextXAlignment.Left
      textLabel6.Text = p7.Name
      textLabel6.Parent = frame3

      textLabel5 = Instance.new("TextLabel")
      textLabel5.Size = UDim2.new(1, -10, 0, 20)
      textLabel5.Position = UDim2.new(0, 5, 0, 25)
      textLabel5.BackgroundTransparency = 1
      textLabel5.TextColor3 = Color3.fromRGB(255, 0, 0)
      textLabel5.TextStrokeTransparency = 0.7
      textLabel5.Font = Enum.Font.SourceSansItalic
      textLabel5.TextSize = 14
      textLabel5.TextXAlignment = Enum.TextXAlignment.Left
      textLabel5.Text = ""
      textLabel5.Parent = frame3

      employeeESP2.Parent = p7
      v25[p7] = employeeESP2

      v26[p7] = runService.RenderStepped:Connect(function()
        if not humanoidRootPart2:IsDescendantOf(Workspace) or not localPlayer3.Character
          or not localPlayer3.Character:FindFirstChild("HumanoidRootPart") then
          f7(p7)
          return
        else
          local magnitude2 = (humanoidRootPart2.Position
            - localPlayer3.Character.HumanoidRootPart.Position).Magnitude

          if magnitude2 > v24 or not employeeESP then
            employeeESP2.Enabled = false
          else
            employeeESP2.Enabled = true
            textLabel5.Text = string.format("Distance: %.1f studs", magnitude2)
          end

          return
        end
      end)

      return
    end
  end
end

local function f9()
  for key4 in pairs(v25) do
    f7(key4)
  end
end

local function f10()
  f9()

  for index2, value12 in ipairs(employees:GetChildren()) do
    if value12:FindFirstChildOfClass("Humanoid") then
      f8(value12)
    end
  end
end

local connect3

local function f11()
  if connect3 then
    connect3:Disconnect()
  end

  connect3 = employees.ChildAdded:Connect(function(child)
    task.delay(0.2, function()
      if child:FindFirstChildOfClass("Humanoid") then
        f8(child)
      end
    end)
  end)
end

v2.Visual:AddToggle("ESP_Employees", {
  Title = "👷 Employee ESP",
  Description = "Show ESP for employees within range",
  Default = false,
  Callback = function(value13)
    employeeESP = value13

    if value13 then
      f10()
      f11()
    else
      f9()

      if connect3 then
        connect3:Disconnect()
        connect3 = nil
      end
    end
  end,
})

v2.Visual:AddSlider("ESP_EmployeeRange", {
  Title = "👁️ Employee ESP Max Range",
  Description = "Max distance to show employee ESP",
  Default = v24,
  Min = 50,
  Max = 2000,
  Rounding = 0,
  Callback = function(value14) v24 = value14 end,
})

local floor2 = Workspace:WaitForChild("GameObjects"):WaitForChild("Physical"):WaitForChild("Map"):WaitForChild("Floor")

local v27 = {
  ["2 litre Dr. Bob"] = true,
  Apple = true,
  Banana = true,
  Beans = true,
  ["Bloxy Soda"] = true,
  Burger = true,
  Meatballs = true,
  Chips = true,
  Hotdog = true,
  Lemon = true,
  Pizza = true,
  ["Striped Donut"] = true,
  Water = true,
  Medkit = true,
  ["Dr. Bob Soda"] = true,
  ["Ice Cream"] = true,
  Cookie = true,
  ["Lemon Slice"] = true,
  ["Fish Crackers"] = true,
}

local v28 = {}
local v29 = {}
local v30 = 250

local function f12(p8)
  if v28[p8] then
    v28[p8]:Destroy()
    v28[p8] = nil
  end

  if v29[p8] then
    v29[p8]:Disconnect()
    v29[p8] = nil
  end
end

local f13

local function f14()
  for key5, value15 in pairs(floor2:GetChildren()) do
    local items2 = value15:FindFirstChild("Items")

    if items2 then
      for key6, value16 in pairs(items2:GetChildren()) do
        if v27[value16.Name] then
          f12(value16)
          f13(value16)
        end
      end

      items2.ChildAdded:Connect(function(child2)
        if v27[child2.Name] then
          f12(child2)
          f13(child2)
        end
      end)
    end
  end
end

function f13(p9)
  local basePart4 = p9:IsA("BasePart") and p9 or p9:FindFirstChildWhichIsA("BasePart")
  local itemESP, textLabel7

  if not basePart4 then
    return
  else
    itemESP = Instance.new("BillboardGui")
    itemESP.Name = "ItemESP"
    itemESP.Adornee = basePart4
    itemESP.AlwaysOnTop = true
    itemESP.Size = UDim2.new(0, 150, 0, 50)
    itemESP.StudsOffset = Vector3.new(0, 3, 0)
    itemESP.LightInfluence = 0
    itemESP.ResetOnSpawn = false

    local frame4 = Instance.new("Frame")
    frame4.Size = UDim2.new(1, 0, 1, 0)
    frame4.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame4.BackgroundTransparency = 0.5
    frame4.BorderSizePixel = 1
    frame4.BorderColor3 = Color3.fromRGB(0, 255, 0)
    frame4.Parent = itemESP

    local textLabel8 = Instance.new("TextLabel")
    textLabel8.Size = UDim2.new(1, -10, 0, 25)
    textLabel8.Position = UDim2.new(0, 5, 0, 0)
    textLabel8.BackgroundTransparency = 1
    textLabel8.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel8.TextStrokeTransparency = 0.7
    textLabel8.Font = Enum.Font.SourceSansBold
    textLabel8.TextSize = 18
    textLabel8.TextXAlignment = Enum.TextXAlignment.Left
    textLabel8.Text = p9.Name
    textLabel8.Parent = frame4

    textLabel7 = Instance.new("TextLabel")
    textLabel7.Size = UDim2.new(1, -10, 0, 20)
    textLabel7.Position = UDim2.new(0, 5, 0, 25)
    textLabel7.BackgroundTransparency = 1
    textLabel7.TextColor3 = Color3.fromRGB(0, 255, 0)
    textLabel7.TextStrokeTransparency = 0.7
    textLabel7.Font = Enum.Font.SourceSansItalic
    textLabel7.TextSize = 14
    textLabel7.TextXAlignment = Enum.TextXAlignment.Left
    textLabel7.Text = ""
    textLabel7.Parent = frame4

    itemESP.Parent = p9
    v28[p9] = itemESP

    v29[p9] = runService.RenderStepped:Connect(function()
      if not basePart4:IsDescendantOf(Workspace) or not localPlayer3.Character
        or not localPlayer3.Character:FindFirstChild("HumanoidRootPart") then
        f12(p9)
        return
      else
        local magnitude3 = (basePart4.Position - localPlayer3.Character.HumanoidRootPart.Position).Magnitude

        if magnitude3 > v30 then
          itemESP.Enabled = false
        else
          itemESP.Enabled = true
          textLabel7.Text = string.format("Distance: %.1f studs", magnitude3)
        end

        return
      end
    end)

    return
  end
end

local connect4

local function f15()
  if connect4 then
    connect4:Disconnect()
  end

  for key7 in pairs(v28) do
    f12(key7)
  end

  v28 = {}
  v29 = {}
end

local function f16()
  f15()
  f14()

  connect4 = floor2.ChildAdded:Connect(function(child3)
    if child3:IsA("Model") then
      local waitForChild = child3:WaitForChild("Items", 5)

      if waitForChild then
        for key8, value17 in pairs(waitForChild:GetChildren()) do
          if v27[value17.Name] then
            f12(value17)
            f13(value17)
          end
        end

        waitForChild.ChildAdded:Connect(function(child4)
          if v27[child4.Name] then
            f12(child4)
            f13(child4)
          end
        end)
      end
    end
  end)
end

v2.Visual:AddToggle("ESP_Items", {
  Title = "📦 Item ESP",
  Description = "Shows ESP only on valid nearby items",
  Default = false,
  Callback = function(value18)
    if value18 then
      f16()
    else
      f15()
    end
  end,
})

v2.Visual:AddSlider("ESP_ItemRange", {
  Title = "📏 Item ESP Max Range",
  Description = "Max distance to show item ESP",
  Default = v30,
  Min = 50,
  Max = 500,
  Rounding = 0,
  Callback = function(value19) v30 = value19 end,
})

saveManager:SetLibrary(fluent)
interfaceManager:SetLibrary(fluent)

saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({})

interfaceManager:SetFolder("FluentScriptHub")
saveManager:SetFolder("FluentScriptHub/Game")
interfaceManager:BuildInterfaceSection(v2.Settings)
saveManager:BuildConfigSection(v2.Settings)
window:SelectTab(1)

fluent:Notify({
  Title = "Sealient's 3008 UI",
  Content = "Loaded successfully, Please Enjoy.",
  Duration = 6,
})

fluent:Notify({ Title = "Discord", Content = "S6c5we5D4J", Duration = 6 })

saveManager:LoadAutoloadConfig()
