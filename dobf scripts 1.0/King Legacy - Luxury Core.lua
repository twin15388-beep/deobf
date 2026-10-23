local players = game:GetService("Players")
local virtualInputManager = game:GetService("VirtualInputManager")
local userInputService = game:GetService("UserInputService")
local teleportService = game:GetService("TeleportService")
local httpService = game:GetService("HttpService")
local runService = game:GetService("RunService")
local coreGui = game:GetService("CoreGui")
local currentCamera = workspace.CurrentCamera
local localPlayer = players.LocalPlayer
local userTIER = getgenv().USER_TIER or "VIP"
local v1 = "ZH"

local v2 = {
  ZH = {
    titleVIP = "⚜ 👑 KING LEGACY | 頂級奢華 VIP 核心 👑 ⚜",
    titleFree = "✦ ⚡ KING LEGACY | 輕量奢華 FREE 版 ⚡ ✦",
    authorText = "✨ 作者：carl | 點我複製 DC 群組 🔗",
    authorCopied = "📋 已成功複製 Discord 邀請連結至剪貼簿！",
    statusOff = "❖ 狀態：系統安全待命中 ✦",
    statusOn = "⚡ 狀態：極速自動掛機掠奪中... ⚜",
    tabMain = "❖ 核心控制面板",
    tabSkill = "⚡ 戰鬥技能配置",
    btnAutoStart = "▶ 啟動自動刷賞金系統 🚀",
    btnAutoStop = "⏸ 暫停自動刷賞金系統 🛑",
    btnAimOff = "🌐 360° 全方位自瞄追蹤 ➔ [ 關閉 ✕ ]",
    btnAimOn = "🌐 360° 全方位自瞄追蹤 ➔ [ 開啟 ⚡ ]",
    btnStickOff = "🔒 極限目標吸附跟隨 ➔ [ 關閉 ✕ ]",
    btnStickOn = "🔒 極限目標吸附跟隨 ➔ [ 開啟 ⚜ ]",
    btnEspOff = "👁️ 頂級精準玩家透視 (ESP) ➔ [ 關閉 ✕ ]",
    btnEspOn = "👁️ 頂級精準玩家透視 (ESP) ➔ [ 開啟 ✦ ]",
    targetPlaceholder = "🔍 請輸入鎖定玩家名稱 (留空自動尋敵)...",
    btnSwitchTarget = "👤 輪替切換下個目標 ⟳",
    btnHop = "🌐 智慧伺服器跨頻切換 🔀",
    slot1 = "⭐ [ 1 ] 武器欄位",
    slot2 = "⭐ [ 2 ] 武器欄位",
    slot3 = "⭐ [ 3 ] 武器欄位",
    skillBtn = "⚜ 技能 ➔ ",
  },
  EN = {
    titleVIP = "⚜ 👑 KING LEGACY | ULTIMATE VIP CORE 👑 ⚜",
    titleFree = "✦ ⚡ KING LEGACY | LUXURY FREE ⚡ ✦",
    authorText = "✨ Author: carl | Click to Copy DC 🔗",
    authorCopied = "📋 Discord invite link copied to clipboard!",
    statusOff = "❖ Status: Standby & Secure ✦",
    statusOn = "⚡ Status: Auto Bounty Executing... ⚜",
    tabMain = "❖ Main Control",
    tabSkill = "⚡ Skill Config",
    btnAutoStart = "▶ Start Auto Bounty 🚀",
    btnAutoStop = "⏸ Stop Auto Bounty 🛑",
    btnAimOff = "🌐 360° Skill Aimlock ➔ [ OFF ✕ ]",
    btnAimOn = "🌐 360° Skill Aimlock ➔ [ ON ⚡ ]",
    btnStickOff = "🔒 Target Lock Magnet ➔ [ OFF ✕ ]",
    btnStickOn = "🔒 Target Lock Magnet ➔ [ ON ⚜ ]",
    btnEspOff = "👁️ Pro Player ESP ➔ [ OFF ✕ ]",
    btnEspOn = "👁️ Pro Player ESP ➔ [ ON ✦ ]",
    targetPlaceholder = "🔍 Enter Player Name (Blank = Nearest)...",
    btnSwitchTarget = "👤 Switch Target ⟳",
    btnHop = "🌐 Smart Server Hop 🔀",
    slot1 = "⭐ [ 1 ] Slot",
    slot2 = "⭐ [ 2 ] Slot",
    slot3 = "⭐ [ 3 ] Slot",
    skillBtn = "⚜ Skill ➔ ",
  },
}

local function f1(parent, p1)
  local uiCorner

  do
    uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, p1 or 12)
  end

  do
    uiCorner.Parent = parent
  end
end

