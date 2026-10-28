local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1
L0_1 = game
L1_1 = L0_1
L0_1 = L0_1.GetService
L2_1 = "UserInputService"
L0_1 = L0_1(L1_1, L2_1)
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "TweenService"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = game
L3_1 = L2_1
L2_1 = L2_1.GetService
L4_1 = "RunService"
L2_1 = L2_1(L3_1, L4_1)
L3_1 = game
L4_1 = L3_1
L3_1 = L3_1.GetService
L5_1 = "Players"
L3_1 = L3_1(L4_1, L5_1)
L3_1 = L3_1.LocalPlayer
L5_1 = L3_1
L4_1 = L3_1.GetMouse
L4_1 = L4_1(L5_1)
L5_1 = game
L6_1 = L5_1
L5_1 = L5_1.GetService
L7_1 = "HttpService"
L5_1 = L5_1(L6_1, L7_1)
L6_1 = {}
L7_1 = {}
L6_1.Elements = L7_1
L7_1 = {}
L6_1.ThemeObjects = L7_1
L7_1 = {}
L6_1.Connections = L7_1
L7_1 = {}
L6_1.Flags = L7_1
L7_1 = {}
L8_1 = {}
L9_1 = Color3
L9_1 = L9_1.fromRGB
L10_1 = 24
L11_1 = 27
L12_1 = 40
L9_1 = L9_1(L10_1, L11_1, L12_1)
L8_1.Main = L9_1
L9_1 = Color3
L9_1 = L9_1.fromRGB
L10_1 = 30
L11_1 = 33
L12_1 = 50
L9_1 = L9_1(L10_1, L11_1, L12_1)
L8_1.Second = L9_1
L9_1 = Color3
L9_1 = L9_1.fromRGB
L10_1 = 45
L11_1 = 50
L12_1 = 75
L9_1 = L9_1(L10_1, L11_1, L12_1)
L8_1.Stroke = L9_1
L9_1 = Color3
L9_1 = L9_1.fromRGB
L10_1 = 45
L11_1 = 50
L12_1 = 75
L9_1 = L9_1(L10_1, L11_1, L12_1)
L8_1.Divider = L9_1
L9_1 = Color3
L9_1 = L9_1.fromRGB
L10_1 = 220
L11_1 = 230
L12_1 = 255
L9_1 = L9_1(L10_1, L11_1, L12_1)
L8_1.Text = L9_1
L9_1 = Color3
L9_1 = L9_1.fromRGB
L10_1 = 150
L11_1 = 160
L12_1 = 200
L9_1 = L9_1(L10_1, L11_1, L12_1)
L8_1.TextDark = L9_1
L7_1.Blue = L8_1
L6_1.Themes = L7_1
L6_1.SelectedTheme = "Blue"
L6_1.Folder = nil
L6_1.SaveCfg = false
L7_1 = {}

function L8_1(A0_2)
  local L1_2
  L1_2 = L7_1
  L1_2 = L1_2[A0_2]
  if L1_2 ~= nil then
    L1_2 = L7_1
    L1_2 = L1_2[A0_2]
    return L1_2
  end
  L1_2 = nil
end

L9_1 = Instance
L9_1 = L9_1.new
L10_1 = "ScreenGui"
L9_1 = L9_1(L10_1)
L9_1.Name = "Orion"
L10_1 = syn
if L10_1 then
  L10_1 = syn
  L10_1 = L10_1.protect_gui
  L11_1 = L9_1
  L10_1(L11_1)
  L10_1 = game
  L10_1 = L10_1.CoreGui
  L9_1.Parent = L10_1
else
  L10_1 = gethui
  L10_1 = L10_1()
  if not L10_1 then
    L10_1 = game
    L10_1 = L10_1.CoreGui
  end
  L9_1.Parent = L10_1
end
L10_1 = gethui
if L10_1 then
  L10_1 = ipairs
  L11_1 = gethui
  L11_1 = L11_1()
  L12_1 = L11_1
  L11_1 = L11_1.GetChildren
  L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1 = L11_1(L12_1)
  L10_1, L11_1, L12_1 = L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
  for L13_1, L14_1 in L10_1, L11_1, L12_1 do
    L15_1 = L14_1.Name
    L16_1 = L9_1.Name
    if L15_1 == L16_1 and L14_1 ~= L9_1 then
      L16_1 = L14_1
      L15_1 = L14_1.Destroy
      L15_1(L16_1)
    end
  end
else
  L10_1 = ipairs
  L11_1 = game
  L11_1 = L11_1.CoreGui
  L12_1 = L11_1
  L11_1 = L11_1.GetChildren
  L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1 = L11_1(L12_1)
  L10_1, L11_1, L12_1 = L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
  for L13_1, L14_1 in L10_1, L11_1, L12_1 do
    L15_1 = L14_1.Name
    L16_1 = L9_1.Name
    if L15_1 == L16_1 and L14_1 ~= L9_1 then
      L16_1 = L14_1
      L15_1 = L14_1.Destroy
      L15_1(L16_1)
    end
  end
end

function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = gethui
  if L1_2 then
    L1_2 = L9_1
    L1_2 = L1_2.Parent
    L2_2 = gethui
    L2_2 = L2_2()
    L1_2 = L1_2 == L2_2
    return L1_2
  end
  L1_2 = L9_1
  L1_2 = L1_2.Parent
  L2_2 = game
  L3_2 = L2_2
  L2_2 = L2_2.GetService
  L4_2 = "CoreGui"
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2 == L2_2
end

L6_1.IsRunning = L10_1

function L10_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = L6_1
  L3_2 = L2_2
  L2_2 = L2_2.IsRunning
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    return
  end
  L3_2 = A0_2
  L2_2 = A0_2.Connect
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = L6_1
  L4_2 = L4_2.Connections
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end

L11_1 = task
L11_1 = L11_1.spawn

function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  while true do
    L0_2 = L6_1
    L1_2 = L0_2
    L0_2 = L0_2.IsRunning
    L0_2 = L0_2(L1_2)
    if not L0_2 then
      break
    end
    L0_2 = wait
    L0_2()
  end
  L0_2 = next
  L1_2 = L6_1
  L1_2 = L1_2.Connections
  L2_2 = nil
  for L3_2, L4_2 in L0_2, L1_2, L2_2 do
    L6_2 = L4_2
    L5_2 = L4_2.Disconnect
    L5_2(L6_2)
  end
end

L11_1(L12_1)

function L11_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = pcall
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = false
    L1_3 = nil
    L2_3 = nil
    L3_3 = nil
    L4_3 = A0_2
    L4_3 = L4_3.InputBegan
    L5_3 = L4_3
    L4_3 = L4_3.Connect
    
    function L6_3(A0_4)
      local L1_4, L2_4, L3_4
      L1_4 = A0_4.UserInputType
      L2_4 = Enum
      L2_4 = L2_4.UserInputType
      L2_4 = L2_4.MouseButton1
      if L1_4 ~= L2_4 then
        L1_4 = A0_4.UserInputType
        L2_4 = Enum
        L2_4 = L2_4.UserInputType
        L2_4 = L2_4.Touch
        if L1_4 ~= L2_4 then
          goto lbl_26
        end
      end
      L1_4 = true
      L0_3 = L1_4
      L1_4 = A0_4.Position
      L2_3 = L1_4
      L1_4 = A1_2
      L1_4 = L1_4.Position
      L3_3 = L1_4
      L1_4 = A0_4.Changed
      L2_4 = L1_4
      L1_4 = L1_4.Connect
      
      function L3_4()
        local L0_5, L1_5
        L0_5 = A0_4
        L0_5 = L0_5.UserInputState
        L1_5 = Enum
        L1_5 = L1_5.UserInputState
        L1_5 = L1_5.End
        if L0_5 == L1_5 then
          L0_5 = false
          L0_3 = L0_5
        end
      end
      
      L1_4(L2_4, L3_4)
      ::lbl_26::
    end
    
    L4_3(L5_3, L6_3)
    L4_3 = A0_2
    L4_3 = L4_3.InputChanged
    L5_3 = L4_3
    L4_3 = L4_3.Connect
    
    function L6_3(A0_4)
      local L1_4, L2_4
      L1_4 = A0_4.UserInputType
      L2_4 = Enum
      L2_4 = L2_4.UserInputType
      L2_4 = L2_4.MouseMovement
      if L1_4 ~= L2_4 then
        L1_4 = A0_4.UserInputType
        L2_4 = Enum
        L2_4 = L2_4.UserInputType
        L2_4 = L2_4.Touch
        if L1_4 ~= L2_4 then
          goto lbl_14
        end
      end
      L1_3 = A0_4
      ::lbl_14::
    end
    
    L4_3(L5_3, L6_3)
    L4_3 = L0_1
    L4_3 = L4_3.InputChanged
    L5_3 = L4_3
    L4_3 = L4_3.Connect
    
    function L6_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4
      L1_4 = L1_3
      if A0_4 == L1_4 then
        L1_4 = L0_3
        if L1_4 then
          L1_4 = A0_4.Position
          L2_4 = L2_3
          L1_4 = L1_4 - L2_4
          L2_4 = UDim2
          L2_4 = L2_4.new
          L3_4 = L3_3
          L3_4 = L3_4.X
          L3_4 = L3_4.Scale
          L4_4 = L3_3
          L4_4 = L4_4.X
          L4_4 = L4_4.Offset
          L5_4 = L1_4.X
          L4_4 = L4_4 + L5_4
          L5_4 = L3_3
          L5_4 = L5_4.Y
          L5_4 = L5_4.Scale
          L6_4 = L3_3
          L6_4 = L6_4.Y
          L6_4 = L6_4.Offset
          L7_4 = L1_4.Y
          L6_4 = L6_4 + L7_4
          L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
          L3_4 = L1_1
          L4_4 = L3_4
          L3_4 = L3_4.Create
          L5_4 = A1_2
          L6_4 = TweenInfo
          L6_4 = L6_4.new
          L7_4 = 0.1
          L8_4 = Enum
          L8_4 = L8_4.EasingStyle
          L8_4 = L8_4.Quad
          L9_4 = Enum
          L9_4 = L9_4.EasingDirection
          L9_4 = L9_4.Out
          L6_4 = L6_4(L7_4, L8_4, L9_4)
          L7_4 = {}
          L7_4.Position = L2_4
          L3_4 = L3_4(L4_4, L5_4, L6_4, L7_4)
          L4_4 = L3_4
          L3_4 = L3_4.Play
          L3_4(L4_4)
        end
      end
    end
    
    L4_3(L5_3, L6_3)
  end
  
  L2_2(L3_2)
end

function L12_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = Instance
  L3_2 = L3_2.new
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = next
  L5_2 = A1_2 or L5_2
  if not A1_2 then
    L5_2 = {}
  end
  L6_2 = nil
  for L7_2, L8_2 in L4_2, L5_2, L6_2 do
    L3_2[L7_2] = L8_2
  end
  L4_2 = next
  L5_2 = A2_2 or L5_2
  if not A2_2 then
    L5_2 = {}
  end
  L6_2 = nil
  for L7_2, L8_2 in L4_2, L5_2, L6_2 do
    L8_2.Parent = L3_2
  end
end

function L13_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = L6_1
  L2_2 = L2_2.Elements
  
  function L3_2(...)
    local L0_3, L1_3, L2_3, L3_3
    L1_3 = A1_2
    L2_3, L3_3 = ...
  end
  
  L2_2[A0_2] = L3_2
end

function L14_1(A0_2, ...)
  local L1_2, L2_2, L3_2, L4_2
  L2_2 = L6_1
  L2_2 = L2_2.Elements
  L2_2 = L2_2[A0_2]
  L3_2, L4_2 = ...
  L2_2 = L2_2(L3_2, L4_2)
end

function L15_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = table
  L2_2 = L2_2.foreach
  L3_2 = A1_2
  
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_2
    L2_3[A0_3] = A1_3
  end
  
  L2_2(L3_2, L4_2)
end

function L16_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = table
  L2_2 = L2_2.foreach
  L3_2 = A1_2
  
  function L4_2(A0_3, A1_3)
    local L2_3
    L2_3 = A0_2
    A1_3.Parent = L2_3
  end
  
  L2_2(L3_2, L4_2)
end

function L17_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = math
  L2_2 = L2_2.floor
  L3_2 = A0_2 / A1_2
  L4_2 = math
  L4_2 = L4_2.sign
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L4_2 = L4_2 * 0.5
  L3_2 = L3_2 + L4_2
  L2_2 = L2_2(L3_2)
  L2_2 = L2_2 * A1_2
  if L2_2 < 0 then
    L2_2 = L2_2 + A1_2
  end
end

function L18_1(A0_2)
  local L1_2, L2_2, L3_2
  L2_2 = A0_2
  L1_2 = A0_2.IsA
  L3_2 = "Frame"
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L2_2 = A0_2
    L1_2 = A0_2.IsA
    L3_2 = "TextButton"
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      goto lbl_13
    end
  end
  L1_2 = "BackgroundColor3"
  do return L1_2 end
  ::lbl_13::
  L2_2 = A0_2
  L1_2 = A0_2.IsA
  L3_2 = "ScrollingFrame"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = "ScrollBarImageColor3"
    return L1_2
  end
  L2_2 = A0_2
  L1_2 = A0_2.IsA
  L3_2 = "UIStroke"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = "Color"
    return L1_2
  end
  L2_2 = A0_2
  L1_2 = A0_2.IsA
  L3_2 = "TextLabel"
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L2_2 = A0_2
    L1_2 = A0_2.IsA
    L3_2 = "TextBox"
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      goto lbl_39
    end
  end
  L1_2 = "TextColor3"
  do return L1_2 end
  ::lbl_39::
  L2_2 = A0_2
  L1_2 = A0_2.IsA
  L3_2 = "ImageLabel"
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L2_2 = A0_2
    L1_2 = A0_2.IsA
    L3_2 = "ImageButton"
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      goto lbl_51
    end
  end
  L1_2 = "ImageColor3"
  do return L1_2 end
  ::lbl_51::
end

function L19_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L6_1
  L2_2 = L2_2.ThemeObjects
  L2_2 = L2_2[A1_2]
  if not L2_2 then
    L2_2 = L6_1
    L2_2 = L2_2.ThemeObjects
    L3_2 = {}
    L2_2[A1_2] = L3_2
  end
  L2_2 = table
  L2_2 = L2_2.insert
  L3_2 = L6_1
  L3_2 = L3_2.ThemeObjects
  L3_2 = L3_2[A1_2]
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
  L2_2 = L18_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L6_1
  L3_2 = L3_2.Themes
  L4_2 = L6_1
  L4_2 = L4_2.SelectedTheme
  L3_2 = L3_2[L4_2]
  L3_2 = L3_2[A1_2]
  A0_2[L2_2] = L3_2
end

function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = pairs
  L1_2 = L6_1
  L1_2 = L1_2.ThemeObjects
  L0_2, L1_2, L2_2 = L0_2(L1_2)
  for L3_2, L4_2 in L0_2, L1_2, L2_2 do
    L5_2 = pairs
    L6_2 = L4_2
    L5_2, L6_2, L7_2 = L5_2(L6_2)
    for L8_2, L9_2 in L5_2, L6_2, L7_2 do
      L10_2 = L18_1
      L11_2 = L9_2
      L10_2 = L10_2(L11_2)
      L11_2 = L6_1
      L11_2 = L11_2.Themes
      L12_2 = L6_1
      L12_2 = L12_2.SelectedTheme
      L11_2 = L11_2[L12_2]
      L11_2 = L11_2[L3_2]
      L9_2[L10_2] = L11_2
    end
  end
end

function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = {}
  L2_2 = A0_2.R
  L2_2 = L2_2 * 255
  L1_2.R = L2_2
  L2_2 = A0_2.G
  L2_2 = L2_2 * 255
  L1_2.G = L2_2
  L2_2 = A0_2.B
  L2_2 = L2_2 * 255
  L1_2.B = L2_2
end

function L22_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = Color3
  L1_2 = L1_2.fromRGB
  L2_2 = A0_2.R
  L3_2 = A0_2.G
  L4_2 = A0_2.B
end

function L23_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L5_1
  L2_2 = L1_2
  L1_2 = L1_2.JSONDecode
  L3_2 = A0_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = table
  L2_2 = L2_2.foreach
  L3_2 = L1_2
  
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = L6_1
    L2_3 = L2_3.Flags
    L2_3 = L2_3[A0_3]
    if L2_3 then
      L2_3 = spawn
      
      function L3_3()
        local L0_4, L1_4, L2_4, L3_4
        L0_4 = L6_1
        L0_4 = L0_4.Flags
        L1_4 = A0_3
        L0_4 = L0_4[L1_4]
        L0_4 = L0_4.Type
        if L0_4 == "Colorpicker" then
          L0_4 = L6_1
          L0_4 = L0_4.Flags
          L1_4 = A0_3
          L0_4 = L0_4[L1_4]
          L1_4 = L0_4
          L0_4 = L0_4.Set
          L2_4 = L22_1
          L3_4 = A1_3
          L2_4, L3_4 = L2_4(L3_4)
          L0_4(L1_4, L2_4, L3_4)
        else
          L0_4 = L6_1
          L0_4 = L0_4.Flags
          L1_4 = A0_3
          L0_4 = L0_4[L1_4]
          L1_4 = L0_4
          L0_4 = L0_4.Set
          L2_4 = A1_3
          L0_4(L1_4, L2_4)
        end
      end
      
      L2_3(L3_3)
    else
      L2_3 = warn
      L3_3 = "Orion Library Config Loader - Could not find "
      L4_3 = A0_3
      L5_3 = A1_3
      L2_3(L3_3, L4_3, L5_3)
    end
  end
  
  L2_2(L3_2, L4_2)
end

function L24_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = L6_1
  L3_2 = L3_2.Flags
  L2_2, L3_2, L4_2 = L2_2(L3_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = L6_2.Save
    if L7_2 then
      L7_2 = L6_2.Type
      if L7_2 == "Colorpicker" then
        L7_2 = L21_1
        L8_2 = L6_2.Value
        L7_2 = L7_2(L8_2)
        L1_2[L5_2] = L7_2
      else
        L7_2 = L6_2.Value
        L1_2[L5_2] = L7_2
      end
    end
  end
  L2_2 = writefile
  L3_2 = L6_1
  L3_2 = L3_2.Folder
  L4_2 = "/"
  L5_2 = A0_2
  L6_2 = ".txt"
  L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
  L4_2 = tostring
  L5_2 = L5_1
  L6_2 = L5_2
  L5_2 = L5_2.JSONEncode
  L7_2 = L1_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2)
  L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end

L25_1 = {}
L26_1 = Enum
L26_1 = L26_1.UserInputType
L26_1 = L26_1.MouseButton1
L27_1 = Enum
L27_1 = L27_1.UserInputType
L27_1 = L27_1.MouseButton2
L28_1 = Enum
L28_1 = L28_1.UserInputType
L28_1 = L28_1.MouseButton3
L25_1[1] = L26_1
L25_1[2] = L27_1
L25_1[3] = L28_1
L26_1 = {}
L27_1 = Enum
L27_1 = L27_1.KeyCode
L27_1 = L27_1.Unknown
L28_1 = Enum
L28_1 = L28_1.KeyCode
L28_1 = L28_1.W
L29_1 = Enum
L29_1 = L29_1.KeyCode
L29_1 = L29_1.A
L30_1 = Enum
L30_1 = L30_1.KeyCode
L30_1 = L30_1.S
L31_1 = Enum
L31_1 = L31_1.KeyCode
L31_1 = L31_1.D
L32_1 = Enum
L32_1 = L32_1.KeyCode
L32_1 = L32_1.Up
L33_1 = Enum
L33_1 = L33_1.KeyCode
L33_1 = L33_1.Left
L34_1 = Enum
L34_1 = L34_1.KeyCode
L34_1 = L34_1.Down
L35_1 = Enum
L35_1 = L35_1.KeyCode
L35_1 = L35_1.Right
L36_1 = Enum
L36_1 = L36_1.KeyCode
L36_1 = L36_1.Slash
L37_1 = Enum
L37_1 = L37_1.KeyCode
L37_1 = L37_1.Tab
L38_1 = Enum
L38_1 = L38_1.KeyCode
L38_1 = L38_1.Backspace
L39_1 = Enum
L39_1 = L39_1.KeyCode
L39_1 = L39_1.Escape
L26_1[1] = L27_1
L26_1[2] = L28_1
L26_1[3] = L29_1
L26_1[4] = L30_1
L26_1[5] = L31_1
L26_1[6] = L32_1
L26_1[7] = L33_1
L26_1[8] = L34_1
L26_1[9] = L35_1
L26_1[10] = L36_1
L26_1[11] = L37_1
L26_1[12] = L38_1
L26_1[13] = L39_1

function L27_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = next
  L3_2 = A0_2
  L4_2 = nil
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    if L6_2 == A1_2 then
      L7_2 = true
      return L7_2
    end
  end
end

L28_1 = L13_1
L29_1 = "Corner"

