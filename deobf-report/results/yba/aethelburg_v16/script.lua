--[[
    YBA: AETHELBURG V16 - THE APEX ARCHITECTURE
    Version: 16.0.0
    Type: Full Framework (Uncompressed)
    
    FEATURES:
    - Dynamic Item and Player ESP (with Caching System)
    - Smooth Glide and Trajectory Calculation
    - Stand-Sync Combat Engine (CFrame based on enemy movement)
    - Comprehensive UI Library (Dropdown, Slider, Toggle, Tween)
    - Anti-Cheat Bypass Systems (WalkSpeed, Anti-TS)
]] local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Mouse = LocalPlayer:GetMouse()
local Camera = Workspace.CurrentCamera -- [ 1. CENTRAL CONFIGURATION ]
local AethelConfig = {UI = {MainColor = Color3.fromRGB(0, 170, 255), BgColor = Color3.fromRGB(15, 15, 18), ToggleKey = Enum.KeyCode.Period}, Farm = {Active = false, TargetNPC = "All", AttackHeight = 3.5, AttackDistance = 0.6, SkillSpam = false, AutoStand = true, AutoHeal = true, IsHealing = false, CurrentEnemy = nil}, Sensory = {ItemESP = false, PlayerESP = false, DrawDistance = true, AutoCollect = false, CollectRange = 15, MaxDistance = 3000}, Movement = {SpeedHack = false, SpeedMultiplier = 1.65, AntiTimeStop = true, AntiAFK = true, GlideSpeed = 75, IsGliding = false}} -- [ 2. ITEM DATABASE ]
local ItemDatabase = { ["Lucky Arrow"] = {Color = Color3.fromRGB(255, 0, 255), Rarity = "Legendary"}, ["Pelvis of The Saint's Corpse"] = {Color = Color3.fromRGB(255, 0, 255), Rarity = "Legendary"}, ["Heart of The Saint's Corpse"] = {Color = Color3.fromRGB(255, 0, 255), Rarity = "Legendary"}, ["Left Arm of The Saint's Corpse"] = {Color = Color3.fromRGB(0, 255, 255), Rarity = "Rare"}, ["Rib Cage of The Saint's Corpse"] = {Color = Color3.fromRGB(0, 255, 255), Rarity = "Rare"}, ["Pure Rokakaka"] = {Color = Color3.fromRGB(255, 150, 0), Rarity = "Epic"}, ["Requiem Arrow"] = {Color = Color3.fromRGB(255, 150, 0), Rarity = "Epic"}, ["Joe's Diary"] = {Color = Color3.fromRGB(255, 150, 0), Rarity = "Epic"}, ["Dio's Diary"] = {Color = Color3.fromRGB(255, 150, 0), Rarity = "Epic"}, ["Mysterious Arrow"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Rokakaka"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Diamond"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Quinton's Glove"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Ancient Scroll"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Steel Ball"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Zeppeli's Headband"] = {Color = Color3.fromRGB(255, 255, 0), Rarity = "Common"}, ["Candy"] = {Color = Color3.fromRGB(255, 100, 100), Rarity = "Event"}}
local ActiveFilters = {}
for name, _ in pairs(ItemDatabase) do
  ActiveFilters[name] = true
end
-- [ 3. SECURE UI CLEANUP ]
local function SecureCleanUI()
  if PlayerGui:FindFirstChild("AethelApexUI") then
    PlayerGui.AethelApexUI:Destroy()
  end
  local targetCore = pcall(function()
    return CoreGui.Name
  end
  ) and CoreGui or PlayerGui
  if targetCore:FindFirstChild("AethelApexESP") then
    targetCore.AethelApexESP:Destroy()
  end
end
SecureCleanUI() -- [ 4. UI FRAMEWORK: WINDOW AND NAVIGATION ]
local AethelGui = Instance.new("ScreenGui")
AethelGui.Name = "AethelApexUI"
AethelGui.Parent = PlayerGui
AethelGui.ResetOnSpawn = false
AethelGui.IgnoreGuiInset = true
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Background"
MainFrame.Parent = AethelGui
MainFrame.Size = UDim2.new(0, 700, 0, 500)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
MainFrame.BackgroundColor3 = AethelConfig.UI.BgColor
MainFrame.BorderSizePixel = 0
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke")
MainStroke.Parent = MainFrame
MainStroke.Thickness = 2
MainStroke.Color = AethelConfig.UI.MainColor
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border -- Drag Logic
local Dragging, DragInput, DragStart, StartPosition
MainFrame.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
    Dragging = true
    DragStart = input.Position
    StartPosition = MainFrame.Position
  end
end
)
UserInputService.InputChanged:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseMovement then
    DragInput = input
  end
end
)
RunService.RenderStepped:Connect(function()
  if Dragging and DragInput then
    local delta = DragInput.Position - DragStart
    MainFrame.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
  end
end
)
UserInputService.InputEnded:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 then
    Dragging = false
  end
