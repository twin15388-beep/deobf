--[[
Game: Your Bizarre Adventure | DEOBFUSCATED (static recovery) | NOT TESTED IN ROBLOX
Source: https://github.com/volmaksDev/My-Scripts/blob/231da028cc84a5e0dcd9ece97a0008aec47dc794/YBA.lua
Source SHA-256: f86244ca7b694f450f42182039bce37f4d296c5639c1c9f85f35cf5d636f40ff
Recovery: prostone4/Prometheus-Deobfuscator@6ee3291ec83fdc58c04e17bb1f1703386619711a on the WeAreDevs/WAD v1.0.0 protected input; two runs produced byte-identical output.
The 1353-line Lua body below is the decoder output copied unchanged. Identifiers f1..f25, v1..v55 and p1..p26 are decoder-generated, NOT the author's names, and this provenance header is OUR addition, not a recovered author comment.
Game handlers are inline, not a loader: workspace.Item_Spawns.Items money farm with ProximityPrompt/E pickup and camera override, Merchant sell dialogue through the character RemoteEvent, players.LocalPlayer.PlayerStats.Money, "1x Lucky Arrow" purchase at money >= 50000, PlayerStats.Stand/Race ESP billboards, workspace.FastTravel locations (Merchant's Keep, Parking Lot, Prison Bridge, Train Station, Via Toledo, Via dell'Oceano) and hard-coded boss coordinates (Jotaro Kujo, Dio, Diavolo, Ascended Dio).
Risks: it can spend in-game money (50000 per Lucky Arrow, every 2 s while enabled); "YBA god mode" writes other players' HumanoidRootPart.CFrame every Heartbeat; it reads/writes/deletes NotSameServers.json through executor file APIs and requests games.roblox.com server lists.
External dependency, NOT included and NOT audited: WindUI is fetched and executed at startup from the mutable URL https://github.com/Footagesus/WindUI/releases/latest/download/main.lua; without it the script returns early.
The code contains no PlaceId check, was never executed in Roblox, and static recovery proves neither equivalence with the unobfuscated original nor server acceptance of these remotes. The Server Hop button loops forever and never calls TeleportService.
Check reports/game-sources-2026-10-22-wad.md for handler parameters, limits and negative results.
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
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local virtualInputManager = game:GetService("VirtualInputManager")
local placeId = game.PlaceId
local jsonDecode = {}
local nextPageCursor = ""
local hour = os.date("!*t").hour

if not pcall(function() jsonDecode = httpService:JSONDecode(readfile("NotSameServers.json")) end) then
  table.insert(jsonDecode, hour)
  writefile("NotSameServers.json", httpService:JSONEncode(jsonDecode))
end

local function f1(...)
  print("[Revenge Hub]", ...)
end

function TPReturner()
  local jsonDecode2

  if nextPageCursor == "" then
    jsonDecode2 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
      .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
  else
    jsonDecode2 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"
      .. placeId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. nextPageCursor))
  end

  local v1 = ""

  if jsonDecode2.nextPageCursor and jsonDecode2.nextPageCursor ~= "null"
    and jsonDecode2.nextPageCursor ~= nil then
    nextPageCursor = jsonDecode2.nextPageCursor
  end

  local count = 0

  for key, value in pairs(jsonDecode2.data) do
    local v2 = true
    v1 = tostring(value.id)

    if tonumber(value.maxPlayers) > tonumber(value.playing) then
      for key2, value2 in pairs(jsonDecode) do
        if count ~= 0 then
          if v1 == tostring(value2) then
            v2 = false
          end
        elseif tonumber(hour) ~= tonumber(value2) then
          pcall(function()
            delfile("NotSameServers.json")
            jsonDecode = {}
            table.insert(jsonDecode, hour)
          end)
        end

        count = count + 1
      end

      if v2 == true then
        table.insert(jsonDecode, v1)
        wait()
        wait(4)
      end
    end
  end
end

function Teleport()
  while wait() do
    pcall(function()
      TPReturner()

      if nextPageCursor ~= "" then
        TPReturner()
      end
    end)
  end
end

local function f2(p1, p2, p3)
  local v3 = p3 or 10
  local v4 = os.clock()

  while os.clock() - v4 < v3 do
    local findFirstChild = p1:FindFirstChild(p2)

    if findFirstChild then
      return findFirstChild
    end

    wait(0.1)
  end

  return nil
end

local windUI = nil

