local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1, L123_1, L124_1, L125_1, L126_1, L127_1, L128_1, L129_1, L130_1, L131_1, L132_1, L133_1, L134_1, L135_1, L136_1, L137_1, L138_1
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
L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1, L123_1, L124_1, L125_1, L126_1, L127_1, L128_1, L129_1, L130_1, L131_1, L132_1, L133_1, L134_1, L135_1, L136_1, L137_1, L138_1 = L2_1(L3_1)
L1_1, L2_1, L3_1 = L1_1(L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1, L123_1, L124_1, L125_1, L126_1, L127_1, L128_1, L129_1, L130_1, L131_1, L132_1, L133_1, L134_1, L135_1, L136_1, L137_1, L138_1)
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
L1_1 = Instance
L1_1 = L1_1.new
L2_1 = "ScreenGui"
L1_1 = L1_1(L2_1)
L2_1 = Instance
L2_1 = L2_1.new
L3_1 = "Frame"
L2_1 = L2_1(L3_1)
L3_1 = Instance
L3_1 = L3_1.new
L4_1 = "UICorner"
L3_1 = L3_1(L4_1)
L4_1 = Instance
L4_1 = L4_1.new
L5_1 = "Frame"
L4_1 = L4_1(L5_1)
L5_1 = Instance
L5_1 = L5_1.new
L6_1 = "ImageLabel"
L5_1 = L5_1(L6_1)
L6_1 = Instance
L6_1 = L6_1.new
L7_1 = "Frame"
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
L10_1 = "Frame"
L9_1 = L9_1(L10_1)
L10_1 = Instance
L10_1 = L10_1.new
L11_1 = "Frame"
L10_1 = L10_1(L11_1)
L11_1 = Instance
L11_1 = L11_1.new
L12_1 = "UICorner"
L11_1 = L11_1(L12_1)
L12_1 = Instance
L12_1 = L12_1.new
L13_1 = "UIPadding"
L12_1 = L12_1(L13_1)
L13_1 = Instance
L13_1 = L13_1.new
L14_1 = "UIListLayout"
L13_1 = L13_1(L14_1)
L14_1 = Instance
L14_1 = L14_1.new
L15_1 = "TextButton"
L14_1 = L14_1(L15_1)
L15_1 = Instance
L15_1 = L15_1.new
L16_1 = "UIPadding"
L15_1 = L15_1(L16_1)
L16_1 = Instance
L16_1 = L16_1.new
L17_1 = "TextLabel"
L16_1 = L16_1(L17_1)
L17_1 = Instance
L17_1 = L17_1.new
L18_1 = "ImageLabel"
L17_1 = L17_1(L18_1)
L18_1 = Instance
L18_1 = L18_1.new
L19_1 = "TextButton"
L18_1 = L18_1(L19_1)
L19_1 = Instance
L19_1 = L19_1.new
L20_1 = "UIPadding"
L19_1 = L19_1(L20_1)
L20_1 = Instance
L20_1 = L20_1.new
L21_1 = "TextLabel"
L20_1 = L20_1(L21_1)
L21_1 = Instance
L21_1 = L21_1.new
L22_1 = "ImageLabel"
L21_1 = L21_1(L22_1)
L22_1 = Instance
L22_1 = L22_1.new
L23_1 = "TextButton"
L22_1 = L22_1(L23_1)
L23_1 = Instance
L23_1 = L23_1.new
L24_1 = "UIPadding"
L23_1 = L23_1(L24_1)
L24_1 = Instance
L24_1 = L24_1.new
L25_1 = "TextLabel"
L24_1 = L24_1(L25_1)
L25_1 = Instance
L25_1 = L25_1.new
L26_1 = "ImageLabel"
L25_1 = L25_1(L26_1)
L26_1 = Instance
L26_1 = L26_1.new
L27_1 = "Frame"
L26_1 = L26_1(L27_1)
L27_1 = Instance
L27_1 = L27_1.new
L28_1 = "UICorner"
L27_1 = L27_1(L28_1)
L28_1 = Instance
L28_1 = L28_1.new
L29_1 = "Frame"
L28_1 = L28_1(L29_1)
L29_1 = Instance
L29_1 = L29_1.new
L30_1 = "TextLabel"
L29_1 = L29_1(L30_1)
L30_1 = Instance
L30_1 = L30_1.new
L31_1 = "UIPadding"
L30_1 = L30_1(L31_1)
L31_1 = Instance
L31_1 = L31_1.new
L32_1 = "UIListLayout"
L31_1 = L31_1(L32_1)
L32_1 = Instance
L32_1 = L32_1.new
L33_1 = "Frame"
L32_1 = L32_1(L33_1)
L33_1 = Instance
L33_1 = L33_1.new
L34_1 = "TextButton"
L33_1 = L33_1(L34_1)
L34_1 = Instance
L34_1 = L34_1.new
L35_1 = "UICorner"
L34_1 = L34_1(L35_1)
L35_1 = Instance
L35_1 = L35_1.new
L36_1 = "TextButton"
L35_1 = L35_1(L36_1)
L36_1 = Instance
L36_1 = L36_1.new
L37_1 = "UICorner"
L36_1 = L36_1(L37_1)
L37_1 = Instance
L37_1 = L37_1.new
L38_1 = "TextLabel"
L37_1 = L37_1(L38_1)
L38_1 = Instance
L38_1 = L38_1.new
L39_1 = "UIPadding"
L38_1 = L38_1(L39_1)
L39_1 = Instance
L39_1 = L39_1.new
L40_1 = "TextButton"
L39_1 = L39_1(L40_1)
L40_1 = Instance
L40_1 = L40_1.new
L41_1 = "UIPadding"
L40_1 = L40_1(L41_1)
L41_1 = Instance
L41_1 = L41_1.new
L42_1 = "ImageLabel"
L41_1 = L41_1(L42_1)
L42_1 = Instance
L42_1 = L42_1.new
L43_1 = "TextButton"
L42_1 = L42_1(L43_1)
L43_1 = Instance
L43_1 = L43_1.new
L44_1 = "UIPadding"
L43_1 = L43_1(L44_1)
L44_1 = Instance
L44_1 = L44_1.new
L45_1 = "ImageLabel"
L44_1 = L44_1(L45_1)
L45_1 = Instance
L45_1 = L45_1.new
L46_1 = "TextButton"
L45_1 = L45_1(L46_1)
L46_1 = Instance
L46_1 = L46_1.new
L47_1 = "UIPadding"
L46_1 = L46_1(L47_1)
L47_1 = Instance
L47_1 = L47_1.new
L48_1 = "ImageLabel"
L47_1 = L47_1(L48_1)
L48_1 = Instance
L48_1 = L48_1.new
L49_1 = "Frame"
L48_1 = L48_1(L49_1)
L49_1 = Instance
L49_1 = L49_1.new
L50_1 = "TextButton"
L49_1 = L49_1(L50_1)
L50_1 = Instance
L50_1 = L50_1.new
L51_1 = "UICorner"
L50_1 = L50_1(L51_1)
L51_1 = Instance
L51_1 = L51_1.new
L52_1 = "TextButton"
L51_1 = L51_1(L52_1)
L52_1 = Instance
L52_1 = L52_1.new
L53_1 = "UICorner"
L52_1 = L52_1(L53_1)
L53_1 = Instance
L53_1 = L53_1.new
L54_1 = "TextLabel"
L53_1 = L53_1(L54_1)
L54_1 = Instance
L54_1 = L54_1.new
L55_1 = "UIPadding"
L54_1 = L54_1(L55_1)
L55_1 = Instance
L55_1 = L55_1.new
L56_1 = "Frame"
L55_1 = L55_1(L56_1)
L56_1 = Instance
L56_1 = L56_1.new
L57_1 = "TextButton"
L56_1 = L56_1(L57_1)
L57_1 = Instance
L57_1 = L57_1.new
L58_1 = "UICorner"
L57_1 = L57_1(L58_1)
L58_1 = Instance
L58_1 = L58_1.new
L59_1 = "TextBox"
L58_1 = L58_1(L59_1)
L59_1 = Instance
L59_1 = L59_1.new
L60_1 = "UICorner"
L59_1 = L59_1(L60_1)
L60_1 = Instance
L60_1 = L60_1.new
L61_1 = "TextButton"
L60_1 = L60_1(L61_1)
L61_1 = Instance
L61_1 = L61_1.new
L62_1 = "UICorner"
L61_1 = L61_1(L62_1)
L62_1 = Instance
L62_1 = L62_1.new
L63_1 = "TextLabel"
L62_1 = L62_1(L63_1)
L63_1 = Instance
L63_1 = L63_1.new
L64_1 = "UIPadding"
L63_1 = L63_1(L64_1)
L64_1 = Instance
L64_1 = L64_1.new
L65_1 = "TextButton"
L64_1 = L64_1(L65_1)
L65_1 = Instance
L65_1 = L65_1.new
L66_1 = "UIPadding"
L65_1 = L65_1(L66_1)
L66_1 = Instance
L66_1 = L66_1.new
L67_1 = "ImageLabel"
L66_1 = L66_1(L67_1)
L67_1 = Instance
L67_1 = L67_1.new
L68_1 = "Frame"
L67_1 = L67_1(L68_1)
L68_1 = Instance
L68_1 = L68_1.new
L69_1 = "TextLabel"
L68_1 = L68_1(L69_1)
L69_1 = Instance
L69_1 = L69_1.new
L70_1 = "UIPadding"
L69_1 = L69_1(L70_1)
L70_1 = Instance
L70_1 = L70_1.new
L71_1 = "UIListLayout"
L70_1 = L70_1(L71_1)
L71_1 = Instance
L71_1 = L71_1.new
L72_1 = "TextButton"
L71_1 = L71_1(L72_1)
L72_1 = Instance
L72_1 = L72_1.new
L73_1 = "UIPadding"
L72_1 = L72_1(L73_1)
L73_1 = Instance
L73_1 = L73_1.new
L74_1 = "ImageLabel"
L73_1 = L73_1(L74_1)
L74_1 = Instance
L74_1 = L74_1.new
L75_1 = "TextButton"
L74_1 = L74_1(L75_1)
L75_1 = Instance
L75_1 = L75_1.new
L76_1 = "UIPadding"
L75_1 = L75_1(L76_1)
L76_1 = Instance
L76_1 = L76_1.new
L77_1 = "ImageLabel"
L76_1 = L76_1(L77_1)
L77_1 = Instance
L77_1 = L77_1.new
L78_1 = "TextButton"
L77_1 = L77_1(L78_1)
L78_1 = Instance
L78_1 = L78_1.new
L79_1 = "UICorner"
L78_1 = L78_1(L79_1)
L79_1 = Instance
L79_1 = L79_1.new
L80_1 = "TextButton"
L79_1 = L79_1(L80_1)
L80_1 = Instance
L80_1 = L80_1.new
L81_1 = "UIPadding"
L80_1 = L80_1(L81_1)
L81_1 = Instance
L81_1 = L81_1.new
L82_1 = "ImageLabel"
L81_1 = L81_1(L82_1)
L82_1 = Instance
L82_1 = L82_1.new
L83_1 = "TextButton"
L82_1 = L82_1(L83_1)
L83_1 = Instance
L83_1 = L83_1.new
L84_1 = "ImageLabel"
L83_1 = L83_1(L84_1)
L84_1 = Instance
L84_1 = L84_1.new
L85_1 = "UIPadding"
L84_1 = L84_1(L85_1)
L85_1 = Instance
L85_1 = L85_1.new
L86_1 = "Frame"
L85_1 = L85_1(L86_1)
L86_1 = Instance
L86_1 = L86_1.new
L87_1 = "TextLabel"
L86_1 = L86_1(L87_1)
L87_1 = Instance
L87_1 = L87_1.new
L88_1 = "UIPadding"
L87_1 = L87_1(L88_1)
L88_1 = Instance
L88_1 = L88_1.new
L89_1 = "UIListLayout"
L88_1 = L88_1(L89_1)
L89_1 = Instance
L89_1 = L89_1.new
L90_1 = "TextButton"
L89_1 = L89_1(L90_1)
L90_1 = Instance
L90_1 = L90_1.new
L91_1 = "UIPadding"
L90_1 = L90_1(L91_1)
L91_1 = Instance
L91_1 = L91_1.new
L92_1 = "ImageLabel"
L91_1 = L91_1(L92_1)
L92_1 = Instance
L92_1 = L92_1.new
L93_1 = "TextBox"
L92_1 = L92_1(L93_1)
L93_1 = Instance
L93_1 = L93_1.new
L94_1 = "UICorner"
L93_1 = L93_1(L94_1)
L94_1 = Instance
L94_1 = L94_1.new
L95_1 = "TextButton"
L94_1 = L94_1(L95_1)
L95_1 = Instance
L95_1 = L95_1.new
L96_1 = "UIPadding"
L95_1 = L95_1(L96_1)
L96_1 = Instance
L96_1 = L96_1.new
L97_1 = "ImageLabel"
L96_1 = L96_1(L97_1)
L97_1 = Instance
L97_1 = L97_1.new
L98_1 = "TextBox"
L97_1 = L97_1(L98_1)
L98_1 = Instance
L98_1 = L98_1.new
L99_1 = "UICorner"
L98_1 = L98_1(L99_1)
L99_1 = Instance
L99_1 = L99_1.new
L100_1 = "TextButton"
L99_1 = L99_1(L100_1)
L100_1 = Instance
L100_1 = L100_1.new
L101_1 = "UIPadding"
L100_1 = L100_1(L101_1)
L101_1 = Instance
L101_1 = L101_1.new
L102_1 = "ImageLabel"
L101_1 = L101_1(L102_1)
L102_1 = Instance
L102_1 = L102_1.new
L103_1 = "TextButton"
L102_1 = L102_1(L103_1)
L103_1 = Instance
L103_1 = L103_1.new
L104_1 = "UICorner"
L103_1 = L103_1(L104_1)
L104_1 = Instance
L104_1 = L104_1.new
L105_1 = "Frame"
L104_1 = L104_1(L105_1)
L105_1 = Instance
L105_1 = L105_1.new
L106_1 = "TextButton"
L105_1 = L105_1(L106_1)
L106_1 = Instance
L106_1 = L106_1.new
L107_1 = "UICorner"
L106_1 = L106_1(L107_1)
L107_1 = Instance
L107_1 = L107_1.new
L108_1 = "TextLabel"
L107_1 = L107_1(L108_1)
L108_1 = Instance
L108_1 = L108_1.new
L109_1 = "UIPadding"
L108_1 = L108_1(L109_1)
L109_1 = Instance
L109_1 = L109_1.new
L110_1 = "TextButton"
L109_1 = L109_1(L110_1)
L110_1 = Instance
L110_1 = L110_1.new
L111_1 = "UIPadding"
L110_1 = L110_1(L111_1)
L111_1 = Instance
L111_1 = L111_1.new
L112_1 = "ImageLabel"
L111_1 = L111_1(L112_1)
L112_1 = Instance
L112_1 = L112_1.new
L113_1 = "TextButton"
L112_1 = L112_1(L113_1)
L113_1 = Instance
L113_1 = L113_1.new
L114_1 = "UIPadding"
L113_1 = L113_1(L114_1)
L114_1 = Instance
L114_1 = L114_1.new
L115_1 = "ImageLabel"
L114_1 = L114_1(L115_1)
L1_1.Name = "ScreenGUI"
L115_1 = game
L115_1 = L115_1.CoreGui
L1_1.Parent = L115_1
L2_1.Name = "LIGHTUX"
L2_1.Parent = L1_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L2_1.BackgroundColor3 = L115_1
L2_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.31115216
L117_1 = 0
L118_1 = 0.293827146
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L2_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 613
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L2_1.Size = L115_1
L2_1.Active = true
L2_1.Draggable = true
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L3_1.CornerRadius = L115_1
L3_1.Parent = L2_1
L4_1.Name = "DropShadowHolder"
L4_1.Parent = L2_1
L4_1.BackgroundTransparency = 1
L4_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 1
L117_1 = 0
L118_1 = 1
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L4_1.Size = L115_1
L4_1.ZIndex = 0
L5_1.Name = "DropShadow"
L5_1.Parent = L4_1
L115_1 = Vector2
L115_1 = L115_1.new
L116_1 = 0.5
L117_1 = 0.5
L115_1 = L115_1(L116_1, L117_1)
L5_1.AnchorPoint = L115_1
L5_1.BackgroundTransparency = 1
L5_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.5
L117_1 = 0
L118_1 = 0.5
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L5_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 1
L117_1 = 47
L118_1 = 1
L119_1 = 47
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L5_1.Size = L115_1
L5_1.ZIndex = 0
L5_1.Image = "rbxassetid://6014261993"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L5_1.ImageColor3 = L115_1
L5_1.ImageTransparency = 0.5
L115_1 = Enum
L115_1 = L115_1.ScaleType
L115_1 = L115_1.Slice
L5_1.ScaleType = L115_1
L115_1 = Rect
L115_1 = L115_1.new
L116_1 = 49
L117_1 = 49
L118_1 = 450
L119_1 = 450
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L5_1.SliceCenter = L115_1
L6_1.Name = "Navigation"
L6_1.Parent = L2_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 4
L117_1 = 9
L118_1 = 16
L115_1 = L115_1(L116_1, L117_1, L118_1)
L6_1.BackgroundColor3 = L115_1
L6_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 213
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L6_1.Size = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L7_1.CornerRadius = L115_1
L7_1.Parent = L6_1
L8_1.Name = "HIDDEN"
L8_1.Parent = L6_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 4
L117_1 = 9
L118_1 = 16
L115_1 = L115_1(L116_1, L117_1, L118_1)
L8_1.BackgroundColor3 = L115_1
L8_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0469483584
L117_1 = 0
L118_1 = 0
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L8_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 203
L118_1 = 0
L119_1 = 9
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L8_1.Size = L115_1
L9_1.Name = "HIDDEN"
L9_1.Parent = L6_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 4
L117_1 = 9
L118_1 = 16
L115_1 = L115_1(L116_1, L117_1, L118_1)
L9_1.BackgroundColor3 = L115_1
L9_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0469483584
L117_1 = 0
L118_1 = 0.972972989
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L9_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 203
L118_1 = 0
L119_1 = 9
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L9_1.Size = L115_1
L10_1.Name = "ButtonsHolder"
L10_1.Parent = L6_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 4
L117_1 = 9
L118_1 = 16
L115_1 = L115_1(L116_1, L117_1, L118_1)
L10_1.BackgroundColor3 = L115_1
L10_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 213
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L10_1.Size = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L11_1.CornerRadius = L115_1
L11_1.Parent = L10_1
L12_1.Parent = L10_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 8
L115_1 = L115_1(L116_1, L117_1)
L12_1.PaddingBottom = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 8
L115_1 = L115_1(L116_1, L117_1)
L12_1.PaddingTop = L115_1
L13_1.Parent = L10_1
L115_1 = Enum
L115_1 = L115_1.SortOrder
L115_1 = L115_1.LayoutOrder
L13_1.SortOrder = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 1
L115_1 = L115_1(L116_1, L117_1)
L13_1.Padding = L115_1
L14_1.Name = "CombatButton"
L14_1.Parent = L10_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L14_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.00469483575
L117_1 = 0
L118_1 = 0.321766555
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L14_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 214
L118_1 = 0
L119_1 = 50
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L14_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.ArialBold
L14_1.Font = L115_1
L14_1.Text = "Combat"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L14_1.TextColor3 = L115_1
L14_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L14_1.TextXAlignment = L115_1
L15_1.Parent = L14_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 20
L115_1 = L115_1(L116_1, L117_1)
L15_1.PaddingBottom = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 50
L115_1 = L115_1(L116_1, L117_1)
L15_1.PaddingLeft = L115_1
L16_1.Name = "INFO"
L16_1.Parent = L14_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L16_1.BackgroundColor3 = L115_1
L16_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.00613496918
L117_1 = 0
L118_1 = 0.899999976
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L16_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 156
L118_1 = 0
L119_1 = 14
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L16_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L16_1.Font = L115_1
L16_1.Text = "Silent Aim, Autofarm, Hitbox"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 186
L117_1 = 186
L118_1 = 186
L115_1 = L115_1(L116_1, L117_1, L118_1)
L16_1.TextColor3 = L115_1
L16_1.TextSize = 14
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L16_1.TextXAlignment = L115_1
L115_1 = Enum
L115_1 = L115_1.TextYAlignment
L115_1 = L115_1.Top
L16_1.TextYAlignment = L115_1
L17_1.Name = "Icon"
L17_1.Parent = L14_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L17_1.BackgroundColor3 = L115_1
L17_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.261999995
L117_1 = 0
L118_1 = 0.200000003
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L17_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 36
L118_1 = 0
L119_1 = 35
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L17_1.Size = L115_1
L17_1.Image = "http://www.roblox.com/asset/?id=11378036715"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L17_1.ImageColor3 = L115_1
L18_1.Name = "PlayerButton"
L18_1.Parent = L10_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L18_1.BackgroundColor3 = L115_1
L18_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.00469483575
L117_1 = 0
L118_1 = 0.324921131
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L18_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 214
L118_1 = 0
L119_1 = 50
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L18_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.ArialBold
L18_1.Font = L115_1
L18_1.Text = "Player"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L18_1.TextColor3 = L115_1
L18_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L18_1.TextXAlignment = L115_1
L19_1.Parent = L18_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 20
L115_1 = L115_1(L116_1, L117_1)
L19_1.PaddingBottom = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 50
L115_1 = L115_1(L116_1, L117_1)
L19_1.PaddingLeft = L115_1
L20_1.Name = "INFO"
L20_1.Parent = L18_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L20_1.BackgroundColor3 = L115_1
L20_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.00613496918
L117_1 = 0
L118_1 = 0.899999976
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L20_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 156
L118_1 = 0
L119_1 = 14
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L20_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L20_1.Font = L115_1
L20_1.Text = "Speed, JumpPower, Fly"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 186
L117_1 = 186
L118_1 = 186
L115_1 = L115_1(L116_1, L117_1, L118_1)
L20_1.TextColor3 = L115_1
L20_1.TextSize = 14
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L20_1.TextXAlignment = L115_1
L115_1 = Enum
L115_1 = L115_1.TextYAlignment
L115_1 = L115_1.Top
L20_1.TextYAlignment = L115_1
L21_1.Name = "Icon"
L21_1.Parent = L18_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L21_1.BackgroundColor3 = L115_1
L21_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.261999995
L117_1 = 0
L118_1 = 0.200000003
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L21_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 36
L118_1 = 0
L119_1 = 35
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L21_1.Size = L115_1
L21_1.Image = "http://www.roblox.com/asset/?id=11378105473"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L21_1.ImageColor3 = L115_1
L22_1.Name = "SettingButton"
L22_1.Parent = L10_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L22_1.BackgroundColor3 = L115_1
L22_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.00469483575
L117_1 = 0
L118_1 = 0.321766555
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L22_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 214
L118_1 = 0
L119_1 = 50
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L22_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.ArialBold
L22_1.Font = L115_1
L22_1.Text = "Setting"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L22_1.TextColor3 = L115_1
L22_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L22_1.TextXAlignment = L115_1
L23_1.Parent = L22_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 20
L115_1 = L115_1(L116_1, L117_1)
L23_1.PaddingBottom = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 50
L115_1 = L115_1(L116_1, L117_1)
L23_1.PaddingLeft = L115_1
L24_1.Name = "INFO"
L24_1.Parent = L22_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L24_1.BackgroundColor3 = L115_1
L24_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.00613496918
L117_1 = 0
L118_1 = 0.899999976
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L24_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 156
L118_1 = 0
L119_1 = 14
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L24_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L24_1.Font = L115_1
L24_1.Text = "Credits, Discord, UI Toggle"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 186
L117_1 = 186
L118_1 = 186
L115_1 = L115_1(L116_1, L117_1, L118_1)
L24_1.TextColor3 = L115_1
L24_1.TextSize = 14
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L24_1.TextXAlignment = L115_1
L115_1 = Enum
L115_1 = L115_1.TextYAlignment
L115_1 = L115_1.Top
L24_1.TextYAlignment = L115_1
L25_1.Name = "Icon"
L25_1.Parent = L22_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L25_1.BackgroundColor3 = L115_1
L25_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.261999995
L117_1 = 0
L118_1 = 0.200000003
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L25_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 36
L118_1 = 0
L119_1 = 35
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L25_1.Size = L115_1
L25_1.Image = "http://www.roblox.com/asset/?id=11378125026"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L25_1.ImageColor3 = L115_1
L26_1.Name = "PageHolder"
L26_1.Parent = L2_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L26_1.BackgroundColor3 = L115_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 27
L117_1 = 42
L118_1 = 53
L115_1 = L115_1(L116_1, L117_1, L118_1)
L26_1.BorderColor3 = L115_1
L26_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.349102765
L117_1 = 0
L118_1 = -4.67203034E-4
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L26_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L26_1.Size = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L27_1.CornerRadius = L115_1
L27_1.Parent = L26_1
L28_1.Name = "CombatPage"
L28_1.Parent = L26_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L28_1.BackgroundColor3 = L115_1
L28_1.BackgroundTransparency = 1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 27
L117_1 = 42
L118_1 = 53
L115_1 = L115_1(L116_1, L117_1, L118_1)
L28_1.BorderColor3 = L115_1
L28_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.00160679221
L117_1 = 0
L118_1 = -4.67203034E-4
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L28_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L28_1.Size = L115_1
L29_1.Name = "Combattitle"
L29_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L29_1.BackgroundColor3 = L115_1
L29_1.BackgroundTransparency = 1
L29_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L29_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 380
L118_1 = 0
L119_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L29_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.ArialBold
L29_1.Font = L115_1
L29_1.Text = "Combat"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L29_1.TextColor3 = L115_1
L29_1.TextSize = 25
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L29_1.TextXAlignment = L115_1
L30_1.Parent = L29_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 20
L115_1 = L115_1(L116_1, L117_1)
L30_1.PaddingLeft = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 13
L115_1 = L115_1(L116_1, L117_1)
L30_1.PaddingTop = L115_1
L31_1.Parent = L28_1
L115_1 = Enum
L115_1 = L115_1.SortOrder
L115_1 = L115_1.LayoutOrder
L31_1.SortOrder = L115_1
L32_1.Name = "AutoFarm"
L32_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L32_1.BackgroundColor3 = L115_1
L32_1.BackgroundTransparency = 1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 27
L117_1 = 42
L118_1 = 53
L115_1 = L115_1(L116_1, L117_1, L118_1)
L32_1.BorderColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 0
L118_1 = 0.369369388
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L32_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L32_1.Size = L115_1
L33_1.Name = "FarmOff"
L33_1.Parent = L32_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L33_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L33_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L33_1.Size = L115_1
L33_1.Visible = false
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L33_1.Font = L115_1
L33_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L33_1.TextColor3 = L115_1
L33_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L34_1.CornerRadius = L115_1
L34_1.Parent = L33_1
L35_1.Name = "FarmOn"
L35_1.Parent = L32_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L35_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L35_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L35_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L35_1.Font = L115_1
L35_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L35_1.TextColor3 = L115_1
L35_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L36_1.CornerRadius = L115_1
L36_1.Parent = L35_1
L37_1.Parent = L32_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L37_1.BackgroundColor3 = L115_1
L37_1.BackgroundTransparency = 1
L37_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 27
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L37_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L37_1.Font = L115_1
L37_1.Text = "Autofarm"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L37_1.TextColor3 = L115_1
L37_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L37_1.TextXAlignment = L115_1
L38_1.Parent = L37_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L38_1.PaddingLeft = L115_1
L39_1.Name = "SilentAimZombiesButton"
L39_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L39_1.BackgroundColor3 = L115_1
L39_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.00250626775
L117_1 = 0
L118_1 = 0.279279262
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L39_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L39_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L39_1.Font = L115_1
L39_1.Text = "Silent Aim Zombies"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L39_1.TextColor3 = L115_1
L39_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L39_1.TextXAlignment = L115_1
L40_1.Parent = L39_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L40_1.PaddingLeft = L115_1
L41_1.Parent = L39_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L41_1.BackgroundColor3 = L115_1
L41_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972735286
L117_1 = 0
L118_1 = 0.107142881
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L41_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L41_1.Size = L115_1
L41_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L41_1.ImageColor3 = L115_1
L42_1.Name = "SilentAimBossesButton"
L42_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L42_1.BackgroundColor3 = L115_1
L42_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0651629046
L117_1 = 0
L118_1 = 1.14414418
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L42_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L42_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L42_1.Font = L115_1
L42_1.Text = "Silent Aim Bosses"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L42_1.TextColor3 = L115_1
L42_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L42_1.TextXAlignment = L115_1
L43_1.Parent = L42_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L43_1.PaddingLeft = L115_1
L44_1.Parent = L42_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L44_1.BackgroundColor3 = L115_1
L44_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972735286
L117_1 = 0
L118_1 = 0.107142881
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L44_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L44_1.Size = L115_1
L44_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L44_1.ImageColor3 = L115_1
L45_1.Name = "HeadHitboxExtenderButton"
L45_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L45_1.BackgroundColor3 = L115_1
L45_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.696741819
L117_1 = 0
L118_1 = 0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L45_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L45_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L45_1.Font = L115_1
L45_1.Text = "Extend Head Hitbox"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L45_1.TextColor3 = L115_1
L45_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L45_1.TextXAlignment = L115_1
L46_1.Parent = L45_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L46_1.PaddingLeft = L115_1
L47_1.Parent = L45_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L47_1.BackgroundColor3 = L115_1
L47_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972735286
L117_1 = 0
L118_1 = 0.107142881
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L47_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L47_1.Size = L115_1
L47_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L47_1.ImageColor3 = L115_1
L48_1.Name = "PowerupFrame"
L48_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L48_1.BackgroundColor3 = L115_1
L48_1.BackgroundTransparency = 1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 27
L117_1 = 42
L118_1 = 53
L115_1 = L115_1(L116_1, L117_1, L118_1)
L48_1.BorderColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 0
L118_1 = 0.369369388
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L48_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L48_1.Size = L115_1
L49_1.Name = "PowerupsONToggle"
L49_1.Parent = L48_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L49_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L49_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L49_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L49_1.Font = L115_1
L49_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L49_1.TextColor3 = L115_1
L49_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L50_1.CornerRadius = L115_1
L50_1.Parent = L49_1
L51_1.Name = "PowerupsOFFToggle"
L51_1.Parent = L48_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L51_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L51_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L51_1.Size = L115_1
L51_1.Visible = false
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L51_1.Font = L115_1
L51_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L51_1.TextColor3 = L115_1
L51_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L52_1.CornerRadius = L115_1
L52_1.Parent = L51_1
L53_1.Parent = L48_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L53_1.BackgroundColor3 = L115_1
L53_1.BackgroundTransparency = 1
L53_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 27
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L53_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L53_1.Font = L115_1
L53_1.Text = "Collect Powerups"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L53_1.TextColor3 = L115_1
L53_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L53_1.TextXAlignment = L115_1
L54_1.Parent = L53_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L54_1.PaddingLeft = L115_1
L55_1.Name = "AutoEquipFrame"
L55_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L55_1.BackgroundColor3 = L115_1
L55_1.BackgroundTransparency = 1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 27
L117_1 = 42
L118_1 = 53
L115_1 = L115_1(L116_1, L117_1, L118_1)
L55_1.BorderColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 0
L118_1 = 0.369369388
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L55_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L55_1.Size = L115_1
L56_1.Name = "UnEquipToggle"
L56_1.Parent = L55_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L56_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L56_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L56_1.Size = L115_1
L56_1.Visible = false
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L56_1.Font = L115_1
L56_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L56_1.TextColor3 = L115_1
L56_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L57_1.CornerRadius = L115_1
L57_1.Parent = L56_1
L58_1.Name = "weapon"
L58_1.Parent = L55_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L58_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.709273219
L117_1 = 0
L118_1 = 0.035714291
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L58_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 107
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L58_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L58_1.Font = L115_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 178
L117_1 = 178
L118_1 = 178
L115_1 = L115_1(L116_1, L117_1, L118_1)
L58_1.PlaceholderColor3 = L115_1
L58_1.PlaceholderText = "Weapon Name"
L58_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L58_1.TextColor3 = L115_1
L58_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L59_1.CornerRadius = L115_1
L59_1.Parent = L58_1
L60_1.Name = "AutoEquipToggle"
L60_1.Parent = L55_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L60_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L60_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L60_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L60_1.Font = L115_1
L60_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L60_1.TextColor3 = L115_1
L60_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L61_1.CornerRadius = L115_1
L61_1.Parent = L60_1
L62_1.Parent = L55_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L62_1.BackgroundColor3 = L115_1
L62_1.BackgroundTransparency = 1
L62_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 0
L118_1 = -0.035714291
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L62_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 27
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L62_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L62_1.Font = L115_1
L62_1.Text = "Auto Equip"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L62_1.TextColor3 = L115_1
L62_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L62_1.TextXAlignment = L115_1
L63_1.Parent = L62_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L63_1.PaddingLeft = L115_1
L64_1.Name = "AntiAfkButton"
L64_1.Parent = L28_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L64_1.BackgroundColor3 = L115_1
L64_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L64_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L64_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L64_1.Font = L115_1
L64_1.Text = "Anti-AFK"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L64_1.TextColor3 = L115_1
L64_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L64_1.TextXAlignment = L115_1
L65_1.Parent = L64_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L65_1.PaddingLeft = L115_1
L66_1.Parent = L64_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L66_1.BackgroundColor3 = L115_1
L66_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972735286
L117_1 = 0
L118_1 = 0.107142881
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L66_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L66_1.Size = L115_1
L66_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L66_1.ImageColor3 = L115_1
L67_1.Name = "SettingPage"
L67_1.Parent = L26_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L67_1.BackgroundColor3 = L115_1
L67_1.BackgroundTransparency = 1
L67_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.00160679221
L117_1 = 0
L118_1 = -4.67203034E-4
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L67_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L67_1.Size = L115_1
L67_1.Visible = false
L68_1.Name = "PlayerTitle"
L68_1.Parent = L67_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L68_1.BackgroundColor3 = L115_1
L68_1.BackgroundTransparency = 1
L68_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L68_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 380
L118_1 = 0
L119_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L68_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.ArialBold
L68_1.Font = L115_1
L68_1.Text = "Setting"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L68_1.TextColor3 = L115_1
L68_1.TextSize = 25
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L68_1.TextXAlignment = L115_1
L69_1.Parent = L68_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 20
L115_1 = L115_1(L116_1, L117_1)
L69_1.PaddingLeft = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 13
L115_1 = L115_1(L116_1, L117_1)
L69_1.PaddingTop = L115_1
L70_1.Parent = L67_1
L115_1 = Enum
L115_1 = L115_1.SortOrder
L115_1 = L115_1.LayoutOrder
L70_1.SortOrder = L115_1
L71_1.Name = "CopyDiscord"
L71_1.Parent = L67_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L71_1.BackgroundColor3 = L115_1
L71_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L71_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L71_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L71_1.Font = L115_1
L71_1.Text = "Copy Discord Invite"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L71_1.TextColor3 = L115_1
L71_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L71_1.TextXAlignment = L115_1
L72_1.Parent = L71_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L72_1.PaddingLeft = L115_1
L73_1.Parent = L71_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L73_1.BackgroundColor3 = L115_1
L73_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L73_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L73_1.Size = L115_1
L73_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L73_1.ImageColor3 = L115_1
L74_1.Name = "UIToggle"
L74_1.Parent = L67_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L74_1.BackgroundColor3 = L115_1
L74_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L74_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L74_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L74_1.Font = L115_1
L74_1.Text = "Toggle UI"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L74_1.TextColor3 = L115_1
L74_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L74_1.TextXAlignment = L115_1
L75_1.Parent = L74_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L75_1.PaddingLeft = L115_1
L76_1.Parent = L74_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L76_1.BackgroundColor3 = L115_1
L76_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L76_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L76_1.Size = L115_1
L76_1.Image = "http://www.roblox.com/asset/?id=11380635544"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L76_1.ImageColor3 = L115_1
L77_1.Parent = L74_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L77_1.BackgroundColor3 = L115_1
L77_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.904624283
L117_1 = 0
L118_1 = 0.142857105
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L77_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 20
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L77_1.Size = L115_1
L77_1.AutoButtonColor = false
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L77_1.Font = L115_1
L77_1.Text = "L"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 178
L117_1 = 178
L118_1 = 178
L115_1 = L115_1(L116_1, L117_1, L118_1)
L77_1.TextColor3 = L115_1
L77_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L78_1.CornerRadius = L115_1
L78_1.Parent = L77_1
L79_1.Name = "Credits"
L79_1.Parent = L67_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L79_1.BackgroundColor3 = L115_1
L79_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L79_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L79_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L79_1.Font = L115_1
L79_1.Text = "zertic#0948, soder2391#5933, Script owners"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L79_1.TextColor3 = L115_1
L79_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L79_1.TextXAlignment = L115_1
L80_1.Parent = L79_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L80_1.PaddingLeft = L115_1
L81_1.Parent = L79_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L81_1.BackgroundColor3 = L115_1
L81_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L81_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L81_1.Size = L115_1
L81_1.Image = "http://www.roblox.com/asset/?id=11380635544"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L81_1.ImageColor3 = L115_1
L82_1.Name = "Credits"
L82_1.Parent = L67_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L82_1.BackgroundColor3 = L115_1
L82_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L82_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L82_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L82_1.Font = L115_1
L82_1.Text = "Version v1.4"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L82_1.TextColor3 = L115_1
L82_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L82_1.TextXAlignment = L115_1
L83_1.Parent = L82_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L83_1.BackgroundColor3 = L115_1
L83_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L83_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L83_1.Size = L115_1
L83_1.Image = "http://www.roblox.com/asset/?id=11380635544"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L83_1.ImageColor3 = L115_1
L84_1.Parent = L82_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L84_1.PaddingLeft = L115_1
L85_1.Name = "PlayerPage"
L85_1.Parent = L26_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L85_1.BackgroundColor3 = L115_1
L85_1.BackgroundTransparency = 1
L85_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.00160679221
L117_1 = 0
L118_1 = -4.67203034E-4
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L85_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 333
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L85_1.Size = L115_1
L85_1.Visible = false
L86_1.Name = "PlayerTitle"
L86_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 11
L117_1 = 19
L118_1 = 31
L115_1 = L115_1(L116_1, L117_1, L118_1)
L86_1.BackgroundColor3 = L115_1
L86_1.BackgroundTransparency = 1
L86_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L86_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 380
L118_1 = 0
L119_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L86_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.ArialBold
L86_1.Font = L115_1
L86_1.Text = "Player"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L86_1.TextColor3 = L115_1
L86_1.TextSize = 25
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L86_1.TextXAlignment = L115_1
L87_1.Parent = L86_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 20
L115_1 = L115_1(L116_1, L117_1)
L87_1.PaddingLeft = L115_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 13
L115_1 = L115_1(L116_1, L117_1)
L87_1.PaddingTop = L115_1
L88_1.Parent = L85_1
L115_1 = Enum
L115_1 = L115_1.SortOrder
L115_1 = L115_1.LayoutOrder
L88_1.SortOrder = L115_1
L89_1.Name = "setws"
L89_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L89_1.BackgroundColor3 = L115_1
L89_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L89_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L89_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L89_1.Font = L115_1
L89_1.Text = "WalkSpeed"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L89_1.TextColor3 = L115_1
L89_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L89_1.TextXAlignment = L115_1
L90_1.Parent = L89_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L90_1.PaddingLeft = L115_1
L91_1.Parent = L89_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L91_1.BackgroundColor3 = L115_1
L91_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L91_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L91_1.Size = L115_1
L91_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L91_1.ImageColor3 = L115_1
L92_1.Name = "wsinput"
L92_1.Parent = L89_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L92_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.661291957
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L92_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 107
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L92_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L92_1.Font = L115_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 178
L117_1 = 178
L118_1 = 178
L115_1 = L115_1(L116_1, L117_1, L118_1)
L92_1.PlaceholderColor3 = L115_1
L92_1.PlaceholderText = "Value"
L92_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L92_1.TextColor3 = L115_1
L92_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L93_1.CornerRadius = L115_1
L93_1.Parent = L92_1
L94_1.Name = "setjp"
L94_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L94_1.BackgroundColor3 = L115_1
L94_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L94_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L94_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L94_1.Font = L115_1
L94_1.Text = "JumpPower"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L94_1.TextColor3 = L115_1
L94_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L94_1.TextXAlignment = L115_1
L95_1.Parent = L94_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L95_1.PaddingLeft = L115_1
L96_1.Parent = L94_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L96_1.BackgroundColor3 = L115_1
L96_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L96_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L96_1.Size = L115_1
L96_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L96_1.ImageColor3 = L115_1
L97_1.Name = "jpinput"
L97_1.Parent = L94_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L97_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.661291957
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L97_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 107
L118_1 = 0
L119_1 = 22
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L97_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L97_1.Font = L115_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 178
L117_1 = 178
L118_1 = 178
L115_1 = L115_1(L116_1, L117_1, L118_1)
L97_1.PlaceholderColor3 = L115_1
L97_1.PlaceholderText = "Value"
L97_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L97_1.TextColor3 = L115_1
L97_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L98_1.CornerRadius = L115_1
L98_1.Parent = L97_1
L99_1.Name = "FlyButton"
L99_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L99_1.BackgroundColor3 = L115_1
L99_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L99_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L99_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L99_1.Font = L115_1
L99_1.Text = "Fly"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L99_1.TextColor3 = L115_1
L99_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L99_1.TextXAlignment = L115_1
L100_1.Parent = L99_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L100_1.PaddingLeft = L115_1
L101_1.Parent = L99_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L101_1.BackgroundColor3 = L115_1
L101_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L101_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L101_1.Size = L115_1
L101_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L101_1.ImageColor3 = L115_1
L102_1.Parent = L99_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L102_1.BackgroundColor3 = L115_1
L102_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.904624283
L117_1 = 0
L118_1 = 0.142857105
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L102_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 20
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L102_1.Size = L115_1
L102_1.AutoButtonColor = false
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L102_1.Font = L115_1
L102_1.Text = "F"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 178
L117_1 = 178
L118_1 = 178
L115_1 = L115_1(L116_1, L117_1, L118_1)
L102_1.TextColor3 = L115_1
L102_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L103_1.CornerRadius = L115_1
L103_1.Parent = L102_1
L104_1.Name = "InfiniiteJumpFrame"
L104_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L104_1.BackgroundColor3 = L115_1
L104_1.BackgroundTransparency = 1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 27
L117_1 = 42
L118_1 = 53
L115_1 = L115_1(L116_1, L117_1, L118_1)
L104_1.BorderColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 0
L118_1 = 0.369369388
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L104_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L104_1.Size = L115_1
L105_1.Name = "InfiniteJumpToggle"
L105_1.Parent = L104_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 29
L117_1 = 40
L118_1 = 58
L115_1 = L115_1(L116_1, L117_1, L118_1)
L105_1.BackgroundColor3 = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = 0.107142858
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L105_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 24
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L105_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSans
L105_1.Font = L115_1
L105_1.Text = ""
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 0
L118_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1)
L105_1.TextColor3 = L115_1
L105_1.TextSize = 14
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 4
L115_1 = L115_1(L116_1, L117_1)
L106_1.CornerRadius = L115_1
L106_1.Parent = L105_1
L107_1.Parent = L104_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L107_1.BackgroundColor3 = L115_1
L107_1.BackgroundTransparency = 1
L107_1.BorderSizePixel = 0
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 27
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L107_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L107_1.Font = L115_1
L107_1.Text = "Infinite Jump"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L107_1.TextColor3 = L115_1
L107_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L107_1.TextXAlignment = L115_1
L108_1.Parent = L107_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L108_1.PaddingLeft = L115_1
L109_1.Name = "ClickTPButton"
L109_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L109_1.BackgroundColor3 = L115_1
L109_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L109_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L109_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L109_1.Font = L115_1
L109_1.Text = "Click Teleport Tool"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L109_1.TextColor3 = L115_1
L109_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L109_1.TextXAlignment = L115_1
L110_1.Parent = L109_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L110_1.PaddingLeft = L115_1
L111_1.Parent = L109_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L111_1.BackgroundColor3 = L115_1
L111_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L111_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L111_1.Size = L115_1
L111_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L111_1.ImageColor3 = L115_1
L112_1.Name = "BtoolsButton"
L112_1.Parent = L85_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L112_1.BackgroundColor3 = L115_1
L112_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0.0501253121
L117_1 = 0
L118_1 = -0.00300300308
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L112_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 399
L118_1 = 0
L119_1 = 28
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L112_1.Size = L115_1
L115_1 = Enum
L115_1 = L115_1.Font
L115_1 = L115_1.SourceSansBold
L112_1.Font = L115_1
L112_1.Text = "Building Tools"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 255
L117_1 = 255
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L112_1.TextColor3 = L115_1
L112_1.TextSize = 18
L115_1 = Enum
L115_1 = L115_1.TextXAlignment
L115_1 = L115_1.Left
L112_1.TextXAlignment = L115_1
L113_1.Parent = L112_1
L115_1 = UDim
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 53
L115_1 = L115_1(L116_1, L117_1)
L113_1.PaddingLeft = L115_1
L114_1.Parent = L112_1
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L114_1.BackgroundColor3 = L115_1
L114_1.BackgroundTransparency = 1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = -0.0972734541
L117_1 = 0
L118_1 = 0.0357142873
L119_1 = 0
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L114_1.Position = L115_1
L115_1 = UDim2
L115_1 = L115_1.new
L116_1 = 0
L117_1 = 23
L118_1 = 0
L119_1 = 25
L115_1 = L115_1(L116_1, L117_1, L118_1, L119_1)
L114_1.Size = L115_1
L114_1.Image = "http://www.roblox.com/asset/?id=11378411872"
L115_1 = Color3
L115_1 = L115_1.fromRGB
L116_1 = 0
L117_1 = 136
L118_1 = 255
L115_1 = L115_1(L116_1, L117_1, L118_1)
L114_1.ImageColor3 = L115_1