end
) -- Toggle Key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
  if not gameProcessed and input.KeyCode == AethelConfig.UI.ToggleKey then
    MainFrame.Visible = not MainFrame.Visible
  end
end
) -- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.Size = UDim2.new(0, 200, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Sidebar.BorderSizePixel = 0
local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Name = "Logo"
LogoLabel.Parent = Sidebar
LogoLabel.Size = UDim2.new(1, 0, 0, 80)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "AETHELBURG\nAPEX V16"
LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoLabel.Font = Enum.Font.GothamBlack
LogoLabel.TextSize = 20
local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.Padding = UDim.new(0, 5)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder -- Page Container
local PageContainer = Instance.new("Frame")
PageContainer.Name = "PageContainer"
PageContainer.Parent = MainFrame
PageContainer.Size = UDim2.new(1, -200, 1, 0)
PageContainer.Position = UDim2.new(0, 200, 0, 0)
PageContainer.BackgroundTransparency = 1 -- [ 5. UI COMPONENT FACTORY ]
local ActivePage = nil
local ActiveTabBtn = nil
local function CreateTab(tabName)
  local TabButton = Instance.new("TextButton")
  TabButton.Parent = Sidebar
  TabButton.Size = UDim2.new(0.9, 0, 0, 45)
  TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
  TabButton.Text = tabName
  TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
  TabButton.Font = Enum.Font.GothamBold
  TabButton.TextSize = 14
  local TabCorner = Instance.new("UICorner")
  TabCorner.CornerRadius = UDim.new(0, 6)
  TabCorner.Parent = TabButton
  local PageFrame = Instance.new("ScrollingFrame")
  PageFrame.Name = tabName .. "Page"
  PageFrame.Parent = PageContainer
  PageFrame.Size = UDim2.new(1, -30, 1, -30)
  PageFrame.Position = UDim2.new(0, 15, 0, 15)
  PageFrame.BackgroundTransparency = 1
  PageFrame.Visible = false
  PageFrame.ScrollBarThickness = 4
  PageFrame.ScrollBarImageColor3 = AethelConfig.UI.MainColor
  local PageLayout = Instance.new("UIListLayout")
  PageLayout.Parent = PageFrame
  PageLayout.Padding = UDim.new(0, 10)
  PageLayout.SortOrder = Enum.SortOrder.LayoutOrder PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PageFrame.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
  end
  )
  TabButton.MouseButton1Click:Connect(function()
    if ActivePage then
      ActivePage.Visible = false TweenService:Create(ActiveTabBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(30, 30, 35), TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
    end
    PageFrame.Visible = true
    ActivePage = PageFrame
    ActiveTabBtn = TabButton TweenService:Create(TabButton, TweenInfo.new(0.3), {BackgroundColor3 = AethelConfig.UI.MainColor, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
  end
  )
  return PageFrame
end
local function CreateToggle(parent, text, defaultState, callback)
  local ToggleFrame = Instance.new("Frame")
  ToggleFrame.Parent = parent
  ToggleFrame.Size = UDim2.new(1, 0, 0, 50)
  ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
  local ToggleCorner = Instance.new("UICorner")
  ToggleCorner.CornerRadius = UDim.new(0, 6)
  ToggleCorner.Parent = ToggleFrame
  local ToggleLabel = Instance.new("TextLabel")
  ToggleLabel.Parent = ToggleFrame
  ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
  ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
  ToggleLabel.BackgroundTransparency = 1
  ToggleLabel.Text = text
  ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  ToggleLabel.Font = Enum.Font.GothamSemibold
  ToggleLabel.TextSize = 14
  ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
  local ToggleButton = Instance.new("TextButton")
  ToggleButton.Parent = ToggleFrame
  ToggleButton.Size = UDim2.new(0, 50, 0, 26)
  ToggleButton.Position = UDim2.new(1, -65, 0.5, -13)
  ToggleButton.BackgroundColor3 = defaultState and AethelConfig.UI.MainColor or Color3.fromRGB(45, 45, 50)
  ToggleButton.Text = ""
  local ButtonCorner = Instance.new("UICorner")
  ButtonCorner.CornerRadius = UDim.new(1, 0)
  ButtonCorner.Parent = ToggleButton
  local ToggleCircle = Instance.new("Frame")
  ToggleCircle.Parent = ToggleButton
  ToggleCircle.Size = UDim2.new(0, 20, 0, 20)
  ToggleCircle.Position = defaultState and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
  ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
  local CircleCorner = Instance.new("UICorner")
  CircleCorner.CornerRadius = UDim.new(1, 0)
  CircleCorner.Parent = ToggleCircle
  local currentState = defaultState
  ToggleButton.MouseButton1Click:Connect(function()
    currentState = not currentState
    callback(currentState)
    local targetColor = currentState and AethelConfig.UI.MainColor or Color3.fromRGB(45, 45, 50)
    local targetPosition = currentState and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10) TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = targetColor}):Play() TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = targetPosition}):Play()
  end
  )
