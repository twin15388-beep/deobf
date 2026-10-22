--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/0x100C/Roblox-Scripts/blob/97fa45e403a00a3d7d1a06c4271e0a787269dd33/Obsfucate/Prison-Life%28Half-Broken%29.lua
Source SHA-256: dd8a5a7502a263969db9031bfb3a99389d722c9921dc5a678d9979e131962bea
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a
Check reports/game-sources-2026-10-21-followup.md for function parameters, limits and risks.
MIT LICENSE BEGIN
MIT License

Copyright (c) 2025 s-0-u-l-z

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
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local windUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local v1 = {}
local localPlayer = players.LocalPlayer
;(localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
local currentCamera = workspace.CurrentCamera

function v1.equip(cframe)
  local humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")

  local create = tweenService:Create(humanoidRootPart, TweenInfo.new(0.05), { CFrame = cframe })
  create:Play()
  create.Completed:Wait()

  tweenService:Create(humanoidRootPart, TweenInfo.new(0.05), {
    CFrame = humanoidRootPart.CFrame,
  }):Play()
end

local window = windUI:CreateWindow({
  Title = "Vex Hub | Prison Life",
  Author = "Author: .interception. & s0ulz.lua",
  Folder = "VexHub",
  Icon = "flame",
  Transparent = false,
  HideSearchBar = false,
})

window:Tag({ Title = "PL1.0.3", Radius = 8 })

windUI:AddTheme({
  Name = "Midnight Blue",
  Accent = Color3.fromHex("#1e3a8a"),
  Dialog = Color3.fromHex("#1e293b"),
  Outline = Color3.fromHex("#3b82f6"),
  Text = Color3.fromHex("#f1f5f9"),
  Placeholder = Color3.fromHex("#64748b"),
  Background = Color3.fromHex("#0f172a"),
  Button = Color3.fromHex("#334155"),
  Icon = Color3.fromHex("#94a3b8"),
})

windUI:AddTheme({
  Name = "Crimson Red",
  Accent = Color3.fromHex("#7f1d1d"),
  Dialog = Color3.fromHex("#1c1917"),
  Outline = Color3.fromHex("#dc2626"),
  Text = Color3.fromHex("#fef2f2"),
  Placeholder = Color3.fromHex("#78716c"),
  Background = Color3.fromHex("#0a0a0a"),
  Button = Color3.fromHex("#44403c"),
  Icon = Color3.fromHex("#a8a29e"),
})

windUI:AddTheme({
  Name = "Forest Green",
  Accent = Color3.fromHex("#14532d"),
  Dialog = Color3.fromHex("#1c1917"),
  Outline = Color3.fromHex("#16a34a"),
  Text = Color3.fromHex("#f0fdf4"),
  Placeholder = Color3.fromHex("#78716c"),
  Background = Color3.fromHex("#0a0a0a"),
  Button = Color3.fromHex("#44403c"),
  Icon = Color3.fromHex("#bbf7d0"),
})

windUI:AddTheme({
  Name = "Purple Haze",
  Accent = Color3.fromHex("#581c87"),
  Dialog = Color3.fromHex("#18181b"),
  Outline = Color3.fromHex("#a855f7"),
  Text = Color3.fromHex("#faf5ff"),
  Placeholder = Color3.fromHex("#71717a"),
  Background = Color3.fromHex("#09090b"),
  Button = Color3.fromHex("#3f3f46"),
  Icon = Color3.fromHex("#d8b4fe"),
})

windUI:AddTheme({
  Name = "Ocean Depths",
  Accent = Color3.fromHex("#164e63"),
  Dialog = Color3.fromHex("#0c4a6e"),
  Outline = Color3.fromHex("#0ea5e9"),
  Text = Color3.fromHex("#f0f9ff"),
  Placeholder = Color3.fromHex("#7dd3fc"),
  Background = Color3.fromHex("#082f49"),
  Button = Color3.fromHex("#075985"),
  Icon = Color3.fromHex("#bae6fd"),
})

windUI:AddTheme({
  Name = "Sunset Orange",
  Accent = Color3.fromHex("#7c2d12"),
  Dialog = Color3.fromHex("#1c1917"),
  Outline = Color3.fromHex("#ea580c"),
  Text = Color3.fromHex("#fff7ed"),
  Placeholder = Color3.fromHex("#78716c"),
  Background = Color3.fromHex("#0a0a0a"),
  Button = Color3.fromHex("#44403c"),
  Icon = Color3.fromHex("#fed7aa"),
})

windUI:AddTheme({
  Name = "Rose Pink",
  Accent = Color3.fromHex("#881337"),
  Dialog = Color3.fromHex("#1c1917"),
  Outline = Color3.fromHex("#f43f5e"),
  Text = Color3.fromHex("#fff1f2"),
  Placeholder = Color3.fromHex("#78716c"),
  Background = Color3.fromHex("#0a0a0a"),
  Button = Color3.fromHex("#44403c"),
  Icon = Color3.fromHex("#fda4af"),
})

windUI:AddTheme({
  Name = "Cyber Yellow",
  Accent = Color3.fromHex("#713f12"),
  Dialog = Color3.fromHex("#1c1917"),
  Outline = Color3.fromHex("#eab308"),
  Text = Color3.fromHex("#fefce8"),
  Placeholder = Color3.fromHex("#78716c"),
  Background = Color3.fromHex("#0a0a0a"),
  Button = Color3.fromHex("#44403c"),
  Icon = Color3.fromHex("#fde047"),
})

windUI:AddTheme({
  Name = "Arctic White",
  Accent = Color3.fromHex("#e5e7eb"),
  Dialog = Color3.fromHex("#f3f4f6"),
  Outline = Color3.fromHex("#6b7280"),
  Text = Color3.fromHex("#111827"),
  Placeholder = Color3.fromHex("#9ca3af"),
  Background = Color3.fromHex("#ffffff"),
  Button = Color3.fromHex("#d1d5db"),
  Icon = Color3.fromHex("#4b5563"),
})

windUI:AddTheme({
  Name = "Neon Teal",
  Accent = Color3.fromHex("#134e4a"),
  Dialog = Color3.fromHex("#1c1917"),
  Outline = Color3.fromHex("#14b8a6"),
  Text = Color3.fromHex("#f0fdfa"),
  Placeholder = Color3.fromHex("#78716c"),
  Background = Color3.fromHex("#0a0a0a"),
  Button = Color3.fromHex("#44403c"),
  Icon = Color3.fromHex("#5eead4"),
})

windUI:AddTheme({
  Name = "Tokyo",
  Accent = Color3.fromHex("#e01b24"),
  Dialog = Color3.fromHex("#1a1a2e"),
  Outline = Color3.fromHex("#ff6b9d"),
  Text = Color3.fromHex("#eaeaea"),
  Placeholder = Color3.fromHex("#6c757d"),
  Background = Color3.fromHex("#0f0f1e"),
  Button = Color3.fromHex("#16213e"),
  Icon = Color3.fromHex("#c9184a"),
})

windUI:AddTheme({
  Name = "Ubuntu",
  Accent = Color3.fromHex("#e95420"),
  Dialog = Color3.fromHex("#2c2c2c"),
  Outline = Color3.fromHex("#ff7f50"),
  Text = Color3.fromHex("#f5f5f5"),
  Placeholder = Color3.fromHex("#999999"),
  Background = Color3.fromHex("#1a1a1a"),
  Button = Color3.fromHex("#3d3d3d"),
  Icon = Color3.fromHex("#dd4814"),
})

windUI:AddTheme({
  Name = "Linux Mint",
  Accent = Color3.fromHex("#87c442"),
  Dialog = Color3.fromHex("#2b2b2b"),
  Outline = Color3.fromHex("#9bdb4d"),
  Text = Color3.fromHex("#f5f5f5"),
  Placeholder = Color3.fromHex("#808080"),
  Background = Color3.fromHex("#1a1a1a"),
  Button = Color3.fromHex("#353535"),
  Icon = Color3.fromHex("#6fa22e"),
})

windUI:AddTheme({
  Name = "Vaporwave",
  Accent = Color3.fromHex("#ff71ce"),
  Dialog = Color3.fromHex("#261447"),
  Outline = Color3.fromHex("#01cdfe"),
  Text = Color3.fromHex("#fffb96"),
  Placeholder = Color3.fromHex("#b967ff"),
  Background = Color3.fromHex("#0e0032"),
  Button = Color3.fromHex("#3d1f5c"),
  Icon = Color3.fromHex("#05ffa1"),
})

windUI:AddTheme({
  Name = "Dracula",
  Accent = Color3.fromHex("#bd93f9"),
  Dialog = Color3.fromHex("#44475a"),
  Outline = Color3.fromHex("#ff79c6"),
  Text = Color3.fromHex("#f8f8f2"),
  Placeholder = Color3.fromHex("#6272a4"),
  Background = Color3.fromHex("#282a36"),
  Button = Color3.fromHex("#44475a"),
  Icon = Color3.fromHex("#8be9fd"),
})

windUI:AddTheme({
  Name = "Nord",
  Accent = Color3.fromHex("#88c0d0"),
  Dialog = Color3.fromHex("#3b4252"),
  Outline = Color3.fromHex("#81a1c1"),
  Text = Color3.fromHex("#eceff4"),
  Placeholder = Color3.fromHex("#4c566a"),
  Background = Color3.fromHex("#2e3440"),
  Button = Color3.fromHex("#434c5e"),
  Icon = Color3.fromHex("#5e81ac"),
})

windUI:AddTheme({
  Name = "Monokai",
  Accent = Color3.fromHex("#f92672"),
  Dialog = Color3.fromHex("#3e3d32"),
  Outline = Color3.fromHex("#66d9ef"),
  Text = Color3.fromHex("#f8f8f2"),
  Placeholder = Color3.fromHex("#75715e"),
  Background = Color3.fromHex("#272822"),
  Button = Color3.fromHex("#49483e"),
  Icon = Color3.fromHex("#a6e22e"),
})

windUI:AddTheme({
  Name = "Synthwave",
  Accent = Color3.fromHex("#ff007c"),
  Dialog = Color3.fromHex("#241b2f"),
  Outline = Color3.fromHex("#00d9ff"),
  Text = Color3.fromHex("#f0f0ff"),
  Placeholder = Color3.fromHex("#5a4d73"),
  Background = Color3.fromHex("#1a1423"),
  Button = Color3.fromHex("#352845"),
  Icon = Color3.fromHex("#ffd000"),
})

windUI:AddTheme({
  Name = "Gruvbox Dark",
  Accent = Color3.fromHex("#d79921"),
  Dialog = Color3.fromHex("#3c3836"),
  Outline = Color3.fromHex("#fabd2f"),
  Text = Color3.fromHex("#ebdbb2"),
  Placeholder = Color3.fromHex("#928374"),
  Background = Color3.fromHex("#282828"),
  Button = Color3.fromHex("#504945"),
  Icon = Color3.fromHex("#b8bb26"),
})

windUI:AddTheme({
  Name = "Cyberpunk",
  Accent = Color3.fromHex("#fcee09"),
  Dialog = Color3.fromHex("#2a1d4a"),
  Outline = Color3.fromHex("#00ffc8"),
  Text = Color3.fromHex("#ffffff"),
  Placeholder = Color3.fromHex("#a855f7"),
  Background = Color3.fromHex("#0d0221"),
  Button = Color3.fromHex("#3d2b5f"),
  Icon = Color3.fromHex("#ff007f"),
})

windUI:AddTheme({
  Name = "Matrix",
  Accent = Color3.fromHex("#00ff41"),
  Dialog = Color3.fromHex("#0d1a0d"),
  Outline = Color3.fromHex("#39ff14"),
  Text = Color3.fromHex("#00ff41"),
  Placeholder = Color3.fromHex("#0d4d0d"),
  Background = Color3.fromHex("#000000"),
  Button = Color3.fromHex("#003300"),
  Icon = Color3.fromHex("#00ff41"),
})

windUI:AddTheme({
  Name = "Sunset Vibes",
  Accent = Color3.fromHex("#ff6b35"),
  Dialog = Color3.fromHex("#2c1810"),
  Outline = Color3.fromHex("#f7931e"),
  Text = Color3.fromHex("#fff5e1"),
  Placeholder = Color3.fromHex("#8b4513"),
  Background = Color3.fromHex("#1a0f0a"),
  Button = Color3.fromHex("#3d2314"),
  Icon = Color3.fromHex("#ffa500"),
})

windUI:AddTheme({
  Name = "Coral Reef",
  Accent = Color3.fromHex("#ff6f61"),
  Dialog = Color3.fromHex("#1a3a52"),
  Outline = Color3.fromHex("#4ecdc4"),
  Text = Color3.fromHex("#f7fff7"),
  Placeholder = Color3.fromHex("#5b8fa3"),
  Background = Color3.fromHex("#0f2027"),
  Button = Color3.fromHex("#2c5364"),
  Icon = Color3.fromHex("#ffe66d"),
})

local combatSection = window:Section({ Title = "Combat", Icon = "crosshair", Opened = true })

local aimbotTab = combatSection:Tab({ Title = "Aimbot", Icon = "target" })
aimbotTab:Section({ Title = "Aimbot" })

local v2 = 100
local v3 = false
local targetPart = "HumanoidRootPart"
local targets = "All"
local aimbotKeybind = "V"
local wallCheck = true

local circle = Drawing.new("Circle")
circle.Thickness = 2
circle.NumSides = 100
circle.Radius = v2
circle.Filled = false
circle.Visible = false
circle.Color = Color3.fromRGB(255, 255, 255)
circle.Transparency = 1

local aimbotToggle = aimbotTab:Toggle({
  Title = "Aimbot",
  Type = "Checkbox",
  Value = false,
  Callback = function(value)
    v3 = value
    circle.Visible = value
  end,
})

aimbotTab:Keybind({
  Title = "Aimbot Keybind",
  Desc = "Keybind to toggle Aimbot",
  Value = aimbotKeybind,
  Callback = function(value2) aimbotKeybind = value2 end,
})

aimbotTab:Toggle({
  Title = "Wall Check",
  Type = "Checkbox",
  Value = true,
  Callback = function(value3) wallCheck = value3 end,
})

aimbotTab:Dropdown({
  Title = "Target Part",
  Values = { "HumanoidRootPart", "Head" },
  AllowNone = false,
  Callback = function(value4) targetPart = value4 or "HumanoidRootPart" end,
})

aimbotTab:Dropdown({
  Title = "Targets",
  Values = { "All", "Inmates", "Criminals", "Guards" },
  AllowNone = false,
  Callback = function(value5) targets = value5 or "All" end,
})

aimbotTab:Section({ Title = "FOV Circle" })

aimbotTab:Slider({
  Title = "FOV Circle Size",
  Step = 5,
  Value = { Min = 50, Max = 500, Default = 100 },
  Callback = function(value6)
    v2 = tonumber(value6) or 100
    circle.Radius = tonumber(value6) or 100
  end,
})

aimbotTab:Slider({
  Title = "FOV Circle Thickness",
  Step = 1,
  Value = { Min = 1, Max = 10, Default = 2 },
  Callback = function(value7) circle.Thickness = tonumber(value7) or 2 end,
})

aimbotTab:Colorpicker({
  Title = "FOV Circle Color",
  Desc = "Change FOV Circle Color",
  Default = Color3.fromRGB(255, 255, 255),
  Callback = function(value8) circle.Color = value8 end,
})

runService.RenderStepped:Connect(function()
  if v3 then
    local getMouseLocation = userInputService:GetMouseLocation()
    circle.Position = Vector2.new(getMouseLocation.X, getMouseLocation.Y)
    circle.Visible = true
  else
    circle.Visible = false
  end
end)

local function f1(p1)
  if not wallCheck then
    return true
  else
    local position = currentCamera.CFrame.Position
    local position2 = p1.Position

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, p1.Parent }
    raycastParams.IgnoreWater = true

    local raycast = workspace:Raycast(position, position2 - position, raycastParams)

    if not raycast then
      return true
    end

    return raycast.Instance:IsDescendantOf(p1.Parent)
  end
