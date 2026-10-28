local function f1(p1, p2, p3, p4)
  local v1 = p2
  local v2 = p1
  local v3 = p4
  local v4 = p3
  local v5 = {}
  local boxHandleAdornment = Instance.new("BoxHandleAdornment")

  local vector = p4
  vector = p4 and Vector3.new(4, 6, 4)

  local v6 = vector

  do
  end

  boxHandleAdornment.Size = vector or Vector3.new(4, 4, 4)
  boxHandleAdornment.AlwaysOnTop = true
  boxHandleAdornment.ZIndex = 5
  boxHandleAdornment.Transparency = 0.5
  boxHandleAdornment.Color3 = p3
  boxHandleAdornment.Adornee = p1
  boxHandleAdornment.Parent = p1

  v5.box = boxHandleAdornment

  local billboardGui = Instance.new("BillboardGui")
  billboardGui.Size = UDim2.new(0, 150, 0, 40)
  billboardGui.StudsOffset = Vector3.new(0, 4.5, 0)
  billboardGui.AlwaysOnTop = true
  billboardGui.Adornee = p1
  billboardGui.Parent = p1

  local instance = Instance.new("TextLabel", billboardGui)
  instance.Size = UDim2.new(1, 0, 1, 0)
  instance.BackgroundTransparency = 1
  instance.TextColor3 = p3
  instance.TextSize = 12
  instance.Font = Enum.Font.GothamBold
  instance.Text = p2
  instance.TextStrokeTransparency = 0.5

  v5.gui = billboardGui
  v5.label = instance

  return v5
end

do
end

