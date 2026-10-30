-- deobfuscated.lua
-- ВНИМАНИЕ: восстановлено по функциям (unluac не смог разобрать файл целиком).
-- Функции, помеченные PSEUDO, даны в виде дизассемблера и не являются исходным Lua.

-- ══════════ main.p0 ══════════
-- PSEUDO (дизассемблер):
-- -- constants: 4 strings
-- 
-- -- function main  params=0 nups=1 lines=0..0
-- [   1] R0 = U0                                    -- line -1
-- [   2] R0 = R0['Character']                       -- line -1
-- [   3] R0 = R0['FindFirstChild']; R1 = R0         -- line -1
-- [   4] R2 = 'Humanoid'                            -- line -1
-- [   5] R0..R1 = R0(R1, R2)                        -- line -1
-- [   6] if R0 == false then goto next+1            -- line -1
-- ::L6::
-- goto L13  (jump +6)
-- [   8] R0 = U0                                    -- line -1
-- [   9] R0 = R0['Character']                       -- line -1
-- [  10] R0 = R0['Humanoid']                        -- line -1
-- [  11] R1 = _ENV['_G']                            -- line -1
-- [  12] R1 = R1['WalkSpeed']                       -- line -1
-- R0['WalkSpeed'] = R1
-- [  14] return ...                                 -- line -1
-- 
-- -- ===== string constants =====
-- --   'Character'
-- --   'FindFirstChild'
-- --   'Humanoid'
-- --   'WalkSpeed'

-- ══════════ main.p1 ══════════
local L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L2_1 = game
L3_1 = L2_1
L2_1 = L2_1.GetService
L4_1 = "VirtualInputManager"
L2_1 = L2_1(L3_1, L4_1)
L3_1 = L2_1
L2_1 = L2_1.SendKeyEvent
L4_1 = true
L5_1 = A0_1
L6_1 = false
L7_1 = game
L2_1(L3_1, L4_1, L5_1, L6_1, L7_1)
L2_1 = wait
L3_1 = A1_1
L2_1(L3_1)
L2_1 = game
L3_1 = L2_1
L2_1 = L2_1.GetService
L4_1 = "VirtualInputManager"
L2_1 = L2_1(L3_1, L4_1)
L3_1 = L2_1
L2_1 = L2_1.SendKeyEvent
L4_1 = false
L5_1 = A0_1
L6_1 = false
L7_1 = game
L2_1(L3_1, L4_1, L5_1, L6_1, L7_1)

-- ══════════ main.p2 ══════════
local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1
L1_1 = game
L1_1 = L1_1.Players
L1_1 = L1_1.LocalPlayer
L1_1 = L1_1.Character
L1_1 = L1_1.PrimaryPart
L1_1 = L1_1.Position
L2_1 = pairs
L3_1 = game
L4_1 = L3_1
L3_1 = L3_1.GetService
L5_1 = "Workspace"
L3_1 = L3_1(L4_1, L5_1)
L3_1 = L3_1.WORKSPACE_Interactables
L3_1 = L3_1.Mining
L3_1 = L3_1.OreDeposits
L4_1 = L3_1
L3_1 = L3_1.GetDescendants
L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1 = L3_1(L4_1)
L2_1, L3_1, L4_1 = L2_1(L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1)
for L5_1, L6_1 in L2_1, L3_1, L4_1 do
  L7_1 = string
  L7_1 = L7_1.match
  L8_1 = L6_1.Name
  L9_1 = "Base"
  L7_1 = L7_1(L8_1, L9_1)
  if L7_1 then
    if L0_1 == nil then
      L0_1 = L6_1
    else
      L7_1 = L6_1.Position
      L7_1 = L1_1 - L7_1
      L7_1 = L7_1.magnitude
      L8_1 = L0_1.Position
      L8_1 = L8_1 - L1_1
      L8_1 = L8_1.magnitude
      if L7_1 < L8_1 then
        L0_1 = L6_1
      end
    end
  end
end

-- ══════════ main.p3 ══════════
-- PSEUDO (дизассемблер):
-- -- constants: 3 strings
-- 
-- -- function main  params=1 nups=1 lines=0..0
-- [   1] R1 = _ENV['tick']                          -- line -1
-- [   2] R1..R2 = R1()                              -- line -1
-- [   3] R2 = U0                                    -- line -1
-- [   4] R1 = R1 - R2                               -- line -1
-- [   5] if (R0 == 'h') ~= false then goto next+1   -- line -1
-- goto L13  (jump +7)
-- [   7] R2 = _ENV['math']                          -- line -1
-- [   8] R2 = R2['floor']                           -- line -1
-- [   9] R3 = R1 / 60                               -- line -1
-- [  10] R3 = R3 / 60                               -- line -1
-- [  11] R2..R3 = R2(R3)                            -- line -1
-- [  12] R2 = R2 % 60                               -- line -1
-- [  13] return ... R2                              -- line -1
-- [  14] if (R0 == 'm') ~= false then goto next+1   -- line -1
-- goto L21  (jump +6)
-- [  16] R2 = _ENV['math']                          -- line -1
-- [  17] R2 = R2['floor']                           -- line -1
-- [  18] R3 = R1 / 60                               -- line -1
-- [  19] R2..R3 = R2(R3)                            -- line -1
-- [  20] R2 = R2 % 60                               -- line -1
-- [  21] return ... R2                              -- line -1
-- [  22] if (R0 == 's') ~= false then goto next+1   -- line -1
-- goto L27  (jump +4)
-- [  24] R2 = _ENV['math']                          -- line -1
-- [  25] R2 = R2['floor']                           -- line -1
-- [  26] R3 = R1 % 60                               -- line -1
-- [  27] return R2(R3)                              -- line -1
-- [  28] return ...                                 -- line -1
-- 
-- -- ===== string constants =====
-- --   'floor'
-- --   'math'
-- --   'tick'

-- ══════════ main.p4 ══════════
local L1_1, L2_1, L3_1
L1_1 = A0_1.Name
if L1_1 == "ErrorPrompt" then
  L2_1 = A0_1
  L1_1 = A0_1.FindFirstChild
  L3_1 = "MessageArea"
  L1_1 = L1_1(L2_1, L3_1)
  if L1_1 then
    L1_1 = A0_1.MessageArea
    L2_1 = L1_1
    L1_1 = L1_1.FindFirstChild
    L3_1 = "ErrorFrame"
    L1_1 = L1_1(L2_1, L3_1)
    if L1_1 then
      L1_1 = print
      L2_1 = "ERRORPROMPT"
      L1_1(L2_1)
    end
  end
end

-- ══════════ main.p5 ══════════
-- PSEUDO (дизассемблер):
-- -- constants: 24 strings
-- 
-- -- function main  params=1 nups=5 lines=0..0
-- [   1] R1 = R0['KeyCode']                         -- line -1
-- [   2] R2 = _ENV['Enum']                          -- line -1
-- [   3] R2 = R2['KeyCode']                         -- line -1
-- [   4] R2 = R2['Return']                          -- line -1
-- [   5] if (R1 == R2) ~= false then goto next+1    -- line -1
-- goto L9  (jump +3)
-- [   7] R1 = _ENV['print']                         -- line -1
-- [   8] R2 = 'KeyCode ERROR'                       -- line -1
-- [   9] R1..R1 = R1(R2)                            -- line -1
-- [  10] R1 = R0['KeyCode']                         -- line -1
-- [  11] R2 = _ENV['Enum']                          -- line -1
-- [  12] R2 = R2['KeyCode']                         -- line -1
-- [  13] R2 = R2['F']                               -- line -1
-- [  14] if (R1 == R2) ~= false then goto next+1    -- line -1
-- goto L64  (jump +49)
-- [  16] R1 = _ENV['_G']                            -- line -1
-- [  17] R1 = R1['toping']                          -- line -1
-- _ENV['oldtoping'] = R1
-- [  19] R1 = _ENV['_G']                            -- line -1
-- [  20] R2 = _ENV['_G']                            -- line -1
-- [  21] R2 = R2['DiscordName']                     -- line -1
-- R1['toping'] = R2
-- [  23] R1 = _ENV['string']                        -- line -1
-- [  24] R1 = R1['gsub']                            -- line -1
-- [  25] R2 = _ENV['game']                          -- line -1
-- [  26] R2 = R2['Players']                         -- line -1
-- [  27] R2 = R2['LocalPlayer']                     -- line -1
-- [  28] R2 = R2['PlayerGui']                       -- line -1
-- [  29] R2 = R2['PlayerInfo']                      -- line -1
-- [  30] R2 = R2['StatBars']                        -- line -1
-- [  31] R2 = R2['PlayerDataFrame']                 -- line -1
-- [  32] R2 = R2['Bucks']                           -- line -1
-- [  33] R2 = R2['Text']                            -- line -1
-- [  34] R2 = R2['sub']; R3 = R2                    -- line -1
-- [  35] R4 = 2                                     -- line -1
-- [  36] R2..R3 = R2(R3, R4)                        -- line -1
-- [  37] R3 = ','                                   -- line -1
-- [  38] R4 = ''                                    -- line -1
-- [  39] R1..R2 = R1(R2, R3, R4)                    -- line -1
-- U0 = R1
-- [  41] R1 = _ENV['wait']                          -- line -1
-- [  42] R2 = 0.75                                  -- line -1
-- [  43] R1..R1 = R1(R2)                            -- line -1
-- [  44] R1 = _ENV['string']                        -- line -1
-- [  45] R1 = R1['gsub']                            -- line -1
-- [  46] R2 = _ENV['game']                          -- line -1
-- [  47] R2 = R2['Players']                         -- line -1
-- [  48] R2 = R2['LocalPlayer']                     -- line -1
-- [  49] R2 = R2['PlayerGui']                       -- line -1
-- [  50] R2 = R2['PlayerInfo']                      -- line -1
-- [  51] R2 = R2['StatBars']                        -- line -1
-- [  52] R2 = R2['PlayerDataFrame']                 -- line -1
-- [  53] R2 = R2['Bucks']                           -- line -1
-- [  54] R2 = R2['Text']                            -- line -1
-- [  55] R2 = R2['sub']; R3 = R2                    -- line -1
-- [  56] R4 = 2                                     -- line -1
-- [  57] R2..R3 = R2(R3, R4)                        -- line -1
-- [  58] R3 = ','                                   -- line -1
-- [  59] R4 = ''                                    -- line -1
-- [  60] R1..R2 = R1(R2, R3, R4)                    -- line -1
-- _ENV['Money'] = R1
-- [  62] R1 = _ENV['_G']                            -- line -1
-- [  63] R2 = _ENV['oldtoping']                     -- line -1
-- R1['toping'] = R2
-- [  65] R1 = R0['KeyCode']                         -- line -1
-- [  66] R2 = _ENV['Enum']                          -- line -1
-- [  67] R2 = R2['KeyCode']                         -- line -1
-- [  68] R2 = R2['F1']                              -- line -1
-- [  69] if (R1 == R2) ~= false then goto next+1    -- line -1
-- goto L88  (jump +18)
-- [  71] R1 = U1                                    -- line -1
-- [  72] R2 = 'Mining Stats'                        -- line -1
-- [  73] R3 = _ENV['string']                        -- line -1
-- [  74] R3 = R3['format']                          -- line -1
-- [  75] R4 = 'You have mined in total: %d.\nYou are in this server since: %dh %dm %ds.\nYou have earned a total of: %d$.\n' -- line -1
-- [  76] R5 = U2                                    -- line -1
-- [  77] R6 = U3                                    -- line -1
-- [  78] R7 = 'h'                                   -- line -1
-- [  79] R6..R7 = R6(R7)                            -- line -1
-- [  80] R7 = U3                                    -- line -1
-- [  81] R8 = 'm'                                   -- line -1
-- [  82] R7..R8 = R7(R8)                            -- line -1
-- [  83] R8 = U3                                    -- line -1
-- [  84] R9 = 's'                                   -- line -1
-- [  85] R8..R9 = R8(R9)                            -- line -1
-- [  86] R9 = U4                                    -- line -1
-- [  87] R3..R-1 = R3(R4, R5, R6, R7, R8, R9)       -- line -1
-- [  88] R1..R1 = R1()                              -- line -1
-- [  89] return ...                                 -- line -1
-- 
-- -- ===== string constants =====
-- --   'Bucks'
-- --   'DiscordName'
-- --   'Enum'
-- --   'KeyCode'
-- --   'KeyCode ERROR'
-- --   'LocalPlayer'
-- --   'Mining Stats'
-- --   'Money'
-- --   'PlayerDataFrame'
-- --   'PlayerGui'
-- --   'PlayerInfo'
-- --   'Players'
-- --   'Return'
-- --   'StatBars'
-- --   'Text'
-- --   'You have mined in total: %d.\nYou are in this server since: %dh %dm %ds.\nYou have earned a total of: %d$.\n'
-- --   'format'
-- --   'game'
-- --   'gsub'
-- --   'oldtoping'
-- --   'print'
-- --   'string'
-- --   'toping'
-- --   'wait'

-- ══════════ main.p6 ══════════
local L0_1, L1_1
L0_1 = game
L0_1 = L0_1.Players
L0_1 = L0_1.LocalPlayer
L0_1 = L0_1.PlayerGui
L0_1 = L0_1.InventoryUI
L0_1 = L0_1.Inventory
L0_1 = L0_1.Container
L0_1 = L0_1.BottomBar
L0_1 = L0_1.Body
L0_1 = L0_1.NumSlots
L0_1 = L0_1.Text
L0_1 = L0_1 == "30 / 30"