end

local function f2()
  if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
    return nil
  else
    local v4 = nil
    local huge = math.huge

    for key, value9 in pairs(players:GetPlayers()) do
      if value9 ~= localPlayer and value9.Character
        and value9.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = value9.Character:FindFirstChild("Humanoid")

        if humanoid and humanoid.Health > 0 then
          local findFirstChild = value9.Character:FindFirstChild(targetPart)

          if findFirstChild then
            local v5 = false

            if targets == "All" then
              v5 = true
            elseif targets == "Inmates" and value9.Team and value9.Team.Name == "Inmates" then
              v5 = true
            elseif targets == "Criminals" and value9.Team and value9.Team.Name == "Criminals" then
              v5 = true
            elseif targets == "Guards" and value9.Team and value9.Team.Name == "Guards" then
              v5 = true
            end

            if v5 and f1(findFirstChild) then
              local v6, v7 = currentCamera:WorldToViewportPoint(findFirstChild.Position)
              local viewportSize = currentCamera.ViewportSize

              if v7 and v6.Z > 0 and v6.X >= 0 and v6.X <= viewportSize.X and v6.Y >= 0
                and v6.Y <= viewportSize.Y then
                local getMouseLocation2 = userInputService:GetMouseLocation()

                local v8 = math.sqrt((v6.X - getMouseLocation2.X) ^ 2
                  + (v6.Y - getMouseLocation2.Y) ^ 2)

                if v8 < v2 and v8 < huge then
                  v4 = findFirstChild
                  huge = v8
                end
              end
            end
          end
        end
      end
    end

    return v4
  end
