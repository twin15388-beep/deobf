local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local waitForChild = replicatedStorage:WaitForChild("Remotes", 10)
local fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local saveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local interfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local v1 = {
  any = 0,
  normal = 1,
  shadow = 2,
  ego = 3,
  golden = 4,
  overflow = 5,
  electric = 6,
  predator = 7,
  monster = 8,
  diamond = 9,
  awakening = 10,
  flowstate = 11,
}

local values = {
  "0 - Any (ทั้งหมด)", "1 - Normal", "2 - Shadow", "3 - Ego", "4 - Golden",
  "5 - Overflow", "6 - Electric", "7 - Predator", "8 - Monster", "9 - Diamond",
  "10 - Awakening", "11 - FlowState",
}

local v2 = {
  teamz = "teamz",
  ["team z"] = "teamz",
  tzraichi = "teamz",
  firstselection = "firstselection",
  ["first selection"] = "firstselection",
  fsisagi = "firstselection",
  secondselection = "secondselection",
  ["second selection"] = "secondselection",
  ssaryu = "secondselection",
  thirdselection = "thirdselection",
  ["third selection"] = "thirdselection",
  tskarasu = "thirdselection",
  ubers = "ubers",
  ubfukaku = "ubers",
  u20 = "u20",
  ["u-20"] = "u20",
  u20darai = "u20",
  b11 = "b11",
  b11otoya = "b11",
  b11aces = "b11aces",
  ["b11 aces"] = "b11aces",
  barin = "b11aces",
  zstrikers = "zstrikers",
  ["z strikers"] = "zstrikers",
  ["z-strikers"] = "zstrikers",
  zstrike = "zstrikers",
  zshido = "zstrikers",
  basmunchen = "basmunchen",
  ["bas munchen"] = "basmunchen",
  bm = "basmunchen",
  manshinecity = "manshinecity",
  ["manshine city"] = "manshinecity",
  mc = "manshinecity",
  pxg = "pxg",
  basmunchenelite = "basmunchenelite",
  ["bas munchen elite"] = "basmunchenelite",
  barchaelite = "barchaelite",
  ["barcha elite"] = "barchaelite",
  manshineelite = "manshineelite",
  ["manshine elite"] = "manshineelite",
  uberselite = "uberselite",
  ["ubers elite"] = "uberselite",
  pxgelite = "pxgelite",
  ["pxg elite"] = "pxgelite",
}

local v3 = {
  any = 0,
  teamz = 1,
  firstselection = 2,
  secondselection = 3,
  thirdselection = 4,
  ubers = 5,
  u20 = 6,
  b11 = 7,
  b11aces = 8,
  zstrikers = 9,
  basmunchen = 10,
  manshinecity = 11,
  pxg = 12,
  basmunchenelite = 13,
  barchaelite = 14,
  manshineelite = 15,
  uberselite = 16,
  pxgelite = 17,
}

local values2 = {
  "0 - Any (ซื้อทั้งหมด)", "1 - Team Z", "2 - First Selection",
  "3 - Second Selection", "4 - Third Selection", "5 - Ubers", "6 - U-20", "7 - B11",
  "8 - B11 Aces", "9 - Z-Strikers", "10 - BasMunchen", "11 - ManshineCity", "12 - PXG",
  "13 - BasMunchenElite", "14 - BarchaElite", "15 - ManshineElite", "16 - UbersElite",
  "17 - PXGElite",
}

local function f1(p1, p2)
  if type(p1) == "number" then
    return p1
  elseif not p1 then
    return p2 or 0
  else
    local d = tostring(p1):match("^(%d+)")

    if d then
      return tonumber(d)
    end

    return p2 or 0
  end
end

local function f2(p3)
  if not p3 or p3 == "" then
    return 0
  else
    local d2 = tostring(p3):match("^(%d+)")

    if d2 then
      return tonumber(d2)
    else
      local sS = string.lower(tostring(p3)):gsub("%s+", " "):match("^%s*(.-)%s*$")

      if v2[sS] then
        return v3[v2[sS]] or 0
      end

      for key, value in pairs(v2) do
        if string.find(sS, key, 1, true) then
          return v3[value] or 0
        end
      end

      for key2, value2 in pairs(v3) do
        if string.find(sS, key2, 1, true) or string.find(key2, sS, 1, true) then
          return value2
        end
      end

      return 0
    end
  end
end

local function f3(p4)
  if not p4 or p4 == "" then
    return 0
  else
    local d3 = tostring(p4):match("^(%d+)")

    if d3 then
      return tonumber(d3)
    else
      local sS2 = string.lower(tostring(p4)):match("^%s*(.-)%s*$")

      if v1[sS2] then
        return v1[sS2]
      end

      for key3, value3 in pairs(v1) do
        if string.find(sS2, key3, 1, true) then
          return value3
        end
      end

      return 0
    end
  end
end

local v4 = {
  F = 0,
  D = 1,
  C = 2,
  B = 3,
  A = 4,
  S = 5,
  SS = 6,
  SSS = 7,
  EX = 8,
  X = 9,
  UR = 10,
}

local v5 = {
  F = 0.5,
  D = 1,
  C = 1.5,
  B = 2.2,
  A = 3.5,
  S = 6,
  SS = 10,
  SSS = 16,
  EX = 28,
  X = 50,
  UR = 100,
}

local v6 = {
  Normal = 1,
  Shadow = 2,
  Ego = 3.5,
  Golden = 3.8,
  Overflow = 4.2,
  Electric = 5.5,
  Predator = 6.5,
  Monster = 8,
  Diamond = 15,
  Awakening = 20,
  FlowState = 25,
}

local v7 = {
  AutoCarrySell = false,
  TeleportMode = "InstantTP",
  TweenSpeed = 65,
  CollectDelay = 0.4,
  MinBallCountToCollect = 1,
  AutoPolisher = false,
  PolishTimeout = 12,
  AutoRollConveyor = false,
  RollDelay = 0.12,
  MinTargetBox = "0 - Any (ซื้อทั้งหมด)",
  MinTargetMutation = "0 - Any (ทั้งหมด)",
  MinBoxRank = 0,
  MinMutationRank = 0,
  ConveyorMatchMode = "Box AND Mutation",
  AutoTeleportToBuy = true,
  AutoEquipBest = false,
  AutoLevelUp = false,
  MaxUnitLevel = 50,
  AutoPlaceBox = false,
  PlaceBoxInterval = 2,
  AutoBuyMarket = false,
  MarketMinBox = "Any",
  MarketMinMutation = "Any",
  MarketScanDelay = 1.2,
  AutoUpgrades = false,
  UpgradeDelay = 0.05,
  AutoRerollGrade = false,
  RerollTargetGrade = "S",
  SelectedUnitIdentifier = "",
  SelectedUnitSource = "None",
  SelectedDropperRef = nil,
  RerollSpeed = 0.04,
  AutoCollectMap = false,
  CollectMapInterval = 3,
}

local function f4(p5)
  local v8 = math.floor(p5 or 0)

  if v8 >= 1000000000 then
    return string.format("%.1fB", v8 / 1000000000)
  elseif v8 >= 1000000 then
    return string.format("%.1fM", v8 / 1000000)
  else
    if v8 >= 1000 then
      return string.format("%.1fK", v8 / 1000)
    end

    return tostring(v8)
  end
end