function L115_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L14_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L14_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = L28_1
    L0_3.Visible = true
    L0_3 = L85_1
    L0_3.Visible = false
    L0_3 = L67_1
    L0_3.Visible = false
    L0_3 = L14_1
    L0_3.BackgroundTransparency = 0
    L0_3 = L18_1
    L0_3.BackgroundTransparency = 1
    L0_3 = L22_1
    L0_3.BackgroundTransparency = 1
  end
  
  L1_2(L2_2, L3_2)
end

L116_1 = coroutine
L116_1 = L116_1.wrap
L117_1 = L115_1
L116_1 = L116_1(L117_1)
L116_1()

function L116_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L18_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L18_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = L28_1
    L0_3.Visible = false
    L0_3 = L85_1
    L0_3.Visible = true
    L0_3 = L67_1
    L0_3.Visible = false
    L0_3 = L14_1
    L0_3.BackgroundTransparency = 1
    L0_3 = L18_1
    L0_3.BackgroundTransparency = 0
    L0_3 = L22_1
    L0_3.BackgroundTransparency = 1
  end
  
  L1_2(L2_2, L3_2)
end

L117_1 = coroutine
L117_1 = L117_1.wrap
L118_1 = L116_1
L117_1 = L117_1(L118_1)
L117_1()