end

runService.RenderStepped:Connect(function()
  local humanoidRootPart2 = v3 and localPlayer.Character
    and localPlayer.Character:FindFirstChild("HumanoidRootPart")

  local v9, v10

  if humanoidRootPart2 then
    local v11 = f2()

    if v11 then
      local v12, v13 = currentCamera:WorldToViewportPoint(v11.Position)
      local viewportSize2 = currentCamera.ViewportSize

      if v13 and v12.Z > 0 and v12.X >= 0 and v12.X <= viewportSize2.X and v12.Y >= 0
        and v12.Y <= viewportSize2.Y then
        local getMouseLocation3 = userInputService:GetMouseLocation()
        v9 = v12.X - getMouseLocation3.X
        v10 = v12.Y - getMouseLocation3.Y

        if mousemoverel then
          pcall(function() mousemoverel(v9, v10) end)
        end
      end
    end
  end
end)

userInputService.InputBegan:Connect(function(input, p2)
  if p2 then
    return
  end

  if input.KeyCode == Enum.KeyCode[aimbotKeybind] then
    v3 = not v3
    aimbotToggle:Set(v3)
    circle.Visible = v3
  end
end)

local triggerBotTab = combatSection:Tab({ Title = "TriggerBot", Icon = "zap" })
triggerBotTab:Section({ Title = "TriggerBot" })

local v14 = false
local shootDelay = 0.1
local v15 = 0

local function f3()
  local v16 = tick()

  if v16 - v15 < shootDelay then
    return
  end

  mouse1click()
  v15 = v16
end

local function f4()
  if not localPlayer.Character then
    return nil
  else
    local target = localPlayer:GetMouse().Target

    if target then
      local getPlayerFromCharacter = players:GetPlayerFromCharacter(target.Parent)

      if getPlayerFromCharacter and getPlayerFromCharacter ~= localPlayer then
        local humanoid2 = getPlayerFromCharacter.Character
          and getPlayerFromCharacter.Character:FindFirstChild("Humanoid")

        if humanoid2 and humanoid2.Health > 0 then
          if targets == "All" then
            return getPlayerFromCharacter
          end

          if targets == "Inmates" and getPlayerFromCharacter.Team
            and getPlayerFromCharacter.Team.Name == "Inmates" then
            return getPlayerFromCharacter
          end

          if targets == "Criminals" and getPlayerFromCharacter.Team
            and getPlayerFromCharacter.Team.Name == "Criminals" then
            return getPlayerFromCharacter
          end

          if targets == "Guards" and getPlayerFromCharacter.Team
            and getPlayerFromCharacter.Team.Name == "Guards" then
            return getPlayerFromCharacter
          end

          return nil
        end

        return nil
      end

      return nil
    end

    return nil
  end