end
local function CreateButton(parent, text, callback)
  local Button = Instance.new("TextButton")
  Button.Parent = parent
  Button.Size = UDim2.new(1, 0, 0, 45)
  Button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
  Button.Text = text
  Button.TextColor3 = Color3.fromRGB(255, 255, 255)
  Button.Font = Enum.Font.GothamBold
  Button.TextSize = 14
  local ButtonCorner = Instance.new("UICorner")
  ButtonCorner.CornerRadius = UDim.new(0, 6)
  ButtonCorner.Parent = Button
  Button.MouseButton1Click:Connect(function()
    -- Click Animation
    TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = AethelConfig.UI.MainColor}):Play()
    task.wait(0.1) TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
    callback()
  end
  )
end
local function CreateSlider(parent, text, min, max, default, callback)
  local SliderFrame = Instance.new("Frame")
  SliderFrame.Parent = parent
  SliderFrame.Size = UDim2.new(1, 0, 0, 70)
  SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
  local SliderCorner = Instance.new("UICorner")
  SliderCorner.CornerRadius = UDim.new(0, 6)
  SliderCorner.Parent = SliderFrame
  local SliderLabel = Instance.new("TextLabel")
  SliderLabel.Parent = SliderFrame
  SliderLabel.Size = UDim2.new(1, -30, 0, 30)
  SliderLabel.Position = UDim2.new(0, 15, 0, 5)
  SliderLabel.BackgroundTransparency = 1
  SliderLabel.Text = text .. ": " .. tostring(default)
  SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  SliderLabel.Font = Enum.Font.GothamSemibold
  SliderLabel.TextSize = 14
  SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
  local Track = Instance.new("TextButton")
  Track.Parent = SliderFrame
  Track.Size = UDim2.new(1, -30, 0, 8)
  Track.Position = UDim2.new(0, 15, 0, 45)
  Track.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
  Track.Text = ""
  Track.AutoButtonColor = false
  local TrackCorner = Instance.new("UICorner")
  TrackCorner.CornerRadius = UDim.new(1, 0)
  TrackCorner.Parent = Track
  local Fill = Instance.new("Frame")
  Fill.Parent = Track
  Fill.Size = UDim2.new( (default - min) / (max - min), 0, 1, 0)
  Fill.BackgroundColor3 = AethelConfig.UI.MainColor
  local FillCorner = Instance.new("UICorner")
  FillCorner.CornerRadius = UDim.new(1, 0)
  FillCorner.Parent = Fill
  local isDragging = false
  local function UpdateSlider()
    local mousePos = UserInputService:GetMouseLocation().X
    local trackPos = Track.AbsolutePosition.X
    local trackSize = Track.AbsoluteSize.X
    local percentage = math.clamp( (mousePos - trackPos) / trackSize, 0, 1)
    local value = math.floor(min + (max - min) * percentage)
    Fill.Size = UDim2.new(percentage, 0, 1, 0)
    SliderLabel.Text = text .. ": " .. tostring(value)
    callback(value)
  end
  Track.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
      isDragging = true
      UpdateSlider()
    end
  end
  )
  UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
      isDragging = false
    end
  end
  )
  UserInputService.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
      UpdateSlider()
    end
  end
  )