function L117_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L22_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L22_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = L28_1
    L0_3.Visible = false
    L0_3 = L85_1
    L0_3.Visible = false
    L0_3 = L67_1
    L0_3.Visible = true
    L0_3 = L14_1
    L0_3.BackgroundTransparency = 1
    L0_3 = L18_1
    L0_3.BackgroundTransparency = 1
    L0_3 = L22_1
    L0_3.BackgroundTransparency = 0
  end
  
  L1_2(L2_2, L3_2)
end

L118_1 = coroutine
L118_1 = L118_1.wrap
L119_1 = L117_1
L118_1 = L118_1(L119_1)
L118_1()

function L118_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L33_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L33_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = L35_1
    L0_3.Visible = true
    L0_3 = L33_1
    L0_3.Visible = false
    L0_3 = 8
    L1_3 = game
    L2_3 = L1_3
    L1_3 = L1_3.GetService
    L3_3 = "Players"
    L1_3 = L1_3(L2_3, L3_3)
    L1_3 = L1_3.LocalPlayer
    
    function L2_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4
      L1_4 = 99999
      L2_4 = pairs
      L3_4 = game
      L3_4 = L3_4.Workspace
      L3_4 = L3_4.BossFolder
      L4_4 = L3_4
      L3_4 = L3_4.GetChildren
      L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4 = L3_4(L4_4)
      L2_4, L3_4, L4_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4)
      for L5_4, L6_4 in L2_4, L3_4, L4_4 do
        L8_4 = L6_4
        L7_4 = L6_4.FindFirstChild
        L9_4 = "Head"
        L7_4 = L7_4(L8_4, L9_4)
        if L7_4 ~= nil then
          L7_4 = L1_3
          L7_4 = L7_4.Character
          L7_4 = L7_4.Head
          L7_4 = L7_4.Position
          L8_4 = L6_4.Head
          L8_4 = L8_4.Position
          L7_4 = L7_4 - L8_4
          L7_4 = L7_4.magnitude
          if L1_4 > L7_4 then
            L1_4 = L7_4
            L0_4 = L6_4
          end
        end
      end
      L2_4 = pairs
      L3_4 = game
      L3_4 = L3_4.Workspace
      L3_4 = L3_4.enemies
      L4_4 = L3_4
      L3_4 = L3_4.GetChildren
      L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4 = L3_4(L4_4)
      L2_4, L3_4, L4_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4)
      for L5_4, L6_4 in L2_4, L3_4, L4_4 do
        L8_4 = L6_4
        L7_4 = L6_4.FindFirstChild
        L9_4 = "Head"
        L7_4 = L7_4(L8_4, L9_4)
        if L7_4 ~= nil then
          L7_4 = L1_3
          L7_4 = L7_4.Character
          L7_4 = L7_4.Head
          L7_4 = L7_4.Position
          L8_4 = L6_4.Head
          L8_4 = L8_4.Position
          L7_4 = L7_4 - L8_4
          L7_4 = L7_4.magnitude
          if L1_4 > L7_4 then
            L1_4 = L7_4
            L0_4 = L6_4
          end
        end
      end
    end
    
    L3_3 = _G
    L3_3.farm2 = false
    L3_3 = L1_3.Chatted
    L4_3 = L3_3
    L3_3 = L3_3.Connect
    
    function L5_3(A0_4)
      local L1_4, L2_4
      if A0_4 == ";autofarm false" then
        L1_4 = _G
        L1_4.farm2 = false
      elseif A0_4 == ";autofarm true" then
        L1_4 = _G
        L1_4.farm2 = true
      end
    end
    
    L3_3(L4_3, L5_3)
    L3_3 = _G
    L3_3.globalTarget = nil
    L3_3 = game
    L4_3 = L3_3
    L3_3 = L3_3.GetService
    L5_3 = "RunService"
    L3_3 = L3_3(L4_3, L5_3)
    L3_3 = L3_3.RenderStepped
    L4_3 = L3_3
    L3_3 = L3_3.Connect
    
    function L5_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4
      L0_4 = _G
      L0_4 = L0_4.farm2
      if L0_4 == true then
        L0_4 = L2_3
        L0_4 = L0_4()
        if L0_4 ~= nil then
          L1_4 = game
          L2_4 = L1_4
          L1_4 = L1_4.GetService
          L3_4 = "Workspace"
          L1_4 = L1_4(L2_4, L3_4)
          L1_4 = L1_4.CurrentCamera
          L2_4 = CFrame
          L2_4 = L2_4.new
          L3_4 = game
          L4_4 = L3_4
          L3_4 = L3_4.GetService
          L5_4 = "Workspace"
          L3_4 = L3_4(L4_4, L5_4)
          L3_4 = L3_4.CurrentCamera
          L3_4 = L3_4.CFrame
          L3_4 = L3_4.p
          L4_4 = L0_4.Head
          L4_4 = L4_4.Position
          L2_4 = L2_4(L3_4, L4_4)
          L1_4.CFrame = L2_4
          L1_4 = L1_3
          L1_4 = L1_4.Character
          L1_4 = L1_4.HumanoidRootPart
          L2_4 = L0_4.HumanoidRootPart
          L2_4 = L2_4.CFrame
          L3_4 = CFrame
          L3_4 = L3_4.new
          L4_4 = 0
          L5_4 = L0_3
          L6_4 = 9
          L3_4 = L3_4(L4_4, L5_4, L6_4)
          L2_4 = L2_4 * L3_4
          L1_4.CFrame = L2_4
          L1_4 = _G
          L1_4.globalTarget = L0_4
        end
      end
    end
    
    L3_3(L4_3, L5_3)
    L3_3 = spawn
    
    function L4_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4
      while true do
        L0_4 = wait
        L0_4 = L0_4()
        if not L0_4 then
          break
        end
        L0_4 = game
        L0_4 = L0_4.Players
        L0_4 = L0_4.LocalPlayer
        L0_4 = L0_4.Character
        L0_4 = L0_4.HumanoidRootPart
        L1_4 = Vector3
        L1_4 = L1_4.new
        L2_4 = 0
        L3_4 = 0
        L4_4 = 0
        L1_4 = L1_4(L2_4, L3_4, L4_4)
        L0_4.Velocity = L1_4
        L0_4 = game
        L0_4 = L0_4.Players
        L0_4 = L0_4.LocalPlayer
        L0_4 = L0_4.Character
        L0_4 = L0_4.Torso
        L1_4 = Vector3
        L1_4 = L1_4.new
        L2_4 = 0
        L3_4 = 0
        L4_4 = 0
        L1_4 = L1_4(L2_4, L3_4, L4_4)
        L0_4.Velocity = L1_4
      end
    end
    
    L3_3(L4_3)
    while true do
      L3_3 = wait
      L3_3 = L3_3()
      if not L3_3 then
        break
      end
      L3_3 = _G
      L3_3 = L3_3.farm2
      if L3_3 == true then
        L3_3 = _G
        L3_3 = L3_3.globalTarget
        if L3_3 ~= nil then
          L3_3 = _G
          L3_3 = L3_3.globalTarget
          L4_3 = L3_3
          L3_3 = L3_3.FindFirstChild
          L5_3 = "Head"
          L3_3 = L3_3(L4_3, L5_3)
          if L3_3 then
            L3_3 = L1_3.Character
            L4_3 = L3_3
            L3_3 = L3_3.FindFirstChildOfClass
            L5_3 = "Tool"
            L3_3 = L3_3(L4_3, L5_3)
            if L3_3 then
              L3_3 = _G
              L3_3 = L3_3.globalTarget
              L4_3 = game
              L4_3 = L4_3.ReplicatedStorage
              L4_3 = L4_3.Gun
              L5_3 = L4_3
              L4_3 = L4_3.FireServer
              L6_3 = {}
              L7_3 = Vector3
              L7_3 = L7_3.new
              L8_3 = 0
              L9_3 = 0
              L10_3 = 0
              L7_3 = L7_3(L8_3, L9_3, L10_3)
              L6_3.Normal = L7_3
              L7_3 = L3_3.Head
              L7_3 = L7_3.Position
              L6_3.Direction = L7_3
              L7_3 = L1_3.Character
              L8_3 = L7_3
              L7_3 = L7_3.FindFirstChildOfClass
              L9_3 = "Tool"
              L7_3 = L7_3(L8_3, L9_3)
              L7_3 = L7_3.Name
              L6_3.Name = L7_3
              L7_3 = L3_3.Head
              L6_3.Hit = L7_3
              L7_3 = L3_3.Head
              L7_3 = L7_3.Position
              L6_3.Origin = L7_3
              L7_3 = L3_3.Head
              L7_3 = L7_3.Position
              L6_3.Pos = L7_3
              L4_3(L5_3, L6_3)
              L4_3 = wait
              L4_3()
            end
          end
        end
      end
    end
  end
  
  L1_2(L2_2, L3_2)