end

local connect = nil

local function f5()
  if connect then
    connect:Disconnect()
    connect = nil
  end
end

local function f6()
  if connect then
    connect:Disconnect()
  end

  connect = runService.RenderStepped:Connect(function()
    if not v14 then
      return
    end

    if f4() then
      f3()
    end
  end)
end

triggerBotTab:Toggle({
  Title = "TriggerBot On/Off",
  Desc = "Automatically shoot when hovering over players",
  Type = "Checkbox",
  Value = false,
  Callback = function(value10)
    v14 = value10

    if value10 then
      f6()
    else
      f5()
    end
  end,
})

triggerBotTab:Slider({
  Title = "Shoot Delay",
  Desc = "Delay between shots in seconds",
  Step = 0.01,
  Value = { Min = 0.01, Max = 1, Default = 0.1 },
  Callback = function(value11) shootDelay = tonumber(value11) or 0.1 end,
})

triggerBotTab:Paragraph({
  Title = "Note",
  Desc = "TriggerBot uses the same target filters as Aimbot. Make sure you have a gun equipped for this to work.",
})

local allTab = combatSection:Tab({ Title = "All", Icon = "crown" })
allTab:Section({ Title = "Mass Actions" })

allTab:Button({
  Title = "Arrest All",
  Desc = "Arrest all criminals (Guards only)",
  Callback = function()
    local arrestPlayer = replicatedStorage:WaitForChild("Remotes"):WaitForChild("ArrestPlayer")
    local character = localPlayer.Character

    if character and character:FindFirstChild("HumanoidRootPart") then
      local cframe2 = character.HumanoidRootPart.CFrame

      for key2, value12 in pairs(players:GetPlayers()) do
        local v17 = value12

        if v17 ~= localPlayer and v17.Team and v17.Team.Name == "Criminals" then
          local character2 = v17.Character

          if character2 and character and character2:FindFirstChild("HumanoidRootPart")
            and character:FindFirstChild("HumanoidRootPart") then
            print("Attempting to arrest:", v17.Name)
            local v18 = tick()
            local v19 = false

            while tick() - v18 < 3 and not v19 do
              if not character2 or not character2:FindFirstChild("HumanoidRootPart")
                or not character or not character:FindFirstChild("HumanoidRootPart") then
                break
              end

              character.HumanoidRootPart.CFrame = character2.HumanoidRootPart.CFrame
                * CFrame.new(0, 0, 2)

              if pcall(function() return arrestPlayer:InvokeServer(v17) end) then
                print("Successfully arrested:", v17.Name)
                v19 = true
                break
              end

              task.wait(0.1)
            end

            if not v19 then
              print("Failed to arrest:", v17.Name)
            end

            task.wait(0.2)
          end
        end
      end

      if character and character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = cframe2
        print("Arrest sequence complete. Returned to original position.")
      end
    end
  end,
})

allTab:Paragraph({
  Title = "Note",
  Desc = "This feature only works if you're on the Guards team. It will continuously follow each criminal until arrested, then move to the next.",
})

local hitboxExpanderTab = combatSection:Tab({ Title = "Hitbox Expander", Icon = "box" })
hitboxExpanderTab:Section({ Title = "Hitbox Expander" })

_G.HeadSize = 15
_G.Disabled = false
_G.HitboxTransparency = 0.7
_G.HitboxColor = Color3.fromRGB(0, 255, 0)

local connect2

local function f7()
  if connect2 then
    connect2:Disconnect()
  end

  connect2 = runService.RenderStepped:Connect(function()
    if _G.Disabled then
      for key3, value13 in pairs(players:GetPlayers()) do
        local v20 = value13

        if v20.Name ~= localPlayer.Name then
          pcall(function()
            local humanoidRootPart3 = v20.Character
              and v20.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart3 then
              humanoidRootPart3.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
              humanoidRootPart3.Transparency = _G.HitboxTransparency
              humanoidRootPart3.Color = _G.HitboxColor
              humanoidRootPart3.Material = Enum.Material.Neon
              humanoidRootPart3.CanCollide = false
            end
          end)
        end
      end
    end
  end)
end

local function f8()
  _G.Disabled = false

  if connect2 then
    connect2:Disconnect()
    connect2 = nil
  end

  for key4, value14 in pairs(players:GetPlayers()) do
    local v21 = value14

    if v21.Name ~= localPlayer.Name then
      pcall(function()
        local humanoidRootPart4 = v21.Character
          and v21.Character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart4 then
          humanoidRootPart4.Size = Vector3.new(2, 2, 1)
          humanoidRootPart4.Transparency = 1
          humanoidRootPart4.BrickColor = BrickColor.new("Medium stone grey")
          humanoidRootPart4.Material = Enum.Material.Plastic
          humanoidRootPart4.CanCollide = true
        end
      end)
    end
  end
end

hitboxExpanderTab:Toggle({
  Title = "Hitbox Expander On/Off",
  Desc = "Enable/Disables Hitbox Expander",
  Icon = "box",
  Value = false,
  Callback = function(value15)
    if value15 == false then
      f8()
    else
      _G.Disabled = true
      f7()
    end
  end,
})

hitboxExpanderTab:Slider({
  Title = "Hitbox Size",
  Desc = "Changes Hitbox Size",
  Step = 1,
  Value = { Min = 1, Max = 50, Default = 15 },
  Callback = function(value16) _G.HeadSize = tonumber(value16) or 15 end,
})

hitboxExpanderTab:Slider({
  Title = "Hitbox Transparency",
  Desc = "Changes Hitbox Opacity",
  Step = 0.1,
  Value = { Min = 0.1, Max = 1, Default = 0.7 },
  Callback = function(value17) _G.HitboxTransparency = value17 end,
})

hitboxExpanderTab:Colorpicker({
  Title = "Hitbox Expander Color",
  Desc = "Change Hitbox Color",
  Default = Color3.fromRGB(0, 255, 0),
  Callback = function(value18) _G.HitboxColor = value18 end,
})

window:Divider()
local visualsSection = window:Section({ Title = "Visuals", Icon = "eye", Opened = true })

local espTab = visualsSection:Tab({ Title = "ESP", Icon = "scan" })
espTab:Section({ Title = "ESP Settings" })

