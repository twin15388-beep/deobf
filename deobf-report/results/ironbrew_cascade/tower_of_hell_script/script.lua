local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1
L1_1 = "ScreenGui"
L2_1 = "ImageLabel"
L3_1 = "TextButton"
L4_1 = "TextButton"
L5_1 = "TextButton"
L6_1 = "TextButton"
L6_1 = game.CoreGui
L6_1 = Enum.ZIndexBehavior.Sibling
arg = L6_1
L7_1 = 255
L8_1 = 255
L9_1 = 255
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L7_1 = 0.427115172
L8_1 = 0
L9_1 = 0.298597217
L10_1 = 0
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L7_1 = 0
L8_1 = 219
L9_1 = 0
L10_1 = 201
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L1_1 = "http://www.roblox.com/asset/?id=4695436661"
L7_1 = 85
L8_1 = 0
L9_1 = 255
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L7_1 = 0.14611873
L8_1 = 0
L9_1 = 0.761193991
L10_1 = 0
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L7_1 = 0
L8_1 = 154
L9_1 = 0
L10_1 = 40
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L6_1 = Enum.Font.SciFi
L7_1 = 255
L8_1 = 0
L9_1 = 0
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L2_1 = true
L6_1 = L2_1.MouseButton1Down
L3_1 = Instance.new(L4_1)
L4_1 = Instance.new(L5_1)
L5_1 = Instance.new(L6_1)
L7_1 = L6_1
L6_1 = L6_1.connect
function L8_1(...)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  arg = game
  L1_2 = arg
  L2_2 = "UserInputService"
  L1_2 = game.Players.LocalPlayer
  L3_2 = L1_2
  arg = arg.GetService(L1_2, L2_2)
  L2_2 = L1_2.GetMouse(L3_2)
  function L3_2(A0_3, ...)
    local L2_3, L3_3, L4_3, L5_3
    arg = L1_2.Character
    if arg == nil then
    else
      L3_3 = arg
      L2_3 = arg.MoveTo
      L4_3 = A0_3
      L2_3(L3_3, L4_3)
    end
  end
  To = L3_2
  L3_2 = arg.InputBegan
  L4_2 = L3_2
  L3_2 = L3_2.Connect
  function L5_2(A0_3, ...)
    local L2_3, L3_3, L4_3
    arg = A0_3.UserInputType
    L2_3 = Enum.UserInputType.MouseButton1
    if arg ~= L2_3 then
    else
      arg = arg
      L2_3 = arg
      L3_3 = Enum.KeyCode.LeftControl
      arg = arg.IsKeyDown(L2_3, L3_3)
      if not arg then
      else
        arg = To
        L2_3 = L2_2.Hit.p
        arg(L2_3)
      end
    end
  end
  L3_2(L4_2, L5_2)
end
L6_1(L7_1, L8_1)
L7_1 = 255
L8_1 = 0
L9_1 = 0
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L7_1 = 0.849315047
L8_1 = 0
L9_1 = 0
L10_1 = 0
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L7_1 = 0
L8_1 = 33
L9_1 = 0
L10_1 = 27
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L6_1 = Enum.Font.SourceSans
L7_1 = 0
L8_1 = 0
L9_1 = 0
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L3_1 = true
L6_1 = L3_1.MouseButton1Down
L7_1 = L6_1
L6_1 = L6_1.connect
function L8_1(...)
  local L1_2
  arg = false
