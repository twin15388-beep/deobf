local L1_1, L2_1, L3_1, L4_1
arg = game
L1_1 = arg
L2_1 = "VirtualUser"
L1_1 = game
L2_1 = L1_1
L3_1 = "Players"
L1_1 = ((L1_1.GetService(L2_1, L3_1)).LocalPlayer).Idled
arg = arg.GetService(L1_1, L2_1)
L2_1 = L1_1
L1_1 = L1_1.connect
function L3_1(...)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  arg = arg
  L3_2 = 0
  L4_2 = 0
  L1_2 = arg
  arg = arg.Button2Down
  L2_2 = Vector2.new(L3_2, L4_2)
  L3_2 = workspace.CurrentCamera.CFrame
  arg(L1_2, L2_2, L3_2)
  arg = wait
  L1_2 = 1
  arg(L1_2)
  arg = arg
  L3_2 = 0
  L4_2 = 0
  L1_2 = arg
  arg = arg.Button2Up
  L2_2 = Vector2.new(L3_2, L4_2)
  L3_2 = workspace.CurrentCamera.CFrame
  arg(L1_2, L2_2, L3_2)
end
L1_1(L2_1, L3_1)