end

L119_1 = coroutine
L119_1 = L119_1.wrap
L120_1 = L118_1
L119_1 = L119_1(L120_1)
L119_1()

function L119_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L35_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L35_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = L35_1
    L0_3.Visible = false
    L0_3 = L33_1
    L0_3.Visible = true
    L0_3 = 8
    L1_3 = game
    L2_3 = L1_3
    L1_3 = L1_3.GetService
    L3_3 = "Players"
    L1_3 = L1_3(L2_3, L3_3)
    L1_3 = L1_3.LocalPlayer
    
    function L2_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4
      L1_4 = 99999
      L2_4 = pairs
      L3_4 = game
      L3_4 = L3_4.Workspace
      L3_4 = L3_4.BossFolder
      L4_4 = L3_4
      L3_4 = L3_4.GetChildren
      L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4 = L3_4(L4_4)
      L2_4, L3_4, L4_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4)
      for L5_4, L6_4 in L2_4, L3_4, L4_4 do
        L8_4 = L6_4
        L7_4 = L6_4.FindFirstChild
        L9_4 = "Head"
        L7_4 = L7_4(L8_4, L9_4)
        if L7_4 ~= nil then
          L7_4 = L1_3
          L7_4 = L7_4.Character
          L7_4 = L7_4.Head
          L7_4 = L7_4.Position
          L8_4 = L6_4.Head
          L8_4 = L8_4.Position
          L7_4 = L7_4 - L8_4
          L7_4 = L7_4.magnitude
          if L1_4 > L7_4 then
            L1_4 = L7_4
            L0_4 = L6_4
          end
        end
      end
      L2_4 = pairs
      L3_4 = game
      L3_4 = L3_4.Workspace
      L3_4 = L3_4.enemies
      L4_4 = L3_4
      L3_4 = L3_4.GetChildren
      L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4 = L3_4(L4_4)
      L2_4, L3_4, L4_4 = L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4)
      for L5_4, L6_4 in L2_4, L3_4, L4_4 do
        L8_4 = L6_4
        L7_4 = L6_4.FindFirstChild
        L9_4 = "Head"
        L7_4 = L7_4(L8_4, L9_4)
        if L7_4 ~= nil then
          L7_4 = L1_3
          L7_4 = L7_4.Character
          L7_4 = L7_4.Head
          L7_4 = L7_4.Position
          L8_4 = L6_4.Head
          L8_4 = L8_4.Position
          L7_4 = L7_4 - L8_4
          L7_4 = L7_4.magnitude
          if L1_4 > L7_4 then
            L1_4 = L7_4
            L0_4 = L6_4
          end
        end
      end
    end
    
    L3_3 = _G
    L3_3.farm2 = true
    L3_3 = L1_3.Chatted
    L4_3 = L3_3
    L3_3 = L3_3.Connect
    
    function L5_3(A0_4)
      local L1_4, L2_4
      if A0_4 == ";autofarm false" then
        L1_4 = _G
        L1_4.farm2 = false
      elseif A0_4 == ";autofarm true" then
        L1_4 = _G
        L1_4.farm2 = true
      end
    end
    
    L3_3(L4_3, L5_3)
    L3_3 = _G
    L3_3.globalTarget = nil
    L3_3 = game
    L4_3 = L3_3
    L3_3 = L3_3.GetService
    L5_3 = "RunService"
    L3_3 = L3_3(L4_3, L5_3)
    L3_3 = L3_3.RenderStepped
    L4_3 = L3_3
    L3_3 = L3_3.Connect
    
    function L5_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4
      L0_4 = _G
      L0_4 = L0_4.farm2
      if L0_4 == true then
        L0_4 = L2_3
        L0_4 = L0_4()
        if L0_4 ~= nil then
          L1_4 = game
          L2_4 = L1_4
          L1_4 = L1_4.GetService
          L3_4 = "Workspace"
          L1_4 = L1_4(L2_4, L3_4)
          L1_4 = L1_4.CurrentCamera
          L2_4 = CFrame
          L2_4 = L2_4.new
          L3_4 = game
          L4_4 = L3_4
          L3_4 = L3_4.GetService
          L5_4 = "Workspace"
          L3_4 = L3_4(L4_4, L5_4)
          L3_4 = L3_4.CurrentCamera
          L3_4 = L3_4.CFrame
          L3_4 = L3_4.p
          L4_4 = L0_4.Head
          L4_4 = L4_4.Position
          L2_4 = L2_4(L3_4, L4_4)
          L1_4.CFrame = L2_4
          L1_4 = L1_3
          L1_4 = L1_4.Character
          L1_4 = L1_4.HumanoidRootPart
          L2_4 = L0_4.HumanoidRootPart
          L2_4 = L2_4.CFrame
          L3_4 = CFrame
          L3_4 = L3_4.new
          L4_4 = 0
          L5_4 = L0_3
          L6_4 = 9
          L3_4 = L3_4(L4_4, L5_4, L6_4)
          L2_4 = L2_4 * L3_4
          L1_4.CFrame = L2_4
          L1_4 = _G
          L1_4.globalTarget = L0_4
        end
      end
    end
    
    L3_3(L4_3, L5_3)
    L3_3 = spawn
    
    function L4_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4
      while true do
        L0_4 = wait
        L0_4 = L0_4()
        if not L0_4 then
          break
        end
        L0_4 = game
        L0_4 = L0_4.Players
        L0_4 = L0_4.LocalPlayer
        L0_4 = L0_4.Character
        L0_4 = L0_4.HumanoidRootPart
        L1_4 = Vector3
        L1_4 = L1_4.new
        L2_4 = 0
        L3_4 = 0
        L4_4 = 0
        L1_4 = L1_4(L2_4, L3_4, L4_4)
        L0_4.Velocity = L1_4
        L0_4 = game
        L0_4 = L0_4.Players
        L0_4 = L0_4.LocalPlayer
        L0_4 = L0_4.Character
        L0_4 = L0_4.Torso
        L1_4 = Vector3
        L1_4 = L1_4.new
        L2_4 = 0
        L3_4 = 0
        L4_4 = 0
        L1_4 = L1_4(L2_4, L3_4, L4_4)
        L0_4.Velocity = L1_4
      end
    end
    
    L3_3(L4_3)
    while true do
      L3_3 = wait
      L3_3 = L3_3()
      if not L3_3 then
        break
      end
      L3_3 = _G
      L3_3 = L3_3.farm2
      if L3_3 == true then
        L3_3 = _G
        L3_3 = L3_3.globalTarget
        if L3_3 ~= nil then
          L3_3 = _G
          L3_3 = L3_3.globalTarget
          L4_3 = L3_3
          L3_3 = L3_3.FindFirstChild
          L5_3 = "Head"
          L3_3 = L3_3(L4_3, L5_3)
          if L3_3 then
            L3_3 = L1_3.Character
            L4_3 = L3_3
            L3_3 = L3_3.FindFirstChildOfClass
            L5_3 = "Tool"
            L3_3 = L3_3(L4_3, L5_3)
            if L3_3 then
              L3_3 = _G
              L3_3 = L3_3.globalTarget
              L4_3 = game
              L4_3 = L4_3.ReplicatedStorage
              L4_3 = L4_3.Gun
              L5_3 = L4_3
              L4_3 = L4_3.FireServer
              L6_3 = {}
              L7_3 = Vector3
              L7_3 = L7_3.new
              L8_3 = 0
              L9_3 = 0
              L10_3 = 0
              L7_3 = L7_3(L8_3, L9_3, L10_3)
              L6_3.Normal = L7_3
              L7_3 = L3_3.Head
              L7_3 = L7_3.Position
              L6_3.Direction = L7_3
              L7_3 = L1_3.Character
              L8_3 = L7_3
              L7_3 = L7_3.FindFirstChildOfClass
              L9_3 = "Tool"
              L7_3 = L7_3(L8_3, L9_3)
              L7_3 = L7_3.Name
              L6_3.Name = L7_3
              L7_3 = L3_3.Head
              L6_3.Hit = L7_3
              L7_3 = L3_3.Head
              L7_3 = L7_3.Position
              L6_3.Origin = L7_3
              L7_3 = L3_3.Head
              L7_3 = L7_3.Position
              L6_3.Pos = L7_3
              L4_3(L5_3, L6_3)
              L4_3 = wait
              L4_3()
            end
          end
        end
      end
    end
  end
  
  L1_2(L2_2, L3_2)
