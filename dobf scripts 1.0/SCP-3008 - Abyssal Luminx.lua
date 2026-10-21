--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/3008-%20UPDATED/3008%20%28new%29.lua
Source SHA-256: f9d194286f131534198665e7718ed97ac1c91dbaff083f3870e643b1715f425c
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

local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local lighting = game:GetService("Lighting")
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local virtualUser = game:GetService("VirtualUser")
local teleportService = game:GetService("TeleportService")
local luminxUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sealient/LuminxUI/refs/heads/main/LuminxUI.lua"))()

task.spawn(function()
  local abyssalWelcome = Instance.new("ScreenGui")
  abyssalWelcome.Name = "AbyssalWelcome"
  abyssalWelcome.ResetOnSpawn = false
  abyssalWelcome.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  abyssalWelcome.DisplayOrder = 9999
  abyssalWelcome.Parent = game.Players.LocalPlayer.PlayerGui

  local instance = Instance.new("Frame", abyssalWelcome)
  instance.Size = UDim2.new(1, 0, 1, 0)
  instance.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  instance.BackgroundTransparency = 0.45
  instance.BorderSizePixel = 0
  instance.ZIndex = 1

  local instance2 = Instance.new("Frame", abyssalWelcome)
  instance2.Size = UDim2.new(0, 400, 0, 300)
  instance2.AnchorPoint = Vector2.new(0.5, 0.5)
  instance2.Position = UDim2.new(0.5, 0, 0.5, 0)
  instance2.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
  instance2.BorderSizePixel = 0
  instance2.ZIndex = 2

  Instance.new("UICorner", instance2).CornerRadius = UDim.new(0, 10)

  local instance3 = Instance.new("UIStroke", instance2)
  instance3.Thickness = 1.5
  instance3.Color = Color3.fromRGB(0, 150, 255)
  instance3.Transparency = 0.3

  local instance4 = Instance.new("TextLabel", instance2)
  instance4.Size = UDim2.new(1, -20, 0, 40)
  instance4.Position = UDim2.new(0, 10, 0, 14)
  instance4.BackgroundTransparency = 1
  instance4.Text = "Abyssal  v1.0.0"
  instance4.Font = Enum.Font.GothamBold
  instance4.TextSize = 22
  instance4.TextColor3 = Color3.fromRGB(0, 150, 255)
  instance4.TextXAlignment = Enum.TextXAlignment.Center
  instance4.ZIndex = 3

  local instance5 = Instance.new("TextLabel", instance2)
  instance5.Size = UDim2.new(1, -30, 0, 20)
  instance5.Position = UDim2.new(0, 15, 0, 56)
  instance5.BackgroundTransparency = 1
  instance5.Text = "A free exploit menu for SCP-3008"
  instance5.Font = Enum.Font.Gotham
  instance5.TextSize = 13
  instance5.TextColor3 = Color3.fromRGB(140, 140, 140)
  instance5.TextXAlignment = Enum.TextXAlignment.Center
  instance5.ZIndex = 3

  local instance6 = Instance.new("Frame", instance2)
  instance6.Size = UDim2.new(1, -30, 0, 1)
  instance6.Position = UDim2.new(0, 15, 0, 84)
  instance6.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
  instance6.BorderSizePixel = 0
  instance6.ZIndex = 3

  local instance7 = Instance.new("TextLabel", instance2)
  instance7.Size = UDim2.new(1, -30, 0, 110)
  instance7.Position = UDim2.new(0, 15, 0, 96)
  instance7.BackgroundTransparency = 1
  instance7.Text = "Thanks for using Abyssal!\n\nIf you enjoy this menu, please consider:\n• ⭐  Liking & favouriting the script\n• 📢  Sharing it with friends\n• 💬  Leaving feedback so I can improve it\n\nYour support keeps this project alive."
  instance7.Font = Enum.Font.Gotham
  instance7.TextSize = 12
  instance7.TextColor3 = Color3.fromRGB(190, 190, 190)
  instance7.TextXAlignment = Enum.TextXAlignment.Left
  instance7.TextYAlignment = Enum.TextYAlignment.Top
  instance7.TextWrapped = true
  instance7.ZIndex = 3

  local instance8 = Instance.new("TextButton", instance2)
  instance8.Size = UDim2.new(1, -30, 0, 36)
  instance8.Position = UDim2.new(0, 15, 1, -50)
  instance8.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
  instance8.BorderSizePixel = 0
  instance8.Text = "Got it — Let's go!"
  instance8.Font = Enum.Font.GothamBold
  instance8.TextSize = 14
  instance8.TextColor3 = Color3.fromRGB(255, 255, 255)
  instance8.ZIndex = 4

  Instance.new("UICorner", instance8).CornerRadius = UDim.new(0, 7)

  instance8.MouseEnter:Connect(function()
    tweenService:Create(instance8, TweenInfo.new(0.15), {
      BackgroundColor3 = Color3.fromRGB(0, 150, 255),
    }):Play()
  end)

  instance8.MouseLeave:Connect(function()
    tweenService:Create(instance8, TweenInfo.new(0.15), {
      BackgroundColor3 = Color3.fromRGB(0, 120, 220),
    }):Play()
  end)

  instance8.MouseButton1Click:Connect(function()
    tweenService:Create(
      instance2, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
      { Position = UDim2.new(0.5, 0, 1.5, 0), BackgroundTransparency = 1 }
    ):Play()

    tweenService:Create(instance, TweenInfo.new(0.35), { BackgroundTransparency = 1 }):Play()
    task.delay(0.4, function() abyssalWelcome:Destroy() end)
  end)
end)

