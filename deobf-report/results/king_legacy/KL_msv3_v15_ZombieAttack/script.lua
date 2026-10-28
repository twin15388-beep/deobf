local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1
L0_1 = false

function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = string
  L1_2 = L1_2.split
  L2_2 = A0_2
  L3_2 = " "
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2[2]
  if L2_2 == " " then
    L2_2 = "sssssssssssssssssssssssssss"
  end
  if L2_2 == "" then
    L2_2 = "sssssssssssssssssssssssssss"
  end
  if L2_2 == "  " then
    L2_2 = "sssssssssssssssssssssssssss"
  end
  L3_2 = pairs
  L4_2 = game
  L4_2 = L4_2.Players
  L5_2 = L4_2
  L4_2 = L4_2.GetPlayers
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L4_2(L5_2)
  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  for L6_2, L7_2 in L3_2, L4_2, L5_2 do
    L8_2 = string
    L8_2 = L8_2.lower
    L9_2 = L2_2
    L8_2 = L8_2(L9_2)
    L9_2 = string
    L9_2 = L9_2.lower
    L10_2 = L7_2.Name
    L9_2 = L9_2(L10_2)
    L10_2 = string
    L10_2 = L10_2.match
    L11_2 = L9_2
    L12_2 = L8_2
    L10_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L10_2 = L7_2.Name
      user = L10_2
      L10_2 = user
      return L10_2
    end
  end
end

matchuser = L1_1
L1_1 = pairs
L2_1 = game
L2_1 = L2_1.Players
L3_1 = L2_1
L2_1 = L2_1.GetPlayers
L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1 = L2_1(L3_1)
L1_1, L2_1, L3_1 = L1_1(L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1)
for L4_1, L5_1 in L1_1, L2_1, L3_1 do
  L7_1 = L5_1
  L6_1 = L5_1.IsInGroup
  L8_1 = 16527976
  L6_1 = L6_1(L7_1, L8_1)
  if L6_1 then
    function L6_1()
      local L0_2, L1_2
      
      L0_2 = game
      L0_2 = L0_2.Players
      L0_2 = L0_2.LocalPlayer
      L0_2 = L0_2.Character
      L0_2 = L0_2.LowerTorso
      L0_2.Anchored = true
      L0_2 = game
      L0_2 = L0_2.Players
      L0_2 = L0_2.LocalPlayer
      L0_2 = L0_2.Character
      L0_2 = L0_2.UppperTorso
      L0_2.Anchored = true
    end
    
    function L7_1()
      local L0_2, L1_2
      L0_2 = game
      L0_2 = L0_2.Players
      L0_2 = L0_2.LocalPlayer
      L0_2 = L0_2.Character
      L0_2 = L0_2.LowerTorso
      L0_2.Anchored = false
      L0_2 = game
      L0_2 = L0_2.Players
      L0_2 = L0_2.LocalPlayer
      L0_2 = L0_2.Character
      L0_2 = L0_2.UppperTorso
      L1_2 = flase
      L0_2.Anchored = L1_2
    end
    
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":kick"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L1_2 = L1_2.Name
        L2_2 = matchuser
        L3_2 = A0_2
        L2_2 = L2_2(L3_2)
        if L1_2 == L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L2_2 = L1_2
          L1_2 = L1_2.Kick
          L3_2 = "Kicked by Premium User "
          L4_2 = L5_1
          L4_2 = L4_2.Name
          L3_2 = L3_2 .. L4_2
          L1_2(L2_2, L3_2)
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2, L5_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":fling ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.HumanoidRootPart
          L2_2 = CFrame
          L2_2 = L2_2.new
          L3_2 = 0
          L4_2 = 999
          L5_2 = 0
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          L1_2.CFrame = L2_2
          L1_2 = 99999999
          power = L1_2
          L1_2 = game
          L2_2 = L1_2
          L1_2 = L1_2.GetService
          L3_2 = "RunService"
          L1_2 = L1_2(L2_2, L3_2)
          L1_2 = L1_2.Stepped
          L2_2 = L1_2
          L1_2 = L1_2.connect
          
          function L3_2()
            local L0_3, L1_3
            L0_3 = game
            L0_3 = L0_3.Players
            L0_3 = L0_3.LocalPlayer
            L0_3 = L0_3.Character
            L0_3 = L0_3.Head
            L0_3.CanCollide = false
            L0_3 = game
            L0_3 = L0_3.Players
            L0_3 = L0_3.LocalPlayer
            L0_3 = L0_3.Character
            L0_3 = L0_3.UpperTorso
            L0_3.CanCollide = false
            L0_3 = game
            L0_3 = L0_3.Players
            L0_3 = L0_3.LocalPlayer
            L0_3 = L0_3.Character
            L0_3 = L0_3.LowerTorso
            L0_3.CanCollide = false
            L0_3 = game
            L0_3 = L0_3.Players
            L0_3 = L0_3.LocalPlayer
            L0_3 = L0_3.Character
            L0_3 = L0_3.HumanoidRootPart
            L0_3.CanCollide = false
          end
          
          L1_2(L2_2, L3_2)
          L1_2 = wait
          L2_2 = 0.1
          L1_2(L2_2)
          L1_2 = Instance
          L1_2 = L1_2.new
          L2_2 = "BodyThrust"
          L1_2 = L1_2(L2_2)
          L2_2 = game
          L2_2 = L2_2.Players
          L2_2 = L2_2.LocalPlayer
          L2_2 = L2_2.Character
          L2_2 = L2_2.HumanoidRootPart
          L1_2.Parent = L2_2
          L2_2 = Vector3
          L2_2 = L2_2.new
          L3_2 = power
          L4_2 = 0
          L5_2 = power
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          L1_2.Force = L2_2
          L2_2 = game
          L2_2 = L2_2.Players
          L2_2 = L2_2.LocalPlayer
          L2_2 = L2_2.Character
          L2_2 = L2_2.HumanoidRootPart
          L2_2 = L2_2.Position
          L1_2.Location = L2_2
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":benx ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = wait
          L2_2 = 0
          L1_2(L2_2)
          L1_2 = "Yeah Yeah!"
          L2_2 = "All"
          L3_2 = game
          L4_2 = L3_2
          L3_2 = L3_2.GetService
          L5_2 = "ReplicatedStorage"
          L3_2 = L3_2(L4_2, L5_2)
          L3_2 = L3_2.DefaultChatSystemChatEvents
          L3_2 = L3_2.SayMessageRequest
          L5_2 = L3_2
          L4_2 = L3_2.FireServer
          L6_2 = L1_2
          L7_2 = L2_2
          L4_2(L5_2, L6_2, L7_2)
          L4_2 = true
          L0_1 = L4_2
          while true do
            L4_2 = L0_1
            if not L4_2 then
              break
            end
            L4_2 = game
            L5_2 = L4_2
            L4_2 = L4_2.GetService
            L6_2 = "Players"
            L4_2 = L4_2(L5_2, L6_2)
            L4_2 = L4_2.LocalPlayer
            L4_2 = L4_2.Character
            L4_2 = L4_2.Humanoid
            hummy = L4_2
            L4_2 = pcall
            
            function L5_2()
              local L0_3, L1_3
              L0_3 = hummy
              L0_3 = L0_3.Parent
              L0_3 = L0_3.Pants
              L1_3 = L0_3
              L0_3 = L0_3.Destroy
              L0_3(L1_3)
            end
            
            L4_2(L5_2)
            L4_2 = pcall
            
            function L5_2()
              local L0_3, L1_3
              L0_3 = hummy
              L0_3 = L0_3.Parent
              L0_3 = L0_3.Shirt
              L1_3 = L0_3
              L0_3 = L0_3.Destroy
              L0_3(L1_3)
            end
            
            L4_2(L5_2)
            L4_2 = game
            L4_2 = L4_2.Players
            L4_2 = L4_2.LocalPlayer
            L4_2 = L4_2.Character
            L4_2 = L4_2.HumanoidRootPart
            L5_2 = L5_1
            L5_2 = L5_2.Character
            L5_2 = L5_2.HumanoidRootPart
            L5_2 = L5_2.CFrame
            L6_2 = L5_1
            L6_2 = L6_2.Character
            L6_2 = L6_2.HumanoidRootPart
            L6_2 = L6_2.CFrame
            L6_2 = L6_2.lookVector
            L6_2 = L6_2 * 0.5
            L5_2 = L5_2 + L6_2
            L4_2.CFrame = L5_2
            L4_2 = game
            L4_2 = L4_2.Players
            L4_2 = L4_2.LocalPlayer
            L4_2 = L4_2.Character
            L4_2 = L4_2.HumanoidRootPart
            L5_2 = game
            L5_2 = L5_2.Players
            L5_2 = L5_2.LocalPlayer
            L5_2 = L5_2.Character
            L5_2 = L5_2.HumanoidRootPart
            L5_2 = L5_2.CFrame
            L5_2 = L5_2.lookVector
            L5_2 = L5_2 * 70
            L4_2.Velocity = L5_2
            L4_2 = wait
            L5_2 = 0.1
            L4_2(L5_2)
            L4_2 = game
            L4_2 = L4_2.Players
            L4_2 = L4_2.LocalPlayer
            L4_2 = L4_2.Character
            L4_2 = L4_2.HumanoidRootPart
            L5_2 = game
            L5_2 = L5_2.Players
            L5_2 = L5_2.LocalPlayer
            L5_2 = L5_2.Character
            L5_2 = L5_2.HumanoidRootPart
            L5_2 = L5_2.CFrame
            L5_2 = L5_2.lookVector
            L5_2 = L5_2 * -200
            L4_2.Velocity = L5_2
          end
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = "korblox"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L2_2 = L1_2.Character
          L3_2 = L2_2.RightLowerLeg
          L3_2.MeshId = "902942093"
          L3_2 = L2_2.RightLowerLeg
          L3_2.Transparency = "1"
          L3_2 = L2_2.RightUpperLeg
          L3_2.MeshId = "http://www.roblox.com/asset/?id=902942096"
          L3_2 = L2_2.RightUpperLeg
          L3_2.TextureID = "http://roblox.com/asset/?id=902843398"
          L3_2 = L2_2.RightFoot
          L3_2.MeshId = "902942089"
          L3_2 = L2_2.RightFoot
          L3_2.Transparency = "1"
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":freeze ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = L6_1
          L1_2()
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":unfreeze ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = L7_1
          L1_2()
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":unbenx ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = false
          L0_1 = L1_2
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":thaw ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = L7_1
          L1_2()
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":ban ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L2_2 = L1_2
          L1_2 = L1_2.kick
          L3_2 = "PERMA BAN"
          L1_2(L2_2, L3_2)
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":kill ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.Humanoid
          L2_2 = L1_2
          L1_2 = L1_2.Destroy
          L1_2(L2_2)
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":premcmds"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = "korblox"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":bring"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L1_2 = L1_2.Name
        L2_2 = matchuser
        L3_2 = A0_2
        L2_2 = L2_2(L3_2)
        if L1_2 == L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.HumanoidRootPart
          L2_2 = CFrame
          L2_2 = L2_2.new
          L3_2 = L5_1
          L3_2 = L3_2.Character
          L3_2 = L3_2.HumanoidRootPart
          L3_2 = L3_2.Position
          L2_2 = L2_2(L3_2)
          L1_2.CFrame = L2_2
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2, L5_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":grave ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.HumanoidRootPart
          L2_2 = CFrame
          L2_2 = L2_2.new
          L3_2 = game
          L3_2 = L3_2.Players
          L3_2 = L3_2.LocalPlayer
          L3_2 = L3_2.Character
          L3_2 = L3_2.UpperTorso
          L3_2 = L3_2.Position
          L3_2 = L3_2.X
          L4_2 = game
          L4_2 = L4_2.Players
          L4_2 = L4_2.LocalPlayer
          L4_2 = L4_2.Character
          L4_2 = L4_2.UpperTorso
          L4_2 = L4_2.Position
          L4_2 = L4_2.Y
          L4_2 = L4_2 - 10
          L5_2 = game
          L5_2 = L5_2.Players
          L5_2 = L5_2.LocalPlayer
          L5_2 = L5_2.Character
          L5_2 = L5_2.UpperTorso
          L5_2 = L5_2.Position
          L5_2 = L5_2.z
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          L1_2.CFrame = L2_2
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.LowerTorso
          L1_2.Anchored = true
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2, L5_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":ungrave ."
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 ~= L2_2 then
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.LowerTorso
          L1_2.Anchored = false
          L1_2 = wait
          L2_2 = 0.1
          L1_2(L2_2)
          L1_2 = game
          L1_2 = L1_2.Players
          L1_2 = L1_2.LocalPlayer
          L1_2 = L1_2.Character
          L1_2 = L1_2.HumanoidRootPart
          L2_2 = CFrame
          L2_2 = L2_2.new
          L3_2 = game
          L3_2 = L3_2.Players
          L3_2 = L3_2.LocalPlayer
          L3_2 = L3_2.Character
          L3_2 = L3_2.UpperTorso
          L3_2 = L3_2.Position
          L3_2 = L3_2.X
          L4_2 = game
          L4_2 = L4_2.Players
          L4_2 = L4_2.LocalPlayer
          L4_2 = L4_2.Character
          L4_2 = L4_2.UpperTorso
          L4_2 = L4_2.Position
          L4_2 = L4_2.Y
          L4_2 = L4_2 + 10
          L5_2 = game
          L5_2 = L5_2.Players
          L5_2 = L5_2.LocalPlayer
          L5_2 = L5_2.Character
          L5_2 = L5_2.UpperTorso
          L5_2 = L5_2.Position
          L5_2 = L5_2.z
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          L1_2.CFrame = L2_2
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":unfreeze me"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 == L2_2 then
          L1_2 = L7_1
          L1_2()
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":thaw me"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 == L2_2 then
          L1_2 = L7_1
          L1_2()
        end
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = ":freeusers"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L2_2 = L1_2
        L1_2 = L1_2.GetService
        L3_2 = "ReplicatedStorage"
        L1_2 = L1_2(L2_2, L3_2)
        L1_2 = L1_2.DefaultChatSystemChatEvents
        L1_2 = L1_2.SayMessageRequest
        L2_2 = L1_2
        L1_2 = L1_2.FireServer
        L3_2 = "LTX"
        L4_2 = "All"
        L1_2(L2_2, L3_2, L4_2)
      end
    end
    
    L8_1(L9_1, L10_1)
    L8_1 = L5_1.Chatted
    L9_1 = L8_1
    L8_1 = L8_1.connect
    
    function L10_1(A0_2)
      local L1_2, L2_2, L3_2, L4_2, L5_2
      L2_2 = A0_2
      L1_2 = A0_2.match
      L3_2 = "cmds"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = game
        L1_2 = L1_2.Players
        L1_2 = L1_2.LocalPlayer
        L2_2 = L5_1
        if L1_2 == L2_2 then
          L1_2 = game
          L2_2 = L1_2
          L1_2 = L1_2.GetService
          L3_2 = "StarterGui"
          L1_2 = L1_2(L2_2, L3_2)
          L2_2 = L1_2
          L1_2 = L1_2.SetCore
          L3_2 = "SendNotification"
          L4_2 = {}
          L4_2.Title = "Cmds:"
          L4_2.Text = "check cord"
          L4_2.Time = 50
          L4_2.Icon = "rbxassetid://505845268"
          L1_2(L2_2, L3_2, L4_2)
        end
      end
    end
    
    L8_1(L9_1, L10_1)
  end
end
L1_1 = loadstring
L2_1 = game
L3_1 = L2_1
L2_1 = L2_1.HttpGet
L4_1 = "https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua"
L5_1 = true
L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1 = L2_1(L3_1, L4_1, L5_1)
L1_1 = L1_1(L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1)
L1_1 = L1_1()
L2_1 = Instance
L2_1 = L2_1.new
L3_1 = "ScreenGui"
L2_1 = L2_1(L3_1)

