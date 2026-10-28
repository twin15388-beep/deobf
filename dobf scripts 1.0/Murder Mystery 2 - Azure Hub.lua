local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")
local localPlayer = players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

for index, value in ipairs({ "AzureHubMM2" }) do
  local findFirstChild = playerGui:FindFirstChild(value)

  if findFirstChild then
    findFirstChild:Destroy()
  end
end

local v1 = true
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local v6 = false
local count = 0
local v7 = false
local count2 = 0

local v8 = {
  Noclip = false,
  Speed = 16,
  Jump = 50,
  AllESP = false,
  MurderESP = false,
  SheriffESP = false,
  InnocentESP = false,
  Distance = false,
  DropGunESP = false,
  AutoKillMurder = false,
  AutoPickGun = false,
}

local v9 = {
  BG = Color3.fromRGB(13, 7, 26),
  Sidebar = Color3.fromRGB(22, 11, 41),
  Card = Color3.fromRGB(36, 18, 65),
  Purple = Color3.fromRGB(125, 40, 255),
  Magenta = Color3.fromRGB(222, 43, 255),
  Border = Color3.fromRGB(95, 47, 151),
  White = Color3.fromRGB(250, 243, 255),
  Gray = Color3.fromRGB(178, 156, 205),
}

local function f1()
  for index2, value2 in ipairs(workspace:GetDescendants()) do
    local lower = value2.Name:lower()

    if lower == "dropgun" or lower == "gundrop" then
      local basePart = value2:IsA("BasePart") and value2

      local findFirstChildWhichIsA = basePart
      findFirstChildWhichIsA = basePart or value2:FindFirstChildWhichIsA("BasePart", true)

      if findFirstChildWhichIsA then
        return value2, findFirstChildWhichIsA
      end
    end
  end
end

local function f2(p1)
  if not p1 and (v8.Noclip or v6) then
    return
  end

  for key, value3 in pairs(v5) do
    if key.Parent then
      key.CanCollide = value3
    end

    v5[key] = nil
  end
end

local function f3(p2, p3, p4)
  local v10 = false
  local v11 = false
  p3.Active = true
  local inputBegan = p3.InputBegan
  local v12, position, position2

  table.insert(v2, inputBegan:Connect(function(p5)
    if p5.UserInputType ~= Enum.UserInputType.Touch
      and p5.UserInputType ~= Enum.UserInputType.MouseButton1 then
      return
    end

    v10 = true
    v12 = p5
    position = p5.Position
    position2 = p2.Position
    v11 = false
  end))

  local inputChanged = userInputService.InputChanged

  table.insert(v2, inputChanged:Connect(function(p6)
    if not v10 then
      return
    end

    if p6 ~= v12
      and not (v12 and v12.UserInputType == Enum.UserInputType.MouseButton1
        and p6.UserInputType == Enum.UserInputType.MouseMovement) then
      return
    else
      local v13 = p6.Position - position

      if v13.Magnitude > 8 then
        v11 = true
      end

      if v11 then
        p2.Position = UDim2.new(
          position2.X.Scale, position2.X.Offset + v13.X, position2.Y.Scale,
          position2.Y.Offset + v13.Y
        )
      end

      return
    end
  end))

  local inputEnded = userInputService.InputEnded

  table.insert(v2, inputEnded:Connect(function(p7)
    if not v10 or p7 ~= v12 then
      return
    end

    v10 = false

    if not v11 and p4 then
      p4()
    end
  end))
end

local function f4()
  local character = localPlayer.Character

  if not character then
    return
  end

  for index3, value4 in ipairs(character:GetDescendants()) do
    if value4:IsA("BasePart") then
      if v5[value4] == nil then
        v5[value4] = value4.CanCollide
      end

      value4.CanCollide = false
    end
  end
end

local arcade = Enum.Font.Arcade

local function f5(p8)
  local character2 = (p8 or localPlayer).Character
  return character2 and character2:FindFirstChild("HumanoidRootPart")
end

local f6

local function f7(p9, p10)
  f6("UICorner", { CornerRadius = UDim.new(0, p10 or 10) }, p9)
end

local function f8(p11, p12, p13)
  local create = tweenService:Create(p11, TweenInfo.new(
    p13 or 0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out
  ), p12)

  create:Play()
  return create
end

local function f9()
  local character3 = localPlayer.Character
  return character3 and character3:FindFirstChildOfClass("Humanoid")
end

function f6(p14, p15, parent)
  local instance = Instance.new(p14)

  for key2, value5 in pairs(p15 or {}) do
    instance[key2] = value5
  end

  instance.Parent = parent
  return instance
end

local function f10(p16, p17, p18)
  f6("UIStroke", { Color = p17 or v9.Border, Thickness = p18 or 1.2 }, p16)
end

local function f11(p19, p20)
  local character4 = p19.Character
  local backpack = p19:FindFirstChild("Backpack")

  return character4 and character4:FindFirstChild(p20)
    or backpack and backpack:FindFirstChild(p20)
end