local v5, v6 = pcall(function()
  windUI = loadstring((game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua", true
  )))()
end)

local f3, f4, f5, f6, vector, f7, f8, localPlayer, humanoidRootPart, v7, money, position,
  position2, position3, position4, position5, position6, vector2, vector3, vector4, vector5,
  vector6, f9, localPlayer2, v8, v9, v10, f10, v11, f11, v12, v13, visualTab, fastTravelTab,
  creditsTab

if not v5 or not windUI then
  f1("Failed to load WindUI:", v6)
  return
else
  localPlayer = players.LocalPlayer
  humanoidRootPart = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):FindFirstChild("HumanoidRootPart")

  _G.MoneyFarm_Enabled = false
  _G.MoneyFarm_Stop = false
  _G.TeleportSpeed = 10
  _G.AutoSell = true
  _G.AutoBuyLuckyArrow = false
  _G.EspRace = false
  _G.EspStand = false
  _G.EspStyle = false
  _G.EspPlayers = false
  _G.YbaGodMode_Enabled = false

  v7 = {}
  money = players.LocalPlayer.PlayerStats.Money
  position = workspace.FastTravel["Merchant's Keep"].TeleportTo.Value.Position
  position2 = workspace.FastTravel["Parking Lot"].TeleportTo.Value.Position
  position3 = workspace.FastTravel["Prison Bridge"].TeleportTo.Value.Position
  position4 = workspace.FastTravel["Train Station"].TeleportTo.Value.Position
  position5 = workspace.FastTravel["Via Toledo"].TeleportTo.Value.Position
  position6 = workspace.FastTravel["Via dell'Oceano"].TeleportTo.Value.Position
  vector2 = Vector3.new(-569.23376464844, -25.754217147827, -146.56980895996094)
  vector3 = Vector3.new(311.75445556641, -0.039037950336933, -185.12309265137)
  vector4 = Vector3.new(753.00628662109, -42.479499816895, 92.378364562988)
  vector5 = Vector3.new(-117.302734375, 9.506591796875, -956.86376953125)
  vector6 = Vector3.new(1062.7100830078, 126.16677856445, -28.663818359375)

  function f3(p4, p5, p6)
    if not p4 or typeof(p4) ~= "Vector3" then
      return false
    else
      local position7 = humanoidRootPart.Position
      local magnitude = (p4 - position7).Magnitude

      if magnitude <= 0.1 then
        humanoidRootPart.CFrame = CFrame.new(p4, p4 + humanoidRootPart.CFrame.LookVector)
        return true
      else
        local v14 = math.max(1, math.ceil(magnitude / p5)) * p6
        local total = 0
        local cframe = humanoidRootPart.CFrame

        while total < v14 and true do
          total = total + runService.Heartbeat:Wait()
          local lerp = position7:Lerp(p4, (math.clamp(total / v14, 0, 1)))
          humanoidRootPart.CFrame = CFrame.new(lerp, lerp + cframe.LookVector)
        end

        humanoidRootPart.CFrame = CFrame.new(p4, p4 + cframe.LookVector)
        return true
      end
    end
  end

  vector = Vector3.new(8490.5439453125, -469.50018310547, 8151.3793945312)

  function f4(title, content, duration)
    windUI:Notify({
      Title = title,
      Content = content,
      Duration = duration,
      Icon = "bird",
    })
  end

  function f5(p7)
    for index, value3 in ipairs(game.Players:GetPlayers()) do
      local name = value3.Name

      if string.match(name:lower(), p7:lower()) then
        return value3
      end
    end

    return nil
  end

  function f9()
    f1("Initializing AutoFarm...")
    local localPlayer3 = players.LocalPlayer

    if not localPlayer3 then
      f1("Player not found")
      return nil
    end

    local character = localPlayer3.Character

    if not character then
      f1("Waiting for character...")
      local v15 = localPlayer3.CharacterAdded:Wait()

      if not v15 then
        f1("Character not found")
        return nil
      end

      character = v15
    end

    local v16 = f2(character, "HumanoidRootPart")

    if not v16 then
      f1("HumanoidRootPart not found")
      return nil
    end

    local currentCamera = workspace.CurrentCamera

    local f12, f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, items, autoSell, v17,
      v18, connect, connect2, v19, v20, f25, v21, v22, v23

    if not currentCamera then
      f1("Camera not found")
      return nil
    else
      local itemSpawns = f2(workspace, "Item_Spawns")

      if not itemSpawns then
        f1("Item_Spawns not found in workspace")
        itemSpawns = workspace:FindFirstChild("Item_Spawns")

        if not itemSpawns then
          f1("Item_Spawns not found anywhere")
          return nil
        end
      end

      items = f2(itemSpawns, "Items")

      if not items then
        f1("Items folder not found in Item_Spawns")
        items = itemSpawns:FindFirstChild("Items")

        if not items then
          f1("Items folder not found anywhere")
          return nil
        end
      end

      f1("Found items folder:", items:GetFullName())
      autoSell = _G.AutoSell
      v17 = {}
      v18 = false
      connect = nil
      connect2 = nil

      function f12()
        return _G.MoneyFarm_Enabled and not _G.MoneyFarm_Stop
      end

      v19 = {
        "Mysterious Arrow", "Rokakaka", "Gold Coin", "Diamond", "Pure Rokakaka",
        "Quinton's Glove", "Steel Ball", "Rib Cage of The Saint's Corpse",
        "Zepellin's Headband", "Zeppeli's Hat", "Caesar's Headband", "Clackers", "Stone Mask",
        "Ancient Scroll", "Dio's Diary",
      }

      function f13(p8)
        if not f12() or not p8 or typeof(p8) ~= "Vector3" then
          return false
        else
          local teleportSpeed = _G.TeleportSpeed or 15
          local position8 = v16.Position
          local magnitude2 = (p8 - position8).Magnitude

          if magnitude2 <= 0.1 then
            v16.CFrame = CFrame.new(p8, p8 + v16.CFrame.LookVector)
            return true
          else
            local v24 = math.max(1, math.ceil(magnitude2 / teleportSpeed)) * 0.07
            local total2 = 0
            local cframe2 = v16.CFrame

            while total2 < v24 and f12() do
              total2 = total2 + runService.Heartbeat:Wait()
              local lerp2 = position8:Lerp(p8, (math.clamp(total2 / v24, 0, 1)))
              v16.CFrame = CFrame.new(lerp2, lerp2 + cframe2.LookVector)
            end

            if f12() then
              v16.CFrame = CFrame.new(p8, p8 + cframe2.LookVector)
            end

            return true
          end
        end
      end

      function f24(p9)
        return p9 and p9.Parent and typeof(p9) == "Instance"
      end

      function f14(p10)
        if not v20(p10) then
          return false
        end

        for index2, value4 in ipairs(v17) do
          if value4 == p10 then
            return true
          end
        end

        return false
      end

      v20 = f24

      function f15(p11)
        if not f12() or not v20(p11) then
          return nil
        elseif p11:IsA("BasePart") then
          return p11
        else
          local getDescendants = p11:GetDescendants()

          for i = 1, #getDescendants do
            local v25 = getDescendants[i]

            if v25:IsA("BasePart") then
              return v25
            end
          end

          return nil
        end
      end

      function f25(p12)
        if not f12() or not v20(p12) or f14(p12) then
          return false
        end

        table.insert(v17, p12)
        f1("Enqueued item:", p12.Name)
        return true
      end

      function f16(p13)
        if not f12() or not v20(p13) then
          return nil
        else
          local getDescendants2 = p13:GetDescendants()

          for j = 1, #getDescendants2 do
            local v26 = getDescendants2[j]

            if v26:IsA("ProximityPrompt") then
              return v26
            end
          end

          return nil
        end
      end

      function f17()
        if not f12() then
          return 0
        else
          local count2 = 0

          for index3, value5 in ipairs(items:GetChildren()) do
            if v20(value5) and f25(value5) then
              count2 = count2 + 1
            end
          end

          f1("Enqueued", count2, "existing items")
          return count2
        end
      end

      function f18()
        if not f12() then
          return false, "Farm disabled"
        else
          local v27, v28 = pcall(function()
            virtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.22)
            virtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
          end)

          return v27, v28
        end
      end

      function f19(p14)
        if not f12() or not v20(p14) then
          return false
        else
          local v29 = f15(p14)

          if not v29 then
            f1("No physical part found for", p14.Name)
            return false
          end

          f1("Collecting:", p14.Name)
          f13(v29.Position + Vector3.new(0, 3, 0))
          task.wait(0.1)

          if not f12() then
            return false
          else
            local cameraType = currentCamera.CameraType
            local cframe3 = currentCamera.CFrame
            currentCamera.CameraType = Enum.CameraType.Scriptable
            local vector7 = Vector3.new(0, 6, 0)
            currentCamera.CFrame = CFrame.new(v29.Position + vector7, v29.Position)
            local v30 = f16(p14)
            local position9 = v29.Position
            local maxActivationDistance = 6

            if v30 and v20(v30) then
              maxActivationDistance = v30.MaxActivationDistance or maxActivationDistance

              if v30.Parent and v30.Parent:IsA("BasePart") then
                position9 = v30.Parent.Position
              end

              f1("Prompt found. Distance:", maxActivationDistance)
            else
              f1("No prompt found, using touch-based pickup")
            end

            local count3 = 0
            local v31 = false

            while count3 < 2 and f12() do
              if not v20(p14) then
                v31 = true
                break
              else
                if (v16.Position - position9).Magnitude > maxActivationDistance - 0.5 then
                  f13(position9)
                  task.wait(0.1)
                end

                if v30 and v30.Enabled then
                  local v32, v33 = v21()

                  if v32 then
                    f1("Pressed E, waiting for item...")
                  else
                    f1("Failed to press E:", v33)
                  end
                else
                  v16.CFrame = CFrame.new(v29.Position + Vector3.new(2, 0, 2))
                end

                local total3 = 0

                while total3 < 2 and f12() do
                  if not v20(p14) then
                    v31 = true
                    break
                  end

                  task.wait(0.2)
                  total3 = total3 + 0.2
                end

                if v31 then
                  f1("Successfully collected:", p14.Name)
                  break
                end

                count3 = count3 + 1
                f1("Attempt", count3, "failed for", p14.Name)
                task.wait(0.3)
              end
            end

            if f12() then
              currentCamera.CameraType = cameraType
              currentCamera.CFrame = cframe3
            end

            task.wait(0.3)
            return v31
          end
        end
      end

      v21 = f18

      function f20(p15)
        if not f12() or not v20(p15) then
          return nil
        else
          local v34, v35 = pcall(function() return p15:WaitForChild("RemoteEvent", 3) end)

          if v34 and v35 then
            return v35
          end

          f1("Merchant RemoteEvent not found")
          return nil
        end
      end

      function f21(p16)
        if not f12() or not v20(p16) then
          return false
        end

        if not p16.Parent or p16.Parent == nil then
          f1("Tool no longer exists:", p16.Name)
          return false
        end

        if p16.Parent ~= character then
          f1("Tool is not on character:", p16.Name)
          return false
        end

        local v36 = v22(character)
        local v37

        if not v36 then
          return false
        else
          v37 = {
            "EndDialogue", { Option = "Option2", Dialogue = "Dialogue5", NPC = "Merchant" },
          }

          local v38, v39 = pcall(function() v36:FireServer(unpack(v37)) end)

          if v38 then
            f1("Sold:", p16.Name)
            return true
          end

          f1("Failed to sell:", p16.Name, "Error:", v39)
          return false
        end
      end

      v22 = f20

      function f22(p17)
        if not f12() or not v20(p17) then
          return
        else
          local v40 = f2(p17, "Humanoid")
          local v41 = f2(localPlayer3, "Backpack")

          if not v40 or not v41 then
            f1("Humanoid or Backpack not found")
            return
          else
            local v42 = {}

            while f12() and v20(p17) do
              local v43 = {}

              for index4, value6 in ipairs(v41:GetChildren()) do
                if value6 and value6:IsA("Tool") then
                  table.insert(v43, value6)
                end
              end

              for k = 1, #v43 do
                if not f12() then
                  break
                else
                  local v44 = v43[k]

                  if v44 and v44:IsA("Tool") and v44.Parent == v41 then
                    local v45 = false

                    for index5, value7 in ipairs(v19) do
                      if v44.Name == value7 then
                        v45 = true
                        break
                      end
                    end

                    if v45 then
                      local name2 = v44.Name
                      v40:EquipTool(v44)
                      task.wait(1)

                      if v44.Parent == p17 and autoSell then
                        local v46 = tick()

                        if v46 - (v42[name2] or 0) >= 0.5 then
                          local findFirstChild2 = p17:FindFirstChild(name2)

                          if findFirstChild2 and findFirstChild2:IsA("Tool") then
                            if v23(findFirstChild2) then
                              v42[name2] = v46
                            end
                          else
                            f1("Tool not found on character:", name2)
                          end
                        end
                      end

                      task.wait(0.1)
                    end
                  end
                end
              end

              if f12() then
                task.wait(1)
              end
            end

            return
          end
        end
      end

      v23 = f21

      function f23()
        if v18 or not f12() then
          return
        end

        v18 = true
        f1("Starting queue processing...")

        while #v17 > 0 and f12() do
          local v47 = table.remove(v17, 1)

          if v20(v47) then
            if not f19(v47) then
              f1("Failed to collect:", v47.Name)
              table.insert(v17, v47)
            end
          else
            f1("Item no longer valid, skipping")
          end

          if f12() then
            task.wait(0.3)
          end
        end

        v18 = false
        f1("Queue processing finished")
      end

      connect = items.ChildAdded:Connect(function(child)
        if f12() and v20(child) then
          f25(child)

          if not v18 then
            task.spawn(f23)
          end
        end
      end)

      connect2 = items.ChildRemoved:Connect(function(child2)
        if not f12() then
          return
        end

        for m = #v17, 1, -1 do
          if v17[m] == child2 then
            table.remove(v17, m)
            f1("Removed from queue:", child2.Name)
          end
        end
      end)

      if f17() > 0 and f12() then
        task.spawn(f23)
      end

      localPlayer3.CharacterAdded:Connect(function(character2)
        if f12() then
          f1("Character changed, updating references...")
          character = character2
          v16 = f2(character, "HumanoidRootPart")

          if v16 then
            task.wait(1)
            f22(character)
          end
        end
      end)

      if f12() then
        task.wait(1)
        f22(character)
      end

      f1("AutoFarm system initialized successfully!")

      return function()
        _G.MoneyFarm_Stop = true
        f1("Stopping AutoFarm...")

        if connect then
          connect:Disconnect()
        end

        if connect2 then
          connect2:Disconnect()
        end

        v17 = {}
        v18 = false

        pcall(function()
          if currentCamera then
            currentCamera.CameraType = Enum.CameraType.Custom
          end
        end)

        f1("AutoFarm stopped completely")
      end
    end
  end

  localPlayer2 = players.LocalPlayer
  v8 = {}
  v9 = {}

  v10 = {
    playerEsp = function(p18) return p18.Name end,
    standEsp = function(p19)
      return p19:FindFirstChild("PlayerStats") and p19.PlayerStats:FindFirstChild("Stand")
        and p19.PlayerStats.Stand.Value
    end,
    raceEsp = function(p20)
      return p20:FindFirstChild("PlayerStats") and p20.PlayerStats:FindFirstChild("Race")
        and p20.PlayerStats.Race.Value
    end,
  }

  function f7(p21, p22, p23)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = p22
    billboardGui.Adornee = p21
    billboardGui.Size = UDim2.new(0, 200, 0, 50)

    if p22 == "playerEsp" then
      billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    elseif p22 == "standEsp" then
      billboardGui.StudsOffset = Vector3.new(0, 3.5, 0)
    else
      billboardGui.StudsOffset = Vector3.new(0, 5.5, 0)
    end

    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = p21

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = p23 or ""
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = billboardGui

    return billboardGui
  end

  function f6()
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
      return
    else
      local humanoidRootPart2 = localPlayer.Character.HumanoidRootPart

      for key3, value8 in pairs(workspace.Living:GetChildren()) do
        if value8:IsA("Model") and game.Players:FindFirstChild(value8.Name) then
          local v48 = game.Players[value8.Name]
          local v49 = false

          for index6, value9 in ipairs(v7) do
            if value9 and v48.Name == value9.Name then
              v49 = true
              break
            end
          end

          if not v49 and value8:FindFirstChild("HumanoidRootPart") then
            value8.HumanoidRootPart.CFrame = humanoidRootPart2.CFrame
          end
        end
      end

      return
    end
  end

  function f10(p24, p25)
    if not v10[p24] then
      return
    end

    if not p25 then
      v9[p24] = false

      if v8[p24] then
        v8[p24]:Disconnect()
        v8[p24] = nil
      end

      for index7, value10 in ipairs(players:GetPlayers()) do
        if value10 ~= localPlayer2 and value10.Character
          and value10.Character:FindFirstChild("Head") then
          local findFirstChild3 = value10.Character.Head:FindFirstChild(p24)

          if findFirstChild3 then
            findFirstChild3:Destroy()
          end
        end
      end

      return
    end

    v9[p24] = true

    v8[p24] = runService.RenderStepped:Connect(function()
      for index8, value11 in ipairs(players:GetPlayers()) do
        if value11 ~= localPlayer2 then
          local character3 = value11.Character

          if character3 then
            local head = character3:FindFirstChild("Head")

            if head then
              local v50 = v10[p24](value11)

              if v50 then
                local findFirstChild4 = head:FindFirstChild(p24)

                if not findFirstChild4 then
                  f7(head, p24, tostring(v50))
                else
                  findFirstChild4.TextLabel.Text = tostring(v50)
                end
              end
            end
          end
        end
      end
    end)
  end

  runService.Heartbeat:Connect(function()
    if _G.YbaGodMode_Enabled then
      f6()
    end
  end)

  function f8(p26)
    if not p26 or typeof(p26) ~= "Vector3" then
      return false
    else
      local position10 = humanoidRootPart.Position
      local magnitude3 = (p26 - position10).Magnitude

      if magnitude3 <= 0.1 then
        humanoidRootPart.CFrame = CFrame.new(p26, p26 + humanoidRootPart.CFrame.LookVector)
        return true
      else
        local v51 = math.max(1, math.ceil(magnitude3 / 18)) * 0.05
        local total4 = 0
        local cframe4 = humanoidRootPart.CFrame

        while total4 < v51 and true do
          total4 = total4 + runService.Heartbeat:Wait()
          local lerp3 = position10:Lerp(p26, (math.clamp(total4 / v51, 0, 1)))
          humanoidRootPart.CFrame = CFrame.new(lerp3, lerp3 + cframe4.LookVector)
        end

        humanoidRootPart.CFrame = CFrame.new(p26, p26 + cframe4.LookVector)
        return true
      end
    end
  end

  local v52

  v52, v11 = pcall(function()
    return windUI:CreateWindow({
      Title = "Revenge Hub | Universal loader",
      Icon = "coins",
      Author = "by volmaks.dev",
      Folder = "MoneyFarm",
      User = {
        Enabled = true,
        Anonymous = false,
        Callback = function() f1("User profile clicked") end,
      },
    })
  end)

  if not v52 or not v11 then
    f1("Failed to create window")
    return
  else
    function f11()
      players.LocalPlayer.Character:WaitForChild("RemoteEvent"):FireServer(unpack({
        "PurchaseShopItem", { ItemName = "1x Lucky Arrow" },
      }))
    end

    local v53

    v53, v12 = pcall(function()
      return v11:Tab({ Title = "Auto Farm", Icon = "bitcoin", Locked = false })
    end)

    if not v53 or not v12 then
      f1("Failed to create farm tab")
      return
    else
      v13 = nil

      if not pcall(function()
        return v12:Toggle({
          Title = "Enable Money Farm",
          Desc = "Automatically collect and sell items",
          Icon = "power-off",
          Type = "Checkbox",
          Default = false,
          Callback = function(value12)
            _G.MoneyFarm_Enabled = value12
            _G.MoneyFarm_Stop = not value12

            if value12 then
              f1("Starting Money Farm...")
              v13 = f9()

              if not v13 then
                f1("Failed to start AutoFarm")
                _G.MoneyFarm_Enabled = false
              end
            else
              f1("Stopping Money Farm...")

              if v13 then
                v13()
                v13 = nil
              end
            end
          end,
        })
      end) then
        f1("Failed to create farm toggle")
      end

      if not pcall(function()
        return v12:Toggle({
          Title = "Enable Auto buy Lucky Arrow",
          Desc = "Automatically buys lucky arrow from the shop",
          Icon = "power-off",
          Type = "Checkbox",
          Default = false,
          Callback = function(value13)
            _G.AutoBuyLuckyArrow = value13

            if value13 then
              f1("Starting Autobuy lucky arrows...")

              v13 = task.spawn(function()
                while _G.AutoBuyLuckyArrow do
                  if money.Value >= 50000 then
                    f11()
                    f1("Bought Lucky Arrow!")
                  end

                  task.wait(2)
                end
              end)
            else
              f1("Stopping Autobuy..")
              _G.AutoBuyLuckyArrow = false
              v13 = nil
            end
          end,
        })
      end) then
        f1("Failed to create auto buy toggle")
      end

      local ybaGodTab = v11:Tab({ Title = "Yba God", Icon = "bitcoin", Locked = false })

      ybaGodTab:Input({
        Title = "Add people to the ignore list",
        Desc = "You can put a part of the username",
        InputIcon = "bird",
        Type = "Input",
        Placeholder = "volmaks",
        Callback = function(value14)
          local v54 = f5(value14)

          if v54 then
            table.insert(v7, v54)
          end

          f4("Notification", tostring(v54) .. "was added to the ignore list", 4)
        end,
      })

      ybaGodTab:Input({
        Title = "Remove people from the ignore list",
        Desc = "You can put a part of the username",
        InputIcon = "bird",
        Type = "Input",
        Placeholder = "volmaks",
        Callback = function(value15)
          local v55 = f5(value15)

          if v55 then
            for index9, value16 in ipairs(v7) do
              if value16 and value16.Name == v55.Name then
                table.remove(v7, index9)
                f4("Notification", v55.Name .. " was removed from the ignore list", 4)
                return
              end
            end

            f4("Notification", v55.Name .. " was not found in the ignore list", 4)
            return
          end

          f4("Error", "Player not found", 4)
        end,
      })

      ybaGodTab:Toggle({
        Title = "YBA god mode",
        Desc = "Brings all player to you (except players, that has been mentioned in ignore)",
        Icon = "bird",
        Type = "Checkbox",
        Default = false,
        Callback = function(value17) _G.YbaGodMode_Enabled = value17 end,
      })

      Window:Tab({ Title = "Server Hop", Icon = "aperture", Locked = false }):Button({
        Title = "Server Hop",
        Desc = "Join another server",
        Locked = false,
        Callback = function() Teleport() end,
      })

      visualTab = Window:Tab({ Title = "Visual", Icon = "glasses", Locked = false })

      if not pcall(function()
        return visualTab:Toggle({
          Title = "Esp players",
          Desc = "",
          Icon = "power-off",
          Type = "Checkbox",
          Default = false,
          Callback = function(value18)
            _G.EspPlayers = value18

            if value18 then
              task.spawn(function() f10("playerEsp", _G.EspPlayers) end)
            else
              f10("playerEsp", _G.EspPlayers)
              _G.EspPlayers = false
            end
          end,
        })
      end) then
        warn("Failed to create playerEsp toggle")
      end

      if not pcall(function()
        return visualTab:Toggle({
          Title = "Esp Stand",
          Desc = "",
          Icon = "power-off",
          Type = "Checkbox",
          Default = false,
          Callback = function(value19)
            _G.EspStand = value19

            if value19 then
              task.spawn(function() f10("standEsp", _G.EspStand) end)
            else
              f10("standEsp", _G.EspStand)
              _G.EspStand = false
            end
          end,
        })
      end) then
        warn("Failed to create standEsp toggle")
      end

      if not pcall(function()
        return visualTab:Toggle({
          Title = "Esp Race",
          Desc = "",
          Icon = "power-off",
          Type = "Checkbox",
          Default = false,
          Callback = function(value20)
            _G.EspRace = value20

            if value20 then
              task.spawn(function() f10("raceEsp", _G.EspRace) end)
            else
              f10("raceEsp", _G.EspRace)
              _G.EspRace = false
            end
          end,
        })
      end) then
        warn("Failed to create raceEsp toggle")
      end

      fastTravelTab = Window:Tab({ Title = "Fast Travel", Icon = "hand-coins", Locked = false })
      fastTravelTab:Section({ Title = "Default TP", TextXAlignment = "Left", TextSize = 20 })

      fastTravelTab:Button({
        Title = "Travel to Merchant",
        Desc = "",
        Locked = false,
        Callback = function() f3(position, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Parking Lot",
        Desc = "",
        Locked = false,
        Callback = function() f3(position2, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Prison Bridge",
        Desc = "",
        Locked = false,
        Callback = function() f3(position3, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Train Station",
        Desc = "",
        Locked = false,
        Callback = function() f3(position4, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Via Toledo",
        Desc = "",
        Locked = false,
        Callback = function() f3(position5, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Via Dell Oceano",
        Desc = "",
        Locked = false,
        Callback = function() f3(position6, 10, 0.1) end,
      })

      pcall(function() fastTravelTab:Divider() end)
      fastTravelTab:Section({ Title = "Other TP", TextXAlignment = "Left", TextSize = 20 })
      pcall(function() fastTravelTab:Divider() end)

      fastTravelTab:Button({
        Title = "Travel to The Boss' Cafe",
        Desc = "",
        Locked = false,
        Callback = function() f3(vector2, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to the Arcade",
        Desc = "",
        Locked = false,
        Callback = function() f3(vector3, 10, 0.1) end,
      })

      fastTravelTab:Section({ Title = "Bosses", TextXAlignment = "Left", TextSize = 20 })

      pcall(function() fastTravelTab:Divider() end)

      fastTravelTab:Button({
        Title = "Travel to Jotaro Kujo",
        Desc = "",
        Locked = false,
        Callback = function() f3(vector4, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Dio",
        Desc = "",
        Locked = false,
        Callback = function() f3(vector5, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Diavolo",
        Desc = "",
        Locked = false,
        Callback = function() f3(vector6, 10, 0.1) end,
      })

      fastTravelTab:Button({
        Title = "Travel to Ascended Dio",
        Desc = "(Better to use after tp to the Prison Bridge)",
        Locked = false,
        Callback = function() f8(vector) end,
      })

      creditsTab = Window:Tab({ Title = "Credits", Icon = "scroll-text", Locked = false })
      creditsTab:Section({ Title = "Info", TextXAlignment = "Left", TextSize = 25 })

      pcall(function() creditsTab:Divider() end)

      creditsTab:Section({
        Title = "Current version: 1.0.0",
        TextXAlignment = "Left",
        TextSize = 20,
      })

      creditsTab:Section({
        Title = "Author: volmaks.dev (discord)",
        TextXAlignment = "Left",
        TextSize = 20,
      })

      creditsTab:Section({
        Title = "Tested on: Velocity (PC)",
        TextXAlignment = "Left",
        TextSize = 20,
      })

      creditsTab:Section({ Title = "Discord Server", TextXAlignment = "Left", TextSize = 25 })

      pcall(function() creditsTab:Divider() end)

      creditsTab:Paragraph({
        Title = "Discord server (EN)",
        Desc = "https://discord.gg/G5ZyAzVTsC",
        Color = "White",
        Locked = false,
        Buttons = {
          {
            Icon = "bird",
            Title = "Copy Server Link",
            Callback = function() toclipboard("https://discord.gg/G5ZyAzVTsC") end,
          },
        },
      })

      pcall(function() creditsTab:Divider() end)

      creditsTab:Section({ Title = "Note", TextXAlignment = "Left", TextSize = 20 })

      creditsTab:Section({
        Title = "Want to get early access and also be able to chat with me? - buy the premium version",
        TextXAlignment = "Center",
        TextSize = 15,
      })

      local tipsTab = Window:Tab({ Title = "Tips", Icon = "hand-coins", Locked = false })

      tipsTab:Section({
        Title = "Your support helps me a lot when creating scripts. Thank you!",
        TextXAlignment = "Left",
        TextSize = 15,
      })

      tipsTab:Paragraph({
        Title = "USDT TRC20",
        Desc = "",
        Color = "White",
        Locked = false,
        Buttons = {
          {
            Icon = "bird",
            Title = "Copy USDT TRC20 adress",
            Callback = function() toclipboard("TUfCoWaa8jQ2oCrzosE2vVRobLa6KukWbu") end,
          },
        },
      })

      tipsTab:Paragraph({
        Title = "TON",
        Desc = "The Open Network only",
        Color = "White",
        Locked = false,
        Buttons = {
          {
            Icon = "bird",
            Title = "Copy TON adress",
            Callback = function()
              toclipboard("UQCLInXLKldwVwlfQfy7EeEQJA5Oy3wXGcPgljrDFdQScQfy")
            end,
          },
        },
      })

      tipsTab:Paragraph({
        Title = "LTC",
        Desc = "Litecoin network only",
        Color = "White",
        Locked = false,
        Buttons = {
          {
            Icon = "bird",
            Title = "Copy LTC adress",
            Callback = function() toclipboard("ltc1q7auca24uggp7pz0fw24s67v7dxhlapwxfvxkum") end,
          },
        },
      })

      tipsTab:Paragraph({
        Title = "ETH",
        Desc = "Ethereum network only",
        Color = "White",
        Locked = false,
        Buttons = {
          {
            Icon = "bird",
            Title = "Copy ETH adress",
            Callback = function() toclipboard("0xFDe67e2fD7EEfC02545A510B0087a29F24ceb3FA") end,
          },
        },
      })

      f1("GUI loaded successfully!")
      f1("Ready to use - toggle the switch to start farming")

      return
    end
  end
end