function L3_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2
  if A0_2 == "bHSHsmd019sksasd" then
    bnHsdMDsnKsnaMDSsjddsposksadbyr = A1_2
    L2_2 = "no"
    bnHsdMDsnKsnaMDSsjddsposks = L2_2
    L2_2 = loadstring
    L3_2 = game
    L4_2 = L3_2
    L3_2 = L3_2.HttpGet
    L5_2 = "https://raw.githubusercontent.com/treeofplant/461d-4682-97/main/asa58700f.lua"
    L6_2 = true
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2 = L3_2(L4_2, L5_2, L6_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2)
    L2_2()
    L2_2 = bnHsdMDsnKsnaMDSsjddsposks
    if L2_2 == "trueogt15STjAlPT1IG6gw" then
      L2_2 = L1_1
      L2_2 = L2_2.new
      L3_2 = "success"
      L4_2 = "Success"
      L5_2 = "Correct key."
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      yes1 = L2_2
      L2_2 = L2_1
      L3_2 = L2_2
      L2_2 = L2_2.Destroy
      L2_2(L3_2)
      L2_2 = delfile
      L3_2 = "lightuxkey.txt"
      L2_2(L3_2)
      L2_2 = writefile
      L3_2 = "lightuxkey.txt"
      L4_2 = A1_2
      L2_2(L3_2, L4_2)
      L2_2 = yes1
      L3_2 = L2_2
      L2_2 = L2_2.deleteTimeout
      L4_2 = 2
      L2_2(L3_2, L4_2)
      L2_2 = Instance
      L2_2 = L2_2.new
      L3_2 = "ScreenGui"
      L2_2 = L2_2(L3_2)
      L3_2 = Instance
      L3_2 = L3_2.new
      L4_2 = "Frame"
      L3_2 = L3_2(L4_2)
      L4_2 = Instance
      L4_2 = L4_2.new
      L5_2 = "UICorner"
      L4_2 = L4_2(L5_2)
      L5_2 = Instance
      L5_2 = L5_2.new
      L6_2 = "Frame"
      L5_2 = L5_2(L6_2)
      L6_2 = Instance
      L6_2 = L6_2.new
      L7_2 = "ImageLabel"
      L6_2 = L6_2(L7_2)
      L7_2 = Instance
      L7_2 = L7_2.new
      L8_2 = "Frame"
      L7_2 = L7_2(L8_2)
      L8_2 = Instance
      L8_2 = L8_2.new
      L9_2 = "UICorner"
      L8_2 = L8_2(L9_2)
      L9_2 = Instance
      L9_2 = L9_2.new
      L10_2 = "Frame"
      L9_2 = L9_2(L10_2)
      L10_2 = Instance
      L10_2 = L10_2.new
      L11_2 = "Frame"
      L10_2 = L10_2(L11_2)
      L11_2 = Instance
      L11_2 = L11_2.new
      L12_2 = "Frame"
      L11_2 = L11_2(L12_2)
      L12_2 = Instance
      L12_2 = L12_2.new
      L13_2 = "UICorner"
      L12_2 = L12_2(L13_2)
      L13_2 = Instance
      L13_2 = L13_2.new
      L14_2 = "UIListLayout"
      L13_2 = L13_2(L14_2)
      L14_2 = Instance
      L14_2 = L14_2.new
      L15_2 = "TextButton"
      L14_2 = L14_2(L15_2)
      L15_2 = Instance
      L15_2 = L15_2.new
      L16_2 = "UIPadding"
      L15_2 = L15_2(L16_2)
      L16_2 = Instance
      L16_2 = L16_2.new
      L17_2 = "TextLabel"
      L16_2 = L16_2(L17_2)
      L17_2 = Instance
      L17_2 = L17_2.new
      L18_2 = "ImageLabel"
      L17_2 = L17_2(L18_2)
      L18_2 = Instance
      L18_2 = L18_2.new
      L19_2 = "TextButton"
      L18_2 = L18_2(L19_2)
      L19_2 = Instance
      L19_2 = L19_2.new
      L20_2 = "UIPadding"
      L19_2 = L19_2(L20_2)
      L20_2 = Instance
      L20_2 = L20_2.new
      L21_2 = "TextLabel"
      L20_2 = L20_2(L21_2)
      L21_2 = Instance
      L21_2 = L21_2.new
      L22_2 = "ImageLabel"
      L21_2 = L21_2(L22_2)
      L22_2 = Instance
      L22_2 = L22_2.new
      L23_2 = "TextButton"
      L22_2 = L22_2(L23_2)
      L23_2 = Instance
      L23_2 = L23_2.new
      L24_2 = "UIPadding"
      L23_2 = L23_2(L24_2)
      L24_2 = Instance
      L24_2 = L24_2.new
      L25_2 = "TextLabel"
      L24_2 = L24_2(L25_2)
      L25_2 = Instance
      L25_2 = L25_2.new
      L26_2 = "ImageLabel"
      L25_2 = L25_2(L26_2)
      L26_2 = Instance
      L26_2 = L26_2.new
      L27_2 = "UIPadding"
      L26_2 = L26_2(L27_2)
      L27_2 = Instance
      L27_2 = L27_2.new
      L28_2 = "TextButton"
      L27_2 = L27_2(L28_2)
      L28_2 = Instance
      L28_2 = L28_2.new
      L29_2 = "UIPadding"
      L28_2 = L28_2(L29_2)
      L29_2 = Instance
      L29_2 = L29_2.new
      L30_2 = "TextLabel"
      L29_2 = L29_2(L30_2)
      L30_2 = Instance
      L30_2 = L30_2.new
      L31_2 = "ImageLabel"
      L30_2 = L30_2(L31_2)
      L31_2 = Instance
      L31_2 = L31_2.new
      L32_2 = "Frame"
      L31_2 = L31_2(L32_2)
      L32_2 = Instance
      L32_2 = L32_2.new
      L33_2 = "UICorner"
      L32_2 = L32_2(L33_2)
      L33_2 = Instance
      L33_2 = L33_2.new
      L34_2 = "Frame"
      L33_2 = L33_2(L34_2)
      L34_2 = Instance
      L34_2 = L34_2.new
      L35_2 = "TextLabel"
      L34_2 = L34_2(L35_2)
      L35_2 = Instance
      L35_2 = L35_2.new
      L36_2 = "UIPadding"
      L35_2 = L35_2(L36_2)
      L36_2 = Instance
      L36_2 = L36_2.new
      L37_2 = "Folder"
      L36_2 = L36_2(L37_2)
      L37_2 = Instance
      L37_2 = L37_2.new
      L38_2 = "TextButton"
      L37_2 = L37_2(L38_2)
      L38_2 = Instance
      L38_2 = L38_2.new
      L39_2 = "UIPadding"
      L38_2 = L38_2(L39_2)
      L39_2 = Instance
      L39_2 = L39_2.new
      L40_2 = "ImageLabel"
      L39_2 = L39_2(L40_2)
      L40_2 = Instance
      L40_2 = L40_2.new
      L41_2 = "TextButton"
      L40_2 = L40_2(L41_2)
      L41_2 = Instance
      L41_2 = L41_2.new
      L42_2 = "UIPadding"
      L41_2 = L41_2(L42_2)
      L42_2 = Instance
      L42_2 = L42_2.new
      L43_2 = "ImageLabel"
      L42_2 = L42_2(L43_2)
      L43_2 = Instance
      L43_2 = L43_2.new
      L44_2 = "Frame"
      L43_2 = L43_2(L44_2)
      L44_2 = Instance
      L44_2 = L44_2.new
      L45_2 = "TextButton"
      L44_2 = L44_2(L45_2)
      L45_2 = Instance
      L45_2 = L45_2.new
      L46_2 = "TextButton"
      L45_2 = L45_2(L46_2)
      L46_2 = Instance
      L46_2 = L46_2.new
      L47_2 = "UICorner"
      L46_2 = L46_2(L47_2)
      L47_2 = Instance
      L47_2 = L47_2.new
      L48_2 = "UIPadding"
      L47_2 = L47_2(L48_2)
      L48_2 = Instance
      L48_2 = L48_2.new
      L49_2 = "UIListLayout"
      L48_2 = L48_2(L49_2)
      L49_2 = Instance
      L49_2 = L49_2.new
      L50_2 = "TextButton"
      L49_2 = L49_2(L50_2)
      L50_2 = Instance
      L50_2 = L50_2.new
      L51_2 = "TextButton"
      L50_2 = L50_2(L51_2)
      L51_2 = Instance
      L51_2 = L51_2.new
      L52_2 = "UICorner"
      L51_2 = L51_2(L52_2)
      L52_2 = Instance
      L52_2 = L52_2.new
      L53_2 = "UIPadding"
      L52_2 = L52_2(L53_2)
      L53_2 = Instance
      L53_2 = L53_2.new
      L54_2 = "Frame"
      L53_2 = L53_2(L54_2)
      L54_2 = Instance
      L54_2 = L54_2.new
      L55_2 = "UIListLayout"
      L54_2 = L54_2(L55_2)
      L55_2 = Instance
      L55_2 = L55_2.new
      L56_2 = "TextButton"
      L55_2 = L55_2(L56_2)
      L56_2 = Instance
      L56_2 = L56_2.new
      L57_2 = "TextButton"
      L56_2 = L56_2(L57_2)
      L57_2 = Instance
      L57_2 = L57_2.new
      L58_2 = "UICorner"
      L57_2 = L57_2(L58_2)
      L58_2 = Instance
      L58_2 = L58_2.new
      L59_2 = "UIPadding"
      L58_2 = L58_2(L59_2)
      L59_2 = Instance
      L59_2 = L59_2.new
      L60_2 = "TextButton"
      L59_2 = L59_2(L60_2)
      L60_2 = Instance
      L60_2 = L60_2.new
      L61_2 = "TextButton"
      L60_2 = L60_2(L61_2)
      L61_2 = Instance
      L61_2 = L61_2.new
      L62_2 = "UICorner"
      L61_2 = L61_2(L62_2)
      L62_2 = Instance
      L62_2 = L62_2.new
      L63_2 = "UIPadding"
      L62_2 = L62_2(L63_2)
      L63_2 = Instance
      L63_2 = L63_2.new
      L64_2 = "TextButton"
      L63_2 = L63_2(L64_2)
      L64_2 = Instance
      L64_2 = L64_2.new
      L65_2 = "TextButton"
      L64_2 = L64_2(L65_2)
      L65_2 = Instance
      L65_2 = L65_2.new
      L66_2 = "UICorner"
      L65_2 = L65_2(L66_2)
      L66_2 = Instance
      L66_2 = L66_2.new
      L67_2 = "UIPadding"
      L66_2 = L66_2(L67_2)
      L67_2 = Instance
      L67_2 = L67_2.new
      L68_2 = "TextBox"
      L67_2 = L67_2(L68_2)
      L68_2 = Instance
      L68_2 = L68_2.new
      L69_2 = "UICorner"
      L68_2 = L68_2(L69_2)
      L69_2 = Instance
      L69_2 = L69_2.new
      L70_2 = "Frame"
      L69_2 = L69_2(L70_2)
      L70_2 = Instance
      L70_2 = L70_2.new
      L71_2 = "TextLabel"
      L70_2 = L70_2(L71_2)
      L71_2 = Instance
      L71_2 = L71_2.new
      L72_2 = "UIPadding"
      L71_2 = L71_2(L72_2)
      L72_2 = Instance
      L72_2 = L72_2.new
      L73_2 = "Frame"
      L72_2 = L72_2(L73_2)
      L73_2 = Instance
      L73_2 = L73_2.new
      L74_2 = "UIListLayout"
      L73_2 = L73_2(L74_2)
      L74_2 = Instance
      L74_2 = L74_2.new
      L75_2 = "TextButton"
      L74_2 = L74_2(L75_2)
      L75_2 = Instance
      L75_2 = L75_2.new
      L76_2 = "TextButton"
      L75_2 = L75_2(L76_2)
      L76_2 = Instance
      L76_2 = L76_2.new
      L77_2 = "UICorner"
      L76_2 = L76_2(L77_2)
      L77_2 = Instance
      L77_2 = L77_2.new
      L78_2 = "UIPadding"
      L77_2 = L77_2(L78_2)
      L78_2 = Instance
      L78_2 = L78_2.new
      L79_2 = "TextButton"
      L78_2 = L78_2(L79_2)
      L79_2 = Instance
      L79_2 = L79_2.new
      L80_2 = "TextButton"
      L79_2 = L79_2(L80_2)
      L80_2 = Instance
      L80_2 = L80_2.new
      L81_2 = "UICorner"
      L80_2 = L80_2(L81_2)
      L81_2 = Instance
      L81_2 = L81_2.new
      L82_2 = "UIPadding"
      L81_2 = L81_2(L82_2)
      L82_2 = Instance
      L82_2 = L82_2.new
      L83_2 = "Frame"
      L82_2 = L82_2(L83_2)
      L83_2 = Instance
      L83_2 = L83_2.new
      L84_2 = "TextLabel"
      L83_2 = L83_2(L84_2)
      L84_2 = Instance
      L84_2 = L84_2.new
      L85_2 = "UIPadding"
      L84_2 = L84_2(L85_2)
      L85_2 = Instance
      L85_2 = L85_2.new
      L86_2 = "Frame"
      L85_2 = L85_2(L86_2)
      L86_2 = Instance
      L86_2 = L86_2.new
      L87_2 = "UIListLayout"
      L86_2 = L86_2(L87_2)
      L87_2 = Instance
      L87_2 = L87_2.new
      L88_2 = "TextButton"
      L87_2 = L87_2(L88_2)
      L88_2 = Instance
      L88_2 = L88_2.new
      L89_2 = "UIPadding"
      L88_2 = L88_2(L89_2)
      L89_2 = Instance
      L89_2 = L89_2.new
      L90_2 = "TextButton"
      L89_2 = L89_2(L90_2)
      L90_2 = Instance
      L90_2 = L90_2.new
      L91_2 = "UICorner"
      L90_2 = L90_2(L91_2)
      L91_2 = Instance
      L91_2 = L91_2.new
      L92_2 = "TextButton"
      L91_2 = L91_2(L92_2)
      L92_2 = Instance
      L92_2 = L92_2.new
      L93_2 = "UIPadding"
      L92_2 = L92_2(L93_2)
      L93_2 = Instance
      L93_2 = L93_2.new
      L94_2 = "TextButton"
      L93_2 = L93_2(L94_2)
      L94_2 = Instance
      L94_2 = L94_2.new
      L95_2 = "UIPadding"
      L94_2 = L94_2(L95_2)
      L95_2 = Instance
      L95_2 = L95_2.new
      L96_2 = "TextButton"
      L95_2 = L95_2(L96_2)
      L96_2 = Instance
      L96_2 = L96_2.new
      L97_2 = "UIPadding"
      L96_2 = L96_2(L97_2)
      L97_2 = Instance
      L97_2 = L97_2.new
      L98_2 = "TextButton"
      L97_2 = L97_2(L98_2)
      L98_2 = Instance
      L98_2 = L98_2.new
      L99_2 = "UIPadding"
      L98_2 = L98_2(L99_2)
      L99_2 = Instance
      L99_2 = L99_2.new
      L100_2 = "Frame"
      L99_2 = L99_2(L100_2)
      L100_2 = Instance
      L100_2 = L100_2.new
      L101_2 = "ImageLabel"
      L100_2 = L100_2(L101_2)
      L101_2 = Instance
      L101_2 = L101_2.new
      L102_2 = "Frame"
      L101_2 = L101_2(L102_2)
      L102_2 = Instance
      L102_2 = L102_2.new
      L103_2 = "UICorner"
      L102_2 = L102_2(L103_2)
      L103_2 = Instance
      L103_2 = L103_2.new
      L104_2 = "ImageLabel"
      L103_2 = L103_2(L104_2)
      L104_2 = Instance
      L104_2 = L104_2.new
      L105_2 = "Frame"
      L104_2 = L104_2(L105_2)
      L105_2 = Instance
      L105_2 = L105_2.new
      L106_2 = "TextLabel"
      L105_2 = L105_2(L106_2)
      L106_2 = Instance
      L106_2 = L106_2.new
      L107_2 = "UIPadding"
      L106_2 = L106_2(L107_2)
      L107_2 = Instance
      L107_2 = L107_2.new
      L108_2 = "Frame"
      L107_2 = L107_2(L108_2)
      L108_2 = Instance
      L108_2 = L108_2.new
      L109_2 = "UIListLayout"
      L108_2 = L108_2(L109_2)
      L109_2 = Instance
      L109_2 = L109_2.new
      L110_2 = "TextButton"
      L109_2 = L109_2(L110_2)
      L110_2 = Instance
      L110_2 = L110_2.new
      L111_2 = "UIPadding"
      L110_2 = L110_2(L111_2)
      L111_2 = Instance
      L111_2 = L111_2.new
      L112_2 = "Frame"
      L111_2 = L111_2(L112_2)
      L112_2 = Instance
      L112_2 = L112_2.new
      L113_2 = "TextButton"
      L112_2 = L112_2(L113_2)
      L113_2 = Instance
      L113_2 = L113_2.new
      L114_2 = "Frame"
      L113_2 = L113_2(L114_2)
      L114_2 = Instance
      L114_2 = L114_2.new
      L115_2 = "ImageLabel"
      L114_2 = L114_2(L115_2)
      L115_2 = Instance
      L115_2 = L115_2.new
      L116_2 = "UICorner"
      L115_2 = L115_2(L116_2)
      L116_2 = Instance
      L116_2 = L116_2.new
      L117_2 = "UICorner"
      L116_2 = L116_2(L117_2)
      L117_2 = Instance
      L117_2 = L117_2.new
      L118_2 = "UICorner"
      L117_2 = L117_2(L118_2)
      L118_2 = Instance
      L118_2 = L118_2.new
      L119_2 = "TextButton"
      L118_2 = L118_2(L119_2)
      L119_2 = Instance
      L119_2 = L119_2.new
      L120_2 = "UIPadding"
      L119_2 = L119_2(L120_2)
      L120_2 = Instance
      L120_2 = L120_2.new
      L121_2 = "Frame"
      L120_2 = L120_2(L121_2)
      L121_2 = Instance
      L121_2 = L121_2.new
      L122_2 = "TextButton"
      L121_2 = L121_2(L122_2)
      L122_2 = Instance
      L122_2 = L122_2.new
      L123_2 = "Frame"
      L122_2 = L122_2(L123_2)
      L123_2 = Instance
      L123_2 = L123_2.new
      L124_2 = "ImageLabel"
      L123_2 = L123_2(L124_2)
      L124_2 = Instance
      L124_2 = L124_2.new
      L125_2 = "UICorner"
      L124_2 = L124_2(L125_2)
      L125_2 = Instance
      L125_2 = L125_2.new
      L126_2 = "UICorner"
      L125_2 = L125_2(L126_2)
      L126_2 = Instance
      L126_2 = L126_2.new
      L127_2 = "UICorner"
      L126_2 = L126_2(L127_2)
      L127_2 = Instance
      L127_2 = L127_2.new
      L128_2 = "TextButton"
      L127_2 = L127_2(L128_2)
      L128_2 = Instance
      L128_2 = L128_2.new
      L129_2 = "TextButton"
      L128_2 = L128_2(L129_2)
      L129_2 = Instance
      L129_2 = L129_2.new
      L130_2 = "UICorner"
      L129_2 = L129_2(L130_2)
      L130_2 = Instance
      L130_2 = L130_2.new
      L131_2 = "UIPadding"
      L130_2 = L130_2(L131_2)
      L131_2 = Instance
      L131_2 = L131_2.new
      L132_2 = "TextButton"
      L131_2 = L131_2(L132_2)
      L132_2 = Instance
      L132_2 = L132_2.new
      L133_2 = "TextButton"
      L132_2 = L132_2(L133_2)
      L133_2 = Instance
      L133_2 = L133_2.new
      L134_2 = "UICorner"
      L133_2 = L133_2(L134_2)
      L134_2 = Instance
      L134_2 = L134_2.new
      L135_2 = "UIPadding"
      L134_2 = L134_2(L135_2)
      L135_2 = Instance
      L135_2 = L135_2.new
      L136_2 = "Frame"
      L135_2 = L135_2(L136_2)
      L136_2 = Instance
      L136_2 = L136_2.new
      L137_2 = "UIListLayout"
      L136_2 = L136_2(L137_2)
      L137_2 = Instance
      L137_2 = L137_2.new
      L138_2 = "TextButton"
      L137_2 = L137_2(L138_2)
      L138_2 = Instance
      L138_2 = L138_2.new
      L139_2 = "UIPadding"
      L138_2 = L138_2(L139_2)
      L139_2 = Instance
      L139_2 = L139_2.new
      L140_2 = "TextButton"
      L139_2 = L139_2(L140_2)
      L140_2 = Instance
      L140_2 = L140_2.new
      L141_2 = "UIPadding"
      L140_2 = L140_2(L141_2)
      L141_2 = Instance
      L141_2 = L141_2.new
      L142_2 = "Folder"
      L141_2 = L141_2(L142_2)
      L142_2 = Instance
      L142_2 = L142_2.new
      L143_2 = "TextButton"
      L142_2 = L142_2(L143_2)
      L143_2 = Instance
      L143_2 = L143_2.new
      L144_2 = "UIPadding"
      L143_2 = L143_2(L144_2)
      L144_2 = Instance
      L144_2 = L144_2.new
      L145_2 = "ImageLabel"
      L144_2 = L144_2(L145_2)
      L145_2 = Instance
      L145_2 = L145_2.new
      L146_2 = "TextButton"
      L145_2 = L145_2(L146_2)
      L146_2 = Instance
      L146_2 = L146_2.new
      L147_2 = "UIPadding"
      L146_2 = L146_2(L147_2)
      L147_2 = Instance
      L147_2 = L147_2.new
      L148_2 = "ImageLabel"
      L147_2 = L147_2(L148_2)
      L148_2 = Instance
      L148_2 = L148_2.new
      L149_2 = "TextLabel"
      L148_2 = L148_2(L149_2)
      L2_2.Name = "PC Version"
      L149_2 = game
      L149_2 = L149_2.CoreGui
      L2_2.Parent = L149_2
      L3_2.Name = "LIGHTUX"
      L3_2.Parent = L2_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L3_2.BackgroundColor3 = L149_2
      L3_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.343410224
      L151_2 = 0
      L152_2 = 0.365432113
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L3_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 613
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L3_2.Size = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L4_2.CornerRadius = L149_2
      L4_2.Parent = L3_2
      L5_2.Name = "DropShadowHolder"
      L5_2.Parent = L3_2
      L5_2.BackgroundTransparency = 1
      L5_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 1
      L151_2 = 0
      L152_2 = 1
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L5_2.Size = L149_2
      L5_2.ZIndex = 0
      L6_2.Name = "DropShadow"
      L6_2.Parent = L5_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0.5
      L149_2 = L149_2(L150_2, L151_2)
      L6_2.AnchorPoint = L149_2
      L6_2.BackgroundTransparency = 1
      L6_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.500815749
      L151_2 = 0
      L152_2 = 6.91366339
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L6_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 1.01794457
      L151_2 = 47
      L152_2 = 14.3573608
      L153_2 = 47
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L6_2.Size = L149_2
      L6_2.ZIndex = 0
      L6_2.Image = "rbxassetid://6014261993"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L6_2.ImageColor3 = L149_2
      L6_2.ImageTransparency = 0.5
      L149_2 = Enum
      L149_2 = L149_2.ScaleType
      L149_2 = L149_2.Slice
      L6_2.ScaleType = L149_2
      L149_2 = Rect
      L149_2 = L149_2.new
      L150_2 = 49
      L151_2 = 49
      L152_2 = 450
      L153_2 = 450
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L6_2.SliceCenter = L149_2
      L7_2.Name = "Navigation"
      L7_2.Parent = L3_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 4
      L151_2 = 9
      L152_2 = 16
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L7_2.BackgroundColor3 = L149_2
      L7_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 213
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L7_2.Size = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L8_2.CornerRadius = L149_2
      L8_2.Parent = L7_2
      L9_2.Name = "HIDDEN"
      L9_2.Parent = L7_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 4
      L151_2 = 9
      L152_2 = 16
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L9_2.BackgroundColor3 = L149_2
      L9_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.0469483584
      L151_2 = 0
      L152_2 = 0
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L9_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 203
      L152_2 = 0
      L153_2 = 9
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L9_2.Size = L149_2
      L10_2.Name = "HIDDEN"
      L10_2.Parent = L7_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 4
      L151_2 = 9
      L152_2 = 16
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L10_2.BackgroundColor3 = L149_2
      L10_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.0469483584
      L151_2 = 0
      L152_2 = 0.972972989
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L10_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 203
      L152_2 = 0
      L153_2 = 9
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L10_2.Size = L149_2
      L11_2.Name = "ButtonsHolder"
      L11_2.Parent = L7_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 8
      L151_2 = 10
      L152_2 = 15
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L11_2.BackgroundColor3 = L149_2
      L11_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 224
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L11_2.Size = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L12_2.CornerRadius = L149_2
      L12_2.Parent = L11_2
      L13_2.Parent = L11_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L13_2.SortOrder = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 1
      L149_2 = L149_2(L150_2, L151_2)
      L13_2.Padding = L149_2
      L14_2.Name = "CombatButton"
      L14_2.Parent = L11_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 13
      L151_2 = 18
      L152_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L14_2.BackgroundColor3 = L149_2
      L14_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 214
      L152_2 = 0
      L153_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L14_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L14_2.Font = L149_2
      L14_2.Text = "Combat"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L14_2.TextColor3 = L149_2
      L14_2.TextSize = 19
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L14_2.TextXAlignment = L149_2
      L15_2.Parent = L14_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L15_2.PaddingBottom = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 55
      L149_2 = L149_2(L150_2, L151_2)
      L15_2.PaddingLeft = L149_2
      L16_2.Name = "INFO"
      L16_2.Parent = L14_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L16_2.BackgroundColor3 = L149_2
      L16_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 3.75887248E-5
      L151_2 = 0
      L152_2 = 0.899999619
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L16_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 157
      L152_2 = 0
      L153_2 = 14
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L16_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L16_2.Font = L149_2
      L16_2.Text = "Silent Aim, Autofarm, Hitbox"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 117
      L151_2 = 117
      L152_2 = 117
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L16_2.TextColor3 = L149_2
      L16_2.TextSize = 13
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L16_2.TextXAlignment = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextYAlignment
      L149_2 = L149_2.Top
      L16_2.TextYAlignment = L149_2
      L17_2.Name = "Icon"
      L17_2.Parent = L14_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L17_2.BackgroundColor3 = L149_2
      L17_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.287157238
      L151_2 = 0
      L152_2 = 0.262499988
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L17_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 36
      L152_2 = 0
      L153_2 = 35
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L17_2.Size = L149_2
      L17_2.Image = "http://www.roblox.com/asset/?id=11378036715"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 5
      L151_2 = 149
      L152_2 = 216
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L17_2.ImageColor3 = L149_2
      L18_2.Name = "MiscButton"
      L18_2.Parent = L11_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 13
      L151_2 = 18
      L152_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L18_2.BackgroundColor3 = L149_2
      L18_2.BackgroundTransparency = 1
      L18_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 214
      L152_2 = 0
      L153_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L18_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L18_2.Font = L149_2
      L18_2.Text = "Miscellaneous"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L18_2.TextColor3 = L149_2
      L18_2.TextSize = 19
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L18_2.TextXAlignment = L149_2
      L19_2.Parent = L18_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L19_2.PaddingBottom = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 55
      L149_2 = L149_2(L150_2, L151_2)
      L19_2.PaddingLeft = L149_2
      L20_2.Name = "INFO"
      L20_2.Parent = L18_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L20_2.BackgroundColor3 = L149_2
      L20_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 3.75887248E-5
      L151_2 = 0
      L152_2 = 0.899999619
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L20_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 157
      L152_2 = 0
      L153_2 = 14
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L20_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L20_2.Font = L149_2
      L20_2.Text = "Anti AFK, Collect Powerups"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 117
      L151_2 = 117
      L152_2 = 117
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L20_2.TextColor3 = L149_2
      L20_2.TextSize = 13
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L20_2.TextXAlignment = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextYAlignment
      L149_2 = L149_2.Top
      L20_2.TextYAlignment = L149_2
      L21_2.Name = "Icon"
      L21_2.Parent = L18_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L21_2.BackgroundColor3 = L149_2
      L21_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.287157238
      L151_2 = 0
      L152_2 = 0.262499988
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L21_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 36
      L152_2 = 0
      L153_2 = 35
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L21_2.Size = L149_2
      L21_2.Image = "http://www.roblox.com/asset/?id=12073628370"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 5
      L151_2 = 149
      L152_2 = 216
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L21_2.ImageColor3 = L149_2
      L22_2.Name = "PlayersButton"
      L22_2.Parent = L11_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 13
      L151_2 = 18
      L152_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L22_2.BackgroundColor3 = L149_2
      L22_2.BackgroundTransparency = 1
      L22_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 214
      L152_2 = 0
      L153_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L22_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L22_2.Font = L149_2
      L22_2.Text = "Player"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L22_2.TextColor3 = L149_2
      L22_2.TextSize = 19
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L22_2.TextXAlignment = L149_2
      L23_2.Parent = L22_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L23_2.PaddingBottom = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 55
      L149_2 = L149_2(L150_2, L151_2)
      L23_2.PaddingLeft = L149_2
      L24_2.Name = "INFO"
      L24_2.Parent = L22_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L24_2.BackgroundColor3 = L149_2
      L24_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 3.75887248E-5
      L151_2 = 0
      L152_2 = 0.899999619
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L24_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 157
      L152_2 = 0
      L153_2 = 14
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L24_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L24_2.Font = L149_2
      L24_2.Text = "Speed, Fly, Jumppower, Inf jump"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 117
      L151_2 = 117
      L152_2 = 117
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L24_2.TextColor3 = L149_2
      L24_2.TextSize = 13
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L24_2.TextXAlignment = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextYAlignment
      L149_2 = L149_2.Top
      L24_2.TextYAlignment = L149_2
      L25_2.Name = "Icon"
      L25_2.Parent = L22_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L25_2.BackgroundColor3 = L149_2
      L25_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.287157238
      L151_2 = 0
      L152_2 = 0.262499988
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L25_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 36
      L152_2 = 0
      L153_2 = 35
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L25_2.Size = L149_2
      L25_2.Image = "http://www.roblox.com/asset/?id=11378105473"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 5
      L151_2 = 149
      L152_2 = 216
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L25_2.ImageColor3 = L149_2
      L26_2.Parent = L11_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 8
      L149_2 = L149_2(L150_2, L151_2)
      L26_2.PaddingBottom = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 8
      L149_2 = L149_2(L150_2, L151_2)
      L26_2.PaddingTop = L149_2
      L27_2.Name = "SettingsButton"
      L27_2.Parent = L11_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 13
      L151_2 = 18
      L152_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L27_2.BackgroundColor3 = L149_2
      L27_2.BackgroundTransparency = 1
      L27_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 214
      L152_2 = 0
      L153_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L27_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L27_2.Font = L149_2
      L27_2.Text = "Settings"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L27_2.TextColor3 = L149_2
      L27_2.TextSize = 19
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L27_2.TextXAlignment = L149_2
      L28_2.Parent = L27_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L28_2.PaddingBottom = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 55
      L149_2 = L149_2(L150_2, L151_2)
      L28_2.PaddingLeft = L149_2
      L29_2.Name = "INFO"
      L29_2.Parent = L27_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L29_2.BackgroundColor3 = L149_2
      L29_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 3.75887248E-5
      L151_2 = 0
      L152_2 = 0.899999619
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L29_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 157
      L152_2 = 0
      L153_2 = 14
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L29_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L29_2.Font = L149_2
      L29_2.Text = "Open/Close, Credits, Lightux+"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 117
      L151_2 = 117
      L152_2 = 117
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L29_2.TextColor3 = L149_2
      L29_2.TextSize = 13
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L29_2.TextXAlignment = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextYAlignment
      L149_2 = L149_2.Top
      L29_2.TextYAlignment = L149_2
      L30_2.Name = "Icon"
      L30_2.Parent = L27_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L30_2.BackgroundColor3 = L149_2
      L30_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.287157238
      L151_2 = 0
      L152_2 = 0.262499988
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L30_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 36
      L152_2 = 0
      L153_2 = 35
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L30_2.Size = L149_2
      L30_2.Image = "http://www.roblox.com/asset/?id=12073628370"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 5
      L151_2 = 149
      L152_2 = 216
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L30_2.ImageColor3 = L149_2
      L31_2.Name = "PageHolder"
      L31_2.Parent = L3_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 13
      L151_2 = 18
      L152_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L31_2.BackgroundColor3 = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 27
      L151_2 = 42
      L152_2 = 53
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L31_2.BorderColor3 = L149_2
      L31_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.345840126
      L151_2 = 0
      L152_2 = 0
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L31_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 401
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L31_2.Size = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L32_2.CornerRadius = L149_2
      L32_2.Parent = L31_2
      L33_2.Name = "CombatPage"
      L33_2.Parent = L31_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L33_2.BackgroundColor3 = L149_2
      L33_2.BackgroundTransparency = 1
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 27
      L151_2 = 42
      L152_2 = 53
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L33_2.BorderColor3 = L149_2
      L33_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00160685321
      L151_2 = 0
      L152_2 = -4.67203034E-4
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L33_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L33_2.Size = L149_2
      L34_2.Name = "Combattitle"
      L34_2.Parent = L33_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L34_2.BackgroundColor3 = L149_2
      L34_2.BackgroundTransparency = 1
      L34_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 398
      L152_2 = 0
      L153_2 = 55
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L34_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.Arial
      L34_2.Font = L149_2
      L34_2.Text = "Combat"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L34_2.TextColor3 = L149_2
      L34_2.TextSize = 25
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L34_2.TextXAlignment = L149_2
      L35_2.Parent = L34_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L35_2.PaddingLeft = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 13
      L149_2 = L149_2(L150_2, L151_2)
      L35_2.PaddingTop = L149_2
      L36_2.Name = "PageButtons"
      L36_2.Parent = L33_2
      L37_2.Name = "WeaponsButton"
      L37_2.Parent = L36_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L37_2.BackgroundColor3 = L149_2
      L37_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.24060151
      L151_2 = 0
      L152_2 = 0.153153151
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L37_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 84
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L37_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L37_2.Font = L149_2
      L37_2.Text = "Weapons"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L37_2.TextColor3 = L149_2
      L37_2.TextSize = 14
      L38_2.Parent = L37_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L38_2.PaddingRight = L149_2
      L39_2.Name = "WeaponLine"
      L39_2.Parent = L37_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L39_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.101999998
      L151_2 = 0
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L39_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 50
      L152_2 = 0
      L153_2 = 1
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L39_2.Size = L149_2
      L39_2.Visible = false
      L39_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L39_2.ImageColor3 = L149_2
      L40_2.Name = "ZombiesButton"
      L40_2.Parent = L36_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L40_2.BackgroundColor3 = L149_2
      L40_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.0300751887
      L151_2 = 0
      L152_2 = 0.153153151
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L40_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 84
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L40_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L40_2.Font = L149_2
      L40_2.Text = "Zombies"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L40_2.TextColor3 = L149_2
      L40_2.TextSize = 14
      L41_2.Parent = L40_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L41_2.PaddingRight = L149_2
      L42_2.Name = "ZombLine"
      L42_2.Parent = L40_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L42_2.BackgroundColor3 = L149_2
      L42_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.122000001
      L151_2 = 0
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L42_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 48
      L152_2 = 0
      L153_2 = 1
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L42_2.Size = L149_2
      L42_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L42_2.ImageColor3 = L149_2
      L43_2.Name = "ZombiesPage"
      L43_2.Parent = L33_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 234
      L151_2 = 170
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L43_2.BackgroundColor3 = L149_2
      L43_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0050125313
      L151_2 = 0
      L152_2 = 0.265198678
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L43_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 244
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L43_2.Size = L149_2
      L44_2.Name = "Autofarm"
      L44_2.Parent = L43_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L44_2.BackgroundColor3 = L149_2
      L44_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L44_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L44_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L44_2.Font = L149_2
      L44_2.Text = "Autofarm"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L44_2.TextColor3 = L149_2
      L44_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L44_2.TextXAlignment = L149_2
      L45_2.Name = "AutofarmToggle"
      L45_2.Parent = L44_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L45_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L45_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L45_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L45_2.Font = L149_2
      L45_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L45_2.TextColor3 = L149_2
      L45_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L46_2.CornerRadius = L149_2
      L46_2.Parent = L45_2
      L47_2.Parent = L44_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L47_2.PaddingLeft = L149_2
      L48_2.Parent = L43_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L48_2.SortOrder = L149_2
      L49_2.Name = "HeadHitboxExtenderButton"
      L49_2.Parent = L43_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L49_2.BackgroundColor3 = L149_2
      L49_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L49_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L49_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L49_2.Font = L149_2
      L49_2.Text = "Zombie bighead"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L49_2.TextColor3 = L149_2
      L49_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L49_2.TextXAlignment = L149_2
      L50_2.Name = "BigheadToggle"
      L50_2.Parent = L49_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L50_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L50_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L50_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L50_2.Font = L149_2
      L50_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L50_2.TextColor3 = L149_2
      L50_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L51_2.CornerRadius = L149_2
      L51_2.Parent = L50_2
      L52_2.Parent = L49_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L52_2.PaddingLeft = L149_2
      L53_2.Name = "WeaponsPage"
      L53_2.Parent = L33_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 234
      L151_2 = 170
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L53_2.BackgroundColor3 = L149_2
      L53_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0050125313
      L151_2 = 0
      L152_2 = 0.265198678
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L53_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 244
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L53_2.Size = L149_2
      L53_2.Visible = false
      L54_2.Parent = L53_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L54_2.SortOrder = L149_2
      L55_2.Name = "SilentAimZomb"
      L55_2.Parent = L53_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L55_2.BackgroundColor3 = L149_2
      L55_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L55_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L55_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L55_2.Font = L149_2
      L55_2.Text = "Silent aim zombies"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L55_2.TextColor3 = L149_2
      L55_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L55_2.TextXAlignment = L149_2
      L56_2.Name = "SilentAimToggle"
      L56_2.Parent = L55_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L56_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L56_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L56_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L56_2.Font = L149_2
      L56_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L56_2.TextColor3 = L149_2
      L56_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L57_2.CornerRadius = L149_2
      L57_2.Parent = L56_2
      L58_2.Parent = L55_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L58_2.PaddingLeft = L149_2
      L59_2.Name = "SilentAimboss"
      L59_2.Parent = L53_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L59_2.BackgroundColor3 = L149_2
      L59_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L59_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L59_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L59_2.Font = L149_2
      L59_2.Text = "Silent aim bosses"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L59_2.TextColor3 = L149_2
      L59_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L59_2.TextXAlignment = L149_2
      L60_2.Name = "SilentAimbossToggle"
      L60_2.Parent = L59_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L60_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L60_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L60_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L60_2.Font = L149_2
      L60_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L60_2.TextColor3 = L149_2
      L60_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L61_2.CornerRadius = L149_2
      L61_2.Parent = L60_2
      L62_2.Parent = L59_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L62_2.PaddingLeft = L149_2
      L63_2.Name = "AutoEquip"
      L63_2.Parent = L53_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L63_2.BackgroundColor3 = L149_2
      L63_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L63_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L63_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L63_2.Font = L149_2
      L63_2.Text = "Auto equip"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L63_2.TextColor3 = L149_2
      L63_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L63_2.TextXAlignment = L149_2
      L64_2.Name = "AutoEquipToggle"
      L64_2.Parent = L63_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L64_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L64_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L64_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L64_2.Font = L149_2
      L64_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L64_2.TextColor3 = L149_2
      L64_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L65_2.CornerRadius = L149_2
      L65_2.Parent = L64_2
      L66_2.Parent = L63_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L66_2.PaddingLeft = L149_2
      L67_2.Name = "weapon"
      L67_2.Parent = L63_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L67_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.665920615
      L151_2 = 0
      L152_2 = 0.13916257
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L67_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 107
      L152_2 = 0
      L153_2 = 22
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L67_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L67_2.Font = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 178
      L151_2 = 178
      L152_2 = 178
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L67_2.PlaceholderColor3 = L149_2
      L67_2.PlaceholderText = "Weapon Name"
      L67_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L67_2.TextColor3 = L149_2
      L67_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L68_2.CornerRadius = L149_2
      L68_2.Parent = L67_2
      L69_2.Name = "MiscPage"
      L69_2.Parent = L31_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L69_2.BackgroundColor3 = L149_2
      L69_2.BackgroundTransparency = 1
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 27
      L151_2 = 42
      L152_2 = 53
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L69_2.BorderColor3 = L149_2
      L69_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00160679221
      L151_2 = 0
      L152_2 = -4.67203034E-4
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L69_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L69_2.Size = L149_2
      L69_2.Visible = false
      L70_2.Name = "MiscTitle"
      L70_2.Parent = L69_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L70_2.BackgroundColor3 = L149_2
      L70_2.BackgroundTransparency = 1
      L70_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 398
      L152_2 = 0
      L153_2 = 55
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L70_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.Arial
      L70_2.Font = L149_2
      L70_2.Text = "Miscellaneous"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L70_2.TextColor3 = L149_2
      L70_2.TextSize = 25
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L70_2.TextXAlignment = L149_2
      L71_2.Parent = L70_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L71_2.PaddingLeft = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 13
      L149_2 = L149_2(L150_2, L151_2)
      L71_2.PaddingTop = L149_2
      L72_2.Name = "SmallPage"
      L72_2.Parent = L69_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 234
      L151_2 = 170
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L72_2.BackgroundColor3 = L149_2
      L72_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0050125313
      L151_2 = 0
      L152_2 = 0.165165171
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L72_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 277
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L72_2.Size = L149_2
      L73_2.Parent = L72_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L73_2.SortOrder = L149_2
      L74_2.Name = "AntiAFK"
      L74_2.Parent = L72_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L74_2.BackgroundColor3 = L149_2
      L74_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00174179068
      L151_2 = 0
      L152_2 = -0.0215872824
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L74_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L74_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L74_2.Font = L149_2
      L74_2.Text = "Anti AFK"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L74_2.TextColor3 = L149_2
      L74_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L74_2.TextXAlignment = L149_2
      L75_2.Name = "AntiAFKToggle"
      L75_2.Parent = L74_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L75_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L75_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L75_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L75_2.Font = L149_2
      L75_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L75_2.TextColor3 = L149_2
      L75_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L76_2.CornerRadius = L149_2
      L76_2.Parent = L75_2
      L77_2.Parent = L74_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L77_2.PaddingLeft = L149_2
      L78_2.Name = "Collectpowerups"
      L78_2.Parent = L72_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L78_2.BackgroundColor3 = L149_2
      L78_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L78_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L78_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L78_2.Font = L149_2
      L78_2.Text = "Collect powerups"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L78_2.TextColor3 = L149_2
      L78_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L78_2.TextXAlignment = L149_2
      L79_2.Name = "PowerupsTOggle"
      L79_2.Parent = L78_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L79_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L79_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L79_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L79_2.Font = L149_2
      L79_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L79_2.TextColor3 = L149_2
      L79_2.TextSize = 14
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L80_2.CornerRadius = L149_2
      L80_2.Parent = L79_2
      L81_2.Parent = L78_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L81_2.PaddingLeft = L149_2
      L82_2.Name = "SettingsPage"
      L82_2.Parent = L31_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L82_2.BackgroundColor3 = L149_2
      L82_2.BackgroundTransparency = 1
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 27
      L151_2 = 42
      L152_2 = 53
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L82_2.BorderColor3 = L149_2
      L82_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00160679221
      L151_2 = 0
      L152_2 = -4.67203034E-4
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L82_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L82_2.Size = L149_2
      L82_2.Visible = false
      L83_2.Name = "SettingsTitle"
      L83_2.Parent = L82_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L83_2.BackgroundColor3 = L149_2
      L83_2.BackgroundTransparency = 1
      L83_2.BorderSizePixel = 0
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 398
      L152_2 = 0
      L153_2 = 55
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L83_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.Arial
      L83_2.Font = L149_2
      L83_2.Text = "Settings"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L83_2.TextColor3 = L149_2
      L83_2.TextSize = 25
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L83_2.TextXAlignment = L149_2
      L84_2.Parent = L83_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L84_2.PaddingLeft = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 13
      L149_2 = L149_2(L150_2, L151_2)
      L84_2.PaddingTop = L149_2
      L85_2.Name = "SmallPage"
      L85_2.Parent = L82_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 234
      L151_2 = 170
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L85_2.BackgroundColor3 = L149_2
      L85_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0050125313
      L151_2 = 0
      L152_2 = 0.165165171
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L85_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 277
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L85_2.Size = L149_2
      L86_2.Parent = L85_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L86_2.SortOrder = L149_2
      L87_2.Name = "Open/Close"
      L87_2.Parent = L85_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L87_2.BackgroundColor3 = L149_2
      L87_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L87_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L87_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L87_2.Font = L149_2
      L87_2.Text = "Open/Close UI"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L87_2.TextColor3 = L149_2
      L87_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L87_2.TextXAlignment = L149_2
      L88_2.Parent = L87_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L88_2.PaddingLeft = L149_2
      L89_2.Name = "UIButton"
      L89_2.Parent = L87_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L89_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.909890175
      L151_2 = 0
      L152_2 = 0.0735542923
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L89_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L89_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L89_2.Font = L149_2
      L89_2.Text = "L"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L89_2.TextColor3 = L149_2
      L89_2.TextSize = 14
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L89_2.TextStrokeColor3 = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L90_2.CornerRadius = L149_2
      L90_2.Parent = L89_2
      L91_2.Name = "Credits"
      L91_2.Parent = L85_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L91_2.BackgroundColor3 = L149_2
      L91_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L91_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L91_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L91_2.Font = L149_2
      L91_2.Text = "Credits"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L91_2.TextColor3 = L149_2
      L91_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L91_2.TextXAlignment = L149_2
      L92_2.Parent = L91_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L92_2.PaddingLeft = L149_2
      L93_2.Name = "CopyDiscord"
      L93_2.Parent = L85_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L93_2.BackgroundColor3 = L149_2
      L93_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L93_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L93_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L93_2.Font = L149_2
      L93_2.Text = "Copy discord invite"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L93_2.TextColor3 = L149_2
      L93_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L93_2.TextXAlignment = L149_2
      L94_2.Parent = L93_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L94_2.PaddingLeft = L149_2
      L95_2.Name = "LightuxPrem"
      L95_2.Parent = L85_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L95_2.BackgroundColor3 = L149_2
      L95_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L95_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L95_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L95_2.Font = L149_2
      L95_2.Text = "Lightux+ information"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L95_2.TextColor3 = L149_2
      L95_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L95_2.TextXAlignment = L149_2
      L96_2.Parent = L95_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L96_2.PaddingLeft = L149_2
      L97_2.Name = "Background color"
      L97_2.Parent = L85_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L97_2.BackgroundColor3 = L149_2
      L97_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0.418772548
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L97_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 292
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L97_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L97_2.Font = L149_2
      L97_2.Text = "Background color"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L97_2.TextColor3 = L149_2
      L97_2.TextSize = 15
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L97_2.TextXAlignment = L149_2
      L98_2.Parent = L97_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L98_2.PaddingLeft = L149_2
      L99_2.Name = "colorpi"
      L99_2.Parent = L82_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0.5
      L149_2 = L149_2(L150_2, L151_2)
      L99_2.AnchorPoint = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L99_2.BackgroundColor3 = L149_2
      L99_2.BackgroundTransparency = 1
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.823308229
      L151_2 = 0
      L152_2 = 0.647147179
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L99_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.25
      L151_2 = 0
      L152_2 = 0.25
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L99_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.SizeConstraint
      L150_2 = "RelativeXX"
      L149_2 = L149_2[L150_2]
      L99_2.SizeConstraint = L149_2
      L149_2 = "RGB"
      L100_2.Name = L149_2
      L100_2.Parent = L99_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0
      L149_2 = L149_2(L150_2, L151_2)
      L100_2.AnchorPoint = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L100_2.BackgroundColor3 = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 40
      L151_2 = 40
      L152_2 = 40
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L100_2.BorderColor3 = L149_2
      L149_2 = 0
      L100_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.629110098
      L151_2 = 0
      L152_2 = 0.097111553
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L100_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.821779847
      L151_2 = 0
      L152_2 = 0.222888514
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L100_2.Size = L149_2
      L149_2 = 4
      L100_2.ZIndex = L149_2
      L149_2 = "rbxassetid://1433361550"
      L100_2.Image = L149_2
      L149_2 = Rect
      L149_2 = L149_2.new
      L150_2 = 10
      L151_2 = 10
      L152_2 = 90
      L153_2 = 90
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L100_2.SliceCenter = L149_2
      L149_2 = "Marker"
      L101_2.Name = L149_2
      L101_2.Parent = L100_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0.5
      L149_2 = L149_2(L150_2, L151_2)
      L101_2.AnchorPoint = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L101_2.BackgroundColor3 = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L101_2.BorderColor3 = L149_2
      L149_2 = 2
      L101_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0
      L152_2 = 1
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L101_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L152_2 = 0
      L153_2 = 4
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L101_2.Size = L149_2
      L149_2 = 5
      L101_2.ZIndex = L149_2
      L102_2.Parent = L101_2
      L149_2 = "Preview"
      L103_2.Name = L149_2
      L103_2.Parent = L99_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0
      L149_2 = L149_2(L150_2, L151_2)
      L103_2.AnchorPoint = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L103_2.BackgroundColor3 = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 40
      L151_2 = 40
      L152_2 = 40
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L103_2.BorderColor3 = L149_2
      L149_2 = 2
      L103_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.33455506
      L151_2 = 0
      L152_2 = 0.629999995
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L103_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.269110143
      L151_2 = 0
      L152_2 = 0.100000001
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L103_2.Size = L149_2
      L149_2 = false
      L103_2.Visible = L149_2
      L149_2 = 4
      L103_2.ZIndex = L149_2
      L149_2 = Rect
      L149_2 = L149_2.new
      L150_2 = 10
      L151_2 = 10
      L152_2 = 90
      L153_2 = 90
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L103_2.SliceCenter = L149_2
      L149_2 = "PlayersPage"
      L104_2.Name = L149_2
      L104_2.Parent = L31_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L104_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L104_2.BackgroundTransparency = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 27
      L151_2 = 42
      L152_2 = 53
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L104_2.BorderColor3 = L149_2
      L149_2 = 0
      L104_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00160679221
      L151_2 = 0
      L152_2 = -4.67203034E-4
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L104_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 333
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L104_2.Size = L149_2
      L149_2 = false
      L104_2.Visible = L149_2
      L149_2 = "PlayerTitle"
      L105_2.Name = L149_2
      L105_2.Parent = L104_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 11
      L151_2 = 19
      L152_2 = 31
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L105_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L105_2.BackgroundTransparency = L149_2
      L149_2 = 0
      L105_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 398
      L152_2 = 0
      L153_2 = 55
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L105_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.Arial
      L105_2.Font = L149_2
      L105_2.Text = "Player"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L105_2.TextColor3 = L149_2
      L149_2 = 25
      L105_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L105_2.TextXAlignment = L149_2
      L106_2.Parent = L105_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L106_2.PaddingLeft = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 13
      L149_2 = L149_2(L150_2, L151_2)
      L106_2.PaddingTop = L149_2
      L149_2 = "PlayerPage"
      L107_2.Name = L149_2
      L107_2.Parent = L104_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 234
      L151_2 = 170
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L107_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L107_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0050125313
      L151_2 = 0
      L152_2 = 0.265198678
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L107_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 244
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L107_2.Size = L149_2
      L108_2.Parent = L107_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L108_2.SortOrder = L149_2
      L149_2 = "WalkSpeed"
      L109_2.Name = L149_2
      L109_2.Parent = L107_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L109_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L109_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L109_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L109_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L109_2.Font = L149_2
      L149_2 = "WalkSpeed"
      L109_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L109_2.TextColor3 = L149_2
      L149_2 = 15
      L109_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L109_2.TextXAlignment = L149_2
      L110_2.Parent = L109_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 21
      L149_2 = L149_2(L150_2, L151_2)
      L110_2.PaddingLeft = L149_2
      L149_2 = "WalkSpeedSlider"
      L111_2.Name = L149_2
      L111_2.Parent = L107_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L111_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L111_2.BackgroundTransparency = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L111_2.BorderColor3 = L149_2
      L149_2 = 0
      L111_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0.118852459
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L111_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.897947013
      L151_2 = 0
      L152_2 = 0.0729507878
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L111_2.Size = L149_2
      L149_2 = "Slider"
      L112_2.Name = L149_2
      L112_2.Parent = L111_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0.5
      L149_2 = L149_2(L150_2, L151_2)
      L112_2.AnchorPoint = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 14
      L151_2 = 18
      L152_2 = 40
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L112_2.BackgroundColor3 = L149_2
      L149_2 = 0
      L112_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.387189299
      L151_2 = 0
      L152_2 = 0.443820089
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L112_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.625213265
      L151_2 = 0
      L152_2 = 0.280898362
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L112_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L150_2 = "Cartoon"
      L149_2 = L149_2[L150_2]
      L112_2.Font = L149_2
      L112_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L112_2.TextColor3 = L149_2
      L149_2 = 14
      L112_2.TextSize = L149_2
      L149_2 = "Bar"
      L113_2.Name = L149_2
      L113_2.Parent = L112_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L113_2.BackgroundColor3 = L149_2
      L149_2 = 0
      L113_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0306784436
      L151_2 = 0
      L152_2 = 0
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L113_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.235614806
      L151_2 = 0
      L152_2 = 0.973472774
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L113_2.Size = L149_2
      L114_2.Parent = L113_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L114_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L114_2.BackgroundTransparency = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L114_2.BorderColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.992388248
      L151_2 = 0
      L152_2 = -1.424227
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L114_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 17
      L152_2 = 0
      L153_2 = 17
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L114_2.Size = L149_2
      L149_2 = "rbxassetid://12071797864"
      L114_2.Image = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L114_2.ImageColor3 = L149_2
      L115_2.Parent = L113_2
      L116_2.Parent = L112_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L117_2.CornerRadius = L149_2
      L117_2.Parent = L111_2
      L149_2 = "JumpPower"
      L118_2.Name = L149_2
      L118_2.Parent = L107_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L118_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L118_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L118_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L118_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L118_2.Font = L149_2
      L149_2 = "JumpPower"
      L118_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L118_2.TextColor3 = L149_2
      L149_2 = 15
      L118_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L118_2.TextXAlignment = L149_2
      L119_2.Parent = L118_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 21
      L149_2 = L149_2(L150_2, L151_2)
      L119_2.PaddingLeft = L149_2
      L149_2 = "JumpPowerSlider"
      L120_2.Name = L149_2
      L120_2.Parent = L107_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L120_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L120_2.BackgroundTransparency = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L120_2.BorderColor3 = L149_2
      L149_2 = 0
      L120_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0.118852459
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L120_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.897947013
      L151_2 = 0
      L152_2 = 0.0729507878
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L120_2.Size = L149_2
      L149_2 = "Slider"
      L121_2.Name = L149_2
      L121_2.Parent = L120_2
      L149_2 = Vector2
      L149_2 = L149_2.new
      L150_2 = 0.5
      L151_2 = 0.5
      L149_2 = L149_2(L150_2, L151_2)
      L121_2.AnchorPoint = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 14
      L151_2 = 18
      L152_2 = 40
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L121_2.BackgroundColor3 = L149_2
      L149_2 = 0
      L121_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.387189299
      L151_2 = 0
      L152_2 = 0.443820089
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L121_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.625213265
      L151_2 = 0
      L152_2 = 0.280898362
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L121_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L150_2 = "Cartoon"
      L149_2 = L149_2[L150_2]
      L121_2.Font = L149_2
      L121_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L121_2.TextColor3 = L149_2
      L149_2 = 14
      L121_2.TextSize = L149_2
      L149_2 = "Bar"
      L122_2.Name = L149_2
      L122_2.Parent = L121_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L122_2.BackgroundColor3 = L149_2
      L149_2 = 0
      L122_2.BorderSizePixel = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0306784436
      L151_2 = 0
      L152_2 = 0
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L122_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.235614806
      L151_2 = 0
      L152_2 = 0.973472774
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L122_2.Size = L149_2
      L123_2.Parent = L122_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L123_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L123_2.BackgroundTransparency = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L123_2.BorderColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.992388248
      L151_2 = 0
      L152_2 = -1.424227
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L123_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 17
      L152_2 = 0
      L153_2 = 17
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L123_2.Size = L149_2
      L149_2 = "rbxassetid://12071797864"
      L123_2.Image = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L123_2.ImageColor3 = L149_2
      L124_2.Parent = L122_2
      L125_2.Parent = L121_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L126_2.CornerRadius = L149_2
      L126_2.Parent = L120_2
      L149_2 = "Fly"
      L127_2.Name = L149_2
      L127_2.Parent = L107_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L127_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L127_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L127_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L127_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L127_2.Font = L149_2
      L149_2 = "Fly"
      L127_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L127_2.TextColor3 = L149_2
      L149_2 = 15
      L127_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L127_2.TextXAlignment = L149_2
      L149_2 = "FlyToggle"
      L128_2.Name = L149_2
      L128_2.Parent = L127_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L128_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L128_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L128_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L128_2.Font = L149_2
      L128_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L128_2.TextColor3 = L149_2
      L149_2 = 14
      L128_2.TextSize = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L129_2.CornerRadius = L149_2
      L129_2.Parent = L128_2
      L130_2.Parent = L127_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L130_2.PaddingLeft = L149_2
      L149_2 = "InfiniteJump"
      L131_2.Name = L149_2
      L131_2.Parent = L107_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L131_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L131_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L131_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L131_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L131_2.Font = L149_2
      L149_2 = "Infinite jump"
      L131_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L131_2.TextColor3 = L149_2
      L149_2 = 15
      L131_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L131_2.TextXAlignment = L149_2
      L149_2 = "FlyToggle"
      L132_2.Name = L149_2
      L132_2.Parent = L131_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 29
      L151_2 = 40
      L152_2 = 58
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L132_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0901098251
      L151_2 = 0
      L152_2 = 0.10803704
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L132_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 22
      L152_2 = 0
      L153_2 = 23
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L132_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSans
      L132_2.Font = L149_2
      L132_2.Text = ""
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 0
      L152_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L132_2.TextColor3 = L149_2
      L149_2 = 14
      L132_2.TextSize = L149_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 4
      L149_2 = L149_2(L150_2, L151_2)
      L133_2.CornerRadius = L149_2
      L133_2.Parent = L132_2
      L134_2.Parent = L131_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 53
      L149_2 = L149_2(L150_2, L151_2)
      L134_2.PaddingLeft = L149_2
      L149_2 = "ToolPage"
      L135_2.Name = L149_2
      L135_2.Parent = L104_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 234
      L151_2 = 170
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L135_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L135_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = -0.0050125313
      L151_2 = 0
      L152_2 = 0.265198678
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L135_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 400
      L152_2 = 0
      L153_2 = 244
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L135_2.Size = L149_2
      L149_2 = false
      L135_2.Visible = L149_2
      L136_2.Parent = L135_2
      L149_2 = Enum
      L149_2 = L149_2.SortOrder
      L149_2 = L149_2.LayoutOrder
      L136_2.SortOrder = L149_2
      L149_2 = "ClickTP"
      L137_2.Name = L149_2
      L137_2.Parent = L135_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L137_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L137_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L137_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L137_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L137_2.Font = L149_2
      L149_2 = "Click teleport tool"
      L137_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L137_2.TextColor3 = L149_2
      L149_2 = 15
      L137_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L137_2.TextXAlignment = L149_2
      L138_2.Parent = L137_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L138_2.PaddingLeft = L149_2
      L149_2 = "Btools"
      L139_2.Name = L149_2
      L139_2.Parent = L135_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 26
      L151_2 = 42
      L152_2 = 52
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L139_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L139_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.00424179062
      L151_2 = 0
      L152_2 = 0.00300288107
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L139_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 399
      L152_2 = 0
      L153_2 = 29
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L139_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L139_2.Font = L149_2
      L149_2 = "Building Tools"
      L139_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L139_2.TextColor3 = L149_2
      L149_2 = 15
      L139_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L149_2 = L149_2.Left
      L139_2.TextXAlignment = L149_2
      L140_2.Parent = L139_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 24
      L149_2 = L149_2(L150_2, L151_2)
      L140_2.PaddingLeft = L149_2
      L141_2.Name = "PageButtons"
      L141_2.Parent = L104_2
      L149_2 = "ToolButton"
      L142_2.Name = L149_2
      L142_2.Parent = L141_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L142_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L142_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.24060151
      L151_2 = 0
      L152_2 = 0.153153151
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L142_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 84
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L142_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L142_2.Font = L149_2
      L149_2 = "Tools"
      L142_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L142_2.TextColor3 = L149_2
      L149_2 = 14
      L142_2.TextSize = L149_2
      L143_2.Parent = L142_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L143_2.PaddingRight = L149_2
      L149_2 = "ToolLine"
      L144_2.Name = L149_2
      L144_2.Parent = L142_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L144_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.219999999
      L151_2 = 0
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L144_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 35
      L152_2 = 0
      L153_2 = 1
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L144_2.Size = L149_2
      L149_2 = false
      L144_2.Visible = L149_2
      L144_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L144_2.ImageColor3 = L149_2
      L149_2 = "PlayerButton"
      L145_2.Name = L149_2
      L145_2.Parent = L141_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L145_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L145_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.0300751887
      L151_2 = 0
      L152_2 = 0.153153151
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L145_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 84
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L145_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L145_2.Font = L149_2
      L149_2 = "Player edit"
      L145_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L145_2.TextColor3 = L149_2
      L149_2 = 14
      L145_2.TextSize = L149_2
      L146_2.Parent = L145_2
      L149_2 = UDim
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 20
      L149_2 = L149_2(L150_2, L151_2)
      L146_2.PaddingRight = L149_2
      L149_2 = "PlayerLine"
      L147_2.Name = L149_2
      L147_2.Parent = L145_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L147_2.BackgroundColor3 = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.0700000003
      L151_2 = 0
      L152_2 = 0
      L153_2 = 24
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L147_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 55
      L152_2 = 0
      L153_2 = 1
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L147_2.Size = L149_2
      L147_2.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 0
      L151_2 = 136
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L147_2.ImageColor3 = L149_2
      L148_2.Parent = L3_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L148_2.BackgroundColor3 = L149_2
      L149_2 = 1
      L148_2.BackgroundTransparency = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0.667210519
      L151_2 = 0
      L152_2 = 0
      L153_2 = 0
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L148_2.Position = L149_2
      L149_2 = UDim2
      L149_2 = L149_2.new
      L150_2 = 0
      L151_2 = 200
      L152_2 = 0
      L153_2 = 16
      L149_2 = L149_2(L150_2, L151_2, L152_2, L153_2)
      L148_2.Size = L149_2
      L149_2 = Enum
      L149_2 = L149_2.Font
      L149_2 = L149_2.SourceSansSemibold
      L148_2.Font = L149_2
      L149_2 = "Drag top"
      L148_2.Text = L149_2
      L149_2 = Color3
      L149_2 = L149_2.fromRGB
      L150_2 = 255
      L151_2 = 255
      L152_2 = 255
      L149_2 = L149_2(L150_2, L151_2, L152_2)
      L148_2.TextColor3 = L149_2
      L149_2 = 14
      L148_2.TextSize = L149_2
      L149_2 = Enum
      L149_2 = L149_2.TextXAlignment
      L150_2 = "Right"
      L149_2 = L149_2[L150_2]
      L148_2.TextXAlignment = L149_2
      
      function L149_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L14_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L14_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L33_2
          L0_4.Visible = true
          L0_4 = L69_2
          L0_4.Visible = false
          L0_4 = L104_2
          L0_4.Visible = false
          L0_4 = L82_2
          L0_4.Visible = false
          L0_4 = L14_2
          L0_4.BackgroundTransparency = 0
          L0_4 = L18_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L22_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L27_2
          L0_4.BackgroundTransparency = 1
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L150_2 = coroutine
      L151_2 = "wrap"
      L150_2 = L150_2[L151_2]
      L151_2 = L149_2
      L150_2 = L150_2(L151_2)
      L150_2()
      
      function L150_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L18_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L18_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L33_2
          L0_4.Visible = false
          L0_4 = L69_2
          L0_4.Visible = true
          L0_4 = L104_2
          L0_4.Visible = false
          L0_4 = L82_2
          L0_4.Visible = false
          L0_4 = L14_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L18_2
          L0_4.BackgroundTransparency = 0
          L0_4 = L22_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L27_2
          L0_4.BackgroundTransparency = 1
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L151_2 = coroutine
      L152_2 = "wrap"
      L151_2 = L151_2[L152_2]
      L152_2 = L150_2
      L151_2 = L151_2(L152_2)
      L151_2()
      
      function L151_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L22_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L22_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L33_2
          L0_4.Visible = false
          L0_4 = L69_2
          L0_4.Visible = false
          L0_4 = L104_2
          L0_4.Visible = true
          L0_4 = L82_2
          L0_4.Visible = false
          L0_4 = L14_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L18_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L22_2
          L0_4.BackgroundTransparency = 0
          L0_4 = L27_2
          L0_4.BackgroundTransparency = 1
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L152_2 = coroutine
      L153_2 = "wrap"
      L152_2 = L152_2[L153_2]
      L153_2 = L151_2
      L152_2 = L152_2(L153_2)
      L152_2()
      
      function L152_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L27_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L27_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L33_2
          L0_4.Visible = false
          L0_4 = L69_2
          L0_4.Visible = false
          L0_4 = L104_2
          L0_4.Visible = false
          L0_4 = L82_2
          L0_4.Visible = true
          L0_4 = L14_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L18_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L22_2
          L0_4.BackgroundTransparency = 1
          L0_4 = L27_2
          L0_4.BackgroundTransparency = 0
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L153_2 = coroutine
      L154_2 = "wrap"
      L153_2 = L153_2[L154_2]
      L154_2 = L152_2
      L153_2 = L153_2(L154_2)
      L153_2()
      
      function L153_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L37_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L37_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L43_2
          L0_4.Visible = false
          L0_4 = L53_2
          L0_4.Visible = true
          L0_4 = L42_2
          L0_4.Visible = false
          L0_4 = L39_2
          L0_4.Visible = true
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L154_2 = coroutine
      L155_2 = "wrap"
      L154_2 = L154_2[L155_2]
      L155_2 = L153_2
      L154_2 = L154_2(L155_2)
      L154_2()
      
      function L154_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L40_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L40_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L43_2
          L0_4.Visible = true
          L0_4 = L53_2
          L0_4.Visible = false
          L0_4 = L42_2
          L0_4.Visible = true
          L0_4 = L39_2
          L0_4.Visible = false
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L155_2 = coroutine
      L156_2 = "wrap"
      L155_2 = L155_2[L156_2]
      L156_2 = L154_2
      L155_2 = L155_2(L156_2)
      L155_2()
      
      function L155_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L45_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = false
            toggle = L0_4
          else
            L0_4 = true
            toggle = L0_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = 16
            L1_4 = game
            L2_4 = L1_4
            L1_4 = L1_4.GetService
            L3_4 = "Players"
            L1_4 = L1_4(L2_4, L3_4)
            L1_4 = L1_4.LocalPlayer
            
            function L2_4()
              local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5
              L1_5 = 99999
              L2_5 = pairs
              L3_5 = game
              L3_5 = L3_5.Workspace
              L3_5 = L3_5.BossFolder
              L4_5 = L3_5
              L3_5 = L3_5.GetChildren
              L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5 = L3_5(L4_5)
              L2_5, L3_5, L4_5 = L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5)
              for L5_5, L6_5 in L2_5, L3_5, L4_5 do
                L8_5 = L6_5
                L7_5 = L6_5.FindFirstChild
                L9_5 = "Head"
                L7_5 = L7_5(L8_5, L9_5)
                if L7_5 ~= nil then
                  L7_5 = L1_4
                  L7_5 = L7_5.Character
                  L7_5 = L7_5.Head
                  L7_5 = L7_5.Position
                  L8_5 = L6_5.Head
                  L8_5 = L8_5.Position
                  L7_5 = L7_5 - L8_5
                  L7_5 = L7_5.magnitude
                  if L1_5 > L7_5 then
                    L1_5 = L7_5
                    L0_5 = L6_5
                  end
                end
              end
              L2_5 = pairs
              L3_5 = game
              L3_5 = L3_5.Workspace
              L3_5 = L3_5.enemies
              L4_5 = L3_5
              L3_5 = L3_5.GetChildren
              L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5 = L3_5(L4_5)
              L2_5, L3_5, L4_5 = L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5)
              for L5_5, L6_5 in L2_5, L3_5, L4_5 do
                L8_5 = L6_5
                L7_5 = L6_5.FindFirstChild
                L9_5 = "Head"
                L7_5 = L7_5(L8_5, L9_5)
                if L7_5 ~= nil then
                  L7_5 = L1_4
                  L7_5 = L7_5.Character
                  L7_5 = L7_5.Head
                  L7_5 = L7_5.Position
                  L8_5 = L6_5.Head
                  L8_5 = L8_5.Position
                  L7_5 = L7_5 - L8_5
                  L7_5 = L7_5.magnitude
                  if L1_5 > L7_5 then
                    L1_5 = L7_5
                    L0_5 = L6_5
                  end
                end
              end
            end
            
            L3_4 = _G
            L3_4.farm2 = true
            L3_4 = L1_4.Chatted
            L4_4 = L3_4
            L3_4 = L3_4.Connect
            
            function L5_4(A0_5)
              local L1_5, L2_5
              if A0_5 == ";autofarm false" then
                L1_5 = _G
                L1_5.farm2 = false
              elseif A0_5 == ";autofarm true" then
                L1_5 = _G
                L1_5.farm2 = true
              end
            end
            
            L3_4(L4_4, L5_4)
            L3_4 = _G
            L3_4.globalTarget = nil
            L3_4 = game
            L4_4 = L3_4
            L3_4 = L3_4.GetService
            L5_4 = "RunService"
            L3_4 = L3_4(L4_4, L5_4)
            L3_4 = L3_4.RenderStepped
            L4_4 = L3_4
            L3_4 = L3_4.Connect
            
            function L5_4()
              local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
              L0_5 = _G
              L0_5 = L0_5.farm2
              if L0_5 == true then
                L0_5 = L2_4
                L0_5 = L0_5()
                if L0_5 ~= nil then
                  L1_5 = game
                  L2_5 = L1_5
                  L1_5 = L1_5.GetService
                  L3_5 = "Workspace"
                  L1_5 = L1_5(L2_5, L3_5)
                  L1_5 = L1_5.CurrentCamera
                  L2_5 = CFrame
                  L2_5 = L2_5.new
                  L3_5 = game
                  L4_5 = L3_5
                  L3_5 = L3_5.GetService
                  L5_5 = "Workspace"
                  L3_5 = L3_5(L4_5, L5_5)
                  L3_5 = L3_5.CurrentCamera
                  L3_5 = L3_5.CFrame
                  L3_5 = L3_5.p
                  L4_5 = L0_5.Head
                  L4_5 = L4_5.Position
                  L2_5 = L2_5(L3_5, L4_5)
                  L1_5.CFrame = L2_5
                  L1_5 = L1_4
                  L1_5 = L1_5.Character
                  L1_5 = L1_5.HumanoidRootPart
                  L2_5 = L0_5.HumanoidRootPart
                  L2_5 = L2_5.CFrame
                  L3_5 = CFrame
                  L3_5 = L3_5.new
                  L4_5 = 0
                  L5_5 = L0_4
                  L6_5 = 16
                  L3_5 = L3_5(L4_5, L5_5, L6_5)
                  L2_5 = L2_5 * L3_5
                  L1_5.CFrame = L2_5
                  L1_5 = _G
                  L1_5.globalTarget = L0_5
                end
              end
            end
            
            L3_4(L4_4, L5_4)
            L3_4 = spawn
            
            function L4_4()
              local L0_5
              while true do
                L0_5 = wait
                L0_5 = L0_5()
                if not L0_5 then
                  break
                end
              end
            end
            
            L3_4(L4_4)
            while true do
              L3_4 = wait
              L3_4 = L3_4()
              if not L3_4 then
                break
              end
              L3_4 = _G
              L3_4 = L3_4.farm2
              if L3_4 == true then
                L3_4 = _G
                L3_4 = L3_4.globalTarget
                if L3_4 ~= nil then
                  L3_4 = _G
                  L3_4 = L3_4.globalTarget
                  L4_4 = L3_4
                  L3_4 = L3_4.FindFirstChild
                  L5_4 = "Head"
                  L3_4 = L3_4(L4_4, L5_4)
                  if L3_4 then
                    L3_4 = L1_4.Character
                    L4_4 = L3_4
                    L3_4 = L3_4.FindFirstChildOfClass
                    L5_4 = "Tool"
                    L3_4 = L3_4(L4_4, L5_4)
                    if L3_4 then
                      L3_4 = _G
                      L3_4 = L3_4.globalTarget
                      L4_4 = game
                      L4_4 = L4_4.ReplicatedStorage
                      L4_4 = L4_4.Gun
                      L5_4 = L4_4
                      L4_4 = L4_4.FireServer
                      L6_4 = {}
                      L7_4 = Vector3
                      L7_4 = L7_4.new
                      L8_4 = 0
                      L9_4 = 0
                      L10_4 = 0
                      L7_4 = L7_4(L8_4, L9_4, L10_4)
                      L6_4.Normal = L7_4
                      L7_4 = L3_4.Head
                      L7_4 = L7_4.Position
                      L6_4.Direction = L7_4
                      L7_4 = L1_4.Character
                      L8_4 = L7_4
                      L7_4 = L7_4.FindFirstChildOfClass
                      L9_4 = "Tool"
                      L7_4 = L7_4(L8_4, L9_4)
                      L7_4 = L7_4.Name
                      L6_4.Name = L7_4
                      L7_4 = L3_4.Head
                      L6_4.Hit = L7_4
                      L7_4 = L3_4.Head
                      L7_4 = L7_4.Position
                      L6_4.Origin = L7_4
                      L7_4 = L3_4.Head
                      L7_4 = L7_4.Position
                      L6_4.Pos = L7_4
                      L4_4(L5_4, L6_4)
                      L4_4 = wait
                      L4_4()
                    end
                  end
                end
              end
            end
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = 16
            L1_4 = game
            L2_4 = L1_4
            L1_4 = L1_4.GetService
            L3_4 = "Players"
            L1_4 = L1_4(L2_4, L3_4)
            L1_4 = L1_4.LocalPlayer
            
            function L2_4()
              local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5
              L1_5 = 99999
              L2_5 = pairs
              L3_5 = game
              L3_5 = L3_5.Workspace
              L3_5 = L3_5.BossFolder
              L4_5 = L3_5
              L3_5 = L3_5.GetChildren
              L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5 = L3_5(L4_5)
              L2_5, L3_5, L4_5 = L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5)
              for L5_5, L6_5 in L2_5, L3_5, L4_5 do
                L8_5 = L6_5
                L7_5 = L6_5.FindFirstChild
                L9_5 = "Head"
                L7_5 = L7_5(L8_5, L9_5)
                if L7_5 ~= nil then
                  L7_5 = L1_4
                  L7_5 = L7_5.Character
                  L7_5 = L7_5.Head
                  L7_5 = L7_5.Position
                  L8_5 = L6_5.Head
                  L8_5 = L8_5.Position
                  L7_5 = L7_5 - L8_5
                  L7_5 = L7_5.magnitude
                  if L1_5 > L7_5 then
                    L1_5 = L7_5
                    L0_5 = L6_5
                  end
                end
              end
              L2_5 = pairs
              L3_5 = game
              L3_5 = L3_5.Workspace
              L3_5 = L3_5.enemies
              L4_5 = L3_5
              L3_5 = L3_5.GetChildren
              L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5 = L3_5(L4_5)
              L2_5, L3_5, L4_5 = L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5)
              for L5_5, L6_5 in L2_5, L3_5, L4_5 do
                L8_5 = L6_5
                L7_5 = L6_5.FindFirstChild
                L9_5 = "Head"
                L7_5 = L7_5(L8_5, L9_5)
                if L7_5 ~= nil then
                  L7_5 = L1_4
                  L7_5 = L7_5.Character
                  L7_5 = L7_5.Head
                  L7_5 = L7_5.Position
                  L8_5 = L6_5.Head
                  L8_5 = L8_5.Position
                  L7_5 = L7_5 - L8_5
                  L7_5 = L7_5.magnitude
                  if L1_5 > L7_5 then
                    L1_5 = L7_5
                    L0_5 = L6_5
                  end
                end
              end
            end
            
            L3_4 = _G
            L3_4.farm2 = false
            L3_4 = L1_4.Chatted
            L4_4 = L3_4
            L3_4 = L3_4.Connect
            
            function L5_4(A0_5)
              local L1_5, L2_5
              if A0_5 == ";autofarm false" then
                L1_5 = _G
                L1_5.farm2 = false
              elseif A0_5 == ";autofarm true" then
                L1_5 = _G
                L1_5.farm2 = true
              end
            end
            
            L3_4(L4_4, L5_4)
            L3_4 = _G
            L3_4.globalTarget = nil
            L3_4 = game
            L4_4 = L3_4
            L3_4 = L3_4.GetService
            L5_4 = "RunService"
            L3_4 = L3_4(L4_4, L5_4)
            L3_4 = L3_4.RenderStepped
            L4_4 = L3_4
            L3_4 = L3_4.Connect
            
            function L5_4()
              local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
              L0_5 = _G
              L0_5 = L0_5.farm2
              if L0_5 == true then
                L0_5 = L2_4
                L0_5 = L0_5()
                if L0_5 ~= nil then
                  L1_5 = game
                  L2_5 = L1_5
                  L1_5 = L1_5.GetService
                  L3_5 = "Workspace"
                  L1_5 = L1_5(L2_5, L3_5)
                  L1_5 = L1_5.CurrentCamera
                  L2_5 = CFrame
                  L2_5 = L2_5.new
                  L3_5 = game
                  L4_5 = L3_5
                  L3_5 = L3_5.GetService
                  L5_5 = "Workspace"
                  L3_5 = L3_5(L4_5, L5_5)
                  L3_5 = L3_5.CurrentCamera
                  L3_5 = L3_5.CFrame
                  L3_5 = L3_5.p
                  L4_5 = L0_5.Head
                  L4_5 = L4_5.Position
                  L2_5 = L2_5(L3_5, L4_5)
                  L1_5.CFrame = L2_5
                  L1_5 = L1_4
                  L1_5 = L1_5.Character
                  L1_5 = L1_5.HumanoidRootPart
                  L2_5 = L0_5.HumanoidRootPart
                  L2_5 = L2_5.CFrame
                  L3_5 = CFrame
                  L3_5 = L3_5.new
                  L4_5 = 0
                  L5_5 = L0_4
                  L6_5 = 16
                  L3_5 = L3_5(L4_5, L5_5, L6_5)
                  L2_5 = L2_5 * L3_5
                  L1_5.CFrame = L2_5
                  L1_5 = _G
                  L1_5.globalTarget = L0_5
                end
              end
            end
            
            L3_4(L4_4, L5_4)
            L3_4 = spawn
            
            function L4_4()
              local L0_5
              repeat
                L0_5 = wait
                L0_5 = L0_5()
              until not L0_5
            end
            
            L3_4(L4_4)
            while true do
              L3_4 = wait
              L3_4 = L3_4()
              if not L3_4 then
                break
              end
              L3_4 = _G
              L3_4 = L3_4.farm2
              if L3_4 == true then
                L3_4 = _G
                L3_4 = L3_4.globalTarget
                if L3_4 ~= nil then
                  L3_4 = _G
                  L3_4 = L3_4.globalTarget
                  L4_4 = L3_4
                  L3_4 = L3_4.FindFirstChild
                  L5_4 = "Head"
                  L3_4 = L3_4(L4_4, L5_4)
                  if L3_4 then
                    L3_4 = L1_4.Character
                    L4_4 = L3_4
                    L3_4 = L3_4.FindFirstChildOfClass
                    L5_4 = "Tool"
                    L3_4 = L3_4(L4_4, L5_4)
                    if L3_4 then
                      L3_4 = _G
                      L3_4 = L3_4.globalTarget
                      L4_4 = game
                      L4_4 = L4_4.ReplicatedStorage
                      L4_4 = L4_4.Gun
                      L5_4 = L4_4
                      L4_4 = L4_4.FireServer
                      L6_4 = {}
                      L7_4 = Vector3
                      L7_4 = L7_4.new
                      L8_4 = 0
                      L9_4 = 0
                      L10_4 = 0
                      L7_4 = L7_4(L8_4, L9_4, L10_4)
                      L6_4.Normal = L7_4
                      L7_4 = L3_4.Head
                      L7_4 = L7_4.Position
                      L6_4.Direction = L7_4
                      L7_4 = L1_4.Character
                      L8_4 = L7_4
                      L7_4 = L7_4.FindFirstChildOfClass
                      L9_4 = "Tool"
                      L7_4 = L7_4(L8_4, L9_4)
                      L7_4 = L7_4.Name
                      L6_4.Name = L7_4
                      L7_4 = L3_4.Head
                      L6_4.Hit = L7_4
                      L7_4 = L3_4.Head
                      L7_4 = L7_4.Position
                      L6_4.Origin = L7_4
                      L7_4 = L3_4.Head
                      L7_4 = L7_4.Position
                      L6_4.Pos = L7_4
                      L4_4(L5_4, L6_4)
                      L4_4 = wait
                      L4_4()
                    end
                  end
                end
              end
            end
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L156_2 = coroutine
      L157_2 = "wrap"
      L156_2 = L156_2[L157_2]
      L157_2 = L155_2
      L156_2 = L156_2(L157_2)
      L156_2()
      
      function L156_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L50_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = false
            toggle = L0_4
          else
            L0_4 = true
            toggle = L0_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = _G
            L0_4.Bighead = true
            L0_4 = 5
            Size_of_head = L0_4
            while true do
              L0_4 = _G
              L0_4 = L0_4.Bighead
              if not L0_4 then
                break
              end
              L0_4 = wait
              L1_4 = 0.3
              L0_4(L1_4)
              L0_4 = game
              L0_4 = L0_4.Workspace
              L0_4 = L0_4.enemies
              L1_4 = L0_4
              L0_4 = L0_4.FindFirstChild
              L2_4 = "Zombie"
              L0_4 = L0_4(L1_4, L2_4)
              if L0_4 then
                L0_4 = pairs
                L1_4 = game
                L1_4 = L1_4.Workspace
                L1_4 = L1_4.enemies
                L2_4 = L1_4
                L1_4 = L1_4.GetChildren
                L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4 = L1_4(L2_4)
                L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4)
                for L3_4, L4_4 in L0_4, L1_4, L2_4 do
                  L5_4 = wait
                  L5_4()
                  L6_4 = L4_4
                  L5_4 = L4_4.FindFirstChild
                  L7_4 = "Head"
                  L5_4 = L5_4(L6_4, L7_4)
                  if L5_4 then
                    L5_4 = L4_4.Head
                    L5_4.CanCollide = false
                    L5_4 = L4_4.Head
                    L6_4 = Vector3
                    L6_4 = L6_4.new
                    L7_4 = Size_of_head
                    L8_4 = Size_of_head
                    L9_4 = Size_of_head
                    L6_4 = L6_4(L7_4, L8_4, L9_4)
                    L5_4.Size = L6_4
                    L5_4 = L4_4.Head
                    L6_4 = L4_4.Torso
                    L6_4 = L6_4.CFrame
                    L7_4 = CFrame
                    L7_4 = L7_4.new
                    L8_4 = 0
                    L9_4 = Size_of_head
                    L9_4 = L9_4 / 2
                    L10_4 = 0
                    L7_4 = L7_4(L8_4, L9_4, L10_4)
                    L6_4 = L6_4 * L7_4
                    L5_4.CFrame = L6_4
                  end
                end
              end
            end
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = _G
            L0_4.Bighead = false
            L0_4 = 1
            Size_of_head = L0_4
            L0_4 = game
            L0_4 = L0_4.Workspace
            L0_4 = L0_4.enemies
            L1_4 = L0_4
            L0_4 = L0_4.FindFirstChild
            L2_4 = "Zombie"
            L0_4 = L0_4(L1_4, L2_4)
            if L0_4 then
              L0_4 = pairs
              L1_4 = game
              L1_4 = L1_4.Workspace
              L1_4 = L1_4.enemies
              L2_4 = L1_4
              L1_4 = L1_4.GetChildren
              L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4 = L1_4(L2_4)
              L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4)
              for L3_4, L4_4 in L0_4, L1_4, L2_4 do
                L6_4 = L4_4
                L5_4 = L4_4.FindFirstChild
                L7_4 = "Head"
                L5_4 = L5_4(L6_4, L7_4)
                if L5_4 then
                  L5_4 = L4_4.Head
                  L5_4.CanCollide = false
                  L5_4 = L4_4.Head
                  L6_4 = Vector3
                  L6_4 = L6_4.new
                  L7_4 = Size_of_head
                  L8_4 = Size_of_head
                  L9_4 = Size_of_head
                  L6_4 = L6_4(L7_4, L8_4, L9_4)
                  L5_4.Size = L6_4
                  L5_4 = L4_4.Head
                  L6_4 = L4_4.Torso
                  L6_4 = L6_4.CFrame
                  L7_4 = CFrame
                  L7_4 = L7_4.new
                  L8_4 = 0
                  L9_4 = Size_of_head
                  L9_4 = L9_4 / 2
                  L10_4 = 0
                  L7_4 = L7_4(L8_4, L9_4, L10_4)
                  L6_4 = L6_4 * L7_4
                  L5_4.CFrame = L6_4
                end
              end
            end
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L157_2 = coroutine
      L158_2 = "wrap"
      L157_2 = L157_2[L158_2]
      L158_2 = L156_2
      L157_2 = L157_2(L158_2)
      L157_2()
      
      function L157_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L55_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L49_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
          L0_4 = 4
          Size_of_head = L0_4
          while true do
            L0_4 = wait
            L0_4 = L0_4()
            if not L0_4 then
              break
            end
            L0_4 = game
            L0_4 = L0_4.Workspace
            L0_4 = L0_4.enemies
            L1_4 = L0_4
            L0_4 = L0_4.FindFirstChild
            L2_4 = "Zombie"
            L0_4 = L0_4(L1_4, L2_4)
            if L0_4 then
              L0_4 = pairs
              L1_4 = game
              L1_4 = L1_4.Workspace
              L1_4 = L1_4.enemies
              L2_4 = L1_4
              L1_4 = L1_4.GetChildren
              L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4 = L1_4(L2_4)
              L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4)
              for L3_4, L4_4 in L0_4, L1_4, L2_4 do
                L5_4 = wait
                L5_4()
                L6_4 = L4_4
                L5_4 = L4_4.FindFirstChild
                L7_4 = "Head"
                L5_4 = L5_4(L6_4, L7_4)
                if L5_4 then
                  L5_4 = L4_4.Head
                  L5_4.CanCollide = false
                  L5_4 = L4_4.Head
                  L6_4 = Vector3
                  L6_4 = L6_4.new
                  L7_4 = Size_of_head
                  L8_4 = Size_of_head
                  L9_4 = Size_of_head
                  L6_4 = L6_4(L7_4, L8_4, L9_4)
                  L5_4.Size = L6_4
                  L5_4 = L4_4.Head
                  L6_4 = L4_4.Torso
                  L6_4 = L6_4.CFrame
                  L7_4 = CFrame
                  L7_4 = L7_4.new
                  L8_4 = 0
                  L9_4 = Size_of_head
                  L9_4 = L9_4 / 2
                  L10_4 = 0
                  L7_4 = L7_4(L8_4, L9_4, L10_4)
                  L6_4 = L6_4 * L7_4
                  L5_4.CFrame = L6_4
                end
              end
            end
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L158_2 = coroutine
      L159_2 = "wrap"
      L158_2 = L158_2[L159_2]
      L159_2 = L157_2
      L158_2 = L158_2(L159_2)
      L158_2()
      
      function L158_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L56_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = L0_3
          L0_4 = L0_4.Parent
          L0_4 = L0_4.BackgroundColor3
          L1_4 = Color3
          L1_4 = L1_4.fromRGB
          L2_4 = 29
          L3_4 = 40
          L4_4 = 58
          L1_4 = L1_4(L2_4, L3_4, L4_4)
          if L0_4 == L1_4 then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          else
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L159_2 = coroutine
      L160_2 = "wrap"
      L159_2 = L159_2[L160_2]
      L160_2 = L158_2
      L159_2 = L159_2(L160_2)
      L159_2()
      
      function L159_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L56_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = game
        L1_3 = L1_3.Workspace
        L2_3 = L1_3
        L1_3 = L1_3.FindFirstChild
        L3_3 = "enemies"
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = false
          L2_3 = workspace
          L2_3 = L2_3.enemies
          L3_3 = game
          L4_3 = L3_3
          L3_3 = L3_3.GetService
          L5_3 = "Players"
          L3_3 = L3_3(L4_3, L5_3)
          L4_3 = L3_3.LocalPlayer
          L6_3 = L4_3
          L5_3 = L4_3.GetMouse
          L5_3 = L5_3(L6_3)
          L6_3 = game
          L7_3 = L6_3
          L6_3 = L6_3.GetService
          L8_3 = "RunService"
          L6_3 = L6_3(L7_3, L8_3)
          L7_3 = game
          L8_3 = L7_3
          L7_3 = L7_3.GetService
          L9_3 = "TweenService"
          L7_3 = L7_3(L8_3, L9_3)
          L8_3 = TweenInfo
          L8_3 = L8_3.new
          L9_3 = 0.4
          L10_3 = Enum
          L10_3 = L10_3.EasingStyle
          L10_3 = L10_3.Linear
          L11_3 = Enum
          L11_3 = L11_3.EasingDirection
          L11_3 = L11_3.InOut
          L8_3 = L8_3(L9_3, L10_3, L11_3)
          
          function L9_3()
            local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
            L0_4 = math
            L0_4 = L0_4.huge
            L1_4 = nil
            L2_4 = pairs
            L3_4 = L2_3
            L4_4 = L3_4
            L3_4 = L3_4.GetChildren
            L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4 = L3_4(L4_4)
            L2_4, L3_4, L4_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
            for L5_4, L6_4 in L2_4, L3_4, L4_4 do
              L8_4 = L6_4
              L7_4 = L6_4.FindFirstChild
              L9_4 = "Head"
              L7_4 = L7_4(L8_4, L9_4)
              if L7_4 then
                L8_4 = L6_4
                L7_4 = L6_4.FindFirstChildOfClass
                L9_4 = "Humanoid"
                L7_4 = L7_4(L8_4, L9_4)
                if not L7_4 then
                else
                  L7_4 = L6_4.Humanoid
                  L7_4 = L7_4.Health
                  if L7_4 <= 0 then
                  else
                    L7_4 = workspace
                    L7_4 = L7_4.CurrentCamera
                    L8_4 = L7_4
                    L7_4 = L7_4.WorldToViewportPoint
                    L9_4 = L6_4.Head
                    L9_4 = L9_4.Position
                    L7_4, L8_4 = L7_4(L8_4, L9_4)
                    if L8_4 then
                      L9_4 = Vector2
                      L9_4 = L9_4.new
                      L10_4 = L5_3
                      L10_4 = L10_4.X
                      L11_4 = L5_3
                      L11_4 = L11_4.Y
                      L9_4 = L9_4(L10_4, L11_4)
                      L10_4 = Vector2
                      L10_4 = L10_4.new
                      L11_4 = L7_4.X
                      L12_4 = L7_4.Y
                      L10_4 = L10_4(L11_4, L12_4)
                      L9_4 = L9_4 - L10_4
                      L9_4 = L9_4.Magnitude
                      if L0_4 > L9_4 then
                        L1_4 = L6_4
                        L0_4 = L9_4
                      end
                    end
                  end
                end
              end
            end
            L2_4 = L0_3
            L2_4 = L2_4.Parent
            L2_4 = L2_4.BackgroundColor3
            L3_4 = Color3
            L3_4 = L3_4.fromRGB
            L4_4 = 29
            L5_4 = 40
            L6_4 = 58
            L3_4 = L3_4(L4_4, L5_4, L6_4)
            if L2_4 == L3_4 then
              L1_4 = nil
            end
          end
          
          L10_3 = L9_3
          L10_3 = L10_3()
          L11_3 = L6_3.Stepped
          L12_3 = L11_3
          L11_3 = L11_3.Connect
          
          function L13_3(A0_4, A1_4)
            local L2_4
            L2_4 = L9_3
            L2_4 = L2_4()
            L10_3 = L2_4
          end
          
          L11_3(L12_3, L13_3)
          
          function L11_3(A0_4)
            local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4
            L1_4 = Instance
            L1_4 = L1_4.new
            L2_4 = "Highlight"
            L1_4 = L1_4(L2_4)
            L1_4.Adornee = A0_4
            L2_4 = Color3
            L2_4 = L2_4.fromRGB
            L3_4 = 5
            L4_4 = 149
            L5_4 = 216
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L1_4.FillColor = L2_4
            L1_4.FillTransparency = 0.2
            L2_4 = Color3
            L2_4 = L2_4.fromRGB
            L3_4 = 5
            L4_4 = 149
            L5_4 = 216
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L1_4.OutlineColor = L2_4
            L1_4.OutlineTransparency = 0.2
            L2_4 = Enum
            L2_4 = L2_4.HighlightDepthMode
            L2_4 = L2_4.AlwaysOnTop
            L1_4.DepthMode = L2_4
            L1_4.Parent = A0_4
            L2_4 = L7_3
            L3_4 = L2_4
            L2_4 = L2_4.Create
            L4_4 = L1_4
            L5_4 = L8_3
            L6_4 = {}
            L6_4.FillTransparency = 1
            L6_4.OutlineTransparency = 0.8
            L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
            L3_4 = L2_4.Completed
            L4_4 = L3_4
            L3_4 = L3_4.Connect
            
            function L5_4()
              local L0_5, L1_5
              L0_5 = L1_4
              L1_5 = L0_5
              L0_5 = L0_5.Destroy
              L0_5(L1_5)
            end
            
            L3_4(L4_4, L5_4)
            L4_4 = L2_4
            L3_4 = L2_4.Play
            L3_4(L4_4)
          end
          
          L12_3 = nil
          L13_3 = hookmetamethod
          L14_3 = game
          L15_3 = "__index"
          
          function L16_3(A0_4, A1_4)
            local L2_4, L3_4, L4_4
            L2_4 = checkcaller
            L2_4 = L2_4()
            if not L2_4 then
              L2_4 = L5_3
              if A0_4 == L2_4 and A1_4 == "Hit" then
                L2_4 = L10_3
                if L2_4 then
                  L2_4 = task
                  L2_4 = L2_4.spawn
                  L3_4 = L11_3
                  L4_4 = L10_3
                  L2_4(L3_4, L4_4)
                  L2_4 = L10_3
                  L2_4 = L2_4.Head
                  L2_4 = L2_4.CFrame
                  return L2_4
                end
              end
            end
            L2_4 = L12_3
            L3_4 = A0_4
            L4_4 = A1_4
          end
          
          L13_3 = L13_3(L14_3, L15_3, L16_3)
          L12_3 = L13_3
        end
      end
      
      L160_2 = coroutine
      L161_2 = "wrap"
      L160_2 = L160_2[L161_2]
      L161_2 = L159_2
      L160_2 = L160_2(L161_2)
      L160_2()
      
      function L160_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L60_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = game
        L1_3 = L1_3.Workspace
        L2_3 = L1_3
        L1_3 = L1_3.FindFirstChild
        L3_3 = "enemies"
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = false
          L2_3 = workspace
          L2_3 = L2_3.BossFolder
          L3_3 = game
          L4_3 = L3_3
          L3_3 = L3_3.GetService
          L5_3 = "Players"
          L3_3 = L3_3(L4_3, L5_3)
          L4_3 = L3_3.LocalPlayer
          L6_3 = L4_3
          L5_3 = L4_3.GetMouse
          L5_3 = L5_3(L6_3)
          L6_3 = game
          L7_3 = L6_3
          L6_3 = L6_3.GetService
          L8_3 = "RunService"
          L6_3 = L6_3(L7_3, L8_3)
          L7_3 = game
          L8_3 = L7_3
          L7_3 = L7_3.GetService
          L9_3 = "TweenService"
          L7_3 = L7_3(L8_3, L9_3)
          L8_3 = TweenInfo
          L8_3 = L8_3.new
          L9_3 = 0.4
          L10_3 = Enum
          L10_3 = L10_3.EasingStyle
          L10_3 = L10_3.Linear
          L11_3 = Enum
          L11_3 = L11_3.EasingDirection
          L11_3 = L11_3.InOut
          L8_3 = L8_3(L9_3, L10_3, L11_3)
          
          function L9_3()
            local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
            L0_4 = math
            L0_4 = L0_4.huge
            L1_4 = nil
            L2_4 = pairs
            L3_4 = L2_3
            L4_4 = L3_4
            L3_4 = L3_4.GetChildren
            L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4 = L3_4(L4_4)
            L2_4, L3_4, L4_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
            for L5_4, L6_4 in L2_4, L3_4, L4_4 do
              L8_4 = L6_4
              L7_4 = L6_4.FindFirstChild
              L9_4 = "Head"
              L7_4 = L7_4(L8_4, L9_4)
              if not L7_4 then
              else
                L8_4 = L6_4
                L7_4 = L6_4.FindFirstChildOfClass
                L9_4 = "Humanoid"
                L7_4 = L7_4(L8_4, L9_4)
                if not L7_4 then
                else
                  L7_4 = L6_4.Humanoid
                  L7_4 = L7_4.Health
                  if L7_4 <= 0 then
                  else
                    L7_4 = workspace
                    L7_4 = L7_4.CurrentCamera
                    L8_4 = L7_4
                    L7_4 = L7_4.WorldToViewportPoint
                    L9_4 = L6_4.Head
                    L9_4 = L9_4.Position
                    L7_4, L8_4 = L7_4(L8_4, L9_4)
                    if L8_4 then
                      L9_4 = Vector2
                      L9_4 = L9_4.new
                      L10_4 = L5_3
                      L10_4 = L10_4.X
                      L11_4 = L5_3
                      L11_4 = L11_4.Y
                      L9_4 = L9_4(L10_4, L11_4)
                      L10_4 = Vector2
                      L10_4 = L10_4.new
                      L11_4 = L7_4.X
                      L12_4 = L7_4.Y
                      L10_4 = L10_4(L11_4, L12_4)
                      L9_4 = L9_4 - L10_4
                      L9_4 = L9_4.Magnitude
                      if L0_4 > L9_4 then
                        L1_4 = L6_4
                        L0_4 = L9_4
                      end
                    end
                  end
                end
              end
            end
            L2_4 = L0_3
            L2_4 = L2_4.Parent
            L2_4 = L2_4.BackgroundColor3
            L3_4 = Color3
            L3_4 = L3_4.fromRGB
            L4_4 = 29
            L5_4 = 40
            L6_4 = 58
            L3_4 = L3_4(L4_4, L5_4, L6_4)
            if L2_4 == L3_4 then
              L1_4 = nil
            end
          end
          
          L10_3 = L9_3
          L10_3 = L10_3()
          L11_3 = L6_3.Stepped
          L12_3 = L11_3
          L11_3 = L11_3.Connect
          
          function L13_3(A0_4, A1_4)
            local L2_4
            L2_4 = L9_3
            L2_4 = L2_4()
            L10_3 = L2_4
          end
          
          L11_3(L12_3, L13_3)
          
          function L11_3(A0_4)
            local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4
            L1_4 = Instance
            L1_4 = L1_4.new
            L2_4 = "Highlight"
            L1_4 = L1_4(L2_4)
            L1_4.Adornee = A0_4
            L2_4 = Color3
            L2_4 = L2_4.fromRGB
            L3_4 = 5
            L4_4 = 149
            L5_4 = 216
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L1_4.FillColor = L2_4
            L1_4.FillTransparency = 0.2
            L2_4 = Color3
            L2_4 = L2_4.fromRGB
            L3_4 = 5
            L4_4 = 149
            L5_4 = 216
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L1_4.OutlineColor = L2_4
            L1_4.OutlineTransparency = 0.2
            L2_4 = Enum
            L2_4 = L2_4.HighlightDepthMode
            L2_4 = L2_4.AlwaysOnTop
            L1_4.DepthMode = L2_4
            L1_4.Parent = A0_4
            L2_4 = L7_3
            L3_4 = L2_4
            L2_4 = L2_4.Create
            L4_4 = L1_4
            L5_4 = L8_3
            L6_4 = {}
            L6_4.FillTransparency = 1
            L6_4.OutlineTransparency = 0.8
            L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
            L3_4 = L2_4.Completed
            L4_4 = L3_4
            L3_4 = L3_4.Connect
            
            function L5_4()
              local L0_5, L1_5
              L0_5 = L1_4
              L1_5 = L0_5
              L0_5 = L0_5.Destroy
              L0_5(L1_5)
            end
            
            L3_4(L4_4, L5_4)
            L4_4 = L2_4
            L3_4 = L2_4.Play
            L3_4(L4_4)
          end
          
          L12_3 = nil
          L13_3 = hookmetamethod
          L14_3 = game
          L15_3 = "__index"
          
          function L16_3(A0_4, A1_4)
            local L2_4, L3_4, L4_4
            L2_4 = checkcaller
            L2_4 = L2_4()
            if not L2_4 then
              L2_4 = L5_3
              if A0_4 == L2_4 and A1_4 == "Hit" then
                L2_4 = L10_3
                if L2_4 then
                  L2_4 = task
                  L2_4 = L2_4.spawn
                  L3_4 = L11_3
                  L4_4 = L10_3
                  L2_4(L3_4, L4_4)
                  L2_4 = L10_3
                  L2_4 = L2_4.Head
                  L2_4 = L2_4.CFrame
                  return L2_4
                end
              end
            end
            L2_4 = L12_3
            L3_4 = A0_4
            L4_4 = A1_4
          end
          
          L13_3 = L13_3(L14_3, L15_3, L16_3)
          L12_3 = L13_3
        end
      end
      
      L161_2 = coroutine
      L162_2 = "wrap"
      L161_2 = L161_2[L162_2]
      L162_2 = L160_2
      L161_2 = L161_2(L162_2)
      L161_2()
      
      function L161_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L60_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = L0_3
          L0_4 = L0_4.Parent
          L0_4 = L0_4.BackgroundColor3
          L1_4 = Color3
          L1_4 = L1_4.fromRGB
          L2_4 = 29
          L3_4 = 40
          L4_4 = 58
          L1_4 = L1_4(L2_4, L3_4, L4_4)
          if L0_4 == L1_4 then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          else
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L162_2 = coroutine
      L163_2 = "wrap"
      L162_2 = L162_2[L163_2]
      L163_2 = L161_2
      L162_2 = L162_2(L163_2)
      L162_2()
      
      function L162_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L64_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = false
            toggle = L0_4
          else
            L0_4 = true
            toggle = L0_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = _G
            L0_4.equip = true
            while true do
              L0_4 = _G
              L0_4 = L0_4.equip
              if not L0_4 then
                break
              end
              L0_4 = wait
              L0_4()
              L0_4 = pairs
              L1_4 = game
              L1_4 = L1_4.Players
              L1_4 = L1_4.LocalPlayer
              L1_4 = L1_4.Backpack
              L2_4 = L1_4
              L1_4 = L1_4.GetChildren
              L1_4, L2_4, L3_4, L4_4, L5_4, L6_4 = L1_4(L2_4)
              L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4)
              for L3_4, L4_4 in L0_4, L1_4, L2_4 do
                L5_4 = L4_4.Name
                L6_4 = L67_2
                L6_4 = L6_4.Text
                if L5_4 == L6_4 then
                  L5_4 = game
                  L5_4 = L5_4.Players
                  L5_4 = L5_4.LocalPlayer
                  L5_4 = L5_4.Character
                  L4_4.Parent = L5_4
                end
              end
            end
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = _G
            L0_4.equip = false
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L163_2 = coroutine
      L164_2 = "wrap"
      L163_2 = L163_2[L164_2]
      L164_2 = L162_2
      L163_2 = L163_2(L164_2)
      L163_2()
      
      function L163_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L75_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = false
            toggle = L0_4
          else
            L0_4 = true
            toggle = L0_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = _G
            L0_4.AFK = true
            L0_4 = game
            L0_4 = L0_4.Players
            L0_4 = L0_4.LocalPlayer
            L0_4 = L0_4.Idled
            L1_4 = L0_4
            L0_4 = L0_4.Connect
            
            function L2_4()
              local L0_5, L1_5, L2_5, L3_5
              L0_5 = game
              L1_5 = L0_5
              L0_5 = L0_5.GetService
              L2_5 = "VirtualUser"
              L0_5 = L0_5(L1_5, L2_5)
              L2_5 = L0_5
              L1_5 = L0_5.CaptureController
              L1_5(L2_5)
              L2_5 = L0_5
              L1_5 = L0_5.ClickButton2
              L3_5 = Vector2
              L3_5 = L3_5.new
              L3_5 = L3_5()
              L1_5(L2_5, L3_5)
            end
            
            L0_4(L1_4, L2_4)
            L0_4 = toggle
            if L0_4 == false then
              L0_4 = _G
              L0_4.AFK = false
            end
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L164_2 = coroutine
      L165_2 = "wrap"
      L164_2 = L164_2[L165_2]
      L165_2 = L163_2
      L164_2 = L164_2(L165_2)
      L164_2()
      
      function L164_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L79_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = false
            toggle = L0_4
          else
            L0_4 = true
            toggle = L0_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = _G
            L0_4.Powerups = true
            while true do
              L0_4 = _G
              L0_4 = L0_4.Powerups
              if not L0_4 then
                break
              end
              L0_4 = wait
              L1_4 = 0.4
              L0_4(L1_4)
              L0_4 = pairs
              L1_4 = game
              L2_4 = L1_4
              L1_4 = L1_4.GetService
              L3_4 = "Workspace"
              L1_4 = L1_4(L2_4, L3_4)
              L1_4 = L1_4.Powerups
              L2_4 = L1_4
              L1_4 = L1_4.GetDescendants
              L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4 = L1_4(L2_4)
              L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4)
              for L3_4, L4_4 in L0_4, L1_4, L2_4 do
                L5_4 = L4_4.ClassName
                if L5_4 == "TouchTransmitter" then
                  L5_4 = game
                  L5_4 = L5_4.Players
                  L5_4 = L5_4.LocalPlayer
                  L5_4 = L5_4.Character
                  L5_4 = L5_4.Humanoid
                  L5_4 = L5_4.Health
                  if L5_4 ~= 0 then
                    L5_4 = game
                    L5_4 = L5_4.Players
                    L5_4 = L5_4.LocalPlayer
                    L5_4 = L5_4.Character
                    if L5_4 then
                      L5_4 = L4_4.Parent
                      L5_4 = L5_4.Parent
                      L5_4 = L5_4.ClassName
                      if L5_4 == "Model" then
                        L5_4 = firetouchinterest
                        L6_4 = game
                        L6_4 = L6_4.Players
                        L6_4 = L6_4.LocalPlayer
                        L6_4 = L6_4.Character
                        L7_4 = L6_4
                        L6_4 = L6_4.FindFirstChildOfClass
                        L8_4 = "Part"
                        L6_4 = L6_4(L7_4, L8_4)
                        L7_4 = L4_4.Parent
                        L8_4 = 0
                        L5_4(L6_4, L7_4, L8_4)
                        L5_4 = wait
                        L5_4()
                        L5_4 = firetouchinterest
                        L6_4 = game
                        L6_4 = L6_4.Players
                        L6_4 = L6_4.LocalPlayer
                        L6_4 = L6_4.Character
                        L7_4 = L6_4
                        L6_4 = L6_4.FindFirstChildOfClass
                        L8_4 = "Part"
                        L6_4 = L6_4(L7_4, L8_4)
                        L7_4 = L4_4.Parent
                        L8_4 = 1
                        L5_4(L6_4, L7_4, L8_4)
                      end
                    end
                  end
                end
              end
              L0_4 = toggle
              if L0_4 == false then
                L0_4 = _G
                L0_4.Powerups = false
              end
            end
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L165_2 = coroutine
      L166_2 = "wrap"
      L165_2 = L165_2[L166_2]
      L166_2 = L164_2
      L165_2 = L165_2(L166_2)
      L165_2()
      
      function L165_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L87_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = Instance
          L0_4 = L0_4.new
          L1_4 = "HopperBin"
          L2_4 = game
          L3_4 = L2_4
          L2_4 = L2_4.service
          L4_4 = "Players"
          L2_4 = L2_4(L3_4, L4_4)
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Backpack
          L0_4 = L0_4(L1_4, L2_4)
          bin = L0_4
          L0_4 = bin
          L0_4.Name = "Teleport"
          
          function L0_4(A0_5)
            local L1_5, L2_5, L3_5, L4_5, L5_5
            L1_5 = game
            L2_5 = L1_5
            L1_5 = L1_5.service
            L3_5 = "Players"
            L1_5 = L1_5(L2_5, L3_5)
            L1_5 = L1_5.LocalPlayer
            if L1_5 ~= nil then
              L2_5 = L1_5.Character
              if L2_5 ~= nil then
                goto lbl_12
              end
            end
            do return end
            ::lbl_12::
            L2_5 = L1_5.Character
            L4_5 = L2_5
            L3_5 = L2_5.MoveTo
            L5_5 = A0_5
            L3_5(L4_5, L5_5)
          end
          
          teleportPlayer = L0_4
          L0_4 = true
          enabled = L0_4
          
          function L0_4(A0_5)
            local L1_5, L2_5, L3_5, L4_5
            L1_5 = enabled
            if not L1_5 then
              return
            end
            L1_5 = game
            L2_5 = L1_5
            L1_5 = L1_5.service
            L3_5 = "Players"
            L1_5 = L1_5(L2_5, L3_5)
            L1_5 = L1_5.LocalPlayer
            if L1_5 == nil then
              return
            end
            L2_5 = A0_5.Hit
            L3_5 = teleportPlayer
            L4_5 = L2_5.p
            L3_5(L4_5)
          end
          
          onButton1Down = L0_4
          
          function L0_4(A0_5)
            local L1_5, L2_5, L3_5
            L1_5 = A0_5.Button1Down
            L2_5 = L1_5
            L1_5 = L1_5.connect
            
            function L3_5()
              local L0_6, L1_6
              L0_6 = onButton1Down
              L1_6 = A0_5
              L0_6(L1_6)
            end
            
            L1_5(L2_5, L3_5)
          end
          
          onSelected = L0_4
          L0_4 = bin
          L0_4 = L0_4.Selected
          L1_4 = L0_4
          L0_4 = L0_4.connect
          L2_4 = onSelected
          L0_4(L1_4, L2_4)
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L166_2 = coroutine
      L167_2 = "wrap"
      L166_2 = L166_2[L167_2]
      L167_2 = L165_2
      L166_2 = L166_2(L167_2)
      L166_2()
      
      function L166_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L91_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L91_2
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = loadstring
          L1_4 = game
          L2_4 = L1_4
          L1_4 = L1_4.HttpGet
          L3_4 = "https://raw.githubusercontent.com/cool83birdcarfly02six/Credits/main/README.md"
          L4_4 = true
          L1_4, L2_4, L3_4, L4_4 = L1_4(L2_4, L3_4, L4_4)
          L0_4 = L0_4(L1_4, L2_4, L3_4, L4_4)
          L0_4()
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L167_2 = coroutine
      L168_2 = "wrap"
      L167_2 = L167_2[L168_2]
      L168_2 = L166_2
      L167_2 = L167_2(L168_2)
      L167_2()
      
      function L167_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L93_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L93_2
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = setclipboard
          L1_4 = "https://discord.gg/sdCSmXRjuX"
          L0_4(L1_4)
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L168_2 = coroutine
      L169_2 = "wrap"
      L168_2 = L168_2[L169_2]
      L169_2 = L167_2
      L168_2 = L168_2(L169_2)
      L168_2()
      
      function L168_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L95_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L95_2
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = loadstring
          L1_4 = game
          L2_4 = L1_4
          L1_4 = L1_4.HttpGet
          L3_4 = "https://raw.githubusercontent.com/cool83birdcarfly02six/Premium/main/README.md"
          L4_4 = true
          L1_4, L2_4, L3_4, L4_4 = L1_4(L2_4, L3_4, L4_4)
          L0_4 = L0_4(L1_4, L2_4, L3_4, L4_4)
          L0_4()
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L169_2 = coroutine
      L170_2 = "wrap"
      L169_2 = L169_2[L170_2]
      L170_2 = L168_2
      L169_2 = L169_2(L170_2)
      L169_2()
      
      function L169_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L99_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = game
        L1_3 = L1_3.Players
        L1_3 = L1_3.LocalPlayer
        L3_3 = L1_3
        L2_3 = L1_3.GetMouse
        L2_3 = L2_3(L3_3)
        L3_3 = L0_3.Parent
        L4_3 = L3_3
        L3_3 = L3_3.WaitForChild
        L5_3 = "RGB"
        L3_3 = L3_3(L4_3, L5_3)
        L4_3 = L0_3.Parent
        L5_3 = L4_3
        L4_3 = L4_3.WaitForChild
        L6_3 = "Preview"
        L4_3 = L4_3(L5_3, L6_3)
        L5_3 = Color3
        L5_3 = L5_3.fromHSV
        L6_3 = 1
        L7_3 = 1
        L8_3 = 1
        L5_3 = L5_3(L6_3, L7_3, L8_3)
        L6_3 = {}
        L7_3 = 1
        L8_3 = 1
        L9_3 = 1
        L6_3[1] = L7_3
        L6_3[2] = L8_3
        L6_3[3] = L9_3
        L7_3 = false
        
        function L8_3(A0_4, A1_4, A2_4)
          local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
          L3_4 = L0_3
          L3_4 = L3_4.Parent
          L3_4 = L3_4.Parent
          L3_4 = L3_4.Visible
          if L3_4 == true then
            L3_4 = {}
            L4_4 = A0_4 or L4_4
            if not A0_4 then
              L4_4 = L6_3
              L4_4 = L4_4[1]
            end
            L5_4 = A1_4 or L5_4
            if not A1_4 then
              L5_4 = L6_3
              L5_4 = L5_4[2]
            end
            L6_4 = A2_4 or L6_4
            if not A2_4 then
              L6_4 = L6_3
              L6_4 = L6_4[3]
            end
            L3_4[1] = L4_4
            L3_4[2] = L5_4
            L3_4[3] = L6_4
            L6_3 = L3_4
            L3_4 = Color3
            L3_4 = L3_4.fromHSV
            L4_4 = L6_3
            L4_4 = L4_4[1]
            L5_4 = L6_3
            L5_4 = L5_4[2]
            L6_4 = L6_3
            L6_4 = L6_4[3]
            L3_4 = L3_4(L4_4, L5_4, L6_4)
            L5_3 = L3_4
            L3_4 = pairs
            L4_4 = L0_3
            L4_4 = L4_4.Parent
            L4_4 = L4_4.Parent
            L4_4 = L4_4.Parent
            L4_4 = L4_4.Parent
            L4_4 = L4_4.Parent
            L5_4 = L4_4
            L4_4 = L4_4.GetDescendants
            L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4 = L4_4(L5_4)
            L3_4, L4_4, L5_4 = L3_4(L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4)
            for L6_4, L7_4 in L3_4, L4_4, L5_4 do
              L9_4 = L7_4
              L8_4 = L7_4.IsA
              L10_4 = "ImageLabel"
              L8_4 = L8_4(L9_4, L10_4)
              if L8_4 then
                L8_4 = L7_4.Parent
                L8_4 = L8_4.Name
                if L8_4 == "colorpi" then
                else
                  L8_4 = L5_3
                  L7_4.ImageColor3 = L8_4
                end
              end
            end
          end
        end
        
        function L9_3(A0_4)
          local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
          L1_4 = L0_3
          L1_4 = L1_4.Parent
          L1_4 = L1_4.Parent
          L1_4 = L1_4.Visible
          if L1_4 == true then
            L1_4 = L2_3
            L1_4 = L1_4.X
            L2_4 = A0_4.AbsolutePosition
            L2_4 = L2_4.X
            L1_4 = L1_4 - L2_4
            L2_4 = L2_3
            L2_4 = L2_4.Y
            L3_4 = A0_4.AbsolutePosition
            L3_4 = L3_4.Y
            L2_4 = L2_4 - L3_4
            L3_4 = A0_4.AbsoluteSize
            L3_4 = L3_4.X
            L4_4 = A0_4.AbsoluteSize
            L4_4 = L4_4.Y
            if 0 <= L1_4 and 0 <= L2_4 and L1_4 <= L3_4 and L2_4 <= L4_4 then
              L5_4 = L1_4 / L3_4
              L6_4 = L2_4 / L4_4
              return L5_4, L6_4
            end
          end
        end
        
        function L10_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
          L0_4 = L0_3
          L0_4 = L0_4.Parent
          L0_4 = L0_4.Parent
          L0_4 = L0_4.Visible
          if L0_4 == true then
            L0_4 = mouse1Down
            if L0_4 then
              L0_4 = L9_3
              L1_4 = L3_3
              L0_4, L1_4 = L0_4(L1_4)
              if L0_4 and L1_4 then
                L2_4 = L3_3
                L3_4 = L2_4
                L2_4 = L2_4.WaitForChild
                L4_4 = "Marker"
                L2_4 = L2_4(L3_4, L4_4)
                L3_4 = UDim2
                L3_4 = L3_4.new
                L4_4 = L0_4
                L5_4 = 0
                L6_4 = L1_4
                L7_4 = 0
                L3_4 = L3_4(L4_4, L5_4, L6_4, L7_4)
                L2_4.Position = L3_4
                L2_4 = L8_3
                L3_4 = 1 - L0_4
                L4_4 = 1 - L1_4
                L2_4(L3_4, L4_4)
              end
              L2_4 = L9_3
              L3_4 = L3_3
              L2_4, L3_4 = L2_4(L3_4)
              if L2_4 and L3_4 then
                L4_4 = value
                L5_4 = L4_4
                L4_4 = L4_4.WaitForChild
                L6_4 = "Marker"
                L4_4 = L4_4(L5_4, L6_4)
                L5_4 = UDim2
                L5_4 = L5_4.new
                L6_4 = 0.5
                L7_4 = 0
                L8_4 = L3_4
                L9_4 = 0
                L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4)
                L4_4.Position = L5_4
                L4_4 = L8_3
                L5_4 = nil
                L6_4 = nil
                L7_4 = 1 - L3_4
                L4_4(L5_4, L6_4, L7_4)
              end
            end
          end
        end
        
        L11_3 = L2_3.Move
        L12_3 = L11_3
        L11_3 = L11_3.connect
        L13_3 = L10_3
        L11_3(L12_3, L13_3)
        L11_3 = L2_3.Button1Down
        L12_3 = L11_3
        L11_3 = L11_3.connect
        
        function L13_3()
          local L0_4
          L0_4 = true
          mouse1Down = L0_4
        end
        
        L11_3(L12_3, L13_3)
        L11_3 = L2_3.Button1Up
        L12_3 = L11_3
        L11_3 = L11_3.connect
        
        function L13_3()
          local L0_4
          L0_4 = false
          mouse1Down = L0_4
        end
        
        L11_3(L12_3, L13_3)
      end
      
      L170_2 = coroutine
      L171_2 = "wrap"
      L170_2 = L170_2[L171_2]
      L171_2 = L169_2
      L170_2 = L170_2(L171_2)
      L170_2()
      
      function L170_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L111_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = 11
        L2_3 = 111
        L3_3 = L0_3.Parent
        L3_3 = L3_3.Slider
        L4_3 = L3_3.Bar
        L5_3 = game
        L5_3 = L5_3.Players
        L5_3 = L5_3.LocalPlayer
        L6_3 = L5_3
        L5_3 = L5_3.GetMouse
        L5_3 = L5_3(L6_3)
        L6_3 = false
        L7_3 = L3_3.MouseButton1Down
        L8_3 = L7_3
        L7_3 = L7_3.Connect
        
        function L9_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
          L0_4 = true
          L6_3 = L0_4
          L0_4 = L4_3
          L1_4 = UDim2
          L1_4 = L1_4.new
          L2_4 = math
          L2_4 = L2_4.clamp
          L3_4 = game
          L3_4 = L3_4.Players
          L3_4 = L3_4.LocalPlayer
          L4_4 = L3_4
          L3_4 = L3_4.GetMouse
          L3_4 = L3_4(L4_4)
          L3_4 = L3_4.X
          L4_4 = L3_3
          L4_4 = L4_4.AbsolutePosition
          L4_4 = L4_4.X
          L3_4 = L3_4 - L4_4
          L4_4 = L3_3
          L4_4 = L4_4.AbsoluteSize
          L4_4 = L4_4.X
          L3_4 = L3_4 / L4_4
          L4_4 = 0
          L5_4 = 1
          L2_4 = L2_4(L3_4, L4_4, L5_4)
          L3_4 = 0
          L4_4 = 1
          L5_4 = 0
          L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
          L0_4.Size = L1_4
          L0_4 = game
          L0_4 = L0_4.Players
          L0_4 = L0_4.LocalPlayer
          L0_4 = L0_4.Character
          L0_4 = L0_4.Humanoid
          L1_4 = tonumber
          L2_4 = math
          L2_4 = L2_4.floor
          L3_4 = L4_3
          L3_4 = L3_4.Size
          L3_4 = L3_4.X
          L3_4 = L3_4.Scale
          L4_4 = L2_3
          L3_4 = L3_4 * L4_4
          L2_4, L3_4, L4_4, L5_4 = L2_4(L3_4)
          L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
          L0_4.WalkSpeed = L1_4
        end
        
        L7_3(L8_3, L9_3)
        L7_3 = game
        L8_3 = L7_3
        L7_3 = L7_3.GetService
        L9_3 = "UserInputService"
        L7_3 = L7_3(L8_3, L9_3)
        L7_3 = L7_3.InputEnded
        L8_3 = L7_3
        L7_3 = L7_3.Connect
        
        function L9_3(A0_4, A1_4)
          local L2_4, L3_4
          L2_4 = A0_4.UserInputType
          L3_4 = Enum
          L3_4 = L3_4.UserInputType
          L3_4 = L3_4.MouseButton1
          if L2_4 == L3_4 then
            L2_4 = false
            L6_3 = L2_4
          end
        end
        
        L7_3(L8_3, L9_3)
        L7_3 = L5_3.Move
        L8_3 = L7_3
        L7_3 = L7_3.Connect
        
        function L9_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
          L0_4 = L6_3
          if L0_4 then
            L0_4 = L4_3
            L1_4 = UDim2
            L1_4 = L1_4.new
            L2_4 = math
            L2_4 = L2_4.clamp
            L3_4 = game
            L3_4 = L3_4.Players
            L3_4 = L3_4.LocalPlayer
            L4_4 = L3_4
            L3_4 = L3_4.GetMouse
            L3_4 = L3_4(L4_4)
            L3_4 = L3_4.X
            L4_4 = L3_3
            L4_4 = L4_4.AbsolutePosition
            L4_4 = L4_4.X
            L3_4 = L3_4 - L4_4
            L4_4 = L3_3
            L4_4 = L4_4.AbsoluteSize
            L4_4 = L4_4.X
            L3_4 = L3_4 / L4_4
            L4_4 = 0
            L5_4 = 1
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L3_4 = 0
            L4_4 = 1
            L5_4 = 0
            L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
            L0_4.Size = L1_4
            L0_4 = game
            L0_4 = L0_4.Players
            L0_4 = L0_4.LocalPlayer
            L0_4 = L0_4.Character
            L0_4 = L0_4.Humanoid
            L1_4 = tonumber
            L2_4 = math
            L2_4 = L2_4.floor
            L3_4 = L4_3
            L3_4 = L3_4.Size
            L3_4 = L3_4.X
            L3_4 = L3_4.Scale
            L4_4 = L2_3
            L3_4 = L3_4 * L4_4
            L2_4, L3_4, L4_4, L5_4 = L2_4(L3_4)
            L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
            L0_4.WalkSpeed = L1_4
          end
        end
        
        L7_3(L8_3, L9_3)
      end
      
      L171_2 = coroutine
      L172_2 = "wrap"
      L171_2 = L171_2[L172_2]
      L172_2 = L170_2
      L171_2 = L171_2(L172_2)
      L171_2()
      
      function L171_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L120_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = 11
        L2_3 = 111
        L3_3 = L0_3.Parent
        L3_3 = L3_3.Slider
        L4_3 = L3_3.Bar
        L5_3 = game
        L5_3 = L5_3.Players
        L5_3 = L5_3.LocalPlayer
        L6_3 = L5_3
        L5_3 = L5_3.GetMouse
        L5_3 = L5_3(L6_3)
        L6_3 = false
        L7_3 = L3_3.MouseButton1Down
        L8_3 = L7_3
        L7_3 = L7_3.Connect
        
        function L9_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
          L0_4 = true
          L6_3 = L0_4
          L0_4 = L4_3
          L1_4 = UDim2
          L1_4 = L1_4.new
          L2_4 = math
          L2_4 = L2_4.clamp
          L3_4 = game
          L3_4 = L3_4.Players
          L3_4 = L3_4.LocalPlayer
          L4_4 = L3_4
          L3_4 = L3_4.GetMouse
          L3_4 = L3_4(L4_4)
          L3_4 = L3_4.X
          L4_4 = L3_3
          L4_4 = L4_4.AbsolutePosition
          L4_4 = L4_4.X
          L3_4 = L3_4 - L4_4
          L4_4 = L3_3
          L4_4 = L4_4.AbsoluteSize
          L4_4 = L4_4.X
          L3_4 = L3_4 / L4_4
          L4_4 = 0
          L5_4 = 1
          L2_4 = L2_4(L3_4, L4_4, L5_4)
          L3_4 = 0
          L4_4 = 1
          L5_4 = 0
          L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
          L0_4.Size = L1_4
          L0_4 = game
          L0_4 = L0_4.Players
          L0_4 = L0_4.LocalPlayer
          L0_4 = L0_4.Character
          L0_4 = L0_4.Humanoid
          L1_4 = tonumber
          L2_4 = math
          L2_4 = L2_4.floor
          L3_4 = L4_3
          L3_4 = L3_4.Size
          L3_4 = L3_4.X
          L3_4 = L3_4.Scale
          L4_4 = L2_3
          L3_4 = L3_4 * L4_4
          L2_4, L3_4, L4_4, L5_4 = L2_4(L3_4)
          L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
          L0_4.JumpPower = L1_4
          L0_4 = game
          L0_4 = L0_4.Players
          L0_4 = L0_4.LocalPlayer
          L0_4 = L0_4.Character
          L0_4 = L0_4.Humanoid
          L1_4 = tonumber
          L2_4 = math
          L2_4 = L2_4.floor
          L3_4 = L4_3
          L3_4 = L3_4.Size
          L3_4 = L3_4.X
          L3_4 = L3_4.Scale
          L4_4 = L2_3
          L3_4 = L3_4 * L4_4
          L2_4, L3_4, L4_4, L5_4 = L2_4(L3_4)
          L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
          L0_4.JumpHeight = L1_4
        end
        
        L7_3(L8_3, L9_3)
        L7_3 = game
        L8_3 = L7_3
        L7_3 = L7_3.GetService
        L9_3 = "UserInputService"
        L7_3 = L7_3(L8_3, L9_3)
        L7_3 = L7_3.InputEnded
        L8_3 = L7_3
        L7_3 = L7_3.Connect
        
        function L9_3(A0_4, A1_4)
          local L2_4, L3_4
          L2_4 = A0_4.UserInputType
          L3_4 = Enum
          L3_4 = L3_4.UserInputType
          L3_4 = L3_4.MouseButton1
          if L2_4 == L3_4 then
            L2_4 = false
            L6_3 = L2_4
          end
        end
        
        L7_3(L8_3, L9_3)
        L7_3 = L5_3.Move
        L8_3 = L7_3
        L7_3 = L7_3.Connect
        
        function L9_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
          L0_4 = L6_3
          if L0_4 then
            L0_4 = L4_3
            L1_4 = UDim2
            L1_4 = L1_4.new
            L2_4 = math
            L2_4 = L2_4.clamp
            L3_4 = game
            L3_4 = L3_4.Players
            L3_4 = L3_4.LocalPlayer
            L4_4 = L3_4
            L3_4 = L3_4.GetMouse
            L3_4 = L3_4(L4_4)
            L3_4 = L3_4.X
            L4_4 = L3_3
            L4_4 = L4_4.AbsolutePosition
            L4_4 = L4_4.X
            L3_4 = L3_4 - L4_4
            L4_4 = L3_3
            L4_4 = L4_4.AbsoluteSize
            L4_4 = L4_4.X
            L3_4 = L3_4 / L4_4
            L4_4 = 0
            L5_4 = 1
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            L3_4 = 0
            L4_4 = 1
            L5_4 = 0
            L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
            L0_4.Size = L1_4
            L0_4 = game
            L0_4 = L0_4.Players
            L0_4 = L0_4.LocalPlayer
            L0_4 = L0_4.Character
            L0_4 = L0_4.Humanoid
            L1_4 = tonumber
            L2_4 = math
            L2_4 = L2_4.floor
            L3_4 = L4_3
            L3_4 = L3_4.Size
            L3_4 = L3_4.X
            L3_4 = L3_4.Scale
            L4_4 = L2_3
            L3_4 = L3_4 * L4_4
            L2_4, L3_4, L4_4, L5_4 = L2_4(L3_4)
            L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
            L0_4.JumpPower = L1_4
            L0_4 = game
            L0_4 = L0_4.Players
            L0_4 = L0_4.LocalPlayer
            L0_4 = L0_4.Character
            L0_4 = L0_4.Humanoid
            L1_4 = tonumber
            L2_4 = math
            L2_4 = L2_4.floor
            L3_4 = L4_3
            L3_4 = L3_4.Size
            L3_4 = L3_4.X
            L3_4 = L3_4.Scale
            L4_4 = L2_3
            L3_4 = L3_4 * L4_4
            L2_4, L3_4, L4_4, L5_4 = L2_4(L3_4)
            L1_4 = L1_4(L2_4, L3_4, L4_4, L5_4)
            L0_4.JumpHeight = L1_4
          end
        end
        
        L7_3(L8_3, L9_3)
      end
      
      L172_2 = coroutine
      L173_2 = "wrap"
      L172_2 = L172_2[L173_2]
      L173_2 = L171_2
      L172_2 = L172_2(L173_2)
      L172_2()
      
      function L172_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L128_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
          L0_4 = L127_2
          if L0_4 == true then
            L0_4 = false
            L127_2 = L0_4
            return
          end
          L0_4 = true
          L127_2 = L0_4
          L0_4 = game
          L0_4 = L0_4.Players
          L0_4 = L0_4.LocalPlayer
          L1_4 = L0_4
          L0_4 = L0_4.GetMouse
          L2_4 = ""
          L0_4 = L0_4(L1_4, L2_4)
          L1_4 = game
          L1_4 = L1_4.Players
          L1_4 = L1_4.LocalPlayer
          L2_4 = game
          L2_4 = L2_4.Players
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Character
          L3_4 = L2_4
          L2_4 = L2_4.WaitForChild
          L4_4 = "HumanoidRootPart"
          L2_4(L3_4, L4_4)
          L2_4 = game
          L2_4 = L2_4.Players
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Character
          L2_4 = L2_4.HumanoidRootPart
          L3_4 = 5
          L4_4 = {}
          L4_4.a = false
          L4_4.d = false
          L4_4.w = false
          L4_4.s = false
          L5_4 = nil
          L6_4 = nil
          
          function L7_4()
            local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
            L0_5 = Instance
            L0_5 = L0_5.new
            L1_5 = "BodyPosition"
            L2_5 = L2_4
            L0_5 = L0_5(L1_5, L2_5)
            L1_5 = Instance
            L1_5 = L1_5.new
            L2_5 = "BodyGyro"
            L3_5 = L2_4
            L1_5 = L1_5(L2_5, L3_5)
            L0_5.Name = "EPIXPOS"
            L2_5 = Vector3
            L2_5 = L2_5.new
            L3_5 = math
            L3_5 = L3_5.huge
            L4_5 = math
            L4_5 = L4_5.huge
            L5_5 = math
            L5_5 = L5_5.huge
            L2_5 = L2_5(L3_5, L4_5, L5_5)
            L0_5.maxForce = L2_5
            L2_5 = L2_4
            L2_5 = L2_5.Position
            L0_5.position = L2_5
            L2_5 = Vector3
            L2_5 = L2_5.new
            L3_5 = 9000000000
            L4_5 = 9000000000
            L5_5 = 9000000000
            L2_5 = L2_5(L3_5, L4_5, L5_5)
            L1_5.maxTorque = L2_5
            L2_5 = L2_4
            L2_5 = L2_5.CFrame
            L1_5.cframe = L2_5
            repeat
              L2_5 = wait
              L2_5()
              L2_5 = L1_4
              L2_5 = L2_5.Character
              L2_5 = L2_5.Humanoid
              L2_5.PlatformStand = true
              L2_5 = L1_5.cframe
              L3_5 = L1_5.cframe
              L3_5 = L3_5.p
              L2_5 = L2_5 - L3_5
              L3_5 = L0_5.position
              L2_5 = L2_5 + L3_5
              L3_5 = L4_4
              L3_5 = L3_5.w
              if not L3_5 then
                L3_5 = L4_4
                L3_5 = L3_5.s
                if not L3_5 then
                  L3_5 = L4_4
                  L3_5 = L3_5.a
                  if not L3_5 then
                    L3_5 = L4_4
                    L3_5 = L3_5.d
                    if not L3_5 then
                    end
                  end
                end
              end
              L3_5 = L4_4
              L3_5 = L3_5.w
              if L3_5 then
                L3_5 = workspace
                L3_5 = L3_5.CurrentCamera
                L3_5 = L3_5.CoordinateFrame
                L3_5 = L3_5.lookVector
                L4_5 = L3_4
                L3_5 = L3_5 * L4_5
                L2_5 = L2_5 + L3_5
              end
              L3_5 = L4_4
              L3_5 = L3_5.s
              if L3_5 then
                L3_5 = workspace
                L3_5 = L3_5.CurrentCamera
                L3_5 = L3_5.CoordinateFrame
                L3_5 = L3_5.lookVector
                L4_5 = L3_4
                L3_5 = L3_5 * L4_5
                L2_5 = L2_5 - L3_5
              end
              L3_5 = L4_4
              L3_5 = L3_5.d
              if L3_5 then
                L3_5 = CFrame
                L3_5 = L3_5.new
                L4_5 = L3_4
                L5_5 = 0
                L6_5 = 0
                L3_5 = L3_5(L4_5, L5_5, L6_5)
                L2_5 = L2_5 * L3_5
              end
              L3_5 = L4_4
              L3_5 = L3_5.a
              if L3_5 then
                L3_5 = CFrame
                L3_5 = L3_5.new
                L4_5 = L3_4
                L4_5 = -L4_5
                L5_5 = 0
                L6_5 = 0
                L3_5 = L3_5(L4_5, L5_5, L6_5)
                L2_5 = L2_5 * L3_5
              end
              L3_5 = L3_4
              if 5 < L3_5 then
              end
              L3_5 = L2_5.p
              L0_5.position = L3_5
              L3_5 = L4_4
              L3_5 = L3_5.w
              if L3_5 then
                L3_5 = workspace
                L3_5 = L3_5.CurrentCamera
                L3_5 = L3_5.CoordinateFrame
                L4_5 = CFrame
                L4_5 = L4_5.Angles
                L5_5 = math
                L5_5 = L5_5.rad
                L6_5 = L3_4
                L6_5 = L6_5 * 15
                L5_5 = L5_5(L6_5)
                L5_5 = -L5_5
                L6_5 = 0
                L7_5 = 0
                L4_5 = L4_5(L5_5, L6_5, L7_5)
                L3_5 = L3_5 * L4_5
                L1_5.cframe = L3_5
              else
                L3_5 = L4_4
                L3_5 = L3_5.s
                if L3_5 then
                  L3_5 = workspace
                  L3_5 = L3_5.CurrentCamera
                  L3_5 = L3_5.CoordinateFrame
                  L4_5 = CFrame
                  L4_5 = L4_5.Angles
                  L5_5 = math
                  L5_5 = L5_5.rad
                  L6_5 = L3_4
                  L6_5 = L6_5 * 15
                  L5_5 = L5_5(L6_5)
                  L6_5 = 0
                  L7_5 = 0
                  L4_5 = L4_5(L5_5, L6_5, L7_5)
                  L3_5 = L3_5 * L4_5
                  L1_5.cframe = L3_5
                else
                  L3_5 = workspace
                  L3_5 = L3_5.CurrentCamera
                  L3_5 = L3_5.CoordinateFrame
                  L1_5.cframe = L3_5
                end
              end
              L3_5 = L127_2
            until not L3_5
            if L1_5 then
              L3_5 = L1_5
              L2_5 = L1_5.Destroy
              L2_5(L3_5)
            end
            if L0_5 then
              L3_5 = L0_5
              L2_5 = L0_5.Destroy
              L2_5(L3_5)
            end
            L2_5 = false
            flying = L2_5
            L2_5 = L1_4
            L2_5 = L2_5.Character
            L2_5 = L2_5.Humanoid
            L2_5.PlatformStand = false
          end
          
          L8_4 = L0_4.KeyDown
          L9_4 = L8_4
          L8_4 = L8_4.connect
          
          function L10_4(A0_5)
            local L1_5, L2_5
            L1_5 = L2_4
            if L1_5 then
              L1_5 = L2_4
              L1_5 = L1_5.Parent
              if L1_5 then
                goto lbl_17
              end
            end
            L1_5 = false
            flying = L1_5
            L1_5 = L5_4
            L2_5 = L1_5
            L1_5 = L1_5.disconnect
            L1_5(L2_5)
            L1_5 = L6_4
            L2_5 = L1_5
            L1_5 = L1_5.disconnect
            L1_5(L2_5)
            do return end
            ::lbl_17::
            if A0_5 == "w" then
              L1_5 = L4_4
              L1_5.w = true
            elseif A0_5 == "s" then
              L1_5 = L4_4
              L1_5.s = true
            elseif A0_5 == "a" then
              L1_5 = L4_4
              L1_5.a = true
            elseif A0_5 == "d" then
              L1_5 = L4_4
              L1_5.d = true
            end
          end
          
          L8_4 = L8_4(L9_4, L10_4)
          L5_4 = L8_4
          L8_4 = L0_4.KeyUp
          L9_4 = L8_4
          L8_4 = L8_4.connect
          
          function L10_4(A0_5)
            local L1_5, L2_5
            if A0_5 == "w" then
              L1_5 = L4_4
              L1_5.w = false
            elseif A0_5 == "s" then
              L1_5 = L4_4
              L1_5.s = false
            elseif A0_5 == "a" then
              L1_5 = L4_4
              L1_5.a = false
            elseif A0_5 == "d" then
              L1_5 = L4_4
              L1_5.d = false
            end
          end
          
          L8_4 = L8_4(L9_4, L10_4)
          L6_4 = L8_4
          L8_4 = L7_4
          L8_4()
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L173_2 = coroutine
      L174_2 = "wrap"
      L173_2 = L173_2[L174_2]
      L174_2 = L172_2
      L173_2 = L173_2(L174_2)
      L173_2()
      
      function L173_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L128_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = L0_3
          L0_4 = L0_4.Parent
          L0_4 = L0_4.BackgroundColor3
          L1_4 = Color3
          L1_4 = L1_4.fromRGB
          L2_4 = 29
          L3_4 = 40
          L4_4 = 58
          L1_4 = L1_4(L2_4, L3_4, L4_4)
          if L0_4 == L1_4 then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          else
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L174_2 = coroutine
      L175_2 = "wrap"
      L174_2 = L174_2[L175_2]
      L175_2 = L173_2
      L174_2 = L174_2(L175_2)
      L174_2()
      
      function L174_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L132_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = false
        toggle = L1_3
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = false
            toggle = L0_4
          else
            L0_4 = true
            toggle = L0_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 0
            L3_4 = 136
            L4_4 = 255
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = L0_3
            L0_4 = L0_4.Parent
            L1_4 = Color3
            L1_4 = L1_4.fromRGB
            L2_4 = 29
            L3_4 = 40
            L4_4 = 58
            L1_4 = L1_4(L2_4, L3_4, L4_4)
            L0_4.BackgroundColor3 = L1_4
          end
          L0_4 = toggle
          if L0_4 == true then
            L0_4 = _G
            L0_4.infinjump = true
            L0_4 = game
            L1_4 = L0_4
            L0_4 = L0_4.GetService
            L2_4 = "Players"
            L0_4 = L0_4(L1_4, L2_4)
            L0_4 = L0_4.LocalPlayer
            L2_4 = L0_4
            L1_4 = L0_4.GetMouse
            L1_4 = L1_4(L2_4)
            L2_4 = L1_4.KeyDown
            L3_4 = L2_4
            L2_4 = L2_4.connect
            
            function L4_4(A0_5)
              local L1_5, L2_5, L3_5
              L1_5 = _G
              L1_5 = L1_5.infinjump
              if L1_5 then
                L2_5 = A0_5
                L1_5 = A0_5.byte
                L1_5 = L1_5(L2_5)
                if L1_5 == 32 then
                  L1_5 = game
                  L2_5 = L1_5
                  L1_5 = L1_5.GetService
                  L3_5 = "Players"
                  L1_5 = L1_5(L2_5, L3_5)
                  L1_5 = L1_5.LocalPlayer
                  L1_5 = L1_5.Character
                  L2_5 = L1_5
                  L1_5 = L1_5.FindFirstChildOfClass
                  L3_5 = "Humanoid"
                  L1_5 = L1_5(L2_5, L3_5)
                  Humanoid = L1_5
                  L1_5 = Humanoid
                  L2_5 = L1_5
                  L1_5 = L1_5.ChangeState
                  L3_5 = "Jumping"
                  L1_5(L2_5, L3_5)
                  L1_5 = wait
                  L1_5()
                  L1_5 = Humanoid
                  L2_5 = L1_5
                  L1_5 = L1_5.ChangeState
                  L3_5 = "Seated"
                  L1_5(L2_5, L3_5)
                end
              end
            end
            
            L2_4(L3_4, L4_4)
          end
          L0_4 = toggle
          if L0_4 == false then
            L0_4 = _G
            L0_4 = L0_4.infinjump
            if L0_4 == true then
              L0_4 = _G
              L0_4.infinjump = false
            else
            end
          end
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L175_2 = coroutine
      L176_2 = "wrap"
      L175_2 = L175_2[L176_2]
      L176_2 = L174_2
      L175_2 = L175_2(L176_2)
      L175_2()
      
      function L175_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L137_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4
          L0_4 = Instance
          L0_4 = L0_4.new
          L1_4 = "HopperBin"
          L2_4 = game
          L3_4 = L2_4
          L2_4 = L2_4.service
          L4_4 = "Players"
          L2_4 = L2_4(L3_4, L4_4)
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Backpack
          L0_4 = L0_4(L1_4, L2_4)
          bin = L0_4
          L0_4 = bin
          L0_4.Name = "Teleport"
          
          function L0_4(A0_5)
            local L1_5, L2_5, L3_5, L4_5, L5_5
            L1_5 = game
            L2_5 = L1_5
            L1_5 = L1_5.service
            L3_5 = "Players"
            L1_5 = L1_5(L2_5, L3_5)
            L1_5 = L1_5.LocalPlayer
            if L1_5 ~= nil then
              L2_5 = L1_5.Character
              if L2_5 ~= nil then
                goto lbl_12
              end
            end
            do return end
            ::lbl_12::
            L2_5 = L1_5.Character
            L4_5 = L2_5
            L3_5 = L2_5.MoveTo
            L5_5 = A0_5
            L3_5(L4_5, L5_5)
          end
          
          teleportPlayer = L0_4
          L0_4 = true
          enabled = L0_4
          
          function L0_4(A0_5)
            local L1_5, L2_5, L3_5, L4_5
            L1_5 = enabled
            if not L1_5 then
              return
            end
            L1_5 = game
            L2_5 = L1_5
            L1_5 = L1_5.service
            L3_5 = "Players"
            L1_5 = L1_5(L2_5, L3_5)
            L1_5 = L1_5.LocalPlayer
            if L1_5 == nil then
              return
            end
            L2_5 = A0_5.Hit
            L3_5 = teleportPlayer
            L4_5 = L2_5.p
            L3_5(L4_5)
          end
          
          onButton1Down = L0_4
          
          function L0_4(A0_5)
            local L1_5, L2_5, L3_5
            L1_5 = A0_5.Button1Down
            L2_5 = L1_5
            L1_5 = L1_5.connect
            
            function L3_5()
              local L0_6, L1_6
              L0_6 = onButton1Down
              L1_6 = A0_5
              L0_6(L1_6)
            end
            
            L1_5(L2_5, L3_5)
          end
          
          onSelected = L0_4
          L0_4 = bin
          L0_4 = L0_4.Selected
          L1_4 = L0_4
          L0_4 = L0_4.connect
          L2_4 = onSelected
          L0_4(L1_4, L2_4)
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L176_2 = coroutine
      L177_2 = "wrap"
      L176_2 = L176_2[L177_2]
      L177_2 = L175_2
      L176_2 = L176_2(L177_2)
      L176_2()
      
      function L176_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L139_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3.Parent
        L1_3 = L1_3.MouseButton1Down
        L2_3 = L1_3
        L1_3 = L1_3.connect
        
        function L3_3()
          local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4
          L0_4 = game
          L0_4 = L0_4.StarterGui
          L1_4 = L0_4
          L0_4 = L0_4.SetCoreGuiEnabled
          L2_4 = Enum
          L2_4 = L2_4.CoreGuiType
          L2_4 = L2_4.Backpack
          L3_4 = true
          L0_4(L1_4, L2_4, L3_4)
          L0_4 = pairs
          L1_4 = game
          L2_4 = L1_4
          L1_4 = L1_4.GetService
          L3_4 = "Workspace"
          L1_4 = L1_4(L2_4, L3_4)
          L2_4 = L1_4
          L1_4 = L1_4.GetChildren
          L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4 = L1_4(L2_4)
          L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4)
          for L3_4, L4_4 in L0_4, L1_4, L2_4 do
            L5_4 = L4_4.ClassName
            if L5_4 == "Part" then
              L4_4.Locked = false
            end
            L5_4 = L4_4.ClassName
            if L5_4 == "MeshPart" then
              L4_4.Locked = false
            end
            L5_4 = L4_4.ClassName
            if L5_4 == "UnionOperation" then
              L4_4.Locked = false
            end
            L5_4 = L4_4.ClassName
            if L5_4 == "Model" then
              L5_4 = pairs
              L7_4 = L4_4
              L6_4 = L4_4.GetChildren
              L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4 = L6_4(L7_4)
              L5_4, L6_4, L7_4 = L5_4(L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4)
              for L8_4, L9_4 in L5_4, L6_4, L7_4 do
                L10_4 = L9_4.ClassName
                if L10_4 == "Part" then
                  L9_4.Locked = false
                end
                L10_4 = L9_4.ClassName
                if L10_4 == "MeshPart" then
                  L9_4.Locked = false
                end
                L10_4 = L9_4.ClassName
                if L10_4 == "UnionOperation" then
                  L9_4.Locked = false
                end
                L10_4 = L9_4.ClassName
                if L10_4 == "Model" then
                  L10_4 = pairs
                  L12_4 = L9_4
                  L11_4 = L9_4.GetChildren
                  L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4 = L11_4(L12_4)
                  L10_4, L11_4, L12_4 = L10_4(L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4)
                  for L13_4, L14_4 in L10_4, L11_4, L12_4 do
                    L15_4 = L14_4.ClassName
                    if L15_4 == "Part" then
                      L14_4.Locked = false
                    end
                    L15_4 = L14_4.ClassName
                    if L15_4 == "MeshPart" then
                      L14_4.Locked = false
                    end
                    L15_4 = L14_4.ClassName
                    if L15_4 == "UnionOperation" then
                      L14_4.Locked = false
                    end
                    L15_4 = print
                    L16_4 = "twitter.com/M4KubeX"
                    L15_4(L16_4)
                    L15_4 = L14_4.ClassName
                    if L15_4 == "Model" then
                      L15_4 = pairs
                      L17_4 = L14_4
                      L16_4 = L14_4.GetChildren
                      L16_4, L17_4, L18_4, L19_4, L20_4 = L16_4(L17_4)
                      L15_4, L16_4, L17_4 = L15_4(L16_4, L17_4, L18_4, L19_4, L20_4)
                      for L18_4, L19_4 in L15_4, L16_4, L17_4 do
                        L20_4 = L19_4.ClassName
                        if L20_4 == "Part" then
                          L19_4.Locked = false
                        end
                        L20_4 = L19_4.ClassName
                        if L20_4 == "MeshPart" then
                          L19_4.Locked = false
                        end
                        L20_4 = L19_4.ClassName
                        if L20_4 == "UnionOperation" then
                          L19_4.Locked = false
                        end
                        L20_4 = L19_4.ClassName
                        if L20_4 == "Model" then
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          L0_4 = Instance
          L0_4 = L0_4.new
          L1_4 = "HopperBin"
          L2_4 = game
          L3_4 = L2_4
          L2_4 = L2_4.GetService
          L4_4 = "Players"
          L2_4 = L2_4(L3_4, L4_4)
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Backpack
          L0_4 = L0_4(L1_4, L2_4)
          c = L0_4
          L0_4 = c
          L1_4 = Enum
          L1_4 = L1_4.BinType
          L1_4 = L1_4.Hammer
          L0_4.BinType = L1_4
          L0_4 = Instance
          L0_4 = L0_4.new
          L1_4 = "HopperBin"
          L2_4 = game
          L3_4 = L2_4
          L2_4 = L2_4.GetService
          L4_4 = "Players"
          L2_4 = L2_4(L3_4, L4_4)
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Backpack
          L0_4 = L0_4(L1_4, L2_4)
          c = L0_4
          L0_4 = c
          L1_4 = Enum
          L1_4 = L1_4.BinType
          L1_4 = L1_4.Clone
          L0_4.BinType = L1_4
          L0_4 = Instance
          L0_4 = L0_4.new
          L1_4 = "HopperBin"
          L2_4 = game
          L3_4 = L2_4
          L2_4 = L2_4.GetService
          L4_4 = "Players"
          L2_4 = L2_4(L3_4, L4_4)
          L2_4 = L2_4.LocalPlayer
          L2_4 = L2_4.Backpack
          L0_4 = L0_4(L1_4, L2_4)
          c = L0_4
          L0_4 = c
          L1_4 = Enum
          L1_4 = L1_4.BinType
          L1_4 = L1_4.Grab
          L0_4.BinType = L1_4
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L177_2 = coroutine
      L178_2 = "wrap"
      L177_2 = L177_2[L178_2]
      L178_2 = L176_2
      L177_2 = L177_2(L178_2)
      L177_2()
      
      function L177_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L142_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L142_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L107_2
          L0_4.Visible = false
          L0_4 = L135_2
          L0_4.Visible = true
          L0_4 = L147_2
          L0_4.Visible = false
          L0_4 = L144_2
          L0_4.Visible = true
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L178_2 = coroutine
      L179_2 = "wrap"
      L178_2 = L178_2[L179_2]
      L179_2 = L177_2
      L178_2 = L178_2(L179_2)
      L178_2()
      
      function L178_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L145_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L145_2
        L1_3 = L1_3.MouseButton1Click
        L2_3 = L1_3
        L1_3 = L1_3.Connect
        
        function L3_3()
          local L0_4, L1_4
          L0_4 = L107_2
          L0_4.Visible = true
          L0_4 = L135_2
          L0_4.Visible = false
          L0_4 = L147_2
          L0_4.Visible = true
          L0_4 = L144_2
          L0_4.Visible = false
        end
        
        L1_3(L2_3, L3_3)
      end
      
      L179_2 = coroutine
      L180_2 = "wrap"
      L179_2 = L179_2[L180_2]
      L180_2 = L178_2
      L179_2 = L179_2(L180_2)
      L179_2()
      
      function L179_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L3_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3.Parent
        L1_3 = L1_3.Parent
        L1_3 = L1_3.LIGHTUX
        L2_3 = Enum
        L2_3 = L2_3.KeyCode
        L2_3 = L2_3.L
        L3_3 = game
        L4_3 = L3_3
        L3_3 = L3_3.GetService
        L5_3 = "UserInputService"
        L3_3 = L3_3(L4_3, L5_3)
        L4_3 = true
        L5_3 = L3_3.InputBegan
        L6_3 = L5_3
        L5_3 = L5_3.Connect
        
        function L7_3(A0_4, A1_4)
          local L2_4, L3_4
          L2_4 = A0_4.KeyCode
          L3_4 = L2_3
          if L2_4 == L3_4 then
            L2_4 = L3_3
            L3_4 = L2_4
            L2_4 = L2_4.GetFocusedTextBox
            L2_4 = L2_4(L3_4)
            if L2_4 == nil then
              L2_4 = L4_3
              if L2_4 == false then
                L2_4 = true
                L4_3 = L2_4
                L2_4 = L1_3
                L3_4 = L4_3
                L2_4.Visible = L3_4
              else
                L2_4 = L4_3
                if L2_4 == true then
                  L2_4 = false
                  L4_3 = L2_4
                  L2_4 = L1_3
                  L3_4 = L4_3
                  L2_4.Visible = L3_4
                end
              end
            end
          end
        end
        
        L5_3(L6_3, L7_3)
      end
      
      L180_2 = coroutine
      L181_2 = "wrap"
      L180_2 = L180_2[L181_2]
      L181_2 = L179_2
      L180_2 = L180_2(L181_2)
      L180_2()
      
      function L180_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
        L0_3 = Instance
        L0_3 = L0_3.new
        L1_3 = "LocalScript"
        L2_3 = L3_2
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = game
        L2_3 = L1_3
        L1_3 = L1_3.GetService
        L3_3 = "UserInputService"
        L1_3 = L1_3(L2_3, L3_3)
        L2_3 = game
        L3_3 = L2_3
        L2_3 = L2_3.GetService
        L4_3 = "RunService"
        L2_3 = L2_3(L3_3, L4_3)
        L3_3 = L0_3.Parent
        L4_3 = nil
        L5_3 = nil
        L6_3 = nil
        L7_3 = nil
        
        function L8_3(A0_4, A1_4, A2_4)
          local L3_4
          L3_4 = A1_4 - A0_4
          L3_4 = L3_4 * A2_4
          L3_4 = A0_4 + L3_4
        end
        
        Lerp = L8_3
        L8_3 = nil
        L9_3 = nil
        L10_3 = 8
        
        function L11_3(A0_4)
          local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
          L1_4 = L7_3
          if not L1_4 then
            return
          end
          L1_4 = L4_3
          if not L1_4 then
            L1_4 = L9_3
            if L1_4 then
              L1_4 = L3_3
              L2_4 = UDim2
              L2_4 = L2_4.new
              L3_4 = L7_3
              L3_4 = L3_4.X
              L3_4 = L3_4.Scale
              L4_4 = Lerp
              L5_4 = L3_3
              L5_4 = L5_4.Position
              L5_4 = L5_4.X
              L5_4 = L5_4.Offset
              L6_4 = L9_3
              L6_4 = L6_4.X
              L6_4 = L6_4.Offset
              L7_4 = L10_3
              L7_4 = A0_4 * L7_4
              L4_4 = L4_4(L5_4, L6_4, L7_4)
              L5_4 = L7_3
              L5_4 = L5_4.Y
              L5_4 = L5_4.Scale
              L6_4 = Lerp
              L7_4 = L3_3
              L7_4 = L7_4.Position
              L7_4 = L7_4.Y
              L7_4 = L7_4.Offset
              L8_4 = L9_3
              L8_4 = L8_4.Y
              L8_4 = L8_4.Offset
              L9_4 = L10_3
              L9_4 = A0_4 * L9_4
              L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4 = L6_4(L7_4, L8_4, L9_4)
              L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
              L1_4.Position = L2_4
              return
            end
          end
          L1_4 = L8_3
          L2_4 = L1_3
          L3_4 = L2_4
          L2_4 = L2_4.GetMouseLocation
          L2_4 = L2_4(L3_4)
          L1_4 = L1_4 - L2_4
          L2_4 = L7_3
          L2_4 = L2_4.X
          L2_4 = L2_4.Offset
          L3_4 = L1_4.X
          L2_4 = L2_4 - L3_4
          L3_4 = L7_3
          L3_4 = L3_4.Y
          L3_4 = L3_4.Offset
          L4_4 = L1_4.Y
          L3_4 = L3_4 - L4_4
          L4_4 = UDim2
          L4_4 = L4_4.new
          L5_4 = L7_3
          L5_4 = L5_4.X
          L5_4 = L5_4.Scale
          L6_4 = L2_4
          L7_4 = L7_3
          L7_4 = L7_4.Y
          L7_4 = L7_4.Scale
          L8_4 = L3_4
          L4_4 = L4_4(L5_4, L6_4, L7_4, L8_4)
          L9_3 = L4_4
          L4_4 = L3_3
          L5_4 = UDim2
          L5_4 = L5_4.new
          L6_4 = L7_3
          L6_4 = L6_4.X
          L6_4 = L6_4.Scale
          L7_4 = Lerp
          L8_4 = L3_3
          L8_4 = L8_4.Position
          L8_4 = L8_4.X
          L8_4 = L8_4.Offset
          L9_4 = L2_4
          L10_4 = L10_3
          L10_4 = A0_4 * L10_4
          L7_4 = L7_4(L8_4, L9_4, L10_4)
          L8_4 = L7_3
          L8_4 = L8_4.Y
          L8_4 = L8_4.Scale
          L9_4 = Lerp
          L10_4 = L3_3
          L10_4 = L10_4.Position
          L10_4 = L10_4.Y
          L10_4 = L10_4.Offset
          L11_4 = L3_4
          L12_4 = L10_3
          L12_4 = A0_4 * L12_4
          L9_4, L10_4, L11_4, L12_4 = L9_4(L10_4, L11_4, L12_4)
          L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
          L4_4.Position = L5_4
        end
        
        Update = L11_3
        L11_3 = L3_3.InputBegan
        L12_3 = L11_3
        L11_3 = L11_3.Connect
        
        function L13_3(A0_4)
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
              goto lbl_30
            end
          end
          L1_4 = true
          L4_3 = L1_4
          L1_4 = A0_4.Position
          L6_3 = L1_4
          L1_4 = L3_3
          L1_4 = L1_4.Position
          L7_3 = L1_4
          L1_4 = L1_3
          L2_4 = L1_4
          L1_4 = L1_4.GetMouseLocation
          L1_4 = L1_4(L2_4)
          L8_3 = L1_4
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
              L4_3 = L0_5
            end
          end
          
          L1_4(L2_4, L3_4)
          ::lbl_30::
        end
        
        L11_3(L12_3, L13_3)
        L11_3 = L3_3.InputChanged
        L12_3 = L11_3
        L11_3 = L11_3.Connect
        
        function L13_3(A0_4)
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
          L5_3 = A0_4
          ::lbl_14::
        end
        
        L11_3(L12_3, L13_3)
        L11_3 = L2_3.Heartbeat
        L12_3 = L11_3
        L11_3 = L11_3.Connect
        L13_3 = Update
        L11_3(L12_3, L13_3)
      end
      
      L181_2 = coroutine
      L182_2 = "wrap"
      L181_2 = L181_2[L182_2]
      L182_2 = L180_2
      L181_2 = L181_2(L182_2)
      L181_2()
      L181_2 = print
      L182_2 = "cor"
      L181_2(L182_2)
    else
      L2_2 = L1_1
      L2_2 = L2_2.new
      L3_2 = "error"
      L4_2 = "Error"
      L5_2 = "Incorrect key."
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      no1 = L2_2
      L2_2 = no1
      L3_2 = L2_2
      L2_2 = L2_2.deleteTimeout
      L4_2 = 2
      L2_2(L3_2, L4_2)
    end
  end