function L30_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L12_1
  L3_2 = "UICorner"
  L4_2 = {}
  L5_2 = UDim
  L5_2 = L5_2.new
  L6_2 = A0_2 or L6_2
  if not A0_2 then
    L6_2 = 0
  end
  L7_2 = A1_2 or L7_2
  if not A1_2 then
    L7_2 = 10
  end
  L5_2 = L5_2(L6_2, L7_2)
  L4_2.CornerRadius = L5_2
  L2_2 = L2_2(L3_2, L4_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "Stroke"

function L30_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = L12_1
  L3_2 = "UIStroke"
  L4_2 = {}
  L5_2 = A0_2 or L5_2
  if not A0_2 then
    L5_2 = Color3
    L5_2 = L5_2.fromRGB
    L6_2 = 255
    L7_2 = 255
    L8_2 = 255
    L5_2 = L5_2(L6_2, L7_2, L8_2)
  end
  L4_2.Color = L5_2
  L5_2 = A1_2 or L5_2
  if not A1_2 then
    L5_2 = 1
  end
  L4_2.Thickness = L5_2
  L2_2 = L2_2(L3_2, L4_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "List"

function L30_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L12_1
  L3_2 = "UIListLayout"
  L4_2 = {}
  L5_2 = Enum
  L5_2 = L5_2.SortOrder
  L5_2 = L5_2.LayoutOrder
  L4_2.SortOrder = L5_2
  L5_2 = UDim
  L5_2 = L5_2.new
  L6_2 = A0_2 or L6_2
  if not A0_2 then
    L6_2 = 0
  end
  L7_2 = A1_2 or L7_2
  if not A1_2 then
    L7_2 = 0
  end
  L5_2 = L5_2(L6_2, L7_2)
  L4_2.Padding = L5_2
  L2_2 = L2_2(L3_2, L4_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "Padding"

function L30_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = L12_1
  L5_2 = "UIPadding"
  L6_2 = {}
  L7_2 = UDim
  L7_2 = L7_2.new
  L8_2 = 0
  L9_2 = A0_2 or L9_2
  if not A0_2 then
    L9_2 = 4
  end
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.PaddingBottom = L7_2
  L7_2 = UDim
  L7_2 = L7_2.new
  L8_2 = 0
  L9_2 = A1_2 or L9_2
  if not A1_2 then
    L9_2 = 4
  end
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.PaddingLeft = L7_2
  L7_2 = UDim
  L7_2 = L7_2.new
  L8_2 = 0
  L9_2 = A2_2 or L9_2
  if not A2_2 then
    L9_2 = 4
  end
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.PaddingRight = L7_2
  L7_2 = UDim
  L7_2 = L7_2.new
  L8_2 = 0
  L9_2 = A3_2 or L9_2
  if not A3_2 then
    L9_2 = 4
  end
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.PaddingTop = L7_2
  L4_2 = L4_2(L5_2, L6_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "TFrame"

function L30_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L12_1
  L1_2 = "Frame"
  L2_2 = {}
  L2_2.BackgroundTransparency = 1
  L0_2 = L0_2(L1_2, L2_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "Frame"

function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = L12_1
  L2_2 = "Frame"
  L3_2 = {}
  L4_2 = A0_2 or L4_2
  if not A0_2 then
    L4_2 = Color3
    L4_2 = L4_2.fromRGB
    L5_2 = 255
    L6_2 = 255
    L7_2 = 255
    L4_2 = L4_2(L5_2, L6_2, L7_2)
  end
  L3_2.BackgroundColor3 = L4_2
  L3_2.BorderSizePixel = 0
  L1_2 = L1_2(L2_2, L3_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "RoundFrame"

function L30_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = L12_1
  L4_2 = "Frame"
  L5_2 = {}
  L6_2 = A0_2 or L6_2
  if not A0_2 then
    L6_2 = Color3
    L6_2 = L6_2.fromRGB
    L7_2 = 255
    L8_2 = 255
    L9_2 = 255
    L6_2 = L6_2(L7_2, L8_2, L9_2)
  end
  L5_2.BackgroundColor3 = L6_2
  L5_2.BorderSizePixel = 0
  L6_2 = {}
  L7_2 = L12_1
  L8_2 = "UICorner"
  L9_2 = {}
  L10_2 = UDim
  L10_2 = L10_2.new
  L11_2 = A1_2
  L12_2 = A2_2
  L10_2 = L10_2(L11_2, L12_2)
  L9_2.CornerRadius = L10_2
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2(L8_2, L9_2)
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L6_2[4] = L10_2
  L6_2[5] = L11_2
  L6_2[6] = L12_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "Button"

function L30_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L12_1
  L1_2 = "TextButton"
  L2_2 = {}
  L2_2.Text = ""
  L2_2.AutoButtonColor = false
  L2_2.BackgroundTransparency = 1
  L2_2.BorderSizePixel = 0
  L0_2 = L0_2(L1_2, L2_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "ScrollFrame"

function L30_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = L12_1
  L3_2 = "ScrollingFrame"
  L4_2 = {}
  L4_2.BackgroundTransparency = 1
  L4_2.MidImage = "rbxassetid://7445543667"
  L4_2.BottomImage = "rbxassetid://7445543667"
  L4_2.TopImage = "rbxassetid://7445543667"
  L4_2.ScrollBarImageColor3 = A0_2
  L4_2.BorderSizePixel = 0
  L4_2.ScrollBarThickness = A1_2
  L5_2 = UDim2
  L5_2 = L5_2.new
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L4_2.CanvasSize = L5_2
  L2_2 = L2_2(L3_2, L4_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "Image"

function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L12_1
  L2_2 = "ImageLabel"
  L3_2 = {}
  L3_2.Image = A0_2
  L3_2.BackgroundTransparency = 1
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L8_1
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 ~= nil then
    L2_2 = L8_1
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2.Image = L2_2
  end
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "ImageButton"

function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L12_1
  L2_2 = "ImageButton"
  L3_2 = {}
  L3_2.Image = A0_2
  L3_2.BackgroundTransparency = 1
  L1_2 = L1_2(L2_2, L3_2)
end

L28_1(L29_1, L30_1)
L28_1 = L13_1
L29_1 = "Label"

function L30_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L12_1
  L4_2 = "TextLabel"
  L5_2 = {}
  L6_2 = A0_2 or L6_2
  if not A0_2 then
    L6_2 = ""
  end
  L5_2.Text = L6_2
  L6_2 = Color3
  L6_2 = L6_2.fromRGB
  L7_2 = 240
  L8_2 = 240
  L9_2 = 240
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L5_2.TextColor3 = L6_2
  L6_2 = A2_2 or L6_2
  if not A2_2 then
    L6_2 = 0
  end
  L5_2.TextTransparency = L6_2
  L6_2 = A1_2 or L6_2
  if not A1_2 then
    L6_2 = 15
  end
  L5_2.TextSize = L6_2
  L6_2 = Enum
  L6_2 = L6_2.Font
  L6_2 = L6_2.Gotham
  L5_2.Font = L6_2
  L5_2.RichText = true
  L5_2.BackgroundTransparency = 1
  L6_2 = Enum
  L6_2 = L6_2.TextXAlignment
  L6_2 = L6_2.Left
  L5_2.TextXAlignment = L6_2
  L3_2 = L3_2(L4_2, L5_2)
end

L28_1(L29_1, L30_1)
L28_1 = L15_1
L29_1 = L16_1
L30_1 = L14_1
L31_1 = "TFrame"
L30_1 = L30_1(L31_1)
L31_1 = {}
L32_1 = L15_1
L33_1 = L14_1
L34_1 = "List"
L33_1 = L33_1(L34_1)
L34_1 = {}
L35_1 = Enum
L35_1 = L35_1.HorizontalAlignment
L35_1 = L35_1.Center
L34_1.HorizontalAlignment = L35_1
L35_1 = Enum
L35_1 = L35_1.SortOrder
L35_1 = L35_1.LayoutOrder
L34_1.SortOrder = L35_1
L35_1 = Enum
L35_1 = L35_1.VerticalAlignment
L35_1 = L35_1.Bottom
L34_1.VerticalAlignment = L35_1
L35_1 = UDim
L35_1 = L35_1.new
L36_1 = 0
L37_1 = 5
L35_1 = L35_1(L36_1, L37_1)
L34_1.Padding = L35_1
L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1 = L32_1(L33_1, L34_1)
L31_1[1] = L32_1
L31_1[2] = L33_1
L31_1[3] = L34_1
L31_1[4] = L35_1
L31_1[5] = L36_1
L31_1[6] = L37_1
L31_1[7] = L38_1
L31_1[8] = L39_1
L29_1 = L29_1(L30_1, L31_1)
L30_1 = {}
L31_1 = UDim2
L31_1 = L31_1.new
L32_1 = 1
L33_1 = -25
L34_1 = 1
L35_1 = -25
L31_1 = L31_1(L32_1, L33_1, L34_1, L35_1)
L30_1.Position = L31_1
L31_1 = UDim2
L31_1 = L31_1.new
L32_1 = 0
L33_1 = 300
L34_1 = 1
L35_1 = -25
L31_1 = L31_1(L32_1, L33_1, L34_1, L35_1)
L30_1.Size = L31_1
L31_1 = Vector2
L31_1 = L31_1.new
L32_1 = 1
L33_1 = 1
L31_1 = L31_1(L32_1, L33_1)
L30_1.AnchorPoint = L31_1
L30_1.Parent = L9_1
L28_1 = L28_1(L29_1, L30_1)

function L29_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = spawn
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = A1_2
    L1_3 = A1_2
    L1_3 = L1_3.Name
    if not L1_3 then
      L1_3 = "Notification"
    end
    L0_3.Name = L1_3
    L0_3 = A1_2
    L1_3 = A1_2
    L1_3 = L1_3.Content
    if not L1_3 then
      L1_3 = "Test"
    end
    L0_3.Content = L1_3
    L0_3 = A1_2
    L1_3 = A1_2
    L1_3 = L1_3.Image
    if not L1_3 then
      L1_3 = "rbxassetid://4384403532"
    end
    L0_3.Image = L1_3
    L0_3 = A1_2
    L1_3 = A1_2
    L1_3 = L1_3.Time
    if not L1_3 then
      L1_3 = 15
    end
    L0_3.Time = L1_3
    L0_3 = L15_1
    L1_3 = L14_1
    L2_3 = "TFrame"
    L1_3 = L1_3(L2_3)
    L2_3 = {}
    L3_3 = UDim2
    L3_3 = L3_3.new
    L4_3 = 1
    L5_3 = 0
    L6_3 = 0
    L7_3 = 0
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L2_3.Size = L3_3
    L3_3 = Enum
    L3_3 = L3_3.AutomaticSize
    L3_3 = L3_3.Y
    L2_3.AutomaticSize = L3_3
    L3_3 = L28_1
    L2_3.Parent = L3_3
    L0_3 = L0_3(L1_3, L2_3)
    L1_3 = L16_1
    L2_3 = L15_1
    L3_3 = L14_1
    L4_3 = "RoundFrame"
    L5_3 = Color3
    L5_3 = L5_3.fromRGB
    L6_3 = 24
    L7_3 = 27
    L8_3 = 40
    L5_3 = L5_3(L6_3, L7_3, L8_3)
    L6_3 = 0
    L7_3 = 10
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L4_3 = {}
    L4_3.Parent = L0_3
    L5_3 = UDim2
    L5_3 = L5_3.new
    L6_3 = 1
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
    L4_3.Size = L5_3
    L5_3 = UDim2
    L5_3 = L5_3.new
    L6_3 = 1
    L7_3 = -55
    L8_3 = 0
    L9_3 = 0
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
    L4_3.Position = L5_3
    L4_3.BackgroundTransparency = 0
    L5_3 = Enum
    L5_3 = L5_3.AutomaticSize
    L5_3 = L5_3.Y
    L4_3.AutomaticSize = L5_3
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = L14_1
    L5_3 = "Stroke"
    L6_3 = Color3
    L6_3 = L6_3.fromRGB
    L7_3 = 45
    L8_3 = 50
    L9_3 = 75
    L6_3 = L6_3(L7_3, L8_3, L9_3)
    L7_3 = 1.2
    L4_3 = L4_3(L5_3, L6_3, L7_3)
    L5_3 = L14_1
    L6_3 = "Padding"
    L7_3 = 12
    L8_3 = 12
    L9_3 = 12
    L10_3 = 12
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3)
    L6_3 = L15_1
    L7_3 = L14_1
    L8_3 = "Image"
    L9_3 = A1_2
    L9_3 = L9_3.Image
    L7_3 = L7_3(L8_3, L9_3)
    L8_3 = {}
    L9_3 = UDim2
    L9_3 = L9_3.new
    L10_3 = 0
    L11_3 = 20
    L12_3 = 0
    L13_3 = 20
    L9_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
    L8_3.Size = L9_3
    L9_3 = Color3
    L9_3 = L9_3.fromRGB
    L10_3 = 220
    L11_3 = 230
    L12_3 = 255
    L9_3 = L9_3(L10_3, L11_3, L12_3)
    L8_3.ImageColor3 = L9_3
    L8_3.Name = "Icon"
    L6_3 = L6_3(L7_3, L8_3)
    L7_3 = L15_1
    L8_3 = L14_1
    L9_3 = "Label"
    L10_3 = A1_2
    L10_3 = L10_3.Name
    L11_3 = 15
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L9_3 = {}
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 1
    L12_3 = -30
    L13_3 = 0
    L14_3 = 20
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L9_3.Size = L10_3
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 30
    L13_3 = 0
    L14_3 = 0
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L9_3.Position = L10_3
    L10_3 = Enum
    L10_3 = L10_3.Font
    L10_3 = L10_3.GothamBold
    L9_3.Font = L10_3
    L9_3.Name = "Title"
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 220
    L12_3 = 230
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L9_3.TextColor3 = L10_3
    L7_3 = L7_3(L8_3, L9_3)
    L8_3 = L15_1
    L9_3 = L14_1
    L10_3 = "Label"
    L11_3 = A1_2
    L11_3 = L11_3.Content
    L12_3 = 14
    L9_3 = L9_3(L10_3, L11_3, L12_3)
    L10_3 = {}
    L11_3 = UDim2
    L11_3 = L11_3.new
    L12_3 = 1
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L11_3 = L11_3(L12_3, L13_3, L14_3, L15_3)
    L10_3.Size = L11_3
    L11_3 = UDim2
    L11_3 = L11_3.new
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 25
    L11_3 = L11_3(L12_3, L13_3, L14_3, L15_3)
    L10_3.Position = L11_3
    L11_3 = Enum
    L11_3 = L11_3.Font
    L11_3 = L11_3.GothamSemibold
    L10_3.Font = L11_3
    L10_3.Name = "Content"
    L11_3 = Enum
    L11_3 = L11_3.AutomaticSize
    L11_3 = L11_3.Y
    L10_3.AutomaticSize = L11_3
    L11_3 = Color3
    L11_3 = L11_3.fromRGB
    L12_3 = 150
    L13_3 = 160
    L14_3 = 200
    L11_3 = L11_3(L12_3, L13_3, L14_3)
    L10_3.TextColor3 = L11_3
    L10_3.TextWrapped = true
    L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3 = L8_3(L9_3, L10_3)
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.5
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quint
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L7_3 = UDim2
    L7_3 = L7_3.new
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
    L6_3.Position = L7_3
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = wait
    L3_3 = A1_2
    L3_3 = L3_3.Time
    L3_3 = L3_3 - 0.88
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3.Icon
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.4
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quint
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L6_3.ImageTransparency = 1
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.8
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quint
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L6_3.BackgroundTransparency = 0.6
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = wait
    L3_3 = 0.3
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3.UIStroke
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.6
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quint
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L6_3.Transparency = 0.9
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3.Title
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.6
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quint
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L6_3.TextTransparency = 0.4
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3.Content
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.6
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quint
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L6_3.TextTransparency = 0.5
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = wait
    L3_3 = 0.05
    L2_3(L3_3)
    L3_3 = L1_3
    L2_3 = L1_3.TweenPosition
    L4_3 = UDim2
    L4_3 = L4_3.new
    L5_3 = 1
    L6_3 = 20
    L7_3 = 0
    L8_3 = 0
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
    L5_3 = "In"
    L6_3 = "Quint"
    L7_3 = 0.8
    L8_3 = true
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
    L2_3 = wait
    L3_3 = 1.35
    L2_3(L3_3)
    L3_3 = L1_3
    L2_3 = L1_3.Destroy
    L2_3(L3_3)
  end
  
  L2_2(L3_2)
end

L6_1.MakeNotification = L29_1

function L29_1(A0_2)
  local L1_2, L2_2
  L1_2 = L6_1
  L1_2 = L1_2.SaveCfg
  if L1_2 then
    L1_2 = pcall
    
    function L2_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = isfile
      L1_3 = L6_1
      L1_3 = L1_3.Folder
      L2_3 = "/"
      L3_3 = game
      L3_3 = L3_3.GameId
      L4_3 = ".txt"
      L1_3 = L1_3 .. L2_3 .. L3_3 .. L4_3
      L0_3 = L0_3(L1_3)
      if L0_3 then
        L0_3 = L23_1
        L1_3 = readfile
        L2_3 = L6_1
        L2_3 = L2_3.Folder
        L3_3 = "/"
        L4_3 = game
        L4_3 = L4_3.GameId
        L5_3 = ".txt"
        L2_3 = L2_3 .. L3_3 .. L4_3 .. L5_3
        L1_3, L2_3, L3_3, L4_3, L5_3 = L1_3(L2_3)
        L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
        L0_3 = L6_1
        L1_3 = L0_3
        L0_3 = L0_3.MakeNotification
        L2_3 = {}
        L2_3.Name = "Configuration"
        L3_3 = "Auto-loaded configuration for the game "
        L4_3 = game
        L4_3 = L4_3.GameId
        L5_3 = "."
        L3_3 = L3_3 .. L4_3 .. L5_3
        L2_3.Content = L3_3
        L2_3.Time = 5
        L0_3(L1_3, L2_3)
      end
    end
    
    L1_2(L2_2)
  end
end

L6_1.Init = L29_1

function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2
  L2_2 = true
  L3_2 = false
  L4_2 = false
  L5_2 = false
  if not A1_2 then
    L6_2 = {}
    A1_2 = L6_2
  end
  L6_2 = A1_2.Name
  if not L6_2 then
    L6_2 = "Solara Hub"
  end
  A1_2.Name = L6_2
  L6_2 = A1_2.ConfigFolder
  if not L6_2 then
    L6_2 = A1_2.Name
  end
  A1_2.ConfigFolder = L6_2
  L6_2 = A1_2.SaveConfig
  if not L6_2 then
    L6_2 = false
  end
  A1_2.SaveConfig = L6_2
  L6_2 = A1_2.HidePremium
  if not L6_2 then
    L6_2 = false
  end
  A1_2.HidePremium = L6_2
  L6_2 = A1_2.IntroEnabled
  if L6_2 == nil then
    A1_2.IntroEnabled = true
  end
  L6_2 = A1_2.IntroText
  if not L6_2 then
    L6_2 = "Solara Hub"
  end
  A1_2.IntroText = L6_2
  L6_2 = A1_2.CloseCallback
  if not L6_2 then
    function L6_2()
      local L0_3
    end
  end
  A1_2.CloseCallback = L6_2
  L6_2 = A1_2.ShowIcon
  if not L6_2 then
    L6_2 = false
  end
  A1_2.ShowIcon = L6_2
  L6_2 = A1_2.Icon
  if not L6_2 then
    L6_2 = "rbxassetid://7734068321"
  end
  A1_2.Icon = L6_2
  L6_2 = A1_2.IntroIcon
  if not L6_2 then
    L6_2 = "rbxassetid://7734068321"
  end
  A1_2.IntroIcon = L6_2
  L6_2 = L6_1
  L7_2 = A1_2.ConfigFolder
  L6_2.Folder = L7_2
  L6_2 = L6_1
  L7_2 = A1_2.SaveConfig
  L6_2.SaveCfg = L7_2
  L6_2 = A1_2.SaveConfig
  if L6_2 then
    L6_2 = isfolder
    L7_2 = A1_2.ConfigFolder
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = makefolder
      L7_2 = A1_2.ConfigFolder
      L6_2(L7_2)
    end
  end
  L6_2 = L19_1
  L7_2 = L16_1
  L8_2 = L15_1
  L9_2 = L14_1
  L10_2 = "ScrollFrame"
  L11_2 = Color3
  L11_2 = L11_2.fromRGB
  L12_2 = 255
  L13_2 = 255
  L14_2 = 255
  L11_2 = L11_2(L12_2, L13_2, L14_2)
  L12_2 = 4
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = {}
  L11_2 = UDim2
  L11_2 = L11_2.new
  L12_2 = 1
  L13_2 = 0
  L14_2 = 1
  L15_2 = -50
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L10_2.Size = L11_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = {}
  L10_2 = L14_1
  L11_2 = "List"
  L10_2 = L10_2(L11_2)
  L11_2 = L14_1
  L12_2 = "Padding"
  L13_2 = 8
  L14_2 = 0
  L15_2 = 0
  L16_2 = 8
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L9_2[4] = L13_2
  L9_2[5] = L14_2
  L9_2[6] = L15_2
  L9_2[7] = L16_2
  L9_2[8] = L17_2
  L9_2[9] = L18_2
  L9_2[10] = L19_2
  L9_2[11] = L20_2
  L9_2[12] = L21_2
  L9_2[13] = L22_2
  L9_2[14] = L23_2
  L9_2[15] = L24_2
  L9_2[16] = L25_2
  L9_2[17] = L26_2
  L9_2[18] = L27_2
  L9_2[19] = L28_2
  L9_2[20] = L29_2
  L9_2[21] = L30_2
  L9_2[22] = L31_2
  L9_2[23] = L32_2
  L9_2[24] = L33_2
  L9_2[25] = L34_2
  L9_2[26] = L35_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = "Divider"
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = L10_1
  L8_2 = L6_2.UIListLayout
  L9_2 = L8_2
  L8_2 = L8_2.GetPropertyChangedSignal
  L10_2 = "AbsoluteContentSize"
  L8_2 = L8_2(L9_2, L10_2)
  
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = L6_2
    L1_3 = UDim2
    L1_3 = L1_3.new
    L2_3 = 0
    L3_3 = 0
    L4_3 = 0
    L5_3 = L6_2
    L5_3 = L5_3.UIListLayout
    L5_3 = L5_3.AbsoluteContentSize
    L5_3 = L5_3.Y
    L5_3 = L5_3 + 16
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
    L0_3.CanvasSize = L1_3
  end
  
  L7_2(L8_2, L9_2)
  L7_2 = L16_1
  L8_2 = L15_1
  L9_2 = L14_1
  L10_2 = "Button"
  L9_2 = L9_2(L10_2)
  L10_2 = {}
  L11_2 = UDim2
  L11_2 = L11_2.new
  L12_2 = 0.5
  L13_2 = 0
  L14_2 = 1
  L15_2 = 0
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L10_2.Size = L11_2
  L11_2 = UDim2
  L11_2 = L11_2.new
  L12_2 = 0.5
  L13_2 = 0
  L14_2 = 0
  L15_2 = 0
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L10_2.Position = L11_2
  L10_2.BackgroundTransparency = 1
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = {}
  L10_2 = L19_1
  L11_2 = L15_1
  L12_2 = L14_1
  L13_2 = "Image"
  L14_2 = "rbxassetid://7072725342"
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = {}
  L14_2 = UDim2
  L14_2 = L14_2.new
  L15_2 = 0
  L16_2 = 9
  L17_2 = 0
  L18_2 = 6
  L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
  L13_2.Position = L14_2
  L14_2 = UDim2
  L14_2 = L14_2.new
  L15_2 = 0
  L16_2 = 18
  L17_2 = 0
  L18_2 = 18
  L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
  L13_2.Size = L14_2
  L11_2 = L11_2(L12_2, L13_2)
  L12_2 = "Text"
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L10_2(L11_2, L12_2)
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L9_2[4] = L13_2
  L9_2[5] = L14_2
  L9_2[6] = L15_2
  L9_2[7] = L16_2
  L9_2[8] = L17_2
  L9_2[9] = L18_2
  L9_2[10] = L19_2
  L9_2[11] = L20_2
  L9_2[12] = L21_2
  L9_2[13] = L22_2
  L9_2[14] = L23_2
  L9_2[15] = L24_2
  L9_2[16] = L25_2
  L9_2[17] = L26_2
  L9_2[18] = L27_2
  L9_2[19] = L28_2
  L9_2[20] = L29_2
  L9_2[21] = L30_2
  L9_2[22] = L31_2
  L9_2[23] = L32_2
  L9_2[24] = L33_2
  L9_2[25] = L34_2
  L9_2[26] = L35_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = L16_1
  L9_2 = L15_1
  L10_2 = L14_1
  L11_2 = "Button"
  L10_2 = L10_2(L11_2)
  L11_2 = {}
  L12_2 = UDim2
  L12_2 = L12_2.new
  L13_2 = 0.5
  L14_2 = 0
  L15_2 = 1
  L16_2 = 0
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
  L11_2.Size = L12_2
  L11_2.BackgroundTransparency = 1
  L9_2 = L9_2(L10_2, L11_2)
  L10_2 = {}
  L11_2 = L19_1
  L12_2 = L15_1
  L13_2 = L14_1
  L14_2 = "Image"
  L15_2 = "rbxassetid://7072719338"
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = {}
  L15_2 = UDim2
  L15_2 = L15_2.new
  L16_2 = 0
  L17_2 = 9
  L18_2 = 0
  L19_2 = 6
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L14_2.Position = L15_2
  L15_2 = UDim2
  L15_2 = L15_2.new
  L16_2 = 0
  L17_2 = 18
  L18_2 = 0
  L19_2 = 18
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L14_2.Size = L15_2
  L14_2.Name = "Ico"
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = "Text"
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L11_2(L12_2, L13_2)
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L10_2[4] = L14_2
  L10_2[5] = L15_2
  L10_2[6] = L16_2
  L10_2[7] = L17_2
  L10_2[8] = L18_2
  L10_2[9] = L19_2
  L10_2[10] = L20_2
  L10_2[11] = L21_2
  L10_2[12] = L22_2
  L10_2[13] = L23_2
  L10_2[14] = L24_2
  L10_2[15] = L25_2
  L10_2[16] = L26_2
  L10_2[17] = L27_2
  L10_2[18] = L28_2
  L10_2[19] = L29_2
  L10_2[20] = L30_2
  L10_2[21] = L31_2
  L10_2[22] = L32_2
  L10_2[23] = L33_2
  L10_2[24] = L34_2
  L10_2[25] = L35_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = L15_1
  L10_2 = L14_1
  L11_2 = "TFrame"
  L10_2 = L10_2(L11_2)
  L11_2 = {}
  L12_2 = UDim2
  L12_2 = L12_2.new
  L13_2 = 1
  L14_2 = 0
  L15_2 = 0
  L16_2 = 50
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
  L11_2.Size = L12_2
  L9_2 = L9_2(L10_2, L11_2)
  L10_2 = L19_1
  L11_2 = L16_1
  L12_2 = L15_1
  L13_2 = L14_1
  L14_2 = "RoundFrame"
  L15_2 = Color3
  L15_2 = L15_2.fromRGB
  L16_2 = 255
  L17_2 = 255
  L18_2 = 255
  L15_2 = L15_2(L16_2, L17_2, L18_2)
  L16_2 = 0
  L17_2 = 10
  L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
  L14_2 = {}
  L15_2 = UDim2
  L15_2 = L15_2.new
  L16_2 = 0
  L17_2 = 150
  L18_2 = 1
  L19_2 = -50
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L14_2.Size = L15_2
  L15_2 = UDim2
  L15_2 = L15_2.new
  L16_2 = 0
  L17_2 = 0
  L18_2 = 0
  L19_2 = 50
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L14_2.Position = L15_2
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = {}
  L14_2 = L19_1
  L15_2 = L15_1
  L16_2 = L14_1
  L17_2 = "Frame"
  L16_2 = L16_2(L17_2)
  L17_2 = {}
  L18_2 = UDim2
  L18_2 = L18_2.new
  L19_2 = 1
  L20_2 = 0
  L21_2 = 0
  L22_2 = 10
  L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
  L17_2.Size = L18_2
  L18_2 = UDim2
  L18_2 = L18_2.new
  L19_2 = 0
  L20_2 = 0
  L21_2 = 0
  L22_2 = 0
  L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
  L17_2.Position = L18_2
  L15_2 = L15_2(L16_2, L17_2)
  L16_2 = "Second"
  L14_2 = L14_2(L15_2, L16_2)
  L15_2 = L19_1
  L16_2 = L15_1
  L17_2 = L14_1
  L18_2 = "Frame"
  L17_2 = L17_2(L18_2)
  L18_2 = {}
  L19_2 = UDim2
  L19_2 = L19_2.new
  L20_2 = 0
  L21_2 = 10
  L22_2 = 1
  L23_2 = 0
  L19_2 = L19_2(L20_2, L21_2, L22_2, L23_2)
  L18_2.Size = L19_2
  L19_2 = UDim2
  L19_2 = L19_2.new
  L20_2 = 1
  L21_2 = -10
  L22_2 = 0
  L23_2 = 0
  L19_2 = L19_2(L20_2, L21_2, L22_2, L23_2)
  L18_2.Position = L19_2
  L16_2 = L16_2(L17_2, L18_2)
  L17_2 = "Second"
  L15_2 = L15_2(L16_2, L17_2)
  L16_2 = L19_1
  L17_2 = L15_1
  L18_2 = L14_1
  L19_2 = "Frame"
  L18_2 = L18_2(L19_2)
  L19_2 = {}
  L20_2 = UDim2
  L20_2 = L20_2.new
  L21_2 = 0
  L22_2 = 1
  L23_2 = 1
  L24_2 = 0
  L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2)
  L19_2.Size = L20_2
  L20_2 = UDim2
  L20_2 = L20_2.new
  L21_2 = 1
  L22_2 = -1
  L23_2 = 0
  L24_2 = 0
  L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2)
  L19_2.Position = L20_2
  L17_2 = L17_2(L18_2, L19_2)
  L18_2 = "Stroke"
  L16_2 = L16_2(L17_2, L18_2)
  L17_2 = L6_2
  L18_2 = L16_1
  L19_2 = L15_1
  L20_2 = L14_1
  L21_2 = "TFrame"
  L20_2 = L20_2(L21_2)
  L21_2 = {}
  L22_2 = UDim2
  L22_2 = L22_2.new
  L23_2 = 1
  L24_2 = 0
  L25_2 = 0
  L26_2 = 50
  L22_2 = L22_2(L23_2, L24_2, L25_2, L26_2)
  L21_2.Size = L22_2
  L22_2 = UDim2
  L22_2 = L22_2.new
  L23_2 = 0
  L24_2 = 0
  L25_2 = 1
  L26_2 = -50
  L22_2 = L22_2(L23_2, L24_2, L25_2, L26_2)
  L21_2.Position = L22_2
  L19_2 = L19_2(L20_2, L21_2)
  L20_2 = {}
  L21_2 = L19_1
  L22_2 = L15_1
  L23_2 = L14_1
  L24_2 = "Frame"
  L23_2 = L23_2(L24_2)
  L24_2 = {}
  L25_2 = UDim2
  L25_2 = L25_2.new
  L26_2 = 1
  L27_2 = 0
  L28_2 = 0
  L29_2 = 1
  L25_2 = L25_2(L26_2, L27_2, L28_2, L29_2)
  L24_2.Size = L25_2
  L22_2 = L22_2(L23_2, L24_2)
  L23_2 = "Stroke"
  L21_2 = L21_2(L22_2, L23_2)
  L22_2 = L19_1
  L23_2 = L16_1
  L24_2 = L15_1
  L25_2 = L14_1
  L26_2 = "Frame"
  L25_2 = L25_2(L26_2)
  L26_2 = {}
  L27_2 = Vector2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 0.5
  L27_2 = L27_2(L28_2, L29_2)
  L26_2.AnchorPoint = L27_2
  L27_2 = UDim2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 32
  L30_2 = 0
  L31_2 = 32
  L27_2 = L27_2(L28_2, L29_2, L30_2, L31_2)
  L26_2.Size = L27_2
  L27_2 = UDim2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 10
  L30_2 = 0.5
  L31_2 = 0
  L27_2 = L27_2(L28_2, L29_2, L30_2, L31_2)
  L26_2.Position = L27_2
  L24_2 = L24_2(L25_2, L26_2)
  L25_2 = {}
  L26_2 = L15_1
  L27_2 = L14_1
  L28_2 = "Image"
  L29_2 = "https://www.roblox.com/headshot-thumbnail/image?userId="
  L30_2 = L3_1
  L30_2 = L30_2.UserId
  L31_2 = "&width=420&height=420&format=png"
  L29_2 = L29_2 .. L30_2 .. L31_2
  L27_2 = L27_2(L28_2, L29_2)
  L28_2 = {}
  L29_2 = UDim2
  L29_2 = L29_2.new
  L30_2 = 1
  L31_2 = 0
  L32_2 = 1
  L33_2 = 0
  L29_2 = L29_2(L30_2, L31_2, L32_2, L33_2)
  L28_2.Size = L29_2
  L26_2 = L26_2(L27_2, L28_2)
  L27_2 = L19_1
  L28_2 = L15_1
  L29_2 = L14_1
  L30_2 = "Image"
  L31_2 = "rbxassetid://4031889928"
  L29_2 = L29_2(L30_2, L31_2)
  L30_2 = {}
  L31_2 = UDim2
  L31_2 = L31_2.new
  L32_2 = 1
  L33_2 = 0
  L34_2 = 1
  L35_2 = 0
  L31_2 = L31_2(L32_2, L33_2, L34_2, L35_2)
  L30_2.Size = L31_2
  L28_2 = L28_2(L29_2, L30_2)
  L29_2 = "Second"
  L27_2 = L27_2(L28_2, L29_2)
  L28_2 = L14_1
  L29_2 = "Corner"
  L30_2 = 1
  L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L28_2(L29_2, L30_2)
  L25_2[1] = L26_2
  L25_2[2] = L27_2
  L25_2[3] = L28_2
  L25_2[4] = L29_2
  L25_2[5] = L30_2
  L25_2[6] = L31_2
  L25_2[7] = L32_2
  L25_2[8] = L33_2
  L25_2[9] = L34_2
  L25_2[10] = L35_2
  L23_2 = L23_2(L24_2, L25_2)
  L24_2 = "Divider"
  L22_2 = L22_2(L23_2, L24_2)
  L23_2 = L16_1
  L24_2 = L15_1
  L25_2 = L14_1
  L26_2 = "TFrame"
  L25_2 = L25_2(L26_2)
  L26_2 = {}
  L27_2 = Vector2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 0.5
  L27_2 = L27_2(L28_2, L29_2)
  L26_2.AnchorPoint = L27_2
  L27_2 = UDim2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 32
  L30_2 = 0
  L31_2 = 32
  L27_2 = L27_2(L28_2, L29_2, L30_2, L31_2)
  L26_2.Size = L27_2
  L27_2 = UDim2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 10
  L30_2 = 0.5
  L31_2 = 0
  L27_2 = L27_2(L28_2, L29_2, L30_2, L31_2)
  L26_2.Position = L27_2
  L24_2 = L24_2(L25_2, L26_2)
  L25_2 = {}
  L26_2 = L19_1
  L27_2 = L14_1
  L28_2 = "Stroke"
  L27_2 = L27_2(L28_2)
  L28_2 = "Stroke"
  L26_2 = L26_2(L27_2, L28_2)
  L27_2 = L14_1
  L28_2 = "Corner"
  L29_2 = 1
  L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L27_2(L28_2, L29_2)
  L25_2[1] = L26_2
  L25_2[2] = L27_2
  L25_2[3] = L28_2
  L25_2[4] = L29_2
  L25_2[5] = L30_2
  L25_2[6] = L31_2
  L25_2[7] = L32_2
  L25_2[8] = L33_2
  L25_2[9] = L34_2
  L25_2[10] = L35_2
  L23_2 = L23_2(L24_2, L25_2)
  L24_2 = L19_1
  L25_2 = L15_1
  L26_2 = L14_1
  L27_2 = "Label"
  L28_2 = L3_1
  L28_2 = L28_2.DisplayName
  L29_2 = A1_2.HidePremium
  if L29_2 then
    L29_2 = 14
    if L29_2 then
      goto lbl_515
    end
  end
  L29_2 = 13
  ::lbl_515::
  L26_2 = L26_2(L27_2, L28_2, L29_2)
  L27_2 = {}
  L28_2 = UDim2
  L28_2 = L28_2.new
  L29_2 = 1
  L30_2 = -60
  L31_2 = 0
  L32_2 = 13
  L28_2 = L28_2(L29_2, L30_2, L31_2, L32_2)
  L27_2.Size = L28_2
  L28_2 = A1_2.HidePremium
  if L28_2 then
    L28_2 = UDim2
    L28_2 = L28_2.new
    L29_2 = 0
    L30_2 = 50
    L31_2 = 0
    L32_2 = 19
    L28_2 = L28_2(L29_2, L30_2, L31_2, L32_2)
    if L28_2 then
      goto lbl_544
    end
  end
  L28_2 = UDim2
  L28_2 = L28_2.new
  L29_2 = 0
  L30_2 = 50
  L31_2 = 0
  L32_2 = 12
  L28_2 = L28_2(L29_2, L30_2, L31_2, L32_2)
  ::lbl_544::
  L27_2.Position = L28_2
  L28_2 = Enum
  L28_2 = L28_2.Font
  L28_2 = L28_2.GothamBold
  L27_2.Font = L28_2
  L27_2.ClipsDescendants = true
  L25_2 = L25_2(L26_2, L27_2)
  L26_2 = "Text"
  L24_2 = L24_2(L25_2, L26_2)
  L25_2 = L19_1
  L26_2 = L15_1
  L27_2 = L14_1
  L28_2 = "Label"
  L29_2 = ""
  L30_2 = 12
  L27_2 = L27_2(L28_2, L29_2, L30_2)
  L28_2 = {}
  L29_2 = UDim2
  L29_2 = L29_2.new
  L30_2 = 1
  L31_2 = -60
  L32_2 = 0
  L33_2 = 12
  L29_2 = L29_2(L30_2, L31_2, L32_2, L33_2)
  L28_2.Size = L29_2
  L29_2 = UDim2
  L29_2 = L29_2.new
  L30_2 = 0
  L31_2 = 50
  L32_2 = 1
  L33_2 = -25
  L29_2 = L29_2(L30_2, L31_2, L32_2, L33_2)
  L28_2.Position = L29_2
  L29_2 = A1_2.HidePremium
  L29_2 = not L29_2
  L28_2.Visible = L29_2
  L26_2 = L26_2(L27_2, L28_2)
  L27_2 = "TextDark"
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L25_2(L26_2, L27_2)
  L20_2[1] = L21_2
  L20_2[2] = L22_2
  L20_2[3] = L23_2
  L20_2[4] = L24_2
  L20_2[5] = L25_2
  L20_2[6] = L26_2
  L20_2[7] = L27_2
  L20_2[8] = L28_2
  L20_2[9] = L29_2
  L20_2[10] = L30_2
  L20_2[11] = L31_2
  L20_2[12] = L32_2
  L20_2[13] = L33_2
  L20_2[14] = L34_2
  L20_2[15] = L35_2
  L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L18_2(L19_2, L20_2)
  L13_2[1] = L14_2
  L13_2[2] = L15_2
  L13_2[3] = L16_2
  L13_2[4] = L17_2
  L13_2[5] = L18_2
  L13_2[6] = L19_2
  L13_2[7] = L20_2
  L13_2[8] = L21_2
  L13_2[9] = L22_2
  L13_2[10] = L23_2
  L13_2[11] = L24_2
  L13_2[12] = L25_2
  L13_2[13] = L26_2
  L13_2[14] = L27_2
  L13_2[15] = L28_2
  L13_2[16] = L29_2
  L13_2[17] = L30_2
  L13_2[18] = L31_2
  L13_2[19] = L32_2
  L13_2[20] = L33_2
  L13_2[21] = L34_2
  L13_2[22] = L35_2
  L11_2 = L11_2(L12_2, L13_2)
  L12_2 = "Second"
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = L19_1
  L12_2 = L15_1
  L13_2 = L14_1
  L14_2 = "Label"
  L15_2 = A1_2.Name
  L16_2 = 14
  L13_2 = L13_2(L14_2, L15_2, L16_2)
  L14_2 = {}
  L15_2 = UDim2
  L15_2 = L15_2.new
  L16_2 = 1
  L17_2 = -30
  L18_2 = 2
  L19_2 = 0
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L14_2.Size = L15_2
  L15_2 = UDim2
  L15_2 = L15_2.new
  L16_2 = 0
  L17_2 = 25
  L18_2 = 0
  L19_2 = -24
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L14_2.Position = L15_2
  L15_2 = Enum
  L15_2 = L15_2.Font
  L15_2 = L15_2.GothamBlack
  L14_2.Font = L15_2
  L14_2.TextSize = 20
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = "Text"
  L11_2 = L11_2(L12_2, L13_2)
  L12_2 = L19_1
  L13_2 = L15_1
  L14_2 = L14_1
  L15_2 = "Frame"
  L14_2 = L14_2(L15_2)
  L15_2 = {}
  L16_2 = UDim2
  L16_2 = L16_2.new
  L17_2 = 1
  L18_2 = 0
  L19_2 = 0
  L20_2 = 1
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2)
  L15_2.Size = L16_2
  L16_2 = UDim2
  L16_2 = L16_2.new
  L17_2 = 0
  L18_2 = 0
  L19_2 = 1
  L20_2 = -1
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2)
  L15_2.Position = L16_2
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = "Stroke"
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = L19_1
  L14_2 = L16_1
  L15_2 = L15_1
  L16_2 = L14_1
  L17_2 = "RoundFrame"
  L18_2 = Color3
  L18_2 = L18_2.fromRGB
  L19_2 = 255
  L20_2 = 255
  L21_2 = 255
  L18_2 = L18_2(L19_2, L20_2, L21_2)
  L19_2 = 0
  L20_2 = 10
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2)
  L17_2 = {}
  L18_2 = L9_1
  L17_2.Parent = L18_2
  L18_2 = UDim2
  L18_2 = L18_2.new
  L19_2 = 0.5
  L20_2 = -307
  L21_2 = 0.5
  L22_2 = -172
  L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
  L17_2.Position = L18_2
  L18_2 = UDim2
  L18_2 = L18_2.new
  L19_2 = 0
  L20_2 = 615
  L21_2 = 0
  L22_2 = 344
  L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2)
  L17_2.Size = L18_2
  L17_2.ClipsDescendants = true
  L15_2 = L15_2(L16_2, L17_2)
  L16_2 = {}
  L17_2 = L16_1
  L18_2 = L15_1
  L19_2 = L14_1
  L20_2 = "TFrame"
  L19_2 = L19_2(L20_2)
  L20_2 = {}
  L21_2 = UDim2
  L21_2 = L21_2.new
  L22_2 = 1
  L23_2 = 0
  L24_2 = 0
  L25_2 = 50
  L21_2 = L21_2(L22_2, L23_2, L24_2, L25_2)
  L20_2.Size = L21_2
  L20_2.Name = "TopBar"
  L18_2 = L18_2(L19_2, L20_2)
  L19_2 = {}
  L20_2 = L11_2
  L21_2 = L12_2
  L22_2 = L19_1
  L23_2 = L16_1
  L24_2 = L15_1
  L25_2 = L14_1
  L26_2 = "RoundFrame"
  L27_2 = Color3
  L27_2 = L27_2.fromRGB
  L28_2 = 255
  L29_2 = 255
  L30_2 = 255
  L27_2 = L27_2(L28_2, L29_2, L30_2)
  L28_2 = 0
  L29_2 = 7
  L25_2 = L25_2(L26_2, L27_2, L28_2, L29_2)
  L26_2 = {}
  L27_2 = UDim2
  L27_2 = L27_2.new
  L28_2 = 0
  L29_2 = 70
  L30_2 = 0
  L31_2 = 30
  L27_2 = L27_2(L28_2, L29_2, L30_2, L31_2)
  L26_2.Size = L27_2
  L27_2 = UDim2
  L27_2 = L27_2.new
  L28_2 = 1
  L29_2 = -90
  L30_2 = 0
  L31_2 = 10
  L27_2 = L27_2(L28_2, L29_2, L30_2, L31_2)
  L26_2.Position = L27_2
  L24_2 = L24_2(L25_2, L26_2)
  L25_2 = {}
  L26_2 = L19_1
  L27_2 = L14_1
  L28_2 = "Stroke"
  L27_2 = L27_2(L28_2)
  L28_2 = "Stroke"
  L26_2 = L26_2(L27_2, L28_2)
  L27_2 = L19_1
  L28_2 = L15_1
  L29_2 = L14_1
  L30_2 = "Frame"
  L29_2 = L29_2(L30_2)
  L30_2 = {}
  L31_2 = UDim2
  L31_2 = L31_2.new
  L32_2 = 0
  L33_2 = 1
  L34_2 = 1
  L35_2 = 0
  L31_2 = L31_2(L32_2, L33_2, L34_2, L35_2)
  L30_2.Size = L31_2
  L31_2 = UDim2
  L31_2 = L31_2.new
  L32_2 = 0.5
  L33_2 = 0
  L34_2 = 0
  L35_2 = 0
  L31_2 = L31_2(L32_2, L33_2, L34_2, L35_2)
  L30_2.Position = L31_2
  L28_2 = L28_2(L29_2, L30_2)
  L29_2 = "Stroke"
  L27_2 = L27_2(L28_2, L29_2)
  L28_2 = L7_2
  L29_2 = L8_2
  L25_2[1] = L26_2
  L25_2[2] = L27_2
  L25_2[3] = L28_2
  L25_2[4] = L29_2
  L23_2 = L23_2(L24_2, L25_2)
  L24_2 = "Second"
  L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2 = L22_2(L23_2, L24_2)
  L19_2[1] = L20_2
  L19_2[2] = L21_2
  L19_2[3] = L22_2
  L19_2[4] = L23_2
  L19_2[5] = L24_2
  L19_2[6] = L25_2
  L19_2[7] = L26_2
  L19_2[8] = L27_2
  L19_2[9] = L28_2
  L19_2[10] = L29_2
  L19_2[11] = L30_2
  L19_2[12] = L31_2
  L19_2[13] = L32_2
  L19_2[14] = L33_2
  L19_2[15] = L34_2
  L19_2[16] = L35_2
  L17_2 = L17_2(L18_2, L19_2)
  L18_2 = L9_2
  L19_2 = L10_2
  L16_2[1] = L17_2
  L16_2[2] = L18_2
  L16_2[3] = L19_2
  L14_2 = L14_2(L15_2, L16_2)
  L15_2 = "Main"
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = A1_2.ShowIcon
  if L14_2 then
    L14_2 = UDim2
    L14_2 = L14_2.new
    L15_2 = 0
    L16_2 = 50
    L17_2 = 0
    L18_2 = -24
    L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
    L11_2.Position = L14_2
    L14_2 = L15_1
    L15_2 = L14_1
    L16_2 = "Image"
    L17_2 = A1_2.Icon
    L15_2 = L15_2(L16_2, L17_2)
    L16_2 = {}
    L17_2 = UDim2
    L17_2 = L17_2.new
    L18_2 = 0
    L19_2 = 20
    L20_2 = 0
    L21_2 = 20
    L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
    L16_2.Size = L17_2
    L17_2 = UDim2
    L17_2 = L17_2.new
    L18_2 = 0
    L19_2 = 25
    L20_2 = 0
    L21_2 = 15
    L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
    L16_2.Position = L17_2
    L14_2 = L14_2(L15_2, L16_2)
    L15_2 = L13_2.TopBar
    L14_2.Parent = L15_2
  end
  L14_2 = L11_1
  L15_2 = L9_2
  L16_2 = L13_2
  L14_2(L15_2, L16_2)
  L14_2 = L10_1
  L15_2 = L7_2.MouseButton1Up
  
  function L16_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = L13_2
    L0_3.Visible = false
    L0_3 = true
    L5_2 = L0_3
    L0_3 = L6_1
    L1_3 = L0_3
    L0_3 = L0_3.MakeNotification
    L2_3 = {}
    L2_3.Name = "Interface Hidden"
    L2_3.Content = "Tap RightShift to reopen the interface"
    L2_3.Time = 5
    L0_3(L1_3, L2_3)
    L0_3 = A1_2
    L0_3 = L0_3.CloseCallback
    L0_3()
  end
  
  L14_2(L15_2, L16_2)
  L14_2 = L10_1
  L15_2 = L0_1
  L15_2 = L15_2.InputBegan
  
  function L16_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.KeyCode
    L2_3 = Enum
    L2_3 = L2_3.KeyCode
    L2_3 = L2_3.RightShift
    if L1_3 == L2_3 then
      L1_3 = L5_2
      if L1_3 then
        L1_3 = L13_2
        L1_3.Visible = true
      end
    end
  end
  
  L14_2(L15_2, L16_2)
  L14_2 = L10_1
  L15_2 = L8_2.MouseButton1Up
  
  function L16_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L0_3 = L3_2
    if L0_3 then
      L0_3 = L1_1
      L1_3 = L0_3
      L0_3 = L0_3.Create
      L2_3 = L13_2
      L3_3 = TweenInfo
      L3_3 = L3_3.new
      L4_3 = 0.5
      L5_3 = Enum
      L5_3 = L5_3.EasingStyle
      L5_3 = L5_3.Quint
      L6_3 = Enum
      L6_3 = L6_3.EasingDirection
      L6_3 = L6_3.Out
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      L4_3 = {}
      L5_3 = UDim2
      L5_3 = L5_3.new
      L6_3 = 0
      L7_3 = 615
      L8_3 = 0
      L9_3 = 344
      L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
      L4_3.Size = L5_3
      L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
      L1_3 = L0_3
      L0_3 = L0_3.Play
      L0_3(L1_3)
      L0_3 = L8_2
      L0_3 = L0_3.Ico
      L0_3.Image = "rbxassetid://7072719338"
      L0_3 = wait
      L1_3 = 0.02
      L0_3(L1_3)
      L0_3 = L13_2
      L0_3.ClipsDescendants = false
      L0_3 = L10_2
      L0_3.Visible = true
      L0_3 = L12_2
      L0_3.Visible = true
    else
      L0_3 = L13_2
      L0_3.ClipsDescendants = true
      L0_3 = L12_2
      L0_3.Visible = false
      L0_3 = L8_2
      L0_3 = L0_3.Ico
      L0_3.Image = "rbxassetid://7072720870"
      L0_3 = L1_1
      L1_3 = L0_3
      L0_3 = L0_3.Create
      L2_3 = L13_2
      L3_3 = TweenInfo
      L3_3 = L3_3.new
      L4_3 = 0.5
      L5_3 = Enum
      L5_3 = L5_3.EasingStyle
      L5_3 = L5_3.Quint
      L6_3 = Enum
      L6_3 = L6_3.EasingDirection
      L6_3 = L6_3.Out
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      L4_3 = {}
      L5_3 = UDim2
      L5_3 = L5_3.new
      L6_3 = 0
      L7_3 = L11_2
      L7_3 = L7_3.TextBounds
      L7_3 = L7_3.X
      L7_3 = L7_3 + 140
      L8_3 = 0
      L9_3 = 50
      L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
      L4_3.Size = L5_3
      L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
      L1_3 = L0_3
      L0_3 = L0_3.Play
      L0_3(L1_3)
      L0_3 = wait
      L1_3 = 0.1
      L0_3(L1_3)
      L0_3 = L10_2
      L0_3.Visible = false
    end
    L0_3 = L3_2
    L0_3 = not L0_3
    L3_2 = L0_3
  end
  
  L14_2(L15_2, L16_2)
  
  function L14_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = L13_2
    L0_3.Visible = false
    L0_3 = L15_1
    L1_3 = L14_1
    L2_3 = "Image"
    L3_3 = A1_2
    L3_3 = L3_3.IntroIcon
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = L9_1
    L2_3.Parent = L3_3
    L3_3 = Vector2
    L3_3 = L3_3.new
    L4_3 = 0.5
    L5_3 = 0.5
    L3_3 = L3_3(L4_3, L5_3)
    L2_3.AnchorPoint = L3_3
    L3_3 = UDim2
    L3_3 = L3_3.new
    L4_3 = 0.5
    L5_3 = 0
    L6_3 = 0.4
    L7_3 = 0
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L2_3.Position = L3_3
    L3_3 = UDim2
    L3_3 = L3_3.new
    L4_3 = 0
    L5_3 = 28
    L6_3 = 0
    L7_3 = 28
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L2_3.Size = L3_3
    L3_3 = Color3
    L3_3 = L3_3.fromRGB
    L4_3 = 255
    L5_3 = 255
    L6_3 = 255
    L3_3 = L3_3(L4_3, L5_3, L6_3)
    L2_3.ImageColor3 = L3_3
    L2_3.ImageTransparency = 1
    L0_3 = L0_3(L1_3, L2_3)
    L1_3 = L15_1
    L2_3 = L14_1
    L3_3 = "Label"
    L4_3 = A1_2
    L4_3 = L4_3.IntroText
    L5_3 = 14
    L2_3 = L2_3(L3_3, L4_3, L5_3)
    L3_3 = {}
    L4_3 = L9_1
    L3_3.Parent = L4_3
    L4_3 = UDim2
    L4_3 = L4_3.new
    L5_3 = 1
    L6_3 = 0
    L7_3 = 1
    L8_3 = 0
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
    L3_3.Size = L4_3
    L4_3 = Vector2
    L4_3 = L4_3.new
    L5_3 = 0.5
    L6_3 = 0.5
    L4_3 = L4_3(L5_3, L6_3)
    L3_3.AnchorPoint = L4_3
    L4_3 = UDim2
    L4_3 = L4_3.new
    L5_3 = 0.5
    L6_3 = 19
    L7_3 = 0.5
    L8_3 = 0
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
    L3_3.Position = L4_3
    L4_3 = Enum
    L4_3 = L4_3.TextXAlignment
    L4_3 = L4_3.Center
    L3_3.TextXAlignment = L4_3
    L4_3 = Enum
    L4_3 = L4_3.Font
    L4_3 = L4_3.GothamBold
    L3_3.Font = L4_3
    L3_3.TextTransparency = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L0_3
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.3
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quad
    L8_3 = Enum
    L8_3 = L8_3.EasingDirection
    L8_3 = L8_3.Out
    L5_3 = L5_3(L6_3, L7_3, L8_3)
    L6_3 = {}
    L6_3.ImageTransparency = 0
    L7_3 = UDim2
    L7_3 = L7_3.new
    L8_3 = 0.5
    L9_3 = 0
    L10_3 = 0.5
    L11_3 = 0
    L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
    L6_3.Position = L7_3
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = wait
    L3_3 = 0.8
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L0_3
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.3
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quad
    L8_3 = Enum
    L8_3 = L8_3.EasingDirection
    L8_3 = L8_3.Out
    L5_3 = L5_3(L6_3, L7_3, L8_3)
    L6_3 = {}
    L7_3 = UDim2
    L7_3 = L7_3.new
    L8_3 = 0.5
    L9_3 = L1_3.TextBounds
    L9_3 = L9_3.X
    L9_3 = L9_3 / 2
    L9_3 = -L9_3
    L10_3 = 0.5
    L11_3 = 0
    L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
    L6_3.Position = L7_3
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = wait
    L3_3 = 0.3
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.3
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quad
    L8_3 = Enum
    L8_3 = L8_3.EasingDirection
    L8_3 = L8_3.Out
    L5_3 = L5_3(L6_3, L7_3, L8_3)
    L6_3 = {}
    L6_3.TextTransparency = 0
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = wait
    L3_3 = 2
    L2_3(L3_3)
    L2_3 = L1_1
    L3_3 = L2_3
    L2_3 = L2_3.Create
    L4_3 = L1_3
    L5_3 = TweenInfo
    L5_3 = L5_3.new
    L6_3 = 0.3
    L7_3 = Enum
    L7_3 = L7_3.EasingStyle
    L7_3 = L7_3.Quad
    L8_3 = Enum
    L8_3 = L8_3.EasingDirection
    L8_3 = L8_3.Out
    L5_3 = L5_3(L6_3, L7_3, L8_3)
    L6_3 = {}
    L6_3.TextTransparency = 1
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = L2_3
    L2_3 = L2_3.Play
    L2_3(L3_3)
    L2_3 = L13_2
    L2_3.Visible = true
    L3_3 = L0_3
    L2_3 = L0_3.Destroy
    L2_3(L3_3)
    L3_3 = L1_3
    L2_3 = L1_3.Destroy
    L2_3(L3_3)
  end
  
  L15_2 = A1_2.IntroEnabled
  if L15_2 then
    L15_2 = L14_2
    L15_2()
  end
  L15_2 = {}
  
  function L16_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3
    if not A1_3 then
      L2_3 = {}
      A1_3 = L2_3
    end
    L2_3 = A1_3.Name
    if not L2_3 then
      L2_3 = "Tab"
    end
    A1_3.Name = L2_3
    L2_3 = A1_3.Icon
    if not L2_3 then
      L2_3 = ""
    end
    A1_3.Icon = L2_3
    L2_3 = A1_3.PremiumOnly
    if not L2_3 then
      L2_3 = false
    end
    A1_3.PremiumOnly = L2_3
    L2_3 = L16_1
    L3_3 = L15_1
    L4_3 = L14_1
    L5_3 = "Button"
    L4_3 = L4_3(L5_3)
    L5_3 = {}
    L6_3 = UDim2
    L6_3 = L6_3.new
    L7_3 = 1
    L8_3 = 0
    L9_3 = 0
    L10_3 = 30
    L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3)
    L5_3.Size = L6_3
    L6_3 = L6_2
    L5_3.Parent = L6_3
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = {}
    L5_3 = L19_1
    L6_3 = L15_1
    L7_3 = L14_1
    L8_3 = "Image"
    L9_3 = A1_3.Icon
    L7_3 = L7_3(L8_3, L9_3)
    L8_3 = {}
    L9_3 = Vector2
    L9_3 = L9_3.new
    L10_3 = 0
    L11_3 = 0.5
    L9_3 = L9_3(L10_3, L11_3)
    L8_3.AnchorPoint = L9_3
    L9_3 = UDim2
    L9_3 = L9_3.new
    L10_3 = 0
    L11_3 = 18
    L12_3 = 0
    L13_3 = 18
    L9_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
    L8_3.Size = L9_3
    L9_3 = UDim2
    L9_3 = L9_3.new
    L10_3 = 0
    L11_3 = 10
    L12_3 = 0.5
    L13_3 = 0
    L9_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
    L8_3.Position = L9_3
    L8_3.ImageTransparency = 0.4
    L8_3.Name = "Ico"
    L6_3 = L6_3(L7_3, L8_3)
    L7_3 = "Text"
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = L19_1
    L7_3 = L15_1
    L8_3 = L14_1
    L9_3 = "Label"
    L10_3 = A1_3.Name
    L11_3 = 14
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L9_3 = {}
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 1
    L12_3 = -35
    L13_3 = 1
    L14_3 = 0
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L9_3.Size = L10_3
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 35
    L13_3 = 0
    L14_3 = 0
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L9_3.Position = L10_3
    L10_3 = Enum
    L10_3 = L10_3.Font
    L10_3 = L10_3.GothamSemibold
    L9_3.Font = L10_3
    L9_3.TextTransparency = 0.4
    L9_3.Name = "Title"
    L7_3 = L7_3(L8_3, L9_3)
    L8_3 = "Text"
    L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L6_3(L7_3, L8_3)
    L4_3[1] = L5_3
    L4_3[2] = L6_3
    L4_3[3] = L7_3
    L4_3[4] = L8_3
    L4_3[5] = L9_3
    L4_3[6] = L10_3
    L4_3[7] = L11_3
    L4_3[8] = L12_3
    L4_3[9] = L13_3
    L4_3[10] = L14_3
    L4_3[11] = L15_3
    L4_3[12] = L16_3
    L4_3[13] = L17_3
    L4_3[14] = L18_3
    L4_3[15] = L19_3
    L4_3[16] = L20_3
    L4_3[17] = L21_3
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = L8_1
    L4_3 = A1_3.Icon
    L3_3 = L3_3(L4_3)
    if L3_3 ~= nil then
      L3_3 = L2_3.Ico
      L4_3 = L8_1
      L5_3 = A1_3.Icon
      L4_3 = L4_3(L5_3)
      L3_3.Image = L4_3
    end
    L3_3 = L19_1
    L4_3 = L16_1
    L5_3 = L15_1
    L6_3 = L14_1
    L7_3 = "ScrollFrame"
    L8_3 = Color3
    L8_3 = L8_3.fromRGB
    L9_3 = 255
    L10_3 = 255
    L11_3 = 255
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L9_3 = 5
    L6_3 = L6_3(L7_3, L8_3, L9_3)
    L7_3 = {}
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 1
    L10_3 = -150
    L11_3 = 1
    L12_3 = -50
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L7_3.Size = L8_3
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0
    L10_3 = 150
    L11_3 = 0
    L12_3 = 50
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L7_3.Position = L8_3
    L8_3 = L13_2
    L7_3.Parent = L8_3
    L7_3.Visible = false
    L7_3.Name = "ItemContainer"
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = {}
    L7_3 = L14_1
    L8_3 = "List"
    L9_3 = 0
    L10_3 = 6
    L7_3 = L7_3(L8_3, L9_3, L10_3)
    L8_3 = L14_1
    L9_3 = "Padding"
    L10_3 = 15
    L11_3 = 10
    L12_3 = 10
    L13_3 = 15
    L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L8_3(L9_3, L10_3, L11_3, L12_3, L13_3)
    L6_3[1] = L7_3
    L6_3[2] = L8_3
    L6_3[3] = L9_3
    L6_3[4] = L10_3
    L6_3[5] = L11_3
    L6_3[6] = L12_3
    L6_3[7] = L13_3
    L6_3[8] = L14_3
    L6_3[9] = L15_3
    L6_3[10] = L16_3
    L6_3[11] = L17_3
    L6_3[12] = L18_3
    L6_3[13] = L19_3
    L6_3[14] = L20_3
    L6_3[15] = L21_3
    L4_3 = L4_3(L5_3, L6_3)
    L5_3 = "Divider"
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = L10_1
    L5_3 = L3_3.UIListLayout
    L6_3 = L5_3
    L5_3 = L5_3.GetPropertyChangedSignal
    L7_3 = "AbsoluteContentSize"
    L5_3 = L5_3(L6_3, L7_3)
    
    function L6_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
      L0_4 = L3_3
      L1_4 = UDim2
      L1_4 = L1_4.new
      L2_4 = 0
      L3_4 = 0
      L4_4 = 0
      L5_4 = L3_3
      L5_4 = L5_4.UIListLayout
      L5_4 = L5_4.AbsoluteContentSize
      L5_4 = L5_4.Y
      L5_4 = L5_4 + 30
      L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
      L0_4.CanvasSize = L1_4
    end
    
    L4_3(L5_3, L6_3)
    L4_3 = L2_2
    if L4_3 then
      L4_3 = false
      L2_2 = L4_3
      L4_3 = L2_3.Ico
      L4_3.ImageTransparency = 0
      L4_3 = L2_3.Title
      L4_3.TextTransparency = 0
      L4_3 = L2_3.Title
      L5_3 = Enum
      L5_3 = L5_3.Font
      L5_3 = L5_3.GothamBlack
      L4_3.Font = L5_3
      L3_3.Visible = true
    end
    L4_3 = L10_1
    L5_3 = L2_3.MouseButton1Click
    
    function L6_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4
      L0_4 = next
      L1_4 = L6_2
      L2_4 = L1_4
      L1_4 = L1_4.GetChildren
      L1_4, L2_4 = L1_4(L2_4)
      for L3_4, L4_4 in L0_4, L1_4, L2_4 do
        L6_4 = L4_4
        L5_4 = L4_4.IsA
        L7_4 = "TextButton"
        L5_4 = L5_4(L6_4, L7_4)
        if L5_4 then
          L5_4 = L4_4.Title
          L6_4 = Enum
          L6_4 = L6_4.Font
          L6_4 = L6_4.GothamSemibold
          L5_4.Font = L6_4
          L5_4 = L1_1
          L6_4 = L5_4
          L5_4 = L5_4.Create
          L7_4 = L4_4.Ico
          L8_4 = TweenInfo
          L8_4 = L8_4.new
          L9_4 = 0.25
          L10_4 = Enum
          L10_4 = L10_4.EasingStyle
          L10_4 = L10_4.Quint
          L11_4 = Enum
          L11_4 = L11_4.EasingDirection
          L11_4 = L11_4.Out
          L8_4 = L8_4(L9_4, L10_4, L11_4)
          L9_4 = {}
          L9_4.ImageTransparency = 0.4
          L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4)
          L6_4 = L5_4
          L5_4 = L5_4.Play
          L5_4(L6_4)
          L5_4 = L1_1
          L6_4 = L5_4
          L5_4 = L5_4.Create
          L7_4 = L4_4.Title
          L8_4 = TweenInfo
          L8_4 = L8_4.new
          L9_4 = 0.25
          L10_4 = Enum
          L10_4 = L10_4.EasingStyle
          L10_4 = L10_4.Quint
          L11_4 = Enum
          L11_4 = L11_4.EasingDirection
          L11_4 = L11_4.Out
          L8_4 = L8_4(L9_4, L10_4, L11_4)
          L9_4 = {}
          L9_4.TextTransparency = 0.4
          L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4)
          L6_4 = L5_4
          L5_4 = L5_4.Play
          L5_4(L6_4)
        end
      end
      L0_4 = next
      L1_4 = L13_2
      L2_4 = L1_4
      L1_4 = L1_4.GetChildren
      L1_4, L2_4 = L1_4(L2_4)
      for L3_4, L4_4 in L0_4, L1_4, L2_4 do
        L5_4 = L4_4.Name
        if L5_4 == "ItemContainer" then
          L4_4.Visible = false
        end
      end
      L0_4 = L1_1
      L1_4 = L0_4
      L0_4 = L0_4.Create
      L2_4 = L2_3
      L2_4 = L2_4.Ico
      L3_4 = TweenInfo
      L3_4 = L3_4.new
      L4_4 = 0.25
      L5_4 = Enum
      L5_4 = L5_4.EasingStyle
      L5_4 = L5_4.Quint
      L6_4 = Enum
      L6_4 = L6_4.EasingDirection
      L6_4 = L6_4.Out
      L3_4 = L3_4(L4_4, L5_4, L6_4)
      L4_4 = {}
      L4_4.ImageTransparency = 0
      L0_4 = L0_4(L1_4, L2_4, L3_4, L4_4)
      L1_4 = L0_4
      L0_4 = L0_4.Play
      L0_4(L1_4)
      L0_4 = L1_1
      L1_4 = L0_4
      L0_4 = L0_4.Create
      L2_4 = L2_3
      L2_4 = L2_4.Title
      L3_4 = TweenInfo
      L3_4 = L3_4.new
      L4_4 = 0.25
      L5_4 = Enum
      L5_4 = L5_4.EasingStyle
      L5_4 = L5_4.Quint
      L6_4 = Enum
      L6_4 = L6_4.EasingDirection
      L6_4 = L6_4.Out
      L3_4 = L3_4(L4_4, L5_4, L6_4)
      L4_4 = {}
      L4_4.TextTransparency = 0
      L0_4 = L0_4(L1_4, L2_4, L3_4, L4_4)
      L1_4 = L0_4
      L0_4 = L0_4.Play
      L0_4(L1_4)
      L0_4 = L2_3
      L0_4 = L0_4.Title
      L1_4 = Enum
      L1_4 = L1_4.Font
      L1_4 = L1_4.GothamBlack
      L0_4.Font = L1_4
      L0_4 = L3_3
      L0_4.Visible = true
    end
    
    L4_3(L5_3, L6_3)
    
    function L4_3(A0_4)
      local L1_4, L2_4
      L1_4 = {}
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5
        L2_5 = L19_1
        L3_5 = L16_1
        L4_5 = L15_1
        L5_5 = L14_1
        L6_5 = "RoundFrame"
        L7_5 = Color3
        L7_5 = L7_5.fromRGB
        L8_5 = 255
        L9_5 = 255
        L10_5 = 255
        L7_5 = L7_5(L8_5, L9_5, L10_5)
        L8_5 = 0
        L9_5 = 5
        L5_5 = L5_5(L6_5, L7_5, L8_5, L9_5)
        L6_5 = {}
        L7_5 = UDim2
        L7_5 = L7_5.new
        L8_5 = 1
        L9_5 = 0
        L10_5 = 0
        L11_5 = 30
        L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
        L6_5.Size = L7_5
        L6_5.BackgroundTransparency = 0.7
        L7_5 = A0_4
        L6_5.Parent = L7_5
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = {}
        L6_5 = L19_1
        L7_5 = L15_1
        L8_5 = L14_1
        L9_5 = "Label"
        L10_5 = A1_5
        L11_5 = 15
        L8_5 = L8_5(L9_5, L10_5, L11_5)
        L9_5 = {}
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 1
        L12_5 = -12
        L13_5 = 1
        L14_5 = 0
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Size = L10_5
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 0
        L12_5 = 12
        L13_5 = 0
        L14_5 = 0
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Position = L10_5
        L10_5 = Enum
        L10_5 = L10_5.Font
        L10_5 = L10_5.GothamBold
        L9_5.Font = L10_5
        L9_5.Name = "Content"
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = "Text"
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = L19_1
        L8_5 = L14_1
        L9_5 = "Stroke"
        L8_5 = L8_5(L9_5)
        L9_5 = "Stroke"
        L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5 = L7_5(L8_5, L9_5)
        L5_5[1] = L6_5
        L5_5[2] = L7_5
        L5_5[3] = L8_5
        L5_5[4] = L9_5
        L5_5[5] = L10_5
        L5_5[6] = L11_5
        L5_5[7] = L12_5
        L5_5[8] = L13_5
        L5_5[9] = L14_5
        L3_5 = L3_5(L4_5, L5_5)
        L4_5 = "Second"
        L2_5 = L2_5(L3_5, L4_5)
        L3_5 = {}
        
        function L4_5(A0_6, A1_6)
          local L2_6, L3_6
          L2_6 = L2_5
          L2_6 = L2_6.Content
          L2_6.Text = A1_6
        end
        
        L3_5.Set = L4_5
      end
      
      L1_4.AddLabel = L2_4
      
      function L2_4(A0_5, A1_5, A2_5)
        local L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5
        if not A1_5 then
          A1_5 = "Text"
        end
        if not A2_5 then
          A2_5 = "Content"
        end
        L3_5 = L19_1
        L4_5 = L16_1
        L5_5 = L15_1
        L6_5 = L14_1
        L7_5 = "RoundFrame"
        L8_5 = Color3
        L8_5 = L8_5.fromRGB
        L9_5 = 255
        L10_5 = 255
        L11_5 = 255
        L8_5 = L8_5(L9_5, L10_5, L11_5)
        L9_5 = 0
        L10_5 = 5
        L6_5 = L6_5(L7_5, L8_5, L9_5, L10_5)
        L7_5 = {}
        L8_5 = UDim2
        L8_5 = L8_5.new
        L9_5 = 1
        L10_5 = 0
        L11_5 = 0
        L12_5 = 30
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L7_5.Size = L8_5
        L7_5.BackgroundTransparency = 0.7
        L8_5 = A0_4
        L7_5.Parent = L8_5
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = {}
        L7_5 = L19_1
        L8_5 = L15_1
        L9_5 = L14_1
        L10_5 = "Label"
        L11_5 = A1_5
        L12_5 = 15
        L9_5 = L9_5(L10_5, L11_5, L12_5)
        L10_5 = {}
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 1
        L13_5 = -12
        L14_5 = 0
        L15_5 = 14
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Size = L11_5
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 0
        L13_5 = 12
        L14_5 = 0
        L15_5 = 10
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Position = L11_5
        L11_5 = Enum
        L11_5 = L11_5.Font
        L11_5 = L11_5.GothamBold
        L10_5.Font = L11_5
        L10_5.Name = "Title"
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = "Text"
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = L19_1
        L9_5 = L15_1
        L10_5 = L14_1
        L11_5 = "Label"
        L12_5 = ""
        L13_5 = 13
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = {}
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 1
        L14_5 = -24
        L15_5 = 0
        L16_5 = 0
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Size = L12_5
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 0
        L14_5 = 12
        L15_5 = 0
        L16_5 = 26
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Position = L12_5
        L12_5 = Enum
        L12_5 = L12_5.Font
        L12_5 = L12_5.GothamSemibold
        L11_5.Font = L12_5
        L11_5.Name = "Content"
        L11_5.TextWrapped = true
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = "TextDark"
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = L19_1
        L10_5 = L14_1
        L11_5 = "Stroke"
        L10_5 = L10_5(L11_5)
        L11_5 = "Stroke"
        L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5 = L9_5(L10_5, L11_5)
        L6_5[1] = L7_5
        L6_5[2] = L8_5
        L6_5[3] = L9_5
        L6_5[4] = L10_5
        L6_5[5] = L11_5
        L6_5[6] = L12_5
        L6_5[7] = L13_5
        L6_5[8] = L14_5
        L6_5[9] = L15_5
        L6_5[10] = L16_5
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = "Second"
        L3_5 = L3_5(L4_5, L5_5)
        L4_5 = L10_1
        L5_5 = L3_5.Content
        L6_5 = L5_5
        L5_5 = L5_5.GetPropertyChangedSignal
        L7_5 = "Text"
        L5_5 = L5_5(L6_5, L7_5)
        
        function L6_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6
          L0_6 = L3_5
          L0_6 = L0_6.Content
          L1_6 = UDim2
          L1_6 = L1_6.new
          L2_6 = 1
          L3_6 = -24
          L4_6 = 0
          L5_6 = L3_5
          L5_6 = L5_6.Content
          L5_6 = L5_6.TextBounds
          L5_6 = L5_6.Y
          L1_6 = L1_6(L2_6, L3_6, L4_6, L5_6)
          L0_6.Size = L1_6
          L0_6 = L3_5
          L1_6 = UDim2
          L1_6 = L1_6.new
          L2_6 = 1
          L3_6 = 0
          L4_6 = 0
          L5_6 = L3_5
          L5_6 = L5_6.Content
          L5_6 = L5_6.TextBounds
          L5_6 = L5_6.Y
          L5_6 = L5_6 + 35
          L1_6 = L1_6(L2_6, L3_6, L4_6, L5_6)
          L0_6.Size = L1_6
        end
        
        L4_5(L5_5, L6_5)
        L4_5 = L3_5.Content
        L4_5.Text = A2_5
        L4_5 = {}
        
        function L5_5(A0_6, A1_6)
          local L2_6, L3_6
          L2_6 = L3_5
          L2_6 = L2_6.Content
          L2_6.Text = A1_6
        end
        
        L4_5.Set = L5_5
      end
      
      L1_4.AddParagraph = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5
        if not A1_5 then
          L2_5 = {}
          A1_5 = L2_5
        end
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Button"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = A1_5.Icon
        if not L2_5 then
          L2_5 = "rbxassetid://3944703587"
        end
        A1_5.Icon = L2_5
        L2_5 = {}
        L3_5 = L15_1
        L4_5 = L14_1
        L5_5 = "Button"
        L4_5 = L4_5(L5_5)
        L5_5 = {}
        L6_5 = UDim2
        L6_5 = L6_5.new
        L7_5 = 1
        L8_5 = 0
        L9_5 = 1
        L10_5 = 0
        L6_5 = L6_5(L7_5, L8_5, L9_5, L10_5)
        L5_5.Size = L6_5
        L3_5 = L3_5(L4_5, L5_5)
        L4_5 = L19_1
        L5_5 = L16_1
        L6_5 = L15_1
        L7_5 = L14_1
        L8_5 = "RoundFrame"
        L9_5 = Color3
        L9_5 = L9_5.fromRGB
        L10_5 = 255
        L11_5 = 255
        L12_5 = 255
        L9_5 = L9_5(L10_5, L11_5, L12_5)
        L10_5 = 0
        L11_5 = 5
        L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
        L8_5 = {}
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 1
        L11_5 = 0
        L12_5 = 0
        L13_5 = 33
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Size = L9_5
        L9_5 = A0_4
        L8_5.Parent = L9_5
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = {}
        L8_5 = L19_1
        L9_5 = L15_1
        L10_5 = L14_1
        L11_5 = "Label"
        L12_5 = A1_5.Name
        L13_5 = 15
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = {}
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 1
        L14_5 = -12
        L15_5 = 1
        L16_5 = 0
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Size = L12_5
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 0
        L14_5 = 12
        L15_5 = 0
        L16_5 = 0
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Position = L12_5
        L12_5 = Enum
        L12_5 = L12_5.Font
        L12_5 = L12_5.GothamBold
        L11_5.Font = L12_5
        L11_5.Name = "Content"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = "Text"
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = L19_1
        L10_5 = L15_1
        L11_5 = L14_1
        L12_5 = "Image"
        L13_5 = A1_5.Icon
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = {}
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 0
        L15_5 = 20
        L16_5 = 0
        L17_5 = 20
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Size = L13_5
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 1
        L15_5 = -30
        L16_5 = 0
        L17_5 = 7
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Position = L13_5
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = "TextDark"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = L19_1
        L11_5 = L14_1
        L12_5 = "Stroke"
        L11_5 = L11_5(L12_5)
        L12_5 = "Stroke"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = L3_5
        L7_5[1] = L8_5
        L7_5[2] = L9_5
        L7_5[3] = L10_5
        L7_5[4] = L11_5
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = "Second"
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = L10_1
        L6_5 = L3_5.MouseEnter
        
        function L7_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L4_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L5_5(L6_5, L7_5)
        L5_5 = L10_1
        L6_5 = L3_5.MouseLeave
        
        function L7_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L4_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = L6_1
          L5_6 = L5_6.Themes
          L6_6 = L6_1
          L6_6 = L6_6.SelectedTheme
          L5_6 = L5_6[L6_6]
          L5_6 = L5_6.Second
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L5_5(L6_5, L7_5)
        L5_5 = L10_1
        L6_5 = L3_5.MouseButton1Up
        
        function L7_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L4_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
          L0_6 = spawn
          
          function L1_6()
            local L0_7
            L0_7 = A1_5
            L0_7 = L0_7.Callback
            L0_7()
          end
          
          L0_6(L1_6)
        end
        
        L5_5(L6_5, L7_5)
        L5_5 = L10_1
        L6_5 = L3_5.MouseButton1Down
        
        function L7_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L4_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 6
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 6
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 6
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L5_5(L6_5, L7_5)
        
        function L5_5(A0_6, A1_6)
          local L2_6, L3_6
          L2_6 = L4_5
          L2_6 = L2_6.Content
          L2_6.Text = A1_6
        end
        
        L2_5.Set = L5_5
      end
      
      L1_4.AddButton = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5
        if not A1_5 then
          L2_5 = {}
          A1_5 = L2_5
        end
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Toggle"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Default
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Default = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = A1_5.Color
        if not L2_5 then
          L2_5 = Color3
          L2_5 = L2_5.fromRGB
          L3_5 = 9
          L4_5 = 99
          L5_5 = 195
          L2_5 = L2_5(L3_5, L4_5, L5_5)
        end
        A1_5.Color = L2_5
        L2_5 = A1_5.Flag
        if not L2_5 then
          L2_5 = nil
        end
        A1_5.Flag = L2_5
        L2_5 = A1_5.Save
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Save = L2_5
        L2_5 = {}
        L3_5 = A1_5.Default
        L2_5.Value = L3_5
        L3_5 = A1_5.Save
        L2_5.Save = L3_5
        L3_5 = L15_1
        L4_5 = L14_1
        L5_5 = "Button"
        L4_5 = L4_5(L5_5)
        L5_5 = {}
        L6_5 = UDim2
        L6_5 = L6_5.new
        L7_5 = 1
        L8_5 = 0
        L9_5 = 1
        L10_5 = 0
        L6_5 = L6_5(L7_5, L8_5, L9_5, L10_5)
        L5_5.Size = L6_5
        L3_5 = L3_5(L4_5, L5_5)
        L4_5 = L16_1
        L5_5 = L15_1
        L6_5 = L14_1
        L7_5 = "RoundFrame"
        L8_5 = A1_5.Color
        L9_5 = 0
        L10_5 = 4
        L6_5 = L6_5(L7_5, L8_5, L9_5, L10_5)
        L7_5 = {}
        L8_5 = UDim2
        L8_5 = L8_5.new
        L9_5 = 0
        L10_5 = 24
        L11_5 = 0
        L12_5 = 24
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L7_5.Size = L8_5
        L8_5 = UDim2
        L8_5 = L8_5.new
        L9_5 = 1
        L10_5 = -24
        L11_5 = 0.5
        L12_5 = 0
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L7_5.Position = L8_5
        L8_5 = Vector2
        L8_5 = L8_5.new
        L9_5 = 0.5
        L10_5 = 0.5
        L8_5 = L8_5(L9_5, L10_5)
        L7_5.AnchorPoint = L8_5
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = {}
        L7_5 = L15_1
        L8_5 = L14_1
        L9_5 = "Stroke"
        L8_5 = L8_5(L9_5)
        L9_5 = {}
        L10_5 = A1_5.Color
        L9_5.Color = L10_5
        L9_5.Name = "Stroke"
        L9_5.Transparency = 0.5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = L15_1
        L9_5 = L14_1
        L10_5 = "Image"
        L11_5 = "rbxassetid://3944680095"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = {}
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 0
        L13_5 = 20
        L14_5 = 0
        L15_5 = 20
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Size = L11_5
        L11_5 = Vector2
        L11_5 = L11_5.new
        L12_5 = 0.5
        L13_5 = 0.5
        L11_5 = L11_5(L12_5, L13_5)
        L10_5.AnchorPoint = L11_5
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 0.5
        L13_5 = 0
        L14_5 = 0.5
        L15_5 = 0
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Position = L11_5
        L11_5 = Color3
        L11_5 = L11_5.fromRGB
        L12_5 = 255
        L13_5 = 255
        L14_5 = 255
        L11_5 = L11_5(L12_5, L13_5, L14_5)
        L10_5.ImageColor3 = L11_5
        L10_5.Name = "Ico"
        L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5 = L8_5(L9_5, L10_5)
        L6_5[1] = L7_5
        L6_5[2] = L8_5
        L6_5[3] = L9_5
        L6_5[4] = L10_5
        L6_5[5] = L11_5
        L6_5[6] = L12_5
        L6_5[7] = L13_5
        L6_5[8] = L14_5
        L6_5[9] = L15_5
        L6_5[10] = L16_5
        L6_5[11] = L17_5
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = L19_1
        L6_5 = L16_1
        L7_5 = L15_1
        L8_5 = L14_1
        L9_5 = "RoundFrame"
        L10_5 = Color3
        L10_5 = L10_5.fromRGB
        L11_5 = 255
        L12_5 = 255
        L13_5 = 255
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = 0
        L12_5 = 5
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L9_5 = {}
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 1
        L12_5 = 0
        L13_5 = 0
        L14_5 = 38
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Size = L10_5
        L10_5 = A0_4
        L9_5.Parent = L10_5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = {}
        L9_5 = L19_1
        L10_5 = L15_1
        L11_5 = L14_1
        L12_5 = "Label"
        L13_5 = A1_5.Name
        L14_5 = 15
        L11_5 = L11_5(L12_5, L13_5, L14_5)
        L12_5 = {}
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 1
        L15_5 = -12
        L16_5 = 1
        L17_5 = 0
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Size = L13_5
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 0
        L15_5 = 12
        L16_5 = 0
        L17_5 = 0
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Position = L13_5
        L13_5 = Enum
        L13_5 = L13_5.Font
        L13_5 = L13_5.GothamBold
        L12_5.Font = L13_5
        L12_5.Name = "Content"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = "Text"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = L19_1
        L11_5 = L14_1
        L12_5 = "Stroke"
        L11_5 = L11_5(L12_5)
        L12_5 = "Stroke"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = L4_5
        L12_5 = L3_5
        L8_5[1] = L9_5
        L8_5[2] = L10_5
        L8_5[3] = L11_5
        L8_5[4] = L12_5
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = "Second"
        L5_5 = L5_5(L6_5, L7_5)
        
        function L6_5(A0_6, A1_6)
          local L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6, L11_6
          L2_6 = L2_5
          L2_6.Value = A1_6
          L2_6 = L1_1
          L3_6 = L2_6
          L2_6 = L2_6.Create
          L4_6 = L4_5
          L5_6 = TweenInfo
          L5_6 = L5_6.new
          L6_6 = 0.3
          L7_6 = Enum
          L7_6 = L7_6.EasingStyle
          L7_6 = L7_6.Quint
          L8_6 = Enum
          L8_6 = L8_6.EasingDirection
          L8_6 = L8_6.Out
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L6_6 = {}
          L7_6 = L2_5
          L7_6 = L7_6.Value
          if L7_6 then
            L7_6 = A1_5
            L7_6 = L7_6.Color
            if L7_6 then
              goto lbl_29
            end
          end
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L7_6 = L7_6.Default
          L7_6 = L7_6.Divider
          ::lbl_29::
          L6_6.BackgroundColor3 = L7_6
          L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
          L3_6 = L2_6
          L2_6 = L2_6.Play
          L2_6(L3_6)
          L2_6 = L1_1
          L3_6 = L2_6
          L2_6 = L2_6.Create
          L4_6 = L4_5
          L4_6 = L4_6.Stroke
          L5_6 = TweenInfo
          L5_6 = L5_6.new
          L6_6 = 0.3
          L7_6 = Enum
          L7_6 = L7_6.EasingStyle
          L7_6 = L7_6.Quint
          L8_6 = Enum
          L8_6 = L8_6.EasingDirection
          L8_6 = L8_6.Out
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L6_6 = {}
          L7_6 = L2_5
          L7_6 = L7_6.Value
          if L7_6 then
            L7_6 = A1_5
            L7_6 = L7_6.Color
            if L7_6 then
              goto lbl_60
            end
          end
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L7_6 = L7_6.Default
          L7_6 = L7_6.Stroke
          ::lbl_60::
          L6_6.Color = L7_6
          L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
          L3_6 = L2_6
          L2_6 = L2_6.Play
          L2_6(L3_6)
          L2_6 = L1_1
          L3_6 = L2_6
          L2_6 = L2_6.Create
          L4_6 = L4_5
          L4_6 = L4_6.Ico
          L5_6 = TweenInfo
          L5_6 = L5_6.new
          L6_6 = 0.3
          L7_6 = Enum
          L7_6 = L7_6.EasingStyle
          L7_6 = L7_6.Quint
          L8_6 = Enum
          L8_6 = L8_6.EasingDirection
          L8_6 = L8_6.Out
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L6_6 = {}
          L7_6 = L2_5
          L7_6 = L7_6.Value
          if L7_6 then
            L7_6 = 0
            if L7_6 then
              goto lbl_87
            end
          end
          L7_6 = 1
          ::lbl_87::
          L6_6.ImageTransparency = L7_6
          L7_6 = L2_5
          L7_6 = L7_6.Value
          if L7_6 then
            L7_6 = UDim2
            L7_6 = L7_6.new
            L8_6 = 0
            L9_6 = 20
            L10_6 = 0
            L11_6 = 20
            L7_6 = L7_6(L8_6, L9_6, L10_6, L11_6)
            if L7_6 then
              goto lbl_108
            end
          end
          L7_6 = UDim2
          L7_6 = L7_6.new
          L8_6 = 0
          L9_6 = 8
          L10_6 = 0
          L11_6 = 8
          L7_6 = L7_6(L8_6, L9_6, L10_6, L11_6)
          ::lbl_108::
          L6_6.Size = L7_6
          L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
          L3_6 = L2_6
          L2_6 = L2_6.Play
          L2_6(L3_6)
          L2_6 = A1_5
          L2_6 = L2_6.Callback
          L3_6 = L2_5
          L3_6 = L3_6.Value
          L2_6(L3_6)
        end
        
        L2_5.Set = L6_5
        L7_5 = L2_5
        L6_5 = L2_5.Set
        L8_5 = L2_5.Value
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L3_5.MouseEnter
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L3_5.MouseLeave
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = L6_1
          L5_6 = L5_6.Themes
          L6_6 = L6_1
          L6_6 = L6_6.SelectedTheme
          L5_6 = L5_6[L6_6]
          L5_6 = L5_6.Second
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L3_5.MouseButton1Up
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
          L0_6 = L24_1
          L1_6 = game
          L1_6 = L1_6.GameId
          L0_6(L1_6)
          L0_6 = L2_5
          L1_6 = L0_6
          L0_6 = L0_6.Set
          L2_6 = L2_5
          L2_6 = L2_6.Value
          L2_6 = not L2_6
          L0_6(L1_6, L2_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L3_5.MouseButton1Down
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 6
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 6
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 6
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = A1_5.Flag
        if L6_5 then
          L6_5 = L6_1
          L6_5 = L6_5.Flags
          L7_5 = A1_5.Flag
          L6_5[L7_5] = L2_5
        end
      end
      
      L1_4.AddToggle = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5
        if not A1_5 then
          L2_5 = {}
          A1_5 = L2_5
        end
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Slider"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Min
        if not L2_5 then
          L2_5 = 0
        end
        A1_5.Min = L2_5
        L2_5 = A1_5.Max
        if not L2_5 then
          L2_5 = 100
        end
        A1_5.Max = L2_5
        L2_5 = A1_5.Increment
        if not L2_5 then
          L2_5 = 1
        end
        A1_5.Increment = L2_5
        L2_5 = A1_5.Default
        if not L2_5 then
          L2_5 = 50
        end
        A1_5.Default = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = A1_5.ValueName
        if not L2_5 then
          L2_5 = ""
        end
        A1_5.ValueName = L2_5
        L2_5 = A1_5.Color
        if not L2_5 then
          L2_5 = Color3
          L2_5 = L2_5.fromRGB
          L3_5 = 9
          L4_5 = 149
          L5_5 = 98
          L2_5 = L2_5(L3_5, L4_5, L5_5)
        end
        A1_5.Color = L2_5
        L2_5 = A1_5.Flag
        if not L2_5 then
          L2_5 = nil
        end
        A1_5.Flag = L2_5
        L2_5 = A1_5.Save
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Save = L2_5
        L2_5 = {}
        L3_5 = A1_5.Default
        L2_5.Value = L3_5
        L3_5 = A1_5.Save
        L2_5.Save = L3_5
        L3_5 = false
        L4_5 = L16_1
        L5_5 = L15_1
        L6_5 = L14_1
        L7_5 = "RoundFrame"
        L8_5 = A1_5.Color
        L9_5 = 0
        L10_5 = 5
        L6_5 = L6_5(L7_5, L8_5, L9_5, L10_5)
        L7_5 = {}
        L8_5 = UDim2
        L8_5 = L8_5.new
        L9_5 = 0
        L10_5 = 0
        L11_5 = 1
        L12_5 = 0
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L7_5.Size = L8_5
        L7_5.BackgroundTransparency = 0.3
        L7_5.ClipsDescendants = true
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = {}
        L7_5 = L19_1
        L8_5 = L15_1
        L9_5 = L14_1
        L10_5 = "Label"
        L11_5 = "value"
        L12_5 = 13
        L9_5 = L9_5(L10_5, L11_5, L12_5)
        L10_5 = {}
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 1
        L13_5 = -12
        L14_5 = 0
        L15_5 = 14
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Size = L11_5
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 0
        L13_5 = 12
        L14_5 = 0
        L15_5 = 6
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Position = L11_5
        L11_5 = Enum
        L11_5 = L11_5.Font
        L11_5 = L11_5.GothamBold
        L10_5.Font = L11_5
        L10_5.Name = "Value"
        L10_5.TextTransparency = 0
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = "Text"
        L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5 = L7_5(L8_5, L9_5)
        L6_5[1] = L7_5
        L6_5[2] = L8_5
        L6_5[3] = L9_5
        L6_5[4] = L10_5
        L6_5[5] = L11_5
        L6_5[6] = L12_5
        L6_5[7] = L13_5
        L6_5[8] = L14_5
        L6_5[9] = L15_5
        L6_5[10] = L16_5
        L6_5[11] = L17_5
        L6_5[12] = L18_5
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = L16_1
        L6_5 = L15_1
        L7_5 = L14_1
        L8_5 = "RoundFrame"
        L9_5 = A1_5.Color
        L10_5 = 0
        L11_5 = 5
        L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
        L8_5 = {}
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 1
        L11_5 = -24
        L12_5 = 0
        L13_5 = 26
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Size = L9_5
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 0
        L11_5 = 12
        L12_5 = 0
        L13_5 = 30
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Position = L9_5
        L8_5.BackgroundTransparency = 0.9
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = {}
        L8_5 = L15_1
        L9_5 = L14_1
        L10_5 = "Stroke"
        L9_5 = L9_5(L10_5)
        L10_5 = {}
        L11_5 = A1_5.Color
        L10_5.Color = L11_5
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = L19_1
        L10_5 = L15_1
        L11_5 = L14_1
        L12_5 = "Label"
        L13_5 = "value"
        L14_5 = 13
        L11_5 = L11_5(L12_5, L13_5, L14_5)
        L12_5 = {}
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 1
        L15_5 = -12
        L16_5 = 0
        L17_5 = 14
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Size = L13_5
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 0
        L15_5 = 12
        L16_5 = 0
        L17_5 = 6
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Position = L13_5
        L13_5 = Enum
        L13_5 = L13_5.Font
        L13_5 = L13_5.GothamBold
        L12_5.Font = L13_5
        L12_5.Name = "Value"
        L12_5.TextTransparency = 0.8
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = "Text"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = L4_5
        L7_5[1] = L8_5
        L7_5[2] = L9_5
        L7_5[3] = L10_5
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = L19_1
        L7_5 = L16_1
        L8_5 = L15_1
        L9_5 = L14_1
        L10_5 = "RoundFrame"
        L11_5 = Color3
        L11_5 = L11_5.fromRGB
        L12_5 = 255
        L13_5 = 255
        L14_5 = 255
        L11_5 = L11_5(L12_5, L13_5, L14_5)
        L12_5 = 0
        L13_5 = 4
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L10_5 = {}
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 1
        L13_5 = 0
        L14_5 = 0
        L15_5 = 65
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Size = L11_5
        L11_5 = A0_4
        L10_5.Parent = L11_5
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = {}
        L10_5 = L19_1
        L11_5 = L15_1
        L12_5 = L14_1
        L13_5 = "Label"
        L14_5 = A1_5.Name
        L15_5 = 15
        L12_5 = L12_5(L13_5, L14_5, L15_5)
        L13_5 = {}
        L14_5 = UDim2
        L14_5 = L14_5.new
        L15_5 = 1
        L16_5 = -12
        L17_5 = 0
        L18_5 = 14
        L14_5 = L14_5(L15_5, L16_5, L17_5, L18_5)
        L13_5.Size = L14_5
        L14_5 = UDim2
        L14_5 = L14_5.new
        L15_5 = 0
        L16_5 = 12
        L17_5 = 0
        L18_5 = 10
        L14_5 = L14_5(L15_5, L16_5, L17_5, L18_5)
        L13_5.Position = L14_5
        L14_5 = Enum
        L14_5 = L14_5.Font
        L14_5 = L14_5.GothamBold
        L13_5.Font = L14_5
        L13_5.Name = "Content"
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = "Text"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = L19_1
        L12_5 = L14_1
        L13_5 = "Stroke"
        L12_5 = L12_5(L13_5)
        L13_5 = "Stroke"
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = L5_5
        L9_5[1] = L10_5
        L9_5[2] = L11_5
        L9_5[3] = L12_5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = "Second"
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = L5_5.InputBegan
        L8_5 = L7_5
        L7_5 = L7_5.Connect
        
        function L9_5(A0_6)
          local L1_6, L2_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = true
            L3_5 = L1_6
          end
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L5_5.InputEnded
        L8_5 = L7_5
        L7_5 = L7_5.Connect
        
        function L9_5(A0_6)
          local L1_6, L2_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = false
            L3_5 = L1_6
          end
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L0_1
        L7_5 = L7_5.InputChanged
        L8_5 = L7_5
        L7_5 = L7_5.Connect
        
        function L9_5(A0_6)
          local L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
          L1_6 = L3_5
          if L1_6 then
            L1_6 = A0_6.UserInputType
            L2_6 = Enum
            L2_6 = L2_6.UserInputType
            L2_6 = L2_6.MouseMovement
            if L1_6 == L2_6 then
              L1_6 = math
              L1_6 = L1_6.clamp
              L2_6 = A0_6.Position
              L2_6 = L2_6.X
              L3_6 = L5_5
              L3_6 = L3_6.AbsolutePosition
              L3_6 = L3_6.X
              L2_6 = L2_6 - L3_6
              L3_6 = L5_5
              L3_6 = L3_6.AbsoluteSize
              L3_6 = L3_6.X
              L2_6 = L2_6 / L3_6
              L3_6 = 0
              L4_6 = 1
              L1_6 = L1_6(L2_6, L3_6, L4_6)
              L2_6 = L2_5
              L3_6 = L2_6
              L2_6 = L2_6.Set
              L4_6 = A1_5
              L4_6 = L4_6.Min
              L5_6 = A1_5
              L5_6 = L5_6.Max
              L6_6 = A1_5
              L6_6 = L6_6.Min
              L5_6 = L5_6 - L6_6
              L5_6 = L5_6 * L1_6
              L4_6 = L4_6 + L5_6
              L2_6(L3_6, L4_6)
              L2_6 = L24_1
              L3_6 = game
              L3_6 = L3_6.GameId
              L2_6(L3_6)
            end
          end
        end
        
        L7_5(L8_5, L9_5)
        
        function L7_5(A0_6, A1_6)
          local L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6
          L2_6 = math
          L2_6 = L2_6.clamp
          L3_6 = L17_1
          L4_6 = A1_6
          L5_6 = A1_5
          L5_6 = L5_6.Increment
          L3_6 = L3_6(L4_6, L5_6)
          L4_6 = A1_5
          L4_6 = L4_6.Min
          L5_6 = A1_5
          L5_6 = L5_6.Max
          L2_6 = L2_6(L3_6, L4_6, L5_6)
          A0_6.Value = L2_6
          L2_6 = L1_1
          L3_6 = L2_6
          L2_6 = L2_6.Create
          L4_6 = L4_5
          L5_6 = TweenInfo
          L5_6 = L5_6.new
          L6_6 = 0.15
          L7_6 = Enum
          L7_6 = L7_6.EasingStyle
          L7_6 = L7_6.Quad
          L8_6 = Enum
          L8_6 = L8_6.EasingDirection
          L8_6 = L8_6.Out
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L6_6 = {}
          L7_6 = UDim2
          L7_6 = L7_6.fromScale
          L8_6 = A0_6.Value
          L9_6 = A1_5
          L9_6 = L9_6.Min
          L8_6 = L8_6 - L9_6
          L9_6 = A1_5
          L9_6 = L9_6.Max
          L10_6 = A1_5
          L10_6 = L10_6.Min
          L9_6 = L9_6 - L10_6
          L8_6 = L8_6 / L9_6
          L9_6 = 1
          L7_6 = L7_6(L8_6, L9_6)
          L6_6.Size = L7_6
          L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
          L3_6 = L2_6
          L2_6 = L2_6.Play
          L2_6(L3_6)
          L2_6 = L5_5
          L2_6 = L2_6.Value
          L3_6 = tostring
          L4_6 = A0_6.Value
          L3_6 = L3_6(L4_6)
          L4_6 = " "
          L5_6 = A1_5
          L5_6 = L5_6.ValueName
          L3_6 = L3_6 .. L4_6 .. L5_6
          L2_6.Text = L3_6
          L2_6 = L4_5
          L2_6 = L2_6.Value
          L3_6 = tostring
          L4_6 = A0_6.Value
          L3_6 = L3_6(L4_6)
          L4_6 = " "
          L5_6 = A1_5
          L5_6 = L5_6.ValueName
          L3_6 = L3_6 .. L4_6 .. L5_6
          L2_6.Text = L3_6
          L2_6 = A1_5
          L2_6 = L2_6.Callback
          L3_6 = A0_6.Value
          L2_6(L3_6)
        end
        
        L2_5.Set = L7_5
        L8_5 = L2_5
        L7_5 = L2_5.Set
        L9_5 = L2_5.Value
        L7_5(L8_5, L9_5)
        L7_5 = A1_5.Flag
        if L7_5 then
          L7_5 = L6_1
          L7_5 = L7_5.Flags
          L8_5 = A1_5.Flag
          L7_5[L8_5] = L2_5
        end
      end
      
      L1_4.AddSlider = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5
        if not A1_5 then
          L2_5 = {}
          A1_5 = L2_5
        end
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Dropdown"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Options
        if not L2_5 then
          L2_5 = {}
        end
        A1_5.Options = L2_5
        L2_5 = A1_5.Default
        if not L2_5 then
          L2_5 = ""
        end
        A1_5.Default = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = A1_5.Flag
        if not L2_5 then
          L2_5 = nil
        end
        A1_5.Flag = L2_5
        L2_5 = A1_5.Save
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Save = L2_5
        L2_5 = {}
        L3_5 = A1_5.Default
        L2_5.Value = L3_5
        L3_5 = A1_5.Options
        L2_5.Options = L3_5
        L3_5 = {}
        L2_5.Buttons = L3_5
        L2_5.Toggled = false
        L2_5.Type = "Dropdown"
        L3_5 = A1_5.Save
        L2_5.Save = L3_5
        L3_5 = 5
        L4_5 = table
        L4_5 = L4_5.find
        L5_5 = L2_5.Options
        L6_5 = L2_5.Value
        L4_5 = L4_5(L5_5, L6_5)
        if not L4_5 then
          L2_5.Value = "..."
        end
        L4_5 = L14_1
        L5_5 = "List"
        L4_5 = L4_5(L5_5)
        L5_5 = L19_1
        L6_5 = L15_1
        L7_5 = L16_1
        L8_5 = L14_1
        L9_5 = "ScrollFrame"
        L10_5 = Color3
        L10_5 = L10_5.fromRGB
        L11_5 = 40
        L12_5 = 40
        L13_5 = 40
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = 4
        L8_5 = L8_5(L9_5, L10_5, L11_5)
        L9_5 = {}
        L10_5 = L4_5
        L9_5[1] = L10_5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = {}
        L9_5 = A0_4
        L8_5.Parent = L9_5
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 0
        L11_5 = 0
        L12_5 = 0
        L13_5 = 38
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Position = L9_5
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 1
        L11_5 = 0
        L12_5 = 1
        L13_5 = -38
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Size = L9_5
        L8_5.ClipsDescendants = true
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = "Divider"
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = L15_1
        L7_5 = L14_1
        L8_5 = "Button"
        L7_5 = L7_5(L8_5)
        L8_5 = {}
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 1
        L11_5 = 0
        L12_5 = 1
        L13_5 = 0
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Size = L9_5
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = L19_1
        L8_5 = L16_1
        L9_5 = L15_1
        L10_5 = L14_1
        L11_5 = "RoundFrame"
        L12_5 = Color3
        L12_5 = L12_5.fromRGB
        L13_5 = 255
        L14_5 = 255
        L15_5 = 255
        L12_5 = L12_5(L13_5, L14_5, L15_5)
        L13_5 = 0
        L14_5 = 5
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L11_5 = {}
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 1
        L14_5 = 0
        L15_5 = 0
        L16_5 = 38
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Size = L12_5
        L12_5 = A0_4
        L11_5.Parent = L12_5
        L11_5.ClipsDescendants = true
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = {}
        L11_5 = L5_5
        L12_5 = L15_1
        L13_5 = L16_1
        L14_5 = L14_1
        L15_5 = "TFrame"
        L14_5 = L14_5(L15_5)
        L15_5 = {}
        L16_5 = L19_1
        L17_5 = L15_1
        L18_5 = L14_1
        L19_5 = "Label"
        L20_5 = A1_5.Name
        L21_5 = 15
        L18_5 = L18_5(L19_5, L20_5, L21_5)
        L19_5 = {}
        L20_5 = UDim2
        L20_5 = L20_5.new
        L21_5 = 1
        L22_5 = -12
        L23_5 = 1
        L24_5 = 0
        L20_5 = L20_5(L21_5, L22_5, L23_5, L24_5)
        L19_5.Size = L20_5
        L20_5 = UDim2
        L20_5 = L20_5.new
        L21_5 = 0
        L22_5 = 12
        L23_5 = 0
        L24_5 = 0
        L20_5 = L20_5(L21_5, L22_5, L23_5, L24_5)
        L19_5.Position = L20_5
        L20_5 = Enum
        L20_5 = L20_5.Font
        L20_5 = L20_5.GothamBold
        L19_5.Font = L20_5
        L19_5.Name = "Content"
        L17_5 = L17_5(L18_5, L19_5)
        L18_5 = "Text"
        L16_5 = L16_5(L17_5, L18_5)
        L17_5 = L19_1
        L18_5 = L15_1
        L19_5 = L14_1
        L20_5 = "Image"
        L21_5 = "rbxassetid://7072706796"
        L19_5 = L19_5(L20_5, L21_5)
        L20_5 = {}
        L21_5 = UDim2
        L21_5 = L21_5.new
        L22_5 = 0
        L23_5 = 20
        L24_5 = 0
        L25_5 = 20
        L21_5 = L21_5(L22_5, L23_5, L24_5, L25_5)
        L20_5.Size = L21_5
        L21_5 = Vector2
        L21_5 = L21_5.new
        L22_5 = 0
        L23_5 = 0.5
        L21_5 = L21_5(L22_5, L23_5)
        L20_5.AnchorPoint = L21_5
        L21_5 = UDim2
        L21_5 = L21_5.new
        L22_5 = 1
        L23_5 = -30
        L24_5 = 0.5
        L25_5 = 0
        L21_5 = L21_5(L22_5, L23_5, L24_5, L25_5)
        L20_5.Position = L21_5
        L21_5 = Color3
        L21_5 = L21_5.fromRGB
        L22_5 = 240
        L23_5 = 240
        L24_5 = 240
        L21_5 = L21_5(L22_5, L23_5, L24_5)
        L20_5.ImageColor3 = L21_5
        L20_5.Name = "Ico"
        L18_5 = L18_5(L19_5, L20_5)
        L19_5 = "TextDark"
        L17_5 = L17_5(L18_5, L19_5)
        L18_5 = L19_1
        L19_5 = L15_1
        L20_5 = L14_1
        L21_5 = "Label"
        L22_5 = "Selected"
        L23_5 = 13
        L20_5 = L20_5(L21_5, L22_5, L23_5)
        L21_5 = {}
        L22_5 = UDim2
        L22_5 = L22_5.new
        L23_5 = 1
        L24_5 = -40
        L25_5 = 1
        L26_5 = 0
        L22_5 = L22_5(L23_5, L24_5, L25_5, L26_5)
        L21_5.Size = L22_5
        L22_5 = Enum
        L22_5 = L22_5.Font
        L22_5 = L22_5.Gotham
        L21_5.Font = L22_5
        L21_5.Name = "Selected"
        L22_5 = Enum
        L22_5 = L22_5.TextXAlignment
        L22_5 = L22_5.Right
        L21_5.TextXAlignment = L22_5
        L19_5 = L19_5(L20_5, L21_5)
        L20_5 = "TextDark"
        L18_5 = L18_5(L19_5, L20_5)
        L19_5 = L19_1
        L20_5 = L15_1
        L21_5 = L14_1
        L22_5 = "Frame"
        L21_5 = L21_5(L22_5)
        L22_5 = {}
        L23_5 = UDim2
        L23_5 = L23_5.new
        L24_5 = 1
        L25_5 = 0
        L26_5 = 0
        L27_5 = 1
        L23_5 = L23_5(L24_5, L25_5, L26_5, L27_5)
        L22_5.Size = L23_5
        L23_5 = UDim2
        L23_5 = L23_5.new
        L24_5 = 0
        L25_5 = 0
        L26_5 = 1
        L27_5 = -1
        L23_5 = L23_5(L24_5, L25_5, L26_5, L27_5)
        L22_5.Position = L23_5
        L22_5.Name = "Line"
        L22_5.Visible = false
        L20_5 = L20_5(L21_5, L22_5)
        L21_5 = "Stroke"
        L19_5 = L19_5(L20_5, L21_5)
        L20_5 = L6_5
        L15_5[1] = L16_5
        L15_5[2] = L17_5
        L15_5[3] = L18_5
        L15_5[4] = L19_5
        L15_5[5] = L20_5
        L13_5 = L13_5(L14_5, L15_5)
        L14_5 = {}
        L15_5 = UDim2
        L15_5 = L15_5.new
        L16_5 = 1
        L17_5 = 0
        L18_5 = 0
        L19_5 = 38
        L15_5 = L15_5(L16_5, L17_5, L18_5, L19_5)
        L14_5.Size = L15_5
        L14_5.ClipsDescendants = true
        L14_5.Name = "F"
        L12_5 = L12_5(L13_5, L14_5)
        L13_5 = L19_1
        L14_5 = L14_1
        L15_5 = "Stroke"
        L14_5 = L14_5(L15_5)
        L15_5 = "Stroke"
        L13_5 = L13_5(L14_5, L15_5)
        L14_5 = L14_1
        L15_5 = "Corner"
        L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5 = L14_5(L15_5)
        L10_5[1] = L11_5
        L10_5[2] = L12_5
        L10_5[3] = L13_5
        L10_5[4] = L14_5
        L10_5[5] = L15_5
        L10_5[6] = L16_5
        L10_5[7] = L17_5
        L10_5[8] = L18_5
        L10_5[9] = L19_5
        L10_5[10] = L20_5
        L10_5[11] = L21_5
        L10_5[12] = L22_5
        L10_5[13] = L23_5
        L10_5[14] = L24_5
        L10_5[15] = L25_5
        L10_5[16] = L26_5
        L10_5[17] = L27_5
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = "Second"
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = L10_1
        L10_5 = L4_5
        L9_5 = L4_5.GetPropertyChangedSignal
        L11_5 = "AbsoluteContentSize"
        L9_5 = L9_5(L10_5, L11_5)
        
        function L10_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6
          L0_6 = L5_5
          L1_6 = UDim2
          L1_6 = L1_6.new
          L2_6 = 0
          L3_6 = 0
          L4_6 = 0
          L5_6 = L4_5
          L5_6 = L5_6.AbsoluteContentSize
          L5_6 = L5_6.Y
          L1_6 = L1_6(L2_6, L3_6, L4_6, L5_6)
          L0_6.CanvasSize = L1_6
        end
        
        L8_5(L9_5, L10_5)
        
        function L8_5(A0_6)
          local L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6, L11_6, L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6
          L1_6 = pairs
          L2_6 = A0_6
          L1_6, L2_6, L3_6 = L1_6(L2_6)
          for L4_6, L5_6 in L1_6, L2_6, L3_6 do
            L6_6 = L19_1
            L7_6 = L15_1
            L8_6 = L16_1
            L9_6 = L14_1
            L10_6 = "Button"
            L11_6 = Color3
            L11_6 = L11_6.fromRGB
            L12_6 = 40
            L13_6 = 40
            L14_6 = 40
            L11_6, L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6 = L11_6(L12_6, L13_6, L14_6)
            L9_6 = L9_6(L10_6, L11_6, L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6)
            L10_6 = {}
            L11_6 = L14_1
            L12_6 = "Corner"
            L13_6 = 0
            L14_6 = 6
            L11_6 = L11_6(L12_6, L13_6, L14_6)
            L12_6 = L19_1
            L13_6 = L15_1
            L14_6 = L14_1
            L15_6 = "Label"
            L16_6 = L5_6
            L17_6 = 13
            L18_6 = 0.4
            L14_6 = L14_6(L15_6, L16_6, L17_6, L18_6)
            L15_6 = {}
            L16_6 = UDim2
            L16_6 = L16_6.new
            L17_6 = 0
            L18_6 = 8
            L19_6 = 0
            L20_6 = 0
            L16_6 = L16_6(L17_6, L18_6, L19_6, L20_6)
            L15_6.Position = L16_6
            L16_6 = UDim2
            L16_6 = L16_6.new
            L17_6 = 1
            L18_6 = -8
            L19_6 = 1
            L20_6 = 0
            L16_6 = L16_6(L17_6, L18_6, L19_6, L20_6)
            L15_6.Size = L16_6
            L15_6.Name = "Title"
            L13_6 = L13_6(L14_6, L15_6)
            L14_6 = "Text"
            L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6 = L12_6(L13_6, L14_6)
            L10_6[1] = L11_6
            L10_6[2] = L12_6
            L10_6[3] = L13_6
            L10_6[4] = L14_6
            L10_6[5] = L15_6
            L10_6[6] = L16_6
            L10_6[7] = L17_6
            L10_6[8] = L18_6
            L10_6[9] = L19_6
            L10_6[10] = L20_6
            L8_6 = L8_6(L9_6, L10_6)
            L9_6 = {}
            L10_6 = L5_5
            L9_6.Parent = L10_6
            L10_6 = UDim2
            L10_6 = L10_6.new
            L11_6 = 1
            L12_6 = 0
            L13_6 = 0
            L14_6 = 28
            L10_6 = L10_6(L11_6, L12_6, L13_6, L14_6)
            L9_6.Size = L10_6
            L9_6.BackgroundTransparency = 1
            L9_6.ClipsDescendants = true
            L7_6 = L7_6(L8_6, L9_6)
            L8_6 = "Divider"
            L6_6 = L6_6(L7_6, L8_6)
            L7_6 = L10_1
            L8_6 = L6_6.MouseButton1Click
            
            function L9_6()
              local L0_7, L1_7, L2_7
              L0_7 = L2_5
              L1_7 = L0_7
              L0_7 = L0_7.Set
              L2_7 = L5_6
              L0_7(L1_7, L2_7)
              L0_7 = L24_1
              L1_7 = game
              L1_7 = L1_7.GameId
              L0_7(L1_7)
            end
            
            L7_6(L8_6, L9_6)
            L7_6 = L2_5
            L7_6 = L7_6.Buttons
            L7_6[L5_6] = L6_6
          end
        end
        
        function L9_5(A0_6, A1_6, A2_6)
          local L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          if A2_6 then
            L3_6 = pairs
            L4_6 = L2_5
            L4_6 = L4_6.Buttons
            L3_6, L4_6, L5_6 = L3_6(L4_6)
            for L6_6, L7_6 in L3_6, L4_6, L5_6 do
              L9_6 = L7_6
              L8_6 = L7_6.Destroy
              L8_6(L9_6)
            end
            L3_6 = table
            L3_6 = L3_6.clear
            L4_6 = L2_5
            L4_6 = L4_6.Options
            L3_6(L4_6)
            L3_6 = table
            L3_6 = L3_6.clear
            L4_6 = L2_5
            L4_6 = L4_6.Buttons
            L3_6(L4_6)
          end
          L3_6 = L2_5
          L3_6.Options = A1_6
          L3_6 = L8_5
          L4_6 = L2_5
          L4_6 = L4_6.Options
          L3_6(L4_6)
        end
        
        L2_5.Refresh = L9_5
        
        function L9_5(A0_6, A1_6)
          local L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6, L11_6, L12_6, L13_6
          L2_6 = table
          L2_6 = L2_6.find
          L3_6 = L2_5
          L3_6 = L3_6.Options
          L4_6 = A1_6
          L2_6 = L2_6(L3_6, L4_6)
          if not L2_6 then
            L2_6 = L2_5
            L2_6.Value = "..."
            L2_6 = L7_5
            L2_6 = L2_6.F
            L2_6 = L2_6.Selected
            L3_6 = L2_5
            L3_6 = L3_6.Value
            L2_6.Text = L3_6
            L2_6 = pairs
            L3_6 = L2_5
            L3_6 = L3_6.Buttons
            L2_6, L3_6, L4_6 = L2_6(L3_6)
            for L5_6, L6_6 in L2_6, L3_6, L4_6 do
              L7_6 = L1_1
              L8_6 = L7_6
              L7_6 = L7_6.Create
              L9_6 = L6_6
              L10_6 = TweenInfo
              L10_6 = L10_6.new
              L11_6 = 0.15
              L12_6 = Enum
              L12_6 = L12_6.EasingStyle
              L12_6 = L12_6.Quad
              L13_6 = Enum
              L13_6 = L13_6.EasingDirection
              L13_6 = L13_6.Out
              L10_6 = L10_6(L11_6, L12_6, L13_6)
              L11_6 = {}
              L11_6.BackgroundTransparency = 1
              L7_6 = L7_6(L8_6, L9_6, L10_6, L11_6)
              L8_6 = L7_6
              L7_6 = L7_6.Play
              L7_6(L8_6)
              L7_6 = L1_1
              L8_6 = L7_6
              L7_6 = L7_6.Create
              L9_6 = L6_6.Title
              L10_6 = TweenInfo
              L10_6 = L10_6.new
              L11_6 = 0.15
              L12_6 = Enum
              L12_6 = L12_6.EasingStyle
              L12_6 = L12_6.Quad
              L13_6 = Enum
              L13_6 = L13_6.EasingDirection
              L13_6 = L13_6.Out
              L10_6 = L10_6(L11_6, L12_6, L13_6)
              L11_6 = {}
              L11_6.TextTransparency = 0.4
              L7_6 = L7_6(L8_6, L9_6, L10_6, L11_6)
              L8_6 = L7_6
              L7_6 = L7_6.Play
              L7_6(L8_6)
            end
            return
          end
          L2_6 = L2_5
          L2_6.Value = A1_6
          L2_6 = L7_5
          L2_6 = L2_6.F
          L2_6 = L2_6.Selected
          L3_6 = L2_5
          L3_6 = L3_6.Value
          L2_6.Text = L3_6
          L2_6 = pairs
          L3_6 = L2_5
          L3_6 = L3_6.Buttons
          L2_6, L3_6, L4_6 = L2_6(L3_6)
          for L5_6, L6_6 in L2_6, L3_6, L4_6 do
            L7_6 = L1_1
            L8_6 = L7_6
            L7_6 = L7_6.Create
            L9_6 = L6_6
            L10_6 = TweenInfo
            L10_6 = L10_6.new
            L11_6 = 0.15
            L12_6 = Enum
            L12_6 = L12_6.EasingStyle
            L12_6 = L12_6.Quad
            L13_6 = Enum
            L13_6 = L13_6.EasingDirection
            L13_6 = L13_6.Out
            L10_6 = L10_6(L11_6, L12_6, L13_6)
            L11_6 = {}
            L11_6.BackgroundTransparency = 1
            L7_6 = L7_6(L8_6, L9_6, L10_6, L11_6)
            L8_6 = L7_6
            L7_6 = L7_6.Play
            L7_6(L8_6)
            L7_6 = L1_1
            L8_6 = L7_6
            L7_6 = L7_6.Create
            L9_6 = L6_6.Title
            L10_6 = TweenInfo
            L10_6 = L10_6.new
            L11_6 = 0.15
            L12_6 = Enum
            L12_6 = L12_6.EasingStyle
            L12_6 = L12_6.Quad
            L13_6 = Enum
            L13_6 = L13_6.EasingDirection
            L13_6 = L13_6.Out
            L10_6 = L10_6(L11_6, L12_6, L13_6)
            L11_6 = {}
            L11_6.TextTransparency = 0.4
            L7_6 = L7_6(L8_6, L9_6, L10_6, L11_6)
            L8_6 = L7_6
            L7_6 = L7_6.Play
            L7_6(L8_6)
          end
          L2_6 = L1_1
          L3_6 = L2_6
          L2_6 = L2_6.Create
          L4_6 = L2_5
          L4_6 = L4_6.Buttons
          L4_6 = L4_6[A1_6]
          L5_6 = TweenInfo
          L5_6 = L5_6.new
          L6_6 = 0.15
          L7_6 = Enum
          L7_6 = L7_6.EasingStyle
          L7_6 = L7_6.Quad
          L8_6 = Enum
          L8_6 = L8_6.EasingDirection
          L8_6 = L8_6.Out
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L6_6 = {}
          L6_6.BackgroundTransparency = 0
          L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
          L3_6 = L2_6
          L2_6 = L2_6.Play
          L2_6(L3_6)
          L2_6 = L1_1
          L3_6 = L2_6
          L2_6 = L2_6.Create
          L4_6 = L2_5
          L4_6 = L4_6.Buttons
          L4_6 = L4_6[A1_6]
          L4_6 = L4_6.Title
          L5_6 = TweenInfo
          L5_6 = L5_6.new
          L6_6 = 0.15
          L7_6 = Enum
          L7_6 = L7_6.EasingStyle
          L7_6 = L7_6.Quad
          L8_6 = Enum
          L8_6 = L8_6.EasingDirection
          L8_6 = L8_6.Out
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L6_6 = {}
          L6_6.TextTransparency = 0
          L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
          L3_6 = L2_6
          L2_6 = L2_6.Play
          L2_6(L3_6)
          L2_6 = A1_5
          L2_6 = L2_6.Callback
          L3_6 = L2_5
          L3_6 = L3_6.Value
        end
        
        L2_5.Set = L9_5
        L9_5 = L10_1
        L10_5 = L6_5.MouseButton1Click
        
        function L11_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6, L11_6, L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6, L21_6, L22_6, L23_6, L24_6, L25_6, L26_6, L27_6, L28_6, L29_6, L30_6, L31_6, L32_6, L33_6, L34_6, L35_6, L36_6, L37_6, L38_6, L39_6, L40_6, L41_6, L42_6, L43_6, L44_6, L45_6, L46_6, L47_6, L48_6, L49_6, L50_6, L51_6, L52_6, L53_6, L54_6, L55_6, L56_6, L57_6, L58_6, L59_6, L60_6, L61_6, L62_6, L63_6, L64_6, L65_6, L66_6, L67_6, L68_6, L69_6, L70_6, L71_6, L72_6, L73_6, L74_6, L75_6, L76_6, L77_6, L78_6, L79_6, L80_6, L81_6, L82_6, L83_6, L84_6, L85_6, L86_6, L87_6, L88_6, L89_6, L90_6, L91_6, L92_6, L93_6, L94_6, L95_6, L96_6, L97_6, L98_6, L99_6, L100_6, L101_6, L102_6, L103_6, L104_6, L105_6, L106_6, L107_6, L108_6, L109_6, L110_6, L111_6, L112_6, L113_6, L114_6, L115_6, L116_6, L117_6, L118_6, L119_6, L120_6, L121_6, L122_6, L123_6, L124_6, L125_6, L126_6, L127_6, L128_6, L129_6, L130_6, L131_6, L132_6, L133_6, L134_6, L135_6, L136_6, L137_6, L138_6, L139_6, L140_6, L141_6, L142_6, L143_6, L144_6, L145_6, L146_6, L147_6, L148_6, L149_6, L150_6, L151_6, L152_6, L153_6, L154_6, L155_6, L156_6, L157_6, L158_6, L159_6, L160_6, L161_6, L162_6, L163_6, L164_6, L165_6, L166_6, L167_6, L168_6, L169_6, L170_6, L171_6, L172_6, L173_6, L174_6, L175_6, L176_6, L177_6, L178_6, L179_6, L180_6, L181_6, L182_6, L183_6, L184_6, L185_6, L186_6, L187_6, L188_6, L189_6, L190_6, L191_6, L192_6, L193_6, L194_6, L195_6, L196_6, L197_6, L198_6, L199_6, L200_6, L201_6, L202_6, L203_6, L204_6, L205_6, L206_6, L207_6, L208_6, L209_6, L210_6, L211_6, L212_6, L213_6, L214_6, L215_6, L216_6, L217_6, L218_6, L219_6, L220_6, L221_6, L222_6, L223_6, L224_6, L225_6, L226_6, L227_6, L228_6, L229_6, L230_6, L231_6, L232_6, L233_6, L234_6, L235_6, L236_6, L237_6, L238_6, L239_6, L240_6, L241_6, L242_6, L243_6, L244_6, L245_6, L246_6, L247_6, L248_6, L249_6, L250_6, L251_6, L252_6, L253_6, L254_6
          L0_6 = L2_5
          L1_6 = L2_5
          L1_6 = L1_6.Toggled
          L1_6 = not L1_6
          L0_6.Toggled = L1_6
          L0_6 = L7_5
          L0_6 = L0_6.F
          L0_6 = L0_6.Line
          L1_6 = L2_5
          L1_6 = L1_6.Toggled
          L0_6.Visible = L1_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L7_5
          L2_6 = L2_6.F
          L2_6 = L2_6.Ico
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.15
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quad
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = L2_5
          L5_6 = L5_6.Toggled
          if L5_6 then
            L5_6 = 180
            if L5_6 then
              goto lbl_36
            end
          end
          L5_6 = 0
          ::lbl_36::
          L4_6.Rotation = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
          L0_6 = L2_5
          L0_6 = L0_6.Options
          L0_6 = #L0_6
          L1_6 = L3_5
          if L0_6 > L1_6 then
            L0_6 = L1_1
            L1_6 = L0_6
            L0_6 = L0_6.Create
            L2_6 = L7_5
            L3_6 = TweenInfo
            L3_6 = L3_6.new
            L4_6 = 0.15
            L5_6 = Enum
            L5_6 = L5_6.EasingStyle
            L5_6 = L5_6.Quad
            L6_6 = Enum
            L6_6 = L6_6.EasingDirection
            L6_6 = L6_6.Out
            L3_6 = L3_6(L4_6, L5_6, L6_6)
            L4_6 = {}
            L5_6 = L2_5
            L5_6 = L5_6.Toggled
            if L5_6 then
              L5_6 = UDim2
              L5_6 = L5_6.new
              L6_6 = 1
              L7_6 = 0
              L8_6 = 0
              L9_6 = L3_5
              L9_6 = L9_6 * 28
              L9_6 = 38 + L9_6
              L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
              if L5_6 then
                goto lbl_82
              end
            end
            L5_6 = UDim2
            L5_6 = L5_6.new
            L6_6 = 1
            L7_6 = 0
            L8_6 = 0
            L9_6 = 38
            L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
            ::lbl_82::
            L4_6.Size = L5_6
            L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
            L1_6 = L0_6
            L0_6 = L0_6.Play
            L0_6(L1_6)
          else
            L0_6 = L1_1
            L1_6 = L0_6
            L0_6 = L0_6.Create
            L2_6 = L7_5
            L3_6 = TweenInfo
            L3_6 = L3_6.new
            L4_6 = 0.15
            L5_6 = Enum
            L5_6 = L5_6.EasingStyle
            L5_6 = L5_6.Quad
            L6_6 = Enum
            L6_6 = L6_6.EasingDirection
            L6_6 = L6_6.Out
            L3_6 = L3_6(L4_6, L5_6, L6_6)
            L4_6 = {}
            L5_6 = L2_5
            L5_6 = L5_6.Toggled
            if L5_6 then
              L5_6 = UDim2
              L5_6 = L5_6.new
              L6_6 = 1
              L7_6 = 0
              L8_6 = 0
              L9_6 = L4_5
              L9_6 = L9_6.AbsoluteContentSize
              L9_6 = L9_6.Y
              L9_6 = L9_6 + 38
              L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
              if L5_6 then
                goto lbl_124
              end
            end
            L5_6 = UDim2
            L5_6 = L5_6.new
            L6_6 = 1
            L7_6 = 0
            L8_6 = 0
            L9_6 = 38
            L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
            ::lbl_124::
            L4_6.Size = L5_6
            L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
            L1_6 = L0_6
            L0_6 = L0_6.Play
            L0_6(L1_6)
          end
        end
        
        L9_5(L10_5, L11_5)
        L10_5 = L2_5
        L9_5 = L2_5.Refresh
        L11_5 = L2_5.Options
        L12_5 = false
        L9_5(L10_5, L11_5, L12_5)
        L10_5 = L2_5
        L9_5 = L2_5.Set
        L11_5 = L2_5.Value
        L9_5(L10_5, L11_5)
        L9_5 = A1_5.Flag
        if L9_5 then
          L9_5 = L6_1
          L9_5 = L9_5.Flags
          L10_5 = A1_5.Flag
          L9_5[L10_5] = L2_5
        end
      end
      
      L1_4.AddDropdown = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Bind"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Default
        if not L2_5 then
          L2_5 = Enum
          L2_5 = L2_5.KeyCode
          L2_5 = L2_5.Unknown
        end
        A1_5.Default = L2_5
        L2_5 = A1_5.Hold
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Hold = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = A1_5.Flag
        if not L2_5 then
          L2_5 = nil
        end
        A1_5.Flag = L2_5
        L2_5 = A1_5.Save
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Save = L2_5
        L2_5 = {}
        L3_5 = Value
        L2_5.Binding = false
        L2_5.Type = "Bind"
        L4_5 = A1_5.Save
        L2_5.Save = L4_5
        L2_5[1] = L3_5
        L3_5 = false
        L4_5 = L15_1
        L5_5 = L14_1
        L6_5 = "Button"
        L5_5 = L5_5(L6_5)
        L6_5 = {}
        L7_5 = UDim2
        L7_5 = L7_5.new
        L8_5 = 1
        L9_5 = 0
        L10_5 = 1
        L11_5 = 0
        L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
        L6_5.Size = L7_5
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = L19_1
        L6_5 = L16_1
        L7_5 = L15_1
        L8_5 = L14_1
        L9_5 = "RoundFrame"
        L10_5 = Color3
        L10_5 = L10_5.fromRGB
        L11_5 = 255
        L12_5 = 255
        L13_5 = 255
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = 0
        L12_5 = 4
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L9_5 = {}
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 0
        L12_5 = 24
        L13_5 = 0
        L14_5 = 24
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Size = L10_5
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 1
        L12_5 = -12
        L13_5 = 0.5
        L14_5 = 0
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Position = L10_5
        L10_5 = Vector2
        L10_5 = L10_5.new
        L11_5 = 1
        L12_5 = 0.5
        L10_5 = L10_5(L11_5, L12_5)
        L9_5.AnchorPoint = L10_5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = {}
        L9_5 = L19_1
        L10_5 = L14_1
        L11_5 = "Stroke"
        L10_5 = L10_5(L11_5)
        L11_5 = "Stroke"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = L19_1
        L11_5 = L15_1
        L12_5 = L14_1
        L13_5 = "Label"
        L14_5 = A1_5.Name
        L15_5 = 14
        L12_5 = L12_5(L13_5, L14_5, L15_5)
        L13_5 = {}
        L14_5 = UDim2
        L14_5 = L14_5.new
        L15_5 = 1
        L16_5 = 0
        L17_5 = 1
        L18_5 = 0
        L14_5 = L14_5(L15_5, L16_5, L17_5, L18_5)
        L13_5.Size = L14_5
        L14_5 = Enum
        L14_5 = L14_5.Font
        L14_5 = L14_5.GothamBold
        L13_5.Font = L14_5
        L14_5 = Enum
        L14_5 = L14_5.TextXAlignment
        L14_5 = L14_5.Center
        L13_5.TextXAlignment = L14_5
        L13_5.Name = "Value"
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = "Text"
        L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5 = L10_5(L11_5, L12_5)
        L8_5[1] = L9_5
        L8_5[2] = L10_5
        L8_5[3] = L11_5
        L8_5[4] = L12_5
        L8_5[5] = L13_5
        L8_5[6] = L14_5
        L8_5[7] = L15_5
        L8_5[8] = L16_5
        L8_5[9] = L17_5
        L8_5[10] = L18_5
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = "Main"
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = L19_1
        L7_5 = L16_1
        L8_5 = L15_1
        L9_5 = L14_1
        L10_5 = "RoundFrame"
        L11_5 = Color3
        L11_5 = L11_5.fromRGB
        L12_5 = 255
        L13_5 = 255
        L14_5 = 255
        L11_5 = L11_5(L12_5, L13_5, L14_5)
        L12_5 = 0
        L13_5 = 5
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L10_5 = {}
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 1
        L13_5 = 0
        L14_5 = 0
        L15_5 = 38
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Size = L11_5
        L11_5 = A0_4
        L10_5.Parent = L11_5
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = {}
        L10_5 = L19_1
        L11_5 = L15_1
        L12_5 = L14_1
        L13_5 = "Label"
        L14_5 = A1_5.Name
        L15_5 = 15
        L12_5 = L12_5(L13_5, L14_5, L15_5)
        L13_5 = {}
        L14_5 = UDim2
        L14_5 = L14_5.new
        L15_5 = 1
        L16_5 = -12
        L17_5 = 1
        L18_5 = 0
        L14_5 = L14_5(L15_5, L16_5, L17_5, L18_5)
        L13_5.Size = L14_5
        L14_5 = UDim2
        L14_5 = L14_5.new
        L15_5 = 0
        L16_5 = 12
        L17_5 = 0
        L18_5 = 0
        L14_5 = L14_5(L15_5, L16_5, L17_5, L18_5)
        L13_5.Position = L14_5
        L14_5 = Enum
        L14_5 = L14_5.Font
        L14_5 = L14_5.GothamBold
        L13_5.Font = L14_5
        L13_5.Name = "Content"
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = "Text"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = L19_1
        L12_5 = L14_1
        L13_5 = "Stroke"
        L12_5 = L12_5(L13_5)
        L13_5 = "Stroke"
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = L5_5
        L13_5 = L4_5
        L9_5[1] = L10_5
        L9_5[2] = L11_5
        L9_5[3] = L12_5
        L9_5[4] = L13_5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = "Second"
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = L10_1
        L8_5 = L5_5.Value
        L9_5 = L8_5
        L8_5 = L8_5.GetPropertyChangedSignal
        L10_5 = "Text"
        L8_5 = L8_5(L9_5, L10_5)
        
        function L9_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = UDim2
          L5_6 = L5_6.new
          L6_6 = 0
          L7_6 = L5_5
          L7_6 = L7_6.Value
          L7_6 = L7_6.TextBounds
          L7_6 = L7_6.X
          L7_6 = L7_6 + 16
          L8_6 = 0
          L9_6 = 24
          L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
          L4_6.Size = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L4_5.InputEnded
        
        function L9_5(A0_6)
          local L1_6, L2_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = L2_5
            L1_6 = L1_6.Binding
            if L1_6 then
              return
            end
            L1_6 = L2_5
            L1_6.Binding = true
            L1_6 = L5_5
            L1_6 = L1_6.Value
            L1_6.Text = ""
          end
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L0_1
        L8_5 = L8_5.InputBegan
        
        function L9_5(A0_6)
          local L1_6, L2_6, L3_6, L4_6
          L1_6 = L0_1
          L2_6 = L1_6
          L1_6 = L1_6.GetFocusedTextBox
          L1_6 = L1_6(L2_6)
          if L1_6 then
            return
          end
          L1_6 = A0_6.KeyCode
          L1_6 = L1_6.Name
          L2_6 = L2_5
          L2_6 = L2_6.Value
          if L1_6 ~= L2_6 then
            L1_6 = A0_6.UserInputType
            L1_6 = L1_6.Name
            L2_6 = L2_5
            L2_6 = L2_6.Value
            if L1_6 ~= L2_6 then
              goto lbl_38
            end
          end
          L1_6 = L2_5
          L1_6 = L1_6.Binding
          if not L1_6 then
            L1_6 = A1_5
            L1_6 = L1_6.Hold
            if L1_6 then
              L1_6 = true
              L3_5 = L1_6
              L1_6 = A1_5
              L1_6 = L1_6.Callback
              L2_6 = L3_5
              L1_6(L2_6)
            else
              L1_6 = A1_5
              L1_6 = L1_6.Callback
              L1_6()
            end
          else
            ::lbl_38::
            L1_6 = L2_5
            L1_6 = L1_6.Binding
            if L1_6 then
              L1_6 = nil
              L2_6 = pcall
              
              function L3_6()
                local L0_7, L1_7, L2_7
                L0_7 = L27_1
                L1_7 = L26_1
                L2_7 = A0_6
                L2_7 = L2_7.KeyCode
                L0_7 = L0_7(L1_7, L2_7)
                if not L0_7 then
                  L0_7 = A0_6
                  L0_7 = L0_7.KeyCode
                  L1_6 = L0_7
                end
              end
              
              L2_6(L3_6)
              L2_6 = pcall
              
              function L3_6()
                local L0_7, L1_7, L2_7
                L0_7 = L27_1
                L1_7 = L25_1
                L2_7 = A0_6
                L2_7 = L2_7.UserInputType
                L0_7 = L0_7(L1_7, L2_7)
                if L0_7 then
                  L0_7 = L1_6
                  if not L0_7 then
                    L0_7 = A0_6
                    L0_7 = L0_7.UserInputType
                    L1_6 = L0_7
                  end
                end
              end
              
              L2_6(L3_6)
              if not L1_6 then
                L2_6 = L2_5
                L1_6 = L2_6.Value
              end
              L2_6 = L2_5
              L3_6 = L2_6
              L2_6 = L2_6.Set
              L4_6 = L1_6
              L2_6(L3_6, L4_6)
              L2_6 = L24_1
              L3_6 = game
              L3_6 = L3_6.GameId
              L2_6(L3_6)
            end
          end
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L0_1
        L8_5 = L8_5.InputEnded
        
        function L9_5(A0_6)
          local L1_6, L2_6
          L1_6 = A0_6.KeyCode
          L1_6 = L1_6.Name
          L2_6 = L2_5
          L2_6 = L2_6.Value
          if L1_6 ~= L2_6 then
            L1_6 = A0_6.UserInputType
            L1_6 = L1_6.Name
            L2_6 = L2_5
            L2_6 = L2_6.Value
            if L1_6 ~= L2_6 then
              goto lbl_26
            end
          end
          L1_6 = A1_5
          L1_6 = L1_6.Hold
          if L1_6 then
            L1_6 = L3_5
            if L1_6 then
              L1_6 = false
              L3_5 = L1_6
              L1_6 = A1_5
              L1_6 = L1_6.Callback
              L2_6 = L3_5
              L1_6(L2_6)
            end
          end
          ::lbl_26::
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L4_5.MouseEnter
        
        function L9_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L6_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L4_5.MouseLeave
        
        function L9_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L6_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = L6_1
          L5_6 = L5_6.Themes
          L6_6 = L6_1
          L6_6 = L6_6.SelectedTheme
          L5_6 = L5_6[L6_6]
          L5_6 = L5_6.Second
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L4_5.MouseButton1Up
        
        function L9_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L6_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L7_5(L8_5, L9_5)
        L7_5 = L10_1
        L8_5 = L4_5.MouseButton1Down
        
        function L9_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L6_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 6
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 6
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 6
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L7_5(L8_5, L9_5)
        
        function L7_5(A0_6, A1_6)
          local L2_6, L3_6
          L2_6 = L2_5
          L2_6.Binding = false
          L2_6 = L2_5
          L3_6 = A1_6 or L3_6
          if not A1_6 then
            L3_6 = L2_5
            L3_6 = L3_6.Value
          end
          L2_6.Value = L3_6
          L2_6 = L2_5
          L3_6 = L2_5
          L3_6 = L3_6.Value
          L3_6 = L3_6.Name
          if not L3_6 then
            L3_6 = L2_5
            L3_6 = L3_6.Value
          end
          L2_6.Value = L3_6
          L2_6 = L5_5
          L2_6 = L2_6.Value
          L3_6 = L2_5
          L3_6 = L3_6.Value
          L2_6.Text = L3_6
        end
        
        L2_5.Set = L7_5
        L8_5 = L2_5
        L7_5 = L2_5.Set
        L9_5 = A1_5.Default
        L7_5(L8_5, L9_5)
        L7_5 = A1_5.Flag
        if L7_5 then
          L7_5 = L6_1
          L7_5 = L7_5.Flags
          L8_5 = A1_5.Flag
          L7_5[L8_5] = L2_5
        end
      end
      
      L1_4.AddBind = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5
        if not A1_5 then
          L2_5 = {}
          A1_5 = L2_5
        end
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Textbox"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Default
        if not L2_5 then
          L2_5 = ""
        end
        A1_5.Default = L2_5
        L2_5 = A1_5.TextDisappear
        if not L2_5 then
          L2_5 = false
        end
        A1_5.TextDisappear = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = L15_1
        L3_5 = L14_1
        L4_5 = "Button"
        L3_5 = L3_5(L4_5)
        L4_5 = {}
        L5_5 = UDim2
        L5_5 = L5_5.new
        L6_5 = 1
        L7_5 = 0
        L8_5 = 1
        L9_5 = 0
        L5_5 = L5_5(L6_5, L7_5, L8_5, L9_5)
        L4_5.Size = L5_5
        L2_5 = L2_5(L3_5, L4_5)
        L3_5 = L19_1
        L4_5 = L12_1
        L5_5 = "TextBox"
        L6_5 = {}
        L7_5 = UDim2
        L7_5 = L7_5.new
        L8_5 = 1
        L9_5 = 0
        L10_5 = 1
        L11_5 = 0
        L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
        L6_5.Size = L7_5
        L6_5.BackgroundTransparency = 1
        L7_5 = Color3
        L7_5 = L7_5.fromRGB
        L8_5 = 255
        L9_5 = 255
        L10_5 = 255
        L7_5 = L7_5(L8_5, L9_5, L10_5)
        L6_5.TextColor3 = L7_5
        L7_5 = Color3
        L7_5 = L7_5.fromRGB
        L8_5 = 210
        L9_5 = 210
        L10_5 = 210
        L7_5 = L7_5(L8_5, L9_5, L10_5)
        L6_5.PlaceholderColor3 = L7_5
        L6_5.PlaceholderText = "Input"
        L7_5 = Enum
        L7_5 = L7_5.Font
        L7_5 = L7_5.GothamSemibold
        L6_5.Font = L7_5
        L7_5 = Enum
        L7_5 = L7_5.TextXAlignment
        L7_5 = L7_5.Center
        L6_5.TextXAlignment = L7_5
        L6_5.TextSize = 14
        L6_5.ClearTextOnFocus = false
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = "Text"
        L3_5 = L3_5(L4_5, L5_5)
        L4_5 = L19_1
        L5_5 = L16_1
        L6_5 = L15_1
        L7_5 = L14_1
        L8_5 = "RoundFrame"
        L9_5 = Color3
        L9_5 = L9_5.fromRGB
        L10_5 = 255
        L11_5 = 255
        L12_5 = 255
        L9_5 = L9_5(L10_5, L11_5, L12_5)
        L10_5 = 0
        L11_5 = 4
        L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
        L8_5 = {}
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 0
        L11_5 = 24
        L12_5 = 0
        L13_5 = 24
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Size = L9_5
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 1
        L11_5 = -12
        L12_5 = 0.5
        L13_5 = 0
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Position = L9_5
        L9_5 = Vector2
        L9_5 = L9_5.new
        L10_5 = 1
        L11_5 = 0.5
        L9_5 = L9_5(L10_5, L11_5)
        L8_5.AnchorPoint = L9_5
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = {}
        L8_5 = L19_1
        L9_5 = L14_1
        L10_5 = "Stroke"
        L9_5 = L9_5(L10_5)
        L10_5 = "Stroke"
        L8_5 = L8_5(L9_5, L10_5)
        L9_5 = L3_5
        L7_5[1] = L8_5
        L7_5[2] = L9_5
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = "Main"
        L4_5 = L4_5(L5_5, L6_5)
        L5_5 = L19_1
        L6_5 = L16_1
        L7_5 = L15_1
        L8_5 = L14_1
        L9_5 = "RoundFrame"
        L10_5 = Color3
        L10_5 = L10_5.fromRGB
        L11_5 = 255
        L12_5 = 255
        L13_5 = 255
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = 0
        L12_5 = 5
        L8_5 = L8_5(L9_5, L10_5, L11_5, L12_5)
        L9_5 = {}
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 1
        L12_5 = 0
        L13_5 = 0
        L14_5 = 38
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Size = L10_5
        L10_5 = A0_4
        L9_5.Parent = L10_5
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = {}
        L9_5 = L19_1
        L10_5 = L15_1
        L11_5 = L14_1
        L12_5 = "Label"
        L13_5 = A1_5.Name
        L14_5 = 15
        L11_5 = L11_5(L12_5, L13_5, L14_5)
        L12_5 = {}
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 1
        L15_5 = -12
        L16_5 = 1
        L17_5 = 0
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Size = L13_5
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 0
        L15_5 = 12
        L16_5 = 0
        L17_5 = 0
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Position = L13_5
        L13_5 = Enum
        L13_5 = L13_5.Font
        L13_5 = L13_5.GothamBold
        L12_5.Font = L13_5
        L12_5.Name = "Content"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = "Text"
        L9_5 = L9_5(L10_5, L11_5)
        L10_5 = L19_1
        L11_5 = L14_1
        L12_5 = "Stroke"
        L11_5 = L11_5(L12_5)
        L12_5 = "Stroke"
        L10_5 = L10_5(L11_5, L12_5)
        L11_5 = L4_5
        L12_5 = L2_5
        L8_5[1] = L9_5
        L8_5[2] = L10_5
        L8_5[3] = L11_5
        L8_5[4] = L12_5
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = "Second"
        L5_5 = L5_5(L6_5, L7_5)
        L6_5 = L10_1
        L8_5 = L3_5
        L7_5 = L3_5.GetPropertyChangedSignal
        L9_5 = "Text"
        L7_5 = L7_5(L8_5, L9_5)
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L4_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.45
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = UDim2
          L5_6 = L5_6.new
          L6_6 = 0
          L7_6 = L3_5
          L7_6 = L7_6.TextBounds
          L7_6 = L7_6.X
          L7_6 = L7_6 + 16
          L8_6 = 0
          L9_6 = 24
          L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
          L4_6.Size = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L3_5.FocusLost
        
        function L8_5()
          local L0_6, L1_6
          L0_6 = A1_5
          L0_6 = L0_6.Callback
          L1_6 = L3_5
          L1_6 = L1_6.Text
          L0_6(L1_6)
          L0_6 = A1_5
          L0_6 = L0_6.TextDisappear
          if L0_6 then
            L0_6 = L3_5
            L0_6.Text = ""
          end
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = A1_5.Default
        L3_5.Text = L6_5
        L6_5 = L10_1
        L7_5 = L2_5.MouseEnter
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L2_5.MouseLeave
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = L6_1
          L5_6 = L5_6.Themes
          L6_6 = L6_1
          L6_6 = L6_6.SelectedTheme
          L5_6 = L5_6[L6_6]
          L5_6 = L5_6.Second
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L2_5.MouseButton1Up
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 3
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 3
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 3
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
          L0_6 = L3_5
          L1_6 = L0_6
          L0_6 = L0_6.CaptureFocus
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
        L6_5 = L10_1
        L7_5 = L2_5.MouseButton1Down
        
        function L8_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L5_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.25
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quint
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = Color3
          L5_6 = L5_6.fromRGB
          L6_6 = L6_1
          L6_6 = L6_6.Themes
          L7_6 = L6_1
          L7_6 = L7_6.SelectedTheme
          L6_6 = L6_6[L7_6]
          L6_6 = L6_6.Second
          L6_6 = L6_6.R
          L6_6 = L6_6 * 255
          L6_6 = L6_6 + 6
          L7_6 = L6_1
          L7_6 = L7_6.Themes
          L8_6 = L6_1
          L8_6 = L8_6.SelectedTheme
          L7_6 = L7_6[L8_6]
          L7_6 = L7_6.Second
          L7_6 = L7_6.G
          L7_6 = L7_6 * 255
          L7_6 = L7_6 + 6
          L8_6 = L6_1
          L8_6 = L8_6.Themes
          L9_6 = L6_1
          L9_6 = L9_6.SelectedTheme
          L8_6 = L8_6[L9_6]
          L8_6 = L8_6.Second
          L8_6 = L8_6.B
          L8_6 = L8_6 * 255
          L8_6 = L8_6 + 6
          L5_6 = L5_6(L6_6, L7_6, L8_6)
          L4_6.BackgroundColor3 = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
        end
        
        L6_5(L7_5, L8_5)
      end
      
      L1_4.AddTextbox = L2_4
      
      function L2_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        if not A1_5 then
          L2_5 = {}
          A1_5 = L2_5
        end
        L2_5 = A1_5.Name
        if not L2_5 then
          L2_5 = "Colorpicker"
        end
        A1_5.Name = L2_5
        L2_5 = A1_5.Default
        if not L2_5 then
          L2_5 = Color3
          L2_5 = L2_5.fromRGB
          L3_5 = 255
          L4_5 = 255
          L5_5 = 255
          L2_5 = L2_5(L3_5, L4_5, L5_5)
        end
        A1_5.Default = L2_5
        L2_5 = A1_5.Callback
        if not L2_5 then
          function L2_5()
            local L0_6
          end
        end
        A1_5.Callback = L2_5
        L2_5 = A1_5.Flag
        if not L2_5 then
          L2_5 = nil
        end
        A1_5.Flag = L2_5
        L2_5 = A1_5.Save
        if not L2_5 then
          L2_5 = false
        end
        A1_5.Save = L2_5
        L2_5 = 1
        L3_5 = 1
        L4_5 = 1
        L5_5 = {}
        L6_5 = A1_5.Default
        L5_5.Value = L6_5
        L5_5.Toggled = false
        L5_5.Type = "Colorpicker"
        L6_5 = A1_5.Save
        L5_5.Save = L6_5
        L6_5 = L12_1
        L7_5 = "ImageLabel"
        L8_5 = {}
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = 0
        L11_5 = 18
        L12_5 = 0
        L13_5 = 18
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5)
        L8_5.Size = L9_5
        L9_5 = UDim2
        L9_5 = L9_5.new
        L10_5 = select
        L11_5 = 3
        L12_5 = Color3
        L12_5 = L12_5.toHSV
        L13_5 = L5_5.Value
        L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L12_5(L13_5)
        L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L10_5(L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L9_5 = L9_5(L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L8_5.Position = L9_5
        L9_5 = Enum
        L9_5 = L9_5.ScaleType
        L9_5 = L9_5.Fit
        L8_5.ScaleType = L9_5
        L9_5 = Vector2
        L9_5 = L9_5.new
        L10_5 = 0.5
        L11_5 = 0.5
        L9_5 = L9_5(L10_5, L11_5)
        L8_5.AnchorPoint = L9_5
        L8_5.BackgroundTransparency = 1
        L8_5.Image = "http://www.roblox.com/asset/?id=4805639000"
        L6_5 = L6_5(L7_5, L8_5)
        L7_5 = L12_1
        L8_5 = "ImageLabel"
        L9_5 = {}
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 0
        L12_5 = 18
        L13_5 = 0
        L14_5 = 18
        L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
        L9_5.Size = L10_5
        L10_5 = UDim2
        L10_5 = L10_5.new
        L11_5 = 0.5
        L12_5 = 0
        L13_5 = select
        L14_5 = 1
        L15_5 = Color3
        L15_5 = L15_5.toHSV
        L16_5 = L5_5.Value
        L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L15_5(L16_5)
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L13_5 = 1 - L13_5
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L9_5.Position = L10_5
        L10_5 = Enum
        L10_5 = L10_5.ScaleType
        L10_5 = L10_5.Fit
        L9_5.ScaleType = L10_5
        L10_5 = Vector2
        L10_5 = L10_5.new
        L11_5 = 0.5
        L12_5 = 0.5
        L10_5 = L10_5(L11_5, L12_5)
        L9_5.AnchorPoint = L10_5
        L9_5.BackgroundTransparency = 1
        L9_5.Image = "http://www.roblox.com/asset/?id=4805639000"
        L7_5 = L7_5(L8_5, L9_5)
        L8_5 = L12_1
        L9_5 = "ImageLabel"
        L10_5 = {}
        L11_5 = UDim2
        L11_5 = L11_5.new
        L12_5 = 1
        L13_5 = -25
        L14_5 = 1
        L15_5 = 0
        L11_5 = L11_5(L12_5, L13_5, L14_5, L15_5)
        L10_5.Size = L11_5
        L10_5.Visible = false
        L10_5.Image = "rbxassetid://4155801252"
        L11_5 = {}
        L12_5 = L12_1
        L13_5 = "UICorner"
        L14_5 = {}
        L15_5 = UDim
        L15_5 = L15_5.new
        L16_5 = 0
        L17_5 = 5
        L15_5 = L15_5(L16_5, L17_5)
        L14_5.CornerRadius = L15_5
        L12_5 = L12_5(L13_5, L14_5)
        L13_5 = L6_5
        L11_5[1] = L12_5
        L11_5[2] = L13_5
        L8_5 = L8_5(L9_5, L10_5, L11_5)
        L9_5 = L12_1
        L10_5 = "Frame"
        L11_5 = {}
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 0
        L14_5 = 20
        L15_5 = 1
        L16_5 = 0
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Size = L12_5
        L12_5 = UDim2
        L12_5 = L12_5.new
        L13_5 = 1
        L14_5 = -20
        L15_5 = 0
        L16_5 = 0
        L12_5 = L12_5(L13_5, L14_5, L15_5, L16_5)
        L11_5.Position = L12_5
        L11_5.Visible = false
        L12_5 = {}
        L13_5 = L12_1
        L14_5 = "UIGradient"
        L15_5 = {}
        L15_5.Rotation = 270
        L16_5 = ColorSequence
        L16_5 = L16_5.new
        L17_5 = {}
        L18_5 = ColorSequenceKeypoint
        L18_5 = L18_5.new
        L19_5 = 0
        L20_5 = Color3
        L20_5 = L20_5.fromRGB
        L21_5 = 255
        L22_5 = 0
        L23_5 = 4
        L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L20_5(L21_5, L22_5, L23_5)
        L18_5 = L18_5(L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L19_5 = ColorSequenceKeypoint
        L19_5 = L19_5.new
        L20_5 = 0.2
        L21_5 = Color3
        L21_5 = L21_5.fromRGB
        L22_5 = 234
        L23_5 = 255
        L24_5 = 0
        L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L21_5(L22_5, L23_5, L24_5)
        L19_5 = L19_5(L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L20_5 = ColorSequenceKeypoint
        L20_5 = L20_5.new
        L21_5 = 0.4
        L22_5 = Color3
        L22_5 = L22_5.fromRGB
        L23_5 = 21
        L24_5 = 255
        L25_5 = 0
        L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L22_5(L23_5, L24_5, L25_5)
        L20_5 = L20_5(L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L21_5 = ColorSequenceKeypoint
        L21_5 = L21_5.new
        L22_5 = 0.6
        L23_5 = Color3
        L23_5 = L23_5.fromRGB
        L24_5 = 0
        L25_5 = 255
        L26_5 = 255
        L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L23_5(L24_5, L25_5, L26_5)
        L21_5 = L21_5(L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L22_5 = ColorSequenceKeypoint
        L22_5 = L22_5.new
        L23_5 = 0.8
        L24_5 = Color3
        L24_5 = L24_5.fromRGB
        L25_5 = 0
        L26_5 = 17
        L27_5 = 255
        L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L24_5(L25_5, L26_5, L27_5)
        L22_5 = L22_5(L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L23_5 = ColorSequenceKeypoint
        L23_5 = L23_5.new
        L24_5 = 0.9
        L25_5 = Color3
        L25_5 = L25_5.fromRGB
        L26_5 = 255
        L27_5 = 0
        L28_5 = 251
        L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L25_5(L26_5, L27_5, L28_5)
        L23_5 = L23_5(L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L24_5 = ColorSequenceKeypoint
        L24_5 = L24_5.new
        L25_5 = 1
        L26_5 = Color3
        L26_5 = L26_5.fromRGB
        L27_5 = 255
        L28_5 = 0
        L29_5 = 4
        L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L26_5(L27_5, L28_5, L29_5)
        L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L24_5(L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L17_5[1] = L18_5
        L17_5[2] = L19_5
        L17_5[3] = L20_5
        L17_5[4] = L21_5
        L17_5[5] = L22_5
        L17_5[6] = L23_5
        L17_5[7] = L24_5
        L17_5[8] = L25_5
        L17_5[9] = L26_5
        L17_5[10] = L27_5
        L17_5[11] = L28_5
        L17_5[12] = L29_5
        L17_5[13] = L30_5
        L17_5[14] = L31_5
        L17_5[15] = L32_5
        L17_5[16] = L33_5
        L17_5[17] = L34_5
        L17_5[18] = L35_5
        L17_5[19] = L36_5
        L17_5[20] = L37_5
        L17_5[21] = L38_5
        L17_5[22] = L39_5
        L17_5[23] = L40_5
        L17_5[24] = L41_5
        L17_5[25] = L42_5
        L17_5[26] = L43_5
        L17_5[27] = L44_5
        L17_5[28] = L45_5
        L17_5[29] = L46_5
        L17_5[30] = L47_5
        L17_5[31] = L48_5
        L17_5[32] = L49_5
        L17_5[33] = L50_5
        L17_5[34] = L51_5
        L17_5[35] = L52_5
        L17_5[36] = L53_5
        L17_5[37] = L54_5
        L17_5[38] = L55_5
        L17_5[39] = L56_5
        L17_5[40] = L57_5
        L17_5[41] = L58_5
        L17_5[42] = L59_5
        L17_5[43] = L60_5
        L17_5[44] = L61_5
        L17_5[45] = L62_5
        L17_5[46] = L63_5
        L17_5[47] = L64_5
        L17_5[48] = L65_5
        L17_5[49] = L66_5
        L17_5[50] = L67_5
        L17_5[51] = L68_5
        L17_5[52] = L69_5
        L17_5[53] = L70_5
        L17_5[54] = L71_5
        L17_5[55] = L72_5
        L17_5[56] = L73_5
        L17_5[57] = L74_5
        L17_5[58] = L75_5
        L17_5[59] = L76_5
        L17_5[60] = L77_5
        L17_5[61] = L78_5
        L17_5[62] = L79_5
        L17_5[63] = L80_5
        L17_5[64] = L81_5
        L17_5[65] = L82_5
        L17_5[66] = L83_5
        L17_5[67] = L84_5
        L17_5[68] = L85_5
        L17_5[69] = L86_5
        L17_5[70] = L87_5
        L17_5[71] = L88_5
        L17_5[72] = L89_5
        L17_5[73] = L90_5
        L17_5[74] = L91_5
        L17_5[75] = L92_5
        L17_5[76] = L93_5
        L17_5[77] = L94_5
        L17_5[78] = L95_5
        L17_5[79] = L96_5
        L17_5[80] = L97_5
        L17_5[81] = L98_5
        L17_5[82] = L99_5
        L17_5[83] = L100_5
        L17_5[84] = L101_5
        L17_5[85] = L102_5
        L17_5[86] = L103_5
        L17_5[87] = L104_5
        L17_5[88] = L105_5
        L17_5[89] = L106_5
        L17_5[90] = L107_5
        L17_5[91] = L108_5
        L17_5[92] = L109_5
        L17_5[93] = L110_5
        L17_5[94] = L111_5
        L17_5[95] = L112_5
        L17_5[96] = L113_5
        L17_5[97] = L114_5
        L17_5[98] = L115_5
        L17_5[99] = L116_5
        L17_5[100] = L117_5
        L17_5[101] = L118_5
        L17_5[102] = L119_5
        L17_5[103] = L120_5
        L17_5[104] = L121_5
        L17_5[105] = L122_5
        L17_5[106] = L123_5
        L17_5[107] = L124_5
        L17_5[108] = L125_5
        L17_5[109] = L126_5
        L17_5[110] = L127_5
        L17_5[111] = L128_5
        L17_5[112] = L129_5
        L17_5[113] = L130_5
        L17_5[114] = L131_5
        L17_5[115] = L132_5
        L17_5[116] = L133_5
        L17_5[117] = L134_5
        L17_5[118] = L135_5
        L17_5[119] = L136_5
        L17_5[120] = L137_5
        L17_5[121] = L138_5
        L17_5[122] = L139_5
        L17_5[123] = L140_5
        L17_5[124] = L141_5
        L17_5[125] = L142_5
        L17_5[126] = L143_5
        L17_5[127] = L144_5
        L17_5[128] = L145_5
        L17_5[129] = L146_5
        L17_5[130] = L147_5
        L17_5[131] = L148_5
        L17_5[132] = L149_5
        L17_5[133] = L150_5
        L17_5[134] = L151_5
        L17_5[135] = L152_5
        L17_5[136] = L153_5
        L17_5[137] = L154_5
        L17_5[138] = L155_5
        L17_5[139] = L156_5
        L17_5[140] = L157_5
        L17_5[141] = L158_5
        L17_5[142] = L159_5
        L17_5[143] = L160_5
        L17_5[144] = L161_5
        L17_5[145] = L162_5
        L17_5[146] = L163_5
        L17_5[147] = L164_5
        L17_5[148] = L165_5
        L17_5[149] = L166_5
        L17_5[150] = L167_5
        L17_5[151] = L168_5
        L17_5[152] = L169_5
        L17_5[153] = L170_5
        L17_5[154] = L171_5
        L17_5[155] = L172_5
        L17_5[156] = L173_5
        L17_5[157] = L174_5
        L17_5[158] = L175_5
        L17_5[159] = L176_5
        L17_5[160] = L177_5
        L17_5[161] = L178_5
        L17_5[162] = L179_5
        L17_5[163] = L180_5
        L17_5[164] = L181_5
        L17_5[165] = L182_5
        L17_5[166] = L183_5
        L17_5[167] = L184_5
        L17_5[168] = L185_5
        L17_5[169] = L186_5
        L17_5[170] = L187_5
        L17_5[171] = L188_5
        L17_5[172] = L189_5
        L17_5[173] = L190_5
        L17_5[174] = L191_5
        L17_5[175] = L192_5
        L17_5[176] = L193_5
        L17_5[177] = L194_5
        L17_5[178] = L195_5
        L17_5[179] = L196_5
        L17_5[180] = L197_5
        L17_5[181] = L198_5
        L17_5[182] = L199_5
        L17_5[183] = L200_5
        L17_5[184] = L201_5
        L17_5[185] = L202_5
        L17_5[186] = L203_5
        L17_5[187] = L204_5
        L17_5[188] = L205_5
        L17_5[189] = L206_5
        L17_5[190] = L207_5
        L17_5[191] = L208_5
        L17_5[192] = L209_5
        L17_5[193] = L210_5
        L17_5[194] = L211_5
        L17_5[195] = L212_5
        L17_5[196] = L213_5
        L17_5[197] = L214_5
        L17_5[198] = L215_5
        L17_5[199] = L216_5
        L17_5[200] = L217_5
        L17_5[201] = L218_5
        L17_5[202] = L219_5
        L17_5[203] = L220_5
        L17_5[204] = L221_5
        L17_5[205] = L222_5
        L17_5[206] = L223_5
        L17_5[207] = L224_5
        L17_5[208] = L225_5
        L17_5[209] = L226_5
        L17_5[210] = L227_5
        L17_5[211] = L228_5
        L17_5[212] = L229_5
        L17_5[213] = L230_5
        L17_5[214] = L231_5
        L17_5[215] = L232_5
        L17_5[216] = L233_5
        L17_5[217] = L234_5
        L17_5[218] = L235_5
        L17_5[219] = L236_5
        L17_5[220] = L237_5
        L17_5[221] = L238_5
        L17_5[222] = L239_5
        L17_5[223] = L240_5
        L17_5[224] = L241_5
        L17_5[225] = L242_5
        L17_5[226] = L243_5
        L17_5[227] = L244_5
        L17_5[228] = L245_5
        L17_5[229] = L246_5
        L17_5[230] = L247_5
        L17_5[231] = L248_5
        L17_5[232] = L249_5
        L17_5[233] = L250_5
        L17_5[234] = L251_5
        L17_5[235] = L252_5
        L17_5[236] = L253_5
        L17_5[237] = L254_5
        L16_5 = L16_5(L17_5)
        L15_5.Color = L16_5
        L13_5 = L13_5(L14_5, L15_5)
        L14_5 = L12_1
        L15_5 = "UICorner"
        L16_5 = {}
        L17_5 = UDim
        L17_5 = L17_5.new
        L18_5 = 0
        L19_5 = 5
        L17_5 = L17_5(L18_5, L19_5)
        L16_5.CornerRadius = L17_5
        L14_5 = L14_5(L15_5, L16_5)
        L15_5 = L7_5
        L12_5[1] = L13_5
        L12_5[2] = L14_5
        L12_5[3] = L15_5
        L9_5 = L9_5(L10_5, L11_5, L12_5)
        L10_5 = L12_1
        L11_5 = "Frame"
        L12_5 = {}
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 0
        L15_5 = 0
        L16_5 = 0
        L17_5 = 32
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Position = L13_5
        L13_5 = UDim2
        L13_5 = L13_5.new
        L14_5 = 1
        L15_5 = 0
        L16_5 = 1
        L17_5 = -32
        L13_5 = L13_5(L14_5, L15_5, L16_5, L17_5)
        L12_5.Size = L13_5
        L12_5.BackgroundTransparency = 1
        L12_5.ClipsDescendants = true
        L13_5 = {}
        L14_5 = L9_5
        L15_5 = L8_5
        L16_5 = L12_1
        L17_5 = "UIPadding"
        L18_5 = {}
        L19_5 = UDim
        L19_5 = L19_5.new
        L20_5 = 0
        L21_5 = 35
        L19_5 = L19_5(L20_5, L21_5)
        L18_5.PaddingLeft = L19_5
        L19_5 = UDim
        L19_5 = L19_5.new
        L20_5 = 0
        L21_5 = 35
        L19_5 = L19_5(L20_5, L21_5)
        L18_5.PaddingRight = L19_5
        L19_5 = UDim
        L19_5 = L19_5.new
        L20_5 = 0
        L21_5 = 10
        L19_5 = L19_5(L20_5, L21_5)
        L18_5.PaddingBottom = L19_5
        L19_5 = UDim
        L19_5 = L19_5.new
        L20_5 = 0
        L21_5 = 17
        L19_5 = L19_5(L20_5, L21_5)
        L18_5.PaddingTop = L19_5
        L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L16_5(L17_5, L18_5)
        L13_5[1] = L14_5
        L13_5[2] = L15_5
        L13_5[3] = L16_5
        L13_5[4] = L17_5
        L13_5[5] = L18_5
        L13_5[6] = L19_5
        L13_5[7] = L20_5
        L13_5[8] = L21_5
        L13_5[9] = L22_5
        L13_5[10] = L23_5
        L13_5[11] = L24_5
        L13_5[12] = L25_5
        L13_5[13] = L26_5
        L13_5[14] = L27_5
        L13_5[15] = L28_5
        L13_5[16] = L29_5
        L13_5[17] = L30_5
        L13_5[18] = L31_5
        L13_5[19] = L32_5
        L13_5[20] = L33_5
        L13_5[21] = L34_5
        L13_5[22] = L35_5
        L13_5[23] = L36_5
        L13_5[24] = L37_5
        L13_5[25] = L38_5
        L13_5[26] = L39_5
        L13_5[27] = L40_5
        L13_5[28] = L41_5
        L13_5[29] = L42_5
        L13_5[30] = L43_5
        L13_5[31] = L44_5
        L13_5[32] = L45_5
        L13_5[33] = L46_5
        L13_5[34] = L47_5
        L13_5[35] = L48_5
        L13_5[36] = L49_5
        L13_5[37] = L50_5
        L13_5[38] = L51_5
        L13_5[39] = L52_5
        L13_5[40] = L53_5
        L13_5[41] = L54_5
        L13_5[42] = L55_5
        L13_5[43] = L56_5
        L13_5[44] = L57_5
        L13_5[45] = L58_5
        L13_5[46] = L59_5
        L13_5[47] = L60_5
        L13_5[48] = L61_5
        L13_5[49] = L62_5
        L13_5[50] = L63_5
        L13_5[51] = L64_5
        L13_5[52] = L65_5
        L13_5[53] = L66_5
        L13_5[54] = L67_5
        L13_5[55] = L68_5
        L13_5[56] = L69_5
        L13_5[57] = L70_5
        L13_5[58] = L71_5
        L13_5[59] = L72_5
        L13_5[60] = L73_5
        L13_5[61] = L74_5
        L13_5[62] = L75_5
        L13_5[63] = L76_5
        L13_5[64] = L77_5
        L13_5[65] = L78_5
        L13_5[66] = L79_5
        L13_5[67] = L80_5
        L13_5[68] = L81_5
        L13_5[69] = L82_5
        L13_5[70] = L83_5
        L13_5[71] = L84_5
        L13_5[72] = L85_5
        L13_5[73] = L86_5
        L13_5[74] = L87_5
        L13_5[75] = L88_5
        L13_5[76] = L89_5
        L13_5[77] = L90_5
        L13_5[78] = L91_5
        L13_5[79] = L92_5
        L13_5[80] = L93_5
        L13_5[81] = L94_5
        L13_5[82] = L95_5
        L13_5[83] = L96_5
        L13_5[84] = L97_5
        L13_5[85] = L98_5
        L13_5[86] = L99_5
        L13_5[87] = L100_5
        L13_5[88] = L101_5
        L13_5[89] = L102_5
        L13_5[90] = L103_5
        L13_5[91] = L104_5
        L13_5[92] = L105_5
        L13_5[93] = L106_5
        L13_5[94] = L107_5
        L13_5[95] = L108_5
        L13_5[96] = L109_5
        L13_5[97] = L110_5
        L13_5[98] = L111_5
        L13_5[99] = L112_5
        L13_5[100] = L113_5
        L13_5[101] = L114_5
        L13_5[102] = L115_5
        L13_5[103] = L116_5
        L13_5[104] = L117_5
        L13_5[105] = L118_5
        L13_5[106] = L119_5
        L13_5[107] = L120_5
        L13_5[108] = L121_5
        L13_5[109] = L122_5
        L13_5[110] = L123_5
        L13_5[111] = L124_5
        L13_5[112] = L125_5
        L13_5[113] = L126_5
        L13_5[114] = L127_5
        L13_5[115] = L128_5
        L13_5[116] = L129_5
        L13_5[117] = L130_5
        L13_5[118] = L131_5
        L13_5[119] = L132_5
        L13_5[120] = L133_5
        L13_5[121] = L134_5
        L13_5[122] = L135_5
        L13_5[123] = L136_5
        L13_5[124] = L137_5
        L13_5[125] = L138_5
        L13_5[126] = L139_5
        L13_5[127] = L140_5
        L13_5[128] = L141_5
        L13_5[129] = L142_5
        L13_5[130] = L143_5
        L13_5[131] = L144_5
        L13_5[132] = L145_5
        L13_5[133] = L146_5
        L13_5[134] = L147_5
        L13_5[135] = L148_5
        L13_5[136] = L149_5
        L13_5[137] = L150_5
        L13_5[138] = L151_5
        L13_5[139] = L152_5
        L13_5[140] = L153_5
        L13_5[141] = L154_5
        L13_5[142] = L155_5
        L13_5[143] = L156_5
        L13_5[144] = L157_5
        L13_5[145] = L158_5
        L13_5[146] = L159_5
        L13_5[147] = L160_5
        L13_5[148] = L161_5
        L13_5[149] = L162_5
        L13_5[150] = L163_5
        L13_5[151] = L164_5
        L13_5[152] = L165_5
        L13_5[153] = L166_5
        L13_5[154] = L167_5
        L13_5[155] = L168_5
        L13_5[156] = L169_5
        L13_5[157] = L170_5
        L13_5[158] = L171_5
        L13_5[159] = L172_5
        L13_5[160] = L173_5
        L13_5[161] = L174_5
        L13_5[162] = L175_5
        L13_5[163] = L176_5
        L13_5[164] = L177_5
        L13_5[165] = L178_5
        L13_5[166] = L179_5
        L13_5[167] = L180_5
        L13_5[168] = L181_5
        L13_5[169] = L182_5
        L13_5[170] = L183_5
        L13_5[171] = L184_5
        L13_5[172] = L185_5
        L13_5[173] = L186_5
        L13_5[174] = L187_5
        L13_5[175] = L188_5
        L13_5[176] = L189_5
        L13_5[177] = L190_5
        L13_5[178] = L191_5
        L13_5[179] = L192_5
        L13_5[180] = L193_5
        L13_5[181] = L194_5
        L13_5[182] = L195_5
        L13_5[183] = L196_5
        L13_5[184] = L197_5
        L13_5[185] = L198_5
        L13_5[186] = L199_5
        L13_5[187] = L200_5
        L13_5[188] = L201_5
        L13_5[189] = L202_5
        L13_5[190] = L203_5
        L13_5[191] = L204_5
        L13_5[192] = L205_5
        L13_5[193] = L206_5
        L13_5[194] = L207_5
        L13_5[195] = L208_5
        L13_5[196] = L209_5
        L13_5[197] = L210_5
        L13_5[198] = L211_5
        L13_5[199] = L212_5
        L13_5[200] = L213_5
        L13_5[201] = L214_5
        L13_5[202] = L215_5
        L13_5[203] = L216_5
        L13_5[204] = L217_5
        L13_5[205] = L218_5
        L13_5[206] = L219_5
        L13_5[207] = L220_5
        L13_5[208] = L221_5
        L13_5[209] = L222_5
        L13_5[210] = L223_5
        L13_5[211] = L224_5
        L13_5[212] = L225_5
        L13_5[213] = L226_5
        L13_5[214] = L227_5
        L13_5[215] = L228_5
        L13_5[216] = L229_5
        L13_5[217] = L230_5
        L13_5[218] = L231_5
        L13_5[219] = L232_5
        L13_5[220] = L233_5
        L13_5[221] = L234_5
        L13_5[222] = L235_5
        L13_5[223] = L236_5
        L13_5[224] = L237_5
        L13_5[225] = L238_5
        L13_5[226] = L239_5
        L13_5[227] = L240_5
        L13_5[228] = L241_5
        L13_5[229] = L242_5
        L13_5[230] = L243_5
        L13_5[231] = L244_5
        L13_5[232] = L245_5
        L13_5[233] = L246_5
        L13_5[234] = L247_5
        L13_5[235] = L248_5
        L13_5[236] = L249_5
        L13_5[237] = L250_5
        L13_5[238] = L251_5
        L13_5[239] = L252_5
        L13_5[240] = L253_5
        L13_5[241] = L254_5
        L10_5 = L10_5(L11_5, L12_5, L13_5)
        L11_5 = L15_1
        L12_5 = L14_1
        L13_5 = "Button"
        L12_5 = L12_5(L13_5)
        L13_5 = {}
        L14_5 = UDim2
        L14_5 = L14_5.new
        L15_5 = 1
        L16_5 = 0
        L17_5 = 1
        L18_5 = 0
        L14_5 = L14_5(L15_5, L16_5, L17_5, L18_5)
        L13_5.Size = L14_5
        L11_5 = L11_5(L12_5, L13_5)
        L12_5 = L19_1
        L13_5 = L16_1
        L14_5 = L15_1
        L15_5 = L14_1
        L16_5 = "RoundFrame"
        L17_5 = Color3
        L17_5 = L17_5.fromRGB
        L18_5 = 255
        L19_5 = 255
        L20_5 = 255
        L17_5 = L17_5(L18_5, L19_5, L20_5)
        L18_5 = 0
        L19_5 = 4
        L15_5 = L15_5(L16_5, L17_5, L18_5, L19_5)
        L16_5 = {}
        L17_5 = UDim2
        L17_5 = L17_5.new
        L18_5 = 0
        L19_5 = 24
        L20_5 = 0
        L21_5 = 24
        L17_5 = L17_5(L18_5, L19_5, L20_5, L21_5)
        L16_5.Size = L17_5
        L17_5 = UDim2
        L17_5 = L17_5.new
        L18_5 = 1
        L19_5 = -12
        L20_5 = 0.5
        L21_5 = 0
        L17_5 = L17_5(L18_5, L19_5, L20_5, L21_5)
        L16_5.Position = L17_5
        L17_5 = Vector2
        L17_5 = L17_5.new
        L18_5 = 1
        L19_5 = 0.5
        L17_5 = L17_5(L18_5, L19_5)
        L16_5.AnchorPoint = L17_5
        L14_5 = L14_5(L15_5, L16_5)
        L15_5 = {}
        L16_5 = L19_1
        L17_5 = L14_1
        L18_5 = "Stroke"
        L17_5 = L17_5(L18_5)
        L18_5 = "Stroke"
        L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L16_5(L17_5, L18_5)
        L15_5[1] = L16_5
        L15_5[2] = L17_5
        L15_5[3] = L18_5
        L15_5[4] = L19_5
        L15_5[5] = L20_5
        L15_5[6] = L21_5
        L15_5[7] = L22_5
        L15_5[8] = L23_5
        L15_5[9] = L24_5
        L15_5[10] = L25_5
        L15_5[11] = L26_5
        L15_5[12] = L27_5
        L15_5[13] = L28_5
        L15_5[14] = L29_5
        L15_5[15] = L30_5
        L15_5[16] = L31_5
        L15_5[17] = L32_5
        L15_5[18] = L33_5
        L15_5[19] = L34_5
        L15_5[20] = L35_5
        L15_5[21] = L36_5
        L15_5[22] = L37_5
        L15_5[23] = L38_5
        L15_5[24] = L39_5
        L15_5[25] = L40_5
        L15_5[26] = L41_5
        L15_5[27] = L42_5
        L15_5[28] = L43_5
        L15_5[29] = L44_5
        L15_5[30] = L45_5
        L15_5[31] = L46_5
        L15_5[32] = L47_5
        L15_5[33] = L48_5
        L15_5[34] = L49_5
        L15_5[35] = L50_5
        L15_5[36] = L51_5
        L15_5[37] = L52_5
        L15_5[38] = L53_5
        L15_5[39] = L54_5
        L15_5[40] = L55_5
        L15_5[41] = L56_5
        L15_5[42] = L57_5
        L15_5[43] = L58_5
        L15_5[44] = L59_5
        L15_5[45] = L60_5
        L15_5[46] = L61_5
        L15_5[47] = L62_5
        L15_5[48] = L63_5
        L15_5[49] = L64_5
        L15_5[50] = L65_5
        L15_5[51] = L66_5
        L15_5[52] = L67_5
        L15_5[53] = L68_5
        L15_5[54] = L69_5
        L15_5[55] = L70_5
        L15_5[56] = L71_5
        L15_5[57] = L72_5
        L15_5[58] = L73_5
        L15_5[59] = L74_5
        L15_5[60] = L75_5
        L15_5[61] = L76_5
        L15_5[62] = L77_5
        L15_5[63] = L78_5
        L15_5[64] = L79_5
        L15_5[65] = L80_5
        L15_5[66] = L81_5
        L15_5[67] = L82_5
        L15_5[68] = L83_5
        L15_5[69] = L84_5
        L15_5[70] = L85_5
        L15_5[71] = L86_5
        L15_5[72] = L87_5
        L15_5[73] = L88_5
        L15_5[74] = L89_5
        L15_5[75] = L90_5
        L15_5[76] = L91_5
        L15_5[77] = L92_5
        L15_5[78] = L93_5
        L15_5[79] = L94_5
        L15_5[80] = L95_5
        L15_5[81] = L96_5
        L15_5[82] = L97_5
        L15_5[83] = L98_5
        L15_5[84] = L99_5
        L15_5[85] = L100_5
        L15_5[86] = L101_5
        L15_5[87] = L102_5
        L15_5[88] = L103_5
        L15_5[89] = L104_5
        L15_5[90] = L105_5
        L15_5[91] = L106_5
        L15_5[92] = L107_5
        L15_5[93] = L108_5
        L15_5[94] = L109_5
        L15_5[95] = L110_5
        L15_5[96] = L111_5
        L15_5[97] = L112_5
        L15_5[98] = L113_5
        L15_5[99] = L114_5
        L15_5[100] = L115_5
        L15_5[101] = L116_5
        L15_5[102] = L117_5
        L15_5[103] = L118_5
        L15_5[104] = L119_5
        L15_5[105] = L120_5
        L15_5[106] = L121_5
        L15_5[107] = L122_5
        L15_5[108] = L123_5
        L15_5[109] = L124_5
        L15_5[110] = L125_5
        L15_5[111] = L126_5
        L15_5[112] = L127_5
        L15_5[113] = L128_5
        L15_5[114] = L129_5
        L15_5[115] = L130_5
        L15_5[116] = L131_5
        L15_5[117] = L132_5
        L15_5[118] = L133_5
        L15_5[119] = L134_5
        L15_5[120] = L135_5
        L15_5[121] = L136_5
        L15_5[122] = L137_5
        L15_5[123] = L138_5
        L15_5[124] = L139_5
        L15_5[125] = L140_5
        L15_5[126] = L141_5
        L15_5[127] = L142_5
        L15_5[128] = L143_5
        L15_5[129] = L144_5
        L15_5[130] = L145_5
        L15_5[131] = L146_5
        L15_5[132] = L147_5
        L15_5[133] = L148_5
        L15_5[134] = L149_5
        L15_5[135] = L150_5
        L15_5[136] = L151_5
        L15_5[137] = L152_5
        L15_5[138] = L153_5
        L15_5[139] = L154_5
        L15_5[140] = L155_5
        L15_5[141] = L156_5
        L15_5[142] = L157_5
        L15_5[143] = L158_5
        L15_5[144] = L159_5
        L15_5[145] = L160_5
        L15_5[146] = L161_5
        L15_5[147] = L162_5
        L15_5[148] = L163_5
        L15_5[149] = L164_5
        L15_5[150] = L165_5
        L15_5[151] = L166_5
        L15_5[152] = L167_5
        L15_5[153] = L168_5
        L15_5[154] = L169_5
        L15_5[155] = L170_5
        L15_5[156] = L171_5
        L15_5[157] = L172_5
        L15_5[158] = L173_5
        L15_5[159] = L174_5
        L15_5[160] = L175_5
        L15_5[161] = L176_5
        L15_5[162] = L177_5
        L15_5[163] = L178_5
        L15_5[164] = L179_5
        L15_5[165] = L180_5
        L15_5[166] = L181_5
        L15_5[167] = L182_5
        L15_5[168] = L183_5
        L15_5[169] = L184_5
        L15_5[170] = L185_5
        L15_5[171] = L186_5
        L15_5[172] = L187_5
        L15_5[173] = L188_5
        L15_5[174] = L189_5
        L15_5[175] = L190_5
        L15_5[176] = L191_5
        L15_5[177] = L192_5
        L15_5[178] = L193_5
        L15_5[179] = L194_5
        L15_5[180] = L195_5
        L15_5[181] = L196_5
        L15_5[182] = L197_5
        L15_5[183] = L198_5
        L15_5[184] = L199_5
        L15_5[185] = L200_5
        L15_5[186] = L201_5
        L15_5[187] = L202_5
        L15_5[188] = L203_5
        L15_5[189] = L204_5
        L15_5[190] = L205_5
        L15_5[191] = L206_5
        L15_5[192] = L207_5
        L15_5[193] = L208_5
        L15_5[194] = L209_5
        L15_5[195] = L210_5
        L15_5[196] = L211_5
        L15_5[197] = L212_5
        L15_5[198] = L213_5
        L15_5[199] = L214_5
        L15_5[200] = L215_5
        L15_5[201] = L216_5
        L15_5[202] = L217_5
        L15_5[203] = L218_5
        L15_5[204] = L219_5
        L15_5[205] = L220_5
        L15_5[206] = L221_5
        L15_5[207] = L222_5
        L15_5[208] = L223_5
        L15_5[209] = L224_5
        L15_5[210] = L225_5
        L15_5[211] = L226_5
        L15_5[212] = L227_5
        L15_5[213] = L228_5
        L15_5[214] = L229_5
        L15_5[215] = L230_5
        L15_5[216] = L231_5
        L15_5[217] = L232_5
        L15_5[218] = L233_5
        L15_5[219] = L234_5
        L15_5[220] = L235_5
        L15_5[221] = L236_5
        L15_5[222] = L237_5
        L15_5[223] = L238_5
        L15_5[224] = L239_5
        L15_5[225] = L240_5
        L15_5[226] = L241_5
        L15_5[227] = L242_5
        L15_5[228] = L243_5
        L15_5[229] = L244_5
        L15_5[230] = L245_5
        L15_5[231] = L246_5
        L15_5[232] = L247_5
        L15_5[233] = L248_5
        L15_5[234] = L249_5
        L15_5[235] = L250_5
        L15_5[236] = L251_5
        L15_5[237] = L252_5
        L15_5[238] = L253_5
        L15_5[239] = L254_5
        L13_5 = L13_5(L14_5, L15_5)
        L14_5 = "Main"
        L12_5 = L12_5(L13_5, L14_5)
        L13_5 = L19_1
        L14_5 = L16_1
        L15_5 = L15_1
        L16_5 = L14_1
        L17_5 = "RoundFrame"
        L18_5 = Color3
        L18_5 = L18_5.fromRGB
        L19_5 = 255
        L20_5 = 255
        L21_5 = 255
        L18_5 = L18_5(L19_5, L20_5, L21_5)
        L19_5 = 0
        L20_5 = 5
        L16_5 = L16_5(L17_5, L18_5, L19_5, L20_5)
        L17_5 = {}
        L18_5 = UDim2
        L18_5 = L18_5.new
        L19_5 = 1
        L20_5 = 0
        L21_5 = 0
        L22_5 = 38
        L18_5 = L18_5(L19_5, L20_5, L21_5, L22_5)
        L17_5.Size = L18_5
        L18_5 = A0_4
        L17_5.Parent = L18_5
        L15_5 = L15_5(L16_5, L17_5)
        L16_5 = {}
        L17_5 = L15_1
        L18_5 = L16_1
        L19_5 = L14_1
        L20_5 = "TFrame"
        L19_5 = L19_5(L20_5)
        L20_5 = {}
        L21_5 = L19_1
        L22_5 = L15_1
        L23_5 = L14_1
        L24_5 = "Label"
        L25_5 = A1_5.Name
        L26_5 = 15
        L23_5 = L23_5(L24_5, L25_5, L26_5)
        L24_5 = {}
        L25_5 = UDim2
        L25_5 = L25_5.new
        L26_5 = 1
        L27_5 = -12
        L28_5 = 1
        L29_5 = 0
        L25_5 = L25_5(L26_5, L27_5, L28_5, L29_5)
        L24_5.Size = L25_5
        L25_5 = UDim2
        L25_5 = L25_5.new
        L26_5 = 0
        L27_5 = 12
        L28_5 = 0
        L29_5 = 0
        L25_5 = L25_5(L26_5, L27_5, L28_5, L29_5)
        L24_5.Position = L25_5
        L25_5 = Enum
        L25_5 = L25_5.Font
        L25_5 = L25_5.GothamBold
        L24_5.Font = L25_5
        L24_5.Name = "Content"
        L22_5 = L22_5(L23_5, L24_5)
        L23_5 = "Text"
        L21_5 = L21_5(L22_5, L23_5)
        L22_5 = L12_5
        L23_5 = L11_5
        L24_5 = L19_1
        L25_5 = L15_1
        L26_5 = L14_1
        L27_5 = "Frame"
        L26_5 = L26_5(L27_5)
        L27_5 = {}
        L28_5 = UDim2
        L28_5 = L28_5.new
        L29_5 = 1
        L30_5 = 0
        L31_5 = 0
        L32_5 = 1
        L28_5 = L28_5(L29_5, L30_5, L31_5, L32_5)
        L27_5.Size = L28_5
        L28_5 = UDim2
        L28_5 = L28_5.new
        L29_5 = 0
        L30_5 = 0
        L31_5 = 1
        L32_5 = -1
        L28_5 = L28_5(L29_5, L30_5, L31_5, L32_5)
        L27_5.Position = L28_5
        L27_5.Name = "Line"
        L27_5.Visible = false
        L25_5 = L25_5(L26_5, L27_5)
        L26_5 = "Stroke"
        L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L24_5(L25_5, L26_5)
        L20_5[1] = L21_5
        L20_5[2] = L22_5
        L20_5[3] = L23_5
        L20_5[4] = L24_5
        L20_5[5] = L25_5
        L20_5[6] = L26_5
        L20_5[7] = L27_5
        L20_5[8] = L28_5
        L20_5[9] = L29_5
        L20_5[10] = L30_5
        L20_5[11] = L31_5
        L20_5[12] = L32_5
        L20_5[13] = L33_5
        L20_5[14] = L34_5
        L20_5[15] = L35_5
        L20_5[16] = L36_5
        L20_5[17] = L37_5
        L20_5[18] = L38_5
        L20_5[19] = L39_5
        L20_5[20] = L40_5
        L20_5[21] = L41_5
        L20_5[22] = L42_5
        L20_5[23] = L43_5
        L20_5[24] = L44_5
        L20_5[25] = L45_5
        L20_5[26] = L46_5
        L20_5[27] = L47_5
        L20_5[28] = L48_5
        L20_5[29] = L49_5
        L20_5[30] = L50_5
        L20_5[31] = L51_5
        L20_5[32] = L52_5
        L20_5[33] = L53_5
        L20_5[34] = L54_5
        L20_5[35] = L55_5
        L20_5[36] = L56_5
        L20_5[37] = L57_5
        L20_5[38] = L58_5
        L20_5[39] = L59_5
        L20_5[40] = L60_5
        L20_5[41] = L61_5
        L20_5[42] = L62_5
        L20_5[43] = L63_5
        L20_5[44] = L64_5
        L20_5[45] = L65_5
        L20_5[46] = L66_5
        L20_5[47] = L67_5
        L20_5[48] = L68_5
        L20_5[49] = L69_5
        L20_5[50] = L70_5
        L20_5[51] = L71_5
        L20_5[52] = L72_5
        L20_5[53] = L73_5
        L20_5[54] = L74_5
        L20_5[55] = L75_5
        L20_5[56] = L76_5
        L20_5[57] = L77_5
        L20_5[58] = L78_5
        L20_5[59] = L79_5
        L20_5[60] = L80_5
        L20_5[61] = L81_5
        L20_5[62] = L82_5
        L20_5[63] = L83_5
        L20_5[64] = L84_5
        L20_5[65] = L85_5
        L20_5[66] = L86_5
        L20_5[67] = L87_5
        L20_5[68] = L88_5
        L20_5[69] = L89_5
        L20_5[70] = L90_5
        L20_5[71] = L91_5
        L20_5[72] = L92_5
        L20_5[73] = L93_5
        L20_5[74] = L94_5
        L20_5[75] = L95_5
        L20_5[76] = L96_5
        L20_5[77] = L97_5
        L20_5[78] = L98_5
        L20_5[79] = L99_5
        L20_5[80] = L100_5
        L20_5[81] = L101_5
        L20_5[82] = L102_5
        L20_5[83] = L103_5
        L20_5[84] = L104_5
        L20_5[85] = L105_5
        L20_5[86] = L106_5
        L20_5[87] = L107_5
        L20_5[88] = L108_5
        L20_5[89] = L109_5
        L20_5[90] = L110_5
        L20_5[91] = L111_5
        L20_5[92] = L112_5
        L20_5[93] = L113_5
        L20_5[94] = L114_5
        L20_5[95] = L115_5
        L20_5[96] = L116_5
        L20_5[97] = L117_5
        L20_5[98] = L118_5
        L20_5[99] = L119_5
        L20_5[100] = L120_5
        L20_5[101] = L121_5
        L20_5[102] = L122_5
        L20_5[103] = L123_5
        L20_5[104] = L124_5
        L20_5[105] = L125_5
        L20_5[106] = L126_5
        L20_5[107] = L127_5
        L20_5[108] = L128_5
        L20_5[109] = L129_5
        L20_5[110] = L130_5
        L20_5[111] = L131_5
        L20_5[112] = L132_5
        L20_5[113] = L133_5
        L20_5[114] = L134_5
        L20_5[115] = L135_5
        L20_5[116] = L136_5
        L20_5[117] = L137_5
        L20_5[118] = L138_5
        L20_5[119] = L139_5
        L20_5[120] = L140_5
        L20_5[121] = L141_5
        L20_5[122] = L142_5
        L20_5[123] = L143_5
        L20_5[124] = L144_5
        L20_5[125] = L145_5
        L20_5[126] = L146_5
        L20_5[127] = L147_5
        L20_5[128] = L148_5
        L20_5[129] = L149_5
        L20_5[130] = L150_5
        L20_5[131] = L151_5
        L20_5[132] = L152_5
        L20_5[133] = L153_5
        L20_5[134] = L154_5
        L20_5[135] = L155_5
        L20_5[136] = L156_5
        L20_5[137] = L157_5
        L20_5[138] = L158_5
        L20_5[139] = L159_5
        L20_5[140] = L160_5
        L20_5[141] = L161_5
        L20_5[142] = L162_5
        L20_5[143] = L163_5
        L20_5[144] = L164_5
        L20_5[145] = L165_5
        L20_5[146] = L166_5
        L20_5[147] = L167_5
        L20_5[148] = L168_5
        L20_5[149] = L169_5
        L20_5[150] = L170_5
        L20_5[151] = L171_5
        L20_5[152] = L172_5
        L20_5[153] = L173_5
        L20_5[154] = L174_5
        L20_5[155] = L175_5
        L20_5[156] = L176_5
        L20_5[157] = L177_5
        L20_5[158] = L178_5
        L20_5[159] = L179_5
        L20_5[160] = L180_5
        L20_5[161] = L181_5
        L20_5[162] = L182_5
        L20_5[163] = L183_5
        L20_5[164] = L184_5
        L20_5[165] = L185_5
        L20_5[166] = L186_5
        L20_5[167] = L187_5
        L20_5[168] = L188_5
        L20_5[169] = L189_5
        L20_5[170] = L190_5
        L20_5[171] = L191_5
        L20_5[172] = L192_5
        L20_5[173] = L193_5
        L20_5[174] = L194_5
        L20_5[175] = L195_5
        L20_5[176] = L196_5
        L20_5[177] = L197_5
        L20_5[178] = L198_5
        L20_5[179] = L199_5
        L20_5[180] = L200_5
        L20_5[181] = L201_5
        L20_5[182] = L202_5
        L20_5[183] = L203_5
        L20_5[184] = L204_5
        L20_5[185] = L205_5
        L20_5[186] = L206_5
        L20_5[187] = L207_5
        L20_5[188] = L208_5
        L20_5[189] = L209_5
        L20_5[190] = L210_5
        L20_5[191] = L211_5
        L20_5[192] = L212_5
        L20_5[193] = L213_5
        L20_5[194] = L214_5
        L20_5[195] = L215_5
        L20_5[196] = L216_5
        L20_5[197] = L217_5
        L20_5[198] = L218_5
        L20_5[199] = L219_5
        L20_5[200] = L220_5
        L20_5[201] = L221_5
        L20_5[202] = L222_5
        L20_5[203] = L223_5
        L20_5[204] = L224_5
        L20_5[205] = L225_5
        L20_5[206] = L226_5
        L20_5[207] = L227_5
        L20_5[208] = L228_5
        L20_5[209] = L229_5
        L20_5[210] = L230_5
        L20_5[211] = L231_5
        L20_5[212] = L232_5
        L20_5[213] = L233_5
        L20_5[214] = L234_5
        L20_5[215] = L235_5
        L20_5[216] = L236_5
        L20_5[217] = L237_5
        L20_5[218] = L238_5
        L20_5[219] = L239_5
        L20_5[220] = L240_5
        L20_5[221] = L241_5
        L20_5[222] = L242_5
        L20_5[223] = L243_5
        L20_5[224] = L244_5
        L20_5[225] = L245_5
        L20_5[226] = L246_5
        L20_5[227] = L247_5
        L20_5[228] = L248_5
        L20_5[229] = L249_5
        L20_5[230] = L250_5
        L20_5[231] = L251_5
        L20_5[232] = L252_5
        L20_5[233] = L253_5
        L20_5[234] = L254_5
        L18_5 = L18_5(L19_5, L20_5)
        L19_5 = {}
        L20_5 = UDim2
        L20_5 = L20_5.new
        L21_5 = 1
        L22_5 = 0
        L23_5 = 0
        L24_5 = 38
        L20_5 = L20_5(L21_5, L22_5, L23_5, L24_5)
        L19_5.Size = L20_5
        L19_5.ClipsDescendants = true
        L19_5.Name = "F"
        L17_5 = L17_5(L18_5, L19_5)
        L18_5 = L10_5
        L19_5 = L19_1
        L20_5 = L14_1
        L21_5 = "Stroke"
        L20_5 = L20_5(L21_5)
        L21_5 = "Stroke"
        L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5 = L19_5(L20_5, L21_5)
        L16_5[1] = L17_5
        L16_5[2] = L18_5
        L16_5[3] = L19_5
        L16_5[4] = L20_5
        L16_5[5] = L21_5
        L16_5[6] = L22_5
        L16_5[7] = L23_5
        L16_5[8] = L24_5
        L16_5[9] = L25_5
        L16_5[10] = L26_5
        L16_5[11] = L27_5
        L16_5[12] = L28_5
        L16_5[13] = L29_5
        L16_5[14] = L30_5
        L16_5[15] = L31_5
        L16_5[16] = L32_5
        L16_5[17] = L33_5
        L16_5[18] = L34_5
        L16_5[19] = L35_5
        L16_5[20] = L36_5
        L16_5[21] = L37_5
        L16_5[22] = L38_5
        L16_5[23] = L39_5
        L16_5[24] = L40_5
        L16_5[25] = L41_5
        L16_5[26] = L42_5
        L16_5[27] = L43_5
        L16_5[28] = L44_5
        L16_5[29] = L45_5
        L16_5[30] = L46_5
        L16_5[31] = L47_5
        L16_5[32] = L48_5
        L16_5[33] = L49_5
        L16_5[34] = L50_5
        L16_5[35] = L51_5
        L16_5[36] = L52_5
        L16_5[37] = L53_5
        L16_5[38] = L54_5
        L16_5[39] = L55_5
        L16_5[40] = L56_5
        L16_5[41] = L57_5
        L16_5[42] = L58_5
        L16_5[43] = L59_5
        L16_5[44] = L60_5
        L16_5[45] = L61_5
        L16_5[46] = L62_5
        L16_5[47] = L63_5
        L16_5[48] = L64_5
        L16_5[49] = L65_5
        L16_5[50] = L66_5
        L16_5[51] = L67_5
        L16_5[52] = L68_5
        L16_5[53] = L69_5
        L16_5[54] = L70_5
        L16_5[55] = L71_5
        L16_5[56] = L72_5
        L16_5[57] = L73_5
        L16_5[58] = L74_5
        L16_5[59] = L75_5
        L16_5[60] = L76_5
        L16_5[61] = L77_5
        L16_5[62] = L78_5
        L16_5[63] = L79_5
        L16_5[64] = L80_5
        L16_5[65] = L81_5
        L16_5[66] = L82_5
        L16_5[67] = L83_5
        L16_5[68] = L84_5
        L16_5[69] = L85_5
        L16_5[70] = L86_5
        L16_5[71] = L87_5
        L16_5[72] = L88_5
        L16_5[73] = L89_5
        L16_5[74] = L90_5
        L16_5[75] = L91_5
        L16_5[76] = L92_5
        L16_5[77] = L93_5
        L16_5[78] = L94_5
        L16_5[79] = L95_5
        L16_5[80] = L96_5
        L16_5[81] = L97_5
        L16_5[82] = L98_5
        L16_5[83] = L99_5
        L16_5[84] = L100_5
        L16_5[85] = L101_5
        L16_5[86] = L102_5
        L16_5[87] = L103_5
        L16_5[88] = L104_5
        L16_5[89] = L105_5
        L16_5[90] = L106_5
        L16_5[91] = L107_5
        L16_5[92] = L108_5
        L16_5[93] = L109_5
        L16_5[94] = L110_5
        L16_5[95] = L111_5
        L16_5[96] = L112_5
        L16_5[97] = L113_5
        L16_5[98] = L114_5
        L16_5[99] = L115_5
        L16_5[100] = L116_5
        L16_5[101] = L117_5
        L16_5[102] = L118_5
        L16_5[103] = L119_5
        L16_5[104] = L120_5
        L16_5[105] = L121_5
        L16_5[106] = L122_5
        L16_5[107] = L123_5
        L16_5[108] = L124_5
        L16_5[109] = L125_5
        L16_5[110] = L126_5
        L16_5[111] = L127_5
        L16_5[112] = L128_5
        L16_5[113] = L129_5
        L16_5[114] = L130_5
        L16_5[115] = L131_5
        L16_5[116] = L132_5
        L16_5[117] = L133_5
        L16_5[118] = L134_5
        L16_5[119] = L135_5
        L16_5[120] = L136_5
        L16_5[121] = L137_5
        L16_5[122] = L138_5
        L16_5[123] = L139_5
        L16_5[124] = L140_5
        L16_5[125] = L141_5
        L16_5[126] = L142_5
        L16_5[127] = L143_5
        L16_5[128] = L144_5
        L16_5[129] = L145_5
        L16_5[130] = L146_5
        L16_5[131] = L147_5
        L16_5[132] = L148_5
        L16_5[133] = L149_5
        L16_5[134] = L150_5
        L16_5[135] = L151_5
        L16_5[136] = L152_5
        L16_5[137] = L153_5
        L16_5[138] = L154_5
        L16_5[139] = L155_5
        L16_5[140] = L156_5
        L16_5[141] = L157_5
        L16_5[142] = L158_5
        L16_5[143] = L159_5
        L16_5[144] = L160_5
        L16_5[145] = L161_5
        L16_5[146] = L162_5
        L16_5[147] = L163_5
        L16_5[148] = L164_5
        L16_5[149] = L165_5
        L16_5[150] = L166_5
        L16_5[151] = L167_5
        L16_5[152] = L168_5
        L16_5[153] = L169_5
        L16_5[154] = L170_5
        L16_5[155] = L171_5
        L16_5[156] = L172_5
        L16_5[157] = L173_5
        L16_5[158] = L174_5
        L16_5[159] = L175_5
        L16_5[160] = L176_5
        L16_5[161] = L177_5
        L16_5[162] = L178_5
        L16_5[163] = L179_5
        L16_5[164] = L180_5
        L16_5[165] = L181_5
        L16_5[166] = L182_5
        L16_5[167] = L183_5
        L16_5[168] = L184_5
        L16_5[169] = L185_5
        L16_5[170] = L186_5
        L16_5[171] = L187_5
        L16_5[172] = L188_5
        L16_5[173] = L189_5
        L16_5[174] = L190_5
        L16_5[175] = L191_5
        L16_5[176] = L192_5
        L16_5[177] = L193_5
        L16_5[178] = L194_5
        L16_5[179] = L195_5
        L16_5[180] = L196_5
        L16_5[181] = L197_5
        L16_5[182] = L198_5
        L16_5[183] = L199_5
        L16_5[184] = L200_5
        L16_5[185] = L201_5
        L16_5[186] = L202_5
        L16_5[187] = L203_5
        L16_5[188] = L204_5
        L16_5[189] = L205_5
        L16_5[190] = L206_5
        L16_5[191] = L207_5
        L16_5[192] = L208_5
        L16_5[193] = L209_5
        L16_5[194] = L210_5
        L16_5[195] = L211_5
        L16_5[196] = L212_5
        L16_5[197] = L213_5
        L16_5[198] = L214_5
        L16_5[199] = L215_5
        L16_5[200] = L216_5
        L16_5[201] = L217_5
        L16_5[202] = L218_5
        L16_5[203] = L219_5
        L16_5[204] = L220_5
        L16_5[205] = L221_5
        L16_5[206] = L222_5
        L16_5[207] = L223_5
        L16_5[208] = L224_5
        L16_5[209] = L225_5
        L16_5[210] = L226_5
        L16_5[211] = L227_5
        L16_5[212] = L228_5
        L16_5[213] = L229_5
        L16_5[214] = L230_5
        L16_5[215] = L231_5
        L16_5[216] = L232_5
        L16_5[217] = L233_5
        L16_5[218] = L234_5
        L16_5[219] = L235_5
        L16_5[220] = L236_5
        L16_5[221] = L237_5
        L16_5[222] = L238_5
        L16_5[223] = L239_5
        L16_5[224] = L240_5
        L16_5[225] = L241_5
        L16_5[226] = L242_5
        L16_5[227] = L243_5
        L16_5[228] = L244_5
        L16_5[229] = L245_5
        L16_5[230] = L246_5
        L16_5[231] = L247_5
        L16_5[232] = L248_5
        L16_5[233] = L249_5
        L16_5[234] = L250_5
        L16_5[235] = L251_5
        L16_5[236] = L252_5
        L16_5[237] = L253_5
        L16_5[238] = L254_5
        L14_5 = L14_5(L15_5, L16_5)
        L15_5 = "Second"
        L13_5 = L13_5(L14_5, L15_5)
        L14_5 = L10_1
        L15_5 = L11_5.MouseButton1Click
        
        function L16_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = L5_5
          L1_6 = L5_5
          L1_6 = L1_6.Toggled
          L1_6 = not L1_6
          L0_6.Toggled = L1_6
          L0_6 = L1_1
          L1_6 = L0_6
          L0_6 = L0_6.Create
          L2_6 = L13_5
          L3_6 = TweenInfo
          L3_6 = L3_6.new
          L4_6 = 0.15
          L5_6 = Enum
          L5_6 = L5_6.EasingStyle
          L5_6 = L5_6.Quad
          L6_6 = Enum
          L6_6 = L6_6.EasingDirection
          L6_6 = L6_6.Out
          L3_6 = L3_6(L4_6, L5_6, L6_6)
          L4_6 = {}
          L5_6 = L5_5
          L5_6 = L5_6.Toggled
          if L5_6 then
            L5_6 = UDim2
            L5_6 = L5_6.new
            L6_6 = 1
            L7_6 = 0
            L8_6 = 0
            L9_6 = 148
            L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
            if L5_6 then
              goto lbl_40
            end
          end
          L5_6 = UDim2
          L5_6 = L5_6.new
          L6_6 = 1
          L7_6 = 0
          L8_6 = 0
          L9_6 = 38
          L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
          ::lbl_40::
          L4_6.Size = L5_6
          L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
          L1_6 = L0_6
          L0_6 = L0_6.Play
          L0_6(L1_6)
          L0_6 = L8_5
          L1_6 = L5_5
          L1_6 = L1_6.Toggled
          L0_6.Visible = L1_6
          L0_6 = L9_5
          L1_6 = L5_5
          L1_6 = L1_6.Toggled
          L0_6.Visible = L1_6
          L0_6 = L13_5
          L0_6 = L0_6.F
          L0_6 = L0_6.Line
          L1_6 = L5_5
          L1_6 = L1_6.Toggled
          L0_6.Visible = L1_6
        end
        
        L14_5(L15_5, L16_5)
        
        function L14_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6
          L0_6 = L12_5
          L1_6 = Color3
          L1_6 = L1_6.fromHSV
          L2_6 = L2_5
          L3_6 = L3_5
          L4_6 = L4_5
          L1_6 = L1_6(L2_6, L3_6, L4_6)
          L0_6.BackgroundColor3 = L1_6
          L0_6 = L8_5
          L1_6 = Color3
          L1_6 = L1_6.fromHSV
          L2_6 = L2_5
          L3_6 = 1
          L4_6 = 1
          L1_6 = L1_6(L2_6, L3_6, L4_6)
          L0_6.BackgroundColor3 = L1_6
          L0_6 = L5_5
          L1_6 = L0_6
          L0_6 = L0_6.Set
          L2_6 = L12_5
          L2_6 = L2_6.BackgroundColor3
          L0_6(L1_6, L2_6)
          L0_6 = A1_5
          L0_6 = L0_6.Callback
          L1_6 = L12_5
          L1_6 = L1_6.BackgroundColor3
          L0_6(L1_6)
          L0_6 = L24_1
          L1_6 = game
          L1_6 = L1_6.GameId
          L0_6(L1_6)
        end
        
        L15_5 = math
        L15_5 = L15_5.clamp
        L16_5 = L7_5.AbsolutePosition
        L16_5 = L16_5.Y
        L17_5 = L9_5.AbsolutePosition
        L17_5 = L17_5.Y
        L16_5 = L16_5 - L17_5
        L17_5 = 0
        L18_5 = L9_5.AbsoluteSize
        L18_5 = L18_5.Y
        L15_5 = L15_5(L16_5, L17_5, L18_5)
        L16_5 = L9_5.AbsoluteSize
        L16_5 = L16_5.Y
        L15_5 = L15_5 / L16_5
        L2_5 = 1 - L15_5
        L15_5 = math
        L15_5 = L15_5.clamp
        L16_5 = L6_5.AbsolutePosition
        L16_5 = L16_5.X
        L17_5 = L8_5.AbsolutePosition
        L17_5 = L17_5.X
        L16_5 = L16_5 - L17_5
        L17_5 = 0
        L18_5 = L8_5.AbsoluteSize
        L18_5 = L18_5.X
        L15_5 = L15_5(L16_5, L17_5, L18_5)
        L16_5 = L8_5.AbsoluteSize
        L16_5 = L16_5.X
        L3_5 = L15_5 / L16_5
        L15_5 = math
        L15_5 = L15_5.clamp
        L16_5 = L6_5.AbsolutePosition
        L16_5 = L16_5.Y
        L17_5 = L8_5.AbsolutePosition
        L17_5 = L17_5.Y
        L16_5 = L16_5 - L17_5
        L17_5 = 0
        L18_5 = L8_5.AbsoluteSize
        L18_5 = L18_5.Y
        L15_5 = L15_5(L16_5, L17_5, L18_5)
        L16_5 = L8_5.AbsoluteSize
        L16_5 = L16_5.Y
        L15_5 = L15_5 / L16_5
        L4_5 = 1 - L15_5
        L15_5 = L10_1
        L16_5 = L8_5.InputBegan
        
        function L17_5(A0_6)
          local L1_6, L2_6, L3_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = ColorInput
            if L1_6 then
              L1_6 = ColorInput
              L2_6 = L1_6
              L1_6 = L1_6.Disconnect
              L1_6(L2_6)
            end
            L1_6 = L10_1
            L2_6 = L2_1
            L2_6 = L2_6.RenderStepped
            
            function L3_6()
              local L0_7, L1_7, L2_7, L3_7, L4_7, L5_7, L6_7, L7_7, L8_7, L9_7, L10_7, L11_7, L12_7, L13_7, L14_7, L15_7, L16_7, L17_7, L18_7, L19_7, L20_7, L21_7, L22_7, L23_7, L24_7, L25_7, L26_7, L27_7, L28_7, L29_7, L30_7, L31_7, L32_7, L33_7, L34_7, L35_7, L36_7, L37_7, L38_7, L39_7, L40_7, L41_7, L42_7, L43_7, L44_7, L45_7, L46_7, L47_7, L48_7, L49_7, L50_7, L51_7, L52_7, L53_7, L54_7, L55_7, L56_7, L57_7, L58_7, L59_7, L60_7, L61_7, L62_7, L63_7, L64_7, L65_7, L66_7, L67_7, L68_7, L69_7, L70_7, L71_7, L72_7, L73_7, L74_7, L75_7, L76_7, L77_7, L78_7, L79_7, L80_7, L81_7, L82_7, L83_7, L84_7, L85_7, L86_7, L87_7, L88_7, L89_7, L90_7, L91_7, L92_7, L93_7, L94_7, L95_7, L96_7, L97_7, L98_7, L99_7, L100_7, L101_7, L102_7, L103_7, L104_7, L105_7, L106_7, L107_7, L108_7, L109_7, L110_7, L111_7, L112_7, L113_7, L114_7, L115_7, L116_7, L117_7, L118_7, L119_7, L120_7, L121_7, L122_7, L123_7, L124_7, L125_7, L126_7, L127_7, L128_7, L129_7, L130_7, L131_7, L132_7, L133_7, L134_7, L135_7, L136_7, L137_7, L138_7, L139_7, L140_7, L141_7, L142_7, L143_7, L144_7, L145_7, L146_7, L147_7, L148_7, L149_7, L150_7, L151_7, L152_7, L153_7, L154_7, L155_7, L156_7, L157_7, L158_7, L159_7, L160_7, L161_7, L162_7, L163_7, L164_7, L165_7, L166_7, L167_7, L168_7, L169_7, L170_7, L171_7, L172_7, L173_7, L174_7, L175_7, L176_7, L177_7, L178_7, L179_7, L180_7, L181_7, L182_7, L183_7, L184_7, L185_7, L186_7, L187_7, L188_7, L189_7, L190_7, L191_7, L192_7, L193_7, L194_7, L195_7, L196_7, L197_7, L198_7, L199_7, L200_7, L201_7, L202_7, L203_7, L204_7, L205_7, L206_7, L207_7, L208_7, L209_7, L210_7, L211_7, L212_7, L213_7, L214_7, L215_7, L216_7, L217_7, L218_7, L219_7, L220_7, L221_7, L222_7, L223_7, L224_7, L225_7, L226_7, L227_7, L228_7, L229_7, L230_7, L231_7, L232_7, L233_7, L234_7, L235_7, L236_7, L237_7, L238_7, L239_7, L240_7, L241_7, L242_7, L243_7, L244_7, L245_7, L246_7, L247_7, L248_7, L249_7, L250_7, L251_7, L252_7, L253_7, L254_7
              L0_7 = math
              L0_7 = L0_7.clamp
              L1_7 = L4_1
              L1_7 = L1_7.X
              L2_7 = L8_5
              L2_7 = L2_7.AbsolutePosition
              L2_7 = L2_7.X
              L1_7 = L1_7 - L2_7
              L2_7 = 0
              L3_7 = L8_5
              L3_7 = L3_7.AbsoluteSize
              L3_7 = L3_7.X
              L0_7 = L0_7(L1_7, L2_7, L3_7)
              L1_7 = L8_5
              L1_7 = L1_7.AbsoluteSize
              L1_7 = L1_7.X
              L0_7 = L0_7 / L1_7
              L1_7 = math
              L1_7 = L1_7.clamp
              L2_7 = L4_1
              L2_7 = L2_7.Y
              L3_7 = L8_5
              L3_7 = L3_7.AbsolutePosition
              L3_7 = L3_7.Y
              L2_7 = L2_7 - L3_7
              L3_7 = 0
              L4_7 = L8_5
              L4_7 = L4_7.AbsoluteSize
              L4_7 = L4_7.Y
              L1_7 = L1_7(L2_7, L3_7, L4_7)
              L2_7 = L8_5
              L2_7 = L2_7.AbsoluteSize
              L2_7 = L2_7.Y
              L1_7 = L1_7 / L2_7
              L2_7 = L6_5
              L3_7 = UDim2
              L3_7 = L3_7.new
              L4_7 = L0_7
              L5_7 = 0
              L6_7 = L1_7
              L7_7 = 0
              L3_7 = L3_7(L4_7, L5_7, L6_7, L7_7)
              L2_7.Position = L3_7
              L3_5 = L0_7
              L2_7 = 1 - L1_7
              L4_5 = L2_7
              L2_7 = L14_5
              L2_7()
            end
            
            L1_6 = L1_6(L2_6, L3_6)
            ColorInput = L1_6
          end
        end
        
        L15_5(L16_5, L17_5)
        L15_5 = L10_1
        L16_5 = L8_5.InputEnded
        
        function L17_5(A0_6)
          local L1_6, L2_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = ColorInput
            if L1_6 then
              L1_6 = ColorInput
              L2_6 = L1_6
              L1_6 = L1_6.Disconnect
              L1_6(L2_6)
            end
          end
        end
        
        L15_5(L16_5, L17_5)
        L15_5 = L10_1
        L16_5 = L9_5.InputBegan
        
        function L17_5(A0_6)
          local L1_6, L2_6, L3_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = HueInput
            if L1_6 then
              L1_6 = HueInput
              L2_6 = L1_6
              L1_6 = L1_6.Disconnect
              L1_6(L2_6)
            end
            L1_6 = L10_1
            L2_6 = L2_1
            L2_6 = L2_6.RenderStepped
            
            function L3_6()
              local L0_7, L1_7, L2_7, L3_7, L4_7, L5_7, L6_7, L7_7, L8_7, L9_7, L10_7, L11_7, L12_7, L13_7, L14_7, L15_7, L16_7, L17_7, L18_7, L19_7, L20_7, L21_7, L22_7, L23_7, L24_7, L25_7, L26_7, L27_7, L28_7, L29_7, L30_7, L31_7, L32_7, L33_7, L34_7, L35_7, L36_7, L37_7, L38_7, L39_7, L40_7, L41_7, L42_7, L43_7, L44_7, L45_7, L46_7, L47_7, L48_7, L49_7, L50_7, L51_7, L52_7, L53_7, L54_7, L55_7, L56_7, L57_7, L58_7, L59_7, L60_7, L61_7, L62_7, L63_7, L64_7, L65_7, L66_7, L67_7, L68_7, L69_7, L70_7, L71_7, L72_7, L73_7, L74_7, L75_7, L76_7, L77_7, L78_7, L79_7, L80_7, L81_7, L82_7, L83_7, L84_7, L85_7, L86_7, L87_7, L88_7, L89_7, L90_7, L91_7, L92_7, L93_7, L94_7, L95_7, L96_7, L97_7, L98_7, L99_7, L100_7, L101_7, L102_7, L103_7, L104_7, L105_7, L106_7, L107_7, L108_7, L109_7, L110_7, L111_7, L112_7, L113_7, L114_7, L115_7, L116_7, L117_7, L118_7, L119_7, L120_7, L121_7, L122_7, L123_7, L124_7, L125_7, L126_7, L127_7, L128_7, L129_7, L130_7, L131_7, L132_7, L133_7, L134_7, L135_7, L136_7, L137_7, L138_7, L139_7, L140_7, L141_7, L142_7, L143_7, L144_7, L145_7, L146_7, L147_7, L148_7, L149_7, L150_7, L151_7, L152_7, L153_7, L154_7, L155_7, L156_7, L157_7, L158_7, L159_7, L160_7, L161_7, L162_7, L163_7, L164_7, L165_7, L166_7, L167_7, L168_7, L169_7, L170_7, L171_7, L172_7, L173_7, L174_7, L175_7, L176_7, L177_7, L178_7, L179_7, L180_7, L181_7, L182_7, L183_7, L184_7, L185_7, L186_7, L187_7, L188_7, L189_7, L190_7, L191_7, L192_7, L193_7, L194_7, L195_7, L196_7, L197_7, L198_7, L199_7, L200_7, L201_7, L202_7, L203_7, L204_7, L205_7, L206_7, L207_7, L208_7, L209_7, L210_7, L211_7, L212_7, L213_7, L214_7, L215_7, L216_7, L217_7, L218_7, L219_7, L220_7, L221_7, L222_7, L223_7, L224_7, L225_7, L226_7, L227_7, L228_7, L229_7, L230_7, L231_7, L232_7, L233_7, L234_7, L235_7, L236_7, L237_7, L238_7, L239_7, L240_7, L241_7, L242_7, L243_7, L244_7, L245_7, L246_7, L247_7, L248_7, L249_7, L250_7, L251_7, L252_7, L253_7, L254_7
              L0_7 = math
              L0_7 = L0_7.clamp
              L1_7 = L4_1
              L1_7 = L1_7.Y
              L2_7 = L9_5
              L2_7 = L2_7.AbsolutePosition
              L2_7 = L2_7.Y
              L1_7 = L1_7 - L2_7
              L2_7 = 0
              L3_7 = L9_5
              L3_7 = L3_7.AbsoluteSize
              L3_7 = L3_7.Y
              L0_7 = L0_7(L1_7, L2_7, L3_7)
              L1_7 = L9_5
              L1_7 = L1_7.AbsoluteSize
              L1_7 = L1_7.Y
              L0_7 = L0_7 / L1_7
              L1_7 = L7_5
              L2_7 = UDim2
              L2_7 = L2_7.new
              L3_7 = 0.5
              L4_7 = 0
              L5_7 = L0_7
              L6_7 = 0
              L2_7 = L2_7(L3_7, L4_7, L5_7, L6_7)
              L1_7.Position = L2_7
              L1_7 = 1 - L0_7
              L2_5 = L1_7
              L1_7 = L14_5
              L1_7()
            end
            
            L1_6 = L1_6(L2_6, L3_6)
            HueInput = L1_6
          end
        end
        
        L15_5(L16_5, L17_5)
        L15_5 = L10_1
        L16_5 = L9_5.InputEnded
        
        function L17_5(A0_6)
          local L1_6, L2_6
          L1_6 = A0_6.UserInputType
          L2_6 = Enum
          L2_6 = L2_6.UserInputType
          L2_6 = L2_6.MouseButton1
          if L1_6 == L2_6 then
            L1_6 = HueInput
            if L1_6 then
              L1_6 = HueInput
              L2_6 = L1_6
              L1_6 = L1_6.Disconnect
              L1_6(L2_6)
            end
          end
        end
        
        L15_5(L16_5, L17_5)
        
        function L15_5(A0_6, A1_6)
          local L2_6, L3_6
          L2_6 = L5_5
          L2_6.Value = A1_6
          L2_6 = L12_5
          L3_6 = L5_5
          L3_6 = L3_6.Value
          L2_6.BackgroundColor3 = L3_6
          L2_6 = A1_5
          L2_6 = L2_6.Callback
          L3_6 = L5_5
          L3_6 = L3_6.Value
          L2_6(L3_6)
        end
        
        L5_5.Set = L15_5
        L16_5 = L5_5
        L15_5 = L5_5.Set
        L17_5 = L5_5.Value
        L15_5(L16_5, L17_5)
        L15_5 = A1_5.Flag
        if L15_5 then
          L15_5 = L6_1
          L15_5 = L15_5.Flags
          L16_5 = A1_5.Flag
          L15_5[L16_5] = L5_5
        end
      end
      
      L1_4.AddColorpicker = L2_4
    end
    
    L5_3 = {}
    
    function L6_3(A0_4, A1_4)
      local L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4
      L2_4 = A1_4.Name
      if not L2_4 then
        L2_4 = "Section"
      end
      A1_4.Name = L2_4
      L2_4 = L16_1
      L3_4 = L15_1
      L4_4 = L14_1
      L5_4 = "TFrame"
      L4_4 = L4_4(L5_4)
      L5_4 = {}
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 1
      L8_4 = 0
      L9_4 = 0
      L10_4 = 26
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L5_4.Size = L6_4
      L6_4 = L3_3
      L5_4.Parent = L6_4
      L3_4 = L3_4(L4_4, L5_4)
      L4_4 = {}
      L5_4 = L19_1
      L6_4 = L15_1
      L7_4 = L14_1
      L8_4 = "Label"
      L9_4 = A1_4.Name
      L10_4 = 14
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L8_4 = {}
      L9_4 = UDim2
      L9_4 = L9_4.new
      L10_4 = 1
      L11_4 = -12
      L12_4 = 0
      L13_4 = 16
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.Size = L9_4
      L9_4 = UDim2
      L9_4 = L9_4.new
      L10_4 = 0
      L11_4 = 0
      L12_4 = 0
      L13_4 = 3
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.Position = L9_4
      L9_4 = Enum
      L9_4 = L9_4.Font
      L9_4 = L9_4.GothamSemibold
      L8_4.Font = L9_4
      L6_4 = L6_4(L7_4, L8_4)
      L7_4 = "TextDark"
      L5_4 = L5_4(L6_4, L7_4)
      L6_4 = L16_1
      L7_4 = L15_1
      L8_4 = L14_1
      L9_4 = "TFrame"
      L8_4 = L8_4(L9_4)
      L9_4 = {}
      L10_4 = Vector2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 0
      L10_4 = L10_4(L11_4, L12_4)
      L9_4.AnchorPoint = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 1
      L12_4 = 0
      L13_4 = 1
      L14_4 = -24
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L9_4.Size = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 0
      L13_4 = 0
      L14_4 = 23
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L9_4.Position = L10_4
      L9_4.Name = "Holder"
      L7_4 = L7_4(L8_4, L9_4)
      L8_4 = {}
      L9_4 = L14_1
      L10_4 = "List"
      L11_4 = 0
      L12_4 = 6
      L9_4, L10_4, L11_4, L12_4, L13_4, L14_4 = L9_4(L10_4, L11_4, L12_4)
      L8_4[1] = L9_4
      L8_4[2] = L10_4
      L8_4[3] = L11_4
      L8_4[4] = L12_4
      L8_4[5] = L13_4
      L8_4[6] = L14_4
      L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4 = L6_4(L7_4, L8_4)
      L4_4[1] = L5_4
      L4_4[2] = L6_4
      L4_4[3] = L7_4
      L4_4[4] = L8_4
      L4_4[5] = L9_4
      L4_4[6] = L10_4
      L4_4[7] = L11_4
      L4_4[8] = L12_4
      L4_4[9] = L13_4
      L4_4[10] = L14_4
      L2_4 = L2_4(L3_4, L4_4)
      L3_4 = L10_1
      L4_4 = L2_4.Holder
      L4_4 = L4_4.UIListLayout
      L5_4 = L4_4
      L4_4 = L4_4.GetPropertyChangedSignal
      L6_4 = "AbsoluteContentSize"
      L4_4 = L4_4(L5_4, L6_4)
      
      function L5_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5
        L0_5 = L2_4
        L1_5 = UDim2
        L1_5 = L1_5.new
        L2_5 = 1
        L3_5 = 0
        L4_5 = 0
        L5_5 = L2_4
        L5_5 = L5_5.Holder
        L5_5 = L5_5.UIListLayout
        L5_5 = L5_5.AbsoluteContentSize
        L5_5 = L5_5.Y
        L5_5 = L5_5 + 31
        L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
        L0_5.Size = L1_5
        L0_5 = L2_4
        L0_5 = L0_5.Holder
        L1_5 = UDim2
        L1_5 = L1_5.new
        L2_5 = 1
        L3_5 = 0
        L4_5 = 0
        L5_5 = L2_4
        L5_5 = L5_5.Holder
        L5_5 = L5_5.UIListLayout
        L5_5 = L5_5.AbsoluteContentSize
        L5_5 = L5_5.Y
        L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
        L0_5.Size = L1_5
      end
      
      L3_4(L4_4, L5_4)
      L3_4 = {}
      L4_4 = next
      L5_4 = L4_3
      L6_4 = L2_4.Holder
      L5_4, L6_4 = L5_4(L6_4)
      for L7_4, L8_4 in L4_4, L5_4, L6_4 do
        L3_4[L7_4] = L8_4
      end
    end
    
    L5_3.AddSection = L6_3
    L6_3 = next
    L7_3 = L4_3
    L8_3 = L3_3
    L7_3, L8_3 = L7_3(L8_3)
    for L9_3, L10_3 in L6_3, L7_3, L8_3 do
      L5_3[L9_3] = L10_3
    end
    L6_3 = A1_3.PremiumOnly
    if L6_3 then
      L6_3 = next
      L7_3 = L5_3
      L8_3 = nil
      for L9_3, L10_3 in L6_3, L7_3, L8_3 do
        function L11_3()
          local L0_4
        end
        
        L5_3[L9_3] = L11_3
      end
      L7_3 = L3_3
      L6_3 = L3_3.FindFirstChild
      L8_3 = "UIListLayout"
      L6_3 = L6_3(L7_3, L8_3)
      L7_3 = L6_3
      L6_3 = L6_3.Destroy
      L6_3(L7_3)
      L7_3 = L3_3
      L6_3 = L3_3.FindFirstChild
      L8_3 = "UIPadding"
      L6_3 = L6_3(L7_3, L8_3)
      L7_3 = L6_3
      L6_3 = L6_3.Destroy
      L6_3(L7_3)
      L6_3 = L16_1
      L7_3 = L15_1
      L8_3 = L14_1
      L9_3 = "TFrame"
      L8_3 = L8_3(L9_3)
      L9_3 = {}
      L10_3 = UDim2
      L10_3 = L10_3.new
      L11_3 = 1
      L12_3 = 0
      L13_3 = 1
      L14_3 = 0
      L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
      L9_3.Size = L10_3
      L10_3 = ItemParent
      L9_3.Parent = L10_3
      L7_3 = L7_3(L8_3, L9_3)
      L8_3 = {}
      L9_3 = L19_1
      L10_3 = L15_1
      L11_3 = L14_1
      L12_3 = "Image"
      L13_3 = "rbxassetid://3610239960"
      L11_3 = L11_3(L12_3, L13_3)
      L12_3 = {}
      L13_3 = UDim2
      L13_3 = L13_3.new
      L14_3 = 0
      L15_3 = 18
      L16_3 = 0
      L17_3 = 18
      L13_3 = L13_3(L14_3, L15_3, L16_3, L17_3)
      L12_3.Size = L13_3
      L13_3 = UDim2
      L13_3 = L13_3.new
      L14_3 = 0
      L15_3 = 15
      L16_3 = 0
      L17_3 = 15
      L13_3 = L13_3(L14_3, L15_3, L16_3, L17_3)
      L12_3.Position = L13_3
      L12_3.ImageTransparency = 0.4
      L10_3 = L10_3(L11_3, L12_3)
      L11_3 = "Text"
      L9_3 = L9_3(L10_3, L11_3)
      L10_3 = L19_1
      L11_3 = L15_1
      L12_3 = L14_1
      L13_3 = "Label"
      L14_3 = "Unauthorised Access"
      L15_3 = 14
      L12_3 = L12_3(L13_3, L14_3, L15_3)
      L13_3 = {}
      L14_3 = UDim2
      L14_3 = L14_3.new
      L15_3 = 1
      L16_3 = -38
      L17_3 = 0
      L18_3 = 14
      L14_3 = L14_3(L15_3, L16_3, L17_3, L18_3)
      L13_3.Size = L14_3
      L14_3 = UDim2
      L14_3 = L14_3.new
      L15_3 = 0
      L16_3 = 38
      L17_3 = 0
      L18_3 = 18
      L14_3 = L14_3(L15_3, L16_3, L17_3, L18_3)
      L13_3.Position = L14_3
      L13_3.TextTransparency = 0.4
      L11_3 = L11_3(L12_3, L13_3)
      L12_3 = "Text"
      L10_3 = L10_3(L11_3, L12_3)
      L11_3 = L19_1
      L12_3 = L15_1
      L13_3 = L14_1
      L14_3 = "Image"
      L15_3 = "rbxassetid://4483345875"
      L13_3 = L13_3(L14_3, L15_3)
      L14_3 = {}
      L15_3 = UDim2
      L15_3 = L15_3.new
      L16_3 = 0
      L17_3 = 56
      L18_3 = 0
      L19_3 = 56
      L15_3 = L15_3(L16_3, L17_3, L18_3, L19_3)
      L14_3.Size = L15_3
      L15_3 = UDim2
      L15_3 = L15_3.new
      L16_3 = 0
      L17_3 = 84
      L18_3 = 0
      L19_3 = 110
      L15_3 = L15_3(L16_3, L17_3, L18_3, L19_3)
      L14_3.Position = L15_3
      L12_3 = L12_3(L13_3, L14_3)
      L13_3 = "Text"
      L11_3 = L11_3(L12_3, L13_3)
      L12_3 = L19_1
      L13_3 = L15_1
      L14_3 = L14_1
      L15_3 = "Label"
      L16_3 = "Premium Features"
      L17_3 = 14
      L14_3 = L14_3(L15_3, L16_3, L17_3)
      L15_3 = {}
      L16_3 = UDim2
      L16_3 = L16_3.new
      L17_3 = 1
      L18_3 = -150
      L19_3 = 0
      L20_3 = 14
      L16_3 = L16_3(L17_3, L18_3, L19_3, L20_3)
      L15_3.Size = L16_3
      L16_3 = UDim2
      L16_3 = L16_3.new
      L17_3 = 0
      L18_3 = 150
      L19_3 = 0
      L20_3 = 112
      L16_3 = L16_3(L17_3, L18_3, L19_3, L20_3)
      L15_3.Position = L16_3
      L16_3 = Enum
      L16_3 = L16_3.Font
      L16_3 = L16_3.GothamBold
      L15_3.Font = L16_3
      L13_3 = L13_3(L14_3, L15_3)
      L14_3 = "Text"
      L12_3 = L12_3(L13_3, L14_3)
      L13_3 = L19_1
      L14_3 = L15_1
      L15_3 = L14_1
      L16_3 = "Label"
      L17_3 = "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)"
      L18_3 = 12
      L15_3 = L15_3(L16_3, L17_3, L18_3)
      L16_3 = {}
      L17_3 = UDim2
      L17_3 = L17_3.new
      L18_3 = 1
      L19_3 = -200
      L20_3 = 0
      L21_3 = 14
      L17_3 = L17_3(L18_3, L19_3, L20_3, L21_3)
      L16_3.Size = L17_3
      L17_3 = UDim2
      L17_3 = L17_3.new
      L18_3 = 0
      L19_3 = 150
      L20_3 = 0
      L21_3 = 138
      L17_3 = L17_3(L18_3, L19_3, L20_3, L21_3)
      L16_3.Position = L17_3
      L16_3.TextWrapped = true
      L16_3.TextTransparency = 0.4
      L14_3 = L14_3(L15_3, L16_3)
      L15_3 = "Text"
      L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L13_3(L14_3, L15_3)
      L8_3[1] = L9_3
      L8_3[2] = L10_3
      L8_3[3] = L11_3
      L8_3[4] = L12_3
      L8_3[5] = L13_3
      L8_3[6] = L14_3
      L8_3[7] = L15_3
      L8_3[8] = L16_3
      L8_3[9] = L17_3
      L8_3[10] = L18_3
      L8_3[11] = L19_3
      L8_3[12] = L20_3
      L8_3[13] = L21_3
      L6_3(L7_3, L8_3)
    end
  end
  
  L15_2.MakeTab = L16_2
end

L6_1.MakeWindow = L29_1

function L29_1(A0_2)
  local L1_2, L2_2
  L1_2 = L9_1
  L2_2 = L1_2
  L1_2 = L1_2.Destroy
  L1_2(L2_2)
end

L6_1.Destroy = L29_1