local function f2(p2, p3)
  do
    p2.Activated:Connect(p3)
    p2.MouseEnter:Connect(function() p2.BackgroundTransparency = 0.1 end)
  end

  do
    p2.MouseLeave:Connect(function() p2.BackgroundTransparency = 0 end)
  end
end

local v5 = false
local v6 = true
local v7 = false
local v8 = false
local v9 = nil
local v10 = {}

local v11 = {
  [Enum.KeyCode.Q] = true,
  [Enum.KeyCode.Z] = true,
  [Enum.KeyCode.X] = false,
  [Enum.KeyCode.C] = false,
  [Enum.KeyCode.V] = false,
  [Enum.KeyCode.E] = false,
  [Enum.KeyCode.T] = true,
  [Enum.KeyCode.Y] = true,
}

local v12 = {
  [Enum.KeyCode.One] = true,
  [Enum.KeyCode.Two] = true,
  [Enum.KeyCode.Three] = true,
}

local kingLegacyLuxuryHubV105 = Instance.new("ScreenGui")
kingLegacyLuxuryHubV105.Name = "KingLegacy_LuxuryHub_v105"
kingLegacyLuxuryHubV105.Parent = coreGui

local v13 = userTIER == "VIP" and 625 or 175

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, v13)
frame.Position = UDim2.new(0, 40, 0.5, userTIER == "VIP" and -312 or -87)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
frame.Active = true
frame.Parent = kingLegacyLuxuryHubV105

f1(frame, 16)

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(212, 175, 55)
uiStroke.Thickness = 2
uiStroke.Transparency = 0.25
uiStroke.Parent = frame

local frame2 = Instance.new("Frame")
frame2.Size = UDim2.new(1, 0, 0, 52)
frame2.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
frame2.Parent = frame