-- ══════════ main.p7 ══════════
-- PSEUDO (дизассемблер):
-- -- constants: 32 strings
-- 
-- -- function main  params=0 nups=2 lines=0..0
-- [   1] R0 = _ENV['game']                          -- line -1
-- [   2] R0 = R0['Players']                         -- line -1
-- [   3] R0 = R0['LocalPlayer']                     -- line -1
-- [   4] R0 = R0['PlayerGui']                       -- line -1
-- [   5] R0 = R0['Prompts']                         -- line -1
-- [   6] R0 = R0['ActionBindsFeed']                 -- line -1
-- [   7] R0 = R0['Respawn']                         -- line -1
-- [   8] R0 = R0['Visible']                         -- line -1
-- [   9] if R0 == false then goto next+1            -- line -1
-- ::L9::
-- goto L24  (jump +14)
-- [  11] R0 = _ENV['respawnVisible']                -- line -1
-- [  12] if (R0 == true) ~= false then goto next+1  -- line -1
-- goto L21  (jump +8)
-- [  14] R0 = _ENV['print']                         -- line -1
-- [  15] R1 = 'You died'                            -- line -1
-- [  16] R0..R0 = R0(R1)                            -- line -1
-- [  17] R0 = false                                 -- line -1
-- _ENV['respawnVisible'] = R0
-- [  19] R0 = U0                                    -- line -1
-- [  20] R0..R0 = R0()                              -- line -1
-- goto L24  (jump +3)
-- [  22] R0 = _ENV['print']                         -- line -1
-- [  23] R1 = 'Error'                               -- line -1
-- [  24] R0..R0 = R0(R1)                            -- line -1
-- [  25] R0 = _ENV['game']                          -- line -1
-- [  26] R0 = R0['Players']                         -- line -1
-- [  27] R0 = R0['LocalPlayer']                     -- line -1
-- [  28] R0 = R0['PlayerGui']                       -- line -1
-- [  29] R0 = R0['Prompts']                         -- line -1
-- [  30] R0 = R0['ActionBindsFeed']                 -- line -1
-- [  31] R0 = R0['Respawn']                         -- line -1
-- [  32] R0 = R0['Visible']                         -- line -1
-- [  33] if R0 == true then goto next+1             -- line -1
-- goto L36  (jump +2)
-- ::L34::
-- [  35] R0 = true                                  -- line -1
-- _ENV['respawnVisible'] = R0
-- [  37] R0 = _ENV['game']                          -- line -1
-- [  38] R0 = R0['Players']                         -- line -1
-- [  39] R0 = R0['LocalPlayer']                     -- line -1
-- [  40] R0 = R0['PlayerGui']                       -- line -1
-- [  41] R0 = R0['Hotbar']                          -- line -1
-- [  42] R0 = R0['HotBar']                          -- line -1
-- [  43] R0 = R0['Container']                       -- line -1
-- [  44] R0 = R0['HotbarList']                      -- line -1
-- [  45] R0 = R0['Body']                            -- line -1
-- [  46] R0 = R0['HotbarSlot_Utility_1']            -- line -1
-- [  47] R0 = R0['Container']                       -- line -1
-- [  48] R0 = R0['Slot']                            -- line -1
-- [  49] R0 = R0['Stroke_3px']                      -- line -1
-- [  50] R0 = R0['ImageColor3']                     -- line -1
-- [  51] R1 = _ENV['Color3']                        -- line -1
-- [  52] R1 = R1['fromRGB']                         -- line -1
-- [  53] R2 = 255                                   -- line -1
-- [  54] R3 = 255                                   -- line -1
-- [  55] R4 = 255                                   -- line -1
-- [  56] R1..R2 = R1(R2, R3, R4)                    -- line -1
-- [  57] if (R0 == R1) ~= true then goto next+1     -- line -1
-- goto L64  (jump +6)
-- ::L58::
-- [  59] R0 = U1                                    -- line -1
-- [  60] R1 = _ENV['Enum']                          -- line -1
-- [  61] R1 = R1['KeyCode']                         -- line -1
-- [  62] R1 = R1['Four']                            -- line -1
-- [  63] R2 = 0                                     -- line -1
-- [  64] R0..R0 = R0(R1, R2)                        -- line -1
-- [  65] R0 = _ENV['game']                          -- line -1
-- [  66] R0 = R0['Players']                         -- line -1
-- [  67] R0 = R0['LocalPlayer']                     -- line -1
-- [  68] R0 = R0['PlayerGui']                       -- line -1
-- [  69] R0 = R0['InventoryUI']                     -- line -1
-- [  70] R0 = R0['Enabled']                         -- line -1
-- [  71] if R0 == true then goto next+1             -- line -1
-- goto L78  (jump +6)
-- ::L72::
-- [  73] R0 = U1                                    -- line -1
-- [  74] R1 = _ENV['Enum']                          -- line -1
-- [  75] R1 = R1['KeyCode']                         -- line -1
-- [  76] R1 = R1['B']                               -- line -1
-- [  77] R2 = 0                                     -- line -1
-- [  78] R0..R0 = R0(R1, R2)                        -- line -1
-- [  79] R0 = _ENV['game']                          -- line -1
-- [  80] R0 = R0['Players']                         -- line -1
-- [  81] R0 = R0['LocalPlayer']                     -- line -1
-- [  82] R0 = R0['PlayerGui']                       -- line -1
-- [  83] R0 = R0['Prompts']                         -- line -1
-- [  84] R0 = R0['ActionBindsFeed']                 -- line -1
-- [  85] R0 = R0['GetUp']                           -- line -1
-- [  86] R0 = R0['Visible']                         -- line -1
-- [  87] if R0 == false then goto next+1            -- line -1
-- ::L87::
-- goto L94  (jump +6)
-- [  89] R0 = U1                                    -- line -1
-- [  90] R1 = _ENV['Enum']                          -- line -1
-- [  91] R1 = R1['KeyCode']                         -- line -1
-- [  92] R1 = R1['E']                               -- line -1
-- [  93] R2 = 0                                     -- line -1
-- [  94] R0..R0 = R0(R1, R2)                        -- line -1
-- [  95] R0 = _ENV['game']                          -- line -1
-- [  96] R0 = R0['GetService']; R1 = R0             -- line -1
-- [  97] R2 = 'Players'                             -- line -1
-- [  98] R0..R1 = R0(R1, R2)                        -- line -1
-- [  99] R0 = R0['LocalPlayer']                     -- line -1
-- [ 100] R0 = R0['PlayerGui']                       -- line -1
-- [ 101] R0 = R0['Prompts']                         -- line -1
-- [ 102] R0 = R0['ActionBindsFeed']                 -- line -1
-- [ 103] R0 = R0['BreakFree']                       -- line -1
-- [ 104] R0 = R0['Visible']                         -- line -1
-- [ 105] if R0 == false then goto next+1            -- line -1
-- ::L105::
-- goto L109  (jump +3)
-- [ 107] R0 = _ENV['print']                         -- line -1
-- [ 108] R1 = 'LASSO'                               -- line -1
-- [ 109] R0..R0 = R0(R1)                            -- line -1
-- [ 110] return ...                                 -- line -1
-- 
-- -- ===== string constants =====
-- --   'ActionBindsFeed'
-- --   'Body'
-- --   'BreakFree'
-- --   'Color3'
-- --   'Container'
-- --   'Enabled'
-- --   'Enum'
-- --   'Error'
-- --   'Four'
-- --   'GetService'
-- --   'GetUp'
-- --   'HotBar'
-- --   'Hotbar'
-- --   'HotbarList'
-- --   'HotbarSlot_Utility_1'
-- --   'ImageColor3'
-- --   'InventoryUI'
-- --   'KeyCode'
-- --   'LASSO'
-- --   'LocalPlayer'
-- --   'PlayerGui'
-- --   'Players'
-- --   'Prompts'
-- --   'Respawn'
-- --   'Slot'
-- --   'Stroke_3px'
-- --   'Visible'
-- --   'You died'
-- --   'fromRGB'
-- --   'game'
-- --   'print'
-- --   'respawnVisible'

-- ══════════ main.p8.p0 ══════════
-- PSEUDO (дизассемблер):
-- -- constants: 7 strings
-- 
-- -- function main  params=0 nups=1 lines=0..0
-- [   1] R0 = _ENV['game']                          -- line -1
-- [   2] R0 = R0['Players']                         -- line -1
-- [   3] R0 = R0['LocalPlayer']                     -- line -1
-- [   4] R0 = R0['PlayerGui']                       -- line -1
-- [   5] R0 = R0['ConfirmPopup']                    -- line -1
-- R0['Enabled'] = R1
-- [   7] R0 = U0                                    -- line -1
-- [   8] R0 = R0['Destroy']; R1 = R0                -- line -1
-- [   9] R0..R0 = R0(R1)                            -- line -1
-- [  10] return ...                                 -- line -1
-- 
-- -- ===== string constants =====
-- --   'ConfirmPopup'
-- --   'Destroy'
-- --   'Enabled'
-- --   'LocalPlayer'
-- --   'PlayerGui'
-- --   'Players'
-- --   'game'

-- ══════════ main.p8 ══════════
local L2_1, L3_1, L4_1, L5_1
L2_1 = game
L2_1 = L2_1.Players
L2_1 = L2_1.LocalPlayer
L2_1 = L2_1.PlayerGui
L2_1 = L2_1.ConfirmPopup
L3_1 = L2_1
L2_1 = L2_1.FindFirstChild
L4_1 = A0_1
L2_1 = L2_1(L3_1, L4_1)
if not L2_1 then
  L2_1 = game
  L2_1 = L2_1.Players
  L2_1 = L2_1.LocalPlayer
  L2_1 = L2_1.PlayerGui
  L2_1 = L2_1.ConfirmPopup
  L2_1.Enabled = true
  L2_1 = game
  L2_1 = L2_1.Players
  L2_1 = L2_1.LocalPlayer
  L2_1 = L2_1.PlayerGui
  L2_1 = L2_1.ConfirmPopup
  L2_1 = L2_1.ConfirmPopup
  L3_1 = L2_1
  L2_1 = L2_1.Clone
  L2_1 = L2_1(L3_1)
  L3_1 = game
  L3_1 = L3_1.Players
  L3_1 = L3_1.LocalPlayer
  L3_1 = L3_1.PlayerGui
  L3_1 = L3_1.ConfirmPopup
  L2_1.Parent = L3_1
  L2_1.Name = A0_1
  L3_1 = L2_1.Container
  L3_1 = L3_1.TopBar
  L3_1 = L3_1.Header
  L3_1 = L3_1.TopTitleText
  L3_1.Text = A0_1
  L3_1 = L2_1.Container
  L3_1 = L3_1.Body
  L3_1 = L3_1.Page
  L3_1 = L3_1.Contents
  L3_1 = L3_1.BodyText
  L4_1 = tostring
  L5_1 = A1_1
  L4_1 = L4_1(L5_1)
  L3_1.Text = L4_1
  L3_1 = L2_1.Container
  L3_1 = L3_1.Body
  L3_1 = L3_1.Page
  L3_1 = L3_1.AcceptButton
  L3_1 = L3_1.MouseButton1Down
  L4_1 = L3_1
  L3_1 = L3_1.Connect
  
  function L5_1()
    local L0_2, L1_2
    L0_2 = game
    L0_2 = L0_2.Players
    L0_2 = L0_2.LocalPlayer
    L0_2 = L0_2.PlayerGui
    L0_2 = L0_2.ConfirmPopup
    L0_2.Enabled = false
    L0_2 = L2_1
    L1_2 = L0_2
    L0_2 = L0_2.Destroy
    L0_2(L1_2)
  end
  
  L3_1(L4_1, L5_1)
  L2_1.Visible = true
else
  L2_1 = Popup
  L2_1 = L2_1.Container
  L2_1 = L2_1.Body
  L2_1 = L2_1.Page
  L2_1 = L2_1.Contents
  L2_1 = L2_1.BodyText
  L3_1 = tostring
  L4_1 = A1_1
  L3_1 = L3_1(L4_1)
  L2_1.Text = L3_1
end

-- ══════════ main.p9 ══════════
local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1
L0_1 = Serverswitchgrund
if L0_1 == true then
  L0_1 = wait
  L1_1 = 1
  L0_1(L1_1)
  L0_1 = game
  L0_1 = L0_1.HttpService
  L1_1 = L0_1
  L0_1 = L0_1.JSONDecode
  L2_1 = game
  L3_1 = L2_1
  L2_1 = L2_1.HttpGet
  L4_1 = "https://games.roblox.com/v1/games/2317712696/servers/Public?sortOrder=Asc&limit=100"
  L2_1, L3_1, L4_1, L5_1 = L2_1(L3_1, L4_1)
  L0_1 = L0_1(L1_1, L2_1, L3_1, L4_1, L5_1)
  L1_1 = L0_1.data
  L2_1 = math
  L2_1 = L2_1.random
  L3_1 = 1
  L4_1 = L0_1.data
  L4_1 = #L4_1
  L2_1 = L2_1(L3_1, L4_1)
  L1_1 = L1_1[L2_1]
  repeat
    L2_1 = L1_1.playing
    L3_1 = L1_1.maxPlayers
  until L2_1 ~= L3_1
  L2_1 = game
  L3_1 = L2_1
  L2_1 = L2_1.GetService
  L4_1 = "TeleportService"
  L2_1 = L2_1(L3_1, L4_1)
  L3_1 = L2_1
  L2_1 = L2_1.TeleportToPlaceInstance
  L4_1 = game
  L4_1 = L4_1.PlaceId
  L5_1 = L1_1.id
  L2_1(L3_1, L4_1, L5_1)
else
  L0_1 = ondeathgrind
  if L0_1 == true then
    L0_1 = wait
    L1_1 = 8
    L0_1(L1_1)
    L0_1 = game
    L1_1 = L0_1
    L0_1 = L0_1.GetService
    L2_1 = "VirtualInputManager"
    L0_1 = L0_1(L1_1, L2_1)
    L1_1 = L0_1
    L0_1 = L0_1.SendKeyEvent
    L2_1 = true
    L3_1 = Enum
    L3_1 = L3_1.KeyCode
    L3_1 = L3_1.E
    L4_1 = false
    L5_1 = game
    L0_1(L1_1, L2_1, L3_1, L4_1, L5_1)
    L0_1 = game
    L1_1 = L0_1
    L0_1 = L0_1.GetService
    L2_1 = "ReplicatedStorage"
    L0_1 = L0_1(L1_1, L2_1)
    L0_1 = L0_1.Communication
    L0_1 = L0_1.Functions
    L0_1 = L0_1.Respawn
    L1_1 = L0_1
    L0_1 = L0_1.InvokeServer
    L2_1 = "Bronze"
    L0_1(L1_1, L2_1)
    L0_1 = startnew
    L0_1()
  else
    L0_1 = print
    L1_1 = "Stoped autofarm"
    L0_1(L1_1)
  end
end

-- ══════════ main.p10 ══════════
local L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "VirtualInputManager"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = L1_1
L1_1 = L1_1.SendKeyEvent
L3_1 = true
L4_1 = Enum
L4_1 = L4_1.KeyCode
L4_1 = L4_1.Y
L5_1 = false
L6_1 = game
L1_1(L2_1, L3_1, L4_1, L5_1, L6_1)
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "VirtualInputManager"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = L1_1
L1_1 = L1_1.SendKeyEvent
L3_1 = false
L4_1 = Enum
L4_1 = L4_1.KeyCode
L4_1 = L4_1.Y
L5_1 = false
L6_1 = game
L1_1(L2_1, L3_1, L4_1, L5_1, L6_1)
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "VirtualInputManager"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = L1_1
L1_1 = L1_1.SendKeyEvent
L3_1 = true
L4_1 = Enum
L4_1 = L4_1.KeyCode
L4_1 = L4_1.Nine
L5_1 = false
L6_1 = game
L1_1(L2_1, L3_1, L4_1, L5_1, L6_1)
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "VirtualInputManager"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = L1_1
L1_1 = L1_1.SendKeyEvent
L3_1 = false
L4_1 = Enum
L4_1 = L4_1.KeyCode
L4_1 = L4_1.Nine
L5_1 = false
L6_1 = game
L1_1(L2_1, L3_1, L4_1, L5_1, L6_1)
L1_1 = game
L2_1 = L1_1
L1_1 = L1_1.GetService
L3_1 = "PathfindingService"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = game
L2_1 = L2_1.Players
L2_1 = L2_1.LocalPlayer
L2_1 = L2_1.Character
L3_1 = L2_1
L2_1 = L2_1.WaitForChild
L4_1 = "Humanoid"
L2_1 = L2_1(L3_1, L4_1)
L3_1 = game
L3_1 = L3_1.Players
L3_1 = L3_1.LocalPlayer
L3_1 = L3_1.Character
L4_1 = L3_1
L3_1 = L3_1.WaitForChild
L5_1 = "LowerTorso"
L3_1 = L3_1(L4_1, L5_1)
L5_1 = L1_1
L4_1 = L1_1.CreatePath
L6_1 = {}
L6_1.AgentCanClimb = true
L6_1.AgentCanJump = true
L4_1 = L4_1(L5_1, L6_1)
L6_1 = L4_1
L5_1 = L4_1.ComputeAsync
L7_1 = L3_1.Position
L8_1 = A0_1
L5_1(L6_1, L7_1, L8_1)
L6_1 = L4_1
L5_1 = L4_1.GetWaypoints
L5_1 = L5_1(L6_1)
L6_1 = pairs
L7_1 = L5_1
L6_1, L7_1, L8_1 = L6_1(L7_1)
for L9_1, L10_1 in L6_1, L7_1, L8_1 do
  L11_1 = L10_1.Action
  L12_1 = Enum
  L12_1 = L12_1.PathWaypointAction
  L12_1 = L12_1.Jump
  if L11_1 == L12_1 then
    L12_1 = L2_1
    L11_1 = L2_1.ChangeState
    L13_1 = Enum
    L13_1 = L13_1.HumanoidStateType
    L13_1 = L13_1.Jumping
    L11_1(L12_1, L13_1)
  end
  L12_1 = L2_1
  L11_1 = L2_1.MoveTo
  L13_1 = L10_1.Position
  L11_1(L12_1, L13_1)
  L11_1 = L2_1.MoveToFinished
  L12_1 = L11_1
  L11_1 = L11_1.Wait
  L11_1(L12_1)
