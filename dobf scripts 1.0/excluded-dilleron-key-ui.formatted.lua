local v0 = string.char
local v1 = string.byte
local v2 = string.sub
local v3 = bit32 or bit
local v4 = v3.bxor
local v5 = table.concat
local v6 = table.insert
local function v7(v75, v76)
  local v77 = {}
  for v145 = 1, #v75 do
    v6(v77, v0(v4(v1(v2(v75, v145, v145 + 1)), v1(v2(v76, 1 + (v145 % #v76), 1 + (v145 % #v76) + 1))) % 256))
  end
  return v5(v77)
end
local v8 = {
  KEY_LINK = "https://scriptix.live",
  VALID_KEYS = {"PHANTOM-ABCD-1234", "TEST-KEY-2025", "DEMO-KEY-FREE"},
  CALLBACK_ON_SUCCESS = function()
  print("[PHANTOM] Payload delivered successfully.")
end
}
local v9 = game:GetService("Players")
local v10 = game:GetService("TweenService")
local v11 = game:GetService("UserInputService")
local v12 = v9.LocalPlayer
local v13 = {
  BG_BLACK = Color3.fromRGB(8, 8, 10),
  BG_DARK = Color3.fromRGB(14, 14, 18),
  BG_PANEL = Color3.fromRGB(18, 18, 24),
  BG_SURFACE = Color3.fromRGB(24, 24, 32),
  BG_INPUT = Color3.fromRGB(12, 12, 16),
  BG_HOVER = Color3.fromRGB(32, 32, 42),
  BORDER = Color3.fromRGB(40, 40, 55),
  BORDER_BRIGHT = Color3.fromRGB(60, 60, 80),
  RED_PRIMARY = Color3.fromRGB(220, 40, 40),
  RED_DARK = Color3.fromRGB(140, 20, 20),
  RED_GLOW = Color3.fromRGB(255, 60, 60),
  RED_DIM = Color3.fromRGB(80, 20, 20),
  AMBER = Color3.fromRGB(220, 170, 30),
  GREEN_OK = Color3.fromRGB(40, 200, 80),
  GREEN_DIM = Color3.fromRGB(20, 80, 40),
  WHITE = Color3.fromRGB(220, 220, 230),
  TEXT_BRIGHT = Color3.fromRGB(200, 200, 215),
  TEXT_MID = Color3.fromRGB(130, 130, 150),
  TEXT_DIM = Color3.fromRGB(65, 65, 80),
  CLASSIFIED = Color3.fromRGB(180, 30, 30)
}
local function v14(v78, v79, v80, v81, v82)
  local v83 = 0
  local v84
  while true do
    local v146 = 0
    while true do
      if (v146 == 0) then
        if (v83 == 0) then
          v84 = v10:Create(v78, TweenInfo.new(v80 or 0.3, v81 or Enum.EasingStyle.Quint, v82 or Enum.EasingDirection.Out), v79)
          v84:Play()
          v83 = 1
        end
        if (v83 == 1) then
          return v84
        end
        break
      end
    end
  end
end
local function v15(v85, v86)
  local v87 = 0
  local v88
  while true do
    local v147 = 0
    while true do
      if (v147 == 0) then
        if (v87 == 0) then
          v88 = Instance.new(v85)
          for v206, v207 in pairs(v86 or {}) do
            if (v206 ~= "Parent") then
              pcall(function()
                v88[v206] = v207
              end)
            end
          end
          v87 = 1
        end
        if (1 == v87) then
          if (v86 and v86.Parent) then
            v88.Parent = v86.Parent
          end
          return v88
        end
        break
      end
    end
  end
end
local function v16(v89, v90)
  return v15("UICorner", {CornerRadius = UDim.new(0, v90 or 6), Parent = v89})
end
local function v17(v91, v92, v93, v94)
  return v15("UIStroke", {
    Color = v92 or v13.BORDER,
    Thickness = v93 or 1,
    Transparency = v94 or 0,
    Parent = v91
  })
end
local function v18(v95)
  local v96 = 0
  local v97
  local v98
  while true do
    if (v96 == 0) then
      v97 = "0123456789ABCDEF"
      v98 = ""
      v96 = 1
    end
    if (v96 == 1) then
      local v169 = 0
      while true do
        if (v169 == 0) then
          for v208 = 1, v95 or 8 do
            local v209 = 0
            local v210
            while true do
              if (v209 == 0) then
                v210 = math.random(1, 16)
                v98 = v98 .. v97:sub(v210, v210)
                break
              end
            end
          end
          return v98
        end
      end
    end
  end
end
local function v19(v99, v100, v101, v102)
  local v103 = 0
  while true do
    if (1 == v103) then
      for v181 = 1, #v100 do
        local v182 = 0
        while true do
          if (v182 == 1) then
            task.wait(v101 or 0.02)
            break
          end
          if (v182 == 0) then
            if (not v99 or not v99.Parent) then
              return
            end
            v99.Text = v100:sub(1, v181)
            v182 = 1
          end
        end
      end
      break
    end
    if (0 == v103) then
      v99.Text = ""
      if v102 then
        v99.TextColor3 = v102
      end
      v103 = 1
    end
  end
end
local function v20(v104, v105)
  if (v104 >= v105) then
    return v104
  end
  return math.random(v104, v105)
end
pcall(function()
  if game:GetService("CoreGui"):FindFirstChild("PhantomKeySystem") then
    game:GetService("CoreGui"):FindFirstChild("PhantomKeySystem"):Destroy()
  end
end)
pcall(function()
  if (v12:FindFirstChild("PlayerGui") and v12.PlayerGui:FindFirstChild("PhantomKeySystem")) then
    v12.PlayerGui.PhantomKeySystem:Destroy()
  end
end)
local v21 = v15("ScreenGui", {
  Name = "PhantomKeySystem",
  DisplayOrder = 999,
  IgnoreGuiInset = true,
  ResetOnSpawn = false,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})
local v22 = pcall(function()
  v21.Parent = game:GetService("CoreGui")
end)
if not v22 then
  v21.Parent = v12:WaitForChild("PlayerGui")
end
local v23 = v15("Frame", {
  Name = "Backdrop",
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundColor3 = v13.BG_BLACK,
  BackgroundTransparency = 0.14999999999997726,
  BorderSizePixel = 0,
  ZIndex = 1,
  Parent = v21
})
local v24 = {
  {UDim2.new(0, 20, 0, 20), "\9484"},
  {UDim2.new(1, -35, 0, 20), "\9488"},
  {UDim2.new(0, 20, 1, -35), "\9492"},
  {UDim2.new(1, -35, 1, -35), "\9496"}
}
for v107, v108 in ipairs(v24) do
  v15("TextLabel", {
    Size = UDim2.new(0, 15, 0, 15),
    Position = v108[1],
    BackgroundTransparency = 1,
    Text = v108[2],
    TextSize = 14,
    Font = Enum.Font.Code,
    TextColor3 = v13.RED_DIM,
    ZIndex = 2,
    Parent = v23
  })
end
local v25 = v15("TextLabel", {
  Name = "Watermark",
  Size = UDim2.new(0, 500, 0, 40),
  Position = UDim2.new(0.5, -250, 0.5, -20),
  BackgroundTransparency = 1,
  Text = "\9632 CLASSIFIED \9632 CLASSIFIED \9632 CLASSIFIED \9632 CLASSIFIED \9632",
  TextSize = 16,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_DIM,
  TextTransparency = 0.85,
  Rotation = -15,
  ZIndex = 2,
  Parent = v23
})
local v26 = v15("Frame", {
  Name = "RedScan",
  Size = UDim2.new(1, 0, 0, 2),
  Position = UDim2.new(0, 0, 0, 0),
  BackgroundColor3 = v13.RED_PRIMARY,
  BackgroundTransparency = 0.6,
  BorderSizePixel = 0,
  ZIndex = 3,
  Parent = v23
})
task.spawn(function()
  while v21 and v21.Parent do
    v26.Position = UDim2.new(0, 0, -0.01, 0)
    v14(v26, {Position = UDim2.new(0, 0, 1.009999999999991, 0)}, 3, Enum.EasingStyle.Linear)
    task.wait(3.5)
  end
end)
local v27 = v15("Frame", {
  Name = "Window",
  Size = UDim2.new(0, 440, 0, 500),
  Position = UDim2.new(0.5, -220, 0.5, -250),
  BackgroundColor3 = v13.BG_PANEL,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 10,
  Parent = v21
})
v16(v27, 3)
local v28 = v17(v27, v13.RED_PRIMARY, 1, 0.5)
local v29 = v15("Frame", {
  Name = "TopBar",
  Size = UDim2.new(1, 0, 0, 44),
  BackgroundColor3 = v13.BG_DARK,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 20,
  Parent = v27
})
v16(v29, 3)
v15("Frame", {
  Size = UDim2.new(1, 0, 0, 8),
  Position = UDim2.new(0, 0, 1, -8),
  BackgroundColor3 = v13.BG_DARK,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 20,
  Parent = v29
})
v15("Frame", {
  Size = UDim2.new(1, 0, 0, 2),
  Position = UDim2.new(0, 0, 1, -2),
  BackgroundColor3 = v13.RED_PRIMARY,
  BackgroundTransparency = 0.3,
  BorderSizePixel = 0,
  ZIndex = 21,
  Parent = v29
})
v15("TextLabel", {
  Size = UDim2.new(0, 20, 0, 44),
  Position = UDim2.new(0, 14, 0, 0),
  BackgroundTransparency = 1,
  Text = "\9670",
  TextSize = 14,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_PRIMARY,
  ZIndex = 22,
  Parent = v29
})
local v30 = v15("TextLabel", {
  Name = "BlinkDot",
  Size = UDim2.new(0, 20, 0, 44),
  Position = UDim2.new(0, 30, 0, 0),
  BackgroundTransparency = 1,
  Text = "\9679",
  TextSize = 10,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_GLOW,
  ZIndex = 22,
  Parent = v29
})
task.spawn(function()
  while v21 and v21.Parent do
    if (v30 and v30.Parent) then
      local v171 = 0
      while true do
        if (v171 == 0) then
          v14(v30, {TextTransparency = 0.8}, 0.8, Enum.EasingStyle.Sine)
          task.wait(0.8)
          v171 = 1
        end
        if (v171 == 1) then
          v14(v30, {TextTransparency = 0}, 0.8, Enum.EasingStyle.Sine)
          task.wait(0.7999999999999545)
          break
        end
      end
    else
      break
    end
  end
end)
v15("TextLabel", {
  Size = UDim2.new(1, -120, 1, 0),
  Position = UDim2.new(0, 50, 0, 0),
  BackgroundTransparency = 1,
  Text = "PHANTOM // AUTH SYSTEM",
  TextSize = 14,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_BRIGHT,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 22,
  Parent = v29
})
local v31 = v15("Frame", {
  Name = "ClassBadge",
  Size = UDim2.new(0, 78, 0, 22),
  Position = UDim2.new(1, -130, 0.5, -11),
  BackgroundColor3 = v13.RED_DIM,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 22,
  Parent = v29
})
v16(v31, 3)
v17(v31, v13.RED_PRIMARY, 1, 0.2999999999999545)
v15("TextLabel", {
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundTransparency = 1,
  Text = "CLASSIFIED",
  TextSize = 9,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_GLOW,
  ZIndex = 23,
  Parent = v31
})
local v32 = v15("TextButton", {
  Name = "Close",
  Size = UDim2.new(0, 32, 0, 32),
  Position = UDim2.new(1, -42, 0.5, -16),
  BackgroundColor3 = v13.RED_DIM,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Text = "\10005",
  TextColor3 = v13.RED_PRIMARY,
  TextSize = 14,
  Font = Enum.Font.Code,
  AutoButtonColor = false,
  ZIndex = 22,
  Parent = v29
})
v16(v32, 3)
v32.MouseEnter:Connect(function()
  v14(v32, {BackgroundColor3 = v13.RED_PRIMARY, TextColor3 = v13.WHITE}, 0.15)
end)
v32.MouseLeave:Connect(function()
  v14(v32, {BackgroundColor3 = v13.RED_DIM, TextColor3 = v13.RED_PRIMARY}, 0.15)
end)
v32.MouseButton1Click:Connect(function()
  local v109 = 0
  while true do
    if (v109 == 1) then
      v14(v23, {BackgroundTransparency = 1}, 0.3)
      task.wait(0.35)
      v109 = 2
    end
    if (v109 == 2) then
      v21:Destroy()
      break
    end
    if (v109 == 0) then
      v14(v27, {BackgroundTransparency = 1, Size = UDim2.new(0, 440, 0, 8)}, 0.3)
      v14(v28, {Transparency = 1}, 0.2)
      v109 = 1
    end
  end
end)
local v33, v34, v35, v36 = false, nil, nil, nil
v29.InputBegan:Connect(function(v110)
  if ((v110.UserInputType == Enum.UserInputType.MouseButton1) or (v110.UserInputType == Enum.UserInputType.Touch)) then
    local v155 = 0
    local v156
    while true do
      if (0 == v155) then
        v156 = 0
        while true do
          if (v156 == 0) then
            v33 = true
            v35 = v110.Position
            v156 = 1
          end
          if (v156 == 1) then
            v36 = v27.Position
            v110.Changed:Connect(function()
              if (v110.UserInputState == Enum.UserInputState.End) then
                v33 = false
              end
            end)
            break
          end
        end
        break
      end
    end
  end
end)
v29.InputChanged:Connect(function(v111)
  if ((v111.UserInputType == Enum.UserInputType.MouseMovement) or (v111.UserInputType == Enum.UserInputType.Touch)) then
    v34 = v111
  end
end)
v11.InputChanged:Connect(function(v112)
  if ((v112 == v34) and v33) then
    local v157 = v112.Position - v35
    v27.Position = UDim2.new(v36.X.Scale, v36.X.Offset + v157.X, v36.Y.Scale, v36.Y.Offset + v157.Y)
  end
end)
local v37 = v15("Frame", {
  Name = "Content",
  Size = UDim2.new(1, 0, 1, -44),
  Position = UDim2.new(0, 0, 0, 44),
  BackgroundColor3 = v13.BG_PANEL,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ClipsDescendants = true,
  ZIndex = 11,
  Parent = v27
})
local v38 = v15("Frame", {
  Name = "P1",
  Size = UDim2.new(1, -36, 1, -36),
  Position = UDim2.new(0, 18, 0, 18),
  BackgroundTransparency = 1,
  ZIndex = 12,
  Parent = v37
})
local v39 = v15("Frame", {
  Name = "Emblem",
  Size = UDim2.new(1, 0, 0, 72),
  Position = UDim2.new(0, 0, 0, 0),
  BackgroundColor3 = v13.BG_SURFACE,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v38
})
v16(v39, 4)
v17(v39, v13.BORDER, 1, 0.39999999999997726)
v15("TextLabel", {
  Size = UDim2.new(0, 50, 1, 0),
  Position = UDim2.new(0, 12, 0, 0),
  BackgroundTransparency = 1,
  Text = "\128737\65039",
  TextSize = 32,
  Font = Enum.Font.Code,
  ZIndex = 14,
  Parent = v39
})
v15("TextLabel", {
  Size = UDim2.new(1, -80, 0, 22),
  Position = UDim2.new(0, 62, 0, 14),
  BackgroundTransparency = 1,
  Text = "PHANTOM DEFENSE SYSTEM",
  TextSize = 15,
  Font = Enum.Font.Code,
  TextColor3 = v13.WHITE,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v39
})
v15("TextLabel", {
  Size = UDim2.new(1, -80, 0, 16),
  Position = UDim2.new(0, 62, 0, 38),
  BackgroundTransparency = 1,
  Text = "Authorization Required \8212 Clearance Level 5",
  TextSize = 10,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v39
})
local v40 = v15("Frame", {
  Name = "InfoGrid",
  Size = UDim2.new(1, 0, 0, 48),
  Position = UDim2.new(0, 0, 0, 80),
  BackgroundTransparency = 1,
  ZIndex = 13,
  Parent = v38
})
local v41 = {
  {label = "THREAT LEVEL", value = "ELEVATED", color = v13.AMBER},
  {label = "ENCRYPTION", value = "AES-256", color = v13.GREEN_OK},
  {label = "SESSION", value = v18(6), color = v13.TEXT_MID}
}
for v113, v114 in ipairs(v41) do
  local v115 = v15("Frame", {
    Name = "Info" .. v113,
    Size = UDim2.new(0.3333333333333333, -4, 1, 0),
    Position = UDim2.new((v113 - 1) / 3, ((v113 == 1) and 0) or 2, 0, 0),
    BackgroundColor3 = v13.BG_INPUT,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    ZIndex = 14,
    Parent = v40
  })
  v16(v115, 3)
  v15("TextLabel", {
    Size = UDim2.new(1, -10, 0, 12),
    Position = UDim2.new(0, 5, 0, 6),
    BackgroundTransparency = 1,
    Text = v114.label,
    TextSize = 8,
    Font = Enum.Font.Code,
    TextColor3 = v13.TEXT_DIM,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 15,
    Parent = v115
  })
  v15("TextLabel", {
    Name = "Value",
    Size = UDim2.new(1, -10, 0, 14),
    Position = UDim2.new(0, 5, 0, 22),
    BackgroundTransparency = 1,
    Text = v114.value,
    TextSize = 11,
    Font = Enum.Font.Code,
    TextColor3 = v114.color,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 15,
    Parent = v115
  })
end
local v42 = v40:FindFirstChild("Info1") and v40.Info1:FindFirstChild("Value")
v15("Frame", {
  Size = UDim2.new(1, 0, 0, 1),
  Position = UDim2.new(0, 0, 0, 138),
  BackgroundColor3 = v13.BORDER,
  BackgroundTransparency = 0.3,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v38
})
local v43 = v15("TextLabel", {
  Size = UDim2.new(0, 180, 0, 16),
  Position = UDim2.new(0.5, -90, 0, 130),
  BackgroundColor3 = v13.BG_PANEL,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Text = " \9670 ENTER ACCESS KEY \9670 ",
  TextSize = 10,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_PRIMARY,
  ZIndex = 14,
  Parent = v38
})
local v44 = v15("Frame", {
  Name = "InputContainer",
  Size = UDim2.new(1, 0, 0, 44),
  Position = UDim2.new(0, 0, 0, 158),
  BackgroundColor3 = v13.BG_INPUT,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v38
})
v16(v44, 4)
local v45 = v17(v44, v13.BORDER, 1, 0.2)
v15("Frame", {
  Size = UDim2.new(0, 3, 0, 28),
  Position = UDim2.new(0, 10, 0.5, -14),
  BackgroundColor3 = v13.RED_PRIMARY,
  BackgroundTransparency = 0.2999999999999545,
  BorderSizePixel = 0,
  ZIndex = 14,
  Parent = v44
})
v16(v44:GetChildren()[#v44:GetChildren()], 1)
local v46 = v15("TextBox", {
  Name = "KeyInput",
  Size = UDim2.new(1, -32, 1, 0),
  Position = UDim2.new(0, 22, 0, 0),
  BackgroundTransparency = 1,
  Text = "",
  PlaceholderText = "PHANTOM-XXXX-XXXX-XXXX",
  PlaceholderColor3 = v13.TEXT_DIM,
  TextColor3 = v13.RED_GLOW,
  TextSize = 14,
  Font = Enum.Font.Code,
  TextXAlignment = Enum.TextXAlignment.Left,
  ClearTextOnFocus = false,
  ZIndex = 14,
  Parent = v44
})
v46.Focused:Connect(function()
  v14(v45, {Color = v13.RED_PRIMARY, Transparency = 0}, 0.15000000000009095)
end)
v46.FocusLost:Connect(function()
  v14(v45, {Color = v13.BORDER, Transparency = 0.2}, 0.2)
end)
local v47 = v15("TextLabel", {
  Name = "Status",
  Size = UDim2.new(1, 0, 0, 18),
  Position = UDim2.new(0, 0, 0, 208),
  BackgroundTransparency = 1,
  Text = "",
  TextSize = 11,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_MID,
  TextXAlignment = Enum.TextXAlignment.Left,
  TextTransparency = 1,
  ZIndex = 13,
  Parent = v38
})
local function v48(v116, v117, v118)
  local v119 = 0
  while true do
    if (v119 == 0) then
      v47.Text = v116
      v47.TextColor3 = v117 or v13.TEXT_MID
      v119 = 1
    end
    if (v119 == 1) then
      v14(v47, {TextTransparency = 0}, 0.15)
      if v118 then
        task.delay(v118, function()
          if (v47 and v47.Parent) then
            v14(v47, {TextTransparency = 1}, 0.5)
          end
        end)
      end
      break
    end
  end
end
local v49 = v15("TextButton", {
  Name = "Verify",
  Size = UDim2.new(1, 0, 0, 44),
  Position = UDim2.new(0, 0, 0, 234),
  BackgroundColor3 = v13.RED_DIM,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Text = "",
  AutoButtonColor = false,
  ZIndex = 13,
  Parent = v38
})
v16(v49, 4)
local v50 = v17(v49, v13.RED_PRIMARY, 1, 0.3)
v15("TextLabel", {
  Size = UDim2.new(0, 20, 1, 0),
  Position = UDim2.new(0, 14, 0, 0),
  BackgroundTransparency = 1,
  Text = "\9654",
  TextSize = 12,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_GLOW,
  ZIndex = 14,
  Parent = v49
})
v15("TextLabel", {
  Name = "BtnLabel",
  Size = UDim2.new(1, -40, 1, 0),
  Position = UDim2.new(0, 36, 0, 0),
  BackgroundTransparency = 1,
  Text = "AUTHENTICATE",
  TextSize = 14,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_GLOW,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v49
})
v49.MouseEnter:Connect(function()
  local v120 = 0
  while true do
    if (v120 == 1) then
      for v183, v184 in ipairs(v49:GetChildren()) do
        if v184:IsA("TextLabel") then
          v14(v184, {TextColor3 = v13.WHITE}, 0.15)
        end
      end
      break
    end
    if (0 == v120) then
      v14(v49, {BackgroundColor3 = v13.RED_PRIMARY}, 0.15)
      v14(v50, {Transparency = 0}, 0.10000000000000142)
      v120 = 1
    end
  end
end)
v49.MouseLeave:Connect(function()
  v14(v49, {BackgroundColor3 = v13.RED_DIM}, 0.15)
  v14(v50, {Transparency = 0.2999999999999545}, 0.09999999999990905)
  for v150, v151 in ipairs(v49:GetChildren()) do
    if v151:IsA("TextLabel") then
      v14(v151, {TextColor3 = v13.RED_GLOW}, 0.15000000000009095)
    end
  end
end)
local v51 = v15("TextButton", {
  Name = "GetKey",
  Size = UDim2.new(1, 0, 0, 40),
  Position = UDim2.new(0, 0, 0, 286),
  BackgroundColor3 = v13.BG_SURFACE,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Text = "",
  AutoButtonColor = false,
  ZIndex = 13,
  Parent = v38
})
v16(v51, 4)
local v52 = v17(v51, v13.BORDER_BRIGHT, 1, 0.2)
v15("TextLabel", {
  Size = UDim2.new(0, 20, 1, 0),
  Position = UDim2.new(0, 14, 0, 0),
  BackgroundTransparency = 1,
  Text = "\128273",
  TextSize = 14,
  Font = Enum.Font.Code,
  ZIndex = 14,
  Parent = v51
})
v15("TextLabel", {
  Size = UDim2.new(1, -40, 1, 0),
  Position = UDim2.new(0, 36, 0, 0),
  BackgroundTransparency = 1,
  Text = "GET FREE KEY",
  TextSize = 12,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_MID,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v51
})
v15("TextLabel", {
  Size = UDim2.new(0, 20, 1, 0),
  Position = UDim2.new(1, -28, 0, 0),
  BackgroundTransparency = 1,
  Text = "\8594",
  TextSize = 14,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  ZIndex = 14,
  Parent = v51
})
v51.MouseEnter:Connect(function()
  local v121 = 0
  while true do
    if (v121 == 0) then
      v14(v51, {BackgroundColor3 = v13.BG_HOVER}, 0.15)
      v14(v52, {Color = v13.TEXT_MID, Transparency = 0}, 0.15000000000009095)
      break
    end
  end
end)
v51.MouseLeave:Connect(function()
  local v122 = 0
  local v123
  while true do
    if (v122 == 0) then
      v123 = 0
      while true do
        if (v123 == 0) then
          v14(v51, {BackgroundColor3 = v13.BG_SURFACE}, 0.15)
          v14(v52, {Color = v13.BORDER_BRIGHT, Transparency = 0.2}, 0.15)
          break
        end
      end
      break
    end
  end
end)
local v53 = v15("Frame", {
  Name = "Progress",
  Size = UDim2.new(1, 0, 0, 4),
  Position = UDim2.new(0, 0, 0, 336),
  BackgroundColor3 = v13.BORDER,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Visible = false,
  ZIndex = 13,
  Parent = v38
})
v16(v53, 2)
local v54 = v15("Frame", {
  Size = UDim2.new(0, 0, 1, 0),
  BackgroundColor3 = v13.RED_PRIMARY,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 14,
  Parent = v53
})
v16(v54, 2)
v15("Frame", {
  Size = UDim2.new(1, 0, 0, 1),
  Position = UDim2.new(0, 0, 1, -34),
  BackgroundColor3 = v13.BORDER,
  BackgroundTransparency = 0.5,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v38
})
local v55 = v15("TextLabel", {
  Size = UDim2.new(0.5, 0, 0, 14),
  Position = UDim2.new(0, 0, 1, -24),
  BackgroundTransparency = 1,
  Text = "PHANTOM v1.0",
  TextSize = 9,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 13,
  Parent = v38
})
local v56 = v15("TextLabel", {
  Size = UDim2.new(0.5, 0, 0, 14),
  Position = UDim2.new(0.5, 0, 1, -24),
  BackgroundTransparency = 1,
  Text = "",
  TextSize = 9,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  TextXAlignment = Enum.TextXAlignment.Right,
  ZIndex = 13,
  Parent = v38
})
task.spawn(function()
  while v21 and v21.Parent do
    if (v56 and v56.Parent) then
      v56.Text = "\9670 " .. os.date("%H:%M:%S") .. " UTC"
    else
      break
    end
    task.wait(1)
  end
end)
local v57 = v15("Frame", {
  Name = "P2",
  Size = UDim2.new(1, -36, 1, -36),
  Position = UDim2.new(1.2, 0, 0, 18),
  BackgroundTransparency = 1,
  Visible = false,
  ZIndex = 12,
  Parent = v37
})
local v58 = v15("Frame", {
  Size = UDim2.new(1, 0, 0, 50),
  Position = UDim2.new(0, 0, 0, 0),
  BackgroundColor3 = v13.BG_SURFACE,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v57
})
v16(v58, 4)
v17(v58, v13.BORDER, 1, 0.40000000000009095)
v15("TextLabel", {
  Size = UDim2.new(0, 30, 1, 0),
  Position = UDim2.new(0, 12, 0, 0),
  BackgroundTransparency = 1,
  Text = "\128225",
  TextSize = 22,
  Font = Enum.Font.Code,
  ZIndex = 14,
  Parent = v58
})
v15("TextLabel", {
  Size = UDim2.new(1, -60, 0, 18),
  Position = UDim2.new(0, 46, 0, 8),
  BackgroundTransparency = 1,
  Text = "KEY ACQUISITION BRIEFING",
  TextSize = 13,
  Font = Enum.Font.Code,
  TextColor3 = v13.WHITE,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v58
})
v15("TextLabel", {
  Size = UDim2.new(1, -60, 0, 14),
  Position = UDim2.new(0, 46, 0, 28),
  BackgroundTransparency = 1,
  Text = "Follow protocol exactly as described below",
  TextSize = 9,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v58
})
local v59 = v15("Frame", {
  Name = "Steps",
  Size = UDim2.new(1, 0, 0, 225),
  Position = UDim2.new(0, 0, 0, 58),
  BackgroundTransparency = 1,
  ZIndex = 13,
  Parent = v57
})
v15("UIListLayout", {
  SortOrder = Enum.SortOrder.LayoutOrder,
  Padding = UDim.new(0, 4),
  Parent = v59
})
local v60 = {
  {
  n = "01",
  text = "Click [ COPY LINK ] to copy the access URL",
  icon = "\128433\65039",
  pri = "HIGH"
},
  {
  n = "02",
  text = "Open a web browser on your device",
  icon = "\127760",
  pri = "MED"
},
  {
  n = "03",
  text = "Paste link into address bar \8594 Execute",
  icon = "\128203",
  pri = "HIGH"
},
  {
  n = "04",
  text = "Download software for key generation",
  icon = "\9989",
  pri = "HIGH"
},
  {
  n = "05",
  text = "Extract generated key from the software",
  icon = "\128273",
  pri = "MED"
},
  {
  n = "06",
  text = "Return and submit key for authentication",
  icon = "\128737\65039",
  pri = "LOW"
}
}
for v124, v125 in ipairs(v60) do
  local v126 = v15("Frame", {
    Size = UDim2.new(1, 0, 0, 34),
    BackgroundColor3 = v13.BG_INPUT,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    LayoutOrder = v124,
    ZIndex = 14,
    Parent = v59
  })
  v16(v126, 3)
  local v127 = v15("Frame", {
    Size = UDim2.new(0, 28, 0, 24),
    Position = UDim2.new(0, 6, 0.5, -12),
    BackgroundColor3 = v13.RED_DIM,
    BackgroundTransparency = 0,
    BorderSizePixel = 0,
    ZIndex = 15,
    Parent = v126
  })
  v16(v127, 3)
  v15("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = v125.n,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextColor3 = v13.RED_GLOW,
    ZIndex = 16,
    Parent = v127
  })
  v15("TextLabel", {
    Size = UDim2.new(0, 20, 1, 0),
    Position = UDim2.new(0, 40, 0, 0),
    BackgroundTransparency = 1,
    Text = v125.icon,
    TextSize = 13,
    Font = Enum.Font.Code,
    ZIndex = 15,
    Parent = v126
  })
  v15("TextLabel", {
    Size = UDim2.new(1, -110, 1, 0),
    Position = UDim2.new(0, 62, 0, 0),
    BackgroundTransparency = 1,
    Text = v125.text,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextColor3 = v13.TEXT_BRIGHT,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextWrapped = true,
    ZIndex = 15,
    Parent = v126
  })
  local v128 = ((v125.pri == "HIGH") and v13.RED_PRIMARY) or ((v125.pri == "MED") and v13.AMBER) or v13.GREEN_OK
  local v129 = v15("Frame", {
    Size = UDim2.new(0, 34, 0, 16),
    Position = UDim2.new(1, -42, 0.5, -8),
    BackgroundColor3 = v128,
    BackgroundTransparency = 0.8,
    BorderSizePixel = 0,
    ZIndex = 15,
    Parent = v126
  })
  v16(v129, 3)
  v15("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = v125.pri,
    TextSize = 7,
    Font = Enum.Font.Code,
    TextColor3 = v128,
    ZIndex = 16,
    Parent = v129
  })
end
local v61 = v15("TextButton", {
  Name = "CopyBtn",
  Size = UDim2.new(1, 0, 0, 44),
  Position = UDim2.new(0, 0, 0, 292),
  BackgroundColor3 = v13.RED_DIM,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Text = "",
  AutoButtonColor = false,
  ZIndex = 14,
  Parent = v57
})
v16(v61, 4)
local v62 = v17(v61, v13.RED_PRIMARY, 1, 0.3)
local v63 = v15("TextLabel", {
  Name = "Label",
  Size = UDim2.new(1, 0, 1, 0),
  BackgroundTransparency = 1,
  Text = "\128203  COPY LINK",
  TextSize = 14,
  Font = Enum.Font.Code,
  TextColor3 = v13.RED_GLOW,
  ZIndex = 15,
  Parent = v61
})
v61.MouseEnter:Connect(function()
  v14(v61, {BackgroundColor3 = v13.RED_PRIMARY}, 0.15)
  v14(v63, {TextColor3 = v13.WHITE}, 0.15)
end)
v61.MouseLeave:Connect(function()
  local v130 = 0
  while true do
    if (v130 == 0) then
      v14(v61, {BackgroundColor3 = v13.RED_DIM}, 0.15000000000000568)
      v14(v63, {TextColor3 = v13.RED_GLOW}, 0.14999999999997726)
      break
    end
  end
end)
local v64 = v15("TextLabel", {
  Size = UDim2.new(1, 0, 0, 16),
  Position = UDim2.new(0, 0, 0, 340),
  BackgroundTransparency = 1,
  Text = "\10003 LINK COPIED \8212 PROCEED TO BROWSER",
  TextSize = 10,
  Font = Enum.Font.Code,
  TextColor3 = v13.GREEN_OK,
  TextTransparency = 1,
  ZIndex = 14,
  Parent = v57
})
local v65 = v15("TextButton", {
  Name = "Back",
  Size = UDim2.new(1, 0, 0, 36),
  Position = UDim2.new(0, 0, 0, 362),
  BackgroundColor3 = v13.BG_SURFACE,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  Text = "\8592 RETURN TO AUTH SCREEN",
  TextSize = 11,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_MID,
  AutoButtonColor = false,
  ZIndex = 14,
  Parent = v57
})
v16(v65, 4)
v17(v65, v13.BORDER, 1, 0.4)
v65.MouseEnter:Connect(function()
  v14(v65, {BackgroundColor3 = v13.BG_HOVER, TextColor3 = v13.TEXT_BRIGHT}, 0.14999999999997726)
end)
v65.MouseLeave:Connect(function()
  v14(v65, {BackgroundColor3 = v13.BG_SURFACE, TextColor3 = v13.TEXT_MID}, 0.15)
end)
local v66 = v15("Frame", {
  Name = "P3",
  Size = UDim2.new(1, -36, 1, -36),
  Position = UDim2.new(0, 18, 1.2, 0),
  BackgroundTransparency = 1,
  Visible = false,
  ZIndex = 12,
  Parent = v37
})
local v67 = v15("Frame", {
  Size = UDim2.new(1, 0, 0, 60),
  Position = UDim2.new(0, 0, 0, 20),
  BackgroundColor3 = v13.GREEN_DIM,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v66
})
v16(v67, 4)
v17(v67, v13.GREEN_OK, 1, 0.4)
v15("TextLabel", {
  Size = UDim2.new(0, 40, 1, 0),
  Position = UDim2.new(0, 14, 0, 0),
  BackgroundTransparency = 1,
  Text = "\9989",
  TextSize = 28,
  Font = Enum.Font.Code,
  ZIndex = 14,
  Parent = v67
})
v15("TextLabel", {
  Size = UDim2.new(1, -70, 0, 22),
  Position = UDim2.new(0, 56, 0, 10),
  BackgroundTransparency = 1,
  Text = "ACCESS GRANTED",
  TextSize = 16,
  Font = Enum.Font.Code,
  TextColor3 = v13.GREEN_OK,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v67
})
v15("TextLabel", {
  Size = UDim2.new(1, -70, 0, 14),
  Position = UDim2.new(0, 56, 0, 34),
  BackgroundTransparency = 1,
  Text = "Authentication successful \8212 clearance granted",
  TextSize = 10,
  Font = Enum.Font.Code,
  TextColor3 = Color3.fromRGB(30, 140, 60),
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 14,
  Parent = v67
})
local v68 = v15("Frame", {
  Size = UDim2.new(1, 0, 0, 100),
  Position = UDim2.new(0, 0, 0, 92),
  BackgroundColor3 = v13.BG_INPUT,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v66
})
v16(v68, 4)
v17(v68, v13.BORDER, 1, 0.4)
local v69 = v15("TextLabel", {
  Name = "Detail",
  Size = UDim2.new(1, -20, 1, -16),
  Position = UDim2.new(0, 10, 0, 8),
  BackgroundTransparency = 1,
  Text = "",
  TextSize = 11,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_MID,
  TextXAlignment = Enum.TextXAlignment.Left,
  TextYAlignment = Enum.TextYAlignment.Top,
  ZIndex = 14,
  Parent = v68
})
v15("TextLabel", {
  Size = UDim2.new(1, 0, 0, 16),
  Position = UDim2.new(0, 0, 0, 206),
  BackgroundTransparency = 1,
  Text = "\9670 INITIALIZING PAYLOAD",
  TextSize = 10,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 13,
  Parent = v66
})
local v70 = v15("Frame", {
  Size = UDim2.new(1, 0, 0, 6),
  Position = UDim2.new(0, 0, 0, 228),
  BackgroundColor3 = v13.BORDER,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 13,
  Parent = v66
})
v16(v70, 3)
local v71 = v15("Frame", {
  Size = UDim2.new(0, 0, 1, 0),
  BackgroundColor3 = v13.GREEN_OK,
  BackgroundTransparency = 0,
  BorderSizePixel = 0,
  ZIndex = 14,
  Parent = v70
})
v16(v71, 3)
local v72 = v15("TextLabel", {
  Size = UDim2.new(1, 0, 0, 14),
  Position = UDim2.new(0, 0, 0, 240),
  BackgroundTransparency = 1,
  Text = "LOADING...",
  TextSize = 9,
  Font = Enum.Font.Code,
  TextColor3 = v13.TEXT_DIM,
  TextXAlignment = Enum.TextXAlignment.Left,
  ZIndex = 13,
  Parent = v66
})
local v73 = 1
local function v74(v131)
  local v132 = 0
  local v133
  local v134
  local v135
  local v136
  while true do
    if (v132 == 0) then
      v133 = {v38, v57, v66}
      v134 = v133[v73]
      v132 = 1
    end
    if (v132 == 4) then
      task.delay(0.4, function()
        if (v134 and v134.Parent) then
          v134.Visible = false
        end
      end)
      v73 = v131
      break
    end
    if (v132 == 3) then
      v14(v134, {Position = v136}, 0.35, Enum.EasingStyle.Quint)
      v14(v135, {Position = UDim2.new(0, 18, 0, 18)}, 0.35, Enum.EasingStyle.Quint)
      v132 = 4
    end
    if (v132 == 2) then
      if (v131 > v73) then
        v135.Position = UDim2.new(1.2, 0, 0, 18)
      else
        v135.Position = UDim2.new(-1.2, 0, 0, 18)
      end
      v136 = ((v131 > v73) and UDim2.new(-1.2, 0, 0, 18)) or UDim2.new(1.2, 0, 0, 18)
      v132 = 3
    end
    if (v132 == 1) then
      local v176 = 0
      while true do
        if (v176 == 0) then
          v135 = v133[v131]
          v135.Visible = true
          v176 = 1
        end
        if (v176 == 1) then
          v132 = 2
          break
        end
      end
    end
  end
end
v51.MouseButton1Click:Connect(function()
  v74(2)
end)
v65.MouseButton1Click:Connect(function()
  v74(1)
end)
v61.MouseButton1Click:Connect(function()
  pcall(function()
    if setclipboard then
      setclipboard(v8.KEY_LINK)
    elseif toclipboard then
      toclipboard(v8.KEY_LINK)
    end
  end)
  v63.Text = "\10003  LINK COPIED"
  v14(v64, {TextTransparency = 0}, 0.15)
  task.delay(2.5, function()
    if (v63 and v63.Parent) then
      local v177 = 0
      while true do
        if (0 == v177) then
          v63.Text = "\128203  COPY LINK"
          v14(v64, {TextTransparency = 1}, 0.40000000000009095)
          break
        end
      end
    end
  end)
end)
v49.MouseButton1Click:Connect(function()
  local v138 = v46.Text:gsub("^%s+", ""):gsub("%s+$", "")
  if (v138 == "") then
    local v159 = 0
    local v160
    while true do
      if (v159 == 2) then
        return
      end
      if (0 == v159) then
        v48("\9650 NO INPUT \8212 Enter an access key", v13.AMBER, 3)
        v160 = v44.Position
        v159 = 1
      end
      if (v159 == 1) then
        for v201 = 1, 5 do
          v14(v44, {Position = v160 + UDim2.new(0, 5 * ((((v201 % 2) == 0) and 1) or -1), 0, 0)}, 0.040000000000020464)
          task.wait(0.03999999999996362)
        end
        v14(v44, {Position = v160}, 0.04)
        v159 = 2
      end
    end
  end
  v48("\9670 VERIFYING \8212 Contacting auth server...", v13.AMBER)
  v53.Visible = true
  v54.Size = UDim2.new(0, 0, 1, 0)
  v54.BackgroundColor3 = v13.RED_PRIMARY
  v14(v54, {Size = UDim2.new(0.7, 0, 1, 0)}, 1.2, Enum.EasingStyle.Quad)
  if v42 then
    local v161 = 0
    local v162
    while true do
      if (v161 == 0) then
        v162 = 0
        while true do
          if (v162 == 0) then
            v42.Text = "SCANNING"
            v42.TextColor3 = v13.AMBER
            break
          end
        end
        break
      end
    end
  end
  task.wait(v20(12, 20) / 10)
  local v143 = false
  for v152, v153 in ipairs(v8.VALID_KEYS) do
    if (v138 == v153) then
      v143 = true
      break
    end
  end
  if v143 then
    local v163 = 0
    local v164
    local v165
    local v166
    while true do
      if (v163 == 1) then
        v14(v45, {Color = v13.GREEN_OK}, 0.2)
        v14(v28, {Color = v13.GREEN_OK, Transparency = 0.2}, 0.3)
        if v42 then
          local v212 = 0
          while true do
            if (v212 == 0) then
              v42.Text = "CLEAR"
              v42.TextColor3 = v13.GREEN_OK
              break
            end
          end
        end
        v163 = 2
      end
      if (v163 == 2) then
        local v190 = 0
        while true do
          if (v190 == 1) then
            v74(3)
            v163 = 3
            break
          end
          if (v190 == 0) then
            task.wait(1)
            v53.Visible = false
            v190 = 1
          end
        end
      end
      if (v163 == 6) then
        v14(v27, {Size = UDim2.new(0, 440, 0, 6)}, 0.30000000000001137, Enum.EasingStyle.Quint)
        v14(v28, {Transparency = 1}, 0.25)
        v14(v23, {BackgroundTransparency = 1}, 0.3)
        v163 = 7
      end
      if (v163 == 3) then
        task.wait(0.5)
        v164 = ((#v138 > 8) and (v138:sub(1, 8) .. "\8226\8226\8226\8226\8226\8226\8226\8226")) or v138
        v165 = string.format("OPERATOR:    %s\nKEY:         %s\nTIMESTAMP:   %s\nSESSION:     %s\nCLEARANCE:   LEVEL 5", v12.Name, v164, os.date("%Y-%m-%d %H:%M:%S"), v18(8))
        v163 = 4
      end
      if (5 == v163) then
        v166 = {
          "LOADING MODULES...",
          "DECRYPTING PAYLOAD...",
          "INJECTING...",
          "\9670 COMPLETE"
        }
        for v202, v203 in ipairs(v166) do
          task.wait(0.6)
          if (v72 and v72.Parent) then
            v72.Text = v203
            if (v202 == #v166) then
              v72.TextColor3 = v13.GREEN_OK
            end
          end
        end
        task.wait(1.5)
        v163 = 6
      end
      if (v163 == 7) then
        task.wait(0.4)
        v21:Destroy()
        v8.CALLBACK_ON_SUCCESS()
        break
      end
      if (v163 == 4) then
        v19(v69, v165, 0.012, v13.TEXT_MID)
        task.wait(0.4)
        v14(v71, {Size = UDim2.new(1, 0, 1, 0)}, 2.5, Enum.EasingStyle.Quad)
        v163 = 5
      end
      if (v163 == 0) then
        v14(v54, {Size = UDim2.new(1, 0, 1, 0)}, 0.3)
        v54.BackgroundColor3 = v13.GREEN_OK
        v48("\10003 KEY VERIFIED \8212 Access granted", v13.GREEN_OK)
        v163 = 1
      end
    end
  else
    local v167 = 0
    local v168
    while true do
      if (v167 == 2) then
        v14(v44, {Position = v168}, 0.04)
        task.wait(2)
        v14(v45, {Color = v13.BORDER}, 0.3)
        v14(v28, {Color = v13.RED_PRIMARY, Transparency = 0.5}, 0.5)
        v167 = 3
      end
      if (v167 == 0) then
        v14(v54, {Size = UDim2.new(1, 0, 1, 0)}, 0.19999999999998863)
        v54.BackgroundColor3 = v13.RED_GLOW
        v48("\10005 INVALID KEY \8212 Access denied", v13.RED_GLOW, 4)
        v14(v45, {Color = v13.RED_PRIMARY}, 0.15000000000000568)
        v167 = 1
      end
      if (v167 == 3) then
        v53.Visible = false
        if v42 then
          local v213 = 0
          local v214
          while true do
            if (v213 == 0) then
              v214 = 0
              while true do
                if (0 == v214) then
                  v42.Text = "ELEVATED"
                  v42.TextColor3 = v13.AMBER
                  break
                end
              end
              break
            end
          end
        end
        break
      end
      if (v167 == 1) then
        v14(v28, {Color = v13.RED_GLOW, Transparency = 0.20000000000004547}, 0.15000000000009095)
        if v42 then
          local v215 = 0
          while true do
            if (v215 == 0) then
              v42.Text = "ALERT"
              v42.TextColor3 = v13.RED_GLOW
              break
            end
          end
        end
        v168 = v44.Position
        for v204 = 1, 6 do
          local v205 = 0
          while true do
            if (v205 == 0) then
              v14(v44, {Position = v168 + UDim2.new(0, 7 * ((((v204 % 2) == 0) and 1) or -1), 0, 0)}, 0.04)
              task.wait(0.04)
              break
            end
          end
        end
        v167 = 2
      end
    end
  end
end)
task.spawn(function()
  local v144 = 0
  while true do
    if (v144 == 0) then
      v27.BackgroundTransparency = 0
      v27.Size = UDim2.new(0, 440, 0, 4)
      v144 = 1
    end
    if (v144 == 4) then
      v14(v28, {Transparency = 0.5}, 0.2999999999999545)
      break
    end
    if (v144 == 3) then
      v14(v27, {Size = UDim2.new(0, 440, 0, 500), Position = UDim2.new(0.5, -220, 0.5, -250)}, 0.45, Enum.EasingStyle.Quint)
      task.wait(0.15)
      v144 = 4
    end
    if (2 == v144) then
      v14(v28, {Color = v13.RED_GLOW, Transparency = 0}, 0.1)
      task.wait(0.1)
      v144 = 3
    end
    if (v144 == 1) then
      v27.Position = UDim2.new(0.5, -220, 0.5, -2)
      task.wait(0.15)
      v144 = 2
    end
  end
end)
task.spawn(function()
  while v21 and v21.Parent do
    v14(v28, {Transparency = 0.35}, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    task.wait(2)
    v14(v28, {Transparency = 0.7000000000000455}, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    task.wait(2)
  end
end)
task.spawn(function()
  while v21 and v21.Parent do
    local v154 = 0
    while true do
      if (v154 == 0) then
        v21.DisplayOrder = 999
        task.wait(2)
        break
      end
    end
  end
end)
print("[PHANTOM] v1.0 Key system loaded | CoreGui | DisplayOrder 999")