f1(frame2, 16)

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -150, 1, 0)
textLabel.Position = UDim2.new(0, 16, 0, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = userTIER == "VIP" and v2[v1].titleVIP or v2[v1].titleFree
textLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
textLabel.Font = Enum.Font.FredokaOne
textLabel.TextSize = 15
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = frame2

local textButton = Instance.new("TextButton")
textButton.Size = UDim2.new(0, 36, 0, 32)
textButton.Position = UDim2.new(1, -122, 0, 10)
textButton.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
textButton.Text = v1 == "ZH" and "EN 🌐" or "中 🌐"
textButton.TextColor3 = Color3.fromRGB(255, 215, 0)
textButton.Font = Enum.Font.FredokaOne
textButton.TextSize = 13
textButton.Parent = frame2

f1(textButton, 8)

local textButton2 = Instance.new("TextButton")
textButton2.Size = UDim2.new(0, 32, 0, 32)
textButton2.Position = UDim2.new(1, -82, 0, 10)
textButton2.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
textButton2.Text = "🗕"
textButton2.TextColor3 = Color3.new(1, 1, 1)
textButton2.Font = Enum.Font.FredokaOne
textButton2.TextSize = 14
textButton2.Parent = frame2

f1(textButton2, 8)

local textButton3 = Instance.new("TextButton")
textButton3.Size = UDim2.new(0, 32, 0, 32)
textButton3.Position = UDim2.new(1, -42, 0, 10)
textButton3.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
textButton3.Text = "✕"
textButton3.TextColor3 = Color3.new(1, 1, 1)
textButton3.Font = Enum.Font.FredokaOne
textButton3.TextSize = 15
textButton3.Parent = frame2

f1(textButton3, 8)

local textButton4 = Instance.new("TextButton")
textButton4.Size = UDim2.new(1, -30, 0, 26)
textButton4.Position = UDim2.new(0, 15, 0, 58)
textButton4.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
textButton4.BackgroundTransparency = 0.5
textButton4.Text = v2[v1].authorText
textButton4.TextColor3 = Color3.fromRGB(100, 180, 255)
textButton4.Font = Enum.Font.FredokaOne
textButton4.TextSize = 13
textButton4.TextXAlignment = Enum.TextXAlignment.Left
textButton4.Parent = frame

f1(textButton4, 8)

textButton4.Activated:Connect(function()
  do
    if setclipboard then
      do
        setclipboard("https://discord.gg/9u7UTY6TEg")
        textButton4.Text = v2[v1].authorCopied
      end

      do
        textButton4.TextColor3 = Color3.fromRGB(0, 230, 130)

        task.delay(2, function()
          do
            textButton4.Text = v2[v1].authorText
            textButton4.TextColor3 = Color3.fromRGB(100, 180, 255)
          end
        end)
      end
    end
  end
end)

local v15 = false

f2(textButton2, function()
  do
    do
      v15 = not v15
      textButton2.Text = v15 and "🗖" or "🗕"
    end

    do
      for index, value in ipairs(frame:GetChildren()) do
        if value ~= frame2 and value ~= uiStroke then
          value.Visible = not v15
        end
      end

      frame.Size = v15 and UDim2.new(0, 420, 0, 52) or UDim2.new(0, 420, 0, v13)
    end
  end
end)

f2(textButton3, function()
  do
    do
      v21 = true
      v5 = false
    end

    do
      v7 = false
      v8 = false
    end

    do
      for key, value2 in pairs(v10) do
        for key2, value3 in pairs(value2) do
          if type(value3) == "table" then
            for key3, value4 in pairs(value3) do
              value4:Remove()
            end
          else
            value3:Remove()
          end
        end
      end

      kingLegacyLuxuryHubV105:Destroy()
    end
  end
end)

local v18 = {}

local function f3()
  textLabel.Text = userTIER == "VIP" and v2[v1].titleVIP or v2[v1].titleFree
  textButton.Text = v1 == "ZH" and "EN 🌐" or "中 🌐"
  textButton4.Text = v2[v1].authorText

  if userTIER == "FREE" then
    if v18.aimBtn then
      v18.aimBtn.Text = v7 and v2[v1].btnAimOn or v2[v1].btnAimOff
    end
  else
    do
      if v18.statusText then
        v18.statusText.Text = v5 and v2[v1].statusOn or v2[v1].statusOff
      end

      if v18.mainTabBtn then
        v18.mainTabBtn.Text = v2[v1].tabMain
      end
    end

    do
      if v18.skillTabBtn then
        v18.skillTabBtn.Text = v2[v1].tabSkill
      end

      if v18.autoBtn then
        v18.autoBtn.Text = v5 and v2[v1].btnAutoStop or v2[v1].btnAutoStart
      end
    end

    do
      if v18.aimBtn then
        v18.aimBtn.Text = v7 and v2[v1].btnAimOn or v2[v1].btnAimOff
      end

      if v18.stickBtn then
        v18.stickBtn.Text = v6 and v2[v1].btnStickOn or v2[v1].btnStickOff
      end
    end

    do
      if v18.espBtn then
        v18.espBtn.Text = v8 and v2[v1].btnEspOn or v2[v1].btnEspOff
      end

      if v18.targetInput then
        v18.targetInput.PlaceholderText = v2[v1].targetPlaceholder
      end
    end

    do
      if v18.switchBtn then
        v18.switchBtn.Text = v2[v1].btnSwitchTarget
      end

      if v18.hopBtn then
        v18.hopBtn.Text = v2[v1].btnHop
      end
    end
  end
end

textButton.Activated:Connect(function()
  do
    v1 = v1 == "ZH" and "EN" or "ZH"
    f3()
  end
end)

if userTIER == "FREE" then
  local textButton5

  do
    textButton5 = Instance.new("TextButton")
    textButton5.Size = UDim2.new(1, -30, 0, 56)
    textButton5.Position = UDim2.new(0, 15, 0, 92)
  end

  do
    textButton5.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    textButton5.Text = v2[v1].btnAimOff
    textButton5.TextColor3 = Color3.new(1, 1, 1)
  end

  do
    textButton5.Font = Enum.Font.FredokaOne
    textButton5.TextSize = 15
    textButton5.Parent = frame
  end

  do
    f1(textButton5, 12)
    v18.aimBtn = textButton5

    f2(textButton5, function()
      do
        v7 = not v7

        textButton5.BackgroundColor3 = v7 and Color3.fromRGB(0, 130, 200)
          or Color3.fromRGB(22, 22, 30)
      end

      do
        textButton5.Text = v7 and v2[v1].btnAimOn or v2[v1].btnAimOff
      end
    end)
  end
end

local v23

if userTIER == "VIP" then
  local frame3 = Instance.new("Frame")
  frame3.Size = UDim2.new(1, -30, 0, 42)
  frame3.Position = UDim2.new(0, 15, 0, 90)
  frame3.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
  frame3.Parent = frame

  f1(frame3, 12)

  local frame4 = Instance.new("Frame")
  frame4.Size = UDim2.new(0, 10, 0, 10)
  frame4.Position = UDim2.new(0, 14, 0.5, -5)
  frame4.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
  frame4.Parent = frame3

  f1(frame4, 5)

  local textLabel2 = Instance.new("TextLabel")
  textLabel2.Size = UDim2.new(1, -36, 1, 0)
  textLabel2.Position = UDim2.new(0, 32, 0, 0)
  textLabel2.BackgroundTransparency = 1
  textLabel2.Text = v2[v1].statusOff
  textLabel2.TextColor3 = Color3.fromRGB(190, 190, 210)
  textLabel2.Font = Enum.Font.FredokaOne
  textLabel2.TextSize = 14
  textLabel2.TextXAlignment = Enum.TextXAlignment.Left
  textLabel2.Parent = frame3

  v18.statusText = textLabel2

  local frame5 = Instance.new("Frame")
  frame5.Size = UDim2.new(1, -30, 0, 40)
  frame5.Position = UDim2.new(0, 15, 0, 140)
  frame5.BackgroundTransparency = 1
  frame5.Parent = frame

  local textButton6 = Instance.new("TextButton")
  textButton6.Size = UDim2.new(0.48, 0, 1, 0)
  textButton6.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
  textButton6.Text = v2[v1].tabMain
  textButton6.TextColor3 = Color3.fromRGB(255, 215, 0)
  textButton6.Font = Enum.Font.FredokaOne
  textButton6.TextSize = 14
  textButton6.Parent = frame5

  f1(textButton6, 12)
  v18.mainTabBtn = textButton6

  local textButton7 = Instance.new("TextButton")
  textButton7.Size = UDim2.new(0.48, 0, 1, 0)
  textButton7.Position = UDim2.new(0.52, 0, 0, 0)
  textButton7.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
  textButton7.Text = v2[v1].tabSkill
  textButton7.TextColor3 = Color3.fromRGB(140, 140, 160)
  textButton7.Font = Enum.Font.FredokaOne
  textButton7.TextSize = 14
  textButton7.Parent = frame5

  f1(textButton7, 12)
  v18.skillTabBtn = textButton7

  local frame6 = Instance.new("Frame")
  frame6.Size = UDim2.new(1, -30, 0, 410)
  frame6.Position = UDim2.new(0, 15, 0, 190)
  frame6.BackgroundTransparency = 1
  frame6.Parent = frame

  local frame7 = Instance.new("Frame")
  frame7.Size = UDim2.new(1, 0, 1, 0)
  frame7.BackgroundTransparency = 1
  frame7.Parent = frame6

  local frame8 = Instance.new("Frame")
  frame8.Size = UDim2.new(1, 0, 1, 0)
  frame8.BackgroundTransparency = 1
  frame8.Visible = false
  frame8.Parent = frame6

  f2(textButton6, function()
    do
      do
        frame7.Visible = true
        frame8.Visible = false
      end

      do
        textButton6.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        textButton6.TextColor3 = Color3.fromRGB(255, 215, 0)
      end

      do
        textButton7.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        textButton7.TextColor3 = Color3.fromRGB(140, 140, 160)
      end
    end
  end)

  f2(textButton7, function()
    do
      frame7.Visible = false
      frame8.Visible = true
    end

    do
      textButton7.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
      textButton7.TextColor3 = Color3.fromRGB(255, 215, 0)
    end

    do
      textButton6.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
      textButton6.TextColor3 = Color3.fromRGB(140, 140, 160)
    end
  end)

  local textButton8 = Instance.new("TextButton")
  textButton8.Size = UDim2.new(1, 0, 0, 46)
  textButton8.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
  textButton8.Text = v2[v1].btnAutoStart
  textButton8.TextColor3 = Color3.fromRGB(0, 230, 130)
  textButton8.Font = Enum.Font.FredokaOne
  textButton8.TextSize = 15
  textButton8.Parent = frame7

  f1(textButton8, 12)
  v18.autoBtn = textButton8

  local textButton9 = Instance.new("TextButton")
  textButton9.Size = UDim2.new(1, 0, 0, 40)
  textButton9.Position = UDim2.new(0, 0, 0, 56)
  textButton9.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
  textButton9.Text = v2[v1].btnAimOff
  textButton9.TextColor3 = Color3.new(1, 1, 1)
  textButton9.Font = Enum.Font.FredokaOne
  textButton9.TextSize = 14
  textButton9.Parent = frame7

  f1(textButton9, 12)
  v18.aimBtn = textButton9

  f2(textButton9, function()
    do
      v7 = not v7

      textButton9.BackgroundColor3 = v7 and Color3.fromRGB(0, 120, 180)
        or Color3.fromRGB(20, 20, 28)
    end

    do
      textButton9.Text = v7 and v2[v1].btnAimOn or v2[v1].btnAimOff
    end
  end)

  local textButton10 = Instance.new("TextButton")
  textButton10.Size = UDim2.new(1, 0, 0, 40)
  textButton10.Position = UDim2.new(0, 0, 0, 104)

  textButton10.BackgroundColor3 = v6 and Color3.fromRGB(140, 60, 20)
    or Color3.fromRGB(20, 20, 28)

  textButton10.Text = v6 and v2[v1].btnStickOn or v2[v1].btnStickOff
  textButton10.TextColor3 = Color3.new(1, 1, 1)
  textButton10.Font = Enum.Font.FredokaOne
  textButton10.TextSize = 14
  textButton10.Parent = frame7

  f1(textButton10, 12)
  v18.stickBtn = textButton10

  f2(textButton10, function()
    do
      v6 = not v6

      textButton10.BackgroundColor3 = v6 and Color3.fromRGB(140, 60, 20)
        or Color3.fromRGB(20, 20, 28)
    end

    do
      textButton10.Text = v6 and v2[v1].btnStickOn or v2[v1].btnStickOff
    end
  end)

  local textButton11 = Instance.new("TextButton")
  textButton11.Size = UDim2.new(1, 0, 0, 40)
  textButton11.Position = UDim2.new(0, 0, 0, 152)
  textButton11.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
  textButton11.Text = v2[v1].btnEspOff
  textButton11.TextColor3 = Color3.new(1, 1, 1)
  textButton11.Font = Enum.Font.FredokaOne
  textButton11.TextSize = 14
  textButton11.Parent = frame7

  f1(textButton11, 12)
  v18.espBtn = textButton11

  f2(textButton11, function()
    do
      v8 = not v8

      textButton11.BackgroundColor3 = v8 and Color3.fromRGB(180, 45, 55)
        or Color3.fromRGB(20, 20, 28)
    end

    do
      textButton11.Text = v8 and v2[v1].btnEspOn or v2[v1].btnEspOff
    end
  end)

  local textBox = Instance.new("TextBox")
  textBox.Size = UDim2.new(1, 0, 0, 42)
  textBox.Position = UDim2.new(0, 0, 0, 200)
  textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
  textBox.PlaceholderText = v2[v1].targetPlaceholder
  textBox.Text = ""
  textBox.TextColor3 = Color3.fromRGB(240, 240, 240)
  textBox.Font = Enum.Font.FredokaOne
  textBox.TextSize = 14
  textBox.Parent = frame7

  f1(textBox, 12)
  v18.targetInput = textBox

  textBox.FocusLost:Connect(function(p4)
    if textBox.Text ~= "" then
      for index2, value5 in ipairs(players:GetPlayers()) do
        if value5 ~= localPlayer
          and string.lower(value5.Name):sub(1, #textBox.Text) == string.lower(textBox.Text) then
          v23 = value5
          break
        end
      end
    else
      v23 = nil
    end
  end)

  local textButton12 = Instance.new("TextButton")
  textButton12.Size = UDim2.new(0.48, 0, 0, 42)
  textButton12.Position = UDim2.new(0, 0, 0, 252)
  textButton12.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
  textButton12.Text = v2[v1].btnSwitchTarget
  textButton12.TextColor3 = Color3.new(1, 1, 1)
  textButton12.Font = Enum.Font.FredokaOne
  textButton12.TextSize = 13.5
  textButton12.Parent = frame7

  f1(textButton12, 12)
  v18.switchBtn = textButton12

  f2(textButton12, function()
    local v30

    do
      v30 = {}

      for index3, value6 in ipairs(players:GetPlayers()) do
        if value6 ~= localPlayer and value6.Character
          and value6.Character:FindFirstChild("HumanoidRootPart") then
          local humanoid = value6.Character:FindFirstChildOfClass("Humanoid")

          if humanoid and humanoid.Health > 0 then
            table.insert(v30, value6)
          end
        end
      end
    end

    do
      if #v30 > 0 then
        local v31 = 1

        for index4, value7 in ipairs(v30) do
          if value7 == v9 or value7 == v23 then
            v31 = index4 + 1
            break
          end
        end

        if v31 > #v30 then
          v31 = 1
        end

        v23 = v30[v31]
        v9 = v30[v31]
        textBox.Text = v23.Name
      end
    end
  end)

  local textButton13 = Instance.new("TextButton")
  textButton13.Size = UDim2.new(0.48, 0, 0, 42)
  textButton13.Position = UDim2.new(0.52, 0, 0, 252)
  textButton13.BackgroundColor3 = Color3.fromRGB(32, 32, 44)
  textButton13.Text = v2[v1].btnHop
  textButton13.TextColor3 = Color3.new(1, 1, 1)
  textButton13.Font = Enum.Font.FredokaOne
  textButton13.TextSize = 13.5
  textButton13.Parent = frame7

  f1(textButton13, 12)
  v18.hopBtn = textButton13
  f2(textButton13, function() end)

  for index5, value8 in ipairs({
    { key = Enum.KeyCode.One, id = "slot1" }, { key = Enum.KeyCode.Two, id = "slot2" },
    { key = Enum.KeyCode.Three, id = "slot3" },
  }) do
    local textButton14

    do
      textButton14 = Instance.new("TextButton")
      textButton14.Size = UDim2.new(0.31, 0, 0, 40)
      textButton14.Position = UDim2.new((index5 - 1) * 0.345, 0, 0, 12)

      textButton14.BackgroundColor3 = v12[value8.key] and Color3.fromRGB(0, 110, 180)
        or Color3.fromRGB(20, 20, 28)
    end

    do
      textButton14.Text = v2[v1][value8.id]
      textButton14.TextColor3 = Color3.new(1, 1, 1)
      textButton14.Font = Enum.Font.FredokaOne
      textButton14.TextSize = 13
    end

    do
      textButton14.Parent = frame8
      f1(textButton14, 10)

      f2(textButton14, function()
        do
          do
            v12[value8.key] = not v12[value8.key]

            textButton14.BackgroundColor3 = v12[value8.key] and Color3.fromRGB(0, 110, 180)
              or Color3.fromRGB(20, 20, 28)
          end
        end
      end)
    end
  end

  for index6, value9 in ipairs({
    Enum.KeyCode.Q, Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V,
    Enum.KeyCode.E, Enum.KeyCode.T, Enum.KeyCode.Y,
  }) do
    local textButton15

    do
      local v34, v35 = (index6 - 1) % 3, math.floor((index6 - 1) / 3)

      textButton15 = Instance.new("TextButton")
      textButton15.Size = UDim2.new(0.31, 0, 0, 40)
      textButton15.Position = UDim2.new(v34 * 0.345, 0, 0, 64 + v35 * 46)
    end

    do
      textButton15.BackgroundColor3 = v11[value9] and Color3.fromRGB(35, 130, 70)
        or Color3.fromRGB(20, 20, 28)

      textButton15.Text = v2[v1].skillBtn .. value9.Name
      textButton15.TextColor3 = Color3.new(1, 1, 1)
      textButton15.Font = Enum.Font.FredokaOne
    end

    do
      textButton15.TextSize = 13
      textButton15.Parent = frame8

      f1(textButton15, 10)

      f2(textButton15, function()
        do
          v11[value9] = not v11[value9]

          textButton15.BackgroundColor3 = v11[value9] and Color3.fromRGB(35, 130, 70)
            or Color3.fromRGB(20, 20, 28)
        end
      end)
    end
  end

  f2(textButton8, function()
    do
      v5 = not v5

      if v5 then
        do
          textButton8.Text = v2[v1].btnAutoStop
          textButton8.TextColor3 = Color3.fromRGB(255, 90, 90)
        end

        do
          frame4.BackgroundColor3 = Color3.fromRGB(0, 230, 130)
          textLabel2.Text = v2[v1].statusOn
        end
      else
        do
          textButton8.Text = v2[v1].btnAutoStart
          textButton8.TextColor3 = Color3.fromRGB(0, 230, 130)
        end

        do
          frame4.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
          textLabel2.Text = v2[v1].statusOff
        end
      end
    end
  end)
end

local v38, position, position2

frame2.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
    do
      v38 = true
      position = input.Position
    end

    do
      position2 = frame.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          v38 = false
        end
      end)
    end
  end
end)