local function f12(p21, text, p22, p23)
  return f6("TextLabel", {
    BackgroundTransparency = 1,
    Text = text,
    TextColor3 = p23 or v9.White,
    Font = arcade,
    TextSize = p22 or 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
  }, p21)
end

local function f13(p24)
  if f11(p24, "Knife") then
    return "Murderer"
  end

  if f11(p24, "Gun") then
    return "Sheriff"
  end

  return "Innocent"
end

local function f14(p25)
  for index4, value6 in ipairs(players:GetPlayers()) do
    if value6 ~= localPlayer and f13(value6) == p25 and f5(value6) then
      return value6
    end
  end
end

local v14 = {
  Murderer = Color3.fromRGB(255, 55, 80),
  Sheriff = Color3.fromRGB(45, 155, 255),
  Innocent = Color3.fromRGB(55, 255, 120),
}

local function f15(p26)
  local v15 = v3[p26]

  if v15 then
    if v15.h then
      v15.h:Destroy()
    end

    if v15.b then
      v15.b:Destroy()
    end
  end

  v3[p26] = nil
end

local function f16(p27)
  local gsub = p27:lower():gsub("[^%w]", "")

  return gsub == "coin" or gsub:find("coinserver", 1, true) ~= nil
    or gsub:match("^coin%d+$") ~= nil
end

local function f17()
  for index5, value7 in ipairs(players:GetPlayers()) do
    if value7 ~= localPlayer then
      local character5 = value7.Character
      local v16 = f5(value7)
      local v17 = f13(value7)

      if not (v8.AllESP or v17 == "Murderer" and v8.MurderESP or v17 == "Sheriff" and v8.SheriffESP
          or v17 == "Innocent" and v8.InnocentESP)
        or not character5
        or not v16 then
        f15(value7)
      else
        local v18 = v3[value7]

        if not v18 or v18.character ~= character5 or v18.role ~= v17 or not v18.h.Parent then
          f15(value7)

          local h = f6("Highlight", {
            Adornee = character5,
            DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
            FillColor = v14[v17],
            FillTransparency = 0.5,
            OutlineColor = v9.White,
          }, character5)

          local v19 = f6("BillboardGui", {
            Adornee = v16,
            Size = UDim2.fromOffset(240, 45),
            StudsOffset = Vector3.new(0, 3, 0),
            AlwaysOnTop = true,
          }, v16)

          local v20 = f6("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = value7.DisplayName,
            TextColor3 = v14[v17],
            TextStrokeTransparency = 0,
            TextScaled = true,
            Font = arcade,
          }, v19)

          f6("UITextSizeConstraint", { MaxTextSize = 18, MinTextSize = 9 }, v20)

          v18 = {
            character = character5,
            role = v17,
            h = h,
            b = v19,
            label = v20,
          }

          v3[value7] = v18
        end

        local v21 = f5()

        local label = v18.label

        label.Text = value7.DisplayName
          .. (v8.Distance and v21
              and " [" .. math.floor((v21.Position - v16.Position).Magnitude) .. "]"
            or "")
      end
    end
  end
end

local f18

local function f19()
  if not v8.DropGunESP then
    for key3 in pairs(v4) do
      f18(key3)
    end

    return
  else
    local v22, v23 = f1()

    for key4 in pairs(v4) do
      if key4 ~= v22 then
        f18(key4)
      end
    end

    if not v22 or not v23 then
      return
    else
      local v24 = v4[v22]

      if not v24 or not v24.h.Parent then
        local color = Color3.fromRGB(255, 220, 40)

        local h2 = f6("Highlight", {
          Adornee = v22,
          DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
          FillColor = color,
          FillTransparency = 0.25,
          OutlineColor = v9.White,
        }, v22)

        local v25 = f6("BillboardGui", {
          Adornee = v23,
          Size = UDim2.fromOffset(240, 45),
          StudsOffset = Vector3.new(0, 2.5, 0),
          AlwaysOnTop = true,
        }, v23)

        v24 = {
          h = h2,
          b = v25,
          label = f6("TextLabel", {
            Size = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Text = "DROP GUN",
            TextColor3 = Color3.fromRGB(255, 230, 40),
            TextStrokeTransparency = 0,
            TextScaled = true,
            Font = arcade,
          }, v25),
        }

        v4[v22] = v24
      end

      local v26 = f5()

      local label2 = v24.label

      label2.Text = "DROP GUN"
        .. (v8.Distance and v26
            and " [" .. math.floor((v26.Position - v23.Position).Magnitude) .. "]"
          or "")

      return
    end
  end
end

function f18(p28)
  local v27 = v4[p28]

  if v27 then
    if v27.h then
      v27.h:Destroy()
    end

    if v27.b then
      v27.b:Destroy()
    end
  end

  v4[p28] = nil
end

