local L1_1, L2_1, L3_1, L4_1, L5_1
while true do
  arg = wait()
  if not arg then
    break
  end
  arg = game.Players.LocalPlayer.leaderstats.Stage.Value + 1
  clvl = arg
  arg = game.Workspace.stages
  L1_1 = arg
  arg = arg.FindFirstChild
  L2_1 = tostring
  L3_1 = clvl
  L2_1, L3_1, L4_1, L5_1 = L2_1(L3_1)
  arg = arg(L1_1, L2_1, L3_1, L4_1, L5_1)
  if not arg then
  else
    L1_1 = game.Workspace.stages
    arg = game.Players.LocalPlayer.Character.HumanoidRootPart
    L2_1 = L1_1
    L1_1 = L1_1.FindFirstChild
    L3_1 = tostring
    L4_1 = clvl
    L3_1, L4_1, L5_1 = L3_1(L4_1)
    L1_1 = (L1_1(L2_1, L3_1, L4_1, L5_1)).CFrame
    arg = L1_1
  end
end