local abyssalWindow = luminxUI:CreateWindow("Abyssal")

userInputService.InputBegan:Connect(function(input, p1)
  if p1 then
    return
  end

  if input.KeyCode == Enum.KeyCode.V then
    local mainGui = luminxUI.MainGui

    if mainGui then
      mainGui.Enabled = not mainGui.Enabled
    end
  end
end)

local v1 = {
  Players = false,
  Employees = false,
  Items = false,
  Nametags = false,
  FillEnabled = true,
  FillTrans = 0.6,
  MaxRange = 500,
  PlayerColor = Color3.fromRGB(0, 150, 255),
  EmployColor = Color3.fromRGB(255, 150, 0),
  ItemColor = Color3.fromRGB(0, 255, 150),
}

local v2 = {}

local function f1()
  for key, value in pairs(v2) do
    local v3 = value

    pcall(function()
      if v3.highlight and v3.highlight.Parent then
        v3.highlight:Destroy()
      end

      if v3.billboard and v3.billboard.Parent then
        v3.billboard:Destroy()
      end
    end)
  end

  v2 = {}
end

local bESPTab = abyssalWindow:CreateTab("B ESP")
bESPTab:CreateLabel("ESP Targets")

bESPTab:CreateToggle("Player ESP", false, function(p2)
  v1.Players = p2

  if not p2 then
    f1()
  end

  luminxUI:Notify(
    "Visuals", p2 and "Player ESP on" or "Player ESP off", 2, p2 and "success" or "info"
  )
end, "switch")

bESPTab:CreateToggle("Employee ESP", false, function(p3)
  v1.Employees = p3

  if not p3 then
    f1()
  end

  luminxUI:Notify(
    "Visuals", p3 and "Employee ESP on" or "Employee ESP off", 2, p3 and "success" or "info"
  )
end, "switch")

bESPTab:CreateToggle("Item ESP", false, function(p4)
  v1.Items = p4

  if not p4 then
    f1()
  end

  luminxUI:Notify(
    "Visuals", p4 and "Item ESP on" or "Item ESP off", 2, p4 and "success" or "info"
  )
end, "switch")

bESPTab:CreateLabel("Display Options")

bESPTab:CreateToggle("Nametags", false, function(p5)
  v1.Nametags = p5
  f1()

  luminxUI:Notify(
    "Visuals", p5 and "Nametags on" or "Nametags off", 2, p5 and "success" or "info"
  )
end, "switch")

bESPTab:CreateToggle("Fill Highlight", true, function(p6)
  v1.FillEnabled = p6
  f1()
  luminxUI:Notify("Visuals", p6 and "Fill on" or "Fill off", 2, "info")
end, "switch")