end

bn9ksmsnMSLOS012S = L3_1
L3_1 = pcall

function L4_1()
  local L0_2, L1_2
  L0_2 = readfile
  L1_2 = "lightuxkey.txt"
  L0_2 = L0_2(L1_2)
  savedkey121 = L0_2
end

L3_1 = L3_1(L4_1)
if not L3_1 then
  L4_1 = writefile
  L5_1 = "lightuxkey.txt"
  L6_1 = "start"
  L4_1(L5_1, L6_1)
end
L4_1 = bn9ksmsnMSLOS012S
L5_1 = "bHSHsmd019sksasd"
L6_1 = readfile
L7_1 = "lightuxkey.txt"
L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1 = L6_1(L7_1)
L4_1(L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1)
L4_1 = Instance
L4_1 = L4_1.new
L5_1 = "Frame"
L4_1 = L4_1(L5_1)
L5_1 = Instance
L5_1 = L5_1.new
L6_1 = "UICorner"
L5_1 = L5_1(L6_1)
L6_1 = Instance
L6_1 = L6_1.new
L7_1 = "ImageLabel"
L6_1 = L6_1(L7_1)
L7_1 = Instance
L7_1 = L7_1.new
L8_1 = "UICorner"
L7_1 = L7_1(L8_1)
L8_1 = Instance
L8_1 = L8_1.new
L9_1 = "Frame"
L8_1 = L8_1(L9_1)
L9_1 = Instance
L9_1 = L9_1.new
L10_1 = "TextLabel"
L9_1 = L9_1(L10_1)
L10_1 = Instance
L10_1 = L10_1.new
L11_1 = "TextBox"
L10_1 = L10_1(L11_1)
L11_1 = Instance
L11_1 = L11_1.new
L12_1 = "UICorner"
L11_1 = L11_1(L12_1)
L12_1 = Instance
L12_1 = L12_1.new
L13_1 = "Frame"
L12_1 = L12_1(L13_1)
L13_1 = Instance
L13_1 = L13_1.new
L14_1 = "UICorner"
L13_1 = L13_1(L14_1)
L14_1 = Instance
L14_1 = L14_1.new
L15_1 = "ImageLabel"
L14_1 = L14_1(L15_1)
L15_1 = Instance
L15_1 = L15_1.new
L16_1 = "TextButton"
L15_1 = L15_1(L16_1)
L16_1 = Instance
L16_1 = L16_1.new
L17_1 = "UICorner"
L16_1 = L16_1(L17_1)
L17_1 = Instance
L17_1 = L17_1.new
L18_1 = "UIGradient"
L17_1 = L17_1(L18_1)
L18_1 = Instance
L18_1 = L18_1.new
L19_1 = "TextButton"
L18_1 = L18_1(L19_1)
L19_1 = Instance
L19_1 = L19_1.new
L20_1 = "ImageButton"
L19_1 = L19_1(L20_1)
L20_1 = Instance
L20_1 = L20_1.new
L21_1 = "TextLabel"
L20_1 = L20_1(L21_1)
L21_1 = Instance
L21_1 = L21_1.new
L22_1 = "Frame"
L21_1 = L21_1(L22_1)
L22_1 = Instance
L22_1 = L22_1.new
L23_1 = "TextLabel"
L22_1 = L22_1(L23_1)
L23_1 = Instance
L23_1 = L23_1.new
L24_1 = "TextButton"
L23_1 = L23_1(L24_1)
L24_1 = Instance
L24_1 = L24_1.new
L25_1 = "ImageButton"
L24_1 = L24_1(L25_1)
L25_1 = Instance
L25_1 = L25_1.new
L26_1 = "Frame"
L25_1 = L25_1(L26_1)
L26_1 = Instance
L26_1 = L26_1.new
L27_1 = "UIListLayout"
L26_1 = L26_1(L27_1)
L27_1 = Instance
L27_1 = L27_1.new
L28_1 = "TextLabel"
L27_1 = L27_1(L28_1)
L28_1 = Instance
L28_1 = L28_1.new
L29_1 = "TextLabel"
L28_1 = L28_1(L29_1)
L29_1 = Instance
L29_1 = L29_1.new
L30_1 = "TextLabel"
L29_1 = L29_1(L30_1)
L30_1 = Instance
L30_1 = L30_1.new
L31_1 = "TextButton"
L30_1 = L30_1(L31_1)
L31_1 = Instance
L31_1 = L31_1.new
L32_1 = "UICorner"
L31_1 = L31_1(L32_1)
L2_1.Name = "KeySystem123"
L32_1 = game
L32_1 = L32_1.CoreGui
L2_1.Parent = L32_1
L32_1 = Enum
L32_1 = L32_1.ZIndexBehavior
L32_1 = L32_1.Sibling
L2_1.ZIndexBehavior = L32_1
L4_1.Name = "LightuxKey"
L4_1.Parent = L2_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 11
L34_1 = 19
L35_1 = 31
L32_1 = L32_1(L33_1, L34_1, L35_1)
L4_1.BackgroundColor3 = L32_1
L4_1.BorderSizePixel = 0
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.404797852
L34_1 = 0
L35_1 = 0.282716036
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L4_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 491
L35_1 = 0
L36_1 = 352
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L4_1.Size = L32_1
L4_1.Draggable = true
L32_1 = UDim
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 23
L32_1 = L32_1(L33_1, L34_1)
L5_1.CornerRadius = L32_1
L5_1.Parent = L4_1
L6_1.Name = "ImageLeft"
L6_1.Parent = L4_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 11
L34_1 = 19
L35_1 = 31
L32_1 = L32_1(L33_1, L34_1, L35_1)
L6_1.BackgroundColor3 = L32_1
L6_1.BackgroundTransparency = 1
L6_1.BorderSizePixel = 0
L6_1.ClipsDescendants = true
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 288
L35_1 = 0
L36_1 = 352
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L6_1.Size = L32_1
L6_1.Image = "http://www.roblox.com/asset/?id=12265502280"
L6_1.ImageTransparency = 0.8
L32_1 = Enum
L32_1 = L32_1.ScaleType
L32_1 = L32_1.Crop
L6_1.ScaleType = L32_1
L32_1 = UDim
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 23
L32_1 = L32_1(L33_1, L34_1)
L7_1.CornerRadius = L32_1
L7_1.Parent = L6_1
L8_1.Name = "KeySystemPage"
L8_1.Parent = L4_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 11
L34_1 = 19
L35_1 = 31
L32_1 = L32_1(L33_1, L34_1, L35_1)
L8_1.BackgroundColor3 = L32_1
L8_1.BorderSizePixel = 0
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.570264757
L34_1 = 0
L35_1 = 0
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L8_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 178
L35_1 = 0
L36_1 = 352
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L8_1.Size = L32_1
L9_1.Name = "Title"
L9_1.Parent = L8_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L9_1.BackgroundColor3 = L32_1
L9_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = -3.4289414E-7
L34_1 = 0
L35_1 = 0.247159094
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L9_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 211
L35_1 = 0
L36_1 = 50
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L9_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L9_1.Font = L32_1
L9_1.Text = "Key System"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L9_1.TextColor3 = L32_1
L9_1.TextSize = 20
L10_1.Name = "KeyInput"
L10_1.Parent = L8_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 0
L34_1 = 0
L35_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1)
L10_1.BackgroundColor3 = L32_1
L10_1.BackgroundTransparency = 1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 27
L34_1 = 42
L35_1 = 53
L32_1 = L32_1(L33_1, L34_1, L35_1)
L10_1.BorderColor3 = L32_1
L10_1.BorderSizePixel = 0
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.284979194
L34_1 = 0
L35_1 = 0.389204562
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L10_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 136
L35_1 = 0
L36_1 = 28
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L10_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L10_1.Font = L32_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 235
L34_1 = 235
L35_1 = 235
L32_1 = L32_1(L33_1, L34_1, L35_1)
L10_1.PlaceholderColor3 = L32_1
L10_1.PlaceholderText = "Key"
L10_1.Text = ""
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L10_1.TextColor3 = L32_1
L10_1.TextSize = 14
L32_1 = Enum
L32_1 = L32_1.TextXAlignment
L32_1 = L32_1.Left
L10_1.TextXAlignment = L32_1
L11_1.Parent = L10_1
L12_1.Name = "KeyFrame"
L12_1.Parent = L8_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 0
L34_1 = 0
L35_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1)
L12_1.BackgroundColor3 = L32_1
L12_1.BackgroundTransparency = 0.6
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.100386076
L34_1 = 0
L35_1 = 0.386363626
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L12_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 175
L35_1 = 0
L36_1 = 32
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L12_1.Size = L32_1
L13_1.Parent = L12_1
L14_1.Parent = L12_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L14_1.BackgroundColor3 = L32_1
L14_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.0294296741
L34_1 = 0
L35_1 = 0.154762268
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L14_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 21
L35_1 = 0
L36_1 = 21
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L14_1.Size = L32_1
L14_1.Image = "http://www.roblox.com/asset/?id=12265010605"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 235
L34_1 = 235
L35_1 = 235
L32_1 = L32_1(L33_1, L34_1, L35_1)
L14_1.ImageColor3 = L32_1
L15_1.Name = "Check Key"
L15_1.Parent = L8_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L15_1.BackgroundColor3 = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.137583017
L34_1 = 0
L35_1 = 0.508522749
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L15_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 162
L35_1 = 0
L36_1 = 30
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L15_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L15_1.Font = L32_1
L15_1.Text = "Check Key"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 0
L34_1 = 0
L35_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1)
L15_1.TextColor3 = L32_1
L15_1.TextSize = 14
L32_1 = UDim
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 40
L32_1 = L32_1(L33_1, L34_1)
L16_1.CornerRadius = L32_1
L16_1.Parent = L15_1
L32_1 = ColorSequence
L32_1 = L32_1.new
L33_1 = {}
L34_1 = ColorSequenceKeypoint
L34_1 = L34_1.new
L35_1 = 0
L36_1 = Color3
L36_1 = L36_1.fromRGB
L37_1 = 45
L38_1 = 168
L39_1 = 182
L36_1, L37_1, L38_1, L39_1, L40_1 = L36_1(L37_1, L38_1, L39_1)
L34_1 = L34_1(L35_1, L36_1, L37_1, L38_1, L39_1, L40_1)
L35_1 = ColorSequenceKeypoint
L35_1 = L35_1.new
L36_1 = 1
L37_1 = Color3
L37_1 = L37_1.fromRGB
L38_1 = 64
L39_1 = 96
L40_1 = 161
L37_1, L38_1, L39_1, L40_1 = L37_1(L38_1, L39_1, L40_1)
L35_1, L36_1, L37_1, L38_1, L39_1, L40_1 = L35_1(L36_1, L37_1, L38_1, L39_1, L40_1)
L33_1[1] = L34_1
L33_1[2] = L35_1
L33_1[3] = L36_1
L33_1[4] = L37_1
L33_1[5] = L38_1
L33_1[6] = L39_1
L33_1[7] = L40_1
L32_1 = L32_1(L33_1)
L17_1.Color = L32_1
L17_1.Parent = L15_1
L18_1.Name = "GetKeyButton"
L18_1.Parent = L8_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L18_1.BackgroundColor3 = L32_1
L18_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = -0.00526308222
L34_1 = 0
L35_1 = 0.884797037
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L18_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 211
L35_1 = 0
L36_1 = 40
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L18_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSans
L18_1.Font = L32_1
L18_1.Text = "Get Your Key"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 175
L34_1 = 175
L35_1 = 175
L32_1 = L32_1(L33_1, L34_1, L35_1)
L18_1.TextColor3 = L32_1
L18_1.TextSize = 14
L19_1.Name = "arrow_forward"
L19_1.Parent = L18_1
L19_1.BackgroundTransparency = 1
L19_1.LayoutOrder = 5
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.665094316
L34_1 = 0
L35_1 = 0.375000596
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L19_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 19
L35_1 = 0
L36_1 = 14
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L19_1.Size = L32_1
L19_1.ZIndex = 2
L19_1.Image = "rbxassetid://3926307971"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 175
L34_1 = 175
L35_1 = 175
L32_1 = L32_1(L33_1, L34_1, L35_1)
L19_1.ImageColor3 = L32_1
L32_1 = Vector2
L32_1 = L32_1.new
L33_1 = 564
L34_1 = 284
L32_1 = L32_1(L33_1, L34_1)
L19_1.ImageRectOffset = L32_1
L32_1 = Vector2
L32_1 = L32_1.new
L33_1 = 36
L34_1 = 36
L32_1 = L32_1(L33_1, L34_1)
L19_1.ImageRectSize = L32_1
L20_1.Name = "Info"
L20_1.Parent = L8_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L20_1.BackgroundColor3 = L32_1
L20_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = -3.4289414E-7
L34_1 = 0
L35_1 = 0.605113626
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L20_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 211
L35_1 = 0
L36_1 = 23
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L20_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L20_1.Font = L32_1
L20_1.Text = "Correct keys will automaticly save"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 175
L34_1 = 175
L35_1 = 175
L32_1 = L32_1(L33_1, L34_1, L35_1)
L20_1.TextColor3 = L32_1
L20_1.TextSize = 13
L21_1.Name = "GetKeyPage"
L21_1.Parent = L4_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 11
L34_1 = 19
L35_1 = 31
L32_1 = L32_1(L33_1, L34_1, L35_1)
L21_1.BackgroundColor3 = L32_1
L21_1.BorderSizePixel = 0
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.569999993
L34_1 = 0
L35_1 = 0
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L21_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 178
L35_1 = 0
L36_1 = 352
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L21_1.Size = L32_1
L21_1.Visible = false
L22_1.Name = "Title"
L22_1.Parent = L21_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L22_1.BackgroundColor3 = L32_1
L22_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = -0.00526308222
L34_1 = 0
L35_1 = 0.0284090918
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L22_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 215
L35_1 = 0
L36_1 = 50
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L22_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L22_1.Font = L32_1
L22_1.Text = "Get Key"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L22_1.TextColor3 = L32_1
L22_1.TextSize = 20
L23_1.Name = "KeySystemButton"
L23_1.Parent = L21_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L23_1.BackgroundColor3 = L32_1
L23_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = -0.00526308222
L34_1 = 0
L35_1 = 0.884797037
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L23_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 212
L35_1 = 0
L36_1 = 40
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L23_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSans
L23_1.Font = L32_1
L23_1.Text = "Key System"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 175
L34_1 = 175
L35_1 = 175
L32_1 = L32_1(L33_1, L34_1, L35_1)
L23_1.TextColor3 = L32_1
L23_1.TextSize = 14
L24_1.Name = "arrow_forward"
L24_1.Parent = L23_1
L24_1.BackgroundTransparency = 1
L24_1.LayoutOrder = 5
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.665094316
L34_1 = 0
L35_1 = 0.325000584
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L24_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 19
L35_1 = 0
L36_1 = 14
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L24_1.Size = L32_1
L24_1.ZIndex = 2
L24_1.Image = "rbxassetid://3926307971"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 175
L34_1 = 175
L35_1 = 175
L32_1 = L32_1(L33_1, L34_1, L35_1)
L24_1.ImageColor3 = L32_1
L32_1 = Vector2
L32_1 = L32_1.new
L33_1 = 564
L34_1 = 284
L32_1 = L32_1(L33_1, L34_1)
L24_1.ImageRectOffset = L32_1
L32_1 = Vector2
L32_1 = L32_1.new
L33_1 = 36
L34_1 = 36
L32_1 = L32_1(L33_1, L34_1)
L24_1.ImageRectSize = L32_1
L25_1.Name = "Steps"
L25_1.Parent = L21_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L25_1.BackgroundColor3 = L32_1
L25_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.146658778
L34_1 = 0
L35_1 = 0.170454532
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L25_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 160
L35_1 = 0
L36_1 = 66
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L25_1.Size = L32_1
L26_1.Parent = L25_1
L32_1 = Enum
L32_1 = L32_1.SortOrder
L32_1 = L32_1.LayoutOrder
L26_1.SortOrder = L32_1
L27_1.Parent = L25_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L27_1.BackgroundColor3 = L32_1
L27_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 186
L35_1 = 0
L36_1 = 22
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L27_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L27_1.Font = L32_1
L27_1.Text = "1. Join discord"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L27_1.TextColor3 = L32_1
L27_1.TextSize = 13
L27_1.TextWrapped = true
L32_1 = Enum
L32_1 = L32_1.TextXAlignment
L32_1 = L32_1.Left
L27_1.TextXAlignment = L32_1
L32_1 = Enum
L32_1 = L32_1.TextYAlignment
L32_1 = L32_1.Top
L27_1.TextYAlignment = L32_1
L28_1.Parent = L25_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L28_1.BackgroundColor3 = L32_1
L28_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 0
L35_1 = 0.106280193
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L28_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 129
L35_1 = 0
L36_1 = 22
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L28_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L28_1.Font = L32_1
L28_1.Text = "2. Go to the #key channel"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L28_1.TextColor3 = L32_1
L28_1.TextSize = 13
L32_1 = Enum
L32_1 = L32_1.TextXAlignment
L32_1 = L32_1.Left
L28_1.TextXAlignment = L32_1
L32_1 = Enum
L32_1 = L32_1.TextYAlignment
L32_1 = L32_1.Top
L28_1.TextYAlignment = L32_1
L29_1.Parent = L25_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L29_1.BackgroundColor3 = L32_1
L29_1.BackgroundTransparency = 1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 0
L35_1 = 0.212560385
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L29_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 139
L35_1 = 0
L36_1 = 22
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L29_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.SourceSansSemibold
L29_1.Font = L32_1
L29_1.Text = "3. Complete word.ink link"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L29_1.TextColor3 = L32_1
L29_1.TextSize = 13
L32_1 = Enum
L32_1 = L32_1.TextXAlignment
L32_1 = L32_1.Left
L29_1.TextXAlignment = L32_1
L32_1 = Enum
L32_1 = L32_1.TextYAlignment
L32_1 = L32_1.Top
L29_1.TextYAlignment = L32_1
L30_1.Name = "JoinDiscord"
L30_1.Parent = L21_1
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 82
L34_1 = 99
L35_1 = 157
L32_1 = L32_1(L33_1, L34_1, L35_1)
L30_1.BackgroundColor3 = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0.178237736
L34_1 = 0
L35_1 = 0.392601192
L36_1 = 0
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1.Position = L32_1
L32_1 = UDim2
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 149
L35_1 = 0
L36_1 = 35
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1.Size = L32_1
L32_1 = Enum
L32_1 = L32_1.Font
L32_1 = L32_1.ArialBold
L30_1.Font = L32_1
L30_1.Text = "Discord Server"
L32_1 = Color3
L32_1 = L32_1.fromRGB
L33_1 = 255
L34_1 = 255
L35_1 = 255
L32_1 = L32_1(L33_1, L34_1, L35_1)
L30_1.TextColor3 = L32_1
L30_1.TextSize = 15
L32_1 = UDim
L32_1 = L32_1.new
L33_1 = 0
L34_1 = 6
L32_1 = L32_1(L33_1, L34_1)
L31_1.CornerRadius = L32_1
L31_1.Parent = L30_1