end
L6_1 = game
L7_1 = L6_1
L6_1 = L6_1.GetService
L8_1 = "VirtualInputManager"
L6_1 = L6_1(L7_1, L8_1)
L7_1 = L6_1
L6_1 = L6_1.SendKeyEvent
L8_1 = true
L9_1 = Enum
L9_1 = L9_1.KeyCode
L9_1 = L9_1.Y
L10_1 = false
L11_1 = game
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = game
L7_1 = L6_1
L6_1 = L6_1.GetService
L8_1 = "VirtualInputManager"
L6_1 = L6_1(L7_1, L8_1)
L7_1 = L6_1
L6_1 = L6_1.SendKeyEvent
L8_1 = false
L9_1 = Enum
L9_1 = L9_1.KeyCode
L9_1 = L9_1.Y
L10_1 = false
L11_1 = game
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = game
L7_1 = L6_1
L6_1 = L6_1.GetService
L8_1 = "VirtualInputManager"
L6_1 = L6_1(L7_1, L8_1)
L7_1 = L6_1
L6_1 = L6_1.SendKeyEvent
L8_1 = true
L9_1 = Enum
L9_1 = L9_1.KeyCode
L9_1 = L9_1.Nine
L10_1 = false
L11_1 = game
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = game
L7_1 = L6_1
L6_1 = L6_1.GetService
L8_1 = "VirtualInputManager"
L6_1 = L6_1(L7_1, L8_1)
L7_1 = L6_1
L6_1 = L6_1.SendKeyEvent
L8_1 = false
L9_1 = Enum
L9_1 = L9_1.KeyCode
L9_1 = L9_1.Nine
L10_1 = false
L11_1 = game
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)