local function f5(p6)
  if not p6 then
    return false
  end

  if firesignal then
    pcall(function() firesignal(p6.Activated) end)
    pcall(function() firesignal(p6.MouseButton1Click) end)
    return true
  end

  return false
end

local v9 = {
  CurrentPlot = nil,
  CollectPart = nil,
  SellNpc = nil,
  PolisherModel = nil,
  PolisherCollectPart = nil,
  RollStationPart = nil,
  RollButtonHitbox = nil,
  Status = "Initializing...",
  LastPlaceBoxTime = 0,
  LastMarketScanTime = 0,
  LastUpgradeTime = 0,
  LastCollectMapTime = 0,
  RerollingActive = false,
}

local function f6()
  if not v9.PolisherCollectPart then
    return false
  end

  if v9.PolisherCollectPart:FindFirstChild("ShinySellCrateModel") then
    return true
  end

  if (v9.PolisherCollectPart:GetAttribute("PolishedBallCount") or 0) > 0 then
    return true
  else
    local proximityPrompt = v9.PolisherCollectPart:FindFirstChildOfClass("ProximityPrompt")

    if proximityPrompt and proximityPrompt.Enabled and proximityPrompt.ActionText == "Collect" then
      return true
    end

    return false
  end
end

local function f7(p7, ...)
  if not waitForChild then
    return false
  else
    local findFirstChild = waitForChild:FindFirstChild(p7)

    if findFirstChild and findFirstChild:IsA("RemoteEvent") then
      findFirstChild:FireServer(...)
      return true
    end

    if findFirstChild and findFirstChild:IsA("RemoteFunction") then
      return findFirstChild:InvokeServer(...)
    end

    return false
  end
end

local function f8()
  local plotModels = workspace:FindFirstChild("Map")
    and workspace.Map:FindFirstChild("PlotModels")

  if not plotModels then
    return nil
  else
    local findFirstChild2 = plotModels:FindFirstChild(localPlayer.Name)

    if findFirstChild2 then
      return findFirstChild2
    else
      local character = localPlayer.Character
      local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
      local v10 = nil
      local huge = math.huge

      for index, value4 in ipairs(plotModels:GetChildren()) do
        local systems = value4:FindFirstChild("Systems")

        local tycoonConveyor = systems
        tycoonConveyor = systems and value4.Systems:FindFirstChild("TycoonConveyor")

        if tycoonConveyor then
          local collectPart = tycoonConveyor:FindFirstChild("CollectPart")

          if collectPart and humanoidRootPart then
            local magnitude = (collectPart.Position - humanoidRootPart.Position).Magnitude

            if magnitude < huge then
              huge = magnitude
              v10 = value4
            end
          end
        end
      end

      return v10
    end
  end
end

local function f9(p8)
  local character2 = localPlayer.Character

  if not character2 then
    return
  else
    local humanoidRootPart2 = character2:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart2 then
      return
    end

    if v7.TeleportMode == "RemoteOnly" then
      return
    end

    if v7.TeleportMode == "InstantTP" then
      humanoidRootPart2.CFrame = CFrame.new(p8 + Vector3.new(0, 3, 0))
      task.wait(0.08)
    elseif v7.TeleportMode == "Tween" then
      local v11 = math.clamp(
        (humanoidRootPart2.Position - p8).Magnitude / v7.TweenSpeed, 0.1, 4
      )

      local create = tweenService:Create(
        humanoidRootPart2, TweenInfo.new(v11, Enum.EasingStyle.Linear),
        { CFrame = CFrame.new(p8 + Vector3.new(0, 3, 0)) }
      )

      create:Play()
      create.Completed:Wait()
    end

    return
  end
end

local function f10(p9)
  if not p9 or not p9.Parent then
    return false
  end

  pcall(function()
    if fireproximityprompt then
      fireproximityprompt(p9, 0)
      fireproximityprompt(p9)
    end
  end)

  pcall(function()
    p9:InputHoldBegin()
    task.wait(p9.HoldDuration or 0)
    p9:InputHoldEnd()
  end)

  return true
end

local function f11()
  if not v9.CollectPart then
    return false
  end

  if v9.CollectPart:FindFirstChild("SellCrateModel") then
    return true
  end

  if (v9.CollectPart:GetAttribute("PendingBallCount") or 0) >= v7.MinBallCountToCollect then
    return true
  else
    local proximityPrompt2 = v9.CollectPart:FindFirstChildOfClass("ProximityPrompt")

    if proximityPrompt2 and proximityPrompt2.Enabled then
      return true
    end

    return false
  end
end

local function f12()
  local character3 = localPlayer.Character

  if not character3 then
    return false
  end

  for index2, value5 in ipairs(character3:GetChildren()) do
    if (value5:IsA("Model") or value5:IsA("Tool")) and string.find(value5.Name, "Crate") then
      return true
    end
  end

  if localPlayer:GetAttribute("HoldingCrate") or localPlayer:GetAttribute("Carrying") then
    return true
  end

  return false
end

local function f13()
  if not v9.CurrentPlot then
    return {}
  else
    local tycoonConveyor2 = v9.CurrentPlot:FindFirstChild("Systems")
      and v9.CurrentPlot.Systems:FindFirstChild("TycoonConveyor")

    if not tycoonConveyor2 then
      return {}
    else
      local conveyors = tycoonConveyor2:FindFirstChild("Conveyors")

      if not conveyors then
        return {}
      else
        local v12 = {}

        for index3, value6 in ipairs(conveyors:GetChildren()) do
          local droppers = value6:FindFirstChild("Droppers")

          if droppers then
            for index4, value7 in ipairs(droppers:GetChildren()) do
              table.insert(v12, value7)
            end
          end
        end

        return v12
      end
    end
  end
end

local function f14()
  local v13 = f8()

  if not v13 then
    v9.Status = "Plot not found!"
    return false
  else
    v9.CurrentPlot = v13

    local tycoonConveyor3 = v13:FindFirstChild("Systems")
      and v13.Systems:FindFirstChild("TycoonConveyor")

    if tycoonConveyor3 then
      v9.CollectPart = tycoonConveyor3:FindFirstChild("CollectPart")
    end

    local zones = v13:FindFirstChild("Systems") and v13.Systems:FindFirstChild("Zones")

    if zones then
      v9.SellNpc = zones:FindFirstChild("sell npc")
    end

    local polisherModel = v13:FindFirstChild("Systems")
      and v13.Systems:FindFirstChild("PolisherModel")

    if polisherModel then
      v9.PolisherModel = polisherModel

      if polisherModel:FindFirstChild("PhysicalModel") then
        v9.PolisherCollectPart = polisherModel.PhysicalModel:FindFirstChild("CollectPart")
      end
    end

    local systems2 = v13:FindFirstChild("Systems")

    if systems2 then
      local rollStation = systems2:FindFirstChild("RollStation")

      if rollStation then
        v9.RollStationPart = rollStation:FindFirstChild("ConveyorPart")
      end

      local buttonModel = systems2:FindFirstChild("ButtonModel")

      if buttonModel and buttonModel:FindFirstChild("Button")
        and buttonModel.Button:FindFirstChild("Model") then
        v9.RollButtonHitbox = buttonModel.Button.Model:FindFirstChild("Hitbox")
      end
    end

    v9.Status = "Plot linked: " .. v13.Name
    return v9.CollectPart ~= nil and v9.SellNpc ~= nil
  end
end