bESPTab:CreateSlider("Fill Transparency", 0, 10, 6, function(p7)
  v1.FillTrans = p7 / 10

  for key2, value2 in pairs(v2) do
    local v4 = value2

    pcall(function()
      if v4.highlight then
        local highlight = v4.highlight
        highlight.FillTransparency = v1.FillEnabled and v1.FillTrans or 1
      end
    end)
  end
end)

bESPTab:CreateColorPicker("Player Color", Color3.fromRGB(0, 150, 255), function(playerColor)
  v1.PlayerColor = playerColor
  f1()
end)

bESPTab:CreateColorPicker("Employee Color", Color3.fromRGB(255, 150, 0), function(employColor)
  v1.EmployColor = employColor
  f1()
end)

bESPTab:CreateColorPicker("Item Color", Color3.fromRGB(0, 255, 150), function(itemColor)
  v1.ItemColor = itemColor
  f1()
end)

bESPTab:CreateLabel("Range Settings")
bESPTab:CreateSlider("Max Range", 50, 5000, 500, function(maxRange) v1.MaxRange = maxRange end)

bESPTab:CreateButton("Clear All ESP", function()
  f1()
  luminxUI:Notify("Visuals", "ESP cleared", 2, "warn")
end)

bESPTab:CreateKeybind("Toggle UI Key", Enum.KeyCode.V, function()
  local mainGui2 = luminxUI.MainGui

  if mainGui2 then
    mainGui2.Enabled = not mainGui2.Enabled
  end
end)

local function f2(p8)
  if p8:IsA("Model") then
    if p8.PrimaryPart then
      return p8.PrimaryPart
    else
      local humanoidRootPart = p8:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart then
        return humanoidRootPart
      end

      for key3, value3 in pairs(p8:GetDescendants()) do
        if value3:IsA("BasePart") then
          return value3
        end
      end

      return nil
    end
  else
    if p8:IsA("BasePart") then
      return p8
    end

    return nil
  end
end

local f3

local function f4()
  local v5 = {}
  local v6 = f3("GameObjects", "Physical", "Employees")

  if v6 then
    for key4, value4 in pairs(v6:GetChildren()) do
      table.insert(v5, value4)
    end
  end

  local employees = replicatedStorage:FindFirstChild("Employees")

  if employees then
    for key5, value5 in pairs(employees:GetChildren()) do
      table.insert(v5, value5)
    end
  end

  return v5
end

local f5

local function f6(p9, p10, text)
  local v7 = not p9 or not p9.Parent
  local espHighlight, espBillboard

  if v7 then
    return
  elseif v2[p9] then
    return
  elseif f5(p9) > v1.MaxRange then
    return
  else
    espHighlight = Instance.new("Highlight")
    espHighlight.Name = "ESPHighlight"
    espHighlight.Adornee = p9
    espHighlight.OutlineColor = p10
    espHighlight.OutlineTransparency = 0
    espHighlight.FillColor = p10
    espHighlight.FillTransparency = v1.FillEnabled and v1.FillTrans or 1
    espHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    espHighlight.Parent = game.Players.LocalPlayer.PlayerGui

    espBillboard = nil

    if v1.Nametags then
      espBillboard = Instance.new("BillboardGui")
      espBillboard.Name = "ESPBillboard"
      espBillboard.Size = UDim2.new(0, 120, 0, 30)
      espBillboard.StudsOffset = Vector3.new(0, 3, 0)
      espBillboard.MaxDistance = v1.MaxRange
      espBillboard.AlwaysOnTop = true

      local v8 = espBillboard
      v8.Adornee = f2(p9) or p9

      espBillboard.Parent = game.Players.LocalPlayer.PlayerGui

      local instance9 = Instance.new("Frame", espBillboard)
      instance9.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
      instance9.BackgroundTransparency = 0.5
      instance9.Size = UDim2.new(1, 0, 1, 0)
      instance9.BorderSizePixel = 0

      Instance.new("UICorner", instance9).CornerRadius = UDim.new(0, 4)

      local instance10 = Instance.new("TextLabel", instance9)
      instance10.BackgroundTransparency = 1
      instance10.Size = UDim2.new(1, -6, 1, 0)
      instance10.Position = UDim2.new(0, 3, 0, 0)
      instance10.Text = text
      instance10.TextColor3 = p10
      instance10.Font = Enum.Font.GothamBold
      instance10.TextSize = 12
      instance10.TextXAlignment = Enum.TextXAlignment.Left
    end

    v2[p9] = { highlight = espHighlight, billboard = espBillboard }

    p9.AncestryChanged:Connect(function()
      if not p9.Parent then
        pcall(function()
          if espHighlight and espHighlight.Parent then
            espHighlight:Destroy()
          end
        end)

        pcall(function()
          if espBillboard and espBillboard.Parent then
            espBillboard:Destroy()
          end
        end)

        v2[p9] = nil
      end
    end)

    return
  end
