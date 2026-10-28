local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1
L0_1 = getgenv
L0_1 = L0_1()
L0_1 = L0_1.Preset
if L0_1 == "Maxx" then
  L0_1 = _G
  L1_1 = Color3
  L1_1 = L1_1.fromRGB
  L2_1 = 255
  L3_1 = 184
  L4_1 = 0
  L1_1 = L1_1(L2_1, L3_1, L4_1)
  L0_1.SliderColor = L1_1
  L0_1 = _G
  L1_1 = Color3
  L1_1 = L1_1.fromRGB
  L2_1 = 255
  L3_1 = 184
  L4_1 = 0
  L1_1 = L1_1(L2_1, L3_1, L4_1)
  L0_1.ButtonColor = L1_1
  L0_1 = _G
  L1_1 = Color3
  L1_1 = L1_1.fromRGB
  L2_1 = 255
  L3_1 = 184
  L4_1 = 0
  L1_1 = L1_1(L2_1, L3_1, L4_1)
  L0_1.ToggleColor = L1_1
end
L0_1 = {}
L0_1.count = 0
L0_1.binding = false
L0_1.rainbowI = 0
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "TweenService"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = game
L3_1 = L2_1
L2_1 = L2_1.GetService
L4_1 = "Players"
L2_1 = L2_1(L3_1, L4_1)
L2_1 = L2_1.LocalPlayer
L3_1 = L2_1
L2_1 = L2_1.GetMouse
L2_1 = L2_1(L3_1)
L3_1 = game
L4_1 = L3_1
L3_1 = L3_1.GetService
L5_1 = "HttpService"
L3_1 = L3_1(L4_1, L5_1)
L5_1 = L3_1
L4_1 = L3_1.GenerateGUID
L6_1 = true
L4_1 = L4_1(L5_1, L6_1)
L5_1 = string
L5_1 = L5_1.gsub
L6_1 = L4_1
L7_1 = "{"
L8_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1)
L4_1 = L5_1
L5_1 = string
L5_1 = L5_1.gsub
L6_1 = L4_1
L7_1 = "}"
L8_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1)
L4_1 = L5_1
L5_1 = pairs
L6_1 = game
L7_1 = L6_1
L6_1 = L6_1.GetService
L8_1 = "CoreGui"
L6_1 = L6_1(L7_1, L8_1)
L7_1 = L6_1
L6_1 = L6_1.GetDescendants
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1, L6_1, L7_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
for L8_1, L9_1 in L5_1, L6_1, L7_1 do
  L10_1 = L9_1.Name
  if L10_1 == "HiI'mSexyDon'tTouchMePls" then
    L10_1 = L9_1.Parent
    L11_1 = L10_1
    L10_1 = L10_1.Destroy
    L10_1(L11_1)
  end
end
L5_1 = Instance
L5_1 = L5_1.new
L6_1 = "ScreenGui"
L5_1 = L5_1(L6_1)
L6_1 = tostring
L7_1 = L4_1
L6_1 = L6_1(L7_1)
L5_1.Name = L6_1
L6_1 = game
L7_1 = L6_1
L6_1 = L6_1.GetService
L8_1 = "CoreGui"
L6_1 = L6_1(L7_1, L8_1)
L5_1.Parent = L6_1
L6_1 = Instance
L6_1 = L6_1.new
L7_1 = "IntValue"
L8_1 = L5_1
L6_1 = L6_1(L7_1, L8_1)
L6_1.Name = "HiI'mSexyDon'tTouchMePls"
L7_1 = game
L8_1 = L7_1
L7_1 = L7_1.GetService
L9_1 = "UserInputService"
L7_1 = L7_1(L8_1, L9_1)
L7_1 = L7_1.InputEnded
L8_1 = L7_1
L7_1 = L7_1.Connect

function L9_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.KeyCode
  L2_2 = Enum
  L2_2 = L2_2.KeyCode
  L2_2 = L2_2.RightControl
  if L1_2 == L2_2 then
    L1_2 = L5_1
    L2_2 = L5_1
    L2_2 = L2_2.Enabled
    L2_2 = not L2_2
    L1_2.Enabled = L2_2
  end
  return
end

L7_1(L8_1, L9_1)