local function f15()
  if not v9.SellNpc then
    return false
  end

  v9.Status = "Moving to Sell NPC..."

  f9(v9.SellNpc:FindFirstChild("HumanoidRootPart") and v9.SellNpc.HumanoidRootPart.Position
    or v9.SellNpc:GetPivot().Position)

  v9.Status = "Selling crates..."
  task.wait(0.15)
  f7("SellCrate")
  v9.SellNpc:FindFirstChildOfClass("ProximityPrompt")
  task.wait(v7.CollectDelay)
  return true
end

local function f16()
  if not v9.CollectPart then
    return false
  end

  v9.Status = "Moving to Conveyor..."
  f9(v9.CollectPart.Position)
  v9.Status = "Carrying crates..."
  task.wait(0.15)
  f7("PickupCrateBox")
  v9.CollectPart:FindFirstChildOfClass("ProximityPrompt")
  task.wait(v7.CollectDelay)
  return true
end

local function f17()
  if not v9.PolisherCollectPart or not v9.PolisherModel then
    return false
  elseif f6() then
    v9.Status = "Collecting ready Polished Crate..."
    f9(v9.PolisherCollectPart.Position)
    task.wait(0.15)
    f7("CollectPolisherCrate")
    v9.PolisherCollectPart:FindFirstChildOfClass("ProximityPrompt")
    task.wait(0.3)
    f15()
    return true
  else
    v9.Status = "Depositing into Polisher..."
    f9(v9.PolisherCollectPart.Position)
    task.wait(0.15)
    f7("DepositCrate")

    v9.PolisherCollectPart:FindFirstChildOfClass("ProximityPrompt")
    v9.Status = "Polishing crates in progress..."

    local v14 = tick()

    while tick() - v14 < v7.PolishTimeout do
      task.wait(0.3)

      if f6() then
        break
      end

      if v9.PolisherModel:GetAttribute("PolisherActive") == false and tick() - v14 > 2 then
        break
      end
    end

    task.wait(0.2)
    v9.Status = "Collecting Polished Crate..."
    f9(v9.PolisherCollectPart.Position)
    task.wait(0.15)
    f7("CollectPolisherCrate")
    v9.PolisherCollectPart:FindFirstChildOfClass("ProximityPrompt")
    task.wait(0.35)
    f15()
    return true
  end
end

task.spawn(function()
  while true do
    pcall(function()
      if not v9.CurrentPlot or not v9.CollectPart then
        f14()
        task.wait(1)
        return
      end

      if v7.AutoPolisher and f6() then
        f17()
        task.wait(0.4)
        return
      end

      if v7.AutoCarrySell then
        if f11() or f12() then
          f16()

          if v7.AutoPolisher and v9.PolisherCollectPart then
            f17()
          else
            f15()
          end

          v9.Status = "Completed batch. Waiting..."
        else
          v9.Status = "Accumulating crates..."
        end
      end
    end)

    task.wait(0.5)
  end
end)

local function f18()
  if not (v9.RollStationPart and v9.RollStationPart.Parent) and v9.CurrentPlot then
    local systems3 = v9.CurrentPlot:FindFirstChild("Systems")
    local rollStation2 = systems3 and systems3:FindFirstChild("RollStation")

    if rollStation2 then
      v9.RollStationPart = rollStation2:FindFirstChild("ConveyorPart")
    end
  end

  local rollStationPart = v9.RollStationPart

  if rollStationPart then
    local boxName = rollStationPart:GetAttribute("BoxName")
    local variant = rollStationPart:GetAttribute("Variant")
    local rollId = rollStationPart:GetAttribute("RollId")
    local rollCooldownUntil = rollStationPart:GetAttribute("RollCooldownUntil") or 0

    if boxName and boxName ~= "" then
      return boxName, variant or "Normal", rollId, rollCooldownUntil
    else
      local boxModel = rollStationPart:FindFirstChild("BoxModel")
      local boxPriceBillboardGui = boxModel and boxModel:FindFirstChild("BoxPriceBillboardGui")
      local frame = boxPriceBillboardGui and boxPriceBillboardGui:FindFirstChild("Frame")

      if frame then
        local nameLabel = frame:FindFirstChild("NameLabel")
        local variantLabel = frame:FindFirstChild("VariantLabel")

        if nameLabel and nameLabel.Text ~= "" then
          return nameLabel.Text, variantLabel and variantLabel.Text ~= "" and variantLabel.Text or "Normal", rollId, rollCooldownUntil
        end

        return "TeamZ", "Normal", nil, 0
      end

      return "TeamZ", "Normal", nil, 0
    end
  else
    return "TeamZ", "Normal", nil, 0
  end
end

local function f19(p10, p11)
  local v15 = f1(v7.MinTargetBox, v7.MinBoxRank or 0)
  local v16 = f1(v7.MinTargetMutation, v7.MinMutationRank or 0)
  local v17 = f2(p10)
  local v18 = f3(p11)
  local v19 = v15 == 0 or v17 >= v15
  local v20 = v16 == 0 or v18 >= v16

  if v7.ConveyorMatchMode == "Box Only" then
    return v19
  elseif v7.ConveyorMatchMode == "Mutation Only" then
    return v20
  else
    if v7.ConveyorMatchMode == "Box OR Mutation" then
      return v19 or v20
    end

    return v19 and v20
  end
end

local function f20(p12, p13, p14)
  local rollStationPart2 = v9.RollStationPart
  local character4 = localPlayer.Character
  local humanoidRootPart3 = character4 and character4:FindFirstChild("HumanoidRootPart")
  local cframe = humanoidRootPart3 and humanoidRootPart3.CFrame

  if v7.AutoTeleportToBuy and humanoidRootPart3 and rollStationPart2 then
    humanoidRootPart3.CFrame = CFrame.new(rollStationPart2.Position + Vector3.new(0, 3, 2))
    task.wait(0.12)
  end

  local v21 = tick()

  while tick() - v21 < 2 do
    if v9.RollButtonHitbox and v9.RollButtonHitbox.Parent then
      local clickDetector = v9.RollButtonHitbox:FindFirstChildOfClass("ClickDetector")

      if clickDetector then
        pcall(function() fireclickdetector(clickDetector) end)
        pcall(function() fireclickdetector(clickDetector, 0) end)
      end
    end

    if rollStationPart2 and rollStationPart2.Parent then
      for index5, value8 in ipairs(rollStationPart2.Parent:GetDescendants()) do
        if value8:IsA("ProximityPrompt") then
          f10(value8)
        end
      end
    end

    if p14 then
      f7("PurchaseConveyorRoll", p14)
    end

    f7("PurchaseConveyorRoll")
    f7("RequestSetConveyorSelectedBox", p12)
    f7("RequestSetConveyorAutoBuy", true)
    f7("RequestSetConveyorAutoSpawn", true)

    pcall(function()
      local waitForChild2 = localPlayer:WaitForChild("PlayerGui", 2)
      local autoBuyGui = waitForChild2 and waitForChild2:FindFirstChild("AutoBuyGui")
      local mainFrame = autoBuyGui and autoBuyGui:FindFirstChild("MainFrame")
      local scrollingHolder = mainFrame and mainFrame:FindFirstChild("ScrollingHolder")

      local autoConveyorFrame = scrollingHolder
        and scrollingHolder:FindFirstChild("AutoConveyorFrame")

      local autoBuyFrame = autoConveyorFrame
        and autoConveyorFrame:FindFirstChild("AutoBuyFrame")

      local onButton = autoBuyFrame and autoBuyFrame:FindFirstChild("OnButton")
    end)

    task.wait(0.12)
    local v22, v23, v24 = f18()

    if v24 and p14 and v24 ~= p14 or v22 ~= p12 then
      break
    end
  end

  task.wait(0.15)
  f7("RequestSetConveyorAutoBuy", false)

  if v7.AutoTeleportToBuy and cframe and humanoidRootPart3 and rollStationPart2 then
    if (cframe.Position - rollStationPart2.Position).Magnitude > 10 then
      humanoidRootPart3.CFrame = cframe
    end
  end
