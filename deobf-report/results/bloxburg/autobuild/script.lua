local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1
L0_1 = false
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "RunService"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = L1_1
L1_1 = L1_1.IsStudio
L1_1 = L1_1(L2_1)
if L1_1 then
  L1_1 = {}
  genv_table = L1_1
  
  function L1_1()
    local L0_2
    L0_2 = genv_table
  end
  
  getgenv = L1_1
  L1_1 = true
  PROTOSMASHER_LOADED = L1_1
  
  function L1_1(...)
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L1_2 = print
    L2_2 = "Writing: "
    L3_2, L4_2 = ...
    L1_2(L2_2, L3_2, L4_2)
  end
  
  writefile = L1_1
  
  function L1_1(A0_2)
    local L1_2, L2_2
    L1_2 = error
    L2_2 = "impossible to read file"
    L1_2(L2_2)
  end
  
  readfile = L1_1
  
  function L1_1()
    local L0_2, L1_2, L2_2
    L0_2 = getmetatable
    L1_2 = newproxy
    L2_2 = true
    L1_2, L2_2 = L1_2(L2_2)
  end
  
  getrawmetatable = L1_1
  
  function L1_1()
    local L0_2
    L0_2 = "nil"
  end
  
  get_namecall_method = L1_1
  
  function L1_1()
    local L0_2
  end
  
  make_writeable = L1_1
  
  function L1_1(A0_2)
  end
  
  protect_function = L1_1
  
  function L1_1(A0_2, A1_2)
    local L2_2
  end
  
  setreadonly = L1_1
  
  function L1_1(A0_2)
    local L1_2
    L1_2 = false
  end
  
  is_readonly = L1_1
  
  function L1_1(A0_2)
    local L1_2
  end
  
  make_readonly = L1_1
  
  function L1_1(A0_2, A1_2)
  end
  
  set_simulation_radius = L1_1
  
  function L1_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = A0_2.Headers
    if L1_2 ~= nil then
      L1_2 = A0_2.Headers
      L1_2["proto-user-identifier"] = "Roblox Studio Test"
    else
      L1_2 = {}
      L1_2["proto-user-identifier"] = "Roblox Studio Test"
      A0_2.Headers = L1_2
    end
    L1_2 = game
    L1_2 = L1_2.ReplicatedStorage
    L1_2 = L1_2.serverside_http_handler
    L2_2 = L1_2
    L1_2 = L1_2.InvokeServer
    L3_2 = A0_2
  end
  
  http_request = L1_1
  
  function L1_1()
    local L0_2
    L0_2 = {}
  end
  
  getgc = L1_1
  
  function L1_1(...)
    local L0_2, L1_2, L2_2
    L1_2, L2_2 = ...
  end
  
  detour_function = L1_1
  L1_1 = detour_function
  hookfunction = L1_1
  
  function L1_1()
    local L0_2
  end
  
  unlock_modulescript = L1_1
  
  function L1_1(...)
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L1_2 = warn
    L2_2 = "Clipboard Set: "
    L3_2, L4_2 = ...
    L1_2(L2_2, L3_2, L4_2)
  end
  
  setclipboard = L1_1
  
  function L1_1()
    local L0_2, L1_2
    L1_2 = true
  end
  
  is_l_closure = L1_1
  
  function L1_1()
    local L0_2, L1_2
    L1_2 = false
  end
  
  is_protosmasher_closure = L1_1
  
  function L1_1()
    local L0_2, L1_2
    L0_2 = {}
    L1_2 = getfenv
    L1_2 = L1_2()
    L0_2[1] = L1_2
  end
  
  getrenv = L1_1
  L1_1 = {}
  
  function L2_1()
    local L0_2, L1_2
    L1_2 = {}
  end
  
  L1_1.getupvalues = L2_1
  
  function L2_1()
    local L0_2, L1_2
    L1_2 = {}
  end
  
  L1_1.getconstants = L2_1
  debug = L1_1
end
L1_1 = PROTOSMASHER_LOADED
if not L1_1 then
  L1_1 = getgenv
  L1_1 = L1_1()
  L2_1 = islclosure
  L1_1.is_l_closure = L2_1
  L1_1 = syn
  if L1_1 then
    L1_1 = is_sirhurt_closure
    if not L1_1 then
      L1_1 = is_synapse_function
      is_protosmasher_closure = L1_1
  end
  else
    L1_1 = is_sirhurt_closure
    if L1_1 ~= nil then
      L1_1 = is_sirhurt_closure
      is_protosmasher_closure = L1_1
    else
      L1_1 = SENTINEL_LOADED
      if L1_1 then
        L1_1 = issentinelclosure
        is_protosmasher_closure = L1_1
      else
        L1_1 = KRNL_LOADED
        if L1_1 then
          function L1_1()
            local L0_2, L1_2
            
            L1_2 = false
          end
          
          is_protosmasher_closure = L1_1
        end
      end
    end
  end
end
L1_1 = getreg
if not L1_1 then
  L1_1 = debug
  L1_1 = L1_1.getregistry
end
L2_1 = getupvalues
if not L2_1 then
  L2_1 = debug
  L2_1 = L2_1.getupvalues
end
L3_1 = getfenv
if not L3_1 then
  L3_1 = debug
  L3_1 = L3_1.getfenv
end
L4_1 = nil
L5_1 = getrenv
if not L5_1 then
  L5_1 = debug
  L5_1 = L5_1.getrenv
end
L6_1 = hookfunc
if not L6_1 then
  L6_1 = hookfunction
end
L7_1 = nil
L8_1 = getgc
if not L8_1 then
  L8_1 = debug
  L8_1 = L8_1.getgc
end
L9_1 = getconstants
if not L9_1 then
  L9_1 = debug
  L9_1 = L9_1.getconstants
end

function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if A0_2 == nil then
    L1_2 = ".NIL"
    return L1_2
  end
  L1_2 = A0_2.Parent
  L2_2 = game
  L1_2 = L1_2 == L2_2
  if L1_2 then
    L2_2 = A0_2.ClassName
    if L2_2 then
      goto lbl_17
    end
  end
  L2_2 = A0_2.Name
  ::lbl_17::
  L3_2 = game
  if A0_2 ~= L3_2 then
    L3_2 = L10_1
    L4_2 = A0_2.Parent
    L3_2 = L3_2(L4_2)
    if L3_2 then
      goto lbl_26
    end
  end
  L3_2 = ""
  ::lbl_26::
  if L1_2 then
    L4_2 = ":GetService(\"%s\")"
    if L4_2 then
      goto lbl_52
    end
  end
  L4_2 = #L2_2
  if L4_2 ~= 0 then
    L5_2 = L2_2
    L4_2 = L2_2.match
    L6_2 = "[^%w]+"
    L4_2 = L4_2(L5_2, L6_2)
    if not L4_2 then
      L5_2 = L2_2
      L4_2 = L2_2.sub
      L6_2 = 1
      L7_2 = 1
      L4_2 = L4_2(L5_2, L6_2, L7_2)
      L5_2 = L4_2
      L4_2 = L4_2.match
      L6_2 = "[^%a]"
      L4_2 = L4_2(L5_2, L6_2)
      if not L4_2 then
        goto lbl_51
      end
    end
  end
  L4_2 = "[\"%s\"]"
  ::lbl_51::
  if not L4_2 then
    L4_2 = ".%s"
  end
  ::lbl_52::
  L5_2 = L4_2
  L4_2 = L4_2.format
  L6_2 = L2_2
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 .. L4_2
end

function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if not A2_2 then
    A2_2 = ""
  end
  L3_2 = next
  L4_2 = A0_2
  L5_2 = nil
  for L6_2, L7_2 in L3_2, L4_2, L5_2 do
    if A1_2 == L7_2 then
      L8_2 = A2_2
      L9_2 = L6_2
      L8_2 = L8_2 .. L9_2
      return L8_2
    end
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L8_2 == "table" then
      L8_2 = L11_1
      L9_2 = L7_2
      L10_2 = A1_2
      L11_2 = L6_2
      L12_2 = "."
      L11_2 = L11_2 .. L12_2
      L8_2 = L8_2(L9_2, L10_2, L11_2)
      if L8_2 ~= nil then
        L9_2 = A2_2
        L10_2 = L8_2
        L9_2 = L9_2 .. L10_2
        return L9_2
      end
    end
  end
end

L12_1 = getrenv
L12_1 = L12_1()

function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L2_2 = typeof
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = nil
  L4_2 = "    "
  L5_2 = A1_2 or L5_2
  if not A1_2 then
    L5_2 = 0
  end
  if L2_2 == "string" then
    L6_2 = "\"%s\""
    L7_2 = L6_2
    L6_2 = L6_2.format
    L8_2 = A0_2
    L6_2 = L6_2(L7_2, L8_2)
    L3_2 = L6_2
  elseif L2_2 == "Instance" then
    L6_2 = L10_1
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L7_2 = L6_2
    L6_2 = L6_2.sub
    L8_2 = 2
    L6_2 = L6_2(L7_2, L8_2)
    L3_2 = L6_2
  elseif L2_2 == "table" then
    L6_2 = ""
    L7_2 = 0
    L5_2 = L5_2 + 1
    L8_2 = next
    L9_2 = A0_2
    L10_2 = nil
    for L11_2, L12_2 in L8_2, L9_2, L10_2 do
      L7_2 = L7_2 + 1
      if L12_2 == A0_2 then
        L13_2 = "THIS_TABLE"
        if L13_2 then
          goto lbl_47
          L12_2 = L13_2 or L12_2
        end
      end
      L13_2 = L13_1
      L14_2 = L12_2
      L15_2 = L5_2
      L13_2 = L13_2(L14_2, L15_2)
      L12_2 = L13_2
      ::lbl_47::
      if 1 < L7_2 then
        L13_2 = ","
        if L13_2 then
          goto lbl_53
        end
      end
      L13_2 = ""
      ::lbl_53::
      L14_2 = "\n"
      L16_2 = L4_2
      L15_2 = L4_2.rep
      L17_2 = L5_2
      L15_2 = L15_2(L16_2, L17_2)
      L13_2 = L13_2 .. L14_2 .. L15_2
      if L7_2 ~= L11_2 then
        L14_2 = L6_2
        L15_2 = "%s[%s] = %s"
        L16_2 = L15_2
        L15_2 = L15_2.format
        L17_2 = L13_2
        if L11_2 ~= A0_2 then
          L18_2 = L13_1
          L19_2 = L11_2
          L20_2 = L5_2
          L18_2 = L18_2(L19_2, L20_2)
          if L18_2 then
            goto lbl_73
          end
        end
        L18_2 = "THIS_TABLE"
        ::lbl_73::
        L19_2 = L12_2
        L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
        L6_2 = L14_2 .. L15_2
      else
        L14_2 = L6_2
        L15_2 = "%s%s"
        L16_2 = L15_2
        L15_2 = L15_2.format
        L17_2 = L13_2
        L18_2 = L12_2
        L15_2 = L15_2(L16_2, L17_2, L18_2)
        L6_2 = L14_2 .. L15_2
      end
    end
    L5_2 = L5_2 - 1
    L8_2 = "{%s}"
    L9_2 = L8_2
    L8_2 = L8_2.format
    L10_2 = L6_2
    L11_2 = #L6_2
    if 0 < L11_2 then
      L11_2 = "\n"
      L13_2 = L4_2
      L12_2 = L4_2.rep
      L14_2 = L5_2
      L12_2 = L12_2(L13_2, L14_2)
      L11_2 = L11_2 .. L12_2
      if L11_2 then
        goto lbl_101
      end
    end
    L11_2 = ""
    ::lbl_101::
    L10_2 = L10_2 .. L11_2
    L8_2 = L8_2(L9_2, L10_2)
    L3_2 = L8_2
  elseif L2_2 == "CFrame" or L2_2 == "Vector3" or L2_2 == "Vector2" or L2_2 == "UDim2" or L2_2 == "Color3" or L2_2 == "Vector3int16" or L2_2 == "UDim" or L2_2 == "Vector2int16" then
    L6_2 = "%s.new(%s)"
    L7_2 = L6_2
    L6_2 = L6_2.format
    L8_2 = L2_2
    L9_2 = tostring
    L10_2 = A0_2
    L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L9_2(L10_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    L3_2 = L6_2
  elseif L2_2 == "userdata" then
    L6_2 = nil
    L7_2 = getrawmetatable
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = L7_2 or L8_2
    if L7_2 then
      L8_2 = rawget
      L9_2 = L7_2
      L10_2 = "__tostring"
      L8_2 = L8_2(L9_2, L10_2)
    end
    if L8_2 then
      L9_2 = make_writeable
      L10_2 = L7_2
      L9_2(L10_2)
      L7_2.__tostring = nil
      L9_2 = tostring
      L10_2 = A0_2
      L9_2 = L9_2(L10_2)
      L3_2 = L9_2
      L9_2 = rawset
      L10_2 = L7_2
      L11_2 = "__tostring"
      L12_2 = L8_2
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = rawget
      L10_2 = L7_2
      L11_2 = "__metatable"
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 ~= nil then
        L9_2 = make_readonly
        L10_2 = L7_2
        L9_2(L10_2)
      end
    else
      L9_2 = tostring
      L10_2 = A0_2
      L9_2 = L9_2(L10_2)
      L3_2 = L9_2
    end
  else
    L6_2 = tostring
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L3_2 = L6_2
  end
end

L14_1 = nil
L15_1 = pairs
L16_1 = L8_1
L17_1 = true
L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1 = L16_1(L17_1)
L15_1, L16_1, L17_1 = L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1)
for L18_1, L19_1 in L15_1, L16_1, L17_1 do
  L20_1 = type
  L21_1 = L19_1
  L20_1 = L20_1(L21_1)
  if L20_1 == "table" then
    L20_1 = rawget
    L21_1 = L19_1
    L22_1 = "Shared"
    L20_1 = L20_1(L21_1, L22_1)
    if L20_1 then
      L20_1 = rawget
      L21_1 = L19_1
      L22_1 = "net"
      L20_1 = L20_1(L21_1, L22_1)
      if L20_1 then
        L4_1 = L19_1
      end
    end
  else
    L20_1 = type
    L21_1 = L19_1
    L20_1 = L20_1(L21_1)
    if L20_1 == "function" then
      L20_1 = getfenv
      L21_1 = L19_1
      L20_1 = L20_1(L21_1)
      L20_1 = L20_1.script
      L21_1 = game
      L22_1 = L21_1
      L21_1 = L21_1.GetService
      L23_1 = "ReplicatedStorage"
      L21_1 = L21_1(L22_1, L23_1)
      L21_1 = L21_1.Modules
      L21_1 = L21_1.DataManager
      if L20_1 == L21_1 then
        L20_1 = L9_1
        L21_1 = L19_1
        L20_1 = L20_1(L21_1)
        L21_1 = table
        L21_1 = L21_1.find
        L22_1 = L20_1
        L23_1 = "RemoteFunction"
        L21_1 = L21_1(L22_1, L23_1)
        if L21_1 then
          L21_1 = table
          L21_1 = L21_1.find
          L22_1 = L20_1
          L23_1 = "RemoteEvent"
          L21_1 = L21_1(L22_1, L23_1)
          if L21_1 then
            L14_1 = L19_1
          end
        end
      end
    end
  end
end
L15_1 = getconnections
if not L15_1 then
  L15_1 = get_signal_cons
end
if L15_1 then
  L16_1 = PROTOSMASHER_LOADED
  if not L16_1 then
    L16_1 = pairs
    L17_1 = L15_1
    L18_1 = game
    L19_1 = L18_1
    L18_1 = L18_1.GetService
    L20_1 = "ScriptContext"
    L18_1 = L18_1(L19_1, L20_1)
    L18_1 = L18_1.Error
    L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1 = L17_1(L18_1)
    L16_1, L17_1, L18_1 = L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1)
    for L19_1, L20_1 in L16_1, L17_1, L18_1 do
      L21_1 = type
      L22_1 = L20_1
      L21_1 = L21_1(L22_1)
      if L21_1 == "table" then
        L22_1 = L20_1
        L21_1 = L20_1.Disable
        L21_1(L22_1)
      else
        L21_1 = type
        L22_1 = L20_1.Disconnect
        L21_1 = L21_1(L22_1)
        if L21_1 == "function" then
          L22_1 = L20_1
          L21_1 = L20_1.Disconnect
          L21_1(L22_1)
        end
      end
    end
end
else
  L16_1 = warn
  L17_1 = "No getconnections found! Bloxburg logging may ban you!"
  L16_1(L17_1)
end
L16_1 = L4_1.Modules
L16_1 = L16_1.GUIHandler
L17_1 = L4_1.Modules
L17_1 = L17_1.JobManager
L18_1 = L4_1.Modules
L18_1 = L18_1.NotificationHandler
L19_1 = game
L20_1 = L19_1
L19_1 = L19_1.GetService
L21_1 = "Players"
L19_1 = L19_1(L20_1, L21_1)
L19_1 = L19_1.LocalPlayer
L19_1 = L19_1.PlayerGui
L19_1 = L19_1.MainGUI
L19_1 = L19_1.VersionLabel
L19_1 = L19_1.Text
L20_1 = game
L20_1 = L20_1.Players
L20_1 = L20_1.LocalPlayer
L20_1 = L20_1.PlayerGui
L20_1 = L20_1.MainGUI
L20_1 = L20_1.Scripts
L20_1 = L20_1.JobManager
L21_1 = rconsoleprint
if not L21_1 then
  L21_1 = print
end
L22_1 = {}

function L23_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L0_1
  if L2_2 then
    L2_2 = pcall
    L3_2 = L13_1
    L4_2 = A1_2
    L2_2, L3_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L4_2 = warn
      L5_2 = "Dump Error:"
      L6_2 = L3_2
      L4_2(L5_2, L6_2)
    end
    L4_2 = L21_1
    L5_2 = "[Chroma-Script]: RemoteEvent Fired\n"
    L6_2 = L3_2
    L7_2 = "\n"
    L5_2 = L5_2 .. L6_2 .. L7_2
    L4_2(L5_2)
  end
  L2_2 = L14_1
  L3_2 = A1_2.Type
  L2_2 = L2_2(L3_2)
  if L2_2 then
    A1_2.Type = nil
    L4_2 = L2_2
    L3_2 = L2_2.FireServer
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  else
    L3_2 = error
    L4_2 = "[Chroma-API / ERROR]: \""
    L5_2 = A1_2.Type
    L6_2 = "\" RemoteEvent Does Not Exist!"
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
  end
end

L22_1.FireServer = L23_1

function L23_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L0_1
  if L2_2 then
    L2_2 = pcall
    L3_2 = L13_1
    L4_2 = A1_2
    L2_2, L3_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L4_2 = warn
      L5_2 = "Dump Error:"
      L6_2 = L3_2
      L4_2(L5_2, L6_2)
    end
    L4_2 = L21_1
    L5_2 = "[Chroma-Script]: RemoteFunction Called\n"
    L6_2 = L3_2
    L7_2 = "\n"
    L5_2 = L5_2 .. L6_2 .. L7_2
    L4_2(L5_2)
  end
  L2_2 = L14_1
  L3_2 = A1_2.Type
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    A1_2.Type = nil
    L4_2 = L2_2
    L3_2 = L2_2.InvokeServer
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    return L3_2
  end
  L3_2 = error
  L4_2 = "[Chroma-API / ERROR]: \""
  L5_2 = A1_2.Type
  L6_2 = "\" RemoteFunction Does Not Exist!"
  L4_2 = L4_2 .. L5_2 .. L6_2
  L3_2(L4_2)
end

L22_1.InvokeServer = L23_1
L23_1 = L22_1
L24_1 = game
L25_1 = L24_1
L24_1 = L24_1.GetService
L26_1 = "VirtualUser"
L24_1 = L24_1(L25_1, L26_1)
L25_1 = game
L26_1 = L25_1
L25_1 = L25_1.GetService
L27_1 = "Players"
L25_1 = L25_1(L26_1, L27_1)
L25_1 = L25_1.LocalPlayer
L25_1 = L25_1.Idled
L26_1 = L25_1
L25_1 = L25_1.connect

function L27_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = L24_1
  L1_2 = L0_2
  L0_2 = L0_2.Button2Down
  L2_2 = Vector2
  L2_2 = L2_2.new
  L3_2 = 0
  L4_2 = 0
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = workspace
  L3_2 = L3_2.CurrentCamera
  L3_2 = L3_2.CFrame
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = wait
  L1_2 = 1
  L0_2(L1_2)
  L0_2 = L24_1
  L1_2 = L0_2
  L0_2 = L0_2.Button2Up
  L2_2 = Vector2
  L2_2 = L2_2.new
  L3_2 = 0
  L4_2 = 0
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = workspace
  L3_2 = L3_2.CurrentCamera
  L3_2 = L3_2.CFrame
  L0_2(L1_2, L2_2, L3_2)
end

L25_1(L26_1, L27_1)
L25_1 = getgenv
L25_1 = L25_1()
L25_1 = L25_1.jobend_hooked
if L25_1 ~= true then
  L25_1 = getgenv
  L25_1 = L25_1()
  L25_1.jobend_hooked = true
  L25_1 = pairs
  L27_1 = L20_1
  L26_1 = L20_1.GetChildren
  L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1 = L26_1(L27_1)
  L25_1, L26_1, L27_1 = L25_1(L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1)
  for L28_1, L29_1 in L25_1, L26_1, L27_1 do
    L31_1 = L29_1
    L30_1 = L29_1.IsA
    L32_1 = "ModuleScript"
    L30_1 = L30_1(L31_1, L32_1)
    if L30_1 then
      L30_1 = require
      L31_1 = L29_1
      L30_1 = L30_1(L31_1)
      L30_1 = L30_1.EndShift
      L31_1 = require
      L32_1 = L29_1
      L31_1 = L31_1(L32_1)
      
      function L32_1(...)
        local L0_2, L1_2, L2_2, L3_2
        L1_2 = getgenv
        L1_2 = L1_2()
        L1_2 = L1_2.autofarming
        if L1_2 == true then
          L1_2 = print
          L2_2 = "[Chroma-API / INFO]: EndShift Blocked!"
          L1_2(L2_2)
          L1_2 = wait
          L2_2 = 9000000000
          L1_2(L2_2)
          return
        end
        L1_2 = L30_1
        L2_2, L3_2 = ...
      end
      
      L31_1.EndShift = L32_1
      L31_1 = print
      L32_1 = "[Chroma-API / INFO]: Hooked EndShift for "
      L33_1 = L29_1.Name
      L31_1(L32_1, L33_1)
    end
  end
end
L25_1 = getgenv
L25_1 = L25_1()
L25_1 = L25_1.autofarm_namecall_hooked
if not L25_1 then
  L25_1 = getgenv
  L25_1 = L25_1()
  L25_1.autofarm_namecall_hooked = true
  L25_1 = loadstring
  L26_1 = "\r\n\t\tlocal mt = getrawmetatable(game)\r\n\t\tlocal oldNamecall = mt.__namecall \r\n\t\tsetreadonly(mt, false)\r\n\t\tlocal protect = protect_function or newcclosure\r\n\t\t\r\n\t\tmt.__namecall = protect(function(self, ...)\r\n\t\t\tlocal args = {...} \r\n\r\n\t\t\tif getnamecallmethod() == \"FireServer\" and args[1].Order and args[1].Workstation then\r\n\t\t\t\tif args[1].Workstation.Parent.Name == \"HairdresserWorkstations\" and getgenv().autofarming == true then\r\n\r\n\t\t\t\t\targs[1].Order = {\r\n\t\t\t\t\t\targs[1].Workstation.Occupied.Value.Order.Style.Value,\r\n\t\t\t\t\t\targs[1].Workstation.Occupied.Value.Order.Color.Value\r\n\t\t\t\t\t}\r\n\r\n\t\t\t\t\treturn oldNamecall(self, unpack(args))\r\n\r\n\t\t\t\telseif args[1].Workstation.Parent.Name == \"CashierWorkstations\" and getgenv().autofarming == true then \r\n\r\n\t\t\t\t\targs[1].Order = {\r\n\t\t\t\t\t\targs[1].Workstation.Occupied.Value.Order.Burger.Value,\r\n\t\t\t\t\t\targs[1].Workstation.Occupied.Value.Order.Fries.Value,\r\n\t\t\t\t\t\targs[1].Workstation.Occupied.Value.Order.Cola.Value\r\n\t\t\t\t\t}\r\n\r\n\t\t\t\t\treturn oldNamecall(self, unpack(args))\r\n\r\n\t\t\t\telseif args[1].Workstation.Parent.Name == \"BakerWorkstations\" and getgenv().autofarming == true then \r\n\r\n\t\t\t\t\targs[1].Order = {\r\n\t\t\t\t\t\ttrue, \r\n\t\t\t\t\t\ttrue, \r\n\t\t\t\t\t\ttrue, \r\n\t\t\t\t\t\targs[1].Workstation.Order.Value\r\n\t\t\t\t\t}\r\n\r\n\t\t\t\t\treturn oldNamecall(self, unpack(args))\r\n\r\n\t\t\t\tend\r\n\t\t\tend\r\n\r\n\t\t\treturn oldNamecall(self, ...)\r\n\t\tend)\r\n\r\n\t\tsetreadonly(mt, true)\r\n\t\tprint(\"[Chroma-API / DEBUG]: Namecall Hooked\")\r\n\t"
  L25_1 = L25_1(L26_1)
  L25_1()
end
L25_1 = {}

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L2_2 = pcall
  L3_2 = http_request
  L4_2 = {}
  L4_2.Url = "https://api.applebee1558.com/lumbsmasher/server_message"
  L4_2.Method = "GET"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.http_request
    L4_2 = {}
    L4_2.Url = "https://api.applebee1558.com/lumbsmasher/server_message"
    L4_2.Method = "GET"
    L2_2 = L2_2(L3_2, L4_2)
    L2_2 = L2_2.Body
    return L2_2
  end
  L2_2 = "Server Error"
end

L25_1.get_server_message = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = getgenv
  L1_2 = L1_2()
  L1_2 = L1_2.whitelistkey
  if L1_2 == nil then
    L2_2 = "Un-Whitelisted User!"
    return L2_2
  end
  L2_2 = pcall
  L3_2 = http_request
  L4_2 = {}
  L5_2 = "https://lumbsmasherapi.applebee1558.com/discordtag/"
  L6_2 = L1_2
  L5_2 = L5_2 .. L6_2
  L4_2.Url = L5_2
  L4_2.Method = "GET"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.http_request
    L4_2 = {}
    L5_2 = "https://lumbsmasherapi.applebee1558.com/discordtag/"
    L6_2 = L1_2
    L5_2 = L5_2 .. L6_2
    L4_2.Url = L5_2
    L4_2.Method = "GET"
    L2_2 = L2_2(L3_2, L4_2)
    L2_2 = L2_2.Body
    return L2_2
  end
  L2_2 = A0_2.localplayer
  L2_2 = L2_2.Name
end

L25_1.get_discord_tag = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = getgenv
  L1_2 = L1_2()
  L1_2 = L1_2.whitelistkey
  if L1_2 == nil then
    L2_2 = "Role: Un-Whitelisted User"
    return L2_2
  end
  L2_2 = pcall
  L3_2 = http_request
  L4_2 = {}
  L5_2 = "https://api.applebee1558.com/lumbsmasher/role/"
  L6_2 = L1_2
  L5_2 = L5_2 .. L6_2
  L4_2.Url = L5_2
  L4_2.Method = "GET"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.http_request
    L4_2 = {}
    L5_2 = "https://api.applebee1558.com/lumbsmasher/role/"
    L6_2 = L1_2
    L5_2 = L5_2 .. L6_2
    L4_2.Url = L5_2
    L4_2.Method = "GET"
    L2_2 = L2_2(L3_2, L4_2)
    L2_2 = L2_2.Body
    return L2_2
  end
  L2_2 = "Role: Server Error!"
end

L25_1.get_role = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = getgenv
  L1_2 = L1_2()
  L1_2 = L1_2.script_version
  if L1_2 == nil then
    L2_2 = _G
    L1_2 = L2_2.version
  end
  if L1_2 == nil then
    L1_2 = "TEST"
  end
  L2_2 = "Chroma Bloxburg <font size=\"15\">v"
  L3_2 = L1_2
  L4_2 = "</font>"
  L2_2 = L2_2 .. L3_2 .. L4_2
end

L25_1.get_title = L26_1

function L26_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  if A2_2 == nil then
    A2_2 = "Chroma - Notification"
  end
  if A3_2 == nil then
    A3_2 = "rbxassetid://7798014288"
  end
  L4_2 = L18_1
  L5_2 = L4_2
  L4_2 = L4_2.CreateNotification
  L6_2 = A2_2
  L7_2 = A3_2
  L8_2 = A1_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
end

L25_1.notify = L26_1
L26_1 = {}
L25_1.job_tp_queue = L26_1
L26_1 = {}
L25_1.plot_tp_queue = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = A0_2.queue_running
  if L1_2 then
    return
  end
  A0_2.queue_running = true
  while true do
    L1_2 = A0_2.queue_running
    if not L1_2 then
      break
    end
    L1_2 = wait
    L1_2()
    L1_2 = A0_2.job_tp_queue
    L1_2 = L1_2[1]
    if L1_2 then
      L1_2 = L4_1
      L1_2 = L1_2.Modules
      L1_2 = L1_2.LoadingHandler
      L2_2 = L1_2
      L1_2 = L1_2.ShowLoading
      L3_2 = "ToWork"
      L1_2(L2_2, L3_2)
      L1_2 = L22_1
      L2_2 = L1_2
      L1_2 = L1_2.InvokeServer
      L3_2 = {}
      L3_2.Type = "ToWork"
      L4_2 = A0_2.job_tp_queue
      L4_2 = L4_2[1]
      L3_2.Name = L4_2
      L1_2, L2_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L3_2 = L4_1
        L3_2 = L3_2.Modules
        L3_2 = L3_2.CharacterHandler
        L4_2 = L3_2
        L3_2 = L3_2.GetRoot
        L3_2 = L3_2(L4_2)
        L4_2 = L4_1
        L4_2 = L4_2.Modules
        L4_2 = L4_2.CharacterHandler
        L5_2 = L4_2
        L4_2 = L4_2.Detach
        L4_2(L5_2)
        L3_2.Anchored = true
        L3_2.CFrame = L1_2
        L4_2 = wait
        L5_2 = L2_2
        L4_2(L5_2)
        L3_2.Anchored = false
      end
      L3_2 = L4_1
      L3_2 = L3_2.Modules
      L3_2 = L3_2.LoadingHandler
      L4_2 = L3_2
      L3_2 = L3_2.HideLoading
      L5_2 = "ToWork"
      L3_2(L4_2, L5_2)
      A0_2.is_job_teleporting = false
      L3_2 = table
      L3_2 = L3_2.remove
      L4_2 = A0_2.job_tp_queue
      L5_2 = 1
      L3_2(L4_2, L5_2)
    end
    L1_2 = A0_2.plot_tp_queue
    L1_2 = L1_2[1]
    if L1_2 then
      L1_2 = L4_1
      L1_2 = L1_2.Modules
      L1_2 = L1_2.ClientStats
      L2_2 = L1_2
      L1_2 = L1_2.Get
      L3_2 = "IsPlaying"
      L1_2 = L1_2(L2_2, L3_2)
      if not L1_2 then
        return
      end
      L1_2 = L4_1
      L1_2 = L1_2.Modules
      L1_2 = L1_2.BuildInterface
      L2_2 = L1_2
      L1_2 = L1_2.InBuildMode
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = L4_1
        L1_2 = L1_2.task
        L1_2 = L1_2.run
        
        function L2_2()
          local L0_3, L1_3
          L0_3 = L4_1
          L0_3 = L0_3.Modules
          L0_3 = L0_3.BuildInterface
          L1_3 = L0_3
          L0_3 = L0_3.Exit
          L0_3(L1_3)
        end
        
        L1_2(L2_2)
      end
      L1_2 = L4_1
      L1_2 = L1_2.Modules
      L1_2 = L1_2.LoadingHandler
      L2_2 = L1_2
      L1_2 = L1_2.ShowLoading
      L3_2 = "ToPlot"
      L1_2(L2_2, L3_2)
      L1_2 = A0_2.plot_tp_queue
      L1_2 = L1_2[1]
      L2_2 = L22_1
      L3_2 = L2_2
      L2_2 = L2_2.InvokeServer
      L4_2 = {}
      L4_2.Type = "ToPlot"
      L4_2.Player = L1_2
      L2_2, L3_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        L4_2 = L4_1
        L4_2 = L4_2.Modules
        L4_2 = L4_2.CharacterHandler
        L5_2 = L4_2
        L4_2 = L4_2.GetRoot
        L4_2 = L4_2(L5_2)
        L5_2 = L4_1
        L5_2 = L5_2.Modules
        L5_2 = L5_2.CharacterHandler
        L6_2 = L5_2
        L5_2 = L5_2.Detach
        L5_2(L6_2)
        L4_2.Anchored = true
        L4_2.CFrame = L2_2
        L5_2 = wait
        L6_2 = L3_2
        L5_2(L6_2)
        L4_2.Anchored = false
      end
      L4_2 = L4_1
      L4_2 = L4_2.Modules
      L4_2 = L4_2.LoadingHandler
      L5_2 = L4_2
      L4_2 = L4_2.HideLoading
      L6_2 = "ToPlot"
      L4_2(L5_2, L6_2)
      A0_2.is_plot_teleporting = false
      L4_2 = table
      L4_2 = L4_2.remove
      L5_2 = A0_2.plot_tp_queue
      L6_2 = 1
      L4_2(L5_2, L6_2)
    end
  end
end

L25_1.run_queue = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  if A1_2 then
    L2_2 = game
    L2_2 = L2_2.Players
    L2_2 = L2_2.LocalPlayer
    L2_2 = L2_2.Character
    L2_2 = L2_2.NameGUI
    L3_2 = L2_2
    L2_2 = L2_2.Destroy
    L2_2(L3_2)
    L2_2 = wait
    L2_2()
  else
    A0_2.is_plot_teleporting = true
    L2_2 = table
    L2_2 = L2_2.insert
    L3_2 = A0_2.plot_tp_queue
    L4_2 = game
    L4_2 = L4_2.Players
    L4_2 = L4_2.LocalPlayer
    L2_2(L3_2, L4_2)
  end
end

L25_1.teleport_to_plot = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = table
  L2_2 = L2_2.insert
  L3_2 = A0_2.plot_tp_queue
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end

L25_1.teleport_player_plot = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  A0_2.is_job_teleporting = true
  L2_2 = table
  L2_2 = L2_2.insert
  L3_2 = A0_2.job_tp_queue
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end

L25_1.teleport_job = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = game
  L2_2 = L2_2.Players
  L2_2 = L2_2.LocalPlayer
  L3_2 = L2_2.Character
  L3_2 = L3_2.Humanoid
  L3_2 = L3_2.WalkSpeed
  L4_2 = game
  L4_2 = L4_2.Workspace
  L4_2 = L4_2.Gravity
  L5_2 = game
  L5_2 = L5_2.Workspace
  L5_2.Gravity = 0
  L5_2 = TweenInfo
  L5_2 = L5_2.new
  L6_2 = L2_2.Character
  L6_2 = L6_2.HumanoidRootPart
  L6_2 = L6_2.Position
  L7_2 = A1_2.p
  L6_2 = L6_2 - L7_2
  L6_2 = L6_2.Magnitude
  L6_2 = L6_2 / L3_2
  L7_2 = Enum
  L7_2 = L7_2.EasingStyle
  L7_2 = L7_2.Linear
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = game
  L7_2 = L6_2
  L6_2 = L6_2.GetService
  L8_2 = "TweenService"
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = L6_2
  L6_2 = L6_2.Create
  L8_2 = L2_2.Character
  L8_2 = L8_2.HumanoidRootPart
  L9_2 = L5_2
  L10_2 = {}
  L10_2.CFrame = A1_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L8_2 = L6_2
  L7_2 = L6_2.Play
  L7_2(L8_2)
  L7_2 = L6_2.Completed
  L8_2 = L7_2
  L7_2 = L7_2.wait
  L7_2(L8_2)
  L7_2 = game
  L7_2 = L7_2.Workspace
  L7_2.Gravity = L4_2
end

L25_1.tween_teleport = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = game
  L2_2 = L2_2.Players
  L2_2 = L2_2.LocalPlayer
  L3_2 = L2_2.Character
  L3_2 = L3_2.Humanoid
  L3_2 = L3_2.WalkSpeed
  L4_2 = L2_2.Character
  L5_2 = L4_2
  L4_2 = L4_2.FindFirstChildOfClass
  L6_2 = "Model"
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = L4_1
    L4_2 = L4_2.Shared
    L4_2 = L4_2.VehicleHandler
    L4_2 = L4_2.VehicleData
    L5_2 = string
    L5_2 = L5_2.split
    L6_2 = L2_2.Character
    L7_2 = L6_2
    L6_2 = L6_2.FindFirstChildOfClass
    L8_2 = "Model"
    L6_2 = L6_2(L7_2, L8_2)
    L6_2 = L6_2.Name
    L7_2 = "_"
    L5_2 = L5_2(L6_2, L7_2)
    L5_2 = L5_2[2]
    L4_2 = L4_2[L5_2]
    L3_2 = L4_2.ForwardSpeed
  else
    L4_2 = L2_2.Character
    L4_2 = L4_2.Humanoid
    L3_2 = L4_2.WalkSpeed
  end
  L4_2 = game
  L4_2 = L4_2.Workspace
  L4_2 = L4_2.Gravity
  L5_2 = game
  L5_2 = L5_2.Workspace
  L5_2.Gravity = 0
  
  function L5_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = Instance
    L1_3 = L1_3.new
    L2_3 = "BodyVelocity"
    L3_3 = L2_2
    L3_3 = L3_3.Character
    L3_3 = L3_3.HumanoidRootPart
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = Vector3
    L2_3 = L2_3.new
    L3_3 = 9000000000
    L4_3 = 9000000000
    L5_3 = 9000000000
    L2_3 = L2_3(L3_3, L4_3, L5_3)
    L1_3.MaxForce = L2_3
    L2_3 = L3_2
    L1_3.P = L2_3
    repeat
      L2_3 = A0_3.p
      L3_3 = L2_2
      L3_3 = L3_3.Character
      L3_3 = L3_3.HumanoidRootPart
      L3_3 = L3_3.Position
      L2_3 = L2_3 - L3_3
      L2_3 = L2_3.Unit
      L3_3 = L3_2
      L2_3 = L2_3 * L3_3
      L1_3.Velocity = L2_3
      L3_3 = wait
      L3_3()
      L3_3 = L2_2
      L3_3 = L3_3.Character
      L3_3 = L3_3.HumanoidRootPart
      L3_3 = L3_3.Position
      L4_3 = A0_3.p
      L3_3 = L3_3 - L4_3
      L3_3 = L3_3.Magnitude
    until L3_3 < 15
    L2_3 = Vector3
    L2_3 = L2_3.new
    L3_3 = 0
    L4_3 = 0
    L5_3 = 0
    L2_3 = L2_3(L3_3, L4_3, L5_3)
    L1_3.Velocity = L2_3
    L2_3 = wait
    L3_3 = 0.1
    L2_3(L3_3)
    L3_3 = L1_3
    L2_3 = L1_3.Destroy
    L2_3(L3_3)
  end
  
  L6_2 = L2_2.Character
  L6_2 = L6_2.HumanoidRootPart
  L6_2 = L6_2.CFrame
  L7_2 = L2_2.Character
  L8_2 = L7_2
  L7_2 = L7_2.SetPrimaryPartCFrame
  L9_2 = CFrame
  L9_2 = L9_2.new
  L10_2 = L6_2.X
  L11_2 = -50
  L12_2 = L6_2.Z
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2, L11_2, L12_2)
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = wait
  L8_2 = 0.1
  L7_2(L8_2)
  L7_2 = L5_2
  L8_2 = CFrame
  L8_2 = L8_2.new
  L9_2 = A1_2.X
  L10_2 = -50
  L11_2 = A1_2.Z
  L8_2, L9_2, L10_2, L11_2, L12_2 = L8_2(L9_2, L10_2, L11_2)
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = wait
  L8_2 = 0.1
  L7_2(L8_2)
  L7_2 = L2_2.Character
  L8_2 = L7_2
  L7_2 = L7_2.SetPrimaryPartCFrame
  L9_2 = CFrame
  L9_2 = L9_2.new
  L10_2 = A1_2
  L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = game
  L7_2 = L7_2.Workspace
  L7_2.Gravity = L4_2
end

L25_1.auto_drive = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = game
  L2_2 = L2_2.Players
  L2_2 = L2_2.LocalPlayer
  L3_2 = L2_2.Character
  L3_2 = L3_2.Humanoid
  L3_2 = L3_2.WalkSpeed
  L4_2 = L2_2.Character
  L5_2 = L4_2
  L4_2 = L4_2.FindFirstChildOfClass
  L6_2 = "Model"
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = pairs
    L5_2 = L2_2.Character
    L6_2 = L5_2
    L5_2 = L5_2.GetChildren
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2(L6_2)
    L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    for L7_2, L8_2 in L4_2, L5_2, L6_2 do
      L10_2 = L8_2
      L9_2 = L8_2.IsA
      L11_2 = "Model"
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 then
        L9_2 = pcall
        
        function L10_2()
          local L0_3, L1_3, L2_3, L3_3
          L0_3 = L4_1
          L0_3 = L0_3.Shared
          L0_3 = L0_3.VehicleHandler
          L0_3 = L0_3.VehicleData
          L1_3 = string
          L1_3 = L1_3.split
          L2_3 = L8_2
          L2_3 = L2_3.Name
          L3_3 = "_"
          L1_3 = L1_3(L2_3, L3_3)
          L1_3 = L1_3[2]
          L0_3 = L0_3[L1_3]
          L0_3 = L0_3.ForwardSpeed
          L3_2 = L0_3
        end
        
        L9_2(L10_2)
      end
    end
  end
  
  function L4_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L1_3 = Instance
    L1_3 = L1_3.new
    L2_3 = "CFrameValue"
    L1_3 = L1_3(L2_3)
    L2_3 = L2_2
    L2_3 = L2_3.Character
    L2_3 = L2_3.HumanoidRootPart
    L2_3 = L2_3.CFrame
    L1_3.Value = L2_3
    L2_3 = L1_3.Changed
    L3_3 = L2_3
    L2_3 = L2_3.Connect
    
    function L4_3()
      local L0_4, L1_4, L2_4
      L0_4 = L2_2
      L0_4 = L0_4.Character
      L1_4 = L0_4
      L0_4 = L0_4.SetPrimaryPartCFrame
      L2_4 = L1_3
      L2_4 = L2_4.Value
      L0_4(L1_4, L2_4)
    end
    
    L2_3(L3_3, L4_3)
    L2_3 = game
    L3_3 = L2_3
    L2_3 = L2_3.GetService
    L4_3 = "TweenService"
    L2_3 = L2_3(L3_3, L4_3)
    L4_3 = L2_3
    L3_3 = L2_3.Create
    L5_3 = L1_3
    L6_3 = TweenInfo
    L6_3 = L6_3.new
    L7_3 = L2_2
    L7_3 = L7_3.Character
    L7_3 = L7_3.HumanoidRootPart
    L7_3 = L7_3.Position
    L8_3 = A0_3.p
    L7_3 = L7_3 - L8_3
    L7_3 = L7_3.Magnitude
    L8_3 = L3_2
    L8_3 = L8_3 * 1
    L7_3 = L7_3 / L8_3
    L8_3 = Enum
    L8_3 = L8_3.EasingStyle
    L8_3 = L8_3.Linear
    L6_3 = L6_3(L7_3, L8_3)
    L7_3 = {}
    L7_3.Value = A0_3
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L5_3 = L3_3
    L4_3 = L3_3.Play
    L4_3(L5_3)
    L4_3 = L3_3.Completed
    L5_3 = L4_3
    L4_3 = L4_3.wait
    L4_3(L5_3)
    L5_3 = L1_3
    L4_3 = L1_3.Destroy
    L4_3(L5_3)
  end
  
  L5_2 = 0
  L6_2 = pairs
  L7_2 = L2_2.Character
  L8_2 = L7_2
  L7_2 = L7_2.GetDescendants
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L7_2(L8_2)
  L6_2, L7_2, L8_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  for L9_2, L10_2 in L6_2, L7_2, L8_2 do
    L12_2 = L10_2
    L11_2 = L10_2.IsA
    L13_2 = "Union"
    L11_2 = L11_2(L12_2, L13_2)
    if not L11_2 then
      L12_2 = L10_2
      L11_2 = L10_2.IsA
      L13_2 = "BasePart"
      L11_2 = L11_2(L12_2, L13_2)
      if not L11_2 then
        goto lbl_55
      end
    end
    L11_2 = L10_2.Mass
    L5_2 = L5_2 + L11_2
    ::lbl_55::
  end
  L6_2 = Instance
  L6_2 = L6_2.new
  L7_2 = "BodyForce"
  L8_2 = L2_2.Character
  L8_2 = L8_2.HumanoidRootPart
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = Vector3
  L7_2 = L7_2.new
  L8_2 = 0
  L9_2 = game
  L9_2 = L9_2.Workspace
  L9_2 = L9_2.Gravity
  L9_2 = L5_2 * L9_2
  L10_2 = 0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L6_2.Force = L7_2
  L7_2 = L2_2.Character
  L7_2 = L7_2.HumanoidRootPart
  L7_2 = L7_2.CFrame
  L8_2 = L2_2.Character
  L9_2 = L8_2
  L8_2 = L8_2.SetPrimaryPartCFrame
  L10_2 = CFrame
  L10_2 = L10_2.new
  L11_2 = L7_2.X
  L12_2 = -50
  L13_2 = L7_2.Z
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2, L12_2, L13_2)
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  L8_2 = wait
  L9_2 = 0.1
  L8_2(L9_2)
  L8_2 = L4_2
  L9_2 = CFrame
  L9_2 = L9_2.new
  L10_2 = A1_2.X
  L11_2 = -50
  L12_2 = A1_2.Z
  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2, L11_2, L12_2)
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  L9_2 = L6_2
  L8_2 = L6_2.Destroy
  L8_2(L9_2)
  L8_2 = wait
  L9_2 = 0.1
  L8_2(L9_2)
  L8_2 = L2_2.Character
  L9_2 = L8_2
  L8_2 = L8_2.SetPrimaryPartCFrame
  L10_2 = CFrame
  L10_2 = L10_2.new
  L11_2 = A1_2
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
end

L25_1.auto_drive_old = L26_1

function L26_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L3_2 = game
  L3_2 = L3_2.Workspace
  L3_2 = L3_2.Plots
  L4_2 = "Plot_"
  L5_2 = game
  L5_2 = L5_2.Players
  L5_2 = L5_2.LocalPlayer
  L5_2 = L5_2.Name
  L4_2 = L4_2 .. L5_2
  L3_2 = L3_2[L4_2]
  L4_2 = L4_1
  L4_2 = L4_2.Shared
  L4_2 = L4_2.FoodHandler
  L4_2 = L4_2.FoodData
  L4_2 = L4_2[A1_2]
  L5_2 = game
  L5_2 = L5_2.Players
  L5_2 = L5_2.LocalPlayer
  L6_2 = nil
  L7_2 = nil
  L8_2 = pairs
  L9_2 = L3_2.House
  L9_2 = L9_2.Counters
  L10_2 = L9_2
  L9_2 = L9_2.GetDescendants
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L9_2(L10_2)
  L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  for L11_2, L12_2 in L8_2, L9_2, L10_2 do
    L13_2 = math
    L13_2 = L13_2.huge
    L14_2 = string
    L14_2 = L14_2.find
    L15_2 = L12_2.Name
    L16_2 = L15_2
    L15_2 = L15_2.lower
    L15_2 = L15_2(L16_2)
    L16_2 = "fridge"
    L14_2 = L14_2(L15_2, L16_2)
    if L14_2 then
      L14_2 = game
      L14_2 = L14_2.Players
      L14_2 = L14_2.LocalPlayer
      L15_2 = L14_2
      L14_2 = L14_2.DistanceFromCharacter
      L16_2 = L12_2.Position
      L14_2 = L14_2(L15_2, L16_2)
      if L13_2 > L14_2 then
        L15_2 = L12_2
        L14_2 = L12_2.FindFirstChild
        L16_2 = "AttachPos"
        L14_2 = L14_2(L15_2, L16_2)
        if not L14_2 then
          L15_2 = L12_2
          L14_2 = L12_2.FindFirstChild
          L16_2 = "AttachPos1"
          L14_2 = L14_2(L15_2, L16_2)
          if not L14_2 then
            goto lbl_75
          end
        end
        L14_2 = game
        L14_2 = L14_2.Players
        L14_2 = L14_2.LocalPlayer
        L15_2 = L14_2
        L14_2 = L14_2.DistanceFromCharacter
        L16_2 = L12_2.Position
        L14_2 = L14_2(L15_2, L16_2)
        L13_2 = L14_2
        L15_2 = L12_2
        L14_2 = L12_2.FindFirstChild
        L16_2 = "AttachPos"
        L14_2 = L14_2(L15_2, L16_2)
        if L14_2 then
          L14_2 = L12_2.AttachPos
          L14_2 = L14_2.CFrame
          if L14_2 then
            goto lbl_74
            L7_2 = L14_2 or L7_2
          end
        end
        L14_2 = L12_2.AttachPos1
        L7_2 = L14_2.CFrame
        ::lbl_74::
        L6_2 = L12_2
      end
    end
    ::lbl_75::
  end
  if not L6_2 then
    L8_2 = print
    L9_2 = "No Fridge"
    L8_2(L9_2)
    return
  end
  L9_2 = A0_2
  L8_2 = A0_2.tween_teleport
  L10_2 = L7_2
  L8_2(L9_2, L10_2)
  while true do
    L8_2 = L4_1
    L8_2 = L8_2.Shared
    L8_2 = L8_2.EquipmentHandler
    L9_2 = L8_2
    L8_2 = L8_2.GetEquipped
    L10_2 = game
    L10_2 = L10_2.Players
    L10_2 = L10_2.LocalPlayer
    L8_2 = L8_2(L9_2, L10_2)
    if L8_2 then
      break
    end
    L8_2 = L23_1
    L9_2 = L8_2
    L8_2 = L8_2.FireServer
    L10_2 = {}
    L10_2.Type = "Interact"
    L10_2.Target = L6_2
    L10_2.Path = "1"
    L8_2(L9_2, L10_2)
    L8_2 = L23_1
    L9_2 = L8_2
    L8_2 = L8_2.FireServer
    L10_2 = {}
    L10_2.Type = "TakeIngredient"
    L10_2.Name = A1_2
    L8_2(L9_2, L10_2)
    L8_2 = wait
    L9_2 = 0.1
    L8_2(L9_2)
  end
  
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.FoodHandler
    L1_3 = L1_3.CookActions
    L2_3 = {}
    L3_3 = type
    L4_3 = A0_3
    L3_3 = L3_3(L4_3)
    if L3_3 == "table" then
      L3_3 = pairs
      L4_3 = A0_3
      L3_3, L4_3, L5_3 = L3_3(L4_3)
      for L6_3, L7_3 in L3_3, L4_3, L5_3 do
        L8_3 = L1_3[L7_3]
        L8_3 = L8_3.Type
        if L8_3 then
          L8_3 = table
          L8_3 = L8_3.insert
          L9_3 = L2_3
          L10_3 = L1_3[L7_3]
          L10_3 = L10_3.Type
          L8_3(L9_3, L10_3)
        else
          L8_3 = L1_3[L7_3]
          L8_3 = L8_3.Types
          if L8_3 then
            L8_3 = pairs
            L9_3 = L1_3[L7_3]
            L9_3 = L9_3.Types
            L8_3, L9_3, L10_3 = L8_3(L9_3)
            for L11_3, L12_3 in L8_3, L9_3, L10_3 do
              L13_3 = table
              L13_3 = L13_3.insert
              L14_3 = L2_3
              L15_3 = L12_3
              L13_3(L14_3, L15_3)
            end
          end
        end
      end
    else
      L3_3 = L1_3[A0_3]
      L3_3 = L3_3.Type
      if L3_3 then
        L3_3 = {}
        L4_3 = L1_3[A0_3]
        L4_3 = L4_3.Type
        L3_3[1] = L4_3
        L2_3 = L3_3
      else
        L3_3 = L1_3[A0_3]
        L3_3 = L3_3.Types
        if L3_3 then
          L3_3 = L1_3[A0_3]
          L2_3 = L3_3.Types
        end
      end
    end
    if not L2_3 then
      L3_3 = false
      return L3_3
    end
    L3_3 = math
    L3_3 = L3_3.huge
    L4_3 = nil
    L5_3 = pairs
    L6_3 = L3_2
    L6_3 = L6_3.House
    L6_3 = L6_3.Counters
    L7_3 = L6_3
    L6_3 = L6_3.GetChildren
    L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3 = L6_3(L7_3)
    L5_3, L6_3, L7_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
    for L8_3, L9_3 in L5_3, L6_3, L7_3 do
      L10_3 = pairs
      L11_3 = L4_1
      L11_3 = L11_3.Items
      L12_3 = L11_3
      L11_3 = L11_3.GetItem
      L13_3 = L9_3.Name
      L11_3 = L11_3(L12_3, L13_3)
      L11_3 = L11_3.Types
      L10_3, L11_3, L12_3 = L10_3(L11_3)
      for L13_3, L14_3 in L10_3, L11_3, L12_3 do
        L16_3 = L9_3
        L15_3 = L9_3.FindFirstChild
        L17_3 = "ItemHolder"
        L15_3 = L15_3(L16_3, L17_3)
        if L15_3 == nil then
          L15_3 = table
          L15_3 = L15_3.find
          L16_3 = L2_3
          L17_3 = L14_3
          L15_3 = L15_3(L16_3, L17_3)
          if L15_3 then
            L15_3 = L5_2
            L16_3 = L15_3
            L15_3 = L15_3.DistanceFromCharacter
            L17_3 = L9_3.Position
            L15_3 = L15_3(L16_3, L17_3)
            if L3_3 > L15_3 then
              L15_3 = warn
              L16_3 = L9_3.Name
              L15_3(L16_3)
              L15_3 = L5_2
              L16_3 = L15_3
              L15_3 = L15_3.DistanceFromCharacter
              L17_3 = L9_3.Position
              L15_3 = L15_3(L16_3, L17_3)
              L3_3 = L15_3
              L4_3 = L9_3
            end
          end
        end
      end
    end
    if L4_3 == nil then
      L5_3 = false
      return L5_3
    end
  end
  
  L9_2 = pairs
  L10_2 = L4_2.Recipe
  L9_2, L10_2, L11_2 = L9_2(L10_2)
  for L12_2, L13_2 in L9_2, L10_2, L11_2 do
    L14_2 = L8_2
    L15_2 = L13_2
    L14_2 = L14_2(L15_2)
    if not L14_2 then
      return
    end
    L16_2 = A0_2
    L15_2 = A0_2.tween_teleport
    L17_2 = L14_2.AttachPos
    L17_2 = L17_2.CFrame
    L15_2(L16_2, L17_2)
    while true do
      L15_2 = L4_1
      L15_2 = L15_2.Shared
      L15_2 = L15_2.EquipmentHandler
      L16_2 = L15_2
      L15_2 = L15_2.GetEquipped
      L17_2 = L5_2
      L15_2 = L15_2(L16_2, L17_2)
      if not L15_2 then
        break
      end
      L15_2 = 1
      L16_2 = 5
      L17_2 = 1
      for L18_2 = L15_2, L16_2, L17_2 do
        L19_2 = print
        L20_2 = L12_2
        L19_2(L20_2)
        L19_2 = L23_1
        L20_2 = L19_2
        L19_2 = L19_2.FireServer
        L21_2 = {}
        L21_2.Type = "Interact"
        L21_2.Target = L14_2
        L22_2 = tostring
        L23_2 = L18_2
        L22_2 = L22_2(L23_2)
        L21_2.Path = L22_2
        L19_2(L20_2, L21_2)
        L19_2 = wait
        L19_2()
        L19_2 = L4_1
        L19_2 = L19_2.Shared
        L19_2 = L19_2.EquipmentHandler
        L20_2 = L19_2
        L19_2 = L19_2.GetEquipped
        L21_2 = L5_2
        L19_2 = L19_2(L20_2, L21_2)
        if not L19_2 then
          break
        end
      end
    end
    repeat
      L15_2 = game
      L16_2 = L15_2
      L15_2 = L15_2.GetService
      L17_2 = "RunService"
      L15_2 = L15_2(L16_2, L17_2)
      L15_2 = L15_2.RenderStepped
      L16_2 = L15_2
      L15_2 = L15_2.Wait
      L15_2(L16_2)
      L15_2 = L5_2.PlayerGui
      L15_2 = L15_2.MainGUI
      L15_2 = L15_2.Scripts
      L15_2 = L15_2.Hotbar
      L16_2 = L15_2
      L15_2 = L15_2.FindFirstChild
      L17_2 = "Event"
      L15_2 = L15_2(L16_2, L17_2)
      if L15_2 then
        L15_2 = L5_2.PlayerGui
        L15_2 = L15_2.MainGUI
        L15_2 = L15_2.Scripts
        L15_2 = L15_2.Hotbar
        L16_2 = L15_2
        L15_2 = L15_2.FindFirstChild
        L17_2 = "Event"
        L15_2 = L15_2(L16_2, L17_2)
        L16_2 = L15_2
        L15_2 = L15_2.Fire
        L17_2 = true
        L15_2(L16_2, L17_2)
      end
      L16_2 = L14_2
      L15_2 = L14_2.FindFirstChild
      L17_2 = "ObjectData"
      L15_2 = L15_2(L16_2, L17_2)
      if L15_2 then
        L16_2 = L14_2
        L15_2 = L14_2.FindFirstChild
        L17_2 = "ObjectData"
        L15_2 = L15_2(L16_2, L17_2)
        L16_2 = L15_2
        L15_2 = L15_2.FindFirstChild
        L17_2 = "TakeFoodEvent"
        L15_2 = L15_2(L16_2, L17_2)
        if L15_2 then
          L15_2 = 1
          L16_2 = 5
          L17_2 = 1
          for L18_2 = L15_2, L16_2, L17_2 do
            L19_2 = L23_1
            L20_2 = L19_2
            L19_2 = L19_2.FireServer
            L21_2 = {}
            L21_2.Type = "Interact"
            L21_2.Target = L14_2
            L22_2 = tostring
            L23_2 = L18_2
            L22_2 = L22_2(L23_2)
            L21_2.Path = L22_2
            L19_2(L20_2, L21_2)
            L19_2 = wait
            L19_2()
            L19_2 = L4_1
            L19_2 = L19_2.Shared
            L19_2 = L19_2.EquipmentHandler
            L20_2 = L19_2
            L19_2 = L19_2.GetEquipped
            L21_2 = L5_2
            L19_2 = L19_2(L20_2, L21_2)
            if L19_2 then
              break
            end
          end
        end
      end
      L15_2 = L4_1
      L15_2 = L15_2.Shared
      L15_2 = L15_2.EquipmentHandler
      L16_2 = L15_2
      L15_2 = L15_2.GetEquipped
      L17_2 = L5_2
      L15_2 = L15_2(L16_2, L17_2)
    until L15_2
  end
  if A2_2 then
    L10_2 = A0_2
    L9_2 = A0_2.tween_teleport
    L11_2 = L6_2.AttachPos
    L11_2 = L11_2.CFrame
    L9_2(L10_2, L11_2)
    L9_2 = L23_1
    L10_2 = L9_2
    L9_2 = L9_2.FireServer
    L11_2 = {}
    L11_2.Type = "Interact"
    L11_2.Target = L6_2
    L11_2.Path = "3"
    L9_2(L10_2, L11_2)
  else
    L9_2 = nil
    L10_2 = nil
    L11_2 = nil
    L12_2 = pairs
    L13_2 = L3_2.House
    L13_2 = L13_2.Counters
    L14_2 = L13_2
    L13_2 = L13_2.GetChildren
    L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L13_2(L14_2)
    L12_2, L13_2, L14_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    for L15_2, L16_2 in L12_2, L13_2, L14_2 do
      L17_2 = string
      L17_2 = L17_2.find
      L18_2 = L16_2.Name
      L19_2 = L18_2
      L18_2 = L18_2.lower
      L18_2 = L18_2(L19_2)
      L19_2 = "counter"
      L17_2 = L17_2(L18_2, L19_2)
      if L17_2 then
        L18_2 = L16_2
        L17_2 = L16_2.findFirstChild
        L19_2 = "ItemHolder"
        L17_2 = L17_2(L18_2, L19_2)
        if L17_2 == nil then
          L18_2 = L16_2
          L17_2 = L16_2.FindFirstChild
          L19_2 = "ObjectModel"
          L17_2 = L17_2(L18_2, L19_2)
          if L17_2 then
            L17_2 = L16_2.ObjectModel
            L18_2 = L17_2
            L17_2 = L17_2.FindFirstChild
            L19_2 = "PlaceArea"
            L17_2 = L17_2(L18_2, L19_2)
            if L17_2 then
              L17_2 = L16_2.ObjectModel
              L18_2 = L17_2
              L17_2 = L17_2.FindFirstChild
              L19_2 = "AttachPos"
              L17_2 = L17_2(L18_2, L19_2)
              if L17_2 then
                L10_2 = L16_2
                L17_2 = L16_2.ObjectModel
                L17_2 = L17_2.PlaceArea
                L9_2 = L17_2.CFrame
                L17_2 = L16_2.ObjectModel
                L17_2 = L17_2.AttachPos
                L11_2 = L17_2.CFrame
                break
              end
            end
          end
        end
      end
    end
    L13_2 = A0_2
    L12_2 = A0_2.tween_teleport
    L14_2 = L11_2
    L12_2(L13_2, L14_2)
    L12_2 = 3
    L13_2 = 5
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = L23_1
      L17_2 = L16_2
      L16_2 = L16_2.FireServer
      L18_2 = {}
      L18_2.Type = "Interact"
      L18_2.Target = L10_2
      L19_2 = tostring
      L20_2 = L15_2
      L19_2 = L19_2(L20_2)
      L18_2.Path = L19_2
      L19_2 = L9_2.p
      L18_2.Pos = L19_2
      L16_2(L17_2, L18_2)
      L16_2 = wait
      L16_2()
    end
    L12_2 = L10_2.ItemHolder
    L12_2 = L12_2[A1_2]
    return L12_2
  end
end

L25_1.auto_cook = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L4_1
  L1_2 = L1_2.Modules
  L1_2 = L1_2.ClientStats
  L2_2 = L1_2
  L1_2 = L1_2.Get
  L3_2 = "MoodData/Energy"
  L1_2, L2_2 = L1_2(L2_2, L3_2)
end

L25_1.get_energy = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L4_1
  L1_2 = L1_2.Modules
  L1_2 = L1_2.ClientStats
  L2_2 = L1_2
  L1_2 = L1_2.Get
  L3_2 = "MoodData/Hunger"
  L1_2, L2_2 = L1_2(L2_2, L3_2)
end

L25_1.get_hunger = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L4_1
  L1_2 = L1_2.Modules
  L1_2 = L1_2.ClientStats
  L2_2 = L1_2
  L1_2 = L1_2.Get
  L3_2 = "MoodData/Hygiene"
  L1_2, L2_2 = L1_2(L2_2, L3_2)
end

L25_1.get_hygiene = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L4_1
  L1_2 = L1_2.Modules
  L1_2 = L1_2.ClientStats
  L2_2 = L1_2
  L1_2 = L1_2.Get
  L3_2 = "MoodData/Fun"
  L1_2, L2_2 = L1_2(L2_2, L3_2)
end

L25_1.get_fun = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = game
  L2_2 = L1_2
  L1_2 = L1_2.GetService
  L3_2 = "VirtualUser"
  L1_2 = L1_2(L2_2, L3_2)
  L3_2 = L1_2
  L2_2 = L1_2.CaptureController
  L2_2(L3_2)
  L3_2 = L1_2
  L2_2 = L1_2.SetKeyDown
  L4_2 = "0x20"
  L2_2(L3_2, L4_2)
  L2_2 = wait
  L2_2()
  L3_2 = L1_2
  L2_2 = L1_2.SetKeyUp
  L4_2 = "0x20"
  L2_2(L3_2, L4_2)
end

L25_1.jump = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L2_2 = A0_2
  L1_2 = A0_2.get_fun
  L1_2 = L1_2(L2_2)
  if 99 < L1_2 then
    return
  end
  L1_2 = nil
  L2_2 = game
  L3_2 = L2_2
  L2_2 = L2_2.GetService
  L4_2 = "Workspace"
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2.Plots
  L3_2 = L2_2
  L2_2 = L2_2.FindFirstChild
  L4_2 = "Plot_"
  L5_2 = game
  L5_2 = L5_2.Players
  L5_2 = L5_2.LocalPlayer
  L5_2 = L5_2.Name
  L4_2 = L4_2 .. L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = pairs
  L4_2 = L2_2.House
  L5_2 = L4_2
  L4_2 = L4_2.GetDescendants
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L4_2(L5_2)
  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L6_2, L7_2 in L3_2, L4_2, L5_2 do
    L9_2 = L7_2
    L8_2 = L7_2.FindFirstChild
    L10_2 = "ScreenPoint"
    L8_2 = L8_2(L9_2, L10_2)
    if L8_2 ~= nil then
      L9_2 = L7_2
      L8_2 = L7_2.FindFirstChild
      L10_2 = "ObjectData"
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 ~= nil then
        L8_2 = L7_2.ObjectData
        L9_2 = L8_2
        L8_2 = L8_2.FindFirstChild
        L10_2 = "TVGui"
        L8_2 = L8_2(L9_2, L10_2)
        if L8_2 ~= nil then
          L1_2 = L7_2
          break
        end
      end
    end
  end
  if L1_2 == nil then
    L4_2 = A0_2
    L3_2 = A0_2.notify
    L5_2 = "Please purchase a TV to boost Fun Mood!"
    L3_2(L4_2, L5_2)
    return
  end
  repeat
    L4_2 = A0_2
    L3_2 = A0_2.tween_teleport
    L5_2 = L1_2.ScreenPoint
    L5_2 = L5_2.CFrame
    L6_2 = Vector3
    L6_2 = L6_2.new
    L7_2 = 0
    L8_2 = 2
    L9_2 = 0
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L5_2 = L5_2 + L6_2
    L3_2(L4_2, L5_2)
    L3_2 = wait
    L3_2()
    L3_2 = L1_2.ObjectData
    L3_2 = L3_2.IsOn
    L3_2 = L3_2.Value
    if L3_2 ~= true then
      L3_2 = L22_1
      L4_2 = L3_2
      L3_2 = L3_2.FireServer
      L5_2 = {}
      L5_2.Type = "Interact"
      L5_2.Target = L1_2
      L5_2.Path = "1"
      L3_2(L4_2, L5_2)
      L3_2 = wait
      L3_2()
    end
    L3_2 = L22_1
    L4_2 = L3_2
    L3_2 = L3_2.FireServer
    L5_2 = {}
    L5_2.Type = "Interact"
    L5_2.Target = L1_2
    L5_2.Path = "3"
    L3_2(L4_2, L5_2)
    L3_2 = wait
    L4_2 = 2
    L3_2(L4_2)
    L4_2 = A0_2
    L3_2 = A0_2.get_fun
    L3_2 = L3_2(L4_2)
  until 99 < L3_2
  L4_2 = A0_2
  L3_2 = A0_2.jump
  L3_2(L4_2)
  L3_2 = print
  L4_2 = "Fun Boosted!"
  L3_2(L4_2)
end

L25_1.boost_fun = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L2_2 = A0_2
  L1_2 = A0_2.get_hygiene
  L1_2 = L1_2(L2_2)
  if 99 < L1_2 then
    return
  end
  L1_2 = nil
  L2_2 = game
  L3_2 = L2_2
  L2_2 = L2_2.GetService
  L4_2 = "Workspace"
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2.Plots
  L3_2 = L2_2
  L2_2 = L2_2.FindFirstChild
  L4_2 = "Plot_"
  L5_2 = game
  L5_2 = L5_2.Players
  L5_2 = L5_2.LocalPlayer
  L5_2 = L5_2.Name
  L4_2 = L4_2 .. L5_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = pairs
  L4_2 = L2_2.House
  L5_2 = L4_2
  L4_2 = L4_2.GetDescendants
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L4_2(L5_2)
  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L6_2, L7_2 in L3_2, L4_2, L5_2 do
    L8_2 = string
    L8_2 = L8_2.find
    L9_2 = L7_2.Name
    L10_2 = L9_2
    L9_2 = L9_2.lower
    L9_2 = L9_2(L10_2)
    L10_2 = "shower"
    L11_2 = 1
    L12_2 = true
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    if L8_2 then
      L9_2 = L7_2
      L8_2 = L7_2.FindFirstChild
      L10_2 = "AttachPos"
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 ~= nil then
        L9_2 = L7_2
        L8_2 = L7_2.FindFirstChild
        L10_2 = "ObjectData"
        L8_2 = L8_2(L9_2, L10_2)
        if L8_2 ~= nil then
          L9_2 = L7_2
          L8_2 = L7_2.FindFirstChild
          L10_2 = "Water"
          L8_2 = L8_2(L9_2, L10_2)
          if L8_2 ~= nil then
            L1_2 = L7_2
            break
          end
        end
      end
    end
  end
  if L1_2 == nil then
    L3_2 = pairs
    L4_2 = L2_2.House
    L5_2 = L4_2
    L4_2 = L4_2.GetDescendants
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L4_2(L5_2)
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    for L6_2, L7_2 in L3_2, L4_2, L5_2 do
      L8_2 = string
      L8_2 = L8_2.find
      L9_2 = L7_2.Name
      L10_2 = L9_2
      L9_2 = L9_2.lower
      L9_2 = L9_2(L10_2)
      L10_2 = "sink"
      L11_2 = 1
      L12_2 = true
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
      if L8_2 then
        L9_2 = L7_2
        L8_2 = L7_2.FindFirstChild
        L10_2 = "Water"
        L8_2 = L8_2(L9_2, L10_2)
        if L8_2 ~= nil then
          L9_2 = L7_2
          L8_2 = L7_2.FindFirstChild
          L10_2 = "ObjectData"
          L8_2 = L8_2(L9_2, L10_2)
          if L8_2 then
            L1_2 = L7_2
            break
          end
        end
      end
    end
  end
  if L1_2 == nil then
    L4_2 = A0_2
    L3_2 = A0_2.notify
    L5_2 = "Please purchase a shower or a sink to boost Hygiene Mood!"
    L3_2(L4_2, L5_2)
    return
  end
  L4_2 = L1_2
  L3_2 = L1_2.FindFirstChild
  L5_2 = "AttachPos"
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = L1_2.AttachPos
    L3_2 = L3_2.CFrame
    if L3_2 then
      goto lbl_105
    end
  end
  L3_2 = L1_2.CFrame
  ::lbl_105::
  repeat
    L5_2 = A0_2
    L4_2 = A0_2.tween_teleport
    L6_2 = Vector3
    L6_2 = L6_2.new
    L7_2 = 0
    L8_2 = 2
    L9_2 = 0
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L6_2 = L3_2 + L6_2
    L4_2(L5_2, L6_2)
    L4_2 = wait
    L4_2()
    L4_2 = L22_1
    L5_2 = L4_2
    L4_2 = L4_2.FireServer
    L6_2 = {}
    L6_2.Type = "Interact"
    L6_2.Target = L1_2
    L6_2.Path = "1"
    L4_2(L5_2, L6_2)
    L4_2 = wait
    L5_2 = 2
    L4_2(L5_2)
    L5_2 = A0_2
    L4_2 = A0_2.get_hygiene
    L4_2 = L4_2(L5_2)
  until 99 < L4_2
  L5_2 = A0_2
  L4_2 = A0_2.jump
  L4_2(L5_2)
  L4_2 = print
  L5_2 = "Hygiene Boosted!"
  L4_2(L5_2)
end

L25_1.boost_hygiene = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L2_2 = A0_2
  L1_2 = A0_2.get_energy
  L1_2 = L1_2(L2_2)
  if 99 < L1_2 then
    return
  end
  L1_2 = nil
  L2_2 = nil
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "Workspace"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2.Plots
  L4_2 = L3_2
  L3_2 = L3_2.FindFirstChild
  L5_2 = "Plot_"
  L6_2 = game
  L6_2 = L6_2.Players
  L6_2 = L6_2.LocalPlayer
  L6_2 = L6_2.Name
  L5_2 = L5_2 .. L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = pairs
  L5_2 = L3_2.House
  L6_2 = L5_2
  L5_2 = L5_2.GetDescendants
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L5_2(L6_2)
  L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L7_2, L8_2 in L4_2, L5_2, L6_2 do
    L9_2 = string
    L9_2 = L9_2.find
    L10_2 = L8_2.Name
    L11_2 = L10_2
    L10_2 = L10_2.lower
    L10_2 = L10_2(L11_2)
    L11_2 = "bed"
    L12_2 = 1
    L13_2 = true
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    if L9_2 then
      L10_2 = L8_2
      L9_2 = L8_2.FindFirstChild
      L11_2 = "AttachPos"
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 == nil then
        L10_2 = L8_2
        L9_2 = L8_2.FindFirstChild
        L11_2 = "AttachPos1"
        L9_2 = L9_2(L10_2, L11_2)
        if L9_2 == nil then
          goto lbl_71
        end
      end
      L10_2 = L8_2
      L9_2 = L8_2.FindFirstChild
      L11_2 = "ObjectData"
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 ~= nil then
        L9_2 = L8_2.ObjectData
        L10_2 = L9_2
        L9_2 = L9_2.FindFirstChild
        L11_2 = "IsMessy"
        L9_2 = L9_2(L10_2, L11_2)
        if L9_2 ~= nil then
          L1_2 = L8_2
          L10_2 = L8_2
          L9_2 = L8_2.FindFirstChild
          L11_2 = "AttachPos"
          L9_2 = L9_2(L10_2, L11_2)
          if L9_2 then
            L9_2 = L8_2.AttachPos
            L9_2 = L9_2.CFrame
            if L9_2 then
              goto lbl_70
              L2_2 = L9_2 or L2_2
            end
          end
          L9_2 = L8_2.AttachPos1
          L2_2 = L9_2.CFrame
          ::lbl_70::
          break
        end
      end
    end
    ::lbl_71::
  end
  if L1_2 == nil then
    L4_2 = pairs
    L5_2 = L3_2.House
    L6_2 = L5_2
    L5_2 = L5_2.GetDescendants
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L5_2(L6_2)
    L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    for L7_2, L8_2 in L4_2, L5_2, L6_2 do
      L9_2 = string
      L9_2 = L9_2.find
      L10_2 = L8_2.Name
      L11_2 = L10_2
      L10_2 = L10_2.lower
      L10_2 = L10_2(L11_2)
      L11_2 = "sofa"
      L12_2 = 1
      L13_2 = true
      L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
      if not L9_2 then
        L9_2 = string
        L9_2 = L9_2.find
        L10_2 = L8_2.Name
        L11_2 = L10_2
        L10_2 = L10_2.lower
        L10_2 = L10_2(L11_2)
        L11_2 = "chair"
        L12_2 = 1
        L13_2 = true
        L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
        if not L9_2 then
          goto lbl_126
        end
      end
      L10_2 = L8_2
      L9_2 = L8_2.FindFirstChild
      L11_2 = "AttachPos"
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 == nil then
        L10_2 = L8_2
        L9_2 = L8_2.FindFirstChild
        L11_2 = "AttachPos1"
        L9_2 = L9_2(L10_2, L11_2)
        if L9_2 == nil then
          goto lbl_126
        end
      end
      L1_2 = L8_2
      L10_2 = L8_2
      L9_2 = L8_2.FindFirstChild
      L11_2 = "AttachPos"
      L9_2 = L9_2(L10_2, L11_2)
      if L9_2 then
        L9_2 = L8_2.AttachPos
        L9_2 = L9_2.CFrame
        if L9_2 then
          goto lbl_125
          L2_2 = L9_2 or L2_2
        end
      end
      L9_2 = L8_2.AttachPos1
      L2_2 = L9_2.CFrame
      ::lbl_125::
      do break end
      ::lbl_126::
    end
  end
  if L1_2 == nil then
    L5_2 = A0_2
    L4_2 = A0_2.notify
    L6_2 = "Please purchase a bed or a sofa to boost Energy Mood!"
    L4_2(L5_2, L6_2)
    return
  end
  L5_2 = A0_2
  L4_2 = A0_2.tween_teleport
  L6_2 = Vector3
  L6_2 = L6_2.new
  L7_2 = 0
  L8_2 = 2
  L9_2 = 0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L6_2 = L2_2 + L6_2
  L4_2(L5_2, L6_2)
  L4_2 = wait
  L4_2()
  L4_2 = L22_1
  L5_2 = L4_2
  L4_2 = L4_2.FireServer
  L6_2 = {}
  L6_2.Type = "Interact"
  L6_2.Target = L1_2
  L6_2.Path = "1"
  L4_2(L5_2, L6_2)
  repeat
    L4_2 = wait
    L5_2 = 2
    L4_2(L5_2)
    L5_2 = A0_2
    L4_2 = A0_2.get_energy
    L4_2 = L4_2(L5_2)
  until 99 < L4_2
  L5_2 = A0_2
  L4_2 = A0_2.jump
  L4_2(L5_2)
  L4_2 = print
  L5_2 = "Energy Boosted!"
  L4_2(L5_2)
end

L25_1.boost_energy = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L2_2 = A0_2
  L1_2 = A0_2.get_hunger
  L1_2 = L1_2(L2_2)
  if 99 < L1_2 then
    return
  end
  L2_2 = A0_2
  L1_2 = A0_2.auto_cook
  L3_2 = "Garden Salad"
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L4_1
  L2_2 = L2_2.Shared
  L2_2 = L2_2.EquipmentHandler
  L3_2 = L2_2
  L2_2 = L2_2.GetEquipped
  L4_2 = game
  L4_2 = L4_2.Players
  L4_2 = L4_2.LocalPlayer
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 ~= nil then
    L2_2 = L22_1
    L3_2 = L2_2
    L2_2 = L2_2.FireServer
    L4_2 = {}
    L4_2.Type = "UnequipItem"
    L5_2 = L4_1
    L5_2 = L5_2.Shared
    L5_2 = L5_2.EquipmentHandler
    L6_2 = L5_2
    L5_2 = L5_2.GetEquipped
    L7_2 = game
    L7_2 = L7_2.Players
    L7_2 = L7_2.LocalPlayer
    L5_2 = L5_2(L6_2, L7_2)
    L4_2.Item = L5_2
    L2_2(L3_2, L4_2)
    L2_2 = wait
    L3_2 = 1
    L2_2(L3_2)
  end
  repeat
    L2_2 = print
    L3_2 = "Getting food..."
    L2_2(L3_2)
    repeat
      L2_2 = L22_1
      L3_2 = L2_2
      L2_2 = L2_2.FireServer
      L4_2 = {}
      L4_2.Type = "Interact"
      L4_2.Target = L1_2
      L4_2.Path = "2"
      L2_2(L3_2, L4_2)
      L2_2 = wait
      L3_2 = 1
      L2_2(L3_2)
      L2_2 = L4_1
      L2_2 = L2_2.Shared
      L2_2 = L2_2.EquipmentHandler
      L3_2 = L2_2
      L2_2 = L2_2.GetEquipped
      L4_2 = game
      L4_2 = L4_2.Players
      L4_2 = L4_2.LocalPlayer
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 ~= nil then
        break
      end
      L2_2 = L1_2.ObjectData
      L2_2 = L2_2.FoodQuantity
      L2_2 = L2_2.Value
    until L2_2 == -1
    L2_2 = print
    L3_2 = "Food Came, Eating..."
    L2_2(L3_2)
    L2_2 = L22_1
    L3_2 = L2_2
    L2_2 = L2_2.FireServer
    L4_2 = {}
    L4_2.Type = "Eat"
    L5_2 = L4_1
    L5_2 = L5_2.Shared
    L5_2 = L5_2.EquipmentHandler
    L6_2 = L5_2
    L5_2 = L5_2.GetEquipped
    L7_2 = game
    L7_2 = L7_2.Players
    L7_2 = L7_2.LocalPlayer
    L5_2 = L5_2(L6_2, L7_2)
    L4_2.Item = L5_2
    L2_2(L3_2, L4_2)
    L2_2 = wait
    L3_2 = 3
    L2_2(L3_2)
    repeat
      L2_2 = wait
      L2_2()
      L2_2 = L4_1
      L2_2 = L2_2.Shared
      L2_2 = L2_2.EquipmentHandler
      L3_2 = L2_2
      L2_2 = L2_2.GetEquipped
      L4_2 = game
      L4_2 = L4_2.Players
      L4_2 = L4_2.LocalPlayer
      L2_2 = L2_2(L3_2, L4_2)
    until L2_2 ~= nil
    L2_2 = print
    L3_2 = "Eating Done, Disposing..."
    L2_2(L3_2)
    repeat
      L2_2 = L22_1
      L3_2 = L2_2
      L2_2 = L2_2.FireServer
      L4_2 = {}
      L4_2.Type = "UnequipItem"
      L5_2 = L4_1
      L5_2 = L5_2.Shared
      L5_2 = L5_2.EquipmentHandler
      L6_2 = L5_2
      L5_2 = L5_2.GetEquipped
      L7_2 = game
      L7_2 = L7_2.Players
      L7_2 = L7_2.LocalPlayer
      L5_2 = L5_2(L6_2, L7_2)
      L4_2.Item = L5_2
      L2_2(L3_2, L4_2)
      L2_2 = wait
      L2_2()
      L2_2 = L4_1
      L2_2 = L2_2.Shared
      L2_2 = L2_2.EquipmentHandler
      L3_2 = L2_2
      L2_2 = L2_2.GetEquipped
      L4_2 = game
      L4_2 = L4_2.Players
      L4_2 = L4_2.LocalPlayer
      L2_2 = L2_2(L3_2, L4_2)
    until L2_2 == nil
    L2_2 = L1_2.ObjectData
    L2_2 = L2_2.FoodQuantity
    L2_2 = L2_2.Value
  until L2_2 == -1
  L2_2 = print
  L3_2 = "Finished, Disposing Bowl..."
  L2_2(L3_2)
  repeat
    L2_2 = L22_1
    L3_2 = L2_2
    L2_2 = L2_2.FireServer
    L4_2 = {}
    L4_2.Type = "Interact"
    L4_2.Target = L1_2
    L4_2.Path = "1"
    L2_2(L3_2, L4_2)
    L2_2 = wait
    L2_2()
    L2_2 = L4_1
    L2_2 = L2_2.Shared
    L2_2 = L2_2.EquipmentHandler
    L3_2 = L2_2
    L2_2 = L2_2.GetEquipped
    L4_2 = game
    L4_2 = L4_2.Players
    L4_2 = L4_2.LocalPlayer
    L2_2 = L2_2(L3_2, L4_2)
  until L2_2 ~= nil
  L2_2 = wait
  L3_2 = 1
  L2_2(L3_2)
  L2_2 = L22_1
  L3_2 = L2_2
  L2_2 = L2_2.FireServer
  L4_2 = {}
  L4_2.Type = "UnequipItem"
  L5_2 = L4_1
  L5_2 = L5_2.Shared
  L5_2 = L5_2.EquipmentHandler
  L6_2 = L5_2
  L5_2 = L5_2.GetEquipped
  L7_2 = game
  L7_2 = L7_2.Players
  L7_2 = L7_2.LocalPlayer
  L5_2 = L5_2(L6_2, L7_2)
  L4_2.Item = L5_2
  L2_2(L3_2, L4_2)
  L2_2 = wait
  L2_2()
end

L25_1.boost_hunger = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = L4_1
  L3_2 = L3_2.Shared
  L3_2 = L3_2.FoodHandler
  L3_2 = L3_2.OrderedFoodData
  L2_2, L3_2, L4_2 = L2_2(L3_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = table
    L7_2 = L7_2.insert
    L8_2 = L1_2
    L9_2 = L6_2.Name
    L7_2(L8_2, L9_2)
  end
end

L25_1.get_food_list = L26_1
L25_1.schema_version = "alpha x bloxburg base file v2 (center : water)"

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = A0_2.is_plugin
  if L2_2 then
    L2_2 = game
    L2_2 = L2_2.HttpService
    L3_2 = L2_2
    L2_2 = L2_2.RequestAsync
    L4_2 = A1_2
    return L2_2(L3_2, L4_2)
  end
  L2_2 = http_request
  if not L2_2 then
    L2_2 = request
    if not L2_2 then
      L2_2 = syn
      if L2_2 then
        L2_2 = syn
        L2_2 = L2_2.request
        if L2_2 then
          goto lbl_28
        end
      end
      L2_2 = http
      if L2_2 then
        L2_2 = http
        L2_2 = L2_2.request
      end
    end
  end
  ::lbl_28::
  L3_2 = L2_2
  L4_2 = A1_2
end

L25_1.http_request = L26_1

function L26_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = string
  L3_2 = L3_2.format
  L4_2 = "https://api.applebee1558.com/alphax/v2/bloxburg_bases/%s"
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if A2_2 then
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "https://api.applebee1558.com/alphax/v2/bloxburg_bases/%s/preview"
    L6_2 = A1_2
    L4_2 = L4_2(L5_2, L6_2)
    L3_2 = L4_2
  end
  L5_2 = A0_2
  L4_2 = A0_2.http_request
  L6_2 = {}
  L6_2.Url = L3_2
  L7_2 = {}
  L7_2["Content-Type"] = "application/json"
  L6_2.Headers = L7_2
  L6_2.Method = "GET"
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2.StatusCode
  if L5_2 == 200 then
    L5_2 = game
    L5_2 = L5_2.HttpService
    L6_2 = L5_2
    L5_2 = L5_2.JSONDecode
    L7_2 = L4_2.Body
    return L5_2(L6_2, L7_2)
  end
  L5_2 = pcall
  L6_2 = game
  L6_2 = L6_2.HttpService
  L6_2 = L6_2.JSONDecode
  L7_2 = game
  L7_2 = L7_2.HttpService
  L8_2 = L4_2.Body
  L5_2, L6_2 = L5_2(L6_2, L7_2, L8_2)
  if L5_2 then
    return L6_2
  end
  L7_2 = {}
  L7_2.message = L6_2
  L7_2.code = 4000
end

L25_1.get_base_metadata = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = setclipboard
  L3_2 = A1_2
  L2_2(L3_2)
end

L25_1.copy_clipboard = L26_1

function L26_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "Workspace"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2.Plots
  L4_2 = L3_2
  L3_2 = L3_2.FindFirstChild
  L5_2 = "Plot_"
  L6_2 = A1_2.Name
  L5_2 = L5_2 .. L6_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L5_2 = A0_2
    L4_2 = A0_2.notify
    L6_2 = A1_2.Name
    L7_2 = " does not have a plot!"
    L6_2 = L6_2 .. L7_2
    L7_2 = "Base Saving"
    L4_2(L5_2, L6_2, L7_2)
    return
  end
  L5_2 = L3_2
  L4_2 = L3_2.FindFirstChild
  L6_2 = "LODModel"
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L5_2 = A0_2
    L4_2 = A0_2.teleport_player_plot
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
    repeat
      L4_2 = wait
      L4_2()
      L5_2 = L3_2
      L4_2 = L3_2.FindFirstChild
      L6_2 = "LODModel"
      L4_2 = L4_2(L5_2, L6_2)
    until not L4_2
  end
  L4_2 = L16_1
  L4_2 = L4_2.ConfirmBox
  L5_2 = nil
  L6_2 = "Do you really want to save this base?"
  L7_2 = "Info"
  L8_2 = 3
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  if not L4_2 then
    return
  end
  
  function L5_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = {}
    L3_3 = A0_3
    L2_3 = A0_3.components
    L2_3, L3_3 = L2_3(L3_3)
    L1_3[1] = L2_3
    L1_3[2] = L3_3
  end
  
  function L6_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = CFrame
    L1_3 = L1_3.new
    L2_3 = unpack
    L3_3 = A0_3
    L2_3, L3_3 = L2_3(L3_3)
  end
  
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = {}
    L2_3 = A0_3.X
    L3_3 = A0_3.Y
    L4_3 = A0_3.Z
    L1_3[1] = L2_3
    L1_3[2] = L3_3
    L1_3[3] = L4_3
  end
  
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = Vector3
    L1_3 = L1_3.new
    L2_3 = unpack
    L3_3 = A0_3
    L2_3, L3_3 = L2_3(L3_3)
  end
  
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.ObjectManager
    L2_3 = L1_3
    L1_3 = L1_3.RoundToSaveResolution
    L3_3 = CFrame
    L3_3 = L3_3.new
    L4_3 = A0_3
    L3_3, L4_3, L5_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
    L1_3 = L1_3.p
    L2_3 = L7_2
    L3_3 = L3_2
    L3_3 = L3_3.Water
    L3_3 = L3_3.CFrame
    L4_3 = L3_3
    L3_3 = L3_3.PointToObjectSpace
    L5_3 = L1_3
    L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
  end
  
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.ObjectManager
    L2_3 = L1_3
    L1_3 = L1_3.RoundToSaveResolution
    L3_3 = A0_3
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L5_2
    L3_3 = L3_2
    L3_3 = L3_3.Water
    L3_3 = L3_3.CFrame
    L4_3 = L3_3
    L3_3 = L3_3.ToObjectSpace
    L5_3 = L1_3
    L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
  end
  
  L11_2 = 0
  L12_2 = {}
  L13_2 = {}
  L14_2 = {}
  L15_2 = {}
  L16_2 = {}
  L17_2 = {}
  L18_2 = {}
  L19_2 = {}
  L20_2 = {}
  L21_2 = {}
  L22_2 = {}
  L23_2 = {}
  L22_2.Objects = L23_2
  
  function L23_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L1_3 = {}
    L2_3 = L4_1
    L2_3 = L2_3.Shared
    L2_3 = L2_3.ObjectManager
    L3_3 = L2_3
    L2_3 = L2_3.GetAppearanceData
    L4_3 = A0_3
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = pairs
    L4_3 = L2_3
    L3_3, L4_3, L5_3 = L3_3(L4_3)
    for L6_3, L7_3 in L3_3, L4_3, L5_3 do
      L8_3 = #L7_3
      if L8_3 == 0 then
        L8_3 = {}
        L1_3[L6_3] = L8_3
      else
        L8_3 = {}
        L9_3 = BrickColor
        L9_3 = L9_3.new
        L10_3 = tonumber
        L11_3 = L7_3[1]
        L10_3, L11_3, L12_3 = L10_3(L11_3)
        L9_3 = L9_3(L10_3, L11_3, L12_3)
        L9_3 = L9_3.Name
        L8_3[1] = L9_3
        L9_3 = tonumber
        L10_3 = L7_3[2]
        L9_3 = L9_3(L10_3)
        if L9_3 == 0 then
          L8_3[2] = 0
        else
          L9_3 = L4_1
          L9_3 = L9_3.Shared
          L9_3 = L9_3.MaterialData
          L10_3 = L9_3
          L9_3 = L9_3.GetMaterialFromID
          L11_3 = tonumber
          L12_3 = L7_3[2]
          L11_3, L12_3 = L11_3(L12_3)
          L9_3 = L9_3(L10_3, L11_3, L12_3)
          L9_3 = L9_3.Name
          L8_3[2] = L9_3
        end
        L1_3[L6_3] = L8_3
      end
    end
  end
  
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Walls
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = L28_2.Name
    if L29_2 == "Wall" then
      L29_2 = {}
      L30_2 = L4_1
      L30_2 = L30_2.Shared
      L30_2 = L30_2.WallHandler
      L31_2 = L30_2
      L30_2 = L30_2.GetWallEdges
      L32_2 = L28_2
      L30_2, L31_2 = L30_2(L31_2, L32_2)
      L32_2 = L9_2
      L33_2 = L30_2
      L32_2 = L32_2(L33_2)
      L29_2.From = L32_2
      L32_2 = L9_2
      L33_2 = L31_2
      L32_2 = L32_2(L33_2)
      L29_2.To = L32_2
      L32_2 = L23_2
      L33_2 = L28_2.RPart
      L32_2 = L32_2(L33_2)
      L32_2 = L32_2[1]
      L33_2 = L23_2
      L34_2 = L28_2.LPart
      L33_2 = L33_2(L34_2)
      L33_2 = L33_2[2]
      L34_2 = {}
      L34_2.L = L32_2
      L34_2.R = L33_2
      L29_2.Color = L34_2
      L34_2 = L4_1
      L34_2 = L34_2.Shared
      L34_2 = L34_2.PlotHandler
      L35_2 = L34_2
      L34_2 = L34_2.GetObjectValue
      L36_2 = L28_2
      L34_2 = L34_2(L35_2, L36_2)
      L11_2 = L11_2 + L34_2
      L35_2 = L28_2
      L34_2 = L28_2.FindFirstChild
      L36_2 = "ItemHolder"
      L34_2 = L34_2(L35_2, L36_2)
      if L34_2 then
        L34_2 = {}
        L35_2 = pairs
        L36_2 = L28_2.ItemHolder
        L37_2 = L36_2
        L36_2 = L36_2.GetChildren
        L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L36_2(L37_2)
        L35_2, L36_2, L37_2 = L35_2(L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
        for L38_2, L39_2 in L35_2, L36_2, L37_2 do
          L41_2 = L39_2
          L40_2 = L39_2.IsA
          L42_2 = "BasePart"
          L40_2 = L40_2(L41_2, L42_2)
          if L40_2 then
            L40_2 = {}
            L41_2 = L39_2.Name
            L40_2.Name = L41_2
            L41_2 = L23_2
            L42_2 = L39_2
            L41_2 = L41_2(L42_2)
            L40_2.Color = L41_2
            L41_2 = L10_2
            L42_2 = L39_2.CFrame
            L41_2 = L41_2(L42_2)
            L40_2.CF = L41_2
            L41_2 = L39_2.SideValue
            L41_2 = L41_2.Value
            L41_2 = L41_2 == 1
            L40_2.Side = L41_2
            L41_2 = L4_1
            L41_2 = L41_2.Shared
            L41_2 = L41_2.PlotHandler
            L42_2 = L41_2
            L41_2 = L41_2.GetObjectValue
            L43_2 = L39_2
            L41_2 = L41_2(L42_2, L43_2)
            L11_2 = L11_2 + L41_2
            L41_2 = table
            L41_2 = L41_2.insert
            L42_2 = L34_2
            L43_2 = L40_2
            L41_2(L42_2, L43_2)
          end
        end
        L29_2.Objects = L34_2
      end
      L34_2 = table
      L34_2 = L34_2.insert
      L35_2 = L13_2
      L36_2 = L29_2
      L34_2(L35_2, L36_2)
    end
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Floor
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = {}
    L30_2 = {}
    L31_2 = pairs
    L32_2 = L28_2.PointData
    L33_2 = L32_2
    L32_2 = L32_2.GetChildren
    L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
    L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
    for L34_2, L35_2 in L31_2, L32_2, L33_2 do
      L36_2 = L35_2.Value
      L37_2 = table
      L37_2 = L37_2.insert
      L38_2 = L30_2
      L39_2 = L9_2
      L40_2 = L3_2.Ground
      L40_2 = L40_2.CFrame
      L41_2 = L40_2
      L40_2 = L40_2.PointToWorldSpace
      L42_2 = L36_2
      L40_2 = L40_2(L41_2, L42_2)
      L41_2 = Vector3
      L41_2 = L41_2.new
      L42_2 = 0
      L43_2 = 0.05
      L44_2 = 0
      L41_2 = L41_2(L42_2, L43_2, L44_2)
      L40_2 = L40_2 + L41_2
      L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L39_2(L40_2)
      L37_2(L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
    end
    L29_2.Points = L30_2
    L31_2 = L4_1
    L31_2 = L31_2.Shared
    L31_2 = L31_2.PlotHandler
    L32_2 = L31_2
    L31_2 = L31_2.GetObjectValue
    L33_2 = L28_2
    L31_2 = L31_2(L32_2, L33_2)
    L11_2 = L11_2 + L31_2
    L31_2 = L23_2
    L32_2 = L28_2
    L31_2 = L31_2(L32_2)
    L29_2.Color = L31_2
    L32_2 = L28_2
    L31_2 = L28_2.FindFirstChild
    L33_2 = "ItemHolder"
    L31_2 = L31_2(L32_2, L33_2)
    if L31_2 then
      L31_2 = {}
      L32_2 = pairs
      L33_2 = L28_2.ItemHolder
      L34_2 = L33_2
      L33_2 = L33_2.GetChildren
      L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L33_2(L34_2)
      L32_2, L33_2, L34_2 = L32_2(L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      for L35_2, L36_2 in L32_2, L33_2, L34_2 do
        L38_2 = L36_2
        L37_2 = L36_2.IsA
        L39_2 = "BasePart"
        L37_2 = L37_2(L38_2, L39_2)
        if L37_2 then
          L37_2 = {}
          L38_2 = L36_2.Name
          L37_2.Name = L38_2
          L38_2 = L23_2
          L39_2 = L36_2
          L38_2 = L38_2(L39_2)
          L37_2.Color = L38_2
          L38_2 = L10_2
          L39_2 = L36_2.CFrame
          L38_2 = L38_2(L39_2)
          L37_2.CF = L38_2
          L38_2 = L4_1
          L38_2 = L38_2.Shared
          L38_2 = L38_2.PlotHandler
          L39_2 = L38_2
          L38_2 = L38_2.GetObjectValue
          L40_2 = L36_2
          L38_2 = L38_2(L39_2, L40_2)
          L11_2 = L11_2 + L38_2
          L38_2 = table
          L38_2 = L38_2.insert
          L39_2 = L31_2
          L40_2 = L37_2
          L38_2(L39_2, L40_2)
        end
      end
      L29_2.Objects = L31_2
    end
    L31_2 = table
    L31_2 = L31_2.insert
    L32_2 = L14_2
    L33_2 = L29_2
    L31_2(L32_2, L33_2)
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Roof
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = {}
    L30_2 = {}
    L31_2 = pairs
    L32_2 = L28_2.PointData
    L33_2 = L32_2
    L32_2 = L32_2.GetChildren
    L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
    L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
    for L34_2, L35_2 in L31_2, L32_2, L33_2 do
      L36_2 = L35_2.Value
      L37_2 = table
      L37_2 = L37_2.insert
      L38_2 = L30_2
      L39_2 = L9_2
      L40_2 = L3_2.Ground
      L40_2 = L40_2.CFrame
      L41_2 = L40_2
      L40_2 = L40_2.PointToWorldSpace
      L42_2 = L36_2
      L40_2 = L40_2(L41_2, L42_2)
      L41_2 = Vector3
      L41_2 = L41_2.new
      L42_2 = 0
      L43_2 = 0.05
      L44_2 = 0
      L41_2 = L41_2(L42_2, L43_2, L44_2)
      L40_2 = L40_2 + L41_2
      L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L39_2(L40_2)
      L37_2(L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
    end
    L29_2.Points = L30_2
    L31_2 = {}
    L32_2 = L28_2.Name
    L31_2.Type = L32_2
    L31_2.IsPreview = false
    L31_2.RotateNum = 0
    L29_2.Settings = L31_2
    L31_2 = pairs
    L32_2 = L28_2.PropertyData
    L33_2 = L32_2
    L32_2 = L32_2.GetChildren
    L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
    L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
    for L34_2, L35_2 in L31_2, L32_2, L33_2 do
      L36_2 = L29_2.Settings
      L37_2 = L35_2.Name
      L38_2 = L35_2.Value
      L36_2[L37_2] = L38_2
    end
    L31_2 = L4_1
    L31_2 = L31_2.Shared
    L31_2 = L31_2.PlotHandler
    L32_2 = L31_2
    L31_2 = L31_2.GetObjectValue
    L33_2 = L28_2
    L31_2 = L31_2(L32_2, L33_2)
    L11_2 = L11_2 + L31_2
    L31_2 = L23_2
    L32_2 = L28_2
    L31_2 = L31_2(L32_2)
    L29_2.Color = L31_2
    L32_2 = L28_2
    L31_2 = L28_2.FindFirstChild
    L33_2 = "ItemHolder"
    L31_2 = L31_2(L32_2, L33_2)
    if L31_2 then
      L31_2 = {}
      L32_2 = pairs
      L33_2 = L28_2.ItemHolder
      L34_2 = L33_2
      L33_2 = L33_2.GetChildren
      L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L33_2(L34_2)
      L32_2, L33_2, L34_2 = L32_2(L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      for L35_2, L36_2 in L32_2, L33_2, L34_2 do
        L38_2 = L36_2
        L37_2 = L36_2.IsA
        L39_2 = "BasePart"
        L37_2 = L37_2(L38_2, L39_2)
        if L37_2 then
          L37_2 = {}
          L38_2 = L36_2.Name
          L37_2.Name = L38_2
          L38_2 = L23_2
          L39_2 = L36_2
          L38_2 = L38_2(L39_2)
          L37_2.Color = L38_2
          L38_2 = L10_2
          L39_2 = L36_2.CFrame
          L38_2 = L38_2(L39_2)
          L37_2.CF = L38_2
          L38_2 = L4_1
          L38_2 = L38_2.Shared
          L38_2 = L38_2.PlotHandler
          L39_2 = L38_2
          L38_2 = L38_2.GetObjectValue
          L40_2 = L36_2
          L38_2 = L38_2(L39_2, L40_2)
          L11_2 = L11_2 + L38_2
          L38_2 = table
          L38_2 = L38_2.insert
          L39_2 = L31_2
          L40_2 = L37_2
          L38_2(L39_2, L40_2)
        end
      end
      L29_2.Objects = L31_2
    end
    L31_2 = table
    L31_2 = L31_2.insert
    L32_2 = L15_2
    L33_2 = L29_2
    L31_2(L32_2, L33_2)
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Fences
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = L28_2.Name
    if L29_2 ~= "Poles" then
      L29_2 = {}
      L30_2 = L4_1
      L30_2 = L30_2.Shared
      L30_2 = L30_2.FenceHandler
      L31_2 = L30_2
      L30_2 = L30_2.GetEdges
      L32_2 = L28_2
      L30_2, L31_2 = L30_2(L31_2, L32_2)
      L32_2 = L9_2
      L33_2 = L30_2.p
      L32_2 = L32_2(L33_2)
      L29_2.From = L32_2
      L32_2 = L9_2
      L33_2 = L31_2.p
      L32_2 = L32_2(L33_2)
      L29_2.To = L32_2
      L32_2 = L28_2.Name
      L29_2.Name = L32_2
      L32_2 = L23_2
      L33_2 = L28_2
      L32_2 = L32_2(L33_2)
      L29_2.Color = L32_2
      L32_2 = L4_1
      L32_2 = L32_2.Shared
      L32_2 = L32_2.PlotHandler
      L33_2 = L32_2
      L32_2 = L32_2.GetObjectValue
      L34_2 = L28_2
      L32_2 = L32_2(L33_2, L34_2)
      L11_2 = L11_2 + L32_2
      L33_2 = L28_2
      L32_2 = L28_2.FindFirstChild
      L34_2 = "ItemHolder"
      L32_2 = L32_2(L33_2, L34_2)
      if L32_2 then
        L32_2 = {}
        L33_2 = pairs
        L34_2 = L28_2.ItemHolder
        L35_2 = L34_2
        L34_2 = L34_2.GetChildren
        L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L34_2(L35_2)
        L33_2, L34_2, L35_2 = L33_2(L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
        for L36_2, L37_2 in L33_2, L34_2, L35_2 do
          L39_2 = L37_2
          L38_2 = L37_2.IsA
          L40_2 = "BasePart"
          L38_2 = L38_2(L39_2, L40_2)
          if L38_2 then
            L38_2 = {}
            L39_2 = L37_2.Name
            L38_2.Name = L39_2
            L39_2 = L10_2
            L40_2 = L37_2.CFrame
            L39_2 = L39_2(L40_2)
            L38_2.CF = L39_2
            L39_2 = L4_1
            L39_2 = L39_2.Shared
            L39_2 = L39_2.PlotHandler
            L40_2 = L39_2
            L39_2 = L39_2.GetObjectValue
            L41_2 = L37_2
            L39_2 = L39_2(L40_2, L41_2)
            L11_2 = L11_2 + L39_2
            L39_2 = L23_2
            L40_2 = L37_2
            L39_2 = L39_2(L40_2)
            L38_2.Color = L39_2
            L39_2 = table
            L39_2 = L39_2.insert
            L40_2 = L32_2
            L41_2 = L38_2
            L39_2(L40_2, L41_2)
          end
        end
        L29_2.Objects = L32_2
      end
      L32_2 = table
      L32_2 = L32_2.insert
      L33_2 = L16_2
      L34_2 = L29_2
      L32_2(L33_2, L34_2)
    end
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Counters
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = {}
    L30_2 = L28_2.Name
    L29_2.Name = L30_2
    L30_2 = L10_2
    L31_2 = L28_2.CFrame
    L30_2 = L30_2(L31_2)
    L29_2.CF = L30_2
    L30_2 = L4_1
    L30_2 = L30_2.Shared
    L30_2 = L30_2.PlotHandler
    L31_2 = L30_2
    L30_2 = L30_2.GetObjectValue
    L32_2 = L28_2
    L30_2 = L30_2(L31_2, L32_2)
    L11_2 = L11_2 + L30_2
    L30_2 = L23_2
    L31_2 = L28_2
    L30_2 = L30_2(L31_2)
    L29_2.Color = L30_2
    L31_2 = L28_2
    L30_2 = L28_2.FindFirstChild
    L32_2 = "ItemHolder"
    L30_2 = L30_2(L31_2, L32_2)
    if L30_2 then
      L30_2 = {}
      L31_2 = pairs
      L32_2 = L28_2.ItemHolder
      L33_2 = L32_2
      L32_2 = L32_2.GetChildren
      L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
      L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      for L34_2, L35_2 in L31_2, L32_2, L33_2 do
        L37_2 = L35_2
        L36_2 = L35_2.IsA
        L38_2 = "BasePart"
        L36_2 = L36_2(L37_2, L38_2)
        if L36_2 then
          L36_2 = {}
          L37_2 = L35_2.Name
          L36_2.Name = L37_2
          L37_2 = L10_2
          L38_2 = L35_2.CFrame
          L37_2 = L37_2(L38_2)
          L36_2.CF = L37_2
          L37_2 = L23_2
          L38_2 = L35_2
          L37_2 = L37_2(L38_2)
          L36_2.Color = L37_2
          L37_2 = L4_1
          L37_2 = L37_2.Shared
          L37_2 = L37_2.PlotHandler
          L38_2 = L37_2
          L37_2 = L37_2.GetObjectValue
          L39_2 = L35_2
          L37_2 = L37_2(L38_2, L39_2)
          L11_2 = L11_2 + L37_2
          L37_2 = table
          L37_2 = L37_2.insert
          L38_2 = L30_2
          L39_2 = L36_2
          L37_2(L38_2, L39_2)
        end
      end
      L29_2.Objects = L30_2
    end
    L30_2 = table
    L30_2 = L30_2.insert
    L31_2 = L17_2
    L32_2 = L29_2
    L30_2(L31_2, L32_2)
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Objects
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = {}
    L30_2 = L28_2.Name
    L29_2.Name = L30_2
    L30_2 = L23_2
    L31_2 = L28_2
    L30_2 = L30_2(L31_2)
    L29_2.Color = L30_2
    L30_2 = L10_2
    L31_2 = L28_2.CFrame
    L30_2 = L30_2(L31_2)
    L29_2.CF = L30_2
    L30_2 = L4_1
    L30_2 = L30_2.Shared
    L30_2 = L30_2.PlotHandler
    L31_2 = L30_2
    L30_2 = L30_2.GetObjectValue
    L32_2 = L28_2
    L30_2 = L30_2(L31_2, L32_2)
    L11_2 = L11_2 + L30_2
    L31_2 = L28_2
    L30_2 = L28_2.FindFirstChild
    L32_2 = "ItemHolder"
    L30_2 = L30_2(L31_2, L32_2)
    if L30_2 then
      L30_2 = {}
      L31_2 = pairs
      L32_2 = L28_2.ItemHolder
      L33_2 = L32_2
      L32_2 = L32_2.GetChildren
      L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
      L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      for L34_2, L35_2 in L31_2, L32_2, L33_2 do
        L37_2 = L35_2
        L36_2 = L35_2.IsA
        L38_2 = "BasePart"
        L36_2 = L36_2(L37_2, L38_2)
        if L36_2 then
          L36_2 = {}
          L37_2 = L35_2.Name
          L36_2.Name = L37_2
          L37_2 = L23_2
          L38_2 = L35_2
          L37_2 = L37_2(L38_2)
          L36_2.Color = L37_2
          L37_2 = L10_2
          L38_2 = L35_2.CFrame
          L37_2 = L37_2(L38_2)
          L36_2.CF = L37_2
          L37_2 = L4_1
          L37_2 = L37_2.Shared
          L37_2 = L37_2.PlotHandler
          L38_2 = L37_2
          L37_2 = L37_2.GetObjectValue
          L39_2 = L35_2
          L37_2 = L37_2(L38_2, L39_2)
          L11_2 = L11_2 + L37_2
          L37_2 = table
          L37_2 = L37_2.insert
          L38_2 = L30_2
          L39_2 = L36_2
          L37_2(L38_2, L39_2)
        end
      end
      L29_2.Objects = L30_2
    end
    L30_2 = table
    L30_2 = L30_2.insert
    L31_2 = L18_2
    L32_2 = L29_2
    L30_2(L31_2, L32_2)
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Basements
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = {}
    L30_2 = L28_2.Name
    L29_2.Name = L30_2
    L30_2 = L10_2
    L31_2 = L28_2.PrimaryPart
    L31_2 = L31_2.CFrame
    L30_2 = L30_2(L31_2)
    L29_2.Center = L30_2
    L30_2 = {}
    L31_2 = L28_2.PrimaryPart
    L31_2 = L31_2.Size
    L31_2 = L31_2.X
    L32_2 = L28_2.PrimaryPart
    L32_2 = L32_2.Size
    L32_2 = L32_2.Z
    L30_2[1] = L31_2
    L30_2[2] = L32_2
    L29_2.Size = L30_2
    L30_2 = L4_1
    L30_2 = L30_2.Shared
    L30_2 = L30_2.PlotHandler
    L31_2 = L30_2
    L30_2 = L30_2.GetObjectValue
    L32_2 = L28_2
    L30_2 = L30_2(L31_2, L32_2)
    L11_2 = L11_2 + L30_2
    L31_2 = L28_2
    L30_2 = L28_2.FindFirstChild
    L32_2 = "ItemHolder"
    L30_2 = L30_2(L31_2, L32_2)
    if L30_2 then
      L30_2 = {}
      L31_2 = pairs
      L32_2 = L28_2.ItemHolder
      L33_2 = L32_2
      L32_2 = L32_2.GetChildren
      L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
      L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      for L34_2, L35_2 in L31_2, L32_2, L33_2 do
        L37_2 = L35_2
        L36_2 = L35_2.IsA
        L38_2 = "BasePart"
        L36_2 = L36_2(L37_2, L38_2)
        if L36_2 then
          L36_2 = {}
          L37_2 = L35_2.Name
          L36_2.Name = L37_2
          L37_2 = L23_2
          L38_2 = L35_2
          L37_2 = L37_2(L38_2)
          L36_2.Color = L37_2
          L37_2 = L10_2
          L38_2 = L35_2.CFrame
          L37_2 = L37_2(L38_2)
          L36_2.CF = L37_2
          L37_2 = L4_1
          L37_2 = L37_2.Shared
          L37_2 = L37_2.PlotHandler
          L38_2 = L37_2
          L37_2 = L37_2.GetObjectValue
          L39_2 = L35_2
          L37_2 = L37_2(L38_2, L39_2)
          L11_2 = L11_2 + L37_2
          L37_2 = table
          L37_2 = L37_2.insert
          L38_2 = L30_2
          L39_2 = L36_2
          L37_2(L38_2, L39_2)
        end
      end
      L29_2.Objects = L30_2
    end
    L30_2 = table
    L30_2 = L30_2.insert
    L31_2 = L19_2
    L32_2 = L29_2
    L30_2(L31_2, L32_2)
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Pools
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = {}
    L30_2 = L28_2.Name
    L29_2.Name = L30_2
    L30_2 = L10_2
    L31_2 = L28_2.PrimaryPart
    L31_2 = L31_2.CFrame
    L30_2 = L30_2(L31_2)
    L29_2.Center = L30_2
    L30_2 = {}
    L31_2 = L28_2.PrimaryPart
    L31_2 = L31_2.Size
    L31_2 = L31_2.X
    L32_2 = L28_2.PrimaryPart
    L32_2 = L32_2.Size
    L32_2 = L32_2.Z
    L30_2[1] = L31_2
    L30_2[2] = L32_2
    L29_2.Size = L30_2
    L30_2 = L4_1
    L30_2 = L30_2.Shared
    L30_2 = L30_2.PlotHandler
    L31_2 = L30_2
    L30_2 = L30_2.GetObjectValue
    L32_2 = L28_2
    L30_2 = L30_2(L31_2, L32_2)
    L11_2 = L11_2 + L30_2
    L31_2 = L28_2
    L30_2 = L28_2.FindFirstChild
    L32_2 = "ItemHolder"
    L30_2 = L30_2(L31_2, L32_2)
    if L30_2 then
      L30_2 = {}
      L31_2 = pairs
      L32_2 = L28_2.ItemHolder
      L33_2 = L32_2
      L32_2 = L32_2.GetChildren
      L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
      L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
      for L34_2, L35_2 in L31_2, L32_2, L33_2 do
        L37_2 = L35_2
        L36_2 = L35_2.IsA
        L38_2 = "BasePart"
        L36_2 = L36_2(L37_2, L38_2)
        if L36_2 then
          L36_2 = {}
          L37_2 = L35_2.Name
          L36_2.Name = L37_2
          L37_2 = L23_2
          L38_2 = L35_2
          L37_2 = L37_2(L38_2)
          L36_2.Color = L37_2
          L37_2 = L10_2
          L38_2 = L35_2.CFrame
          L37_2 = L37_2(L38_2)
          L36_2.CF = L37_2
          L37_2 = L4_1
          L37_2 = L37_2.Shared
          L37_2 = L37_2.PlotHandler
          L38_2 = L37_2
          L37_2 = L37_2.GetObjectValue
          L39_2 = L35_2
          L37_2 = L37_2(L38_2, L39_2)
          L11_2 = L11_2 + L37_2
          L37_2 = table
          L37_2 = L37_2.insert
          L38_2 = L30_2
          L39_2 = L36_2
          L37_2(L38_2, L39_2)
        end
      end
      L29_2.Objects = L30_2
    end
    L30_2 = table
    L30_2 = L30_2.insert
    L31_2 = L20_2
    L32_2 = L29_2
    L30_2(L31_2, L32_2)
  end
  L24_2 = pairs
  L25_2 = L3_2.House
  L25_2 = L25_2.Paths
  L26_2 = L25_2
  L25_2 = L25_2.GetChildren
  L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L25_2(L26_2)
  L24_2, L25_2, L26_2 = L24_2(L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
  for L27_2, L28_2 in L24_2, L25_2, L26_2 do
    L29_2 = L28_2.Name
    if L29_2 ~= "Poles" then
      L29_2 = {}
      L30_2 = L28_2.Name
      L29_2.Name = L30_2
      L30_2 = L23_2
      L31_2 = L28_2
      L30_2 = L30_2(L31_2)
      L29_2.Color = L30_2
      L30_2 = L9_2
      L31_2 = L28_2.BPole
      L31_2 = L31_2.Value
      L31_2 = L31_2.Parent
      L31_2 = L31_2.Position
      L30_2 = L30_2(L31_2)
      L29_2.To = L30_2
      L30_2 = L9_2
      L31_2 = L28_2.FPole
      L31_2 = L31_2.Value
      L31_2 = L31_2.Parent
      L31_2 = L31_2.Position
      L30_2 = L30_2(L31_2)
      L29_2.From = L30_2
      L30_2 = L4_1
      L30_2 = L30_2.Shared
      L30_2 = L30_2.PlotHandler
      L31_2 = L30_2
      L30_2 = L30_2.GetObjectValue
      L32_2 = L28_2
      L30_2 = L30_2(L31_2, L32_2)
      L11_2 = L11_2 + L30_2
      L31_2 = L28_2
      L30_2 = L28_2.FindFirstChild
      L32_2 = "ItemHolder"
      L30_2 = L30_2(L31_2, L32_2)
      if L30_2 then
        L30_2 = {}
        L31_2 = pairs
        L32_2 = L28_2.ItemHolder
        L33_2 = L32_2
        L32_2 = L32_2.GetChildren
        L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2 = L32_2(L33_2)
        L31_2, L32_2, L33_2 = L31_2(L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2)
        for L34_2, L35_2 in L31_2, L32_2, L33_2 do
          L37_2 = L35_2
          L36_2 = L35_2.IsA
          L38_2 = "BasePart"
          L36_2 = L36_2(L37_2, L38_2)
          if L36_2 then
            L36_2 = {}
            L37_2 = L35_2.Name
            L36_2.Name = L37_2
            L37_2 = L23_2
            L38_2 = L35_2
            L37_2 = L37_2(L38_2)
            L36_2.Color = L37_2
            L37_2 = L10_2
            L38_2 = L35_2.CFrame
            L37_2 = L37_2(L38_2)
            L36_2.CF = L37_2
            L37_2 = L4_1
            L37_2 = L37_2.Shared
            L37_2 = L37_2.PlotHandler
            L38_2 = L37_2
            L37_2 = L37_2.GetObjectValue
            L39_2 = L35_2
            L37_2 = L37_2(L38_2, L39_2)
            L11_2 = L11_2 + L37_2
            L37_2 = table
            L37_2 = L37_2.insert
            L38_2 = L30_2
            L39_2 = L36_2
            L37_2(L38_2, L39_2)
          end
        end
        L29_2.Objects = L30_2
      end
      L30_2 = table
      L30_2 = L30_2.insert
      L31_2 = L21_2
      L32_2 = L29_2
      L30_2(L31_2, L32_2)
    end
  end
  L24_2 = {}
  L24_2.Move = nil
  L25_2 = {}
  L24_2.Objects = L25_2
  L12_2.FrontObjects = L24_2
  L12_2.Walls = L13_2
  L12_2.Floors = L14_2
  L12_2.Roofs = L15_2
  L12_2.Counters = L17_2
  L12_2.Fences = L16_2
  L12_2.Objects = L18_2
  L12_2.Basements = L19_2
  L12_2.Pools = L20_2
  L12_2.Paths = L21_2
  L12_2.Money = L11_2
  L24_2 = A0_2.schema_version
  L12_2.FileVersion = L24_2
  L24_2 = game
  L24_2 = L24_2.Players
  L24_2 = L24_2.LocalPlayer
  L24_2 = L24_2.UserId
  L12_2.user_id = L24_2
  L24_2 = game
  L25_2 = L24_2
  L24_2 = L24_2.GetService
  L26_2 = "HttpService"
  L24_2 = L24_2(L25_2, L26_2)
  L25_2 = L24_2
  L24_2 = L24_2.JSONEncode
  L26_2 = L12_2
  L24_2 = L24_2(L25_2, L26_2)
  L26_2 = A0_2
  L25_2 = A0_2.http_request
  L27_2 = {}
  L27_2.Url = "https://api.applebee1558.com/alphax/v2/bloxburg_bases"
  L28_2 = {}
  L28_2["Content-Type"] = "application/json"
  L27_2.Headers = L28_2
  L27_2.Method = "POST"
  L27_2.Body = L24_2
  L25_2 = L25_2(L26_2, L27_2)
  L26_2 = L25_2.StatusCode
  if L26_2 == 200 then
    L26_2 = game
    L26_2 = L26_2.HttpService
    L27_2 = L26_2
    L26_2 = L26_2.JSONDecode
    L28_2 = L25_2.Body
    return L26_2(L27_2, L28_2)
  end
  L26_2 = pcall
  L27_2 = game
  L27_2 = L27_2.HttpService
  L27_2 = L27_2.JSONDecode
  L28_2 = game
  L28_2 = L28_2.HttpService
  L29_2 = L25_2.Body
  L26_2, L27_2 = L26_2(L27_2, L28_2, L29_2)
  if L26_2 then
    return L27_2
  end
  L28_2 = {}
  L28_2.message = L27_2
  L28_2.code = 4000
end

L25_1.save_base = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A1_2 % 60
  L2_2 = A1_2 - L2_2
  L2_2 = L2_2 / 60
  L3_2 = L2_2 * 60
  A1_2 = A1_2 - L3_2
  L3_2 = L2_2 % 60
  L3_2 = L2_2 - L3_2
  L3_2 = L3_2 / 60
  L4_2 = L3_2 * 60
  L2_2 = L2_2 - L4_2
  L4_2 = L3_2
  L5_2 = L2_2
  L6_2 = A1_2
end

L25_1.split_time = L26_1

function L26_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2)
  local L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2
  L8_2 = game
  L8_2 = L8_2.Players
  L8_2 = L8_2.LocalPlayer
  L9_2 = pairs
  L10_2 = game
  L11_2 = L10_2
  L10_2 = L10_2.GetService
  L12_2 = "ReplicatedStorage"
  L10_2 = L10_2(L11_2, L12_2)
  L10_2 = L10_2.Stats
  L11_2 = L8_2.Name
  L10_2 = L10_2[L11_2]
  L10_2 = L10_2.Gamepasses
  L11_2 = L10_2
  L10_2 = L10_2.GetChildren
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L10_2(L11_2)
  L9_2, L10_2, L11_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
  for L12_2, L13_2 in L9_2, L10_2, L11_2 do
    L14_2 = game
    L15_2 = L14_2
    L14_2 = L14_2.GetService
    L16_2 = "MarketplaceService"
    L14_2 = L14_2(L15_2, L16_2)
    L15_2 = L14_2
    L14_2 = L14_2.UserOwnsGamePassAsync
    L16_2 = L8_2.UserId
    L17_2 = tonumber
    L18_2 = L13_2.Name
    L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L17_2(L18_2)
    L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    L15_2 = L13_2.Value
    if L14_2 ~= L15_2 then
      L16_2 = L8_2
      L15_2 = L8_2.Kick
      L17_2 = "Exploit Detection: Attempted to use free gamepass exploits!"
      L15_2(L16_2, L17_2)
      return
    end
  end
  L9_2 = game
  L10_2 = L9_2
  L9_2 = L9_2.GetService
  L11_2 = "Workspace"
  L9_2 = L9_2(L10_2, L11_2)
  L9_2 = L9_2.Plots
  L10_2 = L9_2
  L9_2 = L9_2.FindFirstChild
  L11_2 = "Plot_"
  L12_2 = A2_2.Name
  L11_2 = L11_2 .. L12_2
  L9_2 = L9_2(L10_2, L11_2)
  if not L9_2 then
    L11_2 = A0_2
    L10_2 = A0_2.notify
    L12_2 = A2_2.Name
    L13_2 = " does not have a plot!"
    L12_2 = L12_2 .. L13_2
    L13_2 = "Base Building"
    L10_2(L11_2, L12_2, L13_2)
    return
  end
  L10_2 = A4_2
  L11_2 = "Loading..."
  L10_2(L11_2)
  
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = {}
    L3_3 = A0_3
    L2_3 = A0_3.components
    L2_3, L3_3 = L2_3(L3_3)
    L1_3[1] = L2_3
    L1_3[2] = L3_3
  end
  
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = CFrame
    L1_3 = L1_3.new
    L2_3 = unpack
    L3_3 = A0_3
    L2_3, L3_3 = L2_3(L3_3)
  end
  
  function L12_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = {}
    L2_3 = A0_3.X
    L3_3 = A0_3.Y
    L4_3 = A0_3.Z
    L1_3[1] = L2_3
    L1_3[2] = L3_3
    L1_3[3] = L4_3
  end
  
  function L13_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = Vector3
    L1_3 = L1_3.new
    L2_3 = unpack
    L3_3 = A0_3
    L2_3, L3_3 = L2_3(L3_3)
  end
  
  function L14_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.ObjectManager
    L2_3 = L1_3
    L1_3 = L1_3.RoundToSaveResolution
    L3_3 = CFrame
    L3_3 = L3_3.new
    L4_3 = A0_3
    L3_3, L4_3, L5_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
    L1_3 = L1_3.p
    L2_3 = L12_2
    L3_3 = L9_2
    L3_3 = L3_3.Water
    L3_3 = L3_3.CFrame
    L4_3 = L3_3
    L3_3 = L3_3.PointToObjectSpace
    L5_3 = L1_3
    L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
  end
  
  function L15_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.ObjectManager
    L2_3 = L1_3
    L1_3 = L1_3.RoundToSaveResolution
    L3_3 = A0_3
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L10_2
    L3_3 = L9_2
    L3_3 = L3_3.Water
    L3_3 = L3_3.CFrame
    L4_3 = L3_3
    L3_3 = L3_3.ToObjectSpace
    L5_3 = L1_3
    L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
  end
  
  L16_2 = A1_2
  L17_2 = L16_2.FileVersion
  L18_2 = A0_2.schema_version
  if L17_2 ~= L18_2 then
    L17_2 = A4_2
    L18_2 = "Base ID Outdated! Please re-save the base again!"
    L17_2(L18_2)
    return
  end
  L17_2 = tostring
  L18_2 = L4_1
  L18_2 = L18_2.Shared
  L18_2 = L18_2.PlotHandler
  L19_2 = L18_2
  L18_2 = L18_2.GetBuildPlot
  L20_2 = L8_2
  L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L18_2(L19_2, L20_2)
  L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
  L18_2 = "Plot_"
  L19_2 = A2_2.Name
  L18_2 = L18_2 .. L19_2
  if L17_2 ~= L18_2 then
    L17_2 = L18_1
    L18_2 = L17_2
    L17_2 = L17_2.CreateNotification
    L19_2 = "Error"
    L20_2 = nil
    L21_2 = "Please enter build mode in "
    L22_2 = A2_2.Name
    L23_2 = "'s Base first before auto-building!"
    L21_2 = L21_2 .. L22_2 .. L23_2
    L17_2(L18_2, L19_2, L20_2, L21_2)
    return
  end
  L17_2 = game
  L18_2 = L17_2
  L17_2 = L17_2.GetService
  L19_2 = "ReplicatedStorage"
  L17_2 = L17_2(L18_2, L19_2)
  L17_2 = L17_2.Stats
  L18_2 = A2_2.Name
  L17_2 = L17_2[L18_2]
  L17_2 = L17_2.Money
  L17_2 = L17_2.Value
  L18_2 = L16_2.Money
  if L17_2 < L18_2 then
    L17_2 = L16_1
    L17_2 = L17_2.ConfirmBox
    L18_2 = nil
    L19_2 = [[
You don't have enough money to load this base.
This base will not be loaded fully.
 You need $]]
    L20_2 = tostring
    L21_2 = L16_2.Money
    L22_2 = game
    L23_2 = L22_2
    L22_2 = L22_2.GetService
    L24_2 = "ReplicatedStorage"
    L22_2 = L22_2(L23_2, L24_2)
    L22_2 = L22_2.Stats
    L23_2 = L8_2.Name
    L22_2 = L22_2[L23_2]
    L22_2 = L22_2.Money
    L22_2 = L22_2.Value
    L21_2 = L21_2 - L22_2
    L20_2 = L20_2(L21_2)
    L21_2 = [[
 more to load this base fully.
Do you still want to load?]]
    L19_2 = L19_2 .. L20_2 .. L21_2
    L20_2 = "Error"
    L21_2 = 0
    L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
    if not L17_2 then
      return
    end
  end
  L17_2 = 0
  L18_2 = pairs
  L19_2 = L16_2.Objects
  L18_2, L19_2, L20_2 = L18_2(L19_2)
  for L21_2, L22_2 in L18_2, L19_2, L20_2 do
    L23_2 = L4_1
    L23_2 = L23_2.Items
    L24_2 = L23_2
    L23_2 = L23_2.GetItem
    L25_2 = L22_2.Name
    L23_2 = L23_2(L24_2, L25_2)
    if L23_2 then
      L23_2 = L4_1
      L23_2 = L23_2.Items
      L24_2 = L23_2
      L23_2 = L23_2.GetItem
      L25_2 = L22_2.Name
      L23_2 = L23_2(L24_2, L25_2)
      L23_2 = L23_2.BSPrice
      if L23_2 then
        L23_2 = L4_1
        L23_2 = L23_2.Items
        L24_2 = L23_2
        L23_2 = L23_2.GetItem
        L25_2 = L22_2.Name
        L23_2 = L23_2(L24_2, L25_2)
        L23_2 = L23_2.BSPrice
        L17_2 = L17_2 + L23_2
      end
    end
  end
  L18_2 = [[
Do you really want to load base from file?
Money Required : ]]
  L19_2 = tostring
  L20_2 = L16_2.Money
  L20_2 = L20_2 - L17_2
  L19_2 = L19_2(L20_2)
  L20_2 = [[

Sell Value : ]]
  L21_2 = tostring
  L22_2 = math
  L22_2 = L22_2.round
  L23_2 = L16_2.Money
  L24_2 = L4_1
  L24_2 = L24_2.Shared
  L24_2 = L24_2.PlotHandler
  L24_2 = L24_2.SellPercentage
  L23_2 = L23_2 * L24_2
  L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L22_2(L23_2)
  L21_2 = L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
  L18_2 = L18_2 .. L19_2 .. L20_2 .. L21_2
  if A3_2 and L17_2 ~= 0 then
    L19_2 = L18_2
    L20_2 = [[

Bloxbucks Value : ]]
    L21_2 = tostring
    L22_2 = L17_2
    L21_2 = L21_2(L22_2)
    L18_2 = L19_2 .. L20_2 .. L21_2
  end
  L19_2 = L16_1
  L19_2 = L19_2.ConfirmBox
  L20_2 = nil
  L21_2 = L18_2
  L22_2 = [[

Use Bloxbucks : ]]
  L23_2 = tostring
  L24_2 = A3_2
  L23_2 = L23_2(L24_2)
  L24_2 = [[

This build may require gamepasses.]]
  L21_2 = L21_2 .. L22_2 .. L23_2 .. L24_2
  L22_2 = "Info"
  L23_2 = 3
  L19_2 = L19_2(L20_2, L21_2, L22_2, L23_2)
  if not L19_2 then
    return
  end
  
  function L20_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = L9_2
    L1_3 = L1_3.Water
    L1_3 = L1_3.CFrame
    L2_3 = L1_3
    L1_3 = L1_3.PointToWorldSpace
    L3_3 = L13_2
    L4_3 = A0_3
    L3_3, L4_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3)
  end
  
  function L21_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = L9_2
    L1_3 = L1_3.Water
    L1_3 = L1_3.CFrame
    L2_3 = L1_3
    L1_3 = L1_3.ToWorldSpace
    L3_3 = L11_2
    L4_3 = A0_3
    L3_3, L4_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3)
  end
  
  function L22_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L1_3 = RaycastParams
    L1_3 = L1_3.new
    L1_3 = L1_3()
    L2_3 = Enum
    L2_3 = L2_3.RaycastFilterType
    L2_3 = L2_3.Whitelist
    L1_3.FilterType = L2_3
    L2_3 = {}
    L3_3 = L9_2
    L2_3[1] = L3_3
    L1_3.FilterDescendantsInstances = L2_3
    L1_3.IgnoreWater = true
    L2_3 = game
    L2_3 = L2_3.Workspace
    L3_3 = L2_3
    L2_3 = L2_3.Raycast
    L4_3 = A0_3
    L5_3 = Vector3
    L5_3 = L5_3.new
    L6_3 = 0
    L7_3 = -100
    L8_3 = 0
    L5_3 = L5_3(L6_3, L7_3, L8_3)
    L6_3 = L1_3
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = nil
    if L2_3 then
      L4_3 = L2_3.Instance
      if L4_3 then
        L3_3 = L2_3.Instance
        L4_3 = L3_3.Parent
        L5_3 = L9_2
        L6_3 = L5_3
        L5_3 = L5_3.FindFirstChild
        L7_3 = "GroundParts"
        L5_3 = L5_3(L6_3, L7_3)
        if L4_3 == L5_3 then
          goto lbl_64
        end
        L4_3 = L3_3.Parent
        L5_3 = L9_2
        if L4_3 == L5_3 then
          goto lbl_64
        end
        L4_3 = L3_3.Parent
        if L4_3 then
          while true do
            L4_3 = L3_3.Parent
            L4_3 = L4_3.Parent
            L5_3 = L9_2
            L5_3 = L5_3.House
            if L4_3 == L5_3 then
              break
            end
            L3_3 = L3_3.Parent
          end
        else
          L4_3 = L9_2
          L4_3 = L4_3.PrimaryPart
          do return L4_3 end
          L4_3 = L9_2
          L4_3 = L4_3.PrimaryPart
          do return L4_3 end
          L4_3 = L9_2
          L4_3 = L4_3.PrimaryPart
          return L4_3
        end
      end
    end
    ::lbl_64::
  end
  
  function L23_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
    L1_3 = math
    L1_3 = L1_3.atan2
    L2_3 = A0_3.lookVector
    L2_3 = L2_3.z
    L3_3 = A0_3.lookVector
    L3_3 = L3_3.x
    L1_3 = L1_3(L2_3, L3_3)
    L1_3 = -L1_3
    L2_3 = math
    L2_3 = L2_3.pi
    L2_3 = L2_3 * 0.5
    L1_3 = L1_3 - L2_3
    if L1_3 < 0 then
      L2_3 = math
      L2_3 = L2_3.pi
      L2_3 = 2 * L2_3
      L1_3 = L2_3 + L1_3
    end
  end
  
  function L24_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = {}
    L2_3 = 1
    L3_3 = 4
    L4_3 = 1
    for L5_3 = L2_3, L3_3, L4_3 do
      L6_3 = A0_3[L5_3]
      if L6_3 then
        L6_3 = A0_3[L5_3]
        L6_3 = #L6_3
        if L6_3 ~= 0 then
          L6_3 = {}
          L1_3[L5_3] = L6_3
          L6_3 = A0_3[L5_3]
          L6_3 = L6_3[1]
          if L6_3 ~= 0 then
            L6_3 = L1_3[L5_3]
            L7_3 = BrickColor
            L7_3 = L7_3.new
            L8_3 = A0_3[L5_3]
            L8_3 = L8_3[1]
            L7_3 = L7_3(L8_3)
            L7_3 = L7_3.Number
            L6_3[1] = L7_3
          else
            L6_3 = L1_3[L5_3]
            L6_3[1] = 0
          end
          L6_3 = A0_3[L5_3]
          L6_3 = L6_3[2]
          if L6_3 ~= 0 then
            L6_3 = L4_1
            L6_3 = L6_3.Shared
            L6_3 = L6_3.MaterialData
            L6_3 = L6_3.Materials
            L7_3 = tostring
            L8_3 = A0_3[L5_3]
            L8_3 = L8_3[2]
            L7_3 = L7_3(L8_3)
            L6_3 = L6_3[L7_3]
            if L6_3 then
              L6_3 = L1_3[L5_3]
              L7_3 = L4_1
              L7_3 = L7_3.Shared
              L7_3 = L7_3.MaterialData
              L7_3 = L7_3.Materials
              L8_3 = tostring
              L9_3 = A0_3[L5_3]
              L9_3 = L9_3[2]
              L8_3 = L8_3(L9_3)
              L7_3 = L7_3[L8_3]
              L7_3 = L7_3.ID
              L6_3[2] = L7_3
            else
              L6_3 = L1_3[L5_3]
              L6_3[2] = 0
            end
          else
            L6_3 = L1_3[L5_3]
            L6_3[2] = 0
          end
      end
      else
        L6_3 = {}
        L1_3[L5_3] = L6_3
      end
    end
  end
  
  function L25_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3 = L4_1
    L1_3 = L1_3.Items
    L2_3 = L1_3
    L1_3 = L1_3.GetItem
    L3_3 = A0_3
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L2_3 = L1_3.Price
      if not L2_3 then
        L2_3 = L1_3.BSPrice
        if not L2_3 then
          goto lbl_70
        end
      end
      L2_3 = L1_3.Hidden
      if L2_3 then
        L2_3 = false
        return L2_3
      end
      L2_3 = L1_3.BSPrice
      if L2_3 then
        L2_3 = A3_2
        if not L2_3 then
          L2_3 = warn
          L3_3 = "Skipped "
          L4_3 = A0_3
          L5_3 = ". Because of BSPrice"
          L3_3 = L3_3 .. L4_3 .. L5_3
          L2_3(L3_3)
          L2_3 = A0_2
          L3_3 = L2_3
          L2_3 = L2_3.notify
          L4_3 = string
          L4_3 = L4_3.format
          L5_3 = "Skipped %s due to Bloxbuck Disabled!"
          L6_3 = A0_3
          L4_3 = L4_3(L5_3, L6_3)
          L5_3 = "AutoBuild"
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = false
          return L2_3
        end
      end
      L2_3 = L4_1
      L2_3 = L2_3.Shared
      L2_3 = L2_3.ItemManager
      L3_3 = L2_3
      L2_3 = L2_3.IsLocked
      L4_3 = L1_3
      L5_3 = L8_2
      L2_3 = L2_3(L3_3, L4_3, L5_3)
      if L2_3 then
        L2_3 = warn
        L3_3 = "Skipped "
        L4_3 = A0_3
        L5_3 = ". Because of your skill levels."
        L3_3 = L3_3 .. L4_3 .. L5_3
        L2_3(L3_3)
        L2_3 = A0_2
        L3_3 = L2_3
        L2_3 = L2_3.notify
        L4_3 = string
        L4_3 = L4_3.format
        L5_3 = "Skipped %s due to your Skill Levels!"
        L6_3 = A0_3
        L4_3 = L4_3(L5_3, L6_3)
        L5_3 = "AutoBuild"
        L2_3(L3_3, L4_3, L5_3)
        L2_3 = false
        return L2_3
      end
      L2_3 = true
      return L2_3
    end
    ::lbl_70::
    L2_3 = false
  end
  
  L26_2 = 1
  
  function L27_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
    L0_3 = L26_2
    L0_3 = L0_3 + 1
    L26_2 = L0_3
    L0_3 = L26_2
    if 4 < L0_3 then
      L0_3 = wait
      L1_3 = 2.8
      L0_3(L1_3)
      L0_3 = 1
      L26_2 = L0_3
    end
  end
  
  function L28_2(...)
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L1_3 = L0_1
    if not L1_3 then
      return
    end
    L1_3 = "[AutoBuild / DEBUG]:"
    L2_3 = pairs
    L3_3 = {}
    L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = ...
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L2_3, L3_3, L4_3 = L2_3(L3_3)
    for L5_3, L6_3 in L2_3, L3_3, L4_3 do
      L7_3 = L1_3
      L8_3 = " "
      L9_3 = tostring
      L10_3 = L6_3
      L9_3 = L9_3(L10_3)
      L1_3 = L7_3 .. L8_3 .. L9_3
    end
    L2_3 = L21_1
    if L2_3 then
      L2_3 = L21_1
      L3_3 = L1_3
      L4_3 = "\n"
      L3_3 = L3_3 .. L4_3
      L2_3(L3_3)
    else
      L2_3 = print
      L3_3 = L1_3
      L2_3(L3_3)
    end
  end
  
  L29_2 = 0
  L30_2 = game
  L31_2 = L30_2
  L30_2 = L30_2.GetService
  L32_2 = "ReplicatedStorage"
  L30_2 = L30_2(L31_2, L32_2)
  L30_2 = L30_2.Stats
  L31_2 = A2_2.Name
  L30_2 = L30_2[L31_2]
  L30_2 = L30_2.Money
  L30_2 = L30_2.Value
  L31_2 = 0
  L32_2 = 0
  
  function L33_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L1_3 = pairs
    L2_3 = A0_3
    L1_3, L2_3, L3_3 = L1_3(L2_3)
    for L4_3, L5_3 in L1_3, L2_3, L3_3 do
      L6_3 = type
      L7_3 = L5_3
      L6_3 = L6_3(L7_3)
      if L6_3 == "table" then
        L6_3 = L5_3.Objects
        if L6_3 ~= nil then
          L6_3 = L29_2
          L7_3 = L5_3.Objects
          L7_3 = #L7_3
          L6_3 = L6_3 + L7_3
          L29_2 = L6_3
          L6_3 = pairs
          L7_3 = L5_3.Objects
          L6_3, L7_3, L8_3 = L6_3(L7_3)
          for L9_3, L10_3 in L6_3, L7_3, L8_3 do
            L11_3 = L10_3.Objects
            if L11_3 ~= nil then
              L11_3 = L33_2
              L12_3 = {}
              L13_3 = L10_3
              L12_3[1] = L13_3
              L11_3(L12_3)
            end
          end
        end
      end
    end
  end
  
  L34_2 = pairs
  L35_2 = A1_2
  L34_2, L35_2, L36_2 = L34_2(L35_2)
  for L37_2, L38_2 in L34_2, L35_2, L36_2 do
    L39_2 = type
    L40_2 = L38_2
    L39_2 = L39_2(L40_2)
    if L39_2 == "table" then
      L39_2 = L33_2
      L40_2 = L38_2
      L39_2(L40_2)
      L39_2 = #L38_2
      L29_2 = L29_2 + L39_2
    end
  end
  L34_2 = nil
  L35_2 = {}
  L36_2 = 0.75
  
  function L37_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = L32_2
    L0_3 = L0_3 + 1
    L32_2 = L0_3
    L0_3 = A6_2
    L1_3 = L32_2
    L2_3 = L29_2
    L0_3(L1_3, L2_3)
    L0_3 = L34_2
    if L0_3 == nil then
      L0_3 = tick
      L0_3 = L0_3()
      L34_2 = L0_3
    else
      L0_3 = tick
      L0_3 = L0_3()
      L1_3 = L34_2
      L0_3 = L0_3 - L1_3
      L1_3 = table
      L1_3 = L1_3.insert
      L2_3 = L35_2
      L3_3 = L0_3
      L1_3(L2_3, L3_3)
      L1_3 = 0
      L2_3 = pairs
      L3_3 = L35_2
      L2_3, L3_3, L4_3 = L2_3(L3_3)
      for L5_3, L6_3 in L2_3, L3_3, L4_3 do
        L1_3 = L1_3 + L6_3
      end
      L2_3 = L35_2
      L2_3 = #L2_3
      L2_3 = L1_3 / L2_3
      L36_2 = L2_3
      L2_3 = tick
      L2_3 = L2_3()
      L34_2 = L2_3
    end
    L0_3 = A5_2
    L1_3 = A0_2
    L2_3 = L1_3
    L1_3 = L1_3.split_time
    L3_3 = L29_2
    L4_3 = L32_2
    L3_3 = L3_3 - L4_3
    L4_3 = L36_2
    L3_3 = L3_3 * L4_3
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3 = L1_3(L2_3, L3_3)
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3)
  end
  
  L38_2 = A6_2
  L39_2 = 0
  L40_2 = L29_2
  L38_2(L39_2, L40_2)
  L38_2 = A4_2
  L39_2 = "Building Base..."
  L38_2(L39_2)
  L38_2 = L16_2.FrontObjects
  if L38_2 then
    L38_2 = L23_1
    L39_2 = L38_2
    L38_2 = L38_2.InvokeServer
    L40_2 = {}
    L40_2.Type = "MoveFrontObjects"
    L41_2 = L16_2.FrontObjects
    L41_2 = L41_2.Move
    L40_2.Pos = L41_2
    L38_2(L39_2, L40_2)
  end
  L38_2 = L28_2
  L39_2 = "Building Floors!"
  L38_2(L39_2)
  L38_2 = A4_2
  L39_2 = "Building Floors..."
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Floors
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = {}
    L44_2 = pairs
    L45_2 = L42_2.Points
    L44_2, L45_2, L46_2 = L44_2(L45_2)
    for L47_2, L48_2 in L44_2, L45_2, L46_2 do
      L49_2 = table
      L49_2 = L49_2.insert
      L50_2 = L43_2
      L51_2 = L20_2
      L52_2 = L48_2
      L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2)
      L49_2(L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    end
    L44_2 = L27_2
    L44_2()
    L44_2 = L23_1
    L45_2 = L44_2
    L44_2 = L44_2.InvokeServer
    L46_2 = {}
    L46_2.Type = "PlaceFloor"
    L46_2.Points = L43_2
    L44_2, L45_2 = L44_2(L45_2, L46_2)
    L46_2 = L37_2
    L46_2()
    if not L44_2 then
      L46_2 = print
      L47_2 = L44_2
      L48_2 = L45_2
      L46_2(L47_2, L48_2)
      L31_2 = L31_2 + 1
    end
    if L44_2 then
      L46_2 = L23_1
      L47_2 = L46_2
      L46_2 = L46_2.InvokeServer
      L48_2 = {}
      L48_2.Type = "ColorObject"
      L48_2.Object = L44_2
      L48_2.UseMaterials = true
      L49_2 = L24_2
      L50_2 = L42_2.Color
      L49_2 = L49_2(L50_2)
      L48_2.Data = L49_2
      L46_2(L47_2, L48_2)
      L46_2 = L42_2.Objects
      if L46_2 then
        L46_2 = pairs
        L47_2 = L42_2.Objects
        L46_2, L47_2, L48_2 = L46_2(L47_2)
        for L49_2, L50_2 in L46_2, L47_2, L48_2 do
          L51_2 = L37_2
          L51_2()
          L51_2 = L25_2
          L52_2 = L50_2.Name
          L51_2 = L51_2(L52_2)
          if L51_2 then
            L51_2 = L50_2.Side
            if not L51_2 then
              L50_2.Side = true
            end
            L51_2 = L27_2
            L51_2()
            L51_2 = L23_1
            L52_2 = L51_2
            L51_2 = L51_2.InvokeServer
            L53_2 = {}
            L53_2.Type = "PlaceObject"
            L54_2 = L50_2.Name
            L53_2.Name = L54_2
            L54_2 = L50_2.Side
            L53_2.Side = L54_2
            L53_2.TargetModel = L44_2
            L54_2 = L21_2
            L55_2 = L50_2.CF
            L54_2 = L54_2(L55_2)
            L54_2 = L54_2.p
            L53_2.Pos = L54_2
            L54_2 = L23_2
            L55_2 = L21_2
            L56_2 = L50_2.CF
            L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L55_2(L56_2)
            L54_2 = L54_2(L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
            L53_2.Rot = L54_2
            L51_2, L52_2 = L51_2(L52_2, L53_2)
            L53_2 = L23_1
            L54_2 = L53_2
            L53_2 = L53_2.InvokeServer
            L55_2 = {}
            L55_2.Type = "ColorObject"
            L55_2.Object = L51_2
            L55_2.UseMaterials = true
            L56_2 = L24_2
            L57_2 = L50_2.Color
            L56_2 = L56_2(L57_2)
            L55_2.Data = L56_2
            L53_2(L54_2, L55_2)
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Basements!"
  L38_2(L39_2)
  L38_2 = A4_2
  L39_2 = "Building Basements..."
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Basements
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = L27_2
    L43_2()
    L43_2 = L23_1
    L44_2 = L43_2
    L43_2 = L43_2.InvokeServer
    L45_2 = {}
    L45_2.Type = "PlaceBasement"
    L46_2 = L9_2.Ground
    L46_2 = L46_2.CFrame
    L47_2 = L46_2
    L46_2 = L46_2.ToObjectSpace
    L48_2 = L21_2
    L49_2 = L42_2.Center
    L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L48_2(L49_2)
    L46_2 = L46_2(L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    L45_2.Center = L46_2
    L46_2 = Vector2
    L46_2 = L46_2.new
    L47_2 = unpack
    L48_2 = L42_2.Size
    L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L47_2(L48_2)
    L46_2 = L46_2(L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    L45_2.Size = L46_2
    L43_2, L44_2 = L43_2(L44_2, L45_2)
    L45_2 = L37_2
    L45_2()
    if not L43_2 then
      L31_2 = L31_2 + 1
    end
    L45_2 = L42_2.Objects
    if L45_2 and L43_2 then
      L45_2 = pairs
      L46_2 = L42_2.Objects
      L45_2, L46_2, L47_2 = L45_2(L46_2)
      for L48_2, L49_2 in L45_2, L46_2, L47_2 do
        L50_2 = L37_2
        L50_2()
        L50_2 = L25_2
        L51_2 = L49_2.Name
        L50_2 = L50_2(L51_2)
        if L50_2 then
          L50_2 = L49_2.Side
          if not L50_2 then
            L49_2.Side = true
          end
          L50_2 = A4_2
          L51_2 = string
          L51_2 = L51_2.format
          L52_2 = "Building %s..."
          L53_2 = L49_2.Name
          L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
          L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
          L50_2 = L27_2
          L50_2()
          L50_2 = L23_1
          L51_2 = L50_2
          L50_2 = L50_2.InvokeServer
          L52_2 = {}
          L52_2.Type = "PlaceObject"
          L53_2 = L49_2.Name
          L52_2.Name = L53_2
          L53_2 = L49_2.Side
          L52_2.Side = L53_2
          L52_2.TargetModel = L43_2
          L53_2 = L21_2
          L54_2 = L49_2.CF
          L53_2 = L53_2(L54_2)
          L53_2 = L53_2.p
          L52_2.Pos = L53_2
          L53_2 = L23_2
          L54_2 = L21_2
          L55_2 = L49_2.CF
          L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
          L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
          L52_2.Rot = L53_2
          L50_2, L51_2 = L50_2(L51_2, L52_2)
          L52_2 = L23_1
          L53_2 = L52_2
          L52_2 = L52_2.InvokeServer
          L54_2 = {}
          L54_2.Type = "ColorObject"
          L54_2.Object = L50_2
          L54_2.UseMaterials = true
          L55_2 = L24_2
          L56_2 = L49_2.Color
          L55_2 = L55_2(L56_2)
          L54_2.Data = L55_2
          L52_2(L53_2, L54_2)
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Walls!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Walls
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = "Building Wall"
    L43_2(L44_2)
    L43_2 = L37_2
    L43_2()
    L43_2 = L27_2
    L43_2()
    L43_2 = L23_1
    L44_2 = L43_2
    L43_2 = L43_2.InvokeServer
    L45_2 = {}
    L45_2.Type = "PlaceWall"
    L46_2 = L20_2
    L47_2 = L42_2.To
    L46_2 = L46_2(L47_2)
    L45_2.To = L46_2
    L46_2 = L20_2
    L47_2 = L42_2.From
    L46_2 = L46_2(L47_2)
    L45_2.From = L46_2
    L43_2, L44_2 = L43_2(L44_2, L45_2)
    if not L43_2 then
      L45_2 = print
      L46_2 = L43_2
      L47_2 = L44_2
      L45_2(L46_2, L47_2)
      L31_2 = L31_2 + 1
    else
      L45_2 = L42_2.Color
      L45_2 = L45_2.R
      L45_2 = #L45_2
      if L45_2 == 2 then
        L45_2 = L23_1
        L46_2 = L45_2
        L45_2 = L45_2.InvokeServer
        L47_2 = {}
        L47_2.Type = "ColorObject"
        L47_2.Object = L43_2
        L47_2.UseMaterials = true
        L48_2 = L24_2
        L49_2 = {}
        L50_2 = L42_2.Color
        L50_2 = L50_2.R
        L49_2[1] = L50_2
        L48_2 = L48_2(L49_2)
        L47_2.Data = L48_2
        L47_2.Side = "R"
        L45_2(L46_2, L47_2)
        L45_2 = L23_1
        L46_2 = L45_2
        L45_2 = L45_2.InvokeServer
        L47_2 = {}
        L47_2.Type = "ColorObject"
        L47_2.Object = L43_2
        L47_2.UseMaterials = true
        L48_2 = L24_2
        L49_2 = {}
        L50_2 = L42_2.Color
        L50_2 = L50_2.L
        L49_2[1] = L50_2
        L48_2 = L48_2(L49_2)
        L47_2.Data = L48_2
        L47_2.Side = "L"
        L45_2(L46_2, L47_2)
      else
        L45_2 = L23_1
        L46_2 = L45_2
        L45_2 = L45_2.InvokeServer
        L47_2 = {}
        L47_2.Type = "ColorObject"
        L47_2.Object = L43_2
        L47_2.UseMaterials = true
        L48_2 = L24_2
        L49_2 = L42_2.Color
        L49_2 = L49_2.R
        L48_2 = L48_2(L49_2)
        L47_2.Data = L48_2
        L47_2.Side = "R"
        L45_2(L46_2, L47_2)
        L45_2 = L23_1
        L46_2 = L45_2
        L45_2 = L45_2.InvokeServer
        L47_2 = {}
        L47_2.Type = "ColorObject"
        L47_2.Object = L43_2
        L47_2.UseMaterials = true
        L48_2 = L24_2
        L49_2 = L42_2.Color
        L49_2 = L49_2.L
        L48_2 = L48_2(L49_2)
        L47_2.Data = L48_2
        L47_2.Side = "L"
        L45_2(L46_2, L47_2)
      end
      if L43_2 then
        L45_2 = L42_2.Objects
        if L45_2 then
          L45_2 = pairs
          L46_2 = L42_2.Objects
          L45_2, L46_2, L47_2 = L45_2(L46_2)
          for L48_2, L49_2 in L45_2, L46_2, L47_2 do
            L50_2 = L37_2
            L50_2()
            L50_2 = L25_2
            L51_2 = L49_2.Name
            L50_2 = L50_2(L51_2)
            if L50_2 then
              L50_2 = L49_2.Side
              if not L50_2 then
                L49_2.Side = true
              end
              L50_2 = A4_2
              L51_2 = string
              L51_2 = L51_2.format
              L52_2 = "Building %s..."
              L53_2 = L49_2.Name
              L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
              L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
              L50_2 = L27_2
              L50_2()
              L50_2 = L23_1
              L51_2 = L50_2
              L50_2 = L50_2.InvokeServer
              L52_2 = {}
              L52_2.Type = "PlaceObject"
              L53_2 = L49_2.Name
              L52_2.Name = L53_2
              L53_2 = L49_2.Side
              L52_2.Side = L53_2
              L52_2.TargetModel = L43_2
              L53_2 = L21_2
              L54_2 = L49_2.CF
              L53_2 = L53_2(L54_2)
              L53_2 = L53_2.p
              L52_2.Pos = L53_2
              L53_2 = L23_2
              L54_2 = L21_2
              L55_2 = L49_2.CF
              L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
              L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
              L52_2.Rot = L53_2
              L50_2, L51_2 = L50_2(L51_2, L52_2)
              L52_2 = L23_1
              L53_2 = L52_2
              L52_2 = L52_2.InvokeServer
              L54_2 = {}
              L54_2.Type = "ColorObject"
              L54_2.Object = L50_2
              L54_2.UseMaterials = true
              L55_2 = L24_2
              L56_2 = L49_2.Color
              L55_2 = L55_2(L56_2)
              L54_2.Data = L55_2
              L52_2(L53_2, L54_2)
            end
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Roofs!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Roofs
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = "Building Roof"
    L43_2(L44_2)
    L43_2 = L37_2
    L43_2()
    L43_2 = {}
    L44_2 = pairs
    L45_2 = L42_2.Points
    L44_2, L45_2, L46_2 = L44_2(L45_2)
    for L47_2, L48_2 in L44_2, L45_2, L46_2 do
      L49_2 = table
      L49_2 = L49_2.insert
      L50_2 = L43_2
      L51_2 = L20_2
      L52_2 = L48_2
      L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2)
      L49_2(L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    end
    L44_2 = L27_2
    L44_2()
    L44_2 = L23_1
    L45_2 = L44_2
    L44_2 = L44_2.InvokeServer
    L46_2 = {}
    L46_2.Type = "PlaceRoof"
    L47_2 = L42_2.Settings
    L46_2.Settings = L47_2
    L47_2 = L43_2[1]
    L46_2.Start = L47_2
    L46_2.Points = L43_2
    L44_2, L45_2 = L44_2(L45_2, L46_2)
    if not L44_2 then
      L31_2 = L31_2 + 1
    end
    L46_2 = L23_1
    L47_2 = L46_2
    L46_2 = L46_2.InvokeServer
    L48_2 = {}
    L48_2.Type = "ColorObject"
    L48_2.Object = L44_2
    L48_2.UseMaterials = true
    L49_2 = L24_2
    L50_2 = L42_2.Color
    L49_2 = L49_2(L50_2)
    L48_2.Data = L49_2
    L46_2(L47_2, L48_2)
    L46_2 = L42_2.Objects
    if L46_2 then
      L46_2 = pairs
      L47_2 = L42_2.Objects
      L46_2, L47_2, L48_2 = L46_2(L47_2)
      for L49_2, L50_2 in L46_2, L47_2, L48_2 do
        L51_2 = L37_2
        L51_2()
        L51_2 = L25_2
        L52_2 = L50_2.Name
        L51_2 = L51_2(L52_2)
        if L51_2 then
          L51_2 = L50_2.Side
          if not L51_2 then
            L50_2.Side = true
          end
          L51_2 = A4_2
          L52_2 = string
          L52_2 = L52_2.format
          L53_2 = "Building %s..."
          L54_2 = L50_2.Name
          L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L52_2(L53_2, L54_2)
          L51_2(L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
          L51_2 = L27_2
          L51_2()
          L51_2 = L23_1
          L52_2 = L51_2
          L51_2 = L51_2.InvokeServer
          L53_2 = {}
          L53_2.Type = "PlaceObject"
          L54_2 = L50_2.Name
          L53_2.Name = L54_2
          L54_2 = L50_2.Side
          L53_2.Side = L54_2
          L53_2.TargetModel = L44_2
          L54_2 = L21_2
          L55_2 = L50_2.CF
          L54_2 = L54_2(L55_2)
          L54_2 = L54_2.p
          L53_2.Pos = L54_2
          L54_2 = L23_2
          L55_2 = L21_2
          L56_2 = L50_2.CF
          L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L55_2(L56_2)
          L54_2 = L54_2(L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
          L53_2.Rot = L54_2
          L51_2, L52_2 = L51_2(L52_2, L53_2)
          L53_2 = L23_1
          L54_2 = L53_2
          L53_2 = L53_2.InvokeServer
          L55_2 = {}
          L55_2.Type = "ColorObject"
          L55_2.Object = L51_2
          L55_2.UseMaterials = true
          L56_2 = L24_2
          L57_2 = L50_2.Color
          L56_2 = L56_2(L57_2)
          L55_2.Data = L56_2
          L53_2(L54_2, L55_2)
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Fences!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Fences
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = "Building Fence"
    L43_2(L44_2)
    L43_2 = L37_2
    L43_2()
    L43_2 = L27_2
    L43_2()
    L43_2 = L23_1
    L44_2 = L43_2
    L43_2 = L43_2.InvokeServer
    L45_2 = {}
    L45_2.Type = "PlaceFence"
    L46_2 = L20_2
    L47_2 = L42_2.To
    L46_2 = L46_2(L47_2)
    L45_2.To = L46_2
    L46_2 = L20_2
    L47_2 = L42_2.From
    L46_2 = L46_2(L47_2)
    L45_2.From = L46_2
    L46_2 = L42_2.Name
    L45_2.ItemType = L46_2
    L43_2, L44_2 = L43_2(L44_2, L45_2)
    if L43_2 then
      L45_2 = L23_1
      L46_2 = L45_2
      L45_2 = L45_2.InvokeServer
      L47_2 = {}
      L47_2.Type = "ColorObject"
      L47_2.Object = L43_2
      L47_2.UseMaterials = true
      L48_2 = L24_2
      L49_2 = L42_2.Color
      L48_2 = L48_2(L49_2)
      L47_2.Data = L48_2
      L45_2(L46_2, L47_2)
      L45_2 = L42_2.Objects
      if L45_2 then
        L45_2 = pairs
        L46_2 = L42_2.Objects
        L45_2, L46_2, L47_2 = L45_2(L46_2)
        for L48_2, L49_2 in L45_2, L46_2, L47_2 do
          L50_2 = A4_2
          L51_2 = string
          L51_2 = L51_2.format
          L52_2 = "Building %s..."
          L53_2 = L49_2.Name
          L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
          L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
          L50_2 = L37_2
          L50_2()
          L50_2 = L25_2
          L51_2 = L49_2.Name
          L50_2 = L50_2(L51_2)
          if L50_2 then
            L50_2 = L27_2
            L50_2()
            L50_2 = L23_1
            L51_2 = L50_2
            L50_2 = L50_2.InvokeServer
            L52_2 = {}
            L52_2.Type = "PlaceObject"
            L53_2 = L49_2.Name
            L52_2.Name = L53_2
            L52_2.TargetModel = L43_2
            L53_2 = L21_2
            L54_2 = L49_2.CF
            L53_2 = L53_2(L54_2)
            L53_2 = L53_2.p
            L52_2.Pos = L53_2
            L53_2 = L23_2
            L54_2 = L21_2
            L55_2 = L49_2.CF
            L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
            L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
            L52_2.Rot = L53_2
            L50_2, L51_2 = L50_2(L51_2, L52_2)
            L52_2 = L23_1
            L53_2 = L52_2
            L52_2 = L52_2.InvokeServer
            L54_2 = {}
            L54_2.Type = "ColorObject"
            L54_2.Object = L50_2
            L54_2.UseMaterials = true
            L55_2 = L24_2
            L56_2 = L49_2.Color
            L55_2 = L55_2(L56_2)
            L54_2.Data = L55_2
            L52_2(L53_2, L54_2)
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Pools!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Pools
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = "Building Pool"
    L43_2(L44_2)
    L43_2 = L27_2
    L43_2()
    L43_2 = L37_2
    L43_2()
    L43_2 = L23_1
    L44_2 = L43_2
    L43_2 = L43_2.InvokeServer
    L45_2 = {}
    L45_2.Type = "PlacePool"
    L46_2 = L9_2.Ground
    L46_2 = L46_2.CFrame
    L47_2 = L46_2
    L46_2 = L46_2.ToObjectSpace
    L48_2 = L21_2
    L49_2 = L42_2.Center
    L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L48_2(L49_2)
    L46_2 = L46_2(L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    L45_2.Center = L46_2
    L46_2 = Vector2
    L46_2 = L46_2.new
    L47_2 = unpack
    L48_2 = L42_2.Size
    L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L47_2(L48_2)
    L46_2 = L46_2(L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    L45_2.Size = L46_2
    L46_2 = L42_2.Name
    L45_2.ItemType = L46_2
    L43_2, L44_2 = L43_2(L44_2, L45_2)
    if not L43_2 then
      L31_2 = L31_2 + 1
    end
    if L43_2 then
      L45_2 = L42_2.Objects
      if L45_2 then
        L45_2 = pairs
        L46_2 = L42_2.Objects
        L45_2, L46_2, L47_2 = L45_2(L46_2)
        for L48_2, L49_2 in L45_2, L46_2, L47_2 do
          L50_2 = L37_2
          L50_2()
          L50_2 = L25_2
          L51_2 = L49_2.Name
          L50_2 = L50_2(L51_2)
          if L50_2 then
            L50_2 = L49_2.Side
            if not L50_2 then
              L49_2.Side = true
            end
            L50_2 = A4_2
            L51_2 = string
            L51_2 = L51_2.format
            L52_2 = "Building %s..."
            L53_2 = L49_2.Name
            L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
            L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
            L50_2 = L27_2
            L50_2()
            L50_2 = L23_1
            L51_2 = L50_2
            L50_2 = L50_2.InvokeServer
            L52_2 = {}
            L52_2.Type = "PlaceObject"
            L53_2 = L49_2.Name
            L52_2.Name = L53_2
            L53_2 = L49_2.Side
            L52_2.Side = L53_2
            L52_2.TargetModel = L43_2
            L53_2 = L21_2
            L54_2 = L49_2.CF
            L53_2 = L53_2(L54_2)
            L53_2 = L53_2.p
            L52_2.Pos = L53_2
            L53_2 = L23_2
            L54_2 = L21_2
            L55_2 = L49_2.CF
            L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
            L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
            L52_2.Rot = L53_2
            L50_2, L51_2 = L50_2(L51_2, L52_2)
            L52_2 = L23_1
            L53_2 = L52_2
            L52_2 = L52_2.InvokeServer
            L54_2 = {}
            L54_2.Type = "ColorObject"
            L54_2.Object = L50_2
            L54_2.UseMaterials = true
            L55_2 = L24_2
            L56_2 = L49_2.Color
            L55_2 = L55_2(L56_2)
            L54_2.Data = L55_2
            L52_2(L53_2, L54_2)
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Paths!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Paths
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = "Building Path"
    L43_2(L44_2)
    L43_2 = L27_2
    L43_2()
    L43_2 = L37_2
    L43_2()
    L43_2 = L23_1
    L44_2 = L43_2
    L43_2 = L43_2.InvokeServer
    L45_2 = {}
    L45_2.Type = "PlacePath"
    L46_2 = L20_2
    L47_2 = L42_2.To
    L46_2 = L46_2(L47_2)
    L45_2.To = L46_2
    L46_2 = L20_2
    L47_2 = L42_2.From
    L46_2 = L46_2(L47_2)
    L45_2.From = L46_2
    L43_2, L44_2 = L43_2(L44_2, L45_2)
    if not L43_2 then
      L31_2 = L31_2 + 1
      L45_2 = print
      L46_2 = L43_2
      L47_2 = L44_2
      L45_2(L46_2, L47_2)
    else
      L45_2 = L23_1
      L46_2 = L45_2
      L45_2 = L45_2.InvokeServer
      L47_2 = {}
      L47_2.Type = "ColorObject"
      L47_2.Object = L43_2
      L47_2.UseMaterials = true
      L48_2 = L24_2
      L49_2 = L42_2.Color
      L48_2 = L48_2(L49_2)
      L47_2.Data = L48_2
      L45_2(L46_2, L47_2)
      if L43_2 then
        L45_2 = L42_2.Objects
        if L45_2 then
          L45_2 = pairs
          L46_2 = L42_2.Objects
          L45_2, L46_2, L47_2 = L45_2(L46_2)
          for L48_2, L49_2 in L45_2, L46_2, L47_2 do
            L50_2 = L37_2
            L50_2()
            L50_2 = L25_2
            L51_2 = L49_2.Name
            L50_2 = L50_2(L51_2)
            if L50_2 then
              L50_2 = L49_2.Side
              if not L50_2 then
                L49_2.Side = true
              end
              L50_2 = A4_2
              L51_2 = string
              L51_2 = L51_2.format
              L52_2 = "Building %s..."
              L53_2 = L49_2.Name
              L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
              L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
              L50_2 = L27_2
              L50_2()
              L50_2 = L23_1
              L51_2 = L50_2
              L50_2 = L50_2.InvokeServer
              L52_2 = {}
              L52_2.Type = "PlaceObject"
              L53_2 = L49_2.Name
              L52_2.Name = L53_2
              L53_2 = L49_2.Side
              L52_2.Side = L53_2
              L52_2.TargetModel = L43_2
              L53_2 = L21_2
              L54_2 = L49_2.CF
              L53_2 = L53_2(L54_2)
              L53_2 = L53_2.p
              L52_2.Pos = L53_2
              L53_2 = L23_2
              L54_2 = L21_2
              L55_2 = L49_2.CF
              L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
              L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
              L52_2.Rot = L53_2
              L50_2, L51_2 = L50_2(L51_2, L52_2)
              L52_2 = L23_1
              L53_2 = L52_2
              L52_2 = L52_2.InvokeServer
              L54_2 = {}
              L54_2.Type = "ColorObject"
              L54_2.Object = L50_2
              L54_2.UseMaterials = true
              L55_2 = L24_2
              L56_2 = L49_2.Color
              L55_2 = L55_2(L56_2)
              L54_2.Data = L55_2
              L52_2(L53_2, L54_2)
            end
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Counters!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Counters
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = "Building Counters"
    L43_2(L44_2)
    L43_2 = L37_2
    L43_2()
    L43_2 = L25_2
    L44_2 = L42_2.Name
    L43_2 = L43_2(L44_2)
    if L43_2 then
      L43_2 = L27_2
      L43_2()
      L43_2 = L23_1
      L44_2 = L43_2
      L43_2 = L43_2.InvokeServer
      L45_2 = {}
      L45_2.Type = "PlaceObject"
      L46_2 = L23_2
      L47_2 = L21_2
      L48_2 = L42_2.CF
      L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L47_2(L48_2)
      L46_2 = L46_2(L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
      L45_2.Rot = L46_2
      L46_2 = L21_2
      L47_2 = L42_2.CF
      L46_2 = L46_2(L47_2)
      L46_2 = L46_2.p
      L45_2.Pos = L46_2
      L46_2 = L42_2.Name
      L45_2.Name = L46_2
      L46_2 = L22_2
      L47_2 = L21_2
      L48_2 = L42_2.CF
      L47_2 = L47_2(L48_2)
      L47_2 = L47_2.p
      L46_2 = L46_2(L47_2)
      L45_2.TargetModel = L46_2
      L43_2, L44_2 = L43_2(L44_2, L45_2)
      if not L43_2 then
        L31_2 = L31_2 + 1
      end
      L45_2 = L23_1
      L46_2 = L45_2
      L45_2 = L45_2.InvokeServer
      L47_2 = {}
      L47_2.Type = "ColorObject"
      L47_2.Object = L43_2
      L47_2.UseMaterials = true
      L48_2 = L24_2
      L49_2 = L42_2.Color
      L48_2 = L48_2(L49_2)
      L47_2.Data = L48_2
      L45_2(L46_2, L47_2)
      L45_2 = L42_2.Objects
      if L45_2 then
        L45_2 = pairs
        L46_2 = L42_2.Objects
        L45_2, L46_2, L47_2 = L45_2(L46_2)
        for L48_2, L49_2 in L45_2, L46_2, L47_2 do
          L50_2 = L37_2
          L50_2()
          L50_2 = L25_2
          L51_2 = L49_2.Name
          L50_2 = L50_2(L51_2)
          if L50_2 then
            L50_2 = A4_2
            L51_2 = string
            L51_2 = L51_2.format
            L52_2 = "Building %s..."
            L53_2 = L49_2.Name
            L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
            L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
            L50_2 = L27_2
            L50_2()
            L50_2 = L23_1
            L51_2 = L50_2
            L50_2 = L50_2.InvokeServer
            L52_2 = {}
            L52_2.Type = "PlaceObject"
            L53_2 = L49_2.Name
            L52_2.Name = L53_2
            L52_2.TargetModel = L43_2
            L53_2 = L21_2
            L54_2 = L49_2.CF
            L53_2 = L53_2(L54_2)
            L53_2 = L53_2.p
            L52_2.Pos = L53_2
            L53_2 = L23_2
            L54_2 = L21_2
            L55_2 = L49_2.CF
            L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
            L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
            L52_2.Rot = L53_2
            L50_2, L51_2 = L50_2(L51_2, L52_2)
            L52_2 = L23_1
            L53_2 = L52_2
            L52_2 = L52_2.InvokeServer
            L54_2 = {}
            L54_2.Type = "ColorObject"
            L54_2.Object = L50_2
            L54_2.UseMaterials = true
            L55_2 = L24_2
            L56_2 = L49_2.Color
            L55_2 = L55_2(L56_2)
            L54_2.Data = L55_2
            L52_2(L53_2, L54_2)
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Building Loose Objects!"
  L38_2(L39_2)
  L38_2 = pairs
  L39_2 = L16_2.Objects
  L38_2, L39_2, L40_2 = L38_2(L39_2)
  for L41_2, L42_2 in L38_2, L39_2, L40_2 do
    L43_2 = A4_2
    L44_2 = string
    L44_2 = L44_2.format
    L45_2 = "Building %s..."
    L46_2 = L42_2.Name
    L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L44_2(L45_2, L46_2)
    L43_2(L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
    L43_2 = L27_2
    L43_2()
    L43_2 = L37_2
    L43_2()
    L43_2 = L25_2
    L44_2 = L42_2.Name
    L43_2 = L43_2(L44_2)
    if L43_2 then
      L43_2 = L27_2
      L43_2()
      L43_2 = L23_1
      L44_2 = L43_2
      L43_2 = L43_2.InvokeServer
      L45_2 = {}
      L45_2.Type = "PlaceObject"
      L46_2 = L23_2
      L47_2 = L21_2
      L48_2 = L42_2.CF
      L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L47_2(L48_2)
      L46_2 = L46_2(L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
      L45_2.Rot = L46_2
      L46_2 = L21_2
      L47_2 = L42_2.CF
      L46_2 = L46_2(L47_2)
      L46_2 = L46_2.p
      L45_2.Pos = L46_2
      L46_2 = L42_2.Name
      L45_2.Name = L46_2
      L46_2 = L22_2
      L47_2 = L21_2
      L48_2 = L42_2.CF
      L47_2 = L47_2(L48_2)
      L47_2 = L47_2.p
      L46_2 = L46_2(L47_2)
      L45_2.TargetModel = L46_2
      L43_2, L44_2 = L43_2(L44_2, L45_2)
      if not L43_2 then
        L31_2 = L31_2 + 1
      else
        L45_2 = L23_1
        L46_2 = L45_2
        L45_2 = L45_2.InvokeServer
        L47_2 = {}
        L47_2.Type = "ColorObject"
        L47_2.Object = L43_2
        L47_2.UseMaterials = true
        L48_2 = L24_2
        L49_2 = L42_2.Color
        L48_2 = L48_2(L49_2)
        L47_2.Data = L48_2
        L45_2(L46_2, L47_2)
        L45_2 = L42_2.Objects
        if L45_2 then
          L45_2 = pairs
          L46_2 = L42_2.Objects
          L45_2, L46_2, L47_2 = L45_2(L46_2)
          for L48_2, L49_2 in L45_2, L46_2, L47_2 do
            L50_2 = L37_2
            L50_2()
            L50_2 = L25_2
            L51_2 = L49_2.Name
            L50_2 = L50_2(L51_2)
            if L50_2 then
              L50_2 = A4_2
              L51_2 = string
              L51_2 = L51_2.format
              L52_2 = "Building %s..."
              L53_2 = L49_2.Name
              L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L51_2(L52_2, L53_2)
              L50_2(L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
              L50_2 = L27_2
              L50_2()
              L50_2 = L23_1
              L51_2 = L50_2
              L50_2 = L50_2.InvokeServer
              L52_2 = {}
              L52_2.Type = "PlaceObject"
              L53_2 = L49_2.Name
              L52_2.Name = L53_2
              L52_2.TargetModel = L43_2
              L53_2 = L21_2
              L54_2 = L49_2.CF
              L53_2 = L53_2(L54_2)
              L53_2 = L53_2.p
              L52_2.Pos = L53_2
              L53_2 = L23_2
              L54_2 = L21_2
              L55_2 = L49_2.CF
              L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2 = L54_2(L55_2)
              L53_2 = L53_2(L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2)
              L52_2.Rot = L53_2
              L50_2, L51_2 = L50_2(L51_2, L52_2)
              L52_2 = L23_1
              L53_2 = L52_2
              L52_2 = L52_2.InvokeServer
              L54_2 = {}
              L54_2.Type = "ColorObject"
              L54_2.Object = L50_2
              L54_2.UseMaterials = true
              L55_2 = L24_2
              L56_2 = L49_2.Color
              L55_2 = L55_2(L56_2)
              L54_2.Data = L55_2
              L52_2(L53_2, L54_2)
            end
          end
        end
      end
    end
  end
  L38_2 = L28_2
  L39_2 = "Build Done!"
  L38_2(L39_2)
  L38_2 = warn
  L39_2 = "Total Failed : "
  L40_2 = tostring
  L41_2 = L31_2
  L40_2 = L40_2(L41_2)
  L39_2 = L39_2 .. L40_2
  L38_2(L39_2)
  L38_2 = L18_1
  L39_2 = L38_2
  L38_2 = L38_2.CreateNotification
  L40_2 = "Success"
  L41_2 = nil
  L42_2 = [[
Load Done.
(If base is big, you need to wait few more seconds for it to finish)
The total money you spent for this base is $]]
  L43_2 = tostring
  L44_2 = game
  L45_2 = L44_2
  L44_2 = L44_2.GetService
  L46_2 = "ReplicatedStorage"
  L44_2 = L44_2(L45_2, L46_2)
  L44_2 = L44_2.Stats
  L45_2 = A2_2.Name
  L44_2 = L44_2[L45_2]
  L44_2 = L44_2.Money
  L44_2 = L44_2.Value
  L44_2 = L30_2 - L44_2
  L43_2 = L43_2(L44_2)
  L44_2 = "."
  L42_2 = L42_2 .. L43_2 .. L44_2
  L38_2(L39_2, L40_2, L41_2, L42_2)
  L38_2 = true
end

L25_1.autobuild_base = L26_1

function L26_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2
  L4_2 = game
  L4_2 = L4_2.Workspace
  L5_2 = L4_2
  L4_2 = L4_2.FindFirstChild
  L6_2 = "ChromaBasePreview"
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = game
    L4_2 = L4_2.Workspace
    L4_2 = L4_2.ChromaBasePreview
    L5_2 = L4_2
    L4_2 = L4_2.Destroy
    L4_2(L5_2)
  end
  L4_2 = game
  L4_2 = L4_2.Players
  L4_2 = L4_2.LocalPlayer
  L5_2 = pairs
  L6_2 = game
  L7_2 = L6_2
  L6_2 = L6_2.GetService
  L8_2 = "ReplicatedStorage"
  L6_2 = L6_2(L7_2, L8_2)
  L6_2 = L6_2.Stats
  L7_2 = L4_2.Name
  L6_2 = L6_2[L7_2]
  L6_2 = L6_2.Gamepasses
  L7_2 = L6_2
  L6_2 = L6_2.GetChildren
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2 = L6_2(L7_2)
  L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2)
  for L8_2, L9_2 in L5_2, L6_2, L7_2 do
    L10_2 = game
    L11_2 = L10_2
    L10_2 = L10_2.GetService
    L12_2 = "MarketplaceService"
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = L10_2
    L10_2 = L10_2.UserOwnsGamePassAsync
    L12_2 = L4_2.UserId
    L13_2 = tonumber
    L14_2 = L9_2.Name
    L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2 = L13_2(L14_2)
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2)
    L11_2 = L9_2.Value
    if L10_2 ~= L11_2 then
      L12_2 = L4_2
      L11_2 = L4_2.Kick
      L13_2 = "Exploit Detection: Attempt to use free gamepass exploits!"
      L11_2(L12_2, L13_2)
      return
    end
  end
  L5_2 = game
  L6_2 = L5_2
  L5_2 = L5_2.GetService
  L7_2 = "Workspace"
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = L5_2.Plots
  L6_2 = L5_2
  L5_2 = L5_2.FindFirstChild
  L7_2 = "Plot_"
  L8_2 = A2_2.Name
  L7_2 = L7_2 .. L8_2
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L7_2 = A0_2
    L6_2 = A0_2.notify
    L8_2 = A2_2.Name
    L9_2 = " does not have a plot!"
    L8_2 = L8_2 .. L9_2
    L9_2 = "Base Building"
    L6_2(L7_2, L8_2, L9_2)
    return
  end
  
  function L6_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = {}
    L3_3 = A0_3
    L2_3 = A0_3.components
    L2_3, L3_3 = L2_3(L3_3)
    L1_3[1] = L2_3
    L1_3[2] = L3_3
  end
  
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = CFrame
    L1_3 = L1_3.new
    L2_3 = unpack
    L3_3 = A0_3
    L2_3, L3_3 = L2_3(L3_3)
  end
  
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = {}
    L2_3 = A0_3.X
    L3_3 = A0_3.Y
    L4_3 = A0_3.Z
    L1_3[1] = L2_3
    L1_3[2] = L3_3
    L1_3[3] = L4_3
  end
  
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = Vector3
    L1_3 = L1_3.new
    L2_3 = unpack
    L3_3 = A0_3
    L2_3, L3_3 = L2_3(L3_3)
  end
  
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.ObjectManager
    L2_3 = L1_3
    L1_3 = L1_3.RoundToSaveResolution
    L3_3 = CFrame
    L3_3 = L3_3.new
    L4_3 = A0_3
    L3_3, L4_3, L5_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
    L1_3 = L1_3.p
    L2_3 = L8_2
    L3_3 = L5_2
    L3_3 = L3_3.Water
    L3_3 = L3_3.CFrame
    L4_3 = L3_3
    L3_3 = L3_3.PointToObjectSpace
    L5_3 = L1_3
    L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
  end
  
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = L4_1
    L1_3 = L1_3.Shared
    L1_3 = L1_3.ObjectManager
    L2_3 = L1_3
    L1_3 = L1_3.RoundToSaveResolution
    L3_3 = A0_3
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L6_2
    L3_3 = L5_2
    L3_3 = L3_3.Water
    L3_3 = L3_3.CFrame
    L4_3 = L3_3
    L3_3 = L3_3.ToObjectSpace
    L5_3 = L1_3
    L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
  end
  
  function L12_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = {}
    L2_3 = 1
    L3_3 = 4
    L4_3 = 1
    for L5_3 = L2_3, L3_3, L4_3 do
      L6_3 = A0_3[L5_3]
      if L6_3 then
        L6_3 = A0_3[L5_3]
        L6_3 = #L6_3
        if L6_3 ~= 0 then
          L6_3 = {}
          L1_3[L5_3] = L6_3
          L6_3 = A0_3[L5_3]
          L6_3 = L6_3[1]
          if L6_3 ~= 0 then
            L6_3 = L1_3[L5_3]
            L7_3 = BrickColor
            L7_3 = L7_3.new
            L8_3 = A0_3[L5_3]
            L8_3 = L8_3[1]
            L7_3 = L7_3(L8_3)
            L7_3 = L7_3.Number
            L6_3[1] = L7_3
          else
            L6_3 = L1_3[L5_3]
            L6_3[1] = 0
          end
          L6_3 = A0_3[L5_3]
          L6_3 = L6_3[2]
          if L6_3 ~= 0 then
            L6_3 = L4_1
            L6_3 = L6_3.Shared
            L6_3 = L6_3.MaterialData
            L6_3 = L6_3.Materials
            L7_3 = tostring
            L8_3 = A0_3[L5_3]
            L8_3 = L8_3[2]
            L7_3 = L7_3(L8_3)
            L6_3 = L6_3[L7_3]
            if L6_3 then
              L6_3 = L1_3[L5_3]
              L7_3 = L4_1
              L7_3 = L7_3.Shared
              L7_3 = L7_3.MaterialData
              L7_3 = L7_3.Materials
              L8_3 = tostring
              L9_3 = A0_3[L5_3]
              L9_3 = L9_3[2]
              L8_3 = L8_3(L9_3)
              L7_3 = L7_3[L8_3]
              L7_3 = L7_3.ID
              L6_3[2] = L7_3
            else
              L6_3 = L1_3[L5_3]
              L6_3[2] = 0
            end
          else
            L6_3 = L1_3[L5_3]
            L6_3[2] = 0
          end
      end
      else
        L6_3 = {}
        L1_3[L5_3] = L6_3
      end
    end
  end
  
  L13_2 = A1_2
  L14_2 = L13_2.FileVersion
  L15_2 = A0_2.schema_version
  if L14_2 ~= L15_2 then
    L14_2 = A3_2
    L15_2 = "Base ID Outdated! Please re-save the base again!"
    L14_2(L15_2)
    return
  end
  
  function L14_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = L5_2
    L1_3 = L1_3.Water
    L1_3 = L1_3.CFrame
    L2_3 = L1_3
    L1_3 = L1_3.PointToWorldSpace
    L3_3 = L9_2
    L4_3 = A0_3
    L3_3, L4_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3)
  end
  
  function L15_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = L5_2
    L1_3 = L1_3.Water
    L1_3 = L1_3.CFrame
    L2_3 = L1_3
    L1_3 = L1_3.ToWorldSpace
    L3_3 = L7_2
    L4_3 = A0_3
    L3_3, L4_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3)
  end
  
  function L16_2(...)
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L1_3 = L0_1
    if not L1_3 then
      return
    end
    L1_3 = "[AutoBuild / DEBUG]:"
    L2_3 = pairs
    L3_3 = {}
    L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = ...
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L2_3, L3_3, L4_3 = L2_3(L3_3)
    for L5_3, L6_3 in L2_3, L3_3, L4_3 do
      L7_3 = L1_3
      L8_3 = " "
      L9_3 = tostring
      L10_3 = L6_3
      L9_3 = L9_3(L10_3)
      L1_3 = L7_3 .. L8_3 .. L9_3
    end
    L2_3 = L21_1
    if L2_3 then
      L2_3 = L21_1
      L3_3 = L1_3
      L4_3 = "\n"
      L3_3 = L3_3 .. L4_3
      L2_3(L3_3)
    else
      L2_3 = print
      L3_3 = L1_3
      L2_3(L3_3)
    end
  end
  
  L17_2 = 0
  
  function L18_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
    L0_3 = L17_2
    L0_3 = L0_3 + 1
    L17_2 = L0_3
    L0_3 = L17_2
    if 10 < L0_3 then
      L0_3 = 0
      L17_2 = L0_3
      L0_3 = game
      L1_3 = L0_3
      L0_3 = L0_3.GetService
      L2_3 = "RunService"
      L0_3 = L0_3(L1_3, L2_3)
      L0_3 = L0_3.RenderStepped
      L1_3 = L0_3
      L0_3 = L0_3.Wait
      L0_3(L1_3)
    end
  end
  
  L19_2 = Instance
  L19_2 = L19_2.new
  L20_2 = "Folder"
  L21_2 = workspace
  L19_2 = L19_2(L20_2, L21_2)
  L19_2.Name = "ChromaBasePreview"
  
  function L20_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3
    L2_3 = L12_2
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    L3_3 = pairs
    L4_3 = L2_3
    L3_3, L4_3, L5_3 = L3_3(L4_3)
    for L6_3, L7_3 in L3_3, L4_3, L5_3 do
      L9_3 = A1_3
      L8_3 = A1_3.FindFirstChild
      L10_3 = "ColorGroup"
      L11_3 = tostring
      L12_3 = L6_3
      L11_3 = L11_3(L12_3)
      L10_3 = L10_3 .. L11_3
      L8_3 = L8_3(L9_3, L10_3)
      if L8_3 then
        L8_3 = pairs
        L10_3 = A1_3
        L9_3 = A1_3.FindFirstChild
        L11_3 = "ColorGroup"
        L12_3 = tostring
        L13_3 = L6_3
        L12_3 = L12_3(L13_3)
        L11_3 = L11_3 .. L12_3
        L9_3 = L9_3(L10_3, L11_3)
        L10_3 = L9_3
        L9_3 = L9_3.GetChildren
        L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3 = L9_3(L10_3)
        L8_3, L9_3, L10_3 = L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
        for L11_3, L12_3 in L8_3, L9_3, L10_3 do
          L12_3 = L12_3.Value
          L13_3 = type
          L14_3 = L12_3
          L13_3 = L13_3(L14_3)
          if L13_3 == "userdata" then
            L14_3 = L12_3
            L13_3 = L12_3.IsA
            L15_3 = "BasePart"
            L13_3 = L13_3(L14_3, L15_3)
            if L13_3 then
              L13_3 = BrickColor
              L13_3 = L13_3.new
              L14_3 = L7_3[1]
              L13_3 = L13_3(L14_3)
              L12_3.BrickColor = L13_3
              L13_3 = L4_1
              L13_3 = L13_3.Shared
              L13_3 = L13_3.MaterialData
              L14_3 = L13_3
              L13_3 = L13_3.GetMaterialFromID
              L15_3 = L7_3[2]
              L13_3 = L13_3(L14_3, L15_3)
              if L13_3 then
                L14_3 = L13_3.Name
                L15_3 = L14_3
                L14_3 = L14_3.sub
                L16_3 = 1
                L17_3 = 1
                L14_3 = L14_3(L15_3, L16_3, L17_3)
                if L14_3 == "*" then
                  L14_3 = L13_3.Main
                  if L14_3 then
                    goto lbl_64
                  end
                end
                L14_3 = L13_3.Name
                ::lbl_64::
                L12_3.Material = L14_3
              end
            end
          end
        end
      end
    end
  end
  
  function L21_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L1_3 = L15_2
    L2_3 = A0_3.CF
    L1_3 = L1_3(L2_3)
    L2_3 = A0_3.Name
    L3_3 = game
    L4_3 = L3_3
    L3_3 = L3_3.GetService
    L5_3 = "ReplicatedStorage"
    L3_3 = L3_3(L4_3, L5_3)
    L3_3 = L3_3.ItemModels
    L4_3 = L3_3
    L3_3 = L3_3.FindFirstChild
    L5_3 = L2_3
    L6_3 = true
    L3_3 = L3_3(L4_3, L5_3, L6_3)
    if L3_3 then
      L5_3 = L3_3
      L4_3 = L3_3.IsA
      L6_3 = "Model"
      L4_3 = L4_3(L5_3, L6_3)
      if L4_3 then
        L5_3 = L3_3
        L4_3 = L3_3.Clone
        L4_3 = L4_3(L5_3)
        L6_3 = L4_3
        L5_3 = L4_3.SetPrimaryPartCFrame
        L7_3 = L1_3
        L5_3(L6_3, L7_3)
        L5_3 = L19_2
        L4_3.Parent = L5_3
        L5_3 = A0_3.Color
        if L5_3 then
          L5_3 = L20_2
          L6_3 = A0_3.Color
          L7_3 = L4_3
          L5_3(L6_3, L7_3)
        end
        L5_3 = A0_3.Objects
        if L5_3 then
          L5_3 = pairs
          L6_3 = A0_3.Objects
          L5_3, L6_3, L7_3 = L5_3(L6_3)
          for L8_3, L9_3 in L5_3, L6_3, L7_3 do
            L10_3 = L21_2
            L11_3 = L9_3
            L10_3(L11_3)
            L10_3 = L18_2
            L10_3()
          end
        end
      end
    end
  end
  
  L22_2 = L16_2
  L23_2 = "Previewing Floors!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Floors
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = pcall
    
    function L28_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
      L0_3 = {}
      L1_3 = pairs
      L2_3 = L26_2
      L2_3 = L2_3.Points
      L1_3, L2_3, L3_3 = L1_3(L2_3)
      for L4_3, L5_3 in L1_3, L2_3, L3_3 do
        L6_3 = table
        L6_3 = L6_3.insert
        L7_3 = L0_3
        L8_3 = L14_2
        L9_3 = L5_3
        L8_3, L9_3 = L8_3(L9_3)
        L6_3(L7_3, L8_3, L9_3)
      end
      L1_3 = L4_1
      L1_3 = L1_3.Shared
      L1_3 = L1_3.Polygon
      L2_3 = L1_3
      L1_3 = L1_3.fromPoints
      L3_3 = L0_3
      L1_3 = L1_3(L2_3, L3_3)
      L3_3 = L1_3
      L2_3 = L1_3.Fill
      
      function L4_3(A0_4)
        local L1_4, L2_4, L3_4, L4_4, L5_4
        L1_4 = L19_2
        A0_4.Parent = L1_4
        A0_4.Name = "Floor Preview"
        L1_4 = L26_2
        L1_4 = L1_4.Color
        if L1_4 then
          L1_4 = BrickColor
          L1_4 = L1_4.new
          L2_4 = L26_2
          L2_4 = L2_4.Color
          L2_4 = L2_4[1]
          L2_4 = L2_4[1]
          L1_4 = L1_4(L2_4)
          A0_4.BrickColor = L1_4
          L1_4 = L4_1
          L1_4 = L1_4.Shared
          L1_4 = L1_4.MaterialData
          L1_4 = L1_4.Materials
          L2_4 = L26_2
          L2_4 = L2_4.Color
          L2_4 = L2_4[1]
          L2_4 = L2_4[2]
          L1_4 = L1_4[L2_4]
          if L1_4 then
            L2_4 = L1_4.Name
            L3_4 = L2_4
            L2_4 = L2_4.sub
            L4_4 = 1
            L5_4 = 1
            L2_4 = L2_4(L3_4, L4_4, L5_4)
            if L2_4 == "*" then
              L2_4 = L1_4.Main
              if L2_4 then
                goto lbl_38
              end
            end
            L2_4 = L1_4.Name
            ::lbl_38::
            A0_4.Material = L2_4
          end
        end
      end
      
      L2_3(L3_3, L4_3)
      L2_3 = L18_2
      L2_3()
      L2_3 = L26_2
      L2_3 = L2_3.Objects
      if L2_3 then
        L2_3 = pairs
        L3_3 = L26_2
        L3_3 = L3_3.Objects
        L2_3, L3_3, L4_3 = L2_3(L3_3)
        for L5_3, L6_3 in L2_3, L3_3, L4_3 do
          L7_3 = L21_2
          L8_3 = L6_3
          L7_3(L8_3)
          L7_3 = L18_2
          L7_3()
        end
      end
    end
    
    L27_2(L28_2)
  end
  L22_2 = L16_2
  L23_2 = "Previewing Basements!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Basements
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = L26_2.Objects
    if L27_2 then
      L27_2 = pairs
      L28_2 = L26_2.Objects
      L27_2, L28_2, L29_2 = L27_2(L28_2)
      for L30_2, L31_2 in L27_2, L28_2, L29_2 do
        L32_2 = L21_2
        L33_2 = L31_2
        L32_2(L33_2)
        L32_2 = L18_2
        L32_2()
      end
    end
  end
  L22_2 = L16_2
  L23_2 = "Previewing Walls!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Walls
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = L14_2
    L28_2 = L26_2.To
    L27_2 = L27_2(L28_2)
    L28_2 = L14_2
    L29_2 = L26_2.From
    L28_2 = L28_2(L29_2)
    L29_2 = L27_2 + L28_2
    L29_2 = L29_2 / 2
    L30_2 = Instance
    L30_2 = L30_2.new
    L31_2 = "Part"
    L32_2 = L19_2
    L30_2 = L30_2(L31_2, L32_2)
    L31_2 = Vector3
    L31_2 = L31_2.new
    L32_2 = L27_2 - L28_2
    L32_2 = L32_2.Magnitude
    L33_2 = 12
    L34_2 = 0.25
    L31_2 = L31_2(L32_2, L33_2, L34_2)
    L30_2.Size = L31_2
    L31_2 = CFrame
    L31_2 = L31_2.new
    L32_2 = L29_2
    L33_2 = L28_2
    L31_2 = L31_2(L32_2, L33_2)
    L33_2 = L31_2
    L32_2 = L31_2.ToWorldSpace
    L34_2 = CFrame
    L34_2 = L34_2.Angles
    L35_2 = 0
    L36_2 = math
    L36_2 = L36_2.rad
    L37_2 = -90
    L36_2 = L36_2(L37_2)
    L37_2 = 0
    L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2 = L34_2(L35_2, L36_2, L37_2)
    L32_2 = L32_2(L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2)
    L30_2.CFrame = L32_2
    L30_2.Anchored = true
    L30_2.CanCollide = false
    L32_2 = L18_2
    L32_2()
    L32_2 = L26_2.Objects
    if L32_2 then
      L32_2 = pairs
      L33_2 = L26_2.Objects
      L32_2, L33_2, L34_2 = L32_2(L33_2)
      for L35_2, L36_2 in L32_2, L33_2, L34_2 do
        L37_2 = L21_2
        L38_2 = L36_2
        L37_2(L38_2)
        L37_2 = L18_2
        L37_2()
      end
    end
  end
  L22_2 = L16_2
  L23_2 = "Previewing Roofs!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Roofs
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = {}
    L28_2 = pairs
    L29_2 = L26_2.Points
    L28_2, L29_2, L30_2 = L28_2(L29_2)
    for L31_2, L32_2 in L28_2, L29_2, L30_2 do
      L33_2 = table
      L33_2 = L33_2.insert
      L34_2 = L27_2
      L35_2 = L14_2
      L36_2 = L32_2
      L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2 = L35_2(L36_2)
      L33_2(L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2)
    end
    L28_2 = L4_1
    L28_2 = L28_2.Shared
    L28_2 = L28_2.RoofHandler
    L29_2 = L28_2
    L28_2 = L28_2.CreateRoof
    L30_2 = L5_2
    L31_2 = L27_2
    L32_2 = L26_2.Settings
    L28_2 = L28_2(L29_2, L30_2, L31_2, L32_2)
    L29_2 = L28_2.Model
    if L29_2 then
      L29_2 = L28_2.Model
      L29_2.Parent = L19_2
      L29_2 = pairs
      L30_2 = L28_2.Model
      L31_2 = L30_2
      L30_2 = L30_2.GetDescendants
      L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2 = L30_2(L31_2)
      L29_2, L30_2, L31_2 = L29_2(L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2)
      for L32_2, L33_2 in L29_2, L30_2, L31_2 do
        L35_2 = L33_2
        L34_2 = L33_2.IsA
        L36_2 = "BasePart"
        L34_2 = L34_2(L35_2, L36_2)
        if L34_2 then
          L33_2.CanCollide = true
        end
      end
      L29_2 = L26_2.Color
      if L29_2 then
        L29_2 = L20_2
        L30_2 = L26_2.Color
        L31_2 = L28_2.Model
        L29_2(L30_2, L31_2)
      end
    end
    L29_2 = L18_2
    L29_2()
  end
  L22_2 = L16_2
  L23_2 = "Previewing Fences!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Fences
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = L14_2
    L28_2 = L26_2.To
    L27_2 = L27_2(L28_2)
    L28_2 = L14_2
    L29_2 = L26_2.From
    L28_2 = L28_2(L29_2)
    L29_2 = L26_2.Name
    if L29_2 == "Hanging Lights" then
      L26_2.Name = "Classic Hanging Lights"
    end
    L29_2 = L4_1
    L29_2 = L29_2.Shared
    L29_2 = L29_2.FenceHandler
    L30_2 = L29_2
    L29_2 = L29_2.CreateFence
    L31_2 = L5_2
    L32_2 = L26_2.Name
    L29_2, L30_2 = L29_2(L30_2, L31_2, L32_2)
    L32_2 = L30_2
    L31_2 = L30_2.Update
    L33_2 = L27_2
    L34_2 = L28_2
    L31_2(L32_2, L33_2, L34_2)
    L32_2 = L30_2
    L31_2 = L30_2.GetModel
    L31_2 = L31_2(L32_2)
    L31_2.Parent = L19_2
    L32_2 = L26_2.Color
    if L32_2 then
      L32_2 = L20_2
      L33_2 = L26_2.Color
      L34_2 = L31_2
      L32_2(L33_2, L34_2)
    end
    L32_2 = L18_2
    L32_2()
  end
  L22_2 = L16_2
  L23_2 = "Previewing Pools!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Pools
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
  end
  L22_2 = L16_2
  L23_2 = "Previewing Paths!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Paths
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
  end
  L22_2 = L16_2
  L23_2 = "Previewing Counters!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Counters
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = L21_2
    L28_2 = L26_2
    L27_2(L28_2)
    L27_2 = L26_2.Objects
    if L27_2 then
      L27_2 = pairs
      L28_2 = L26_2.Objects
      L27_2, L28_2, L29_2 = L27_2(L28_2)
      for L30_2, L31_2 in L27_2, L28_2, L29_2 do
        L32_2 = L21_2
        L33_2 = L31_2
        L32_2(L33_2)
        L32_2 = L18_2
        L32_2()
      end
    end
    L27_2 = L18_2
    L27_2()
  end
  L22_2 = L16_2
  L23_2 = "Previewing Loose Objects!"
  L22_2(L23_2)
  L22_2 = pairs
  L23_2 = L13_2.Objects
  L22_2, L23_2, L24_2 = L22_2(L23_2)
  for L25_2, L26_2 in L22_2, L23_2, L24_2 do
    L27_2 = L21_2
    L28_2 = L26_2
    L27_2(L28_2)
    L27_2 = L18_2
    L27_2()
  end
  L22_2 = L16_2
  L23_2 = "Preview Done!"
  L22_2(L23_2)
  L22_2 = L18_1
  L23_2 = L22_2
  L22_2 = L22_2.CreateNotification
  L24_2 = "Success"
  L25_2 = nil
  L26_2 = [[
Successfully loaded preview!
Note: This preview does not fully reflect the original build, please build the base or look at images posted by the original uploader for more details on how it should look.]]
  L22_2(L23_2, L24_2, L25_2, L26_2)
  L22_2 = true
end

L25_1.preview_base = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = game
  L1_2 = L1_2.Workspace
  L2_2 = L1_2
  L1_2 = L1_2.FindFirstChild
  L3_2 = "ChromaBasePreview"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = game
    L1_2 = L1_2.Workspace
    L1_2 = L1_2.ChromaBasePreview
    L2_2 = L1_2
    L1_2 = L1_2.Destroy
    L1_2(L2_2)
  end
end

L25_1.destroy_preview = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = {}
  L2_2["Content-Type"] = "application/json"
  L3_2 = game
  L3_2 = L3_2.HttpService
  L4_2 = L3_2
  L3_2 = L3_2.JSONEncode
  L5_2 = {}
  L5_2.image_url = A1_2
  L5_2.x = 60
  L5_2.y = 60
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = "https://api.applebee1558.com/alphax/v2/bloxburg/pixelart"
  L6_2 = A0_2
  L5_2 = A0_2.http_request
  L7_2 = {}
  L7_2.Url = L4_2
  L7_2.Method = "POST"
  L7_2.Headers = L2_2
  L7_2.Body = L3_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = game
  L6_2 = L6_2.HttpService
  L7_2 = L6_2
  L6_2 = L6_2.JSONDecode
  L8_2 = L5_2.Body
  L6_2 = L6_2(L7_2, L8_2)
  L5_2 = L6_2
end

L25_1.get_pixelart_metadata = L26_1

function L26_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2)
  local L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  if not A3_2 then
    L7_2 = tostring
    L8_2 = L4_1
    L8_2 = L8_2.Shared
    L8_2 = L8_2.PlotHandler
    L9_2 = L8_2
    L8_2 = L8_2.GetBuildPlot
    L10_2 = game
    L10_2 = L10_2.Players
    L10_2 = L10_2.LocalPlayer
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L8_2(L9_2, L10_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    L8_2 = "Plot_"
    L9_2 = A2_2.Name
    L8_2 = L8_2 .. L9_2
    if L7_2 ~= L8_2 then
      L7_2 = L18_1
      L8_2 = L7_2
      L7_2 = L7_2.CreateNotification
      L9_2 = "Error"
      L10_2 = nil
      L11_2 = "Please enter build mode in "
      L12_2 = A2_2.Name
      L13_2 = "'s Base first before auto-building!"
      L11_2 = L11_2 .. L12_2 .. L13_2
      L7_2(L8_2, L9_2, L10_2, L11_2)
      return
    end
  end
  L7_2 = 0
  L8_2 = #A1_2
  L9_2 = nil
  L10_2 = {}
  L11_2 = 0.75
  
  function L12_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = L7_2
    L0_3 = L0_3 + 1
    L7_2 = L0_3
    L0_3 = A5_2
    L1_3 = L7_2
    L2_3 = L8_2
    L0_3(L1_3, L2_3)
    L0_3 = L9_2
    if L0_3 == nil then
      L0_3 = tick
      L0_3 = L0_3()
      L9_2 = L0_3
    else
      L0_3 = tick
      L0_3 = L0_3()
      L1_3 = L9_2
      L0_3 = L0_3 - L1_3
      L1_3 = table
      L1_3 = L1_3.insert
      L2_3 = L10_2
      L3_3 = L0_3
      L1_3(L2_3, L3_3)
      L1_3 = 0
      L2_3 = pairs
      L3_3 = L10_2
      L2_3, L3_3, L4_3 = L2_3(L3_3)
      for L5_3, L6_3 in L2_3, L3_3, L4_3 do
        L1_3 = L1_3 + L6_3
      end
      L2_3 = L10_2
      L2_3 = #L2_3
      L2_3 = L1_3 / L2_3
      L11_2 = L2_3
      L2_3 = tick
      L2_3 = L2_3()
      L9_2 = L2_3
    end
    L0_3 = A6_2
    L1_3 = A0_2
    L2_3 = L1_3
    L1_3 = L1_3.split_time
    L3_3 = L8_2
    L4_3 = L7_2
    L3_3 = L3_3 - L4_3
    L4_3 = L11_2
    L3_3 = L3_3 * L4_3
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3 = L1_3(L2_3, L3_3)
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3)
  end
  
  L13_2 = A5_2
  L14_2 = 0
  L15_2 = L8_2
  L13_2(L14_2, L15_2)
  L13_2 = A4_2
  L14_2 = "Building Pixel Art..."
  L13_2(L14_2)
  L13_2 = game
  L13_2 = L13_2.Workspace
  L13_2 = L13_2.Plots
  L14_2 = "Plot_"
  L15_2 = A2_2.Name
  L14_2 = L14_2 .. L15_2
  L13_2 = L13_2[L14_2]
  L14_2 = 1
  
  function L15_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
    L0_3 = L14_2
    L0_3 = L0_3 + 1
    L14_2 = L0_3
    L0_3 = L14_2
    if 4 < L0_3 then
      L0_3 = A3_2
      if not L0_3 then
        L0_3 = wait
        L1_3 = 3
        L0_3(L1_3)
      end
      L0_3 = 1
      L14_2 = L0_3
    end
  end
  
  L16_2 = game
  L16_2 = L16_2.Workspace
  L17_2 = L16_2
  L16_2 = L16_2.FindFirstChild
  L18_2 = "ChromaAutoBuildPreview"
  L16_2 = L16_2(L17_2, L18_2)
  if L16_2 then
    L16_2 = game
    L16_2 = L16_2.Workspace
    L17_2 = L16_2
    L16_2 = L16_2.FindFirstChild
    L18_2 = "ChromaAutoBuildPreview"
    L16_2 = L16_2(L17_2, L18_2)
    L17_2 = L16_2
    L16_2 = L16_2.Destroy
    L16_2(L17_2)
  end
  L16_2 = nil
  L17_2 = game
  L17_2 = L17_2.ReplicatedStorage
  L17_2 = L17_2.ItemModels
  L18_2 = L17_2
  L17_2 = L17_2.FindFirstChild
  L19_2 = "Cube"
  L20_2 = true
  L17_2 = L17_2(L18_2, L19_2, L20_2)
  if A3_2 then
    L18_2 = Instance
    L18_2 = L18_2.new
    L19_2 = "Folder"
    L20_2 = game
    L20_2 = L20_2.Workspace
    L18_2 = L18_2(L19_2, L20_2)
    L16_2 = L18_2
    L16_2.Name = "ChromaAutoBuildPreview"
  end
  L18_2 = Vector3
  L18_2 = L18_2.new
  L19_2 = -73.75
  L20_2 = 3.899993896484375
  L21_2 = -123.75
  L18_2 = L18_2(L19_2, L20_2, L21_2)
  L19_2 = pairs
  L20_2 = A1_2
  L19_2, L20_2, L21_2 = L19_2(L20_2)
  for L22_2, L23_2 in L19_2, L20_2, L21_2 do
    L24_2 = L23_2.X
    L24_2 = 2.5 * L24_2
    L25_2 = L23_2.Y
    L25_2 = 2.5 * L25_2
    L26_2 = BrickColor
    L26_2 = L26_2.new
    L27_2 = Color3
    L27_2 = L27_2.fromRGB
    L28_2 = L23_2.R
    L29_2 = L23_2.G
    L30_2 = L23_2.B
    L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L27_2(L28_2, L29_2, L30_2)
    L26_2 = L26_2(L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    L27_2 = L26_2.Number
    L28_2 = math
    L28_2 = L28_2.pi
    L29_2 = Vector3
    L29_2 = L29_2.new
    L30_2 = L24_2
    L31_2 = 0
    L32_2 = L25_2
    L29_2 = L29_2(L30_2, L31_2, L32_2)
    L29_2 = L18_2 + L29_2
    L30_2 = L21_1
    if not L30_2 then
      L30_2 = print
    end
    L31_2 = "Cube"
    L32_2 = L23_2.X
    if 36 <= L32_2 then
      L31_2 = "Simplicity End Table"
    end
    L32_2 = L15_2
    L32_2()
    L32_2 = L12_2
    L32_2()
    if not A3_2 then
      L32_2 = L22_1
      L33_2 = L32_2
      L32_2 = L32_2.InvokeServer
      L34_2 = {}
      L34_2.Type = "PlaceObject"
      L34_2.Name = L31_2
      L35_2 = L13_2.GroundParts
      L35_2 = L35_2.Ground
      L34_2.TargetModel = L35_2
      L34_2.Rot = L28_2
      L35_2 = L13_2.Water
      L35_2 = L35_2.CFrame
      L36_2 = L35_2
      L35_2 = L35_2.PointToWorldSpace
      L37_2 = L29_2
      L35_2 = L35_2(L36_2, L37_2)
      L34_2.Pos = L35_2
      L32_2, L33_2 = L32_2(L33_2, L34_2)
      L34_2 = L22_1
      L35_2 = L34_2
      L34_2 = L34_2.InvokeServer
      L36_2 = {}
      L36_2.Type = "ColorObject"
      L36_2.Object = L32_2
      L36_2.UseMaterials = true
      L37_2 = {}
      L38_2 = {}
      L39_2 = L27_2
      L40_2 = 15
      L38_2[1] = L39_2
      L38_2[2] = L40_2
      L39_2 = {}
      L40_2 = {}
      L41_2 = {}
      L37_2[1] = L38_2
      L37_2[2] = L39_2
      L37_2[3] = L40_2
      L37_2[4] = L41_2
      L36_2.Data = L37_2
      L34_2(L35_2, L36_2)
    else
      L33_2 = L17_2
      L32_2 = L17_2.Clone
      L32_2 = L32_2(L33_2)
      L32_2.Parent = L16_2
      L33_2 = L32_2.Origin
      L33_2.BrickColor = L26_2
      L33_2 = L32_2.ResizeRoot1
      L33_2.BrickColor = L26_2
      L33_2 = L32_2.PlaceAll
      L33_2.BrickColor = L26_2
      L34_2 = L32_2
      L33_2 = L32_2.SetPrimaryPartCFrame
      L35_2 = CFrame
      L35_2 = L35_2.new
      L36_2 = L13_2.Water
      L36_2 = L36_2.CFrame
      L37_2 = L36_2
      L36_2 = L36_2.PointToWorldSpace
      L38_2 = L29_2
      L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L36_2(L37_2, L38_2)
      L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L35_2(L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
      L33_2(L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    end
  end
end

L25_1.make_pixelart = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = game
  L1_2 = L1_2.Workspace
  L2_2 = L1_2
  L1_2 = L1_2.FindFirstChild
  L3_2 = "ChromaAutoBuildPreview"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = game
    L1_2 = L1_2.Workspace
    L2_2 = L1_2
    L1_2 = L1_2.FindFirstChild
    L3_2 = "ChromaAutoBuildPreview"
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = L1_2
    L1_2 = L1_2.Destroy
    L1_2(L2_2)
  end
end

L25_1.destroy_pixelart_preview = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = L4_1
  L3_2 = L3_2.Shared
  L3_2 = L3_2.JobData
  L3_2 = L3_2.Data
  L2_2, L3_2, L4_2 = L2_2(L3_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = table
    L7_2 = L7_2.insert
    L8_2 = L1_2
    L9_2 = {}
    L10_2 = L6_2.Title
    L11_2 = L5_2
    L9_2[1] = L10_2
    L9_2[2] = L11_2
    L7_2(L8_2, L9_2)
  end
end

L25_1.get_jobs_list = L26_1
L25_1.do_autofarm_loop = false
L25_1.current_job = nil
L25_1.do_moods = false
L25_1.boost_mood_threshold = 30
L25_1.quit_after_amount = 0
L25_1.quit_after_enabled = false

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = next
  L2_2 = workspace
  L2_2 = L2_2.Environment
  L2_2 = L2_2.Locations
  L2_2 = L2_2.StylezHairStudio
  L2_2 = L2_2.HairdresserWorkstations
  L3_2 = L2_2
  L2_2 = L2_2.GetChildren
  L2_2, L3_2 = L2_2(L3_2)
  for L4_2, L5_2 in L1_2, L2_2, L3_2 do
    L6_2 = L5_2.Mirror
    L7_2 = L6_2
    L6_2 = L6_2.FindFirstChild
    L8_2 = "HairdresserGUI"
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = L5_2.Mirror
      L6_2 = L6_2.HairdresserGUI
      L6_2 = L6_2.Used
      L6_2 = L6_2.Visible
      if L6_2 == false then
        goto lbl_29
      end
    end
    L6_2 = L5_2.InUse
    L6_2 = L6_2.Value
    L7_2 = game
    L7_2 = L7_2.Players
    L7_2 = L7_2.LocalPlayer
    ::lbl_29::
    if L6_2 == L7_2 then
      L6_2 = L5_2.Occupied
      L6_2 = L6_2.Value
      if L6_2 ~= nil then
        L6_2 = L5_2.Mirror
        L6_2 = L6_2.HairdresserGUI
        L6_2 = L6_2.Overlay
        L7_2 = L6_2
        L6_2 = L6_2.FindFirstChild
        L8_2 = "false"
        L6_2 = L6_2(L7_2, L8_2)
        L7_2 = Vector2
        L7_2 = L7_2.new
        L8_2 = 0
        L9_2 = 0
        L7_2 = L7_2(L8_2, L9_2)
        L6_2.ImageRectOffset = L7_2
        L6_2 = L5_2.Mirror
        L6_2 = L6_2.HairdresserGUI
        L6_2 = L6_2.Overlay
        L7_2 = L6_2
        L6_2 = L6_2.FindFirstChild
        L8_2 = "false"
        L6_2 = L6_2(L7_2, L8_2)
        L7_2 = Color3
        L7_2 = L7_2.new
        L8_2 = 0
        L9_2 = 255
        L10_2 = 0
        L7_2 = L7_2(L8_2, L9_2, L10_2)
        L6_2.ImageColor3 = L7_2
        L6_2 = next
        L7_2 = L15_1
        L8_2 = L5_2.Mirror
        L8_2 = L8_2.HairdresserGUI
        L8_2 = L8_2.Frame
        L8_2 = L8_2.Done
        L8_2 = L8_2.Activated
        L7_2, L8_2 = L7_2(L8_2)
        for L9_2, L10_2 in L6_2, L7_2, L8_2 do
          L12_2 = L10_2
          L11_2 = L10_2.Fire
          L11_2(L12_2)
        end
      end
    end
  end
end

L25_1.do_hairdresser = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = next
  L2_2 = workspace
  L2_2 = L2_2.Environment
  L2_2 = L2_2.Locations
  L2_2 = L2_2.BloxyBurgers
  L2_2 = L2_2.CashierWorkstations
  L3_2 = L2_2
  L2_2 = L2_2.GetChildren
  L2_2, L3_2 = L2_2(L3_2)
  for L4_2, L5_2 in L1_2, L2_2, L3_2 do
    L6_2 = L5_2.InUse
    L6_2 = L6_2.Value
    L7_2 = game
    L7_2 = L7_2.Players
    L7_2 = L7_2.LocalPlayer
    if L6_2 == L7_2 then
      L6_2 = L5_2.Occupied
      L6_2 = L6_2.Value
      if L6_2 ~= nil then
        goto lbl_29
      end
    end
    L6_2 = L5_2.InUse
    L6_2 = L6_2.Value
    if L6_2 == nil then
      L6_2 = L5_2.Occupied
      L6_2 = L6_2.Value
      ::lbl_29::
      if L6_2 ~= nil then
        L7_2 = L5_2
        L6_2 = L5_2.FindFirstChild
        L8_2 = "OrderDisplay"
        L6_2 = L6_2(L7_2, L8_2)
        if L6_2 then
          L6_2 = L5_2.OrderDisplay
          L7_2 = L6_2
          L6_2 = L6_2.FindFirstChild
          L8_2 = "DisplayMain"
          L6_2 = L6_2(L7_2, L8_2)
          if L6_2 then
            L6_2 = L5_2.OrderDisplay
            L6_2 = L6_2.DisplayMain
            L7_2 = L6_2
            L6_2 = L6_2.FindFirstChild
            L8_2 = "CashierGUI"
            L6_2 = L6_2(L7_2, L8_2)
            if L6_2 then
              L6_2 = L5_2.OrderDisplay
              L6_2 = L6_2.DisplayMain
              L6_2 = L6_2.CashierGUI
              L6_2 = L6_2.Overlay
              L7_2 = L6_2
              L6_2 = L6_2.FindFirstChild
              L8_2 = "false"
              L6_2 = L6_2(L7_2, L8_2)
              L7_2 = Vector2
              L7_2 = L7_2.new
              L8_2 = 0
              L9_2 = 0
              L7_2 = L7_2(L8_2, L9_2)
              L6_2.ImageRectOffset = L7_2
              L6_2 = L5_2.OrderDisplay
              L6_2 = L6_2.DisplayMain
              L6_2 = L6_2.CashierGUI
              L6_2 = L6_2.Overlay
              L7_2 = L6_2
              L6_2 = L6_2.FindFirstChild
              L8_2 = "false"
              L6_2 = L6_2(L7_2, L8_2)
              L7_2 = Color3
              L7_2 = L7_2.new
              L8_2 = 0
              L9_2 = 255
              L10_2 = 0
              L7_2 = L7_2(L8_2, L9_2, L10_2)
              L6_2.ImageColor3 = L7_2
              L6_2 = next
              L7_2 = L15_1
              L8_2 = L5_2.OrderDisplay
              L8_2 = L8_2.DisplayMain
              L8_2 = L8_2.CashierGUI
              L8_2 = L8_2.Frame
              L8_2 = L8_2.Done
              L8_2 = L8_2.Activated
              L7_2, L8_2 = L7_2(L8_2)
              for L9_2, L10_2 in L6_2, L7_2, L8_2 do
                L12_2 = L10_2
                L11_2 = L10_2.Fire
                L11_2(L12_2)
              end
            end
          end
        end
      end
    end
  end
end

L25_1.do_burgercashier = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L2_2 = pairs
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "Workspace"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2._game
  L3_2 = L3_2.SpawnedCharacters
  L4_2 = L3_2
  L3_2 = L3_2.GetChildren
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = L6_2.Name
    if L7_2 == "MikesMotorsCustomer" then
      L8_2 = L6_2
      L7_2 = L6_2.FindFirstChild
      L9_2 = "HumanoidRootPart"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L8_2 = L6_2
        L7_2 = L6_2.FindFirstChild
        L9_2 = "HumanoidRootPart"
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = L7_2
        L7_2 = L7_2.FindFirstChild
        L9_2 = "AttachWeld"
        L7_2 = L7_2(L8_2, L9_2)
        if L7_2 then
          L8_2 = L6_2
          L7_2 = L6_2.WaitForChild
          L9_2 = "HumanoidRootPart"
          L7_2 = L7_2(L8_2, L9_2)
          L8_2 = L7_2
          L7_2 = L7_2.FindFirstChild
          L9_2 = "AttachWeld"
          L7_2 = L7_2(L8_2, L9_2)
          L8_2 = L7_2.Part1
          if L8_2 then
            L8_2 = L7_2.Part1
            L8_2 = L8_2.Name
            if L8_2 == "CustomerTarget" then
              L8_2 = L7_2.Part1
              L8_2 = L8_2.Parent
              L8_2 = L8_2.Name
              if L8_2 == "Workstation" then
                L8_2 = L6_2
                L9_2 = L7_2.Part1
                L9_2 = L9_2.Parent
                L11_2 = L1_2
                L10_2 = L1_2.DistanceFromCharacter
                L12_2 = L9_2.PrimaryPart
                L12_2 = L12_2.Position
                L10_2 = L10_2(L11_2, L12_2)
                if L10_2 < 15 then
                  L11_2 = L8_2
                  L10_2 = L8_2.FindFirstChildOfClass
                  L12_2 = "CFrameValue"
                  L10_2 = L10_2(L11_2, L12_2)
                  if L10_2 then
                    return
                  end
                  L10_2 = Instance
                  L10_2 = L10_2.new
                  L11_2 = "CFrameValue"
                  L12_2 = L8_2
                  L10_2(L11_2, L12_2)
                  L11_2 = L8_2
                  L10_2 = L8_2.WaitForChild
                  L12_2 = "Order"
                  L10_2 = L10_2(L11_2, L12_2)
                  L11_2 = L10_2.Vehicle
                  L11_2 = L11_2.Value
                  L12_2 = nil
                  L14_2 = L10_2
                  L13_2 = L10_2.FindFirstChild
                  L15_2 = "Color"
                  L13_2 = L13_2(L14_2, L15_2)
                  if L13_2 then
                    L12_2 = "Color"
                  else
                    L14_2 = L10_2
                    L13_2 = L10_2.FindFirstChild
                    L15_2 = "Wheels"
                    L13_2 = L13_2(L14_2, L15_2)
                    if L13_2 then
                      L12_2 = "Wheels"
                    else
                      L14_2 = L10_2
                      L13_2 = L10_2.FindFirstChild
                      L15_2 = "Oil"
                      L13_2 = L13_2(L14_2, L15_2)
                      if L13_2 then
                        L12_2 = "Oil"
                      end
                    end
                  end
                  if L12_2 == "Color" then
                    L13_2 = L10_2.Color
                    L13_2 = L13_2.Value
                    L14_2 = game
                    L15_2 = L14_2
                    L14_2 = L14_2.GetService
                    L16_2 = "Workspace"
                    L14_2 = L14_2(L15_2, L16_2)
                    L14_2 = L14_2.Environment
                    L14_2 = L14_2.Locations
                    L14_2 = L14_2.MikesMotors
                    L14_2 = L14_2.PaintingEquipment
                    L15_2 = L14_2
                    L14_2 = L14_2.FindFirstChild
                    L16_2 = L13_2
                    L14_2 = L14_2(L15_2, L16_2)
                    L16_2 = A0_2
                    L15_2 = A0_2.tween_teleport
                    L17_2 = CFrame
                    L17_2 = L17_2.new
                    L18_2 = L14_2.Can
                    L18_2 = L18_2.Position
                    L17_2 = L17_2(L18_2)
                    L18_2 = Vector3
                    L18_2 = L18_2.new
                    L19_2 = 0
                    L20_2 = 1
                    L21_2 = 0
                    L18_2 = L18_2(L19_2, L20_2, L21_2)
                    L17_2 = L17_2 + L18_2
                    L15_2(L16_2, L17_2)
                    while true do
                      L15_2 = L1_2.Character
                      L16_2 = L15_2
                      L15_2 = L15_2.FindFirstChild
                      L17_2 = "Spray Painter"
                      L15_2 = L15_2(L16_2, L17_2)
                      if L15_2 then
                        break
                      end
                      L15_2 = L23_1
                      L16_2 = L15_2
                      L15_2 = L15_2.FireServer
                      L17_2 = {}
                      L17_2.Type = "TakePainter"
                      L17_2.Object = L14_2
                      L15_2(L16_2, L17_2)
                      L15_2 = wait
                      L15_2()
                    end
                    L16_2 = A0_2
                    L15_2 = A0_2.tween_teleport
                    L17_2 = CFrame
                    L17_2 = L17_2.new
                    L18_2 = L8_2.Vehicle
                    L18_2 = L18_2.Body
                    L18_2 = L18_2.Position
                    L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L17_2(L18_2)
                    L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
                    while true do
                      L15_2 = L1_2.Character
                      L16_2 = L15_2
                      L15_2 = L15_2.FindFirstChild
                      L17_2 = "Spray Painter"
                      L15_2 = L15_2(L16_2, L17_2)
                      if not L15_2 then
                        break
                      end
                      L15_2 = L23_1
                      L16_2 = L15_2
                      L15_2 = L15_2.FireServer
                      L17_2 = {}
                      L17_2.Type = "FixBike"
                      L17_2.Workstation = L9_2
                      L15_2(L16_2, L17_2)
                      L15_2 = wait
                      L15_2()
                    end
                    L15_2 = L23_1
                    L16_2 = L15_2
                    L15_2 = L15_2.FireServer
                    L17_2 = {}
                    L17_2.Type = "JobCompleted"
                    L17_2.Workstation = L9_2
                    L15_2(L16_2, L17_2)
                  elseif L12_2 == "Wheels" then
                    L13_2 = L10_2.Wheels
                    L13_2 = L13_2.Value
                    L14_2 = game
                    L15_2 = L14_2
                    L14_2 = L14_2.GetService
                    L16_2 = "Workspace"
                    L14_2 = L14_2(L15_2, L16_2)
                    L14_2 = L14_2.Environment
                    L14_2 = L14_2.Locations
                    L14_2 = L14_2.MikesMotors
                    L14_2 = L14_2.TireRacks
                    L15_2 = L14_2
                    L14_2 = L14_2.FindFirstChild
                    L16_2 = L13_2
                    L14_2 = L14_2(L15_2, L16_2)
                    L16_2 = A0_2
                    L15_2 = A0_2.tween_teleport
                    L17_2 = CFrame
                    L17_2 = L17_2.new
                    L18_2 = L14_2.Part
                    L18_2 = L18_2.Position
                    L17_2 = L17_2(L18_2)
                    L18_2 = Vector3
                    L18_2 = L18_2.new
                    L19_2 = 0
                    L20_2 = 1
                    L21_2 = 0
                    L18_2 = L18_2(L19_2, L20_2, L21_2)
                    L17_2 = L17_2 + L18_2
                    L15_2(L16_2, L17_2)
                    while true do
                      L15_2 = L1_2.Character
                      L16_2 = L15_2
                      L15_2 = L15_2.FindFirstChild
                      L17_2 = "Motorcycle Wheel"
                      L15_2 = L15_2(L16_2, L17_2)
                      if L15_2 then
                        break
                      end
                      L15_2 = L23_1
                      L16_2 = L15_2
                      L15_2 = L15_2.FireServer
                      L17_2 = {}
                      L17_2.Type = "TakeWheel"
                      L17_2.Object = L14_2
                      L15_2(L16_2, L17_2)
                      L15_2 = wait
                      L15_2()
                    end
                    L16_2 = A0_2
                    L15_2 = A0_2.tween_teleport
                    L17_2 = CFrame
                    L17_2 = L17_2.new
                    L18_2 = L8_2.Vehicle
                    L18_2 = L18_2.Body
                    L18_2 = L18_2.Position
                    L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L17_2(L18_2)
                    L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
                    while true do
                      L15_2 = L1_2.Character
                      L16_2 = L15_2
                      L15_2 = L15_2.FindFirstChild
                      L17_2 = "Motorcycle Wheel"
                      L15_2 = L15_2(L16_2, L17_2)
                      if not L15_2 then
                        break
                      end
                      L15_2 = L23_1
                      L16_2 = L15_2
                      L15_2 = L15_2.FireServer
                      L17_2 = {}
                      L17_2.Type = "FixBike"
                      L17_2.Workstation = L9_2
                      L15_2(L16_2, L17_2)
                      L15_2 = wait
                      L15_2()
                    end
                    L16_2 = A0_2
                    L15_2 = A0_2.tween_teleport
                    L17_2 = CFrame
                    L17_2 = L17_2.new
                    L18_2 = L14_2.Part
                    L18_2 = L18_2.Position
                    L17_2 = L17_2(L18_2)
                    L18_2 = Vector3
                    L18_2 = L18_2.new
                    L19_2 = 0
                    L20_2 = 1
                    L21_2 = 0
                    L18_2 = L18_2(L19_2, L20_2, L21_2)
                    L17_2 = L17_2 + L18_2
                    L15_2(L16_2, L17_2)
                    while true do
                      L15_2 = L1_2.Character
                      L16_2 = L15_2
                      L15_2 = L15_2.FindFirstChild
                      L17_2 = "Motorcycle Wheel"
                      L15_2 = L15_2(L16_2, L17_2)
                      if L15_2 then
                        break
                      end
                      L15_2 = L23_1
                      L16_2 = L15_2
                      L15_2 = L15_2.FireServer
                      L17_2 = {}
                      L17_2.Type = "TakeWheel"
                      L17_2.Object = L14_2
                      L15_2(L16_2, L17_2)
                      L15_2 = wait
                      L15_2()
                    end
                    L16_2 = A0_2
                    L15_2 = A0_2.tween_teleport
                    L17_2 = CFrame
                    L17_2 = L17_2.new
                    L18_2 = L8_2.Vehicle
                    L18_2 = L18_2.Body
                    L18_2 = L18_2.Position
                    L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L17_2(L18_2)
                    L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
                    while true do
                      L15_2 = L1_2.Character
                      L16_2 = L15_2
                      L15_2 = L15_2.FindFirstChild
                      L17_2 = "Motorcycle Wheel"
                      L15_2 = L15_2(L16_2, L17_2)
                      if not L15_2 then
                        break
                      end
                      L15_2 = L23_1
                      L16_2 = L15_2
                      L15_2 = L15_2.FireServer
                      L17_2 = {}
                      L17_2.Type = "FixBike"
                      L17_2.Workstation = L9_2
                      L17_2.Front = true
                      L15_2(L16_2, L17_2)
                      L15_2 = wait
                      L15_2()
                    end
                    L15_2 = L23_1
                    L16_2 = L15_2
                    L15_2 = L15_2.FireServer
                    L17_2 = {}
                    L17_2.Type = "JobCompleted"
                    L17_2.Workstation = L9_2
                    L15_2(L16_2, L17_2)
                  elseif L12_2 == "Oil" then
                    L13_2 = game
                    L14_2 = L13_2
                    L13_2 = L13_2.GetService
                    L15_2 = "Workspace"
                    L13_2 = L13_2(L14_2, L15_2)
                    L13_2 = L13_2.Environment
                    L13_2 = L13_2.Locations
                    L13_2 = L13_2.MikesMotors
                    L13_2 = L13_2.OilCans
                    L14_2 = L13_2
                    L13_2 = L13_2.FindFirstChild
                    L15_2 = "Can"
                    L13_2 = L13_2(L14_2, L15_2)
                    L15_2 = A0_2
                    L14_2 = A0_2.tween_teleport
                    L16_2 = CFrame
                    L16_2 = L16_2.new
                    L17_2 = L13_2.Body
                    L17_2 = L17_2.Position
                    L16_2 = L16_2(L17_2)
                    L17_2 = Vector3
                    L17_2 = L17_2.new
                    L18_2 = 0
                    L19_2 = 1
                    L20_2 = 0
                    L17_2 = L17_2(L18_2, L19_2, L20_2)
                    L16_2 = L16_2 + L17_2
                    L14_2(L15_2, L16_2)
                    while true do
                      L14_2 = L1_2.Character
                      L15_2 = L14_2
                      L14_2 = L14_2.FindFirstChild
                      L16_2 = "Oil Can"
                      L14_2 = L14_2(L15_2, L16_2)
                      if L14_2 then
                        break
                      end
                      L14_2 = L23_1
                      L15_2 = L14_2
                      L14_2 = L14_2.FireServer
                      L16_2 = {}
                      L16_2.Type = "TakeOil"
                      L16_2.Object = L13_2
                      L14_2(L15_2, L16_2)
                      L14_2 = wait
                      L14_2()
                    end
                    L15_2 = A0_2
                    L14_2 = A0_2.tween_teleport
                    L16_2 = CFrame
                    L16_2 = L16_2.new
                    L17_2 = L8_2.Vehicle
                    L17_2 = L17_2.Body
                    L17_2 = L17_2.Position
                    L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L16_2(L17_2)
                    L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
                    while true do
                      L14_2 = L1_2.Character
                      L15_2 = L14_2
                      L14_2 = L14_2.FindFirstChild
                      L16_2 = "Oil Can"
                      L14_2 = L14_2(L15_2, L16_2)
                      if not L14_2 then
                        break
                      end
                      L14_2 = L23_1
                      L15_2 = L14_2
                      L14_2 = L14_2.FireServer
                      L16_2 = {}
                      L16_2.Type = "FixBike"
                      L16_2.Workstation = L9_2
                      L14_2(L15_2, L16_2)
                      L14_2 = wait
                      L14_2()
                    end
                    L14_2 = L23_1
                    L15_2 = L14_2
                    L14_2 = L14_2.FireServer
                    L16_2 = {}
                    L16_2.Type = "JobCompleted"
                    L16_2.Workstation = L9_2
                    L14_2(L15_2, L16_2)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

L25_1.do_mechanic = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L2_2 = pairs
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "Workspace"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2.Environment
  L3_2 = L3_2.Locations
  L3_2 = L3_2.PizzaPlanet
  L3_2 = L3_2.BakerWorkstations
  L4_2 = L3_2
  L3_2 = L3_2.GetChildren
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = L6_2.Name
    if L7_2 == "Workstation" then
      function L7_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
        
        L0_3 = L6_2
        L1_3 = L1_2
        L2_3 = L1_3
        L1_3 = L1_3.DistanceFromCharacter
        L3_3 = L0_3.PrimaryPart
        L3_3 = L3_3.Position
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 < 15 then
          L1_3 = L0_3.Order
          L1_3 = L1_3.IngredientsLeft
          L1_3 = L1_3.Value
          if L1_3 < 1 then
            L1_3 = game
            L2_3 = L1_3
            L1_3 = L1_3.GetService
            L3_3 = "Workspace"
            L1_3 = L1_3(L2_3, L3_3)
            L1_3 = L1_3.Environment
            L1_3 = L1_3.Locations
            L1_3 = L1_3.PizzaPlanet
            L1_3 = L1_3.IngredientCrates
            L2_3 = L1_3
            L1_3 = L1_3.FindFirstChild
            L3_3 = "Crate"
            L1_3 = L1_3(L2_3, L3_3)
            L2_3 = A0_2
            L3_3 = L2_3
            L2_3 = L2_3.tween_teleport
            L4_3 = CFrame
            L4_3 = L4_3.new
            L5_3 = L1_3.Position
            L4_3, L5_3, L6_3, L7_3, L8_3 = L4_3(L5_3)
            L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
            while true do
              L2_3 = L1_2
              L2_3 = L2_3.Character
              L3_3 = L2_3
              L2_3 = L2_3.FindFirstChild
              L4_3 = "Ingredient Crate"
              L2_3 = L2_3(L3_3, L4_3)
              if L2_3 then
                break
              end
              L2_3 = L23_1
              L3_3 = L2_3
              L2_3 = L2_3.FireServer
              L4_3 = {}
              L4_3.Type = "TakeIngredientCrate"
              L4_3.Object = L1_3
              L2_3(L3_3, L4_3)
              L2_3 = wait
              L2_3()
            end
            L2_3 = A0_2
            L3_3 = L2_3
            L2_3 = L2_3.tween_teleport
            L4_3 = CFrame
            L4_3 = L4_3.new
            L5_3 = L0_3.PrimaryPart
            L5_3 = L5_3.Position
            L4_3, L5_3, L6_3, L7_3, L8_3 = L4_3(L5_3)
            L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
            while true do
              L2_3 = L1_2
              L2_3 = L2_3.Character
              L3_3 = L2_3
              L2_3 = L2_3.FindFirstChild
              L4_3 = "Ingredient Crate"
              L2_3 = L2_3(L3_3, L4_3)
              if not L2_3 then
                break
              end
              L2_3 = L23_1
              L3_3 = L2_3
              L2_3 = L2_3.FireServer
              L4_3 = {}
              L4_3.Type = "RestockIngredients"
              L4_3.Workstation = L0_3
              L2_3(L3_3, L4_3)
              L2_3 = wait
              L2_3()
            end
            return
          end
          L1_3 = L0_3.Order
          L1_3 = L1_3.Value
          if L1_3 ~= "false" then
            L1_3 = 1
            L2_3 = math
            L2_3 = L2_3.random
            L3_3 = 5
            L4_3 = 6
            L2_3 = L2_3(L3_3, L4_3)
            L3_3 = 1
            for L4_3 = L1_3, L2_3, L3_3 do
              L5_3 = L23_1
              L6_3 = L5_3
              L5_3 = L5_3.FireServer
              L7_3 = {}
              L7_3.Type = "UseWorkstation"
              L7_3.Workstation = L0_3
              L5_3(L6_3, L7_3)
              L5_3 = wait
              L5_3()
            end
            L1_3 = L23_1
            L2_3 = L1_3
            L1_3 = L1_3.FireServer
            L3_3 = {}
            L3_3.Type = "JobCompleted"
            L3_3.Workstation = L0_3
            L4_3 = {}
            L4_3[1] = "true"
            L4_3[2] = "true"
            L4_3[3] = "true"
            L5_3 = L0_3.Order
            L5_3 = L5_3.Value
            L4_3[4] = L5_3
            L3_3.Order = L4_3
            L1_3(L2_3, L3_3)
            L1_3 = wait
            L1_3()
          end
        end
      end
      
      L7_2()
      L7_2 = game
      L8_2 = L7_2
      L7_2 = L7_2.GetService
      L9_2 = "RunService"
      L7_2 = L7_2(L8_2, L9_2)
      L7_2 = L7_2.Heartbeat
      L8_2 = L7_2
      L7_2 = L7_2.Wait
      L7_2(L8_2)
    end
  end
end

L25_1.do_baker = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  repeat
    repeat
      L2_2 = pcall
      
      function L3_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = L23_1
        L1_3 = L0_3
        L0_3 = L0_3.InvokeServer
        L2_3 = {}
        L2_3.Type = "UsePizzaMoped"
        L0_3 = L0_3(L1_3, L2_3)
        L1_2 = L0_3
      end
      
      L2_2(L3_2)
    until L1_2
    L2_2 = game
    L3_2 = L2_2
    L2_2 = L2_2.GetService
    L4_2 = "Workspace"
    L2_2 = L2_2(L3_2, L4_2)
    L2_2 = L2_2.Environment
    L2_2 = L2_2.Locations
    L3_2 = L2_2
    L2_2 = L2_2.FindFirstChild
    L4_2 = "PizzaPlanet"
    L2_2 = L2_2(L3_2, L4_2)
  until L2_2 ~= nil
  if L1_2 then
    L2_2 = nil
    repeat
      L3_2 = game
      L4_2 = L3_2
      L3_2 = L3_2.GetService
      L5_2 = "Workspace"
      L3_2 = L3_2(L4_2, L5_2)
      L3_2 = L3_2.Environment
      L3_2 = L3_2.Locations
      L3_2 = L3_2.PizzaPlanet
      L3_2 = L3_2.Conveyor
      L3_2 = L3_2.MovingBoxes
      L4_2 = L3_2
      L3_2 = L3_2.GetChildren
      L3_2 = L3_2(L4_2)
      L4_2 = #L3_2
      if L4_2 == 0 then
        L4_2 = wait
        L4_2()
      end
      L4_2 = pairs
      L5_2 = L3_2
      L4_2, L5_2, L6_2 = L4_2(L5_2)
      for L7_2, L8_2 in L4_2, L5_2, L6_2 do
        if L2_2 then
          break
        end
        L9_2 = game
        L9_2 = L9_2.Players
        L9_2 = L9_2.LocalPlayer
        L9_2 = L9_2.Character
        L10_2 = L9_2
        L9_2 = L9_2.SetPrimaryPartCFrame
        L11_2 = CFrame
        L11_2 = L11_2.new
        L12_2 = L8_2.Position
        L11_2 = L11_2(L12_2)
        L12_2 = Vector3
        L12_2 = L12_2.new
        L13_2 = 0
        L14_2 = 7
        L15_2 = 0
        L12_2 = L12_2(L13_2, L14_2, L15_2)
        L11_2 = L11_2 + L12_2
        L9_2(L10_2, L11_2)
        L9_2 = L23_1
        L10_2 = L9_2
        L9_2 = L9_2.InvokeServer
        L11_2 = {}
        L11_2.Type = "TakePizzaBox"
        L11_2.Box = L8_2
        L9_2 = L9_2(L10_2, L11_2)
        L2_2 = L9_2
        L9_2 = wait
        L9_2()
      end
    until L2_2 ~= nil
    L4_2 = A0_2
    L3_2 = A0_2.auto_drive
    L5_2 = L2_2.HumanoidRootPart
    L5_2 = L5_2.Position
    L3_2(L4_2, L5_2)
    L3_2 = wait
    L4_2 = 0.5
    L3_2(L4_2)
    L3_2 = L23_1
    L4_2 = L3_2
    L3_2 = L3_2.FireServer
    L5_2 = {}
    L5_2.Type = "DeliverPizza"
    L5_2.Customer = L2_2
    L3_2(L4_2, L5_2)
    L3_2 = wait
    L4_2 = 0.2
    L3_2(L4_2)
  else
    L2_2 = wait
    L2_2()
    L3_2 = A0_2
    L2_2 = A0_2.do_delivery
    L2_2(L3_2)
  end
end

L25_1.do_delievery = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L2_2 = L1_2.Character
  L3_2 = L2_2
  L2_2 = L2_2.FindFirstChild
  L4_2 = "Fishing Rod"
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = false
    L3_2 = spawn
    
    function L4_2()
      local L0_3, L1_3, L2_3
      repeat
        L0_3 = wait
        L0_3()
        L0_3 = L1_2
        L0_3 = L0_3.Character
        L1_3 = L0_3
        L0_3 = L0_3.FindFirstChild
        L2_3 = "Fishing Rod"
        L0_3 = L0_3(L1_3, L2_3)
        if not L0_3 then
          break
        end
        L0_3 = L1_2
        L0_3 = L0_3.Character
        L1_3 = L0_3
        L0_3 = L0_3.FindFirstChild
        L2_3 = "Fishing Rod"
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3
        L0_3 = L0_3.FindFirstChild
        L2_3 = "Bobber"
        L0_3 = L0_3(L1_3, L2_3)
        L0_3 = L0_3.CFrame
        L0_3 = L0_3.Y
      until L0_3 < 6
      L0_3 = true
      L2_2 = L0_3
    end
    
    L3_2(L4_2)
    L3_2 = tick
    L3_2 = L3_2()
    L4_2 = L23_1
    L5_2 = L4_2
    L4_2 = L4_2.FireServer
    L6_2 = {}
    L6_2.State = true
    L6_2.Type = "UseFishingRod"
    L7_2 = Vector3
    L7_2 = L7_2.new
    L8_2 = 1032
    L9_2 = 6
    L10_2 = 1107
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L6_2.Pos = L7_2
    L4_2(L5_2, L6_2)
    repeat
      L4_2 = wait
      L4_2()
    until L2_2
    L4_2 = L23_1
    L5_2 = L4_2
    L4_2 = L4_2.FireServer
    L6_2 = {}
    L6_2.State = false
    L6_2.Type = "UseFishingRod"
    L7_2 = tick
    L7_2 = L7_2()
    L7_2 = L7_2 - L3_2
    L6_2.Time = L7_2
    L4_2(L5_2, L6_2)
  end
end

L25_1.do_fisherman = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L2_2 = pairs
  L3_2 = game
  L4_2 = L3_2
  L3_2 = L3_2.GetService
  L5_2 = "Workspace"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2._game
  L3_2 = L3_2.SpawnedCharacters
  L4_2 = L3_2
  L3_2 = L3_2.GetChildren
  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = L6_2.Name
    if L7_2 == "BensIceCreamCustomer" then
      function L7_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3
        
        L0_3 = L6_2
        L1_3 = L0_3
        L0_3 = L0_3.FindFirstChild
        L2_3 = "HumanoidRootPart"
        L0_3 = L0_3(L1_3, L2_3)
        if not L0_3 then
          return
        end
        L0_3 = L6_2
        L1_3 = L0_3
        L0_3 = L0_3.FindFirstChild
        L2_3 = "HumanoidRootPart"
        L0_3 = L0_3(L1_3, L2_3)
        L1_3 = L0_3
        L0_3 = L0_3.FindFirstChild
        L2_3 = "Motor6D"
        L0_3 = L0_3(L1_3, L2_3)
        if L0_3 then
          L0_3 = L6_2
          L1_3 = L0_3
          L0_3 = L0_3.WaitForChild
          L2_3 = "HumanoidRootPart"
          L0_3 = L0_3(L1_3, L2_3)
          L1_3 = L0_3
          L0_3 = L0_3.FindFirstChild
          L2_3 = "Motor6D"
          L0_3 = L0_3(L1_3, L2_3)
          L1_3 = L0_3.Part1
          if L1_3 then
            L1_3 = L0_3.Part1
            L1_3 = L1_3.Name
            if L1_3 == "CustomerTarget" then
              L1_3 = L6_2
              L2_3 = L0_3.Part1
              L4_3 = L1_3
              L3_3 = L1_3.FindFirstChild
              L5_3 = "Order"
              L3_3 = L3_3(L4_3, L5_3)
              if not L3_3 then
                return
              end
              L5_3 = L1_3
              L4_3 = L1_3.FindFirstChildOfClass
              L6_3 = "CFrameValue"
              L4_3 = L4_3(L5_3, L6_3)
              if L4_3 then
                return
              end
              L4_3 = Instance
              L4_3 = L4_3.new
              L5_3 = "CFrameValue"
              L6_3 = L1_3
              L4_3(L5_3, L6_3)
              L4_3 = A0_2
              L5_3 = L4_3
              L4_3 = L4_3.tween_teleport
              L6_3 = CFrame
              L6_3 = L6_3.new
              L7_3 = 929.095337
              L8_3 = 13.7269897
              L9_3 = 1049.63477
              L10_3 = -0.842953146
              L11_3 = 1.25050681E-8
              L12_3 = 0.537986934
              L13_3 = 3.88757222E-8
              L14_3 = 1
              L15_3 = 3.7668844E-8
              L16_3 = -0.537986934
              L17_3 = 5.26677013E-8
              L18_3 = -0.842953146
              L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3)
              L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3)
              L4_3 = L23_1
              L5_3 = L4_3
              L4_3 = L4_3.FireServer
              L6_3 = {}
              L6_3.Type = "TakeIceCreamCup"
              L4_3(L5_3, L6_3)
              while true do
                L4_3 = L1_2
                L4_3 = L4_3.Character
                L5_3 = L4_3
                L4_3 = L4_3.FindFirstChild
                L6_3 = "Ice Cream Cup"
                L4_3 = L4_3(L5_3, L6_3)
                if L4_3 then
                  break
                end
                L4_3 = wait
                L4_3()
              end
              L4_3 = L1_2
              L4_3 = L4_3.Character
              L5_3 = L4_3
              L4_3 = L4_3.FindFirstChild
              L6_3 = "Ice Cream Cup"
              L4_3 = L4_3(L5_3, L6_3)
              L5_3 = L4_3
              L4_3 = L4_3.WaitForChild
              L6_3 = "Ball1"
              L4_3 = L4_3(L5_3, L6_3)
              L5_3 = L1_2
              L5_3 = L5_3.Character
              L6_3 = L5_3
              L5_3 = L5_3.FindFirstChild
              L7_3 = "Ice Cream Cup"
              L5_3 = L5_3(L6_3, L7_3)
              L6_3 = L5_3
              L5_3 = L5_3.WaitForChild
              L7_3 = "Ball2"
              L5_3 = L5_3(L6_3, L7_3)
              L6_3 = L23_1
              L7_3 = L6_3
              L6_3 = L6_3.FireServer
              L8_3 = {}
              L8_3.Ball = L4_3
              L8_3.Type = "AddIceCreamScoop"
              L10_3 = L3_3
              L9_3 = L3_3.FindFirstChild
              L11_3 = "Flavor1"
              L9_3 = L9_3(L10_3, L11_3)
              L9_3 = L9_3.Value
              L8_3.Taste = L9_3
              L6_3(L7_3, L8_3)
              L6_3 = L23_1
              L7_3 = L6_3
              L6_3 = L6_3.FireServer
              L8_3 = {}
              L8_3.Ball = L5_3
              L8_3.Type = "AddIceCreamScoop"
              L10_3 = L3_3
              L9_3 = L3_3.FindFirstChild
              L11_3 = "Flavor2"
              L9_3 = L9_3(L10_3, L11_3)
              L9_3 = L9_3.Value
              L8_3.Taste = L9_3
              L6_3(L7_3, L8_3)
              L6_3 = L23_1
              L7_3 = L6_3
              L6_3 = L6_3.FireServer
              L8_3 = {}
              L8_3.Type = "AddIceCreamTopping"
              L10_3 = L3_3
              L9_3 = L3_3.FindFirstChild
              L11_3 = "Topping"
              L9_3 = L9_3(L10_3, L11_3)
              L9_3 = L9_3.Value
              L8_3.Taste = L9_3
              L6_3(L7_3, L8_3)
              L6_3 = wait
              L6_3()
              L6_3 = L23_1
              L7_3 = L6_3
              L6_3 = L6_3.FireServer
              L8_3 = {}
              L8_3.Type = "JobCompleted"
              L8_3.Workstation = L2_3
              L6_3(L7_3, L8_3)
            end
          end
        end
      end
      
      L7_2()
      L7_2 = wait
      L7_2()
    end
  end
end

L25_1.do_icecream = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L2_2 = {}
  L3_2 = pairs
  L4_2 = workspace
  L4_2 = L4_2.Environment
  L4_2 = L4_2.Locations
  L4_2 = L4_2.Supermarket
  L4_2 = L4_2.Crates
  L5_2 = L4_2
  L4_2 = L4_2.GetChildren
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L4_2(L5_2)
  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L6_2, L7_2 in L3_2, L4_2, L5_2 do
    L8_2 = L7_2.Name
    if L8_2 ~= "BagCrate" then
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L2_2
      L10_2 = L7_2
      L8_2(L9_2, L10_2)
    end
  end
  L3_2 = table
  L3_2 = L3_2.sort
  L4_2 = L2_2
  
  function L5_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = L1_2
    L3_3 = L2_3
    L2_3 = L2_3.DistanceFromCharacter
    L4_3 = A0_3.Position
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = L1_2
    L4_3 = L3_3
    L3_3 = L3_3.DistanceFromCharacter
    L5_3 = A1_3.Position
    L3_3 = L3_3(L4_3, L5_3)
    L2_3 = L2_3 < L3_3
  end
  
  L3_2(L4_2, L5_2)
  L3_2 = L2_2[1]
  while true do
    L4_2 = L1_2.Character
    L5_2 = L4_2
    L4_2 = L4_2.FindFirstChild
    L6_2 = "Food Crate"
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      break
    end
    L5_2 = A0_2
    L4_2 = A0_2.tween_teleport
    L6_2 = L3_2.CFrame
    L4_2(L5_2, L6_2)
    L4_2 = L23_1
    L5_2 = L4_2
    L4_2 = L4_2.FireServer
    L6_2 = {}
    L6_2.Type = "TakeFoodCrate"
    L6_2.Object = L3_2
    L4_2(L5_2, L6_2)
  end
  L4_2 = {}
  L5_2 = pairs
  L6_2 = workspace
  L6_2 = L6_2.Environment
  L6_2 = L6_2.Locations
  L6_2 = L6_2.Supermarket
  L6_2 = L6_2.Shelves
  L7_2 = L6_2
  L6_2 = L6_2.GetChildren
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L6_2(L7_2)
  L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L8_2, L9_2 in L5_2, L6_2, L7_2 do
    L10_2 = L9_2.IsEmpty
    L10_2 = L10_2.Value
    if L10_2 then
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L4_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
    end
  end
  L5_2 = table
  L5_2 = L5_2.sort
  L6_2 = L4_2
  
  function L7_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = L1_2
    L3_3 = L2_3
    L2_3 = L2_3.DistanceFromCharacter
    L4_3 = A0_3.PrimaryPart
    L4_3 = L4_3.Position
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = L1_2
    L4_3 = L3_3
    L3_3 = L3_3.DistanceFromCharacter
    L5_3 = A1_3.PrimaryPart
    L5_3 = L5_3.Position
    L3_3 = L3_3(L4_3, L5_3)
    L2_3 = L2_3 < L3_3
  end
  
  L5_2(L6_2, L7_2)
  L5_2 = #L4_2
  if 1 < L5_2 then
    L5_2 = L4_2[1]
    while true do
      L6_2 = L1_2.Character
      L7_2 = L6_2
      L6_2 = L6_2.FindFirstChild
      L8_2 = "Food Crate"
      L6_2 = L6_2(L7_2, L8_2)
      if not L6_2 then
        break
      end
      L7_2 = A0_2
      L6_2 = A0_2.tween_teleport
      L8_2 = L5_2.PrimaryPart
      L8_2 = L8_2.CFrame
      L6_2(L7_2, L8_2)
      L6_2 = L23_1
      L7_2 = L6_2
      L6_2 = L6_2.FireServer
      L8_2 = {}
      L8_2.Type = "RestockShelf"
      L8_2.Shelf = L5_2
      L6_2(L7_2, L8_2)
    end
  end
end

L25_1.do_stocker = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = pairs
  L2_2 = workspace
  L2_2 = L2_2.Environment
  L2_2 = L2_2.Locations
  L2_2 = L2_2.Supermarket
  L2_2 = L2_2.CashierWorkstations
  L3_2 = L2_2
  L2_2 = L2_2.GetChildren
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
  L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L1_2, L2_2, L3_2 do
    L6_2 = game
    L6_2 = L6_2.Players
    L6_2 = L6_2.LocalPlayer
    L7_2 = L5_2.Name
    if L7_2 == "Workstation" then
      function L7_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3
        
        L0_3 = L5_2
        L0_3 = L0_3.Occupied
        L0_3 = L0_3.Value
        if L0_3 == nil then
          return
        end
        L0_3 = L5_2
        L1_3 = L5_2
        L1_3 = L1_3.Occupied
        L1_3 = L1_3.Value
        L2_3 = L6_2
        L3_3 = L2_3
        L2_3 = L2_3.DistanceFromCharacter
        L4_3 = L0_3.PrimaryPart
        L4_3 = L4_3.Position
        L2_3 = L2_3(L3_3, L4_3)
        if L2_3 < 8 then
          L3_3 = L1_3
          L2_3 = L1_3.WaitForChild
          L4_3 = "HumanoidRootPart"
          L2_3 = L2_3(L3_3, L4_3)
          L3_3 = L2_3
          L2_3 = L2_3.WaitForChild
          L4_3 = "Motor6D"
          L2_3 = L2_3(L3_3, L4_3)
          L3_3 = 3
          while true do
            L4_3 = L2_3.Part1
            L4_3 = L4_3.Name
            if L4_3 ~= "CustomerTarget_1" then
              break
            end
            L4_3 = L2_3.Parent
            if not L4_3 then
              break
            end
            L4_3 = L0_3.BagsLeft
            L4_3 = L4_3.Value
            if L4_3 < 1 then
              L4_3 = workspace
              L4_3 = L4_3.Environment
              L4_3 = L4_3.Locations
              L4_3 = L4_3.Supermarket
              L4_3 = L4_3.Crates
              L5_3 = L4_3
              L4_3 = L4_3.FindFirstChild
              L6_3 = "BagCrate"
              L4_3 = L4_3(L5_3, L6_3)
              L5_3 = A0_2
              L6_3 = L5_3
              L5_3 = L5_3.tween_teleport
              L7_3 = CFrame
              L7_3 = L7_3.new
              L8_3 = L4_3.Position
              L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3 = L7_3(L8_3)
              L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
              while true do
                L5_3 = L6_2
                L5_3 = L5_3.Character
                L6_3 = L5_3
                L5_3 = L5_3.FindFirstChild
                L7_3 = "BFF Bags"
                L5_3 = L5_3(L6_3, L7_3)
                if L5_3 then
                  break
                end
                L5_3 = L23_1
                L6_3 = L5_3
                L5_3 = L5_3.FireServer
                L7_3 = {}
                L7_3.Type = "TakeNewBags"
                L7_3.Object = L4_3
                L5_3(L6_3, L7_3)
                L5_3 = wait
                L5_3()
              end
              L5_3 = A0_2
              L6_3 = L5_3
              L5_3 = L5_3.tween_teleport
              L7_3 = CFrame
              L7_3 = L7_3.new
              L8_3 = L0_3.PrimaryPart
              L8_3 = L8_3.Position
              L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3 = L7_3(L8_3)
              L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3, L40_3, L41_3, L42_3, L43_3, L44_3, L45_3, L46_3, L47_3, L48_3, L49_3, L50_3, L51_3, L52_3, L53_3, L54_3, L55_3, L56_3, L57_3, L58_3, L59_3, L60_3, L61_3, L62_3, L63_3, L64_3, L65_3, L66_3, L67_3, L68_3, L69_3, L70_3, L71_3, L72_3, L73_3, L74_3, L75_3, L76_3, L77_3, L78_3, L79_3, L80_3, L81_3, L82_3, L83_3, L84_3, L85_3, L86_3, L87_3, L88_3, L89_3, L90_3, L91_3, L92_3, L93_3, L94_3, L95_3, L96_3, L97_3, L98_3, L99_3, L100_3, L101_3, L102_3, L103_3, L104_3, L105_3, L106_3, L107_3, L108_3, L109_3, L110_3, L111_3, L112_3, L113_3, L114_3, L115_3, L116_3, L117_3, L118_3, L119_3, L120_3, L121_3, L122_3, L123_3, L124_3, L125_3, L126_3, L127_3, L128_3, L129_3, L130_3, L131_3, L132_3, L133_3, L134_3, L135_3, L136_3, L137_3, L138_3, L139_3, L140_3, L141_3, L142_3, L143_3, L144_3, L145_3, L146_3, L147_3, L148_3, L149_3, L150_3, L151_3, L152_3, L153_3, L154_3, L155_3, L156_3, L157_3, L158_3, L159_3, L160_3, L161_3, L162_3, L163_3, L164_3, L165_3, L166_3, L167_3, L168_3, L169_3, L170_3, L171_3, L172_3, L173_3, L174_3, L175_3, L176_3, L177_3, L178_3, L179_3, L180_3, L181_3, L182_3, L183_3, L184_3, L185_3, L186_3, L187_3, L188_3, L189_3, L190_3, L191_3, L192_3, L193_3, L194_3, L195_3, L196_3, L197_3, L198_3, L199_3, L200_3, L201_3, L202_3, L203_3, L204_3, L205_3, L206_3, L207_3, L208_3, L209_3, L210_3, L211_3, L212_3, L213_3, L214_3, L215_3, L216_3, L217_3, L218_3, L219_3, L220_3, L221_3, L222_3, L223_3, L224_3, L225_3, L226_3, L227_3, L228_3, L229_3, L230_3, L231_3, L232_3, L233_3, L234_3, L235_3, L236_3, L237_3, L238_3, L239_3, L240_3, L241_3, L242_3, L243_3, L244_3, L245_3, L246_3, L247_3, L248_3, L249_3, L250_3, L251_3, L252_3, L253_3, L254_3)
              while true do
                L5_3 = L6_2
                L5_3 = L5_3.Character
                L6_3 = L5_3
                L5_3 = L5_3.FindFirstChild
                L7_3 = "BFF Bags"
                L5_3 = L5_3(L6_3, L7_3)
                if not L5_3 then
                  break
                end
                L5_3 = L23_1
                L6_3 = L5_3
                L5_3 = L5_3.FireServer
                L7_3 = {}
                L7_3.Type = "RestockBags"
                L7_3.Workstation = L0_3
                L5_3(L6_3, L7_3)
                L5_3 = wait
                L5_3()
              end
            end
            L4_3 = L0_3.DroppedFood
            L5_3 = L4_3
            L4_3 = L4_3.FindFirstChildOfClass
            L6_3 = "Part"
            L4_3 = L4_3(L5_3, L6_3)
            if L4_3 then
              if 2 < L3_3 then
                L3_3 = 0
                L4_3 = L23_1
                L5_3 = L4_3
                L4_3 = L4_3.FireServer
                L6_3 = {}
                L6_3.Type = "TakeNewBag"
                L6_3.Workstation = L0_3
                L4_3(L5_3, L6_3)
                L4_3 = wait
                L5_3 = 0.1
                L4_3(L5_3)
              end
              L4_3 = L23_1
              L5_3 = L4_3
              L4_3 = L4_3.FireServer
              L6_3 = {}
              L6_3.Type = "ScanDroppedItem"
              L7_3 = L0_3.DroppedFood
              L8_3 = L7_3
              L7_3 = L7_3.FindFirstChildOfClass
              L9_3 = "Part"
              L7_3 = L7_3(L8_3, L9_3)
              L6_3.Item = L7_3
              L4_3(L5_3, L6_3)
              L3_3 = L3_3 + 1
              L4_3 = wait
              L5_3 = 0.1
              L4_3(L5_3)
            end
            L4_3 = wait
            L4_3()
          end
          L4_3 = wait
          L5_3 = 0.1
          L4_3(L5_3)
          L4_3 = L23_1
          L5_3 = L4_3
          L4_3 = L4_3.FireServer
          L6_3 = {}
          L6_3.Type = "JobCompleted"
          L6_3.Workstation = L0_3
          L4_3(L5_3, L6_3)
        end
      end
      
      L7_2()
      L7_2 = game
      L8_2 = L7_2
      L7_2 = L7_2.GetService
      L9_2 = "RunService"
      L7_2 = L7_2(L8_2, L9_2)
      L7_2 = L7_2.Heartbeat
      L8_2 = L7_2
      L7_2 = L7_2.Wait
      L7_2(L8_2)
    end
  end
end

L25_1.do_cashier = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = workspace
  L3_2 = L3_2.Environment
  L3_2 = L3_2.Trees
  L4_2 = L3_2
  L3_2 = L3_2.GetChildren
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = L6_2.PrimaryPart
    L7_2 = L7_2.CFrame
    L7_2 = L7_2.Y
    if 0 < L7_2 then
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = L1_2
      L9_2 = L6_2
      L7_2(L8_2, L9_2)
    end
  end
  L2_2 = table
  L2_2 = L2_2.sort
  L3_2 = L1_2
  
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = game
    L2_3 = L2_3.Players
    L2_3 = L2_3.LocalPlayer
    L3_3 = L2_3
    L2_3 = L2_3.DistanceFromCharacter
    L4_3 = A0_3.PrimaryPart
    L4_3 = L4_3.Position
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = game
    L3_3 = L3_3.Players
    L3_3 = L3_3.LocalPlayer
    L4_3 = L3_3
    L3_3 = L3_3.DistanceFromCharacter
    L5_3 = A1_3.PrimaryPart
    L5_3 = L5_3.Position
    L3_3 = L3_3(L4_3, L5_3)
    L2_3 = L2_3 < L3_3
  end
  
  L2_2(L3_2, L4_2)
  L2_2 = #L1_2
  if 1 < L2_2 then
    L2_2 = L1_2[1]
    L4_2 = A0_2
    L3_2 = A0_2.tween_teleport
    L5_2 = L2_2.PrimaryPart
    L5_2 = L5_2.CFrame
    L3_2(L4_2, L5_2)
    L3_2 = L23_1
    L4_2 = L3_2
    L3_2 = L3_2.FireServer
    L5_2 = {}
    L5_2.Tree = L2_2
    L5_2.Type = "UseHatchet"
    L3_2(L4_2, L5_2)
    L3_2 = wait
    L4_2 = 0.5
    L3_2(L4_2)
  end
end

L25_1.do_woodcutter = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L1_2 = {}
  L2_2 = pairs
  L3_2 = workspace
  L3_2 = L3_2.Environment
  L3_2 = L3_2.Locations
  L3_2 = L3_2.GreenClean
  L3_2 = L3_2.Spawns
  L4_2 = L3_2
  L3_2 = L3_2.GetChildren
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L8_2 = L6_2
    L7_2 = L6_2.FindFirstChild
    L9_2 = "Object"
    L7_2 = L7_2(L8_2, L9_2)
    if L7_2 then
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = L1_2
      L9_2 = L6_2
      L7_2(L8_2, L9_2)
    end
  end
  L2_2 = table
  L2_2 = L2_2.sort
  L3_2 = L1_2
  
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = game
    L2_3 = L2_3.Players
    L2_3 = L2_3.LocalPlayer
    L3_3 = L2_3
    L2_3 = L2_3.DistanceFromCharacter
    L4_3 = A0_3.Position
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = game
    L3_3 = L3_3.Players
    L3_3 = L3_3.LocalPlayer
    L4_3 = L3_3
    L3_3 = L3_3.DistanceFromCharacter
    L5_3 = A1_3.Position
    L3_3 = L3_3(L4_3, L5_3)
    L2_3 = L2_3 < L3_3
  end
  
  L2_2(L3_2, L4_2)
  L2_2 = #L1_2
  if 1 < L2_2 then
    L2_2 = L1_2[1]
    L3_2 = nil
    L5_2 = L2_2
    L4_2 = L2_2.FindFirstChild
    L6_2 = "Object"
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = L4_2
    L4_2 = L4_2.IsA
    L6_2 = "Part"
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      L5_2 = L2_2
      L4_2 = L2_2.FindFirstChild
      L6_2 = "Object"
      L4_2 = L4_2(L5_2, L6_2)
      L3_2 = L4_2.CFrame
    else
      L5_2 = L2_2
      L4_2 = L2_2.FindFirstChild
      L6_2 = "Object"
      L4_2 = L4_2(L5_2, L6_2)
      L4_2 = L4_2.PrimaryPart
      L3_2 = L4_2.CFrame
    end
    L5_2 = A0_2
    L4_2 = A0_2.tween_teleport
    L6_2 = L3_2
    L4_2(L5_2, L6_2)
    L4_2 = L23_1
    L5_2 = L4_2
    L4_2 = L4_2.InvokeServer
    L6_2 = {}
    L6_2.Type = "CleanJanitorObject"
    L6_2.Spawn = L2_2
    L4_2(L5_2, L6_2)
  end
end

L25_1.do_janitor = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2
  L1_2 = workspace
  L1_2 = L1_2.Environment
  L1_2 = L1_2.Locations
  L1_2 = L1_2.Static_MinerCave
  L1_2 = L1_2.Folder
  L2_2 = L1_2
  L1_2 = L1_2.GetChildren
  L1_2 = L1_2(L2_2)
  
  function L2_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L2_3 = A0_3
    L1_3 = A0_3.FindFirstChild
    L3_3 = "M"
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L2_3 = A0_3
      L1_3 = A0_3.FindFirstChild
      L3_3 = "M"
      L1_3 = L1_3(L2_3, L3_3)
      L2_3 = L1_3.Color
      L3_3 = Color3
      L3_3 = L3_3.fromRGB
      L4_3 = 160
      L5_3 = 95
      L6_3 = 53
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      if L2_3 == L3_3 then
        L2_3 = 2
        return L2_3
      end
      L2_3 = L1_3.Color
      L3_3 = Color3
      L3_3 = L3_3.fromRGB
      L4_3 = 255
      L5_3 = 176
      L6_3 = 0
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      if L2_3 == L3_3 then
        L2_3 = 3
        return L2_3
      end
      L2_3 = L1_3.Color
      L3_3 = Color3
      L3_3 = L3_3.fromRGB
      L4_3 = 0
      L5_3 = 255
      L6_3 = 0
      L3_3 = L3_3(L4_3, L5_3, L6_3)
      if L2_3 == L3_3 then
        L2_3 = 4
        return L2_3
      end
      L2_3 = 5
      return L2_3
    end
    L1_3 = A0_3.B
    L1_3 = L1_3.ClassName
    if L1_3 == "MeshPart" then
      L1_3 = -10
      return L1_3
    end
    L1_3 = 1
  end
  
  Level = L2_2
  L2_2 = table
  L2_2 = L2_2.sort
  L3_2 = L1_2
  
  function L4_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = Level
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    L3_3 = Level
    L4_3 = A1_3
    L3_3 = L3_3(L4_3)
    if L2_3 == L3_3 then
      L2_3 = A0_3.PrimaryPart
      L2_3 = L2_3.CFrame
      L2_3 = L2_3.Y
      L3_3 = A1_3.PrimaryPart
      L3_3 = L3_3.CFrame
      L3_3 = L3_3.Y
      if L2_3 == L3_3 then
        L2_3 = game
        L2_3 = L2_3.Players
        L2_3 = L2_3.LocalPlayer
        L3_3 = L2_3
        L2_3 = L2_3.DistanceFromCharacter
        L4_3 = A0_3.PrimaryPart
        L4_3 = L4_3.Position
        L2_3 = L2_3(L3_3, L4_3)
        L3_3 = game
        L3_3 = L3_3.Players
        L3_3 = L3_3.LocalPlayer
        L4_3 = L3_3
        L3_3 = L3_3.DistanceFromCharacter
        L5_3 = A1_3.PrimaryPart
        L5_3 = L5_3.Position
        L3_3 = L3_3(L4_3, L5_3)
        L2_3 = L2_3 < L3_3
        return L2_3
      end
      L2_3 = A0_3.PrimaryPart
      L2_3 = L2_3.CFrame
      L2_3 = L2_3.Y
      L3_3 = A1_3.PrimaryPart
      L3_3 = L3_3.CFrame
      L3_3 = L3_3.Y
      L2_3 = L2_3 < L3_3
      return L2_3
    end
    L2_3 = Level
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    L3_3 = Level
    L4_3 = A1_3
    L3_3 = L3_3(L4_3)
    L2_3 = L2_3 > L3_3
  end
  
  L2_2(L3_2, L4_2)
  L2_2 = #L1_2
  if 1 < L2_2 then
    L2_2 = L1_2[1]
    L3_2 = Vector3
    L3_2 = L3_2.new
    L4_2 = string
    L4_2 = L4_2.match
    L5_2 = L2_2.Name
    L6_2 = "(.*)%:(.*)%:(.*)"
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L4_2(L5_2, L6_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    L5_2 = A0_2
    L4_2 = A0_2.tween_teleport
    L6_2 = CFrame
    L6_2 = L6_2.new
    L7_2 = L2_2.PrimaryPart
    L7_2 = L7_2.Position
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2 = L6_2(L7_2)
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2, L41_2, L42_2, L43_2, L44_2, L45_2, L46_2, L47_2, L48_2, L49_2, L50_2, L51_2, L52_2, L53_2, L54_2, L55_2, L56_2, L57_2, L58_2, L59_2, L60_2, L61_2, L62_2, L63_2, L64_2, L65_2, L66_2, L67_2, L68_2, L69_2, L70_2, L71_2, L72_2, L73_2, L74_2, L75_2, L76_2, L77_2, L78_2, L79_2, L80_2, L81_2, L82_2, L83_2, L84_2, L85_2, L86_2, L87_2, L88_2, L89_2, L90_2, L91_2, L92_2, L93_2, L94_2, L95_2, L96_2, L97_2, L98_2, L99_2, L100_2, L101_2, L102_2, L103_2, L104_2, L105_2, L106_2, L107_2, L108_2, L109_2, L110_2, L111_2, L112_2, L113_2, L114_2, L115_2, L116_2, L117_2, L118_2, L119_2, L120_2, L121_2, L122_2, L123_2, L124_2, L125_2, L126_2, L127_2, L128_2, L129_2, L130_2, L131_2, L132_2, L133_2, L134_2, L135_2, L136_2, L137_2, L138_2, L139_2, L140_2, L141_2, L142_2, L143_2, L144_2, L145_2, L146_2, L147_2, L148_2, L149_2, L150_2, L151_2, L152_2, L153_2, L154_2, L155_2, L156_2, L157_2, L158_2, L159_2, L160_2, L161_2, L162_2, L163_2, L164_2, L165_2, L166_2, L167_2, L168_2, L169_2, L170_2, L171_2, L172_2, L173_2, L174_2, L175_2, L176_2, L177_2, L178_2, L179_2, L180_2, L181_2, L182_2, L183_2, L184_2, L185_2, L186_2, L187_2, L188_2, L189_2, L190_2, L191_2, L192_2, L193_2, L194_2, L195_2, L196_2, L197_2, L198_2, L199_2, L200_2, L201_2, L202_2, L203_2, L204_2, L205_2, L206_2, L207_2, L208_2, L209_2, L210_2, L211_2, L212_2, L213_2, L214_2, L215_2, L216_2, L217_2, L218_2, L219_2, L220_2, L221_2, L222_2, L223_2, L224_2, L225_2, L226_2, L227_2, L228_2, L229_2, L230_2, L231_2, L232_2, L233_2, L234_2, L235_2, L236_2, L237_2, L238_2, L239_2, L240_2, L241_2, L242_2, L243_2, L244_2, L245_2, L246_2, L247_2, L248_2, L249_2, L250_2, L251_2, L252_2, L253_2, L254_2)
    L4_2 = L23_1
    L5_2 = L4_2
    L4_2 = L4_2.InvokeServer
    L6_2 = {}
    L6_2.Type = "MineBlock"
    L6_2.P = L3_2
    L4_2(L5_2, L6_2)
  end
end

L25_1.do_miner = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = A0_2.noclip_conn
  if L1_2 ~= nil then
    return
  end
  L1_2 = game
  L2_2 = L1_2
  L1_2 = L1_2.GetService
  L3_2 = "RunService"
  L1_2 = L1_2(L2_2, L3_2)
  L1_2 = L1_2.RenderStepped
  L2_2 = L1_2
  L1_2 = L1_2.Connect
  
  function L3_2()
    local L0_3, L1_3, L2_3
    L0_3 = game
    L0_3 = L0_3.Players
    L0_3 = L0_3.LocalPlayer
    L0_3 = L0_3.Character
    L0_3 = L0_3.Humanoid
    L1_3 = L0_3
    L0_3 = L0_3.ChangeState
    L2_3 = 11
    L0_3(L1_3, L2_3)
  end
  
  L1_2 = L1_2(L2_2, L3_2)
  A0_2.noclip_conn = L1_2
end

L25_1.enable_noclip = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = A0_2.do_autofarm_loop
  if L1_2 then
    return
  end
  A0_2.do_autofarm_loop = true
  while true do
    L1_2 = A0_2.do_autofarm_loop
    if not L1_2 then
      break
    end
    L1_2 = true
    L2_2 = wait
    L2_2()
    L2_2 = L17_1
    L2_2 = L2_2.GetJob
    L2_2 = L2_2()
    L3_2 = A0_2.current_job
    if L2_2 ~= L3_2 then
      if L2_2 == nil then
        A0_2.current_job = nil
        L4_2 = A0_2
        L3_2 = A0_2.notify
        L5_2 = "You no longer have a job. Please start a job to resume auto-farming!"
        L6_2 = "AutoFarm"
        L3_2(L4_2, L5_2, L6_2)
      else
        A0_2.current_job = L2_2
        L4_2 = A0_2
        L3_2 = A0_2.notify
        L5_2 = "Detected Job Switch! Current job changed to "
        L6_2 = tostring
        L7_2 = L2_2
        L6_2 = L6_2(L7_2)
        L5_2 = L5_2 .. L6_2
        L6_2 = "AutoFarm"
        L3_2(L4_2, L5_2, L6_2)
      end
    end
    if L2_2 == nil then
      L1_2 = false
    end
    if L1_2 then
      L3_2 = wait
      L3_2()
      L3_2 = game
      L3_2 = L3_2.Players
      L3_2 = L3_2.LocalPlayer
      L4_2 = getgenv
      L4_2 = L4_2()
      L4_2.autofarming = true
      if L2_2 == "StylezHairdresser" then
        L5_2 = A0_2
        L4_2 = A0_2.do_hairdresser
        L4_2(L5_2)
      elseif L2_2 == "BloxyBurgersCashier" then
        L5_2 = A0_2
        L4_2 = A0_2.do_burgercashier
        L4_2(L5_2)
      elseif L2_2 == "MikesMechanic" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_mechanic
        L4_2(L5_2)
      elseif L2_2 == "PizzaPlanetBaker" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_baker
        L4_2(L5_2)
      elseif L2_2 == "PizzaPlanetDelivery" then
        L5_2 = A0_2
        L4_2 = A0_2.do_delievery
        L4_2(L5_2)
      elseif L2_2 == "HutFisherman" then
        L5_2 = A0_2
        L4_2 = A0_2.do_fisherman
        L4_2(L5_2)
      elseif L2_2 == "BensIceCreamSeller" then
        L5_2 = A0_2
        L4_2 = A0_2.do_icecream
        L4_2(L5_2)
      elseif L2_2 == "SupermarketStocker" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_stocker
        L4_2(L5_2)
      elseif L2_2 == "SupermarketCashier" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_cashier
        L4_2(L5_2)
      elseif L2_2 == "LumberWoodcutter" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_woodcutter
        L4_2(L5_2)
      elseif L2_2 == "CleanJanitor" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_janitor
        L4_2(L5_2)
      elseif L2_2 == "CaveMiner" then
        L5_2 = A0_2
        L4_2 = A0_2.enable_noclip
        L4_2(L5_2)
        L5_2 = A0_2
        L4_2 = A0_2.do_miner
        L4_2(L5_2)
      else
        L5_2 = A0_2
        L4_2 = A0_2.notify
        L6_2 = "Unknown Job: "
        L7_2 = tostring
        L8_2 = L2_2
        L7_2 = L7_2(L8_2)
        L8_2 = "! Please report to applebee#3071"
        L6_2 = L6_2 .. L7_2 .. L8_2
        L4_2(L5_2, L6_2)
      end
      L4_2 = getgenv
      L4_2 = L4_2()
      L4_2.autofarming = false
      L4_2 = A0_2.noclip_conn
      if L4_2 ~= nil then
        L4_2 = A0_2.noclip_conn
        L5_2 = L4_2
        L4_2 = L4_2.Disconnect
        L4_2(L5_2)
        A0_2.noclip_conn = nil
      end
      L4_2 = A0_2.do_moods
      if L4_2 then
        L4_2 = A0_2.boost_mood_threshold
        L6_2 = A0_2
        L5_2 = A0_2.get_hunger
        L5_2 = L5_2(L6_2)
        if not (L4_2 > L5_2) then
          L6_2 = A0_2
          L5_2 = A0_2.get_hygiene
          L5_2 = L5_2(L6_2)
          if not (L4_2 > L5_2) then
            L6_2 = A0_2
            L5_2 = A0_2.get_fun
            L5_2 = L5_2(L6_2)
            if not (L4_2 > L5_2) then
              L6_2 = A0_2
              L5_2 = A0_2.get_energy
              L5_2 = L5_2(L6_2)
              if not (L4_2 > L5_2) then
                goto lbl_188
              end
            end
          end
        end
        L6_2 = A0_2
        L5_2 = A0_2.teleport_to_plot
        L7_2 = false
        L5_2(L6_2, L7_2)
        repeat
          L5_2 = wait
          L5_2()
          L5_2 = A0_2.is_plot_teleporting
        until L5_2 ~= true
        L6_2 = A0_2
        L5_2 = A0_2.boost_fun
        L5_2(L6_2)
        L6_2 = A0_2
        L5_2 = A0_2.boost_hygiene
        L5_2(L6_2)
        L6_2 = A0_2
        L5_2 = A0_2.get_hunger
        L5_2 = L5_2(L6_2)
        if L4_2 > L5_2 then
          L6_2 = A0_2
          L5_2 = A0_2.boost_hunger
          L5_2(L6_2)
        end
        L6_2 = A0_2
        L5_2 = A0_2.boost_energy
        L5_2(L6_2)
        L6_2 = A0_2
        L5_2 = A0_2.teleport_job
        L7_2 = L2_2
        L5_2(L6_2, L7_2)
        repeat
          L5_2 = wait
          L5_2()
          L5_2 = A0_2.is_job_teleporting
        until L5_2 ~= true
      end
      ::lbl_188::
      L4_2 = A0_2.quit_after_enabled
      if L4_2 then
        L4_2 = game
        L5_2 = L4_2
        L4_2 = L4_2.GetService
        L6_2 = "ReplicatedStorage"
        L4_2 = L4_2(L5_2, L6_2)
        L4_2 = L4_2.Stats
        L5_2 = L3_2.Name
        L4_2 = L4_2[L5_2]
        L5_2 = L4_2.Job
        L5_2 = L5_2.ShiftEarnings
        L5_2 = L5_2.Value
        L6_2 = A0_2.quit_after_amount
        if L5_2 > L6_2 then
          L6_2 = A0_2
          L5_2 = A0_2.stop_autofarm
          L5_2(L6_2)
          L6_2 = A0_2
          L5_2 = A0_2.teleport_to_plot
          L7_2 = false
          L5_2(L6_2, L7_2)
          L6_2 = A0_2
          L5_2 = A0_2.notify
          L7_2 = "Autofarm Reached Amount!"
          L5_2(L6_2, L7_2)
        end
      end
    end
  end
  L1_2 = pcall
  
  function L2_2()
    local L0_3, L1_3, L2_3
    L0_3 = game
    L0_3 = L0_3.Players
    L0_3 = L0_3.LocalPlayer
    L0_3 = L0_3.PlayerGui
    L0_3 = L0_3.MainGUI
    L0_3 = L0_3.Scripts
    L0_3 = L0_3.JobManager
    L1_3 = L17_1
    L1_3 = L1_3.GetJob
    L1_3 = L1_3()
    L0_3 = L0_3[L1_3]
    L1_3 = require
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L1_3 = L1_3.EndShift
    L1_3 = L1_3()
  end
  
  L1_2(L2_2)
end

L25_1.start_autofarm = L26_1

function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = getgenv
  L1_2 = L1_2()
  L1_2.autofarming = false
  A0_2.do_autofarm_loop = false
end

L25_1.stop_autofarm = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = L17_1
  L3_2 = L2_2
  L2_2 = L2_2.ShowPaycheck
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end

L25_1.make_paycheck = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = L16_1
  L2_2 = L2_2.ConfirmBox
  L3_2 = nil
  L4_2 = A1_2
  L5_2 = "Confirmation"
  L6_2 = 3
  L2_2(L3_2, L4_2, L5_2, L6_2)
end

L25_1.make_confirmation = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = A0_2.autoopen_door_conn
  if L1_2 then
    return
  end
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L2_2 = L1_2
  L1_2 = L1_2.GetMouse
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.Button1Down
  L3_2 = L2_2
  L2_2 = L2_2.Connect
  
  function L4_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = L1_2
    L0_3 = L0_3.Target
    if L0_3 then
      L0_3 = L1_2
      L0_3 = L0_3.Target
      L0_3 = L0_3.Parent
      if L0_3 then
        L0_3 = L1_2
        L0_3 = L0_3.Target
        L0_3 = L0_3.Parent
        L1_3 = L0_3
        L0_3 = L0_3.IsDescendantOf
        L2_3 = game
        L2_3 = L2_3.Workspace
        L2_3 = L2_3.Plots
        L0_3 = L0_3(L1_3, L2_3)
        if L0_3 then
          L0_3 = L1_2
          L0_3 = L0_3.Target
          L0_3 = L0_3.Parent
          L1_3 = true
          L2_3 = false
          while not L2_3 do
            L3_3 = L0_3.Parent
            L4_3 = game
            L4_3 = L4_3.Workspace
            L4_3 = L4_3.Plots
            if L3_3 == L4_3 then
              L2_3 = true
            end
            L4_3 = L0_3
            L3_3 = L0_3.FindFirstChild
            L5_3 = "DoorSound"
            L3_3 = L3_3(L4_3, L5_3)
            if not L3_3 then
              L4_3 = L0_3
              L3_3 = L0_3.FindFirstChild
              L5_3 = "DoorOpen"
              L3_3 = L3_3(L4_3, L5_3)
              if not L3_3 then
                goto lbl_47
              end
            end
            L1_3 = false
            L2_3 = true
            do break end
            ::lbl_47::
            L0_3 = L0_3.Parent
          end
          if L1_3 == false then
            L4_3 = L0_3
            L3_3 = L0_3.FindFirstChild
            L5_3 = "ObjectData"
            L3_3 = L3_3(L4_3, L5_3)
            if L3_3 then
              L3_3 = L0_3.ObjectData
              L3_3 = L3_3.IsOpen
              L4_3 = L0_3.ObjectData
              L4_3 = L4_3.IsOpen
              L4_3 = L4_3.Value
              L4_3 = not L4_3
              L3_3.Value = L4_3
            end
          end
        end
      end
    end
  end
  
  L2_2 = L2_2(L3_2, L4_2)
  A0_2.autoopen_door_conn = L2_2
end

L25_1.autoopen_door = L26_1

function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.autoopen_door_conn
  if not L1_2 then
    return
  end
  L1_2 = A0_2.autoopen_door_conn
  L2_2 = L1_2
  L1_2 = L1_2.Disconnect
  L1_2(L2_2)
  A0_2.autoopen_door_conn = nil
end

L25_1.stop_autoopendoor = L26_1

function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L1_2 = L1_2.Character
  L1_2 = L1_2.HumanoidRootPart
  L1_2 = L1_2.SmellParticles
  L2_2 = L1_2
  L1_2 = L1_2.Destroy
  L1_2(L2_2)
  L1_2 = game
  L1_2 = L1_2.Players
  L1_2 = L1_2.LocalPlayer
  L1_2 = L1_2.Character
  L1_2 = L1_2.HumanoidRootPart
  L1_2 = L1_2.FlyParticles
  L2_2 = L1_2
  L1_2 = L1_2.Destroy
  L1_2(L2_2)
end

L25_1.remove_stink = L26_1

function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = L4_1
  L1_2 = L1_2.Shared
  L1_2 = L1_2.VehicleHandler
  L1_2 = L1_2.VehicleData
  L2_2 = string
  L2_2 = L2_2.split
  L3_2 = game
  L3_2 = L3_2.Players
  L3_2 = L3_2.LocalPlayer
  L3_2 = L3_2.Character
  L4_2 = L3_2
  L3_2 = L3_2.FindFirstChildOfClass
  L5_2 = "Model"
  L3_2 = L3_2(L4_2, L5_2)
  L3_2 = L3_2.Name
  L4_2 = "_"
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2[2]
  L1_2 = L1_2[L2_2]
end

L25_1.get_cartable = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = pairs
  L3_2 = L8_1
  L4_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 == "table" then
      L7_2 = rawget
      L8_2 = L6_2
      L9_2 = "ForwardSpeed"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L6_2.ForwardSpeed = A1_2
      end
    end
  end
end

L25_1.set_car_forwardspeed = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = pairs
  L3_2 = L8_1
  L4_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 == "table" then
      L7_2 = rawget
      L8_2 = L6_2
      L9_2 = "ReverseSpeed"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L6_2.ReverseSpeed = A1_2
      else
        L7_2 = rawget
        L8_2 = L6_2
        L9_2 = "BackwardsSpeed"
        L7_2 = L7_2(L8_2, L9_2)
        if L7_2 then
          L6_2.BackwardsSpeed = A1_2
        end
      end
    end
  end
end

L25_1.set_car_reversespeed = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = pairs
  L3_2 = L8_1
  L4_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 == "table" then
      L7_2 = rawget
      L8_2 = L6_2
      L9_2 = "TurnSpeed"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L6_2.TurnSpeed = A1_2
      end
    end
  end
end

L25_1.set_car_turnspeed = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = pairs
  L3_2 = L8_1
  L4_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 == "table" then
      L7_2 = rawget
      L8_2 = L6_2
      L9_2 = "StartPitch"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L6_2.StartPitch = A1_2
      end
    end
  end
end

L25_1.set_car_startpitch = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = pairs
  L3_2 = L8_1
  L4_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L2_2, L3_2, L4_2 do
    L7_2 = type
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 == "table" then
      L7_2 = rawget
      L8_2 = L6_2
      L9_2 = "PitchChange"
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L6_2.PitchChange = A1_2
      end
    end
  end
end

L25_1.set_car_pitchchange = L26_1

function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = _G
  L2_2 = L2_2.DiscardFly
  if L2_2 then
    L2_2 = _G
    L2_2 = L2_2.DiscardFly
    L2_2()
    L2_2 = _G
    L2_2.DiscardFly = nil
  end
  if A1_2 == nil then
    A1_2 = 60
  end
  L2_2 = false
  
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = game
    L1_3 = L1_3.Players
    L1_3 = L1_3.LocalPlayer
    L2_3 = L1_3
    L1_3 = L1_3.GetMouse
    L1_3 = L1_3(L2_3)
    repeat
      repeat
        repeat
          repeat
            L2_3 = wait
            L2_3()
            L2_3 = game
            L2_3 = L2_3.Players
            L2_3 = L2_3.LocalPlayer
          until L2_3
          L2_3 = game
          L2_3 = L2_3.Players
          L2_3 = L2_3.LocalPlayer
          L2_3 = L2_3.Character
        until L2_3
        L2_3 = game
        L2_3 = L2_3.Players
        L2_3 = L2_3.LocalPlayer
        L2_3 = L2_3.Character
        L3_3 = L2_3
        L2_3 = L2_3.WaitForChild
        L4_3 = "HumanoidRootPart"
        L2_3 = L2_3(L3_3, L4_3)
      until L2_3
      L2_3 = game
      L2_3 = L2_3.Players
      L2_3 = L2_3.LocalPlayer
      L2_3 = L2_3.Character
      L3_3 = L2_3
      L2_3 = L2_3.FindFirstChild
      L4_3 = "Humanoid"
      L2_3 = L2_3(L3_3, L4_3)
    until L2_3
    repeat
      L2_3 = wait
      L2_3()
    until L1_3
    L2_3 = game
    L2_3 = L2_3.Players
    L2_3 = L2_3.LocalPlayer
    L2_3 = L2_3.Character
    L2_3 = L2_3.HumanoidRootPart
    L3_3 = {}
    L3_3.F = 0
    L3_3.B = 0
    L3_3.L = 0
    L3_3.R = 0
    L3_3.Q = 0
    L3_3.E = 0
    L4_3 = {}
    L4_3.F = 0
    L4_3.B = 0
    L4_3.L = 0
    L4_3.R = 0
    L4_3.Q = 0
    L4_3.E = 0
    L5_3 = 0
    
    function L6_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4
      L0_4 = true
      L2_2 = L0_4
      L0_4 = Instance
      L0_4 = L0_4.new
      L1_4 = "BodyGyro"
      L2_4 = L2_3
      L0_4 = L0_4(L1_4, L2_4)
      L1_4 = Instance
      L1_4 = L1_4.new
      L2_4 = "BodyVelocity"
      L3_4 = L2_3
      L1_4 = L1_4(L2_4, L3_4)
      L0_4.P = 90000
      L2_4 = Vector3
      L2_4 = L2_4.new
      L3_4 = 9000000000
      L4_4 = 9000000000
      L5_4 = 9000000000
      L2_4 = L2_4(L3_4, L4_4, L5_4)
      L0_4.maxTorque = L2_4
      L2_4 = L2_3
      L2_4 = L2_4.CFrame
      L0_4.cframe = L2_4
      L2_4 = Vector3
      L2_4 = L2_4.new
      L3_4 = 0
      L4_4 = 0
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
      L2_4 = spawn
      
      function L3_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        repeat
          L0_5 = wait
          L0_5()
          L0_5 = A0_3
          if not L0_5 then
            L0_5 = game
            L0_5 = L0_5.Players
            L0_5 = L0_5.LocalPlayer
            L0_5 = L0_5.Character
            L1_5 = L0_5
            L0_5 = L0_5.FindFirstChildOfClass
            L2_5 = "Humanoid"
            L0_5 = L0_5(L1_5, L2_5)
            if L0_5 then
              L0_5 = game
              L0_5 = L0_5.Players
              L0_5 = L0_5.LocalPlayer
              L0_5 = L0_5.Character
              L1_5 = L0_5
              L0_5 = L0_5.FindFirstChildOfClass
              L2_5 = "Humanoid"
              L0_5 = L0_5(L1_5, L2_5)
              L0_5.PlatformStand = true
            end
          end
          L0_5 = game
          L0_5 = L0_5.Players
          L0_5 = L0_5.LocalPlayer
          L0_5 = L0_5.Character
          L1_5 = L0_5
          L0_5 = L0_5.FindFirstChildOfClass
          L2_5 = "Humanoid"
          L0_5 = L0_5(L1_5, L2_5)
          if L0_5 then
            L0_5 = game
            L0_5 = L0_5.Players
            L0_5 = L0_5.LocalPlayer
            L0_5 = L0_5.Character
            L1_5 = L0_5
            L0_5 = L0_5.FindFirstChildOfClass
            L2_5 = "Humanoid"
            L0_5 = L0_5(L1_5, L2_5)
            L0_5 = L0_5.Health
            if L0_5 == 0 then
              L0_5 = game
              L0_5 = L0_5.Players
              L0_5 = L0_5.LocalPlayer
              L0_5 = L0_5.CharacterAdded
              L1_5 = L0_5
              L0_5 = L0_5.Wait
              L0_5(L1_5)
              L0_5 = game
              L0_5 = L0_5.Players
              L0_5 = L0_5.LocalPlayer
              L0_5 = L0_5.Character
              L1_5 = L0_5
              L0_5 = L0_5.WaitForChild
              L2_5 = "HumanoidRootPart"
              L0_5(L1_5, L2_5)
              L0_5 = game
              L0_5 = L0_5.Players
              L0_5 = L0_5.LocalPlayer
              L0_5 = L0_5.Character
              L0_5 = L0_5.HumanoidRootPart
              L2_3 = L0_5
              L0_5 = Instance
              L0_5 = L0_5.new
              L1_5 = "BodyGyro"
              L2_5 = L2_3
              L0_5 = L0_5(L1_5, L2_5)
              L0_4 = L0_5
              L0_5 = Instance
              L0_5 = L0_5.new
              L1_5 = "BodyVelocity"
              L2_5 = L2_3
              L0_5 = L0_5(L1_5, L2_5)
              L1_4 = L0_5
              L0_5 = L0_4
              L0_5.P = 90000
              L0_5 = L0_4
              L1_5 = Vector3
              L1_5 = L1_5.new
              L2_5 = 9000000000
              L3_5 = 9000000000
              L4_5 = 9000000000
              L1_5 = L1_5(L2_5, L3_5, L4_5)
              L0_5.maxTorque = L1_5
              L0_5 = L0_4
              L1_5 = L2_3
              L1_5 = L1_5.CFrame
              L0_5.cframe = L1_5
              L0_5 = L1_4
              L1_5 = Vector3
              L1_5 = L1_5.new
              L2_5 = 0
              L3_5 = 0
              L4_5 = 0
              L1_5 = L1_5(L2_5, L3_5, L4_5)
              L0_5.velocity = L1_5
              L0_5 = L1_4
              L1_5 = Vector3
              L1_5 = L1_5.new
              L2_5 = 9000000000
              L3_5 = 9000000000
              L4_5 = 9000000000
              L1_5 = L1_5(L2_5, L3_5, L4_5)
              L0_5.maxForce = L1_5
            end
          end
          L0_5 = L3_3
          L0_5 = L0_5.L
          L1_5 = L3_3
          L1_5 = L1_5.R
          L0_5 = L0_5 + L1_5
          if L0_5 == 0 then
            L0_5 = L3_3
            L0_5 = L0_5.F
            L1_5 = L3_3
            L1_5 = L1_5.B
            L0_5 = L0_5 + L1_5
            if L0_5 == 0 then
              L0_5 = L3_3
              L0_5 = L0_5.Q
              L1_5 = L3_3
              L1_5 = L1_5.E
              L0_5 = L0_5 + L1_5
              if L0_5 == 0 then
                goto lbl_127
              end
            end
          end
          L0_5 = 50
          L5_3 = L0_5
          goto lbl_153
          ::lbl_127::
          L0_5 = L3_3
          L0_5 = L0_5.L
          L1_5 = L3_3
          L1_5 = L1_5.R
          L0_5 = L0_5 + L1_5
          if L0_5 == 0 then
            L0_5 = L3_3
            L0_5 = L0_5.F
            L1_5 = L3_3
            L1_5 = L1_5.B
            L0_5 = L0_5 + L1_5
            if L0_5 == 0 then
              L0_5 = L3_3
              L0_5 = L0_5.Q
              L1_5 = L3_3
              L1_5 = L1_5.E
              L0_5 = L0_5 + L1_5
              if L0_5 == 0 then
                L0_5 = L5_3
                if L0_5 ~= 0 then
                  L0_5 = 0
                  L5_3 = L0_5
                end
              end
            end
          end
          ::lbl_153::
          L0_5 = L3_3
          L0_5 = L0_5.L
          L1_5 = L3_3
          L1_5 = L1_5.R
          L0_5 = L0_5 + L1_5
          if L0_5 == 0 then
            L0_5 = L3_3
            L0_5 = L0_5.F
            L1_5 = L3_3
            L1_5 = L1_5.B
            L0_5 = L0_5 + L1_5
            if L0_5 == 0 then
              L0_5 = L3_3
              L0_5 = L0_5.Q
              L1_5 = L3_3
              L1_5 = L1_5.E
              L0_5 = L0_5 + L1_5
              if L0_5 == 0 then
                goto lbl_235
              end
            end
          end
          L0_5 = L1_4
          L1_5 = workspace
          L1_5 = L1_5.CurrentCamera
          L1_5 = L1_5.CoordinateFrame
          L1_5 = L1_5.lookVector
          L2_5 = L3_3
          L2_5 = L2_5.F
          L3_5 = L3_3
          L3_5 = L3_5.B
          L2_5 = L2_5 + L3_5
          L1_5 = L1_5 * L2_5
          L2_5 = workspace
          L2_5 = L2_5.CurrentCamera
          L2_5 = L2_5.CoordinateFrame
          L3_5 = CFrame
          L3_5 = L3_5.new
          L4_5 = L3_3
          L4_5 = L4_5.L
          L5_5 = L3_3
          L5_5 = L5_5.R
          L4_5 = L4_5 + L5_5
          L5_5 = L3_3
          L5_5 = L5_5.F
          L6_5 = L3_3
          L6_5 = L6_5.B
          L5_5 = L5_5 + L6_5
          L6_5 = L3_3
          L6_5 = L6_5.Q
          L5_5 = L5_5 + L6_5
          L6_5 = L3_3
          L6_5 = L6_5.E
          L5_5 = L5_5 + L6_5
          L5_5 = L5_5 * 0.2
          L6_5 = 0
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L3_5 = L3_5.p
          L2_5 = L2_5 * L3_5
          L3_5 = workspace
          L3_5 = L3_5.CurrentCamera
          L3_5 = L3_5.CoordinateFrame
          L3_5 = L3_5.p
          L2_5 = L2_5 - L3_5
          L1_5 = L1_5 + L2_5
          L2_5 = L5_3
          L1_5 = L1_5 * L2_5
          L0_5.velocity = L1_5
          L0_5 = {}
          L1_5 = L3_3
          L1_5 = L1_5.F
          L0_5.F = L1_5
          L1_5 = L3_3
          L1_5 = L1_5.B
          L0_5.B = L1_5
          L1_5 = L3_3
          L1_5 = L1_5.L
          L0_5.L = L1_5
          L1_5 = L3_3
          L1_5 = L1_5.R
          L0_5.R = L1_5
          L4_3 = L0_5
          goto lbl_314
          ::lbl_235::
          L0_5 = L3_3
          L0_5 = L0_5.L
          L1_5 = L3_3
          L1_5 = L1_5.R
          L0_5 = L0_5 + L1_5
          if L0_5 == 0 then
            L0_5 = L3_3
            L0_5 = L0_5.F
            L1_5 = L3_3
            L1_5 = L1_5.B
            L0_5 = L0_5 + L1_5
            if L0_5 == 0 then
              L0_5 = L3_3
              L0_5 = L0_5.Q
              L1_5 = L3_3
              L1_5 = L1_5.E
              L0_5 = L0_5 + L1_5
              if L0_5 == 0 then
                L0_5 = L5_3
                if L0_5 ~= 0 then
                  L0_5 = L1_4
                  L1_5 = workspace
                  L1_5 = L1_5.CurrentCamera
                  L1_5 = L1_5.CoordinateFrame
                  L1_5 = L1_5.lookVector
                  L2_5 = L4_3
                  L2_5 = L2_5.F
                  L3_5 = L4_3
                  L3_5 = L3_5.B
                  L2_5 = L2_5 + L3_5
                  L1_5 = L1_5 * L2_5
                  L2_5 = workspace
                  L2_5 = L2_5.CurrentCamera
                  L2_5 = L2_5.CoordinateFrame
                  L3_5 = CFrame
                  L3_5 = L3_5.new
                  L4_5 = L4_3
                  L4_5 = L4_5.L
                  L5_5 = L4_3
                  L5_5 = L5_5.R
                  L4_5 = L4_5 + L5_5
                  L5_5 = L4_3
                  L5_5 = L5_5.F
                  L6_5 = L4_3
                  L6_5 = L6_5.B
                  L5_5 = L5_5 + L6_5
                  L6_5 = L3_3
                  L6_5 = L6_5.Q
                  L5_5 = L5_5 + L6_5
                  L6_5 = L3_3
                  L6_5 = L6_5.E
                  L5_5 = L5_5 + L6_5
                  L5_5 = L5_5 * 0.2
                  L6_5 = 0
                  L3_5 = L3_5(L4_5, L5_5, L6_5)
                  L3_5 = L3_5.p
                  L2_5 = L2_5 * L3_5
                  L3_5 = workspace
                  L3_5 = L3_5.CurrentCamera
                  L3_5 = L3_5.CoordinateFrame
                  L3_5 = L3_5.p
                  L2_5 = L2_5 - L3_5
                  L1_5 = L1_5 + L2_5
                  L2_5 = L5_3
                  L1_5 = L1_5 * L2_5
                  L0_5.velocity = L1_5
              end
            end
          end
          else
            L0_5 = L1_4
            L1_5 = Vector3
            L1_5 = L1_5.new
            L2_5 = 0
            L3_5 = 0
            L4_5 = 0
            L1_5 = L1_5(L2_5, L3_5, L4_5)
            L0_5.velocity = L1_5
          end
          ::lbl_314::
          L0_5 = L0_4
          L1_5 = workspace
          L1_5 = L1_5.CurrentCamera
          L1_5 = L1_5.CoordinateFrame
          L0_5.cframe = L1_5
          L0_5 = L2_2
        until not L0_5
        L0_5 = {}
        L0_5.F = 0
        L0_5.B = 0
        L0_5.L = 0
        L0_5.R = 0
        L0_5.Q = 0
        L0_5.E = 0
        L3_3 = L0_5
        L0_5 = {}
        L0_5.F = 0
        L0_5.B = 0
        L0_5.L = 0
        L0_5.R = 0
        L0_5.Q = 0
        L0_5.E = 0
        L4_3 = L0_5
        L0_5 = 0
        L5_3 = L0_5
        L0_5 = L0_4
        L1_5 = L0_5
        L0_5 = L0_5.destroy
        L0_5(L1_5)
        L0_5 = L1_4
        L1_5 = L0_5
        L0_5 = L0_5.destroy
        L0_5(L1_5)
        L0_5 = game
        L0_5 = L0_5.Players
        L0_5 = L0_5.LocalPlayer
        L0_5 = L0_5.Character
        L1_5 = L0_5
        L0_5 = L0_5.FindFirstChildOfClass
        L2_5 = "Humanoid"
        L0_5 = L0_5(L1_5, L2_5)
        if L0_5 then
          L0_5 = game
          L0_5 = L0_5.Players
          L0_5 = L0_5.LocalPlayer
          L0_5 = L0_5.Character
          L1_5 = L0_5
          L0_5 = L0_5.FindFirstChildOfClass
          L2_5 = "Humanoid"
          L0_5 = L0_5(L1_5, L2_5)
          L0_5.PlatformStand = false
        end
      end
      
      L2_4(L3_4)
    end
    
    L7_3 = L1_3.KeyDown
    L8_3 = L7_3
    L7_3 = L7_3.connect
    
    function L9_3(A0_4)
      local L1_4, L2_4
      L2_4 = A0_4
      L1_4 = A0_4.lower
      L1_4 = L1_4(L2_4)
      if L1_4 == "w" then
        L1_4 = L3_3
        L2_4 = A1_2
        L2_4 = L2_4 / 100
        L1_4.F = L2_4
      else
        L2_4 = A0_4
        L1_4 = A0_4.lower
        L1_4 = L1_4(L2_4)
        if L1_4 == "s" then
          L1_4 = L3_3
          L2_4 = A1_2
          L2_4 = -L2_4
          L2_4 = L2_4 / 100
          L1_4.B = L2_4
        else
          L2_4 = A0_4
          L1_4 = A0_4.lower
          L1_4 = L1_4(L2_4)
          if L1_4 == "a" then
            L1_4 = L3_3
            L2_4 = A1_2
            L2_4 = -L2_4
            L2_4 = L2_4 / 100
            L1_4.L = L2_4
          else
            L2_4 = A0_4
            L1_4 = A0_4.lower
            L1_4 = L1_4(L2_4)
            if L1_4 == "d" then
              L1_4 = L3_3
              L2_4 = A1_2
              L2_4 = L2_4 / 100
              L1_4.R = L2_4
            end
          end
        end
      end
    end
    
    L7_3(L8_3, L9_3)
    L7_3 = L1_3.KeyUp
    L8_3 = L7_3
    L7_3 = L7_3.connect
    
    function L9_3(A0_4)
      local L1_4, L2_4
      L2_4 = A0_4
      L1_4 = A0_4.lower
      L1_4 = L1_4(L2_4)
      if L1_4 == "w" then
        L1_4 = L3_3
        L1_4.F = 0
      else
        L2_4 = A0_4
        L1_4 = A0_4.lower
        L1_4 = L1_4(L2_4)
        if L1_4 == "s" then
          L1_4 = L3_3
          L1_4.B = 0
        else
          L2_4 = A0_4
          L1_4 = A0_4.lower
          L1_4 = L1_4(L2_4)
          if L1_4 == "a" then
            L1_4 = L3_3
            L1_4.L = 0
          else
            L2_4 = A0_4
            L1_4 = A0_4.lower
            L1_4 = L1_4(L2_4)
            if L1_4 == "d" then
              L1_4 = L3_3
              L1_4.R = 0
            end
          end
        end
      end
    end
    
    L7_3(L8_3, L9_3)
    L7_3 = L6_3
    L7_3()
  end
  
  function L4_2()
    local L0_3, L1_3, L2_3
    L0_3 = false
    L2_2 = L0_3
    L0_3 = game
    L0_3 = L0_3.Players
    L0_3 = L0_3.LocalPlayer
    L0_3 = L0_3.Character
    L1_3 = L0_3
    L0_3 = L0_3.FindFirstChildOfClass
    L2_3 = "Humanoid"
    L0_3 = L0_3(L1_3, L2_3)
    L0_3.PlatformStand = false
  end
  
  L5_2 = _G
  
  function L6_2()
    local L0_3
    L0_3 = L4_2
    L0_3()
  end
  
  L5_2.DiscardFly = L6_2
  L5_2 = L3_2
  L6_2 = true
  L5_2(L6_2)
end

L25_1.carFly = L26_1

function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = _G
  L1_2 = L1_2.DiscardFly
  if L1_2 then
    L1_2 = _G
    L1_2 = L1_2.DiscardFly
    L1_2()
    L1_2 = _G
    L1_2.DiscardFly = nil
  end
end

L25_1.stopCarFly = L26_1

function L26_1(A0_2)
  local L1_2, L2_2
  A0_2.queue_running = false
  L1_2 = A0_2.autoopen_door_conn
  if L1_2 then
    L1_2 = A0_2.autoopen_door_conn
    L2_2 = L1_2
    L1_2 = L1_2.Disconnect
    L1_2(L2_2)
    A0_2.autoopen_door_conn = nil
  end
  L1_2 = _G
  L1_2 = L1_2.DiscardFly
  if L1_2 then
    L1_2 = _G
    L1_2 = L1_2.DiscardFly
    L1_2()
    L1_2 = _G
    L1_2.DiscardFly = nil
  end
end

L25_1.cleanup = L26_1
L26_1 = spawn

function L27_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L1_2 = L0_2
  L0_2 = L0_2.run_queue
  L0_2(L1_2)
end

L26_1(L27_1)
L26_1 = {}
L27_1 = {}
L26_1.tabs = L27_1
L27_1 = game
L28_1 = L27_1
L27_1 = L27_1.GetService
L29_1 = "TweenService"
L27_1 = L27_1(L28_1, L29_1)

function L28_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = TweenInfo
  L3_2 = L3_2.new
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L27_1
  L5_2 = L4_2
  L4_2 = L4_2.Create
  L6_2 = A0_2
  L7_2 = L3_2
  L8_2 = A1_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = L4_2
  L4_2 = L4_2.Play
  L4_2(L5_2)
end

function L29_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = Instance
  L2_2 = L2_2.new
  L3_2 = "ScreenGui"
  L2_2 = L2_2(L3_2)
  L2_2.Name = A1_2
  L3_2 = game
  L3_2 = L3_2.CoreGui
  L2_2.Parent = L3_2
  L3_2 = Instance
  L3_2 = L3_2.new
  L4_2 = "ImageLabel"
  L3_2 = L3_2(L4_2)
  L4_2 = Instance
  L4_2 = L4_2.new
  L5_2 = "ImageLabel"
  L4_2 = L4_2(L5_2)
  L5_2 = Instance
  L5_2 = L5_2.new
  L6_2 = "TextLabel"
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
  L9_2 = "UIListLayout"
  L8_2 = L8_2(L9_2)
  L3_2.Name = "Frame"
  L3_2.Parent = L2_2
  L9_2 = Color3
  L9_2 = L9_2.fromRGB
  L10_2 = 255
  L11_2 = 255
  L12_2 = 255
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L3_2.BackgroundColor3 = L9_2
  L3_2.BackgroundTransparency = 1
  L3_2.ClipsDescendants = true
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 0.135603473
  L11_2 = 0
  L12_2 = 0.0739393532
  L13_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L3_2.Position = L9_2
  L9_2 = UDim2
  L9_2 = L9_2.new
  L10_2 = 0
  L11_2 = 437
  L12_2 = 0
  L13_2 = 276
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L3_2.Size = L9_2
  L3_2.Image = "rbxassetid://3570695787"
  L9_2 = Color3
  L9_2 = L9_2.fromRGB
  L10_2 = 35
  L11_2 = 40
  L12_2 = 50
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L3_2.ImageColor3 = L9_2
  L9_2 = Enum
  L9_2 = L9_2.ScaleType
  L9_2 = L9_2.Slice
  L3_2.ScaleType = L9_2
  L9_2 = Rect
  L9_2 = L9_2.new
  L10_2 = 100
  L11_2 = 100
  L12_2 = 100
  L13_2 = 100
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L3_2.SliceCenter = L9_2
  L3_2.SliceScale = 0.05
  
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = Instance
    L0_3 = L0_3.new
    L1_3 = "LocalScript"
    L2_3 = L3_2
    L0_3 = L0_3(L1_3, L2_3)
    L1_3 = {}
    L1_3 = L0_3.Parent
    L2_3 = game
    L3_3 = L2_3
    L2_3 = L2_3.GetService
    L4_3 = "UserInputService"
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = nil
    L4_3 = nil
    L5_3 = nil
    L6_3 = nil
    
    function L7_3(A0_4)
      local L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4
      L1_4 = A0_4.Position
      L2_4 = L5_3
      L1_4 = L1_4 - L2_4
      L2_4 = L1_3
      L3_4 = L2_4
      L2_4 = L2_4.TweenPosition
      L4_4 = UDim2
      L4_4 = L4_4.new
      L5_4 = L6_3
      L5_4 = L5_4.X
      L5_4 = L5_4.Scale
      L6_4 = L6_3
      L6_4 = L6_4.X
      L6_4 = L6_4.Offset
      L7_4 = L1_4.X
      L6_4 = L6_4 + L7_4
      L7_4 = L6_3
      L7_4 = L7_4.Y
      L7_4 = L7_4.Scale
      L8_4 = L6_3
      L8_4 = L8_4.Y
      L8_4 = L8_4.Offset
      L9_4 = L1_4.Y
      L8_4 = L8_4 + L9_4
      L4_4 = L4_4(L5_4, L6_4, L7_4, L8_4)
      L5_4 = "Out"
      L6_4 = "Linear"
      L7_4 = 0.1
      L8_4 = true
      L2_4(L3_4, L4_4, L5_4, L6_4, L7_4, L8_4)
    end
    
    L8_3 = L1_3.InputBegan
    L9_3 = L8_3
    L8_3 = L8_3.Connect
    
    function L10_3(A0_4)
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
          goto lbl_26
        end
      end
      L1_4 = true
      L3_3 = L1_4
      L1_4 = A0_4.Position
      L5_3 = L1_4
      L1_4 = L1_3
      L1_4 = L1_4.Position
      L6_3 = L1_4
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
          L3_3 = L0_5
        end
      end
      
      L1_4(L2_4, L3_4)
      ::lbl_26::
    end
    
    L8_3(L9_3, L10_3)
    L8_3 = L1_3.InputChanged
    L9_3 = L8_3
    L8_3 = L8_3.Connect
    
    function L10_3(A0_4)
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
      L4_3 = A0_4
      ::lbl_14::
    end
    
    L8_3(L9_3, L10_3)
    L8_3 = L2_3.InputChanged
    L9_3 = L8_3
    L8_3 = L8_3.Connect
    
    function L10_3(A0_4)
      local L1_4, L2_4
      L1_4 = L4_3
      if A0_4 == L1_4 then
        L1_4 = L3_3
        if L1_4 then
          L1_4 = L7_3
          L2_4 = A0_4
          L1_4(L2_4)
        end
      end
    end
    
    L8_3(L9_3, L10_3)
  end
  
  L10_2 = coroutine
  L10_2 = L10_2.wrap
  L11_2 = L9_2
  L10_2 = L10_2(L11_2)
  L10_2()
  L4_2.Name = "Frame"
  L4_2.Parent = L3_2
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 255
  L12_2 = 255
  L13_2 = 255
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L4_2.BackgroundColor3 = L10_2
  L4_2.BackgroundTransparency = 1
  L10_2 = UDim2
  L10_2 = L10_2.new
  L11_2 = 0
  L12_2 = 437
  L13_2 = 0
  L14_2 = 22
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L4_2.Size = L10_2
  L4_2.Image = "rbxassetid://3570695787"
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 26
  L12_2 = 31
  L13_2 = 41
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L4_2.ImageColor3 = L10_2
  L10_2 = Enum
  L10_2 = L10_2.ScaleType
  L10_2 = L10_2.Slice
  L4_2.ScaleType = L10_2
  L10_2 = Rect
  L10_2 = L10_2.new
  L11_2 = 100
  L12_2 = 100
  L13_2 = 100
  L14_2 = 100
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L4_2.SliceCenter = L10_2
  L4_2.SliceScale = 0.05
  L5_2.Parent = L4_2
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 255
  L12_2 = 255
  L13_2 = 255
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L5_2.BackgroundColor3 = L10_2
  L5_2.BackgroundTransparency = 1
  L5_2.BorderSizePixel = 0
  L10_2 = UDim2
  L10_2 = L10_2.new
  L11_2 = 0.118993133
  L12_2 = 0
  L13_2 = 0
  L14_2 = 0
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L5_2.Position = L10_2
  L10_2 = UDim2
  L10_2 = L10_2.new
  L11_2 = 0
  L12_2 = 194
  L13_2 = 0
  L14_2 = 22
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L5_2.Size = L10_2
  L10_2 = Enum
  L10_2 = L10_2.Font
  L10_2 = L10_2.SourceSans
  L5_2.Font = L10_2
  L5_2.Text = "Home"
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 150
  L12_2 = 150
  L13_2 = 150
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L5_2.TextColor3 = L10_2
  L5_2.TextSize = 15
  L5_2.TextWrapped = true
  L10_2 = Enum
  L10_2 = L10_2.TextXAlignment
  L10_2 = L10_2.Left
  L5_2.TextXAlignment = L10_2
  L6_2.Name = "Frame"
  L6_2.Parent = L3_2
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 255
  L12_2 = 255
  L13_2 = 255
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L6_2.BackgroundColor3 = L10_2
  L6_2.BackgroundTransparency = 1
  L10_2 = UDim2
  L10_2 = L10_2.new
  L11_2 = 0
  L12_2 = 48
  L13_2 = 0
  L14_2 = 276
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L6_2.Size = L10_2
  L6_2.Image = "rbxassetid://3570695787"
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 29
  L12_2 = 34
  L13_2 = 44
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L6_2.ImageColor3 = L10_2
  L10_2 = Enum
  L10_2 = L10_2.ScaleType
  L10_2 = L10_2.Slice
  L6_2.ScaleType = L10_2
  L10_2 = Rect
  L10_2 = L10_2.new
  L11_2 = 100
  L12_2 = 100
  L13_2 = 100
  L14_2 = 100
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L6_2.SliceCenter = L10_2
  L6_2.SliceScale = 0.05
  L7_2.Parent = L6_2
  L10_2 = Color3
  L10_2 = L10_2.fromRGB
  L11_2 = 255
  L12_2 = 255
  L13_2 = 255
  L10_2 = L10_2(L11_2, L12_2, L13_2)
  L7_2.BackgroundColor3 = L10_2
  L7_2.BackgroundTransparency = 1
  L7_2.BorderSizePixel = 0
  L7_2.ClipsDescendants = true
  L10_2 = UDim2
  L10_2 = L10_2.new
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = 72
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L7_2.Position = L10_2
  L10_2 = UDim2
  L10_2 = L10_2.new
  L11_2 = 1
  L12_2 = 0
  L13_2 = 0
  L14_2 = 198
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L7_2.Size = L10_2
  L8_2.Parent = L7_2
  L10_2 = Enum
  L10_2 = L10_2.SortOrder
  L10_2 = L10_2.LayoutOrder
  L8_2.SortOrder = L10_2
  L10_2 = L26_1
  
  function L11_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
    L3_3 = {}
    L4_3 = Instance
    L4_3 = L4_3.new
    L5_3 = "Frame"
    L4_3 = L4_3(L5_3)
    L5_3 = Instance
    L5_3 = L5_3.new
    L6_3 = "ImageLabel"
    L5_3 = L5_3(L6_3)
    L6_3 = Instance
    L6_3 = L6_3.new
    L7_3 = "ImageButton"
    L6_3 = L6_3(L7_3)
    L7_3 = Instance
    L7_3 = L7_3.new
    L8_3 = "Frame"
    L7_3 = L7_3(L8_3)
    L8_3 = Instance
    L8_3 = L8_3.new
    L9_3 = "ScrollingFrame"
    L8_3 = L8_3(L9_3)
    L9_3 = Instance
    L9_3 = L9_3.new
    L10_3 = "UIListLayout"
    L9_3 = L9_3(L10_3)
    L4_3.Name = "TabTemplate"
    L10_3 = L7_2
    L4_3.Parent = L10_3
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 255
    L12_3 = 255
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L4_3.BackgroundColor3 = L10_3
    L4_3.BackgroundTransparency = 1
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 27
    L12_3 = 42
    L13_3 = 53
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L4_3.BorderColor3 = L10_3
    L4_3.BorderSizePixel = 0
    L4_3.ClipsDescendants = true
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 1
    L12_3 = 0
    L13_3 = 0
    L14_3 = 45
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L4_3.Size = L10_3
    L5_3.Name = "Frame"
    L5_3.Parent = L4_3
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 255
    L12_3 = 255
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L5_3.BackgroundColor3 = L10_3
    L5_3.BackgroundTransparency = 1
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 5
    L13_3 = 0
    L14_3 = 6
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L5_3.Position = L10_3
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 37
    L13_3 = 0
    L14_3 = 33
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L5_3.Size = L10_3
    L5_3.Image = "rbxassetid://3570695787"
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 117
    L12_3 = 143
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L5_3.ImageColor3 = L10_3
    L10_3 = Enum
    L10_3 = L10_3.ScaleType
    L10_3 = L10_3.Slice
    L5_3.ScaleType = L10_3
    L10_3 = Rect
    L10_3 = L10_3.new
    L11_3 = 100
    L12_3 = 100
    L13_3 = 100
    L14_3 = 100
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L5_3.SliceCenter = L10_3
    L5_3.SliceScale = 0.05
    L6_3.Parent = L4_3
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 255
    L12_3 = 255
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L6_3.BackgroundColor3 = L10_3
    L6_3.BackgroundTransparency = 1
    L6_3.BorderSizePixel = 0
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 12
    L13_3 = 0
    L14_3 = 11
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L6_3.Position = L10_3
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 23
    L13_3 = 0
    L14_3 = 23
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L6_3.Size = L10_3
    L10_3 = "rbxassetid://"
    L11_3 = tostring
    L12_3 = A2_3
    L11_3 = L11_3(L12_3)
    L10_3 = L10_3 .. L11_3
    if not L10_3 then
      L10_3 = "rbxassetid://7299468850"
    end
    L6_3.Image = L10_3
    L7_3.Name = A1_3
    L10_3 = L3_2
    L7_3.Parent = L10_3
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 255
    L12_3 = 255
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L7_3.BackgroundColor3 = L10_3
    L7_3.BackgroundTransparency = 1
    L7_3.BorderSizePixel = 0
    L7_3.ClipsDescendants = true
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 456
    L13_3 = 0
    L14_3 = 28
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L7_3.Position = L10_3
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 375
    L13_3 = 0
    L14_3 = 240
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L7_3.Size = L10_3
    L8_3.Parent = L7_3
    L8_3.Active = true
    L10_3 = Color3
    L10_3 = L10_3.fromRGB
    L11_3 = 255
    L12_3 = 255
    L13_3 = 255
    L10_3 = L10_3(L11_3, L12_3, L13_3)
    L8_3.BackgroundColor3 = L10_3
    L8_3.BackgroundTransparency = 1
    L8_3.BorderSizePixel = 0
    L10_3 = UDim2
    L10_3 = L10_3.new
    L11_3 = 1
    L12_3 = 0
    L13_3 = 1
    L14_3 = 0
    L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
    L8_3.Size = L10_3
    L8_3.ScrollBarThickness = 0
    L9_3.Parent = L8_3
    L10_3 = Enum
    L10_3 = L10_3.SortOrder
    L10_3 = L10_3.LayoutOrder
    L9_3.SortOrder = L10_3
    L10_3 = UDim
    L10_3 = L10_3.new
    L11_3 = 0
    L12_3 = 6
    L10_3 = L10_3(L11_3, L12_3)
    L9_3.Padding = L10_3
    L10_3 = L6_3.MouseButton1Down
    L11_3 = L10_3
    L10_3 = L10_3.connect
    
    function L12_3()
      local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4
      L0_4 = L5_2
      L1_4 = A1_3
      L0_4.Text = L1_4
      L0_4 = L3_2
      L1_4 = L0_4
      L0_4 = L0_4.FindFirstChild
      L2_4 = A1_3
      L0_4 = L0_4(L1_4, L2_4)
      L1_4 = L0_4
      L0_4 = L0_4.TweenPosition
      L2_4 = UDim2
      L2_4 = L2_4.new
      L3_4 = 0
      L4_4 = 54
      L5_4 = 0
      L6_4 = 28
      L2_4 = L2_4(L3_4, L4_4, L5_4, L6_4)
      L3_4 = "InOut"
      L4_4 = "Linear"
      L5_4 = 0.2
      L0_4(L1_4, L2_4, L3_4, L4_4, L5_4)
      L0_4 = pairs
      L1_4 = L3_2
      L2_4 = L1_4
      L1_4 = L1_4.GetChildren
      L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4 = L1_4(L2_4)
      L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4)
      for L3_4, L4_4 in L0_4, L1_4, L2_4 do
        L6_4 = L4_4
        L5_4 = L4_4.IsA
        L7_4 = "Frame"
        L5_4 = L5_4(L6_4, L7_4)
        if L5_4 then
          L6_4 = L4_4
          L5_4 = L4_4.TweenPosition
          L7_4 = UDim2
          L7_4 = L7_4.new
          L8_4 = 0
          L9_4 = 456
          L10_4 = 0
          L11_4 = 28
          L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
          L8_4 = "InOut"
          L9_4 = "Linear"
          L10_4 = 0.2
          L5_4(L6_4, L7_4, L8_4, L9_4, L10_4)
        end
      end
      L0_4 = pairs
      L1_4 = L4_3
      L1_4 = L1_4.Parent
      L2_4 = L1_4
      L1_4 = L1_4.GetChildren
      L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4 = L1_4(L2_4)
      L0_4, L1_4, L2_4 = L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4)
      for L3_4, L4_4 in L0_4, L1_4, L2_4 do
        L6_4 = L4_4
        L5_4 = L4_4.IsA
        L7_4 = "Frame"
        L5_4 = L5_4(L6_4, L7_4)
        if L5_4 then
          L5_4 = L28_1
          L6_4 = L4_4.ImageButton
          L7_4 = {}
          L8_4 = Color3
          L8_4 = L8_4.fromRGB
          L9_4 = 150
          L10_4 = 150
          L11_4 = 150
          L8_4 = L8_4(L9_4, L10_4, L11_4)
          L7_4.ImageColor3 = L8_4
          L8_4 = 0.15
          L5_4(L6_4, L7_4, L8_4)
          L5_4 = L28_1
          L6_4 = L4_4.Frame
          L7_4 = {}
          L8_4 = Color3
          L8_4 = L8_4.fromRGB
          L9_4 = 33
          L10_4 = 38
          L11_4 = 48
          L8_4 = L8_4(L9_4, L10_4, L11_4)
          L7_4.ImageColor3 = L8_4
          L8_4 = 0.15
          L5_4(L6_4, L7_4, L8_4)
        end
      end
      L0_4 = L28_1
      L1_4 = L4_3
      L1_4 = L1_4.ImageButton
      L2_4 = {}
      L3_4 = Color3
      L3_4 = L3_4.fromRGB
      L4_4 = 255
      L5_4 = 255
      L6_4 = 255
      L3_4 = L3_4(L4_4, L5_4, L6_4)
      L2_4.ImageColor3 = L3_4
      L3_4 = 0.15
      L0_4(L1_4, L2_4, L3_4)
      L0_4 = L28_1
      L1_4 = L4_3
      L1_4 = L1_4.Frame
      L2_4 = {}
      L3_4 = Color3
      L3_4 = L3_4.fromRGB
      L4_4 = 117
      L5_4 = 143
      L6_4 = 255
      L3_4 = L3_4(L4_4, L5_4, L6_4)
      L2_4.ImageColor3 = L3_4
      L3_4 = 0.15
      L0_4(L1_4, L2_4, L3_4)
    end
    
    L10_3(L11_3, L12_3)
    L10_3 = A0_3.tabs
    L11_3 = {}
    L12_3 = L7_3
    L13_3 = L4_3
    L11_3[1] = L12_3
    L11_3[2] = L13_3
    L10_3[A1_3] = L11_3
    
    function L10_3(A0_4, A1_4, A2_4)
      local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4
      L3_4 = A2_4 or nil
      if not A2_4 then
        function L3_4()
          local L0_5
        end
      end
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "Frame"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "ImageLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "TextButton"
      L6_4 = L6_4(L7_4)
      L7_4 = L8_3
      L4_4.Parent = L7_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L4_4.BackgroundColor3 = L7_4
      L4_4.BackgroundTransparency = 1
      L4_4.BorderSizePixel = 0
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0
      L9_4 = 375
      L10_4 = 0
      L11_4 = 35
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L4_4.Size = L7_4
      L5_4.Name = "Frame"
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
      L8_4 = 1
      L9_4 = 0
      L10_4 = 0
      L11_4 = 35
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L5_4.Size = L7_4
      L5_4.Image = "rbxassetid://3570695787"
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 117
      L9_4 = 143
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L5_4.ImageColor3 = L7_4
      L7_4 = Enum
      L7_4 = L7_4.ScaleType
      L7_4 = L7_4.Slice
      L5_4.ScaleType = L7_4
      L7_4 = Rect
      L7_4 = L7_4.new
      L8_4 = 100
      L9_4 = 100
      L10_4 = 100
      L11_4 = 100
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L5_4.SliceCenter = L7_4
      L5_4.SliceScale = 0.05
      L6_4.Parent = L5_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L6_4.BackgroundColor3 = L7_4
      L6_4.BackgroundTransparency = 1
      L6_4.BorderSizePixel = 0
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0.99999994
      L9_4 = 0
      L10_4 = 1
      L11_4 = 0
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L6_4.Size = L7_4
      L7_4 = Enum
      L7_4 = L7_4.Font
      L7_4 = L7_4.SourceSans
      L6_4.Font = L7_4
      L6_4.Text = A1_4
      L7_4 = Color3
      L7_4 = L7_4.fromRGB
      L8_4 = 255
      L9_4 = 255
      L10_4 = 255
      L7_4 = L7_4(L8_4, L9_4, L10_4)
      L6_4.TextColor3 = L7_4
      L6_4.TextSize = 15
      L7_4 = L6_4.MouseButton1Down
      L8_4 = L7_4
      L7_4 = L7_4.connect
      
      function L9_4()
        local L0_5, L1_5
        L0_5 = pcall
        L1_5 = L3_4
        L0_5(L1_5)
      end
      
      L7_4(L8_4, L9_4)
      L7_4 = Vector2
      L7_4 = L7_4.new
      L8_4 = 0.5
      L9_4 = 0.5
      L7_4 = L7_4(L8_4, L9_4)
      L5_4.AnchorPoint = L7_4
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0.5
      L9_4 = 0
      L10_4 = 0.5
      L11_4 = 0
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L5_4.Position = L7_4
      L7_4 = Vector2
      L7_4 = L7_4.new
      L8_4 = 0.5
      L9_4 = 0.5
      L7_4 = L7_4(L8_4, L9_4)
      L6_4.AnchorPoint = L7_4
      L7_4 = UDim2
      L7_4 = L7_4.new
      L8_4 = 0.5
      L9_4 = 0
      L10_4 = 0.5
      L11_4 = 0
      L7_4 = L7_4(L8_4, L9_4, L10_4, L11_4)
      L6_4.Position = L7_4
      L7_4 = L6_4.MouseButton1Down
      L8_4 = L7_4
      L7_4 = L7_4.Connect
      
      function L9_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L6_4
        L1_5 = L0_5
        L0_5 = L0_5.TweenSize
        L2_5 = UDim2
        L2_5 = L2_5.new
        L3_5 = 0.95
        L4_5 = 0
        L5_5 = 0.95
        L6_5 = 0
        L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
        L3_5 = "InOut"
        L4_5 = "Linear"
        L5_5 = 0.08
        L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
        L0_5 = L5_4
        L1_5 = L0_5
        L0_5 = L0_5.TweenSize
        L2_5 = UDim2
        L2_5 = L2_5.new
        L3_5 = 0.95
        L4_5 = 0
        L5_5 = 0.95
        L6_5 = 0
        L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
        L3_5 = "InOut"
        L4_5 = "Linear"
        L5_5 = 0.08
        L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
        L0_5 = wait
        L1_5 = 0.08
        L0_5(L1_5)
        L0_5 = L5_4
        L1_5 = L0_5
        L0_5 = L0_5.TweenSize
        L2_5 = UDim2
        L2_5 = L2_5.new
        L3_5 = 1
        L4_5 = 0
        L5_5 = 1
        L6_5 = 0
        L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
        L3_5 = "InOut"
        L4_5 = "Linear"
        L5_5 = 0.08
        L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
        L0_5 = L6_4
        L1_5 = L0_5
        L0_5 = L0_5.TweenSize
        L2_5 = UDim2
        L2_5 = L2_5.new
        L3_5 = 1
        L4_5 = 0
        L5_5 = 1
        L6_5 = 0
        L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
        L3_5 = "InOut"
        L4_5 = "Linear"
        L5_5 = 0.08
        L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
      end
      
      L7_4(L8_4, L9_4)
    end
    
    L3_3.Button = L10_3
    
    function L10_3(A0_4, A1_4, A2_4)
      local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4
      L3_4 = {}
      L4_4 = false
      L5_4 = A2_4 or L5_4
      if not A2_4 then
        function L5_4()
          local L0_5
        end
      end
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "Frame"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "ImageLabel"
      L7_4 = L7_4(L8_4)
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "TextButton"
      L8_4 = L8_4(L9_4)
      L9_4 = Instance
      L9_4 = L9_4.new
      L10_4 = "ImageLabel"
      L9_4 = L9_4(L10_4)
      L10_4 = L8_3
      L6_4.Parent = L10_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L6_4.BackgroundColor3 = L10_4
      L6_4.BackgroundTransparency = 1
      L6_4.BorderSizePixel = 0
      L6_4.ClipsDescendants = true
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 375
      L13_4 = 0
      L14_4 = 35
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L6_4.Size = L10_4
      L7_4.Name = "Frame"
      L7_4.Parent = L6_4
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
      L11_4 = 1
      L12_4 = 0
      L13_4 = 0
      L14_4 = 35
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L7_4.Size = L10_4
      L7_4.Image = "rbxassetid://3570695787"
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 29
      L12_4 = 34
      L13_4 = 44
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L7_4.ImageColor3 = L10_4
      L10_4 = Enum
      L10_4 = L10_4.ScaleType
      L10_4 = L10_4.Slice
      L7_4.ScaleType = L10_4
      L10_4 = Rect
      L10_4 = L10_4.new
      L11_4 = 100
      L12_4 = 100
      L13_4 = 100
      L14_4 = 100
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L7_4.SliceCenter = L10_4
      L7_4.SliceScale = 0.05
      L8_4.Parent = L7_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L8_4.BackgroundColor3 = L10_4
      L8_4.BackgroundTransparency = 1
      L8_4.BorderSizePixel = 0
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0.0206185561
      L12_4 = 0
      L13_4 = 0
      L14_4 = 0
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L8_4.Position = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0.979381442
      L12_4 = 0
      L13_4 = 1
      L14_4 = 0
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L8_4.Size = L10_4
      L10_4 = Enum
      L10_4 = L10_4.Font
      L10_4 = L10_4.SourceSans
      L8_4.Font = L10_4
      L8_4.Text = A1_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 150
      L12_4 = 150
      L13_4 = 150
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L8_4.TextColor3 = L10_4
      L8_4.TextSize = 15
      L10_4 = Enum
      L10_4 = L10_4.TextXAlignment
      L10_4 = L10_4.Left
      L8_4.TextXAlignment = L10_4
      L9_4.Name = "Frame"
      L9_4.Parent = L7_4
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 255
      L12_4 = 255
      L13_4 = 255
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L9_4.BackgroundColor3 = L10_4
      L9_4.BackgroundTransparency = 1
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0.912883282
      L12_4 = 0
      L13_4 = 0.200000003
      L14_4 = 0
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L9_4.Position = L10_4
      L10_4 = UDim2
      L10_4 = L10_4.new
      L11_4 = 0
      L12_4 = 21
      L13_4 = 0
      L14_4 = 21
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L9_4.Size = L10_4
      L9_4.Image = "rbxassetid://3570695787"
      L10_4 = Color3
      L10_4 = L10_4.fromRGB
      L11_4 = 33
      L12_4 = 38
      L13_4 = 48
      L10_4 = L10_4(L11_4, L12_4, L13_4)
      L9_4.ImageColor3 = L10_4
      L10_4 = Enum
      L10_4 = L10_4.ScaleType
      L10_4 = L10_4.Slice
      L9_4.ScaleType = L10_4
      L10_4 = Rect
      L10_4 = L10_4.new
      L11_4 = 100
      L12_4 = 100
      L13_4 = 100
      L14_4 = 100
      L10_4 = L10_4(L11_4, L12_4, L13_4, L14_4)
      L9_4.SliceCenter = L10_4
      L9_4.SliceScale = 0.05
      
      function L10_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
        L0_5 = L4_4
        L0_5 = not L0_5
        L4_4 = L0_5
        L0_5 = L28_1
        L1_5 = L9_4
        L2_5 = {}
        L3_5 = L4_4
        if L3_5 then
          L3_5 = Color3
          L3_5 = L3_5.fromRGB
          L4_5 = 117
          L5_5 = 143
          L6_5 = 255
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          if L3_5 then
            goto lbl_24
          end
        end
        L3_5 = Color3
        L3_5 = L3_5.fromRGB
        L4_5 = 33
        L5_5 = 38
        L6_5 = 48
        L3_5 = L3_5(L4_5, L5_5, L6_5)
        ::lbl_24::
        L2_5.ImageColor3 = L3_5
        L3_5 = 0.15
        L0_5(L1_5, L2_5, L3_5)
        L0_5 = pcall
        L1_5 = L5_4
        L2_5 = L4_4
        L0_5(L1_5, L2_5)
      end
      
      L11_4 = L8_4.MouseButton1Down
      L12_4 = L11_4
      L11_4 = L11_4.connect
      L13_4 = L10_4
      L11_4(L12_4, L13_4)
    end
    
    L3_3.Toggle = L10_3
    
    function L10_3(A0_4, A1_4, A2_4, A3_4, A4_4)
      local L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4
      L5_4 = A4_4 or nil
      if not A4_4 then
        function L5_4()
          local L0_5
        end
      end
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "Frame"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "ImageLabel"
      L7_4 = L7_4(L8_4)
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "TextButton"
      L8_4 = L8_4(L9_4)
      L9_4 = Instance
      L9_4 = L9_4.new
      L10_4 = "ImageLabel"
      L9_4 = L9_4(L10_4)
      L10_4 = Instance
      L10_4 = L10_4.new
      L11_4 = "TextBox"
      L10_4 = L10_4(L11_4)
      L11_4 = L8_3
      L6_4.Parent = L11_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 255
      L13_4 = 255
      L14_4 = 255
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L6_4.BackgroundColor3 = L11_4
      L6_4.BackgroundTransparency = 1
      L6_4.BorderSizePixel = 0
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 0
      L13_4 = 375
      L14_4 = 0
      L15_4 = 35
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L6_4.Size = L11_4
      L7_4.Name = "Frame"
      L7_4.Parent = L6_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 255
      L13_4 = 255
      L14_4 = 255
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L7_4.BackgroundColor3 = L11_4
      L7_4.BackgroundTransparency = 1
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 1
      L13_4 = 0
      L14_4 = 0
      L15_4 = 35
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L7_4.Size = L11_4
      L7_4.Image = "rbxassetid://3570695787"
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 29
      L13_4 = 34
      L14_4 = 44
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L7_4.ImageColor3 = L11_4
      L11_4 = Enum
      L11_4 = L11_4.ScaleType
      L11_4 = L11_4.Slice
      L7_4.ScaleType = L11_4
      L11_4 = Rect
      L11_4 = L11_4.new
      L12_4 = 100
      L13_4 = 100
      L14_4 = 100
      L15_4 = 100
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L7_4.SliceCenter = L11_4
      L7_4.SliceScale = 0.05
      L8_4.Parent = L7_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 255
      L13_4 = 255
      L14_4 = 255
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L8_4.BackgroundColor3 = L11_4
      L8_4.BackgroundTransparency = 1
      L8_4.BorderSizePixel = 0
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 0.0206185561
      L13_4 = 0
      L14_4 = 0
      L15_4 = 0
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L8_4.Position = L11_4
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 0.979381442
      L13_4 = 0
      L14_4 = 1
      L15_4 = 0
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L8_4.Size = L11_4
      L11_4 = Enum
      L11_4 = L11_4.Font
      L11_4 = L11_4.SourceSans
      L8_4.Font = L11_4
      L8_4.Text = A1_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 150
      L13_4 = 150
      L14_4 = 150
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L8_4.TextColor3 = L11_4
      L8_4.TextSize = 15
      L11_4 = Enum
      L11_4 = L11_4.TextXAlignment
      L11_4 = L11_4.Left
      L8_4.TextXAlignment = L11_4
      L9_4.Name = "Frame"
      L9_4.Parent = L7_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 255
      L13_4 = 255
      L14_4 = 255
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L9_4.BackgroundColor3 = L11_4
      L9_4.BackgroundTransparency = 1
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 0.654216647
      L13_4 = 0
      L14_4 = 0.200000003
      L15_4 = 0
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L9_4.Position = L11_4
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 0
      L13_4 = 118
      L14_4 = 0
      L15_4 = 21
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L9_4.Size = L11_4
      L9_4.Image = "rbxassetid://3570695787"
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 33
      L13_4 = 38
      L14_4 = 48
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L9_4.ImageColor3 = L11_4
      L11_4 = Enum
      L11_4 = L11_4.ScaleType
      L11_4 = L11_4.Slice
      L9_4.ScaleType = L11_4
      L11_4 = Rect
      L11_4 = L11_4.new
      L12_4 = 100
      L13_4 = 100
      L14_4 = 100
      L15_4 = 100
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L9_4.SliceCenter = L11_4
      L9_4.SliceScale = 0.05
      L10_4.Parent = L9_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 255
      L13_4 = 255
      L14_4 = 255
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L10_4.BackgroundColor3 = L11_4
      L10_4.BackgroundTransparency = 1
      L10_4.BorderSizePixel = 0
      L11_4 = UDim2
      L11_4 = L11_4.new
      L12_4 = 1
      L13_4 = 0
      L14_4 = 1
      L15_4 = 0
      L11_4 = L11_4(L12_4, L13_4, L14_4, L15_4)
      L10_4.Size = L11_4
      L11_4 = Enum
      L11_4 = L11_4.Font
      L11_4 = L11_4.SourceSans
      L10_4.Font = L11_4
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 150
      L13_4 = 150
      L14_4 = 150
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L10_4.PlaceholderColor3 = L11_4
      L10_4.PlaceholderText = A2_4
      L10_4.Text = ""
      L11_4 = Color3
      L11_4 = L11_4.fromRGB
      L12_4 = 150
      L13_4 = 150
      L14_4 = 150
      L11_4 = L11_4(L12_4, L13_4, L14_4)
      L10_4.TextColor3 = L11_4
      L10_4.TextSize = 14
      L11_4 = L10_4.FocusLost
      L12_4 = L11_4
      L11_4 = L11_4.Connect
      
      function L13_4(A0_5)
        local L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L1_5 = A3_4
        if L1_5 then
          if A0_5 then
            L1_5 = L10_4
            L1_5 = L1_5.Text
            L1_5 = #L1_5
            if 0 < L1_5 then
              L1_5 = pcall
              L2_5 = L5_4
              L3_5 = L10_4
              L3_5 = L3_5.Text
              L1_5(L2_5, L3_5)
            end
          end
        else
          L1_5 = L10_4
          L1_5 = L1_5.Text
          L1_5 = #L1_5
          if 0 < L1_5 then
            L1_5 = pcall
            L2_5 = L5_4
            L3_5 = L10_4
            L3_5 = L3_5.Text
            L1_5(L2_5, L3_5)
          end
        end
      end
      
      L11_4(L12_4, L13_4)
      
      function L11_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5
        L0_5 = L9_4
        L1_5 = L0_5
        L0_5 = L0_5.TweenSizeAndPosition
        L2_5 = UDim2
        L2_5 = L2_5.new
        L3_5 = 0
        L4_5 = 216
        L5_5 = 0
        L6_5 = 21
        L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
        L3_5 = UDim2
        L3_5 = L3_5.new
        L4_5 = 0.393
        L5_5 = 0
        L6_5 = 0.2
        L7_5 = 0
        L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
        L4_5 = "InOut"
        L5_5 = "Linear"
        L6_5 = 0.1
        L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
        L0_5 = L10_4
        L1_5 = L0_5
        L0_5 = L0_5.CaptureFocus
        L0_5(L1_5)
      end
      
      function L12_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5
        L0_5 = L9_4
        L1_5 = L0_5
        L0_5 = L0_5.TweenSizeAndPosition
        L2_5 = UDim2
        L2_5 = L2_5.new
        L3_5 = 0
        L4_5 = 118
        L5_5 = 0
        L6_5 = 21
        L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
        L3_5 = UDim2
        L3_5 = L3_5.new
        L4_5 = 0.654216647
        L5_5 = 0
        L6_5 = 0.200000003
        L7_5 = 0
        L3_5 = L3_5(L4_5, L5_5, L6_5, L7_5)
        L4_5 = "InOut"
        L5_5 = "Linear"
        L6_5 = 0.1
        L0_5(L1_5, L2_5, L3_5, L4_5, L5_5, L6_5)
      end
      
      L13_4 = L10_4.Focused
      L14_4 = L13_4
      L13_4 = L13_4.connect
      L15_4 = L11_4
      L13_4(L14_4, L15_4)
      L13_4 = L8_4.MouseButton1Click
      L14_4 = L13_4
      L13_4 = L13_4.connect
      L15_4 = L11_4
      L13_4(L14_4, L15_4)
      L13_4 = L10_4.FocusLost
      L14_4 = L13_4
      L13_4 = L13_4.Connect
      L15_4 = L12_4
      L13_4(L14_4, L15_4)
    end
    
    L3_3.Textbox = L10_3
    
    function L10_3(A0_4, A1_4, A2_4, A3_4)
      local L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4, L13_4, L14_4, L15_4, L16_4, L17_4, L18_4, L19_4, L20_4, L21_4, L22_4, L23_4, L24_4, L25_4
      L4_4 = A3_4 or nil
      if not A3_4 then
        function L4_4()
          local L0_5
        end
      end
      L5_4 = false
      L6_4 = Instance
      L6_4 = L6_4.new
      L7_4 = "Frame"
      L6_4 = L6_4(L7_4)
      L7_4 = Instance
      L7_4 = L7_4.new
      L8_4 = "ImageLabel"
      L7_4 = L7_4(L8_4)
      L8_4 = Instance
      L8_4 = L8_4.new
      L9_4 = "ScrollingFrame"
      L8_4 = L8_4(L9_4)
      L9_4 = Instance
      L9_4 = L9_4.new
      L10_4 = "UIListLayout"
      L9_4 = L9_4(L10_4)
      L10_4 = Instance
      L10_4 = L10_4.new
      L11_4 = "ImageLabel"
      L10_4 = L10_4(L11_4)
      L11_4 = Instance
      L11_4 = L11_4.new
      L12_4 = "TextButton"
      L11_4 = L11_4(L12_4)
      L12_4 = Instance
      L12_4 = L12_4.new
      L13_4 = "ImageLabel"
      L12_4 = L12_4(L13_4)
      L13_4 = Instance
      L13_4 = L13_4.new
      L14_4 = "TextLabel"
      L13_4 = L13_4(L14_4)
      L14_4 = L8_3
      L6_4.Parent = L14_4
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L6_4.BackgroundColor3 = L14_4
      L6_4.BackgroundTransparency = 1
      L6_4.BorderSizePixel = 0
      L6_4.ClipsDescendants = true
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0
      L16_4 = 375
      L17_4 = 0
      L18_4 = 35
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L6_4.Size = L14_4
      L7_4.Name = "dropdown"
      L7_4.Parent = L6_4
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L7_4.BackgroundColor3 = L14_4
      L7_4.BackgroundTransparency = 1
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 1
      L16_4 = 0
      L17_4 = 0
      L18_4 = 159
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L7_4.Size = L14_4
      L7_4.Visible = false
      L7_4.Image = "rbxassetid://3570695787"
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 29
      L16_4 = 34
      L17_4 = 44
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L7_4.ImageColor3 = L14_4
      L14_4 = Enum
      L14_4 = L14_4.ScaleType
      L14_4 = L14_4.Slice
      L7_4.ScaleType = L14_4
      L14_4 = Rect
      L14_4 = L14_4.new
      L15_4 = 100
      L16_4 = 100
      L17_4 = 100
      L18_4 = 100
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L7_4.SliceCenter = L14_4
      L7_4.SliceScale = 0.05
      L8_4.Parent = L7_4
      L8_4.Active = true
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L8_4.BackgroundColor3 = L14_4
      L8_4.BackgroundTransparency = 1
      L8_4.BorderSizePixel = 0
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0.0179999992
      L16_4 = 0
      L17_4 = 0.257999986
      L18_4 = 0
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L8_4.Position = L14_4
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0
      L16_4 = 362
      L17_4 = 0
      L18_4 = 114
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L8_4.Size = L14_4
      L8_4.ScrollBarThickness = 0
      L9_4.Parent = L8_4
      L14_4 = Enum
      L14_4 = L14_4.SortOrder
      L14_4 = L14_4.LayoutOrder
      L9_4.SortOrder = L14_4
      L14_4 = UDim
      L14_4 = L14_4.new
      L15_4 = 0
      L16_4 = 4
      L14_4 = L14_4(L15_4, L16_4)
      L9_4.Padding = L14_4
      L10_4.Name = "Frame"
      L10_4.Parent = L6_4
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L10_4.BackgroundColor3 = L14_4
      L10_4.BackgroundTransparency = 1
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 1
      L16_4 = 0
      L17_4 = 0
      L18_4 = 35
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L10_4.Size = L14_4
      L10_4.Image = "rbxassetid://3570695787"
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 29
      L16_4 = 34
      L17_4 = 44
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L10_4.ImageColor3 = L14_4
      L14_4 = Enum
      L14_4 = L14_4.ScaleType
      L14_4 = L14_4.Slice
      L10_4.ScaleType = L14_4
      L14_4 = Rect
      L14_4 = L14_4.new
      L15_4 = 100
      L16_4 = 100
      L17_4 = 100
      L18_4 = 100
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L10_4.SliceCenter = L14_4
      L10_4.SliceScale = 0.05
      L11_4.Parent = L10_4
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L11_4.BackgroundColor3 = L14_4
      L11_4.BackgroundTransparency = 1
      L11_4.BorderSizePixel = 0
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0.0206185561
      L16_4 = 0
      L17_4 = 0
      L18_4 = 0
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L11_4.Position = L14_4
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0.979381442
      L16_4 = 0
      L17_4 = 1
      L18_4 = 0
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L11_4.Size = L14_4
      L14_4 = Enum
      L14_4 = L14_4.Font
      L14_4 = L14_4.SourceSans
      L11_4.Font = L14_4
      L11_4.Text = "Example Dropdown"
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 150
      L16_4 = 150
      L17_4 = 150
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L11_4.TextColor3 = L14_4
      L11_4.TextSize = 15
      L14_4 = Enum
      L14_4 = L14_4.TextXAlignment
      L14_4 = L14_4.Left
      L11_4.TextXAlignment = L14_4
      L12_4.Name = "Frame"
      L12_4.Parent = L10_4
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L12_4.BackgroundColor3 = L14_4
      L12_4.BackgroundTransparency = 1
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0.654216647
      L16_4 = 0
      L17_4 = 0.200000003
      L18_4 = 0
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L12_4.Position = L14_4
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0
      L16_4 = 118
      L17_4 = 0
      L18_4 = 21
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L12_4.Size = L14_4
      L12_4.Image = "rbxassetid://3570695787"
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 33
      L16_4 = 38
      L17_4 = 48
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L12_4.ImageColor3 = L14_4
      L14_4 = Enum
      L14_4 = L14_4.ScaleType
      L14_4 = L14_4.Slice
      L12_4.ScaleType = L14_4
      L14_4 = Rect
      L14_4 = L14_4.new
      L15_4 = 100
      L16_4 = 100
      L17_4 = 100
      L18_4 = 100
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L12_4.SliceCenter = L14_4
      L12_4.SliceScale = 0.05
      L13_4.Parent = L12_4
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 255
      L16_4 = 255
      L17_4 = 255
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L13_4.BackgroundColor3 = L14_4
      L13_4.BackgroundTransparency = 1
      L13_4.BorderSizePixel = 0
      L13_4.ClipsDescendants = true
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0
      L16_4 = 118
      L17_4 = 0
      L18_4 = 21
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L13_4.Size = L14_4
      L14_4 = Enum
      L14_4 = L14_4.Font
      L14_4 = L14_4.SourceSans
      L13_4.Font = L14_4
      L13_4.Text = "Selection"
      L14_4 = Color3
      L14_4 = L14_4.fromRGB
      L15_4 = 150
      L16_4 = 150
      L17_4 = 150
      L14_4 = L14_4(L15_4, L16_4, L17_4)
      L13_4.TextColor3 = L14_4
      L13_4.TextSize = 14
      L14_4 = L11_4.MouseButton1Click
      L15_4 = L14_4
      L14_4 = L14_4.connect
      
      function L16_4()
        local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5, L7_5, L8_5, L9_5, L10_5, L11_5, L12_5, L13_5, L14_5, L15_5, L16_5, L17_5, L18_5, L19_5, L20_5, L21_5, L22_5, L23_5, L24_5, L25_5, L26_5, L27_5, L28_5, L29_5, L30_5, L31_5, L32_5, L33_5, L34_5, L35_5, L36_5, L37_5, L38_5, L39_5, L40_5, L41_5, L42_5, L43_5, L44_5, L45_5, L46_5, L47_5, L48_5, L49_5, L50_5, L51_5, L52_5, L53_5, L54_5, L55_5, L56_5, L57_5, L58_5, L59_5, L60_5, L61_5, L62_5, L63_5, L64_5, L65_5, L66_5, L67_5, L68_5, L69_5, L70_5, L71_5, L72_5, L73_5, L74_5, L75_5, L76_5, L77_5, L78_5, L79_5, L80_5, L81_5, L82_5, L83_5, L84_5, L85_5, L86_5, L87_5, L88_5, L89_5, L90_5, L91_5, L92_5, L93_5, L94_5, L95_5, L96_5, L97_5, L98_5, L99_5, L100_5, L101_5, L102_5, L103_5, L104_5, L105_5, L106_5, L107_5, L108_5, L109_5, L110_5, L111_5, L112_5, L113_5, L114_5, L115_5, L116_5, L117_5, L118_5, L119_5, L120_5, L121_5, L122_5, L123_5, L124_5, L125_5, L126_5, L127_5, L128_5, L129_5, L130_5, L131_5, L132_5, L133_5, L134_5, L135_5, L136_5, L137_5, L138_5, L139_5, L140_5, L141_5, L142_5, L143_5, L144_5, L145_5, L146_5, L147_5, L148_5, L149_5, L150_5, L151_5, L152_5, L153_5, L154_5, L155_5, L156_5, L157_5, L158_5, L159_5, L160_5, L161_5, L162_5, L163_5, L164_5, L165_5, L166_5, L167_5, L168_5, L169_5, L170_5, L171_5, L172_5, L173_5, L174_5, L175_5, L176_5, L177_5, L178_5, L179_5, L180_5, L181_5, L182_5, L183_5, L184_5, L185_5, L186_5, L187_5, L188_5, L189_5, L190_5, L191_5, L192_5, L193_5, L194_5, L195_5, L196_5, L197_5, L198_5, L199_5, L200_5, L201_5, L202_5, L203_5, L204_5, L205_5, L206_5, L207_5, L208_5, L209_5, L210_5, L211_5, L212_5, L213_5, L214_5, L215_5, L216_5, L217_5, L218_5, L219_5, L220_5, L221_5, L222_5, L223_5, L224_5, L225_5, L226_5, L227_5, L228_5, L229_5, L230_5, L231_5, L232_5, L233_5, L234_5, L235_5, L236_5, L237_5, L238_5, L239_5, L240_5, L241_5, L242_5, L243_5, L244_5, L245_5, L246_5, L247_5, L248_5, L249_5, L250_5, L251_5, L252_5, L253_5, L254_5
        L0_5 = L5_4
        L0_5 = not L0_5
        L5_4 = L0_5
        L0_5 = L5_4
        if L0_5 then
          L0_5 = L7_4
          L1_5 = L5_4
          L0_5.Visible = L1_5
          L0_5 = A2_4
          L0_5 = #L0_5
          if L0_5 <= 4 then
            L0_5 = print
            L1_5 = A2_4
            L1_5 = #L1_5
            L1_5 = 29 * L1_5
            L1_5 = 43 + L1_5
            L0_5(L1_5)
            L0_5 = L6_4
            L1_5 = L0_5
            L0_5 = L0_5.TweenSize
            L2_5 = UDim2
            L2_5 = L2_5.new
            L3_5 = 1
            L4_5 = 0
            L5_5 = 0
            L6_5 = A2_4
            L6_5 = #L6_5
            L6_5 = 29 * L6_5
            L6_5 = L6_5 + 35
            L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
            L3_5 = "InOut"
            L4_5 = "Linear"
            L5_5 = 0.15
            L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
            L0_5 = wait
            L1_5 = 0.15
            L0_5(L1_5)
            L0_5 = L8_3
            L1_5 = UDim2
            L1_5 = L1_5.new
            L2_5 = 0
            L3_5 = 243
            L4_5 = 0
            L5_5 = L8_3
            L5_5 = L5_5.UIListLayout
            L5_5 = L5_5.AbsoluteContentSize
            L5_5 = L5_5.Y
            L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
            L0_5.CanvasSize = L1_5
          else
            L0_5 = L6_4
            L1_5 = L0_5
            L0_5 = L0_5.TweenSize
            L2_5 = L7_4
            L2_5 = L2_5.Size
            L3_5 = "InOut"
            L4_5 = "Linear"
            L5_5 = 0.15
            L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
            L0_5 = wait
            L1_5 = 0.15
            L0_5(L1_5)
            L0_5 = L8_3
            L1_5 = UDim2
            L1_5 = L1_5.new
            L2_5 = 0
            L3_5 = 243
            L4_5 = 0
            L5_5 = L8_3
            L5_5 = L5_5.UIListLayout
            L5_5 = L5_5.AbsoluteContentSize
            L5_5 = L5_5.Y
            L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
            L0_5.CanvasSize = L1_5
          end
        else
          L0_5 = L7_4
          L1_5 = L5_4
          L0_5.Visible = L1_5
          L0_5 = L6_4
          L1_5 = L0_5
          L0_5 = L0_5.TweenSize
          L2_5 = UDim2
          L2_5 = L2_5.new
          L3_5 = 0
          L4_5 = 375
          L5_5 = 0
          L6_5 = 35
          L2_5 = L2_5(L3_5, L4_5, L5_5, L6_5)
          L3_5 = "InOut"
          L4_5 = "Linear"
          L5_5 = 0.15
          L0_5(L1_5, L2_5, L3_5, L4_5, L5_5)
          L0_5 = wait
          L1_5 = 0.15
          L0_5(L1_5)
          L0_5 = L8_3
          L1_5 = UDim2
          L1_5 = L1_5.new
          L2_5 = 0
          L3_5 = 243
          L4_5 = 0
          L5_5 = L8_3
          L5_5 = L5_5.UIListLayout
          L5_5 = L5_5.AbsoluteContentSize
          L5_5 = L5_5.Y
          L1_5 = L1_5(L2_5, L3_5, L4_5, L5_5)
          L0_5.CanvasSize = L1_5
        end
      end
      
      L14_4(L15_4, L16_4)
      L14_4 = pairs
      L15_4 = A2_4
      L14_4, L15_4, L16_4 = L14_4(L15_4)
      for L17_4, L18_4 in L14_4, L15_4, L16_4 do
        L19_4 = Instance
        L19_4 = L19_4.new
        L20_4 = "ImageLabel"
        L19_4 = L19_4(L20_4)
        L20_4 = Instance
        L20_4 = L20_4.new
        L21_4 = "TextButton"
        L20_4 = L20_4(L21_4)
        L19_4.Name = "Frame"
        L19_4.Parent = L8_4
        L21_4 = Color3
        L21_4 = L21_4.fromRGB
        L22_4 = 255
        L23_4 = 255
        L24_4 = 255
        L21_4 = L21_4(L22_4, L23_4, L24_4)
        L19_4.BackgroundColor3 = L21_4
        L19_4.BackgroundTransparency = 1
        L21_4 = UDim2
        L21_4 = L21_4.new
        L22_4 = 1
        L23_4 = 0
        L24_4 = 0
        L25_4 = 25
        L21_4 = L21_4(L22_4, L23_4, L24_4, L25_4)
        L19_4.Size = L21_4
        L19_4.Image = "rbxassetid://3570695787"
        L21_4 = Color3
        L21_4 = L21_4.fromRGB
        L22_4 = 33
        L23_4 = 38
        L24_4 = 48
        L21_4 = L21_4(L22_4, L23_4, L24_4)
        L19_4.ImageColor3 = L21_4
        L21_4 = Enum
        L21_4 = L21_4.ScaleType
        L21_4 = L21_4.Slice
        L19_4.ScaleType = L21_4
        L21_4 = Rect
        L21_4 = L21_4.new
        L22_4 = 100
        L23_4 = 100
        L24_4 = 100
        L25_4 = 100
        L21_4 = L21_4(L22_4, L23_4, L24_4, L25_4)
        L19_4.SliceCenter = L21_4
        L19_4.SliceScale = 0.05
        L20_4.Parent = L19_4
        L21_4 = Color3
        L21_4 = L21_4.fromRGB
        L22_4 = 255
        L23_4 = 255
        L24_4 = 255
        L21_4 = L21_4(L22_4, L23_4, L24_4)
        L20_4.BackgroundColor3 = L21_4
        L20_4.BackgroundTransparency = 1
        L20_4.BorderSizePixel = 0
        L21_4 = UDim2
        L21_4 = L21_4.new
        L22_4 = 0
        L23_4 = 0
        L24_4 = 0
        L25_4 = 0
        L21_4 = L21_4(L22_4, L23_4, L24_4, L25_4)
        L20_4.Position = L21_4
        L21_4 = UDim2
        L21_4 = L21_4.new
        L22_4 = 1
        L23_4 = 0
        L24_4 = 1
        L25_4 = 0
        L21_4 = L21_4(L22_4, L23_4, L24_4, L25_4)
        L20_4.Size = L21_4
        L21_4 = Enum
        L21_4 = L21_4.Font
        L21_4 = L21_4.SourceSans
        L20_4.Font = L21_4
        L21_4 = tostring
        L22_4 = L18_4
        L21_4 = L21_4(L22_4)
        L20_4.Text = L21_4
        L21_4 = Color3
        L21_4 = L21_4.fromRGB
        L22_4 = 150
        L23_4 = 150
        L24_4 = 150
        L21_4 = L21_4(L22_4, L23_4, L24_4)
        L20_4.TextColor3 = L21_4
        L20_4.TextSize = 15
        L21_4 = L20_4.MouseButton1Down
        L22_4 = L21_4
        L21_4 = L21_4.connect
        
        function L23_4()
          local L0_5, L1_5
          L0_5 = L13_4
          L1_5 = L20_4
          L1_5 = L1_5.Text
          L0_5.Text = L1_5
          L0_5 = L4_4
          L1_5 = L20_4
          L1_5 = L1_5.Text
          L0_5(L1_5)
        end
        
        L21_4(L22_4, L23_4)
        L21_4 = L20_4
        L22_4 = L21_4.Parent
        L23_4 = L21_4.MouseEnter
        L24_4 = L23_4
        L23_4 = L23_4.Connect
        
        function L25_4()
          local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
          L0_5 = L28_1
          L1_5 = L22_4
          L2_5 = {}
          L3_5 = Color3
          L3_5 = L3_5.fromRGB
          L4_5 = 117
          L5_5 = 143
          L6_5 = 255
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L2_5.ImageColor3 = L3_5
          L3_5 = 0.15
          L0_5(L1_5, L2_5, L3_5)
          L0_5 = L28_1
          L1_5 = L21_4
          L2_5 = {}
          L3_5 = Color3
          L3_5 = L3_5.fromRGB
          L4_5 = 255
          L5_5 = 255
          L6_5 = 255
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L2_5.TextColor3 = L3_5
          L3_5 = 0.15
          L0_5(L1_5, L2_5, L3_5)
        end
        
        L23_4(L24_4, L25_4)
        L23_4 = L21_4.MouseLeave
        L24_4 = L23_4
        L23_4 = L23_4.Connect
        
        function L25_4()
          local L0_5, L1_5, L2_5, L3_5, L4_5, L5_5, L6_5
          L0_5 = L28_1
          L1_5 = L22_4
          L2_5 = {}
          L3_5 = Color3
          L3_5 = L3_5.fromRGB
          L4_5 = 33
          L5_5 = 38
          L6_5 = 48
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L2_5.ImageColor3 = L3_5
          L3_5 = 0.15
          L0_5(L1_5, L2_5, L3_5)
          L0_5 = L28_1
          L1_5 = L21_4
          L2_5 = {}
          L3_5 = Color3
          L3_5 = L3_5.fromRGB
          L4_5 = 150
          L5_5 = 150
          L6_5 = 150
          L3_5 = L3_5(L4_5, L5_5, L6_5)
          L2_5.TextColor3 = L3_5
          L3_5 = 0.15
          L0_5(L1_5, L2_5, L3_5)
        end
        
        L23_4(L24_4, L25_4)
      end
      L14_4 = UDim2
      L14_4 = L14_4.new
      L15_4 = 0
      L16_4 = 0
      L17_4 = 0
      L18_4 = L8_4.UIListLayout
      L18_4 = L18_4.AbsoluteContentSize
      L18_4 = L18_4.Y
      L14_4 = L14_4(L15_4, L16_4, L17_4, L18_4)
      L8_4.CanvasSize = L14_4
    end
    
    L3_3.Dropdown = L10_3
    
    function L10_3(A0_4, A1_4, A2_4)
      local L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4
      L3_4 = Instance
      L3_4 = L3_4.new
      L4_4 = "Frame"
      L3_4 = L3_4(L4_4)
      L4_4 = Instance
      L4_4 = L4_4.new
      L5_4 = "ImageLabel"
      L4_4 = L4_4(L5_4)
      L5_4 = Instance
      L5_4 = L5_4.new
      L6_4 = "TextLabel"
      L5_4 = L5_4(L6_4)
      L6_4 = L8_3
      L3_4.Parent = L6_4
      L6_4 = Color3
      L6_4 = L6_4.fromRGB
      L7_4 = 255
      L8_4 = 255
      L9_4 = 255
      L6_4 = L6_4(L7_4, L8_4, L9_4)
      L3_4.BackgroundColor3 = L6_4
      L3_4.BackgroundTransparency = 1
      L3_4.BorderSizePixel = 0
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 0
      L8_4 = 375
      L9_4 = 0
      L10_4 = 35
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L3_4.Size = L6_4
      L4_4.Name = "Frame"
      L4_4.Parent = L3_4
      L6_4 = Color3
      L6_4 = L6_4.fromRGB
      L7_4 = 255
      L8_4 = 255
      L9_4 = 255
      L6_4 = L6_4(L7_4, L8_4, L9_4)
      L4_4.BackgroundColor3 = L6_4
      L4_4.BackgroundTransparency = 1
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 1
      L8_4 = 0
      L9_4 = 0
      L10_4 = 35
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L4_4.Size = L6_4
      L4_4.Image = "rbxassetid://3570695787"
      L6_4 = Color3
      L6_4 = L6_4.fromRGB
      L7_4 = 117
      L8_4 = 143
      L9_4 = 255
      L6_4 = L6_4(L7_4, L8_4, L9_4)
      L4_4.ImageColor3 = L6_4
      L4_4.ImageTransparency = 1
      L6_4 = Enum
      L6_4 = L6_4.ScaleType
      L6_4 = L6_4.Slice
      L4_4.ScaleType = L6_4
      L6_4 = Rect
      L6_4 = L6_4.new
      L7_4 = 100
      L8_4 = 100
      L9_4 = 100
      L10_4 = 100
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L4_4.SliceCenter = L6_4
      L4_4.SliceScale = 0.05
      L5_4.Parent = L4_4
      L6_4 = Color3
      L6_4 = L6_4.fromRGB
      L7_4 = 255
      L8_4 = 255
      L9_4 = 255
      L6_4 = L6_4(L7_4, L8_4, L9_4)
      L5_4.BackgroundColor3 = L6_4
      L5_4.BackgroundTransparency = 1
      L5_4.BorderSizePixel = 0
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 0.020618489
      L8_4 = 0
      L9_4 = 0
      L10_4 = 0
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L5_4.Position = L6_4
      L6_4 = UDim2
      L6_4 = L6_4.new
      L7_4 = 0.979381502
      L8_4 = 0
      L9_4 = 1
      L10_4 = 0
      L6_4 = L6_4(L7_4, L8_4, L9_4, L10_4)
      L5_4.Size = L6_4
      L6_4 = Enum
      L6_4 = L6_4.Font
      L6_4 = L6_4.SourceSans
      L5_4.Font = L6_4
      L5_4.Text = A1_4
      L6_4 = A2_4 or L6_4
      if not A2_4 then
        L6_4 = Color3
        L6_4 = L6_4.fromRGB
        L7_4 = 150
        L8_4 = 150
        L9_4 = 150
        L6_4 = L6_4(L7_4, L8_4, L9_4)
      end
      L5_4.TextColor3 = L6_4
      L5_4.TextSize = 14
      L6_4 = Enum
      L6_4 = L6_4.TextXAlignment
      L6_4 = L6_4.Left
      L5_4.TextXAlignment = L6_4
    end
    
    L3_3.Textlabel = L10_3
  end
  
  L10_2.Tab = L11_2
  L10_2 = L26_1
  
  function L11_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L2_3 = A0_3.tabs
    L2_3 = L2_3[A1_3]
    if L2_3 then
      L2_3 = A0_3.tabs
      L2_3 = L2_3[A1_3]
      L3_3 = L5_2
      L3_3.Text = A1_3
      L3_3 = L2_3[1]
      L4_3 = L3_3
      L3_3 = L3_3.TweenPosition
      L5_3 = UDim2
      L5_3 = L5_3.new
      L6_3 = 0
      L7_3 = 54
      L8_3 = 0
      L9_3 = 28
      L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
      L6_3 = "InOut"
      L7_3 = "Linear"
      L8_3 = 0.2
      L3_3(L4_3, L5_3, L6_3, L7_3, L8_3)
      L3_3 = L2_3[2]
      L4_3 = pairs
      L5_3 = L3_2
      L6_3 = L5_3
      L5_3 = L5_3.GetChildren
      L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3 = L5_3(L6_3)
      L4_3, L5_3, L6_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
      for L7_3, L8_3 in L4_3, L5_3, L6_3 do
        L10_3 = L8_3
        L9_3 = L8_3.IsA
        L11_3 = "Frame"
        L9_3 = L9_3(L10_3, L11_3)
        if L9_3 then
          L10_3 = L8_3
          L9_3 = L8_3.TweenPosition
          L11_3 = UDim2
          L11_3 = L11_3.new
          L12_3 = 0
          L13_3 = 456
          L14_3 = 0
          L15_3 = 28
          L11_3 = L11_3(L12_3, L13_3, L14_3, L15_3)
          L12_3 = "InOut"
          L13_3 = "Linear"
          L14_3 = 0.2
          L9_3(L10_3, L11_3, L12_3, L13_3, L14_3)
        end
      end
      L4_3 = pairs
      L5_3 = L3_3.Parent
      L6_3 = L5_3
      L5_3 = L5_3.GetChildren
      L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3 = L5_3(L6_3)
      L4_3, L5_3, L6_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
      for L7_3, L8_3 in L4_3, L5_3, L6_3 do
        L10_3 = L8_3
        L9_3 = L8_3.IsA
        L11_3 = "Frame"
        L9_3 = L9_3(L10_3, L11_3)
        if L9_3 then
          L9_3 = L28_1
          L10_3 = L8_3.ImageButton
          L11_3 = {}
          L12_3 = Color3
          L12_3 = L12_3.fromRGB
          L13_3 = 150
          L14_3 = 150
          L15_3 = 150
          L12_3 = L12_3(L13_3, L14_3, L15_3)
          L11_3.ImageColor3 = L12_3
          L12_3 = 0.15
          L9_3(L10_3, L11_3, L12_3)
          L9_3 = L28_1
          L10_3 = L8_3.Frame
          L11_3 = {}
          L12_3 = Color3
          L12_3 = L12_3.fromRGB
          L13_3 = 33
          L14_3 = 38
          L15_3 = 48
          L12_3 = L12_3(L13_3, L14_3, L15_3)
          L11_3.ImageColor3 = L12_3
          L12_3 = 0.15
          L9_3(L10_3, L11_3, L12_3)
        end
      end
      L4_3 = L28_1
      L5_3 = L3_3.ImageButton
      L6_3 = {}
      L7_3 = Color3
      L7_3 = L7_3.fromRGB
      L8_3 = 255
      L9_3 = 255
      L10_3 = 255
      L7_3 = L7_3(L8_3, L9_3, L10_3)
      L6_3.ImageColor3 = L7_3
      L7_3 = 0.15
      L4_3(L5_3, L6_3, L7_3)
      L4_3 = L28_1
      L5_3 = L3_3.Frame
      L6_3 = {}
      L7_3 = Color3
      L7_3 = L7_3.fromRGB
      L8_3 = 117
      L9_3 = 143
      L10_3 = 255
      L7_3 = L7_3(L8_3, L9_3, L10_3)
      L6_3.ImageColor3 = L7_3
      L7_3 = 0.15
      L4_3(L5_3, L6_3, L7_3)
    else
      L2_3 = error
      L3_3 = "Attempted to show a nil frame."
      L2_3(L3_3)
    end
  end
  
  L10_2.Show = L11_2
  L10_2 = L26_1
  
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L1_3 = pairs
    L2_3 = L3_2
    L3_3 = L2_3
    L2_3 = L2_3.GetChildren
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L2_3(L3_3)
    L1_3, L2_3, L3_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    for L4_3, L5_3 in L1_3, L2_3, L3_3 do
      L7_3 = L5_3
      L6_3 = L5_3.IsA
      L8_3 = "Frame"
      L6_3 = L6_3(L7_3, L8_3)
      if L6_3 then
        L6_3 = L5_3.ScrollingFrame
        L7_3 = UDim2
        L7_3 = L7_3.new
        L8_3 = 0
        L9_3 = 243
        L10_3 = 0
        L11_3 = L5_3.ScrollingFrame
        L11_3 = L11_3.UIListLayout
        L11_3 = L11_3.AbsoluteContentSize
        L11_3 = L11_3.Y
        L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
        L6_3.CanvasSize = L7_3
      end
    end
  end
  
  L10_2.ReSize = L11_2
  L10_2 = L26_1
end

L26_1.Create = L29_1

function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = pairs
  L2_2 = game
  L2_2 = L2_2.Players
  L3_2 = L2_2
  L2_2 = L2_2.GetChildren
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
  L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L1_2, L2_2, L3_2 do
    L6_2 = string
    L6_2 = L6_2.sub
    L7_2 = L5_2.Name
    L8_2 = L7_2
    L7_2 = L7_2.lower
    L7_2 = L7_2(L8_2)
    L8_2 = 1
    L9_2 = #A0_2
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L8_2 = A0_2
    L7_2 = A0_2.lower
    L7_2 = L7_2(L8_2)
    if L6_2 ~= L7_2 then
      L6_2 = string
      L6_2 = L6_2.sub
      L7_2 = L5_2.DisplayName
      L8_2 = L7_2
      L7_2 = L7_2.lower
      L7_2 = L7_2(L8_2)
      L8_2 = 1
      L9_2 = #A0_2
      L6_2 = L6_2(L7_2, L8_2, L9_2)
      L8_2 = A0_2
      L7_2 = A0_2.lower
      L7_2 = L7_2(L8_2)
      if L6_2 ~= L7_2 then
        goto lbl_33
      end
    end
    do return L5_2 end
    ::lbl_33::
  end
  L1_2 = false
end

getPlayer = L29_1
L30_1 = L26_1
L29_1 = L26_1.Create
L31_1 = "Blank"
L29_1 = L29_1(L30_1, L31_1)
L31_1 = L29_1
L30_1 = L29_1.Tab
L32_1 = "Autofarm"
L33_1 = 8126620791
L30_1 = L30_1(L31_1, L32_1, L33_1)
L32_1 = L29_1
L31_1 = L29_1.Tab
L33_1 = "Autobuild"
L34_1 = 8126635057
L31_1 = L31_1(L32_1, L33_1, L34_1)
L33_1 = L29_1
L32_1 = L29_1.Tab
L34_1 = "Miscellaneous"
L35_1 = 8126604215
L32_1 = L32_1(L33_1, L34_1, L35_1)
L34_1 = L29_1
L33_1 = L29_1.Tab
L35_1 = "Waypoitns"
L36_1 = 8126641209
L33_1 = L33_1(L34_1, L35_1, L36_1)
L34_1 = game
L35_1 = L34_1
L34_1 = L34_1.GetService
L36_1 = "Players"
L34_1 = L34_1(L35_1, L36_1)
L35_1 = L34_1.LocalPlayer
L37_1 = L30_1
L36_1 = L30_1.Textbox
L38_1 = "Quit After Amount"
L39_1 = "Number"
L40_1 = false

function L41_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = tonumber
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = L25_1
    L2_2 = tonumber
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2.quit_after_amount = L2_2
  end
end

L36_1(L37_1, L38_1, L39_1, L40_1, L41_1)
L37_1 = L30_1
L36_1 = L30_1.Toggle
L38_1 = "Quit After Amount"

function L39_1(A0_2)
  local L1_2, L2_2
  L1_2 = L25_1
  L2_2 = bool
  L1_2.quit_after_enabled = L2_2
end

L36_1(L37_1, L38_1, L39_1)
L37_1 = L30_1
L36_1 = L30_1.Toggle
L38_1 = "Autofarm"

function L39_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = L25_1
    L1_2 = L1_2.start_autofarm
    L2_2 = L25_1
    L1_2(L2_2)
  else
    L1_2 = L25_1
    L1_2 = L1_2.stop_autofarm
    L2_2 = L25_1
    L1_2(L2_2)
  end
end

L36_1(L37_1, L38_1, L39_1)
L37_1 = L30_1
L36_1 = L30_1.Button
L38_1 = "Boost Fun"

function L39_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L0_2 = L0_2.boost_fun
  L1_2 = L25_1
  L0_2(L1_2)
end

L36_1(L37_1, L38_1, L39_1)
L37_1 = L30_1
L36_1 = L30_1.Button
L38_1 = "Boost Energy"

function L39_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L0_2 = L0_2.boost_energy
  L1_2 = L25_1
  L0_2(L1_2)
end

L36_1(L37_1, L38_1, L39_1)
L37_1 = L30_1
L36_1 = L30_1.Button
L38_1 = "Boost Hunger"

function L39_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L0_2 = L0_2.boost_hunger
  L1_2 = L25_1
  L0_2(L1_2)
end

L36_1(L37_1, L38_1, L39_1)
L37_1 = L30_1
L36_1 = L30_1.Button
L38_1 = "Boost Hygiene"

function L39_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L0_2 = L0_2.boost_hygiene
  L1_2 = L25_1
  L0_2(L1_2)
end

L36_1(L37_1, L38_1, L39_1)
L36_1 = false
L37_1 = game
L37_1 = L37_1.Players
L37_1 = L37_1.LocalPlayer
L38_1 = game
L38_1 = L38_1.Players
L38_1 = L38_1.LocalPlayer
L39_1 = ""
L41_1 = L31_1
L40_1 = L31_1.Textbox
L42_1 = "Base ID"
L43_1 = "String"
L44_1 = false

function L45_1(A0_2)
  L39_1 = A0_2
end

L40_1(L41_1, L42_1, L43_1, L44_1, L45_1)
L41_1 = L31_1
L40_1 = L31_1.Textlabel
L42_1 = "Status: "
L43_1 = Color3
L43_1 = L43_1.fromRGB
L44_1 = 150
L45_1 = 150
L46_1 = 150
L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1 = L43_1(L44_1, L45_1, L46_1)
L40_1 = L40_1(L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1)
L42_1 = L31_1
L41_1 = L31_1.Textlabel
L43_1 = "ETA: "
L44_1 = Color3
L44_1 = L44_1.fromRGB
L45_1 = 150
L46_1 = 150
L47_1 = 150
L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1 = L44_1(L45_1, L46_1, L47_1)
L41_1 = L41_1(L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1)
L43_1 = L31_1
L42_1 = L31_1.Textlabel
L44_1 = "Progress: "
L45_1 = Color3
L45_1 = L45_1.fromRGB
L46_1 = 150
L47_1 = 150
L48_1 = 150
L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1 = L45_1(L46_1, L47_1, L48_1)
L42_1 = L42_1(L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1)

function L43_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L40_1
  L2_2 = "Status: "
  L3_2 = tostring
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L2_2 = L2_2 .. L3_2
  L1_2.Text = L2_2
end

function L44_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L41_1
  L2_2 = "ETA: "
  L3_2 = tostring
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L2_2 = L2_2 .. L3_2
  L1_2.Text = L2_2
end

function L45_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = L42_1
  L3_2 = "Progress: "
  L4_2 = tostring
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = " / "
  L6_2 = tostring
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
  L2_2.Text = L3_2
end

L47_1 = L31_1
L46_1 = L31_1.Toggle
L48_1 = "Use Bloxbucks"

function L49_1(A0_2)
  L36_1 = A0_2
end

L46_1(L47_1, L48_1, L49_1)
L47_1 = L31_1
L46_1 = L31_1.Textbox
L48_1 = "Player's Plot"
L49_1 = "String"
L50_1 = false

function L51_1(A0_2)
  local L1_2, L2_2
  L1_2 = getPlayer
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = getPlayer
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L38_1 = L1_2
  end
end

L46_1 = L46_1(L47_1, L48_1, L49_1, L50_1, L51_1)
L48_1 = L31_1
L47_1 = L31_1.Button
L49_1 = "Build Base"

function L50_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = L25_1
  L0_2 = L0_2.get_base_metadata
  L1_2 = L25_1
  L2_2 = L39_1
  L3_2 = false
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = getPlayer
  L2_2 = L46_1
  L2_2 = L2_2.Text
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = L38_1
  end
  L2_2 = L25_1
  L2_2 = L2_2.autobuild_base
  L3_2 = L25_1
  L4_2 = L0_2.base_payload
  L5_2 = L1_2
  L6_2 = L36_1
  L7_2 = L43_1
  L8_2 = L44_1
  L9_2 = L45_1
  L10_2 = L39_1
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
end

L47_1(L48_1, L49_1, L50_1)
L48_1 = L31_1
L47_1 = L31_1.Button
L49_1 = "Preview Base"

function L50_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = L25_1
  L0_2 = L0_2.get_base_metadata
  L1_2 = L25_1
  L2_2 = L39_1
  L3_2 = false
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = getPlayer
  L2_2 = playerText
  L2_2 = L2_2.Text
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = L37_1
  end
  L2_2 = L25_1
  L2_2 = L2_2.preview_base
  L3_2 = L25_1
  L4_2 = L0_2.base_payload
  L5_2 = L1_2
  L6_2 = L43_1
  L2_2(L3_2, L4_2, L5_2, L6_2)
end

L47_1(L48_1, L49_1, L50_1)
L48_1 = L31_1
L47_1 = L31_1.Button
L49_1 = "Clear Preview"

function L50_1()
  local L0_2, L1_2
  L0_2 = L25_1
  L0_2 = L0_2.destroy_preview
  L1_2 = L25_1
  L0_2(L1_2)
end

L47_1(L48_1, L49_1, L50_1)
L48_1 = L31_1
L47_1 = L31_1.Textbox
L49_1 = "Player Name"
L50_1 = "String"
L51_1 = false

function L52_1(A0_2)
  local L1_2, L2_2
  L1_2 = getPlayer
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = getPlayer
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L37_1 = L1_2
  end
end

L47_1 = L47_1(L48_1, L49_1, L50_1, L51_1, L52_1)
L48_1 = ""
L50_1 = L31_1
L49_1 = L31_1.Button
L51_1 = "Save Player Base"

function L52_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = getPlayer
  L1_2 = L47_1
  L1_2 = L1_2.Text
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L0_2 = L37_1
  end
  L1_2 = L25_1
  L1_2 = L1_2.save_base
  L2_2 = L25_1
  L3_2 = L0_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = L1_2.code
  if L2_2 ~= 200 then
    L2_2 = L1_2.code
    if L2_2 ~= 5002 then
      L2_2 = L43_1
      L3_2 = "Save Failed!"
      L2_2(L3_2)
      L2_2 = ""
      L48_1 = L2_2
      L2_2 = warn
      L3_2 = game
      L3_2 = L3_2.HttpService
      L4_2 = L3_2
      L3_2 = L3_2.JSONEncode
      L5_2 = L1_2
      L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2)
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
      L2_2 = L25_1
      L2_2 = L2_2.notify
      L3_2 = L25_1
      L4_2 = string
      L4_2 = L4_2.format
      L5_2 = "Base Save Failed! Message: %s | Code: %s"
      L6_2 = L1_2.message
      L7_2 = L1_2.code
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2)
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    end
  end
  L2_2 = L1_2.code
  if L2_2 == 200 then
    L2_2 = L43_1
    L3_2 = "Save Success!"
    L2_2(L3_2)
    L2_2 = L1_2.inserted_id
    L48_1 = L2_2
  else
    L2_2 = L1_2.code
    if L2_2 == 5002 then
      L2_2 = L43_1
      L3_2 = "Base already exists!"
      L2_2(L3_2)
      L2_2 = L1_2.existing_id
      L48_1 = L2_2
    end
  end
end

L49_1(L50_1, L51_1, L52_1)
L50_1 = L31_1
L49_1 = L31_1.Button
L51_1 = "Copy save ID"

function L52_1()
  local L0_2, L1_2, L2_2
  L0_2 = L25_1
  L0_2 = L0_2.copy_clipboard
  L1_2 = L25_1
  L2_2 = L48_1
  L0_2(L1_2, L2_2)
end

L49_1(L50_1, L51_1, L52_1)
L50_1 = L32_1
L49_1 = L32_1.Textbox
L51_1 = "Enter Fake Confirmation Message"
L52_1 = "String"
L53_1 = false

function L54_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L25_1
  L1_2 = L1_2.make_confirmation
  L2_2 = L25_1
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end

L49_1(L50_1, L51_1, L52_1, L53_1, L54_1)
L50_1 = L32_1
L49_1 = L32_1.Textbox
L51_1 = "Enter Fake Paycheck Message"
L52_1 = "Number"
L53_1 = false

function L54_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = tonumber
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = L25_1
    L1_2 = L1_2.make_paycheck
    L2_2 = L25_1
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
  end
end

L49_1(L50_1, L51_1, L52_1, L53_1, L54_1)
L50_1 = L33_1
L49_1 = L33_1.Textbox
L51_1 = "Teleport to Plot"
L52_1 = "String"
L53_1 = false

function L54_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = L25_1
  L1_2 = L1_2.teleport_player_plot
  L2_2 = L25_1
  L3_2 = getPlayer
  L4_2 = A0_2
  L3_2, L4_2 = L3_2(L4_2)
  L1_2(L2_2, L3_2, L4_2)
end

L49_1(L50_1, L51_1, L52_1, L53_1, L54_1)
L50_1 = L33_1
L49_1 = L33_1.Dropdown
L51_1 = "Teleport to Job"
L52_1 = {}
L53_1 = "Cashier"
L54_1 = "Woodcutter"
L55_1 = "Pizza Baker"
L56_1 = "Mechanic"
L57_1 = "Miner"
L58_1 = "Delivery Person"
L59_1 = "Seller"
L60_1 = "Cashier"
L61_1 = "Stocker"
L62_1 = "Janitor"
L63_1 = "Hairdresser"
L64_1 = "Fisherman"
L52_1[1] = L53_1
L52_1[2] = L54_1
L52_1[3] = L55_1
L52_1[4] = L56_1
L52_1[5] = L57_1
L52_1[6] = L58_1
L52_1[7] = L59_1
L52_1[8] = L60_1
L52_1[9] = L61_1
L52_1[10] = L62_1
L52_1[11] = L63_1
L52_1[12] = L64_1

function L53_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = L25_1
  L1_2 = L1_2.teleport_job
  L2_2 = L25_1
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end

L49_1(L50_1, L51_1, L52_1, L53_1)
L50_1 = L29_1
L49_1 = L29_1.Show
L51_1 = "Autofarm"
L49_1(L50_1, L51_1)
L50_1 = L29_1
L49_1 = L29_1.ReSize
L49_1(L50_1)