local boxESP = false
local chamESP = false
local v22 = {}
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(255, 0, 0)
local espGuards = true

local function f9(p3)
  if p3 then
    for key5, value19 in pairs(v22) do
      if string.find(key5, tostring(p3)) then
        if value19.Remove then
          value19:Remove()
        elseif value19.Destroy then
          value19:Destroy()
        end

        v22[key5] = nil
      end
    end
  else
    for key6, value20 in pairs(v22) do
      if value20 and value20.Remove then
        value20:Remove()
      elseif value20 and value20.Destroy then
        value20:Destroy()
      end
    end

    v22 = {}
  end
end

local espInmates = true

local function f10()
  local square = Drawing.new("Square")
  square.Visible = false
  square.Color = color
  square.Thickness = 2
  square.Transparency = 1
  square.Filled = false

  return square
end

local espCriminals = true

local function f11(p4)
  local highlight = Instance.new("Highlight")
  highlight.Adornee = p4
  highlight.FillColor = color2
  highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
  highlight.FillTransparency = 0.5
  highlight.OutlineTransparency = 0
  highlight.Parent = p4

  return highlight
end

local f12

local function f13()
  for key7, value21 in pairs(players:GetPlayers()) do
    if value21 ~= localPlayer and value21.Character then
      local character3 = value21.Character
      local humanoidRootPart5 = character3:FindFirstChild("HumanoidRootPart")
      local humanoid3 = character3:FindFirstChild("Humanoid")
      local v23 = humanoidRootPart5
      local head = character3:FindFirstChild("Head")

      if humanoidRootPart5 then
        v23 = humanoid3 and humanoid3.Health > 0 and head
      end

      if v23 then
        if not f12(value21) then
          f9(value21.UserId)
        else
          if boxESP then
            if not v22[value21.UserId .. "_box"] then
              v22[value21.UserId .. "_box"] = f10()
            end

            local v24 = v22[value21.UserId .. "_box"]
            local v25, v26 = currentCamera:WorldToViewportPoint(humanoidRootPart5.Position)

            local worldToViewportPoint = currentCamera:WorldToViewportPoint(head.Position + Vector3.new(
              0, 0.5, 0
            ))

            local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(humanoidRootPart5.Position
              - Vector3.new(0, 3, 0))

            if v26 and worldToViewportPoint.Z > 0 and worldToViewportPoint2.Z > 0 then
              local v27 = math.abs(worldToViewportPoint.Y - worldToViewportPoint2.Y)
              local v28 = v27 / 2

              v24.Size = Vector2.new(v28, v27)
              v24.Position = Vector2.new(v25.X - v28 / 2, worldToViewportPoint.Y)
              v24.Color = color
              v24.Visible = true
            else
              v24.Visible = false
            end
          elseif v22[value21.UserId .. "_box"] then
            v22[value21.UserId .. "_box"]:Remove()
            v22[value21.UserId .. "_box"] = nil
          end

          if chamESP then
            if not v22[value21.UserId .. "_cham"] then
              v22[value21.UserId .. "_cham"] = f11(character3)
            else
              local v29 = v22[value21.UserId .. "_cham"]

              if v29 then
                v29.FillColor = color2
              end
            end
          elseif v22[value21.UserId .. "_cham"] then
            v22[value21.UserId .. "_cham"]:Destroy()
            v22[value21.UserId .. "_cham"] = nil
          end
        end
      else
        f9(value21.UserId)
      end
    end
  end
end

function f12(p5)
  if not p5.Team then
    return true
  else
    local name = p5.Team.Name

    if name == "Guards" and not espGuards then
      return false
    end

    if name == "Inmates" and not espInmates then
      return false
    end

    if name == "Criminals" and not espCriminals then
      return false
    end

    return true
  end
end

espTab:Toggle({
  Title = "Box ESP",
  Type = "Checkbox",
  Value = false,
  Callback = function(value22)
    boxESP = value22

    if not value22 then
      for key8, value23 in pairs(v22) do
        if string.find(key8, "_box") and value23.Remove then
          value23:Remove()
          v22[key8] = nil
        end
      end
    end
  end,
})

espTab:Colorpicker({
  Title = "Box ESP Color",
  Desc = "Change Box ESP Color",
  Default = Color3.fromRGB(255, 255, 255),
  Callback = function(value24) color = value24 end,
})

espTab:Toggle({
  Title = "Cham ESP",
  Type = "Checkbox",
  Value = false,
  Callback = function(value25)
    chamESP = value25

    if not value25 then
      for key9, value26 in pairs(v22) do
        if string.find(key9, "_cham") and value26.Destroy then
          value26:Destroy()
          v22[key9] = nil
        end
      end
    end
  end,
})

espTab:Colorpicker({
  Title = "Cham ESP Color",
  Desc = "Change Cham ESP Color",
  Default = Color3.fromRGB(255, 0, 0),
  Callback = function(value27) color2 = value27 end,
})

espTab:Section({ Title = "Team Filters" })

espTab:Toggle({
  Title = "ESP Guards",
  Type = "Checkbox",
  Value = true,
  Callback = function(value28)
    espGuards = value28

    if not value28 then
      for key10, value29 in pairs(players:GetPlayers()) do
        if value29.Team and value29.Team.Name == "Guards" then
          f9(value29.UserId)
        end
      end
    end
  end,
})

espTab:Toggle({
  Title = "ESP Inmates",
  Type = "Checkbox",
  Value = true,
  Callback = function(value30)
    espInmates = value30

    if not value30 then
      for key11, value31 in pairs(players:GetPlayers()) do
        if value31.Team and value31.Team.Name == "Inmates" then
          f9(value31.UserId)
        end
      end
    end
  end,
})

espTab:Toggle({
  Title = "ESP Criminals",
  Type = "Checkbox",
  Value = true,
  Callback = function(value32)
    espCriminals = value32

    if not value32 then
      for key12, value33 in pairs(players:GetPlayers()) do
        if value33.Team and value33.Team.Name == "Criminals" then
          f9(value33.UserId)
        end
      end
    end
  end,
})

local tracersTab = visualsSection:Tab({ Title = "Tracers", Icon = "git-branch" })
tracersTab:Section({ Title = "Tracer Settings" })

local enableTracers = false
local color3 = Color3.fromRGB(255, 255, 0)
local tracerThickness = 2

local function f14()
  local line = Drawing.new("Line")
  line.Visible = false
  line.Color = color3
  line.Thickness = tracerThickness
  line.Transparency = 1

  return line
end

local tracerTarget = "All"
local v30 = {}
local traceGuards = true