function L32_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L18_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L0_2.Parent
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = L0_2
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.KeySystemPage
    L0_3.Visible = false
    L0_3 = L0_2
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.GetKeyPage
    L0_3.Visible = true
  end
  
  L1_2(L2_2, L3_2)
end

L33_1 = coroutine
L33_1 = L33_1.wrap
L34_1 = L32_1
L33_1 = L33_1(L34_1)
L33_1()

function L33_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L23_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L0_2.Parent
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = L0_2
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.KeySystemPage
    L0_3.Visible = true
    L0_3 = L0_2
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.GetKeyPage
    L0_3.Visible = false
  end
  
  L1_2(L2_2, L3_2)
end

L34_1 = coroutine
L34_1 = L34_1.wrap
L35_1 = L33_1
L34_1 = L34_1(L35_1)
L34_1()

function L34_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L30_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L30_1
  L1_2 = L1_2.MouseButton1Down
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = syn
    if L0_3 then
      L0_3 = syn
      L0_3 = L0_3.request
      if L0_3 then
        goto lbl_16
      end
    end
    L0_3 = http
    if L0_3 then
      L0_3 = http
      L0_3 = L0_3.request
      if L0_3 then
        goto lbl_16
      end
    end
    L0_3 = http_request
    ::lbl_16::
    if L0_3 then
      L1_3 = L0_3
      L2_3 = {}
      L2_3.Url = "http://127.0.0.1:6463/rpc?v=1"
      L2_3.Method = "POST"
      L3_3 = {}
      L3_3["Content-Type"] = "application/json"
      L3_3.Origin = "https://discord.com"
      L2_3.Headers = L3_3
      L3_3 = game
      L4_3 = L3_3
      L3_3 = L3_3.GetService
      L5_3 = "HttpService"
      L3_3 = L3_3(L4_3, L5_3)
      L4_3 = L3_3
      L3_3 = L3_3.JSONEncode
      L5_3 = {}
      L5_3.cmd = "INVITE_BROWSER"
      L6_3 = {}
      L6_3.code = "sdCSmXRjuX"
      L5_3.args = L6_3
      L6_3 = game
      L7_3 = L6_3
      L6_3 = L6_3.GetService
      L8_3 = "HttpService"
      L6_3 = L6_3(L7_3, L8_3)
      L7_3 = L6_3
      L6_3 = L6_3.GenerateGUID
      L8_3 = false
      L6_3 = L6_3(L7_3, L8_3)
      L5_3.nonce = L6_3
      L3_3 = L3_3(L4_3, L5_3)
      L2_3.Body = L3_3
      L1_3(L2_3)
    end
  end
  
  L1_2(L2_2, L3_2)