function L7_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L2_2 = {}
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "Players"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2.LocalPlayer
  L4_2 = L3_2
  L3_2 = L3_2.GetMouse
  L3_2 = L3_2(L4_2)
  L4_2 = game
  L5_2 = L4_2
  L4_2 = L4_2.GetService
  L6_2 = "UserInputService"
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = game
  L6_2 = L5_2
  L5_2 = L5_2.GetService
  L7_2 = "RunService"
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = L5_2.Heartbeat
  
  function L6_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = pcall
    
    function L2_3()
      local L0_4, L1_4
      L0_4 = A0_3
      L0_4 = L0_4.MouseEnter
      do return L0_4 end
      return
    end
    
    L1_3, L2_3 = L1_3(L2_3)
    if L1_3 then
      A0_3.Active = true
      L4_3 = L2_3
      L3_3 = L2_3.connect
      
      function L5_3()
        local L0_4, L1_4, L2_4, L3_4, L4_4
        L0_4 = A0_3
        L0_4 = L0_4.InputBegan
        L1_4 = L0_4
        L0_4 = L0_4.connect
        
        function L2_4(A0_5)
          local L1_5, L2_5, L3_5, L4_5
          L1_5 = A0_5.UserInputType
          L2_5 = Enum
          L2_5 = L2_5.UserInputType
          L2_5 = L2_5.MouseButton1
          if L1_5 == L2_5 then
            L1_5 = Vector2
            L1_5 = L1_5.new
            L2_5 = L3_2
            L2_5 = L2_5.X
            L3_5 = A0_3
            L3_5 = L3_5.AbsolutePosition
            L3_5 = L3_5.X
            L2_5 = L2_5 - L3_5
            L3_5 = L3_2
            L3_5 = L3_5.Y
            L4_5 = A0_3
            L4_5 = L4_5.AbsolutePosition
            L4_5 = L4_5.Y
            L3_5 = L3_5 - L4_5
            L1_5 = L1_5(L2_5, L3_5)
            while true do
              L2_5 = L5_2
              L3_5 = L2_5
              L2_5 = L2_5.wait
              L2_5 = L2_5(L3_5)
              if not L2_5 then
                break
              end
              L2_5 = L4_2
              L3_5 = L2_5
              L2_5 = L2_5.IsMouseButtonPressed
              L4_5 = Enum
              L4_5 = L4_5.UserInputType
              L4_5 = L4_5.MouseButton1
              L2_5 = L2_5(L3_5, L4_5)
              if not L2_5 then
                break
              end
              L2_5 = pcall
              
              function L3_5()
                local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6
                L0_6 = A0_3
                L1_6 = L0_6
                L0_6 = L0_6.TweenPosition
                L2_6 = UDim2
                L2_6 = L2_6.new
                L3_6 = 0
                L4_6 = L3_2
                L4_6 = L4_6.X
                L5_6 = L1_5
                L5_6 = L5_6.X
                L4_6 = L4_6 - L5_6
                L5_6 = A0_3
                L5_6 = L5_6.Size
                L5_6 = L5_6.X
                L5_6 = L5_6.Offset
                L6_6 = A0_3
                L6_6 = L6_6.AnchorPoint
                L6_6 = L6_6.X
                L5_6 = L5_6 * L6_6
                L4_6 = L4_6 + L5_6
                L5_6 = 0
                L6_6 = L3_2
                L6_6 = L6_6.Y
                L7_6 = L1_5
                L7_6 = L7_6.Y
                L6_6 = L6_6 - L7_6
                L7_6 = A0_3
                L7_6 = L7_6.Size
                L7_6 = L7_6.Y
                L7_6 = L7_6.Offset
                L8_6 = A0_3
                L8_6 = L8_6.AnchorPoint
                L8_6 = L8_6.Y
                L7_6 = L7_6 * L8_6
                L6_6 = L6_6 + L7_6
                L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
                L3_6 = "Out"
                L4_6 = "Quart"
                L5_6 = 0
                L6_6 = true
                L0_6(L1_6, L2_6, L3_6, L4_6, L5_6, L6_6)
                return
              end
              
              L2_5(L3_5)
            end
            A0_5 = A0_5
          end
          return
        end
        
        L0_4 = L0_4(L1_4, L2_4)
        L1_4 = nil
        L2_4 = A0_3
        L2_4 = L2_4.MouseLeave
        L3_4 = L2_4
        L2_4 = L2_4.connect
        
        function L4_4()
          local L0_5, L1_5
          L0_5 = L0_4
          L1_5 = L0_5
          L0_5 = L0_5.disconnect
          L0_5(L1_5)
          L0_5 = L1_4
          L1_5 = L0_5
          L0_5 = L0_5.disconnect
          L0_5(L1_5)
          return
        end
        
        L2_4 = L2_4(L3_4, L4_4)
        L1_4 = L2_4
        return
      end
      
      L3_3(L4_3, L5_3)
    end
    return
  end
  
  L2_2.new = L6_2
  A0_2 = A0_2
  L3_2 = coroutine
  L3_2 = L3_2.wrap
  
  function L4_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    while 359 do
      L0_3 = 0
      L1_3 = 359
      L2_3 = 1
      for L3_3 = L0_3, L1_3, L2_3 do
        L4_3 = L0_1
        L5_3 = L3_3 / 359
        L4_3.rainbowI = L5_3
        L4_3 = L0_1
        L5_3 = Color3
        L5_3 = L5_3.fromHSV
        L6_3 = L3_3 / 359
        L7_3 = 1
        L8_3 = 1
        L5_3 = L5_3(L6_3, L7_3, L8_3)
        L4_3.rainbowVal = L5_3
        L4_3 = wait
        L4_3()
      end
    end
    return
  end
  
  L3_2 = L3_2(L4_2)
  L3_2()
  L3_2 = L0_1
  L4_2 = L0_1
  L4_2 = L4_2.count
  L4_2 = L4_2 + 1
  L3_2.count = L4_2
  L3_2 = Instance
  L3_2 = L3_2.new
  L4_2 = "ImageLabel"
  L3_2 = L3_2(L4_2)
  L4_2 = Instance
  L4_2 = L4_2.new
  L5_2 = "TextLabel"
  L4_2 = L4_2(L5_2)
  L3_2.Name = "Window"
  L5_2 = L5_1
  L3_2.Parent = L5_2
  L5_2 = Color3
  L5_2 = L5_2.fromRGB
  L6_2 = 255
  L7_2 = 255
  L8_2 = 255
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L3_2.BackgroundColor3 = L5_2
  L3_2.BackgroundTransparency = 1
  L5_2 = UDim2
  L5_2 = L5_2.new
  L6_2 = 0
  L7_2 = L0_1
  L7_2 = L7_2.count
  L7_2 = 250 * L7_2
  L7_2 = L7_2 - 250
  L7_2 = 15 + L7_2
  L8_2 = 0
  L9_2 = 15
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L3_2.Position = L5_2
  L5_2 = UDim2
  L5_2 = L5_2.new
  L6_2 = 0
  L7_2 = 180
  L8_2 = 0
  L9_2 = 35
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L3_2.Size = L5_2
  L3_2.Image = "rbxassetid://4921672704"
  L5_2 = _G
  L5_2 = L5_2.MainColor
  if not L5_2 then
    L5_2 = Color3
    L5_2 = L5_2.fromRGB
    L6_2 = 20
    L7_2 = 20
    L8_2 = 20
    L5_2 = L5_2(L6_2, L7_2, L8_2)
  end
  L3_2.ImageColor3 = L5_2
  L5_2 = Enum
  L5_2 = L5_2.ScaleType
  L5_2 = L5_2.Slice
  L3_2.ScaleType = L5_2
  L5_2 = Rect
  L5_2 = L5_2.new
  L6_2 = 128
  L7_2 = 128
  L8_2 = 128
  L9_2 = 128
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L3_2.SliceCenter = L5_2
  L3_2.SliceScale = 0.05
  L5_2 = Instance
  L5_2 = L5_2.new
  L6_2 = "Frame"
  L5_2 = L5_2(L6_2)
  L6_2 = Instance
  L6_2 = L6_2.new
  L7_2 = "ImageButton"
  L6_2 = L6_2(L7_2)
  L7_2 = Instance
  L7_2 = L7_2.new
  L8_2 = "Frame"
  L7_2 = L7_2(L8_2)
  L8_2 = Instance
  L8_2 = L8_2.new
  L9_2 = "UIListLayout"
  L8_2 = L8_2(L9_2)
  L5_2.Name = "HideRounding"
  L5_2.Parent = L3_2
  L9_2 = _G
  L9_2 = L9_2.MainColor
  if not L9_2 then
    L9_2 = Color3
    L9_2 = L9_2.fromRGB
    L10_2 = 20
    L11_2 = 20
    L12_2 = 20
    L9_2 = L9_2(L10_2, L11_2, L12_2)
  end
  L5_2.BackgroundColor3 = L9_2
  L5_2.BorderSizePixel = 0
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 0
  L11_2 = 0
  L12_2 = 1
  L13_2 = -5
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L5_2.Position = L9_2
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 1
  L11_2 = 0
  L12_2 = 0
  L13_2 = 5
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L5_2.Size = L9_2
  L6_2.Name = "Arrow"
  L6_2.Parent = L3_2
  L9_2 = Color3
  L9_2 = L9_2.fromRGB
  L10_2 = 255
  L11_2 = 255
  L12_2 = 255
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L6_2.BackgroundColor3 = L9_2
  L6_2.BackgroundTransparency = 1
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 1
  L11_2 = -20
  L12_2 = 0
  L13_2 = 10
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L6_2.Position = L9_2
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 0
  L11_2 = 12
  L12_2 = 0
  L13_2 = 12
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L6_2.Size = L9_2
  L6_2.Image = "http://www.roblox.com/asset/?id=4921527706"
  L9_2 = _G
  L9_2 = L9_2.ArrowColor
  if not L9_2 then
    L9_2 = Color3
    L9_2 = L9_2.fromRGB
    L10_2 = 65
    L11_2 = 65
    L12_2 = 65
    L9_2 = L9_2(L10_2, L11_2, L12_2)
  end
  L6_2.ImageColor3 = L9_2
  L7_2.Name = "Sections"
  L7_2.Parent = L3_2
  L9_2 = Color3
  L9_2 = L9_2.fromRGB
  L10_2 = 255
  L11_2 = 255
  L12_2 = 255
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L7_2.BackgroundColor3 = L9_2
  L7_2.BackgroundTransparency = 1
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 0
  L11_2 = 0
  L12_2 = 1
  L13_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L7_2.Position = L9_2
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 1
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L7_2.Size = L9_2
  L4_2.Name = "Title"
  L4_2.Parent = L3_2
  L9_2 = Color3
  L9_2 = L9_2.fromRGB
  L10_2 = 255
  L11_2 = 255
  L12_2 = 255
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L4_2.BackgroundColor3 = L9_2
  L4_2.BackgroundTransparency = 1
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 0.850000024
  L11_2 = 0
  L12_2 = 1
  L13_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L4_2.Size = L9_2
  L9_2 = Enum
  L9_2 = L9_2.Font
  L9_2 = L9_2.SourceSansBold
  L4_2.Font = L9_2
  L4_2.Text = A1_2
  L9_2 = _G
  L9_2 = L9_2.MainTextColor
  if not L9_2 then
    L9_2 = Color3
    L9_2 = L9_2.fromRGB
    L10_2 = 255
    L11_2 = 255
    L12_2 = 255
    L9_2 = L9_2(L10_2, L11_2, L12_2)
  end
  L4_2.TextColor3 = L9_2
  L4_2.TextSize = 18
  L4_2.TextWrapped = true
  L8_2.Parent = L7_2
  L9_2 = Enum
  L9_2 = L9_2.SortOrder
  L9_2 = L9_2.LayoutOrder
  L8_2.SortOrder = L9_2
  L9_2 = false
  L10_2 = L6_2.MouseButton1Click
  L11_2 = L10_2
  L10_2 = L10_2.Connect
  
  function L12_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L0_3 = L9_2
    L0_3 = not L0_3
    L9_2 = L0_3
    L0_3 = L9_2
    if L0_3 then
      L0_3 = L7_2
      L1_3 = L0_3
      L0_3 = L0_3.TweenSize
      L2_3 = UDim2
      L2_3 = L2_3.new
      L3_3 = 1
      L4_3 = 0
      L5_3 = 0
      L6_3 = 1000
      L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
      L3_3 = Enum
      L3_3 = L3_3.EasingDirection
      L3_3 = L3_3.Out
      L4_3 = Enum
      L4_3 = L4_3.EasingStyle
      L4_3 = L4_3.Linear
      L5_3 = 0.2
      L6_3 = true
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3)
      L0_3 = L7_2
      L0_3.ClipsDescendants = false
      L0_3 = pairs
      L1_3 = L7_2
      L2_3 = L1_3
      L1_3 = L1_3.GetChildren
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
      L0_3, L1_3, L2_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
      for L3_3, L4_3 in L0_3, L1_3, L2_3 do
        L6_3 = L4_3
        L5_3 = L4_3.IsA
        L7_3 = "Frame"
        L5_3 = L5_3(L6_3, L7_3)
        if L5_3 then
          L6_3 = L4_3
          L5_3 = L4_3.TweenSize
          L7_3 = UDim2
          L7_3 = L7_3.new
          L8_3 = 1
          L9_3 = 0
          L10_3 = 0
          L11_3 = 35
          L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
          L8_3 = Enum
          L8_3 = L8_3.EasingDirection
          L8_3 = L8_3.Out
          L9_3 = Enum
          L9_3 = L9_3.EasingStyle
          L9_3 = L9_3.Linear
          L10_3 = 0.1
          L11_3 = true
          L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
        end
      end
      L0_3 = L1_1
      L1_3 = L0_3
      L0_3 = L0_3.Create
      L2_3 = L6_2
      L3_3 = TweenInfo
      L3_3 = L3_3.new
      L4_3 = 0.5
      L5_3 = Enum
      L5_3 = L5_3.EasingStyle
      L5_3 = L5_3.Quart
      L6_3 = Enum
      L6_3 = L6_3.EasingDirection
      L6_3 = L6_3.Out
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      L4_3 = {}
      L4_3.Rotation = -90
      L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
      L1_3 = L0_3
      L0_3 = L0_3.Play
      L0_3(L1_3)
    else
      L0_3 = pairs
      L1_3 = L7_2
      L2_3 = L1_3
      L1_3 = L1_3.GetChildren
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
      L0_3, L1_3, L2_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
      for L3_3, L4_3 in L0_3, L1_3, L2_3 do
        L6_3 = L4_3
        L5_3 = L4_3.IsA
        L7_3 = "Frame"
        L5_3 = L5_3(L6_3, L7_3)
        if L5_3 then
          L5_3 = L4_3.Size
          L6_3 = UDim2
          L6_3 = L6_3.new
          L7_3 = 1
          L8_3 = 0
          L9_3 = 0
          L10_3 = 35
          L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3)
          if L5_3 ~= L6_3 then
            L6_3 = L4_3
            L5_3 = L4_3.TweenSize
            L7_3 = UDim2
            L7_3 = L7_3.new
            L8_3 = 1
            L9_3 = 0
            L10_3 = 0
            L11_3 = 35
            L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
            L8_3 = Enum
            L8_3 = L8_3.EasingDirection
            L8_3 = L8_3.Out
            L9_3 = Enum
            L9_3 = L9_3.EasingStyle
            L9_3 = L9_3.Linear
            L10_3 = 0.1
            L11_3 = true
            
            function L12_3()
              local L0_4, L1_4
              L0_4 = L4_3
              L0_4.ClipsDescendants = true
              return
            end
            
            L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
          end
          L6_3 = L4_3
          L5_3 = L4_3.TweenSize
          L7_3 = UDim2
          L7_3 = L7_3.new
          L8_3 = 1
          L9_3 = 0
          L10_3 = 0
          L11_3 = 0
          L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
          L8_3 = Enum
          L8_3 = L8_3.EasingDirection
          L8_3 = L8_3.Out
          L9_3 = Enum
          L9_3 = L9_3.EasingStyle
          L9_3 = L9_3.Linear
          L10_3 = 0.1
          L11_3 = true
          L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          L5_3 = L1_1
          L6_3 = L5_3
          L5_3 = L5_3.Create
          L7_3 = L4_3.Folder
          L7_3 = L7_3.Arrow
          L8_3 = TweenInfo
          L8_3 = L8_3.new
          L9_3 = 0.5
          L10_3 = Enum
          L10_3 = L10_3.EasingStyle
          L10_3 = L10_3.Quart
          L11_3 = Enum
          L11_3 = L11_3.EasingDirection
          L11_3 = L11_3.Out
          L8_3 = L8_3(L9_3, L10_3, L11_3)
          L9_3 = {}
          L9_3.Rotation = 0
          L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
          L6_3 = L5_3
          L5_3 = L5_3.Play
          L5_3(L6_3)
        end
        L0_3 = L0_3
      end
      L0_3 = L7_2
      L0_3.ClipsDescendants = true
      L0_3 = L7_2
      L1_3 = L0_3
      L0_3 = L0_3.TweenSize
      L2_3 = UDim2
      L2_3 = L2_3.new
      L3_3 = 1
      L4_3 = 0
      L5_3 = 0
      L6_3 = 0
      L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
      L3_3 = Enum
      L3_3 = L3_3.EasingDirection
      L3_3 = L3_3.Out
      L4_3 = Enum
      L4_3 = L4_3.EasingStyle
      L4_3 = L4_3.Linear
      L5_3 = 0.2
      L6_3 = true
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3)
      L0_3 = L1_1
      L1_3 = L0_3
      L0_3 = L0_3.Create
      L2_3 = L6_2
      L3_3 = TweenInfo
      L3_3 = L3_3.new
      L4_3 = 0.5
      L5_3 = Enum
      L5_3 = L5_3.EasingStyle
      L5_3 = L5_3.Quart
      L6_3 = Enum
      L6_3 = L6_3.EasingDirection
      L6_3 = L6_3.Out
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      L4_3 = {}
      L4_3.Rotation = 0
      L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
      L1_3 = L0_3
      L0_3 = L0_3.Play
      L0_3(L1_3)
    end
    return
  end
  
  L10_2(L11_2, L12_2)
  L10_2 = {}
  
  function L11_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L2_3 = Instance
    L2_3 = L2_3.new
    L3_3 = "ImageButton"
    L2_3 = L2_3(L3_3)
    L3_3 = Instance
    L3_3 = L3_3.new
    L4_3 = "Frame"
    L3_3 = L3_3(L4_3)
    L4_3 = Instance
    L4_3 = L4_3.new
    L5_3 = "ImageLabel"
    L4_3 = L4_3(L5_3)
    L5_3 = Instance
    L5_3 = L5_3.new
    L6_3 = "Frame"
    L5_3 = L5_3(L6_3)
    L6_3 = Instance
    L6_3 = L6_3.new
    L7_3 = "UIListLayout"
    L6_3 = L6_3(L7_3)
    L7_3 = Instance
    L7_3 = L7_3.new
    L8_3 = "TextLabel"
    L7_3 = L7_3(L8_3)
    L3_3.Name = "Folder"
    L8_3 = L7_2
    L3_3.Parent = L8_3
    L8_3 = Color3
    L8_3 = L8_3.fromRGB
    L9_3 = 255
    L10_3 = 255
    L11_3 = 255
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L3_3.BackgroundColor3 = L8_3
    L3_3.BackgroundTransparency = 1
    L3_3.ClipsDescendants = true
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0
    L10_3 = 180
    L11_3 = 0
    L12_3 = 0
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L3_3.Size = L8_3
    L4_3.Name = "Folder"
    L4_3.Parent = L3_3
    L8_3 = Color3
    L8_3 = L8_3.fromRGB
    L9_3 = 255
    L10_3 = 255
    L11_3 = 255
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L4_3.BackgroundColor3 = L8_3
    L4_3.BackgroundTransparency = 1
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0
    L10_3 = 180
    L11_3 = 0
    L12_3 = 35
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L4_3.Size = L8_3
    L4_3.Image = "rbxassetid://4641600283"
    L8_3 = _G
    L8_3 = L8_3.SecondaryColor
    if not L8_3 then
      L8_3 = Color3
      L8_3 = L8_3.fromRGB
      L9_3 = 26
      L10_3 = 26
      L11_3 = 26
      L8_3 = L8_3(L9_3, L10_3, L11_3)
    end
    L4_3.ImageColor3 = L8_3
    L8_3 = Enum
    L8_3 = L8_3.ScaleType
    L8_3 = L8_3.Slice
    L4_3.ScaleType = L8_3
    L8_3 = Rect
    L8_3 = L8_3.new
    L9_3 = 128
    L10_3 = 128
    L11_3 = 128
    L12_3 = 128
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L4_3.SliceCenter = L8_3
    L4_3.SliceScale = 0.05
    L5_3.Name = "Content"
    L5_3.Parent = L4_3
    L8_3 = Color3
    L8_3 = L8_3.fromRGB
    L9_3 = 255
    L10_3 = 255
    L11_3 = 255
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L5_3.BackgroundColor3 = L8_3
    L5_3.BackgroundTransparency = 1
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0
    L10_3 = 0
    L11_3 = 1
    L12_3 = 0
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L5_3.Position = L8_3
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 1
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L5_3.Size = L8_3
    L7_3.Name = "Title"
    L7_3.Parent = L4_3
    L8_3 = Color3
    L8_3 = L8_3.fromRGB
    L9_3 = 255
    L10_3 = 255
    L11_3 = 255
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L7_3.BackgroundColor3 = L8_3
    L7_3.BackgroundTransparency = 1
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0.0444444455
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L7_3.Position = L8_3
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0.805555582
    L10_3 = 0
    L11_3 = 1
    L12_3 = 0
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L7_3.Size = L8_3
    L8_3 = Enum
    L8_3 = L8_3.Font
    L8_3 = L8_3.SourceSansBold
    L7_3.Font = L8_3
    L7_3.Text = A1_3
    L8_3 = _G
    L8_3 = L8_3.MainTextColor
    if not L8_3 then
      L8_3 = Color3
      L8_3 = L8_3.fromRGB
      L9_3 = 255
      L10_3 = 255
      L11_3 = 255
      L8_3 = L8_3(L9_3, L10_3, L11_3)
    end
    L7_3.TextColor3 = L8_3
    L7_3.TextSize = 18
    L7_3.TextWrapped = true
    L8_3 = Enum
    L8_3 = L8_3.TextXAlignment
    L8_3 = L8_3.Left
    L7_3.TextXAlignment = L8_3
    L2_3.Name = "Arrow"
    L2_3.Parent = L4_3
    L8_3 = Color3
    L8_3 = L8_3.fromRGB
    L9_3 = 255
    L10_3 = 255
    L11_3 = 255
    L8_3 = L8_3(L9_3, L10_3, L11_3)
    L2_3.BackgroundColor3 = L8_3
    L2_3.BackgroundTransparency = 1
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 1
    L10_3 = -20
    L11_3 = 0
    L12_3 = 10
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L2_3.Position = L8_3
    L8_3 = UDim2
    L8_3 = L8_3.new
    L9_3 = 0
    L10_3 = 12
    L11_3 = 0
    L12_3 = 12
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3)
    L2_3.Size = L8_3
    L2_3.Image = "http://www.roblox.com/asset/?id=4921527706"
    L8_3 = _G
    L8_3 = L8_3.ArrowColor
    if not L8_3 then
      L8_3 = Color3
      L8_3 = L8_3.fromRGB
      L9_3 = 65
      L10_3 = 65
      L11_3 = 65
      L8_3 = L8_3(L9_3, L10_3, L11_3)
    end
    L2_3.ImageColor3 = L8_3
    L6_3.Parent = L5_3
    L8_3 = Enum
    L8_3 = L8_3.SortOrder
    L8_3 = L8_3.LayoutOrder
    L6_3.SortOrder = L8_3
    L8_3 = L2_3.MouseButton1Click
    L9_3 = L8_3
    L8_3 = L8_3.Connect
    
    function L10_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4
      L0_4 = L2_3
      L0_4 = L0_4.Rotation
      if L0_4 == 0 then
        L0_4 = L5_3
        L1_4 = L0_4
        L0_4 = L0_4.TweenSize
        L2_4 = UDim2
        L2_4 = L2_4.new
        L3_4 = 1
        L4_4 = 0
        L5_4 = 0
        L6_4 = L6_3
        L6_4 = L6_4.AbsoluteContentSize
        L6_4 = L6_4.Y
        L6_4 = L6_4 + 35
        L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
        L3_4 = Enum
        L3_4 = L3_4.EasingDirection
        L3_4 = L3_4.Out
        L4_4 = Enum
        L4_4 = L4_4.EasingStyle
        L4_4 = L4_4.Linear
        L5_4 = 0.1
        L6_4 = true
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4)
        L0_4 = L3_3
        L1_4 = L0_4
        L0_4 = L0_4.TweenSize
        L2_4 = UDim2
        L2_4 = L2_4.new
        L3_4 = 1
        L4_4 = 0
        L5_4 = 0
        L6_4 = L6_3
        L6_4 = L6_4.AbsoluteContentSize
        L6_4 = L6_4.Y
        L6_4 = L6_4 + 35
        L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
        L3_4 = Enum
        L3_4 = L3_4.EasingDirection
        L3_4 = L3_4.Out
        L4_4 = Enum
        L4_4 = L4_4.EasingStyle
        L4_4 = L4_4.Linear
        L5_4 = 0.1
        L6_4 = true
        
        function L7_4()
          local L0_5, L1_5
          L0_5 = L3_3
          L0_5.ClipsDescendants = false
          return
        end
        
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4)
        L0_4 = L1_1
        L1_4 = L0_4
        L0_4 = L0_4.Create
        L2_4 = L2_3
        L3_4 = TweenInfo
        L3_4 = L3_4.new
        L4_4 = 0.5
        L5_4 = Enum
        L5_4 = L5_4.EasingStyle
        L5_4 = L5_4.Quart
        L6_4 = Enum
        L6_4 = L6_4.EasingDirection
        L6_4 = L6_4.Out
        L3_4 = L3_4(L4_4, L5_4, L6_4)
        L4_4 = {}
        L4_4.Rotation = -90
        L0_4 = L0_4(L1_4, L2_4, L3_4, L4_4)
        L1_4 = L0_4
        L0_4 = L0_4.Play
        L0_4(L1_4)
      else
        L0_4 = L3_3
        L0_4.ClipsDescendants = true
        L0_4 = L5_3
        L1_4 = L0_4
        L0_4 = L0_4.TweenSize
        L2_4 = UDim2
        L2_4 = L2_4.new
        L3_4 = 1
        L4_4 = 0
        L5_4 = 0
        L6_4 = 35
        L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
        L3_4 = Enum
        L3_4 = L3_4.EasingDirection
        L3_4 = L3_4.Out
        L4_4 = Enum
        L4_4 = L4_4.EasingStyle
        L4_4 = L4_4.Linear
        L5_4 = 0.1
        L6_4 = true
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4)
        L0_4 = L3_3
        L1_4 = L0_4
        L0_4 = L0_4.TweenSize
        L2_4 = UDim2
        L2_4 = L2_4.new
        L3_4 = 1
        L4_4 = 0
        L5_4 = 0
        L6_4 = 35
        L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
        L3_4 = Enum
        L3_4 = L3_4.EasingDirection
        L3_4 = L3_4.Out
        L4_4 = Enum
        L4_4 = L4_4.EasingStyle
        L4_4 = L4_4.Linear
        L5_4 = 0.1
        L6_4 = true
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4)
        L0_4 = L1_1
        L1_4 = L0_4
        L0_4 = L0_4.Create
        L2_4 = L2_3
        L3_4 = TweenInfo
        L3_4 = L3_4.new
        L4_4 = 0.5
        L5_4 = Enum
        L5_4 = L5_4.EasingStyle
        L5_4 = L5_4.Quart
        L6_4 = Enum
        L6_4 = L6_4.EasingDirection
        L6_4 = L6_4.Out
        L3_4 = L3_4(L4_4, L5_4, L6_4)
        L4_4 = {}
        L4_4.Rotation = 0
        L0_4 = L0_4(L1_4, L2_4, L3_4, L4_4)
        L1_4 = L0_4
        L0_4 = L0_4.Play
        L0_4(L1_4)
      end
      return
    end
    
    L8_3(L9_3, L10_3)
    L8_3 = {}
    
    function L9_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4
      L1_4 = L2_1
      L1_4 = L1_4.X
      L2_4 = A0_4.AbsolutePosition
      L2_4 = L2_4.X
      L1_4 = L1_4 - L2_4
      L2_4 = L2_1
      L2_4 = L2_4.Y
      L3_4 = A0_4.AbsolutePosition
      L3_4 = L3_4.Y
      L2_4 = L2_4 - L3_4
      L3_4 = A0_4.AbsoluteSize
      L3_4 = L3_4.X
      L4_4 = A0_4.AbsoluteSize
      L4_4 = L4_4.Y
      L5_4 = math
      L5_4 = L5_4.clamp
      L6_4 = L1_4
      L7_4 = 0
      L8_4 = L3_4
      L5_4 = L5_4(L6_4, L7_4, L8_4)
      L1_4 = L5_4
      L5_4 = math
      L5_4 = L5_4.clamp
      L6_4 = L2_4
      L7_4 = 0
      L8_4 = L4_4
      L5_4 = L5_4(L6_4, L7_4, L8_4)
      L2_4 = L5_4
      L5_4 = L1_4
      L6_4 = L2_4
      L7_4 = L1_4 / L3_4
      L8_4 = L2_4 / L4_4
      do return L5_4, L6_4, L7_4, L8_4 end
      return
    end
    
    function L10_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4
      L1_4 = Instance
      L1_4 = L1_4.new
      L2_4 = "ImageLabel"
      L1_4 = L1_4(L2_4)
      L1_4.BackgroundTransparency = 1
      L1_4.Image = "http://www.roblox.com/asset/?id=87913710"
      L1_4.Parent = A0_4
      L2_4 = Color3
      L2_4 = L2_4.fromRGB
      L3_4 = 0
      L4_4 = 0
      L5_4 = 0
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L1_4.ImageColor3 = L2_4
      L2_4 = spawn
      
      function L3_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5
        L0_5 = L9_3
        L1_5 = A0_4
        L0_5, L1_5 = L0_5(L1_5)
        L2_5 = 1
        L3_5 = 50
        L4_5 = 1
        for L5_5 = L2_5, L3_5, L4_5 do
          L6_5 = L1_4
          L7_5 = UDim2
          L7_5 = L7_5.new
          L8_5 = 0
          L9_5 = L5_5
          L10_5 = 0
          L11_5 = L5_5
          L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
          L6_5.Size = L7_5
          L6_5 = L1_4
          L7_5 = UDim2
          L7_5 = L7_5.new
          L8_5 = 0
          L9_5 = L5_5 / 2
          L9_5 = L0_5 - L9_5
          L10_5 = 0
          L11_5 = L5_5 / 2
          L11_5 = L1_5 - L11_5
          L7_5 = L7_5(L8_5, L9_5, L10_5, L11_5)
          L6_5.Position = L7_5
          L6_5 = L1_4
          L7_5 = L5_5 / 50
          L6_5.ImageTransparency = L7_5
          L6_5 = game
          L7_5 = L6_5
          L6_5 = L6_5.GetService
          L8_5 = "RunService"
          L6_5 = L6_5(L7_5, L8_5)
          L6_5 = L6_5.Heartbeat
          L7_5 = L6_5
          L6_5 = L6_5.Wait
          L6_5(L7_5)
        end
        L2_5 = L1_4
        L3_5 = L2_5
        L2_5 = L2_5.Destroy
        L2_5(L3_5)
        return
      end
      
      L2_4(L3_4)
      do return L1_4 end
      return
    end
    
    function L11_3(A0_4, A1_4, A2_4)
      local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
      L3_4 = typeof
      L4_4 = A2_4
      L3_4 = L3_4(L4_4)
      if L3_4 ~= "function" or not A2_4 then
        function A2_4()
          local L0_5, L1_5
          
          return
        end
      end
      L3_4 = Instance
      L3_4 = L3_4.new
      L4_4 = "ImageLabel"
      L3_4 = L3_4(L4_4)
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "ImageButton"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "ImageLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "TextLabel"
      L6_4 = L6_4(L7_4)
      L3_4.Name = "Button"
      L7_4 = L5_3
      L3_4.Parent = L7_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L3_4.BackgroundColor3 = L7_4
      L3_4.BackgroundTransparency = 1
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0
      L9_4 = 180
      L10_4 = 0
      L11_4 = 32
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L3_4.Size = L7_4
      L3_4.Image = "rbxassetid://4641600283"
      L7_4 = _G
      L7_4 = L7_4.TertiaryColor
      if not L7_4 then
        L7_4 = Color3
        L7_4 = L7_4.fromRGB
        L8_4 = 38
        L9_4 = 38
        L10_4 = 38
        L7_4 = L7_4(L8_4, L9_4, L10_4)
      end
      L3_4.ImageColor3 = L7_4
      L7_4 = Enum
      L7_4 = L7_4.ScaleType
      L7_4 = L7_4.Slice
      L3_4.ScaleType = L7_4
      L7_4 = Rect
      L7_4 = L7_4.new
      L8_4 = 128
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L3_4.SliceCenter = L7_4
      L3_4.SliceScale = 0.05
      L3_4.LayoutOrder = 1
      L3_4.ClipsDescendants = false
      L4_4.Name = "Click"
      L4_4.Parent = L3_4
      L7_4 = Vector2
      L7_4 = L7_4.new
      L8_4 = 0.5
      L9_4 = 0.5
      L7_4 = L7_4(L8_4, L9_4)
      L4_4.AnchorPoint = L7_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L4_4.BackgroundColor3 = L7_4
      L4_4.BackgroundTransparency = 1
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0.5
      L9_4 = 0
      L10_4 = 0.5
      L11_4 = 0
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L4_4.Position = L7_4
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0.899999976
      L9_4 = 0
      L10_4 = 0.699999988
      L11_4 = 0
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L4_4.Size = L7_4
      L4_4.Image = "rbxassetid://4921672704"
      L7_4 = _G
      L7_4 = L7_4.ButtonColor
      if not L7_4 then
        L7_4 = Color3
        L7_4 = L7_4.fromRGB
        L8_4 = 0
        L9_4 = 255
        L10_4 = 109
        L7_4 = L7_4(L8_4, L9_4, L10_4)
      end
      L4_4.ImageColor3 = L7_4
      L7_4 = Enum
      L7_4 = L7_4.ScaleType
      L7_4 = L7_4.Slice
      L4_4.ScaleType = L7_4
      L7_4 = Rect
      L7_4 = L7_4.new
      L8_4 = 128
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L4_4.SliceCenter = L7_4
      L4_4.SliceScale = 0.05
      L5_4.Name = "Pointer"
      L5_4.Parent = L4_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L5_4.BackgroundColor3 = L7_4
      L5_4.BackgroundTransparency = 1
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0
      L9_4 = 7
      L10_4 = 0
      L11_4 = 7
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L5_4.Position = L7_4
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0
      L9_4 = 12
      L10_4 = 0
      L11_4 = 12
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L5_4.Size = L7_4
      L5_4.Image = "http://www.roblox.com/asset/?id=4921527578"
      L7_4 = _G
      L7_4 = L7_4.PointerColor
      if not L7_4 then
        L7_4 = Color3
        L7_4 = L7_4.fromRGB
        L8_4 = 0
        L9_4 = 0
        L10_4 = 0
        L7_4 = L7_4(L8_4, L9_4, L10_4)
      end
      L5_4.ImageColor3 = L7_4
      L6_4.Name = "Title"
      L6_4.Parent = L4_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L6_4.BackgroundColor3 = L7_4
      L6_4.BackgroundTransparency = 1
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 1
      L9_4 = 0
      L10_4 = 1
      L11_4 = 0
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L6_4.Size = L7_4
      L7_4 = Enum
      L7_4 = L7_4.Font
      L7_4 = L7_4.SourceSansBold
      L6_4.Font = L7_4
      L6_4.Text = A1_4
      L7_4 = _G
      L7_4 = L7_4.ButtonTextColor
      if not L7_4 then
        L7_4 = Color3
        L7_4 = L7_4.fromRGB
        L8_4 = 0
        L9_4 = 0
        L10_4 = 0
        L7_4 = L7_4(L8_4, L9_4, L10_4)
      end
      L6_4.TextColor3 = L7_4
      L6_4.TextSize = 18
      L6_4.TextWrapped = true
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "ImageLabel"
      L7_4 = L7_4(L8_4)
      L7_4.Name = "Cap"
      L7_4.Parent = L3_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L7_4.BackgroundColor3 = L8_4
      L7_4.BackgroundTransparency = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 0
      L11_4 = 1
      L12_4 = -2
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L7_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = 0
      L11_4 = 0
      L12_4 = 5
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L7_4.Size = L8_4
      L7_4.ZIndex = 3
      L7_4.Image = "rbxassetid://4695358235"
      L8_4 = _G
      L8_4 = L8_4.TertiaryColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 38
        L10_4 = 38
        L11_4 = 38
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L7_4.ImageColor3 = L8_4
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Slice
      L7_4.ScaleType = L8_4
      L8_4 = Rect
      L8_4 = L8_4.new
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L7_4.SliceCenter = L8_4
      L7_4.SliceScale = 0.05
      L8_4 = L4_4.MouseButton1Click
      L9_4 = L8_4
      L8_4 = L8_4.Connect
      
      function L10_4()
        local L0_5, L1_5
        L0_5 = pcall
        L1_5 = A2_4
        L0_5(L1_5)
        L0_5 = L10_3
        L1_5 = L4_4
        L0_5(L1_5)
        return
      end
      
      L8_4(L9_4, L10_4)
      return
    end
    
    L8_3.Button = L11_3
    
    function L11_3(A0_4, A1_4, A2_4)
      local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
      L3_4 = typeof
      L4_4 = A2_4
      L3_4 = L3_4(L4_4)
      if L3_4 ~= "function" or not A2_4 then
        function A2_4()
          local L0_5, L1_5
          
          return
        end
      end
      L3_4 = Instance
      L3_4 = L3_4.new
      L4_4 = "ImageLabel"
      L3_4 = L3_4(L4_4)
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "ImageButton"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "ImageLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "ImageLabel"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "TextLabel"
      L7_4 = L7_4(L8_4)
      L3_4.Name = "Toggle"
      L8_4 = L5_3
      L3_4.Parent = L8_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L3_4.BackgroundColor3 = L8_4
      L3_4.BackgroundTransparency = 1
      L3_4.ClipsDescendants = false
      L3_4.LayoutOrder = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = 0
      L11_4 = 0
      L12_4 = 32
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L3_4.Size = L8_4
      L3_4.Image = "rbxassetid://4641600283"
      L8_4 = _G
      L8_4 = L8_4.TertiaryColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 38
        L10_4 = 38
        L11_4 = 38
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L3_4.ImageColor3 = L8_4
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Slice
      L3_4.ScaleType = L8_4
      L8_4 = Rect
      L8_4 = L8_4.new
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L3_4.SliceCenter = L8_4
      L3_4.SliceScale = 0.05
      L7_4.Name = "Title"
      L7_4.Parent = L3_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L7_4.BackgroundColor3 = L8_4
      L7_4.BackgroundTransparency = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 7
      L11_4 = 0
      L12_4 = 0
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L7_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 145
      L11_4 = 0
      L12_4 = 30
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L7_4.Size = L8_4
      L8_4 = Enum
      L8_4 = L8_4.Font
      L8_4 = L8_4.SourceSansSemibold
      L7_4.Font = L8_4
      L7_4.Text = A1_4
      L8_4 = _G
      L8_4 = L8_4.TextColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 170
        L10_4 = 170
        L11_4 = 170
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L7_4.TextColor3 = L8_4
      L7_4.TextSize = 18
      L7_4.TextWrapped = true
      L8_4 = Enum
      L8_4 = L8_4.TextXAlignment
      L8_4 = L8_4.Left
      L7_4.TextXAlignment = L8_4
      L8_4 = string
      L8_4 = L8_4.len
      L9_4 = A1_4
      L8_4 = L8_4(L9_4)
      if 14 < L8_4 then
        L8_4 = true
        if L8_4 then
          goto lbl_133
        end
      end
      L8_4 = false
      ::lbl_133::
      L7_4.TextScaled = L8_4
      L4_4.Name = "Tick"
      L4_4.Parent = L3_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L4_4.BackgroundColor3 = L8_4
      L4_4.BackgroundTransparency = 1
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 0
      L10_4 = 0
      L11_4 = 0
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L4_4.BorderColor3 = L8_4
      L4_4.BorderSizePixel = 100
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = -26
      L11_4 = 0
      L12_4 = 7
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L4_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 18
      L11_4 = 0
      L12_4 = 18
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L4_4.Size = L8_4
      L4_4.Image = "rbxassetid://4608020054"
      L8_4 = _G
      L8_4 = L8_4.ToggleColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 94
        L10_4 = 93
        L11_4 = 94
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L4_4.ImageColor3 = L8_4
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Slice
      L4_4.ScaleType = L8_4
      L8_4 = Rect
      L8_4 = L8_4.new
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L4_4.SliceCenter = L8_4
      L4_4.SliceScale = 0.03
      L5_4.Name = "Fill"
      L5_4.Parent = L4_4
      L5_4.Active = true
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L5_4.BackgroundColor3 = L8_4
      L5_4.BackgroundTransparency = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 2
      L11_4 = 0
      L12_4 = 2
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L5_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = -4
      L11_4 = 1
      L12_4 = -4
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L5_4.Size = L8_4
      L5_4.Image = "rbxassetid://4608020054"
      L8_4 = _G
      L8_4 = L8_4.TertiaryColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 38
        L10_4 = 38
        L11_4 = 38
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L5_4.ImageColor3 = L8_4
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Slice
      L5_4.ScaleType = L8_4
      L8_4 = Rect
      L8_4 = L8_4.new
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L5_4.SliceCenter = L8_4
      L5_4.SliceScale = 0.01
      L6_4.Name = "Check"
      L6_4.Parent = L4_4
      L6_4.Active = true
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L6_4.BackgroundColor3 = L8_4
      L6_4.BackgroundTransparency = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 5
      L11_4 = 0
      L12_4 = 4
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L6_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = -9
      L11_4 = 1
      L12_4 = -9
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L6_4.Size = L8_4
      L6_4.Image = "rbxassetid://4641741789"
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 38
      L10_4 = 38
      L11_4 = 38
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L6_4.ImageColor3 = L8_4
      L6_4.ImageTransparency = 1
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Fit
      L6_4.ScaleType = L8_4
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "ImageLabel"
      L8_4 = L8_4(L9_4)
      L8_4.Name = "Cap"
      L8_4.Parent = L3_4
      L9_4 = Color3
      L9_4 = L9_4.fromRGB
      L10_4 = 255
      L11_4 = 255
      L12_4 = 255
      L9_4 = L9_4(L10_4, L11_4, L12_4)
      L8_4.BackgroundColor3 = L9_4
      L8_4.BackgroundTransparency = 1
      L9_4 = UDim2
      L9_4 = L9_4.new
      L10_4 = 0
      L11_4 = 0
      L12_4 = 1
      L13_4 = -2
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.Position = L9_4
      L9_4 = UDim2
      L9_4 = L9_4.new
      L10_4 = 1
      L11_4 = 0
      L12_4 = 0
      L13_4 = 5
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.Size = L9_4
      L8_4.ZIndex = 3
      L8_4.Image = "rbxassetid://4695358235"
      L9_4 = _G
      L9_4 = L9_4.TertiaryColor
      if not L9_4 then
        L9_4 = Color3
        L9_4 = L9_4.fromRGB
        L10_4 = 38
        L11_4 = 38
        L12_4 = 38
        L9_4 = L9_4(L10_4, L11_4, L12_4)
      end
      L8_4.ImageColor3 = L9_4
      L9_4 = Enum
      L9_4 = L9_4.ScaleType
      L9_4 = L9_4.Slice
      L8_4.ScaleType = L9_4
      L9_4 = Rect
      L9_4 = L9_4.new
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L13_4 = 128
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.SliceCenter = L9_4
      L8_4.SliceScale = 0.05
      L9_4 = false
      L10_4 = L4_4.MouseButton1Click
      L11_4 = L10_4
      L10_4 = L10_4.Connect
      
      function L12_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5
        L0_5 = L9_4
        L0_5 = not L0_5
        L9_4 = L0_5
        L0_5 = pcall
        L1_5 = A2_4
        L2_5 = L9_4
        L0_5(L1_5, L2_5)
        L0_5 = L9_4
        if L0_5 then
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L4_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.1
          L3_5 = L3_5(L4_5)
          L4_5 = {}
          L5_5 = _G
          L5_5 = L5_5.ToggleColor
          if not L5_5 then
            L5_5 = Color3
            L5_5 = L5_5.fromRGB
            L6_5 = 0
            L7_5 = 255
            L8_5 = 111
            L5_5 = L5_5(L6_5, L7_5, L8_5)
          end
          L4_5.ImageColor3 = L5_5
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
          L0_5 = L5_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSizeAndPosition
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 0
          L5_5 = 0
          L6_5 = 0
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = UDim2
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = 0
          L6_5 = 0.5
          L7_5 = 0
          L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
          L4_5 = "Out"
          L5_5 = "Quart"
          L6_5 = 0.1
          L7_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5)
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L6_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.1
          L3_5 = L3_5(L4_5)
          L4_5 = {}
          L4_5.ImageTransparency = 0
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
        else
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L4_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.1
          L3_5 = L3_5(L4_5)
          L4_5 = {}
          L5_5 = Color3
          L5_5 = L5_5.fromRGB
          L6_5 = 94
          L7_5 = 93
          L8_5 = 94
          L5_5 = L5_5(L6_5, L7_5, L8_5)
          L4_5.ImageColor3 = L5_5
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
          L0_5 = L5_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSizeAndPosition
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 1
          L4_5 = -4
          L5_5 = 1
          L6_5 = -4
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = UDim2
          L3_5 = L3_5.new
          L4_5 = 0
          L5_5 = 2
          L6_5 = 0
          L7_5 = 2
          L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
          L4_5 = "Out"
          L5_5 = "Quart"
          L6_5 = 0.1
          L7_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5)
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L6_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.1
          L3_5 = L3_5(L4_5)
          L4_5 = {}
          L4_5.ImageTransparency = 1
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
        end
        return
      end
      
      L10_4(L11_4, L12_4)
      return
    end
    
    L8_3.Toggle = L11_3
    
    function L11_3(A0_4, A1_4, A2_4, A3_4)
      local L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
      L4_4 = typeof
      L5_4 = A3_4
      L4_4 = L4_4(L5_4)
      if L4_4 ~= "function" or not A3_4 then
        function A3_4()
          local L0_5, L1_5
          
          return
        end
      end
      L4_4 = A2_4.min
      if not L4_4 then
        L4_4 = 1
      end
      min = L4_4
      L4_4 = A2_4.max
      if not L4_4 then
        L4_4 = 10
      end
      max = L4_4
      L4_4 = A2_4.precise
      if not L4_4 then
        L4_4 = false
      end
      precise = L4_4
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "ImageLabel"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "TextLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "ImageLabel"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "TextBox"
      L7_4 = L7_4(L8_4)
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "ImageButton"
      L8_4 = L8_4(L9_4)
      L9_4 = Instance
      L9_4 = L9_4.new
      L10_4 = "ImageLabel"
      L9_4 = L9_4(L10_4)
      L10_4 = Instance
      L10_4 = L10_4.new
      L11_4 = "ImageButton"
      L10_4 = L10_4(L11_4)
      L11_4 = Instance
      L11_4 = L11_4.new
      L12_4 = "ImageLabel"
      L11_4 = L11_4(L12_4)
      L4_4.Name = "Slider"
      L12_4 = L5_3
      L4_4.Parent = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L4_4.BackgroundColor3 = L12_4
      L4_4.BackgroundTransparency = 1
      L4_4.ClipsDescendants = false
      L4_4.LayoutOrder = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0.0299999993
      L14_4 = 0
      L15_4 = 1.22857141
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L4_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 1
      L14_4 = 0
      L15_4 = 0
      L16_4 = 40
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L4_4.Size = L12_4
      L4_4.Image = "rbxassetid://4641600283"
      L12_4 = _G
      L12_4 = L12_4.TertiaryColor
      if not L12_4 then
        L12_4 = Color3
        L12_4 = L12_4.fromRGB
        L13_4 = 38
        L14_4 = 38
        L15_4 = 38
        L12_4 = L12_4(L13_4, L14_4, L15_4)
      end
      L4_4.ImageColor3 = L12_4
      L12_4 = Enum
      L12_4 = L12_4.ScaleType
      L12_4 = L12_4.Slice
      L4_4.ScaleType = L12_4
      L12_4 = Rect
      L12_4 = L12_4.new
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L4_4.SliceCenter = L12_4
      L4_4.SliceScale = 0.05
      L5_4.Name = "Title"
      L5_4.Parent = L4_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L5_4.BackgroundColor3 = L12_4
      L5_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0
      L14_4 = 7
      L15_4 = 0.100000001
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L5_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0
      L14_4 = 125
      L15_4 = 0
      L16_4 = 20
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L5_4.Size = L12_4
      L12_4 = Enum
      L12_4 = L12_4.Font
      L12_4 = L12_4.SourceSansSemibold
      L5_4.Font = L12_4
      L5_4.Text = A1_4
      L12_4 = _G
      L12_4 = L12_4.TextColor
      if not L12_4 then
        L12_4 = Color3
        L12_4 = L12_4.fromRGB
        L13_4 = 170
        L14_4 = 170
        L15_4 = 170
        L12_4 = L12_4(L13_4, L14_4, L15_4)
      end
      L5_4.TextColor3 = L12_4
      L5_4.TextSize = 18
      L12_4 = Enum
      L12_4 = L12_4.TextXAlignment
      L12_4 = L12_4.Left
      L5_4.TextXAlignment = L12_4
      L12_4 = string
      L12_4 = L12_4.len
      L13_4 = A1_4
      L12_4 = L12_4(L13_4)
      if 11 < L12_4 then
        L12_4 = true
        if L12_4 then
          goto lbl_167
        end
      end
      L12_4 = false
      ::lbl_167::
      L5_4.TextScaled = L12_4
      L6_4.Name = "Input"
      L6_4.Parent = L4_4
      L6_4.Active = true
      L12_4 = Vector2
      L12_4 = L12_4.new
      L13_4 = 1
      L14_4 = 0.5
      L12_4 = L12_4(L13_4, L14_4)
      L6_4.AnchorPoint = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L6_4.BackgroundColor3 = L12_4
      L6_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0.964999974
      L14_4 = 0
      L15_4 = 0.360000014
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L6_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0
      L14_4 = 32
      L15_4 = 0
      L16_4 = 16
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L6_4.Size = L12_4
      L6_4.Image = "rbxassetid://4608020054"
      L12_4 = _G
      L12_4 = L12_4.TertiaryColor
      if not L12_4 then
        L12_4 = Color3
        L12_4 = L12_4.fromRGB
        L13_4 = 65
        L14_4 = 65
        L15_4 = 65
        L12_4 = L12_4(L13_4, L14_4, L15_4)
      end
      L6_4.ImageColor3 = L12_4
      L12_4 = Enum
      L12_4 = L12_4.ScaleType
      L12_4 = L12_4.Slice
      L6_4.ScaleType = L12_4
      L12_4 = Rect
      L12_4 = L12_4.new
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L6_4.SliceCenter = L12_4
      L6_4.SliceScale = 0.03
      L7_4.Name = "Value"
      L7_4.Parent = L6_4
      L12_4 = Vector2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0.5
      L12_4 = L12_4(L13_4, L14_4)
      L7_4.AnchorPoint = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L7_4.BackgroundColor3 = L12_4
      L7_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0
      L15_4 = 0.5
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L7_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 1
      L14_4 = 1
      L15_4 = 1
      L16_4 = 1
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L7_4.Size = L12_4
      L12_4 = Enum
      L12_4 = L12_4.Font
      L12_4 = L12_4.SourceSansSemibold
      L7_4.Font = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 112
      L14_4 = 112
      L15_4 = 112
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L7_4.PlaceholderColor3 = L12_4
      L7_4.Text = ""
      L12_4 = _G
      L12_4 = L12_4.TextColor
      if not L12_4 then
        L12_4 = Color3
        L12_4 = L12_4.fromRGB
        L13_4 = 170
        L14_4 = 170
        L15_4 = 170
        L12_4 = L12_4(L13_4, L14_4, L15_4)
      end
      L7_4.TextColor3 = L12_4
      L7_4.TextScaled = true
      L7_4.TextSize = 14
      L7_4.TextWrapped = true
      L8_4.Name = "Slider"
      L8_4.Parent = L4_4
      L12_4 = Vector2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0.5
      L12_4 = L12_4(L13_4, L14_4)
      L8_4.AnchorPoint = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L8_4.BackgroundColor3 = L12_4
      L8_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0
      L15_4 = 0.800000012
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L8_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 1
      L14_4 = -14
      L15_4 = 0
      L16_4 = 4
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L8_4.Size = L12_4
      L8_4.Image = "rbxassetid://4608020054"
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 46
      L14_4 = 46
      L15_4 = 46
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L8_4.ImageColor3 = L12_4
      L12_4 = Enum
      L12_4 = L12_4.ScaleType
      L12_4 = L12_4.Slice
      L8_4.ScaleType = L12_4
      L12_4 = Rect
      L12_4 = L12_4.new
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L8_4.SliceCenter = L12_4
      L9_4.Name = "Indicator"
      L9_4.Parent = L8_4
      L9_4.Active = true
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L9_4.BackgroundColor3 = L12_4
      L9_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 1
      L14_4 = 0
      L15_4 = 1
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L9_4.Size = L12_4
      L9_4.Image = "rbxassetid://4608020054"
      L12_4 = _G
      L12_4 = L12_4.SliderColor
      if not L12_4 then
        L12_4 = Color3
        L12_4 = L12_4.fromRGB
        L13_4 = 0
        L14_4 = 255
        L15_4 = 111
        L12_4 = L12_4(L13_4, L14_4, L15_4)
      end
      L9_4.ImageColor3 = L12_4
      L12_4 = Enum
      L12_4 = L12_4.ScaleType
      L12_4 = L12_4.Slice
      L9_4.ScaleType = L12_4
      L12_4 = Rect
      L12_4 = L12_4.new
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L9_4.SliceCenter = L12_4
      L10_4.Name = "Dragger"
      L10_4.Parent = L9_4
      L12_4 = Vector2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0.5
      L12_4 = L12_4(L13_4, L14_4)
      L10_4.AnchorPoint = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L10_4.BackgroundColor3 = L12_4
      L10_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 1
      L14_4 = 0
      L15_4 = 0.5
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L10_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0
      L14_4 = 10
      L15_4 = 0
      L16_4 = 10
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L10_4.Size = L12_4
      L10_4.ZIndex = 3
      L10_4.Image = "rbxassetid://4608020054"
      L12_4 = Enum
      L12_4 = L12_4.ScaleType
      L12_4 = L12_4.Slice
      L10_4.ScaleType = L12_4
      L12_4 = Rect
      L12_4 = L12_4.new
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L10_4.SliceCenter = L12_4
      L11_4.Name = "Selection"
      L11_4.Parent = L10_4
      L12_4 = Vector2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0.5
      L12_4 = L12_4(L13_4, L14_4)
      L11_4.AnchorPoint = L12_4
      L12_4 = Color3
      L12_4 = L12_4.fromRGB
      L13_4 = 255
      L14_4 = 255
      L15_4 = 255
      L12_4 = L12_4(L13_4, L14_4, L15_4)
      L11_4.BackgroundColor3 = L12_4
      L11_4.BackgroundTransparency = 1
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 0.5
      L14_4 = 0
      L15_4 = 0.5
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L11_4.Position = L12_4
      L12_4 = UDim2
      L12_4 = L12_4.new
      L13_4 = 2
      L14_4 = 0
      L15_4 = 2
      L16_4 = 0
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L11_4.Size = L12_4
      L11_4.ZIndex = 2
      L11_4.Image = "rbxassetid://4608020054"
      L12_4 = _G
      L12_4 = L12_4.DraggerCircleColor
      if not L12_4 then
        L12_4 = Color3
        L12_4 = L12_4.fromRGB
        L13_4 = 0
        L14_4 = 255
        L15_4 = 111
        L12_4 = L12_4(L13_4, L14_4, L15_4)
      end
      L11_4.ImageColor3 = L12_4
      L11_4.ImageTransparency = 1
      L12_4 = Enum
      L12_4 = L12_4.ScaleType
      L12_4 = L12_4.Slice
      L11_4.ScaleType = L12_4
      L12_4 = Rect
      L12_4 = L12_4.new
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L12_4 = L12_4(L13_4, L14_4, L15_4, L16_4)
      L11_4.SliceCenter = L12_4
      L12_4 = Instance
      L12_4 = L12_4.new
      L13_4 = "ImageLabel"
      L12_4 = L12_4(L13_4)
      L12_4.Name = "Cap"
      L12_4.Parent = L4_4
      L13_4 = Color3
      L13_4 = L13_4.fromRGB
      L14_4 = 255
      L15_4 = 255
      L16_4 = 255
      L13_4 = L13_4(L14_4, L15_4, L16_4)
      L12_4.BackgroundColor3 = L13_4
      L12_4.BackgroundTransparency = 1
      L13_4 = UDim2
      L13_4 = L13_4.new
      L14_4 = 0
      L15_4 = 0
      L16_4 = 1
      L17_4 = -2
      L13_4 = L13_4(L14_4, L15_4, L16_4, L17_4)
      L12_4.Position = L13_4
      L13_4 = UDim2
      L13_4 = L13_4.new
      L14_4 = 1
      L15_4 = 0
      L16_4 = 0
      L17_4 = 5
      L13_4 = L13_4(L14_4, L15_4, L16_4, L17_4)
      L12_4.Size = L13_4
      L12_4.ZIndex = 3
      L12_4.Image = "rbxassetid://4695358235"
      L13_4 = _G
      L13_4 = L13_4.TertiaryColor
      if not L13_4 then
        L13_4 = Color3
        L13_4 = L13_4.fromRGB
        L14_4 = 38
        L15_4 = 38
        L16_4 = 38
        L13_4 = L13_4(L14_4, L15_4, L16_4)
      end
      L12_4.ImageColor3 = L13_4
      L13_4 = Enum
      L13_4 = L13_4.ScaleType
      L13_4 = L13_4.Slice
      L12_4.ScaleType = L13_4
      L13_4 = Rect
      L13_4 = L13_4.new
      L14_4 = 128
      L15_4 = 128
      L16_4 = 128
      L17_4 = 128
      L13_4 = L13_4(L14_4, L15_4, L16_4, L17_4)
      L12_4.SliceCenter = L13_4
      L12_4.SliceScale = 0.05
      L13_4 = nil
      L14_4 = game
      L15_4 = L14_4
      L14_4 = L14_4.GetService
      L16_4 = "UserInputService"
      L14_4 = L14_4(L15_4, L16_4)
      L14_4 = L14_4.InputEnded
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4(A0_5)
        local L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5
        L1_5 = A0_5.UserInputType
        L2_5 = Enum
        L2_5 = L2_5.UserInputType
        L2_5 = L2_5.MouseButton1
        if L1_5 == L2_5 then
          L1_5 = L13_4
          if L1_5 then
            L1_5 = L13_4
            L2_5 = L1_5
            L1_5 = L1_5.Disconnect
            L1_5(L2_5)
            L1_5 = nil
            L13_4 = L1_5
            L1_5 = L1_1
            L2_5 = L1_5
            L1_5 = L1_5.Create
            L3_5 = L11_4
            L4_5 = TweenInfo
            L4_5 = L4_5.new
            L5_5 = 0.5
            L6_5 = Enum
            L6_5 = L6_5.EasingStyle
            L6_5 = L6_5.Quart
            L7_5 = Enum
            L7_5 = L7_5.EasingDirection
            L7_5 = L7_5.Out
            L4_5 = L4_5(L5_5, L6_5, L7_5)
            L5_5 = {}
            L5_5.ImageTransparency = 1
            L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
            L2_5 = L1_5
            L1_5 = L1_5.Play
            L1_5(L2_5)
          end
        end
        return
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = L4_4.MouseEnter
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L1_1
        L1_5 = L0_5
        L0_5 = L0_5.Create
        L2_5 = L10_4
        L3_5 = TweenInfo
        L3_5 = L3_5.new
        L4_5 = 0.5
        L5_5 = Enum
        L5_5 = L5_5.EasingStyle
        L5_5 = L5_5.Quart
        L6_5 = Enum
        L6_5 = L6_5.EasingDirection
        L6_5 = L6_5.InOut
        L3_5 = L3_5(L4_5, L5_5, L6_5)
        L4_5 = {}
        L4_5.ImageTransparency = 0
        L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
        L1_5 = L0_5
        L0_5 = L0_5.Play
        L0_5(L1_5)
        return
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = L4_4.MouseLeave
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L13_4
        if not L0_5 then
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L10_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = Enum
          L5_5 = L5_5.EasingStyle
          L5_5 = L5_5.Quart
          L6_5 = Enum
          L6_5 = L6_5.EasingDirection
          L6_5 = L6_5.InOut
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L4_5 = {}
          L4_5.ImageTransparency = 1
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
        else
          L0_5 = spawn
          
          function L1_5()
            local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
            repeat
              L0_6 = wait
              L0_6()
              L0_6 = L13_4
            until not L0_6
            L0_6 = L1_1
            L1_6 = L0_6
            L0_6 = L0_6.Create
            L2_6 = L10_4
            L3_6 = TweenInfo
            L3_6 = L3_6.new
            L4_6 = 0.5
            L5_6 = Enum
            L5_6 = L5_6.EasingStyle
            L5_6 = L5_6.Quart
            L6_6 = Enum
            L6_6 = L6_6.EasingDirection
            L6_6 = L6_6.InOut
            L3_6 = L3_6(L4_6, L5_6, L6_6)
            L4_6 = {}
            L4_6.ImageTransparency = 1
            L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
            L1_6 = L0_6
            L0_6 = L0_6.Play
            L0_6(L1_6)
            return
          end
          
          L0_5(L1_5)
        end
        return
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = L10_4.MouseEnter
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L1_1
        L1_5 = L0_5
        L0_5 = L0_5.Create
        L2_5 = L11_4
        L3_5 = TweenInfo
        L3_5 = L3_5.new
        L4_5 = 0.5
        L5_5 = Enum
        L5_5 = L5_5.EasingStyle
        L5_5 = L5_5.Quart
        L6_5 = Enum
        L6_5 = L6_5.EasingDirection
        L6_5 = L6_5.In
        L3_5 = L3_5(L4_5, L5_5, L6_5)
        L4_5 = {}
        L4_5.ImageTransparency = 0.8
        L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
        L1_5 = L0_5
        L0_5 = L0_5.Play
        L0_5(L1_5)
        return
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = L10_4.MouseLeave
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L13_4
        if not L0_5 then
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L11_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = Enum
          L5_5 = L5_5.EasingStyle
          L5_5 = L5_5.Quart
          L6_5 = Enum
          L6_5 = L6_5.EasingDirection
          L6_5 = L6_5.In
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L4_5 = {}
          L4_5.ImageTransparency = 1
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
        end
        return
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = L10_4.MouseButton1Down
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L13_4
        if L0_5 then
          L0_5 = L13_4
          L1_5 = L0_5
          L0_5 = L0_5.Disconnect
          L0_5(L1_5)
        end
        L0_5 = L1_1
        L1_5 = L0_5
        L0_5 = L0_5.Create
        L2_5 = L11_4
        L3_5 = TweenInfo
        L3_5 = L3_5.new
        L4_5 = 0.5
        L5_5 = Enum
        L5_5 = L5_5.EasingStyle
        L5_5 = L5_5.Quart
        L6_5 = Enum
        L6_5 = L6_5.EasingDirection
        L6_5 = L6_5.In
        L3_5 = L3_5(L4_5, L5_5, L6_5)
        L4_5 = {}
        L4_5.ImageTransparency = 0.8
        L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
        L1_5 = L0_5
        L0_5 = L0_5.Play
        L0_5(L1_5)
        L0_5 = game
        L1_5 = L0_5
        L0_5 = L0_5.GetService
        L2_5 = "RunService"
        L0_5 = L0_5(L1_5, L2_5)
        L0_5 = L0_5.Heartbeat
        L1_5 = L0_5
        L0_5 = L0_5.Connect
        
        function L2_5()
          local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6
          L0_6 = game
          L1_6 = L0_6
          L0_6 = L0_6.GetService
          L2_6 = "UserInputService"
          L0_6 = L0_6(L1_6, L2_6)
          L1_6 = L0_6
          L0_6 = L0_6.GetMouseLocation
          L0_6 = L0_6(L1_6)
          L1_6 = math
          L1_6 = L1_6.clamp
          L2_6 = L0_6.X
          L3_6 = L8_4
          L3_6 = L3_6.AbsolutePosition
          L3_6 = L3_6.X
          L2_6 = L2_6 - L3_6
          L3_6 = L8_4
          L3_6 = L3_6.AbsoluteSize
          L3_6 = L3_6.X
          L2_6 = L2_6 / L3_6
          L3_6 = 0
          L4_6 = 1
          L1_6 = L1_6(L2_6, L3_6, L4_6)
          L2_6 = A2_4
          L2_6 = L2_6.min
          L3_6 = A2_4
          L3_6 = L3_6.max
          L4_6 = A2_4
          L4_6 = L4_6.min
          L3_6 = L3_6 - L4_6
          L3_6 = L3_6 * L1_6
          L2_6 = L2_6 + L3_6
          L3_6 = A2_4
          L3_6 = L3_6.precise
          if not L3_6 then
            L3_6 = math
            L3_6 = L3_6.floor
            L4_6 = L2_6
            L3_6 = L3_6(L4_6)
            L2_6 = L3_6
          else
            L3_6 = string
            L3_6 = L3_6.format
            L4_6 = "%.2f"
            L5_6 = L2_6
            L3_6 = L3_6(L4_6, L5_6)
            L2_6 = L3_6
          end
          L3_6 = tonumber
          L4_6 = L2_6
          L3_6 = L3_6(L4_6)
          L2_6 = L3_6
          L3_6 = L9_4
          L4_6 = L3_6
          L3_6 = L3_6.TweenSize
          L5_6 = UDim2
          L5_6 = L5_6.new
          L6_6 = L1_6
          L7_6 = 0
          L8_6 = 1
          L9_6 = 0
          L5_6 = L5_6(L6_6, L7_6, L8_6, L9_6)
          L6_6 = "InOut"
          L7_6 = "Linear"
          L8_6 = 0
          L9_6 = true
          L3_6(L4_6, L5_6, L6_6, L7_6, L8_6, L9_6)
          L3_6 = L7_4
          L4_6 = tostring
          L5_6 = L2_6
          L4_6 = L4_6(L5_6)
          L3_6.Text = L4_6
          L3_6 = pcall
          L4_6 = A3_4
          L5_6 = L2_6
          L3_6(L4_6, L5_6)
          return
        end
        
        L0_5 = L0_5(L1_5, L2_5)
        L13_4 = L0_5
        return
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = L7_4.FocusLost
      L15_4 = L14_4
      L14_4 = L14_4.Connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = typeof
        L1_5 = tonumber
        L2_5 = L7_4
        L2_5 = L2_5.Text
        L1_5(L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        if L0_5 == "number" then
          L0_5 = tonumber
          L1_5 = L7_4
          L1_5 = L1_5.Text
          L0_5 = L0_5(L1_5)
          L1_5 = A2_4
          L1_5 = L1_5.min
          if L0_5 >= L1_5 then
            L1_5 = A2_4
            L1_5 = L1_5.max
            if L0_5 <= L1_5 then
              L1_5 = A2_4
              L1_5 = L1_5.max
              L1_5 = L1_5 - L0_5
              L2_5 = A2_4
              L2_5 = L2_5.max
              L3_5 = A2_4
              L3_5 = L3_5.min
              L2_5 = L2_5 - L3_5
              L1_5 = L1_5 / L2_5
              L1_5 = 1 - L1_5
              L2_5 = L9_4
              L3_5 = UDim2
              L3_5 = L3_5.new
              L4_5 = L1_5
              L5_5 = 0
              L6_5 = 1
              L7_5 = 0
              L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
              L2_5.Size = L3_5
              L2_5 = pcall
              L3_5 = A3_4
              L4_5 = L0_5
              L2_5(L3_5, L4_5)
          end
          else
            L1_5 = L7_4
            L2_5 = "Min "
            L3_5 = tostring
            L4_5 = A2_4
            L4_5 = L4_5.min
            L3_5 = L3_5(L4_5)
            L4_5 = ", Max "
            L5_5 = tostring
            L6_5 = A2_4
            L6_5 = L6_5.max
            L5_5 = L5_5(L6_5)
            L2_5 = L2_5 .. L3_5 .. L4_5 .. L5_5
            L1_5.Text = L2_5
          end
        else
          L0_5 = L7_4
          L0_5.Text = "Not valid"
        end
        return
      end
      
      L14_4(L15_4, L16_4)
      return
    end
    
    L8_3.Slider = L11_3
    
    function L11_3(A0_4, A1_4, A2_4, A3_4)
      local L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
      L4_4 = typeof
      L5_4 = A3_4
      L4_4 = L4_4(L5_4)
      if L4_4 ~= "function" or not A3_4 then
        function A3_4()
          local L0_5, L1_5
          
          return
        end
      end
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "ImageLabel"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "TextLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "ImageButton"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "TextLabel"
      L7_4 = L7_4(L8_4)
      L8_4 = A2_4
      L9_4 = {}
      L9_4.RightControl = "RightCtrl"
      L9_4.LeftControl = "LeftCtrl"
      L9_4.LeftShift = "LShift"
      L9_4.RightShift = "RShift"
      L9_4.MouseButton1 = "Mouse1"
      L9_4.MouseButton2 = "Mouse2"
      L4_4.Name = "HotKey"
      L10_4 = L5_3
      L4_4.Parent = L10_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L4_4.BackgroundColor3 = L10_4
      L4_4.BackgroundTransparency = 1
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 27
      L12_4 = 42
      L13_4 = 53
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L4_4.BorderColor3 = L10_4
      L4_4.ClipsDescendants = false
      L4_4.LayoutOrder = 1
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 1
      L12_4 = 0
      L13_4 = 0
      L14_4 = 35
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L4_4.Size = L10_4
      L4_4.Image = "rbxassetid://4641600283"
      L10_4 = _G
      L10_4 = L10_4.TertiaryColor
      if not L10_4 then
        L10_4 = Color3
        L10_4 = L10_4.fromRGB
        L11_4 = 38
        L12_4 = 38
        L13_4 = 38
        L10_4 = L10_4(L11_4, L12_4, L13_4)
      end
      L4_4.ImageColor3 = L10_4
      L10_4 = Enum
      L10_4 = L10_4.ScaleType
      L10_4 = L10_4.Slice
      L4_4.ScaleType = L10_4
      L10_4 = Rect
      L10_4 = L10_4.new
      L11_4 = 128
      L12_4 = 128
      L13_4 = 128
      L14_4 = 128
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L4_4.SliceCenter = L10_4
      L4_4.SliceScale = 0.05
      L5_4.Name = "Title"
      L5_4.Parent = L4_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L5_4.BackgroundColor3 = L10_4
      L5_4.BackgroundTransparency = 1
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 7
      L13_4 = 0
      L14_4 = 2
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L5_4.Position = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 125
      L13_4 = 0
      L14_4 = 30
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L5_4.Size = L10_4
      L10_4 = Enum
      L10_4 = L10_4.Font
      L10_4 = L10_4.SourceSansSemibold
      L5_4.Font = L10_4
      L5_4.Text = A1_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 170
      L12_4 = 170
      L13_4 = 170
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L5_4.TextColor3 = L10_4
      L5_4.TextSize = 18
      L5_4.TextWrapped = true
      L10_4 = Enum
      L10_4 = L10_4.TextXAlignment
      L10_4 = L10_4.Left
      L5_4.TextXAlignment = L10_4
      L10_4 = string
      L10_4 = L10_4.len
      L11_4 = A1_4
      L10_4 = L10_4(L11_4)
      if 11 < L10_4 then
        L10_4 = true
        if L10_4 then
          goto lbl_140
        end
      end
      L10_4 = false
      ::lbl_140::
      L5_4.TextScaled = L10_4
      L6_4.Name = "Input"
      L6_4.Parent = L4_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L6_4.BackgroundColor3 = L10_4
      L6_4.BackgroundTransparency = 1
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 1
      L12_4 = -47
      L13_4 = 0
      L14_4 = 7
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L6_4.Position = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 40
      L13_4 = 0
      L14_4 = 21
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L6_4.Size = L10_4
      L6_4.Image = "rbxassetid://4608020054"
      L10_4 = _G
      L10_4 = L10_4.BindColor
      if not L10_4 then
        L10_4 = Color3
        L10_4 = L10_4.fromRGB
        L11_4 = 65
        L12_4 = 65
        L13_4 = 65
        L10_4 = L10_4(L11_4, L12_4, L13_4)
      end
      L6_4.ImageColor3 = L10_4
      L10_4 = Enum
      L10_4 = L10_4.ScaleType
      L10_4 = L10_4.Slice
      L6_4.ScaleType = L10_4
      L10_4 = Rect
      L10_4 = L10_4.new
      L11_4 = 128
      L12_4 = 128
      L13_4 = 128
      L14_4 = 128
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L6_4.SliceCenter = L10_4
      L6_4.SliceScale = 0.03
      L7_4.Name = "Value"
      L7_4.Parent = L6_4
      L10_4 = Vector2
      L10_4 = L10_4.new
      L11_4 = 0.5
      L12_4 = 0.5
      L10_4 = L10_4(L11_4, L12_4)
      L7_4.AnchorPoint = L10_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L7_4.BackgroundColor3 = L10_4
      L7_4.BackgroundTransparency = 1
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0.5
      L12_4 = 0
      L13_4 = 0.5
      L14_4 = 0
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L7_4.Position = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 1
      L12_4 = -7
      L13_4 = 1
      L14_4 = -7
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L7_4.Size = L10_4
      L10_4 = Enum
      L10_4 = L10_4.Font
      L10_4 = L10_4.SourceSansSemibold
      L7_4.Font = L10_4
      L10_4 = L8_4.Name
      L10_4 = L9_4[L10_4]
      if not L10_4 then
        L10_4 = L8_4.Name
      end
      L7_4.Text = L10_4
      L10_4 = _G
      L10_4 = L10_4.ButtonTextColor
      if not L10_4 then
        L10_4 = Color3
        L10_4 = L10_4.fromRGB
        L11_4 = 169
        L12_4 = 169
        L13_4 = 169
        L10_4 = L10_4(L11_4, L12_4, L13_4)
      end
      L7_4.TextColor3 = L10_4
      L7_4.TextScaled = true
      L7_4.TextWrapped = true
      L10_4 = Instance
      L10_4 = L10_4.new
      L11_4 = "ImageLabel"
      L10_4 = L10_4(L11_4)
      L10_4.Name = "Cap"
      L10_4.Parent = L4_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 255
      L13_4 = 255
      L14_4 = 255
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L10_4.BackgroundColor3 = L11_4
      L10_4.BackgroundTransparency = 1
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 0
      L13_4 = 0
      L14_4 = 1
      L15_4 = -2
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L10_4.Position = L11_4
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 1
      L13_4 = 0
      L14_4 = 0
      L15_4 = 5
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L10_4.Size = L11_4
      L10_4.ZIndex = 3
      L10_4.Image = "rbxassetid://4695358235"
      L11_4 = _G
      L11_4 = L11_4.TertiaryColor
      if not L11_4 then
        L11_4 = Color3
        L11_4 = L11_4.fromRGB
        L12_4 = 38
        L13_4 = 38
        L14_4 = 38
        L11_4 = L11_4(L12_4, L13_4, L14_4)
      end
      L10_4.ImageColor3 = L11_4
      L11_4 = Enum
      L11_4 = L11_4.ScaleType
      L11_4 = L11_4.Slice
      L10_4.ScaleType = L11_4
      L11_4 = Rect
      L11_4 = L11_4.new
      L12_4 = 128
      L13_4 = 128
      L14_4 = 128
      L15_4 = 128
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L10_4.SliceCenter = L11_4
      L10_4.SliceScale = 0.05
      L11_4 = L6_4.MouseButton1Click
      L12_4 = L11_4
      L11_4 = L11_4.connect
      
      function L13_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5
        L0_5 = L0_1
        L0_5.binding = true
        L0_5 = L7_4
        L0_5.Text = "..."
        L0_5 = game
        L1_5 = L0_5
        L0_5 = L0_5.GetService
        L2_5 = "UserInputService"
        L0_5 = L0_5(L1_5, L2_5)
        L0_5 = L0_5.InputBegan
        L1_5 = L0_5
        L0_5 = L0_5.wait
        L0_5, L1_5 = L0_5(L1_5)
        L2_5 = tostring
        L3_5 = L0_5.KeyCode
        L3_5 = L3_5.Name
        L2_5 = L2_5(L3_5)
        L3_5 = L0_5.KeyCode
        L8_4 = L3_5
        L3_5 = tostring
        L4_5 = L0_5.UserInputType
        L4_5 = L4_5.Name
        L3_5 = L3_5(L4_5)
        L4_5 = L7_4
        L5_5 = L9_4
        L5_5 = L5_5[L2_5]
        if not L5_5 then
          L5_5 = L2_5
        end
        L4_5.Text = L5_5
        L4_5 = wait
        L5_5 = 0.1
        L4_5(L5_5)
        L4_5 = L0_1
        L4_5.binding = false
        return
      end
      
      L11_4(L12_4, L13_4)
      L11_4 = game
      L12_4 = L11_4
      L11_4 = L11_4.GetService
      L13_4 = "UserInputService"
      L11_4 = L11_4(L12_4, L13_4)
      L11_4 = L11_4.InputBegan
      L12_4 = L11_4
      L11_4 = L11_4.Connect
      
      function L13_4(A0_5)
        local L1_5, L2_5
        L1_5 = L0_1
        L1_5 = L1_5.binding
        if L1_5 == false then
          L1_5 = A0_5.KeyCode
          L2_5 = L8_4
          if L1_5 == L2_5 then
            L1_5 = pcall
            L2_5 = A3_4
            L1_5(L2_5)
          end
        end
        return
      end
      
      L11_4(L12_4, L13_4)
      return
    end
    
    L8_3.Bind = L11_3
    
    function L11_3(A0_4, A1_4, A2_4, A3_4, A4_4)
      local L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "ImageLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "TextLabel"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "ImageButton"
      L7_4 = L7_4(L8_4)
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "ImageLabel"
      L8_4 = L8_4(L9_4)
      L9_4 = Instance
      L9_4 = L9_4.new
      L10_4 = "Frame"
      L9_4 = L9_4(L10_4)
      L10_4 = Instance
      L10_4 = L10_4.new
      L11_4 = "ImageLabel"
      L10_4 = L10_4(L11_4)
      L11_4 = Instance
      L11_4 = L11_4.new
      L12_4 = "ImageLabel"
      L11_4 = L11_4(L12_4)
      L12_4 = Instance
      L12_4 = L12_4.new
      L13_4 = "ScrollingFrame"
      L12_4 = L12_4(L13_4)
      L13_4 = Instance
      L13_4 = L13_4.new
      L14_4 = "UIListLayout"
      L13_4 = L13_4(L14_4)
      L14_4 = Instance
      L14_4 = L14_4.new
      L15_4 = "ImageButton"
      L14_4 = L14_4(L15_4)
      L15_4 = Instance
      L15_4 = L15_4.new
      L16_4 = "TextLabel"
      L15_4 = L15_4(L16_4)
      L16_4 = 0
      L17_4 = 0
      L18_4 = nil
      L19_4 = pairs
      L20_4 = A2_4
      L19_4, L20_4, L21_4 = L19_4(L20_4)
      for L22_4, L23_4 in L19_4, L20_4, L21_4 do
        L16_4 = L16_4 + 23
        L18_4 = nil
      end
      if 150 <= L16_4 then
        L18_4 = 150
        L17_4 = 10
      end
      L5_4.Name = "Dropdown"
      L19_4 = L5_3
      L5_4.Parent = L19_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L5_4.BackgroundColor3 = L19_4
      L5_4.BackgroundTransparency = 1
      L5_4.LayoutOrder = 1
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 0
      L22_4 = 1
      L23_4 = 0
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L5_4.Position = L19_4
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 1
      L21_4 = 0
      L22_4 = 0
      L23_4 = 32
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L5_4.Size = L19_4
      L5_4.Image = "rbxassetid://4641600283"
      L19_4 = _G
      L19_4 = L19_4.TertiaryColor
      if not L19_4 then
        L19_4 = Color3
        L19_4 = L19_4.fromRGB
        L20_4 = 38
        L21_4 = 38
        L22_4 = 38
        L19_4 = L19_4(L20_4, L21_4, L22_4)
      end
      L5_4.ImageColor3 = L19_4
      L19_4 = Enum
      L19_4 = L19_4.ScaleType
      L19_4 = L19_4.Slice
      L5_4.ScaleType = L19_4
      L19_4 = Rect
      L19_4 = L19_4.new
      L20_4 = 128
      L21_4 = 128
      L22_4 = 128
      L23_4 = 128
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L5_4.SliceCenter = L19_4
      L5_4.SliceScale = 0.05
      L6_4.Name = "Title"
      L6_4.Parent = L5_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L6_4.BackgroundColor3 = L19_4
      L6_4.BackgroundTransparency = 1
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 7
      L22_4 = 0
      L23_4 = 2
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L6_4.Position = L19_4
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 145
      L22_4 = 0
      L23_4 = 30
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L6_4.Size = L19_4
      L19_4 = Enum
      L19_4 = L19_4.Font
      L19_4 = L19_4.SourceSansSemibold
      L6_4.Font = L19_4
      L6_4.Text = A1_4
      L19_4 = _G
      L19_4 = L19_4.TextColor
      if not L19_4 then
        L19_4 = Color3
        L19_4 = L19_4.fromRGB
        L20_4 = 169
        L21_4 = 169
        L22_4 = 169
        L19_4 = L19_4(L20_4, L21_4, L22_4)
      end
      L6_4.TextColor3 = L19_4
      L6_4.TextSize = 18
      L6_4.TextWrapped = true
      L19_4 = Enum
      L19_4 = L19_4.TextXAlignment
      L19_4 = L19_4.Left
      L6_4.TextXAlignment = L19_4
      L6_4.TextScaled = false
      L7_4.Name = "Dropdown"
      L7_4.Parent = L5_4
      L19_4 = Vector2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 0.5
      L19_4 = L19_4(L20_4, L21_4)
      L7_4.AnchorPoint = L19_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L7_4.BackgroundColor3 = L19_4
      L7_4.BackgroundTransparency = 1
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 1
      L21_4 = -30
      L22_4 = 0
      L23_4 = 16
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L7_4.Position = L19_4
      L7_4.Rotation = -90
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 25
      L22_4 = 0
      L23_4 = 25
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L7_4.Size = L19_4
      L8_4.Name = "Inside"
      L8_4.Parent = L7_4
      L19_4 = Vector2
      L19_4 = L19_4.new
      L20_4 = 0.5
      L21_4 = 0
      L19_4 = L19_4(L20_4, L21_4)
      L8_4.AnchorPoint = L19_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L8_4.BackgroundColor3 = L19_4
      L8_4.BackgroundTransparency = 1
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 12
      L22_4 = 0
      L23_4 = 11
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L8_4.Position = L19_4
      L8_4.Rotation = 90
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 12
      L22_4 = 0
      L23_4 = 6
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L8_4.Size = L19_4
      L8_4.Image = "rbxassetid://4695336826"
      L19_4 = _G
      L19_4 = L19_4.ArrowColor
      if not L19_4 then
        L19_4 = Color3
        L19_4 = L19_4.fromRGB
        L20_4 = 96
        L21_4 = 96
        L22_4 = 96
        L19_4 = L19_4(L20_4, L21_4, L22_4)
      end
      L8_4.ImageColor3 = L19_4
      L19_4 = Enum
      L19_4 = L19_4.ScaleType
      L19_4 = L19_4.Fit
      L8_4.ScaleType = L19_4
      L9_4.Name = "List"
      L9_4.Parent = L5_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L9_4.BackgroundColor3 = L19_4
      L9_4.BackgroundTransparency = 1
      L9_4.ClipsDescendants = true
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 1
      L21_4 = 0
      L22_4 = 0
      L23_4 = 0
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L9_4.Position = L19_4
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 215
      L22_4 = 0
      L23_4 = 0
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L9_4.Size = L19_4
      L9_4.ZIndex = 6
      L10_4.Name = "List"
      L10_4.Parent = L9_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L10_4.BackgroundColor3 = L19_4
      L10_4.BackgroundTransparency = 1
      L10_4.ClipsDescendants = true
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 15
      L22_4 = 0
      L23_4 = 0
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L10_4.Position = L19_4
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 200
      L22_4 = 1
      L23_4 = 0
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L10_4.Size = L19_4
      L10_4.ZIndex = 6
      L10_4.Image = "rbxassetid://4608020054"
      L19_4 = _G
      L19_4 = L19_4.TertiaryColor
      if not L19_4 then
        L19_4 = Color3
        L19_4 = L19_4.fromRGB
        L20_4 = 38
        L21_4 = 38
        L22_4 = 38
        L19_4 = L19_4(L20_4, L21_4, L22_4)
      end
      L10_4.ImageColor3 = L19_4
      L19_4 = Enum
      L19_4 = L19_4.ScaleType
      L19_4 = L19_4.Slice
      L10_4.ScaleType = L19_4
      L19_4 = Rect
      L19_4 = L19_4.new
      L20_4 = 128
      L21_4 = 128
      L22_4 = 128
      L23_4 = 128
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L10_4.SliceCenter = L19_4
      L10_4.SliceScale = 0.06
      L11_4.Name = "Tail"
      L11_4.Parent = L10_4
      L11_4.Active = true
      L19_4 = Vector2
      L19_4 = L19_4.new
      L20_4 = 1
      L21_4 = 0
      L19_4 = L19_4(L20_4, L21_4)
      L11_4.AnchorPoint = L19_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L11_4.BackgroundColor3 = L19_4
      L11_4.BackgroundTransparency = 1
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 1
      L22_4 = 0
      L23_4 = 8
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L11_4.Position = L19_4
      L11_4.Rotation = 0.01
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 8
      L22_4 = 0
      L23_4 = 16
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L11_4.Size = L19_4
      L11_4.Image = "rbxassetid://4608020821"
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 38
      L21_4 = 38
      L22_4 = 38
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L11_4.ImageColor3 = L19_4
      L12_4.Name = "Elements"
      L12_4.Parent = L10_4
      L19_4 = Color3
      L19_4 = L19_4.fromRGB
      L20_4 = 255
      L21_4 = 255
      L22_4 = 255
      L19_4 = L19_4(L20_4, L21_4, L22_4)
      L12_4.BackgroundColor3 = L19_4
      L12_4.BackgroundTransparency = 1
      L12_4.ClipsDescendants = false
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 1
      L21_4 = -3
      L22_4 = 1
      L23_4 = -5
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L12_4.Size = L19_4
      L12_4.ZIndex = 8
      L19_4 = UDim2
      L19_4 = L19_4.new
      L20_4 = 0
      L21_4 = 0
      L22_4 = 0
      L23_4 = L16_4
      L19_4 = L19_4(L20_4, L21_4, L22_4, L23_4)
      L12_4.CanvasSize = L19_4
      L12_4.ScrollBarThickness = L17_4
      L19_4 = Instance
      L19_4 = L19_4.new
      L20_4 = "ImageLabel"
      L19_4 = L19_4(L20_4)
      L19_4.Name = "Cap"
      L19_4.Parent = L5_4
      L20_4 = Color3
      L20_4 = L20_4.fromRGB
      L21_4 = 255
      L22_4 = 255
      L23_4 = 255
      L20_4 = L20_4(L21_4, L22_4, L23_4)
      L19_4.BackgroundColor3 = L20_4
      L19_4.BackgroundTransparency = 1
      L20_4 = UDim2
      L20_4 = L20_4.new
      L21_4 = 0
      L22_4 = 0
      L23_4 = 1
      L24_4 = -2
      L20_4 = L20_4(L21_4, L22_4, L23_4, L24_4)
      L19_4.Position = L20_4
      L20_4 = UDim2
      L20_4 = L20_4.new
      L21_4 = 1
      L22_4 = 0
      L23_4 = 0
      L24_4 = 5
      L20_4 = L20_4(L21_4, L22_4, L23_4, L24_4)
      L19_4.Size = L20_4
      L19_4.ZIndex = 3
      L19_4.Image = "rbxassetid://4695358235"
      L20_4 = _G
      L20_4 = L20_4.TertiaryColor
      if not L20_4 then
        L20_4 = Color3
        L20_4 = L20_4.fromRGB
        L21_4 = 38
        L22_4 = 38
        L23_4 = 38
        L20_4 = L20_4(L21_4, L22_4, L23_4)
      end
      L19_4.ImageColor3 = L20_4
      L20_4 = Enum
      L20_4 = L20_4.ScaleType
      L20_4 = L20_4.Slice
      L19_4.ScaleType = L20_4
      L20_4 = Rect
      L20_4 = L20_4.new
      L21_4 = 128
      L22_4 = 128
      L23_4 = 128
      L24_4 = 128
      L20_4 = L20_4(L21_4, L22_4, L23_4, L24_4)
      L19_4.SliceCenter = L20_4
      L19_4.SliceScale = 0.05
      L13_4.Parent = L12_4
      L20_4 = Enum
      L20_4 = L20_4.SortOrder
      L20_4 = L20_4.LayoutOrder
      L13_4.SortOrder = L20_4
      L20_4 = 1
      L21_4 = #A2_4
      L22_4 = 1
      for L23_4 = L20_4, L21_4, L22_4 do
        L24_4 = A2_4[L23_4]
        L25_4 = Instance
        L25_4 = L25_4.new
        L26_4 = "ImageButton"
        L25_4 = L25_4(L26_4)
        L26_4 = Instance
        L26_4 = L26_4.new
        L27_4 = "TextLabel"
        L26_4 = L26_4(L27_4)
        L25_4.Name = "Element"
        L25_4.Parent = L12_4
        L27_4 = Color3
        L27_4 = L27_4.fromRGB
        L28_4 = 255
        L29_4 = 255
        L30_4 = 255
        L27_4 = L27_4(L28_4, L29_4, L30_4)
        L25_4.BackgroundColor3 = L27_4
        L25_4.BackgroundTransparency = 1
        L27_4 = UDim2
        L27_4 = L27_4.new
        L28_4 = 1
        L29_4 = 0
        L30_4 = 0
        L31_4 = 23
        L27_4 = L27_4(L28_4, L29_4, L30_4, L31_4)
        L25_4.Size = L27_4
        L25_4.ZIndex = 7
        L25_4.Image = "rbxassetid://4921672704"
        L27_4 = _G
        L27_4 = L27_4.TertiaryColor
        if not L27_4 then
          L27_4 = Color3
          L27_4 = L27_4.fromRGB
          L28_4 = 38
          L29_4 = 38
          L30_4 = 38
          L27_4 = L27_4(L28_4, L29_4, L30_4)
        end
        L25_4.ImageColor3 = L27_4
        L27_4 = Enum
        L27_4 = L27_4.ScaleType
        L27_4 = L27_4.Slice
        L25_4.ScaleType = L27_4
        L27_4 = Rect
        L27_4 = L27_4.new
        L28_4 = 128
        L29_4 = 128
        L30_4 = 128
        L31_4 = 128
        L27_4 = L27_4(L28_4, L29_4, L30_4, L31_4)
        L25_4.SliceCenter = L27_4
        L25_4.SliceScale = 0.05
        L26_4.Name = "Title"
        L26_4.Parent = L25_4
        L26_4.Active = true
        L27_4 = Color3
        L27_4 = L27_4.fromRGB
        L28_4 = 255
        L29_4 = 255
        L30_4 = 255
        L27_4 = L27_4(L28_4, L29_4, L30_4)
        L26_4.BackgroundColor3 = L27_4
        L26_4.BackgroundTransparency = 1
        L27_4 = UDim2
        L27_4 = L27_4.new
        L28_4 = 0
        L29_4 = 5
        L30_4 = 0
        L31_4 = 0
        L27_4 = L27_4(L28_4, L29_4, L30_4, L31_4)
        L26_4.Position = L27_4
        L27_4 = UDim2
        L27_4 = L27_4.new
        L28_4 = 1
        L29_4 = -10
        L30_4 = 1
        L31_4 = 0
        L27_4 = L27_4(L28_4, L29_4, L30_4, L31_4)
        L26_4.Size = L27_4
        L26_4.ZIndex = 100
        L27_4 = Enum
        L27_4 = L27_4.Font
        L27_4 = L27_4.SourceSans
        L26_4.Font = L27_4
        L27_4 = tostring
        L28_4 = L24_4
        L27_4 = L27_4(L28_4)
        L26_4.Text = L27_4
        L27_4 = _G
        L27_4 = L27_4.MainTextColor
        if not L27_4 then
          L27_4 = Color3
          L27_4 = L27_4.fromRGB
          L28_4 = 169
          L29_4 = 169
          L30_4 = 169
          L27_4 = L27_4(L28_4, L29_4, L30_4)
        end
        L26_4.TextColor3 = L27_4
        L26_4.TextScaled = true
        L26_4.TextSize = 18
        L26_4.TextWrapped = true
        L27_4 = Enum
        L27_4 = L27_4.TextXAlignment
        L27_4 = L27_4.Left
        L26_4.TextXAlignment = L27_4
        L27_4 = L25_4.MouseButton1Click
        L28_4 = L27_4
        L27_4 = L27_4.Connect
        
        function L29_4()
          local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
          L0_5 = L9_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSize
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 1
          L4_5 = 0
          L5_5 = 0
          L6_5 = 0
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = "In"
          L4_5 = "Quart"
          L5_5 = 0.5
          L6_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L8_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = Enum
          L5_5 = L5_5.EasingStyle
          L5_5 = L5_5.Quart
          L6_5 = Enum
          L6_5 = L6_5.EasingDirection
          L6_5 = L6_5.In
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L4_5 = {}
          L4_5.Rotation = 90
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
          L0_5 = A3_4
          if L0_5 then
            L0_5 = L6_4
            L1_5 = L26_4
            L1_5 = L1_5.Text
            L0_5.Text = L1_5
          end
          L0_5 = pcall
          L1_5 = A4_4
          L2_5 = L26_4
          L2_5 = L2_5.Text
          L0_5(L1_5, L2_5)
          return
        end
        
        L27_4(L28_4, L29_4)
        A0_4 = A0_4
      end
      L20_4 = L5_4
      
      function L21_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5
        A2_4 = A1_5
        L2_5 = L12_4
        L3_5 = pairs
        L5_5 = L2_5
        L4_5 = L2_5.GetChildren
        L4_5(L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5)
        L3_5, L4_5, L5_5 = L3_5(L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5)
        for L6_5, L7_5 in L3_5, L4_5, L5_5 do
          L9_5 = L7_5
          L8_5 = L7_5.IsA
          L10_5 = "UIListLayout"
          L8_5 = L8_5(L9_5, L10_5)
          if not L8_5 then
            L9_5 = L7_5
            L8_5 = L7_5.Destroy
            L8_5(L9_5)
          end
        end
        L3_5 = 1
        L4_5 = #A1_5
        L5_5 = 1
        for L6_5 = L3_5, L4_5, L5_5 do
          L7_5 = A1_5[L6_5]
          L8_5 = Instance
          L8_5 = L8_5.new
          L9_5 = "ImageButton"
          L8_5 = L8_5(L9_5)
          L9_5 = Instance
          L9_5 = L9_5.new
          L10_5 = "TextLabel"
          L9_5 = L9_5(L10_5)
          L8_5.Name = "Element"
          L10_5 = L12_4
          L8_5.Parent = L10_5
          L10_5 = Color3
          L10_5 = L10_5.fromRGB
          L11_5 = 255
          L12_5 = 255
          L13_5 = 255
          L10_5 = L10_5(L11_5, L12_5, L13_5)
          L8_5.BackgroundColor3 = L10_5
          L8_5.BackgroundTransparency = 1
          L10_5 = UDim2
          L10_5 = L10_5.new
          L11_5 = 1
          L12_5 = 0
          L13_5 = 0
          L14_5 = 23
          L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
          L8_5.Size = L10_5
          L8_5.ZIndex = 7
          L8_5.Image = "rbxassetid://4921672704"
          L10_5 = _G
          L10_5 = L10_5.TertiaryColor
          if not L10_5 then
            L10_5 = Color3
            L10_5 = L10_5.fromRGB
            L11_5 = 38
            L12_5 = 38
            L13_5 = 38
            L10_5 = L10_5(L11_5, L12_5, L13_5)
          end
          L8_5.ImageColor3 = L10_5
          L10_5 = Enum
          L10_5 = L10_5.ScaleType
          L10_5 = L10_5.Slice
          L8_5.ScaleType = L10_5
          L10_5 = Rect
          L10_5 = L10_5.new
          L11_5 = 128
          L12_5 = 128
          L13_5 = 128
          L14_5 = 128
          L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
          L8_5.SliceCenter = L10_5
          L8_5.SliceScale = 0.05
          L9_5.Name = "Title"
          L9_5.Parent = L8_5
          L9_5.Active = true
          L10_5 = Color3
          L10_5 = L10_5.fromRGB
          L11_5 = 255
          L12_5 = 255
          L13_5 = 255
          L10_5 = L10_5(L11_5, L12_5, L13_5)
          L9_5.BackgroundColor3 = L10_5
          L9_5.BackgroundTransparency = 1
          L10_5 = UDim2
          L10_5 = L10_5.new
          L11_5 = 0
          L12_5 = 5
          L13_5 = 0
          L14_5 = 0
          L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
          L9_5.Position = L10_5
          L10_5 = UDim2
          L10_5 = L10_5.new
          L11_5 = 1
          L12_5 = -10
          L13_5 = 1
          L14_5 = 0
          L10_5 = L10_5(L11_5, L12_5, L13_5, L14_5)
          L9_5.Size = L10_5
          L9_5.ZIndex = 100
          L10_5 = Enum
          L10_5 = L10_5.Font
          L10_5 = L10_5.SourceSans
          L9_5.Font = L10_5
          L10_5 = tostring
          L11_5 = L7_5
          L10_5 = L10_5(L11_5)
          L9_5.Text = L10_5
          L10_5 = _G
          L10_5 = L10_5.MainTextColor
          if not L10_5 then
            L10_5 = Color3
            L10_5 = L10_5.fromRGB
            L11_5 = 169
            L12_5 = 169
            L13_5 = 169
            L10_5 = L10_5(L11_5, L12_5, L13_5)
          end
          L9_5.TextColor3 = L10_5
          L9_5.TextScaled = true
          L9_5.TextSize = 18
          L9_5.TextWrapped = true
          L10_5 = Enum
          L10_5 = L10_5.TextXAlignment
          L10_5 = L10_5.Left
          L9_5.TextXAlignment = L10_5
          L10_5 = L8_5.MouseButton1Click
          L11_5 = L10_5
          L10_5 = L10_5.Connect
          
          function L12_5()
            local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6
            L0_6 = L9_4
            L1_6 = L0_6
            L0_6 = L0_6.TweenSize
            L2_6 = UDim2
            L2_6 = L2_6.new
            L3_6 = 1
            L4_6 = 0
            L5_6 = 0
            L6_6 = 0
            L2_6 = L2_6(L3_6, L4_6, L5_6, L6_6)
            L3_6 = "In"
            L4_6 = "Quart"
            L5_6 = 0.5
            L6_6 = true
            L0_6(L1_6, L2_6, L3_6, L4_6, L5_6, L6_6)
            L0_6 = L1_1
            L1_6 = L0_6
            L0_6 = L0_6.Create
            L2_6 = L8_4
            L3_6 = TweenInfo
            L3_6 = L3_6.new
            L4_6 = 0.5
            L5_6 = Enum
            L5_6 = L5_6.EasingStyle
            L5_6 = L5_6.Quart
            L6_6 = Enum
            L6_6 = L6_6.EasingDirection
            L6_6 = L6_6.In
            L3_6 = L3_6(L4_6, L5_6, L6_6)
            L4_6 = {}
            L4_6.Rotation = 90
            L0_6 = L0_6(L1_6, L2_6, L3_6, L4_6)
            L1_6 = L0_6
            L0_6 = L0_6.Play
            L0_6(L1_6)
            L0_6 = A3_4
            if L0_6 then
              L0_6 = L6_4
              L1_6 = L9_5
              L1_6 = L1_6.Text
              L0_6.Text = L1_6
            end
            L0_6 = pcall
            L1_6 = A4_4
            L2_6 = L9_5
            L2_6 = L2_6.Text
            L0_6(L1_6, L2_6)
            return
          end
          
          L10_5(L11_5, L12_5)
          A0_5 = A0_5
        end
        return
      end
      
      L22_4 = L7_4.MouseButton1Click
      L23_4 = L22_4
      L22_4 = L22_4.Connect
      
      function L24_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = toggledrop
        L0_5 = not L0_5
        toggledrop = L0_5
        L0_5 = toggledrop
        if L0_5 then
          L0_5 = 0
          L16_4 = L0_5
          L0_5 = pairs
          L1_5 = A2_4
          L0_5, L1_5, L2_5 = L0_5(L1_5)
          for L3_5, L4_5 in L0_5, L1_5, L2_5 do
            L5_5 = L16_4
            L5_5 = L5_5 + 23
            L16_4 = L5_5
            L5_5 = nil
            L18_4 = L5_5
          end
          L0_5 = L16_4
          if 150 <= L0_5 then
            L0_5 = 150
            L18_4 = L0_5
            L0_5 = 10
            L17_4 = L0_5
            L0_5 = L12_4
            L1_5 = L17_4
            L0_5.ScrollBarThickness = L1_5
          end
          L0_5 = L12_4
          L1_5 = UDim2
          L1_5 = L1_5.new
          L2_5 = 0
          L3_5 = 0
          L4_5 = 0
          L5_5 = L16_4
          L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
          L0_5.CanvasSize = L1_5
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L8_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = Enum
          L5_5 = L5_5.EasingStyle
          L5_5 = L5_5.Quart
          L6_5 = Enum
          L6_5 = L6_5.EasingDirection
          L6_5 = L6_5.Out
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L4_5 = {}
          L4_5.Rotation = 0
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
          L0_5 = L9_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSize
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 215
          L5_5 = 0
          L6_5 = L18_4
          if L6_5 ~= nil then
            L6_5 = L18_4
            if L6_5 then
              goto lbl_71
            end
          end
          L6_5 = L16_4
          ::lbl_71::
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = "Out"
          L4_5 = "Quart"
          L5_5 = 0.5
          L6_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
        else
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L8_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = Enum
          L5_5 = L5_5.EasingStyle
          L5_5 = L5_5.Quart
          L6_5 = Enum
          L6_5 = L6_5.EasingDirection
          L6_5 = L6_5.In
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L4_5 = {}
          L4_5.Rotation = 90
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
          L0_5 = L9_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSize
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 215
          L5_5 = 0
          L6_5 = 0
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = "In"
          L4_5 = "Quart"
          L5_5 = 0.5
          L6_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
        end
        return
      end
      
      L22_4(L23_4, L24_4)
      L22_4 = {}
      L22_4.Refresh = L21_4
      do return L22_4 end
      return
    end
    
    L8_3.Dropdown = L11_3
    
    function L11_3(A0_4, A1_4, A2_4, A3_4)
      local L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4
      L4_4 = typeof
      L5_4 = A3_4
      L4_4 = L4_4(L5_4)
      if L4_4 ~= "function" or not A3_4 then
        function A3_4()
          local L0_5, L1_5
          
          return
        end
      end
      if not A2_4 then
        L4_4 = Color3
        L4_4 = L4_4.fromRGB
        L5_4 = 255
        L6_4 = 0
        L7_4 = 255
        L4_4 = L4_4(L5_4, L6_4, L7_4)
        A2_4 = L4_4
      end
      L4_4 = false
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "ImageLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "TextLabel"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "ImageButton"
      L7_4 = L7_4(L8_4)
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "Frame"
      L8_4 = L8_4(L9_4)
      L9_4 = Instance
      L9_4 = L9_4.new
      L10_4 = "ImageLabel"
      L9_4 = L9_4(L10_4)
      L10_4 = Instance
      L10_4 = L10_4.new
      L11_4 = "ImageButton"
      L10_4 = L10_4(L11_4)
      L11_4 = Instance
      L11_4 = L11_4.new
      L12_4 = "ImageLabel"
      L11_4 = L11_4(L12_4)
      L12_4 = Instance
      L12_4 = L12_4.new
      L13_4 = "ImageLabel"
      L12_4 = L12_4(L13_4)
      L13_4 = Instance
      L13_4 = L13_4.new
      L14_4 = "ImageLabel"
      L13_4 = L13_4(L14_4)
      L14_4 = Instance
      L14_4 = L14_4.new
      L15_4 = "ImageLabel"
      L14_4 = L14_4(L15_4)
      L15_4 = Instance
      L15_4 = L15_4.new
      L16_4 = "ImageButton"
      L15_4 = L15_4(L16_4)
      L16_4 = Instance
      L16_4 = L16_4.new
      L17_4 = "ImageLabel"
      L16_4 = L16_4(L17_4)
      L17_4 = Instance
      L17_4 = L17_4.new
      L18_4 = "ImageLabel"
      L17_4 = L17_4(L18_4)
      L18_4 = Instance
      L18_4 = L18_4.new
      L19_4 = "ImageLabel"
      L18_4 = L18_4(L19_4)
      L19_4 = Instance
      L19_4 = L19_4.new
      L20_4 = "TextBox"
      L19_4 = L19_4(L20_4)
      L20_4 = Instance
      L20_4 = L20_4.new
      L21_4 = "ImageLabel"
      L20_4 = L20_4(L21_4)
      L21_4 = Instance
      L21_4 = L21_4.new
      L22_4 = "TextBox"
      L21_4 = L21_4(L22_4)
      L22_4 = Instance
      L22_4 = L22_4.new
      L23_4 = "ImageLabel"
      L22_4 = L22_4(L23_4)
      L23_4 = Instance
      L23_4 = L23_4.new
      L24_4 = "TextBox"
      L23_4 = L23_4(L24_4)
      L24_4 = Instance
      L24_4 = L24_4.new
      L25_4 = "ImageLabel"
      L24_4 = L24_4(L25_4)
      L25_4 = Instance
      L25_4 = L25_4.new
      L26_4 = "TextBox"
      L25_4 = L25_4(L26_4)
      L26_4 = Instance
      L26_4 = L26_4.new
      L27_4 = "Frame"
      L26_4 = L26_4(L27_4)
      L27_4 = Instance
      L27_4 = L27_4.new
      L28_4 = "ImageButton"
      L27_4 = L27_4(L28_4)
      L28_4 = Instance
      L28_4 = L28_4.new
      L29_4 = "ImageLabel"
      L28_4 = L28_4(L29_4)
      L29_4 = Instance
      L29_4 = L29_4.new
      L30_4 = "ImageLabel"
      L29_4 = L29_4(L30_4)
      L30_4 = Instance
      L30_4 = L30_4.new
      L31_4 = "TextLabel"
      L30_4 = L30_4(L31_4)
      L5_4.Name = "ColorPicker"
      L31_4 = L5_3
      L5_4.Parent = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L5_4.BackgroundColor3 = L31_4
      L5_4.BackgroundTransparency = 1
      L5_4.LayoutOrder = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 0
      L35_4 = 32
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L5_4.Size = L31_4
      L5_4.Image = "rbxassetid://4921677978"
      L31_4 = _G
      L31_4 = L31_4.TertiaryColor
      if not L31_4 then
        L31_4 = Color3
        L31_4 = L31_4.fromRGB
        L32_4 = 38
        L33_4 = 38
        L34_4 = 38
        L31_4 = L31_4(L32_4, L33_4, L34_4)
      end
      L5_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L5_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L5_4.SliceCenter = L31_4
      L5_4.SliceScale = 0.05
      L5_4.ClipsDescendants = false
      L6_4.Name = "Title"
      L6_4.Parent = L5_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L6_4.BackgroundColor3 = L31_4
      L6_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 7
      L34_4 = 0
      L35_4 = 2
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L6_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 145
      L34_4 = 0
      L35_4 = 30
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L6_4.Size = L31_4
      L31_4 = Enum
      L31_4 = L31_4.Font
      L31_4 = L31_4.SourceSansSemibold
      L6_4.Font = L31_4
      L6_4.Text = A1_4
      L31_4 = _G
      L31_4 = L31_4.TextColor
      if not L31_4 then
        L31_4 = Color3
        L31_4 = L31_4.fromRGB
        L32_4 = 169
        L33_4 = 169
        L34_4 = 169
        L31_4 = L31_4(L32_4, L33_4, L34_4)
      end
      L6_4.TextColor3 = L31_4
      L6_4.TextSize = 20
      L6_4.TextWrapped = true
      L31_4 = Enum
      L31_4 = L31_4.TextXAlignment
      L31_4 = L31_4.Left
      L6_4.TextXAlignment = L31_4
      L6_4.TextScaled = false
      L7_4.Name = "Color"
      L7_4.Parent = L5_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L7_4.BackgroundColor3 = L31_4
      L7_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -47
      L34_4 = 0
      L35_4 = 5
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L7_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 40
      L34_4 = 0
      L35_4 = 25
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L7_4.Size = L31_4
      L7_4.AutoButtonColor = false
      L7_4.Image = "rbxassetid://4921672704"
      L7_4.ImageColor3 = A2_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L7_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L7_4.SliceCenter = L31_4
      L7_4.SliceScale = 0.03
      L8_4.Name = "Picker"
      L8_4.Parent = L5_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L8_4.BackgroundColor3 = L31_4
      L8_4.BackgroundTransparency = 1
      L8_4.ClipsDescendants = true
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 0
      L35_4 = -38
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L8_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 0
      L34_4 = 0
      L35_4 = 193
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L8_4.Size = L31_4
      L8_4.ZIndex = 100
      L9_4.Name = "Picker"
      L9_4.Parent = L8_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L9_4.BackgroundColor3 = L31_4
      L9_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 20
      L34_4 = 0
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L9_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 170
      L34_4 = 1
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L9_4.Size = L31_4
      L9_4.ZIndex = 94
      L9_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 38
      L33_4 = 38
      L34_4 = 38
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L9_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L9_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L9_4.SliceCenter = L31_4
      L9_4.SliceScale = 0.05
      L10_4.Name = "Color"
      L10_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L10_4.BackgroundColor3 = L31_4
      L10_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 15
      L34_4 = 0
      L35_4 = 10
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L10_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 100
      L34_4 = 0
      L35_4 = 100
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L10_4.Size = L31_4
      L10_4.AutoButtonColor = false
      L10_4.Image = "rbxassetid://4921700277"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 38
      L33_4 = 38
      L34_4 = 38
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L10_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L10_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L10_4.SliceCenter = L31_4
      L10_4.SliceScale = 0.05
      L11_4.Name = "Darkness"
      L11_4.Parent = L10_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 0
      L34_4 = 132
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L11_4.BackgroundColor3 = L31_4
      L11_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 1
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L11_4.Size = L31_4
      L11_4.ZIndex = 98
      L11_4.Image = "rbxassetid://4921703899"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 0
      L33_4 = 0
      L34_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L11_4.ImageColor3 = L31_4
      L12_4.Name = "Lightness"
      L12_4.Parent = L10_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 0
      L34_4 = 132
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L12_4.BackgroundColor3 = L31_4
      L12_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 1
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L12_4.Size = L31_4
      L12_4.ZIndex = 96
      L12_4.Image = "rbxassetid://4921705601"
      L13_4.Name = "Selection"
      L13_4.Parent = L10_4
      L31_4 = Vector2
      L31_4 = L31_4.new
      L32_4 = 0.5
      L33_4 = 0.5
      L31_4 = L31_4(L32_4, L33_4)
      L13_4.AnchorPoint = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 0
      L34_4 = 132
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L13_4.BackgroundColor3 = L31_4
      L13_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 0
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L13_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 20
      L34_4 = 0
      L35_4 = 20
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L13_4.Size = L31_4
      L13_4.Image = "rbxassetid://4921707067"
      L13_4.ZIndex = 100
      L14_4.Name = "Hue"
      L14_4.Parent = L10_4
      L14_4.BackgroundColor3 = A2_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 1
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L14_4.Size = L31_4
      L14_4.ZIndex = 95
      L15_4.Name = "Hue"
      L15_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L15_4.BackgroundColor3 = L31_4
      L15_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 130
      L34_4 = 0
      L35_4 = 10
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L15_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 15
      L34_4 = 0
      L35_4 = 100
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L15_4.Size = L31_4
      L15_4.ZIndex = 99
      L15_4.AutoButtonColor = false
      L15_4.Image = "rbxassetid://4921700277"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 38
      L33_4 = 38
      L34_4 = 38
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L15_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L15_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L15_4.SliceCenter = L31_4
      L15_4.SliceScale = 0.05
      L16_4.Name = "Selection"
      L16_4.Parent = L15_4
      L31_4 = Vector2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 0.5
      L31_4 = L31_4(L32_4, L33_4)
      L16_4.AnchorPoint = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L16_4.BackgroundColor3 = L31_4
      L16_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 15
      L34_4 = 0
      L35_4 = 15
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L16_4.Size = L31_4
      L16_4.Image = "rbxassetid://4921707067"
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Fit
      L16_4.ScaleType = L31_4
      L16_4.ZIndex = 100
      L17_4.Name = "Rainbow"
      L17_4.Parent = L15_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L17_4.BackgroundColor3 = L31_4
      L17_4.BackgroundTransparency = 1
      L17_4.ClipsDescendants = true
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = 0
      L34_4 = 1
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L17_4.Size = L31_4
      L17_4.ZIndex = 98
      L17_4.Image = "rbxassetid://4921708733"
      L18_4.Name = "R"
      L18_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L18_4.BackgroundColor3 = L31_4
      L18_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 10
      L34_4 = 0
      L35_4 = 118
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L18_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 45
      L34_4 = 0
      L35_4 = 20
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L18_4.Size = L31_4
      L18_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 46
      L33_4 = 46
      L34_4 = 46
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L18_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L18_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L18_4.SliceCenter = L31_4
      L18_4.SliceScale = 0.04
      L18_4.ZIndex = 90
      L19_4.Name = "Value"
      L19_4.Parent = L18_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L19_4.BackgroundColor3 = L31_4
      L19_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -4
      L34_4 = 1
      L35_4 = -4
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L19_4.Size = L31_4
      L19_4.ClearTextOnFocus = false
      L31_4 = Enum
      L31_4 = L31_4.Font
      L31_4 = L31_4.SourceSansSemibold
      L19_4.Font = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 112
      L33_4 = 112
      L34_4 = 112
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L19_4.PlaceholderColor3 = L31_4
      L19_4.Text = "255"
      L31_4 = _G
      L31_4 = L31_4.TextColor
      if not L31_4 then
        L31_4 = Color3
        L31_4 = L31_4.fromRGB
        L32_4 = 169
        L33_4 = 169
        L34_4 = 169
        L31_4 = L31_4(L32_4, L33_4, L34_4)
      end
      L19_4.TextColor3 = L31_4
      L19_4.TextScaled = true
      L19_4.TextSize = 14
      L19_4.TextWrapped = true
      L19_4.ZIndex = 98
      L20_4.Name = "B"
      L20_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L20_4.BackgroundColor3 = L31_4
      L20_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 115
      L34_4 = 0
      L35_4 = 118
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L20_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 45
      L34_4 = 0
      L35_4 = 20
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L20_4.Size = L31_4
      L20_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 46
      L33_4 = 46
      L34_4 = 46
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L20_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L20_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L20_4.SliceCenter = L31_4
      L20_4.SliceScale = 0.04
      L20_4.ZIndex = 98
      L21_4.Name = "Value"
      L21_4.Parent = L20_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L21_4.BackgroundColor3 = L31_4
      L21_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -4
      L34_4 = 1
      L35_4 = -4
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L21_4.Size = L31_4
      L21_4.ClearTextOnFocus = false
      L31_4 = Enum
      L31_4 = L31_4.Font
      L31_4 = L31_4.SourceSansSemibold
      L21_4.Font = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 112
      L33_4 = 112
      L34_4 = 112
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L21_4.PlaceholderColor3 = L31_4
      L21_4.Text = "255"
      L31_4 = _G
      L31_4 = L31_4.TextColor
      if not L31_4 then
        L31_4 = Color3
        L31_4 = L31_4.fromRGB
        L32_4 = 169
        L33_4 = 169
        L34_4 = 169
        L31_4 = L31_4(L32_4, L33_4, L34_4)
      end
      L21_4.TextColor3 = L31_4
      L21_4.TextScaled = true
      L21_4.TextSize = 14
      L21_4.TextWrapped = true
      L21_4.ZIndex = 98
      L22_4.Name = "G"
      L22_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L22_4.BackgroundColor3 = L31_4
      L22_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 63
      L34_4 = 0
      L35_4 = 118
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L22_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 45
      L34_4 = 0
      L35_4 = 20
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L22_4.Size = L31_4
      L22_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 46
      L33_4 = 46
      L34_4 = 46
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L22_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L22_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L22_4.SliceCenter = L31_4
      L22_4.SliceScale = 0.04
      L22_4.ZIndex = 98
      L23_4.Name = "Value"
      L23_4.Parent = L22_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L23_4.BackgroundColor3 = L31_4
      L23_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -4
      L34_4 = 1
      L35_4 = -4
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L23_4.Size = L31_4
      L23_4.ClearTextOnFocus = false
      L31_4 = Enum
      L31_4 = L31_4.Font
      L31_4 = L31_4.SourceSansSemibold
      L23_4.Font = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 112
      L33_4 = 112
      L34_4 = 112
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L23_4.PlaceholderColor3 = L31_4
      L23_4.Text = "255"
      L31_4 = _G
      L31_4 = L31_4.TextColor
      if not L31_4 then
        L31_4 = Color3
        L31_4 = L31_4.fromRGB
        L32_4 = 169
        L33_4 = 169
        L34_4 = 169
        L31_4 = L31_4(L32_4, L33_4, L34_4)
      end
      L23_4.TextColor3 = L31_4
      L23_4.TextScaled = true
      L23_4.TextSize = 14
      L23_4.TextWrapped = true
      L23_4.ZIndex = 98
      L24_4.Name = "HEX"
      L24_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L24_4.BackgroundColor3 = L31_4
      L24_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 10
      L34_4 = 0
      L35_4 = 142
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L24_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 150
      L34_4 = 0
      L35_4 = 20
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L24_4.Size = L31_4
      L24_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 46
      L33_4 = 46
      L34_4 = 46
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L24_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L24_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L24_4.SliceCenter = L31_4
      L24_4.SliceScale = 0.04
      L24_4.ZIndex = 98
      L25_4.Name = "Value"
      L25_4.Parent = L24_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L25_4.BackgroundColor3 = L31_4
      L25_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -4
      L34_4 = 1
      L35_4 = -4
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L25_4.Size = L31_4
      L25_4.ClearTextOnFocus = false
      L31_4 = Enum
      L31_4 = L31_4.Font
      L31_4 = L31_4.SourceSansSemibold
      L25_4.Font = L31_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 112
      L33_4 = 112
      L34_4 = 112
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L25_4.PlaceholderColor3 = L31_4
      L25_4.PlaceholderText = "HEX"
      L25_4.Text = "HEX"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 169
      L33_4 = 169
      L34_4 = 169
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L25_4.TextColor3 = L31_4
      L25_4.TextScaled = true
      L25_4.TextSize = 14
      L25_4.TextWrapped = true
      L25_4.ZIndex = 98
      L26_4.Name = "Rainbow"
      L26_4.Parent = L9_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L26_4.BackgroundColor3 = L31_4
      L26_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 10
      L34_4 = 0
      L35_4 = 166
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L26_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 150
      L34_4 = 0
      L35_4 = 20
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L26_4.Size = L31_4
      L26_4.ZIndex = 98
      L27_4.Name = "Tick"
      L27_4.Parent = L26_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L27_4.BackgroundColor3 = L31_4
      L27_4.BackgroundTransparency = 1
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 0
      L33_4 = 0
      L34_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L27_4.BorderColor3 = L31_4
      L27_4.BorderSizePixel = 100
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -28
      L34_4 = 0
      L35_4 = 0
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L27_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 21
      L34_4 = 0
      L35_4 = 21
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L27_4.Size = L31_4
      L27_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 94
      L33_4 = 93
      L34_4 = 94
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L27_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L27_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L27_4.SliceCenter = L31_4
      L27_4.SliceScale = 0.03
      L27_4.ZIndex = 98
      L28_4.Name = "Fill"
      L28_4.Parent = L27_4
      L28_4.Active = true
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L28_4.BackgroundColor3 = L31_4
      L28_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 2
      L34_4 = 0
      L35_4 = 2
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L28_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -4
      L34_4 = 1
      L35_4 = -4
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L28_4.Size = L31_4
      L28_4.Image = "rbxassetid://4921672704"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 38
      L33_4 = 38
      L34_4 = 38
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L28_4.ImageColor3 = L31_4
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Slice
      L28_4.ScaleType = L31_4
      L31_4 = Rect
      L31_4 = L31_4.new
      L32_4 = 128
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L28_4.SliceCenter = L31_4
      L28_4.SliceScale = 0.01
      L28_4.ZIndex = 98
      L29_4.Name = "Check"
      L29_4.Parent = L27_4
      L29_4.Active = true
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L29_4.BackgroundColor3 = L31_4
      L29_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 5
      L34_4 = 0
      L35_4 = 4
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L29_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 1
      L33_4 = -9
      L34_4 = 1
      L35_4 = -9
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L29_4.Size = L31_4
      L29_4.Image = "rbxassetid://4921680783"
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 38
      L33_4 = 38
      L34_4 = 38
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L29_4.ImageColor3 = L31_4
      L29_4.ImageTransparency = 1
      L31_4 = Enum
      L31_4 = L31_4.ScaleType
      L31_4 = L31_4.Fit
      L29_4.ScaleType = L31_4
      L29_4.ZIndex = 98
      L30_4.Name = "Title"
      L30_4.Parent = L26_4
      L31_4 = Color3
      L31_4 = L31_4.fromRGB
      L32_4 = 255
      L33_4 = 255
      L34_4 = 255
      L31_4 = L31_4(L32_4, L33_4, L34_4)
      L30_4.BackgroundColor3 = L31_4
      L30_4.BackgroundTransparency = 1
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 5
      L34_4 = 0
      L35_4 = -5
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L30_4.Position = L31_4
      L31_4 = UDim2
      L31_4 = L31_4.new
      L32_4 = 0
      L33_4 = 145
      L34_4 = 0
      L35_4 = 30
      L31_4 = L31_4(L32_4, L33_4, L34_4, L35_4)
      L30_4.Size = L31_4
      L31_4 = Enum
      L31_4 = L31_4.Font
      L31_4 = L31_4.SourceSansSemibold
      L30_4.Font = L31_4
      L30_4.Text = "Rainbow"
      L31_4 = _G
      L31_4 = L31_4.TextColor
      if not L31_4 then
        L31_4 = Color3
        L31_4 = L31_4.fromRGB
        L32_4 = 169
        L33_4 = 169
        L34_4 = 169
        L31_4 = L31_4(L32_4, L33_4, L34_4)
      end
      L30_4.TextColor3 = L31_4
      L30_4.TextSize = 20
      L30_4.TextWrapped = true
      L31_4 = Enum
      L31_4 = L31_4.TextXAlignment
      L31_4 = L31_4.Left
      L30_4.TextXAlignment = L31_4
      L30_4.ZIndex = 98
      L31_4 = Instance
      L31_4 = L31_4.new
      L32_4 = "ImageLabel"
      L31_4 = L31_4(L32_4)
      L31_4.Name = "Cap"
      L31_4.Parent = L5_4
      L32_4 = Color3
      L32_4 = L32_4.fromRGB
      L33_4 = 255
      L34_4 = 255
      L35_4 = 255
      L32_4 = L32_4(L33_4, L34_4, L35_4)
      L31_4.BackgroundColor3 = L32_4
      L31_4.BackgroundTransparency = 1
      L32_4 = UDim2
      L32_4 = L32_4.new
      L33_4 = 0
      L34_4 = 0
      L35_4 = 1
      L36_4 = -2
      L32_4 = L32_4(L33_4, L34_4, L35_4, L36_4)
      L31_4.Position = L32_4
      L32_4 = UDim2
      L32_4 = L32_4.new
      L33_4 = 1
      L34_4 = 0
      L35_4 = 0
      L36_4 = 5
      L32_4 = L32_4(L33_4, L34_4, L35_4, L36_4)
      L31_4.Size = L32_4
      L31_4.ZIndex = 3
      L31_4.Image = "rbxassetid://4695358235"
      L32_4 = _G
      L32_4 = L32_4.TertiaryColor
      if not L32_4 then
        L32_4 = Color3
        L32_4 = L32_4.fromRGB
        L33_4 = 38
        L34_4 = 38
        L35_4 = 38
        L32_4 = L32_4(L33_4, L34_4, L35_4)
      end
      L31_4.ImageColor3 = L32_4
      L32_4 = Enum
      L32_4 = L32_4.ScaleType
      L32_4 = L32_4.Slice
      L31_4.ScaleType = L32_4
      L32_4 = Rect
      L32_4 = L32_4.new
      L33_4 = 128
      L34_4 = 128
      L35_4 = 128
      L36_4 = 128
      L32_4 = L32_4(L33_4, L34_4, L35_4, L36_4)
      L31_4.SliceCenter = L32_4
      L31_4.SliceScale = 0.05
      L32_4 = false
      L33_4 = L7_4.MouseButton1Click
      L34_4 = L33_4
      L33_4 = L33_4.Connect
      
      function L35_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L32_4
        L0_5 = not L0_5
        L32_4 = L0_5
        L0_5 = L32_4
        if L0_5 then
          L0_5 = L8_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSize
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 190
          L5_5 = 0
          L6_5 = 193
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = "Out"
          L4_5 = "Quart"
          L5_5 = 0.5
          L6_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
        else
          L0_5 = L8_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSize
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 0
          L5_5 = 0
          L6_5 = 193
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = "Out"
          L4_5 = "Quart"
          L5_5 = 0.5
          L6_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
        end
        return
      end
      
      L33_4(L34_4, L35_4)
      L33_4 = nil
      L34_4 = nil
      L35_4 = game
      L36_4 = L35_4
      L35_4 = L35_4.GetService
      L37_4 = "Players"
      L35_4 = L35_4(L36_4, L37_4)
      L35_4 = L35_4.LocalPlayer
      L36_4 = L35_4
      L35_4 = L35_4.GetMouse
      L35_4 = L35_4(L36_4)
      L36_4 = {}
      L36_4.H = 1
      L36_4.S = 1
      L36_4.V = 1
      
      function L37_4(A0_5, A1_5)
        local L2_5, L3_5, L4_5, L5_5, L6_5
        L2_5 = Color3
        L2_5 = L2_5.fromHSV
        L3_5 = L36_4
        L3_5 = L3_5.H
        L4_5 = L36_4
        L4_5 = L4_5.S
        L5_5 = L36_4
        L5_5 = L5_5.V
        L2_5 = L2_5(L3_5, L4_5, L5_5)
        A0_5.ImageColor3 = L2_5
        L3_5 = Color3
        L3_5 = L3_5.fromHSV
        L4_5 = L36_4
        L4_5 = L4_5.H
        L5_5 = 1
        L6_5 = 1
        L3_5 = L3_5(L4_5, L5_5, L6_5)
        A1_5.BackgroundColor3 = L3_5
        L3_5 = pcall
        L4_5 = A3_4
        L5_5 = L2_5
        L3_5(L4_5, L5_5)
        return
      end
      
      function L38_4(A0_5)
        local L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5
        L1_5 = L35_4
        L1_5 = L1_5.X
        L2_5 = A0_5.AbsolutePosition
        L2_5 = L2_5.X
        L1_5 = L1_5 - L2_5
        L2_5 = L35_4
        L2_5 = L2_5.Y
        L3_5 = A0_5.AbsolutePosition
        L3_5 = L3_5.Y
        L2_5 = L2_5 - L3_5
        L3_5 = A0_5.AbsoluteSize
        L3_5 = L3_5.X
        L4_5 = A0_5.AbsoluteSize
        L4_5 = L4_5.Y
        L5_5 = math
        L5_5 = L5_5.clamp
        L6_5 = L1_5
        L7_5 = 0
        L8_5 = L3_5
        L5_5 = L5_5(L6_5, L7_5, L8_5)
        L1_5 = L5_5
        L5_5 = math
        L5_5 = L5_5.clamp
        L6_5 = L2_5
        L7_5 = 0
        L8_5 = L4_5
        L5_5 = L5_5(L6_5, L7_5, L8_5)
        L2_5 = L5_5
        L5_5 = L1_5 / L3_5
        L6_5 = L2_5 / L4_5
        do return L5_5, L6_5 end
        return
      end
      
      L39_4 = L10_4.InputBegan
      L40_4 = L39_4
      L39_4 = L39_4.Connect
      
      function L41_4(A0_5)
        local L1_5, L2_5, L3_5
        L1_5 = A0_5.UserInputType
        L2_5 = Enum
        L2_5 = L2_5.UserInputType
        L2_5 = L2_5.MouseButton1
        if L1_5 == L2_5 then
          L1_5 = L33_4
          if L1_5 then
            L1_5 = L33_4
            L2_5 = L1_5
            L1_5 = L1_5.Disconnect
            L1_5(L2_5)
          end
          L1_5 = game
          L2_5 = L1_5
          L1_5 = L1_5.GetService
          L3_5 = "RunService"
          L1_5 = L1_5(L2_5, L3_5)
          L1_5 = L1_5.Heartbeat
          L2_5 = L1_5
          L1_5 = L1_5.Connect
          
          function L3_5()
            local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6, L11_6, L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6, L21_6, L22_6, L23_6, L24_6, L25_6, L26_6, L27_6, L28_6, L29_6, L30_6, L31_6, L32_6, L33_6, L34_6, L35_6, L36_6, L37_6, L38_6, L39_6, L40_6, L41_6, L42_6, L43_6, L44_6, L45_6, L46_6, L47_6, L48_6, L49_6, L50_6, L51_6, L52_6, L53_6, L54_6, L55_6, L56_6, L57_6, L58_6, L59_6, L60_6, L61_6, L62_6, L63_6, L64_6, L65_6, L66_6, L67_6, L68_6, L69_6, L70_6, L71_6, L72_6, L73_6, L74_6, L75_6, L76_6, L77_6, L78_6, L79_6, L80_6, L81_6, L82_6, L83_6, L84_6, L85_6, L86_6, L87_6, L88_6, L89_6, L90_6, L91_6, L92_6, L93_6, L94_6, L95_6, L96_6, L97_6, L98_6, L99_6, L100_6, L101_6, L102_6, L103_6, L104_6, L105_6, L106_6, L107_6, L108_6, L109_6, L110_6, L111_6, L112_6, L113_6, L114_6, L115_6, L116_6, L117_6, L118_6, L119_6, L120_6, L121_6, L122_6, L123_6, L124_6, L125_6, L126_6, L127_6, L128_6, L129_6, L130_6, L131_6, L132_6, L133_6, L134_6, L135_6, L136_6, L137_6, L138_6, L139_6, L140_6, L141_6, L142_6, L143_6, L144_6, L145_6, L146_6, L147_6, L148_6, L149_6, L150_6, L151_6, L152_6, L153_6, L154_6, L155_6, L156_6, L157_6, L158_6, L159_6, L160_6, L161_6, L162_6, L163_6, L164_6, L165_6, L166_6, L167_6, L168_6, L169_6, L170_6, L171_6, L172_6, L173_6, L174_6, L175_6, L176_6, L177_6, L178_6, L179_6, L180_6, L181_6, L182_6, L183_6, L184_6, L185_6, L186_6, L187_6, L188_6, L189_6, L190_6, L191_6, L192_6, L193_6, L194_6, L195_6, L196_6, L197_6, L198_6, L199_6, L200_6, L201_6, L202_6, L203_6, L204_6, L205_6, L206_6, L207_6, L208_6, L209_6, L210_6, L211_6, L212_6, L213_6, L214_6, L215_6, L216_6, L217_6, L218_6, L219_6, L220_6, L221_6, L222_6, L223_6, L224_6, L225_6, L226_6, L227_6, L228_6, L229_6, L230_6, L231_6, L232_6, L233_6, L234_6, L235_6, L236_6, L237_6, L238_6, L239_6, L240_6, L241_6, L242_6, L243_6, L244_6, L245_6, L246_6, L247_6, L248_6, L249_6, L250_6, L251_6, L252_6, L253_6, L254_6
            L0_6 = L38_4
            L1_6 = L10_4
            L0_6, L1_6 = L0_6(L1_6)
            L2_6 = L10_4
            L2_6 = L2_6.Selection
            L3_6 = UDim2
            L3_6 = L3_6.new
            L4_6 = L0_6
            L5_6 = 0
            L6_6 = L1_6
            L7_6 = 0
            L3_6 = L3_6(L4_6, L5_6, L6_6, L7_6)
            L2_6.Position = L3_6
            L2_6 = L36_4
            L2_6.S = L0_6
            L2_6 = L36_4
            L3_6 = 1 - L1_6
            L2_6.V = L3_6
            L2_6 = L37_4
            L3_6 = L7_4
            L4_6 = L14_4
            L2_6(L3_6, L4_6)
            return
          end
          
          L1_5 = L1_5(L2_5, L3_5)
          L33_4 = L1_5
        end
        return
      end
      
      L39_4(L40_4, L41_4)
      L39_4 = L15_4.InputBegan
      L40_4 = L39_4
      L39_4 = L39_4.Connect
      
      function L41_4(A0_5)
        local L1_5, L2_5, L3_5
        L1_5 = A0_5.UserInputType
        L2_5 = Enum
        L2_5 = L2_5.UserInputType
        L2_5 = L2_5.MouseButton1
        if L1_5 == L2_5 then
          L1_5 = L34_4
          if L1_5 then
            L1_5 = L34_4
            L2_5 = L1_5
            L1_5 = L1_5.Disconnect
            L1_5(L2_5)
          end
          L1_5 = game
          L2_5 = L1_5
          L1_5 = L1_5.GetService
          L3_5 = "RunService"
          L1_5 = L1_5(L2_5, L3_5)
          L1_5 = L1_5.Heartbeat
          L2_5 = L1_5
          L1_5 = L1_5.Connect
          
          function L3_5()
            local L0_6, L1_6, L2_6, L3_6, L4_6, L5_6, L6_6, L7_6, L8_6, L9_6, L10_6, L11_6, L12_6, L13_6, L14_6, L15_6, L16_6, L17_6, L18_6, L19_6, L20_6, L21_6, L22_6, L23_6, L24_6, L25_6, L26_6, L27_6, L28_6, L29_6, L30_6, L31_6, L32_6, L33_6, L34_6, L35_6, L36_6, L37_6, L38_6, L39_6, L40_6, L41_6, L42_6, L43_6, L44_6, L45_6, L46_6, L47_6, L48_6, L49_6, L50_6, L51_6, L52_6, L53_6, L54_6, L55_6, L56_6, L57_6, L58_6, L59_6, L60_6, L61_6, L62_6, L63_6, L64_6, L65_6, L66_6, L67_6, L68_6, L69_6, L70_6, L71_6, L72_6, L73_6, L74_6, L75_6, L76_6, L77_6, L78_6, L79_6, L80_6, L81_6, L82_6, L83_6, L84_6, L85_6, L86_6, L87_6, L88_6, L89_6, L90_6, L91_6, L92_6, L93_6, L94_6, L95_6, L96_6, L97_6, L98_6, L99_6, L100_6, L101_6, L102_6, L103_6, L104_6, L105_6, L106_6, L107_6, L108_6, L109_6, L110_6, L111_6, L112_6, L113_6, L114_6, L115_6, L116_6, L117_6, L118_6, L119_6, L120_6, L121_6, L122_6, L123_6, L124_6, L125_6, L126_6, L127_6, L128_6, L129_6, L130_6, L131_6, L132_6, L133_6, L134_6, L135_6, L136_6, L137_6, L138_6, L139_6, L140_6, L141_6, L142_6, L143_6, L144_6, L145_6, L146_6, L147_6, L148_6, L149_6, L150_6, L151_6, L152_6, L153_6, L154_6, L155_6, L156_6, L157_6, L158_6, L159_6, L160_6, L161_6, L162_6, L163_6, L164_6, L165_6, L166_6, L167_6, L168_6, L169_6, L170_6, L171_6, L172_6, L173_6, L174_6, L175_6, L176_6, L177_6, L178_6, L179_6, L180_6, L181_6, L182_6, L183_6, L184_6, L185_6, L186_6, L187_6, L188_6, L189_6, L190_6, L191_6, L192_6, L193_6, L194_6, L195_6, L196_6, L197_6, L198_6, L199_6, L200_6, L201_6, L202_6, L203_6, L204_6, L205_6, L206_6, L207_6, L208_6, L209_6, L210_6, L211_6, L212_6, L213_6, L214_6, L215_6, L216_6, L217_6, L218_6, L219_6, L220_6, L221_6, L222_6, L223_6, L224_6, L225_6, L226_6, L227_6, L228_6, L229_6, L230_6, L231_6, L232_6, L233_6, L234_6, L235_6, L236_6, L237_6, L238_6, L239_6, L240_6, L241_6, L242_6, L243_6, L244_6, L245_6, L246_6, L247_6, L248_6, L249_6, L250_6, L251_6, L252_6, L253_6, L254_6
            L0_6 = L38_4
            L1_6 = L15_4
            L0_6, L1_6 = L0_6(L1_6)
            L2_6 = L36_4
            L3_6 = 1 - L1_6
            L2_6.H = L3_6
            L2_6 = L16_4
            L3_6 = UDim2
            L3_6 = L3_6.new
            L4_6 = 0
            L5_6 = 0
            L6_6 = L1_6
            L7_6 = 0
            L3_6 = L3_6(L4_6, L5_6, L6_6, L7_6)
            L2_6.Position = L3_6
            L2_6 = L37_4
            L3_6 = L7_4
            L4_6 = L14_4
            L2_6(L3_6, L4_6)
            return
          end
          
          L1_5 = L1_5(L2_5, L3_5)
          L34_4 = L1_5
        end
        return
      end
      
      L39_4(L40_4, L41_4)
      L39_4 = game
      L40_4 = L39_4
      L39_4 = L39_4.GetService
      L41_4 = "UserInputService"
      L39_4 = L39_4(L40_4, L41_4)
      L39_4 = L39_4.InputEnded
      L40_4 = L39_4
      L39_4 = L39_4.Connect
      
      function L41_4(A0_5)
        local L1_5, L2_5
        L1_5 = A0_5.UserInputType
        L2_5 = Enum
        L2_5 = L2_5.UserInputType
        L2_5 = L2_5.MouseButton1
        if L1_5 == L2_5 then
          L1_5 = L33_4
          if L1_5 then
            L1_5 = L33_4
            L2_5 = L1_5
            L1_5 = L1_5.Disconnect
            L1_5(L2_5)
            L1_5 = nil
            L33_4 = L1_5
          end
          L1_5 = L34_4
          if L1_5 then
            L1_5 = L34_4
            L2_5 = L1_5
            L1_5 = L1_5.Disconnect
            L1_5(L2_5)
            L1_5 = nil
            L34_4 = L1_5
          end
        end
        return
      end
      
      L39_4(L40_4, L41_4)
      
      function L39_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5
        L0_5 = Color3
        L0_5 = L0_5.fromRGB
        L1_5 = tonumber
        L2_5 = L18_4
        L2_5 = L2_5.Value
        L2_5 = L2_5.Text
        L1_5 = L1_5(L2_5)
        L2_5 = tonumber
        L3_5 = L22_4
        L3_5 = L3_5.Value
        L3_5 = L3_5.Text
        L2_5 = L2_5(L3_5)
        L3_5 = tonumber
        L4_5 = L20_4
        L4_5 = L4_5.Value
        L4_5 = L4_5.Text
        L3_5(L4_5)
        L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
        L1_5 = L7_4
        L1_5.ImageColor3 = L0_5
        L1_5 = L14_4
        L1_5.BackgroundColor3 = L0_5
        L1_5 = pcall
        L2_5 = A3_4
        L3_5 = L0_5
        L1_5(L2_5, L3_5)
        return
      end
      
      L40_4 = L18_4.Value
      L41_4 = L22_4.Value
      L42_4 = L20_4.Value
      L43_4 = L40_4.FocusLost
      L44_4 = L43_4
      L43_4 = L43_4.Connect
      
      function L45_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = L40_4
        L0_5 = L0_5.Text
        L1_5 = typeof
        L2_5 = tonumber
        L3_5 = L0_5
        L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        if L1_5 == "number" then
          L1_5 = tonumber
          L2_5 = L0_5
          L1_5 = L1_5(L2_5)
          if 0 <= L1_5 then
            L1_5 = tonumber
            L2_5 = L0_5
            L1_5 = L1_5(L2_5)
            if L1_5 <= 255 then
              L1_5 = L39_4
              L1_5()
            end
          end
        end
        return
      end
      
      L43_4(L44_4, L45_4)
      L43_4 = L41_4.FocusLost
      L44_4 = L43_4
      L43_4 = L43_4.Connect
      
      function L45_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = L41_4
        L0_5 = L0_5.Text
        L1_5 = typeof
        L2_5 = tonumber
        L3_5 = L0_5
        L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        if L1_5 == "number" then
          L1_5 = tonumber
          L2_5 = L0_5
          L1_5 = L1_5(L2_5)
          if 0 <= L1_5 then
            L1_5 = tonumber
            L2_5 = L0_5
            L1_5 = L1_5(L2_5)
            if L1_5 <= 255 then
              L1_5 = L39_4
              L1_5()
            end
          end
        end
        return
      end
      
      L43_4(L44_4, L45_4)
      L43_4 = L42_4.FocusLost
      L44_4 = L43_4
      L43_4 = L43_4.Connect
      
      function L45_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = L42_4
        L0_5 = L0_5.Text
        L1_5 = typeof
        L2_5 = tonumber
        L3_5 = L0_5
        L2_5(L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
        if L1_5 == "number" then
          L1_5 = tonumber
          L2_5 = L0_5
          L1_5 = L1_5(L2_5)
          if 0 <= L1_5 then
            L1_5 = tonumber
            L2_5 = L0_5
            L1_5 = L1_5(L2_5)
            if L1_5 <= 255 then
              L1_5 = L39_4
              L1_5()
            end
          end
        end
        return
      end
      
      L43_4(L44_4, L45_4)
      
      function L43_4(A0_5)
        local L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L2_5 = A0_5
        L1_5 = A0_5.sub
        L3_5 = 2
        L1_5 = L1_5(L2_5, L3_5)
        L2_5 = L1_5
        L1_5 = L1_5.upper
        L1_5 = L1_5(L2_5)
        A0_5 = L1_5
        L1_5 = #A0_5
        if L1_5 == 3 then
          L2_5 = A0_5
          L1_5 = A0_5.sub
          L3_5 = 1
          L4_5 = 1
          L1_5 = L1_5(L2_5, L3_5, L4_5)
          L3_5 = A0_5
          L2_5 = A0_5.sub
          L4_5 = 2
          L5_5 = 2
          L2_5 = L2_5(L3_5, L4_5, L5_5)
          L4_5 = A0_5
          L3_5 = A0_5.sub
          L5_5 = 3
          L6_5 = 3
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L4_5 = A0_5
          L5_5 = tonumber
          L6_5 = L1_5
          L7_5 = L1_5
          L6_5 = L6_5 .. L7_5
          L7_5 = 16
          L5_5 = L5_5(L6_5, L7_5)
          L6_5 = tonumber
          L7_5 = L2_5
          L8_5 = L2_5
          L7_5 = L7_5 .. L8_5
          L8_5 = 16
          L6_5 = L6_5(L7_5, L8_5)
          L7_5 = tonumber
          L8_5 = L3_5
          L9_5 = L3_5
          L8_5 = L8_5 .. L9_5
          L9_5 = 16
          L7_5(L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
          return L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        else
          L1_5 = #A0_5
          if L1_5 == 6 then
            L1_5 = A0_5
            L2_5 = tonumber
            L4_5 = A0_5
            L3_5 = A0_5.sub
            L5_5 = 1
            L6_5 = 2
            L3_5 = L3_5(L4_5, L5_5, L6_5)
            L4_5 = 16
            L2_5 = L2_5(L3_5, L4_5)
            L3_5 = tonumber
            L5_5 = A0_5
            L4_5 = A0_5.sub
            L6_5 = 3
            L7_5 = 4
            L4_5 = L4_5(L5_5, L6_5, L7_5)
            L5_5 = 16
            L3_5 = L3_5(L4_5, L5_5)
            L4_5 = tonumber
            L6_5 = A0_5
            L5_5 = A0_5.sub
            L7_5 = 5
            L8_5 = 6
            L5_5 = L5_5(L6_5, L7_5, L8_5)
            L6_5 = 16
            L4_5(L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
            return L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
          else
            L1_5 = #A0_5
            if L1_5 ~= 3 then
              L1_5 = #A0_5
              if L1_5 < 6 then
                L1_5 = A0_5
                L2_5 = string
                L2_5 = L2_5.rep
                L3_5 = "0"
                L4_5 = #A0_5
                L4_5 = 6 - L4_5
                L2_5 = L2_5(L3_5, L4_5)
                A0_5 = L1_5 .. L2_5
                L1_5 = A0_5
                L2_5 = tonumber
                L4_5 = A0_5
                L3_5 = A0_5.sub
                L5_5 = 1
                L6_5 = 2
                L3_5 = L3_5(L4_5, L5_5, L6_5)
                L4_5 = 16
                L2_5 = L2_5(L3_5, L4_5)
                L3_5 = tonumber
                L5_5 = A0_5
                L4_5 = A0_5.sub
                L6_5 = 3
                L7_5 = 4
                L4_5 = L4_5(L5_5, L6_5, L7_5)
                L5_5 = 16
                L3_5 = L3_5(L4_5, L5_5)
                L4_5 = tonumber
                L6_5 = A0_5
                L5_5 = A0_5.sub
                L7_5 = 5
                L8_5 = 6
                L5_5 = L5_5(L6_5, L7_5, L8_5)
                L6_5 = 16
                L4_5(L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5)
                return L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
              end
            end
          end
        end
        return
      end
      
      L44_4 = L25_4.FocusLost
      L45_4 = L44_4
      L44_4 = L44_4.Connect
      
      function L46_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5
        L0_5 = L43_4
        L1_5 = L25_4
        L1_5 = L1_5.Text
        L0_5, L1_5, L2_5, L3_5 = L0_5(L1_5)
        L4_5 = Color3
        L4_5 = L4_5.toHSV
        L5_5 = Color3
        L5_5 = L5_5.fromRGB
        L6_5 = L1_5
        L7_5 = L2_5
        L8_5 = L3_5
        L5_5(L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5)
        L4_5, L5_5, L6_5 = L4_5(L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5)
        L7_5 = L25_4
        L7_5.Text = L0_5
        L7_5 = L7_4
        L8_5 = Color3
        L8_5 = L8_5.fromRGB
        L9_5 = L1_5
        L10_5 = L2_5
        L11_5 = L3_5
        L8_5 = L8_5(L9_5, L10_5, L11_5)
        L7_5.ImageColor3 = L8_5
        L7_5 = L14_4
        L8_5 = Color3
        L8_5 = L8_5.fromRGB
        L9_5 = L1_5
        L10_5 = L2_5
        L11_5 = L3_5
        L8_5 = L8_5(L9_5, L10_5, L11_5)
        L7_5.BackgroundColor3 = L8_5
        L7_5 = pcall
        L8_5 = A3_4
        L9_5 = Color3
        L9_5 = L9_5.fromRGB
        L10_5 = L1_5
        L11_5 = L2_5
        L12_5 = L3_5
        L9_5(L10_5, L11_5, L12_5)
        L7_5(L8_5, L9_5, L10_5, L11_5, L12_5)
        return
      end
      
      L44_4(L45_4, L46_4)
      L44_4 = L27_4.MouseButton1Click
      L45_4 = L44_4
      L44_4 = L44_4.Connect
      
      function L46_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = L4_4
        L0_5 = not L0_5
        L4_4 = L0_5
        L0_5 = L4_4
        if L0_5 then
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L29_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.1
          L3_5 = L3_5(L4_5)
          L4_5 = {}
          L4_5.ImageTransparency = 0
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
          L0_5 = L28_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSizeAndPosition
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 0
          L5_5 = 0
          L6_5 = 0
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = UDim2
          L3_5 = L3_5.new
          L4_5 = 0.5
          L5_5 = 0
          L6_5 = 0.5
          L7_5 = 0
          L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
          L4_5 = "Out"
          L5_5 = "Quart"
          L6_5 = 0.1
          L7_5 = true
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5)
          L0_5 = L1_1
          L1_5 = L0_5
          L0_5 = L0_5.Create
          L2_5 = L27_4
          L3_5 = TweenInfo
          L3_5 = L3_5.new
          L4_5 = 0.1
          L3_5 = L3_5(L4_5)
          L4_5 = {}
          L5_5 = _G
          L5_5 = L5_5.ToggleColor
          if not L5_5 then
            L5_5 = Color3
            L5_5 = L5_5.fromRGB
            L6_5 = 0
            L7_5 = 255
            L8_5 = 111
            L5_5 = L5_5(L6_5, L7_5, L8_5)
          end
          L4_5.ImageColor3 = L5_5
          L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
          L1_5 = L0_5
          L0_5 = L0_5.Play
          L0_5(L1_5)
        else
          L0_5 = L4_4
          if not L0_5 then
            L0_5 = L1_1
            L1_5 = L0_5
            L0_5 = L0_5.Create
            L2_5 = L29_4
            L3_5 = TweenInfo
            L3_5 = L3_5.new
            L4_5 = 0.1
            L3_5 = L3_5(L4_5)
            L4_5 = {}
            L4_5.ImageTransparency = 1
            L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
            L1_5 = L0_5
            L0_5 = L0_5.Play
            L0_5(L1_5)
            L0_5 = L28_4
            L1_5 = L0_5
            L0_5 = L0_5.TweenSizeAndPosition
            L2_5 = UDim2
            L2_5 = L2_5.new
            L3_5 = 1
            L4_5 = -4
            L5_5 = 1
            L6_5 = -4
            L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
            L3_5 = UDim2
            L3_5 = L3_5.new
            L4_5 = 0
            L5_5 = 2
            L6_5 = 0
            L7_5 = 2
            L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
            L4_5 = "Out"
            L5_5 = "Quart"
            L6_5 = 0.1
            L7_5 = true
            L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5)
            L0_5 = L1_1
            L1_5 = L0_5
            L0_5 = L0_5.Create
            L2_5 = L27_4
            L3_5 = TweenInfo
            L3_5 = L3_5.new
            L4_5 = 0.1
            L3_5 = L3_5(L4_5)
            L4_5 = {}
            L5_5 = Color3
            L5_5 = L5_5.fromRGB
            L6_5 = 94
            L7_5 = 93
            L8_5 = 94
            L5_5 = L5_5(L6_5, L7_5, L8_5)
            L4_5.ImageColor3 = L5_5
            L0_5 = L0_5(L1_5, L2_5, L3_5, L4_5)
            L1_5 = L0_5
            L0_5 = L0_5.Play
            L0_5(L1_5)
          end
        end
        L0_5 = L4_4
        if L0_5 then
          repeat
            L0_5 = L16_4
            L1_5 = L0_5
            L0_5 = L0_5.TweenPosition
            L2_5 = UDim2
            L2_5 = L2_5.new
            L3_5 = 0
            L4_5 = 0
            L5_5 = L0_1
            L5_5 = L5_5.rainbowI
            L6_5 = 0
            L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
            L3_5 = "Out"
            L4_5 = "Quart"
            L5_5 = 0.1
            L6_5 = true
            L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
            L0_5 = L14_4
            L1_5 = L0_1
            L1_5 = L1_5.rainbowVal
            L0_5.BackgroundColor3 = L1_5
            L0_5 = L7_4
            L1_5 = Color3
            L1_5 = L1_5.fromHSV
            L2_5 = L0_1
            L2_5 = L2_5.rainbowI
            L2_5 = 1 - L2_5
            L3_5 = 1
            L4_5 = 1
            L1_5 = L1_5(L2_5, L3_5, L4_5)
            L0_5.ImageColor3 = L1_5
            L0_5 = pcall
            L1_5 = A3_4
            L2_5 = L0_1
            L2_5 = L2_5.rainbowVal
            L0_5(L1_5, L2_5)
            L0_5 = game
            L1_5 = L0_5
            L0_5 = L0_5.GetService
            L2_5 = "RunService"
            L0_5 = L0_5(L1_5, L2_5)
            L0_5 = L0_5.Heartbeat
            L1_5 = L0_5
            L0_5 = L0_5.Wait
            L0_5(L1_5)
            L0_5 = L4_4
          until not L0_5
        end
        return
      end
      
      L44_4(L45_4, L46_4)
      return
    end
    
    L8_3.ColorPicker = L11_3
    
    function L11_3(A0_4, A1_4, A2_4, A3_4)
      local L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4, L26_4, L27_4, L28_4, L29_4, L30_4, L31_4, L32_4, L33_4, L34_4, L35_4, L36_4, L37_4, L38_4, L39_4, L40_4, L41_4, L42_4, L43_4, L44_4, L45_4, L46_4, L47_4, L48_4, L49_4, L50_4, L51_4, L52_4, L53_4, L54_4, L55_4, L56_4, L57_4, L58_4, L59_4, L60_4, L61_4, L62_4, L63_4, L64_4, L65_4, L66_4, L67_4, L68_4, L69_4, L70_4, L71_4, L72_4, L73_4, L74_4, L75_4, L76_4, L77_4, L78_4, L79_4, L80_4, L81_4, L82_4, L83_4, L84_4, L85_4, L86_4, L87_4, L88_4, L89_4, L90_4, L91_4, L92_4, L93_4, L94_4, L95_4, L96_4, L97_4, L98_4, L99_4, L100_4, L101_4, L102_4, L103_4, L104_4, L105_4, L106_4, L107_4, L108_4, L109_4, L110_4, L111_4, L112_4, L113_4, L114_4, L115_4, L116_4, L117_4, L118_4, L119_4, L120_4, L121_4, L122_4, L123_4, L124_4, L125_4, L126_4, L127_4, L128_4, L129_4, L130_4, L131_4, L132_4, L133_4, L134_4, L135_4, L136_4, L137_4, L138_4, L139_4, L140_4, L141_4, L142_4, L143_4, L144_4, L145_4, L146_4, L147_4, L148_4, L149_4, L150_4, L151_4, L152_4, L153_4, L154_4, L155_4, L156_4, L157_4, L158_4, L159_4, L160_4, L161_4, L162_4, L163_4, L164_4, L165_4, L166_4, L167_4, L168_4, L169_4, L170_4, L171_4, L172_4, L173_4, L174_4, L175_4, L176_4, L177_4, L178_4, L179_4, L180_4, L181_4, L182_4, L183_4, L184_4, L185_4, L186_4, L187_4, L188_4, L189_4, L190_4, L191_4, L192_4, L193_4, L194_4, L195_4, L196_4, L197_4, L198_4, L199_4, L200_4, L201_4, L202_4, L203_4, L204_4, L205_4, L206_4, L207_4, L208_4, L209_4, L210_4, L211_4, L212_4, L213_4, L214_4, L215_4, L216_4, L217_4, L218_4, L219_4, L220_4, L221_4, L222_4, L223_4, L224_4, L225_4, L226_4, L227_4, L228_4, L229_4, L230_4, L231_4, L232_4, L233_4, L234_4, L235_4, L236_4, L237_4, L238_4, L239_4, L240_4, L241_4, L242_4, L243_4, L244_4, L245_4, L246_4, L247_4, L248_4, L249_4, L250_4, L251_4, L252_4, L253_4, L254_4
      L4_4 = typeof
      L5_4 = A3_4
      L4_4 = L4_4(L5_4)
      if L4_4 ~= "function" or not A3_4 then
        function A3_4()
          local L0_5, L1_5
          
          return
        end
      end
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "ImageLabel"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "TextLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "ImageButton"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "TextBox"
      L7_4 = L7_4(L8_4)
      L4_4.Name = "Box"
      L8_4 = L5_3
      L4_4.Parent = L8_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L4_4.BackgroundColor3 = L8_4
      L4_4.BackgroundTransparency = 1
      L4_4.ClipsDescendants = false
      L4_4.LayoutOrder = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = 0
      L11_4 = 0
      L12_4 = 33
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L4_4.Size = L8_4
      L4_4.Image = "rbxassetid://4641600283"
      L8_4 = _G
      L8_4 = L8_4.TertiaryColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 38
        L10_4 = 38
        L11_4 = 38
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L4_4.ImageColor3 = L8_4
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Slice
      L4_4.ScaleType = L8_4
      L8_4 = Rect
      L8_4 = L8_4.new
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L4_4.SliceCenter = L8_4
      L4_4.SliceScale = 0.05
      L5_4.Name = "Title"
      L5_4.Parent = L4_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L5_4.BackgroundColor3 = L8_4
      L5_4.BackgroundTransparency = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 7
      L11_4 = 0
      L12_4 = 2
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L5_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 100
      L11_4 = 0
      L12_4 = 30
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L5_4.Size = L8_4
      L8_4 = Enum
      L8_4 = L8_4.Font
      L8_4 = L8_4.SourceSansSemibold
      L5_4.Font = L8_4
      L5_4.Text = A1_4
      L8_4 = _G
      L8_4 = L8_4.ButtonTextColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 170
        L10_4 = 170
        L11_4 = 170
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L5_4.TextColor3 = L8_4
      L5_4.TextSize = 20
      L5_4.TextWrapped = true
      L8_4 = Enum
      L8_4 = L8_4.TextXAlignment
      L8_4 = L8_4.Left
      L5_4.TextXAlignment = L8_4
      L8_4 = string
      L8_4 = L8_4.len
      L9_4 = A1_4
      L8_4 = L8_4(L9_4)
      if 7 < L8_4 then
        L8_4 = true
        if L8_4 then
          goto lbl_129
        end
      end
      L8_4 = false
      ::lbl_129::
      L5_4.TextScaled = L8_4
      L6_4.Name = "Tick"
      L6_4.Parent = L4_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L6_4.BackgroundColor3 = L8_4
      L6_4.BackgroundTransparency = 1
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 0
      L10_4 = 0
      L11_4 = 0
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L6_4.BorderColor3 = L8_4
      L6_4.BorderSizePixel = 100
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = -50
      L11_4 = 0
      L12_4 = 7
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L6_4.Position = L8_4
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 0
      L10_4 = 45
      L11_4 = 0
      L12_4 = 21
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L6_4.Size = L8_4
      L6_4.Image = "rbxassetid://4608020054"
      L8_4 = _G
      L8_4 = L8_4.BindColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 50
        L10_4 = 50
        L11_4 = 50
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L6_4.ImageColor3 = L8_4
      L8_4 = Enum
      L8_4 = L8_4.ScaleType
      L8_4 = L8_4.Slice
      L6_4.ScaleType = L8_4
      L8_4 = Rect
      L8_4 = L8_4.new
      L9_4 = 128
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L6_4.SliceCenter = L8_4
      L6_4.SliceScale = 0.03
      L7_4.Name = "Value"
      L7_4.Parent = L6_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 255
      L10_4 = 255
      L11_4 = 255
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L7_4.BackgroundColor3 = L8_4
      L7_4.BackgroundTransparency = 1
      L8_4 = UDim2
      L8_4 = L8_4.new
      L9_4 = 1
      L10_4 = 0
      L11_4 = 1
      L12_4 = 0
      L8_4 = L8_4(L9_4, L10_4, L11_4, L12_4)
      L7_4.Size = L8_4
      L8_4 = Enum
      L8_4 = L8_4.Font
      L8_4 = L8_4.SourceSansBold
      L7_4.Font = L8_4
      L8_4 = Color3
      L8_4 = L8_4.fromRGB
      L9_4 = 178
      L10_4 = 178
      L11_4 = 178
      L8_4 = L8_4(L9_4, L10_4, L11_4)
      L7_4.PlaceholderColor3 = L8_4
      L7_4.Text = ""
      L8_4 = _G
      L8_4 = L8_4.TextColor
      if not L8_4 then
        L8_4 = Color3
        L8_4 = L8_4.fromRGB
        L9_4 = 216
        L10_4 = 216
        L11_4 = 216
        L8_4 = L8_4(L9_4, L10_4, L11_4)
      end
      L7_4.TextColor3 = L8_4
      L7_4.TextScaled = true
      L7_4.TextSize = 14
      L7_4.TextWrapped = true
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "ImageLabel"
      L8_4 = L8_4(L9_4)
      L8_4.Name = "Cap"
      L8_4.Parent = L4_4
      L9_4 = Color3
      L9_4 = L9_4.fromRGB
      L10_4 = 255
      L11_4 = 255
      L12_4 = 255
      L9_4 = L9_4(L10_4, L11_4, L12_4)
      L8_4.BackgroundColor3 = L9_4
      L8_4.BackgroundTransparency = 1
      L9_4 = UDim2
      L9_4 = L9_4.new
      L10_4 = 0
      L11_4 = 0
      L12_4 = 1
      L13_4 = -2
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.Position = L9_4
      L9_4 = UDim2
      L9_4 = L9_4.new
      L10_4 = 1
      L11_4 = 0
      L12_4 = 0
      L13_4 = 5
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.Size = L9_4
      L8_4.ZIndex = 3
      L8_4.Image = "rbxassetid://4695358235"
      L9_4 = _G
      L9_4 = L9_4.TertiaryColor
      if not L9_4 then
        L9_4 = Color3
        L9_4 = L9_4.fromRGB
        L10_4 = 38
        L11_4 = 38
        L12_4 = 38
        L9_4 = L9_4(L10_4, L11_4, L12_4)
      end
      L8_4.ImageColor3 = L9_4
      L9_4 = Enum
      L9_4 = L9_4.ScaleType
      L9_4 = L9_4.Slice
      L8_4.ScaleType = L9_4
      L9_4 = Rect
      L9_4 = L9_4.new
      L10_4 = 128
      L11_4 = 128
      L12_4 = 128
      L13_4 = 128
      L9_4 = L9_4(L10_4, L11_4, L12_4, L13_4)
      L8_4.SliceCenter = L9_4
      L8_4.SliceScale = 0.05
      L9_4 = L7_4.FocusLost
      L10_4 = L9_4
      L9_4 = L9_4.connect
      
      function L11_4(A0_5)
        local L1_5, L2_5, L3_5, L4_5
        L1_5 = A2_4
        if L1_5 == "number" then
          L1_5 = tonumber
          L2_5 = L7_4
          L2_5 = L2_5.Text
          L1_5 = L1_5(L2_5)
          L2_5 = pcall
          L3_5 = A3_4
          L4_5 = L1_5
          L2_5(L3_5, L4_5)
          L2_5 = L7_4
          L3_5 = tonumber
          L4_5 = L1_5
          L3_5 = L3_5(L4_5)
          L2_5.Text = L3_5
        else
          L1_5 = L7_4
          L2_5 = tostring
          L3_5 = L7_4
          L3_5 = L3_5.Text
          L2_5 = L2_5(L3_5)
          L1_5.Text = L2_5
        end
        L1_5 = pcall
        L2_5 = A3_4
        L3_5 = L7_4
        L3_5 = L3_5.Text
        L1_5(L2_5, L3_5)
        return
      end
      
      L9_4(L10_4, L11_4)
      if A2_4 == "number" then
        L10_4 = L7_4
        L9_4 = L7_4.GetPropertyChangedSignal
        L11_4 = "Text"
        L9_4 = L9_4(L10_4, L11_4)
        L10_4 = L9_4
        L9_4 = L9_4.connect
        
        function L11_4()
          local L0_5, L1_5, L2_5, L3_5, L4_5
          L0_5 = L7_4
          L1_5 = string
          L1_5 = L1_5.gsub
          L2_5 = L7_4
          L2_5 = L2_5.Text
          L3_5 = "[%a+]"
          L4_5 = ""
          L1_5 = L1_5(L2_5, L3_5, L4_5)
          L0_5.Text = L1_5
          return
        end
        
        L9_4(L10_4, L11_4)
      end
      return
    end
    
    L8_3.Box = L11_3
    
    function L11_3(A0_4, A1_4, A2_4)
      local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
      L3_4 = Instance
      L3_4 = L3_4.new
      L4_4 = "ImageLabel"
      L3_4 = L3_4(L4_4)
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "TextLabel"
      L4_4 = L4_4(L5_4)
      L3_4.Name = "Label"
      L5_4 = L5_3
      L3_4.Parent = L5_4
      L5_4 = Color3
      L5_4 = L5_4.fromRGB
      L6_4 = 255
      L7_4 = 255
      L8_4 = 255
      L5_4 = L5_4(L6_4, L7_4, L8_4)
      L3_4.BackgroundColor3 = L5_4
      L3_4.BackgroundTransparency = 1
      L3_4.ClipsDescendants = false
      L3_4.LayoutOrder = 1
      L5_4 = UDim2
      L5_4 = L5_4.new
      L6_4 = 1
      L7_4 = 0
      L8_4 = 0
      L9_4 = 32
      L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4)
      L3_4.Size = L5_4
      L3_4.Image = "rbxassetid://4641600283"
      L5_4 = A2_4.BgColor
      L3_4.ImageColor3 = L5_4
      L5_4 = Enum
      L5_4 = L5_4.ScaleType
      L5_4 = L5_4.Slice
      L3_4.ScaleType = L5_4
      L5_4 = Rect
      L5_4 = L5_4.new
      L6_4 = 128
      L7_4 = 128
      L8_4 = 128
      L9_4 = 128
      L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4)
      L3_4.SliceCenter = L5_4
      L3_4.SliceScale = 0.05
      L4_4.Name = "Title"
      L4_4.Parent = L3_4
      L5_4 = Color3
      L5_4 = L5_4.fromRGB
      L6_4 = 255
      L7_4 = 255
      L8_4 = 255
      L5_4 = L5_4(L6_4, L7_4, L8_4)
      L4_4.BackgroundColor3 = L5_4
      L4_4.BackgroundTransparency = 1
      L5_4 = UDim2
      L5_4 = L5_4.new
      L6_4 = 1
      L7_4 = 0
      L8_4 = 1
      L9_4 = 0
      L5_4 = L5_4(L6_4, L7_4, L8_4, L9_4)
      L4_4.Size = L5_4
      L5_4 = Enum
      L5_4 = L5_4.Font
      L5_4 = L5_4.SourceSansSemibold
      L4_4.Font = L5_4
      L4_4.Text = A1_4
      L5_4 = A2_4.TextColor
      L4_4.TextColor3 = L5_4
      L5_4 = A2_4.TextSize
      L4_4.TextSize = L5_4
      L4_4.TextWrapped = true
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "ImageLabel"
      L5_4 = L5_4(L6_4)
      L5_4.Name = "Cap"
      L5_4.Parent = L3_4
      L6_4 = Color3
      L6_4 = L6_4.fromRGB
      L7_4 = 255
      L8_4 = 255
      L9_4 = 255
      L6_4 = L6_4(L7_4, L8_4, L9_4)
      L5_4.BackgroundColor3 = L6_4
      L5_4.BackgroundTransparency = 1
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 0
      L8_4 = 0
      L9_4 = 1
      L10_4 = -2
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L5_4.Position = L6_4
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 1
      L8_4 = 0
      L9_4 = 0
      L10_4 = 5
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L5_4.Size = L6_4
      L5_4.ZIndex = 3
      L5_4.Image = "rbxassetid://4695358235"
      L6_4 = _G
      L6_4 = L6_4.TertiaryColor
      if not L6_4 then
        L6_4 = Color3
        L6_4 = L6_4.fromRGB
        L7_4 = 38
        L8_4 = 38
        L9_4 = 38
        L6_4 = L6_4(L7_4, L8_4, L9_4)
      end
      L5_4.ImageColor3 = L6_4
      L6_4 = Enum
      L6_4 = L6_4.ScaleType
      L6_4 = L6_4.Slice
      L5_4.ScaleType = L6_4
      L6_4 = Rect
      L6_4 = L6_4.new
      L7_4 = 128
      L8_4 = 128
      L9_4 = 128
      L10_4 = 128
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L5_4.SliceCenter = L6_4
      L5_4.SliceScale = 0.05
      
      function L6_4(A0_5, A1_5)
        local L2_5, L3_5
        L2_5 = L4_4
        L2_5.Text = A1_5
        return
      end
      
      L7_4 = {}
      L7_4.Refresh = L6_4
      do return L7_4 end
      return
    end
    
    L8_3.Label = L11_3
    
    function L11_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4
      L1_4 = L8_3
      L2_4 = L1_4
      L1_4 = L1_4.Button
      L3_4 = "DestroyGui"
      
      function L4_4()
        local L0_5, L1_5
        L0_5 = L5_1
        L1_5 = L0_5
        L0_5 = L0_5.Destroy
        L0_5(L1_5)
        return
      end
      
      L1_4(L2_4, L3_4, L4_4)
      return
    end
    
    L8_3.DestroyGui = L11_3
    do return L8_3 end
    return
  end
  
  L10_2.CreateFolder = L11_2
  L11_2 = L2_2.new
  L12_2 = L3_2
  L11_2(L12_2)
  do return L10_2 end
  return
end

L0_1.CreateWindow = L7_1
do return L0_1 end
return