end
-- [ 6. ESP AND CACHE ENGINE (SENSORY ENGINE) ]
local ESPCache = {}
local ActiveESP = {}
local targetCore = pcall(function()
  return CoreGui.Name
end
) and CoreGui or PlayerGui
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "AethelApexESP"
ESPFolder.Parent = targetCore
local function BuildItemCache(object)
  if object:IsA("ProximityPrompt") or object:IsA("ClickDetector") then
    local parentNode = object.Parent
    local modelNode = parentNode:FindFirstAncestorOfClass("Model") or parentNode
    if modelNode and not modelNode:FindFirstChild("Humanoid") then
      local physicalPart = parentNode:IsA("BasePart") and parentNode or modelNode:FindFirstChildWhichIsA("BasePart", true)
      if physicalPart then
        local itemName = ""
        if object:IsA("ProximityPrompt") and object.ObjectText ~= "" then
          itemName = object.ObjectText
        else
          itemName = modelNode.Name
        end
        if ItemDatabase[itemName] then
          ESPCache[physicalPart] = {Prompt = object, Name = itemName, Data = ItemDatabase[itemName]}
        end
      end
    end
  end
end
-- Cache existing items
for _, descendant in ipairs(Workspace:GetDescendants()) do
  BuildItemCache(descendant)