-- ══════════ main ══════════
-- PSEUDO (дизассемблер):
-- -- constants: 174 strings
-- 
-- -- function main  params=0 nups=0 lines=0..0
-- [   1] R0 = _ENV['game']                          -- line -1
-- [   2] R0 = R0['GetService']; R1 = R0             -- line -1
-- [   3] R2 = 'VirtualInputManager'                 -- line -1
-- [   4] R0..R1 = R0(R1, R2)                        -- line -1
-- [   5] R0 = R0['SendKeyEvent']; R1 = R0           -- line -1
-- [   6] R2 = false                                 -- line -1
-- [   7] R3 = _ENV['Enum']                          -- line -1
-- [   8] R3 = R3['KeyCode']                         -- line -1
-- [   9] R3 = R3['C']                               -- line -1
-- [  10] R4 = false                                 -- line -1
-- [  11] R5 = _ENV['game']                          -- line -1
-- [  12] R0..R0 = R0(R1, R2, R3, R4, R5)            -- line -1
-- [  13] R0 = _ENV['wait']                          -- line -1
-- [  14] R1 = 5                                     -- line -1
-- [  15] R0..R0 = R0(R1)                            -- line -1
-- [  16] R0 = _ENV['_G']                            -- line -1
-- [  17] R0 = R0['WalkSpeed']                       -- line -1
-- [  18] if R0 == true then goto next+1             -- line -1
-- goto L21  (jump +2)
-- ::L19::
-- [  20] R0 = _ENV['_G']                            -- line -1
-- R0['WalkSpeed'] = R1
-- [  22] R0 = _ENV['_G']                            -- line -1
-- [  23] R0 = R0['MineTime']                        -- line -1
-- [  24] if R0 == true then goto next+1             -- line -1
-- goto L27  (jump +2)
-- ::L25::
-- [  26] R0 = _ENV['_G']                            -- line -1
-- R0['MineTime'] = R1
-- [  28] R0 = _ENV['game']                          -- line -1
-- [  29] R0 = R0['Players']                         -- line -1
-- [  30] R0 = R0['LocalPlayer']                     -- line -1
-- [  31] R1 = 1                                     -- line -1
-- [  32] R2 = _ENV['_G']                            -- line -1
-- [  33] R3 = {} size:array=0 hash=5                -- line -1
-- [  34] R4 = '1251.61, 2.02644, -1222.52'          -- line -1
-- [  35] R5 = '1260.56, 0.64796, -1183.46'          -- line -1
-- [  36] R6 = '1230.74, -8.29322, -1133.89'         -- line -1
-- [  37] R7 = '1220.09, -5.76381, -1125.53'         -- line -1
-- [  38] R8 = '1264.35, -24.20690, -1053.62'        -- line -1
-- R3[R1..R5] = R4
-- R2['MineralPosition'] = R3
-- [  41] R2 = _ENV['game']                          -- line -1
-- [  42] R2 = R2['GetService']; R3 = R2             -- line -1
-- [  43] R4 = 'RunService'                          -- line -1
-- [  44] R2..R3 = R2(R3, R4)                        -- line -1
-- [  45] R3 = _ENV['game']                          -- line -1
-- [  46] R3 = R3['Players']                         -- line -1
-- [  47] R3 = R3['LocalPlayer']                     -- line -1
-- [  48] R3 = R3['PlayerGui']                       -- line -1
-- [  49] R3 = R3['FindFirstChild']; R4 = R3         -- line -1
-- [  50] R5 = 'LoadingGate'                         -- line -1
-- [  51] R3..R4 = R3(R4, R5)                        -- line -1
-- [  52] if R3 == false then goto next+1            -- line -1
-- ::L52::
-- goto L56  (jump +3)
-- [  54] R3 = _ENV['wait']                          -- line -1
-- [  55] R3..R3 = R3()                              -- line -1
-- goto L44  (jump -12)
-- [  57] R3 = _ENV['game']                          -- line -1
-- [  58] R3 = R3['GetService']; R4 = R3             -- line -1
-- [  59] R5 = 'ReplicatedStorage'                   -- line -1
-- [  60] R3..R4 = R3(R4, R5)                        -- line -1
-- [  61] R3 = R3['Communication']                   -- line -1
-- [  62] R3 = R3['Functions']                       -- line -1
-- [  63] R3 = R3['Respawn']                         -- line -1
-- [  64] R3 = R3['InvokeServer']; R4 = R3           -- line -1
-- [  65] R5 = 'Bronze'                              -- line -1
-- [  66] R3..R3 = R3(R4, R5)                        -- line -1
-- [  67] R3 = R0['Character']                       -- line -1
-- [  68] R3 = R3['Humanoid']                        -- line -1
-- [  69] R3 = R3['Changed']                         -- line -1
-- [  70] R3 = R3['Connect']; R4 = R3                -- line -1
-- [  71] R5 = closure(proto 0)                      -- line -1
-- [  72] R0 = R0                                    -- line -1
-- [  73] R3..R3 = R3(R4, R5)                        -- line -1
-- [  74] R3 = 1                                     -- line -1
-- _ENV['i'] = R3
-- [  76] R3 = closure(proto 8)                      -- line -1
-- [  77] R4 = closure(proto 1)                      -- line -1
-- [  78] R5 = closure(proto 10)                     -- line -1
-- [  79] R6 = closure(proto 6)                      -- line -1
-- [  80] R7 = closure(proto 2)                      -- line -1
-- [  81] R8 = _ENV['Instance']                      -- line -1
-- [  82] R8 = R8['new']                             -- line -1
-- [  83] R9 = 'Part'                                -- line -1
-- [  84] R8..R9 = R8(R9)                            -- line -1
-- R8['Transparency'] = R9
-- R8['Anchored'] = R9
-- R8['Material'] = R9
-- [  88] R9 = _ENV['Vector3']                       -- line -1
-- [  89] R9 = R9['new']                             -- line -1
-- [  90] R10 = 125                                  -- line -1
-- [  91] R11 = 1                                    -- line -1
-- [  92] R12 = 75                                   -- line -1
-- [  93] R9..R10 = R9(R10, R11, R12)                -- line -1
-- R8['Size'] = R9
-- [  95] R9 = _ENV['Vector3']                       -- line -1
-- [  96] R9 = R9['new']                             -- line -1
-- [  97] R10 = 1149.29                              -- line -1
-- [  98] R11 = -4                                   -- line -1
-- [  99] R12 = -1210.1                              -- line -1
-- [ 100] R9..R10 = R9(R10, R11, R12)                -- line -1
-- R8['Position'] = R9
-- [ 102] R9 = _ENV['game']                          -- line -1
-- [ 103] R9 = R9['Workspace']                       -- line -1
-- R8['Parent'] = R9
-- [ 105] R9 = _ENV['Instance']                      -- line -1
-- [ 106] R9 = R9['new']                             -- line -1
-- [ 107] R10 = 'Part'                               -- line -1
-- [ 108] R9..R10 = R9(R10)                          -- line -1
-- R9['Transparency'] = R10
-- R9['Anchored'] = R10
-- R9['Material'] = R10
-- [ 112] R10 = _ENV['Vector3']                      -- line -1
-- [ 113] R10 = R10['new']                           -- line -1
-- [ 114] R11 = 100                                  -- line -1
-- [ 115] R12 = 1                                    -- line -1
-- [ 116] R13 = 75                                   -- line -1
-- [ 117] R10..R11 = R10(R11, R12, R13)              -- line -1
-- R9['Size'] = R10
-- [ 119] R10 = _ENV['Vector3']                      -- line -1
-- [ 120] R10 = R10['new']                           -- line -1
-- [ 121] R11 = 1175                                 -- line -1
-- [ 122] R12 = -17.392                              -- line -1
-- [ 123] R13 = -1110                                -- line -1
-- [ 124] R10..R11 = R10(R11, R12, R13)              -- line -1
-- R9['Position'] = R10
-- [ 126] R10 = _ENV['game']                         -- line -1
-- [ 127] R10 = R10['Workspace']                     -- line -1
-- R9['Parent'] = R10
-- [ 129] R10 = _ENV['Instance']                     -- line -1
-- [ 130] R10 = R10['new']                           -- line -1
-- [ 131] R11 = 'Part'                               -- line -1
-- [ 132] R10..R11 = R10(R11)                        -- line -1
-- R10['Transparency'] = R11
-- R10['Anchored'] = R11
-- R10['Material'] = R11
-- [ 136] R11 = _ENV['Vector3']                      -- line -1
-- [ 137] R11 = R11['new']                           -- line -1
-- [ 138] R12 = 40                                   -- line -1
-- [ 139] R13 = 1                                    -- line -1
-- [ 140] R14 = 45                                   -- line -1
-- [ 141] R11..R12 = R11(R12, R13, R14)              -- line -1
-- R10['Size'] = R11
-- [ 143] R11 = _ENV['Vector3']                      -- line -1
-- [ 144] R11 = R11['new']                           -- line -1
-- [ 145] R12 = 20                                   -- line -1
-- [ 146] R13 = 0                                    -- line -1
-- [ 147] R14 = 0                                    -- line -1
-- [ 148] R11..R12 = R11(R12, R13, R14)              -- line -1
-- R10['Rotation'] = R11
-- [ 150] R11 = _ENV['Vector3']                      -- line -1
-- [ 151] R11 = R11['new']                           -- line -1
-- [ 152] R12 = 1190.29                              -- line -1
-- [ 153] R13 = -12                                  -- line -1
-- [ 154] R14 = -1152.1                              -- line -1
-- [ 155] R11..R12 = R11(R12, R13, R14)              -- line -1
-- R10['Position'] = R11
-- [ 157] R11 = _ENV['game']                         -- line -1
-- [ 158] R11 = R11['Workspace']                     -- line -1
-- R10['Parent'] = R11
-- [ 160] R11 = _ENV['Instance']                     -- line -1
-- [ 161] R11 = R11['new']                           -- line -1
-- [ 162] R12 = 'Part'                               -- line -1
-- [ 163] R11..R12 = R11(R12)                        -- line -1
-- R11['Transparency'] = R12
-- R11['Anchored'] = R12
-- R11['Material'] = R12
-- [ 167] R12 = _ENV['Vector3']                      -- line -1
-- [ 168] R12 = R12['new']                           -- line -1
-- [ 169] R13 = 5                                    -- line -1
-- [ 170] R14 = 25                                   -- line -1
-- [ 171] R15 = 5                                    -- line -1
-- [ 172] R12..R13 = R12(R13, R14, R15)              -- line -1
-- R11['Size'] = R12
-- [ 174] R12 = _ENV['Vector3']                      -- line -1
-- [ 175] R12 = R12['new']                           -- line -1
-- [ 176] R13 = 1273.45                              -- line -1
-- [ 177] R14 = 8.29245                              -- line -1
-- [ 178] R15 = -1142.2                              -- line -1
-- [ 179] R12..R13 = R12(R13, R14, R15)              -- line -1
-- R11['Position'] = R12
-- [ 181] R12 = _ENV['game']                         -- line -1
-- [ 182] R12 = R12['Workspace']                     -- line -1
-- R11['Parent'] = R12
-- [ 184] R12 = _ENV['Instance']                     -- line -1
-- [ 185] R12 = R12['new']                           -- line -1
-- [ 186] R13 = 'Part'                               -- line -1
-- [ 187] R12..R13 = R12(R13)                        -- line -1
-- R12['Transparency'] = R13
-- R12['Anchored'] = R13
-- R12['Material'] = R13
-- [ 191] R13 = _ENV['Vector3']                      -- line -1
-- [ 192] R13 = R13['new']                           -- line -1
-- [ 193] R14 = 5                                    -- line -1
-- [ 194] R15 = 25                                   -- line -1
-- [ 195] R16 = 5                                    -- line -1
-- [ 196] R13..R14 = R13(R14, R15, R16)              -- line -1
-- R12['Size'] = R13
-- [ 198] R13 = _ENV['Vector3']                      -- line -1
-- [ 199] R13 = R13['new']                           -- line -1
-- [ 200] R14 = 1254.01                              -- line -1
-- [ 201] R15 = 10.0479                              -- line -1
-- [ 202] R16 = -1178.42                             -- line -1
-- [ 203] R13..R14 = R13(R14, R15, R16)              -- line -1
-- R12['Position'] = R13
-- [ 205] R13 = _ENV['game']                         -- line -1
-- [ 206] R13 = R13['Workspace']                     -- line -1
-- R12['Parent'] = R13
-- [ 208] R13 = _ENV['Instance']                     -- line -1
-- [ 209] R13 = R13['new']                           -- line -1
-- [ 210] R14 = 'Part'                               -- line -1
-- [ 211] R13..R14 = R13(R14)                        -- line -1
-- R13['Transparency'] = R14
-- R13['Anchored'] = R14
-- R13['Material'] = R14
-- [ 215] R14 = _ENV['Color3']                       -- line -1
-- [ 216] R14 = R14['fromRGB']                       -- line -1
-- [ 217] R15 = 106                                  -- line -1
-- [ 218] R16 = 165                                  -- line -1
-- [ 219] R17 = 102                                  -- line -1
-- [ 220] R14..R15 = R14(R15, R16, R17)              -- line -1
-- R13['Color'] = R14
-- [ 222] R14 = _ENV['Vector3']                      -- line -1
-- [ 223] R14 = R14['new']                           -- line -1
-- [ 224] R15 = 26                                   -- line -1
-- [ 225] R16 = 0.5                                  -- line -1
-- [ 226] R17 = 15                                   -- line -1
-- [ 227] R14..R15 = R14(R15, R16, R17)              -- line -1
-- R13['Size'] = R14
-- [ 229] R14 = _ENV['Vector3']                      -- line -1
-- [ 230] R14 = R14['new']                           -- line -1
-- [ 231] R15 = 20                                   -- line -1
-- [ 232] R16 = 0                                    -- line -1
-- [ 233] R17 = 0                                    -- line -1
-- [ 234] R14..R15 = R14(R15, R16, R17)              -- line -1
-- R13['Rotation'] = R14
-- [ 236] R14 = _ENV['Vector3']                      -- line -1
-- [ 237] R14 = R14['new']                           -- line -1
-- [ 238] R15 = 1189.79                              -- line -1
-- [ 239] R16 = -12.321                              -- line -1
-- [ 240] R17 = -1149.025                            -- line -1
-- [ 241] R14..R15 = R14(R15, R16, R17)              -- line -1
-- R13['Position'] = R14
-- [ 243] R14 = _ENV['game']                         -- line -1
-- [ 244] R14 = R14['Workspace']                     -- line -1
-- R13['Parent'] = R14
-- [ 246] R14 = _ENV['Instance']                     -- line -1
-- [ 247] R14 = R14['new']                           -- line -1
-- [ 248] R15 = 'Part'                               -- line -1
-- [ 249] R14..R15 = R14(R15)                        -- line -1
-- R14['Transparency'] = R15
-- R14['Anchored'] = R15
-- R14['Material'] = R15
-- [ 253] R15 = _ENV['Color3']                       -- line -1
-- [ 254] R15 = R15['fromRGB']                       -- line -1
-- [ 255] R16 = 106                                  -- line -1
-- [ 256] R17 = 165                                  -- line -1
-- [ 257] R18 = 102                                  -- line -1
-- [ 258] R15..R16 = R15(R16, R17, R18)              -- line -1
-- R14['Color'] = R15
-- [ 260] R15 = _ENV['Vector3']                      -- line -1
-- [ 261] R15 = R15['new']                           -- line -1
-- [ 262] R16 = 12.75                                -- line -1
-- [ 263] R17 = 3.25                                 -- line -1
-- [ 264] R18 = 27.25                                -- line -1
-- [ 265] R15..R16 = R15(R16, R17, R18)              -- line -1
-- R14['Size'] = R15
-- [ 267] R15 = _ENV['Vector3']                      -- line -1
-- [ 268] R15 = R15['new']                           -- line -1
-- [ 269] R16 = 1215.885                             -- line -1
-- [ 270] R17 = -11.327                              -- line -1
-- [ 271] R18 = -1138.045                            -- line -1
-- [ 272] R15..R16 = R15(R16, R17, R18)              -- line -1
-- R14['Position'] = R15
-- [ 274] R15 = _ENV['game']                         -- line -1
-- [ 275] R15 = R15['Workspace']                     -- line -1
-- R14['Parent'] = R15
-- [ 277] R15 = _ENV['Instance']                     -- line -1
-- [ 278] R15 = R15['new']                           -- line -1
-- [ 279] R16 = 'Part'                               -- line -1
-- [ 280] R15..R16 = R15(R16)                        -- line -1
-- R15['Transparency'] = R16
-- R15['Anchored'] = R16
-- R15['Material'] = R16
-- [ 284] R16 = _ENV['Color3']                       -- line -1
-- [ 285] R16 = R16['fromRGB']                       -- line -1
-- [ 286] R17 = 106                                  -- line -1
-- [ 287] R18 = 165                                  -- line -1
-- [ 288] R19 = 102                                  -- line -1
-- [ 289] R16..R17 = R16(R17, R18, R19)              -- line -1
-- R15['Color'] = R16
-- [ 291] R16 = _ENV['Vector3']                      -- line -1
-- [ 292] R16 = R16['new']                           -- line -1
-- [ 293] R17 = 21                                   -- line -1
-- [ 294] R18 = 15                                   -- line -1
-- [ 295] R19 = 2                                    -- line -1
-- [ 296] R16..R17 = R16(R17, R18, R19)              -- line -1
-- R15['Size'] = R16
-- [ 298] R16 = _ENV['Vector3']                      -- line -1
-- [ 299] R16 = R16['new']                           -- line -1
-- [ 300] R17 = 0                                    -- line -1
-- [ 301] R18 = 43.998                               -- line -1
-- [ 302] R19 = 0                                    -- line -1
-- [ 303] R16..R17 = R16(R17, R18, R19)              -- line -1
-- R15['Rotation'] = R16
-- [ 305] R16 = _ENV['Vector3']                      -- line -1
-- [ 306] R16 = R16['new']                           -- line -1
-- [ 307] R17 = 666.105                              -- line -1
-- [ 308] R18 = 41.6                                 -- line -1
-- [ 309] R19 = -805.43                              -- line -1
-- [ 310] R16..R17 = R16(R17, R18, R19)              -- line -1
-- R15['Position'] = R16
-- [ 312] R16 = _ENV['game']                         -- line -1
-- [ 313] R16 = R16['Workspace']                     -- line -1
-- R15['Parent'] = R16
-- [ 315] R16 = _ENV['Instance']                     -- line -1
-- [ 316] R16 = R16['new']                           -- line -1
-- [ 317] R17 = 'Part'                               -- line -1
-- [ 318] R16..R17 = R16(R17)                        -- line -1
-- R16['Transparency'] = R17
-- R16['Anchored'] = R17
-- R16['Material'] = R17
-- [ 322] R17 = _ENV['Color3']                       -- line -1
-- [ 323] R17 = R17['fromRGB']                       -- line -1
-- [ 324] R18 = 106                                  -- line -1
-- [ 325] R19 = 165                                  -- line -1
-- [ 326] R20 = 102                                  -- line -1
-- [ 327] R17..R18 = R17(R18, R19, R20)              -- line -1
-- R16['Color'] = R17
-- [ 329] R17 = _ENV['Vector3']                      -- line -1
-- [ 330] R17 = R17['new']                           -- line -1
-- [ 331] R18 = 7.588                                -- line -1
-- [ 332] R19 = 14                                   -- line -1
-- [ 333] R20 = 1                                    -- line -1
-- [ 334] R17..R18 = R17(R18, R19, R20)              -- line -1
-- R16['Size'] = R17
-- [ 336] R17 = _ENV['Vector3']                      -- line -1
-- [ 337] R17 = R17['new']                           -- line -1
-- [ 338] R18 = 0                                    -- line -1
-- [ 339] R19 = 178.999                              -- line -1
-- [ 340] R20 = 0                                    -- line -1
-- [ 341] R17..R18 = R17(R18, R19, R20)              -- line -1
-- R16['Rotation'] = R17
-- [ 343] R17 = _ENV['Vector3']                      -- line -1
-- [ 344] R17 = R17['new']                           -- line -1
-- [ 345] R18 = 644.039                              -- line -1
-- [ 346] R19 = 43.1                                 -- line -1
-- [ 347] R20 = -838.634                             -- line -1
-- [ 348] R17..R18 = R17(R18, R19, R20)              -- line -1
-- R16['Position'] = R17
-- [ 350] R17 = _ENV['game']                         -- line -1
-- [ 351] R17 = R17['Workspace']                     -- line -1
-- R16['Parent'] = R17
-- [ 353] R17 = _ENV['Instance']                     -- line -1
-- [ 354] R17 = R17['new']                           -- line -1
-- [ 355] R18 = 'Part'                               -- line -1
-- [ 356] R17..R18 = R17(R18)                        -- line -1
-- R17['Transparency'] = R18
-- R17['Anchored'] = R18
-- R17['Material'] = R18
-- [ 360] R18 = _ENV['Color3']                       -- line -1
-- [ 361] R18 = R18['fromRGB']                       -- line -1
-- [ 362] R19 = 106                                  -- line -1
-- [ 363] R20 = 165                                  -- line -1
-- [ 364] R21 = 102                                  -- line -1
-- [ 365] R18..R19 = R18(R19, R20, R21)              -- line -1
-- R17['Color'] = R18
-- [ 367] R18 = _ENV['Vector3']                      -- line -1
-- [ 368] R18 = R18['new']                           -- line -1
-- [ 369] R19 = 26.673                               -- line -1
-- [ 370] R20 = 1                                    -- line -1
-- [ 371] R21 = 5.377                                -- line -1
-- [ 372] R18..R19 = R18(R19, R20, R21)              -- line -1
-- R17['Size'] = R18
-- [ 374] R18 = _ENV['Vector3']                      -- line -1
-- [ 375] R18 = R18['new']                           -- line -1
-- [ 376] R19 = 36.601                               -- line -1
-- [ 377] R20 = -48.058                              -- line -1
-- [ 378] R21 = 0                                    -- line -1
-- [ 379] R18..R19 = R18(R19, R20, R21)              -- line -1
-- R17['Rotation'] = R18
-- [ 381] R18 = _ENV['Vector3']                      -- line -1
-- [ 382] R18 = R18['new']                           -- line -1
-- [ 383] R19 = 652.687                              -- line -1
-- [ 384] R20 = 37.374                               -- line -1
-- [ 385] R21 = -813.69                              -- line -1
-- [ 386] R18..R19 = R18(R19, R20, R21)              -- line -1
-- R17['Position'] = R18
-- [ 388] R18 = _ENV['game']                         -- line -1
-- [ 389] R18 = R18['Workspace']                     -- line -1
-- R17['Parent'] = R18
-- [ 391] R18 = _ENV['pairs']                        -- line -1
-- [ 392] R19 = _ENV['game']                         -- line -1
-- [ 393] R19 = R19['GetService']; R20 = R19         -- line -1
-- [ 394] R21 = 'Workspace'                          -- line -1
-- [ 395] R19..R20 = R19(R20, R21)                   -- line -1
-- [ 396] R19 = R19['WORKSPACE_Geometry']            -- line -1
-- [ 397] R19 = R19['REGION_Plains']                 -- line -1
-- [ 398] R19 = R19['Bronze City']                   -- line -1
-- [ 399] R19 = R19['Buildings']                     -- line -1
-- [ 400] R19 = R19['NewGeneralStore']               -- line -1
-- [ 401] R19 = R19['GetChildren']; R20 = R19        -- line -1
-- [ 402] R19..R-1 = R19(R20)                        -- line -1
-- [ 403] R18..R21 = R18()                           -- line -1
-- goto L443  (jump +39)
-- [ 405] R23 = R22['Name']                          -- line -1
-- [ 406] if (R23 == 'Door') ~= false then goto next+1 -- line -1
-- goto L443  (jump +36)
-- [ 408] R23 = _ENV['pairs']                        -- line -1
-- [ 409] R24 = R22['GetDescendants']; R25 = R22     -- line -1
-- [ 410] R24..R-1 = R24(R25)                        -- line -1
-- [ 411] R23..R26 = R23()                           -- line -1
-- goto L441  (jump +29)
-- [ 413] R28 = R27['IsA']; R29 = R27                -- line -1
-- [ 414] R30 = 'Part'                               -- line -1
-- [ 415] R28..R29 = R28(R29, R30)                   -- line -1
-- [ 416] if R28 == false then goto next+1           -- line -1
-- ::L416::
-- goto L441  (jump +24)
-- [ 418] R28 = _ENV['Instance']                     -- line -1
-- [ 419] R28 = R28['new']                           -- line -1
-- [ 420] R29 = 'PathfindingModifier'                -- line -1
-- [ 421] R28..R29 = R28(R29)                        -- line -1
-- R28['Parent'] = R29
-- R28['PassThrough'] = R29
-- [ 424] R29 = R27['Name']                          -- line -1
-- [ 425] if (R29 == 'Part') ~= true then goto next+1 -- line -1
-- goto L429  (jump +3)
-- [ 427] R29 = R27['Name']                          -- line -1
-- [ 428] if (R29 == 'Primary') ~= false then goto next+1 -- line -1
-- goto L441  (jump +12)
-- [ 430] R29 = R27['Color']                         -- line -1
-- [ 431] R30 = _ENV['Color3']                       -- line -1
-- [ 432] R30 = R30['fromRGB']                       -- line -1
-- [ 433] R31 = 80                                   -- line -1
-- [ 434] R32 = 67                                   -- line -1
-- [ 435] R33 = 60                                   -- line -1
-- [ 436] R30..R31 = R30(R31, R32, R33)              -- line -1
-- [ 437] if (R29 == R30) ~= true then goto next+1   -- line -1
-- goto L440  (jump +2)
-- R27['CanCollide'] = R28
-- goto L441  (jump +1)
-- R27['CanCollide'] = R28
-- [ 442] for-in R23 (n=2) goto ?                    -- line -1
-- goto L412  (jump -31)
-- [ 444] for-in R18 (n=2) goto ?                    -- line -1
-- ::L444::
-- goto L404  (jump -41)
-- [ 446] R18 = _ENV['pairs']                        -- line -1
-- ::L446::
-- [ 447] R19 = _ENV['game']                         -- line -1
-- [ 448] R19 = R19['GetService']; R20 = R19         -- line -1
-- [ 449] R21 = 'Workspace'                          -- line -1
-- [ 450] R19..R20 = R19(R20, R21)                   -- line -1
-- [ 451] R19 = R19['WORKSPACE_Interactables']       -- line -1
-- [ 452] R19 = R19['Mining']                        -- line -1
-- [ 453] R19 = R19['OreDeposits']                   -- line -1
-- [ 454] R19 = R19['GetDescendants']; R20 = R19     -- line -1
-- [ 455] R19..R-1 = R19(R20)                        -- line -1
-- [ 456] R18..R21 = R18()                           -- line -1
-- goto L470  (jump +13)
-- [ 458] R23 = R22['IsA']; R24 = R22                -- line -1
-- [ 459] R25 = 'MeshPart'                           -- line -1
-- [ 460] R23..R24 = R23(R24, R25)                   -- line -1
-- [ 461] if R23 == false then goto next+1           -- line -1
-- ::L461::
-- goto L470  (jump +8)
-- [ 463] R23 = _ENV['Vector3']                      -- line -1
-- [ 464] R23 = R23['new']                           -- line -1
-- [ 465] R24 = 10.16136                             -- line -1
-- [ 466] R25 = 10.53925                             -- line -1
-- [ 467] R26 = 12.97672                             -- line -1
-- [ 468] R23..R24 = R23(R24, R25, R26)              -- line -1
-- R22['Size'] = R23
-- R22['CanCollide'] = R23
-- [ 471] for-in R18 (n=2) goto ?                    -- line -1
-- goto L457  (jump -15)
-- [ 473] R18 = closure(proto 9)                     -- line -1
-- ::L473::
-- [ 474] R19 = _ENV['game']                         -- line -1
-- [ 475] R19 = R19['GetService']; R20 = R19         -- line -1
-- [ 476] R21 = 'CoreGui'                            -- line -1
-- [ 477] R19..R20 = R19(R20, R21)                   -- line -1
-- [ 478] R19 = R19['RobloxPromptGui']               -- line -1
-- [ 479] R19 = R19['promptOverlay']                 -- line -1
-- [ 480] R19 = R19['ChildAdded']                    -- line -1
-- [ 481] R19 = R19['Connect']; R20 = R19            -- line -1
-- [ 482] R21 = closure(proto 4)                     -- line -1
-- [ 483] R19..R19 = R19(R20, R21)                   -- line -1
-- [ 484] R19 = _ENV['game']                         -- line -1
-- [ 485] R19 = R19['GetService']; R20 = R19         -- line -1
-- [ 486] R21 = 'UserInputService'                   -- line -1
-- [ 487] R19..R20 = R19(R20, R21)                   -- line -1
-- [ 488] R20 = 0                                    -- line -1
-- [ 489] R21 = 0                                    -- line -1
-- [ 490] R22 = 0                                    -- line -1
-- [ 491] R23 = 0                                    -- line -1
-- [ 492] R24 = _ENV['tick']                         -- line -1
-- [ 493] R24..R25 = R24()                           -- line -1
-- [ 494] R25 = closure(proto 3)                     -- line -1
-- [ 495] R0 = R24                                   -- line -1
-- [ 496] R26 = R19['InputBegan']                    -- line -1
-- [ 497] R26 = R26['Connect']; R27 = R26            -- line -1
-- [ 498] R28 = closure(proto 5)                     -- line -1
-- [ 499] R0 = R22                                   -- line -1
-- [ 500] R0 = R3                                    -- line -1
-- [ 501] R0 = R21                                   -- line -1
-- [ 502] R0 = R25                                   -- line -1
-- [ 503] R0 = R20                                   -- line -1
-- [ 504] R26..R26 = R26(R27, R28)                   -- line -1
-- [ 505] R26 = R2['Heartbeat']                      -- line -1
-- [ 506] R26 = R26['Connect']; R27 = R26            -- line -1
-- [ 507] R28 = closure(proto 7)                     -- line -1
-- [ 508] R0 = R18                                   -- line -1
-- [ 509] R0 = R4                                    -- line -1
-- [ 510] R26..R26 = R26(R27, R28)                   -- line -1
-- [ 511] R26 = R4                                   -- line -1
-- [ 512] R27 = _ENV['Enum']                         -- line -1
-- [ 513] R27 = R27['KeyCode']                       -- line -1
-- [ 514] R27 = R27['E']                             -- line -1
-- [ 515] R28 = 0                                    -- line -1
-- [ 516] R26..R26 = R26(R27, R28)                   -- line -1
-- [ 517] R26 = R4                                   -- line -1
-- [ 518] R27 = _ENV['Enum']                         -- line -1
-- [ 519] R27 = R27['KeyCode']                       -- line -1
-- [ 520] R27 = R27['B']                             -- line -1
-- [ 521] R28 = 0                                    -- line -1
-- [ 522] R26..R26 = R26(R27, R28)                   -- line -1
-- [ 523] R26 = R5                                   -- line -1
-- [ 524] R27 = _ENV['Vector3']                      -- line -1
-- [ 525] R27 = R27['new']                           -- line -1
-- [ 526] R28 = 654.389                              -- line -1
-- [ 527] R29 = 39.6504                              -- line -1
-- [ 528] R30 = -812.504                             -- line -1
-- [ 529] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 530] R26..R26 = R26()                           -- line -1
-- [ 531] R26 = R5                                   -- line -1
-- [ 532] R27 = _ENV['Vector3']                      -- line -1
-- [ 533] R27 = R27['new']                           -- line -1
-- [ 534] R28 = 663.539                              -- line -1
-- [ 535] R29 = 42.2776                              -- line -1
-- [ 536] R30 = -945.427                             -- line -1
-- [ 537] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 538] R26..R26 = R26()                           -- line -1
-- [ 539] R26 = R5                                   -- line -1
-- [ 540] R27 = _ENV['Vector3']                      -- line -1
-- [ 541] R27 = R27['new']                           -- line -1
-- [ 542] R28 = 738.938                              -- line -1
-- [ 543] R29 = 2.43074                              -- line -1
-- [ 544] R30 = -1119.45                             -- line -1
-- [ 545] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 546] R26..R26 = R26()                           -- line -1
-- [ 547] R26 = _ENV['wait']                         -- line -1
-- [ 548] R26..R27 = R26()                           -- line -1
-- [ 549] if R26 == false then goto next+1           -- line -1
-- ::L549::
-- goto L719  (jump +169)
-- [ 551] R26 = R6                                   -- line -1
-- [ 552] R26..R27 = R26()                           -- line -1
-- [ 553] if R26 == false then goto next+1           -- line -1
-- ::L553::
-- goto L654  (jump +100)
-- [ 555] R26 = R5                                   -- line -1
-- [ 556] R27 = _ENV['Vector3']                      -- line -1
-- [ 557] R27 = R27['new']                           -- line -1
-- [ 558] R28 = 1114.7                               -- line -1
-- [ 559] R29 = 0.0503915                            -- line -1
-- [ 560] R30 = -1226.24                             -- line -1
-- [ 561] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 562] R26..R26 = R26()                           -- line -1
-- [ 563] R26 = R5                                   -- line -1
-- [ 564] R27 = _ENV['Vector3']                      -- line -1
-- [ 565] R27 = R27['new']                           -- line -1
-- [ 566] R28 = 663.539                              -- line -1
-- [ 567] R29 = 42.2776                              -- line -1
-- [ 568] R30 = -945.427                             -- line -1
-- [ 569] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 570] R26..R26 = R26()                           -- line -1
-- [ 571] R26 = R5                                   -- line -1
-- [ 572] R27 = _ENV['Vector3']                      -- line -1
-- [ 573] R27 = R27['new']                           -- line -1
-- [ 574] R28 = 678.886                              -- line -1
-- [ 575] R29 = 39.2537                              -- line -1
-- [ 576] R30 = -901.273                             -- line -1
-- [ 577] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 578] R26..R26 = R26()                           -- line -1
-- [ 579] R26 = R5                                   -- line -1
-- [ 580] R27 = _ENV['Vector3']                      -- line -1
-- [ 581] R27 = R27['new']                           -- line -1
-- [ 582] R28 = 654.389                              -- line -1
-- [ 583] R29 = 39.6504                              -- line -1
-- [ 584] R30 = -812.504                             -- line -1
-- [ 585] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 586] R26..R26 = R26()                           -- line -1
-- [ 587] R26 = _ENV['string']                       -- line -1
-- [ 588] R26 = R26['gsub']                          -- line -1
-- [ 589] R27 = _ENV['game']                         -- line -1
-- [ 590] R27 = R27['Players']                       -- line -1
-- [ 591] R27 = R27['LocalPlayer']                   -- line -1
-- [ 592] R27 = R27['PlayerGui']                     -- line -1
-- [ 593] R27 = R27['PlayerInfo']                    -- line -1
-- [ 594] R27 = R27['StatBars']                      -- line -1
-- [ 595] R27 = R27['PlayerDataFrame']               -- line -1
-- [ 596] R27 = R27['Bucks']                         -- line -1
-- [ 597] R27 = R27['Text']                          -- line -1
-- [ 598] R27 = R27['sub']; R28 = R27                -- line -1
-- [ 599] R29 = 2                                    -- line -1
-- [ 600] R27..R28 = R27(R28, R29)                   -- line -1
-- [ 601] R28 = ','                                  -- line -1
-- [ 602] R29 = ''                                   -- line -1
-- [ 603] R26..R27 = R26(R27, R28, R29)              -- line -1
-- [ 604] R22 = R26                                  -- line -1
-- [ 605] R26 = R4                                   -- line -1
-- [ 606] R27 = _ENV['Enum']                         -- line -1
-- [ 607] R27 = R27['KeyCode']                       -- line -1
-- [ 608] R27 = R27['F']                             -- line -1
-- [ 609] R28 = 1                                    -- line -1
-- [ 610] R26..R26 = R26(R27, R28)                   -- line -1
-- [ 611] R26 = _ENV['string']                       -- line -1
-- [ 612] R26 = R26['gsub']                          -- line -1
-- [ 613] R27 = _ENV['game']                         -- line -1
-- [ 614] R27 = R27['Players']                       -- line -1
-- [ 615] R27 = R27['LocalPlayer']                   -- line -1
-- [ 616] R27 = R27['PlayerGui']                     -- line -1
-- [ 617] R27 = R27['PlayerInfo']                    -- line -1
-- [ 618] R27 = R27['StatBars']                      -- line -1
-- [ 619] R27 = R27['PlayerDataFrame']               -- line -1
-- [ 620] R27 = R27['Bucks']                         -- line -1
-- [ 621] R27 = R27['Text']                          -- line -1
-- [ 622] R27 = R27['sub']; R28 = R27                -- line -1
-- [ 623] R29 = 2                                    -- line -1
-- [ 624] R27..R28 = R27(R28, R29)                   -- line -1
-- [ 625] R28 = ','                                  -- line -1
-- [ 626] R29 = ''                                   -- line -1
-- [ 627] R26..R27 = R26(R27, R28, R29)              -- line -1
-- [ 628] R23 = R26                                  -- line -1
-- [ 629] R26 = R6                                   -- line -1
-- [ 630] R26..R27 = R26()                           -- line -1
-- [ 631] if R26 == true then goto next+1            -- line -1
-- goto L586  (jump -46)
-- ::L632::
-- [ 633] R26 = _ENV['Money']                        -- line -1
-- [ 634] R26 = R20 + R26                            -- line -1
-- [ 635] R20 = R26 - R22                            -- line -1
-- [ 636] R26 = R5                                   -- line -1
-- [ 637] R27 = _ENV['Vector3']                      -- line -1
-- [ 638] R27 = R27['new']                           -- line -1
-- [ 639] R28 = 663.539                              -- line -1
-- [ 640] R29 = 42.2776                              -- line -1
-- [ 641] R30 = -945.427                             -- line -1
-- [ 642] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 643] R26..R26 = R26()                           -- line -1
-- [ 644] R26 = R5                                   -- line -1
-- [ 645] R27 = _ENV['Vector3']                      -- line -1
-- [ 646] R27 = R27['new']                           -- line -1
-- [ 647] R28 = 738.938                              -- line -1
-- [ 648] R29 = 2.43074                              -- line -1
-- [ 649] R30 = -1119.45                             -- line -1
-- [ 650] R27..R-1 = R27(R28, R29, R30)              -- line -1
-- [ 651] R26..R26 = R26()                           -- line -1
-- [ 652] R26 = 1                                    -- line -1
-- _ENV['i'] = R26
-- goto L546  (jump -108)
-- [ 655] R26 = R5                                   -- line -1
-- [ 656] R27 = _ENV['_G']                           -- line -1
-- [ 657] R27 = R27['MineralPosition']               -- line -1
-- [ 658] R28 = _ENV['i']                            -- line -1
-- [ 659] R27 = R27[R28]                             -- line -1
-- [ 660] R26..R26 = R26(R27)                        -- line -1
-- [ 661] R26 = R7                                   -- line -1
-- [ 662] R26..R27 = R26()                           -- line -1
-- [ 663] R26 = R26['Parent']                        -- line -1
-- [ 664] R26 = R26['DepositInfo']                   -- line -1
-- [ 665] R26 = R26['OreRemaining']                  -- line -1
-- [ 666] R26 = R26['Value']                         -- line -1
-- [ 667] if (R26 == 0) ~= true then goto next+1     -- line -1
-- goto L707  (jump +39)
-- [ 669] R26 = 1                                    -- line -1
-- [ 670] R27 = R7                                   -- line -1
-- [ 671] R27..R28 = R27()                           -- line -1
-- [ 672] R27 = R27['Parent']                        -- line -1
-- [ 673] R27 = R27['DepositInfo']                   -- line -1
-- [ 674] R27 = R27['OreRemaining']                  -- line -1
-- [ 675] R27 = R27['Value']                         -- line -1
-- [ 676] R28 = 1                                    -- line -1
-- [ 677] for prep R26 (limit R27 step R28) goto ?   -- line -1
-- [ 678] R30 = _ENV['game']                         -- line -1
-- [ 679] R30 = R30['GetService']; R31 = R30         -- line -1
-- [ 680] R32 = 'VirtualInputManager'                -- line -1
-- [ 681] R30..R31 = R30(R31, R32)                   -- line -1
-- [ 682] R30 = R30['SendMouseButtonEvent']; R31 = R30 -- line -1
-- [ 683] R32 = 0                                    -- line -1
-- [ 684] R33 = 0                                    -- line -1
-- [ 685] R34 = 0                                    -- line -1
-- [ 686] R35 = true                                 -- line -1
-- [ 687] R36 = _ENV['game']                         -- line -1
-- [ 688] R37 = 1                                    -- line -1
-- [ 689] R30..R30 = R30(R31, R32, R33, R34, R35, R36, R37) -- line -1
-- [ 690] R30 = _ENV['wait']                         -- line -1
-- [ 691] R31 = _ENV['_G']                           -- line -1
-- [ 692] R31 = R31['MineTime']                      -- line -1
-- [ 693] R30..R30 = R30(R31)                        -- line -1
-- [ 694] R30 = _ENV['game']                         -- line -1
-- [ 695] R30 = R30['GetService']; R31 = R30         -- line -1
-- [ 696] R32 = 'VirtualInputManager'                -- line -1
-- [ 697] R30..R31 = R30(R31, R32)                   -- line -1
-- [ 698] R30 = R30['SendMouseButtonEvent']; R31 = R30 -- line -1
-- [ 699] R32 = 0                                    -- line -1
-- [ 700] R33 = 0                                    -- line -1
-- [ 701] R34 = 0                                    -- line -1
-- [ 702] R35 = false                                -- line -1
-- [ 703] R36 = _ENV['game']                         -- line -1
-- [ 704] R37 = 1                                    -- line -1
-- [ 705] R30..R30 = R30(R31, R32, R33, R34, R35, R36, R37) -- line -1
-- [ 706] R21 = R21 + 1                              -- line -1
-- [ 707] R26 += R481 ; if R26 < R255 then goto ?    -- line -1
-- [ 708] R26 = _ENV['i']                            -- line -1
-- [ 709] R26 = R26 + 1                              -- line -1
-- _ENV['i'] = R26
-- [ 711] R26 = _ENV['i']                            -- line -1
-- [ 712] R27 = _ENV['_G']                           -- line -1
-- [ 713] R27 = R27['MineralPosition']               -- line -1
-- [ 714] R27 = #R27                                 -- line -1
-- [ 715] if (R26 == R27) ~= false then goto next+1  -- line -1
-- goto L546  (jump -170)
-- [ 717] R26 = 1                                    -- line -1
-- _ENV['i'] = R26
-- goto L546  (jump -173)
-- [ 720] return ...                                 -- line -1
-- 
--   -- function main.p0  params=0 nups=1 lines=0..0
--   [   1]   R0 = U0                                  -- line -1
--   [   2]   R0 = R0['Character']                     -- line -1
--   [   3]   R0 = R0['FindFirstChild']; R1 = R0       -- line -1
--   [   4]   R2 = 'Humanoid'                          -- line -1
--   [   5] R0..R1 = R0(R1, R2)                        -- line -1
--   [   6] if R0 == false then goto next+1            -- line -1
--   ::L6::
--   goto L13  (jump +6)
--   [   8]   R0 = U0                                  -- line -1
--   [   9]   R0 = R0['Character']                     -- line -1
--   [  10]   R0 = R0['Humanoid']                      -- line -1
--   [  11]   R1 = _ENV['_G']                          -- line -1
--   [  12]   R1 = R1['WalkSpeed']                     -- line -1
--   R0['WalkSpeed'] = R1
--   [  14] return ...                                 -- line -1
-- 
--   -- function main.p1  params=2 nups=0 lines=0..0
--   [   1]   R2 = _ENV['game']                        -- line -1
--   [   2]   R2 = R2['GetService']; R3 = R2           -- line -1
--   [   3]   R4 = 'VirtualInputManager'               -- line -1
--   [   4] R2..R3 = R2(R3, R4)                        -- line -1
--   [   5]   R2 = R2['SendKeyEvent']; R3 = R2         -- line -1
--   [   6]   R4 = true                                -- line -1
--   [   7]   R5 = R0                                  -- line -1
--   [   8]   R6 = false                               -- line -1
--   [   9]   R7 = _ENV['game']                        -- line -1
--   [  10] R2..R2 = R2(R3, R4, R5, R6, R7)            -- line -1
--   [  11]   R2 = _ENV['wait']                        -- line -1
--   [  12]   R3 = R1                                  -- line -1
--   [  13] R2..R2 = R2(R3)                            -- line -1
--   [  14]   R2 = _ENV['game']                        -- line -1
--   [  15]   R2 = R2['GetService']; R3 = R2           -- line -1
--   [  16]   R4 = 'VirtualInputManager'               -- line -1
--   [  17] R2..R3 = R2(R3, R4)                        -- line -1
--   [  18]   R2 = R2['SendKeyEvent']; R3 = R2         -- line -1
--   [  19]   R4 = false                               -- line -1
--   [  20]   R5 = R0                                  -- line -1
--   [  21]   R6 = false                               -- line -1
--   [  22]   R7 = _ENV['game']                        -- line -1
--   [  23] R2..R2 = R2(R3, R4, R5, R6, R7)            -- line -1
--   [  24] return ...                                 -- line -1
-- 
--   -- function main.p2  params=0 nups=0 lines=0..0
--   [   1]   R1 = _ENV['game']                        -- line -1
--   [   2]   R1 = R1['Players']                       -- line -1
--   [   3]   R1 = R1['LocalPlayer']                   -- line -1
--   [   4]   R1 = R1['Character']                     -- line -1
--   [   5]   R1 = R1['PrimaryPart']                   -- line -1
--   [   6]   R1 = R1['Position']                      -- line -1
--   [   7]   R2 = _ENV['pairs']                       -- line -1
--   [   8]   R3 = _ENV['game']                        -- line -1
--   [   9]   R3 = R3['GetService']; R4 = R3           -- line -1
--   [  10]   R5 = 'Workspace'                         -- line -1
--   [  11] R3..R4 = R3(R4, R5)                        -- line -1
--   [  12]   R3 = R3['WORKSPACE_Interactables']       -- line -1
--   [  13]   R3 = R3['Mining']                        -- line -1
--   [  14]   R3 = R3['OreDeposits']                   -- line -1
--   [  15]   R3 = R3['GetDescendants']; R4 = R3       -- line -1
--   [  16] R3..R-1 = R3(R4)                           -- line -1
--   [  17] R2..R5 = R2()                              -- line -1
--   goto L38  (jump +20)
--   [  19]   R7 = _ENV['string']                      -- line -1
--   [  20]   R7 = R7['match']                         -- line -1
--   [  21]   R8 = R6['Name']                          -- line -1
--   [  22]   R9 = 'Base'                              -- line -1
--   [  23] R7..R8 = R7(R8, R9)                        -- line -1
--   [  24] if R7 == false then goto next+1            -- line -1
--   ::L24::
--   goto L38  (jump +13)
--   [  26] if (R0 == nil) ~= false then goto next+1   -- line -1
--   goto L29  (jump +2)
--   [  28]   R0 = R6                                  -- line -1
--   goto L38  (jump +9)
--   [  30]   R7 = R6['Position']                      -- line -1
--   [  31]   R7 = R1 - R7                             -- line -1
--   [  32]   R7 = R7['magnitude']                     -- line -1
--   [  33]   R8 = R0['Position']                      -- line -1
--   [  34]   R8 = R8 - R1                             -- line -1
--   [  35]   R8 = R8['magnitude']                     -- line -1
--   [  36] if (R7 < R8) ~= false then goto next+1     -- line -1
--   goto L38  (jump +1)
--   [  38]   R0 = R6                                  -- line -1
--   [  39] for-in R2 (n=2) goto ?                     -- line -1
--   goto L18  (jump -22)
--   [  41] return ...                                 -- line -1
-- 
--   -- function main.p3  params=1 nups=1 lines=0..0
--   [   1]   R1 = _ENV['tick']                        -- line -1
--   [   2] R1..R2 = R1()                              -- line -1
--   [   3]   R2 = U0                                  -- line -1
--   [   4]   R1 = R1 - R2                             -- line -1
--   [   5] if (R0 == 'h') ~= false then goto next+1   -- line -1
--   goto L13  (jump +7)
--   [   7]   R2 = _ENV['math']                        -- line -1
--   [   8]   R2 = R2['floor']                         -- line -1
--   [   9]   R3 = R1 / 60                             -- line -1
--   [  10]   R3 = R3 / 60                             -- line -1
--   [  11] R2..R3 = R2(R3)                            -- line -1
--   [  12]   R2 = R2 % 60                             -- line -1
--   [  13] return ... R2                              -- line -1
--   [  14] if (R0 == 'm') ~= false then goto next+1   -- line -1
--   goto L21  (jump +6)
--   [  16]   R2 = _ENV['math']                        -- line -1
--   [  17]   R2 = R2['floor']                         -- line -1
--   [  18]   R3 = R1 / 60                             -- line -1
--   [  19] R2..R3 = R2(R3)                            -- line -1
--   [  20]   R2 = R2 % 60                             -- line -1
--   [  21] return ... R2                              -- line -1
--   [  22] if (R0 == 's') ~= false then goto next+1   -- line -1
--   goto L27  (jump +4)
--   [  24]   R2 = _ENV['math']                        -- line -1
--   [  25]   R2 = R2['floor']                         -- line -1
--   [  26]   R3 = R1 % 60                             -- line -1
--   [  27] return R2(R3)                              -- line -1
--   [  28] return ...                                 -- line -1
-- 
--   -- function main.p4  params=1 nups=0 lines=0..0
--   [   1]   R1 = R0['Name']                          -- line -1
--   [   2] if (R1 == 'ErrorPrompt') ~= false then goto next+1 -- line -1
--   goto L17  (jump +14)
--   [   4]   R1 = R0['FindFirstChild']; R2 = R0       -- line -1
--   [   5]   R3 = 'MessageArea'                       -- line -1
--   [   6] R1..R2 = R1(R2, R3)                        -- line -1
--   [   7] if R1 == false then goto next+1            -- line -1
--   ::L7::
--   goto L17  (jump +9)
--   [   9]   R1 = R0['MessageArea']                   -- line -1
--   [  10]   R1 = R1['FindFirstChild']; R2 = R1       -- line -1
--   [  11]   R3 = 'ErrorFrame'                        -- line -1
--   [  12] R1..R2 = R1(R2, R3)                        -- line -1
--   [  13] if R1 == false then goto next+1            -- line -1
--   ::L13::
--   goto L17  (jump +3)
--   [  15]   R1 = _ENV['print']                       -- line -1
--   [  16]   R2 = 'ERRORPROMPT'                       -- line -1
--   [  17] R1..R1 = R1(R2)                            -- line -1
--   [  18] return ...                                 -- line -1
-- 
--   -- function main.p5  params=1 nups=5 lines=0..0
--   [   1]   R1 = R0['KeyCode']                       -- line -1
--   [   2]   R2 = _ENV['Enum']                        -- line -1
--   [   3]   R2 = R2['KeyCode']                       -- line -1
--   [   4]   R2 = R2['Return']                        -- line -1
--   [   5] if (R1 == R2) ~= false then goto next+1    -- line -1
--   goto L9  (jump +3)
--   [   7]   R1 = _ENV['print']                       -- line -1
--   [   8]   R2 = 'KeyCode ERROR'                     -- line -1
--   [   9] R1..R1 = R1(R2)                            -- line -1
--   [  10]   R1 = R0['KeyCode']                       -- line -1
--   [  11]   R2 = _ENV['Enum']                        -- line -1
--   [  12]   R2 = R2['KeyCode']                       -- line -1
--   [  13]   R2 = R2['F']                             -- line -1
--   [  14] if (R1 == R2) ~= false then goto next+1    -- line -1
--   goto L64  (jump +49)
--   [  16]   R1 = _ENV['_G']                          -- line -1
--   [  17]   R1 = R1['toping']                        -- line -1
--   _ENV['oldtoping'] = R1
--   [  19]   R1 = _ENV['_G']                          -- line -1
--   [  20]   R2 = _ENV['_G']                          -- line -1
--   [  21]   R2 = R2['DiscordName']                   -- line -1
--   R1['toping'] = R2
--   [  23]   R1 = _ENV['string']                      -- line -1
--   [  24]   R1 = R1['gsub']                          -- line -1
--   [  25]   R2 = _ENV['game']                        -- line -1
--   [  26]   R2 = R2['Players']                       -- line -1
--   [  27]   R2 = R2['LocalPlayer']                   -- line -1
--   [  28]   R2 = R2['PlayerGui']                     -- line -1
--   [  29]   R2 = R2['PlayerInfo']                    -- line -1
--   [  30]   R2 = R2['StatBars']                      -- line -1
--   [  31]   R2 = R2['PlayerDataFrame']               -- line -1
--   [  32]   R2 = R2['Bucks']                         -- line -1
--   [  33]   R2 = R2['Text']                          -- line -1
--   [  34]   R2 = R2['sub']; R3 = R2                  -- line -1
--   [  35]   R4 = 2                                   -- line -1
--   [  36] R2..R3 = R2(R3, R4)                        -- line -1
--   [  37]   R3 = ','                                 -- line -1
--   [  38]   R4 = ''                                  -- line -1
--   [  39] R1..R2 = R1(R2, R3, R4)                    -- line -1
--   U0 = R1
--   [  41]   R1 = _ENV['wait']                        -- line -1
--   [  42]   R2 = 0.75                                -- line -1
--   [  43] R1..R1 = R1(R2)                            -- line -1
--   [  44]   R1 = _ENV['string']                      -- line -1
--   [  45]   R1 = R1['gsub']                          -- line -1
--   [  46]   R2 = _ENV['game']                        -- line -1
--   [  47]   R2 = R2['Players']                       -- line -1
--   [  48]   R2 = R2['LocalPlayer']                   -- line -1
--   [  49]   R2 = R2['PlayerGui']                     -- line -1
--   [  50]   R2 = R2['PlayerInfo']                    -- line -1
--   [  51]   R2 = R2['StatBars']                      -- line -1
--   [  52]   R2 = R2['PlayerDataFrame']               -- line -1
--   [  53]   R2 = R2['Bucks']                         -- line -1
--   [  54]   R2 = R2['Text']                          -- line -1
--   [  55]   R2 = R2['sub']; R3 = R2                  -- line -1
--   [  56]   R4 = 2                                   -- line -1
--   [  57] R2..R3 = R2(R3, R4)                        -- line -1
--   [  58]   R3 = ','                                 -- line -1
--   [  59]   R4 = ''                                  -- line -1
--   [  60] R1..R2 = R1(R2, R3, R4)                    -- line -1
--   _ENV['Money'] = R1
--   [  62]   R1 = _ENV['_G']                          -- line -1
--   [  63]   R2 = _ENV['oldtoping']                   -- line -1
--   R1['toping'] = R2
--   [  65]   R1 = R0['KeyCode']                       -- line -1
--   [  66]   R2 = _ENV['Enum']                        -- line -1
--   [  67]   R2 = R2['KeyCode']                       -- line -1
--   [  68]   R2 = R2['F1']                            -- line -1
--   [  69] if (R1 == R2) ~= false then goto next+1    -- line -1
--   goto L88  (jump +18)
--   [  71]   R1 = U1                                  -- line -1
--   [  72]   R2 = 'Mining Stats'                      -- line -1
--   [  73]   R3 = _ENV['string']                      -- line -1
--   [  74]   R3 = R3['format']                        -- line -1
--   [  75]   R4 = 'You have mined in total: %d.\nYou are in this server since: %dh %dm %ds.\nYou have earned a total of: %d$.\n' -- line -1
--   [  76]   R5 = U2                                  -- line -1
--   [  77]   R6 = U3                                  -- line -1
--   [  78]   R7 = 'h'                                 -- line -1
--   [  79] R6..R7 = R6(R7)                            -- line -1
--   [  80]   R7 = U3                                  -- line -1
--   [  81]   R8 = 'm'                                 -- line -1
--   [  82] R7..R8 = R7(R8)                            -- line -1
--   [  83]   R8 = U3                                  -- line -1
--   [  84]   R9 = 's'                                 -- line -1
--   [  85] R8..R9 = R8(R9)                            -- line -1
--   [  86]   R9 = U4                                  -- line -1
--   [  87] R3..R-1 = R3(R4, R5, R6, R7, R8, R9)       -- line -1
--   [  88] R1..R1 = R1()                              -- line -1
--   [  89] return ...                                 -- line -1
-- 
--   -- function main.p6  params=0 nups=0 lines=0..0
--   [   1]   R0 = _ENV['game']                        -- line -1
--   [   2]   R0 = R0['Players']                       -- line -1
--   [   3]   R0 = R0['LocalPlayer']                   -- line -1
--   [   4]   R0 = R0['PlayerGui']                     -- line -1
--   [   5]   R0 = R0['InventoryUI']                   -- line -1
--   [   6]   R0 = R0['Inventory']                     -- line -1
--   [   7]   R0 = R0['Container']                     -- line -1
--   [   8]   R0 = R0['BottomBar']                     -- line -1
--   [   9]   R0 = R0['Body']                          -- line -1
--   [  10]   R0 = R0['NumSlots']                      -- line -1
--   [  11]   R0 = R0['Text']                          -- line -1
--   [  12] if (R0 == '30 / 30') ~= true then goto next+1 -- line -1
--   goto L14  (jump +1)
--   [  14]   R0 = false  (jump +1)                    -- line -1
--   [  15]   R0 = true                                -- line -1
--   [  16] return ...                                 -- line -1
-- 
--   -- function main.p7  params=0 nups=2 lines=0..0
--   [   1]   R0 = _ENV['game']                        -- line -1
--   [   2]   R0 = R0['Players']                       -- line -1
--   [   3]   R0 = R0['LocalPlayer']                   -- line -1
--   [   4]   R0 = R0['PlayerGui']                     -- line -1
--   [   5]   R0 = R0['Prompts']                       -- line -1
--   [   6]   R0 = R0['ActionBindsFeed']               -- line -1
--   [   7]   R0 = R0['Respawn']                       -- line -1
--   [   8]   R0 = R0['Visible']                       -- line -1
--   [   9] if R0 == false then goto next+1            -- line -1
--   ::L9::
--   goto L24  (jump +14)
--   [  11]   R0 = _ENV['respawnVisible']              -- line -1
--   [  12] if (R0 == true) ~= false then goto next+1  -- line -1
--   goto L21  (jump +8)
--   [  14]   R0 = _ENV['print']                       -- line -1
--   [  15]   R1 = 'You died'                          -- line -1
--   [  16] R0..R0 = R0(R1)                            -- line -1
--   [  17]   R0 = false                               -- line -1
--   _ENV['respawnVisible'] = R0
--   [  19]   R0 = U0                                  -- line -1
--   [  20] R0..R0 = R0()                              -- line -1
--   goto L24  (jump +3)
--   [  22]   R0 = _ENV['print']                       -- line -1
--   [  23]   R1 = 'Error'                             -- line -1
--   [  24] R0..R0 = R0(R1)                            -- line -1
--   [  25]   R0 = _ENV['game']                        -- line -1
--   [  26]   R0 = R0['Players']                       -- line -1
--   [  27]   R0 = R0['LocalPlayer']                   -- line -1
--   [  28]   R0 = R0['PlayerGui']                     -- line -1
--   [  29]   R0 = R0['Prompts']                       -- line -1
--   [  30]   R0 = R0['ActionBindsFeed']               -- line -1
--   [  31]   R0 = R0['Respawn']                       -- line -1
--   [  32]   R0 = R0['Visible']                       -- line -1
--   [  33] if R0 == true then goto next+1             -- line -1
--   goto L36  (jump +2)
--   ::L34::
--   [  35]   R0 = true                                -- line -1
--   _ENV['respawnVisible'] = R0
--   [  37]   R0 = _ENV['game']                        -- line -1
--   [  38]   R0 = R0['Players']                       -- line -1
--   [  39]   R0 = R0['LocalPlayer']                   -- line -1
--   [  40]   R0 = R0['PlayerGui']                     -- line -1
--   [  41]   R0 = R0['Hotbar']                        -- line -1
--   [  42]   R0 = R0['HotBar']                        -- line -1
--   [  43]   R0 = R0['Container']                     -- line -1
--   [  44]   R0 = R0['HotbarList']                    -- line -1
--   [  45]   R0 = R0['Body']                          -- line -1
--   [  46]   R0 = R0['HotbarSlot_Utility_1']          -- line -1
--   [  47]   R0 = R0['Container']                     -- line -1
--   [  48]   R0 = R0['Slot']                          -- line -1
--   [  49]   R0 = R0['Stroke_3px']                    -- line -1
--   [  50]   R0 = R0['ImageColor3']                   -- line -1
--   [  51]   R1 = _ENV['Color3']                      -- line -1
--   [  52]   R1 = R1['fromRGB']                       -- line -1
--   [  53]   R2 = 255                                 -- line -1
--   [  54]   R3 = 255                                 -- line -1
--   [  55]   R4 = 255                                 -- line -1
--   [  56] R1..R2 = R1(R2, R3, R4)                    -- line -1
--   [  57] if (R0 == R1) ~= true then goto next+1     -- line -1
--   goto L64  (jump +6)
--   ::L58::
--   [  59]   R0 = U1                                  -- line -1
--   [  60]   R1 = _ENV['Enum']                        -- line -1
--   [  61]   R1 = R1['KeyCode']                       -- line -1
--   [  62]   R1 = R1['Four']                          -- line -1
--   [  63]   R2 = 0                                   -- line -1
--   [  64] R0..R0 = R0(R1, R2)                        -- line -1
--   [  65]   R0 = _ENV['game']                        -- line -1
--   [  66]   R0 = R0['Players']                       -- line -1
--   [  67]   R0 = R0['LocalPlayer']                   -- line -1
--   [  68]   R0 = R0['PlayerGui']                     -- line -1
--   [  69]   R0 = R0['InventoryUI']                   -- line -1
--   [  70]   R0 = R0['Enabled']                       -- line -1
--   [  71] if R0 == true then goto next+1             -- line -1
--   goto L78  (jump +6)
--   ::L72::
--   [  73]   R0 = U1                                  -- line -1
--   [  74]   R1 = _ENV['Enum']                        -- line -1
--   [  75]   R1 = R1['KeyCode']                       -- line -1
--   [  76]   R1 = R1['B']                             -- line -1
--   [  77]   R2 = 0                                   -- line -1
--   [  78] R0..R0 = R0(R1, R2)                        -- line -1
--   [  79]   R0 = _ENV['game']                        -- line -1
--   [  80]   R0 = R0['Players']                       -- line -1
--   [  81]   R0 = R0['LocalPlayer']                   -- line -1
--   [  82]   R0 = R0['PlayerGui']                     -- line -1
--   [  83]   R0 = R0['Prompts']                       -- line -1
--   [  84]   R0 = R0['ActionBindsFeed']               -- line -1
--   [  85]   R0 = R0['GetUp']                         -- line -1
--   [  86]   R0 = R0['Visible']                       -- line -1
--   [  87] if R0 == false then goto next+1            -- line -1
--   ::L87::
--   goto L94  (jump +6)
--   [  89]   R0 = U1                                  -- line -1
--   [  90]   R1 = _ENV['Enum']                        -- line -1
--   [  91]   R1 = R1['KeyCode']                       -- line -1
--   [  92]   R1 = R1['E']                             -- line -1
--   [  93]   R2 = 0                                   -- line -1
--   [  94] R0..R0 = R0(R1, R2)                        -- line -1
--   [  95]   R0 = _ENV['game']                        -- line -1
--   [  96]   R0 = R0['GetService']; R1 = R0           -- line -1
--   [  97]   R2 = 'Players'                           -- line -1
--   [  98] R0..R1 = R0(R1, R2)                        -- line -1
--   [  99]   R0 = R0['LocalPlayer']                   -- line -1
--   [ 100]   R0 = R0['PlayerGui']                     -- line -1
--   [ 101]   R0 = R0['Prompts']                       -- line -1
--   [ 102]   R0 = R0['ActionBindsFeed']               -- line -1
--   [ 103]   R0 = R0['BreakFree']                     -- line -1
--   [ 104]   R0 = R0['Visible']                       -- line -1
--   [ 105] if R0 == false then goto next+1            -- line -1
--   ::L105::
--   goto L109  (jump +3)
--   [ 107]   R0 = _ENV['print']                       -- line -1
--   [ 108]   R1 = 'LASSO'                             -- line -1
--   [ 109] R0..R0 = R0(R1)                            -- line -1
--   [ 110] return ...                                 -- line -1
-- 
--   -- function main.p8  params=2 nups=0 lines=0..0
--   [   1]   R2 = _ENV['game']                        -- line -1
--   [   2]   R2 = R2['Players']                       -- line -1
--   [   3]   R2 = R2['LocalPlayer']                   -- line -1
--   [   4]   R2 = R2['PlayerGui']                     -- line -1
--   [   5]   R2 = R2['ConfirmPopup']                  -- line -1
--   [   6]   R2 = R2['FindFirstChild']; R3 = R2       -- line -1
--   [   7]   R4 = R0                                  -- line -1
--   [   8] R2..R3 = R2(R3, R4)                        -- line -1
--   [   9] if R2 == true then goto next+1             -- line -1
--   goto L57  (jump +47)
--   ::L10::
--   [  11]   R2 = _ENV['game']                        -- line -1
--   [  12]   R2 = R2['Players']                       -- line -1
--   [  13]   R2 = R2['LocalPlayer']                   -- line -1
--   [  14]   R2 = R2['PlayerGui']                     -- line -1
--   [  15]   R2 = R2['ConfirmPopup']                  -- line -1
--   R2['Enabled'] = R3
--   [  17]   R2 = _ENV['game']                        -- line -1
--   [  18]   R2 = R2['Players']                       -- line -1
--   [  19]   R2 = R2['LocalPlayer']                   -- line -1
--   [  20]   R2 = R2['PlayerGui']                     -- line -1
--   [  21]   R2 = R2['ConfirmPopup']                  -- line -1
--   [  22]   R2 = R2['ConfirmPopup']                  -- line -1
--   [  23]   R2 = R2['Clone']; R3 = R2                -- line -1
--   [  24] R2..R3 = R2(R3)                            -- line -1
--   [  25]   R3 = _ENV['game']                        -- line -1
--   [  26]   R3 = R3['Players']                       -- line -1
--   [  27]   R3 = R3['LocalPlayer']                   -- line -1
--   [  28]   R3 = R3['PlayerGui']                     -- line -1
--   [  29]   R3 = R3['ConfirmPopup']                  -- line -1
--   R2['Parent'] = R3
--   R2['Name'] = R3
--   [  32]   R3 = R2['Container']                     -- line -1
--   [  33]   R3 = R3['TopBar']                        -- line -1
--   [  34]   R3 = R3['Header']                        -- line -1
--   [  35]   R3 = R3['TopTitleText']                  -- line -1
--   R3['Text'] = R4
--   [  37]   R3 = R2['Container']                     -- line -1
--   [  38]   R3 = R3['Body']                          -- line -1
--   [  39]   R3 = R3['Page']                          -- line -1
--   [  40]   R3 = R3['Contents']                      -- line -1
--   [  41]   R3 = R3['BodyText']                      -- line -1
--   [  42]   R4 = _ENV['tostring']                    -- line -1
--   [  43]   R5 = R1                                  -- line -1
--   [  44] R4..R5 = R4(R5)                            -- line -1
--   R3['Text'] = R4
--   [  46]   R3 = R2['Container']                     -- line -1
--   [  47]   R3 = R3['Body']                          -- line -1
--   [  48]   R3 = R3['Page']                          -- line -1
--   [  49]   R3 = R3['AcceptButton']                  -- line -1
--   [  50]   R3 = R3['MouseButton1Down']              -- line -1
--   [  51]   R3 = R3['Connect']; R4 = R3              -- line -1
--   [  52] R5 = closure(proto 0)                      -- line -1
--   [  53]   R0 = R2                                  -- line -1
--   [  54] R3..R3 = R3(R4, R5)                        -- line -1
--   R2['Visible'] = R3
--   close upvalues >= R2
--   goto L67  (jump +10)
--   [  58]   R2 = _ENV['Popup']                       -- line -1
--   [  59]   R2 = R2['Container']                     -- line -1
--   [  60]   R2 = R2['Body']                          -- line -1
--   [  61]   R2 = R2['Page']                          -- line -1
--   [  62]   R2 = R2['Contents']                      -- line -1
--   [  63]   R2 = R2['BodyText']                      -- line -1
--   [  64]   R3 = _ENV['tostring']                    -- line -1
--   [  65]   R4 = R1                                  -- line -1
--   [  66] R3..R4 = R3(R4)                            -- line -1
--   R2['Text'] = R3
--   [  68] return ...                                 -- line -1
-- 
--     -- function main.p8.p0  params=0 nups=1 lines=0..0
--     [   1]     R0 = _ENV['game']                      -- line -1
--     [   2]     R0 = R0['Players']                     -- line -1
--     [   3]     R0 = R0['LocalPlayer']                 -- line -1
--     [   4]     R0 = R0['PlayerGui']                   -- line -1
--     [   5]     R0 = R0['ConfirmPopup']                -- line -1
--     R0['Enabled'] = R1
--     [   7]     R0 = U0                                -- line -1
--     [   8]     R0 = R0['Destroy']; R1 = R0            -- line -1
--     [   9] R0..R0 = R0(R1)                            -- line -1
--     [  10] return ...                                 -- line -1
-- 
--   -- function main.p9  params=0 nups=0 lines=0..0
--   [   1]   R0 = _ENV['Serverswitchgrund']           -- line -1
--   [   2] if (R0 == true) ~= false then goto next+1  -- line -1
--   goto L36  (jump +33)
--   [   4]   R0 = _ENV['wait']                        -- line -1
--   [   5]   R1 = 1                                   -- line -1
--   [   6] R0..R0 = R0(R1)                            -- line -1
--   [   7]   R0 = _ENV['game']                        -- line -1
--   [   8]   R0 = R0['HttpService']                   -- line -1
--   [   9]   R0 = R0['JSONDecode']; R1 = R0           -- line -1
--   [  10]   R2 = _ENV['game']                        -- line -1
--   [  11]   R2 = R2['HttpGet']; R3 = R2              -- line -1
--   [  12]   R4 = 'https://games.roblox.com/v1/games/2317712696/servers/Public?sortOrder=Asc&limit=100' -- line -1
--   [  13] R2..R-1 = R2(R3, R4)                       -- line -1
--   [  14] R0..R1 = R0()                              -- line -1
--   [  15]   R1 = R0['data']                          -- line -1
--   [  16]   R2 = _ENV['math']                        -- line -1
--   [  17]   R2 = R2['random']                        -- line -1
--   [  18]   R3 = 1                                   -- line -1
--   [  19]   R4 = R0['data']                          -- line -1
--   [  20]   R4 = #R4                                 -- line -1
--   [  21] R2..R3 = R2(R3, R4)                        -- line -1
--   [  22]   R1 = R1[R2]                              -- line -1
--   [  23]   R2 = R1['playing']                       -- line -1
--   [  24]   R3 = R1['maxPlayers']                    -- line -1
--   [  25] if (R2 == R3) ~= true then goto next+1     -- line -1
--   goto L22  (jump -4)
--   [  27]   R2 = _ENV['game']                        -- line -1
--   [  28]   R2 = R2['GetService']; R3 = R2           -- line -1
--   ::L28::
--   [  29]   R4 = 'TeleportService'                   -- line -1
--   [  30] R2..R3 = R2(R3, R4)                        -- line -1
--   [  31]   R2 = R2['TeleportToPlaceInstance']; R3 = R2 -- line -1
--   [  32]   R4 = _ENV['game']                        -- line -1
--   [  33]   R4 = R4['PlaceId']                       -- line -1
--   [  34]   R5 = R1['id']                            -- line -1
--   [  35] R2..R2 = R2(R3, R4, R5)                    -- line -1
--   goto L70  (jump +34)
--   [  37]   R0 = _ENV['ondeathgrind']                -- line -1
--   [  38] if (R0 == true) ~= false then goto next+1  -- line -1
--   goto L67  (jump +28)
--   [  40]   R0 = _ENV['wait']                        -- line -1
--   [  41]   R1 = 8                                   -- line -1
--   [  42] R0..R0 = R0(R1)                            -- line -1
--   [  43]   R0 = _ENV['game']                        -- line -1
--   [  44]   R0 = R0['GetService']; R1 = R0           -- line -1
--   [  45]   R2 = 'VirtualInputManager'               -- line -1
--   [  46] R0..R1 = R0(R1, R2)                        -- line -1
--   [  47]   R0 = R0['SendKeyEvent']; R1 = R0         -- line -1
--   [  48]   R2 = true                                -- line -1
--   [  49]   R3 = _ENV['Enum']                        -- line -1
--   [  50]   R3 = R3['KeyCode']                       -- line -1
--   [  51]   R3 = R3['E']                             -- line -1
--   [  52]   R4 = false                               -- line -1
--   [  53]   R5 = _ENV['game']                        -- line -1
--   [  54] R0..R0 = R0(R1, R2, R3, R4, R5)            -- line -1
--   [  55]   R0 = _ENV['game']                        -- line -1
--   [  56]   R0 = R0['GetService']; R1 = R0           -- line -1
--   [  57]   R2 = 'ReplicatedStorage'                 -- line -1
--   [  58] R0..R1 = R0(R1, R2)                        -- line -1
--   [  59]   R0 = R0['Communication']                 -- line -1
--   [  60]   R0 = R0['Functions']                     -- line -1
--   [  61]   R0 = R0['Respawn']                       -- line -1
--   [  62]   R0 = R0['InvokeServer']; R1 = R0         -- line -1
--   [  63]   R2 = 'Bronze'                            -- line -1
--   [  64] R0..R0 = R0(R1, R2)                        -- line -1
--   [  65]   R0 = _ENV['startnew']                    -- line -1
--   [  66] R0..R0 = R0()                              -- line -1
--   goto L70  (jump +3)
--   [  68]   R0 = _ENV['print']                       -- line -1
--   [  69]   R1 = 'Stoped autofarm'                   -- line -1
--   [  70] R0..R0 = R0(R1)                            -- line -1
--   [  71] return ...                                 -- line -1
-- 
--   -- function main.p10  params=1 nups=0 lines=0..0
--   [   1]   R1 = _ENV['game']                        -- line -1
--   [   2]   R1 = R1['GetService']; R2 = R1           -- line -1
--   [   3]   R3 = 'VirtualInputManager'               -- line -1
--   [   4] R1..R2 = R1(R2, R3)                        -- line -1
--   [   5]   R1 = R1['SendKeyEvent']; R2 = R1         -- line -1
--   [   6]   R3 = true                                -- line -1
--   [   7]   R4 = _ENV['Enum']                        -- line -1
--   [   8]   R4 = R4['KeyCode']                       -- line -1
--   [   9]   R4 = R4['Y']                             -- line -1
--   [  10]   R5 = false                               -- line -1
--   [  11]   R6 = _ENV['game']                        -- line -1
--   [  12] R1..R1 = R1(R2, R3, R4, R5, R6)            -- line -1
--   [  13]   R1 = _ENV['game']                        -- line -1
--   [  14]   R1 = R1['GetService']; R2 = R1           -- line -1
--   [  15]   R3 = 'VirtualInputManager'               -- line -1
--   [  16] R1..R2 = R1(R2, R3)                        -- line -1
--   [  17]   R1 = R1['SendKeyEvent']; R2 = R1         -- line -1
--   [  18]   R3 = false                               -- line -1
--   [  19]   R4 = _ENV['Enum']                        -- line -1
--   [  20]   R4 = R4['KeyCode']                       -- line -1
--   [  21]   R4 = R4['Y']                             -- line -1
--   [  22]   R5 = false                               -- line -1
--   [  23]   R6 = _ENV['game']                        -- line -1
--   [  24] R1..R1 = R1(R2, R3, R4, R5, R6)            -- line -1
--   [  25]   R1 = _ENV['game']                        -- line -1
--   [  26]   R1 = R1['GetService']; R2 = R1           -- line -1
--   [  27]   R3 = 'VirtualInputManager'               -- line -1
--   [  28] R1..R2 = R1(R2, R3)                        -- line -1
--   [  29]   R1 = R1['SendKeyEvent']; R2 = R1         -- line -1
--   [  30]   R3 = true                                -- line -1
--   [  31]   R4 = _ENV['Enum']                        -- line -1
--   [  32]   R4 = R4['KeyCode']                       -- line -1
--   [  33]   R4 = R4['Nine']                          -- line -1
--   [  34]   R5 = false                               -- line -1
--   [  35]   R6 = _ENV['game']                        -- line -1
--   [  36] R1..R1 = R1(R2, R3, R4, R5, R6)            -- line -1
--   [  37]   R1 = _ENV['game']                        -- line -1
--   [  38]   R1 = R1['GetService']; R2 = R1           -- line -1
--   [  39]   R3 = 'VirtualInputManager'               -- line -1
--   [  40] R1..R2 = R1(R2, R3)                        -- line -1
--   [  41]   R1 = R1['SendKeyEvent']; R2 = R1         -- line -1
--   [  42]   R3 = false                               -- line -1
--   [  43]   R4 = _ENV['Enum']                        -- line -1
--   [  44]   R4 = R4['KeyCode']                       -- line -1
--   [  45]   R4 = R4['Nine']                          -- line -1
--   [  46]   R5 = false                               -- line -1
--   [  47]   R6 = _ENV['game']                        -- line -1
--   [  48] R1..R1 = R1(R2, R3, R4, R5, R6)            -- line -1
--   [  49]   R1 = _ENV['game']                        -- line -1
--   [  50]   R1 = R1['GetService']; R2 = R1           -- line -1
--   [  51]   R3 = 'PathfindingService'                -- line -1
--   [  52] R1..R2 = R1(R2, R3)                        -- line -1
--   [  53]   R2 = _ENV['game']                        -- line -1
--   [  54]   R2 = R2['Players']                       -- line -1
--   [  55]   R2 = R2['LocalPlayer']                   -- line -1
--   [  56]   R2 = R2['Character']                     -- line -1
--   [  57]   R2 = R2['WaitForChild']; R3 = R2         -- line -1
--   [  58]   R4 = 'Humanoid'                          -- line -1
--   [  59] R2..R3 = R2(R3, R4)                        -- line -1
--   [  60]   R3 = _ENV['game']                        -- line -1
--   [  61]   R3 = R3['Players']                       -- line -1
--   [  62]   R3 = R3['LocalPlayer']                   -- line -1
--   [  63]   R3 = R3['Character']                     -- line -1
--   [  64]   R3 = R3['WaitForChild']; R4 = R3         -- line -1
--   [  65]   R5 = 'LowerTorso'                        -- line -1
--   [  66] R3..R4 = R3(R4, R5)                        -- line -1
--   [  67]   R4 = R1['CreatePath']; R5 = R1           -- line -1
--   [  68]   R6 = {} size:array=2 hash=0              -- line -1
--   R6['AgentCanClimb'] = R7
--   R6['AgentCanJump'] = R7
--   [  71] R4..R5 = R4(R5, R6)                        -- line -1
--   [  72]   R5 = R4['ComputeAsync']; R6 = R4         -- line -1
--   [  73]   R7 = R3['Position']                      -- line -1
--   [  74]   R8 = R0                                  -- line -1
--   [  75] R5..R5 = R5(R6, R7, R8)                    -- line -1
--   [  76]   R5 = R4['GetWaypoints']; R6 = R4         -- line -1
--   [  77] R5..R6 = R5(R6)                            -- line -1
--   [  78]   R6 = _ENV['pairs']                       -- line -1
--   [  79]   R7 = R5                                  -- line -1
--   [  80] R6..R9 = R6(R7)                            -- line -1
--   goto L98  (jump +17)
--   [  82]   R11 = R10['Action']                      -- line -1
--   [  83]   R12 = _ENV['Enum']                       -- line -1
--   [  84]   R12 = R12['PathWaypointAction']          -- line -1
--   [  85]   R12 = R12['Jump']                        -- line -1
--   [  86] if (R11 == R12) ~= false then goto next+1  -- line -1
--   goto L92  (jump +5)
--   [  88]   R11 = R2['ChangeState']; R12 = R2        -- line -1
--   [  89]   R13 = _ENV['Enum']                       -- line -1
--   [  90]   R13 = R13['HumanoidStateType']           -- line -1
--   [  91]   R13 = R13['Jumping']                     -- line -1
--   [  92] R11..R11 = R11(R12, R13)                   -- line -1
--   [  93]   R11 = R2['MoveTo']; R12 = R2             -- line -1
--   [  94]   R13 = R10['Position']                    -- line -1
--   [  95] R11..R11 = R11(R12, R13)                   -- line -1
--   [  96]   R11 = R2['MoveToFinished']               -- line -1
--   [  97]   R11 = R11['Wait']; R12 = R11             -- line -1
--   [  98] R11..R11 = R11(R12)                        -- line -1
--   [  99] for-in R6 (n=2) goto ?                     -- line -1
--   goto L81  (jump -19)
--   [ 101]   R6 = _ENV['game']                        -- line -1
--   ::L101::
--   [ 102]   R6 = R6['GetService']; R7 = R6           -- line -1
--   [ 103]   R8 = 'VirtualInputManager'               -- line -1
--   [ 104] R6..R7 = R6(R7, R8)                        -- line -1
--   [ 105]   R6 = R6['SendKeyEvent']; R7 = R6         -- line -1
--   [ 106]   R8 = true                                -- line -1
--   [ 107]   R9 = _ENV['Enum']                        -- line -1
--   [ 108]   R9 = R9['KeyCode']                       -- line -1
--   [ 109]   R9 = R9['Y']                             -- line -1
--   [ 110]   R10 = false                              -- line -1
--   [ 111]   R11 = _ENV['game']                       -- line -1
--   [ 112] R6..R6 = R6(R7, R8, R9, R10, R11)          -- line -1
--   [ 113]   R6 = _ENV['game']                        -- line -1
--   [ 114]   R6 = R6['GetService']; R7 = R6           -- line -1
--   [ 115]   R8 = 'VirtualInputManager'               -- line -1
--   [ 116] R6..R7 = R6(R7, R8)                        -- line -1
--   [ 117]   R6 = R6['SendKeyEvent']; R7 = R6         -- line -1
--   [ 118]   R8 = false                               -- line -1
--   [ 119]   R9 = _ENV['Enum']                        -- line -1
--   [ 120]   R9 = R9['KeyCode']                       -- line -1
--   [ 121]   R9 = R9['Y']                             -- line -1
--   [ 122]   R10 = false                              -- line -1
--   [ 123]   R11 = _ENV['game']                       -- line -1
--   [ 124] R6..R6 = R6(R7, R8, R9, R10, R11)          -- line -1
--   [ 125]   R6 = _ENV['game']                        -- line -1
--   [ 126]   R6 = R6['GetService']; R7 = R6           -- line -1
--   [ 127]   R8 = 'VirtualInputManager'               -- line -1
--   [ 128] R6..R7 = R6(R7, R8)                        -- line -1
--   [ 129]   R6 = R6['SendKeyEvent']; R7 = R6         -- line -1
--   [ 130]   R8 = true                                -- line -1
--   [ 131]   R9 = _ENV['Enum']                        -- line -1
--   [ 132]   R9 = R9['KeyCode']                       -- line -1
--   [ 133]   R9 = R9['Nine']                          -- line -1
--   [ 134]   R10 = false                              -- line -1
--   [ 135]   R11 = _ENV['game']                       -- line -1
--   [ 136] R6..R6 = R6(R7, R8, R9, R10, R11)          -- line -1
--   [ 137]   R6 = _ENV['game']                        -- line -1
--   [ 138]   R6 = R6['GetService']; R7 = R6           -- line -1
--   [ 139]   R8 = 'VirtualInputManager'               -- line -1
--   [ 140] R6..R7 = R6(R7, R8)                        -- line -1
--   [ 141]   R6 = R6['SendKeyEvent']; R7 = R6         -- line -1
--   [ 142]   R8 = false                               -- line -1
--   [ 143]   R9 = _ENV['Enum']                        -- line -1
--   [ 144]   R9 = R9['KeyCode']                       -- line -1
--   [ 145]   R9 = R9['Nine']                          -- line -1
--   [ 146]   R10 = false                              -- line -1
--   [ 147]   R11 = _ENV['game']                       -- line -1
--   [ 148] R6..R6 = R6(R7, R8, R9, R10, R11)          -- line -1
--   [ 149] return ...                                 -- line -1
-- 
-- -- ===== string constants =====
-- --   '1220.09, -5.76381, -1125.53'
-- --   '1230.74, -8.29322, -1133.89'
-- --   '1251.61, 2.02644, -1222.52'
-- --   '1260.56, 0.64796, -1183.46'
-- --   '1264.35, -24.20690, -1053.62'
-- --   '30 / 30'
-- --   'AcceptButton'
-- --   'Action'
-- --   'ActionBindsFeed'
-- --   'AgentCanClimb'
-- --   'AgentCanJump'
-- --   'Anchored'
-- --   'Base'
-- --   'Body'
-- --   'BodyText'
-- --   'BottomBar'
-- --   'BreakFree'
-- --   'Bronze'
-- --   'Bronze City'
-- --   'Bucks'
-- --   'Buildings'
-- --   'CanCollide'
-- --   'ChangeState'
-- --   'Changed'
-- --   'Character'
-- --   'ChildAdded'
-- --   'Clone'
-- --   'Color'
-- --   'Color3'
-- --   'Communication'
-- --   'ComputeAsync'
-- --   'ConfirmPopup'
-- --   'Connect'
-- --   'Container'
-- --   'Contents'
-- --   'CoreGui'
-- --   'CreatePath'
-- --   'DepositInfo'
-- --   'Destroy'
-- --   'DiscordName'
-- --   'Door'
-- --   'ERRORPROMPT'
-- --   'Enabled'
-- --   'Enum'
-- --   'Error'
-- --   'ErrorFrame'
-- --   'ErrorPrompt'
-- --   'FindFirstChild'
-- --   'ForceField'
-- --   'Four'
-- --   'Functions'
-- --   'GetChildren'
-- --   'GetDescendants'
-- --   'GetService'
-- --   'GetUp'
-- --   'GetWaypoints'
-- --   'Header'
-- --   'Heartbeat'
-- --   'HotBar'
-- --   'Hotbar'
-- --   'HotbarList'
-- --   'HotbarSlot_Utility_1'
-- --   'HttpGet'
-- --   'HttpService'
-- --   'Humanoid'
-- --   'HumanoidStateType'
-- --   'ImageColor3'
-- --   'InputBegan'
-- --   'Instance'
-- --   'Inventory'
-- --   'InventoryUI'
-- --   'InvokeServer'
-- --   'JSONDecode'
-- --   'Jump'
-- --   'Jumping'
-- --   'KeyCode'
-- --   'KeyCode ERROR'
-- --   'LASSO'
-- --   'LoadingGate'
-- --   'LocalPlayer'
-- --   'LowerTorso'
-- --   'Material'
-- --   'MeshPart'
-- --   'MessageArea'
-- --   'MineTime'
-- --   'MineralPosition'
-- --   'Mining'
-- --   'Mining Stats'
-- --   'Money'
-- --   'MouseButton1Down'
-- --   'MoveTo'
-- --   'MoveToFinished'
-- --   'Name'
-- --   'NewGeneralStore'
-- --   'Nine'
-- --   'NumSlots'
-- --   'OreDeposits'
-- --   'OreRemaining'
-- --   'Page'
-- --   'Parent'
-- --   'Part'
-- --   'PassThrough'
-- --   'PathWaypointAction'
-- --   'PathfindingModifier'
-- --   'PathfindingService'
-- --   'PlaceId'
-- --   'PlayerDataFrame'
-- --   'PlayerGui'
-- --   'PlayerInfo'
-- --   'Players'
-- --   'Popup'
-- --   'Position'
-- --   'Primary'
-- --   'PrimaryPart'
-- --   'Prompts'
-- --   'REGION_Plains'
-- --   'ReplicatedStorage'
-- --   'Respawn'
-- --   'Return'
-- --   'RobloxPromptGui'
-- --   'Rotation'
-- --   'RunService'
-- --   'SendKeyEvent'
-- --   'SendMouseButtonEvent'
-- --   'Serverswitchgrund'
-- --   'Size'
-- --   'Slot'
-- --   'StatBars'
-- --   'Stoped autofarm'
-- --   'Stroke_3px'
-- --   'TeleportService'
-- --   'TeleportToPlaceInstance'
-- --   'Text'
-- --   'TopBar'
-- --   'TopTitleText'
-- --   'Transparency'
-- --   'UserInputService'
-- --   'Value'
-- --   'Vector3'
-- --   'VirtualInputManager'
-- --   'Visible'
-- --   'WORKSPACE_Geometry'
-- --   'WORKSPACE_Interactables'
-- --   'Wait'
-- --   'WaitForChild'
-- --   'WalkSpeed'
-- --   'Workspace'
-- --   'You died'
-- --   'You have mined in total: %d.\nYou are in this server since: %dh %dm %ds.\nYou have earned a total of: %d$.\n'
-- --   'data'
-- --   'floor'
-- --   'format'
-- --   'fromRGB'
-- --   'game'
-- --   'gsub'
-- --   'https://games.roblox.com/v1/games/2317712696/servers/Public?sortOrder=Asc&limit=100'
-- --   'magnitude'
-- --   'match'
-- --   'math'
-- --   'maxPlayers'
-- --   'oldtoping'
-- --   'ondeathgrind'
-- --   'pairs'
-- --   'playing'
-- --   'print'
-- --   'promptOverlay'
-- --   'random'
-- --   'respawnVisible'
-- --   'startnew'
-- --   'string'
-- --   'tick'
-- --   'toping'
-- --   'tostring'
-- --   'wait'