local function f15(p6)
  if p6 then
    for key13, value34 in pairs(v30) do
      if string.find(key13, tostring(p6)) then
        if value34.Remove then
          value34:Remove()
        end

        v30[key13] = nil
      end
    end
  else
    for key14, value35 in pairs(v30) do
      if value35 and value35.Remove then
        value35:Remove()
      end
    end

    v30 = {}
  end
end

local traceInmates = true
local traceCriminals = true
local f16

local function f17()
  for key15, value36 in pairs(players:GetPlayers()) do
    if value36 ~= localPlayer and value36.Character then
      local character4 = value36.Character
      local humanoidRootPart6 = character4:FindFirstChild("HumanoidRootPart")
      local humanoid4 = character4:FindFirstChild("Humanoid")

      if humanoidRootPart6 and humanoid4 and humanoid4.Health > 0 then
        if enableTracers and f16(value36) then
          if not v30[value36.UserId .. "_tracer"] then
            v30[value36.UserId .. "_tracer"] = f14()
          end

          local v31 = v30[value36.UserId .. "_tracer"]
          local character5 = localPlayer.Character

          if character5 then
            local head2 = character5:FindFirstChild("Head")

            if head2 then
              local v32, v33 = currentCamera:WorldToViewportPoint(head2.Position)
              local v34, v35 = currentCamera:WorldToViewportPoint(humanoidRootPart6.Position)

              if v35 then
                v31.From = Vector2.new(v32.X, v32.Y)
                v31.To = Vector2.new(v34.X, v34.Y)
                v31.Color = color3
                v31.Thickness = tracerThickness
                v31.Visible = true
              else
                v31.Visible = false
              end
            end
          end
        else
          f15(value36.UserId)
        end
      end
    end
  end
end

function f16(p7)
  if not p7.Team then
    return tracerTarget == "All"
  else
    local name2 = p7.Team.Name

    if name2 == "Guards" and not traceGuards then
      return false
    end

    if name2 == "Inmates" and not traceInmates then
      return false
    end

    if name2 == "Criminals" and not traceCriminals then
      return false
    end

    if tracerTarget == "All" then
      return true
    end

    if tracerTarget == "Guards" and name2 == "Guards" then
      return true
    end

    if tracerTarget == "Inmates" and name2 == "Inmates" then
      return true
    end

    if tracerTarget == "Criminals" and name2 == "Criminals" then
      return true
    end

    return false
  end
end

tracersTab:Toggle({
  Title = "Enable Tracers",
  Type = "Checkbox",
  Value = false,
  Callback = function(value37)
    enableTracers = value37

    if not value37 then
      f15()
    end
  end,
})

tracersTab:Dropdown({
  Title = "Tracer Target",
  Values = { "All", "Inmates", "Criminals", "Guards" },
  AllowNone = false,
  Callback = function(value38) tracerTarget = value38 or "All" end,
})

tracersTab:Colorpicker({
  Title = "Tracer Color",
  Desc = "Change Tracer Color",
  Default = Color3.fromRGB(255, 255, 0),
  Callback = function(value39) color3 = value39 end,
})

tracersTab:Slider({
  Title = "Tracer Thickness",
  Step = 1,
  Value = { Min = 1, Max = 10, Default = 2 },
  Callback = function(value40) tracerThickness = tonumber(value40) or 2 end,
})

tracersTab:Section({ Title = "Team Filters" })

tracersTab:Toggle({
  Title = "Trace Guards",
  Type = "Checkbox",
  Value = true,
  Callback = function(value41)
    traceGuards = value41

    if not value41 then
      for key16, value42 in pairs(players:GetPlayers()) do
        if value42.Team and value42.Team.Name == "Guards" then
          f15(value42.UserId)
        end
      end
    end
  end,
})

tracersTab:Toggle({
  Title = "Trace Inmates",
  Type = "Checkbox",
  Value = true,
  Callback = function(value43)
    traceInmates = value43

    if not value43 then
      for key17, value44 in pairs(players:GetPlayers()) do
        if value44.Team and value44.Team.Name == "Inmates" then
          f15(value44.UserId)
        end
      end
    end
  end,
})

tracersTab:Toggle({
  Title = "Trace Criminals",
  Type = "Checkbox",
  Value = true,
  Callback = function(value45)
    traceCriminals = value45

    if not value45 then
      for key18, value46 in pairs(players:GetPlayers()) do
        if value46.Team and value46.Team.Name == "Criminals" then
          f15(value46.UserId)
        end
      end
    end
  end,
})

runService.RenderStepped:Connect(function()
  if boxESP or chamESP then
    f13()
  end

  if enableTracers then
    f17()
  end
end)

players.PlayerRemoving:Connect(function(player)
  f9(player.UserId)
  f15(player.UserId)
end)

window:Divider()

local loadoutTab = window:Tab({ Title = "Loadout", Icon = "axe" })
loadoutTab:Section({ Title = "Weapon Collection" })

loadoutTab:Paragraph({
  Title = "Weapon Equip",
  Desc = "Teleport to weapon spawns to quickly equip items. Select a weapon and click Equip Item.",
})

local chooseWeapon

loadoutTab:Dropdown({
  Title = "Choose Weapon",
  Values = { "M9", "Remington 870", "AK-47" },
  Multi = false,
  Callback = function(value47) chooseWeapon = value47 end,
})

loadoutTab:Button({
  Title = "Equip Item",
  Callback = function()
    if chooseWeapon == "M9" then
      v1.equip(CFrame.new(813.69866943359, 97.850006103516, 2217.3962402344))
    elseif chooseWeapon == "Remington 870" then
      v1.equip(CFrame.new(820.29858398438, 97.850006103516, 2217.3962402344))
    elseif chooseWeapon == "AK-47" then
      v1.equip(CFrame.new(-922.31268310547, 91.278282165527, 2051.9536132812))
    end
  end,
})

local physicalTab = window:Tab({ Title = "Physical", Icon = "atom" })
physicalTab:Section({ Title = "World Modifications" })

physicalTab:Paragraph({
  Title = "Map Editor",
  Desc = "Remove doors, gates, and teleport around the map. These changes affect your client only.",
})

physicalTab:Button({
  Title = "Remove All KeyCard Doors",
  Callback = function()
    for index, value48 in ipairs(workspace:GetDescendants()) do
      local name3 = value48.Name

      if string.find(name3:lower(), "door_v3", 1, true) then
        pcall(value48.Destroy, value48)
      end
    end
  end,
})

physicalTab:Button({
  Title = "Remove All Cell Gates",
  Callback = function()
    for index2, value49 in ipairs(workspace:GetDescendants()) do
      local name4 = value49.Name

      if string.find(name4:lower(), "CellDoors", 1, true) then
        pcall(value49.Destroy, value49)
      end
    end
  end,
})