end

function f5(p11)
  local localPlayer = game.Players.LocalPlayer
  local character = localPlayer and localPlayer.Character
  local humanoidRootPart2 = character and character:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart2 then
    return math.huge
  else
    local v9 = f2(p11)

    if not v9 then
      return math.huge
    end

    return (humanoidRootPart2.Position - v9.Position).Magnitude
  end
end

local function f7()
  local v10 = {}
  local v11 = f3("GameObjects", "Physical", "Players")

  if v11 then
    for key6, value6 in pairs(v11:GetChildren()) do
      table.insert(v10, value6)
    end
  end

  return v10
end

function f3(...)
  local v12 = workspace

  for index, value7 in ipairs({ ... }) do
    v12 = v12:FindFirstChild(value7)

    if not v12 then
      return nil
    end
  end

  return v12
end

local v13 = {
  Medkits = true,
  Medkit = true,
  Apple = true,
  Banana = true,
  Beans = true,
  Burger = true,
  Chips = true,
  Chocolate = true,
  Cookie = true,
  ["Fish Crackers"] = true,
  ["Glass Shard"] = true,
  Hotdog = true,
  ["Ice Cream"] = true,
  Lemon = true,
  ["Lemon Slice"] = true,
  Meatballs = true,
  Pizza = true,
  ["Striped Donut"] = true,
  ["2 Litre Dr. Bob"] = true,
  ["Bloxy Soda"] = true,
  ["Dr. Bob"] = true,
  Water = true,
}

local v14 = {}

local function f8(p12)
  for key7, value8 in pairs(p12:GetChildren()) do
    if v13[value8.Name] then
      v14[value8] = true
    end
  end

  p12.ChildAdded:Connect(function(child)
    if v13[child.Name] then
      v14[child] = true
    end
  end)

  p12.ChildRemoved:Connect(function(child2) v14[child2] = nil end)
end

local function f9(p13)
  local v15, v16 = pcall(function() return p13:GetDescendants() end)

  if v15 and type(v16) == "table" then
    for index2, value9 in ipairs(v16) do
      local v17 = value9

      pcall(function()
        if v17.Name == "Items" and (v17:IsA("Folder") or v17:IsA("Model")) then
          f8(v17)
        end
      end)
    end
  end

  p13.DescendantAdded:Connect(function(descendant)
    pcall(function()
      if descendant.Name == "Items" and (descendant:IsA("Folder") or descendant:IsA("Model")) then
        f8(descendant)
      end
    end)
  end)
end

task.delay(5, function()
  local v18 = f3("GameObjects", "Physical", "Map")

  if v18 then
    f9(v18)
  end

  local v19 = f3("GameObjects", "Physical", "Items")

  if v19 then
    f8(v19)
  end
end)

local function f10()
  local v20 = {}

  for key8 in pairs(v14) do
    if key8 and key8.Parent then
      table.insert(v20, key8)
    else
      v14[key8] = nil
    end
  end

  return v20
end

local itemsTab = abyssalWindow:CreateTab("Items")
local v21 = {}
local v22 = 1
local v23 = true
local v24 = 3
itemsTab:CreateLabel("Item Finder")
local itemSelectorDropdown