local v40

frame2.InputChanged:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseMovement
    or input2.UserInputType == Enum.UserInputType.Touch then
    v40 = input2
  end
end)

runService.RenderStepped:Connect(function()
  if v38 and v40 then
    do
      local v41 = v40.Position - position

      frame.Position = frame.Position:Lerp(UDim2.new(
        position2.X.Scale, position2.X.Offset + v41.X, position2.Y.Scale,
        position2.Y.Offset + v41.Y
      ), 0.4)
    end
  end
end)

local function f4(p5)
  if v10[p5] then
    return
  end

  local v42 = {}

  for i = 1, 8 do
    local line

    do
      line = Drawing.new("Line")
      line.Visible = false
    end

    do
      line.Thickness = 1.8
      table.insert(v42, line)
    end
  end

  local line2 = Drawing.new("Line")
  line2.Visible = false
  line2.Thickness = 4.5

  local line3 = Drawing.new("Line")
  line3.Visible = false
  line3.Thickness = 4.5
  line3.Color = Color3.fromRGB(20, 20, 20)

  local text = Drawing.new("Text")
  text.Visible = false
  text.Center = true
  text.Outline = true
  text.OutlineColor = Color3.fromRGB(0, 0, 0)
  text.Font = 3
  text.Size = 20
  text.Color = Color3.fromRGB(255, 255, 255)

  local text2 = Drawing.new("Text")
  text2.Visible = false
  text2.Center = true
  text2.Outline = true
  text2.OutlineColor = Color3.fromRGB(0, 0, 0)
  text2.Font = 3
  text2.Size = 17
  text2.Color = Color3.fromRGB(255, 225, 80)

  v10[p5] = {
    BoxLines = v42,
    HealthBar = line2,
    HealthBarBg = line3,
    NameText = text,
    InfoText = text2,
  }