end
L6_1(L7_1, L8_1)
L7_1 = 85
L8_1 = 0
L9_1 = 255
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L7_1 = 0.146118715
L8_1 = 0
L9_1 = 0.527363181
L10_1 = 0
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L7_1 = 0
L8_1 = 154
L9_1 = 0
L10_1 = 40
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L6_1 = Enum.Font.SciFi
L7_1 = 255
L8_1 = 0
L9_1 = 0
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L4_1 = true
L6_1 = L4_1.MouseButton1Down
L7_1 = L6_1
L6_1 = L6_1.connect
function L8_1(...)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  arg = game
  L1_2 = arg
  L2_2 = "Players"
  L1_2 = game
  L2_2 = L1_2
  L3_2 = "UserInputService"
  arg = (arg.GetService(L1_2, L2_2)).LocalPlayer
  L1_2 = L1_2.GetService(L2_2, L3_2)
  L2_2 = 50
  function L2_2(A0_3, A1_3, ...)
    local L3_3, L4_3
    if A0_3 ~= nil then
      arg = A1_3
      L3_3 = A0_3
      arg(L3_3)
    end
  end
  Action = L2_2
  L2_2 = L1_2.InputBegan
  L3_2 = L2_2
  L2_2 = L2_2.connect
  function L4_2(A0_3, ...)
    local L2_3, L3_3, L4_3
    arg = A0_3.UserInputType
    L2_3 = Enum.UserInputType.Keyboard
    if arg ~= L2_3 then
    else
      arg = A0_3.KeyCode
      L2_3 = Enum.KeyCode.Space
      if arg == L2_3 then
        arg = Action
        L2_3 = arg.Character.Humanoid
        function L3_3(A0_4, ...)
          local L2_4, L3_4, L4_4
          L2_4 = A0_4
          arg = A0_4.GetState(L2_4)
          L2_4 = Enum.HumanoidStateType.Jumping
          if arg ~= L2_4 then
            L2_4 = A0_4
            arg = A0_4.GetState(L2_4)
            L2_4 = Enum.HumanoidStateType.Freefall
            if arg ~= L2_4 then
              goto lbl_20
            end
          end
          arg = Action
          L2_4 = A0_4.Parent.HumanoidRootPart
          function L3_4(A0_5, ...)
            local L2_5, L3_5, L4_5, L5_5
            L2_5 = 0
            L3_5 = _G.JumpHeight
            L4_5 = 0
            arg = Vector3.new(L2_5, L3_5, L4_5)
            A0_5.Velocity = arg
          end
          arg(L2_4, L3_4) :: lbl_20 ::
        end
        arg(L2_3, L3_3)
      end
    end
  end
  L2_2(L3_2, L4_2)
end
L6_1(L7_1, L8_1)
L7_1 = 255
L8_1 = 0
L9_1 = 0
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L7_1 = 0.436289489
L8_1 = 0
L9_1 = 0.905811608
L10_1 = 0
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L7_1 = 0
L8_1 = 200
L9_1 = 0
L10_1 = 40
L6_1 = UDim2.new(L7_1, L8_1, L9_1, L10_1)
L6_1 = Enum.Font.SciFi
L7_1 = 85
L8_1 = 0
L9_1 = 255
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L7_1 = 85
L8_1 = 0
L9_1 = 255
L6_1 = Color3.fromRGB(L7_1, L8_1, L9_1)
L5_1 = true
L6_1 = L5_1.MouseButton1Down
L7_1 = L6_1
L6_1 = L6_1.connect
function L8_1(...)
  local L1_2
  arg = false
end
L6_1(L7_1, L8_1)
function L6_1(...)
  local L1_2, L2_2, L3_2
  L1_2 = "LocalScript"
  L2_2 = L1_1
  arg = Instance.new(L1_2, L2_2)
  L1_2 = true
end
L8_1 = L6_1
L7_1 = coroutine.wrap(L8_1)
L7_1()
function L7_1(...)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  arg = Instance.new
  L1_2 = "LocalScript"
  L2_2 = arg
  L1_2 = game
  L2_2 = L1_2
  L3_2 = "StarterGui"
  L1_2 = L1_2.GetService(L2_2, L3_2)
  arg = arg(L1_2, L2_2)
  L2_2 = L1_2
  L1_2 = L1_2.SetCore
  L3_2 = "SendNotification"
  L4_2 = 10
  L1_2(L2_2, L3_2, L4_2)
end
L9_1 = L7_1
L8_1 = coroutine.wrap(L9_1)
L8_1()