local function f11()
  if itemSelectorDropdown and itemSelectorDropdown.Parent then
    itemSelectorDropdown:Destroy()
  end

  itemSelectorDropdown = nil

  if #v21 == 0 then
    itemSelectorDropdown = itemsTab:CreateDropdown(
      "Item Selector", { "No items — press Refresh" }, function() end
    )

    return
  else
    local v25 = {}

    for index3, value10 in ipairs(v21) do
      table.insert(v25, value10.name .. "  (" .. value10.dist .. " st)")
    end

    itemSelectorDropdown = itemsTab:CreateDropdown("Item Selector", v25, function(p14)
      for index4, value11 in ipairs(v21) do
        if p14 == value11.name .. "  (" .. value11.dist .. " st)" then
          v22 = index4

          luminxUI:Notify("Items", "Selected: " .. value11.name .. " — " .. value11.dist
            .. " studs away", 2, "info")

          break
        end
      end
    end)

    return
  end
end

local function f12()
  v21 = {}
  v22 = 1
  local character2 = game.Players.LocalPlayer.Character

  local humanoidRootPart3 = character2
  humanoidRootPart3 = character2 and character2:FindFirstChild("HumanoidRootPart")

  for key9 in pairs(v14) do
    if key9 and key9.Parent then
      local huge = math.huge

      if humanoidRootPart3 then
        local v26 = f2(key9)

        if v26 then
          huge = math.floor((humanoidRootPart3.Position - v26.Position).Magnitude)
        end
      end

      table.insert(v21, { obj = key9, name = key9.Name, dist = huge })
    end
  end

  local v27 = {}

  for index5, value12 in ipairs(v21) do
    if value12.dist > 10 then
      table.insert(v27, value12)
    end
  end

  v21 = v27
  table.sort(v21, function(p15, p16) return p15.dist < p16.dist end)
  f11()

  if #v21 > 0 then
    local v28 = v21[1]

    luminxUI:Notify("Items", #v21 .. " items found — closest: " .. v28.name .. " (" .. v28.dist
      .. " st)", 5, "success")
  else
    luminxUI:Notify("Items", "No whitelisted items found nearby", 3, "warn")
  end
end

itemsTab:CreateButton("Refresh Items", function() f12() end)
itemsTab:CreateDivider("Teleport")

itemsTab:CreateToggle("Auto Return", true, function(p17)
  v23 = p17
  luminxUI:Notify("Items", p17 and "Auto return on" or "Auto return off", 2, "info")
end, "switch")

itemsTab:CreateSlider("Return Delay (s)", 1, 30, 3, function(p18) v24 = p18 end)

local cframe

itemsTab:CreateButton("Teleport to Selected", function()
  if #v21 == 0 then
    luminxUI:Notify("Items", "No items — press Refresh first", 3, "warn")
    return
  else
    local v29 = v21[v22]

    if not v29 or not v29.obj or not v29.obj.Parent then
      luminxUI:Notify("Items", "Item no longer exists — refresh the list", 3, "error")
      return
    else
      local character3 = game.Players.LocalPlayer.Character
      local humanoidRootPart4 = character3 and character3:FindFirstChild("HumanoidRootPart")

      if not humanoidRootPart4 then
        return
      else
        cframe = humanoidRootPart4.CFrame
        local v30 = f2(v29.obj)

        if not v30 then
          luminxUI:Notify("Items", "Could not find item root part", 3, "error")
          return
        end

        humanoidRootPart4.CFrame = v30.CFrame + Vector3.new(0, 4, 0)
        luminxUI:Notify("Items", "Teleported to " .. v29.name, 3, "success")

        if v23 then
          task.delay(v24, function()
            local character4 = game.Players.LocalPlayer.Character

            local humanoidRootPart5 = character4
              and character4:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart5 and cframe then
              humanoidRootPart5.CFrame = cframe
              luminxUI:Notify("Items", "Returned to saved position", 2, "info")
            end
          end)
        end

        return
      end
    end
  end
end)

