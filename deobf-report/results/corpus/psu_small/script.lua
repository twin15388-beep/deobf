local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1
goto lbl_275
while "HttpGet" do
  L0_1 = loadstring
  L1_1 = game
  L2_1 = L1_1
  L1_1 = L1_1.HttpGet
  L3_1 = "https://raw.githubusercontent.com/HimikoToga1474/Public-Releases/master/Wally%20v3"
  L1_1(L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
  L0_1 = L0_1(L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
  L0_1 = L0_1()
  L2_1 = L0_1
  L1_1 = L0_1.CreateWindow
  L3_1 = "Shark Evolution"
  L1_1 = L1_1(L2_1, L3_1)
  L3_1 = L0_1
  L2_1 = L0_1.CreateWindow
  L4_1 = "Version: 1.0.2"
  L2_1 = L2_1(L3_1, L4_1)
  L4_1 = L1_1
  L3_1 = L1_1.CreateFolder
  L5_1 = "Main Functions"
  L3_1 = L3_1(L4_1, L5_1)
  L5_1 = L2_1
  L4_1 = L2_1.CreateFolder
  L6_1 = "Misc Functions"
  L4_1 = L4_1(L5_1, L6_1)
  L6_1 = L1_1
  L5_1 = L1_1.CreateFolder
  L7_1 = "GUI Settings"
  L5_1 = L5_1(L6_1, L7_1)
  L7_1 = L1_1
  L6_1 = L1_1.CreateFolder
  L8_1 = "Credits"
  L6_1 = L6_1(L7_1, L8_1)
  L7_1 = getgenv
  L7_1 = L7_1()
  L8_1 = {}
  L9_1 = "1"
  L10_1 = "2"
  L11_1 = "3"
  L12_1 = "4"
  L13_1 = "5"
  L14_1 = "6"
  L15_1 = "7"
  L16_1 = "8"
  L17_1 = "9"
  L8_1[1] = L9_1
  L8_1[2] = L10_1
  L8_1[3] = L11_1
  L8_1[4] = L12_1
  L8_1[5] = L13_1
  L8_1[6] = L14_1
  L8_1[7] = L15_1
  L8_1[8] = L16_1
  L8_1[9] = L17_1
  L7_1.Areas = L8_1
  L7_1 = getgenv
  L7_1 = L7_1()
  L8_1 = {}
  L9_1 = "1"
  L10_1 = "2"
  L8_1[1] = L9_1
  L8_1[2] = L10_1
  L7_1.Mobs = L8_1
  L7_1 = getgenv
  L7_1 = L7_1()
  L8_1 = {}
  L9_1 = "1"
  L10_1 = "2"
  L11_1 = "3"
  L12_1 = "4"
  L13_1 = "5"
  L14_1 = "6"
  L15_1 = "7"
  L16_1 = "8"
  L17_1 = "9"
  L8_1[1] = L9_1
  L8_1[2] = L10_1
  L8_1[3] = L11_1
  L8_1[4] = L12_1
  L8_1[5] = L13_1
  L8_1[6] = L14_1
  L8_1[7] = L15_1
  L8_1[8] = L16_1
  L8_1[9] = L17_1
  L7_1.Artifacts = L8_1
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.SelectedArea = "1"
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.SelectedMob = "1"
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.Artifact = "1"
  L7_1 = getgenv
  L7_1 = L7_1()
  L8_1 = tostring
  L9_1 = "Monster"
  L10_1 = "_"
  L11_1 = getgenv
  L11_1 = L11_1()
  L11_1 = L11_1.SelectedArea
  L12_1 = "_"
  L13_1 = getgenv
  L13_1 = L13_1()
  L13_1 = L13_1.SelectedMob
  L9_1 = L9_1 .. L10_1 .. L11_1 .. L12_1 .. L13_1
  L8_1 = L8_1(L9_1)
  L7_1.SupaString = L8_1
  L7_1 = getgenv
  L7_1 = L7_1()
  L8_1 = tostring
  L9_1 = "Boss"
  L10_1 = "_"
  L11_1 = getgenv
  L11_1 = L11_1()
  L11_1 = L11_1.SelectedArea
  L12_1 = "_"
  L13_1 = "1"
  L9_1 = L9_1 .. L10_1 .. L11_1 .. L12_1 .. L13_1
  L8_1 = L8_1(L9_1)
  L7_1.SupaBossString = L8_1
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.OpenString = "MergeOneInventory"
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.AutoFarmingMob = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.AutoFarmingBoss = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.AutoChargeSkill = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.OpenArtifacts = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.AutoEvolveOrMutate = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.EquipBest = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.Open3 = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.AutoMerge = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.Noclip = false
  L7_1 = getgenv
  L7_1 = L7_1()
  L7_1.Speed = 10000
  L7_1 = true
  L8_1 = game
  L9_1 = L8_1
  L8_1 = L8_1.GetService
  L10_1 = "TweenService"
  L8_1 = L8_1(L9_1, L10_1)
  L9_1 = game
  L10_1 = L9_1
  L9_1 = L9_1.GetService
  L11_1 = "RunService"
  L9_1 = L9_1(L10_1, L11_1)
  
  function L10_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    goto lbl_16
    while "huge" do
      goto lbl_14
      goto lbl_14
      L7_2 = pcall
      
      function L8_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
        goto lbl_14
        repeat
          repeat
            repeat
              repeat
                repeat
                  while true do
                    do return end
                    while true do
                      L0_3 = L6_2
                      L0_3 = L0_3.Humanoid
                      L0_3 = L0_3.Health
                      if 0 < L0_3 then
                        goto lbl_26
                        goto lbl_26
                        while "match" do
                          L1_2 = L0_3
                          L1_3 = L6_2
                          L0_2 = L1_3
                          ::lbl_14::
                          L0_3 = string
                          L0_3 = L0_3.match
                          L1_3 = L6_2
                          L1_3 = L1_3.Name
                          L2_3 = getgenv
                          L2_3 = L2_3()
                          L2_3 = L2_3.SupaString
                          L0_3 = L0_3(L1_3, L2_3)
                          goto lbl_50
                          goto lbl_50
                          ::lbl_26::
                          L0_3 = game
                          L0_3 = L0_3.Players
                          L0_3 = L0_3.LocalPlayer
                          L0_3 = L0_3.Character
                          L0_3 = L0_3.HumanoidRootPart
                          L0_3 = L0_3.Position
                          L1_3 = L6_2
                          L1_3 = L1_3.HumanoidRootPart
                          L1_3 = L1_3.Position
                          L0_3 = L0_3 - L1_3
                          L0_3 = L0_3.magnitude
                          L1_3 = L1_2
                          goto lbl_41
                          ::lbl_41::
                        end
                      end
                      while true do
                        L0_3 = L6_2
                        L1_3 = L0_3
                        L0_3 = L0_3.FindFirstChild
                        L2_3 = "Humanoid"
                        L0_3 = L0_3(L1_3, L2_3)
                        do break end
                        do break end
                        ::lbl_50::
                        L0_3 = L6_2
                        L0_3 = L0_3.ClassName
                        goto lbl_55
                        ::lbl_55::
                      end
                      L0_3 = L6_2
                      L1_3 = L0_3
                      L0_3 = L0_3.FindFirstChild
                      L2_3 = "HumanoidRootPart"
                      L0_3 = L0_3(L1_3, L2_3)
                      goto lbl_63
                      ::lbl_63::
                    end
                  end
                until L0_3
              until L0_3 < L1_3
            until L0_3
          until L0_3 == "Model"
        until L0_3
      end
      
      L7_2(L8_2)
      L0_2 = L0_2
      ::lbl_14::
      for L5_2, L6_2 in L2_2, L3_2, L4_2 do
      end
      do return L0_2 end
      do return end
      ::lbl_16::
      L1_2 = math
      L1_2 = L1_2.huge
      L2_2 = pairs
      L3_2 = workspace
      L3_2 = L3_2.Monster
      L4_2 = L3_2
      L3_2 = L3_2.GetChildren
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
      L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    end
  end
  
  function L11_1()
    local L0_2, L1_2, L2_2
    goto lbl_15
    while "GetService" do
      do return end
      repeat
        L1_2 = false
        do return L1_2 end
        while "LocalPlayer" do
          L0_2 = game
          L1_2 = L0_2
          L0_2 = L0_2.GetService
          L2_2 = "Players"
          L0_2 = L0_2(L1_2, L2_2)
          L0_2 = L0_2.LocalPlayer
          L0_2 = L0_2.CharacterAdded
          L1_2 = L0_2
          L0_2 = L0_2.Wait
          L0_2 = L0_2(L1_2)
          do break end
          while true do
            do return L0_2 end
            ::lbl_15::
            L0_2 = game
            L1_2 = L0_2
            L0_2 = L0_2.GetService
            L2_2 = "Players"
            L0_2 = L0_2(L1_2, L2_2)
            L0_2 = L0_2.LocalPlayer
            L0_2 = L0_2.Character
            if not L0_2 then
              goto lbl_24
              ::lbl_24::
            end
            goto lbl_28
            ::lbl_28::
          end
        end
      until L0_2
    end
  end
  
  function L12_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    goto lbl_48
    while true do
      if L3_2 then
        goto lbl_10
      repeat
        repeat
          repeat
            else
              while true do
                do return end
                while true do
                  L9_2 = L7_2
                  L8_2 = L7_2.Destroy
                  L8_2(L9_2)
                  ::lbl_10::
                  L4_2 = TweenInfo
                  L4_2 = L4_2.new
                  L5_2 = L3_2.Position
                  L5_2 = L5_2 - A0_2
                  L5_2 = L5_2.magnitude
                  L6_2 = Speed
                  L5_2 = L5_2 / L6_2
                  L6_2 = Enum
                  L6_2 = L6_2.EasingStyle
                  L6_2 = L6_2.Linear
                  L4_2 = L4_2(L5_2, L6_2)
                  L5_2 = {}
                  L6_2 = CFrame
                  L6_2 = L6_2.new
                  L7_2 = A0_2
                  L8_2 = A1_2
                  L6_2 = L6_2(L7_2, L8_2)
                  L5_2.CFrame = L6_2
                  L6_2 = L8_1
                  L7_2 = L6_2
                  L6_2 = L6_2.Create
                  L8_2 = L3_2
                  L9_2 = L4_2
                  L10_2 = L5_2
                  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
                  L8_2 = L6_2
                  L7_2 = L6_2.Play
                  L7_2(L8_2)
                  L7_2 = L7_1
                  goto lbl_63
                  goto lbl_63
                  while true do
                    L4_2 = L2_2
                    L3_2 = L2_2.FindFirstChild
                    L5_2 = "HumanoidRootPart"
                    L3_2 = L3_2(L4_2, L5_2)
                    if L3_2 then
                      goto lbl_62
                    end
                    do break end
                    do break end
                    ::lbl_48::
                    L2_2 = L11_1
                    L2_2 = L2_2()
                    goto lbl_54
                    goto lbl_54
                    ::lbl_54::
                    L4_2 = L2_2
                    L3_2 = L2_2.FindFirstChild
                    L5_2 = "Torso"
                    L3_2 = L3_2(L4_2, L5_2)
                    if L3_2 then
                      goto lbl_62
                    end
                    goto lbl_60
                    ::lbl_60::
                  end
                  L3_2 = false
                  ::lbl_62::
                  ::lbl_63::
                  L7_2 = Instance
                  L7_2 = L7_2.new
                  L8_2 = "BodyVelocity"
                  L7_2 = L7_2(L8_2)
                  L7_2.Parent = L3_2
                  L8_2 = Vector3
                  L8_2 = L8_2.new
                  L9_2 = math
                  L9_2 = L9_2.huge
                  L10_2 = math
                  L10_2 = L10_2.huge
                  L11_2 = math
                  L11_2 = L11_2.huge
                  L8_2 = L8_2(L9_2, L10_2, L11_2)
                  L7_2.MaxForce = L8_2
                  L8_2 = Vector3
                  L8_2 = L8_2.new
                  L9_2 = 0
                  L10_2 = 0
                  L11_2 = 0
                  L8_2 = L8_2(L9_2, L10_2, L11_2)
                  L7_2.Velocity = L8_2
                  L8_2 = L6_2.Completed
                  L9_2 = L8_2
                  L8_2 = L8_2.wait
                  L8_2(L9_2)
                  goto lbl_91
                  ::lbl_91::
                end
              end
            end
          until L7_2 == true
        until L2_2
      until L7_2
    end
  end
  
  L14_1 = L3_1
  L13_1 = L3_1.Dropdown
  L15_1 = "Areas"
  L16_1 = getgenv
  L16_1 = L16_1()
  L16_1 = L16_1.Areas
  
  function L17_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.SelectedArea = A0_2
    L1_2 = getgenv
    L1_2 = L1_2()
    L2_2 = tostring
    L3_2 = "Monster"
    L4_2 = "_"
    L5_2 = A0_2
    L6_2 = "_"
    L7_2 = getgenv
    L7_2 = L7_2()
    L7_2 = L7_2.SelectedMob
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2
    L2_2 = L2_2(L3_2)
    L1_2.SupaString = L2_2
    L1_2 = getgenv
    L1_2 = L1_2()
    L2_2 = tostring
    L3_2 = "Boss"
    L4_2 = "_"
    L5_2 = A0_2
    L6_2 = "_"
    L7_2 = "1"
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2
    L2_2 = L2_2(L3_2)
    L1_2.SupaBossString = L2_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1, L17_1)
  L14_1 = L3_1
  L13_1 = L3_1.Dropdown
  L15_1 = "Mobs"
  L16_1 = getgenv
  L16_1 = L16_1()
  L16_1 = L16_1.Mobs
  
  function L17_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.SelectedMob = A0_2
    L1_2 = getgenv
    L1_2 = L1_2()
    L2_2 = tostring
    L3_2 = "Monster"
    L4_2 = "_"
    L5_2 = getgenv
    L5_2 = L5_2()
    L5_2 = L5_2.SelectedArea
    L6_2 = "_"
    L7_2 = A0_2
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2
    L2_2 = L2_2(L3_2)
    L1_2.SupaString = L2_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1, L17_1)
  L14_1 = L3_1
  L13_1 = L3_1.Dropdown
  L15_1 = "Artifacts"
  L16_1 = getgenv
  L16_1 = L16_1()
  L16_1 = L16_1.Artifacts
  
  function L17_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.Artifact = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1, L17_1)
  L14_1 = L3_1
  L13_1 = L3_1.Slider
  L15_1 = "Speed"
  L16_1 = 50
  L17_1 = 10000
  
  function L18_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.Speed = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1, L17_1, L18_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "AutoFarm"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.AutoFarmingMob = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "AutoFarm Boss"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.AutoFarmingBoss = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "Auto Charge"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.AutoChargeSkill = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "Open 3 At Once"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.Open3 = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "AutoOpen Artifacts"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.OpenArtifacts = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "Auto Merge"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.AutoMerge = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "Equip Best Skill"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.EquipBest = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L3_1
  L13_1 = L3_1.Toggle
  L15_1 = "Auto Evolve/Mutate"
  
  function L16_1(A0_2)
    local L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L1_2 = getgenv
    L1_2 = L1_2()
    L1_2.AutoEvolveOrMutate = A0_2
    return
  end
  
  L13_1(L14_1, L15_1, L16_1)
  L14_1 = L6_1
  L13_1 = L6_1.Label
  L15_1 = "Wally/Aika: UI"
  L13_1(L14_1, L15_1)
  L14_1 = L6_1
  L13_1 = L6_1.Label
  L15_1 = "Himiko Toga#7006: Scripts"
  L13_1(L14_1, L15_1)
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    goto lbl_2
    ::lbl_2::
    while "OpenArtifacts" do
      L0_2 = wait
      L1_2 = 2
      L0_2 = L0_2(L1_2)
      if L0_2 then
        goto lbl_9
        goto lbl_9
        ::lbl_9::
        L0_2 = getgenv
        L0_2 = L0_2()
        L0_2 = L0_2.OpenArtifacts
        if not L0_2 then
          goto lbl_40
        end
        goto lbl_17
      else
        return
      end
      ::lbl_17::
      L0_2 = {}
      L1_2 = {}
      L2_2 = getgenv
      L2_2 = L2_2()
      L2_2 = L2_2.OpenString
      L1_2[1] = L2_2
      L2_2 = tonumber
      L3_2 = getgenv
      L3_2 = L3_2()
      L3_2 = L3_2.Artifact
      L2_2 = L2_2(L3_2)
      L1_2[2] = L2_2
      L0_2[1] = L1_2
      L1_2 = game
      L2_2 = L1_2
      L1_2 = L1_2.GetService
      L3_2 = "ReplicatedStorage"
      L1_2 = L1_2(L2_2, L3_2)
      L1_2 = L1_2.RemoteEvent
      L2_2 = L1_2
      L1_2 = L1_2.FireServer
      L3_2 = unpack
      L4_2 = L0_2
      L3_2(L4_2)
      L1_2(L2_2, L3_2, L4_2)
      ::lbl_40::
    end
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2
    goto lbl_10
    repeat
      do return end
      while "AutoFarmingMob" do
        L0_2 = getgenv
        L0_2 = L0_2()
        L0_2 = L0_2.AutoFarmingMob
        if L0_2 then
          do break end
          break
        end
        ::lbl_10::
        while "pcall" do
          L0_2 = wait
          L0_2 = L0_2()
          goto lbl_15
          ::lbl_15::
          L0_2 = L10_1
          L0_2 = L0_2()
          L1_2 = pcall
          
          function L2_2()
            local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
            goto lbl_12
            while true do
              L0_3 = L0_2
              L1_3 = L0_3
              L0_3 = L0_3.FindFirstChild
              L2_3 = "Humanoid"
              L0_3 = L0_3(L1_3, L2_3)
              L0_3 = L0_3.Health
              if 0 < L0_3 then
                goto lbl_27
              repeat
                repeat
                  repeat
                    repeat
                      repeat
                        else
                          while "wait" do
                            do return end
                            ::lbl_12::
                            L0_3 = L0_2
                            L1_3 = L0_3
                            L0_3 = L0_3.FindFirstChild
                            L2_3 = "HumanoidRootPart"
                            L0_3 = L0_3(L1_3, L2_3)
                            if L0_3 then
                              goto lbl_75
                              goto lbl_75
                              while "Vector3" do
                                L1_3 = getgenv
                                L1_3 = L1_3()
                                L1_3 = L1_3.AutoFarmingMob
                                if L1_3 then
                                  goto lbl_27
                                end
                                ::lbl_27::
                                L0_3 = wait
                                L0_3()
                                L0_3 = L12_1
                                L1_3 = L0_2
                                L1_3 = L1_3.Monster
                                L1_3 = L1_3.Hit_Part
                                L1_3 = L1_3.Position
                                L2_3 = Vector3
                                L2_3 = L2_3.new
                                L3_3 = -1
                                L4_3 = 0
                                L5_3 = 0
                                L2_3 = L2_3(L3_3, L4_3, L5_3)
                                L1_3 = L1_3 + L2_3
                                L2_3 = L0_2
                                L2_3 = L2_3.Monster
                                L2_3 = L2_3.Hit_Part
                                L2_3 = L2_3.Position
                                L0_3(L1_3, L2_3)
                                L0_3 = {}
                                L1_3 = {}
                                L1_3[1] = "AttackMonster"
                                L2_3 = L0_2
                                L1_3[2] = L2_3
                                L0_3[1] = L1_3
                                L1_3 = game
                                L2_3 = L1_3
                                L1_3 = L1_3.GetService
                                L3_3 = "ReplicatedStorage"
                                L1_3 = L1_3(L2_3, L3_3)
                                L1_3 = L1_3.RemoteEvent
                                L2_3 = L1_3
                                L1_3 = L1_3.FireServer
                                L3_3 = unpack
                                L4_3 = L0_3
                                L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
                                L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
                                L1_3 = L0_2
                                do break end
                                do break end
                                while true do
                                  L1_3 = L0_2
                                  L2_3 = L1_3
                                  L1_3 = L1_3.FindFirstChild
                                  L3_3 = "Humanoid"
                                  L1_3 = L1_3(L2_3, L3_3)
                                  goto lbl_83
                                  goto lbl_83
                                  ::lbl_75::
                                  L0_3 = L0_2
                                  L1_3 = L0_3
                                  L0_3 = L0_3.FindFirstChild
                                  L2_3 = "Humanoid"
                                  L0_3 = L0_3(L1_3, L2_3)
                                  goto lbl_82
                                  ::lbl_82::
                                  ::lbl_83::
                                  L1_3 = L0_2
                                  L1_3 = L1_3.Humanoid
                                  L1_3 = L1_3.Health
                                  goto lbl_89
                                  ::lbl_89::
                                  L1_3 = L0_2
                                  L2_3 = L1_3
                                  L1_3 = L1_3.FindFirstChild
                                  L3_3 = "HumanoidRootPart"
                                  L1_3 = L1_3(L2_3, L3_3)
                                  goto lbl_97
                                  ::lbl_97::
                                end
                              end
                            else
                            end
                          end
                        end
                      until L1_3
                    until L1_3
                  until L0_3
                until not (L1_3 <= 0)
              until L1_3
            end
          end
          
          L1_2(L2_2)
          L0_2 = L0_2
        end
      end
    until L0_2
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2
    goto lbl_7
    while "AutoFarmingBoss" do
      L0_2 = pcall
      
      function L1_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
        goto lbl_23
        while true do
          L6_3 = L4_3
          L5_3 = L4_3.FindFirstChild
          L7_3 = "Humanoid"
          L5_3 = L5_3(L6_3, L7_3)
          if L5_3 then
            goto lbl_59
            goto lbl_59
            while "Health" do
              L7_3 = L4_3
              L6_3 = L4_3.FindFirstChild
              L8_3 = "Humanoid"
              L6_3 = L6_3(L7_3, L8_3)
              if L6_3 then
                goto lbl_53
                goto lbl_53
                while 0 do
                  L6_3 = getgenv
                  L6_3 = L6_3()
                  L6_3 = L6_3.AutoFarmingBoss
                  if not L6_3 then
                    for L3_3, L4_3 in L0_3, L1_3, L2_3 do
                      goto lbl_42
                      ::lbl_23::
                      L0_3 = pairs
                      L1_3 = workspace
                      L1_3 = L1_3.Monster
                      L2_3 = L1_3
                      L1_3 = L1_3.GetChildren
                      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
                      L0_3, L1_3, L2_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
                      goto lbl_42
                      while true do
                        do return end
                        L5_3 = string
                        L5_3 = L5_3.find
                        L6_3 = L4_3.Name
                        L7_3 = getgenv
                        L7_3 = L7_3()
                        L7_3 = L7_3.SupaBossString
                        L5_3 = L5_3(L6_3, L7_3)
                        if L5_3 then
                          goto lbl_46
                          goto lbl_46
                        end
                        ::lbl_42::
                        repeat
                          repeat
                            repeat
                              repeat
                                repeat
                                  goto lbl_45
                                  ::lbl_45::
                                  ::lbl_46::
                                  L6_3 = L4_3
                                  L5_3 = L4_3.FindFirstChild
                                  L7_3 = "HumanoidRootPart"
                                  L5_3 = L5_3(L6_3, L7_3)
                                until L5_3
                                goto lbl_52
                                ::lbl_52::
                                ::lbl_53::
                                L6_3 = L4_3.Humanoid
                                L6_3 = L6_3.Health
                              until not (L6_3 <= 0)
                              goto lbl_58
                              ::lbl_58::
                              ::lbl_59::
                              L6_3 = L4_3
                              L5_3 = L4_3.FindFirstChild
                              L7_3 = "Humanoid"
                              L5_3 = L5_3(L6_3, L7_3)
                              L5_3 = L5_3.Health
                            until 0 < L5_3
                            goto lbl_74
                            while true do
                              L7_3 = L4_3
                              L6_3 = L4_3.FindFirstChild
                              L8_3 = "HumanoidRootPart"
                              L6_3 = L6_3(L7_3, L8_3)
                              goto lbl_73
                              ::lbl_73::
                              ::lbl_74::
                              L5_3 = wait
                              L5_3()
                              L5_3 = L12_1
                              L6_3 = L4_3.Monster
                              L6_3 = L6_3.Hit_Part
                              L6_3 = L6_3.Position
                              L7_3 = Vector3
                              L7_3 = L7_3.new
                              L8_3 = -1
                              L9_3 = 0
                              L10_3 = 0
                              L7_3 = L7_3(L8_3, L9_3, L10_3)
                              L6_3 = L6_3 + L7_3
                              L7_3 = L4_3.Monster
                              L7_3 = L7_3.Hit_Part
                              L7_3 = L7_3.Position
                              L5_3(L6_3, L7_3)
                              L5_3 = {}
                              L6_3 = {}
                              L6_3[1] = "AttackMonster"
                              L6_3[2] = L4_3
                              L5_3[1] = L6_3
                              L6_3 = game
                              L7_3 = L6_3
                              L6_3 = L6_3.GetService
                              L8_3 = "ReplicatedStorage"
                              L6_3 = L6_3(L7_3, L8_3)
                              L6_3 = L6_3.RemoteEvent
                              L7_3 = L6_3
                              L6_3 = L6_3.FireServer
                              L8_3 = unpack
                              L9_3 = L5_3
                              L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
                              L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
                              goto lbl_109
                              ::lbl_109::
                            end
                          until L6_3
                        until L4_3
                      end
                    end
                  else
                  end
                end
              end
            end
          end
        end
      end
      
      L0_2(L1_2)
      goto lbl_7
      ::lbl_7::
      repeat
        L0_2 = wait
        L0_2 = L0_2()
        if not L0_2 then
          goto lbl_20
        end
        goto lbl_13
        goto lbl_13
        ::lbl_13::
        L0_2 = getgenv
        L0_2 = L0_2()
        L0_2 = L0_2.AutoFarmingBoss
      until L0_2
      goto lbl_19
      ::lbl_19::
    end
    ::lbl_20::
    return
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2
    goto lbl_10
    repeat
      do return end
      while "AutoFarmingBoss" do
        L0_2 = getgenv
        L0_2 = L0_2()
        L0_2 = L0_2.AutoFarmingBoss
        if not L0_2 then
          break
        end
        goto lbl_16
        goto lbl_16
        ::lbl_10::
        while true do
          L0_2 = wait
          L0_2 = L0_2()
          goto lbl_20
          goto lbl_20
          ::lbl_16::
          repeat
            L0_2 = getgenv
            L0_2 = L0_2()
            L0_2.Noclip = true
            goto lbl_30
            ::lbl_20::
            L0_2 = getgenv
            L0_2 = L0_2()
            L0_2 = L0_2.AutoFarmingMob
          until not L0_2
          goto lbl_26
          ::lbl_26::
          L0_2 = getgenv
          L0_2 = L0_2()
          L0_2.Noclip = false
          ::lbl_30::
        end
      end
    until L0_2
  end
  
  L13_1(L14_1)
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2
    goto lbl_2
    ::lbl_2::
    L0_2 = game
    L1_2 = L0_2
    L0_2 = L0_2.GetService
    L2_2 = "RunService"
    L0_2 = L0_2(L1_2, L2_2)
    L0_2 = L0_2.Stepped
    L1_2 = L0_2
    L0_2 = L0_2.connect
    
    function L2_2()
      local L0_3, L1_3, L2_3
      goto lbl_3
      while "Noclip" do
        do return end
        ::lbl_3::
        L0_3 = getgenv
        L0_3 = L0_3()
        L0_3 = L0_3.Noclip
        if L0_3 then
          goto lbl_10
          goto lbl_10
          ::lbl_10::
          L0_3 = L11_1
          L0_3 = L0_3()
          L1_3 = L0_3
          L0_3 = L0_3.WaitForChild
          L2_3 = "Humanoid"
          L0_3 = L0_3(L1_3, L2_3)
          L1_3 = L0_3
          L0_3 = L0_3.ChangeState
          L2_3 = 11
          L0_3(L1_3, L2_3)
        end
      end
    end
    
    L0_2(L1_2, L2_2)
    return
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    goto lbl_2
    ::lbl_2::
    repeat
      while 1 do
        L0_2 = wait
        L0_2 = L0_2()
        if not L0_2 then
          goto lbl_30
        end
        do break end
        do break end
        while "getgenv" do
          L0_2 = {}
          L1_2 = {}
          L1_2[1] = "ClickChargeSkill"
          L0_2[1] = L1_2
          L1_2 = game
          L2_2 = L1_2
          L1_2 = L1_2.GetService
          L3_2 = "ReplicatedStorage"
          L1_2 = L1_2(L2_2, L3_2)
          L1_2 = L1_2.RemoteEvent
          L2_2 = L1_2
          L1_2 = L1_2.FireServer
          L3_2 = unpack
          L4_2 = L0_2
          L3_2(L4_2)
          L1_2(L2_2, L3_2, L4_2)
          L0_2 = getgenv
          L0_2 = L0_2()
          L0_2 = L0_2.AutoChargeSkill
          goto lbl_29
          ::lbl_29::
        end
      end
    until L0_2
    ::lbl_30::
    return
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2
    goto lbl_13
    while "Open3" do
      L0_2 = getgenv
      L0_2 = L0_2()
      L0_2 = L0_2.Open3
      if L0_2 then
        goto lbl_20
        goto lbl_20
      end
      L0_2 = getgenv
      L0_2 = L0_2()
      L0_2.OpenString = "OpenLootBoxOne"
      goto lbl_13
      ::lbl_13::
      while true do
        L0_2 = wait
        L0_2 = L0_2()
        if L0_2 then
          goto lbl_18
          ::lbl_18::
        end
        do return end
        ::lbl_20::
        L0_2 = getgenv
        L0_2 = L0_2()
        L0_2.OpenString = "OpenLootBoxThree"
      end
    end
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
    goto lbl_36
    repeat
      do return end
      while true do
        L0_2 = {}
        L1_2 = {}
        L1_2[1] = "MergeInventory"
        L0_2[1] = L1_2
        L1_2 = game
        L2_2 = L1_2
        L1_2 = L1_2.GetService
        L3_2 = "ReplicatedStorage"
        L1_2 = L1_2(L2_2, L3_2)
        L1_2 = L1_2.RemoteEvent
        L2_2 = L1_2
        L1_2 = L1_2.FireServer
        L3_2 = unpack
        L4_2 = L0_2
        L3_2(L4_2, L5_2)
        L1_2(L2_2, L3_2, L4_2, L5_2)
        L1_2 = wait
        L2_2 = 2
        L1_2(L2_2)
        L1_2 = {}
        L2_2 = {}
        L2_2[1] = "MergeOneInventory"
        L2_2[2] = 1
        L1_2[1] = L2_2
        L2_2 = game
        L3_2 = L2_2
        L2_2 = L2_2.GetService
        L4_2 = "ReplicatedStorage"
        L2_2 = L2_2(L3_2, L4_2)
        L2_2 = L2_2.RemoteEvent
        L3_2 = L2_2
        L2_2 = L2_2.FireServer
        L4_2 = unpack
        L5_2 = L1_2
        L4_2(L5_2)
        L2_2(L3_2, L4_2, L5_2)
        goto lbl_36
        ::lbl_36::
        repeat
          L0_2 = wait
          L1_2 = 2
          L0_2 = L0_2(L1_2)
          goto lbl_43
          goto lbl_43
          ::lbl_43::
          L0_2 = getgenv
          L0_2 = L0_2()
          L0_2 = L0_2.AutoMerge
        until L0_2
        goto lbl_49
        ::lbl_49::
      end
    until L0_2
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    goto lbl_26
    while true do
      L0_2 = {}
      L1_2 = {}
      L1_2[1] = "EquipSkill"
      L1_2[2] = 1
      L1_2[3] = true
      L0_2[1] = L1_2
      L1_2 = game
      L2_2 = L1_2
      L1_2 = L1_2.GetService
      L3_2 = "ReplicatedStorage"
      L1_2 = L1_2(L2_2, L3_2)
      L1_2 = L1_2.RemoteEvent
      L2_2 = L1_2
      L1_2 = L1_2.FireServer
      L3_2 = unpack
      L4_2 = L0_2
      L3_2(L4_2)
      L1_2(L2_2, L3_2, L4_2)
      do break end
      while true do
        L0_2 = getgenv
        L0_2 = L0_2()
        L0_2 = L0_2.EquipBest
        if L0_2 then
          goto lbl_25
          ::lbl_25::
        end
        ::lbl_26::
        L0_2 = wait
        L1_2 = 10
        L0_2 = L0_2(L1_2)
        if not L0_2 then
          break
        end
        goto lbl_32
        ::lbl_32::
      end
    end
    return
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    goto lbl_25
    repeat
      do return end
      while true do
        L0_2 = {}
        L1_2 = {}
        L1_2[1] = "EvolveOrMutateNextShark"
        L0_2[1] = L1_2
        L1_2 = game
        L2_2 = L1_2
        L1_2 = L1_2.GetService
        L3_2 = "ReplicatedStorage"
        L1_2 = L1_2(L2_2, L3_2)
        L1_2 = L1_2.RemoteEvent
        L2_2 = L1_2
        L1_2 = L1_2.FireServer
        L3_2 = unpack
        L4_2 = L0_2
        L3_2(L4_2)
        L1_2(L2_2, L3_2, L4_2)
        do break end
        while true do
          L0_2 = getgenv
          L0_2 = L0_2()
          L0_2 = L0_2.AutoEvolveOrMutate
          if L0_2 then
            goto lbl_24
            ::lbl_24::
          end
          ::lbl_25::
          L0_2 = wait
          L1_2 = 0.5
          L0_2 = L0_2(L1_2)
          goto lbl_31
          ::lbl_31::
        end
      end
    until L0_2
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L13_1 = coroutine
  L13_1 = L13_1.wrap
  
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2
    goto lbl_2
    ::lbl_2::
    repeat
      L0_2 = wait
      L0_2()
      L0_2 = game
      L1_2 = L0_2
      L0_2 = L0_2.IsLoaded
      L0_2 = L0_2(L1_2)
    until L0_2
    goto lbl_11
    goto lbl_11
    ::lbl_11::
    L0_2 = wait
    L1_2 = 0.1
    L0_2(L1_2)
    L0_2 = game
    L1_2 = L0_2
    L0_2 = L0_2.service
    L2_2 = "VirtualUser"
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = game
    L2_2 = L1_2
    L1_2 = L1_2.service
    L3_2 = "Players"
    L1_2 = L1_2(L2_2, L3_2)
    L1_2 = L1_2.LocalPlayer
    L1_2 = L1_2.Idled
    L2_2 = L1_2
    L1_2 = L1_2.connect
    
    function L3_2()
      local L0_3, L1_3, L2_3, L3_3
      goto lbl_2
      ::lbl_2::
      L0_3 = L0_2
      L1_3 = L0_3
      L0_3 = L0_3.CaptureController
      L0_3(L1_3)
      L0_3 = L0_2
      L1_3 = L0_3
      L0_3 = L0_3.ClickButton2
      L2_3 = Vector2
      L2_3 = L2_3.new
      L2_3(L3_3)
      L0_3(L1_3, L2_3, L3_3)
      return
    end
    
    L1_2(L2_2, L3_2)
    return
  end
  
  L13_1 = L13_1(L14_1)
  L13_1()
  L14_1 = L4_1
  L13_1 = L4_1.DestroyGUI
  L13_1(L14_1)
  L14_1 = L5_1
  L13_1 = L5_1.GuiSettings
  L13_1(L14_1)
  do return end
  ::lbl_275::
  L0_1 = game
  L0_1 = L0_1.Players
  L0_1 = L0_1.LocalPlayer
  L0_1 = L0_1.Name
  if L0_1 == "noah79250" then
    goto lbl_283
    goto lbl_283
    ::lbl_283::
    L0_1 = game
    L1_1 = L0_1
    L0_1 = L0_1.GetService
    L2_1 = "TeleportService"
    L0_1 = L0_1(L1_1, L2_1)
    L1_1 = L0_1
    L0_1 = L0_1.Teleport
    L2_1 = 5678709862
    L0_1(L1_1, L2_1)
  end
end