end

task.spawn(function()
  while true do
    task.wait(0.05)

    if not v7.AutoRollConveyor then
      task.wait(0.5)
    elseif not v9.CurrentPlot then
      task.wait(1)
    else
      pcall(function()
        local v25, v26, v27, v28 = f18()
        local v29 = f2(v25)
        local v30 = f3(v26)
        local v31 = f1(v7.MinTargetBox, v7.MinBoxRank or 0)
        local v32 = f1(v7.MinTargetMutation, v7.MinMutationRank or 0)

        v9.Status = string.format(
          "Roll: %s[%d] %s[%d] | Target: Box[%d] Mut[%d] (%s)", tostring(v25), v29,
          tostring(v26), v30, v31, v32, v7.ConveyorMatchMode or "AND"
        )

        local v33 = tick()
        local v34 = v28 and v28 > 0 and v28 - v33 > 0.3

        if f19(v25, v26) then
          v9.Status = string.format(
            "✅ MATCH! Teleporting & Pressing E to Buy %s [%s]", v25, v26
          )

          fluent:Notify({
            Title = "🎉 Conveyor Matched!",
            Content = string.format(
              "Purchasing: %s (%s) | BoxRank=%d MutRank=%d", v25, v26, v29, v30
            ),
            Duration = 3,
          })

          f20(v25, v26, v27)
          task.wait(1.5)
        elseif v34 then
          local v35 = math.clamp(v28 - v33, 0, 3)
          task.wait(v35 + 0.05)
        else
          f7("RequestConveyorRoll")
          task.wait(math.max(v7.RollDelay, 0.1))
        end
      end)
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(1.5)

    if v7.AutoEquipBest then
      f7("EquipBestPlayerUnits")
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(0.02)

    if not v7.AutoLevelUp then
      task.wait(0.3)
    else
      pcall(function()
        local v36 = {}

        for index6, value9 in ipairs((f13())) do
          local playerUnitName = value9:GetAttribute("PlayerUnitName")
          local unlocked = value9:GetAttribute("Unlocked")
          local playerUnitLevel = value9:GetAttribute("PlayerUnitLevel") or 0

          if unlocked ~= false and playerUnitName and playerUnitName ~= ""
            and playerUnitLevel < v7.MaxUnitLevel then
            table.insert(v36, { dropper = value9, level = playerUnitLevel })
          end
        end

        if #v36 == 0 then
          task.wait(0.3)
          return
        end

        table.sort(v36, function(p15, p16) return p15.level < p16.level end)

        for index7, value10 in ipairs(v36) do
          if not v7.AutoLevelUp then
            break
          end

          f7("RequestPlayerUnitLevelUp", value10.dropper)
        end
      end)
    end
  end
end)

local function f21(p17, p18, p19)
  local v37 = p17 or 1
  local v38 = p18 or "D"
  local v39 = p19 or "Normal"
  return math.floor(v37 * (v5[v38] or 1) * (v6[v39] or 1) * 10)
end

local function f22(p20)
  local playerUnitLevel2 = p20:GetAttribute("PlayerUnitLevel") or 1
  local playerUnitGrade = p20:GetAttribute("PlayerUnitGrade") or "D"
  local playerUnitVariant = p20:GetAttribute("PlayerUnitVariant") or "Normal"
  local ballSpawnCount = p20:GetAttribute("BallSpawnCount")
  return f21(playerUnitLevel2, playerUnitGrade, playerUnitVariant) * (ballSpawnCount or 1)
end

local function f23()
  local v40 = {}

  for index8, value11 in ipairs(localPlayer.Backpack:GetChildren()) do
    if value11:IsA("Tool") then
      local inventoryType = value11:GetAttribute("InventoryType") or ""
      local name = value11.Name
      local variant2 = value11:GetAttribute("Variant") or "Normal"

      if string.find(string.lower(name), "box")
        or string.find(string.lower(inventoryType), "box")
        or string.find(string.lower(name), "crate") then
        local v41 = 0

        for key4, value12 in pairs(v3) do
          if string.find(string.lower(name), string.lower(key4)) and value12 > v41 then
            v41 = value12
          end
        end

        table.insert(v40, {
          tool = value11,
          name = name,
          variant = variant2,
          score = v41 * 100 + (v1[variant2] or 1),
        })
      end
    end
  end

  table.sort(v40, function(p21, p22) return p21.score > p22.score end)
  return v40
end

