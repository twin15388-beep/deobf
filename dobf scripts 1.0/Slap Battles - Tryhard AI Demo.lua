--[[
Game: Slap Battles | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Source: https://github.com/CelerityRBLX/Roblox/blob/5fe709f2a15f8b9e900529bc32d6badb78437607/Slap%20Battles/Tryhard%20AI%20Demo.lua
Source SHA-256: 71dd77491da4f847ff87ecc3303b01a8973c6d36e007cbcaba8d5ee2490d5a67
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a on the WeAreDevs/WAD v1.0.0 protected input (banner present); two runs produced byte-identical output.
The 1149-line Lua body below is the decoder output copied unchanged. Identifiers f1..f21, v1..v90 and p1..p17 are decoder-generated, NOT the author's names, and this provenance header is OUR addition, not a recovered author comment.
Game handlers are inline, not a loader: glove selection through replicatedStorage:FindFirstChild(name .. "Slap") with GeneralHit/SnowHit hit remotes fired as b:FireServer(humanoidRootPart), LastSlappedBy watchers (f8) that pick a random retaliator, target priority classes (f9, values 2/3/4), nearest-player search inside 50 studs (f3), a ground raycast guard before Humanoid:MoveTo (f10), per-glove LoadAnimation on the target Animator (f6), a "Control Panel" ScreenGui (f15, DisplayOrder 123) with six toggle buttons (f16..f21: AI on/off, target cycling through v85/v86, "Rigged" mode, 100<->400 setting) and a 10 s Debris status banner (f2).
IMPORTANT DEFECT IN THE ORIGINAL: the body starts with "local v1 = tick() < 1763809636.9279 and tick() > 1763204836.9279" and the whole script lives inside "if v1 then", i.e. it only ever ran between 2025-11-15T11:07:16Z and 2025-11-22T11:07:16Z. That window has expired, so as recovered this script prints the remaining seconds and does nothing else; getgenv().BSF additionally blocks a second execution.
Risks: it attacks other players automatically through the Slap/GeneralHit/SnowHit remotes and posts chat messages with textChatService.TextChannels.RBXGeneral:SendAsync; no currency or item deletion, no file APIs.
No external script or asset is fetched: this body contains no HttpGet/loadstring, only rbxassetid://17184741588 for its own buttons.
The code contains no PlaceId check, was never executed in Roblox, and static recovery proves neither equivalence with the unobfuscated original nor server acceptance of these remotes.
Check reports/game-sources-2026-10-23-wad.md for handler parameters, limits and negative results.
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

local debris = game:GetService("Debris")
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local textChatService = game:GetService("TextChatService")
local runService = game:GetService("RunService")
local v1 = tick() < 1763809636.9279 and tick() > 1763204836.9279

local f1, f2, f3, v2, localPlayer, teleport1, reset, rbxGeneral, v3, v4, v5, v6, position,
  walkSpeed, random, wait, abs, clamp, huge, v7, find, insert, remove, new, heartbeat, v8, v9,
  textSize, v10, v11, v12, debugCube, text, b, slap, f4, instance, f5, v13, v14, loadAnimation,
  instance2, f6, f7, v15, v16, v17, v18, f8, v19, v20, v22, f9, v23, v24, f10, v25, v26, f11,
  v27, v28

if v1 then
  print(1763809636.9279 - tick())

  if getgenv().BSF then
    warn("Already Executed!")
    return
  else
    localPlayer = players.LocalPlayer
    teleport1 = workspace.Lobby.Teleport1
    reset = localPlayer.Reset
    rbxGeneral = textChatService.TextChannels.RBXGeneral
    v3 = {}
    v4 = nil
    v5 = nil
    v6 = nil
    position = workspace.Arena["main island"].Grass.Position
    walkSpeed = 21
    random = math.random
    wait = task.wait
    abs = math.abs
    clamp = math.clamp
    huge = math.huge
    v7 = ipairs
    find = table.find
    insert = table.insert
    remove = table.remove
    new = RaycastParams.new
    heartbeat = runService.Heartbeat
    v8 = true
    v9 = 1
    local viewportSize = workspace.CurrentCamera.ViewportSize
    textSize = 50 * ((viewportSize.X + viewportSize.Y) / 2 / 1500)
    v10 = false
    v11 = true
    v12 = false

    debugCube = Instance.new("Part", workspace)
    debugCube.Name = "DebugCube"
    debugCube.Anchored = true
    debugCube.Size = Vector3.new(2, 2, 2)
    debugCube.Color = Color3.fromRGB(255, 124, 36)
    debugCube.CanCollide = false

    text = "Default"
    b = replicatedStorage.b
    slap = replicatedStorage.Slap

    function f4(p1, thickness, applyStrokeMode, p2)
      local instance3 = Instance.new("UIStroke", p1)
      instance3.Thickness = thickness
      instance3.LineJoinMode = Enum.LineJoinMode.Round
      instance3.ApplyStrokeMode = applyStrokeMode
      instance3.Transparency = p2 or 0
    end

    local function f12(p3, p4, text2)
      local instance4 = Instance.new("ImageLabel", p3)
      instance4.Image = "rbxassetid://17184741588"
      instance4.Size = UDim2.new(0.2, 0, 0.2, 0)
      instance4.AnchorPoint = Vector2.new(0.5, 0.5)
      instance4.Position = UDim2.new(p4, 0, 0.2, 0)
      instance4.BackgroundTransparency = 1

      local instance5 = Instance.new("TextButton", instance4)
      instance5.Size = UDim2.new(1, 0, 1, 0)
      instance5.AnchorPoint = Vector2.new(0, 0)
      instance5.BackgroundTransparency = 1
      instance5.Text = text2
      instance5.TextSize = textSize
      instance5.Font = Enum.Font.Bangers
      instance5.TextColor3 = Color3.fromRGB(248, 248, 248)

      f4(instance5, 3, Enum.ApplyStrokeMode.Border)
      f4(instance5, 3, Enum.ApplyStrokeMode.Contextual)

      Instance.new("UICorner", instance5).CornerRadius = UDim.new(0, 8)
      return instance5
    end

    local botSlapFarmUI = localPlayer.PlayerGui:FindFirstChild("Bot Slap Farm UI")

    local botSlapFarmUI2 = botSlapFarmUI
    botSlapFarmUI2 = botSlapFarmUI or Instance.new("ScreenGui", localPlayer.PlayerGui)
    botSlapFarmUI2.Name = "Bot Slap Farm UI"
    botSlapFarmUI2.IgnoreGuiInset = true
    botSlapFarmUI2:ClearAllChildren()

    local instance6 = Instance.new("ImageLabel", botSlapFarmUI2)
    instance6.Image = "rbxassetid://17184675278"
    instance6.AnchorPoint = Vector2.new(0.5, 0.5)
    instance6.Position = UDim2.new(0.5, 0, 1.55, 0)
    instance6.Size = UDim2.new(0.5, 0, 0.5, 0)
    instance6.BackgroundTransparency = 1

    local v29 = f12(instance6, 0.225, "Default")
    local v30 = f12(instance6, 0.5, "Dual")
    local v31 = f12(instance6, 0.775, "Snow")

    instance = Instance.new("TextLabel", instance6)
    instance.AnchorPoint = Vector2.new(0.5, 0.5)
    instance.BackgroundTransparency = 1
    instance.Size = UDim2.new(0.8, 0, 0.1, 0)
    instance.Position = UDim2.new(0.5, 0, 0.5, 0)
    instance.Text = "Selected: Default"
    instance.TextColor3 = Color3.fromRGB(248, 248, 248)
    instance.Font = Enum.Font.FredokaOne
    instance.TextSize = textSize

    f4(instance, 2, Enum.ApplyStrokeMode.Contextual)

    function f5(p5)
      instance.Text = "Selected: " .. p5.Text
      text = p5.Text
      slap = replicatedStorage:FindFirstChild(p5.Text .. "Slap") or replicatedStorage.Slap

      if p5.Text == "Default" then
        b = replicatedStorage.b
      elseif p5.Text == "Dual" then
        b = replicatedStorage.GeneralHit
      elseif p5.Text == "Snow" then
        b = replicatedStorage.SnowHit
      end

      print(text)
      print(tostring(b))
      print(tostring(slap))
    end

    local function f13(p6)
      p6.MouseButton1Click:Connect(function() f5(p6) end)
      p6.TouchTap:Connect(function() f5(p6) end)
    end

    f13(v29)
    f13(v30)
    f13(v31)

    local instance7 = Instance.new("TextButton", instance6)
    instance7.AnchorPoint = Vector2.new(0.5, 0.5)
    instance7.Position = UDim2.new(0.5, 0, 0.8, 0)
    instance7.Size = UDim2.new(0.75, 0, 0.15, 0)
    instance7.BackgroundColor3 = Color3.fromRGB(229, 65, 52)
    instance7.Font = Enum.Font.FredokaOne
    instance7.TextColor3 = Color3.fromRGB(254, 254, 254)
    instance7.TextSize = textSize
    instance7.Text = "Dominate"
    instance7.MouseButton1Click:Connect(function() getgenv().BSF = true end)
    instance7.TouchTap:Connect(function() getgenv().BSF = true end)

    f4(instance7, 2, Enum.ApplyStrokeMode.Contextual)
    f4(instance7, 6, Enum.ApplyStrokeMode.Border)

    Instance.new("UICorner", instance7).CornerRadius = UDim.new(0, 8)

    tweenService:Create(
      instance6, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
      { Position = UDim2.new(0.5, 0, 0.5, 0) }
    ):Play()

    v21 = getgenv().BSF

    repeat
      wait(0.02)
    until getgenv().BSF

    if not instance6.Parent then
      warn("Throwing an error to prevent double-execution..")
      workspace:Error()
    end

    tweenService:Create(
      instance6, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
      { Position = UDim2.new(0.5, 0, 1.55, 0) }
    ):Play()

    local function f14(p7)
      local x = Instance.new("Part", workspace)

      if abs(p7.X) > abs(p7.Z) then
        x.Name = "X"
      else
        x.Name = "Z"
      end

      x.Anchored = true
      x.Size = Vector3.new(2, 2, 2)
      x.CanCollide = false
      x.Transparency = 0.5
      x.Position = p7
      x.Color = Color3.new(1, 0.6, 0.9)

      insert(v3, x)
    end

    f14(Vector3.new(-112, -5, -1.6))
    f14(Vector3.new(-158, -5, -1.6))
    f14(Vector3.new(0, -5, 158))
    f14(Vector3.new(0, -5, 109))
    f14(Vector3.new(-1.7, -5, -158))
    f14(Vector3.new(-1.7, -5, -109))

    v13 = nil
    v14 = nil
    loadAnimation = nil
    instance2 = nil

    function f6(p8)
      v13 = p8
      local waitForChild = p8:WaitForChild("Humanoid", 10)
      v14 = waitForChild
      loadAnimation = (waitForChild:FindFirstChild("Animator") or waitForChild):LoadAnimation(slap)

      repeat
        wait()
      until v14.RootPart

      instance2 = Instance.new("BodyGyro", v14.RootPart)
      instance2.D = 400
      instance2.P = 7000
      instance2.MaxTorque = Vector3.yAxis * 1000000000

      print("respawn setup")
    end

    if localPlayer.Character then
      f6(localPlayer.Character)
    end

    task.spawn(function()
      while wait(0.05) do
        if v13 ~= localPlayer.Character and localPlayer.Character then
          f6(localPlayer.Character)
        end
      end
    end)

    function f7(p9)
      if p9.Magnitude == 0 then
        return Vector3.zero
      end

      return p9.Unit
    end

    v15 = {}

    v16 = {
      "ez", "lol", "get rekt", "no skill", "noob", "my grandma plays better",
      "how did you even hit the download button", "delete this game", "loser pro max", "kiddo",
      "pmo", "XD", ":3", "another one bites the dust", "a bizzare death", "not tuff",
      "packed like a sad meal", "fateful death", "el idiot", "poo poo gameplay",
      "someones angry", "special", "mchicken combod", "shoo", "good boy", "pee poo",
      "apply for a zoo cage", "call it animal control", "its futile",
      "did you find something on the ground", "packed back to kindergarten", "imagine losing",
      "divine intrevention", "perish", "L", "lil bro", "dogwater", "get a JOB", "sad",
      "daddys good dog", "pathetic", "sinked down like the titanic", "skill issue",
      "zoo exhibit escape", "owned", "stay humble", "bro thought", "aint no way", "touch grass",
      "ratio", "cry about it", "cope", "copium overdose", "discount player", "keyboard warrior",
      "walking L", "controller disconnected", "free kill", "i almost tried",
      "skill made in china", "press alt f4", "budget boss", "mental patch needed",
      "update your skill", "try harder", "get good", "keyboard ghosted you", "wifi warrior",
      "aim assist baby", "poopy pants", "controller moment", "sleep deprived gameplay", ":P",
      "sigma moment", "sigma reflexes", "bro pressed all buttons but skill",
      "chimp click combo", "return to the enclosure", "gorilla gameplay",
      "survival instincts of a wet napkin", "toddlers aim better when drawing", "good warmup",
      "light work", "textbook definition of failure", "beatiful display of mediocrity",
      "nice try champ", "competitive coping", "ranked coping",
      "i'd quit too if i played like that", "did i touch a nerve", "clipped in 4K",
      "a potato plays better", "007, 0 girls, 0 kills, 7 hours coping",
      "this is like watching a toddler taking its first steps", "goo goo ga ga", "just give up",
      "youre not slick", "bro got put to sleep", "me - 1 you - 0", "silence beta", "bot aim",
      "girls must be slapping you too", "calm down G", "i win buddy", "no maidens?",
      "daddy issues", "losermaxxing", "chopped",
    }

    v17 = false
    v18 = #v16

    function f8(p10, p11)
      local v32 = v17 == false and p10 and p11 == false and v8
      local v33

      if v32 then
        if p10.Value == localPlayer.Name then
          v17 = true
          local v34 = random(1, #v16)
          v33 = v16[v34]
          rbxGeneral:SendAsync(v33)

          if #v16 > 3 then
            remove(v16, v34)
            task.delay(3600 * (#v16 / v18), function() insert(v16, v33) end)
          end

          wait(5)
          v17 = false
        end
      end
    end

    v19 = 1

    v20 = {
      "OVERKILL", "rob", "bob", "Reaper", "Shukuchi", "The Flex", "Run", "God's Hand", "Leash",
      "Error", "Reaper",
    }

    v22 = { "Slicer", "Speedrun", "Sparky", "Extended", "Tycoon", "Bomb" }

    function f9(p12)
      if v11 == false then
        v19 = 4
      elseif find(v20, p12) then
        v19 = 2
      elseif find(v22, p12) then
        v19 = 3
      else
        v19 = 1
      end
    end

    v23 = {
      "Slicer", "OVERKILL", "God's Hand", "The Flex", "Joust", "Bomb", "Reflect", "Shukuchi",
      "Shard", "Leash", "Error", "Hallow Jack", "Debug", "Reaper", "Necromancer",
    }

    v25 = { "Fort", "Cloud", "Brick", "Defense" }

    function f1()
      local v35 = huge
      local v36 = huge
      local v37 = "Default"
      local position2 = v14.RootPart.Position
      local lastSlappedBy = v14.Parent:FindFirstChild("LastSlappedBy")

      if lastSlappedBy then
        lastSlappedBy = lastSlappedBy.Value
      end

      local v38, v39

      for v40, v41 in v7(players:GetPlayers()) do
        local character = v41.Character

        if v41 ~= localPlayer and character and localPlayer:IsFriendsWith(v41.UserId) == false then
          local humanoid = character:FindFirstChildWhichIsA("Humanoid")
          local rootPart

          if humanoid then
            rootPart = humanoid.RootPart or character:WaitForChild("Head", 0.1)
          end

          if humanoid and not character:FindFirstChild("InLobby") and rootPart then
            local v42 = new()
            v42.FilterType = Enum.RaycastFilterType.Exclude
            v42.FilterDescendantsInstances = { character }

            local raycast = workspace:Raycast(rootPart.Position
              + f7(rootPart.AssemblyLinearVelocity) * rootPart.AssemblyLinearVelocity.Magnitude
                * 0.075, Vector3.yAxis * -15, v42)

            local v43 = (rootPart.Position - position).Magnitude < v26
            local rock = character:FindFirstChild("rock")

            if rock then
              rock.CanTouch = false
            end

            local reversed = character:FindFirstChild("Reversed")
            local skull = character:FindFirstChild("Skull")
            local counterd = character:FindFirstChild("Counterd")
            local stevebody = character:FindFirstChild("stevebody")
            local v44 = not character:FindFirstChild("CarKeysCar")

            local v45 = v44

            v45 = v44 and v41.leaderstats.Glove.Value ~= "Admin"
              and character.Head.Transparency < 0.1

            local buddies = character:FindFirstChild("Buddies")

            if buddies then
              buddies = buddies:FindFirstChild(localPlayer.Name)
            end

            local v46 = humanoid.Health > 0
            local fakePartRightArm = character:FindFirstChild("FakePart Right Arm")
            local magnitude = (position2 - rootPart.Position).Magnitude
            local v47 = magnitude
            local value = v41.leaderstats.Glove.Value
            local lastSlappedBy2 = character:FindFirstChild("LastSlappedBy")
            task.spawn(f8, lastSlappedBy2, v46)

            if humanoid.HipHeight == 9 or skull then
              print("noob skull users")

              rootPart.CanCollide = true
              rootPart.Size = Vector3.one * 100

              task.delay(2, function()
                rootPart.CanCollide = false
                rootPart.Size = Vector3.one * 2
              end)
            end

            if v15[v41.Name] then
              v47 = v47 - v15[v41.Name]
            end

            if v41.Name == lastSlappedBy then
              v47 = v47 - 1
            end

            if find(v23, value) then
              v47 = v47 * 0.95
              magnitude = magnitude * 0.99
            elseif find(v25, value) then
              v47 = v47 * 1.05
            end

            if rootPart.AssemblyLinearVelocity.Magnitude > 1 then
              v47 = v47 * 1.05
            end

            if fakePartRightArm then
              magnitude = magnitude * 2
              v47 = v47 * 3
            end

            local v48 = v43

            if v43 then
              local v49 = raycast and not rock and not reversed and not stevebody and not skull
                and v45 and not buddies and v46 and not counterd

              v48 = v49
            end

            if v48 and v47 < v35 then
              v35 = v47
              v36 = magnitude
              v38 = v41
              v39 = character
              v37 = value
            end

            heartbeat:Wait()
          end
        end
      end

      f9(v37)

      if find(v23, v37) then
        walkSpeed = 22
      else
        walkSpeed = 21
      end

      return v38, v39, v36
    end

    v26 = 400

    function f11()
      local v50 = huge
      local v51 = huge
      local v52 = "Default"
      local position3 = v14.RootPart.Position
      local lastSlappedBy3 = v14.Parent:FindFirstChild("LastSlappedBy")

      if lastSlappedBy3 then
        lastSlappedBy3 = lastSlappedBy3.Value
      end

      local v53, v54

      for v55, v56 in v7(players:GetPlayers()) do
        local character2 = v56.Character

        if v56 ~= localPlayer and character2 and localPlayer:IsFriendsWith(v56.UserId) == false then
          local humanoid2 = character2:FindFirstChildWhichIsA("Humanoid")
          local rootPart2

          if humanoid2 then
            rootPart2 = humanoid2.RootPart or character2:WaitForChild("Head", 0.1)
          end

          if humanoid2 and not character2:FindFirstChild("InLobby") and rootPart2 then
            local v57 = new()
            v57.FilterType = Enum.RaycastFilterType.Exclude
            v57.FilterDescendantsInstances = { character2 }

            local raycast2 = workspace:Raycast(rootPart2.Position
              + f7(rootPart2.AssemblyLinearVelocity)
                * rootPart2.AssemblyLinearVelocity.Magnitude * 0.075, Vector3.yAxis * -15, v57)

            local v58 = (rootPart2.Position - position).Magnitude < v26
            local rock2 = character2:FindFirstChild("rock")

            if rock2 then
              rock2.CanTouch = false
            end

            local reversed2 = character2:FindFirstChild("Reversed")
            local skull2 = character2:FindFirstChild("Skull")
            local counterd2 = character2:FindFirstChild("Counterd")
            local stevebody2 = character2:FindFirstChild("stevebody")
            local v59 = not character2:FindFirstChild("CarKeysCar")

            local v60 = v59

            v60 = v59 and v56.leaderstats.Glove.Value ~= "Admin"
              and character2.Head.Transparency < 0.1

            local buddies2 = character2:FindFirstChild("Buddies")

            if buddies2 then
              buddies2 = buddies2:FindFirstChild(localPlayer.Name)
            end

            local v61 = humanoid2.Health > 0
            local fakePartRightArm2 = character2:FindFirstChild("FakePart Right Arm")
            local magnitude2 = (position3 - rootPart2.Position).Magnitude
            local v62 = magnitude2
            local value2 = v56.leaderstats.Glove.Value
            local lastSlappedBy4 = character2:FindFirstChild("LastSlappedBy")
            task.spawn(f8, lastSlappedBy4, v61)

            if humanoid2.HipHeight == 9 or skull2 then
              print("noob skull users")

              rootPart2.CanCollide = true
              rootPart2.Size = Vector3.one * 100

              task.delay(2, function()
                rootPart2.CanCollide = false
                rootPart2.Size = Vector3.one * 2
              end)
            end

            if v15[v56.Name] then
              v62 = v62 - v15[v56.Name]
            end

            if v56.Name == lastSlappedBy3 then
              v62 = v62 - 1
            end

            if find(v23, value2) then
              magnitude2 = magnitude2 * 0.99
              v62 = v62 * 0.95
            elseif find(v25, value2) then
              v62 = v62 * 1.05
            end

            if rootPart2.AssemblyLinearVelocity.Magnitude > 1 then
              v62 = v62 * 1.05
            end

            if fakePartRightArm2 then
              v62 = v62 * 3
              magnitude2 = magnitude2 * 2
            end

            local v63 = v58

            if v58 then
              local v64 = raycast2 and not rock2 and not reversed2 and not stevebody2
                and not skull2 and v60 and not buddies2 and v61 and not counterd2

              v63 = v64
            end

            if v63 and v62 < v50 then
              v53 = v56
              v50 = v62
              v51 = magnitude2
              v54 = character2
              v52 = value2
            end
          end
        end
      end

      f9(v52)

      if find(v23, v52) then
        walkSpeed = 22
      else
        walkSpeed = 21
      end

      return v53, v54, v51
    end

    function f2()
      local instance8 = Instance.new("ScreenGui", localPlayer.PlayerGui)
      debris:AddItem(instance8, 10)

      local instance9 = Instance.new("TextLabel", instance8)
      instance9.Size = UDim2.new(0.6, 0, 0.15, 0)
      instance9.AnchorPoint = Vector2.new(0.5, 0.5)
      instance9.Position = UDim2.new(0.5, 0, 1.1, 0)
      instance9.BackgroundTransparency = 1
      instance9.TextScaled = true
      instance9.TextColor3 = Color3.fromRGB(254, 36, 47)
      instance9.Text = "Equip Your Selected Glove"
      instance9.Font = Enum.Font.FredokaOne

      f4(instance9, 2, Enum.ApplyStrokeMode.Contextual)

      tweenService:Create(
        instance9, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
        { Position = UDim2.new(0.5, 0, 0.7, 0) }
      ):Play()

      repeat
        wait(0.02)
      until localPlayer.leaderstats.Glove.Value == text

      tweenService:Create(
        instance9, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
        { Position = UDim2.new(0.5, 0, 1.1, 0) }
      ):Play()
    end

    function f3(p13)
      local position4 = v14.RootPart.Position
      local v65 = huge
      local v66, v67

      for v68, v69 in v7(v3) do
        local magnitude3 = (position4 - v69.Position).Magnitude
        local v70 = magnitude3 < 50 and magnitude3 > 1.25

        if v69.Name == "X" then
          v67 = abs(v69.Position.X - p13.X) < abs(position4.X - p13.X)
        else
          v67 = abs(v69.Position.Z - p13.Z) < abs(position4.Z - p13.Z)
        end

        if v67 and v70 and magnitude3 < v65 then
          v66 = v69
          v65 = magnitude3
        end
      end

      if v66 then
        v14:MoveTo(v66.Position)
      else
        f10(p13)
      end
    end

    v2 = new()
    v27 = false
    v24 = 4.5

    function f10(p14)
      if workspace:Raycast(p14, Vector3.yAxis * -10, v2) then
        v14:MoveTo(p14)
      end
    end

    v28 = {
      function(p15, p16, p17)
        local cframe = p15.CFrame
        local v71 = clamp(0.5 * p16.Magnitude, 4, 10.5) * v9
        local rightVector = cframe.RightVector
        local v72 = huge
        local v73

        for v74, v75 in v7({ cframe.LookVector * -v71, rightVector * -v71, rightVector * v71 }) do
          local magnitude4 = (v14.RootPart.Position - (p17 + v75)).Magnitude

          if magnitude4 < v72 then
            v72 = magnitude4
            v73 = v75
          end
        end

        local v76 = p17 + v73
        debugCube.Position = v76
        f10(v76)
      end,
      function(p18, p19, p20)
        local v77 = clamp(0.6 * p19.Magnitude, 6, 12.6)
        local v78 = p20 + (v14.RootPart.Position - p20).Unit * v77 * v9
        debugCube.Position = v78
        f10(v78)
      end,
      function(p21, p22, p23)
        local v79 = p23 + f7(p22) * 5
        debugCube.Position = v79
        f10(v79)
      end,
      function(p24, p25, p26)
        local cframe2 = p24.CFrame
        local rightVector2 = cframe2.RightVector
        local v80 = huge
        local v81

        for v82, v83 in v7({ cframe2.LookVector * -v24, rightVector2 * -v24, rightVector2 * v24 }) do
          local magnitude5 = (v14.RootPart.Position - (p26 + v83)).Magnitude

          if magnitude5 < v80 then
            v80 = magnitude5
            v81 = v83
          end
        end

        local v84 = p26 + v81
        debugCube.Position = v84
        f10(v84)
      end,
    }

    workspace.DescendantAdded:Connect(function(descendant)
      local instance10, instance11

      if descendant:IsA("MeshPart") then
        if descendant.MeshId == "rbxassetid://110941084651570" then
          instance11 = Instance.new("Part", descendant)
          instance11.Anchored = true
          instance11.Material = Enum.Material.ForceField
          instance11.Color = Color3.fromRGB(255, 64, 16)
          instance11.CastShadow = false

          task.spawn(function()
            tweenService:Create(instance11, TweenInfo.new(1), { Size = Vector3.one * 60 }):Play()
          end)

          repeat
            instance11.Position = descendant.Position
            wait(0.05)
          until not descendant.Parent
        end
      elseif descendant.Name == "DiscoBall" then
        instance10 = Instance.new("Part", descendant)
        instance10.Anchored = true
        instance10.Material = Enum.Material.ForceField
        instance10.Color = Color3.fromRGB(255, 64, 16)
        instance10.CastShadow = false

        task.spawn(function()
          tweenService:Create(instance10, TweenInfo.new(1), { Size = Vector3.one * 60 }):Play()
        end)

        repeat
          instance10.Position = descendant.Position
          wait(0.05)
        until not descendant.Parent
      end
    end)

    local function f15()
      local controlPanel = Instance.new("ScreenGui", localPlayer.PlayerGui)
      controlPanel.Name = "Control Panel"
      controlPanel.IgnoreGuiInset = true
      controlPanel.DisplayOrder = 123
      controlPanel.ResetOnSpawn = false

      local instance12 = Instance.new("ImageLabel", controlPanel)
      instance12.Image = "rbxassetid://17184675278"
      instance12.AnchorPoint = Vector2.new(0.5, 0.5)
      instance12.Position = UDim2.new(0.5, 0, 1.55, 0)
      instance12.Size = UDim2.new(0.5, 0, 0.5, 0)
      instance12.BackgroundTransparency = 1

      Instance.new("UIAspectRatioConstraint", instance12).AspectRatio = 1.6
      Instance.new("UIDragDetector", instance12)

      local instance13 = Instance.new("TextLabel", instance12)
      instance13.Font = Enum.Font.FredokaOne
      instance13.BackgroundTransparency = 1
      instance13.Text = "Control Panel"
      instance13.Size = UDim2.new(1, 0, 0.1, 0)
      instance13.Position = UDim2.new(0, 0, 0.05, 0)
      instance13.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance13.TextSize = textSize
      instance13.TextScaled = true

      f4(instance13, 2, Enum.ApplyStrokeMode.Contextual)

      local instance14 = Instance.new("TextButton", instance12)
      instance14.Font = Enum.Font.FredokaOne
      instance14.Text = "Toxic Chat"
      instance14.Size = UDim2.new(0.9, 0, 0.1, 0)
      instance14.Position = UDim2.new(0.05, 0, 0.2, 0)
      instance14.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance14.TextSize = textSize
      instance14.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
      instance14.TextScaled = true

      f4(instance14, 2, Enum.ApplyStrokeMode.Contextual)

      local function f16()
        if v8 then
          v8 = false
          instance14.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        else
          v8 = true
          instance14.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        end
      end

      instance14.MouseButton1Click:Connect(f16)
      instance14.TouchTap:Connect(f16)

      local v85 = { 0.5, 0.6, 0.7, 0.8, 0.9, 1 }
      local v86 = 1

      local instance15 = Instance.new("TextButton", instance12)
      instance15.Font = Enum.Font.FredokaOne
      instance15.Text = "Range: " .. tostring(v9 * 100) .. "%"
      instance15.Size = UDim2.new(0.9, 0, 0.1, 0)
      instance15.Position = UDim2.new(0.05, 0, 0.32, 0)
      instance15.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance15.TextSize = textSize
      instance15.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
      instance15.TextScaled = true

      f4(instance15, 2, Enum.ApplyStrokeMode.Contextual)

      local function f17()
        if v86 >= #v85 then
          v86 = 1
        else
          v86 = v86 + 1
        end

        v9 = v85[v86]
        instance15.Text = "Range: " .. tostring(v9 * 100) .. "%"
      end

      instance15.MouseButton1Click:Connect(f17)
      instance15.TouchTap:Connect(f17)

      local instance16 = Instance.new("TextButton", instance12)
      instance16.Font = Enum.Font.FredokaOne
      instance16.Text = "Faster Targeting"
      instance16.Size = UDim2.new(0.9, 0, 0.1, 0)
      instance16.Position = UDim2.new(0.05, 0, 0.44, 0)
      instance16.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance16.TextSize = textSize
      instance16.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
      instance16.TextScaled = true

      f4(instance16, 2, Enum.ApplyStrokeMode.Contextual)

      local function f18()
        if v10 then
          v10 = false
          instance16.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
          print(v10)
        else
          v10 = true
          instance16.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
          print(v10)
        end
      end

      instance16.MouseButton1Click:Connect(f18)
      instance16.TouchTap:Connect(f18)

      local instance17 = Instance.new("TextButton", instance12)
      instance17.Font = Enum.Font.FredokaOne
      instance17.Text = "Rigged"
      instance17.Size = UDim2.new(0.45, 0, 0.1, 0)
      instance17.Position = UDim2.new(0.05, 0, 0.56, 0)
      instance17.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance17.TextSize = textSize
      instance17.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
      instance17.TextScaled = true

      f4(instance17, 2, Enum.ApplyStrokeMode.Contextual)

      local function f19()
        if v11 then
          v11 = false
          instance17.Text = "Not Rigged"
          instance17.BackgroundColor3 = Color3.fromRGB(128, 0, 255)
        else
          instance17.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
          instance17.Text = "Rigged"
          v11 = true
        end
      end

      instance17.MouseButton1Click:Connect(f19)
      instance17.TouchTap:Connect(f19)

      local instance18 = Instance.new("TextButton", instance12)
      instance18.Font = Enum.Font.FredokaOne
      instance18.Text = "Any Glove"
      instance18.Size = UDim2.new(0.45, 0, 0.1, 0)
      instance18.Position = UDim2.new(0.5, 0, 0.56, 0)
      instance18.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance18.TextSize = textSize
      instance18.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
      instance18.TextScaled = true

      f4(instance17, 2, Enum.ApplyStrokeMode.Contextual)

      local function f20()
        if v12 then
          v12 = false
          instance18.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        else
          instance18.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
          v12 = true
        end
      end

      instance18.MouseButton1Click:Connect(f20)
      instance18.TouchTap:Connect(f20)

      local instance19 = Instance.new("TextButton", instance12)
      instance19.Font = Enum.Font.FredokaOne
      instance19.Text = "Stay In Main Island"
      instance19.Size = UDim2.new(0.9, 0, 0.1, 0)
      instance19.Position = UDim2.new(0.05, 0, 0.68, 0)
      instance19.TextColor3 = Color3.fromRGB(248, 248, 248)
      instance19.TextSize = textSize
      instance19.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
      instance19.TextScaled = true

      f4(instance17, 2, Enum.ApplyStrokeMode.Contextual)

      local function f21()
        if v26 == 100 then
          v26 = 400
          instance19.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        else
          instance19.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
          v26 = 100
        end
      end

      instance19.MouseButton1Click:Connect(f21)
      instance19.TouchTap:Connect(f21)

      tweenService:Create(
        instance12, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
        { Position = UDim2.new(0.5, 0, 0.5, 0) }
      ):Play()
    end

    coroutine.resume(coroutine.create(function()
      while true do
        local character3 = localPlayer.Character

        if v14 then
          if not character3:FindFirstChild("InLobby") and v14.Health > 0 then
            if v5 then
              local carKeysCar = v5:FindFirstChild("CarKeysCar")

              if carKeysCar then
                carKeysCar:FindFirstChild("Hitbox")
              end

              local rootPart3 = (v5:WaitForChild("Humanoid", 2)
                or v5:FindFirstChildWhichIsA("Humanoid")).RootPart

              local assemblyLinearVelocity = rootPart3.AssemblyLinearVelocity
              local v87 = rootPart3.Position + f7(assemblyLinearVelocity)

              if v6 > 30 then
                f3(v87)
              else
                v28[v19](rootPart3, assemblyLinearVelocity, v87)
              end
            else
              f10(position)
            end
          elseif localPlayer.leaderstats.Glove.Value ~= text and v12 == false
            and v11 == true then
            f2()

            repeat
              wait(0.02)
            until localPlayer.leaderstats.Glove.Value == text
          else
            v14:MoveTo(teleport1.Position)
          end
        end

        heartbeat:Wait()
      end
    end))

    coroutine.resume(coroutine.create(function()
      while true do
        if v4 and v27 == false then
          local parent = v14.Parent

          if v11 then
            local humanoidRootPart = v5:FindFirstChild("HumanoidRootPart") or v5.PrimaryPart

            if v6
                < (10 + clamp(humanoidRootPart.AssemblyLinearVelocity.Magnitude * 0.25, 0, 10))
                  * v9
              and v27 == false
              and parent:FindFirstChild(text)
              and (v14.RootPart.AssemblyLinearVelocity.Magnitude < 5
                  and parent:FindFirstChild("FakePart Right Arm"))
                == false then
              v27 = true
              loadAnimation:Play()
              b:FireServer(humanoidRootPart)
              task.delay(random(55, 65) * 0.01, function() v27 = false end)
            end
          else
            local tool = localPlayer.Character:FindFirstChildWhichIsA("Tool")

            if tool and v6 < 7.5 then
              tool:Activate()
              local fat = tool:FindFirstChild("Glove")

              if fat then
                fat.Size = fat.Size * 1.05
                fat.Name = "Fat"
              end
            end
          end
        end

        heartbeat:Wait()
      end
    end))

    coroutine.resume(coroutine.create(function()
      while wait() do
        if v10 then
          local v88
          v4, v5, v88 = f11()
          v6 = v88
        else
          local v89
          v4, v5, v89 = f1()
          v6 = v89
        end

        if instance2 and v5 then
          local waitForChild2 = v5:WaitForChild("Humanoid", 1)

          instance2.CFrame = CFrame.lookAt(
            v14.RootPart.Position, waitForChild2.RootPart.Position
          )
        end
      end
    end))

    coroutine.resume(coroutine.create(function()
      while wait(0.2) do
        local character4 = localPlayer.Character
        local tool2 = character4:FindFirstChildWhichIsA("Tool")
        local tool3 = localPlayer.Backpack:FindFirstChildWhichIsA("Tool")
        local wallace = workspace:FindFirstChild("wall")

        if wallace then
          wallace.Name = "Wallace"
          wallace.Size = wallace.Size * 0.5
        end

        if v14.Parent then
          local rootPart4 = v14.RootPart or character4:WaitForChild("Head", 1)

          if rootPart4.AssemblyLinearVelocity.Magnitude < 3 then
            v14:ChangeState(Enum.HumanoidStateType.Jumping)
            wait(0.5)
          end

          v14.WalkSpeed = walkSpeed

          if v14.Sit then
            v14.Sit = false
          end

          if character4:FindFirstChild("Zombie") then
            reset:FireServer()
            wait(1)
          end

          if rootPart4.Position.Magnitude > 1536 or rootPart4.Position.Y < -20 then
            reset:FireServer()
            v14.Health = 0
            wait(1)
          end

          if v14.Health == 0 then
            local lastSlappedBy5 = character4:FindFirstChild("LastSlappedBy")

            if lastSlappedBy5 then
              local value3 = lastSlappedBy5.Value

              if v15[value3] then
                v15[value3] = v15[value3] + 1

                task.spawn(function()
                  for i = 1, 4 do
                    local value4 = lastSlappedBy5.Value
                    v15[value4] = v15[value4] - 0.25
                    wait(30)
                  end
                end)
              else
                v15[value3] = 1

                task.spawn(function()
                  for j = 1, 4 do
                    v15[value3] = v15[value3] - 0.25
                    wait(30)
                  end
                end)
              end
            end
          end

          if not tool2 and tool3 then
            pcall(function() tool3.Parent = character4 end)
          end
        end
      end
    end))

    wait(2)
    f15()
    return
  end
else
  warn("do not.")
  return
end