end

for index7, value10 in ipairs(players:GetPlayers()) do
  if value10 ~= localPlayer then
    f4(value10)
  end
end

players.PlayerAdded:Connect(f4)

players.PlayerRemoving:Connect(function(player)
  if v10[player] then
    do
      for key4, value11 in pairs(v10[player]) do
        if type(value11) == "table" then
          for key5, value12 in pairs(value11) do
            value12:Remove()
          end
        else
          value11:Remove()
        end
      end

      v10[player] = nil
    end
  end
end)

local function f5(p6)
  local v44 = "LV.?"
  local v45 = "⚔️ PVP: ✕"
  local leaderstats = p6:FindFirstChild("leaderstats")

  if leaderstats then
    for index8, value13 in ipairs(leaderstats:GetChildren()) do
      local v46 = string.lower(value13.Name)

      if v46:find("level") or v46:find("lv") or v46:find("等級") then
        v44 = "LV." .. tostring(value13.Value)
        break
      end
    end
  end

  if v44 == "LV.?" and p6:FindFirstChild("Data") and p6.Data:FindFirstChild("Level") then
    v44 = "LV." .. tostring(p6.Data.Level.Value)
  end

  local character = p6.Character

  if character then
    if character:GetAttribute("PVP") == true
      or character:FindFirstChild("PVP") and character.PVP.Value == true then
      v45 = "⚔️ PVP: ✓"
    elseif p6:GetAttribute("PVP") == true then
      v45 = "⚔️ PVP: ✓"
    end
  end

  return v44, v45