task.spawn(function()
  while true do
    task.wait(0.2)

    if not v7.AutoPlaceBox then
      task.wait(0.5)
    elseif tick() - v9.LastPlaceBoxTime < v7.PlaceBoxInterval then
    else
      v9.LastPlaceBoxTime = tick()

      pcall(function()
        local v42 = f23()

        if #v42 == 0 then
          return
        else
          local v43 = v42[1]
          local v44 = f13()
          local v45 = nil
          local v46 = nil
          local huge2 = math.huge

          for index9, value13 in ipairs(v44) do
            if value13:GetAttribute("Unlocked") ~= false then
              local playerUnitName2 = value13:GetAttribute("PlayerUnitName")

              if not playerUnitName2 or playerUnitName2 == "" then
                v45 = value13
                break
              end

              local v47 = f22(value13)

              if v47 < huge2 then
                huge2 = v47
                v46 = value13
              end
            end
          end

          local v48 = v45

          if not v48 and v46 then
            v9.Status = string.format("Removing weakest dropper (~$%s/s)...", f4(huge2))
            f7("RemovePlayerUnitFromDropper", v46)
            task.wait(0.3)
            v48 = v46
          end

          if v48 then
            v9.Status = string.format("Placing Best Box: %s [%s]...", v43.name, v43.variant)

            f7("PlaceBoxOnDropper", v48, v43.tool)
            f7("PlaceBoxOnDropper", v48)

            task.wait(0.3)
            f7("OpenBoxOnDropper", v48)

            if v48:FindFirstChild("ProximityAttachment") then
              v48.ProximityAttachment:FindFirstChildOfClass("ProximityPrompt")
            end

            fluent:Notify({
              Title = "Smart Box Placed",
              Content = string.format("Placed %s (%s)", v43.name, v43.variant),
              Duration = 2.5,
            })
          end

          return
        end
      end)
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(0.2)

    if not v7.AutoBuyMarket then
      task.wait(0.8)
    elseif tick() - v9.LastMarketScanTime < v7.MarketScanDelay then
    else
      v9.LastMarketScanTime = tick()

      pcall(function()
        local marketGui = localPlayer:FindFirstChild("PlayerGui")
          and localPlayer.PlayerGui:FindFirstChild("MarketGui")

        if not marketGui then
          return
        else
          local scrollingFrame = marketGui:FindFirstChild("MainFrame")
            and marketGui.MainFrame:FindFirstChild("ScrollingHolder")
            and marketGui.MainFrame.ScrollingHolder:FindFirstChild("ScrollingFrame")

          if not scrollingFrame then
            return
          end

          for index10, value14 in ipairs(scrollingFrame:GetChildren()) do
            if value14:IsA("ImageLabel") and value14.Name ~= "old" and value14.Name ~= "Default" then
              local itemNameLabel = value14:FindFirstChild("ItemNameLabel")
              local variantLabel2 = value14:FindFirstChild("VariantLabel")
              local text = itemNameLabel and itemNameLabel.Text or value14.Name
              local text2 = variantLabel2 and variantLabel2.Text or "Normal"
              local buttonHolder = value14:FindFirstChild("ButtonHolder")

              local cashButton = buttonHolder
              cashButton = buttonHolder and buttonHolder:FindFirstChild("CashButton")

              local v49 = false

              if not cashButton or not cashButton.Visible then
                v49 = true
              else
                local stockLabel = value14:FindFirstChild("StockLabel")
                  or value14:FindFirstChild("StockText")
                  or value14:FindFirstChild("AmountLabel")

                if stockLabel then
                  local v50 = string.lower(stockLabel.Text or "")

                  if v50 == "0" or string.find(v50, "sold") or string.find(v50, "out") then
                    v49 = true
                  end
                end

                if value14:FindFirstChild("SoldOutFrame") and value14.SoldOutFrame.Visible then
                  v49 = true
                end
              end

              if not v49 and f19(text, text2, v7.MarketMinBox, v7.MarketMinMutation) then
                if cashButton then
                  f5(cashButton)

                  f7("MarketPurchaseCash", value14.Name)
                  f7("MarketPurchaseCash", value14)

                  v9.Status = string.format("Bought Market: %s [%s]", text, text2)

                  fluent:Notify({
                    Title = "Market Purchased",
                    Content = string.format("%s (%s)", text, text2),
                    Duration = 2.5,
                  })

                  task.wait(0.3)
                end
              end
            end
          end

          return
        end
      end)
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(0.1)

    if not v7.AutoUpgrades then
      task.wait(0.5)
    elseif tick() - v9.LastUpgradeTime < 0.4 then
    else
      v9.LastUpgradeTime = tick()

      pcall(function()
        local upgradesGui = localPlayer:FindFirstChild("PlayerGui")
          and localPlayer.PlayerGui:FindFirstChild("UpgradesGui")

        local scrollingFrame2 = upgradesGui and upgradesGui:FindFirstChild("MainFrame")
          and upgradesGui.MainFrame:FindFirstChild("ScrollingHolder")
          and upgradesGui.MainFrame.ScrollingHolder:FindFirstChild("ScrollingFrame")

        if scrollingFrame2 then
          for index11, value15 in ipairs(scrollingFrame2:GetChildren()) do
            if value15:IsA("ImageLabel") and value15.Name ~= "Default" then
              local buttonHolder2 = value15:FindFirstChild("ButtonHolder")

              local cashButton2 = buttonHolder2
              cashButton2 = buttonHolder2 and buttonHolder2:FindFirstChild("CashButton")

              if cashButton2 then
                f5(cashButton2)
                f7("PurchaseUpgrade", value15.Name)
                task.wait(v7.UpgradeDelay)
              end
            end
          end
        else
          for index12, value16 in ipairs({
            "Speed", "Income", "Capacity", "Multiplier", "BallSpeed", "DropRate",
          }) do
            f7("PurchaseUpgrade", value16)
            task.wait(v7.UpgradeDelay)
          end
        end
      end)
    end
  end
end)

local function f24()
  local v51 = {}

  for index13, value17 in ipairs((f13())) do
    local playerUnitName3 = value17:GetAttribute("PlayerUnitName")
    local playerUnitGrade2 = value17:GetAttribute("PlayerUnitGrade") or "?"
    local playerUnitLevel3 = value17:GetAttribute("PlayerUnitLevel") or 1
    local playerUnitVariant2 = value17:GetAttribute("PlayerUnitVariant") or "Normal"

    if playerUnitName3 and playerUnitName3 ~= "" then
      local v52 = f22(value17)

      local v53 = string.format(
        "[House] %s | Lv.%d | %s | %s | ~$%s/s", playerUnitName3, playerUnitLevel3,
        playerUnitVariant2, playerUnitGrade2, f4(v52)
      )

      table.insert(v51, {
        display = v53,
        name = playerUnitName3,
        grade = playerUnitGrade2,
        level = playerUnitLevel3,
        variant = playerUnitVariant2,
        cashPerSec = v52,
        dropper = value17,
        source = "House",
      })
    end
  end

  return v51
end

local function f25()
  local v54 = {}

  for index14, value18 in ipairs(localPlayer.Backpack:GetChildren()) do
    if value18:IsA("Tool") then
      local inventoryType2 = value18:GetAttribute("InventoryType") or ""
      local group = value18:GetAttribute("Group") or ""
      local grade = value18:GetAttribute("Grade")

      if string.find(string.lower(inventoryType2), "playerunit")
        or string.find(string.lower(group), "playerunit") or grade then
        local v55 = grade or "?"
        local level = value18:GetAttribute("Level") or 1
        local variant3 = value18:GetAttribute("Variant") or "Normal"
        local v56 = f21(level, v55, variant3)

        local v57 = string.format(
          "[Bag] %s | Lv.%d | %s | %s | ~$%s/s", value18.Name, level, variant3, v55, f4(v56)
        )

        table.insert(v54, {
          display = v57,
          name = value18.Name,
          grade = v55,
          level = level,
          variant = variant3,
          cashPerSec = v56,
          tool = value18,
          source = "Bag",
        })
      end
    end
  end

  return v54
end

task.spawn(function()
  while true do
    task.wait(v7.RerollSpeed)

    if not v7.AutoRerollGrade or not v9.RerollingActive then
      task.wait(0.2)
    else
      pcall(function()
        local v58 = v4[v7.RerollTargetGrade] or 5

        if v7.SelectedUnitSource == "House" and v7.SelectedDropperRef then
          local selectedDropperRef = v7.SelectedDropperRef
          local playerUnitGrade3 = selectedDropperRef:GetAttribute("PlayerUnitGrade") or "D"

          if (v4[playerUnitGrade3] or 1) >= v58 then
            v9.Status = "Target Grade Achieved: " .. playerUnitGrade3
            v9.RerollingActive = false

            v7.AutoRerollGrade = false

            fluent:Notify({
              Title = "Reroll Complete!",
              Content = string.format("Achieved Grade: %s", playerUnitGrade3),
              Duration = 4,
            })

            return
          end

          f7("RemovePlayerUnitFromDropper", selectedDropperRef)
          task.wait(0.4)
          v7.SelectedUnitSource = "Bag"
          return
        else
          local findFirstChild3 = localPlayer.Backpack:FindFirstChild(v7.SelectedUnitIdentifier)

          if not findFirstChild3 and localPlayer.Character then
            findFirstChild3 = localPlayer.Character:FindFirstChild(v7.SelectedUnitIdentifier)
          end

          if findFirstChild3 then
            local grade2 = findFirstChild3:GetAttribute("Grade")
              or findFirstChild3:GetAttribute("PlayerUnitGrade") or "D"

            if (v4[grade2] or 1) >= v58 then
              v9.Status = "Target Grade Achieved: " .. grade2
              v9.RerollingActive = false

              v7.AutoRerollGrade = false

              fluent:Notify({
                Title = "Reroll Complete!",
                Content = string.format(
                  "Achieved Grade %s on %s!", grade2, findFirstChild3.Name
                ),
                Duration = 4,
              })

              return
            end

            v9.Status = string.format(
              "Rerolling %s (Current: %s -> Goal: %s)", findFirstChild3.Name, grade2,
              v7.RerollTargetGrade
            )

            f7("RerollPlayerUnitGrade", findFirstChild3)
            f7("RerollPlayerUnitGrade", findFirstChild3.Name)

            local inventoryKey = findFirstChild3:GetAttribute("InventoryKey")

            if inventoryKey then
              f7("RerollPlayerUnitGrade", inventoryKey)
            end

            local gradingGui = localPlayer:FindFirstChild("PlayerGui")
              and localPlayer.PlayerGui:FindFirstChild("GradingGui")

            if gradingGui then
              if gradingGui:FindFirstChild("MainFrame") then
                if gradingGui.MainFrame:FindFirstChild("BottomButtonHolder") then
                  gradingGui.MainFrame.BottomButtonHolder:FindFirstChild("OneRollButton")
                end
              end
            end

            return
          end

          v9.Status = "Target unit not found in bag!"
          task.wait(0.4)
          return
        end
      end)
    end
  end
end)