itemsTab:CreateButton("Return to Saved Position", function()
  if not cframe then
    luminxUI:Notify("Items", "No saved position yet", 2, "warn")
    return
  else
    local character5 = game.Players.LocalPlayer.Character
    local humanoidRootPart6 = character5 and character5:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart6 then
      humanoidRootPart6.CFrame = cframe
      luminxUI:Notify("Items", "Returned to saved position", 2, "info")
    end

    return
  end
end)

itemsTab:CreateDivider("Item Selector")

f11()

local visualsTab = abyssalWindow:CreateTab("Visuals")
visualsTab:CreateLabel("Xray")

local abyssalXray

local function f13()
  if abyssalXray then
    return
  end

  abyssalXray = Instance.new("Highlight")
  abyssalXray.Name = "AbyssalXray"
  abyssalXray.Adornee = workspace
  abyssalXray.FillTransparency = 1
  abyssalXray.OutlineTransparency = 0.5
  abyssalXray.OutlineColor = Color3.fromRGB(255, 255, 255)
  abyssalXray.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
  abyssalXray.Parent = game.Players.LocalPlayer.PlayerGui
end

local function f14()
  if abyssalXray then
    abyssalXray:Destroy()
    abyssalXray = nil
  end
end

visualsTab:CreateToggle("Xray (See Through Walls)", false, function(p19)
  if p19 then
    f13()
  else
    f14()
  end

  luminxUI:Notify("Visuals", p19 and "Xray on" or "Xray off", 2, p19 and "success" or "info")
end, "switch")

visualsTab:CreateSlider("Xray Outline Transparency", 0, 9, 5, function(p20)
  if abyssalXray then
    abyssalXray.OutlineTransparency = p20 / 10
  end
end)

visualsTab:CreateLabel("Click Transparency")

local v31 = false
local v32 = 10
local localTransparencyModifier = 0.75
local v33 = {}

visualsTab:CreateToggle("Ctrl+Shift+Click Transparent", false, function(p21)
  v31 = p21

  luminxUI:Notify(
    "Visuals", p21 and "Hold Ctrl+Shift and click a part" or "Click transparency off", 3,
    p21 and "info" or "warn"
  )
end, "switch")

visualsTab:CreateSlider("Revert After (s)", 1, 60, 10, function(p22) v32 = p22 end)

visualsTab:CreateSlider("Transparency Amount", 1, 9, 7, function(p23)
  localTransparencyModifier = p23 / 10
end)

local getMouse = game.Players.LocalPlayer:GetMouse()

getMouse.Button1Down:Connect(function()
  if not v31 then
    return
  end

  if not (userInputService:IsKeyDown(Enum.KeyCode.LeftControl)
    and userInputService:IsKeyDown(Enum.KeyCode.LeftShift)) then
    return
  end

  local target = getMouse.Target

  if not target or not target:IsA("BasePart") then
    return
  end

  if v33[target] then
    task.cancel(v33[target])
  end

  local localTransparencyModifier2 = target.LocalTransparencyModifier
  target.LocalTransparencyModifier = localTransparencyModifier

  v33[target] = task.delay(v32, function()
    pcall(function() target.LocalTransparencyModifier = localTransparencyModifier2 end)
    v33[target] = nil
  end)

  luminxUI:Notify("Visuals", "Part hidden — reverts in " .. v32 .. "s", 2, "info")
end)

visualsTab:CreateLabel("Night Vision")
local brightness = lighting.Brightness
local ambient = lighting.Ambient
local outdoorAmbient

local function f15()
  brightness = lighting.Brightness
  ambient = lighting.Ambient
  outdoorAmbient = lighting.OutdoorAmbient

  lighting.Brightness = 5
  lighting.Ambient = Color3.fromRGB(180, 180, 180)
  lighting.OutdoorAmbient = Color3.fromRGB(180, 180, 180)
end

local function f16()
  lighting.Brightness = brightness
  lighting.Ambient = ambient
  lighting.OutdoorAmbient = outdoorAmbient
end

outdoorAmbient = lighting.OutdoorAmbient

visualsTab:CreateToggle("Night Vision", false, function(p24)
  if p24 then
    f15()
  else
    f16()
  end

  luminxUI:Notify(
    "Visuals", p24 and "Night vision on" or "Night vision off", 2, p24 and "success" or "info"
  )
end, "switch")