end
-- Listen for new items (Zero Lag)
Workspace.DescendantAdded:Connect(function(descendant)
  task.delay(0.2, function()
    BuildItemCache(descendant)
  end
  )
end
) -- ESP Update Loop
task.spawn(function()
  while task.wait(0.5) do
    if not AethelConfig.Sensory.ItemESP then
      for _, espData in pairs(ActiveESP) do
        if espData.Gui then
          espData.Gui:Destroy()
        end
      end
      table.clear(ActiveESP)
      continue
    end
    local validParts = {}
    for part, info in pairs(ESPCache) do
      if part and part.Parent and part:IsDescendantOf(Workspace) and ActiveFilters[info.Name] then
        validParts[part] = true
        local playerRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local distance = playerRoot and math.floor( (playerRoot.Position - part.Position).Magnitude) or 0
        if distance <= AethelConfig.Sensory.MaxDistance then
          if not ActiveESP[part] then
            local BillBoard = Instance.new("BillboardGui")
            BillBoard.Parent = ESPFolder
            BillBoard.AlwaysOnTop = true
            BillBoard.Size = UDim2.new(0, 150, 0, 40)
            BillBoard.Adornee = part
            local TextLbl = Instance.new("TextLabel")
            TextLbl.Parent = BillBoard
            TextLbl.Size = UDim2.new(1, 0, 1, 0)
            TextLbl.BackgroundTransparency = 1
            TextLbl.Font = Enum.Font.GothamBlack
            TextLbl.TextScaled = true
            TextLbl.TextColor3 = info.Data.Color
            local TxtStroke = Instance.new("UIStroke")
            TxtStroke.Parent = TextLbl
            TxtStroke.Thickness = 1.5
            TxtStroke.Color = Color3.new(0, 0, 0)
            ActiveESP[part] = {Gui = BillBoard, Label = TextLbl, Name = info.Name}
          end
          if AethelConfig.Sensory.DrawDistance then
            ActiveESP[part].Label.Text = string.format("%s\n[%dm]", info.Name, distance)
          else
            ActiveESP[part].Label.Text = info.Name
          end
          -- Auto Collect Mechanic
          if AethelConfig.Sensory.AutoCollect and distance <= AethelConfig.Sensory.CollectRange then
            if info.Prompt and info.Prompt:IsA("ProximityPrompt") then
              fireproximityprompt(info.Prompt)
            end
          end
        end
      end
    end
    -- Clean up items not in cache
    for part, espData in pairs(ActiveESP) do
      if not validParts[part] then
        if espData.Gui then
          espData.Gui:Destroy()
        end
        ActiveESP[part] = nil
      end
    end
  end
end
) -- [ 7. COMBAT AI AND STAND-SYNC 5.0 (WARFARE ENGINE) ]
local FarmPlatform = Instance.new("Part")
FarmPlatform.Name = "AethelCombatRaft"
FarmPlatform.Parent = Workspace
FarmPlatform.Size = Vector3.new(15, 1, 15)
FarmPlatform.Transparency = 1
FarmPlatform.Anchored = true
FarmPlatform.CanCollide = true -- Physics Lock (Anti-Jitter)
RunService.Heartbeat:Connect(function()
  if not AethelConfig.Farm.Active then
    return
  end
  local character = LocalPlayer.Character
  if not character then
    return
  end
  local hrp = character:FindFirstChild("HumanoidRootPart")
  if not hrp then
    return
  end
  local currentEnemy = AethelConfig.Farm.CurrentEnemy
  if not currentEnemy or not currentEnemy:FindFirstChild("HumanoidRootPart") then
    return
  end
  local targetHrp = currentEnemy.HumanoidRootPart
  local targetCFrame
  if AethelConfig.Farm.IsHealing then
    -- Safe Healing Position
    targetCFrame = targetHrp.CFrame * CFrame.new(0, 18, 0)
  else
    -- Stand-Sync Calculation (Sticks to enemy's back)
    targetCFrame = targetHrp.CFrame * CFrame.new(0, AethelConfig.Farm.AttackHeight, AethelConfig.Farm.AttackDistance)
  end
  FarmPlatform.CFrame = targetCFrame * CFrame.new(0, -3.5, 0)
  hrp.CFrame = CFrame.lookAt(targetCFrame.Position, targetHrp.Position)
  hrp.AssemblyLinearVelocity = Vector3.zero
end
) -- Combat Decision Loop
task.spawn(function()
  while task.wait(0.1) do
    if AethelConfig.Farm.Active then
      pcall(function()
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChild("Humanoid") -- Health Management
        if AethelConfig.Farm.AutoHeal and humanoid then
          local healthRatio = humanoid.Health / humanoid.MaxHealth
          if healthRatio < 0.3 and not AethelConfig.Farm.IsHealing then
            AethelConfig.Farm.IsHealing = true VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.P, false, game)
          elseif healthRatio >= 0.95 and AethelConfig.Farm.IsHealing then
            AethelConfig.Farm.IsHealing = false VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.P, false, game)
          end
        end
        -- Target Search
        if not AethelConfig.Farm.CurrentEnemy or AethelConfig.Farm.CurrentEnemy.Humanoid.Health <= 0 then
          AethelConfig.Farm.CurrentEnemy = nil
          local nearestDistance = math.huge
          local livingFolder = Workspace:FindFirstChild("Living") or Workspace
          for _, entity in ipairs(livingFolder:GetChildren()) do
            if entity:FindFirstChild("Humanoid") and entity.Humanoid.Health > 0 and entity ~= character and not Players:GetPlayerFromCharacter(entity) then
              if AethelConfig.Farm.TargetNPC == "All" or entity.Name == AethelConfig.Farm.TargetNPC then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                local eHrp = entity:FindFirstChild("HumanoidRootPart")
                if hrp and eHrp then
                  local dist = (hrp.Position - eHrp.Position).Magnitude
                  if dist < nearestDistance then
                    nearestDistance = dist
                    AethelConfig.Farm.CurrentEnemy = entity
                  end
                end
              end
            end
          end
        end
        -- Attack Commands
        if AethelConfig.Farm.CurrentEnemy and not AethelConfig.Farm.IsHealing then
          -- Stand Control
          if AethelConfig.Farm.AutoStand and not character:FindFirstChild("Stand") then
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
            task.wait(0.2)
          end
          -- Basic Attack
          VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0) -- Skill Spam
          if AethelConfig.Farm.SkillSpam then
            local skills = {"E", "R", "T", "Y", "Z", "X"}
            for _, key in ipairs(skills) do
              VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
              task.wait(0.05) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
            end
          end
          task.wait(0.05) VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
      end
      )
    end
  end
