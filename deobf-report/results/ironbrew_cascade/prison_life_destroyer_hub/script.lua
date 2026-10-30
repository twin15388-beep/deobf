local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1
L1_1 = "ScreenGui"
L1_1 = game.StarterGui
arg = L1_1
L2_1 = "ScrollingFrame"
L3_1 = arg
L3_1 = 0.15
L4_1 = 0.15
L5_1 = 0.15
L2_1 = Color3.new(L3_1, L4_1, L5_1)
L3_1 = 0.08
L4_1 = 0
L5_1 = 0.42
L6_1 = 0
L2_1 = UDim2.new(L3_1, L4_1, L5_1, L6_1)
L3_1 = 0
L4_1 = 296
L5_1 = 0
L6_1 = 388
L2_1 = UDim2.new(L3_1, L4_1, L5_1, L6_1)
L3_1 = "ScreenGui"
L3_1 = game.CoreGui
L2_1 = L3_1
L4_1 = "ScrollingFrame"
L5_1 = L2_1
L5_1 = 0.15
L6_1 = 0.15
L7_1 = 0.15
L4_1 = Color3.new(L5_1, L6_1, L7_1)
L5_1 = 0.08
L6_1 = 0
L7_1 = 0.42
L8_1 = 0
L4_1 = UDim2.new(L5_1, L6_1, L7_1, L8_1)
L5_1 = 0
L6_1 = 296
L7_1 = 0
L8_1 = 388
L4_1 = UDim2.new(L5_1, L6_1, L7_1, L8_1)
L3_1 = L4_1
L5_1 = "UIGridLayout"
L6_1 = L3_1
L6_1 = 0
L7_1 = 90
L8_1 = 0
L9_1 = 90
L5_1 = UDim2.new(L6_1, L7_1, L8_1, L9_1)
L1_1 = L2_1
L4_1 = L5_1
while true do
  L6_1 = 1
  L5_1 = wait(L6_1)
  if not L5_1 then
    break
  end
  L5_1 = workspace
  L6_1 = L5_1
  L8_1 = L3_1
  L7_1 = L3_1.getChildren(L8_1)
  L5_1 = L5_1.getDescendants(L6_1)
  L6_1 = {}
  L8_1 = 1
  L9_1 = #L7_1
  L10_1 = 1
  for L11_1 = L8_1, L9_1, L10_1 do
    L12_1 = L7_1[L11_1].ClassName
    if L12_1 ~= "TextButton" then
    else
      L12_1 = L7_1[L11_1]
      L13_1 = L12_1
      L12_1 = L12_1.remove
      L12_1(L13_1)
    end
  end
  L8_1 = 1
  L9_1 = #L5_1
  L10_1 = 1
  for L11_1 = L8_1, L9_1, L10_1 do
    L12_1 = L5_1[L11_1].Name
    if L12_1 == "ItemPickupScript" then
      L12_1 = L5_1[L11_1].Parent
      L13_1 = L12_1
      L14_1 = "ClickDetector"
      L12_1 = L12_1.findFirstChild(L13_1, L14_1)
      if L12_1 then
        L12_1 = table.insert
        L13_1 = L6_1
        L14_1 = L5_1[L11_1].Parent
        L12_1(L13_1, L14_1)
      end
    end
  end
  L8_1 = 1
  L9_1 = #L6_1
  L10_1 = 1
  for L11_1 = L8_1, L9_1, L10_1 do
    L13_1 = "TextButton"
    L14_1 = L3_1
    L14_1 = 1
    L15_1 = 1
    L16_1 = 1
    L13_1 = Color3.new(L14_1, L15_1, L16_1)
    L14_1 = 0
    L15_1 = 100
    L16_1 = 0
    L17_1 = 100
    L13_1 = UDim2.new(L14_1, L15_1, L16_1, L17_1)
    L12_1 = ""
    L14_1 = "ViewportFrame"
    L15_1 = L12_1
    L15_1 = 1
    L16_1 = 0
    L17_1 = 1
    L18_1 = 0
    L14_1 = UDim2.new(L15_1, L16_1, L17_1, L18_1)
    L14_1 = L6_1[L11_1]
    L16_1 = L14_1
    L13_1 = 0
    L15_1 = L13_1
    L17_1 = "Camera"
    L18_1 = L15_1
    L17_1 = Enum.CameraType.Fixed
    L19_1 = 0
    L20_1 = 3
    L21_1 = 0
    L17_1 = L14_1.Position
    L18_1 = L17_1 + (Vector3.new(L19_1, L20_1, L21_1))
    L20_1 = L18_1
    L21_1 = L17_1
    L19_1 = CFrame.new(L20_1, L21_1)
    L16_1 = L19_1
    L19_1 = L12_1.MouseButton1Down
    L13_1 = L16_1
    L20_1 = L19_1
    L19_1 = L19_1.connect
    function L21_1(...)
      local L1_2, L2_2, L3_2
      L1_2 = L11_1
      arg = L6_1[L1_2]
      L1_2 = arg
      L2_2 = "ClickDetector"
      arg = arg.findFirstChild(L1_2, L2_2)
      if not arg then
      else
        arg = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        L1_2 = wait
        L2_2 = 0.05
        L1_2(L2_2)
        L3_2 = L11_1
        L2_2 = L6_1[L3_2].CFrame
        L1_2 = wait
        L2_2 = 0.1
        L1_2(L2_2)
        L3_2 = L11_1
        L1_2 = fireclickdetector
        L2_2 = L6_1[L3_2].ClickDetector
        L1_2(L2_2)
        L1_2 = wait
        L2_2 = 0.3
        L1_2(L2_2)
        L1_2 = arg
      end
    end
    L19_1(L20_1, L21_1)
  end
end