end

L120_1 = coroutine
L120_1 = L120_1.wrap
L121_1 = L119_1
L120_1 = L120_1(L121_1)
L120_1()

function L120_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L39_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L39_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3
    L0_3 = workspace
    L0_3 = L0_3.enemies
    L1_3 = game
    L2_3 = L1_3
    L1_3 = L1_3.GetService
    L3_3 = "Players"
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L1_3.LocalPlayer
    L4_3 = L2_3
    L3_3 = L2_3.GetMouse
    L3_3 = L3_3(L4_3)
    L4_3 = game
    L5_3 = L4_3
    L4_3 = L4_3.GetService
    L6_3 = "RunService"
    L4_3 = L4_3(L5_3, L6_3)
    L5_3 = game
    L6_3 = L5_3
    L5_3 = L5_3.GetService
    L7_3 = "TweenService"
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = TweenInfo
    L6_3 = L6_3.new
    L7_3 = 0.4
    L8_3 = Enum
    L8_3 = L8_3.EasingStyle
    L8_3 = L8_3.Linear
    L9_3 = Enum
    L9_3 = L9_3.EasingDirection
    L9_3 = L9_3.InOut
    L6_3 = L6_3(L7_3, L8_3, L9_3)
    
    function L7_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
      L0_4 = math
      L0_4 = L0_4.huge
      L1_4 = nil
      L2_4 = pairs
      L3_4 = L0_3
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
          if L7_4 then
            L7_4 = L6_4.Humanoid
            L7_4 = L7_4.Health
            if not (L7_4 <= 0) then
              L7_4 = workspace
              L7_4 = L7_4.CurrentCamera
              L8_4 = L7_4
              L7_4 = L7_4.WorldToViewportPoint
              L9_4 = L6_4.Head
              L9_4 = L9_4.Position
              L7_4, L8_4 = L7_4(L8_4, L9_4)
              if not L8_4 then
              else
                L9_4 = Vector2
                L9_4 = L9_4.new
                L10_4 = L3_3
                L10_4 = L10_4.X
                L11_4 = L3_3
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
    end
    
    L8_3 = L7_3
    L8_3 = L8_3()
    L9_3 = L4_3.Stepped
    L10_3 = L9_3
    L9_3 = L9_3.Connect
    
    function L11_3(A0_4, A1_4)
      local L2_4
      L2_4 = L7_3
      L2_4 = L2_4()
      L8_3 = L2_4
    end
    
    L9_3(L10_3, L11_3)
    
    function L9_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4
      L1_4 = Instance
      L1_4 = L1_4.new
      L2_4 = "Highlight"
      L1_4 = L1_4(L2_4)
      L1_4.Adornee = A0_4
      L2_4 = Color3
      L2_4 = L2_4.fromRGB
      L3_4 = 93
      L4_4 = 206
      L5_4 = 255
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.FillColor = L2_4
      L1_4.FillTransparency = 0.2
      L2_4 = Color3
      L2_4 = L2_4.fromRGB
      L3_4 = 22
      L4_4 = 102
      L5_4 = 200
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.OutlineColor = L2_4
      L1_4.OutlineTransparency = 0.2
      L2_4 = Enum
      L2_4 = L2_4.HighlightDepthMode
      L2_4 = L2_4.AlwaysOnTop
      L1_4.DepthMode = L2_4
      L1_4.Parent = A0_4
      L2_4 = L5_3
      L3_4 = L2_4
      L2_4 = L2_4.Create
      L4_4 = L1_4
      L5_4 = L6_3
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
    
    L10_3 = nil
    L11_3 = hookmetamethod
    L12_3 = game
    L13_3 = "__index"
    
    function L14_3(A0_4, A1_4)
      local L2_4, L3_4, L4_4
      L2_4 = checkcaller
      L2_4 = L2_4()
      if not L2_4 then
        L2_4 = L3_3
        if A0_4 == L2_4 and A1_4 == "Hit" then
          L2_4 = L8_3
          if L2_4 then
            L2_4 = task
            L2_4 = L2_4.spawn
            L3_4 = L9_3
            L4_4 = L8_3
            L2_4(L3_4, L4_4)
            L2_4 = L8_3
            L2_4 = L2_4.Head
            L2_4 = L2_4.CFrame
            return L2_4
          end
        end
      end
      L2_4 = L10_3
      L3_4 = A0_4
      L4_4 = A1_4
    end
    
    L11_3 = L11_3(L12_3, L13_3, L14_3)
    L10_3 = L11_3
  end
  
  L1_2(L2_2, L3_2)