physicalTab:Button({
  Title = "TP Inside Prison",
  Callback = function()
    local character6 = localPlayer.Character

    if character6 then
      local humanoidRootPart7 = character6:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart7 then
        humanoidRootPart7.CFrame = CFrame.new(702.549927, 99.9000092, 2247.06055)
      end
    end
  end,
})

physicalTab:Button({
  Title = "TP To Criminal Base",
  Callback = function()
    local character7 = localPlayer.Character

    if character7 then
      local humanoidRootPart8 = character7:FindFirstChild("HumanoidRootPart")

      if humanoidRootPart8 then
        humanoidRootPart8.CFrame = CFrame.new(-897.12, 93.3, 2150.64)
      end
    end
  end,
})

local movementTab = window:Tab({ Title = "Movement", Icon = "footprints" })
movementTab:Section({ Title = "Movement Options" })

movementTab:Slider({
  Title = "Walk Speed",
  Desc = "Movement speed",
  Step = 1,
  Value = { Min = 16, Max = 200, Default = 16 },
  Callback = function(value50)
    local character8 = localPlayer.Character

    if character8 then
      local humanoid5 = character8:FindFirstChildWhichIsA("Humanoid")

      if humanoid5 then
        humanoid5.WalkSpeed = value50
      end
    end
  end,
})

movementTab:Slider({
  Title = "Jump Power",
  Desc = "Jump height",
  Step = 1,
  Value = { Min = 50, Max = 200, Default = 50 },
  Callback = function(value51)
    local character9 = localPlayer.Character

    if character9 then
      local humanoid6 = character9:FindFirstChildWhichIsA("Humanoid")

      if humanoid6 then
        humanoid6.UseJumpPower = true
        humanoid6.JumpPower = value51
      end
    end
  end,
})

movementTab:Space()
movementTab:Divider()

local noclip = false
local connect3 = nil

local function f18()
  if connect3 then
    connect3:Disconnect()
  end

  connect3 = runService.Stepped:Connect(function()
    if not noclip then
      return
    else
      local character10 = localPlayer.Character

      if character10 then
        for key19, value52 in pairs(character10:GetDescendants()) do
          if value52:IsA("BasePart") then
            value52.CanCollide = false
          end
        end
      end

      return
    end
  end)
end

local function f19()
  if connect3 then
    connect3:Disconnect()
    connect3 = nil
  end

  local character11 = localPlayer.Character

  if character11 then
    for key20, value53 in pairs(character11:GetDescendants()) do
      if value53:IsA("BasePart") then
        value53.CanCollide = true
      end
    end
  end
end

movementTab:Toggle({
  Title = "Noclip",
  Desc = "Walk through walls",
  Value = false,
  Callback = function(value54)
    noclip = value54

    if value54 then
      f18()
    else
      f19()
    end
  end,
})

movementTab:Space()
movementTab:Divider()

local v36 = false
local flightSpeed = 50
local flightKeybind = "G"

local v37 = {
  f = 0,
  b = 0,
  l = 0,
  r = 0,
  q = 0,
  e = 0,
}

local v38 = 0

local function f20(p8)
  local animation = Instance.new("Animation")
  animation.AnimationId = "rbxassetid://" .. p8
  return animation
end

local v39 = {
  idle = f20(507766388),
  forward = f20(507767714),
  backwards = f20(507767714),
  left = f20(507767714),
  right = f20(507767714),
}

local bodyGyro, bodyVelocity, connect4, loadAnimation

local function f21()
  v36 = false

  if connect4 then
    connect4:Disconnect()
    connect4 = nil
  end

  if loadAnimation then
    loadAnimation:Stop()
    loadAnimation = nil
  end

  local character12 = localPlayer.Character

  if character12 then
    local humanoid7 = character12:FindFirstChildWhichIsA("Humanoid")

    if humanoid7 then
      humanoid7.PlatformStand = false
    end

    if character12:FindFirstChild("Torso") or character12:FindFirstChild("UpperTorso") then
      if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
      end

      if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
      end
    end
  end

  v37 = {
    f = 0,
    b = 0,
    l = 0,
    r = 0,
    q = 0,
    e = 0,
  }

  v38 = 0
end

local function f22(p9)
  local character13 = localPlayer.Character

  if not character13 then
    return
  else
    local humanoid8 = character13:FindFirstChildWhichIsA("Humanoid")

    if not humanoid8 then
      return
    else
      if loadAnimation then
        loadAnimation:Stop()
        loadAnimation = nil
      end

      local v40 = v39[p9]

      if v40 then
        loadAnimation = humanoid8:LoadAnimation(v40)

        if loadAnimation then
          loadAnimation.Priority = Enum.AnimationPriority.Action
          loadAnimation:Play()
        end
      end

      return
    end
  end
end

local function f23()
  local character14 = localPlayer.Character

  if not character14 then
    return
  else
    local torso = character14:FindFirstChild("Torso")
      or character14:FindFirstChild("UpperTorso")

    if not torso or not character14:FindFirstChildWhichIsA("Humanoid") then
      return
    end

    v36 = true

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 90000
    bodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000)
    bodyGyro.cframe = torso.CFrame
    bodyGyro.Parent = torso

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.velocity = Vector3.new(0, 0, 0)
    bodyVelocity.maxForce = Vector3.new(9000000000, 9000000000, 9000000000)
    bodyVelocity.Parent = torso

    if connect4 then
      connect4:Disconnect()
    end

    connect4 = runService.Heartbeat:Connect(function()
      if not v36 then
        f21()
        return
      else
        local character15 = localPlayer.Character

        if not character15 then
          f21()
          return
        else
          local torso2 = character15:FindFirstChild("Torso")
            or character15:FindFirstChild("UpperTorso")

          local v41 = not torso2
          local humanoid9 = character15:FindFirstChildWhichIsA("Humanoid")

          if v41 or not humanoid9 or humanoid9.Health <= 0 then
            f21()
            return
          end

          if not bodyGyro or not bodyVelocity or bodyGyro.Parent ~= torso2
            or bodyVelocity.Parent ~= torso2 then
            f21()
            return
          else
            humanoid9.PlatformStand = true

            if v37.f + v37.b ~= 0 or v37.l + v37.r ~= 0 or v37.q + v37.e ~= 0 then
              v38 = flightSpeed
            else
              v38 = 0
            end

            if v37.f == 1 then
              f22("forward")
            elseif v37.b == 1 then
              f22("backwards")
            elseif v37.l == 1 then
              f22("left")
            elseif v37.r == 1 then
              f22("right")
            else
              f22("idle")
            end

            local coordinateFrame = workspace.CurrentCamera.CoordinateFrame
            local vector = Vector3.new(0, 0, 0)

            if v37.f == 1 then
              vector = vector + coordinateFrame.LookVector
            end

            if v37.b == 1 then
              vector = vector - coordinateFrame.LookVector
            end

            if v37.l == 1 then
              vector = vector - coordinateFrame.RightVector
            end

            if v37.r == 1 then
              vector = vector + coordinateFrame.RightVector
            end

            if v37.q == 1 then
              vector = vector + Vector3.new(0, 1, 0)
            end

            if v37.e == 1 then
              vector = vector - Vector3.new(0, 1, 0)
            end

            if vector.Magnitude > 0 then
              vector = vector.Unit
            end

            bodyVelocity.velocity = vector * v38
            bodyGyro.cframe = coordinateFrame
            return
          end
        end
      end
    end)

    return
  end