end

L35_1 = coroutine
L35_1 = L35_1.wrap
L36_1 = L34_1
L35_1 = L35_1(L36_1)
L35_1()

function L35_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L4_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = game
  L2_2 = L1_2
  L1_2 = L1_2.GetService
  L3_2 = "UserInputService"
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = game
  L3_2 = L2_2
  L2_2 = L2_2.GetService
  L4_2 = "RunService"
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L0_2.Parent
  L4_2 = nil
  L5_2 = nil
  L6_2 = nil
  L7_2 = nil
  
  function L8_2(A0_3, A1_3, A2_3)
    local L3_3
    L3_3 = A1_3 - A0_3
    L3_3 = L3_3 * A2_3
    L3_3 = A0_3 + L3_3
  end
  
  Lerp = L8_2
  L8_2 = nil
  L9_2 = nil
  L10_2 = 8
  
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L1_3 = L7_2
    if not L1_3 then
      return
    end
    L1_3 = L4_2
    if not L1_3 then
      L1_3 = L9_2
      if L1_3 then
        L1_3 = L3_2
        L2_3 = UDim2
        L2_3 = L2_3.new
        L3_3 = L7_2
        L3_3 = L3_3.X
        L3_3 = L3_3.Scale
        L4_3 = Lerp
        L5_3 = L3_2
        L5_3 = L5_3.Position
        L5_3 = L5_3.X
        L5_3 = L5_3.Offset
        L6_3 = L9_2
        L6_3 = L6_3.X
        L6_3 = L6_3.Offset
        L7_3 = L10_2
        L7_3 = A0_3 * L7_3
        L4_3 = L4_3(L5_3, L6_3, L7_3)
        L5_3 = L7_2
        L5_3 = L5_3.Y
        L5_3 = L5_3.Scale
        L6_3 = Lerp
        L7_3 = L3_2
        L7_3 = L7_3.Position
        L7_3 = L7_3.Y
        L7_3 = L7_3.Offset
        L8_3 = L9_2
        L8_3 = L8_3.Y
        L8_3 = L8_3.Offset
        L9_3 = L10_2
        L9_3 = A0_3 * L9_3
        L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3 = L6_3(L7_3, L8_3, L9_3)
        L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
        L1_3.Position = L2_3
        return
      end
    end
    L1_3 = L8_2
    L2_3 = L1_2
    L3_3 = L2_3
    L2_3 = L2_3.GetMouseLocation
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 - L2_3
    L2_3 = L7_2
    L2_3 = L2_3.X
    L2_3 = L2_3.Offset
    L3_3 = L1_3.X
    L2_3 = L2_3 - L3_3
    L3_3 = L7_2
    L3_3 = L3_3.Y
    L3_3 = L3_3.Offset
    L4_3 = L1_3.Y
    L3_3 = L3_3 - L4_3
    L4_3 = UDim2
    L4_3 = L4_3.new
    L5_3 = L7_2
    L5_3 = L5_3.X
    L5_3 = L5_3.Scale
    L6_3 = L2_3
    L7_3 = L7_2
    L7_3 = L7_3.Y
    L7_3 = L7_3.Scale
    L8_3 = L3_3
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3)
    L9_2 = L4_3
    L4_3 = L3_2
    L5_3 = UDim2
    L5_3 = L5_3.new
    L6_3 = L7_2
    L6_3 = L6_3.X
    L6_3 = L6_3.Scale
    L7_3 = Lerp
    L8_3 = L3_2
    L8_3 = L8_3.Position
    L8_3 = L8_3.X
    L8_3 = L8_3.Offset
    L9_3 = L2_3
    L10_3 = L10_2
    L10_3 = A0_3 * L10_3
    L7_3 = L7_3(L8_3, L9_3, L10_3)
    L8_3 = L7_2
    L8_3 = L8_3.Y
    L8_3 = L8_3.Scale
    L9_3 = Lerp
    L10_3 = L3_2
    L10_3 = L10_3.Position
    L10_3 = L10_3.Y
    L10_3 = L10_3.Offset
    L11_3 = L3_3
    L12_3 = L10_2
    L12_3 = A0_3 * L12_3
    L9_3, L10_3, L11_3, L12_3 = L9_3(L10_3, L11_3, L12_3)
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
    L4_3.Position = L5_3
  end
  
  Update = L11_2
  L11_2 = L3_2.InputBegan
  L12_2 = L11_2
  L11_2 = L11_2.Connect
  
  function L13_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = A0_3.UserInputType
    L2_3 = Enum
    L2_3 = L2_3.UserInputType
    L2_3 = L2_3.MouseButton1
    if L1_3 ~= L2_3 then
      L1_3 = A0_3.UserInputType
      L2_3 = Enum
      L2_3 = L2_3.UserInputType
      L2_3 = L2_3.Touch
      if L1_3 ~= L2_3 then
        goto lbl_30
      end
    end
    L1_3 = true
    L4_2 = L1_3
    L1_3 = A0_3.Position
    L6_2 = L1_3
    L1_3 = L3_2
    L1_3 = L1_3.Position
    L7_2 = L1_3
    L1_3 = L1_2
    L2_3 = L1_3
    L1_3 = L1_3.GetMouseLocation
    L1_3 = L1_3(L2_3)
    L8_2 = L1_3
    L1_3 = A0_3.Changed
    L2_3 = L1_3
    L1_3 = L1_3.Connect
    
    function L3_3()
      local L0_4, L1_4
      L0_4 = A0_3
      L0_4 = L0_4.UserInputState
      L1_4 = Enum
      L1_4 = L1_4.UserInputState
      L1_4 = L1_4.End
      if L0_4 == L1_4 then
        L0_4 = false
        L4_2 = L0_4
      end
    end
    
    L1_3(L2_3, L3_3)
    ::lbl_30::
  end
  
  L11_2(L12_2, L13_2)
  L11_2 = L3_2.InputChanged
  L12_2 = L11_2
  L11_2 = L11_2.Connect
  
  function L13_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.UserInputType
    L2_3 = Enum
    L2_3 = L2_3.UserInputType
    L2_3 = L2_3.MouseMovement
    if L1_3 ~= L2_3 then
      L1_3 = A0_3.UserInputType
      L2_3 = Enum
      L2_3 = L2_3.UserInputType
      L2_3 = L2_3.Touch
      if L1_3 ~= L2_3 then
        goto lbl_14
      end
    end
    L5_2 = A0_3
    ::lbl_14::
  end
  
  L11_2(L12_2, L13_2)
  L11_2 = L2_2.Heartbeat
  L12_2 = L11_2
  L11_2 = L11_2.Connect
  L13_2 = Update
  L11_2(L12_2, L13_2)
