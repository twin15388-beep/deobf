local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
arg = game.Players.LocalPlayer
plr = arg
arg = game.RunService.RenderStepped
rs = arg
arg = plr.Character
L1_1 = arg
L2_1 = "HumanoidRootPart"
L3_1 = 5
arg = arg.WaitForChild(L1_1, L2_1, L3_1)
rootpart = arg

function arg(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, ...)
  local L8_2, L9_2, L10_2, L11_2, L12_2
  L8_2 = "BodyForce"
  L9_2 = 0
  L10_2 = 196.2
  L11_2 = 0
  L10_2 = A0_2
  L9_2 = A0_2.GetMass(L10_2)
  L8_2 = (Vector3.new(L9_2, L10_2, L11_2)) * L9_2
  L8_2 = rs
  arg = A0_2
  L9_2 = L8_2
  L8_2 = L8_2.Connect
  
  function L10_2(...)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L3_3 = A1_2
    L4_3 = A2_2
    L5_3 = A3_2
    L2_3 = CFrame.new(L3_3, L4_3, L5_3)
    L3_3 = A4_2
    L4_3 = A5_2
    L5_3 = A6_2
    L2_3 = CFrame.Angles(L3_3, L4_3, L5_3)
    L1_3 = (rootpart.CFrame * L2_3) * L2_3
    arg = L1_3
  end
  
  L8_2(L9_2, L10_2)
  L9_2 = A0_2
  L8_2 = A0_2.BreakJoints
  L8_2(L9_2)
end

cpos = arg
arg = cpos
L1_1 = plr.Character["Left Arm"]
L2_1 = -1
L3_1 = 1.5
L4_1 = 0
L5_1 = 0
L6_1 = 0
L7_1 = math.rad
L8_1 = -90
L7_1, L8_1, L9_1 = L7_1(L8_1)
arg(L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1)
arg = cpos
L1_1 = plr.Character["Right Arm"]
L2_1 = 1.5
L3_1 = 1
L4_1 = 0
L5_1 = 0
L6_1 = 0
L7_1 = math.rad
L8_1 = 180
L7_1, L8_1, L9_1 = L7_1(L8_1)
arg(L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1)
arg = cpos
L1_1 = plr.Character["Left Leg"]
L2_1 = -1.5
L3_1 = -1
L4_1 = 0
L5_1 = 0
L6_1 = 0
L7_1 = math.rad
L8_1 = 0
L7_1, L8_1, L9_1 = L7_1(L8_1)
arg(L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1)
arg = cpos
L1_1 = plr.Character["Right Leg"]
L2_1 = 1
L3_1 = -1.5
L4_1 = 0
L5_1 = 0
L6_1 = 0
L7_1 = math.rad
L8_1 = 90
L7_1, L8_1, L9_1 = L7_1(L8_1)
arg(L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1)