end

L121_1 = coroutine
L121_1 = L121_1.wrap
L122_1 = L120_1
L121_1 = L121_1(L122_1)
L121_1()

function L121_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L42_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L42_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3
    L0_3 = workspace
    L0_3 = L0_3.BossFolder
    L1_3 = game
    L2_3 = L1_3
    L1_3 = L1_3.GetService
    L3_3 = "Players"
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L1_3.LocalPlayer
    L4_3 = L2_3
    L3_3 = L2_3.GetMouse
    L3_3 = L3_3(L4_3)
    L4_3 = game
    L5_3 = L4_3
    L4_3 = L4_3.GetService
    L6_3 = "RunService"
    L4_3 = L4_3(L5_3, L6_3)
    L5_3 = game
    L6_3 = L5_3
    L5_3 = L5_3.GetService
    L7_3 = "TweenService"
    L5_3 = L5_3(L6_3, L7_3)
    L6_3 = TweenInfo
    L6_3 = L6_3.new
    L7_3 = 0.4
    L8_3 = Enum
    L8_3 = L8_3.EasingStyle
    L8_3 = L8_3.Linear
    L9_3 = Enum
    L9_3 = L9_3.EasingDirection
    L9_3 = L9_3.InOut
    L6_3 = L6_3(L7_3, L8_3, L9_3)
    
    function L7_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
      L0_4 = math
      L0_4 = L0_4.huge
      L1_4 = nil
      L2_4 = pairs
      L3_4 = L0_3
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
            if not (L7_4 <= 0) then
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
                L10_4 = L3_3
                L10_4 = L10_4.X
                L11_4 = L3_3
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
    end
    
    L8_3 = L7_3
    L8_3 = L8_3()
    L9_3 = L4_3.Stepped
    L10_3 = L9_3
    L9_3 = L9_3.Connect
    
    function L11_3(A0_4, A1_4)
      local L2_4
      L2_4 = L7_3
      L2_4 = L2_4()
      L8_3 = L2_4
    end
    
    L9_3(L10_3, L11_3)
    
    function L9_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4
      L1_4 = Instance
      L1_4 = L1_4.new
      L2_4 = "Highlight"
      L1_4 = L1_4(L2_4)
      L1_4.Adornee = A0_4
      L2_4 = Color3
      L2_4 = L2_4.fromRGB
      L3_4 = 255
      L4_4 = 0
      L5_4 = 0
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.FillColor = L2_4
      L1_4.FillTransparency = 0.2
      L2_4 = Color3
      L2_4 = L2_4.fromRGB
      L3_4 = 200
      L4_4 = 0
      L5_4 = 0
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.OutlineColor = L2_4
      L1_4.OutlineTransparency = 0.2
      L2_4 = Enum
      L2_4 = L2_4.HighlightDepthMode
      L2_4 = L2_4.AlwaysOnTop
      L1_4.DepthMode = L2_4
      L1_4.Parent = A0_4
      L2_4 = L5_3
      L3_4 = L2_4
      L2_4 = L2_4.Create
      L4_4 = L1_4
      L5_4 = L6_3
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
    
    L10_3 = nil
    L11_3 = hookmetamethod
    L12_3 = game
    L13_3 = "__index"
    
    function L14_3(A0_4, A1_4)
      local L2_4, L3_4, L4_4
      L2_4 = checkcaller
      L2_4 = L2_4()
      if not L2_4 then
        L2_4 = L3_3
        if A0_4 == L2_4 and A1_4 == "Hit" then
          L2_4 = L8_3
          if L2_4 then
            L2_4 = task
            L2_4 = L2_4.spawn
            L3_4 = L9_3
            L4_4 = L8_3
            L2_4(L3_4, L4_4)
            L2_4 = L8_3
            L2_4 = L2_4.Head
            L2_4 = L2_4.CFrame
            return L2_4
          end
        end
      end
      L2_4 = L10_3
      L3_4 = A0_4
      L4_4 = A1_4
    end
    
    L11_3 = L11_3(L12_3, L13_3, L14_3)
    L10_3 = L11_3
  end
  
  L1_2(L2_2, L3_2)
end

L122_1 = coroutine
L122_1 = L122_1.wrap
L123_1 = L121_1
L122_1 = L122_1(L123_1)
L122_1()

function L122_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L45_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L45_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = 4
    Size_of_head = L0_3
    while true do
      L0_3 = wait
      L0_3 = L0_3()
      if not L0_3 then
        break
      end
      L0_3 = game
      L0_3 = L0_3.Workspace
      L0_3 = L0_3.enemies
      L1_3 = L0_3
      L0_3 = L0_3.FindFirstChild
      L2_3 = "Zombie"
      L0_3 = L0_3(L1_3, L2_3)
      if L0_3 then
        L0_3 = pairs
        L1_3 = game
        L1_3 = L1_3.Workspace
        L1_3 = L1_3.enemies
        L2_3 = L1_3
        L1_3 = L1_3.GetChildren
        L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = L1_3(L2_3)
        L0_3, L1_3, L2_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
        for L3_3, L4_3 in L0_3, L1_3, L2_3 do
          L5_3 = wait
          L5_3()
          L6_3 = L4_3
          L5_3 = L4_3.FindFirstChild
          L7_3 = "Head"
          L5_3 = L5_3(L6_3, L7_3)
          if L5_3 then
            L5_3 = L4_3.Head
            L5_3.CanCollide = false
            L5_3 = L4_3.Head
            L6_3 = Vector3
            L6_3 = L6_3.new
            L7_3 = Size_of_head
            L8_3 = Size_of_head
            L9_3 = Size_of_head
            L6_3 = L6_3(L7_3, L8_3, L9_3)
            L5_3.Size = L6_3
            L5_3 = L4_3.Head
            L6_3 = L4_3.Torso
            L6_3 = L6_3.CFrame
            L7_3 = CFrame
            L7_3 = L7_3.new
            L8_3 = 0
            L9_3 = Size_of_head
            L9_3 = L9_3 / 2
            L10_3 = 0
            L7_3 = L7_3(L8_3, L9_3, L10_3)
            L6_3 = L6_3 * L7_3
            L5_3.CFrame = L6_3
          end
        end
      end
    end
  end
  
  L1_2(L2_2, L3_2)
end

L123_1 = coroutine
L123_1 = L123_1.wrap
L124_1 = L122_1
L123_1 = L123_1(L124_1)
L123_1()

function L123_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L49_1
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
    L0_3 = L0_3.PowerupsONToggle
    L0_3.Visible = false
    L0_3 = L0_2
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.PowerupsOFFToggle
    L0_3.Visible = true
  end
  
  L1_2(L2_2, L3_2)
end

L124_1 = coroutine
L124_1 = L124_1.wrap
L125_1 = L123_1
L124_1 = L124_1(L125_1)
L124_1()

function L124_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L51_1
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
    L0_3 = L0_3.PowerupsOFFToggle
    L0_3.Visible = false
    L0_3 = L0_2
    L0_3 = L0_3.Parent
    L0_3 = L0_3.Parent
    L0_3 = L0_3.PowerupsONToggle
    L0_3.Visible = true
  end
  
  L1_2(L2_2, L3_2)
end

L125_1 = coroutine
L125_1 = L125_1.wrap
L126_1 = L124_1
L125_1 = L125_1(L126_1)
L125_1()

function L125_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L48_1
  L0_2 = L0_2(L1_2, L2_2)
  while true do
    L1_2 = L0_2.Parent
    L1_2 = L1_2.PowerupsOFFToggle
    L1_2 = L1_2.Visible
    if L1_2 == true then
      L1_2 = pairs
      L2_2 = game
      L3_2 = L2_2
      L2_2 = L2_2.GetService
      L4_2 = "Workspace"
      L2_2 = L2_2(L3_2, L4_2)
      L2_2 = L2_2.Powerups
      L3_2 = L2_2
      L2_2 = L2_2.GetDescendants
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
      L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      for L4_2, L5_2 in L1_2, L2_2, L3_2 do
        L6_2 = L5_2.ClassName
        if L6_2 == "TouchTransmitter" then
          L6_2 = game
          L6_2 = L6_2.Players
          L6_2 = L6_2.LocalPlayer
          L6_2 = L6_2.Character
          L6_2 = L6_2.Humanoid
          L6_2 = L6_2.Health
          if L6_2 ~= 0 then
            L6_2 = game
            L6_2 = L6_2.Players
            L6_2 = L6_2.LocalPlayer
            L6_2 = L6_2.Character
            if L6_2 then
              L6_2 = L5_2.Parent
              L6_2 = L6_2.Parent
              L6_2 = L6_2.ClassName
              if L6_2 == "Model" then
                L6_2 = firetouchinterest
                L7_2 = game
                L7_2 = L7_2.Players
                L7_2 = L7_2.LocalPlayer
                L7_2 = L7_2.Character
                L8_2 = L7_2
                L7_2 = L7_2.FindFirstChildOfClass
                L9_2 = "Part"
                L7_2 = L7_2(L8_2, L9_2)
                L8_2 = L5_2.Parent
                L9_2 = 0
                L6_2(L7_2, L8_2, L9_2)
                L6_2 = wait
                L6_2()
                L6_2 = firetouchinterest
                L7_2 = game
                L7_2 = L7_2.Players
                L7_2 = L7_2.LocalPlayer
                L7_2 = L7_2.Character
                L8_2 = L7_2
                L7_2 = L7_2.FindFirstChildOfClass
                L9_2 = "Part"
                L7_2 = L7_2(L8_2, L9_2)
                L8_2 = L5_2.Parent
                L9_2 = 0
                L6_2(L7_2, L8_2, L9_2)
              end
            end
          end
        end
      end
    end
    L1_2 = wait
    L2_2 = 0.4
    L1_2(L2_2)
  end
end

L126_1 = coroutine
L126_1 = L126_1.wrap
L127_1 = L125_1
L126_1 = L126_1(L127_1)
L126_1()

function L126_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L56_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L56_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = L60_1
    L0_3.Visible = true
    L0_3 = L56_1
    L0_3.Visible = false
    L0_3 = _G
    L0_3.equip = false
  end
  
  L1_2(L2_2, L3_2)
end

L127_1 = coroutine
L127_1 = L127_1.wrap
L128_1 = L126_1
L127_1 = L127_1(L128_1)
L127_1()

function L127_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L60_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L60_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = L60_1
    L0_3.Visible = false
    L0_3 = L56_1
    L0_3.Visible = true
    L0_3 = _G
    L0_3.equip = true
    while true do
      L0_3 = _G
      L0_3 = L0_3.equip
      if not L0_3 then
        break
      end
      L0_3 = wait
      L0_3()
      L0_3 = pairs
      L1_3 = game
      L1_3 = L1_3.Players
      L1_3 = L1_3.LocalPlayer
      L1_3 = L1_3.Backpack
      L2_3 = L1_3
      L1_3 = L1_3.GetChildren
      L1_3, L2_3, L3_3, L4_3, L5_3, L6_3 = L1_3(L2_3)
      L0_3, L1_3, L2_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3)
      for L3_3, L4_3 in L0_3, L1_3, L2_3 do
        L5_3 = L4_3.Name
        L6_3 = L58_1
        L6_3 = L6_3.Text
        if L5_3 == L6_3 then
          L5_3 = game
          L5_3 = L5_3.Players
          L5_3 = L5_3.LocalPlayer
          L5_3 = L5_3.Character
          L4_3.Parent = L5_3
        end
      end
    end
  end
  
  L1_2(L2_2, L3_2)
end

L128_1 = coroutine
L128_1 = L128_1.wrap
L129_1 = L127_1
L128_1 = L128_1(L129_1)
L128_1()

function L128_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L64_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L64_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = loadstring
    L1_3 = game
    L2_3 = L1_3
    L1_3 = L1_3.HttpGetAsync
    L3_3 = "https://pastebin.com/raw/0EJsh19M"
    L1_3, L2_3, L3_3 = L1_3(L2_3, L3_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3)
    L0_3()
  end
  
  L1_2(L2_2, L3_2)
end

L129_1 = coroutine
L129_1 = L129_1.wrap
L130_1 = L128_1
L129_1 = L129_1(L130_1)
L129_1()

function L129_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L71_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L71_1
  L1_2 = L1_2.MouseButton1Down
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = setclipboard
    L1_3 = "https://discord.gg/sdCSmXRjuX"
    L0_3(L1_3)
  end
  
  L1_2(L2_2, L3_2)
end

L130_1 = coroutine
L130_1 = L130_1.wrap
L131_1 = L129_1
L130_1 = L130_1(L131_1)
L130_1()

function L130_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L89_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L89_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = game
    L0_3 = L0_3.Players
    L0_3 = L0_3.LocalPlayer
    L0_3 = L0_3.Character
    L0_3 = L0_3.Humanoid
    L1_3 = L92_1
    L1_3 = L1_3.Text
    L0_3.WalkSpeed = L1_3
  end
  
  L1_2(L2_2, L3_2)
end

L131_1 = coroutine
L131_1 = L131_1.wrap
L132_1 = L130_1
L131_1 = L131_1(L132_1)
L131_1()

function L131_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L94_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L94_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3
    L0_3 = game
    L0_3 = L0_3.Players
    L0_3 = L0_3.LocalPlayer
    L0_3 = L0_3.Character
    L0_3 = L0_3.Humanoid
    L1_3 = L97_1
    L1_3 = L1_3.Text
    L0_3.JumpPower = L1_3
  end
  
  L1_2(L2_2, L3_2)
end

L132_1 = coroutine
L132_1 = L132_1.wrap
L133_1 = L131_1
L132_1 = L132_1(L133_1)
L132_1()

