--[[
Game-specific Luau: DEOBFUSCATED (static recovery) / NOT TESTED IN ROBLOX
Source: https://github.com/Sealient/Sealients-Roblox-Scripts/blob/ac50da1fb3f21e357bd4f52d4f9b7203b6d0b967/3008-%20UPDATED/3008.lua
Source SHA-256: 20bf0fca34b40ab629b93551187212217ab3e456982ee7cae1b1919af152f925
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

local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local userInputService = game:GetService("UserInputService")
local v1 = game:GetService("Workspace")
local virtualInputManager = game:GetService("VirtualInputManager")
local players = game:GetService("Players")
local teleportService = game:GetService("TeleportService")
local stats = game:GetService("Stats")
local contentProvider = game:GetService("ContentProvider")
local reduxV2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Sealient/ReduxV2/refs/heads/main/ReduxV2.lua"))()
local popup = reduxV2:CreatePopup()
local notifications = reduxV2:Notifications()
print("🔧 [DEBUG] Popup service created")
local f1

local function f2()
  print("💖 Loading Heartfelt Support UI...")

  local main = reduxV2:CreateMain("A Personal Request... ❤️")
  main.ToggleKey = Enum.KeyCode.RightControl

  local tab = main:CreateTab("From My Heart", "💔")

  local myJourneySection = tab:CreateSection("My Journey...")
  myJourneySection:CreateLabel("⏰ I've spent late nights coding this")
  myJourneySection:CreateLabel("😔 Watching 10,000 people use my work")
  myJourneySection:CreateLabel("💔 But nobody says anything...")
  myJourneySection:CreateLabel("🎮 I just want to make your gaming better")

  myJourneySection:CreateButton("Read My Story...", function()
    popup:Info(
      "This is hard to share...",
      "After 50 hours of work, seeing 10,000 players\nuse my script but receive complete silence...\n\nIt makes me wonder if anyone even cares.\nIf my work matters at all.\n\nA single like or comment would mean\nthe world to me right now. 🥺",
      10
    )
  end)

  local section = tab:CreateSection("How You Can Change This")

  section:CreateButton("Be The First To Care", function()
    popup:Confirm("Make a difference today?", [[
You could be the first person in 10,000
to show they appreciate my work.

Your simple like would prove that
my late nights and effort matter.]], function(p1)
      if p1 == "Confirm" then
        popup:Success(
          "Thank you... 🥹",
          "You have no idea what this means.\nSomeone finally noticed the effort.\n\nThank you for seeing me. ❤️",
          6
        )
      else
        popup:Info(
          "I understand...", "Maybe the next person will care.\nI'll keep trying anyway. 💪",
          4
        )
      end
    end)
  end)

  section:CreateButton("Tell Me What You Want", function()
    popup:Info("Your voice matters...", [[
I don't know what features to add because
nobody tells me what they need.

Your comment could shape the future
of this script and help everyone.

What would make your 3008 experience better?]], 8)
  end)

  local section2 = tab:CreateSection("Why This Hurts")

  section2:CreateButton("The Silence is Deafening", function()
    popup:Warning(
      "Imagine this...",
      "You work for weeks on something special.\nYou give it to 10,000 people for free.\n\nAnd not a single person says 'thank you'.\nNot one person says 'good job'.\n\nIt feels like shouting into an empty room\nwhere everyone takes but nobody gives back. 💔",
      8
    )
  end)

  section2:CreateButton("I'm Not Asking For Money", function()
    popup:Info(
      "Just a little recognition...",
      "I'm not asking for donations.\nI'm not selling anything.\n\nI just want to know that my work\nmatters to someone. Anyone.\n\nThat the sleep I lost and the hours I spent\nactually made a difference for you. 🥺",
      7
    )
  end)

  tab:CreateSection("You Can Change This"):CreateButton("Be My Reason To Keep Going", function()
    popup:Confirm("Keep me motivated?", [[
When nobody engages, it's hard to find
the motivation to keep improving.

Your support would give me the energy
to add amazing new features for you.]], function(p2)
      if p2 == "Confirm" then
        popup:Success(
          "You're my hero... 🦸",
          "Because of you, I'll wake up excited\nto code again tomorrow.\n\nYou just reminded me why I do this.\nThank you for giving me hope. 🌟",
          6
        )
      end
    end)
  end)

  local simpleActionsSection = tab:CreateSection("Simple Actions")

  simpleActionsSection:CreateButton("Load 3008 - Abyssal", function()
    popup:Confirm("Ready to experience my work?", [[
I've poured my heart into this for you.

After you try it, could you please let me
know what you think on RScripts?]])

    popup:Confirm("Coded By Yours Truly", [[
Everything you see in this ui Is all coded and designed by me

From the Actual UI to the Code to the functionality, everything is created by me.]], function(p3)
      main.Enabled = false

      if p3 == "Confirm" then
        popup:Success(
          "Thank you for caring ❤️",
          "Loading the best 3008 experience I could make for you...", 3
        )
      else
        popup:Info("Loading...", "I hope my work makes you happy. 🎮", 2)
      end

      wait(2)
      f1()
    end)
  end)

  simpleActionsSection:CreateButton("I'll Support Later", function()
    popup:Info(
      "I'll be waiting...",
      "I hope you enjoy what I've made.\n\nIf you have a moment later, please\nremember how much your support means. 🥺",
      5
    )

    wait(3)
    main.Enabled = false
    f1()
  end)

  print("✅ Heartfelt Support UI Loaded")
  return main
end

function f1()
  print("🚀 [DEBUG] CreateMainUI() called - starting UI creation...")
  local v2, v3 = pcall(function() return reduxV2:CreateMain("3008 - Abyssal") end)

  local v4, v5, v6, f3, f4, f5, f6, f7, f8, f9, f10, v7, v8, f11, f12, f13, f14, f15, f16, f17,
    f18, f19, v9, v10, v11, f20, f21, f22, f23, f24, f25, f26, f27, f28, v12, v13, f29, f30,
    f31, f32, f33, f34, f35, f36, toggle, toggle2, v14, localPlayer, f37, f38, f39, f40, f41,
    f42, f43, f44, f45, f46, f47, f48, f49, v15, v16, f50, f51, f52, f53, v17, f54, f55, f56,
    v18, f57, f58, v19, f59, f60, v20, f61, f62

  if not v2 then
    print("❌ [DEBUG] Failed to create main UI:", v3)
    popup:Error("UI Creation Failed", "Failed to create main interface")
    return nil
  else
    print("✅ [DEBUG] Main UI object created successfully")
    v4 = { Enabled = false, Employees = {}, Connections = {} }

    v5 = {
      BoxESP = true,
      TracerESP = true,
      NameESP = true,
      DistanceESP = true,
      HealthESP = true,
      BoxColor = Color3.fromRGB(255, 0, 0),
      TracerColor = Color3.fromRGB(255, 255, 255),
      NameColor = Color3.fromRGB(255, 255, 255),
      DistanceColor = Color3.fromRGB(255, 255, 255),
      HealthColor = Color3.fromRGB(0, 255, 0),
      MaxDistance = 500,
      TracerOrigin = "Bottom",
      BoxThickness = 1,
      TextSize = 14,
      TextOutline = true,
    }

    v6 = { new = function(p4) return Drawing.new(p4) end }

    function f3()
      for key, value in pairs(v4.Employees) do
        if value.Box then
          value.Box:Remove()
        end

        if value.Tracer then
          value.Tracer:Remove()
        end

        if value.Name then
          value.Name:Remove()
        end

        if value.Distance then
          value.Distance:Remove()
        end

        if value.Health then
          value.Health:Remove()
        end
      end

      v4.Employees = {}
    end

    function f4(p5)
      if v4.Employees[p5] then
        local v21 = v4.Employees[p5]

        if v21.Box then
          v21.Box:Remove()
        end

        if v21.Tracer then
          v21.Tracer:Remove()
        end

        if v21.Name then
          v21.Name:Remove()
        end

        if v21.Distance then
          v21.Distance:Remove()
        end

        if v21.Health then
          v21.Health:Remove()
        end
      end

      local enemy = p5:FindFirstChild("Enemy")

      if not enemy then
        return
      else
        local square = v6.new("Square")
        square.Visible = false
        square.Color = v5.BoxColor
        square.Thickness = v5.BoxThickness
        square.Filled = false

        local line = v6.new("Line")
        line.Visible = false
        line.Color = v5.TracerColor
        line.Thickness = 1

        local text = v6.new("Text")
        text.Visible = false
        text.Color = v5.NameColor
        text.Size = v5.TextSize
        text.Center = true
        text.Outline = v5.TextOutline
        text.Text = "Employee"

        local text2 = v6.new("Text")
        text2.Visible = false
        text2.Color = v5.DistanceColor
        text2.Size = v5.TextSize
        text2.Center = true
        text2.Outline = v5.TextOutline

        local text3 = v6.new("Text")
        text3.Visible = false
        text3.Color = v5.HealthColor
        text3.Size = v5.TextSize
        text3.Center = true
        text3.Outline = v5.TextOutline

        v4.Employees[p5] = {
          Instance = p5,
          Humanoid = enemy,
          Box = square,
          Tracer = line,
          Name = text,
          Distance = text2,
          Health = text3,
          LastUpdate = tick(),
        }

        return v4.Employees[p5]
      end
    end

    function f5(p6)
      if v4.Employees[p6] then
        local v22 = v4.Employees[p6]

        if v22.Box then
          v22.Box:Remove()
        end

        if v22.Tracer then
          v22.Tracer:Remove()
        end

        if v22.Name then
          v22.Name:Remove()
        end

        if v22.Distance then
          v22.Distance:Remove()
        end

        if v22.Health then
          v22.Health:Remove()
        end

        v4.Employees[p6] = nil
      end
    end

    function f6()
      local y

      if not v4.Enabled then
        return
      else
        local currentCamera = workspace.CurrentCamera
        local getMouse = game.Players.LocalPlayer:GetMouse()
        local v23 = {}

        for key2, value2 in pairs(v4.Employees) do
          if not key2 or not key2.Parent or not value2.Humanoid or value2.Humanoid.Health <= 0 then
            table.insert(v23, key2)
          end
        end

        for index, value3 in ipairs(v23) do
          f5(value3)
        end

        for key3, value4 in pairs(v4.Employees) do
          local humanoidRootPart = key3:FindFirstChild("HumanoidRootPart")

          if not humanoidRootPart then
            value4.Box.Visible = false
            value4.Tracer.Visible = false
            value4.Name.Visible = false
            value4.Distance.Visible = false
            value4.Health.Visible = false
          else
            local v24, v25 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)
            local magnitude = (humanoidRootPart.Position - currentCamera.CFrame.Position).Magnitude

            if magnitude > v5.MaxDistance then
              value4.Box.Visible = false
              value4.Tracer.Visible = false
              value4.Name.Visible = false
              value4.Distance.Visible = false
              value4.Health.Visible = false
            elseif v25 then
              if v5.BoxESP then
                local vector = Vector2.new(2000 / magnitude, 3000 / magnitude)

                value4.Box.Size = vector
                value4.Box.Position = Vector2.new(v24.X - vector.X / 2, v24.Y - vector.Y / 2)
                value4.Box.Color = v5.BoxColor
                value4.Box.Thickness = v5.BoxThickness
                value4.Box.Visible = true
              else
                value4.Box.Visible = false
              end

              if v5.TracerESP then
                if v5.TracerOrigin == "Bottom" then
                  y = currentCamera.ViewportSize.Y
                elseif v5.TracerOrigin == "Top" then
                  y = 0
                else
                  y = getMouse.Y
                end

                value4.Tracer.From = Vector2.new(currentCamera.ViewportSize.X / 2, y)
                value4.Tracer.To = Vector2.new(v24.X, v24.Y)
                value4.Tracer.Color = v5.TracerColor
                value4.Tracer.Visible = true
              else
                value4.Tracer.Visible = false
              end

              if v5.NameESP then
                value4.Name.Position = Vector2.new(v24.X, v24.Y - 40)
                value4.Name.Color = v5.NameColor
                value4.Name.Size = v5.TextSize
                value4.Name.Outline = v5.TextOutline
                value4.Name.Visible = true
              else
                value4.Name.Visible = false
              end

              if v5.DistanceESP then
                value4.Distance.Position = Vector2.new(v24.X, v24.Y - 25)
                value4.Distance.Text = string.format("[%d]", magnitude)
                value4.Distance.Color = v5.DistanceColor
                value4.Distance.Size = v5.TextSize
                value4.Distance.Outline = v5.TextOutline
                value4.Distance.Visible = true
              else
                value4.Distance.Visible = false
              end

              if v5.HealthESP then
                value4.Health.Position = Vector2.new(v24.X, v24.Y - 10)
                value4.Health.Text = string.format("HP: %d", value4.Humanoid.Health)
                value4.Health.Color = v5.HealthColor
                value4.Health.Size = v5.TextSize
                value4.Health.Outline = v5.TextOutline
                value4.Health.Visible = true
              else
                value4.Health.Visible = false
              end
            else
              value4.Box.Visible = false
              value4.Tracer.Visible = false
              value4.Name.Visible = false
              value4.Distance.Visible = false
              value4.Health.Visible = false
            end
          end
        end

        return
      end
    end

    function f7()
      local gameObjects = workspace:FindFirstChild("GameObjects")

      if gameObjects then
        gameObjects = gameObjects:FindFirstChild("Physical")

        if gameObjects then
          gameObjects = gameObjects:FindFirstChild("Employees")
        end
      end

      if not gameObjects then
        return {}
      else
        local v26 = {}

        for key4, value5 in pairs(gameObjects:GetChildren()) do
          if value5:FindFirstChild("Enemy") then
            table.insert(v26, value5)
          end
        end

        return v26
      end
    end

    function f8()
      f3()
      local v27 = f7()

      for key5, value6 in pairs(v27) do
        f4(value6)
      end

      return #v27
    end

    function f9()
      if v4.Connections.UpdateLoop then
        v4.Connections.UpdateLoop:Disconnect()
      end

      local v28 = f8()
      local gameObjects2 = workspace:FindFirstChild("GameObjects")

      if gameObjects2 then
        local physical = gameObjects2:FindFirstChild("Physical")

        if physical then
          local employees = physical:FindFirstChild("Employees")

          if employees then
            local childAdded = employees.ChildAdded

            v4.Connections.EmployeeAdded = childAdded:Connect(function(p7)
              wait(0.5)

              if p7:FindFirstChild("Enemy") then
                f4(p7)
              end
            end)

            local childRemoved = employees.ChildRemoved
            v4.Connections.EmployeeRemoved = childRemoved:Connect(function(p8) f5(p8) end)
          end
        end
      end

      local renderStepped = runService.RenderStepped

      v4.Connections.UpdateLoop = renderStepped:Connect(f6)
      v4.Enabled = true

      notifications:Success(string.format("Employee ESP Enabled! Found %d employees", v28, 3))
    end

    function f10()
      v4.Enabled = false

      for key6, value7 in pairs(v4.Connections) do
        value7:Disconnect()
      end

      v4.Connections = {}
      f3()
      notifications:Warning("Employee ESP Disabled!", 3)
    end

    v7 = { Enabled = false, Players = {}, Connections = {} }

    v8 = {
      BoxESP = true,
      TracerESP = true,
      NameESP = true,
      DistanceESP = true,
      HealthESP = true,
      BoxColor = Color3.fromRGB(0, 255, 0),
      TracerColor = Color3.fromRGB(255, 255, 255),
      NameColor = Color3.fromRGB(255, 255, 255),
      DistanceColor = Color3.fromRGB(255, 255, 255),
      HealthColor = Color3.fromRGB(0, 255, 0),
      MaxDistance = 500,
      TracerOrigin = "Bottom",
      BoxThickness = 1,
      TextSize = 14,
      TextOutline = true,
    }

    function f11()
      for key7, value8 in pairs(v7.Players) do
        if value8.Box then
          value8.Box:Remove()
        end

        if value8.Tracer then
          value8.Tracer:Remove()
        end

        if value8.Name then
          value8.Name:Remove()
        end

        if value8.Distance then
          value8.Distance:Remove()
        end

        if value8.Health then
          value8.Health:Remove()
        end
      end

      v7.Players = {}
      print("🧹 Player ESP cleaned up")
    end

    function f12(p9, p10)
      if v7.Players[p10] then
        RemovePlayerESP(p10)
      end

      local humanoid = p9:FindFirstChild("Humanoid")
      local humanoidRootPart2 = p9:FindFirstChild("HumanoidRootPart")

      if not humanoid then
        print("❌ No Humanoid found for: " .. p10)
        return nil
      elseif not humanoidRootPart2 then
        print("❌ No HumanoidRootPart found for: " .. p10)
        return nil
      else
        local square2 = Drawing.new("Square")
        square2.Visible = false
        square2.Color = v8.BoxColor
        square2.Thickness = v8.BoxThickness
        square2.Filled = false

        local line2 = Drawing.new("Line")
        line2.Visible = false
        line2.Color = v8.TracerColor
        line2.Thickness = 1

        local text4 = Drawing.new("Text")
        text4.Visible = false
        text4.Color = v8.NameColor
        text4.Size = v8.TextSize
        text4.Center = true
        text4.Outline = v8.TextOutline
        text4.Text = p10

        local text5 = Drawing.new("Text")
        text5.Visible = false
        text5.Color = v8.DistanceColor
        text5.Size = v8.TextSize
        text5.Center = true
        text5.Outline = v8.TextOutline

        local text6 = Drawing.new("Text")
        text6.Visible = false
        text6.Color = v8.HealthColor
        text6.Size = v8.TextSize
        text6.Center = true
        text6.Outline = v8.TextOutline

        v7.Players[p10] = {
          Folder = p9,
          PlayerName = p10,
          Humanoid = humanoid,
          HumanoidRootPart = humanoidRootPart2,
          Box = square2,
          Tracer = line2,
          Name = text4,
          Distance = text5,
          Health = text6,
          LastUpdate = tick(),
        }

        print("✅ Created Player ESP for: " .. p10)
        return v7.Players[p10]
      end
    end

    function f13(p11)
      if v7.Players[p11] then
        local v29 = v7.Players[p11]

        if v29.Box then
          v29.Box:Remove()
        end

        if v29.Tracer then
          v29.Tracer:Remove()
        end

        if v29.Name then
          v29.Name:Remove()
        end

        if v29.Distance then
          v29.Distance:Remove()
        end

        if v29.Health then
          v29.Health:Remove()
        end

        v7.Players[p11] = nil
        print("🗑️ Removed Player ESP for: " .. p11)
      end
    end

    function f14()
      local y2

      if not v7.Enabled then
        return
      else
        local currentCamera2 = workspace.CurrentCamera
        local v30 = not currentCamera2
        local localPlayer2 = game.Players.LocalPlayer

        if v30 or not localPlayer2 then
          return
        else
          local getMouse2 = localPlayer2:GetMouse()
          local v31 = {}

          for key8, value9 in pairs(v7.Players) do
            if not value9.Folder or not value9.Folder.Parent or not value9.Humanoid
              or value9.Humanoid.Health <= 0 then
              table.insert(v31, key8)
            end
          end

          for index2, value10 in ipairs(v31) do
            f13(value10)
          end

          for key9, value11 in pairs(v7.Players) do
            if not value11.HumanoidRootPart or not value11.HumanoidRootPart.Parent then
              value11.Box.Visible = false
              value11.Tracer.Visible = false
              value11.Name.Visible = false
              value11.Distance.Visible = false
              value11.Health.Visible = false
            else
              local v32, v33 = currentCamera2:WorldToViewportPoint(value11.HumanoidRootPart.Position)

              local magnitude2 = (value11.HumanoidRootPart.Position
                - currentCamera2.CFrame.Position).Magnitude

              if magnitude2 > v8.MaxDistance then
                value11.Box.Visible = false
                value11.Tracer.Visible = false
                value11.Name.Visible = false
                value11.Distance.Visible = false
                value11.Health.Visible = false
              elseif v33 then
                if v8.BoxESP then
                  local vector2 = Vector2.new(2000 / magnitude2, 3000 / magnitude2)

                  value11.Box.Size = vector2

                  value11.Box.Position = Vector2.new(
                    v32.X - vector2.X / 2, v32.Y - vector2.Y / 2
                  )

                  value11.Box.Color = v8.BoxColor
                  value11.Box.Thickness = v8.BoxThickness
                  value11.Box.Visible = true
                else
                  value11.Box.Visible = false
                end

                if v8.TracerESP then
                  if v8.TracerOrigin == "Bottom" then
                    y2 = currentCamera2.ViewportSize.Y
                  elseif v8.TracerOrigin == "Top" then
                    y2 = 0
                  else
                    y2 = getMouse2.Y
                  end

                  value11.Tracer.From = Vector2.new(currentCamera2.ViewportSize.X / 2, y2)
                  value11.Tracer.To = Vector2.new(v32.X, v32.Y)
                  value11.Tracer.Color = v8.TracerColor
                  value11.Tracer.Visible = true
                else
                  value11.Tracer.Visible = false
                end

                if v8.NameESP then
                  value11.Name.Position = Vector2.new(v32.X, v32.Y - 40)
                  value11.Name.Color = v8.NameColor
                  value11.Name.Size = v8.TextSize
                  value11.Name.Outline = v8.TextOutline
                  value11.Name.Text = key9
                  value11.Name.Visible = true
                else
                  value11.Name.Visible = false
                end

                if v8.DistanceESP then
                  value11.Distance.Position = Vector2.new(v32.X, v32.Y - 25)
                  value11.Distance.Text = string.format("[%d]", magnitude2)
                  value11.Distance.Color = v8.DistanceColor
                  value11.Distance.Size = v8.TextSize
                  value11.Distance.Outline = v8.TextOutline
                  value11.Distance.Visible = true
                else
                  value11.Distance.Visible = false
                end

                if v8.HealthESP then
                  value11.Health.Position = Vector2.new(v32.X, v32.Y - 10)
                  value11.Health.Text = string.format("HP: %d", value11.Humanoid.Health)
                  value11.Health.Color = v8.HealthColor
                  value11.Health.Size = v8.TextSize
                  value11.Health.Outline = v8.TextOutline
                  value11.Health.Visible = true
                else
                  value11.Health.Visible = false
                end
              else
                value11.Box.Visible = false
                value11.Tracer.Visible = false
                value11.Name.Visible = false
                value11.Distance.Visible = false
                value11.Health.Visible = false
              end
            end
          end

          return
        end
      end
    end

    function f15()
      local v34 = {}
      local gameObjects3 = workspace:FindFirstChild("GameObjects")

      if gameObjects3 then
        local physical2 = gameObjects3:FindFirstChild("Physical")

        if physical2 then
          local players2 = physical2:FindFirstChild("Players")

          if players2 then
            print("🔍 Found Players folder at: workspace.GameObjects.Physical.Players")

            for key10, value12 in pairs(players2:GetChildren()) do
              local name = value12.Name

              if value12:FindFirstChild("Humanoid")
                and value12:FindFirstChild("HumanoidRootPart") then
                table.insert(v34, { Folder = value12, PlayerName = name })
                print("👥 Found player: " .. name)
              else
                print("❌ Player folder missing Humanoid/RootPart: " .. name)
              end
            end
          else
            print("❌ Players folder not found at: workspace.GameObjects.Physical.Players")
          end
        else
          print("❌ Physical folder not found")
        end
      else
        print("❌ GameObjects folder not found")
      end

      print("🔍 Player search complete: " .. #v34 .. " players found")
      return v34
    end

    function f16()
      f11()
      local count = 0

      for key11, value13 in pairs((f15())) do
        if f12(value13.Folder, value13.PlayerName) then
          count = count + 1
        end
      end

      print("✅ Player ESP setup: " .. count .. " players tagged")
      return count
    end

    function f17()
      local gameObjects4 = workspace:FindFirstChild("GameObjects")

      if gameObjects4 then
        local physical3 = gameObjects4:FindFirstChild("Physical")

        if physical3 then
          local players3 = physical3:FindFirstChild("Players")

          if players3 then
            local childAdded2 = players3.ChildAdded

            v7.Connections.PlayerAdded = childAdded2:Connect(function(p12)
              wait(1)

              if p12:FindFirstChild("Humanoid") and p12:FindFirstChild("HumanoidRootPart") then
                f12(p12, p12.Name)
                notifications:Success("New player detected: " .. p12.Name, 3)
              else
                print("❌ New player folder missing Humanoid: " .. p12.Name)
              end
            end)

            local childRemoved2 = players3.ChildRemoved

            v7.Connections.PlayerRemoved = childRemoved2:Connect(function(p13)
              f13(p13.Name)
              notifications:Info("Player left: " .. p13.Name, 3)
            end)
          end
        end
      end
    end

    function f18()
      if v7.Connections.UpdateLoop then
        v7.Connections.UpdateLoop:Disconnect()
      end

      local v35 = f16()
      f17()
      local renderStepped2 = runService.RenderStepped

      v7.Connections.UpdateLoop = renderStepped2:Connect(f14)
      v7.Enabled = true

      notifications:Success(string.format(
        "Player ESP Enabled! Found %d players in the facility", v35
      ), 3)
    end

    function f19()
      v7.Enabled = false

      for key12, value14 in pairs(v7.Connections) do
        value14:Disconnect()
      end

      v7.Connections = {}
      f11()
      notifications:Warning("Player ESP Disabled! All player tracking stopped", 3)
    end

    v9 = { Enabled = false, Items = {}, Connections = {} }

    v10 = {
      EnabledItems = {
        Medkit = true,
        Apple = true,
        Banana = true,
        Beans = true,
        Burger = true,
        Chips = true,
        Chocolate = true,
        Cookie = true,
        ["Fish Crackers"] = true,
        Hotdog = true,
        ["Ice Cream"] = true,
        Lemon = true,
        ["Lemon Slice"] = true,
        Meatballs = true,
        Pizza = true,
        ["Striped Donut"] = true,
        ["2 Litre Dr. Bob"] = true,
        ["Bloxy Soda"] = true,
        ["Dr. Bob Soda"] = true,
        Water = true,
      },
      MaxDistance = 200,
      UpdateRate = 0.1,
      ShowIcons = true,
      BillboardSize = UDim2.new(0, 120, 0, 40),
      BillboardOffset = Vector3.new(0, 2.5, 0),
      TextSize = 14,
      Colors = {
        Medkit = Color3.fromRGB(255, 0, 0),
        Food = Color3.fromRGB(255, 165, 0),
        Drink = Color3.fromRGB(0, 100, 255),
      },
      Icons = {
        Medkit = "🩹",
        Apple = "🍎",
        Banana = "🍌",
        Beans = "🥫",
        Burger = "🍔",
        Chips = "🍟",
        Chocolate = "🍫",
        Cookie = "🍪",
        ["Fish Crackers"] = "🐟",
        Hotdog = "🌭",
        ["Ice Cream"] = "🍦",
        Lemon = "🍋",
        ["Lemon Slice"] = "🍋",
        Meatballs = "🍖",
        Pizza = "🍕",
        ["Striped Donut"] = "🍩",
        ["2 Litre Dr. Bob"] = "🥤",
        ["Bloxy Soda"] = "🥤",
        ["Dr. Bob Soda"] = "🥤",
        Water = "💧",
      },
    }

    v11 = {
      Medkit = "Medkit",
      Apple = "Food",
      Banana = "Food",
      Beans = "Food",
      Burger = "Food",
      Chips = "Food",
      Chocolate = "Food",
      Cookie = "Food",
      ["Fish Crackers"] = "Food",
      Hotdog = "Food",
      ["Ice Cream"] = "Food",
      Lemon = "Food",
      ["Lemon Slice"] = "Food",
      Meatballs = "Food",
      Pizza = "Food",
      ["Striped Donut"] = "Food",
      ["2 Litre Dr. Bob"] = "Drink",
      ["Bloxy Soda"] = "Drink",
      ["Dr. Bob Soda"] = "Drink",
      Water = "Drink",
    }

    function f20()
      print("🧹 Cleaning up Item ESP...")
      local count2 = 0

      for key13, value15 in pairs(v9.Items) do
        if value15.Billboard and value15.Billboard.Parent then
          value15.Billboard:Destroy()
          count2 = count2 + 1
        end

        if value15.Highlight and value15.Highlight.Parent then
          value15.Highlight:Destroy()
          count2 = count2 + 1
        end
      end

      v9.Items = {}

      for key14, value16 in pairs(workspace:GetDescendants()) do
        if value16:IsA("BillboardGui") and string.find(value16.Name, "ItemESP_") then
          value16:Destroy()
          count2 = count2 + 1
        end

        if value16:IsA("Highlight") and string.find(value16.Name, "ItemHighlight_") then
          value16:Destroy()
          count2 = count2 + 1
        end
      end

      print("✅ Item ESP cleaned: " .. count2 .. " objects removed")
      return count2
    end

    function f21(p14)
      return v10.Colors[v11[p14]] or Color3.fromRGB(255, 255, 255)
    end

    function f22(p15)
      return v10.Icons[p15] or "📦"
    end

    function f23(p16, p17)
      if not v10.EnabledItems[p17] then
        return nil
      else
        local primaryPart = nil

        if p16:IsA("BasePart") then
          primaryPart = p16
        elseif p16:IsA("Model") then
          primaryPart = p16.PrimaryPart or p16:FindFirstChildWhichIsA("BasePart")
        end

        if not primaryPart then
          return nil
        else
          for key15, value17 in pairs(primaryPart:GetChildren()) do
            if value17:IsA("BillboardGui") and string.find(value17.Name, "ItemESP_") then
              value17:Destroy()
            end

            if value17:IsA("Highlight") and string.find(value17.Name, "ItemHighlight_") then
              value17:Destroy()
            end
          end

          local billboardGui = Instance.new("BillboardGui")
          billboardGui.Name = "ItemESP_" .. p17
          billboardGui.Adornee = primaryPart
          billboardGui.Size = v10.BillboardSize
          billboardGui.StudsOffset = v10.BillboardOffset
          billboardGui.AlwaysOnTop = true
          billboardGui.MaxDistance = v10.MaxDistance
          billboardGui.Enabled = true
          billboardGui.LightInfluence = 0
          billboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

          local textLabel = Instance.new("TextLabel")
          textLabel.Size = UDim2.new(1, 0, 1, 0)
          textLabel.BackgroundTransparency = 1
          textLabel.Text = v10.ShowIcons and f22(p17) .. " " .. p17 or p17
          textLabel.TextColor3 = f21(p17)
          textLabel.TextSize = v10.TextSize
          textLabel.Font = Enum.Font.GothamBold
          textLabel.TextStrokeTransparency = 0
          textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
          textLabel.Parent = billboardGui

          billboardGui.Parent = primaryPart

          local highlight = Instance.new("Highlight")
          highlight.Name = "ItemHighlight_" .. p17
          highlight.Adornee = p16:IsA("Model") and p16 or primaryPart
          highlight.FillColor = f21(p17)
          highlight.OutlineColor = f21(p17)
          highlight.FillTransparency = 0.8
          highlight.OutlineTransparency = 0.3
          highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
          highlight.Enabled = true
          highlight.Parent = primaryPart

          v9.Items[p16] = {
            Instance = p16,
            Name = p17,
            Billboard = billboardGui,
            Highlight = highlight,
            TargetPart = primaryPart,
            CreatedAt = tick(),
          }

          return v9.Items[p16]
        end
      end
    end

    function f24()
      local v36 = {}

      local function f63(p18, p19)
        if p19 > 8 then
          return
        end

        for key16, value18 in pairs(p18:GetChildren()) do
          local name2 = value18.Name

          if v10.EnabledItems[name2] then
            table.insert(v36, { Instance = value18, Name = name2 })
          else
            local v37 = {
              FishCrackers = "Fish Crackers",
              LemonSlice = "Lemon Slice",
              StripedDonut = "Striped Donut",
              ["2-Litre Dr. Bob"] = "2 Litre Dr. Bob",
              ["Dr.Bob Soda"] = "Dr. Bob Soda",
              IceCream = "Ice Cream",
            }

            if v37[name2] then
              table.insert(v36, { Instance = value18, Name = v37[name2] })
            end
          end

          if value18:IsA("Folder") or value18:IsA("Model") then
            f63(value18, p19 + 1)
          end
        end
      end

      for key17, value19 in pairs({ workspace.GameObjects, workspace }) do
        if value19 then
          f63(value19, 0)
        end
      end

      print("🔍 Item scan complete: " .. #v36 .. " items found")
      return v36
    end

    function f25()
      f20()
      local v38 = f24()
      local count3 = 0

      for i = 1, #v38, 25 do
        for j = i, math.min(i + 25 - 1, #v38) do
          local v39 = v38[j]

          if f23(v39.Instance, v39.Name) then
            count3 = count3 + 1
          end
        end

        wait(0.02)
      end

      print("✅ Item ESP setup: " .. count3 .. " items tagged")
      return count3
    end

    function f26()
      if not v9.Enabled then
        return
      else
        local currentCamera3 = workspace.CurrentCamera

        if not currentCamera3 then
          return
        else
          local position = currentCamera3.CFrame.Position
          local maxDistance = v10.MaxDistance

          for key18, value20 in pairs(v9.Items) do
            if not value20.Instance or not value20.Instance.Parent then
              if value20.Billboard then
                value20.Billboard.Enabled = false
              end

              if value20.Highlight then
                value20.Highlight.Enabled = false
              end
            elseif value20.TargetPart then
              local enabled = (value20.TargetPart.Position - position).Magnitude <= maxDistance

              if value20.Billboard then
                value20.Billboard.Enabled = enabled
              end

              if value20.Highlight then
                value20.Highlight.Enabled = enabled
              end
            end
          end

          return
        end
      end
    end

    function f27()
      if v9.Connections.UpdateLoop then
        v9.Connections.UpdateLoop:Disconnect()
      end

      local v40 = f25()
      local heartbeat = runService.Heartbeat

      v9.Connections.UpdateLoop = heartbeat:Connect(function()
        if tick() - (v9.LastUpdate or 0) > v10.UpdateRate then
          f26()
          v9.LastUpdate = tick()
        end
      end)

      v9.Enabled = true

      notifications:Success("Item ESP Enabled! (" .. v40 .. " items)", 3)
    end

    function f28()
      v9.Enabled = false

      if v9.Connections.UpdateLoop then
        v9.Connections.UpdateLoop:Disconnect()
        v9.Connections.UpdateLoop = nil
      end

      f20()
      notifications:Warning("Item ESP Disabled!", 3)
    end

    v12 = {
      Enabled = false,
      Connections = {},
      SavedPosition = nil,
      SavedCFrame = nil,
      IsTeleporting = false,
    }

    v13 = {
      TeleportRange = 5000,
      TeleportCooldown = 1,
      ReturnDelay = 2,
      EnabledItems = {
        Medkit = true,
        Apple = true,
        Banana = true,
        Beans = true,
        Burger = true,
        Chips = true,
        Chocolate = true,
        Cookie = true,
        ["Fish Crackers"] = true,
        Hotdog = true,
        ["Ice Cream"] = true,
        Lemon = true,
        ["Lemon Slice"] = true,
        Meatballs = true,
        Pizza = true,
        ["Striped Donut"] = true,
        ["2 Litre Dr. Bob"] = true,
        ["Bloxy Soda"] = true,
        ["Dr. Bob Soda"] = true,
        Water = true,
      },
      LastTeleport = 0,
    }

    function f29()
      local localPlayer3 = game.Players.LocalPlayer

      if not localPlayer3 or not localPlayer3.Character then
        return false
      else
        local humanoidRootPart3 = localPlayer3.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart3 then
          return false
        end

        v12.SavedPosition = humanoidRootPart3.Position
        v12.SavedCFrame = humanoidRootPart3.CFrame

        print("💾 Saved player position: " .. tostring(v12.SavedPosition))
        return true
      end
    end

    function f30()
      local humanoidRootPart4

      if not v12.SavedPosition then
        notifications:Error("No saved position to return to!", 3)
        return false
      else
        local localPlayer4 = game.Players.LocalPlayer

        if not localPlayer4 or not localPlayer4.Character then
          return false
        end

        humanoidRootPart4 = localPlayer4.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart4 then
          return false
        else
          local v41, v42 = pcall(function()
            humanoidRootPart4.CFrame = v12.SavedCFrame or CFrame.new(v12.SavedPosition)
          end)

          if v41 then
            notifications:Success("Returned to original position!", 3)
            return true
          end

          notifications:Error("Failed to return: " .. tostring(v42), 3)
          return false
        end
      end
    end

    function f31(p20, p21)
      local humanoidRootPart5, position2

      if v12.IsTeleporting then
        return false, "Already teleporting"
      elseif tick() - v13.LastTeleport < v13.TeleportCooldown then
        return false, "Teleport on cooldown"
      else
        local localPlayer5 = game.Players.LocalPlayer

        if not localPlayer5 or not localPlayer5.Character then
          return false, "No character"
        end

        humanoidRootPart5 = localPlayer5.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart5 then
          return false, "No HumanoidRootPart"
        end

        position2 = nil

        if p20:IsA("BasePart") then
          position2 = p20.Position
        elseif p20:IsA("Model") then
          for key19, value21 in pairs(p20:GetChildren()) do
            if value21:IsA("BasePart") then
              position2 = value21.Position
              break
            end
          end
        end

        if not position2 then
          return false, "Could not get item position"
        else
          if not v12.SavedPosition then
            f29()
          end

          v12.IsTeleporting = true
          v13.LastTeleport = tick()

          local v43, v44 = pcall(function()
            local vector3 = Vector3.new(0, 5, 0)
            humanoidRootPart5.CFrame = CFrame.new(position2 + vector3)
          end)

          if v43 then
            notifications:Success("Teleported to " .. p21 .. "!", 3)

            spawn(function()
              wait(v13.ReturnDelay)
              f30()
              v12.IsTeleporting = false
            end)

            return true, "Teleported to item successfully!"
          end

          v12.IsTeleporting = false
          notifications:Error()("Failed to teleport to " .. p21 .. ": " .. tostring(v44), 3)
          return false, "Teleport failed: " .. tostring(v44)
        end
      end
    end

    function f32()
      local v45 = {}
      local localPlayer6 = game.Players.LocalPlayer
      local v46 = not localPlayer6 or not localPlayer6.Character
      local position3, f64

      if v46 then
        return v45
      else
        local humanoidRootPart6 = localPlayer6.Character:FindFirstChild("HumanoidRootPart")

        if not humanoidRootPart6 then
          return v45
        end

        position3 = humanoidRootPart6.Position

        function f64(p22, p23)
          if p23 > 10 then
            return
          end

          for key20, value22 in pairs(p22:GetChildren()) do
            local name3 = value22.Name

            if v13.EnabledItems[name3] then
              local position4 = nil

              if value22:IsA("BasePart") then
                position4 = value22.Position
              elseif value22:IsA("Model") then
                for key21, value23 in pairs(value22:GetChildren()) do
                  if value23:IsA("BasePart") then
                    position4 = value23.Position
                    break
                  end
                end
              end

              if position4 then
                local magnitude3 = (position4 - position3).Magnitude

                if magnitude3 <= v13.TeleportRange then
                  table.insert(v45, {
                    Instance = value22,
                    Name = name3,
                    Distance = magnitude3,
                    Position = position4,
                  })
                end
              end
            end

            if value22:IsA("Folder") or value22:IsA("Model") then
              f64(value22, p23 + 1)
            end
          end
        end

        for key22, value24 in pairs({ workspace.GameObjects, workspace }) do
          if value24 then
            f64(value24, 0)
          end
        end

        table.sort(v45, function(p24, p25) return p24.Distance < p25.Distance end)
        return v45
      end
    end

    function f33(p26)
      local v47 = f32()
      local huge = math.huge
      local v48

      for key23, value25 in pairs(v47) do
        if value25.Name == p26 and value25.Distance < huge then
          v48 = value25
          huge = value25.Distance
        end
      end

      return v48
    end

    function f34(p27)
      if not v13.EnabledItems[p27] then
        notifications:Error(p27 .. " is not enabled for teleport", 3)
        return false
      else
        local v49 = f33(p27)

        if v49 then
          notifications:Info("Found " .. p27 .. " (" .. string.format("%.1f", v49.Distance)
            .. " studs away)", 3)

          return f31(v49.Instance, p27)
        end

        notifications:Warning(
          "No " .. p27 .. " found within " .. v13.TeleportRange .. " studs", 3
        )

        return false
      end
    end

    function f35()
      local v50 = f32()

      if #v50 > 0 then
        local v51 = v50[1]

        notifications:Info("Found " .. v51.Name .. " (" .. string.format("%.1f", v51.Distance)
          .. " studs away)", 3)

        return f31(v51.Instance, v51.Name)
      end

      notifications:Warning("No items found within " .. v13.TeleportRange .. " studs", 3)
      return false
    end

    function f36()
      if v12.SavedPosition then
        f30()
      else
        notifications:Warning("No position saved to return to", 3)
      end
    end

    local employeeESPTab = v3:CreateTab("Employee ESP", "👁️")
    local mainCONTROLSSection = employeeESPTab:CreateSection("MAIN CONTROLS")

    local toggle3 = mainCONTROLSSection:CreateToggle("Enable Employee ESP", false, function(p28)
      if p28 then
        f9()
      else
        f10()
      end
    end)

    mainCONTROLSSection:CreateButton("Refresh Employees", function()
      if v4.Enabled then
        f10()
        wait(0.1)
        f9()
      else
        f8()
      end
    end)

    mainCONTROLSSection:CreateButton("Clear ESP", function()
      f3()
      notifications:Warning("Employee ESP cleared!", 3)
    end)

    local espCOMPONENTSSection = employeeESPTab:CreateSection("ESP COMPONENTS")

    espCOMPONENTSSection:CreateToggle("Box ESP", v5.BoxESP, function(boxESP)
      v5.BoxESP = boxESP
    end)

    espCOMPONENTSSection:CreateToggle("Tracer ESP", v5.TracerESP, function(tracerESP)
      v5.TracerESP = tracerESP
    end)

    espCOMPONENTSSection:CreateToggle("Name ESP", v5.NameESP, function(nameESP)
      v5.NameESP = nameESP
    end)

    espCOMPONENTSSection:CreateToggle("Distance ESP", v5.DistanceESP, function(distanceESP)
      v5.DistanceESP = distanceESP
    end)

    espCOMPONENTSSection:CreateToggle("Health ESP", v5.HealthESP, function(healthESP)
      v5.HealthESP = healthESP
    end)

    local visualSETTINGSSection = employeeESPTab:CreateSection("VISUAL SETTINGS")

    visualSETTINGSSection:CreateColorPicker("Box Color", v5.BoxColor, function(boxColor)
      v5.BoxColor = boxColor
    end)

    visualSETTINGSSection:CreateColorPicker("Tracer Color", v5.TracerColor, function(tracerColor)
      v5.TracerColor = tracerColor
    end)

    visualSETTINGSSection:CreateColorPicker("Name Color", v5.NameColor, function(nameColor)
      v5.NameColor = nameColor
    end)

    visualSETTINGSSection:CreateSlider("Max Distance", 50, 1000, v5.MaxDistance, function(maxDistance2)
      v5.MaxDistance = maxDistance2
    end)

    visualSETTINGSSection:CreateSlider("Text Size", 8, 20, v5.TextSize, function(textSize)
      v5.TextSize = textSize
    end)

    local playerESPTab = v3:CreateTab("Player ESP", "👥")
    local mainCONTROLSSection2 = playerESPTab:CreateSection("MAIN CONTROLS")

    toggle = mainCONTROLSSection2:CreateToggle("Enable Player ESP", false, function(p29)
      if p29 then
        f18()
      else
        f19()
      end
    end)

    mainCONTROLSSection2:CreateButton("Refresh Players", function()
      if v7.Enabled then
        f19()
        wait(0.1)
        f18()
      else
        notifications:Info(
          "Player list refreshed! Found " .. f16() .. " players in the facility", 3
        )
      end
    end)

    mainCONTROLSSection2:CreateButton("Clear Player ESP", function()
      f11()
      toggle:Set(false)
      v7.Enabled = false

      for key24, value26 in pairs(v7.Connections) do
        value26:Disconnect()
      end

      v7.Connections = {}
      notifications:Success("Player ESP cleared! All visual elements removed", 3)
    end)

    local section3 = playerESPTab:CreateSection("PLAYER ESP COMPONENTS")
    section3:CreateToggle("Box ESP", v8.BoxESP, function(boxESP2) v8.BoxESP = boxESP2 end)

    section3:CreateToggle("Tracer ESP", v8.TracerESP, function(tracerESP2)
      v8.TracerESP = tracerESP2
    end)

    section3:CreateToggle("Name ESP", v8.NameESP, function(nameESP2) v8.NameESP = nameESP2 end)

    section3:CreateToggle("Distance ESP", v8.DistanceESP, function(distanceESP2)
      v8.DistanceESP = distanceESP2
    end)

    section3:CreateToggle("Health ESP", v8.HealthESP, function(healthESP2)
      v8.HealthESP = healthESP2
    end)

    local section4 = playerESPTab:CreateSection("PLAYER VISUAL SETTINGS")

    section4:CreateColorPicker("Box Color", v8.BoxColor, function(boxColor2)
      v8.BoxColor = boxColor2
    end)

    section4:CreateColorPicker("Tracer Color", v8.TracerColor, function(tracerColor2)
      v8.TracerColor = tracerColor2
    end)

    section4:CreateColorPicker("Name Color", v8.NameColor, function(nameColor2)
      v8.NameColor = nameColor2
    end)

    section4:CreateColorPicker("Distance Color", v8.DistanceColor, function(distanceColor)
      v8.DistanceColor = distanceColor
    end)

    section4:CreateColorPicker("Health Color", v8.HealthColor, function(healthColor)
      v8.HealthColor = healthColor
    end)

    section4:CreateSlider("Max Distance", 50, 1000, v8.MaxDistance, function(p30)
      v8.MaxDistance = p30
      notifications:Info("Player ESP range set to " .. p30 .. " studs", 3)
    end)

    section4:CreateSlider("Box Thickness", 1, 5, v8.BoxThickness, function(boxThickness)
      v8.BoxThickness = boxThickness
    end)

    section4:CreateSlider("Text Size", 8, 20, v8.TextSize, function(p31)
      v8.TextSize = p31

      for key25, value27 in pairs(v7.Players) do
        if value27.Name then
          value27.Name.Size = p31
        end

        if value27.Distance then
          value27.Distance.Size = p31
        end

        if value27.Health then
          value27.Health.Size = p31
        end
      end
    end)

    section4:CreateToggle("Text Outline", v8.TextOutline, function(p32)
      v8.TextOutline = p32

      for key26, value28 in pairs(v7.Players) do
        if value28.Name then
          value28.Name.Outline = p32
        end

        if value28.Distance then
          value28.Distance.Outline = p32
        end

        if value28.Health then
          value28.Health.Outline = p32
        end
      end
    end)

    section4:CreateDropdown(
      "Tracer Origin", { "Bottom", "Top", "Mouse" },
      function(tracerOrigin) v8.TracerOrigin = tracerOrigin end, "Bottom"
    )

    local debugINFOSection = playerESPTab:CreateSection("DEBUG & INFO")

    debugINFOSection:CreateButton("Debug Folder Structure", function()
      print("🔍 DEBUG: Checking workspace.GameObjects.Physical.Players...")
      local gameObjects5 = workspace:FindFirstChild("GameObjects")

      if gameObjects5 then
        print("✅ Found GameObjects")
        local physical4 = gameObjects5:FindFirstChild("Physical")

        if physical4 then
          print("✅ Found Physical")
          local players4 = physical4:FindFirstChild("Players")

          if players4 then
            print("✅ Found Players folder!")
            print("📁 Players folder contents:")

            for key27, value29 in pairs(players4:GetChildren()) do
              print("   👤 " .. value29.Name .. " (" .. value29.ClassName .. ")")

              for key28, value30 in pairs(value29:GetChildren()) do
                print("      📄 " .. value30.Name .. " (" .. value30.ClassName .. ")")
              end
            end
          else
            print("❌ Players folder not found")
          end
        else
          print("❌ Physical folder not found")
        end
      else
        print("❌ GameObjects folder not found")
      end

      notifications:Info(
        "Folder structure analysis complete - check console for detailed information", 3
      )
    end)

    debugINFOSection:CreateButton("Show Tracked Players", function()
      print("🎯 CURRENTLY TRACKED PLAYERS:")
      local count4 = 0

      for key29, value31 in pairs(v7.Players) do
        print("   👤 " .. key29)
        count4 = count4 + 1
      end

      print("   Total tracked: " .. count4 .. " players")

      if count4 > 0 then
        notifications:Success(
          "Tracking " .. count4 .. " players - check console for details", 3
        )
      else
        notifications:Success("No players currently being tracked", 3)
      end
    end)

    debugINFOSection:CreateButton("System Status", function()
      print("📊 PLAYER ESP SYSTEM STATUS:")
      print("   Enabled: " .. tostring(v7.Enabled))
      print("   Tracked Players: " .. table.count(v7.Players))
      print("   Active Connections: " .. table.count(v7.Connections))
      print("   Max Distance: " .. v8.MaxDistance)

      print("   Components - Box: " .. tostring(v8.BoxESP) .. ", Tracer: "
        .. tostring(v8.TracerESP) .. ", Name: " .. tostring(v8.NameESP))

      notifications:Info("Player ESP system status printed to console", 3)
    end)

    f11()

    print("✅ Fixed Player ESP System Loaded!")
    print("🎯 Now properly detects players in workspace.GameObjects.Physical.Players")
    print("👤 Uses Humanoid component for player detection")

    notifications:Success(
      "Player ESP system loaded successfully! Ready to track players in the facility", 3
    )

    local itemESPTab = v3:CreateTab("Item ESP", "📦")
    local mainCONTROLSSection3 = itemESPTab:CreateSection("MAIN CONTROLS")

    toggle2 = mainCONTROLSSection3:CreateToggle("Enable Item ESP", false, function(p33)
      if p33 then
        f27()
      else
        f28()
      end
    end)

    mainCONTROLSSection3:CreateButton("Refresh Items", function()
      if v9.Enabled then
        f28()
        wait(0.1)
        f27()
      else
        notifications:Info("Refreshed: " .. f25() .. " items", 3)
      end
    end)

    mainCONTROLSSection3:CreateButton("Clear Item ESP", function()
      local v52 = f20()
      toggle2:Set(false)
      v9.Enabled = false

      if v9.Connections.UpdateLoop then
        v9.Connections.UpdateLoop:Disconnect()
        v9.Connections.UpdateLoop = nil
      end

      notifications:Success("Cleared " .. v52 .. " Item ESP objects!", 3)
    end)

    local visualSETTINGSSection2 = itemESPTab:CreateSection("VISUAL SETTINGS")

    visualSETTINGSSection2:CreateToggle("Show Icons", v10.ShowIcons, function(p34)
      v10.ShowIcons = p34

      for key30, value32 in pairs(v9.Items) do
        if value32.Billboard and value32.Billboard:FindFirstChildWhichIsA("TextLabel") then
          local textLabel2 = value32.Billboard:FindFirstChildWhichIsA("TextLabel")
          textLabel2.Text = p34 and f22(value32.Name) .. " " .. value32.Name or value32.Name
        end
      end
    end)

    visualSETTINGSSection2:CreateSlider("Max Distance", 50, 500, v10.MaxDistance, function(maxDistance3)
      v10.MaxDistance = maxDistance3

      for key31, value33 in pairs(v9.Items) do
        if value33.Billboard then
          value33.Billboard.MaxDistance = maxDistance3
        end
      end
    end)

    visualSETTINGSSection2:CreateSlider("Text Size", 8, 20, v10.TextSize, function(textSize2)
      v10.TextSize = textSize2

      for key32, value34 in pairs(v9.Items) do
        if value34.Billboard and value34.Billboard:FindFirstChildWhichIsA("TextLabel") then
          local billboard = value34.Billboard
          billboard:FindFirstChildWhichIsA("TextLabel").TextSize = textSize2
        end
      end
    end)

    itemESPTab:CreateSection("ITEM FILTERS"):CreateToggle("🩹 Medkits", v10.EnabledItems.Medkit, function(medkit)
      v10.EnabledItems.Medkit = medkit

      if v9.Enabled then
        f28()
        wait(0.1)
        f27()
      end
    end)

    local foodITEMSSection = itemESPTab:CreateSection("FOOD ITEMS")

    for index3, value35 in ipairs({
      "Apple", "Banana", "Beans", "Burger", "Chips", "Chocolate", "Cookie", "Fish Crackers",
      "Hotdog", "Ice Cream", "Lemon", "Lemon Slice", "Meatballs", "Pizza", "Striped Donut",
    }) do
      local v53 = value35

      foodITEMSSection:CreateToggle(f22(v53) .. " " .. v53, v10.EnabledItems[v53], function(p35)
        v10.EnabledItems[v53] = p35

        if v9.Enabled then
          f28()
          wait(0.1)
          f27()
        end
      end)
    end

    local drinkITEMSSection = itemESPTab:CreateSection("DRINK ITEMS")

    for index4, value36 in ipairs({ "2 Litre Dr. Bob", "Bloxy Soda", "Dr. Bob Soda", "Water" }) do
      local v54 = value36

      drinkITEMSSection:CreateToggle(f22(v54) .. " " .. v54, v10.EnabledItems[v54], function(p36)
        v10.EnabledItems[v54] = p36

        if v9.Enabled then
          f28()
          wait(0.1)
          f27()
        end
      end)
    end

    local quickPRESETSSection = itemESPTab:CreateSection("QUICK PRESETS")

    quickPRESETSSection:CreateButton("🩹 Medkits Only", function()
      for key33, value37 in pairs(v10.EnabledItems) do
        v10.EnabledItems[key33] = key33 == "Medkit"
      end

      if v9.Enabled then
        f28()
        wait(0.1)
        f27()
      end

      notifications:Success("Showing medkits only", 3)
    end)

    quickPRESETSSection:CreateButton("🥤 Drinks Only", function()
      for key34, value38 in pairs(v10.EnabledItems) do
        v10.EnabledItems[key34] = v11[key34] == "Drink"
      end

      if v9.Enabled then
        f28()
        wait(0.1)
        f27()
      end

      notifications:Info("Showing drinks only", 3)
    end)

    quickPRESETSSection:CreateButton("🍔 Food Only", function()
      for key35, value39 in pairs(v10.EnabledItems) do
        v10.EnabledItems[key35] = v11[key35] == "Food"
      end

      if v9.Enabled then
        f28()
        wait(0.1)
        f27()
      end

      notifications:Info("Showing food only", 3)
    end)

    quickPRESETSSection:CreateButton("✅ All Items", function()
      for key36, value40 in pairs(v10.EnabledItems) do
        v10.EnabledItems[key36] = true
      end

      if v9.Enabled then
        f28()
        wait(0.1)
        f27()
      end

      notifications:Info("Showing all items", 3)
    end)

    f20()

    print("✅ Item ESP System Loaded!")
    print("📦 Features: Billboard + Highlight ESP")
    print("⚡ Performance: Lightweight with distance culling")

    local teleportTab = v3:CreateTab("Teleport", "🚀")

    local section5 = teleportTab:CreateSection("TELEPORT TO CLOSEST ITEM")

    section5:CreateButton("💾 Save Current Position", function()
      if f29() then
        notifications:Success("Position saved!", 3)
      else
        notifications:Error("Failed to save position", 3)
      end
    end)

    section5:CreateButton("🔙 Return to Saved Position", function() f36() end)
    section5:CreateButton("📦 Teleport to Closest Item", function() f35() end)

    teleportTab:CreateSection("TELEPORT TO SPECIFIC ITEMS"):CreateButton("🩹 Teleport to Closest Medkit", function()
      f34("Medkit")
    end)

    local foodITEMSSection2 = teleportTab:CreateSection("FOOD ITEMS")

    for index5, value41 in ipairs({
      "Apple", "Banana", "Beans", "Burger", "Chips", "Chocolate", "Cookie", "Fish Crackers",
      "Hotdog", "Ice Cream", "Lemon", "Lemon Slice", "Meatballs", "Pizza", "Striped Donut",
    }) do
      local v55 = value41
      foodITEMSSection2:CreateButton("🍴 Teleport to Closest " .. v55, function() f34(v55) end)
    end

    local drinkITEMSSection2 = teleportTab:CreateSection("DRINK ITEMS")

    for index6, value42 in ipairs({ "2 Litre Dr. Bob", "Bloxy Soda", "Dr. Bob Soda", "Water" }) do
      local v56 = value42

      drinkITEMSSection2:CreateButton("🥤 Teleport to Closest " .. v56, function()
        f34(v56)
      end)
    end

    local quickFILTERSSection = teleportTab:CreateSection("QUICK FILTERS")

    quickFILTERSSection:CreateButton("🩹 Medkits Only", function()
      for key37, value43 in pairs(v13.EnabledItems) do
        v13.EnabledItems[key37] = key37 == "Medkit"
      end

      notifications:Info("Now filtering for medkits only", 3)
    end)

    quickFILTERSSection:CreateButton("🥤 Drinks Only", function()
      for key38, value44 in pairs(v13.EnabledItems) do
        local enabledItems = v13.EnabledItems

        enabledItems[key38] = string.find(key38, "Bob") or string.find(key38, "Soda")
          or key38 == "Water"
      end

      notifications:Info("Now filtering for drinks only", 3)
    end)

    quickFILTERSSection:CreateButton("🍔 Food Only", function()
      for key39, value45 in pairs(v13.EnabledItems) do
        local enabledItems2 = v13.EnabledItems

        enabledItems2[key39] = not string.find(key39, "Bob") and not string.find(key39, "Soda")
          and key39 ~= "Water" and key39 ~= "Medkit"
      end

      notifications:Info("Now filtering for food only", 3)
    end)

    quickFILTERSSection:CreateButton("✅ All Items", function()
      for key40, value46 in pairs(v13.EnabledItems) do
        v13.EnabledItems[key40] = true
      end

      notifications:Info("Now showing all items", 3)
    end)

    local teleportSETTINGSSection = teleportTab:CreateSection("TELEPORT SETTINGS")

    teleportSETTINGSSection:CreateSlider("Search Range", 100, 10000, v13.TeleportRange, function(p37)
      v13.TeleportRange = p37
      notifications:Info("Search range set to " .. p37 .. " studs", 3)
    end)

    teleportSETTINGSSection:CreateSlider("Return Delay", 1, 10, v13.ReturnDelay, function(p38)
      v13.ReturnDelay = p38
      notifications:Info("Return delay set to " .. p38 .. " seconds", 3)
    end)

    teleportSETTINGSSection:CreateSlider("Teleport Cooldown", 0.5, 5, v13.TeleportCooldown, function(p39)
      v13.TeleportCooldown = p39
      notifications:Info("Cooldown set to " .. p39 .. " seconds", 3)
    end)

    local debugINFOSection2 = teleportTab:CreateSection("DEBUG & INFO")

    debugINFOSection2:CreateButton("🔍 Find All Items in Range", function()
      local v57 = f32()
      print("📦 ALL ITEMS IN RANGE (" .. v13.TeleportRange .. " studs):")

      for index7, value47 in ipairs(v57) do
        print(string.format(
          "   %d. %s (%.1f studs away)", index7, value47.Name, value47.Distance
        ))
      end

      if #v57 > 0 then
        notifications:Success("Found " .. #v57 .. " items in range - check console", 3)
      else
        notifications:Warning("No items found in range", 3)
      end
    end)

    debugINFOSection2:CreateButton("📍 Find Closest of Each Type", function()
      print("📍 CLOSEST ITEMS OF EACH TYPE:")
      local v58 = {}

      for key41, value48 in pairs(v13.EnabledItems) do
        if value48 then
          table.insert(v58, key41)
        end
      end

      for index8, value49 in ipairs(v58) do
        local v59 = f33(value49)

        if v59 then
          print(string.format("   %s: %.1f studs away", value49, v59.Distance))
        else
          print(string.format("   %s: Not found in range", value49))
        end
      end

      notifications:Info("Closest items listed in console", 3)
    end)

    debugINFOSection2:CreateButton("🧪 Test Single Teleport", function()
      local v60 = f32()

      if #v60 > 0 then
        local v61 = v60[1]

        print("🧪 TESTING SINGLE TELEPORT:")
        print("   Item: " .. v61.Name)
        print("   Distance: " .. string.format("%.1f", v61.Distance) .. " studs")

        f31(v61.Instance, v61.Name)
      else
        notifications:Warning("No items found to test with", 3)
      end
    end)

    print("✅ Single Item Teleport System Loaded!")
    print("🚀 Features: Teleport to closest item, auto-return")
    print("📏 Search Range: " .. v13.TeleportRange .. " studs")

    v14 = {
      NightVision = { Enabled = false, OriginalLighting = nil, Intensity = 1 },
      XRayVision = { Enabled = false, OriginalTransparency = {}, WallMaterial = "ForceField" },
      FullBright = {
        Enabled = false,
        OriginalBrightness = nil,
        OriginalAmbient = nil,
        OriginalOutdoorAmbient = nil,
      },
      WalkSpeed = { Enabled = false, OriginalSpeed = 16, CustomSpeed = 50 },
      JumpPower = { Enabled = false, OriginalPower = 50, CustomPower = 100 },
      NoClip = { Enabled = false, OriginalCollisions = {}, Noclipping = false },
      InfiniteJump = { Enabled = false, JumpCooldown = 0 },
      FieldOfView = { Enabled = false, OriginalFOV = 70, CustomFOV = 90 },
      CameraShake = { Enabled = false, Intensity = 1, ShakeLoop = nil },
    }

    localPlayer = players.LocalPlayer

    function f37(p40)
      if v14.NightVision.Enabled == p40 then
        return
      end

      if p40 then
        v14.NightVision.OriginalLighting = {
          Ambient = lighting.Ambient,
          Brightness = lighting.Brightness,
          OutdoorAmbient = lighting.OutdoorAmbient,
        }

        lighting.Ambient = Color3.new(0.3, 0.3, 0.3)
        lighting.Brightness = 2
        lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)

        local currentCamera4 = v1.CurrentCamera

        if currentCamera4 then
          local nightVisionBloom = Instance.new("BloomEffect")
          nightVisionBloom.Name = "NightVisionBloom"
          nightVisionBloom.Intensity = 0.2
          nightVisionBloom.Threshold = 0.7
          nightVisionBloom.Size = 24
          nightVisionBloom.Parent = currentCamera4
        end

        v14.NightVision.Enabled = true
        notifications:Success("Night Vision: ON 🌙", 3)
      else
        if v14.NightVision.OriginalLighting then
          lighting.Ambient = v14.NightVision.OriginalLighting.Ambient
          lighting.Brightness = v14.NightVision.OriginalLighting.Brightness
          lighting.OutdoorAmbient = v14.NightVision.OriginalLighting.OutdoorAmbient
        end

        local currentCamera5 = v1.CurrentCamera

        if currentCamera5 then
          local nightVisionBloom2 = currentCamera5:FindFirstChild("NightVisionBloom")

          if nightVisionBloom2 then
            nightVisionBloom2:Destroy()
          end
        end

        v14.NightVision.Enabled = false
        notifications:Info("Night Vision: OFF", 3)
      end
    end

    function f38(p41)
      if v14.XRayVision.Enabled == p41 then
        return
      end

      if p41 then
        v14.XRayVision.OriginalTransparency = {}

        for key42, value50 in pairs(v1:GetDescendants()) do
          if value50:IsA("BasePart") and value50.Transparency < 0.5 then
            if value50.Name:lower():find("wall") or value50.Name:lower():find("barrier")
              or value50.Name:lower():find("obstacle")
              or value50.Material == Enum.Material.Plastic
              or value50.Material == Enum.Material.Wood
              or value50.Material == Enum.Material.Concrete then
              v14.XRayVision.OriginalTransparency[value50] = value50.Transparency
              value50.Transparency = 0.7
              value50.Material = Enum.Material.ForceField
            end
          end
        end

        v14.XRayVision.Enabled = true
        notifications:Success("X-Ray Vision: ON 🔍", 3)
      else
        for key43, value51 in pairs(v14.XRayVision.OriginalTransparency) do
          if key43 and key43.Parent then
            key43.Transparency = value51
            key43.Material = Enum.Material.Plastic
          end
        end

        v14.XRayVision.OriginalTransparency = {}
        v14.XRayVision.Enabled = false

        notifications:Info("X-Ray Vision: OFF", 3)
      end
    end

    function f39(p42)
      if v14.FullBright.Enabled == p42 then
        return
      end

      if p42 then
        v14.FullBright.OriginalBrightness = lighting.Brightness
        v14.FullBright.OriginalAmbient = lighting.Ambient
        v14.FullBright.OriginalOutdoorAmbient = lighting.OutdoorAmbient

        lighting.Brightness = 2
        lighting.Ambient = Color3.new(1, 1, 1)
        lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        lighting.GlobalShadows = false
        lighting.ClockTime = 14

        v14.FullBright.Enabled = true
        notifications:Success("Full Bright: ON 💡", 3)
      else
        if v14.FullBright.OriginalBrightness then
          lighting.Brightness = v14.FullBright.OriginalBrightness
        end

        if v14.FullBright.OriginalAmbient then
          lighting.Ambient = v14.FullBright.OriginalAmbient
        end

        if v14.FullBright.OriginalOutdoorAmbient then
          lighting.OutdoorAmbient = v14.FullBright.OriginalOutdoorAmbient
        end

        lighting.GlobalShadows = true
        v14.FullBright.Enabled = false
        notifications:Info("Full Bright: OFF")
      end
    end

    function f40()
      local character = localPlayer.Character

      if not character then
        return
      else
        local humanoid2 = character:FindFirstChildOfClass("Humanoid")

        if not humanoid2 then
          return
        end

        if v14.WalkSpeed.Enabled then
          humanoid2.WalkSpeed = v14.WalkSpeed.CustomSpeed
        else
          humanoid2.WalkSpeed = v14.WalkSpeed.OriginalSpeed
        end

        return
      end
    end

    function f41(p43)
      v14.WalkSpeed.Enabled = p43
      f40()

      if p43 then
        notifications:Success("Custom Walk Speed: " .. v14.WalkSpeed.CustomSpeed .. " 🚀", 3)
      else
        notifications:Info("Walk Speed: Reset to default", 3)
      end
    end

    function f42()
      local character2 = localPlayer.Character

      if not character2 then
        return
      else
        local humanoid3 = character2:FindFirstChildOfClass("Humanoid")

        if not humanoid3 then
          return
        end

        if v14.JumpPower.Enabled then
          humanoid3.JumpPower = v14.JumpPower.CustomPower
        else
          humanoid3.JumpPower = v14.JumpPower.OriginalPower
        end

        return
      end
    end

    function f43(p44)
      v14.JumpPower.Enabled = p44
      f42()

      if p44 then
        notifications:Success("Custom Jump Power: " .. v14.JumpPower.CustomPower .. " 🦘", 3)
      else
        notifications:Info("Jump Power: Reset to default", 3)
      end
    end

    function f44(p45)
      v14.NoClip.Enabled = p45

      if p45 then
        notifications:Success("NoClip: ON 👻", 3)
        v14.NoClip.Noclipping = true

        spawn(function()
          while v14.NoClip.Noclipping do
            wait(0.1)
            local character3 = localPlayer.Character

            if character3 then
              for key44, value52 in pairs(character3:GetDescendants()) do
                if value52:IsA("BasePart") and value52.CanCollide then
                  value52.CanCollide = false
                end
              end
            end
          end
        end)
      else
        v14.NoClip.Noclipping = false
        local character4 = localPlayer.Character

        if character4 then
          for key45, value53 in pairs(character4:GetDescendants()) do
            if value53:IsA("BasePart") then
              value53.CanCollide = true
            end
          end
        end

        notifications:Info("NoClip: OFF", 3)
      end
    end

    function f45(p46)
      v14.InfiniteJump.Enabled = p46

      if p46 then
        notifications:Success("Infinite Jump: ON ∞", 3)
        local jumpRequest = userInputService.JumpRequest

        v14.InfiniteJump.Connection = jumpRequest:Connect(function()
          if v14.InfiniteJump.Enabled then
            local character5 = localPlayer.Character

            if character5 and tick() - v14.InfiniteJump.JumpCooldown > 0.2 then
              local humanoid4 = character5:FindFirstChildOfClass("Humanoid")

              if humanoid4 and humanoid4:GetState() == Enum.HumanoidStateType.Freefall then
                humanoid4:ChangeState(Enum.HumanoidStateType.Jumping)
                v14.InfiniteJump.JumpCooldown = tick()
              end
            end
          end
        end)
      else
        if v14.InfiniteJump.Connection then
          v14.InfiniteJump.Connection:Disconnect()
          v14.InfiniteJump.Connection = nil
        end

        notifications:Info("Infinite Jump: OFF", 3)
      end
    end

    function f46()
      local currentCamera6 = v1.CurrentCamera

      if not currentCamera6 then
        return
      end

      if v14.FieldOfView.Enabled then
        currentCamera6.FieldOfView = v14.FieldOfView.CustomFOV
      else
        currentCamera6.FieldOfView = v14.FieldOfView.OriginalFOV
      end
    end

    function f47(p47)
      v14.FieldOfView.Enabled = p47
      f46()

      if p47 then
        notifications:Success("Custom FOV: " .. v14.FieldOfView.CustomFOV .. " 📷", 3)
      else
        notifications:Info("Field of View: Reset to default", 3)
      end
    end

    function f48(p48)
      if v14.CameraShake.Enabled == p48 then
        return
      end

      if p48 then
        notifications:Success("Camera Shake: ON 📸", 3)
        local heartbeat2 = runService.Heartbeat

        v14.CameraShake.ShakeLoop = heartbeat2:Connect(function()
          local currentCamera7 = v1.CurrentCamera

          if currentCamera7 then
            local v62 = math.random(-v14.CameraShake.Intensity, v14.CameraShake.Intensity)
            local v63 = math.random(-v14.CameraShake.Intensity, v14.CameraShake.Intensity)
            local vector4 = Vector3.new(v62 * 0.1, v63 * 0.1, 0)
            currentCamera7.CFrame = currentCamera7.CFrame + vector4
          end
        end)

        v14.CameraShake.Enabled = true
      else
        if v14.CameraShake.ShakeLoop then
          v14.CameraShake.ShakeLoop:Disconnect()
          v14.CameraShake.ShakeLoop = nil
        end

        v14.CameraShake.Enabled = false
        notifications:Info("Camera Shake: OFF", 3)
      end
    end

    function f49()
      local character6 = localPlayer.Character

      if character6 then
        character6:BreakJoints()
        notifications:Success("Character reset! 🔄", 3)
      else
        notifications:Warning("No character found to reset", 3)
      end
    end

    local playerTab = v3:CreateTab("Player", "🎮")

    local visionENHANCEMENTSSection = playerTab:CreateSection("VISION ENHANCEMENTS")

    visionENHANCEMENTSSection:CreateToggle("🌙 Night Vision", false, function(p49)
      f37(p49)
    end)

    visionENHANCEMENTSSection:CreateToggle("🔍 X-Ray Vision", false, function(p50)
      f38(p50)
    end)

    visionENHANCEMENTSSection:CreateToggle("💡 Full Bright", false, function(p51) f39(p51) end)

    local movementENHANCEMENTSSection = playerTab:CreateSection("MOVEMENT ENHANCEMENTS")

    movementENHANCEMENTSSection:CreateToggle("🚀 Custom Walk Speed", false, function(p52)
      f41(p52)
    end)

    movementENHANCEMENTSSection:CreateSlider("Walk Speed Value", 16, 200, v14.WalkSpeed.CustomSpeed, function(p53)
      v14.WalkSpeed.CustomSpeed = p53

      if v14.WalkSpeed.Enabled then
        f40()
      end

      notifications:Success("Walk Speed: " .. p53, 3)
    end)

    movementENHANCEMENTSSection:CreateToggle("🦘 Custom Jump Power", false, function(p54)
      f43(p54)
    end)

    movementENHANCEMENTSSection:CreateSlider("Jump Power Value", 50, 500, v14.JumpPower.CustomPower, function(p55)
      v14.JumpPower.CustomPower = p55

      if v14.JumpPower.Enabled then
        f42()
      end

      notifications:Info("Jump Power: " .. p55, 3)
    end)

    movementENHANCEMENTSSection:CreateToggle("👻 NoClip", false, function(p56) f44(p56) end)

    movementENHANCEMENTSSection:CreateToggle("∞ Infinite Jump", false, function(p57)
      f45(p57)
    end)

    local cameraSETTINGSSection = playerTab:CreateSection("CAMERA SETTINGS")

    cameraSETTINGSSection:CreateToggle("📷 Custom Field of View", false, function(p58)
      f47(p58)
    end)

    cameraSETTINGSSection:CreateSlider("Field of View", 30, 120, v14.FieldOfView.CustomFOV, function(p59)
      v14.FieldOfView.CustomFOV = p59

      if v14.FieldOfView.Enabled then
        f46()
      end

      notifications:Info("FOV: " .. p59, 3)
    end)

    cameraSETTINGSSection:CreateToggle("📸 Camera Shake", false, function(p60) f48(p60) end)

    cameraSETTINGSSection:CreateSlider("Shake Intensity", 1, 10, v14.CameraShake.Intensity, function(p61)
      v14.CameraShake.Intensity = p61
      notifications:Info("Shake Intensity: " .. p61, 3)
    end)

    local characterMANAGEMENTSection = playerTab:CreateSection("CHARACTER MANAGEMENT")
    characterMANAGEMENTSection:CreateButton("🔄 Reset Character", function() f49() end)

    characterMANAGEMENTSection:CreateButton("💾 Save Default Settings", function()
      local character7 = localPlayer.Character

      if character7 then
        local humanoid5 = character7:FindFirstChildOfClass("Humanoid")

        if humanoid5 then
          v14.WalkSpeed.OriginalSpeed = humanoid5.WalkSpeed
          v14.JumpPower.OriginalPower = humanoid5.JumpPower
          notifications:Success("Default settings saved!", 3)
        end
      end
    end)

    local quickPRESETSSection2 = playerTab:CreateSection("QUICK PRESETS")

    quickPRESETSSection2:CreateButton("⚡ Speed Runner", function()
      f41(true)
      v14.WalkSpeed.CustomSpeed = 100
      f40()
      notifications:Success("Speed Runner preset activated! ⚡", 3)
    end)

    quickPRESETSSection2:CreateButton("🦅 High Jumper", function()
      f43(true)
      v14.JumpPower.CustomPower = 200
      f42()
      f45(true)
      notifications:Success("High Jumper preset activated! 🦅", 3)
    end)

    quickPRESETSSection2:CreateButton("👁️ All Vision", function()
      f37(true)
      f38(true)
      f39(true)
      notifications:Success("All Vision modes activated! 👁️", 3)
    end)

    quickPRESETSSection2:CreateButton("🔄 Reset All", function()
      f37(false)
      f38(false)
      f39(false)
      f41(false)
      f43(false)
      f44(false)
      f45(false)
      f47(false)
      f48(false)
      notifications:Success("All enhancements reset! 🔄", 3)
    end)

    localPlayer.CharacterAdded:Connect(function(character8)
      wait(1)

      if v14.WalkSpeed.Enabled then
        f40()
      end

      if v14.JumpPower.Enabled then
        f42()
      end

      if v14.NoClip.Enabled then
        f44(true)
      end

      if v14.FieldOfView.Enabled then
        f46()
      end
    end)

    spawn(function()
      wait(2)
      local currentCamera8 = v1.CurrentCamera

      if currentCamera8 then
        v14.FieldOfView.OriginalFOV = currentCamera8.FieldOfView
      end
    end)

    print("✅ Player Enhancements Tab Fully Loaded!")
    print("🎮 Features: Vision, Movement, Camera, Character controls")

    v15 = {
      Enabled = false,
      OriginalSettings = {},
      PerformanceMode = false,
      AntiAFKEnabled = false,
      AutoRejoinEnabled = false,
      RejoinAttempts = 0,
      MaxRejoinAttempts = 3,
      LastActivityTime = tick(),
      GraphicsQuality = "Auto",
    }

    v16 = { Enabled = false, OriginalGraphics = {}, CurrentSettings = {} }

    function f50()
      local userGameSettings = UserSettings():GetService("UserGameSettings")

      v16.OriginalGraphics = {
        Lighting = {
          GlobalShadows = lighting.GlobalShadows,
          Brightness = lighting.Brightness,
          FogEnd = lighting.FogEnd,
          FogStart = lighting.FogStart,
          EnvironmentDiffuseScale = lighting.EnvironmentDiffuseScale,
          EnvironmentSpecularScale = lighting.EnvironmentSpecularScale,
          ShadowSoftness = lighting.ShadowSoftness,
          GeographicLatitude = lighting.GeographicLatitude,
          Ambient = lighting.Ambient,
          OutdoorAmbient = lighting.OutdoorAmbient,
          ClockTime = lighting.ClockTime,
          ExposureCompensation = lighting.ExposureCompensation,
        },
        Rendering = {
          QualityLevel = settings().Rendering.QualityLevel,
          MeshPartDetailLevel = settings().Rendering.MeshPartDetailLevel,
          EagerBulkExecution = runService:IsEagerBulkExecutionEnabled(),
        },
        GameSettings = { SavedQualityLevel = userGameSettings.SavedQualityLevel },
      }

      print("💾 Original graphics settings saved")
    end

    function f51()
      local userGameSettings2 = UserSettings():GetService("UserGameSettings")

      lighting.GlobalShadows = false
      lighting.Brightness = 2
      lighting.FogEnd = 100000
      lighting.FogStart = 0
      lighting.EnvironmentDiffuseScale = 0
      lighting.EnvironmentSpecularScale = 0
      lighting.ShadowSoftness = 0
      lighting.GeographicLatitude = 41.733
      lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
      lighting.OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
      lighting.ClockTime = 14
      lighting.ExposureCompensation = 0

      for key46, value54 in pairs(lighting:GetChildren()) do
        if value54:IsA("BloomEffect") or value54:IsA("BlurEffect")
          or value54:IsA("ColorCorrectionEffect") or value54:IsA("SunRaysEffect")
          or value54:IsA("DepthOfFieldEffect") then
          value54.Enabled = false
        end
      end

      settings().Rendering.QualityLevel = 1
      settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04

      userGameSettings2.SavedQualityLevel = Enum.SavedQualitySetting.Level01
      runService:SetEagerBulkExecutionMode(true)

      for key47, value55 in pairs(workspace:GetDescendants()) do
        if value55:IsA("ParticleEmitter") or value55:IsA("Fire") or value55:IsA("Smoke") then
          value55.Enabled = false
        end
      end

      v16.CurrentSettings = {
        QualityLevel = 1,
        Shadows = false,
        Particles = false,
        LightingEffects = false,
      }

      print("🚀 Maximum performance mode activated")
    end

    function f52()
      local userGameSettings3 = UserSettings():GetService("UserGameSettings")

      lighting.GlobalShadows = true
      lighting.Brightness = 3
      lighting.FogEnd = 100000
      lighting.EnvironmentDiffuseScale = 0.3
      lighting.EnvironmentSpecularScale = 0.3
      lighting.ShadowSoftness = 0.1

      settings().Rendering.QualityLevel = 5
      userGameSettings3.SavedQualityLevel = Enum.SavedQualitySetting.Level05

      for key48, value56 in pairs(workspace:GetDescendants()) do
        if value56:IsA("ParticleEmitter") then
          value56.Enabled = true
        end
      end

      v16.CurrentSettings = {
        QualityLevel = 5,
        Shadows = true,
        Particles = true,
        LightingEffects = true,
      }

      print("⚖️ Balanced performance mode activated")
    end

    function f53()
      if not v16.OriginalGraphics.Lighting then
        print("❌ No original settings saved")
        return false
      else
        local userGameSettings4 = UserSettings():GetService("UserGameSettings")

        for key49, value57 in pairs(v16.OriginalGraphics.Lighting) do
          lighting[key49] = value57
        end

        settings().Rendering.QualityLevel = v16.OriginalGraphics.Rendering.QualityLevel
        settings().Rendering.MeshPartDetailLevel = v16.OriginalGraphics.Rendering.MeshPartDetailLevel

        userGameSettings4.SavedQualityLevel = v16.OriginalGraphics.GameSettings.SavedQualityLevel
        runService:SetEagerBulkExecutionMode(v16.OriginalGraphics.Rendering.EagerBulkExecution)

        for key50, value58 in pairs(workspace:GetDescendants()) do
          if value58:IsA("ParticleEmitter") or value58:IsA("Fire") or value58:IsA("Smoke") then
            value58.Enabled = true
          end
        end

        v16.CurrentSettings = {}
        print("🎨 Original graphics restored")
        return true
      end
    end

    v17 = {
      Enabled = false,
      MovementPatterns = { "SmallCircle", "FigureEight", "RandomWalk" },
      LastMovement = tick(),
      MovementInterval = 10,
    }

    function f54()
      virtualInputManager:SendMouseMoveEvent(5, 5, v1)
      wait(0.1)

      virtualInputManager:SendMouseMoveEvent(-5, -5, v1)
      virtualInputManager:SendKeyEvent(true, Enum.KeyCode.W, false, game)

      wait(0.05)
      virtualInputManager:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end

    function f55()
      if v17.Enabled then
        return
      end

      v17.Enabled = true

      spawn(function()
        while v17.Enabled do
          v15.LastActivityTime = tick()
          wait(v17.MovementInterval + math.random(-2, 2))
        end
      end)

      print("🤖 Anti-AFK system activated")
    end

    function f56()
      v17.Enabled = false
      print("⏹️ Anti-AFK system stopped")
    end

    v18 = {
      Enabled = false,
      RejoinAttempts = 0,
      MaxRejoinAttempts = 5,
      RejoinDelay = 10,
      LastDisconnectTime = 0,
    }

    function f57()
      players.PlayerRemoving:Connect(function(player)
        if player == players.LocalPlayer and v18.Enabled then
          v18.LastDisconnectTime = tick()
          print("🔌 Player disconnected, preparing auto-rejoin...")

          spawn(function()
            wait(v18.RejoinDelay)

            if v18.RejoinAttempts < v18.MaxRejoinAttempts then
              v18.RejoinAttempts = v18.RejoinAttempts + 1
              print("🔄 Rejoin attempt " .. v18.RejoinAttempts .. "/" .. v18.MaxRejoinAttempts)

              if not pcall(function() teleportService:Teleport(game.PlaceId, players.LocalPlayer) end) then
                print("❌ Rejoin failed, will retry...")
              end
            else
              print("🚫 Max rejoin attempts reached")
            end
          end)
        end
      end)
    end

    function f58()
      local localPlayer7 = players.LocalPlayer
      local v64, v65 = pcall(function() teleportService:Teleport(game.PlaceId, localPlayer7) end)

      if v64 then
        print("🔄 Rejoining game...")
      else
        print("❌ Rejoin failed: " .. tostring(v65))
      end
    end

    v19 = { Enabled = false, OptimizedParts = {} }

    function f59()
      local count5 = 0

      for key51, value59 in pairs(workspace:GetDescendants()) do
        if value59:IsA("Part") or value59:IsA("MeshPart") or value59:IsA("UnionOperation") then
          if value59.Material ~= Enum.Material.Plastic then
            value59.Material = Enum.Material.Plastic
          end

          if value59.Name:lower():find("decoration") or value59.Name:lower():find("detail") then
            value59.CanCollide = false
          end

          table.insert(v19.OptimizedParts, {
            Object = value59,
            OriginalMaterial = value59.Material,
            OriginalCanCollide = value59.CanCollide,
          })

          count5 = count5 + 1
        elseif value59:IsA("Sound") then
          value59.PlaybackSpeed = 1
          value59.Volume = math.min(value59.Volume, 0.5)
        end
      end

      print("🔧 Optimized " .. count5 .. " workspace objects")
    end

    function f60()
      local currentCamera9 = workspace.CurrentCamera

      if currentCamera9 then
        currentCamera9.FieldOfView = 70
        print("📐 Render distance optimizations applied")
      end
    end

    v20 = {
      Enabled = false,
      LastFPS = 0,
      FPSHistory = {},
      MemoryUsage = 0,
    }

    function f61()
      v20.Enabled = true

      spawn(function()
        while v20.Enabled do
          local v66 = runService.RenderStepped:Wait()
          table.insert(v20.FPSHistory, 1 / v66)

          if #v20.FPSHistory > 60 then
            table.remove(v20.FPSHistory, 1)
          end

          v20.MemoryUsage = stats:GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.Script)
          wait(1)
        end
      end)
    end

    function f62()
      if #v20.FPSHistory == 0 then
        return 0
      else
        local total = 0

        for key52, value60 in pairs(v20.FPSHistory) do
          total = total + value60
        end

        return math.floor(total / #v20.FPSHistory)
      end
    end

    local performanceUtilityTab = v3:CreateTab("Performance & Utility", "⚡")

    local fpsBOOSTSection = performanceUtilityTab:CreateSection("FPS BOOST")

    fpsBOOSTSection:CreateButton("💾 Save Original Settings", function()
      f50()
      notifications:Success("Original settings saved!", 3)
    end)

    fpsBOOSTSection:CreateButton("🚀 MAXIMUM PERFORMANCE", function()
      f51()
      notifications:Success("Maximum performance mode activated!", 3)
    end)

    fpsBOOSTSection:CreateButton("⚖️ BALANCED PERFORMANCE", function()
      f52()
      notifications:Success("Balanced performance mode activated!", 3)
    end)

    fpsBOOSTSection:CreateButton("🎨 RESTORE ORIGINAL", function()
      if f53() then
        notifications:Success("Original graphics restored!", 3)
      else
        notifications:Error("No original settings saved!", 3)
      end
    end)

    fpsBOOSTSection:CreateButton("🔧 OPTIMIZE WORKSPACE", function()
      f59()
      notifications:Success("Workspace optimized!", 3)
    end)

    fpsBOOSTSection:CreateButton("📐 REDUCE RENDER DISTANCE", function()
      f60()
      notifications:Success("Render distance optimized!", 3)
    end)

    local section6 = performanceUtilityTab:CreateSection("ANTI-AFK SYSTEM")

    section6:CreateToggle("🤖 Enable Anti-AFK", false, function(p62)
      if p62 then
        f55()
        notifications:Success("Anti-AFK enabled!", 3)
      else
        f56()
        notifications:Info("Anti-AFK disabled", 3)
      end
    end)

    section6:CreateSlider("Movement Interval", 5, 30, v17.MovementInterval, function(p63)
      v17.MovementInterval = p63
      notifications:Info("Movement interval: " .. p63 .. "s", 3)
    end)

    section6:CreateButton("🔄 Simulate Activity", function()
      f54()
      notifications:Success("Activity simulated!", 3)
    end)

    local section7 = performanceUtilityTab:CreateSection("AUTO-REJOIN SYSTEM")

    section7:CreateToggle("🔄 Enable Auto-Rejoin", false, function(p64)
      v18.Enabled = p64

      if p64 then
        f57()
        notifications:Success("Auto-rejoin enabled!", 3)
      else
        notifications:Info("Auto-rejoin disabled", 3)
      end
    end)

    section7:CreateButton("🚀 QUICK REJOIN", function() f58() end)

    section7:CreateSlider("Rejoin Delay", 5, 30, v18.RejoinDelay, function(p65)
      v18.RejoinDelay = p65
      notifications:Info("Rejoin delay: " .. p65 .. "s", 3)
    end)

    local performanceMONITORSection = performanceUtilityTab:CreateSection("PERFORMANCE MONITOR")

    performanceMONITORSection:CreateToggle("📊 Enable Performance Monitor", false, function(p66)
      v20.Enabled = p66

      if p66 then
        f61()
        notifications:Success("Performance monitor started!", 3)
      else
        notifications:Info("Performance monitor stopped", 3)
      end
    end)

    performanceMONITORSection:CreateButton("📈 Show Performance Stats", function()
      local v67 = f62()

      print("📊 PERFORMANCE STATISTICS:")
      print("   Average FPS: " .. v67)
      print("   Memory Usage: " .. string.format("%.1f", v20.MemoryUsage) .. " MB")
      print("   Tracked Frames: " .. #v20.FPSHistory)
      print("   Anti-AFK: " .. tostring(v17.Enabled))
      print("   Auto-Rejoin: " .. tostring(v18.Enabled))

      notifications:Info("Performance stats printed to console", 3)
    end)

    local advancedOPTIMIZATIONSSection = performanceUtilityTab:CreateSection("ADVANCED OPTIMIZATIONS")

    advancedOPTIMIZATIONSSection:CreateButton("🎯 DISABLE ALL PARTICLES", function()
      local count6 = 0

      for key53, value61 in pairs(workspace:GetDescendants()) do
        if value61:IsA("ParticleEmitter") or value61:IsA("Fire") or value61:IsA("Smoke") then
          value61.Enabled = false
          count6 = count6 + 1
        end
      end

      notifications:Success("Disabled " .. count6 .. " particle effects!", 3)
    end)

    advancedOPTIMIZATIONSSection:CreateButton("🔇 REDUCE ALL SOUNDS", function()
      local count7 = 0

      for key54, value62 in pairs(workspace:GetDescendants()) do
        if value62:IsA("Sound") then
          value62.Volume = math.min(value62.Volume, 0.3)
          count7 = count7 + 1
        end
      end

      notifications:Success("Reduced " .. count7 .. " sounds!", 3)
    end)

    advancedOPTIMIZATIONSSection:CreateButton("🔄 RESET ALL OPTIMIZATIONS", function()
      f53()

      for key55, value63 in pairs(workspace:GetDescendants()) do
        if value63:IsA("ParticleEmitter") or value63:IsA("Fire") or value63:IsA("Smoke") then
          value63.Enabled = true
        end
      end

      for key56, value64 in pairs(workspace:GetDescendants()) do
        if value64:IsA("Sound") then
          value64.Volume = 1
        end
      end

      notifications:Success("All optimizations reset!", 3)
    end)

    local quickUTILITIESSection = performanceUtilityTab:CreateSection("QUICK UTILITIES")

    quickUTILITIESSection:CreateButton("🧹 CLEAR GAME CACHE", function()
      if pcall(function() contentProvider:ClearAllContent() end) then
        notifications:Success("Game cache cleared!", 3)
      else
        notifications:Warning("Cache clear not fully supported", 3)
      end
    end)

    quickUTILITIESSection:CreateButton("📝 SERVER INFO", function()
      print("📝 SERVER INFORMATION:")
      print("   Players: " .. #players:GetPlayers() .. "/" .. players.MaxPlayers)
      print("   Place ID: " .. game.PlaceId)
      print("   Job ID: " .. game.JobId)
      print("   Lighting: " .. tostring(lighting.GlobalShadows))
      print("   Graphics Level: " .. settings().Rendering.QualityLevel)

      notifications:Info("Server info printed to console", 3)
    end)

    spawn(function()
      wait(3)
      f50()
      f61()
      f57()

      print("✅ Performance & Utility System Fully Loaded!")
      print("⚡ Features: FPS Boost, Anti-AFK, Auto-Rejoin, Performance Monitor")
    end)

    print("✅ [DEBUG] Main 3008 - Abyssal UI fully loaded!")

    return {
      UI = v3,
      Functions = {
        EmployeeESP = { Toggle = toggle3, Start = f9, Stop = f10 },
        TogglePlayerESP = function(p67) toggle:Set(p67) end,
        RefreshPlayers = function()
          if v7.Enabled then
            f19()
            wait(0.1)
            f18()
          else
            f16()
          end
        end,
        CleanupPlayerESP = f11,
        StartPlayerESP = f18,
        StopPlayerESP = f19,
        ToggleItemESP = function(p68) toggle2:Set(p68) end,
        RefreshItemESP = function()
          if v9.Enabled then
            f28()
            wait(0.1)
            f27()
          else
            f25()
          end
        end,
        SavePosition = f29,
        TeleportToClosestItem = f35,
        TeleportToClosestItemOfType = f34,
        FindClosestItemOfType = f33,
        ManualReturn = f36,
        ApplyMaxPerformance = f51,
        ApplyBalancedPerformance = f52,
        RestoreOriginalGraphics = f53,
        StartAntiAFK = f55,
        StopAntiAFK = f56,
        QuickRejoin = f58,
        GetAverageFPS = f62,
        OptimizeWorkspace = f59,
        ReduceRenderDistance = f60,
      },
    }
  end
end

print("🎮 Starting 3008 - Abyssal with heart...")
wait(3)

popup:Success("TIP", [[
 Make sure to press G to get your cursor to interact with the ui

Or any other in game key to enable your cursor to be free]])

wait(3)

popup:Confirm("Hello friend... 👋", [[
I've created something special for you,
but I need to share something personal first.

Can I be vulnerable with you for a moment?]], function(p69)
  if p69 == "Confirm" then
    wait(1)

    popup:Warning("This is difficult to admit...", "I've spent roughtly and entire day building 3008 - Abyssal.\n10,000 people have used my work...\n\nBut I've never received a single like\nor comment from anyone.\n\nIt's been... lonely. 💔", function()
      wait(1.5)

      popup:Confirm("Could you change that?", [[
You could be the first person to show
that my work matters to someone.

Your simple engagement would mean
more than you could possibly know.]], function(p70)
        if p70 == "Confirm" then
          popup:Success(
            "Thank you... 🥹",
            "You just made a developer's entire week.\nMaybe even their month.\n\nThank you for seeing the person\nbehind the code. ❤️",
            6
          )
        else
          popup:Info(
            "I understand...",
            "It's okay. I appreciate you listening.\nThat means something too. 🙏", 4
          )
        end

        wait(2)
        local v68, v69 = pcall(function() f2() end)

        if not v68 then
          print("❌ Support UI failed: " .. tostring(v69))
          f1()
        end
      end)
    end)
  else
    wait(1)

    popup:Info("I understand boundaries...", [[
Let me just say: your support would
mean the world to a tired developer.

Loading 3008 - Abyssal now...]], 5, function()
      wait(2)
      f2()
    end)
  end
end)

print("✅ Emotional support system loaded")