local function f26()
  local systems4 = workspace:FindFirstChild("Systems")

  if not systems4 then
    return 0
  else
    local character5 = localPlayer.Character
    local humanoidRootPart4 = character5 and character5:FindFirstChild("HumanoidRootPart")

    if not humanoidRootPart4 then
      return 0
    else
      local cframe2 = humanoidRootPart4.CFrame
      local count = 0

      for index15, value19 in ipairs({
        systems4:FindFirstChild("CollectableObjects"),
        systems4:FindFirstChild("VariantTokenSpawns"),
        systems4:FindFirstChild("ActiveCollectableObjects"),
        systems4:FindFirstChild("ActiveVariantTokenSpawns"),
      }) do
        if value19 then
          for index16, value20 in ipairs(value19:GetChildren()) do
            local occupied = value20:GetAttribute("Occupied")
            local objectKey = value20:GetAttribute("ObjectKey")
            local v59 = value20.Name == "TemplateToken"

            local v60 = v59
            v60 = v59 and #value19:GetChildren() <= 2

            if not value20:FindFirstChildOfClass("Model") then
              if not value20:FindFirstChildOfClass("MeshPart") then
                value20:IsA("BasePart")
              end
            end

            local proximityPrompt3 = value20:FindFirstChildOfClass("ProximityPrompt")

            if occupied == true or objectKey ~= nil and objectKey ~= ""
              or string.find(value19.Name, "Active") and not v60 or proximityPrompt3 ~= nil then
              local position = nil

              if value20:IsA("BasePart") then
                position = value20.Position
              elseif value20:IsA("Model") then
                position = value20:GetPivot().Position
              end

              if position then
                humanoidRootPart4.CFrame = CFrame.new(position + Vector3.new(0, 2.5, 0))
                task.wait(0.12)

                if firetouchinterest and value20:IsA("BasePart") then
                  firetouchinterest(humanoidRootPart4, value20, 0)
                  task.wait(0.04)
                  firetouchinterest(humanoidRootPart4, value20, 1)
                end

                for index17, value21 in ipairs(value20:GetDescendants()) do
                  if value21:IsA("ProximityPrompt") then
                    f10(value21)
                  end
                end

                if value20:FindFirstChildOfClass("ProximityPrompt") then
                  f10(value20:FindFirstChildOfClass("ProximityPrompt"))
                end

                f7("CollectCollectableObject", value20)
                f7("CollectVariantTokenSpawn", value20)

                count = count + 1
                task.wait(0.1)
              end
            end
          end
        end
      end

      if count > 0 and humanoidRootPart4 then
        task.wait(0.1)
        humanoidRootPart4.CFrame = cframe2
      end

      return count
    end
  end
end

task.spawn(function()
  v9.LastCollectMapTime = 0

  while true do
    task.wait(0.5)

    if not v7.AutoCollectMap then
      task.wait(0.5)
    else
      local v61 = tick()

      if v61 - v9.LastCollectMapTime < v7.CollectMapInterval then
      else
        v9.LastCollectMapTime = v61

        pcall(function()
          local v62 = f26()

          v9.Status = v62 > 0 and string.format("Collected %d map items!", v62)
            or "Map: No live items found."
        end)
      end
    end
  end
end)

local voidxhubWindow = fluent:CreateWindow({
  Title = "VOIDXHUB",
  SubTitle = "Blue Lock Farm By doraemon_2244",
  TabWidth = 155,
  Size = UDim2.fromOffset(610, 490),
  Acrylic = false,
  Theme = "Dark",
  MinimizeKey = Enum.KeyCode.LeftControl,
})

local v63 = {
  Main = voidxhubWindow:AddTab({ Title = "Carry & Sell", Icon = "shopping-cart" }),
  Conveyor = voidxhubWindow:AddTab({ Title = "Auto Roll", Icon = "repeat" }),
  Units = voidxhubWindow:AddTab({ Title = "Units & Level", Icon = "users" }),
  PlaceBox = voidxhubWindow:AddTab({ Title = "Place Box", Icon = "box" }),
  Market = voidxhubWindow:AddTab({ Title = "Market", Icon = "tag" }),
  Upgrades = voidxhubWindow:AddTab({ Title = "Upgrades", Icon = "arrow-up" }),
  Ranking = voidxhubWindow:AddTab({ Title = "Ranking", Icon = "star" }),
  Map = voidxhubWindow:AddTab({ Title = "Map Collect", Icon = "map-pin" }),
  Settings = voidxhubWindow:AddTab({ Title = "Settings", Icon = "settings" }),
}

local liveStatusAddParagraph = v63.Main:AddParagraph({
  Title = "Live Status",
  Content = "Initializing...",
})

task.spawn(function()
  while true do
    local v64 = ""

    if v9.CollectPart then
      local pendingBallCount = v9.CollectPart:GetAttribute("PendingBallCount") or 0
      local pendingCashDisplay = v9.CollectPart:GetAttribute("PendingCashDisplay") or "$0"

      v64 = string.format(
        "\nBalls: %s | Pending Cash: %s", tostring(pendingBallCount),
        tostring(pendingCashDisplay)
      )
    end

    liveStatusAddParagraph:SetDesc("Status: " .. v9.Status .. v64)
    task.wait(0.4)
  end
end)

v63.Main:AddToggle("AutoCarrySell", {
  Title = "Auto Carry & Sell",
  Description = "หยิบกล่องลังจากสายพานแล้วนำไปขายที่ Sell NPC อัตโนมัติ",
  Default = false,
}):OnChanged(function(autoCarrySell)
  v7.AutoCarrySell = autoCarrySell
end)

v63.Main:AddToggle("AutoPolisher", {
  Title = "Auto Polish Crates",
  Description = "นำกล่องไปขัดเงาให้เสร็จแล้วเก็บไปขาย (แก้บัคขัดเงาเรียบร้อย)",
  Default = false,
}):OnChanged(function(autoPolisher)
  v7.AutoPolisher = autoPolisher
end)