end

local function f6()
  local character2 = localPlayer.Character
  local humanoidRootPart = character2 and character2:FindFirstChild("HumanoidRootPart")

  if not humanoidRootPart then
    return nil
  end

  local v47, huge = nil, math.huge

  for index9, value14 in ipairs(players:GetPlayers()) do
    if value14 ~= localPlayer and value14.Character
      and value14.Character:FindFirstChild("HumanoidRootPart") then
      do
        local humanoid2 = value14.Character:FindFirstChildOfClass("Humanoid")

        if humanoid2 and humanoid2.Health > 0 then
          do
            local magnitude = (humanoidRootPart.Position
              - value14.Character.HumanoidRootPart.Position).Magnitude

            if magnitude < huge then
              do
                do
                  huge = magnitude
                  v47 = value14
                end
              end
            end
          end
        end
      end
    end
  end

  return v47
end

runService.RenderStepped:Connect(function(delta)
  for key6, value15 in pairs(v10) do
    local character3 = key6.Character
    local humanoidRootPart2 = character3 and character3:FindFirstChild("HumanoidRootPart")
    local humanoid3 = character3 and character3:FindFirstChildOfClass("Humanoid")

    if v8 and humanoidRootPart2 and humanoid3 and humanoid3.Health > 0 then
      local v48, v49 = currentCamera:WorldToViewportPoint(humanoidRootPart2.Position)

      if v49 then
        local v51, v52, v53, v54, v55, color, v56, boxLines, v57, v58

        do
          do
            v51 = math.clamp(5500 / v48.Z, 35, 600)
            v52 = v51 * 0.65
          end

          do
            v53 = v51
            v54 = v48.X - v52 / 2
          end
        end

        do
          v55 = v48.Y - v53 / 2

          color = key6.Team and localPlayer.Team and key6.Team == localPlayer.Team
              and Color3.fromRGB(0, 255, 100)
            or Color3.fromRGB(255, 60, 60)

          v56 = math.clamp(v52 * 0.12, 4, 12)
          boxLines = value15.BoxLines
        end

        do
          boxLines[1].From = Vector2.new(v54 + v56, v55)
          boxLines[1].To = Vector2.new(v54 + v52 - v56, v55)
          boxLines[2].From = Vector2.new(v54 + v56, v55 + v53)
          boxLines[2].To = Vector2.new(v54 + v52 - v56, v55 + v53)
        end

        do
          boxLines[3].From = Vector2.new(v54, v55 + v56)
          boxLines[3].To = Vector2.new(v54, v55 + v53 - v56)
          boxLines[4].From = Vector2.new(v54 + v52, v55 + v56)
          boxLines[4].To = Vector2.new(v54 + v52, v55 + v53 - v56)
        end

        do
          boxLines[5].From = Vector2.new(v54 + v56, v55)
          boxLines[5].To = Vector2.new(v54, v55 + v56)
          boxLines[6].From = Vector2.new(v54 + v52 - v56, v55)
          boxLines[6].To = Vector2.new(v54 + v52, v55 + v56)
        end

        do
          boxLines[7].From = Vector2.new(v54 + v56, v55 + v53)
          boxLines[7].To = Vector2.new(v54, v55 + v53 - v56)
          boxLines[8].From = Vector2.new(v54 + v52 - v56, v55 + v53)
          boxLines[8].To = Vector2.new(v54 + v52, v55 + v53 - v56)
        end

        do
          for index10, value16 in ipairs(boxLines) do
            do
              value16.Color = color
              value16.Visible = true
            end
          end

          v57 = math.clamp(humanoid3.Health / humanoid3.MaxHealth, 0, 1)
          v58 = v53 * v57
          value15.HealthBarBg.From = Vector2.new(v54 - 8, v55 + v53)
        end

        do
          value15.HealthBarBg.Name = "BG"
          value15.HealthBarBg.To = Vector2.new(v54 - 8, v55)
          value15.HealthBarBg.Visible = true
          value15.HealthBar.From = Vector2.new(v54 - 8, v55 + v53)
        end

        do
          value15.HealthBar.To = Vector2.new(v54 - 8, v55 + (v53 - v58))
          value15.HealthBar.Color = Color3.fromRGB(255 - v57 * 255, v57 * 255, 0)
          value15.HealthBar.Visible = true

          value15.NameText.Text = "❖ " .. key6.Name .. " [ " .. math.floor(humanoid3.Health)
            .. " HP ] ❖"
        end

        do
          value15.NameText.Position = Vector2.new(v48.X, v55 - 30)
          value15.NameText.Visible = true

          local v59, v60 = f5(key6)
          value15.InfoText.Text = "⚜ " .. v59 .. " ✦ " .. v60 .. " ⚜"
        end

        do
          value15.InfoText.Position = Vector2.new(v48.X, v55 + v53 + 6)
          value15.InfoText.Visible = true
        end
      else
        do
          for index11, value17 in ipairs(value15.BoxLines) do
            value17.Visible = false
          end

          value15.HealthBar.Visible = false
        end

        do
          value15.HealthBarBg.Visible = false
          value15.NameText.Visible = false
        end

        do
          value15.InfoText.Visible = false
        end
      end
    else
      do
        for index12, value18 in ipairs(value15.BoxLines) do
          value18.Visible = false
        end

        value15.HealthBar.Visible = false
      end

      do
        value15.HealthBarBg.Visible = false
        value15.NameText.Visible = false
      end

      do
        value15.InfoText.Visible = false
      end
    end
  end

  local v64 = nil

  if v5 and userTIER == "VIP" then
    do
      do
        if not v9 or not v9.Character
          or v9.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
          v9 = v23 or f6()
        end

        v64 = v9
      end
    end
  elseif v7 then
    v64 = v23 or f6()
  end

  if not v64 then
    return
  end

  local character4, character5 = localPlayer.Character, v64.Character
  local humanoidRootPart3 = character4 and character4:FindFirstChild("HumanoidRootPart")
  local humanoid4 = character4 and character4:FindFirstChildOfClass("Humanoid")

  local humanoidRootPart4 = character5
    and (character5:FindFirstChild("HumanoidRootPart") or character5:FindFirstChild("Head"))

  local humanoid5 = character5 and character5:FindFirstChild("Humanoid")

  if humanoidRootPart3 and humanoid4 and humanoid4.Health > 0 and humanoidRootPart4
    and humanoid5 and humanoid5.Health > 0 then
    local assemblyLinearVelocity, v66, v67

    do
      if v5 and v6 and userTIER == "VIP" then
        do
          local v69 = humanoidRootPart4.CFrame * CFrame.new(0, 0, 1.5)

          humanoidRootPart3.CFrame = humanoidRootPart3.CFrame:Lerp(
            v69, math.clamp(delta * 25, 0, 1)
          )
        end

        do
          humanoidRootPart3.AssemblyLinearVelocity = Vector3.zero
        end
      end

      assemblyLinearVelocity = humanoidRootPart4.AssemblyLinearVelocity or Vector3.zero
    end

    do
      do
        local magnitude2 = (humanoidRootPart4.Position - humanoidRootPart3.Position).Magnitude
        v66 = math.clamp(magnitude2 / 120, 0.08, 0.25)
      end
    end

    do
      do
        v67 = humanoidRootPart4.Position + Vector3.new(0, 0.5, 0) + assemblyLinearVelocity * v66

        currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.lookAt(
          currentCamera.CFrame.Position, v67
        ), math.clamp(delta * 35, 0, 1))
      end
    end

    do
      local v71, v72 = currentCamera:WorldToViewportPoint(v67)

      if v72 then
        virtualInputManager:SendMouseMoveEvent(v71.X, v71.Y, game)
      end
    end
  end
end)