end

L36_1 = coroutine
L36_1 = L36_1.wrap
L37_1 = L35_1
L36_1 = L36_1(L37_1)
L36_1()
L36_1 = L30_1.MouseButton1Down
L37_1 = L36_1
L36_1 = L36_1.Connect

function L38_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = setclipboard
  L1_2 = "https://discord.gg/sdCSmXRjuX"
  L0_2(L1_2)
  L0_2 = L1_1
  L0_2 = L0_2.new
  L1_2 = "success"
  L2_2 = "Copied"
  L3_2 = "Copied discord link to clipboard"
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  mhm131313 = L0_2
  L0_2 = mhm131313
  L1_2 = L0_2
  L0_2 = L0_2.deleteTimeout
  L2_2 = 2
  L0_2(L1_2, L2_2)
end

L36_1(L37_1, L38_1)
L36_1 = L15_1.MouseButton1Click
L37_1 = L36_1
L36_1 = L36_1.Connect

function L38_1()
  local L0_2, L1_2, L2_2
  L0_2 = bn9ksmsnMSLOS012S
  L1_2 = "bHSHsmd019sksasd"
  L2_2 = L10_1
  L2_2 = L2_2.Text
  L0_2(L1_2, L2_2)
end

L36_1(L37_1, L38_1)