visualsTab:CreateLabel("Fog")

local fogEnd = lighting.FogEnd
local fogStart = lighting.FogStart

visualsTab:CreateToggle("Remove Fog", false, function(p25)
  if p25 then
    fogEnd = lighting.FogEnd
    fogStart = lighting.FogStart

    lighting.FogEnd = 100000
    lighting.FogStart = 100000

    luminxUI:Notify("Visuals", "Fog removed", 2, "success")
  else
    lighting.FogEnd = fogEnd
    lighting.FogStart = fogStart
    luminxUI:Notify("Visuals", "Fog restored", 2, "info")
  end
end, "switch")

visualsTab:CreateSlider("Fog Density", 0, 100, 50, function(p26)
  local v34 = 100000 - p26 / 100 * 99900
  lighting.FogEnd = v34
  lighting.FogStart = v34 * 0.1
end)

local miscTab = abyssalWindow:CreateTab("Misc")
local localPlayer2 = players.LocalPlayer

miscTab:CreateLabel("Player")

miscTab:CreateSlider("Walk Speed", 16, 300, 16, function(walkSpeed)
  local character6 = localPlayer2.Character
  local humanoid = character6 and character6:FindFirstChildOfClass("Humanoid")

  if humanoid then
    humanoid.WalkSpeed = walkSpeed
  end
end)

miscTab:CreateSlider("Jump Power", 7, 200, 50, function(jumpPower)
  local character7 = localPlayer2.Character
  local humanoid2 = character7 and character7:FindFirstChildOfClass("Humanoid")

  if humanoid2 then
    humanoid2.JumpPower = jumpPower
  end
end)

local v35 = false

miscTab:CreateToggle("Noclip", false, function(p27)
  v35 = p27
  luminxUI:Notify("Misc", p27 and "Noclip on" or "Noclip off", 2, p27 and "success" or "info")
end, "switch")

runService.Stepped:Connect(function()
  if not v35 then
    return
  else
    local character8 = localPlayer2.Character

    if not character8 then
      return
    end

    for key10, value13 in pairs(character8:GetDescendants()) do
      if value13:IsA("BasePart") then
        value13.CanCollide = false
      end
    end

    return
  end
end)

local v36 = false

miscTab:CreateToggle("Infinite Jump", false, function(p28)
  v36 = p28

  luminxUI:Notify(
    "Misc", p28 and "Infinite jump on" or "Infinite jump off", 2, p28 and "success" or "info"
  )
end, "switch")

userInputService.JumpRequest:Connect(function()
  if not v36 then
    return
  else
    local character9 = localPlayer2.Character
    local humanoid3 = character9 and character9:FindFirstChildOfClass("Humanoid")

    if humanoid3 then
      humanoid3:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    return
  end
end)

local connect

miscTab:CreateToggle("God Mode", false, function(p29)
  if p29 then
    connect = runService.Heartbeat:Connect(function()
      local character10 = localPlayer2.Character
      local humanoid4 = character10 and character10:FindFirstChildOfClass("Humanoid")

      if humanoid4 then
        humanoid4.Health = humanoid4.MaxHealth
      end
    end)
  elseif connect then
    connect:Disconnect()
    connect = nil
  end

  luminxUI:Notify(
    "Misc", p29 and "God mode on" or "God mode off", 2, p29 and "success" or "info"
  )
end, "switch")

miscTab:CreateLabel("Camera")

miscTab:CreateSlider("FOV", 50, 120, 70, function(fieldOfView)
  workspace.CurrentCamera.FieldOfView = fieldOfView
end)

miscTab:CreateToggle("Full Bright", false, function(p30)
  if p30 then
    lighting.Brightness = 10
    lighting.ClockTime = 14
    lighting.FogEnd = 100000
    lighting.GlobalShadows = false
  else
    lighting.Brightness = 2
    lighting.ClockTime = 8
    lighting.FogEnd = fogEnd
    lighting.GlobalShadows = true
  end

  luminxUI:Notify("Misc", p30 and "Full bright on" or "Full bright off", 2, "info")
end, "switch")