v63.Main:AddDropdown("TeleportMode", {
  Title = "Movement Mode",
  Values = { "InstantTP", "Tween", "RemoteOnly" },
  Multi = false,
  Default = 1,
}):OnChanged(function(teleportMode)
  v7.TeleportMode = teleportMode
end)

v63.Main:AddSlider("TweenSpeed", {
  Title = "Tween Speed",
  Default = 65,
  Min = 30,
  Max = 150,
  Rounding = 0,
}):OnChanged(function(tweenSpeed)
  v7.TweenSpeed = tweenSpeed
end)

v63.Main:AddButton({
  Title = "Force Sell Now",
  Description = "วาร์ปไปขายทันที",
  Callback = function() f15() end,
})

v63.Conveyor:AddParagraph({
  Title = "Auto Roll & Auto Buy (Unified)",
  Content = "Roll สุ่มสายพานต่อเนื่องจนกว่าจะได้ Box Tier และ Mutation ถึงขั้นต่ำที่เลือก แล้วจะวาร์ปไปกด E ซื้อให้อัตโนมัติทันที",
})

v63.Conveyor:AddToggle("AutoRollConveyor", {
  Title = "Auto Roll & Auto Buy",
  Description = "เปิดระบบสุ่มสายพานและซื้ออัตโนมัติเมื่อถึงขั้นต่ำ",
  Default = false,
}):OnChanged(function(autoRollConveyor)
  v7.AutoRollConveyor = autoRollConveyor
end)

v63.Conveyor:AddDropdown("ConveyorMatchMode", {
  Title = "Match Mode (โหมดเงื่อนไขการซื้อ)",
  Description = "เลือกวิธีตัดสินใจซื้อเมื่อสุ่มได้",
  Values = { "Box AND Mutation", "Box OR Mutation", "Box Only", "Mutation Only" },
  Multi = false,
  Default = 1,
}):OnChanged(function(conveyorMatchMode)
  v7.ConveyorMatchMode = conveyorMatchMode
end)

v63.Conveyor:AddDropdown("MinTargetBox", {
  Title = "Minimum Box Tier (เลือกตู้ขั้นต่ำ)",
  Description = "ระดับตู้ขั้นต่ำ (0 = ซื้อทั้งหมด, 1 = TeamZ, ..., 9 = ZStrikers)",
  Values = values2,
  Multi = false,
  Default = 1,
}):OnChanged(function(p23)
  v7.MinTargetBox = p23
  v7.MinBoxRank = f1(p23, 0)
end)

v63.Conveyor:AddSlider("MinBoxRankSlider", {
  Title = "Min Box Rank Slider (0-17)",
  Description = "0=Any, 1=TeamZ, 5=Ubers, 9=ZStrikers, 10=BasMunchen, 13=BasMunchenElite, 17=PXGElite",
  Default = 0,
  Min = 0,
  Max = 17,
  Rounding = 0,
}):OnChanged(function(minBoxRank)
  v7.MinBoxRank = minBoxRank
end)

v63.Conveyor:AddDropdown("MinTargetMutation", {
  Title = "Minimum Mutation (เลือก Mutation ขั้นต่ำ)",
  Description = "ระดับ Mutation ขั้นต่ำ (0=Any, 1=Normal, 5=Overflow, 6=Electric, 9=Diamond, 11=FlowState)",
  Values = values,
  Multi = false,
  Default = 1,
}):OnChanged(function(p24)
  v7.MinTargetMutation = p24
  v7.MinMutationRank = f1(p24, 0)
end)

v63.Conveyor:AddSlider("MinMutationRankSlider", {
  Title = "Min Mutation Rank Slider (0-11)",
  Description = "0=Any, 1=Normal, 5=Overflow, 6=Electric, 8=Monster, 9=Diamond, 11=FlowState",
  Default = 0,
  Min = 0,
  Max = 11,
  Rounding = 0,
}):OnChanged(function(minMutationRank)
  v7.MinMutationRank = minMutationRank
end)

v63.Conveyor:AddToggle("AutoTeleportToBuy", {
  Title = "Warp to Conveyor to Buy (กด E ซื้อ)",
  Description = "วาร์ปไปหน้าสายพานเพื่อกด E ซื้อให้อัตโนมัติ (แก้ปัญหาไม่ซื้อ)",
  Default = true,
}):OnChanged(function(autoTeleportToBuy)
  v7.AutoTeleportToBuy = autoTeleportToBuy
end)

v63.Conveyor:AddSlider("RollDelay", {
  Title = "Roll Speed (Delay in Seconds)",
  Default = 0.12,
  Min = 0.05,
  Max = 1,
  Rounding = 2,
}):OnChanged(function(rollDelay)
  v7.RollDelay = rollDelay
end)

v63.Conveyor:AddButton({
  Title = "Roll Once",
  Description = "กด Roll เอง 1 ครั้ง",
  Callback = function() f7("RequestConveyorRoll") end,
})

v63.Conveyor:AddButton({
  Title = "Buy Current Box NOW (กด E ซื้อทันที)",
  Description = "วาร์ปไปที่สายพานแล้วกด E ซื้อตู้ที่อยู่บนสายพานตอนนี้ทันที",
  Callback = function()
    local v65, v66, v67 = f18()
    f20(v65, v66, v67)

    fluent:Notify({
      Title = "Manual Buy",
      Content = string.format("Attempted buy for %s (%s)", tostring(v65), tostring(v66)),
      Duration = 3,
    })
  end,
})

v63.Units:AddParagraph({
  Title = "Units & Rapid Level Up",
  Content = "อัพเลเวลตัวละครทุกตัวเท่าๆ กันอย่างรวดเร็ว (Cap สูงสุดที่ Level 50) พร้อมระบบติดตั้งตัวที่ดีที่สุดอัตโนมัติ",
})

v63.Units:AddToggle("AutoEquipBest", {
  Title = "Auto Equip Best Units",
  Description = "ติดตั้งตัวละครที่ดีที่สุดลงตู้อัตโนมัติตลอดเวลา",
  Default = false,
}):OnChanged(function(autoEquipBest)
  v7.AutoEquipBest = autoEquipBest
end)

v63.Units:AddToggle("AutoLevelUp", {
  Title = "Rapid Auto Level Up (Equal)",
  Description = "อัพเลเวลตัวละครทุกตัวพร้อมกันอย่างรวดเร็วตามเงินที่มี",
  Default = false,
}):OnChanged(function(autoLevelUp)
  v7.AutoLevelUp = autoLevelUp
end)

v63.Units:AddSlider("MaxUnitLevel", {
  Title = "Max Level Cap (Game Limit: 50)",
  Description = "เลเวลสูงสุดที่ต้องการอัพ",
  Default = 50,
  Min = 1,
  Max = 50,
  Rounding = 0,
}):OnChanged(function(maxUnitLevel)
  v7.MaxUnitLevel = maxUnitLevel
end)

v63.Units:AddButton({
  Title = "Equip Best Now",
  Description = "กดติดตั้งตัวละครที่ดีที่สุดทันที 1 ครั้ง",
  Callback = function()
    f7("EquipBestPlayerUnits")
    fluent:Notify({ Title = "Units", Content = "Equipped best units!", Duration = 2 })
  end,
})

v63.PlaceBox:AddParagraph({
  Title = "Smart Box Placement",
  Content = "เลือกกล่องที่ดีที่สุดในกระเป๋า (Tier + Mutation สูงสุด) แล้วนำไปวางแทนตัวที่ผลิตเงิน/วิน้อยที่สุดอัตโนมัติ",
})