local dist = ((loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua")))())

do
end

local players = (game:GetService("Players"))

do
end

local runService = (game:GetService("RunService"))
local v7 = game

local v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23, v24, v25,
  v26

v7:GetService("TweenService")

do
end

local workspace = (game:GetService("Workspace"))

do
end

game:GetService("Teams")

do
end

local replicatedStorage = (game:GetService("ReplicatedStorage"))

do
end

local lighting = (game:GetService("Lighting"))
local localPlayer = players.LocalPlayer
local survivorESP = false
local killerESP = false
local v27 = false
local v28 = false
local v29 = lighting
local outdoorAmbient = lighting.OutdoorAmbient
local ambient = lighting.Ambient
local v30 = outdoorAmbient
local v31 = {}
local v32 = {}
local v33 = {}
local v34 = false

local function f2()
  local currentCamera = workspace.CurrentCamera

  local vector2 = Vector2.new(
    currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2
  )

  local v35 = 200
  local v36 = players
  local v37, v38, v39, v40, v41, head

  for index, value in ipairs(players:GetPlayers()) do
    do
    end

    do
    end

    if value ~= localPlayer and value.Character then
      do
      end

      if value.Team == localPlayer.Team then
      else
        do
        end

        head = value.Character:FindFirstChild("Head")

        if head then
          local v42
          v42 = { currentCamera:WorldToViewportPoint(head.Position) }

          local v43
          v43 = v42[1]

          if v42[2] then
            local magnitude
            magnitude = (vector2 - (Vector2.new(v43.X, v43.Y))).Magnitude

            if magnitude < v35 then
              v35 = magnitude
              v37 = value
            end
          end
        end
      end
    else
    end
  end

  return v37
end

local v44 = localPlayer
localPlayer:GetMouse()

do
end

game:GetService("VirtualInputManager")

local function f3(p5, p6)
  local v45 = p6
  local v46 = p5

  if (type(v45)) == "string" then
    v45 = { v45 }
  end

  for index2, value2 in ipairs(p5:GetChildren()) do
    local v47
    v47 = string.lower(value2.Name)

    for index3, value3 in ipairs(v45) do
      if (string.find(v47, string.lower(value3))) then
        return value2
      end
    end
  end

  return nil
end

local function f4(p7)
  local v48 = p7

  do
  end

  do
  end

  if not p7 or not p7.Team then
    return false
  else
    return (string.find((string.lower(p7.Team.Name)), "killer")) ~= nil
  end
end

local function f5()
  local v49 = replicatedStorage
  local remotes = replicatedStorage:FindFirstChild("Remotes")
  local v50 = remotes
  local v51, v52

  if remotes then
    do
    end

    local generator
    generator = replicatedStorage.Remotes:FindFirstChild("Generator")

    local repairEvent
    repairEvent = generator

    if generator then
      do
      end

      repairEvent = replicatedStorage.Remotes.Generator:FindFirstChild("RepairEvent")
    end

    v50 = repairEvent
  end

  return v50
end

local v53 = f3

local function f6()
  local v54 = {}
  local v55 = workspace

  for index4, value4 in ipairs(workspace:GetDescendants()) do
    local v56
    v56 = value4.Name == "Generator"

    local v57
    v57 = v56

    do
    end

    if v56 and value4:IsA("Model") then
      table.insert(v54, value4)
    end
  end

  return v54
end

local function f7(p8)
  local v58 = p8

  for i = 1, 4 do
    local findFirstChild
    findFirstChild = p8:FindFirstChild("GeneratorPoint" .. i)

    local v59
    v59 = findFirstChild

    do
    end

    if findFirstChild and findFirstChild:IsA("BasePart") then
      return findFirstChild
    end
  end

  local primaryPart = p8.PrimaryPart
  local v60 = primaryPart

  do
  end

  return primaryPart or p8:FindFirstChildWhichIsA("BasePart")
end

local v61 = f5
local v62 = f4
local v63 = f6
local v64 = f7
local v65 = f1
local v66 = dist

local anchHaxWindow = (dist:CreateWindow({
  Title = "ANCH Hax",
  Author = "by ANCH",
  Icon = "anchor",
  Folder = "ANCHHax",
  OpenButton = {
    Enabled = true,
    Draggable = false,
    OnlyIcon = false,
    CornerRadius = (UDim.new(1, 0)),
    StrokeThickness = 3,
    Title = "ANCH Hax",
    Color = (ColorSequence.new((Color3.fromHex("#30FF6A")), Color3.fromHex("#e7ff2f"))),
  },
}))

local v67 = anchHaxWindow
anchHaxWindow:Tag({ Title = "V2.0", Color = (Color3.fromHex("#18c426")), Border = true })
local v68 = anchHaxWindow
anchHaxWindow:DisableTopbarButtons({ "Fullscreen" })
local v69 = anchHaxWindow

local infoTab = anchHaxWindow:Tab({
  Title = "Info",
  Desc = "Important Information & Updates",
  Icon = "solar:info-circle-bold",
  IconColor = (Color3.fromRGB(255, 170, 50)),
  IconShape = "Square",
  Border = true,
})

infoTab:Section({
  Title = "Hello " .. localPlayer.Name .. "!",
  TextSize = 20,
  FontWeight = Enum.FontWeight.SemiBold,
})

infoTab:Section({
  Title = "⚠️ Development Notice:\n\nThis script is still under development!\nThere is a possibility it may get detected if used in public servers.\n\nNeed help or just wanna hang out?\nJoin our Discord server below!",
  TextSize = 18,
  TextTransparency = 0.35,
  FontWeight = Enum.FontWeight.SemiBold,
  Box = true,
  BoxBorder = true,
  Opened = true,
})

local url

do
end

url = "https://discord.com/api/v10/invites/RbPdBpV4Mc?with_counts=true&with_expiration=true"

local v70, v71 = pcall(function()
  do
  end

  local httpService = game:GetService("HttpService")

  do
  end

  local httpService2 = game:GetService("HttpService")

  return httpService:JSONDecode((httpService2:RequestAsync({
    Url = url,
    Method = "GET",
    Headers = { ["User-Agent"] = "ANCH-Hub/1.0", Accept = "application/json" },
  })).Body)
end)

local guild = v70

if v70 then
  do
  end

  guild = v71 and v71.guild
end

if guild then
  infoTab:Section({
    Title = "💬 Join our Discord server!",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
  })

  infoTab:Space()

  local title
  title = tostring(v71.guild.name)

  local v72
  v72 = tostring

  do
  end

  do
  end

  local desc
  desc = v72(v71.guild.description or "Official ANCH Hub Discord Server")

  local image

  image = "https://cdn.discordapp.com/icons/" .. v71.guild.id .. "/" .. v71.guild.icon
    .. ".png?size=1024"

  do
  end

  do
  end

  do
  end

  infoTab:Paragraph({
    Title = title,
    Desc = desc,
    Image = image,
    Thumbnail = v71.guild.banner
        and "https://cdn.discordapp.com/banners/" .. v71.guild.id .. "/" .. v71.guild.banner
          .. ".png?size=512"
      or nil,
    ImageSize = 48,
    Buttons = {
      {
        Title = "Copy link",
        Icon = "link",
        Callback = function()
          if setclipboard then
            setclipboard("https://discord.gg/RbPdBpV4Mc")

            local v73
            v73 = dist

            dist:Notify({
              Title = "Discord Link Copied!",
              Content = "Link has been copied to clipboard.",
            })
          else
            local v74
            v74 = dist

            dist:Notify({
              Title = "Clipboard Not Supported",
              Content = "Check console for link.",
            })

            print("Discord: https://discord.gg/RbPdBpV4Mc")
          end

          return
        end,
      },
      {
        Title = "Open Discord",
        Icon = "solar:chat-round-line-bold",
        Callback = function()
          local v75 = dist
          local v76, v77
          dist:Notify({ Title = "Opening Discord", Content = "Check your browser!" })

          do
          end

          do
          end

          if syn and syn.request then
            syn.request({ Url = "https://discord.gg/RbPdBpV4Mc", Method = "GET" })
          end

          return
        end,
      },
    },
  })

  if v71.approximate_member_count then
    infoTab:Space()

    local v78
    v78 = tostring(v71.approximate_member_count)

    local v79
    v79 = tostring

    do
    end

    do
    end

    do
    end

    do
    end

    do
    end

    do
    end

    infoTab:Section({
      Title = "👥 Members: " .. v78 .. " | 🟢 Online: "
        .. (v79(v71.approximate_presence_count or "N/A")),
      TextSize = 14,
      TextTransparency = 0.4,
      FontWeight = Enum.FontWeight.Regular,
    })
  end
else
  infoTab:Section({
    Title = "💬 Join our Discord server!",
    TextSize = 20,
    FontWeight = Enum.FontWeight.SemiBold,
  })

  infoTab:Space()

  infoTab:Button({
    Title = "Copy Discord Link",
    Color = (Color3.fromHex("#5865F2")),
    Justify = "Center",
    Icon = "solar:chat-round-line-bold",
    IconAlign = "Left",
    Callback = function()
      if setclipboard then
        setclipboard("https://discord.gg/RbPdBpV4Mc")

        local v80
        v80 = dist

        dist:Notify({
          Title = "Discord Link Copied!",
          Content = "Link has been copied to clipboard.",
        })
      else
        print("Discord: https://discord.gg/RbPdBpV4Mc")
      end

      return
    end,
  })
end

infoTab:Space({ Columns = 3 })

local section = infoTab:Section({ Title = "⚠️ Use at your own risk!" })
section:Space()

section:Section({
  Title = "By using ANCH Hub, you acknowledge that:\n\n• This script may be detected by anti-cheat systems\n• Your account could potentially be banned\n• The developer is not responsible for any consequences\n• Always use in private servers when possible",
  TextSize = 15,
  TextTransparency = 0.4,
  FontWeight = Enum.FontWeight.Regular,
})

local creditsInformationSection = infoTab:Section({ Title = "👤 Credits & Information" })
creditsInformationSection:Space()

creditsInformationSection:Section({
  Title = [[
ANCH Hub - Violence District Script

Developer: ANCH
Version: 2.0 (Stable Release)
UI Library: Wind UI by Footagesus
Game: Violence District (Roblox)

Last Updated: ]] .. (os.date("%B %d, %Y")),
  TextSize = 15,
  TextTransparency = 0.35,
  FontWeight = Enum.FontWeight.Regular,
})

local featuresOverviewSection = infoTab:Section({ Title = "✨ Features Overview" })
featuresOverviewSection:Space()

featuresOverviewSection:Section({
  Title = "Current Features:\n\n🎯 Auto-Farm Generator (with killer detection)\n🎁 Auto-Farm Christmas Presents  \n🔫 Auto Aim System\n👁️ ESP for Survivors, Killers & Generators\n🏃 Movement: NoClip, Blink Speed\n📍 Teleportation: Players & Generators\n🔍 Unlimited Camera Zoom\n🌟 Full Bright Lighting\n🎨 Body Lock / Target Lock",
  TextSize = 14,
  TextTransparency = 0.3,
  FontWeight = Enum.FontWeight.Regular,
})

infoTab:Space({ Columns = 2 })

infoTab:Button({
  Title = "Show Keybinds",
  Color = (Color3.fromHex("#30d5ff")),
  Justify = "Center",
  Icon = "solar:keyboard-bold",
  IconAlign = "Left",
  Callback = function()
    local v81 = dist

    dist:Notify({
      Title = "Keybinds",
      Content = [[
RightShift or Insert = Toggle UI
ESC = Close UI]],
    })

    return
  end,
})

infoTab:Space({ Columns = 1 })

infoTab:Button({
  Title = "Changelog",
  Color = (Color3.fromHex("#a2ff30")),
  Justify = "Center",
  Icon = "solar:document-text-bold",
  IconAlign = "Left",
  Callback = function()
    local v82 = dist
    dist:Notify({ Title = "V2.0 Changelog", Content = "All features stable & New UI Design." })
    return
  end,
})

infoTab:Space({ Columns = 1 })

local connect, connect2, connect3, v83

infoTab:Button({
  Title = "Destroy UI",
  Color = (Color3.fromHex("#ff4830")),
  Justify = "Center",
  Icon = "solar:trash-bin-trash-bold",
  IconAlign = "Left",
  Callback = function()
    local v84, v85, v86

    if connect then
      do
      end

      connect:Disconnect()
    end

    if connect2 then
      do
      end

      connect2:Disconnect()
    end

    if connect3 then
      do
      end

      connect3:Disconnect()
    end

    if v83 then
      local v87
      v87 = v83
      v83:Destroy()
    end

    _G.NoSkill = false
    v34 = false
    local v88 = dist
    dist:Notify({ Title = "ANCH Hub", Content = "UI destroyed. Thanks for using!" })
    task.wait(1)
    local v89 = anchHaxWindow
    anchHaxWindow:Destroy()
    return
  end,
})

local v90 = anchHaxWindow

local generalTab = anchHaxWindow:Tab({
  Title = "General",
  Icon = "solar:home-2-bold",
  IconColor = (Color3.fromRGB(255, 170, 50)),
  IconShape = "Square",
  Border = true,
})

generalTab:Toggle({
  Title = "NoClip",
  Desc = "Walk through walls",
  Callback = function(value5)
    local v91, v92

    if value5 then
      do
      end

      connect = (runService.Stepped:Connect(function()
        local v93

        if localPlayer.Character then
          do
          end

          for key, value6 in pairs(localPlayer.Character:GetDescendants()) do
            if (value6:IsA("BasePart")) then
              value6.CanCollide = false
            end
          end
        end

        return
      end))
    else
      if connect then
        do
        end

        connect:Disconnect()
      end
    end

    return
  end,
})

generalTab:Toggle({
  Title = "Flicker/Blink Speed",
  Desc = "Fast movement with blink effect",
  Callback = function(value7)
    local v94 = value7
    local v95, v96

    if value7 then
      do
      end

      connect2 = (runService.Heartbeat:Connect(function()
        local character = localPlayer.Character
        local humanoidRootPart = character
        local v97, v98

        if character then
          do
          end

          humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
        end

        local v99 = humanoidRootPart

        do
        end

        if v99 and v99.AssemblyLinearVelocity.Magnitude > 0.1 then
          v99.CFrame = v99.CFrame + v99.CFrame.lookVector * 0.5
        end

        return
      end))
    else
      if connect2 then
        do
        end

        connect2:Disconnect()
      end
    end

    return
  end,
})

generalTab:Space({ Columns = 2 })

generalTab:Section({
  Title = "Teleportation",
  TextSize = 20,
  FontWeight = Enum.FontWeight.SemiBold,
})

generalTab:Space()

local v100

local dropdown = (generalTab:Dropdown({
  Title = "Select Player Target",
  Values = {},
  Callback = function(value8)
    v100 = value8
    return
  end,
}))

local selectTargetDropdown

generalTab:Button({
  Title = "Refresh Player List",
  Icon = "solar:refresh-bold",
  Callback = function()
    local v101 = {}
    local v102 = players
    local v103

    for index5, value9 in ipairs(players:GetPlayers()) do
      if value9 ~= localPlayer then
        table.insert(v101, value9.Name)
      end
    end

    local v104 = dropdown
    dropdown:Refresh(v101)

    if selectTargetDropdown then
      do
      end

      selectTargetDropdown:Refresh(v101)
    end

    local v105 = dist
    dist:Notify({ Title = "Player List", Content = "Refreshed! Found " .. #v101 .. " players." })
    return
  end,
})

generalTab:Button({
  Title = "TP to Selected Player",
  Icon = "solar:user-bold",
  Color = (Color3.fromHex("#30d5ff")),
  Callback = function()
    local v106 = players

    do
    end

    local v107 = v100 or ""
    local v108 = players
    local findFirstChild2 = players:FindFirstChild(v107)
    local v109 = findFirstChild2
    local v110

    if findFirstChild2 then
      local character2
      character2 = findFirstChild2.Character

      local humanoidRootPart2
      humanoidRootPart2 = character2

      if character2 then
        do
        end

        humanoidRootPart2 = findFirstChild2.Character:FindFirstChild("HumanoidRootPart")
      end

      v109 = humanoidRootPart2
    end

    if v109 then
      localPlayer.Character.HumanoidRootPart.CFrame = findFirstChild2.Character.HumanoidRootPart.CFrame
        * (CFrame.new(0, 3, 0))

      local v111
      v111 = dist

      dist:Notify({ Title = "Teleported", Content = "Teleported to " .. findFirstChild2.Name })
    else
      local v112
      v112 = dist
      dist:Notify({ Title = "Error", Content = "Player not found or invalid!" })
    end

    return
  end,
})

generalTab:Space({ Columns = 1 })

local v113

local dropdown2 = (generalTab:Dropdown({
  Title = "Select Generator Target",
  Values = {},
  Callback = function(value10)
    v113 = value10
    return
  end,
}))

generalTab:Button({
  Title = "Refresh Generator List",
  Icon = "solar:refresh-bold",
  Callback = function()
    v33 = {}
    local v114 = {}

    for index6, value11 in ipairs(f6()) do
      local v115
      v115 = "Generator " .. index6

      v33[v115] = value11
      table.insert(v114, v115)
    end

    local v116 = dropdown2
    dropdown2:Refresh(v114)
    local v117 = dist
    dist:Notify({ Title = "Generator List", Content = "Found " .. #v114 .. " generators." })
    return
  end,
})

generalTab:Button({
  Title = "TP to Selected Generator",
  Icon = "solar:electric-refueling-bold",
  Color = (Color3.fromHex("#a2ff30")),
  Callback = function()
    do
    end

    local v118 = v113 and v33[v113]

    if v118 then
      local v119
      v119 = f7(v33[v113])

      if v119 then
        localPlayer.Character.HumanoidRootPart.CFrame = v119.CFrame * (CFrame.new(0, 3, 3))

        local v120
        v120 = dist

        dist:Notify({ Title = "Teleported", Content = "Teleported to " .. v113 })
      end
    else
      local v121
      v121 = dist
      dist:Notify({ Title = "Error", Content = "Please select a generator first!" })
    end

    return
  end,
})

local v122 = anchHaxWindow

local survivorTab = anchHaxWindow:Tab({
  Title = "Survivor",
  Icon = "solar:check-square-bold",
  IconColor = (Color3.fromRGB(255, 170, 50)),
  IconShape = "Square",
  Border = true,
})

survivorTab:Toggle({
  Title = "Auto-Farm Generator",
  Desc = "Auto teleport & complete generator",
  Callback = function(value12)
    local v123 = value12
    v28 = value12

    if value12 then
      task.spawn(function()
        local v124, v125, v126, v127

        while v28 do
          local v128
          v128 = f5()

          local v129
          v129 = {}

          for index7, value13 in ipairs((f6())) do
            if ((value13:GetAttribute("RepairProgress")) or 0) < 100 then
              table.insert(v129, value13)
            end
          end

          do
          end

          do
          end

          if #v129 > 0 and v128 then
            local v130
            v130 = v129[(math.random(1, #v129))]

            local v131
            v131 = f7(v130)

            localPlayer.Character.HumanoidRootPart.CFrame = v131.CFrame * (CFrame.new(0, 2, 3))
            task.wait(0.5)
            v128:FireServer(v131, true)

            if v28 then
              v130:GetAttribute("RepairProgress")
            end

            repeat
              task.wait(0.5)

              local v132
              v132 = players

              local v133
              v133 = false

              for index8, value14 in ipairs(players:GetPlayers()) do
                local v134
                v134 = f4(value14)

                local v135
                v135 = v134

                if v134 then
                  local character3
                  character3 = value14.Character

                  local humanoidRootPart3
                  humanoidRootPart3 = character3

                  if character3 then
                    do
                    end

                    humanoidRootPart3 = value14.Character:FindFirstChild("HumanoidRootPart")
                  end

                  v135 = humanoidRootPart3
                end

                if v135 then
                  if (localPlayer.Character.HumanoidRootPart.Position
                      - value14.Character.HumanoidRootPart.Position).Magnitude
                    < 100 then
                    v133 = true
                    break
                  else
                  end
                else
                end
              end

              if v133 then
                break
              else
                local v136
                v136 = not v28

                v127 = v136
                v127 = v136 or ((v130:GetAttribute("RepairProgress")) or 0) >= 100
              end
            until v127

            v128:FireServer(v131, false)
            task.wait(1.5)
          else
            task.wait(2)
          end
        end

        return
      end)
    end

    return
  end,
})

local v137 = false

survivorTab:Toggle({
  Title = "Auto-Farm Present",
  Desc = "Farm Gift → Teleport to Christmas Tree",
  Callback = function(value15)
    local v138 = value15
    v137 = value15

    if value15 then
      local v139
      v139 = dist

      dist:Notify({ Title = "Auto-Farm Present", Content = "Started!" })

      task.spawn(function()
        while v137 do
          local v140

          v140 = {
            pcall(function()
              local v141 = workspace
              local map = workspace:FindFirstChild("Map")
              local v142

              if not map then
                task.wait(3)
                return
              else
                local v143
                v143 = f3(map, { "chris", "christmas" })

                if not v143 then
                  task.wait(3)
                  return
                else
                  local v144
                  v144 = f3(v143, { "gift" })

                  if not v144 then
                    task.wait(3)
                    return
                  else
                    local v145
                    v145 = {}

                    for index9, value16 in ipairs(v144:GetChildren()) do
                      if (string.find((string.lower(value16.Name)), "gift")) then
                        local giftHandle
                        giftHandle = value16:FindFirstChild("GiftHandle")

                        local basePart
                        basePart = giftHandle
                        basePart = giftHandle or value16:FindFirstChildWhichIsA("BasePart")

                        if basePart then
                          table.insert(v145, { model = value16, handle = basePart })
                        end
                      end
                    end

                    if #v145 == 0 then
                      local v146
                      v146 = dist

                      dist:Notify({ Title = "Info", Content = "No gifts available, waiting..." })
                      task.wait(3)
                      return
                    else
                      local v147
                      v147 = v145[1]

                      local character4
                      character4 = localPlayer.Character

                      local humanoidRootPart4
                      humanoidRootPart4 = character4

                      if character4 then
                        do
                        end

                        humanoidRootPart4 = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                      end

                      if humanoidRootPart4 then
                        localPlayer.Character.HumanoidRootPart.CFrame = v147.handle.CFrame
                          * (CFrame.new(0, 3, 0))

                        task.wait(0.8)

                        local v148
                        v148 = replicatedStorage

                        local remotes2
                        remotes2 = replicatedStorage:FindFirstChild("Remotes")

                        if remotes2 then
                          local events
                          events = remotes2:FindFirstChild("Events")

                          if events then
                            local christmas
                            christmas = events:FindFirstChild("Christmas")

                            if christmas then
                              local gift
                              gift = christmas:FindFirstChild("gift")

                              if gift then
                                gift:FireServer(v147.model)
                                task.wait(0.8)
                              else
                                local v149
                                v149 = dist

                                dist:Notify({
                                  Title = "Error",
                                  Content = "Gift remote not found!",
                                })
                              end
                            end
                          end
                        end

                        local v150
                        v150 = f3(v143, { "tree", "tute" })

                        if v150 then
                          local basePart2
                          basePart2 = nil

                          for index10, value17 in ipairs((v150:GetChildren())) do
                            local christmasTree
                            christmasTree = value17:FindFirstChild("ChristmasTree")

                            if christmasTree then
                              local treePine
                              treePine = christmasTree:FindFirstChild("TreePine")

                              local v151
                              v151 = treePine

                              do
                              end

                              basePart2 = treePine
                                or christmasTree:FindFirstChildWhichIsA("BasePart")

                              if basePart2 then
                                break
                              else
                              end
                            else
                              basePart2 = value17:FindFirstChildWhichIsA("BasePart")

                              if basePart2 then
                                break
                              else
                              end
                            end
                          end

                          if basePart2 then
                            localPlayer.Character.HumanoidRootPart.CFrame = basePart2.CFrame
                              * (CFrame.new(0, 5, 3))

                            task.wait(1.5)
                          else
                          end
                        else
                        end

                        task.wait(2)
                      end

                      return
                    end
                  end
                end
              end
            end),
          }

          local v152
          v152 = v140[2]

          if not v140[1] then
            local v153
            v153 = dist

            dist:Notify({ Title = "Critical Error", Content = (tostring(v152)) })
            task.wait(3)
          end
        end

        return
      end)
    else
      local v154
      v154 = dist
      dist:Notify({ Title = "Auto-Farm Present", Content = "Stopped!" })
    end

    return
  end,
})

survivorTab:Toggle({
  Title = "No Skill Check",
  Desc = "Remove Generator & Healing Skill Check",
  Callback = function(value18)
    _G.NoSkill = value18

    task.spawn(function()
      local v155

      while _G.NoSkill do
        local v156
        v156 = localPlayer

        local findFirstChild3
        findFirstChild3 = localPlayer:FindFirstChild("PlayerGui", true)

        local findFirstChild4
        findFirstChild4 = findFirstChild3

        if findFirstChild3 then
          do
          end

          findFirstChild4 = localPlayer.PlayerGui:FindFirstChild("Skillcheck-gen", true)
        end

        local v157
        v157 = findFirstChild4

        if v157 then
          v157:Destroy()
        end

        task.wait(0.1)
      end

      return
    end)

    return
  end,
})

local v158 = anchHaxWindow

local killerTab = anchHaxWindow:Tab({
  Title = "Killer",
  Icon = "solar:ghost-bold",
  IconColor = (Color3.fromRGB(255, 170, 50)),
  IconShape = "Square",
  Border = true,
})

selectTargetDropdown = (killerTab:Dropdown({
  Title = "Select Target",
  Values = {},
  Callback = function(value19)
    v100 = value19
    return
  end,
}))

killerTab:Button({
  Title = "Refresh Player List",
  Callback = function()
    local v159 = {}
    local v160 = players

    for index11, value20 in ipairs(players:GetPlayers()) do
      if value20 ~= localPlayer then
        table.insert(v159, value20.Name)
      end
    end

    local v161 = selectTargetDropdown
    selectTargetDropdown:Refresh(v159)

    if dropdown then
      local v162
      v162 = dropdown
      dropdown:Refresh(v159)
    end

    return
  end,
})

killerTab:Toggle({
  Title = "Body Lock",
  Desc = "Select Target from Dropdown",
  Callback = function(value21)
    local v163 = value21
    local v164, v165

    if value21 then
      do
      end

      connect3 = (runService.Heartbeat:Connect(function()
        local v166 = players

        do
        end

        local v167 = v100 or ""
        local v168 = players
        local findFirstChild5 = players:FindFirstChild(v167)
        local v169 = findFirstChild5
        local v170

        if findFirstChild5 then
          local character5
          character5 = findFirstChild5.Character

          local humanoidRootPart5
          humanoidRootPart5 = character5

          if character5 then
            do
            end

            humanoidRootPart5 = findFirstChild5.Character:FindFirstChild("HumanoidRootPart")
          end

          v169 = humanoidRootPart5
        end

        if v169 then
          localPlayer.Character.HumanoidRootPart.CFrame = findFirstChild5.Character.HumanoidRootPart.CFrame
            * (CFrame.new(0, 0, 1.5))
        end

        return
      end))
    else
      if connect3 then
        do
        end

        connect3:Disconnect()
      end
    end

    return
  end,
})

local v171 = anchHaxWindow

local visualsTab = anchHaxWindow:Tab({
  Title = "Visuals",
  Icon = "solar:eye-bold",
  IconColor = (Color3.fromRGB(255, 170, 50)),
  IconShape = "Square",
  Border = true,
})

visualsTab:Toggle({
  Title = "Survivor ESP",
  Desc = "Enable ESP to Survivor (Blue)",
  Callback = function(value22)
    survivorESP = value22
    return
  end,
})

visualsTab:Toggle({
  Title = "Killer ESP",
  Desc = "Enable ESP to Killer (Red)",
  Callback = function(value23)
    killerESP = value23
    return
  end,
})

visualsTab:Toggle({
  Title = "Generator ESP",
  Desc = "Enable ESP to Generator",
  Callback = function(value24)
    local v172 = value24
    local v173, v174
    v27 = value24

    if not value24 then
      for key2, value25 in pairs(v32) do
        do
        end

        value25.box:Destroy()

        do
        end

        value25.gui:Destroy()
      end

      v32 = {}
    end

    return
  end,
})

visualsTab:Toggle({
  Title = "Unlimited Zoom",
  Desc = "Make your vision longer",
  Callback = function(value26)
    if value26 then
      localPlayer.CameraMaxZoomDistance = 100
    else
      localPlayer.CameraMaxZoomDistance = 30
    end

    return
  end,
})

visualsTab:Toggle({
  Title = "Full Bright",
  Desc = "Full Bright for Map",
  Callback = function(value27)
    local v175 = lighting
    local v176 = value27
    local v177, v178
    lighting.Brightness = value27 and 2 or 1
    local v179 = lighting
    local v180 = value27

    do
    end

    do
    end

    lighting.Ambient = value27 and Color3.new(1, 1, 1) or ambient
    local v181 = lighting
    local v182 = value27

    do
    end

    do
    end

    lighting.OutdoorAmbient = value27 and Color3.new(1, 1, 1) or outdoorAmbient
    return
  end,
})

do
end

runService.Heartbeat:Connect(function()
  local v183 = players
  local v184, v185, v186, v187, v188, v189, v190, v191, v192

  for index12, value28 in ipairs(players:GetPlayers()) do
    local v193
    v193 = value28 ~= localPlayer

    local v194
    v194 = v193

    if v193 then
      local character6
      character6 = value28.Character

      local humanoidRootPart6
      humanoidRootPart6 = character6

      if character6 then
        do
        end

        humanoidRootPart6 = value28.Character:FindFirstChild("HumanoidRootPart")
      end

      v194 = humanoidRootPart6
    end

    if v194 then
      local v195
      v195 = f4

      local v196
      v196 = f4(value28)

      local v197
      v197 = v196 and killerESP

      local v198
      v198 = v197

      if not v197 then
        do
        end

        do
        end

        v198 = not v196 and survivorESP
      end

      if v198 then
        if not v31[value28] then
          local color
          color = v196
          color = v196 and Color3.new(1, 0, 0)

          local color2
          color2 = color
          color2 = color or Color3.new(0, 0.5, 1)

          v31[value28] = f1(value28.Character.HumanoidRootPart, value28.Name, color2, true)
        else
          local v199

          v199 = math.floor((localPlayer.Character.HumanoidRootPart.Position
            - value28.Character.HumanoidRootPart.Position).Magnitude)

          local label
          label = v31[value28].label

          local v200
          v200 = label

          local name
          name = value28.Name

          do
          end

          local v201
          v201 = v196 and " [KILLER]" or " [SURVIVOR]"

          local v202
          v202 = label

          label.Text = name .. v201 .. "\n" .. v199 .. "m"
        end
      else
        if v31[value28] then
          do
          end

          v31[value28].box:Destroy()

          do
          end

          v31[value28].gui:Destroy()
          v31[value28] = nil
        end
      end
    end
  end

  if v27 then
    for index13, value29 in ipairs(f6()) do
      local v203
      v203 = f7

      local v204
      v204 = f7(value29)

      local repairProgress
      repairProgress = (value29:GetAttribute("RepairProgress")) or 0

      do
      end

      if v204 and repairProgress < 100 then
        if not v32[value29] then
          v32[value29] = f1(v204, "Generator", (Color3.new(0, 1, 0.5)), false)
        else
          local v205
          v205 = math.floor((localPlayer.Character.HumanoidRootPart.Position - v204.Position).Magnitude)

          v32[value29].label.Text = "Gen " .. index13 .. " [" .. (math.floor(repairProgress)) .. [[
%]
]] .. v205 .. "m"
        end
      else
        if v32[value29] then
          do
          end

          v32[value29].box:Destroy()

          do
          end

          v32[value29].gui:Destroy()
          v32[value29] = nil
        end
      end
    end
  end

  return
end)

local v206 = anchHaxWindow

do
end

;(anchHaxWindow:Tab({
  Title = "Settings",
  Icon = "solar:settings-bold",
  IconColor = (Color3.fromRGB(255, 170, 50)),
  IconShape = "Square",
  Border = true,
})):Button({
  Title = "Destroy UI",
  Desc = "Destroy UI & Turn Off all Feature",
  Callback = function()
    local v207, v208, v209

    if connect then
      do
      end

      connect:Disconnect()
    end

    if connect2 then
      do
      end

      connect2:Disconnect()
    end

    if connect3 then
      do
      end

      connect3:Disconnect()
    end

    if v83 then
      local v210
      v210 = v83
      v83:Destroy()
    end

    _G.NoSkill = false
    v34 = false
    local v211 = dist
    dist:Notify({ Title = "ANCH Hax", Content = "UI destroyed. Thanks for using!" })
    task.wait(1)
    local v212 = anchHaxWindow
    anchHaxWindow:Destroy()
    return
  end,
})

local v213

v213 = (hookmetamethod(game, "__namecall", newcclosure(function(p9, ...)
  local v214 = p9
  local v215 = getnamecallmethod()
  local v216 = { ... }
  local v217 = v215 == "FireServer"
  local v218 = v217
  local v219, v220, v221, v222, v223, v224, v225, v226

  if v217 then
    local v227
    v227 = p9.Name == "Fire"

    local parent
    parent = v227

    if v227 then
      do
      end

      do
      end

      parent = p9.Parent and p9.Parent.Parent
    end

    v218 = parent
  end

  if v218 then
    do
    end

    do
    end

    if p9.Parent.Parent.Name == "Items" and v34 then
      local v228
      v228 = f2()

      do
      end

      if v228 and v228.Character then
        do
        end

        local head2
        head2 = v228.Character:FindFirstChild("Head")

        if head2 then
          if (typeof(v216[1])) == "Vector3" then
            v216[1] = head2.Position
          end

          do
          end

          do
          end

          if v216[2] and (typeof(v216[2])) == "Instance" then
            v216[2] = head2
          end

          local v229
          v229 = dist

          dist:Notify({ Title = "Silent Aim", Content = "Redirected to " .. v228.Name })
          return v213(p9, unpack(v216))
        end
      end
    end
  end

  return v213(p9, ...)
end)))

task.wait(0.5)
local v230 = anchHaxWindow
anchHaxWindow:SelectTab(1)
local v231 = dist
dist:Notify({ Title = "ANCH Hax", Content = "JOIN ANCH COMMUNITY DISCORD!" })
return