function L132_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L99_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L99_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    repeat
      repeat
        repeat
          repeat
            L0_3 = wait
            L0_3()
            L0_3 = game
            L0_3 = L0_3.Players
            L0_3 = L0_3.LocalPlayer
          until L0_3
          L0_3 = game
          L0_3 = L0_3.Players
          L0_3 = L0_3.LocalPlayer
          L0_3 = L0_3.Character
        until L0_3
        L0_3 = game
        L0_3 = L0_3.Players
        L0_3 = L0_3.LocalPlayer
        L0_3 = L0_3.Character
        L1_3 = L0_3
        L0_3 = L0_3.findFirstChild
        L2_3 = "Head"
        L0_3 = L0_3(L1_3, L2_3)
      until L0_3
      L0_3 = game
      L0_3 = L0_3.Players
      L0_3 = L0_3.LocalPlayer
      L0_3 = L0_3.Character
      L1_3 = L0_3
      L0_3 = L0_3.findFirstChild
      L2_3 = "Humanoid"
      L0_3 = L0_3(L1_3, L2_3)
    until L0_3
    L0_3 = game
    L0_3 = L0_3.Players
    L0_3 = L0_3.LocalPlayer
    L1_3 = L0_3
    L0_3 = L0_3.GetMouse
    L0_3 = L0_3(L1_3)
    repeat
      L1_3 = wait
      L1_3()
    until L0_3
    L1_3 = game
    L1_3 = L1_3.Players
    L1_3 = L1_3.LocalPlayer
    L2_3 = L1_3.Character
    L2_3 = L2_3.Head
    L3_3 = false
    L4_3 = true
    L5_3 = {}
    L5_3.f = 0
    L5_3.b = 0
    L5_3.l = 0
    L5_3.r = 0
    L6_3 = {}
    L6_3.f = 0
    L6_3.b = 0
    L6_3.l = 0
    L6_3.r = 0
    L7_3 = 400
    L8_3 = 5000
    
    function L9_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4
      L0_4 = Instance
      L0_4 = L0_4.new
      L1_4 = "BodyGyro"
      L2_4 = L2_3
      L0_4 = L0_4(L1_4, L2_4)
      L0_4.P = 90000
      L1_4 = Vector3
      L1_4 = L1_4.new
      L2_4 = 9000000000
      L3_4 = 9000000000
      L4_4 = 9000000000
      L1_4 = L1_4(L2_4, L3_4, L4_4)
      L0_4.maxTorque = L1_4
      L1_4 = L2_3
      L1_4 = L1_4.CFrame
      L0_4.cframe = L1_4
      L1_4 = Instance
      L1_4 = L1_4.new
      L2_4 = "BodyVelocity"
      L3_4 = L2_3
      L1_4 = L1_4(L2_4, L3_4)
      L2_4 = Vector3
      L2_4 = L2_4.new
      L3_4 = 0
      L4_4 = 0.1
      L5_4 = 0
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.velocity = L2_4
      L2_4 = Vector3
      L2_4 = L2_4.new
      L3_4 = 9000000000
      L4_4 = 9000000000
      L5_4 = 9000000000
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.maxForce = L2_4
      repeat
        L2_4 = wait
        L2_4()
        L2_4 = L1_3
        L2_4 = L2_4.Character
        L2_4 = L2_4.Humanoid
        L2_4.PlatformStand = true
        L2_4 = L5_3
        L2_4 = L2_4.l
        L3_4 = L5_3
        L3_4 = L3_4.r
        L2_4 = L2_4 + L3_4
        if L2_4 == 0 then
          L2_4 = L5_3
          L2_4 = L2_4.f
          L3_4 = L5_3
          L3_4 = L3_4.b
          L2_4 = L2_4 + L3_4
          if L2_4 == 0 then
            goto lbl_70
          end
        end
        L2_4 = L8_3
        L2_4 = L2_4 + 0.5
        L3_4 = L8_3
        L4_4 = L7_3
        L3_4 = L3_4 / L4_4
        L2_4 = L2_4 + L3_4
        L8_3 = L2_4
        L2_4 = L8_3
        L3_4 = L7_3
        if L2_4 > L3_4 then
          L2_4 = L7_3
          L8_3 = L2_4
          goto lbl_95
          ::lbl_70::
          L2_4 = L5_3
          L2_4 = L2_4.l
          L3_4 = L5_3
          L3_4 = L3_4.r
          L2_4 = L2_4 + L3_4
          if L2_4 == 0 then
            L2_4 = L5_3
            L2_4 = L2_4.f
            L3_4 = L5_3
            L3_4 = L3_4.b
            L2_4 = L2_4 + L3_4
            if L2_4 == 0 then
              L2_4 = L8_3
              if L2_4 ~= 0 then
                L2_4 = L8_3
                L2_4 = L2_4 - 1
                L8_3 = L2_4
                L2_4 = L8_3
                if L2_4 < 0 then
                  L2_4 = 0
                  L8_3 = L2_4
                end
              end
            end
          end
        end
        ::lbl_95::
        L2_4 = L5_3
        L2_4 = L2_4.l
        L3_4 = L5_3
        L3_4 = L3_4.r
        L2_4 = L2_4 + L3_4
        if L2_4 == 0 then
          L2_4 = L5_3
          L2_4 = L2_4.f
          L3_4 = L5_3
          L3_4 = L3_4.b
          L2_4 = L2_4 + L3_4
          if L2_4 == 0 then
            goto lbl_166
          end
        end
        L2_4 = game
        L2_4 = L2_4.Workspace
        L2_4 = L2_4.CurrentCamera
        L2_4 = L2_4.CoordinateFrame
        L2_4 = L2_4.lookVector
        L3_4 = L5_3
        L3_4 = L3_4.f
        L4_4 = L5_3
        L4_4 = L4_4.b
        L3_4 = L3_4 + L4_4
        L2_4 = L2_4 * L3_4
        L3_4 = game
        L3_4 = L3_4.Workspace
        L3_4 = L3_4.CurrentCamera
        L3_4 = L3_4.CoordinateFrame
        L4_4 = CFrame
        L4_4 = L4_4.new
        L5_4 = L5_3
        L5_4 = L5_4.l
        L6_4 = L5_3
        L6_4 = L6_4.r
        L5_4 = L5_4 + L6_4
        L6_4 = L5_3
        L6_4 = L6_4.f
        L7_4 = L5_3
        L7_4 = L7_4.b
        L6_4 = L6_4 + L7_4
        L6_4 = L6_4 * 0.2
        L7_4 = 0
        L4_4 = L4_4(L5_4, L6_4, L7_4)
        L4_4 = L4_4.p
        L3_4 = L3_4 * L4_4
        L4_4 = game
        L4_4 = L4_4.Workspace
        L4_4 = L4_4.CurrentCamera
        L4_4 = L4_4.CoordinateFrame
        L4_4 = L4_4.p
        L3_4 = L3_4 - L4_4
        L2_4 = L2_4 + L3_4
        L3_4 = L8_3
        L2_4 = L2_4 * L3_4
        L1_4.velocity = L2_4
        L2_4 = {}
        L3_4 = L5_3
        L3_4 = L3_4.f
        L2_4.f = L3_4
        L3_4 = L5_3
        L3_4 = L3_4.b
        L2_4.b = L3_4
        L3_4 = L5_3
        L3_4 = L3_4.l
        L2_4.l = L3_4
        L3_4 = L5_3
        L3_4 = L3_4.r
        L2_4.r = L3_4
        L6_3 = L2_4
        goto lbl_233
        ::lbl_166::
        L2_4 = L5_3
        L2_4 = L2_4.l
        L3_4 = L5_3
        L3_4 = L3_4.r
        L2_4 = L2_4 + L3_4
        if L2_4 == 0 then
          L2_4 = L5_3
          L2_4 = L2_4.f
          L3_4 = L5_3
          L3_4 = L3_4.b
          L2_4 = L2_4 + L3_4
          if L2_4 == 0 then
            L2_4 = L8_3
            if L2_4 ~= 0 then
              L2_4 = game
              L2_4 = L2_4.Workspace
              L2_4 = L2_4.CurrentCamera
              L2_4 = L2_4.CoordinateFrame
              L2_4 = L2_4.lookVector
              L3_4 = L6_3
              L3_4 = L3_4.f
              L4_4 = L6_3
              L4_4 = L4_4.b
              L3_4 = L3_4 + L4_4
              L2_4 = L2_4 * L3_4
              L3_4 = game
              L3_4 = L3_4.Workspace
              L3_4 = L3_4.CurrentCamera
              L3_4 = L3_4.CoordinateFrame
              L4_4 = CFrame
              L4_4 = L4_4.new
              L5_4 = L6_3
              L5_4 = L5_4.l
              L6_4 = L6_3
              L6_4 = L6_4.r
              L5_4 = L5_4 + L6_4
              L6_4 = L6_3
              L6_4 = L6_4.f
              L7_4 = L6_3
              L7_4 = L7_4.b
              L6_4 = L6_4 + L7_4
              L6_4 = L6_4 * 0.2
              L7_4 = 0
              L4_4 = L4_4(L5_4, L6_4, L7_4)
              L4_4 = L4_4.p
              L3_4 = L3_4 * L4_4
              L4_4 = game
              L4_4 = L4_4.Workspace
              L4_4 = L4_4.CurrentCamera
              L4_4 = L4_4.CoordinateFrame
              L4_4 = L4_4.p
              L3_4 = L3_4 - L4_4
              L2_4 = L2_4 + L3_4
              L3_4 = L8_3
              L2_4 = L2_4 * L3_4
              L1_4.velocity = L2_4
          end
        end
        else
          L2_4 = Vector3
          L2_4 = L2_4.new
          L3_4 = 0
          L4_4 = 0.1
          L5_4 = 0
          L2_4 = L2_4(L3_4, L4_4, L5_4)
          L1_4.velocity = L2_4
        end
        ::lbl_233::
        L2_4 = game
        L2_4 = L2_4.Workspace
        L2_4 = L2_4.CurrentCamera
        L2_4 = L2_4.CoordinateFrame
        L3_4 = CFrame
        L3_4 = L3_4.Angles
        L4_4 = math
        L4_4 = L4_4.rad
        L5_4 = L5_3
        L5_4 = L5_4.f
        L6_4 = L5_3
        L6_4 = L6_4.b
        L5_4 = L5_4 + L6_4
        L5_4 = L5_4 * 50
        L6_4 = L8_3
        L5_4 = L5_4 * L6_4
        L6_4 = L7_3
        L5_4 = L5_4 / L6_4
        L4_4 = L4_4(L5_4)
        L4_4 = -L4_4
        L5_4 = 0
        L6_4 = 0
        L3_4 = L3_4(L4_4, L5_4, L6_4)
        L2_4 = L2_4 * L3_4
        L0_4.cframe = L2_4
        L2_4 = L3_3
      until not L2_4
      L2_4 = {}
      L2_4.f = 0
      L2_4.b = 0
      L2_4.l = 0
      L2_4.r = 0
      L5_3 = L2_4
      L2_4 = {}
      L2_4.f = 0
      L2_4.b = 0
      L2_4.l = 0
      L2_4.r = 0
      L6_3 = L2_4
      L2_4 = 0
      L8_3 = L2_4
      L3_4 = L0_4
      L2_4 = L0_4.Destroy
      L2_4(L3_4)
      L3_4 = L1_4
      L2_4 = L1_4.Destroy
      L2_4(L3_4)
      L2_4 = L1_3
      L2_4 = L2_4.Character
      L2_4 = L2_4.Humanoid
      L2_4.PlatformStand = false
    end
    
    Fly = L9_3
    L9_3 = L0_3.KeyDown
    L10_3 = L9_3
    L9_3 = L9_3.connect
    
    function L11_3(A0_4)
      local L1_4, L2_4
      L2_4 = A0_4
      L1_4 = A0_4.lower
      L1_4 = L1_4(L2_4)
      if L1_4 == "f" then
        L1_4 = L3_3
        if L1_4 then
          L1_4 = false
          L3_3 = L1_4
        else
          L1_4 = true
          L3_3 = L1_4
          L1_4 = Fly
          L1_4()
        end
      else
        L2_4 = A0_4
        L1_4 = A0_4.lower
        L1_4 = L1_4(L2_4)
        if L1_4 == "w" then
          L1_4 = L5_3
          L1_4.f = 1
        else
          L2_4 = A0_4
          L1_4 = A0_4.lower
          L1_4 = L1_4(L2_4)
          if L1_4 == "s" then
            L1_4 = L5_3
            L1_4.b = -1
          else
            L2_4 = A0_4
            L1_4 = A0_4.lower
            L1_4 = L1_4(L2_4)
            if L1_4 == "a" then
              L1_4 = L5_3
              L1_4.l = -1
            else
              L2_4 = A0_4
              L1_4 = A0_4.lower
              L1_4 = L1_4(L2_4)
              if L1_4 == "d" then
                L1_4 = L5_3
                L1_4.r = 1
              end
            end
          end
        end
      end
    end
    
    L9_3(L10_3, L11_3)
    L9_3 = L0_3.KeyUp
    L10_3 = L9_3
    L9_3 = L9_3.connect
    
    function L11_3(A0_4)
      local L1_4, L2_4
      L2_4 = A0_4
      L1_4 = A0_4.lower
      L1_4 = L1_4(L2_4)
      if L1_4 == "w" then
        L1_4 = L5_3
        L1_4.f = 0
      else
        L2_4 = A0_4
        L1_4 = A0_4.lower
        L1_4 = L1_4(L2_4)
        if L1_4 == "s" then
          L1_4 = L5_3
          L1_4.b = 0
        else
          L2_4 = A0_4
          L1_4 = A0_4.lower
          L1_4 = L1_4(L2_4)
          if L1_4 == "a" then
            L1_4 = L5_3
            L1_4.l = 0
          else
            L2_4 = A0_4
            L1_4 = A0_4.lower
            L1_4 = L1_4(L2_4)
            if L1_4 == "d" then
              L1_4 = L5_3
              L1_4.r = 0
            end
          end
        end
      end
    end
    
    L9_3(L10_3, L11_3)
    L9_3 = Fly
    L9_3()
    L9_3 = fly
    L9_3.Text = "Loaded!"
    L9_3 = fly
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 0
    L12_3 = 255
    L13_3 = 50
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L9_3.TextColor3 = L10_3
    L9_3 = wait
    L10_3 = 2
    L9_3(L10_3)
    L9_3 = fly
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L9_3.TextColor3 = L10_3
    L9_3 = fly
    L9_3.Text = "Fly"
  end
  
  L1_2(L2_2, L3_2)