local function f20(p29)
  local v28 = {}
  local v29 = {}

  local function f21(p30)
    if p30 and p30:IsA("BasePart") and p30:IsDescendantOf(workspace) and not p29[p30]
      and not v29[p30] then
      v29[p30] = true
      table.insert(v28, p30)
    end
  end

  for index6, value8 in ipairs(workspace:GetDescendants()) do
    if f16(value8.Name) then
      if value8:IsA("BasePart") then
        f21(value8)
      elseif value8:IsA("Model") or value8:IsA("Folder") then
        for index7, value9 in ipairs(value8:GetDescendants()) do
          if value9:IsA("BasePart") then
            local model = value9:FindFirstAncestorOfClass("Model")

            if not model or model == value8 or f16(model.Name) or value8:IsA("Folder") then
              f21(value9)
            end
          end
        end
      end
    end
  end

  local v30 = f5()

  if v30 then
    table.sort(v28, function(p31, p32)
      return (p31.Position - v30.Position).Magnitude < (p32.Position - v30.Position).Magnitude
    end)
  end

  return v28
end

local v31

local function f22()
  local v32 = v31 or not v1

  local v33, v34, f23, v35, v36, f24, v37, v38, v39, v40, v41, v42, v43, f25, f26, f27, v44,
    f28, f29, f30, v45, v46, v47, f31, f32, v48, v49

  if v32 then
    return
  else
    v31 = f6("ScreenGui", {
      Name = "AzureHubMM2",
      ResetOnSpawn = false,
      IgnoreGuiInset = true,
      DisplayOrder = 25,
    }, playerGui)

    v33 = f6("TextLabel", {
      AnchorPoint = Vector2.new(0.5, 0),
      Position = UDim2.new(0.5, 0, 0, -60),
      Size = UDim2.fromOffset(320, 44),
      BackgroundColor3 = v9.Card,
      Text = "",
      TextColor3 = v9.White,
      TextSize = 12,
      Font = arcade,
      ZIndex = 100,
    }, v31)

    f7(v33)
    f10(v33, v9.Magenta)
    v34 = 0

    function f23(text2)
      if not v1 then
        return
      end

      v34 = v34 + 1
      local v50 = v34
      v33.Text = text2
      f8(v33, { Position = UDim2.new(0.5, 0, 0, 20) })

      task.delay(2.5, function()
        if v1 and v50 == v34 then
          f8(v33, { Position = UDim2.new(0.5, 0, 0, -60) })
        end
      end)
    end

    local v51 = f6("ImageButton", {
      Position = UDim2.new(0, 18, 0.5, -29),
      Size = UDim2.fromOffset(58, 58),
      BackgroundColor3 = v9.Sidebar,
      Image = "rbxassetid://137968665357729",
      ScaleType = Enum.ScaleType.Fit,
      AutoButtonColor = false,
      ZIndex = 30,
    }, v31)

    f7(v51, 15)
    f10(v51, v9.Magenta, 2)

    v35 = f6("Frame", {
      AnchorPoint = Vector2.new(0.5, 0.5),
      Position = UDim2.fromScale(0.5, 0.5),
      Size = UDim2.fromOffset(760, 475),
      BackgroundColor3 = v9.BG,
      BorderSizePixel = 0,
      ClipsDescendants = true,
      Active = true,
      Visible = false,
    }, v31)

    f7(v35, 15)
    f10(v35)
    v36 = f6("UIScale", { Scale = 1 }, v35)

    function f24()
      local currentCamera = workspace.CurrentCamera

      if not currentCamera then
        return 1
      else
        local viewportSize = currentCamera.ViewportSize

        return math.min(
          1, math.max(0.2, (viewportSize.X - 20) / 760),
          math.max(0.2, (viewportSize.Y - 20) / 475)
        )
      end
    end

    v37 = false
    v38 = false

    local function f33()
      if v38 then
        return
      end

      v38 = true

      if not v37 then
        v37 = true
        v35.Visible = true
        v36.Scale = f24() * 0.85
        f8(v36, { Scale = f24() }, 0.25).Completed:Wait()
      else
        v37 = false
        f8(v36, { Scale = f24() * 0.85 }, 0.18).Completed:Wait()

        if v1 then
          v35.Visible = false
        end
      end

      v38 = false
    end

    f3(v51, v51, f33)

    local v52 = f6("Frame", {
      Size = UDim2.new(0, 220, 1, 0),
      BackgroundColor3 = v9.Sidebar,
      BorderSizePixel = 0,
    }, v35)

    local v53 = f6("ImageLabel", {
      Position = UDim2.fromOffset(13, 14),
      Size = UDim2.fromOffset(51, 51),
      BackgroundColor3 = v9.Card,
      Image = "rbxassetid://137968665357729",
      ScaleType = Enum.ScaleType.Fit,
    }, v52)

    f7(v53, 12)
    f10(v53, v9.Magenta)

    local v54 = f12(v52, "AZURE HUB", 21)
    v54.Position = UDim2.fromOffset(74, 24)
    v54.Size = UDim2.fromOffset(140, 31)

    local v55 = f6("ScrollingFrame", {
      Position = UDim2.fromOffset(10, 94),
      Size = UDim2.new(1, -20, 1, -205),
      BackgroundTransparency = 1,
      BorderSizePixel = 0,
      ScrollBarThickness = 2,
      ScrollBarImageColor3 = v9.Magenta,
      CanvasSize = UDim2.fromScale(0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, v52)

    f6(
      "UIListLayout", { Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder }, v55
    )

    local v56 = f6("Frame", {
      Position = UDim2.new(0, 10, 1, -101),
      Size = UDim2.new(1, -20, 0, 90),
      BackgroundColor3 = v9.Card,
    }, v52)

    f7(v56, 12)
    f10(v56)

    v39 = f6("ImageLabel", {
      Position = UDim2.fromOffset(10, 15),
      Size = UDim2.fromOffset(58, 58),
      BackgroundColor3 = v9.Purple,
      Image = "",
      ScaleType = Enum.ScaleType.Crop,
    }, v56)

    f7(v39, 30)
    f10(v39, v9.Magenta, 2)

    task.spawn(function()
      local v57, image = pcall(function()
        return players:GetUserThumbnailAsync(
          localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420
        )
      end)

      if v57 and v1 then
        v39.Image = image
      end
    end)

    local v58 = f12(v56, localPlayer.DisplayName, 16)
    v58.Position = UDim2.fromOffset(79, 17)
    v58.Size = UDim2.new(1, -87, 0, 27)
    v58.TextScaled = true

    f6("UITextSizeConstraint", { MaxTextSize = 17, MinTextSize = 9 }, v58)

    local v59 = f12(v56, "@" .. localPlayer.Name, 11, v9.Magenta)
    v59.Position = UDim2.fromOffset(79, 51)
    v59.Size = UDim2.new(1, -87, 0, 20)

    local v60 = f6("Frame", {
      Position = UDim2.fromOffset(220, 0),
      Size = UDim2.new(1, -220, 1, 0),
      BackgroundTransparency = 1,
    }, v35)

    local v61 = f6(
      "Frame", { Size = UDim2.new(1, 0, 0, 68), BackgroundTransparency = 1, Active = true }, v60
    )

    f3(v35, v61)

    v40 = f12(v61, "Main", 23)
    v40.Position = UDim2.fromOffset(22, 9)
    v40.Size = UDim2.new(1, -110, 0, 32)

    local v62 = f12(v61, "azure hub", 12, v9.Gray)
    v62.Position = UDim2.fromOffset(23, 43)
    v62.Size = UDim2.new(1, -110, 0, 19)

    local v63 = f6("TextButton", {
      Position = UDim2.new(1, -47, 0, 17),
      Size = UDim2.fromOffset(33, 33),
      BackgroundColor3 = v9.Card,
      Text = "X",
      TextColor3 = v9.White,
      TextSize = 17,
      Font = arcade,
    }, v61)

    f7(v63, 9)
    v63.MouseButton1Click:Connect(f33)
    v41 = { "Main", "ESP", "Innocent", "Sheriff", "Murder", "Teleport", "Azure Team" }
    v42 = {}
    v43 = {}

    for index8, value10 in ipairs(v41) do
      local v64 = f6("ScrollingFrame", {
        Name = value10,
        Position = UDim2.fromOffset(0, 68),
        Size = UDim2.new(1, 0, 1, -68),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = v9.Magenta,
        CanvasSize = UDim2.fromScale(0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Visible = index8 == 1,
      }, v60)

      f6("UIPadding", {
        PaddingTop = UDim.new(0, 17),
        PaddingLeft = UDim.new(0, 18),
        PaddingRight = UDim.new(0, 18),
        PaddingBottom = UDim.new(0, 20),
      }, v64)

      f6(
        "UIListLayout", { Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder },
        v64
      )

      v42[index8] = v64
    end

    function f25(p33)
      for index9, value11 in ipairs(v42) do
        local v65 = index9 == p33
        value11.Visible = v65

        f8(v43[index9], {
          BackgroundColor3 = v65 and v9.Purple or v9.Sidebar,
          TextColor3 = v65 and v9.White or v9.Gray,
        })
      end

      v40.Text = v41[p33]
    end

    for index10, value12 in ipairs(v41) do
      local v66 = index10

      local v67 = f6("TextButton", {
        Size = UDim2.new(1, -5, 0, 38),
        BackgroundColor3 = v9.Sidebar,
        Text = value12,
        TextColor3 = v9.Gray,
        TextSize = 14,
        Font = arcade,
        LayoutOrder = v66,
        AutoButtonColor = false,
      }, v55)

      f7(v67, 9)
      v43[v66] = v67
      v67.MouseButton1Click:Connect(function() f25(v66) end)
    end

    f25(1)

    function f26(p34, p35)
      local v68 = f6("Frame", {
        Size = UDim2.new(1, 0, 0, p35 or 75),
        BackgroundColor3 = v9.Card,
        BorderSizePixel = 0,
      }, p34)

      f7(v68)
      f10(v68)
      return v68
    end

    function f27(p36, p37, p38)
      local v69 = f12(p36, p37, 15)
      v69.Position = UDim2.fromOffset(17, 11)
      v69.Size = UDim2.new(1, -115, 0, 27)

      local v70 = f12(p36, p38 or "", 11, v9.Gray)
      v70.Position = UDim2.fromOffset(18, 42)
      v70.Size = UDim2.new(1, -115, 0, 19)
    end

    local function f34(p39, p40, p41, p42)
      local v71 = f26(p39)
      f27(v71, p40, p41)

      local v72 = f12(v71, ">", 22, v9.Magenta)
      v72.Position = UDim2.new(1, -43, 0, 22)
      v72.Size = UDim2.fromOffset(25, 30)

      f6("TextButton", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
      }, v71).MouseButton1Click:Connect(function()
        f8(v71, { BackgroundColor3 = v9.Purple }, 0.12)

        task.delay(0.2, function()
          if v1 and v71.Parent then
            f8(v71, { BackgroundColor3 = v9.Card })
          end
        end)

        task.spawn(p42)
      end)

      return v71
    end

    local function f35(p43, p44, p45, p46, p47)
      local v73 = f26(p43, 73)
      f27(v73, p44, p45)

      local v74 = f6("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -17, 0.5, 0),
        Size = UDim2.fromOffset(51, 28),
        BackgroundColor3 = v9.Border,
        Text = "",
        AutoButtonColor = false,
      }, v73)

      f7(v74, 15)

      local v75 = f6("Frame", {
        Position = UDim2.fromOffset(4, 4),
        Size = UDim2.fromOffset(20, 20),
        BackgroundColor3 = v9.White,
      }, v74)

      f7(v75, 11)

      local function f36()
        f8(v74, { BackgroundColor3 = v8[p46] and v9.Purple or v9.Border })
        f8(v75, { Position = v8[p46] and UDim2.fromOffset(27, 4) or UDim2.fromOffset(4, 4) })
      end

      v74.MouseButton1Click:Connect(function()
        v8[p46] = not v8[p46]
        f36()

        if p47 then
          p47(v8[p46])
        end
      end)

      f36()
    end

    local function f37(p48, p49, p50, p51, p52, p53, fn)
      local v76 = f26(p48, 105)

      local v77 = f12(v76, p49, 15)
      v77.Position = UDim2.fromOffset(17, 9)
      v77.Size = UDim2.new(1, -100, 0, 24)

      local v78 = f12(v76, p50, 11, v9.Gray)
      v78.Position = UDim2.fromOffset(18, 34)
      v78.Size = UDim2.new(1, -100, 0, 18)

      local v79 = f12(v76, tostring(p53), 17, v9.Magenta)
      v79.Position = UDim2.new(1, -78, 0, 13)
      v79.Size = UDim2.fromOffset(60, 25)
      v79.TextXAlignment = Enum.TextXAlignment.Right

      local v80 = f6("Frame", {
        Position = UDim2.new(0, 18, 1, -28),
        Size = UDim2.new(1, -36, 0, 8),
        BackgroundColor3 = v9.Border,
        Active = true,
      }, v76)

      f7(v80, 5)
      local v81 = (p53 - p51) / (p52 - p51)

      local v82 = f6(
        "Frame", { Size = UDim2.fromScale(v81, 1), BackgroundColor3 = v9.Purple }, v80
      )

      f7(v82, 5)

      local v83 = f6("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(v81, 0.5),
        Size = UDim2.fromOffset(19, 19),
        BackgroundColor3 = v9.Magenta,
      }, v80)

      f7(v83, 10)
      local v84 = false

      local function f38(p54)
        local v85 = math.max(v80.AbsoluteSize.X, 1)
        local v86 = math.clamp((p54 - v80.AbsolutePosition.X) / v85, 0, 1)
        local v87 = math.floor(p51 + (p52 - p51) * v86 + 0.5)
        local v88 = (v87 - p51) / (p52 - p51)
        v82.Size = UDim2.fromScale(v88, 1)
        v83.Position = UDim2.fromScale(v88, 0.5)
        v79.Text = tostring(v87)
        fn(v87)
      end

      local v89

      v80.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
          or input.UserInputType == Enum.UserInputType.Touch then
          v84 = true
          v89 = input
          f38(input.Position.X)
        end
      end)

      local inputChanged2 = userInputService.InputChanged

      table.insert(v2, inputChanged2:Connect(function(p55)
        if v84
          and v89
          and (p55 == v89
            or v89.UserInputType == Enum.UserInputType.MouseButton1
              and p55.UserInputType == Enum.UserInputType.MouseMovement) then
          f38(p55.Position.X)
        end
      end))

      local inputEnded2 = userInputService.InputEnded

      table.insert(v2, inputEnded2:Connect(function(p56)
        if p56 == v89 then
          v84 = false
          v89 = nil
        end
      end))
    end

    f35(v42[1], "Noclip", "Atravessar paredes", "Noclip", function(p57)
      if not p57 then
        f2()
      end
    end)

    f37(v42[1], "Velocidade", "Velocidade do personagem", 16, 100, 16, function(p58)
      v8.Speed = p58
      local v90 = f9()

      if v90 then
        v90.WalkSpeed = p58
      end
    end)

    f37(v42[1], "Pulo", "Força do pulo", 50, 200, 50, function(p59)
      v8.Jump = p59
      local v91 = f9()

      if v91 then
        v91.UseJumpPower = true
        v91.JumpPower = p59
      end
    end)

    f35(v42[2], "ESP Todos", "Destacar todos os jogadores", "AllESP", f17)
    f35(v42[2], "Murder ESP", "Destacar Murderer", "MurderESP", f17)
    f35(v42[2], "Sheriff ESP", "Destacar Sheriff", "SheriffESP", f17)
    f35(v42[2], "Innocent ESP", "Destacar Innocents", "InnocentESP", f17)

    f35(v42[2], "Mostrar Distância", "Distância dos jogadores", "Distance", function()
      f17()
      f19()
    end)

    f35(v42[2], "DropGun ESP", "Destacar arma caída", "DropGunESP", f19)

    f34(v42[3], "Pegar Arma", "Ir até a DropGun e voltar", function()
      local v92 = f5()
      local v93, v94 = f1()

      if not v92 or not v94 then
        f23("DropGun não encontrada")
        return
      else
        local cframe = v92.CFrame
        v92.CFrame = v94.CFrame * CFrame.new(0, 2.5, 0)
        task.wait(0.18)

        if v1 and v92.Parent then
          v92.CFrame = cframe
        end

        return
      end
    end)

    f34(v42[3], "Bring Gun", "Trazer a arma até você", function()
      local v95 = f5()
      local v96, v97 = f1()
      local v98

      if not v95 or not v96 then
        f23("DropGun não encontrada")
        return
      else
        local cframe2 = CFrame.new(0, 0, -3)
        v98 = v95.CFrame * cframe2

        if not pcall(function()
          if v96:IsA("Model") then
            v96:PivotTo(v98)
          else
            v97.CFrame = v98
          end
        end) then
          f23("Erro ao mover a arma")
        end

        return
      end
    end)

    f35(v42[3], "Auto Pick Gun", "Vai na DropGun e volta para a posição", "AutoPickGun", function(p60)
      v7 = p60
      count2 = count2 + 1
      local v99 = count2

      if not p60 then
        return
      end

      task.spawn(function()
        while v1 and v7 and count2 == v99 do
          local v100 = f5()
          local v101 = f9()
          local v102, v103 = f1()

          if v100 and v101 and v101.Health > 0 and v103 and v103.Parent then
            local cframe3 = v100.CFrame
            v100.CFrame = v103.CFrame * CFrame.new(0, 2.5, 0)
            task.wait(0.12)

            if v1 and v7 and count2 == v99 and v100.Parent then
              v100.CFrame = cframe3
            end
          end

          task.wait(0.08)
        end
      end)
    end)

    local v104 = f26(v42[3], 75)
    f27(v104, "Coin Farm", "Vai até cada moeda, uma por uma, até 50")

    v44 = f6("TextButton", {
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -15, 0.5, 0),
      Size = UDim2.fromOffset(76, 34),
      BackgroundColor3 = v9.Border,
      Text = "OFF",
      TextColor3 = v9.White,
      Font = arcade,
      TextSize = 13,
      AutoButtonColor = false,
    }, v104)

    f7(v44, 9)

    function f28(p61, p62)
      local total = 0

      while v1 and v6 and count == p62 do
        local v105 = f5()
        local v106 = not v105
        local v107 = f9()

        if v106 or not v107 or v107.Health <= 0 then
          return false
        else
          f4()
          local v108 = p61 - v105.Position
          local magnitude = v108.Magnitude

          if magnitude <= 1.8 then
            v105.CFrame = CFrame.new(p61)
            return true
          else
            local wait = runService.Heartbeat:Wait()
            total = total + wait

            if total > 30 then
              return false
            end

            if not v1 or not v6 or count ~= p62 then
              return false
            else
              local v109 = math.min(65 * math.min(wait, 0.1), magnitude)

              v105.AssemblyLinearVelocity = Vector3.zero
              v105.AssemblyAngularVelocity = Vector3.zero
              v105.CFrame = CFrame.new(v105.Position + v108.Unit * v109)
            end
          end
        end
      end

      return false
    end

    function f29()
      v6 = false
      count = count + 1
      v44.Text = "OFF"
      f8(v44, { BackgroundColor3 = v9.Border })
      local v110 = f5()

      if v110 then
        v110.AssemblyLinearVelocity = Vector3.zero
      end

      f2()
    end

    function f30()
      if v6 then
        return
      end

      v6 = true
      count = count + 1
      local v111 = count
      f5()
      v44.Text = "ON"
      f8(v44, { BackgroundColor3 = v9.Purple })
      f23("Coin Farm: 0/50")

      task.spawn(function()
        local v112 = {}
        local count3 = 0
        local v113 = 0

        while v1 and v6 and count == v111 and count3 < 50 do
          if not f5() then
            task.wait(0.25)
          else
            local v114 = f20(v112)

            if #v114 == 0 then
              v113 = v113 + 1

              if v113 >= 3 then
                v113 = 0
                v112 = {}
              end

              task.wait(0.5)
            else
              v113 = 0
              local v115 = v114[1]

              if not v115 or not v115.Parent then
                if v115 then
                  v112[v115] = true
                end
              elseif f28(v115.Position, v111) then
                task.wait(0.08)
                v112[v115] = true
                count3 = count3 + 1
                f23("Coin Farm: " .. count3 .. "/50")
              else
                v112[v115] = true
              end
            end
          end
        end

        if count3 >= 50 and v1 then
          f23("Coin Farm terminou: 50/50")
        end

        if v6 and count == v111 then
          f29()
        end
      end)
    end

    v44.MouseButton1Click:Connect(function()
      if v6 then
        f29()
        f23("Coin Farm desativado!")
      else
        f30()
      end
    end)

    v45 = f6("TextButton", {
      AnchorPoint = Vector2.new(1, 0.5),
      Position = UDim2.new(1, -18, 0.5, 0),
      Size = UDim2.fromOffset(106, 50),
      BackgroundColor3 = v9.Purple,
      Text = "SHOOT",
      TextColor3 = v9.White,
      Font = arcade,
      TextSize = 19,
      AutoButtonColor = false,
      Visible = false,
      ZIndex = 35,
    }, v31)

    f7(v45, 13)
    f10(v45, v9.Magenta, 2)
    v46 = false

    f3(v45, v45, function()
      local v116 = v46
      local position3, shoot, v117, v118

      if v116 or not v8.AutoKillMurder then
        return
      else
        local character6 = localPlayer.Character
        local gun = character6 and character6:FindFirstChild("Gun")
        shoot = gun and gun:FindFirstChild("Shoot")
        local v119 = not shoot
        local murderer = f14("Murderer")

        if v119 or not shoot:IsA("RemoteEvent") or not murderer then
          f23("Gun ou Murder indisponível")
          return
        else
          local v120 = f5()
          local v121 = f5(murderer)

          if not v120 or not v121 then
            return
          else
            v46 = true
            local handle = gun:FindFirstChild("Handle")
            position3 = handle and handle.Position or v120.Position
            v117 = v121.Position + Vector3.new(0, 1, 0)
            v118 = v117 - position3

            if v118.Magnitude > 0.01 then
              if not pcall(function()
                shoot:FireServer(
                  CFrame.lookAt(position3, v117), CFrame.lookAt(v117, v117 + v118.Unit)
                )
              end) then
                f23("Erro ao disparar")
              end
            end

            task.wait(0.5)
            v46 = false
            return
          end
        end
      end
    end)

    f35(v42[4], "Auto Kill Murder", "Mostrar botão SHOOT", "AutoKillMurder", function(visible)
      v45.Visible = visible
    end)

    v47 = false

    f34(v42[5], "KILL ALL", "Gruda em cada jogador + Knife rápido", function()
      local knife

      if v47 then
        return
      elseif v6 then
        f23("Desative o Coin Farm!")
        return
      else
        local character7 = localPlayer.Character
        local v122 = not character7
        local v123 = f9()
        local v124 = f5()

        if v122 or not v123 or not v124 then
          return
        end

        knife = character7:FindFirstChild("Knife")

        if not knife then
          local backpack2 = localPlayer:FindFirstChild("Backpack")
          knife = backpack2 and backpack2:FindFirstChild("Knife")

          if knife and knife:IsA("Tool") then
            v123:EquipTool(knife)
            task.wait(0.08)
          end
        end

        if not knife or not knife:IsA("Tool") or knife.Parent ~= character7 then
          f23("Equipe a Knife primeiro!")
          return
        else
          v47 = true
          local cframe4 = v124.CFrame

          for index11, value13 in ipairs(players:GetPlayers()) do
            local v125 = value13

            if not v1 then
              break
            elseif v125 ~= localPlayer then
              local v126 = f5(v125)
              local character8 = v125.Character

              local humanoid = character8
              humanoid = character8 and v125.Character:FindFirstChildOfClass("Humanoid")

              if v126 and humanoid and humanoid.Health > 0 then
                for i = 1, 8 do
                  if not v1 or knife.Parent ~= character7 or not v126.Parent
                    or humanoid.Health <= 0 then
                    break
                  else
                    v124.CFrame = v126.CFrame * CFrame.new(0, 0, 1.15)
                    v124.AssemblyLinearVelocity = Vector3.zero
                    v124.AssemblyAngularVelocity = Vector3.zero

                    pcall(function() knife:Activate() end)
                    local azureKillAll = replicatedStorage:FindFirstChild("AzureKillAll")

                    if azureKillAll and azureKillAll:IsA("RemoteEvent") and i == 8 then
                      pcall(function() azureKillAll:FireServer(v125.UserId) end)
                    end

                    task.wait(0.018)
                  end
                end
              end
            end
          end

          if v1 and v124.Parent then
            v124.CFrame = cframe4
            v124.AssemblyLinearVelocity = Vector3.zero
            v124.AssemblyAngularVelocity = Vector3.zero
          end

          v47 = false
          f23("KILL ALL finalizado!")
          return
        end
      end
    end)

    function f31(p63)
      if not p63 or p63 == localPlayer then
        f23("Jogador não encontrado")
        return
      else
        local v127 = f5()
        local v128 = not v127
        local v129 = f5(p63)

        if v128 or not v129 then
          f23("Jogador não disponível")
          return
        end

        v127.CFrame = v129.CFrame * CFrame.new(0, 0, 3)
        return
      end
    end

    function f32()
      local v130 = {}

      for index12, value14 in ipairs(players:GetPlayers()) do
        if value14 ~= localPlayer and f5(value14) then
          table.insert(v130, value14)
        end
      end

      if #v130 == 0 then
        return nil
      end

      return v130[math.random(1, #v130)]
    end

    f34(v42[6], "Teleport Aleatório", "Teleportar para um jogador aleatório", function()
      local v131 = f32()

      if not v131 then
        f23("Nenhum jogador disponível")
        return
      end

      f31(v131)
      f23("Teleportado para " .. v131.DisplayName)
    end)

    f34(v42[6], "Teleport Murder", "Teleportar para o Murder", function()
      local murderer2 = f14("Murderer")

      if not murderer2 then
        f23("Murder não encontrado")
        return
      end

      f31(murderer2)
      f23("Teleportado para o Murder")
    end)

    f34(v42[6], "Teleport Sheriff", "Teleportar para o Sheriff", function()
      local sheriff = f14("Sheriff")

      if not sheriff then
        f23("Sheriff não encontrado")
        return
      end

      f31(sheriff)
      f23("Teleportado para o Sheriff")
    end)

    local v132 = f26(v42[7], 150)

    local v133 = f12(v132, "AZURE TEAM", 20, v9.Magenta)
    v133.Position = UDim2.fromOffset(17, 14)
    v133.Size = UDim2.new(1, -34, 0, 30)
    v133.TextXAlignment = Enum.TextXAlignment.Center

    local v134 = f12(v132, "Lyer / parangokid", 13, v9.White)
    v134.Position = UDim2.fromOffset(17, 48)
    v134.Size = UDim2.new(1, -34, 0, 24)
    v134.TextXAlignment = Enum.TextXAlignment.Center

    local v135 = f12(v132, "Entre no Discord do Azure Hub", 11, v9.Gray)
    v135.Position = UDim2.fromOffset(17, 76)
    v135.Size = UDim2.new(1, -34, 0, 20)
    v135.TextXAlignment = Enum.TextXAlignment.Center

    local v136 = f6("TextButton", {
      AnchorPoint = Vector2.new(0.5, 0),
      Position = UDim2.new(0.5, 0, 0, 105),
      Size = UDim2.fromOffset(210, 32),
      BackgroundColor3 = v9.Purple,
      Text = "COPIAR DISCORD",
      TextColor3 = v9.White,
      TextSize = 12,
      Font = arcade,
      AutoButtonColor = false,
    }, v132)

    f7(v136, 9)
    f10(v136, v9.Magenta)

    v136.MouseButton1Click:Connect(function()
      pcall(function()
        if setclipboard then
          setclipboard("https://discord.gg/GsXa6rRSSk")
        elseif toclipboard then
          toclipboard("https://discord.gg/GsXa6rRSSk")
        end
      end)

      f23("Discord copiado!")
    end)

    v48 = 0
    v49 = 0
    local heartbeat = runService.Heartbeat

    table.insert(v2, heartbeat:Connect(function(p64)
      if not v1 then
        return
      end

      v48 = v48 + p64
      v49 = v49 + p64

      if v48 >= 0.25 then
        v48 = 0

        if v8.AllESP or v8.MurderESP or v8.SheriffESP or v8.InnocentESP then
          f17()
        end
      end

      if v49 >= 0.5 then
        v49 = 0

        if v8.DropGunESP then
          f19()
        end
      end
    end))

    local stepped = runService.Stepped

    table.insert(v2, stepped:Connect(function()
      if not v1 then
        return
      end

      if v8.Noclip or v6 then
        f4()
      elseif next(v5) then
        f2()
      end
    end))

    local characterAdded = localPlayer.CharacterAdded

    table.insert(v2, characterAdded:Connect(function(p65)
      if v6 then
        f29()
      end

      f2(true)
      local waitForChild = p65:WaitForChild("Humanoid", 10)

      if waitForChild and v1 then
        waitForChild.WalkSpeed = v8.Speed
        waitForChild.UseJumpPower = true
        waitForChild.JumpPower = v8.Jump
      end
    end))

    local playerRemoving = players.PlayerRemoving
    table.insert(v2, playerRemoving:Connect(f15))
    local currentCamera2 = workspace.CurrentCamera

    if currentCamera2 then
      local viewportSize2 = currentCamera2:GetPropertyChangedSignal("ViewportSize")

      table.insert(v2, viewportSize2:Connect(function()
        if v1 and v37 then
          v36.Scale = f24()
        end
      end))
    end

    f23("Azure Hub carregado!")
    return
  end
end

f22()

function _G.AzureHubCleanup()
  if not v1 then
    return
  end

  v1 = false
  v6 = false
  count = count + 1
  v7 = false
  count2 = count2 + 1
  f2(true)

  for index13, value15 in ipairs(v2) do
  end

  for key5 in pairs(v3) do
    f15(key5)
  end

  for key6 in pairs(v4) do
    f18(key6)
  end

  if v31 then
    v31:Destroy()
  end
end