v63.PlaceBox:AddToggle("AutoPlaceBox", {
  Title = "Smart Auto Place Box",
  Description = "แทนที่ตัวที่อ่อนที่สุดด้วยกล่องที่ดีที่สุดในกระเป๋า",
  Default = false,
}):OnChanged(function(autoPlaceBox)
  v7.AutoPlaceBox = autoPlaceBox
end)

v63.PlaceBox:AddSlider("PlaceBoxInterval", {
  Title = "Check Interval (Seconds)",
  Default = 2,
  Min = 1,
  Max = 8,
  Rounding = 1,
}):OnChanged(function(placeBoxInterval)
  v7.PlaceBoxInterval = placeBoxInterval
end)

v63.Market:AddParagraph({
  Title = "Market Auto Buy",
  Content = "สแกน Market อัตโนมัติ ซื้อไอเทมที่ได้ Box Tier และ Mutation ถึงขั้นต่ำด้วยเงินสด (Cash) ทันที",
})

v63.Market:AddToggle("AutoBuyMarket", {
  Title = "Auto Buy from Market",
  Description = "เปิดระบบซื้อของอัตโนมัติจากหน้าร้าน Market",
  Default = false,
}):OnChanged(function(autoBuyMarket)
  v7.AutoBuyMarket = autoBuyMarket
end)

v63.Market:AddDropdown("MarketMinBox", {
  Title = "Market Minimum Box Tier",
  Values = values2,
  Multi = false,
  Default = 1,
}):OnChanged(function(marketMinBox)
  v7.MarketMinBox = marketMinBox
end)

v63.Market:AddDropdown("MarketMinMutation", {
  Title = "Market Minimum Mutation",
  Values = values,
  Multi = false,
  Default = 1,
}):OnChanged(function(marketMinMutation)
  v7.MarketMinMutation = marketMinMutation
end)

v63.Upgrades:AddParagraph({
  Title = "Auto Upgrades",
  Content = "อัพเกรดทุกอย่างในบ้าน (Speed, Income, Multiplier ฯลฯ) สลับกันไปเรื่อยๆ เพื่อให้อัพทุกอย่างเท่าๆ กัน",
})

v63.Upgrades:AddToggle("AutoUpgrades", {
  Title = "Auto Upgrade All Equally",
  Description = "อัพทุกอย่างในบ้านให้เท่าๆ กันอัตโนมัติ",
  Default = false,
}):OnChanged(function(autoUpgrades)
  v7.AutoUpgrades = autoUpgrades
end)

v63.Ranking:AddParagraph({
  Title = "Grade Reroll (Ranking)",
  Content = "แสดงรายละเอียด [ชื่อ | เลเวล | Mutation | เกรด | เงินที่ได้/วิ] ของตัวในบ้านและกระเป๋า พร้อมระบบสุ่มหา Grade ที่ต้องการ",
})

local v68 = {}
local v69 = { "(Click Scan Units First)" }

local addDropdown = v63.Ranking:AddDropdown("SelectedUnit", {
  Title = "Select Unit to Reroll",
  Values = v69,
  Multi = false,
  Default = 1,
})

addDropdown:OnChanged(function(p25)
  local v70 = v68[p25]

  if v70 then
    v7.SelectedUnitIdentifier = v70.name
    v7.SelectedUnitSource = v70.source
    v7.SelectedDropperRef = v70.dropper
  end
end)

v63.Ranking:AddButton({
  Title = "Scan Units (Show Details & Cash/s)",
  Description = "โหลดรายชื่อตัวละครพร้อมบอกข้อมูลอย่างละเอียด",
  Callback = function()
    v68 = {}
    v69 = {}
    local v71 = f24()

    for index18, value22 in ipairs(v71) do
      table.insert(v69, value22.display)
      v68[value22.display] = value22
    end

    local v72 = f25()

    for index19, value23 in ipairs(v72) do
      table.insert(v69, value23.display)
      v68[value23.display] = value23
    end

    if #v69 == 0 then
      table.insert(v69, "(No units found)")
    end

    addDropdown:SetValues(v69)

    fluent:Notify({
      Title = "Scan Complete",
      Content = string.format("Found %d units (%d House, %d Bag)", #v71 + #v72, #v71, #v72),
      Duration = 3,
    })
  end,
})

v63.Ranking:AddDropdown("TargetGrade", {
  Title = "Target Minimum Grade",
  Description = "จะหยุดสุ่มเมื่อได้ Grade นี้ขึ้นไป (D→C→B→A→S→SS→SSS→EX→X→UR)",
  Values = { "D", "C", "B", "A", "S", "SS", "SSS", "EX", "X", "UR" },
  Multi = false,
  Default = 5,
}):OnChanged(function(rerollTargetGrade)
  v7.RerollTargetGrade = rerollTargetGrade
end)

v63.Ranking:AddToggle("AutoRerollGrade", {
  Title = "Start Auto Reroll Grade",
  Description = "สุ่มหา Grade ที่เลือกอย่างรวดเร็ว",
  Default = false,
}):OnChanged(function(p26)
  v7.AutoRerollGrade = p26
  v9.RerollingActive = p26

  if p26 then
    fluent:Notify({
      Title = "Reroll Started",
      Content = "Rerolling to Grade " .. v7.RerollTargetGrade,
      Duration = 2.5,
    })
  end
end)

v63.Map:AddParagraph({
  Title = "Map Collectables",
  Content = "วาร์ปเก็บไอเทมที่สปอว์นเกิดตามแมพ เช่น Cash Potions, Grade Tokens และ Variant Token Balls อัตโนมัติ",
})

v63.Map:AddToggle("AutoCollectMap", {
  Title = "Auto Collect Spawned Items",
  Description = "เก็บไอเทมและ Token ที่เกิดตามแมพอัตโนมัติ",
  Default = v7.AutoCollectMap,
}):OnChanged(function(autoCollectMap)
  v7.AutoCollectMap = autoCollectMap
end)

v63.Map:AddSlider("CollectMapInterval", {
  Title = "Check Interval (Seconds)",
  Default = v7.CollectMapInterval,
  Min = 1,
  Max = 10,
  Rounding = 1,
}):OnChanged(function(collectMapInterval)
  v7.CollectMapInterval = collectMapInterval
end)

v63.Map:AddButton({
  Title = "Collect All Map Items NOW",
  Description = "วาร์ปเก็บของทั้งหมดบนแมพทันที 1 รอบ",
  Callback = function()
    local v73 = f26()

    fluent:Notify({
      Title = "Map Collect",
      Content = string.format("Collected %d map item(s)!", v73),
      Duration = 3,
    })
  end,
})

saveManager:SetLibrary(fluent)
interfaceManager:SetLibrary(fluent)

saveManager:IgnoreThemeSettings()
saveManager:SetIgnoreIndexes({})

interfaceManager:SetFolder("BlueLockFarm")
saveManager:SetFolder("BlueLockFarm")
interfaceManager:BuildInterfaceSection(v63.Settings)
saveManager:BuildConfigSection(v63.Settings)
voidxhubWindow:SelectTab(1)
fluent:Notify({ Title = "Blue Lock Farm", Content = "All systems loaded!", Duration = 5 })
f14()
print("[RELWX] Blue Lock Farm v3.2 loaded! Boxes=17 Mutations=11 Grades=D~UR")
