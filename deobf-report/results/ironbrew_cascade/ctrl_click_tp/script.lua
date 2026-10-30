local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
arg = game.Players.LocalPlayer
L2_1 = arg
L2_1 = game
L3_1 = L2_1
L4_1 = "UserInputService"
L1_1 = arg.GetMouse(L2_1)
L4_1 = L1_1.Button1Down
L2_1 = L2_1.GetService(L3_1, L4_1)
L3_1 = false
L5_1 = L4_1
L4_1 = L4_1.connect
function L6_1(...)
  local L1_2, L2_2, L3_2
  arg = L3_1
  if not arg then
  else
    arg = arg.Character
    L1_2 = arg
    arg = arg.MoveTo
    L2_2 = L1_1.Hit.p
    arg(L1_2, L2_2)
  end
end
L4_1(L5_1, L6_1)
L4_1 = L2_1.InputBegan
L5_1 = L4_1
L4_1 = L4_1.connect
function L6_1(A0_2, A1_2, ...)
  local L3_2
  arg = A0_2.UserInputType
  L3_2 = Enum.UserInputType.Keyboard
  if arg == L3_2 then
    arg = A0_2.KeyCode
    L3_2 = Enum.KeyCode.LeftControl
    if arg == L3_2 then
      arg = true
      L3_1 = arg
    else
      arg = A0_2.KeyCode
      L3_2 = Enum.KeyCode.RightControl
      if arg ~= L3_2 then
      else
        arg = true
        L3_1 = arg
      end
    end
  end
end
L4_1(L5_1, L6_1)
L4_1 = L2_1.InputEnded
L5_1 = L4_1
L4_1 = L4_1.connect
function L6_1(A0_2, A1_2, ...)
  local L3_2
  arg = A0_2.UserInputType
  L3_2 = Enum.UserInputType.Keyboard
  if arg ~= L3_2 then
  else
    arg = A0_2.KeyCode
    L3_2 = Enum.KeyCode.LeftControl
    if arg ~= L3_2 then
    else
      arg = false
      L3_1 = arg
      goto lbl_26
    end
    arg = A0_2.KeyCode
    L3_2 = Enum.KeyCode.RightControl
    if arg == L3_2 then
      arg = false
      L3_1 = arg
    end
  end
  :: lbl_26 ::
end
L4_1(L5_1, L6_1)