end
) -- [ 8. BYPASS AND MOVEMENT SYSTEMS ]
RunService.Stepped:Connect(function()
  pcall(function()
    local char = LocalPlayer.Character
    if not char then
      return
    end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid") -- Speed Bypass (Safe Vector Manipulation)
    if AethelConfig.Movement.SpeedHack and hrp and hum and hum.MoveDirection.Magnitude > 0 then
      hrp.CFrame = hrp.CFrame + (hum.MoveDirection * AethelConfig.Movement.SpeedMultiplier)
    end
    -- Time Stop Immunity
    if AethelConfig.Movement.AntiTimeStop then
      for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored and part.Name ~= "HumanoidRootPart" and part.Name ~= "AethelCombatRaft" then
          part.Anchored = false
        end
      end
    end
  end
  )
end
) -- Anti-AFK
LocalPlayer.Idled:Connect(function()
  if AethelConfig.Movement.AntiAFK then
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.1) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
  end
end
) -- Smooth Glide System (Item Teleport)
local function GlideToNearestItem()
  if AethelConfig.Movement.IsGliding then
    return
  end
  local targetPart = nil
  local targetPrompt = nil
  local minDistance = math.huge
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then
    return
  end
  for part, info in pairs(ESPCache) do
    if part and part.Parent and ActiveFilters[info.Name] then
      local dist = (hrp.Position - part.Position).Magnitude
      if dist < minDistance and dist > 6 then
        minDistance = dist
        targetPart = part
        targetPrompt = info.Prompt
      end
    end
  end
  if targetPart then
    AethelConfig.Movement.IsGliding = true
    local glideRaft = Instance.new("Part")
    glideRaft.Parent = Workspace
    glideRaft.Size = Vector3.new(6, 1, 6)
    glideRaft.Anchored = true
    glideRaft.Transparency = 1
    glideRaft.CanCollide = true
    local connection = RunService.Stepped:Connect(function()
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(glideRaft.Position + Vector3.new(0, 3.5, 0), targetPart.Position)
        LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero
      end
    end
    )
    local travelTime = minDistance / AethelConfig.Movement.GlideSpeed
    local tween = TweenService:Create(glideRaft, TweenInfo.new(travelTime, Enum.EasingStyle.Linear), {CFrame = targetPart.CFrame * CFrame.new(0, -3, 0)}) tween:Play()
    task.wait(travelTime) connection:Disconnect() glideRaft:Destroy()
    if targetPrompt and fireproximityprompt then
      task.wait(0.2)
      fireproximityprompt(targetPrompt)
    end
    AethelConfig.Movement.IsGliding = false
  end