end

L133_1 = coroutine
L133_1 = L133_1.wrap
L134_1 = L132_1
L133_1 = L133_1(L134_1)
L133_1()

function L133_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L105_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = false
  toggle = L1_2
  L1_2 = L0_2.Parent
  L1_2 = L1_2.MouseButton1Down
  L2_2 = L1_2
  L1_2 = L1_2.connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = toggle
    if L0_3 == true then
      L0_3 = false
      toggle = L0_3
    else
      L0_3 = true
      toggle = L0_3
    end
    L0_3 = toggle
    if L0_3 == true then
      L0_3 = L0_2
      L0_3 = L0_3.Parent
      L1_3 = Color3
      L1_3 = L1_3.fromRGB
      L2_3 = 0
      L3_3 = 136
      L4_3 = 255
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      L0_3.BackgroundColor3 = L1_3
    end
    L0_3 = toggle
    if L0_3 == false then
      L0_3 = L0_2
      L0_3 = L0_3.Parent
      L1_3 = Color3
      L1_3 = L1_3.fromRGB
      L2_3 = 29
      L3_3 = 40
      L4_3 = 58
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      L0_3.BackgroundColor3 = L1_3
    end
    L0_3 = toggle
    if L0_3 == true then
      L0_3 = _G
      L0_3.infinjump = true
      L0_3 = game
      L1_3 = L0_3
      L0_3 = L0_3.GetService
      L2_3 = "Players"
      L0_3 = L0_3(L1_3, L2_3)
      L0_3 = L0_3.LocalPlayer
      L2_3 = L0_3
      L1_3 = L0_3.GetMouse
      L1_3 = L1_3(L2_3)
      L2_3 = L1_3.KeyDown
      L3_3 = L2_3
      L2_3 = L2_3.connect
      
      function L4_3(A0_4)
        local L1_4, L2_4, L3_4
        L1_4 = _G
        L1_4 = L1_4.infinjump
        if L1_4 then
          L2_4 = A0_4
          L1_4 = A0_4.byte
          L1_4 = L1_4(L2_4)
          if L1_4 == 32 then
            L1_4 = game
            L2_4 = L1_4
            L1_4 = L1_4.GetService
            L3_4 = "Players"
            L1_4 = L1_4(L2_4, L3_4)
            L1_4 = L1_4.LocalPlayer
            L1_4 = L1_4.Character
            L2_4 = L1_4
            L1_4 = L1_4.FindFirstChildOfClass
            L3_4 = "Humanoid"
            L1_4 = L1_4(L2_4, L3_4)
            Humanoid = L1_4
            L1_4 = Humanoid
            L2_4 = L1_4
            L1_4 = L1_4.ChangeState
            L3_4 = "Jumping"
            L1_4(L2_4, L3_4)
            L1_4 = wait
            L1_4()
            L1_4 = Humanoid
            L2_4 = L1_4
            L1_4 = L1_4.ChangeState
            L3_4 = "Seated"
            L1_4(L2_4, L3_4)
          end
        end
      end
      
      L2_3(L3_3, L4_3)
    end
    L0_3 = toggle
    if L0_3 == false then
      L0_3 = _G
      L0_3 = L0_3.infinjump
      if L0_3 == true then
        L0_3 = _G
        L0_3.infinjump = false
      else
      end
    end
  end
  
  L1_2(L2_2, L3_2)
end

L134_1 = coroutine
L134_1 = L134_1.wrap
L135_1 = L133_1
L134_1 = L134_1(L135_1)
L134_1()

function L134_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L109_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L109_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = Instance
    L0_3 = L0_3.new
    L1_3 = "HopperBin"
    L2_3 = game
    L3_3 = L2_3
    L2_3 = L2_3.service
    L4_3 = "Players"
    L2_3 = L2_3(L3_3, L4_3)
    L2_3 = L2_3.LocalPlayer
    L2_3 = L2_3.Backpack
    L0_3 = L0_3(L1_3, L2_3)
    bin = L0_3
    L0_3 = bin
    L0_3.Name = "Teleport"
    
    function L0_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4
      L1_4 = game
      L2_4 = L1_4
      L1_4 = L1_4.service
      L3_4 = "Players"
      L1_4 = L1_4(L2_4, L3_4)
      L1_4 = L1_4.LocalPlayer
      if L1_4 ~= nil then
        L2_4 = L1_4.Character
        if L2_4 ~= nil then
          goto lbl_12
        end
      end
      do return end
      ::lbl_12::
      L2_4 = L1_4.Character
      L4_4 = L2_4
      L3_4 = L2_4.MoveTo
      L5_4 = A0_4
      L3_4(L4_4, L5_4)
    end
    
    teleportPlayer = L0_3
    L0_3 = true
    enabled = L0_3
    
    function L0_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4
      L1_4 = enabled
      if not L1_4 then
        return
      end
      L1_4 = game
      L2_4 = L1_4
      L1_4 = L1_4.service
      L3_4 = "Players"
      L1_4 = L1_4(L2_4, L3_4)
      L1_4 = L1_4.LocalPlayer
      if L1_4 == nil then
        return
      end
      L2_4 = A0_4.Hit
      L3_4 = teleportPlayer
      L4_4 = L2_4.p
      L3_4(L4_4)
    end
    
    onButton1Down = L0_3
    
    function L0_3(A0_4)
      local L1_4, L2_4, L3_4
      L1_4 = A0_4.Button1Down
      L2_4 = L1_4
      L1_4 = L1_4.connect
      
      function L3_4()
        local L0_5, L1_5
        L0_5 = onButton1Down
        L1_5 = A0_4
        L0_5(L1_5)
      end
      
      L1_4(L2_4, L3_4)
    end
    
    onSelected = L0_3
    L0_3 = bin
    L0_3 = L0_3.Selected
    L1_3 = L0_3
    L0_3 = L0_3.connect
    L2_3 = onSelected
    L0_3(L1_3, L2_3)
  end
  
  L1_2(L2_2, L3_2)
end

L135_1 = coroutine
L135_1 = L135_1.wrap
L136_1 = L134_1
L135_1 = L135_1(L136_1)
L135_1()

function L135_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L112_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L112_1
  L1_2 = L1_2.MouseButton1Click
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3
    L0_3 = game
    L0_3 = L0_3.StarterGui
    L1_3 = L0_3
    L0_3 = L0_3.SetCoreGuiEnabled
    L2_3 = Enum
    L2_3 = L2_3.CoreGuiType
    L2_3 = L2_3.Backpack
    L3_3 = true
    L0_3(L1_3, L2_3, L3_3)
    L0_3 = pairs
    L1_3 = game
    L2_3 = L1_3
    L1_3 = L1_3.GetService
    L3_3 = "Workspace"
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L1_3
    L1_3 = L1_3.GetChildren
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3 = L1_3(L2_3)
    L0_3, L1_3, L2_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
    for L3_3, L4_3 in L0_3, L1_3, L2_3 do
      L5_3 = L4_3.ClassName
      if L5_3 == "Part" then
        L4_3.Locked = false
      end
      L5_3 = L4_3.ClassName
      if L5_3 == "MeshPart" then
        L4_3.Locked = false
      end
      L5_3 = L4_3.ClassName
      if L5_3 == "UnionOperation" then
        L4_3.Locked = false
      end
      L5_3 = L4_3.ClassName
      if L5_3 == "Model" then
        L5_3 = pairs
        L7_3 = L4_3
        L6_3 = L4_3.GetChildren
        L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3 = L6_3(L7_3)
        L5_3, L6_3, L7_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
        for L8_3, L9_3 in L5_3, L6_3, L7_3 do
          L10_3 = L9_3.ClassName
          if L10_3 == "Part" then
            L9_3.Locked = false
          end
          L10_3 = L9_3.ClassName
          if L10_3 == "MeshPart" then
            L9_3.Locked = false
          end
          L10_3 = L9_3.ClassName
          if L10_3 == "UnionOperation" then
            L9_3.Locked = false
          end
          L10_3 = L9_3.ClassName
          if L10_3 == "Model" then
            L10_3 = pairs
            L12_3 = L9_3
            L11_3 = L9_3.GetChildren
            L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3 = L11_3(L12_3)
            L10_3, L11_3, L12_3 = L10_3(L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
            for L13_3, L14_3 in L10_3, L11_3, L12_3 do
              L15_3 = L14_3.ClassName
              if L15_3 == "Part" then
                L14_3.Locked = false
              end
              L15_3 = L14_3.ClassName
              if L15_3 == "MeshPart" then
                L14_3.Locked = false
              end
              L15_3 = L14_3.ClassName
              if L15_3 == "UnionOperation" then
                L14_3.Locked = false
              end
              L15_3 = print
              L16_3 = "twitter.com/M4KubeX"
              L15_3(L16_3)
              L15_3 = L14_3.ClassName
              if L15_3 == "Model" then
                L15_3 = pairs
                L17_3 = L14_3
                L16_3 = L14_3.GetChildren
                L16_3, L17_3, L18_3, L19_3, L20_3 = L16_3(L17_3)
                L15_3, L16_3, L17_3 = L15_3(L16_3, L17_3, L18_3, L19_3, L20_3)
                for L18_3, L19_3 in L15_3, L16_3, L17_3 do
                  L20_3 = L19_3.ClassName
                  if L20_3 == "Part" then
                    L19_3.Locked = false
                  end
                  L20_3 = L19_3.ClassName
                  if L20_3 == "MeshPart" then
                    L19_3.Locked = false
                  end
                  L20_3 = L19_3.ClassName
                  if L20_3 == "UnionOperation" then
                    L19_3.Locked = false
                  end
                  L20_3 = L19_3.ClassName
                  if L20_3 == "Model" then
                  end
                end
              end
            end
          end
        end
      end
    end
    L0_3 = Instance
    L0_3 = L0_3.new
    L1_3 = "HopperBin"
    L2_3 = game
    L3_3 = L2_3
    L2_3 = L2_3.GetService
    L4_3 = "Players"
    L2_3 = L2_3(L3_3, L4_3)
    L2_3 = L2_3.LocalPlayer
    L2_3 = L2_3.Backpack
    L0_3 = L0_3(L1_3, L2_3)
    c = L0_3
    L0_3 = c
    L1_3 = Enum
    L1_3 = L1_3.BinType
    L1_3 = L1_3.Hammer
    L0_3.BinType = L1_3
    L0_3 = Instance
    L0_3 = L0_3.new
    L1_3 = "HopperBin"
    L2_3 = game
    L3_3 = L2_3
    L2_3 = L2_3.GetService
    L4_3 = "Players"
    L2_3 = L2_3(L3_3, L4_3)
    L2_3 = L2_3.LocalPlayer
    L2_3 = L2_3.Backpack
    L0_3 = L0_3(L1_3, L2_3)
    c = L0_3
    L0_3 = c
    L1_3 = Enum
    L1_3 = L1_3.BinType
    L1_3 = L1_3.Clone
    L0_3.BinType = L1_3
    L0_3 = Instance
    L0_3 = L0_3.new
    L1_3 = "HopperBin"
    L2_3 = game
    L3_3 = L2_3
    L2_3 = L2_3.GetService
    L4_3 = "Players"
    L2_3 = L2_3(L3_3, L4_3)
    L2_3 = L2_3.LocalPlayer
    L2_3 = L2_3.Backpack
    L0_3 = L0_3(L1_3, L2_3)
    c = L0_3
    L0_3 = c
    L1_3 = Enum
    L1_3 = L1_3.BinType
    L1_3 = L1_3.Grab
    L0_3.BinType = L1_3
  end
  
  L1_2(L2_2, L3_2)
end

L136_1 = coroutine
L136_1 = L136_1.wrap
L137_1 = L135_1
L136_1 = L136_1(L137_1)
L136_1()

function L136_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = Instance
  L0_2 = L0_2.new
  L1_2 = "LocalScript"
  L2_2 = L2_1
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L0_2.Parent
  L1_2 = L1_2.Parent
  L1_2 = L1_2.LIGHTUX
  L2_2 = Enum
  L2_2 = L2_2.KeyCode
  L2_2 = L2_2.L
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "UserInputService"
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = true
  L5_2 = L3_2.InputBegan
  L6_2 = L5_2
  L5_2 = L5_2.Connect
  
  function L7_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A0_3.KeyCode
    L3_3 = L2_2
    if L2_3 == L3_3 then
      L2_3 = L3_2
      L3_3 = L2_3
      L2_3 = L2_3.GetFocusedTextBox
      L2_3 = L2_3(L3_3)
      if L2_3 == nil then
        L2_3 = L4_2
        if L2_3 == false then
          L2_3 = true
          L4_2 = L2_3
          L2_3 = L1_2
          L3_3 = L4_2
          L2_3.Visible = L3_3
        else
          L2_3 = L4_2
          if L2_3 == true then
            L2_3 = false
            L4_2 = L2_3
            L2_3 = L1_2
            L3_3 = L4_2
            L2_3.Visible = L3_3
          end
        end
      end
    end
  end
  
  L5_2(L6_2, L7_2)
end

L137_1 = coroutine
L137_1 = L137_1.wrap
L138_1 = L136_1
L137_1 = L137_1(L138_1)
L137_1()