end

local flightToggle = movementTab:Toggle({
  Title = "Flight",
  Value = false,
  Callback = function(value55)
    if value55 then
      f23()
    else
      f21()
    end
  end,
})

movementTab:Keybind({
  Title = "Flight Keybind",
  Desc = "Keybind to toggle flight",
  Value = flightKeybind,
  Callback = function(value56) flightKeybind = value56 end,
})

movementTab:Slider({
  Title = "Flight Speed",
  Desc = "Flight velocity",
  Step = 1,
  Value = { Min = 10, Max = 200, Default = 50 },
  Callback = function(value57) flightSpeed = value57 end,
})

userInputService.InputBegan:Connect(function(input2, p10)
  if p10 or not v36 then
    return
  else
    local keyCode = input2.KeyCode

    if keyCode == Enum.KeyCode.W then
      v37.f = 1
    elseif keyCode == Enum.KeyCode.S then
      v37.b = 1
    elseif keyCode == Enum.KeyCode.A then
      v37.l = 1
    elseif keyCode == Enum.KeyCode.D then
      v37.r = 1
    elseif keyCode == Enum.KeyCode.Space then
      v37.q = 1
    elseif keyCode == Enum.KeyCode.LeftShift then
      v37.e = 1
    end

    return
  end
end)

userInputService.InputEnded:Connect(function(input3, p11)
  local keyCode2 = input3.KeyCode

  if keyCode2 == Enum.KeyCode.W then
    v37.f = 0
  elseif keyCode2 == Enum.KeyCode.S then
    v37.b = 0
  elseif keyCode2 == Enum.KeyCode.A then
    v37.l = 0
  elseif keyCode2 == Enum.KeyCode.D then
    v37.r = 0
  elseif keyCode2 == Enum.KeyCode.Space then
    v37.q = 0
  elseif keyCode2 == Enum.KeyCode.LeftShift then
    v37.e = 0
  elseif keyCode2 == Enum.KeyCode[flightKeybind] and not p11 then
    if v36 then
      flightToggle:Set(false)
    else
      flightToggle:Set(true)
    end
  end
end)

localPlayer.CharacterAdded:Connect(function(character16)
  f21()

  if noclip then
    task.wait(0.5)
    f18()
  end

  task.wait(1)
  character16:WaitForChild("HumanoidRootPart")
end)

window:Divider()

local settingsTab = window:Tab({ Title = "Settings", Icon = "cog", Locked = false })
settingsTab:Section({ Title = "Appearance", Box = false })

settingsTab:Dropdown({
  Title = "UI Theme",
  Desc = "Change the UI theme",
  Values = {
    "Dark", "Midnight Blue", "Crimson Red", "Forest Green", "Purple Haze", "Ocean Depths",
    "Sunset Orange", "Rose Pink", "Cyber Yellow", "Arctic White", "Neon Teal", "Tokyo",
    "Ubuntu", "Linux Mint", "Vaporwave", "Dracula", "Nord", "Monokai", "Synthwave",
    "Gruvbox Dark", "Cyberpunk", "Matrix", "Sunset Vibes", "Coral Reef",
  },
  AllowNone = false,
  Callback = function(value58) windUI:SetTheme(value58) end,
})

settingsTab:Slider({
  Title = "UI Transparency",
  Desc = "Change UI background transparency",
  Step = 0.05,
  Value = { Min = 0, Max = 1, Default = 0 },
  Callback = function(value59)
    windUI.TransparencyValue = tonumber(value59)

    if tonumber(value59) > 0 then
      window:ToggleTransparency(true)
    else
      window:ToggleTransparency(false)
    end
  end,
})

settingsTab:Space()
settingsTab:Section({ Title = "Toggle Key", Box = false })

settingsTab:Keybind({
  Title = "Keybind",
  Desc = "Keybind to open/close UI",
  Value = "H",
  Callback = function(value60) window:SetToggleKey(Enum.KeyCode[value60]) end,
})

settingsTab:Space()
settingsTab:Section({ Title = "Custom Theme Creator", Box = false })

local v42 = {
  Name = "Custom",
  Accent = Color3.fromHex("#1e3a8a"),
  Dialog = Color3.fromHex("#1e293b"),
  Outline = Color3.fromHex("#3b82f6"),
  Text = Color3.fromHex("#f1f5f9"),
  Placeholder = Color3.fromHex("#64748b"),
  Background = Color3.fromHex("#0f172a"),
  Button = Color3.fromHex("#334155"),
  Icon = Color3.fromHex("#94a3b8"),
}

settingsTab:Colorpicker({
  Title = "Accent Color",
  Desc = "Main accent color",
  Default = v42.Accent,
  Callback = function(value61) v42.Accent = value61 end,
})

settingsTab:Colorpicker({
  Title = "Background Color",
  Desc = "Main background color",
  Default = v42.Background,
  Callback = function(value62) v42.Background = value62 end,
})

settingsTab:Colorpicker({
  Title = "Dialog Color",
  Desc = "Dialog background color",
  Default = v42.Dialog,
  Callback = function(value63) v42.Dialog = value63 end,
})

settingsTab:Colorpicker({
  Title = "Outline Color",
  Desc = "Outline and border color",
  Default = v42.Outline,
  Callback = function(value64) v42.Outline = value64 end,
})

settingsTab:Colorpicker({
  Title = "Text Color",
  Desc = "Main text color",
  Default = v42.Text,
  Callback = function(value65) v42.Text = value65 end,
})

settingsTab:Colorpicker({
  Title = "Button Color",
  Desc = "Button background color",
  Default = v42.Button,
  Callback = function(value66) v42.Button = value66 end,
})

settingsTab:Colorpicker({
  Title = "Icon Color",
  Desc = "Icon tint color",
  Default = v42.Icon,
  Callback = function(value67) v42.Icon = value67 end,
})

settingsTab:Button({
  Title = "Apply Custom Theme",
  Desc = "Apply your custom theme",
  Callback = function()
    windUI:AddTheme(v42)
    windUI:SetTheme("Custom")
  end,
})

aimbotTab:Select()