end
-- [ 9. POPULATING THE INTERFACE AND CONNECTIONS ]
local TabFarm = CreateTab("Combat & Farm")
local TabESP = CreateTab("Sensors")
local TabItems = CreateTab("Filtering")
local TabMisc = CreateTab("Tools") -- Combat Tab
local TargetLabel = Instance.new("TextLabel")
TargetLabel.Parent = TabFarm
TargetLabel.Size = UDim2.new(1, 0, 0, 30)
TargetLabel.BackgroundTransparency = 1
TargetLabel.Text = "TARGET: All"
TargetLabel.TextColor3 = AethelConfig.UI.MainColor
TargetLabel.Font = Enum.Font.GothamBlack
TargetLabel.TextSize = 14
CreateToggle(TabFarm, "Auto Combat Engine", false, function(state)
  AethelConfig.Farm.Active = state
end
)
CreateToggle(TabFarm, "Skill Spam (All Keys)", false, function(state)
  AethelConfig.Farm.SkillSpam = state
end
)
CreateToggle(TabFarm, "Smart Pose-Heal", true, function(state)
  AethelConfig.Farm.AutoHeal = state
end
)
CreateButton(TabFarm, "UPDATE ENEMY LIST", function()
  -- Clear existing dynamic buttons
  for _, child in ipairs(TabFarm:GetChildren()) do
    if child:IsA("TextButton") and child.Text ~= "UPDATE ENEMY LIST" then
      child:Destroy()
    end
  end
  local uniqueMobs = {"All"}
  local livingFolder = Workspace:FindFirstChild("Living") or Workspace
  for _, entity in ipairs(livingFolder:GetChildren()) do
    if entity:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(entity) then
      if not table.find(uniqueMobs, entity.Name) then
        table.insert(uniqueMobs, entity.Name)
      end
    end
  end
  for _, mobName in ipairs(uniqueMobs) do
    CreateButton(TabFarm, "Lock: " .. mobName, function()
      AethelConfig.Farm.TargetNPC = mobName
      TargetLabel.Text = "TARGET: " .. mobName
      AethelConfig.Farm.CurrentEnemy = nil
    end
    )
  end
end
) -- Sensors Tab
CreateToggle(TabESP, "Item Billboard ESP", false, function(state)
  AethelConfig.Sensory.ItemESP = state
end
)
CreateToggle(TabESP, "Auto Collect Nearby Items", false, function(state)
  AethelConfig.Sensory.AutoCollect = state
end
)
CreateButton(TabESP, "TELEPORT TO NEAREST ITEM (GLIDE)", function()
  GlideToNearestItem()
end
) -- Filters Tab
for itemName, _ in pairs(ItemDatabase) do
  CreateToggle(TabItems, itemName, true, function(state)
    ActiveFilters[itemName] = state
  end
  )
end
-- Tools Tab
CreateToggle(TabMisc, "WalkSpeed Bypass", false, function(state)
  AethelConfig.Movement.SpeedHack = state
end
)
CreateSlider(TabMisc, "Speed Multiplier", 1, 10, 2, function(value)
  AethelConfig.Movement.SpeedMultiplier = value
end
)
CreateSlider(TabMisc, "Glide Speed", 50, 200, 75, function(value)
  AethelConfig.Movement.GlideSpeed = value
end
)
CreateToggle(TabMisc, "Time Stop Immunity", true, function(state)
  AethelConfig.Movement.AntiTimeStop = state
end
)
CreateButton(TabMisc, "SHUTDOWN SYSTEM COMPLETELY", function()
  AethelConfig.Farm.Active = false
  AethelConfig.Sensory.ItemESP = false
  SecureCleanUI()
  if FarmPlatform then
    FarmPlatform:Destroy()
  end
  print("Aethelburg Disabled.")
end
) -- [ 10. INITIALIZATION ]
local FirstTabBtn = Sidebar:FindFirstChildWhichIsA("TextButton")
if FirstTabBtn then
  FirstTabBtn.BackgroundColor3 = AethelConfig.UI.MainColor
  FirstTabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
  ActiveTabBtn = FirstTabBtn
end
local FirstPage = PageContainer:FindFirstChildWhichIsA("ScrollingFrame")
if FirstPage then
  FirstPage.Visible = true
  ActivePage = FirstPage
end
print("Aethelburg Apex Architecture Loaded. Use Period (.) key to toggle.")
