local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
arg = game
L1_1 = arg
L2_1 = "Players"
arg = (arg.GetService(L1_1, L2_1)).LocalPlayer
Local = arg
arg = Local.Character
Char = arg
L1_1 = false
tpdback = L1_1
arg = false
touched = arg
arg = Local.CharacterAdded
L1_1 = arg
arg = arg.connect

function L2_1(A0_2, ...)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  arg = script.Disabled
  if arg == true then
  else
    arg = wait
    L2_2 = 0.25
    arg(L2_2)
    arg = Char.HumanoidRootPart.Position
    loc = arg
    arg = Char
    L5_2 = 0
    L6_2 = 0.5
    L7_2 = 0
    L4_2 = Vector3.new(L5_2, L6_2, L7_2)
    L2_2 = arg
    arg = arg.MoveTo
    L3_2 = box.Position + L4_2
    arg(L2_2, L3_2)
  end
end

arg(L1_1, L2_1)
arg = game
L1_1 = arg
L2_1 = "UserInputService"
arg = (arg.GetService(L1_1, L2_1)).InputBegan
L1_1 = arg
arg = arg.connect

function L2_1(A0_2, ...)
  local L2_2, L3_2
  arg = A0_2.KeyCode
  L2_2 = Enum.KeyCode.Equals
  if arg == L2_2 then
    arg = script.Disabled
    if arg ~= true then
      arg = print
      L2_2 = "you may re-execute"
      arg(L2_2)
    end
  end
end

arg(L1_1, L2_1)
L1_1 = "Part"
L2_1 = workspace
arg = Instance.new(L1_1, L2_1)
box = arg
L2_1 = 10
L3_1 = 1
L4_1 = 10
L1_1 = Vector3.new(L2_1, L3_1, L4_1)
L2_1 = 0
L3_1 = 10000
L4_1 = 0
L1_1 = Vector3.new(L2_1, L3_1, L4_1)
arg = box.Touched
L1_1 = arg
arg = arg.connect

function L2_1(A0_2, ...)
  local L2_2
  arg = A0_2.Parent.Name
  L2_2 = Local.Name
  if arg == L2_2 then
    arg = touched
    if arg ~= false then
    else
      arg = true
      touched = arg
      
      function arg(...)
        local L1_3, L2_3, L3_3
        arg = script.Disabled
        if arg ~= true then
          arg = Char.HumanoidRootPart
          L1_3 = arg
          arg = arg.Clone(L1_3)
          no = arg
          arg = wait
          L1_3 = 0.25
          arg(L1_3)
          arg = Char.HumanoidRootPart
          L1_3 = arg
          arg = arg.Destroy
          arg(L1_3)
          L1_3 = Char
          arg = Char
          L1_3 = arg
          arg = arg.MoveTo
          L2_3 = loc
          arg(L1_3, L2_3)
          arg = false
          touched = arg
        end
      end
      
      apply = arg
      arg = Char
      if not arg then
      else
        arg = apply
        arg()
      end
    end
  end
end

arg(L1_1, L2_1)
repeat
  arg = wait
  arg()
  arg = Char
until arg
arg = Char.HumanoidRootPart.Position
loc = arg
arg = Char
L4_1 = 0
L5_1 = 0.5
L6_1 = 0
L3_1 = Vector3.new(L4_1, L5_1, L6_1)
L1_1 = arg
arg = arg.MoveTo
L2_1 = box.Position + L3_1
arg(L1_1, L2_1)