miscTab:CreateLabel("Anti-AFK")

local connect2

miscTab:CreateToggle("Anti-AFK", false, function(p31)
  if p31 then
    connect2 = runService.Heartbeat:Connect(function()
      virtualUser:CaptureController()
      virtualUser:ClickButton2(Vector2.new())
    end)

    localPlayer2.Idled:Connect(function()
      virtualUser:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
      task.wait(1)
      virtualUser:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
    end)

    luminxUI:Notify("Misc", "Anti-AFK on", 2, "success")
  else
    if connect2 then
      connect2:Disconnect()
      connect2 = nil
    end

    luminxUI:Notify("Misc", "Anti-AFK off", 2, "info")
  end
end, "switch")

miscTab:CreateLabel("Session")

miscTab:CreateToggle("Auto Rejoin on Kick", false, function(p32)
  if p32 then
    localPlayer2.OnTeleport:Connect(function(p33)
      if p33 == Enum.TeleportState.Failed then
        teleportService:Teleport(game.PlaceId, localPlayer2)
      end
    end)

    game.Players.PlayerRemoving:Connect(function(player)
      if player == localPlayer2 then
        task.wait(3)
        teleportService:Teleport(game.PlaceId)
      end
    end)

    luminxUI:Notify("Misc", "Auto rejoin on", 2, "success")
  else
    luminxUI:Notify("Misc", "Auto rejoin cannot be disabled mid-session", 3, "warn")
  end
end, "switch")

miscTab:CreateButton("Rejoin Now", function()
  luminxUI:Notify("Misc", "Rejoining...", 2, "info")
  task.delay(1.5, function() teleportService:Teleport(game.PlaceId, localPlayer2) end)
end)

miscTab:CreateButton("Disconnect", function()
  luminxUI:Notify("Misc", "Disconnecting...", 2, "warn")
  task.delay(1, function() teleportService:Teleport(1818) end)
end)

local creditsTab = abyssalWindow:CreateTab("Credits")
creditsTab:CreateLabel("Abyssal  v1.0.0")
creditsTab:CreateDivider("About")
creditsTab:CreateLabel("A free SCP-3008 exploit menu")
creditsTab:CreateLabel("Built with LuminxUI by Sealient")
creditsTab:CreateDivider("Developer")
creditsTab:CreateLabel("Script by: Seally (Sealient)  ❤")
creditsTab:CreateLabel("UI Library: Sealient (LuminxUI)")
creditsTab:CreateDivider("Support")
creditsTab:CreateLabel("Like & favourite to support!")
creditsTab:CreateLabel("Share with friends  ❤")

creditsTab:CreateButton("Copy Script Source URL", function()
  if setclipboard then
    setclipboard("https://raw.githubusercontent.com/Sealient/LuminxUI/refs/heads/main/LuminxUI.lua")
    luminxUI:Notify("Credits", "URL copied to clipboard!", 3, "success")
  else
    luminxUI:Notify("Credits", "Clipboard not available in this executor", 3, "warn")
  end
end)

local v37 = 0

runService.Heartbeat:Connect(function(delta)
  v37 = v37 + delta

  if v37 < 0.5 then
    return
  end

  v37 = 0

  if v1.Players then
    for key11, value14 in pairs(f7()) do
      pcall(f6, value14, v1.PlayerColor, "PLAYER")
    end
  end

  if v1.Employees then
    for key12, value15 in pairs(f4()) do
      pcall(f6, value15, v1.EmployColor, value15.Name)
    end
  end

  if v1.Items then
    for key13, value16 in pairs(f10()) do
      pcall(f6, value16, v1.ItemColor, value16.Name)
    end
  end

  for key14, value17 in pairs(v2) do
    local v38 = value17

    if key14 and key14.Parent then
      if f5(key14) > v1.MaxRange then
        pcall(function() v38.highlight:Destroy() end)

        pcall(function()
          if v38.billboard then
            v38.billboard:Destroy()
          end
        end)

        v2[key14] = nil
      end
    end
  end
end)
