--[[
Game source provenance | SRC | NOT TESTED IN ROBLOX
Original: https://github.com/AshTheScripter/Denzel-s-script-blr/blob/2c847fa2801a2a9803da438118cf91da396e7c54/Denzels%20script%20blr
Source SHA-256: 7547fdda4b4d9e2c8468a3da2e55420b7bb5354ab5c11781e010dba7cb120fa3
Open source (src); no deobfuscation claimed.
Author / terms (from upstream LICENSE):

MIT License

Copyright (c) 2026 Ash_TheGoat

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

-- created by denzel - owner | for help denzel.natsuki on discord
-- v9.2 — Matcha Comfort style: HSV picker, two-column Options, icon bar, credits

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local TeleportService   = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera            = workspace.CurrentCamera

local L = Players.LocalPlayer
local GUI_OPEN = true

-- ================================================================
--  KEYBINDS
-- ================================================================
getgenv().KeyBinds = {
    ToggleDribble = Enum.KeyCode.U,
    ToggleMenu    = Enum.KeyCode.RightAlt,
    ToggleKeybind = Enum.KeyCode.K,
}
local KB = getgenv().KeyBinds

-- ================================================================
--  SETTINGS
-- ================================================================
getgenv().AutoDribbleSettings = {
    EnabledAnim = false, EnabledNoAnim = false,
    DetectMoveAnims = false, range = 35, touchRange = 2,
}
local S = getgenv().AutoDribbleSettings

local VS = {
    TrajectoryEnabled = false, BallPredEnabled = false,
    BallPredShowDist  = true,  AimEnabled      = false,
    AimMode = "humanoid",      AimLineLen      = 60,
    StyleEnabled = false,      StreamProof     = false,
}

local UI_OPTS = {
    Watermark   = false, DarkBackground = false,
    SnowEffect  = false, Blur           = false,
    KeybindList = true,  NotifSound     = true,
}

-- ================================================================
--  COLORS
-- ================================================================
local ACCENT   = Color3.fromRGB(130,  60, 255)   -- purple (Matcha default)
local BG_MAIN  = Color3.fromRGB( 13,  13,  17)
local BG_PANEL = Color3.fromRGB( 19,  19,  25)
local BG_CARD  = Color3.fromRGB( 26,  26,  34)
local BG_BTN   = Color3.fromRGB( 36,  36,  48)
local TXT_PRI  = Color3.fromRGB(225, 225, 232)
local TXT_SEC  = Color3.fromRGB(110, 110, 130)
local TXT_MUT  = Color3.fromRGB( 55,  55,  72)
local OFF_CB   = Color3.fromRGB( 34,  34,  46)
local C_GREEN  = Color3.fromRGB( 40, 210,  80)
local C_BLUE   = Color3.fromRGB( 90, 180, 255)

-- ================================================================
--  ACCENT REGISTRY
-- ================================================================
local accentBGList    = {}
local accentTextList  = {}
local accentFillList  = {}
local accentCBList    = {}   -- {frame, getState}
local accentPillList  = {}   -- {frame, getState}

local function regBG(o)   table.insert(accentBGList,   o); o.BackgroundColor3 = ACCENT end
local function regTxt(o)  table.insert(accentTextList, o); o.TextColor3       = ACCENT end
local function regFill(o) table.insert(accentFillList, o); o.BackgroundColor3 = ACCENT end
local function regCB(cb, gs)
    table.insert(accentCBList, {cb=cb, gs=gs})
    cb.BackgroundColor3 = gs() and ACCENT or OFF_CB
end
local function regPill(p, gs)
    table.insert(accentPillList, {pill=p, gs=gs})
    p.BackgroundColor3 = gs() and ACCENT or Color3.fromRGB(42,42,56)
end

local function setAccent(c)
    ACCENT = c
    for _,o in ipairs(accentBGList)   do pcall(function() o.BackgroundColor3 = ACCENT end) end
    for _,o in ipairs(accentTextList) do pcall(function() o.TextColor3       = ACCENT end) end
    for _,o in ipairs(accentFillList) do pcall(function() o.BackgroundColor3 = ACCENT end) end
    for _,e in ipairs(accentCBList)   do pcall(function() e.cb.BackgroundColor3 = e.gs() and ACCENT or OFF_CB end) end
    for _,e in ipairs(accentPillList) do pcall(function() e.pill.BackgroundColor3 = e.gs() and ACCENT or Color3.fromRGB(42,42,56) end) end
end

-- ================================================================
--  CHARACTER
-- ================================================================
local C, H, M
local AnimCache = {}
local function InitChar()
    C = L.Character or L.CharacterAdded:Wait()
    H = C:WaitForChild("HumanoidRootPart")
    M = C:WaitForChild("Humanoid")
    AnimCache = {}
end
InitChar()
L.CharacterAdded:Connect(InitChar)

local B = ReplicatedStorage.Packages.Knit.Services.BallService.RE.Dribble
local A = require(ReplicatedStorage.Assets.Animations)

local function GetAnim(s)
    if AnimCache[s] then return AnimCache[s] end
    if A.Dribbles and A.Dribbles[s] then
        local anim = Instance.new("Animation")
        anim.AnimationId = A.Dribbles[s]
        local track = M:LoadAnimation(anim)
        AnimCache[s] = track
        return track
    end
end

local function IsOpponent(p)
    return L.Team and p.Team and L.Team ~= p.Team
end
local function GetPing()
    local ok, ping = pcall(function() return L:GetNetworkPing() end)
    return (ok and ping) and math.clamp(ping, 0.01, 0.4) or 0.08
end

-- ================================================================
--  NOTIFICATIONS
-- ================================================================
local notifGui = Instance.new("ScreenGui")
notifGui.Name="DenzelNotifs"; notifGui.ResetOnSpawn=false
notifGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
notifGui.Parent=L:WaitForChild("PlayerGui")
local notifStack={}
local NW=270; local NH=48

local function showNotif(text, active)
    if VS.StreamProof then return end
    for i=#notifStack,1,-1 do
        if not notifStack[i] or not notifStack[i].Parent then table.remove(notifStack,i) end
    end
    for _,f in ipairs(notifStack) do
        if f and f.Parent then
            TweenService:Create(f,TweenInfo.new(0.14,Enum.EasingStyle.Quad),{
                Position=UDim2.new(1,-(NW+12),0,f.Position.Y.Offset-(NH+5))
            }):Play()
        end
    end
    local frame=Instance.new("Frame"); frame.Size=UDim2.new(0,NW,0,NH)
    frame.Position=UDim2.new(1,12,0,18); frame.BackgroundColor3=BG_CARD
    frame.BackgroundTransparency=0; frame.BorderSizePixel=0; frame.Parent=notifGui
    Instance.new("UICorner",frame).CornerRadius=UDim.new(0,9)
    local bar=Instance.new("Frame"); bar.Size=UDim2.new(0,3,1,-8)
    bar.Position=UDim2.new(0,0,0,4); bar.BorderSizePixel=0; bar.Parent=frame
    Instance.new("UICorner",bar).CornerRadius=UDim.new(0,3)
    bar.BackgroundColor3=active==true and C_GREEN or active==false and Color3.fromRGB(80,80,100) or ACCENT
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-16,1,0)
    lbl.Position=UDim2.new(0,12,0,0); lbl.BackgroundTransparency=1
    lbl.TextColor3=TXT_PRI; lbl.TextSize=11; lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.TextWrapped=true
    lbl.Text=tostring(text); lbl.Parent=frame
    table.insert(notifStack,frame)
    TweenService:Create(frame,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
        Position=UDim2.new(1,-(NW+12),0,18)
    }):Play()
    task.delay(3.0,function()
        if not frame.Parent then return end
        TweenService:Create(frame,TweenInfo.new(0.18),{
            Position=UDim2.new(1,14,0,frame.Position.Y.Offset),
            BackgroundTransparency=1
        }):Play()
        task.delay(0.2,function()
            local idx=table.find(notifStack,frame)
            if idx then table.remove(notifStack,idx) end
            if frame.Parent then frame:Destroy() end
        end)
    end)
end

-- ================================================================
--  DRIBBLE CORE
-- ================================================================
local DRIBBLE_CD=0.72; local ANIM_DELAY=0.04; local lastFire=0; local animFired=false

local function PlayDribbleAnim()
    if animFired then return end; animFired=true
    local ok,style=pcall(function() return L.PlayerStats.Style.Value end)
    if not ok or not style then return end
    local track=GetAnim(style)
    if track and not track.IsPlaying then track:Play(); track:AdjustSpeed(1) end
end

local function GetBallOffset()
    if not H then return Vector3.new(0,-2.5,0) end
    local vel=H.AssemblyLinearVelocity; local spd=Vector3.new(vel.X,0,vel.Z).Magnitude
    if spd>4 then
        local fwd=(H.CFrame.LookVector*Vector3.new(1,0,1)).Unit
        local off=math.clamp(spd*0.07,0,1.2)
        return Vector3.new(fwd.X*off,-2.5,fwd.Z*off)
    end
    return Vector3.new(0,-2.5,0)
end

local function FireServer()
    if not (C and C.Values and C.Values.HasBall and C.Values.HasBall.Value) then return end
    local now=tick(); local onCD=(now-lastFire)<DRIBBLE_CD; local ping=GetPing()
    B:FireServer()
    if ping>0.12 then task.delay(0.05,function() pcall(function() B:FireServer() end) end) end
    local ball=workspace:FindFirstChild("Football")
    if ball then ball.AssemblyLinearVelocity=Vector3.zero; ball.CFrame=H.CFrame*CFrame.new(GetBallOffset()) end
    if not onCD then
        lastFire=now; animFired=false
        if S.EnabledAnim then task.delay(ANIM_DELAY,PlayDribbleAnim) end
    end
end

-- ================================================================
--  STEAL DETECTION HEARTBEAT
-- ================================================================
local STEAL_ANIM_IDS={
    ["rbxassetid://109744655458082"]=true,["rbxassetid://121733574804278"]=true,
    ["rbxassetid://80044219275866"]=true, ["rbxassetid://73620981762403"]=true,
    ["rbxassetid://92849301756204"]=true, ["rbxassetid://97461082934710"]=true,
    ["rbxassetid://84920371645019"]=true, ["rbxassetid://101283746582910"]=true,
    ["rbxassetid://88372947561029"]=true, ["rbxassetid://114920837465021"]=true,
    ["rbxassetid://99017382645018"]=true, ["rbxassetid://103847291650038"]=true,
    ["rbxassetid://87264018374501"]=true, ["rbxassetid://116482037591826"]=true,
    ["rbxassetid://94820173659284"]=true, ["rbxassetid://108374629015834"]=true,
    ["rbxassetid://77364829015047"]=true, ["rbxassetid://91830472659102"]=true,
    ["rbxassetid://83920174650923"]=true, ["rbxassetid://96482017345812"]=true,
}
local slideWas={}; local animCD={}
RunService.Heartbeat:Connect(function()
    if not (C and H) then return end
    if not (C.Values and C.Values.HasBall and C.Values.HasBall.Value) then return end
    if not (S.EnabledAnim or S.EnabledNoAnim or S.DetectMoveAnims) then return end
    local myPos=H.Position; local now=tick(); local pt=GetPing()+0.023
    local rsq=S.range*S.range
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=L and IsOpponent(p) and p.Character then
            local ch=p.Character; local r=ch:FindFirstChild("HumanoidRootPart")
            if r then
                local rv=r.AssemblyLinearVelocity
                local function dsq(v) return v.X^2+v.Y^2+v.Z^2 end
                local inR=math.min(dsq(r.Position-myPos),dsq((r.Position+rv*pt)-myPos))<rsq
                local isSlide=ch.Values and ch.Values.Sliding and ch.Values.Sliding.Value==true
                if isSlide and not slideWas[p] and inR then slideWas[p]=true; FireServer() end
                if S.DetectMoveAnims and inR then
                    local hum=ch:FindFirstChildOfClass("Humanoid")
                    local an=hum and hum:FindFirstChildOfClass("Animator")
                    if an and (not animCD[p] or now-animCD[p]>0.45) then
                        for _,tr in ipairs(an:GetPlayingAnimationTracks()) do
                            local id=tr.Animation and tr.Animation.AnimationId or ""
                            if STEAL_ANIM_IDS[id] then animCD[p]=now; FireServer(); break end
                        end
                    end
                end
                if not isSlide then slideWas[p]=false end
            end
        end
    end
end)

-- ================================================================
--  BALL PREDICTION
-- ================================================================
local predFolder=Instance.new("Folder"); predFolder.Name="BallPred"; predFolder.Parent=workspace
local predBall=nil; local predGlow=nil; local predBB=nil; local predLbl=nil
local predSmooth=nil; local predPulse=0

local function buildPredMarker()
    predBall=Instance.new("Part"); predBall.Name="PredBall"; predBall.Shape=Enum.PartType.Ball
    predBall.Material=Enum.Material.Neon; predBall.Color=Color3.fromRGB(255,25,25)
    predBall.Size=Vector3.new(1,1,1); predBall.CanCollide=false; predBall.Anchored=true
    predBall.CastShadow=false; predBall.Transparency=1; predBall.Parent=predFolder
    predGlow=Instance.new("Part"); predGlow.Name="PredGlow"; predGlow.Shape=Enum.PartType.Ball
    predGlow.Material=Enum.Material.Neon; predGlow.Color=Color3.fromRGB(255,80,60)
    predGlow.Size=Vector3.new(1.8,1.8,1.8); predGlow.CanCollide=false; predGlow.Anchored=true
    predGlow.CastShadow=false; predGlow.Transparency=1; predGlow.Parent=predFolder
    predBB=Instance.new("BillboardGui"); predBB.Size=UDim2.new(0,100,0,26)
    predBB.StudsOffset=Vector3.new(0,1.6,0); predBB.AlwaysOnTop=true; predBB.LightInfluence=0
    predBB.Enabled=false; predBB.Adornee=predBall; predBB.Parent=predFolder
    local bg=Instance.new("Frame"); bg.Size=UDim2.new(1,0,1,0)
    bg.BackgroundColor3=Color3.fromRGB(12,12,12); bg.BackgroundTransparency=0.3
    bg.BorderSizePixel=0; bg.Parent=predBB; Instance.new("UICorner",bg).CornerRadius=UDim.new(0,7)
    predLbl=Instance.new("TextLabel"); predLbl.Size=UDim2.new(1,-4,1,0)
    predLbl.Position=UDim2.new(0,2,0,0); predLbl.BackgroundTransparency=1
    predLbl.TextColor3=Color3.fromRGB(255,120,120); predLbl.TextStrokeTransparency=0.2
    predLbl.TextStrokeColor3=Color3.fromRGB(0,0,0); predLbl.TextSize=12
    predLbl.Font=Enum.Font.GothamBold; predLbl.Text=""; predLbl.Parent=bg
end

local function ensurePred() if not (predBall and predBall.Parent) then buildPredMarker() end end

local function hidePred()
    if predBall then predBall.Transparency=1 end
    if predGlow then predGlow.Transparency=1 end
    if predBB   then predBB.Enabled=false end
end

local function simLand(pos,vel)
    local g=-(workspace.Gravity); local STEP=0.02; local DRAG=0.992
    local px,py,pz=pos.X,pos.Y,pos.Z; local vx,vy,vz=vel.X,vel.Y,vel.Z
    local ox,oz=px,pz; local MH2=46*46
    for _=1,500 do
        vy=vy+g*STEP; vx=vx*DRAG; vz=vz*DRAG; px=px+vx*STEP; py=py+vy*STEP; pz=pz+vz*STEP
        if py<=0.5 then return Vector3.new(px,0.5,pz),false end
        local dx,dz=px-ox,pz-oz
        if dx*dx+dz*dz>=MH2 then return Vector3.new(px,math.max(py,0.5),pz),true end
    end
    return Vector3.new(px,0.5,pz),false
end

local function updateBallPred()
    if not VS.BallPredEnabled then hidePred(); return end
    local ball=workspace:FindFirstChild("Football"); if not ball then hidePred(); return end
    local vel=ball.AssemblyLinearVelocity; local speed=vel.Magnitude
    if speed<11 then hidePred(); predSmooth=nil; return end
    ensurePred()
    local raw,capped=simLand(ball.Position,vel)
    predSmooth=predSmooth and predSmooth:Lerp(raw,capped and 0.45 or 0.30) or raw
    predBall.Position=predSmooth; predGlow.Position=predSmooth
    local alpha=math.clamp((speed-11)/22,0,1)
    predBall.Transparency=1-alpha*0.88; predPulse=predPulse+0.09
    predGlow.Transparency=1-alpha*(0.44+math.sin(predPulse)*0.18)
    predBall.Color=Color3.fromRGB(255,25,25)
    predGlow.Color=capped and Color3.fromRGB(255,140,30) or Color3.fromRGB(255,75,55)
    if VS.BallPredShowDist and H then
        predLbl.Text=math.floor((predSmooth-H.Position).Magnitude).." m"; predBB.Enabled=true
    else predBB.Enabled=false end
end

-- ================================================================
--  TRAJECTORY
-- ================================================================
local trajFolder=Instance.new("Folder"); trajFolder.Name="Traj"; trajFolder.Parent=workspace
local trajSegs={}; local landMark=nil

local function ensureTrajSegs(n)
    while #trajSegs<n do
        local s=Instance.new("Part"); s.Material=Enum.Material.Neon
        s.Color=Color3.fromRGB(255,30,30); s.CanCollide=false; s.Anchored=true
        s.CastShadow=false; s.Transparency=1; s.Shape=Enum.PartType.Cylinder
        s.Parent=trajFolder; table.insert(trajSegs,s)
    end
end

local function ensureLandMark()
    if landMark and landMark.Parent then return end
    landMark=Instance.new("Part"); landMark.Shape=Enum.PartType.Ball
    landMark.Material=Enum.Material.Neon; landMark.Color=Color3.fromRGB(255,210,0)
    landMark.Size=Vector3.new(1.1,1.1,1.1); landMark.CanCollide=false
    landMark.Anchored=true; landMark.CastShadow=false; landMark.Transparency=1
    landMark.Parent=trajFolder
    local bb=Instance.new("BillboardGui"); bb.Size=UDim2.new(0,80,0,22)
    bb.StudsOffset=Vector3.new(0,1.5,0); bb.AlwaysOnTop=true; bb.Enabled=false; bb.Parent=landMark
    local tl=Instance.new("TextLabel"); tl.Size=UDim2.new(1,0,1,0)
    tl.BackgroundTransparency=1; tl.TextColor3=Color3.fromRGB(255,255,255)
    tl.TextStrokeTransparency=0.3; tl.TextSize=14; tl.Font=Enum.Font.GothamBold; tl.Parent=bb
end

local function hideTraj()
    for _,s in ipairs(trajSegs) do s.Transparency=1 end
    if landMark then landMark.Transparency=1
        local bb=landMark:FindFirstChildOfClass("BillboardGui"); if bb then bb.Enabled=false end
    end
end

local function updateTrajectory()
    local ball=workspace:FindFirstChild("Football"); if not ball then hideTraj(); return end
    local vel=ball.AssemblyLinearVelocity; if vel.Magnitude<8 then hideTraj(); return end
    local g=-workspace.Gravity; local pos=ball.Position
    local vx,vy,vz=vel.X,vel.Y,vel.Z; local pts={}
    for i=1,60 do
        vy=vy+g*0.05; pos=Vector3.new(pos.X+vx*0.05,pos.Y+vy*0.05,pos.Z+vz*0.05)
        table.insert(pts,pos)
        if pos.Y<=0 and i>1 then pts[i]=Vector3.new(pos.X,0.18,pos.Z); break end
    end
    local n=#pts; ensureTrajSegs(n-1); ensureLandMark()
    for i=1,n-1 do
        local sg=trajSegs[i]; local len=(pts[i+1]-pts[i]).Magnitude
        if len<0.01 then sg.Transparency=1 else
            sg.Size=Vector3.new(len,0.28,0.28)
            sg.CFrame=CFrame.new((pts[i]+pts[i+1])*0.5,pts[i+1])*CFrame.fromEulerAnglesXYZ(0,math.pi/2,0)
            sg.Transparency=0.15+math.clamp(i/(n-1)*1.2,0,1)*0.65
        end
    end
    for i=n,#trajSegs do trajSegs[i].Transparency=1 end
    landMark.Position=pts[n]; landMark.Transparency=0.15
    local bb=landMark:FindFirstChildOfClass("BillboardGui")
    if bb then bb.Enabled=true
        local tl=bb:FindFirstChildOfClass("TextLabel")
        if tl then tl.Text=(H and math.floor((pts[n]-H.Position).Magnitude) or 0).."m" end
    end
end

-- ================================================================
--  AIM LINE
-- ================================================================
local aimFolder=Instance.new("Folder"); aimFolder.Name="Aim"; aimFolder.Parent=workspace
local aimParts={}; local aimBBs={}; local aimHolder=nil

local function getAimDir(p,root)
    if VS.AimMode=="camera" and p==L then return Camera.CFrame.LookVector end
    local v=root.AssemblyLinearVelocity; local vXZ=Vector3.new(v.X,0,v.Z)
    if vXZ.Magnitude>12 then return vXZ.Unit end
    return root.CFrame.LookVector
end
local function getAimPart(p)
    if aimParts[p] and aimParts[p].Parent then return aimParts[p] end
    local ln=Instance.new("Part"); ln.Shape=Enum.PartType.Cylinder
    ln.Material=Enum.Material.Neon; ln.Color=Color3.fromRGB(255,255,255)
    ln.CanCollide=false; ln.Anchored=true; ln.CastShadow=false; ln.Transparency=1; ln.Parent=aimFolder
    aimParts[p]=ln; return ln
end
local function getAimBB(p)
    if aimBBs[p] and aimBBs[p].Parent then return aimBBs[p] end
    local bb=Instance.new("BillboardGui"); bb.Size=UDim2.new(0,130,0,28)
    bb.StudsOffset=Vector3.new(0,4.5,0); bb.AlwaysOnTop=true; bb.Enabled=false; bb.Parent=workspace
    local tl=Instance.new("TextLabel"); tl.Size=UDim2.new(1,0,1,0); tl.BackgroundTransparency=1
    tl.TextColor3=Color3.fromRGB(255,255,255); tl.TextStrokeTransparency=0.2
    tl.TextSize=13; tl.Font=Enum.Font.GothamBold
    tl.Text=(p.DisplayName or p.Name).." ⚽"; tl.Parent=bb; aimBBs[p]=bb; return bb
end
local function showAimLine(p,root)
    local ln=getAimPart(p); local bb=getAimBB(p)
    local dir=getAimDir(p,root); local look=Vector3.new(dir.X,0,dir.Z)
    if look.Magnitude<0.01 then look=Vector3.new(0,0,1) end; look=look.Unit
    local org=root.Position+Vector3.new(0,0.5,0); local tip=org+look*VS.AimLineLen
    ln.Size=Vector3.new(VS.AimLineLen,0.26,0.26)
    ln.CFrame=CFrame.new((org+tip)*0.5,tip)*CFrame.fromEulerAnglesXYZ(0,math.pi/2,0)
    ln.Transparency=0; bb.Adornee=root; bb.Enabled=true
end
local function hideAimLine(p)
    if aimParts[p] then aimParts[p].Transparency=1 end
    if aimBBs[p] then aimBBs[p].Enabled=false end
end
local function clearAllAimLines()
    for p in pairs(aimParts) do if aimParts[p] then aimParts[p].Transparency=1 end end
    for p in pairs(aimBBs) do if aimBBs[p] then aimBBs[p].Enabled=false end end
    aimHolder=nil
end
local function updateAimLine()
    if not VS.AimEnabled then clearAllAimLines(); return end
    local active=nil
    for _,p in ipairs(Players:GetPlayers()) do
        local ch=p.Character; if not ch then continue end
        local v=ch:FindFirstChild("Values"); local hb=v and v:FindFirstChild("HasBall")
        if hb and hb.Value==true then active=p; break end
    end
    if active and active~=aimHolder then
        if aimHolder then hideAimLine(aimHolder) end; aimHolder=active
    end
    if aimHolder then
        local ch=aimHolder.Character; local root=ch and ch:FindFirstChild("HumanoidRootPart")
        if root then showAimLine(aimHolder,root) else hideAimLine(aimHolder) end
    end
    for p in pairs(aimParts) do
        if not p.Parent then
            if aimParts[p] then aimParts[p]:Destroy(); aimParts[p]=nil end
            if aimBBs[p] then aimBBs[p]:Destroy(); aimBBs[p]=nil end
        end
    end
end

-- ================================================================
--  STYLE VIEWER
-- ================================================================
local styleBBs={}
local function getPlayerStyle(player)
    local ok,val=pcall(function()
        local ps=player:FindFirstChild("PlayerStats")
        if ps then local s=ps:FindFirstChild("Style"); if s then return s.Value end end
    end)
    return ok and val or nil
end
local function getOrMakeStyleBB(player)
    if styleBBs[player] and styleBBs[player].Parent then return styleBBs[player] end
    local bb=Instance.new("BillboardGui"); bb.Name="SBB_"..player.Name
    bb.Size=UDim2.new(0,130,0,26); bb.StudsOffset=Vector3.new(0,6,0)
    bb.AlwaysOnTop=true; bb.Enabled=false; bb.Parent=workspace
    local bg=Instance.new("Frame"); bg.Size=UDim2.new(1,0,1,0)
    bg.BackgroundColor3=Color3.fromRGB(0,0,0); bg.BackgroundTransparency=0.4; bg.BorderSizePixel=0; bg.Parent=bb
    Instance.new("UICorner",bg).CornerRadius=UDim.new(0,6)
    local lbl=Instance.new("TextLabel"); lbl.Name="Lbl"; lbl.Size=UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency=1; lbl.TextColor3=Color3.fromRGB(200,230,255)
    lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold; lbl.Text="Style: --"; lbl.Parent=bg
    styleBBs[player]=bb; return bb
end
local function updateStyleBBs()
    if not VS.StyleEnabled then
        for _,bb in pairs(styleBBs) do if bb then bb.Enabled=false end end; return
    end
    for _,p in ipairs(Players:GetPlayers()) do
        if p==L then continue end
        local ch=p.Character; local root=ch and ch:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local bb=getOrMakeStyleBB(p); local style=getPlayerStyle(p)
        if not style then bb.Enabled=false; continue end
        bb.Adornee=root; bb.Enabled=true
        for _,c in ipairs(bb:GetChildren()) do
            if c:IsA("Frame") then
                local l=c:FindFirstChild("Lbl"); if l then l.Text="Style: "..tostring(style) end
            end
        end
    end
end

-- ================================================================
--  UI EFFECTS (watermark, blur, dark bg)
-- ================================================================
local watermarkGui=nil; local blurEffect=nil; local darkFrame=nil; local snowConn=nil; local snowParts={}

local function applyWatermark(on)
    if on then
        if not watermarkGui then
            watermarkGui=Instance.new("ScreenGui"); watermarkGui.Name="DenzelWM"
            watermarkGui.ResetOnSpawn=false; watermarkGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
            watermarkGui.Parent=L:WaitForChild("PlayerGui")
            local f=Instance.new("Frame"); f.Size=UDim2.new(0,200,0,26)
            f.Position=UDim2.new(0,6,0,6); f.BackgroundColor3=BG_MAIN
            f.BackgroundTransparency=0.2; f.BorderSizePixel=0; f.Parent=watermarkGui
            Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
            local l=Instance.new("TextLabel"); l.Size=UDim2.new(1,-8,1,0)
            l.Position=UDim2.new(0,8,0,0); l.BackgroundTransparency=1
            l.TextColor3=TXT_PRI; l.TextSize=11; l.Font=Enum.Font.GothamBold
            l.TextXAlignment=Enum.TextXAlignment.Left
            l.Text="Denzel's GUI  ·  denzel.natsuki"; l.Parent=f
        end
    else
        if watermarkGui then watermarkGui:Destroy(); watermarkGui=nil end
    end
end

local function applyBlur(on)
    if on then
        if not blurEffect then
            blurEffect=Instance.new("BlurEffect")
            blurEffect.Size=10; blurEffect.Parent=game:GetService("Lighting")
        end
    else
        if blurEffect then blurEffect:Destroy(); blurEffect=nil end
    end
end

local function applyDarkBG(on)
    if on then
        if not darkFrame then
            local sg=Instance.new("ScreenGui"); sg.Name="DenzelDark"; sg.ResetOnSpawn=false
            sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; sg.Parent=L:WaitForChild("PlayerGui")
            darkFrame=Instance.new("Frame"); darkFrame.Size=UDim2.new(1,0,1,0)
            darkFrame.BackgroundColor3=Color3.fromRGB(0,0,0)
            darkFrame.BackgroundTransparency=0.65; darkFrame.BorderSizePixel=0
            darkFrame.ZIndex=1; darkFrame.Parent=sg
        end
    else
        if darkFrame and darkFrame.Parent then darkFrame.Parent.Parent:Destroy(); darkFrame=nil end
    end
end

-- ================================================================
--  VISUALS MAIN
-- ================================================================
local function updateVisuals()
    pcall(updateBallPred)
    if VS.TrajectoryEnabled then pcall(updateTrajectory) else pcall(hideTraj) end
    pcall(updateAimLine)
    pcall(updateStyleBBs)
end

-- ================================================================
--  SCREEN GUI
-- ================================================================
local screenGui=Instance.new("ScreenGui")
screenGui.Name="DenzelGUI"; screenGui.ResetOnSpawn=false
screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
screenGui.Parent=L:WaitForChild("PlayerGui")

local uiScale=Instance.new("UIScale"); uiScale.Scale=0; uiScale.Parent=screenGui

-- ================================================================
--  MAIN WINDOW  (680 x 508)
-- ================================================================
local MAIN_W=680; local MAIN_H=508
local main=Instance.new("Frame"); main.Name="Main"
main.Size=UDim2.new(0,MAIN_W,0,MAIN_H); main.Position=UDim2.new(0.5,-MAIN_W/2,0.5,-MAIN_H/2)
main.BackgroundColor3=BG_MAIN; main.BorderSizePixel=0
main.Active=true; main.Draggable=true; main.Parent=screenGui
Instance.new("UICorner",main).CornerRadius=UDim.new(0,10)

-- outer shadow
local shadow=Instance.new("ImageLabel"); shadow.Size=UDim2.new(1,28,1,28)
shadow.Position=UDim2.new(0,-14,0,-10); shadow.BackgroundTransparency=1
shadow.Image="rbxassetid://6015897843"; shadow.ImageColor3=Color3.fromRGB(0,0,0)
shadow.ImageTransparency=0.60; shadow.ScaleType=Enum.ScaleType.Slice
shadow.SliceCenter=Rect.new(49,49,450,450); shadow.ZIndex=0; shadow.Parent=main

-- thin top accent line
local topLine=Instance.new("Frame"); topLine.Size=UDim2.new(1,0,0,2)
topLine.BorderSizePixel=0; topLine.Parent=main; regBG(topLine)

-- ================================================================
--  TOP BAR  (44px)
-- ================================================================
local topBar=Instance.new("Frame"); topBar.Name="TopBar"
topBar.Size=UDim2.new(1,0,0,44); topBar.Position=UDim2.new(0,0,0,2)
topBar.BackgroundColor3=BG_PANEL; topBar.BorderSizePixel=0; topBar.Parent=main
-- fix top corners
Instance.new("UICorner",topBar).CornerRadius=UDim.new(0,10)
local topFix=Instance.new("Frame"); topFix.Size=UDim2.new(1,0,0.55,0)
topFix.Position=UDim2.new(0,0,0.45,0); topFix.BackgroundColor3=BG_PANEL
topFix.BorderSizePixel=0; topFix.Parent=topBar

-- Quick-toggle icon buttons (left side)
local iconBtnsFrame=Instance.new("Frame"); iconBtnsFrame.Size=UDim2.new(0,130,1,-8)
iconBtnsFrame.Position=UDim2.new(0,8,0.5,-12)
iconBtnsFrame.BackgroundTransparency=1; iconBtnsFrame.Parent=topBar
local iconLayout=Instance.new("UIListLayout"); iconLayout.FillDirection=Enum.FillDirection.Horizontal
iconLayout.VerticalAlignment=Enum.VerticalAlignment.Center
iconLayout.Padding=UDim.new(0,3); iconLayout.Parent=iconBtnsFrame

local quickIcons={}
local QUICK_DEFS={
    {icon="⚡", tip="Dribble",    getState=function() return S.EnabledAnim or S.EnabledNoAnim end,
     toggle=function()
         local on=S.EnabledAnim or S.EnabledNoAnim
         S.EnabledAnim=not on; S.EnabledNoAnim=false
         showNotif(not on and "Dribble ON" or "Dribble OFF", not on)
     end},
    {icon="◎",  tip="Ball Pred",  getState=function() return VS.BallPredEnabled end,
     toggle=function()
         VS.BallPredEnabled=not VS.BallPredEnabled
         if not VS.BallPredEnabled then pcall(hidePred) end
         showNotif(VS.BallPredEnabled and "Ball Pred ON" or "Ball Pred OFF", VS.BallPredEnabled)
     end},
    {icon="→",  tip="Aim Line",   getState=function() return VS.AimEnabled end,
     toggle=function()
         VS.AimEnabled=not VS.AimEnabled
         if not VS.AimEnabled then pcall(clearAllAimLines) end
         showNotif(VS.AimEnabled and "Aim Line ON" or "Aim Line OFF", VS.AimEnabled)
     end},
    {icon="〜", tip="Trajectory", getState=function() return VS.TrajectoryEnabled end,
     toggle=function()
         VS.TrajectoryEnabled=not VS.TrajectoryEnabled
         if not VS.TrajectoryEnabled then pcall(hideTraj) end
         showNotif(VS.TrajectoryEnabled and "Trajectory ON" or "Trajectory OFF", VS.TrajectoryEnabled)
     end},
    {icon="★",  tip="Styles",     getState=function() return VS.StyleEnabled end,
     toggle=function()
         VS.StyleEnabled=not VS.StyleEnabled
         showNotif(VS.StyleEnabled and "Style Viewer ON" or "Style Viewer OFF", VS.StyleEnabled)
     end},
}

for _,def in ipairs(QUICK_DEFS) do
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,22,0,22)
    btn.TextSize=11; btn.Font=Enum.Font.GothamBold
    btn.Text=def.icon; btn.BorderSizePixel=0; btn.Parent=iconBtnsFrame
    Instance.new("UICorner",btn).CornerRadius=UDim.new(0,5)
    -- color: accent when on, dark when off
    local function updIcon()
        btn.BackgroundColor3=def.getState() and ACCENT or BG_BTN
        btn.TextColor3=def.getState() and Color3.fromRGB(240,240,240) or TXT_SEC
    end
    updIcon()
    btn.MouseButton1Click:Connect(function() def.toggle(); updIcon() end)
    table.insert(quickIcons,{btn=btn,updIcon=updIcon})
end

-- Separator dot
local sep1=Instance.new("Frame"); sep1.Size=UDim2.new(0,1,0,22)
sep1.Position=UDim2.new(0,146,0.5,-11); sep1.BackgroundColor3=TXT_MUT
sep1.BorderSizePixel=0; sep1.Parent=topBar

-- Title: "Denzel's · Comfort"
local titleBreadcrumb=Instance.new("TextLabel"); titleBreadcrumb.Size=UDim2.new(0,160,1,0)
titleBreadcrumb.Position=UDim2.new(0,154,0,0); titleBreadcrumb.BackgroundTransparency=1
titleBreadcrumb.TextColor3=TXT_PRI; titleBreadcrumb.TextSize=12; titleBreadcrumb.Font=Enum.Font.GothamBold
titleBreadcrumb.TextXAlignment=Enum.TextXAlignment.Left; titleBreadcrumb.Text="Denzel's"
titleBreadcrumb.Parent=topBar

local dotLabel=Instance.new("TextLabel"); dotLabel.Size=UDim2.new(0,12,1,0)
dotLabel.Position=UDim2.new(0,220,0,0); dotLabel.BackgroundTransparency=1
dotLabel.TextColor3=TXT_MUT; dotLabel.TextSize=12; dotLabel.Font=Enum.Font.Gotham
dotLabel.Text="·"; dotLabel.Parent=topBar

local comfortLabel=Instance.new("TextLabel"); comfortLabel.Size=UDim2.new(0,80,1,0)
comfortLabel.Position=UDim2.new(0,230,0,0); comfortLabel.BackgroundTransparency=1
comfortLabel.TextSize=12; comfortLabel.Font=Enum.Font.GothamBold
comfortLabel.TextXAlignment=Enum.TextXAlignment.Left; comfortLabel.Text="Comfort"
comfortLabel.Parent=topBar; regTxt(comfortLabel)

-- stable tag
local stableTag=Instance.new("Frame"); stableTag.Size=UDim2.new(0,42,0,18)
stableTag.Position=UDim2.new(0,308,0.5,-9); stableTag.BorderSizePixel=0
stableTag.BackgroundColor3=Color3.fromRGB(20,60,30); stableTag.Parent=topBar
Instance.new("UICorner",stableTag).CornerRadius=UDim.new(1,0)
local stableLbl=Instance.new("TextLabel"); stableLbl.Size=UDim2.new(1,0,1,0)
stableLbl.BackgroundTransparency=1; stableLbl.TextColor3=C_GREEN
stableLbl.TextSize=9; stableLbl.Font=Enum.Font.GothamBold; stableLbl.Text="stable"
stableLbl.Parent=stableTag

-- Right side: username + stats
local statsContainer=Instance.new("Frame"); statsContainer.Size=UDim2.new(0,240,1,0)
statsContainer.Position=UDim2.new(1,-284,0,0); statsContainer.BackgroundTransparency=1
statsContainer.Parent=topBar
local statsLayout2=Instance.new("UIListLayout"); statsLayout2.FillDirection=Enum.FillDirection.Horizontal
statsLayout2.HorizontalAlignment=Enum.HorizontalAlignment.Right
statsLayout2.VerticalAlignment=Enum.VerticalAlignment.Center
statsLayout2.Padding=UDim.new(0,0); statsLayout2.Parent=statsContainer

local function makeStatChip(initial)
    local chip=Instance.new("Frame"); chip.Size=UDim2.new(0,60,0,28)
    chip.BackgroundTransparency=1; chip.Parent=statsContainer
    local sep=Instance.new("Frame"); sep.Size=UDim2.new(0,1,0,16)
    sep.Position=UDim2.new(0,0,0.5,-8); sep.BackgroundColor3=TXT_MUT
    sep.BorderSizePixel=0; sep.Parent=chip
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-2,1,0)
    lbl.Position=UDim2.new(0,2,0,0); lbl.BackgroundTransparency=1
    lbl.TextColor3=TXT_SEC; lbl.TextSize=10; lbl.Font=Enum.Font.Code
    lbl.Text=initial; lbl.Parent=chip; return lbl
end

-- username chip
local userChip=Instance.new("Frame"); userChip.Size=UDim2.new(0,80,0,28)
userChip.BackgroundTransparency=1; userChip.Parent=statsContainer
local userSep=Instance.new("Frame"); userSep.Size=UDim2.new(0,1,0,16)
userSep.Position=UDim2.new(0,0,0.5,-8); userSep.BackgroundColor3=TXT_MUT
userSep.BorderSizePixel=0; userSep.Parent=userChip
local userLbl=Instance.new("TextLabel"); userLbl.Size=UDim2.new(1,-4,1,0)
userLbl.Position=UDim2.new(0,4,0,0); userLbl.BackgroundTransparency=1
userLbl.TextColor3=TXT_PRI; userLbl.TextSize=10; userLbl.Font=Enum.Font.GothamBold
userLbl.Text=L.Name; userLbl.Parent=userChip

local fpsLbl  = makeStatChip("58 FPS")
local msLbl   = makeStatChip("49 MS")
local timeLbl = makeStatChip("00:00:00")

-- Close & Minimize buttons
local function makeCtrlBtn(icon,xOff,col,cb)
    local b=Instance.new("TextButton"); b.Size=UDim2.new(0,22,0,22)
    b.Position=UDim2.new(1,xOff,0.5,-11); b.BackgroundColor3=col
    b.TextColor3=Color3.fromRGB(255,255,255); b.TextSize=11; b.Font=Enum.Font.GothamBold
    b.Text=icon; b.BorderSizePixel=0; b.Parent=topBar
    Instance.new("UICorner",b).CornerRadius=UDim.new(1,0); b.MouseButton1Click:Connect(cb); return b
end

makeCtrlBtn("✕",-6,Color3.fromRGB(190,45,45),function()
    TweenService:Create(uiScale,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Scale=0}):Play()
    task.wait(0.26); pcall(function()
        hideTraj(); hidePred(); clearAllAimLines()
        for _,bb in pairs(styleBBs) do pcall(function() bb:Destroy() end) end
        trajFolder:Destroy(); aimFolder:Destroy(); predFolder:Destroy()
    end)
    screenGui:Destroy(); notifGui:Destroy()
end)

local minimized=false; local contentFrame; local tabBarFrame; local bottomBarFrame
local minBtn=makeCtrlBtn("–",-32,BG_BTN,function()
    minimized=not minimized
    if tabBarFrame then tabBarFrame.Visible=not minimized end
    if contentFrame then contentFrame.Visible=not minimized end
    if bottomBarFrame then bottomBarFrame.Visible=not minimized end
    if minimized then
        TweenService:Create(main,TweenInfo.new(0.18),{Size=UDim2.new(0,MAIN_W,0,46)}):Play()
        minBtn.Text="+"
    else
        TweenService:Create(main,TweenInfo.new(0.18),{Size=UDim2.new(0,MAIN_W,0,MAIN_H)}):Play()
        minBtn.Text="–"
    end
end)

-- ================================================================
--  TAB BAR  (36px)
-- ================================================================
tabBarFrame=Instance.new("Frame"); tabBarFrame.Name="TabBar"
tabBarFrame.Size=UDim2.new(1,0,0,36); tabBarFrame.Position=UDim2.new(0,0,0,46)
tabBarFrame.BackgroundColor3=BG_PANEL; tabBarFrame.BorderSizePixel=0; tabBarFrame.Parent=main
local tbLayout=Instance.new("UIListLayout"); tbLayout.FillDirection=Enum.FillDirection.Horizontal
tbLayout.HorizontalAlignment=Enum.HorizontalAlignment.Left
tbLayout.VerticalAlignment=Enum.VerticalAlignment.Center
tbLayout.Padding=UDim.new(0,0); tbLayout.Parent=tabBarFrame
Instance.new("UIPadding",tabBarFrame).PaddingLeft=UDim.new(0,10)

-- tab bottom divider
local tabDivider=Instance.new("Frame"); tabDivider.Size=UDim2.new(1,0,0,1)
tabDivider.Position=UDim2.new(0,0,1,-1); tabDivider.BackgroundColor3=Color3.fromRGB(30,30,40)
tabDivider.BorderSizePixel=0; tabDivider.Parent=tabBarFrame

-- ================================================================
--  CONTENT AREA (82px from top, ends 30px from bottom for bottom bar)
-- ================================================================
contentFrame=Instance.new("Frame"); contentFrame.Name="Content"
contentFrame.Size=UDim2.new(1,0,1,-112); contentFrame.Position=UDim2.new(0,0,0,82)
contentFrame.BackgroundTransparency=1; contentFrame.Parent=main

-- ================================================================
--  BOTTOM BAR  (30px)
-- ================================================================
bottomBarFrame=Instance.new("Frame"); bottomBarFrame.Name="BottomBar"
bottomBarFrame.Size=UDim2.new(1,0,0,30); bottomBarFrame.Position=UDim2.new(0,0,1,-30)
bottomBarFrame.BackgroundColor3=BG_PANEL; bottomBarFrame.BorderSizePixel=0; bottomBarFrame.Parent=main
Instance.new("UICorner",bottomBarFrame).CornerRadius=UDim.new(0,10)
local bbFix=Instance.new("Frame"); bbFix.Size=UDim2.new(1,0,0.55,0); bbFix.BackgroundColor3=BG_PANEL
bbFix.BorderSizePixel=0; bbFix.Parent=bottomBarFrame

local bbTopLine=Instance.new("Frame"); bbTopLine.Size=UDim2.new(1,0,0,1)
bbTopLine.BackgroundColor3=Color3.fromRGB(28,28,38); bbTopLine.BorderSizePixel=0; bbTopLine.Parent=bottomBarFrame

local madeByLbl=Instance.new("TextLabel"); madeByLbl.Size=UDim2.new(0.5,0,1,0)
madeByLbl.Position=UDim2.new(0,12,0,0); madeByLbl.BackgroundTransparency=1
madeByLbl.TextColor3=TXT_MUT; madeByLbl.TextSize=10; madeByLbl.Font=Enum.Font.Gotham
madeByLbl.TextXAlignment=Enum.TextXAlignment.Left
madeByLbl.Text="made by denzel.natsuki"; madeByLbl.Parent=bottomBarFrame

local builtLbl=Instance.new("TextLabel"); builtLbl.Size=UDim2.new(0.5,-12,1,0)
builtLbl.Position=UDim2.new(0.5,0,0,0); builtLbl.BackgroundTransparency=1
builtLbl.TextColor3=TXT_MUT; builtLbl.TextSize=10; builtLbl.Font=Enum.Font.Code
builtLbl.TextXAlignment=Enum.TextXAlignment.Right
builtLbl.Text="built: "; builtLbl.Parent=bottomBarFrame

local builtDate=Instance.new("TextLabel"); builtDate.Size=UDim2.new(0,80,1,0)
builtDate.Position=UDim2.new(1,-82,0,0); builtDate.BackgroundTransparency=1
builtDate.TextSize=10; builtDate.Font=Enum.Font.Code
builtDate.TextXAlignment=Enum.TextXAlignment.Right
builtDate.Text="Mar 8 2026"; builtDate.Parent=bottomBarFrame; regTxt(builtDate)

-- ================================================================
--  TABS
-- ================================================================
local tabs={}; local tabPages={}; local activeTab=nil

local function createTab(name)
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,0,1,0)
    btn.AutomaticSize=Enum.AutomaticSize.X; btn.BackgroundTransparency=1
    btn.TextColor3=TXT_MUT; btn.TextSize=11; btn.Font=Enum.Font.GothamBold
    btn.Text="  "..name.."  "; btn.BorderSizePixel=0; btn.Parent=tabBarFrame

    local underline=Instance.new("Frame"); underline.Size=UDim2.new(1,0,0,2)
    underline.Position=UDim2.new(0,0,1,-2); underline.BackgroundTransparency=1
    underline.BorderSizePixel=0; underline.Parent=btn
    regBG(underline)

    local page=Instance.new("Frame"); page.Size=UDim2.new(1,0,1,0)
    page.BackgroundTransparency=1; page.Visible=false; page.Parent=contentFrame

    tabs[name]={btn=btn,underline=underline}; tabPages[name]=page

    btn.MouseButton1Click:Connect(function()
        for n,t in pairs(tabs) do
            t.btn.TextColor3=TXT_MUT
            TweenService:Create(t.underline,TweenInfo.new(0.10),{BackgroundTransparency=1}):Play()
            tabPages[n].Visible=false
        end
        btn.TextColor3=TXT_PRI
        TweenService:Create(underline,TweenInfo.new(0.10),{BackgroundTransparency=0}):Play()
        page.Visible=true; activeTab=name
    end)
    return page
end

local function selectTab(name)
    for n,t in pairs(tabs) do
        t.btn.TextColor3=TXT_MUT; t.underline.BackgroundTransparency=1; tabPages[n].Visible=false
    end
    if tabs[name] then
        tabs[name].btn.TextColor3=TXT_PRI; tabs[name].underline.BackgroundTransparency=0
        tabPages[name].Visible=true; activeTab=name
    end
end

-- ================================================================
--  WIDGET FACTORIES
-- ================================================================
local function makeScrollable(parent)
    local sf=Instance.new("ScrollingFrame"); sf.Size=UDim2.new(1,0,1,0)
    sf.BackgroundTransparency=1; sf.BorderSizePixel=0
    sf.ScrollBarThickness=3; sf.ScrollBarImageColor3=Color3.fromRGB(60,60,82)
    sf.CanvasSize=UDim2.new(0,0,0,0); sf.AutomaticCanvasSize=Enum.AutomaticSize.Y
    sf.Parent=parent
    local l=Instance.new("UIListLayout"); l.FillDirection=Enum.FillDirection.Vertical
    l.Padding=UDim.new(0,5); l.Parent=sf
    local p=Instance.new("UIPadding"); p.PaddingTop=UDim.new(0,10)
    p.PaddingLeft=UDim.new(0,12); p.PaddingRight=UDim.new(0,12)
    p.PaddingBottom=UDim.new(0,10); p.Parent=sf
    return sf
end

local function makeSection(parent, title)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,20)
    row.BackgroundTransparency=1; row.Parent=parent
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,0,1,0)
    lbl.BackgroundTransparency=1; lbl.TextColor3=TXT_MUT; lbl.TextSize=10
    lbl.Font=Enum.Font.GothamBold; lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Text=string.upper(title); lbl.Parent=row
end

-- Matcha-style checkbox row (small colored square, label, optional ?)
local function makeCheckboxRow(parent, text, default, callback, showHelp)
    local state=default or false
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,30)
    row.BackgroundTransparency=1; row.Parent=parent

    local cb=Instance.new("Frame"); cb.Size=UDim2.new(0,14,0,14)
    cb.Position=UDim2.new(0,0,0.5,-7); cb.BorderSizePixel=0; cb.Parent=row
    Instance.new("UICorner",cb).CornerRadius=UDim.new(0,3)
    regCB(cb, function() return state end)

    -- checkmark inside
    local ck=Instance.new("TextLabel"); ck.Size=UDim2.new(1,0,1,0)
    ck.BackgroundTransparency=1; ck.TextColor3=Color3.fromRGB(255,255,255)
    ck.TextSize=10; ck.Font=Enum.Font.GothamBold
    ck.Text=state and "✓" or ""; ck.Parent=cb

    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-30,1,0)
    lbl.Position=UDim2.new(0,20,0,0); lbl.BackgroundTransparency=1
    lbl.TextColor3=TXT_PRI; lbl.TextSize=12; lbl.Font=Enum.Font.Gotham
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=text; lbl.Parent=row

    if showHelp then
        local q=Instance.new("TextButton"); q.Size=UDim2.new(0,16,0,16)
        q.Position=UDim2.new(1,-16,0.5,-8); q.BackgroundColor3=BG_BTN
        q.TextColor3=TXT_MUT; q.TextSize=9; q.Font=Enum.Font.GothamBold
        q.Text="?"; q.BorderSizePixel=0; q.Parent=row
        Instance.new("UICorner",q).CornerRadius=UDim.new(1,0)
    end

    local hit=Instance.new("TextButton"); hit.Size=UDim2.new(1,-20,1,0)
    hit.BackgroundTransparency=1; hit.Text=""; hit.Parent=row
    hit.MouseButton1Click:Connect(function()
        state=not state
        cb.BackgroundColor3=state and ACCENT or OFF_CB
        ck.Text=state and "✓" or ""
        callback(state)
    end)

    return {SetState=function(ns)
        state=ns; cb.BackgroundColor3=state and ACCENT or OFF_CB; ck.Text=state and "✓" or ""
    end}
end

-- Pill toggle (for Dribble/Visuals pages)
local function makePillToggle(parent, text, desc, default, callback)
    local state=default or false
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,52)
    row.BackgroundColor3=BG_CARD; row.BorderSizePixel=0; row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,7)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-56,0,20)
    lbl.Position=UDim2.new(0,12,0,7); lbl.BackgroundTransparency=1
    lbl.TextColor3=TXT_PRI; lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=text; lbl.Parent=row
    local dsc=Instance.new("TextLabel"); dsc.Size=UDim2.new(1,-56,0,14)
    dsc.Position=UDim2.new(0,12,0,29); dsc.BackgroundTransparency=1
    dsc.TextColor3=TXT_MUT; dsc.TextSize=10; dsc.Font=Enum.Font.Gotham
    dsc.TextXAlignment=Enum.TextXAlignment.Left; dsc.Text=desc; dsc.Parent=row
    local pill=Instance.new("Frame"); pill.Size=UDim2.new(0,38,0,18)
    pill.Position=UDim2.new(1,-48,0.5,-9); pill.BorderSizePixel=0; pill.Parent=row
    Instance.new("UICorner",pill).CornerRadius=UDim.new(1,0)
    local knob=Instance.new("Frame"); knob.Size=UDim2.new(0,14,0,14)
    knob.Position=state and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)
    knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.BorderSizePixel=0; knob.Parent=pill
    Instance.new("UICorner",knob).CornerRadius=UDim.new(1,0)
    regPill(pill,function() return state end)
    local hit=Instance.new("TextButton"); hit.Size=UDim2.new(1,0,1,0)
    hit.BackgroundTransparency=1; hit.Text=""; hit.Parent=row
    local function upd()
        TweenService:Create(pill,TweenInfo.new(0.14),{BackgroundColor3=state and ACCENT or Color3.fromRGB(42,42,56)}):Play()
        TweenService:Create(knob,TweenInfo.new(0.14),{Position=state and UDim2.new(1,-16,0.5,-7) or UDim2.new(0,2,0.5,-7)}):Play()
    end
    hit.MouseButton1Click:Connect(function() state=not state; upd(); callback(state) end)
    return {SetState=function(ns) state=ns; upd() end}
end

local function makeSectionCard(parent, title)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,20)
    row.BackgroundTransparency=1; row.Parent=parent
    local bar=Instance.new("Frame"); bar.Size=UDim2.new(0,3,0,14)
    bar.Position=UDim2.new(0,0,0.5,-7); bar.BorderSizePixel=0; bar.Parent=row
    Instance.new("UICorner",bar).CornerRadius=UDim.new(1,0); regBG(bar)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-10,1,0)
    lbl.Position=UDim2.new(0,9,0,0); lbl.BackgroundTransparency=1
    lbl.TextColor3=TXT_SEC; lbl.TextSize=10; lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=string.upper(title); lbl.Parent=row
end

local function makeSlider(parent, text, desc, minV, maxV, def, fmt, callback)
    local cur=def; local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,62)
    row.BackgroundColor3=BG_CARD; row.BorderSizePixel=0; row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,7)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-60,0,18)
    lbl.Position=UDim2.new(0,12,0,7); lbl.BackgroundTransparency=1
    lbl.TextColor3=TXT_PRI; lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold
    lbl.TextXAlignment=Enum.TextXAlignment.Left
    lbl.Text=text; lbl.Parent=row
    local valLbl=Instance.new("TextLabel"); valLbl.Size=UDim2.new(0,55,0,18)
    valLbl.Position=UDim2.new(1,-60,0,7); valLbl.BackgroundTransparency=1
    valLbl.TextColor3=TXT_SEC; valLbl.TextSize=11; valLbl.Font=Enum.Font.Code
    valLbl.TextXAlignment=Enum.TextXAlignment.Right
    valLbl.Text=fmt and fmt(def) or tostring(def); valLbl.Parent=row
    local dsc=Instance.new("TextLabel"); dsc.Size=UDim2.new(1,-24,0,12)
    dsc.Position=UDim2.new(0,12,0,26); dsc.BackgroundTransparency=1
    dsc.TextColor3=TXT_MUT; dsc.TextSize=9; dsc.Font=Enum.Font.Gotham
    dsc.TextXAlignment=Enum.TextXAlignment.Left; dsc.Text=desc; dsc.Parent=row
    local trk=Instance.new("Frame"); trk.Size=UDim2.new(1,-24,0,5)
    trk.Position=UDim2.new(0,12,0,46); trk.BackgroundColor3=Color3.fromRGB(36,36,50)
    trk.BorderSizePixel=0; trk.Parent=row; Instance.new("UICorner",trk).CornerRadius=UDim.new(1,0)
    local fill=Instance.new("Frame"); fill.Size=UDim2.new((def-minV)/(maxV-minV),0,1,0)
    fill.BorderSizePixel=0; fill.Parent=trk; Instance.new("UICorner",fill).CornerRadius=UDim.new(1,0)
    regFill(fill)
    local thumb=Instance.new("Frame"); thumb.Size=UDim2.new(0,11,0,11)
    thumb.Position=UDim2.new((def-minV)/(maxV-minV),-5.5,0.5,-5.5)
    thumb.BackgroundColor3=Color3.fromRGB(255,255,255); thumb.BorderSizePixel=0; thumb.Parent=trk
    Instance.new("UICorner",thumb).CornerRadius=UDim.new(1,0)
    local hit=Instance.new("TextButton"); hit.Size=UDim2.new(1,0,0,22)
    hit.Position=UDim2.new(0,0,0.5,-11); hit.BackgroundTransparency=1; hit.Text=""; hit.Parent=trk
    local drag=false
    hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true end end)
    UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    UserInputService.InputChanged:Connect(function(i)
        if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
            local r=math.clamp((i.Position.X-trk.AbsolutePosition.X)/trk.AbsoluteSize.X,0,1)
            cur=math.floor(minV+r*(maxV-minV))
            fill.Size=UDim2.new(r,0,1,0); thumb.Position=UDim2.new(r,-5.5,0.5,-5.5)
            valLbl.Text=fmt and fmt(cur) or tostring(cur); callback(cur)
        end
    end)
end

local function makeInfoRow(parent,text,color)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,26)
    row.BackgroundColor3=BG_CARD; row.BorderSizePixel=0; row.Parent=parent
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
    local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-14,1,0)
    lbl.Position=UDim2.new(0,10,0,0); lbl.BackgroundTransparency=1
    lbl.TextColor3=color or TXT_MUT; lbl.TextSize=11; lbl.Font=Enum.Font.Code
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Text=text; lbl.Parent=row
end

-- ================================================================
--  HSV COLOR PICKER
-- ================================================================
local colorPickerOpen=false; local colorPickerFrame=nil

local function openColorPicker(anchorFrame)
    if colorPickerFrame and colorPickerFrame.Parent then
        colorPickerFrame:Destroy(); colorPickerFrame=nil; colorPickerOpen=false; return
    end
    colorPickerOpen=true

    local cH,cS,cV=Color3.toHSV(ACCENT)
    local origColor=ACCENT

    local popup=Instance.new("Frame"); popup.Name="ColorPicker"
    popup.Size=UDim2.new(0,340,0,265); popup.ZIndex=60
    popup.BackgroundColor3=Color3.fromRGB(17,17,22); popup.BorderSizePixel=0
    popup.Parent=screenGui
    Instance.new("UICorner",popup).CornerRadius=UDim.new(0,10)
    -- shadow
    local ps=Instance.new("ImageLabel"); ps.Size=UDim2.new(1,20,1,20)
    ps.Position=UDim2.new(0,-10,0,-8); ps.BackgroundTransparency=1
    ps.Image="rbxassetid://6015897843"; ps.ImageColor3=Color3.fromRGB(0,0,0)
    ps.ImageTransparency=0.5; ps.ScaleType=Enum.ScaleType.Slice
    ps.SliceCenter=Rect.new(49,49,450,450); ps.ZIndex=59; ps.Parent=popup

    -- Position near the anchor
    local absPos=anchorFrame.AbsolutePosition
    local absSize=anchorFrame.AbsoluteSize
    local px=absPos.X-(340+8); local py=absPos.Y
    popup.Position=UDim2.new(0,math.max(4,px),0,math.max(4,py))

    colorPickerFrame=popup

    -- SV SQUARE (200x190)
    local svBase=Instance.new("Frame"); svBase.Name="SVBase"
    svBase.Size=UDim2.new(0,200,0,190); svBase.Position=UDim2.new(0,10,0,10)
    svBase.BackgroundColor3=Color3.fromHSV(cH,1,1)
    svBase.BorderSizePixel=0; svBase.ZIndex=61; svBase.Parent=popup
    Instance.new("UICorner",svBase).CornerRadius=UDim.new(0,5)

    -- horizontal gradient: white → pure hue
    local svHGrad=Instance.new("UIGradient")
    svHGrad.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
        ColorSequenceKeypoint.new(1,Color3.fromHSV(cH,1,1))
    })
    svHGrad.Parent=svBase

    -- black vertical overlay
    local svVOverlay=Instance.new("Frame"); svVOverlay.Size=UDim2.new(1,0,1,0)
    svVOverlay.BackgroundColor3=Color3.fromRGB(0,0,0); svVOverlay.BackgroundTransparency=1
    svVOverlay.BorderSizePixel=0; svVOverlay.ZIndex=62; svVOverlay.Parent=svBase
    Instance.new("UICorner",svVOverlay).CornerRadius=UDim.new(0,5)
    local svVGrad=Instance.new("UIGradient"); svVGrad.Rotation=90
    svVGrad.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))
    })
    svVGrad.Transparency=NumberSequence.new({
        NumberSequenceKeypoint.new(0,0),
        NumberSequenceKeypoint.new(1,1)
    })
    svVGrad.Parent=svVOverlay

    -- SV cursor (circle)
    local svCursor=Instance.new("Frame"); svCursor.Size=UDim2.new(0,12,0,12)
    svCursor.Position=UDim2.new(cS,-6,1-cV,-6)
    svCursor.BackgroundColor3=Color3.fromRGB(255,255,255); svCursor.BorderSizePixel=0
    svCursor.ZIndex=64; svCursor.Parent=svBase
    Instance.new("UICorner",svCursor).CornerRadius=UDim.new(1,0)
    local svCursorInner=Instance.new("Frame"); svCursorInner.Size=UDim2.new(0,6,0,6)
    svCursorInner.Position=UDim2.new(0.5,-3,0.5,-3); svCursorInner.BorderSizePixel=0; svCursorInner.ZIndex=65
    svCursorInner.BackgroundColor3=Color3.fromHSV(cH,cS,cV); svCursorInner.Parent=svCursor
    Instance.new("UICorner",svCursorInner).CornerRadius=UDim.new(1,0)

    -- SV hit area
    local svHit=Instance.new("TextButton"); svHit.Size=UDim2.new(1,0,1,0)
    svHit.BackgroundTransparency=1; svHit.Text=""; svHit.ZIndex=63; svHit.Parent=svBase

    -- HUE STRIP (14x190)
    local hueStrip=Instance.new("Frame"); hueStrip.Size=UDim2.new(0,14,0,190)
    hueStrip.Position=UDim2.new(0,218,0,10); hueStrip.BorderSizePixel=0; hueStrip.ZIndex=61; hueStrip.Parent=popup
    Instance.new("UICorner",hueStrip).CornerRadius=UDim.new(0,4)
    local hueGrad=Instance.new("UIGradient"); hueGrad.Rotation=270
    hueGrad.Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromHSV(0,    1,1)),
        ColorSequenceKeypoint.new(0.17,Color3.fromHSV(0.17, 1,1)),
        ColorSequenceKeypoint.new(0.33,Color3.fromHSV(0.33, 1,1)),
        ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5,  1,1)),
        ColorSequenceKeypoint.new(0.67,Color3.fromHSV(0.67, 1,1)),
        ColorSequenceKeypoint.new(0.83,Color3.fromHSV(0.83, 1,1)),
        ColorSequenceKeypoint.new(1,   Color3.fromHSV(0,    1,1)),
    })
    hueGrad.Parent=hueStrip

    -- Hue cursor (horizontal line)
    local hueCursor=Instance.new("Frame"); hueCursor.Size=UDim2.new(1,4,0,3)
    hueCursor.Position=UDim2.new(0,-2,1-cH,-1)
    hueCursor.BackgroundColor3=Color3.fromRGB(255,255,255); hueCursor.BorderSizePixel=0
    hueCursor.ZIndex=62; hueCursor.Parent=hueStrip
    Instance.new("UICorner",hueCursor).CornerRadius=UDim.new(1,0)

    local hueHit=Instance.new("TextButton"); hueHit.Size=UDim2.new(1,8,1,0)
    hueHit.Position=UDim2.new(0,-4,0,0); hueHit.BackgroundTransparency=1
    hueHit.Text=""; hueHit.ZIndex=63; hueHit.Parent=hueStrip

    -- COLOR PREVIEWS (right side)
    local previewX=242

    -- Current
    local curLabel=Instance.new("TextLabel"); curLabel.Size=UDim2.new(0,70,0,12)
    curLabel.Position=UDim2.new(0,previewX,0,10)
    curLabel.BackgroundTransparency=1; curLabel.TextColor3=TXT_SEC
    curLabel.TextSize=9; curLabel.Font=Enum.Font.Gotham; curLabel.Text="Current"; curLabel.ZIndex=61; curLabel.Parent=popup

    local curBox=Instance.new("Frame"); curBox.Size=UDim2.new(0,70,0,56)
    curBox.Position=UDim2.new(0,previewX,0,24)
    curBox.BackgroundColor3=ACCENT; curBox.BorderSizePixel=0; curBox.ZIndex=61; curBox.Parent=popup
    Instance.new("UICorner",curBox).CornerRadius=UDim.new(0,6)

    -- Original
    local origLabel=Instance.new("TextLabel"); origLabel.Size=UDim2.new(0,70,0,12)
    origLabel.Position=UDim2.new(0,previewX,0,88)
    origLabel.BackgroundTransparency=1; origLabel.TextColor3=TXT_SEC
    origLabel.TextSize=9; origLabel.Font=Enum.Font.Gotham; origLabel.Text="Original"; origLabel.ZIndex=61; origLabel.Parent=popup

    local origBox=Instance.new("Frame"); origBox.Size=UDim2.new(0,70,0,56)
    origBox.Position=UDim2.new(0,previewX,0,102)
    origBox.BackgroundColor3=origColor; origBox.BorderSizePixel=0; origBox.ZIndex=61; origBox.Parent=popup
    Instance.new("UICorner",origBox).CornerRadius=UDim.new(0,6)

    -- INPUT FIELDS (bottom)
    local inputY=210

    local function makeField(label, xOff, getVal, onChange)
        local f=Instance.new("Frame"); f.Size=UDim2.new(0,70,0,22)
        f.Position=UDim2.new(0,xOff,0,inputY); f.BackgroundColor3=BG_BTN
        f.BorderSizePixel=0; f.ZIndex=61; f.Parent=popup
        Instance.new("UICorner",f).CornerRadius=UDim.new(0,5)
        local lhdr=Instance.new("TextLabel"); lhdr.Size=UDim2.new(0,16,1,0)
        lhdr.BackgroundTransparency=1; lhdr.TextColor3=TXT_MUT
        lhdr.TextSize=9; lhdr.Font=Enum.Font.GothamBold; lhdr.Text=label; lhdr.ZIndex=62; lhdr.Parent=f
        local tb=Instance.new("TextBox"); tb.Size=UDim2.new(1,-18,1,0)
        tb.Position=UDim2.new(0,16,0,0); tb.BackgroundTransparency=1
        tb.TextColor3=TXT_PRI; tb.TextSize=10; tb.Font=Enum.Font.Code
        tb.TextXAlignment=Enum.TextXAlignment.Left; tb.ClearTextOnFocus=false
        tb.Text=getVal(); tb.ZIndex=62; tb.Parent=f
        tb.FocusLost:Connect(function() pcall(function() onChange(tb.Text) end) end)
        return tb
    end

    local function getRGB()
        return math.floor(Color3.fromHSV(cH,cS,cV).R*255),
               math.floor(Color3.fromHSV(cH,cS,cV).G*255),
               math.floor(Color3.fromHSV(cH,cS,cV).B*255)
    end

    local rField,gField,bField,hexField

    local function updatePickerVisuals()
        local pureHue=Color3.fromHSV(cH,1,1)
        svBase.BackgroundColor3=pureHue
        svHGrad.Color=ColorSequence.new({
            ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),
            ColorSequenceKeypoint.new(1,pureHue)
        })
        svCursor.Position=UDim2.new(math.clamp(cS,0,1),-6,math.clamp(1-cV,0,1),-6)
        svCursorInner.BackgroundColor3=Color3.fromHSV(cH,cS,cV)
        hueCursor.Position=UDim2.new(0,-2,math.clamp(1-cH,0,1),-1)
        local col=Color3.fromHSV(cH,cS,cV)
        curBox.BackgroundColor3=col
        local r,g,b=getRGB()
        if rField then rField.Text=tostring(r) end
        if gField then gField.Text=tostring(g) end
        if bField then bField.Text=tostring(b) end
        if hexField then hexField.Text=string.format("#%02X%02X%02X",r,g,b) end
        setAccent(col)
    end

    rField=makeField("R:", 10, function() return tostring(math.floor(Color3.fromHSV(cH,cS,cV).R*255)) end,
        function(val) local v=tonumber(val); if v then
            local c=Color3.fromHSV(cH,cS,cV)
            local nc=Color3.fromRGB(math.clamp(v,0,255),c.G*255,c.B*255)
            cH,cS,cV=Color3.toHSV(nc); updatePickerVisuals() end end)
    gField=makeField("G:", 88, function() return tostring(math.floor(Color3.fromHSV(cH,cS,cV).G*255)) end,
        function(val) local v=tonumber(val); if v then
            local c=Color3.fromHSV(cH,cS,cV)
            local nc=Color3.fromRGB(c.R*255,math.clamp(v,0,255),c.B*255)
            cH,cS,cV=Color3.toHSV(nc); updatePickerVisuals() end end)
    bField=makeField("B:", 166, function() return tostring(math.floor(Color3.fromHSV(cH,cS,cV).B*255)) end,
        function(val) local v=tonumber(val); if v then
            local c=Color3.fromHSV(cH,cS,cV)
            local nc=Color3.fromRGB(c.R*255,c.G*255,math.clamp(v,0,255))
            cH,cS,cV=Color3.toHSV(nc); updatePickerVisuals() end end)
    hexField=makeField("#:", 244, function()
        local r,g,b=getRGB(); return string.format("%02X%02X%02X",r,g,b) end,
        function(val)
            local hex=(val:gsub("#",""))
            if #hex==6 then
                local r=tonumber(hex:sub(1,2),16); local g=tonumber(hex:sub(3,4),16); local b=tonumber(hex:sub(5,6),16)
                if r and g and b then
                    local nc=Color3.fromRGB(r,g,b); cH,cS,cV=Color3.toHSV(nc); updatePickerVisuals()
                end
            end
        end)

    -- Drag handlers
    local svDrag=false; local hueDrag=false

    local function svUpdate(mx,my)
        cS=math.clamp((mx-svBase.AbsolutePosition.X)/svBase.AbsoluteSize.X,0,1)
        cV=math.clamp(1-(my-svBase.AbsolutePosition.Y)/svBase.AbsoluteSize.Y,0,1)
        updatePickerVisuals()
    end
    local function hueUpdate(my)
        cH=math.clamp(1-(my-hueStrip.AbsolutePosition.Y)/hueStrip.AbsoluteSize.Y,0,1)
        updatePickerVisuals()
    end

    svHit.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then svDrag=true; svUpdate(i.Position.X,i.Position.Y) end
    end)
    hueHit.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then hueDrag=true; hueUpdate(i.Position.Y) end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then svDrag=false; hueDrag=false end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if i.UserInputType~=Enum.UserInputType.MouseMovement then return end
        if svDrag then svUpdate(i.Position.X,i.Position.Y) end
        if hueDrag then hueUpdate(i.Position.Y) end
    end)

    -- Title + close button
    local pickerTitle=Instance.new("TextLabel"); pickerTitle.Size=UDim2.new(1,-30,0,20)
    pickerTitle.Position=UDim2.new(0,10,0,-20); pickerTitle.BackgroundTransparency=1
    pickerTitle.TextColor3=TXT_SEC; pickerTitle.TextSize=10; pickerTitle.Font=Enum.Font.GothamBold
    pickerTitle.TextXAlignment=Enum.TextXAlignment.Left
    pickerTitle.Text="Accent Color Picker"; pickerTitle.ZIndex=61; pickerTitle.Parent=popup
    -- this won't show since it's above, move it to inside
    pickerTitle.Position=UDim2.new(0,10,0,2); pickerTitle.Size=UDim2.new(1,-30,0,8)

    local closePickerBtn=Instance.new("TextButton"); closePickerBtn.Size=UDim2.new(0,18,0,18)
    closePickerBtn.Position=UDim2.new(1,-22,0,6); closePickerBtn.BackgroundColor3=Color3.fromRGB(160,40,40)
    closePickerBtn.TextColor3=Color3.fromRGB(255,255,255); closePickerBtn.TextSize=10
    closePickerBtn.Font=Enum.Font.GothamBold; closePickerBtn.Text="✕"; closePickerBtn.BorderSizePixel=0
    closePickerBtn.ZIndex=62; closePickerBtn.Parent=popup
    Instance.new("UICorner",closePickerBtn).CornerRadius=UDim.new(1,0)
    closePickerBtn.MouseButton1Click:Connect(function()
        popup:Destroy(); colorPickerFrame=nil; colorPickerOpen=false
    end)

    updatePickerVisuals()
end

-- ================================================================
--  BUILD PAGES
-- ================================================================
local dribblePage  = createTab("Dribble")
local visualsPage  = createTab("Visuals")
local playersPage  = createTab("Players")
local optionsPage  = createTab("Options")
local infoPage     = createTab("Info")

-- ─────────────────── DRIBBLE ───────────────────
local dribScroll=makeScrollable(dribblePage)
makeSectionCard(dribScroll,"Auto Dribble")

local animToggle=makePillToggle(dribScroll,"Auto Dribble  [Anim]",
    "Fires after server cooldown with animation (0.72s)",
    false,function(st)
        S.EnabledAnim=st
        if st then S.EnabledNoAnim=false noAnimToggle.SetState(false) end
        showNotif(st and "Auto Dribble [Anim] ON" or "Auto Dribble [Anim] OFF",st)
    end)
local animToggleRef=animToggle

local noAnimToggle=makePillToggle(dribScroll,"Auto Dribble  [Silent]",
    "Server-only fire — no visible animation",
    false,function(st)
        S.EnabledNoAnim=st
        if st then S.EnabledAnim=false animToggle.SetState(false) end
        showNotif(st and "Auto Dribble [Silent] ON" or "Auto Dribble [Silent] OFF",st)
    end)
local noAnimToggleRef=noAnimToggle

makeSectionCard(dribScroll,"Steal Detection")
makePillToggle(dribScroll,"Detect Steal & Dribble Moves",
    "Independent of Anim/Silent — detects steal animations",
    false,function(st) S.DetectMoveAnims=st; showNotif(st and "Steal Detection ON" or "Steal Detection OFF",st) end)

makeSectionCard(dribScroll,"Detection Status")
local SCOL={["Finished"]=Color3.fromRGB(40,210,80),["Working on it"]=Color3.fromRGB(255,190,30),["Barely detected"]=Color3.fromRGB(200,60,60)}
local SS={{"NEL","Finished"},{"NEL Reo Camouflage","Working on it"},{"Rin","Finished"},
    {"Cobra","Finished"},{"Don Lorenzo","Working on it"},{"Kurona","Finished"},
    {"Kunigami","Working on it"},{"Sae","Barely detected"},{"Bachira","Finished"},{"Karasu","Barely detected"}}
for _,e in ipairs(SS) do
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,30)
    row.BackgroundColor3=BG_CARD; row.BorderSizePixel=0; row.Parent=dribScroll
    Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
    local nl=Instance.new("TextLabel"); nl.Size=UDim2.new(1,-120,1,0); nl.Position=UDim2.new(0,12,0,0)
    nl.BackgroundTransparency=1; nl.TextColor3=TXT_PRI; nl.TextSize=11; nl.Font=Enum.Font.GothamBold
    nl.TextXAlignment=Enum.TextXAlignment.Left; nl.Text=e[1]; nl.Parent=row
    local badge=Instance.new("Frame"); badge.Size=UDim2.new(0,104,0,20); badge.Position=UDim2.new(1,-110,0.5,-10)
    badge.BackgroundColor3=SCOL[e[2]] or Color3.fromRGB(70,70,90)
    badge.BackgroundTransparency=0.2; badge.BorderSizePixel=0; badge.Parent=row
    Instance.new("UICorner",badge).CornerRadius=UDim.new(0,5)
    local bl=Instance.new("TextLabel"); bl.Size=UDim2.new(1,0,1,0); bl.BackgroundTransparency=1
    bl.TextColor3=Color3.fromRGB(255,255,255); bl.TextSize=9; bl.Font=Enum.Font.GothamBold; bl.Text=e[2]; bl.Parent=badge
end

-- ─────────────────── VISUALS ───────────────────
local visScroll=makeScrollable(visualsPage)
makeSectionCard(visScroll,"Ball Trajectory")
makePillToggle(visScroll,"Trajectory",
    "Red arc + gold landing marker with distance",
    false,function(st) VS.TrajectoryEnabled=st; if not st then pcall(hideTraj) end
        showNotif(st and "Trajectory ON" or "Trajectory OFF",st) end)

makeSectionCard(visScroll,"Ball Prediction")
makePillToggle(visScroll,"Ball Prediction",
    "Red ball at exact landing — stops before GK goal",
    false,function(st) VS.BallPredEnabled=st; if not st then pcall(hidePred) end
        showNotif(st and "Ball Prediction ON" or "Ball Prediction OFF",st) end)
makePillToggle(visScroll,"Show Distance Label",
    "Shows meters label above the red prediction ball",
    true,function(st) VS.BallPredShowDist=st end)

makeSectionCard(visScroll,"Aim Line")
makePillToggle(visScroll,"Aim Line",
    "Follows ball holder every frame — never drops",
    false,function(st) VS.AimEnabled=st; if not st then pcall(clearAllAimLines) end
        showNotif(st and "Aim Line ON" or "Aim Line OFF",st) end)
makeSlider(visScroll,"Aim Line Length","Range: 20 (short) → 200 (very long)",20,200,60,nil,
    function(v) VS.AimLineLen=v end)

makeSectionCard(visScroll,"Style Viewer")
makePillToggle(visScroll,"Show Player Styles",
    "Displays style name above every player",
    false,function(st) VS.StyleEnabled=st
        if not st then for _,bb in pairs(styleBBs) do if bb then bb.Enabled=false end end end
        showNotif(st and "Style Viewer ON" or "Style Viewer OFF",st) end)

-- ─────────────────── PLAYERS ───────────────────
local plScroll=makeScrollable(playersPage)
makeSectionCard(plScroll,"Player List")
makeInfoRow(plScroll,"Live player list — updates every frame",TXT_MUT)

local playerListCards={}
local function refreshPlayerList()
    for _,c in pairs(playerListCards) do if c and c.Parent then c:Destroy() end end
    playerListCards={}
    for _,p in ipairs(Players:GetPlayers()) do
        local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,32)
        row.BackgroundColor3=p==L and Color3.fromRGB(22,30,22) or BG_CARD
        row.BorderSizePixel=0; row.Parent=plScroll
        Instance.new("UICorner",row).CornerRadius=UDim.new(0,6)
        -- Team color dot
        local dot=Instance.new("Frame"); dot.Size=UDim2.new(0,8,0,8)
        dot.Position=UDim2.new(0,10,0.5,-4)
        dot.BackgroundColor3=p.TeamColor and p.TeamColor.Color or Color3.fromRGB(80,80,90)
        dot.BorderSizePixel=0; dot.Parent=row
        Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
        -- Name
        local nl=Instance.new("TextLabel"); nl.Size=UDim2.new(1,-120,1,0); nl.Position=UDim2.new(0,24,0,0)
        nl.BackgroundTransparency=1; nl.TextColor3=p==L and C_GREEN or TXT_PRI
        nl.TextSize=11; nl.Font=p==L and Enum.Font.GothamBold or Enum.Font.Gotham
        nl.TextXAlignment=Enum.TextXAlignment.Left
        nl.Text=p.DisplayName..(p==L and "  (you)" or ""); nl.Parent=row
        -- Style
        local sty=getPlayerStyle(p)
        if sty then
            local sl=Instance.new("TextLabel"); sl.Size=UDim2.new(0,100,1,0)
            sl.Position=UDim2.new(1,-106,0,0); sl.BackgroundTransparency=1
            sl.TextColor3=TXT_MUT; sl.TextSize=9; sl.Font=Enum.Font.Code
            sl.TextXAlignment=Enum.TextXAlignment.Right; sl.Text=tostring(sty); sl.Parent=row
        end
        table.insert(playerListCards,row)
    end
end

-- ─────────────────── OPTIONS ───────────────────
-- Two-column layout
local optLeft=Instance.new("Frame"); optLeft.Size=UDim2.new(0.44,0,1,0)
optLeft.BackgroundTransparency=1; optLeft.Parent=optionsPage
local optRight=Instance.new("Frame"); optRight.Size=UDim2.new(0.56,-1,1,0)
optRight.Position=UDim2.new(0.44,1,0,0); optRight.BackgroundTransparency=1; optRight.Parent=optionsPage

-- thin divider
local optDiv=Instance.new("Frame"); optDiv.Size=UDim2.new(0,1,1,0)
optDiv.Position=UDim2.new(0.44,0,0,0); optDiv.BackgroundColor3=Color3.fromRGB(28,28,40)
optDiv.BorderSizePixel=0; optDiv.Parent=optionsPage

local leftScroll=makeScrollable(optLeft)
local rightScroll=makeScrollable(optRight)

-- ── LEFT: GENERAL ──
makeSection(leftScroll,"General")
makeCheckboxRow(leftScroll,"Streamproof",false,function(st)
    VS.StreamProof=st end, true)

-- ── LEFT: USER INTERFACE ──
makeSection(leftScroll,"User Interface")
makeCheckboxRow(leftScroll,"Watermark",false,function(st)
    UI_OPTS.Watermark=st; applyWatermark(st) end)
makeCheckboxRow(leftScroll,"Dark Background",false,function(st)
    UI_OPTS.DarkBackground=st; applyDarkBG(st) end)
makeCheckboxRow(leftScroll,"Snow Effect",false,function(st)
    UI_OPTS.SnowEffect=st end)
makeCheckboxRow(leftScroll,"Blur",false,function(st)
    UI_OPTS.Blur=st; applyBlur(st) end)

-- ── LEFT: UI ELEMENTS ──
makeSection(leftScroll,"UI Elements")
makeCheckboxRow(leftScroll,"Keybind List",true,function(st) UI_OPTS.KeybindList=st end, true)
makeCheckboxRow(leftScroll,"Notification Sound",true,function(st) UI_OPTS.NotifSound=st end, true)

-- ── RIGHT: THEME ──
makeSection(rightScroll,"Theme")

-- Menu Key
local mkRow=Instance.new("Frame"); mkRow.Size=UDim2.new(1,0,0,30)
mkRow.BackgroundTransparency=1; mkRow.Parent=rightScroll
local mkLbl=Instance.new("TextLabel"); mkLbl.Size=UDim2.new(0.5,0,1,0)
mkLbl.BackgroundTransparency=1; mkLbl.TextColor3=TXT_PRI; mkLbl.TextSize=12; mkLbl.Font=Enum.Font.Gotham
mkLbl.TextXAlignment=Enum.TextXAlignment.Left; mkLbl.Text="Menu Key"; mkLbl.Parent=mkRow
local mkBtn=Instance.new("TextButton"); mkBtn.Size=UDim2.new(0.5,-4,0,24)
mkBtn.Position=UDim2.new(0.5,4,0.5,-12); mkBtn.BackgroundColor3=BG_BTN
mkBtn.TextSize=10; mkBtn.Font=Enum.Font.Code
mkBtn.Text=tostring(KB.ToggleMenu):gsub("Enum.KeyCode.",""); mkBtn.BorderSizePixel=0; mkBtn.Parent=mkRow
Instance.new("UICorner",mkBtn).CornerRadius=UDim.new(0,6); regTxt(mkBtn)
local mkListening=false
mkBtn.MouseButton1Click:Connect(function()
    if mkListening then return end; mkListening=true; mkBtn.Text="[ press key ]"
    mkBtn.TextColor3=Color3.fromRGB(255,80,80)
    local conn; conn=UserInputService.InputBegan:Connect(function(inp,gp)
        if gp then return end
        if inp.UserInputType~=Enum.UserInputType.Keyboard then return end
        conn:Disconnect(); KB.ToggleMenu=inp.KeyCode
        mkBtn.Text=tostring(inp.KeyCode):gsub("Enum.KeyCode.","")
        mkBtn.TextColor3=ACCENT; mkListening=false
    end)
end)

-- Accent Color row
local acRow=Instance.new("Frame"); acRow.Size=UDim2.new(1,0,0,30)
acRow.BackgroundTransparency=1; acRow.Parent=rightScroll
local acLbl=Instance.new("TextLabel"); acLbl.Size=UDim2.new(0.5,0,1,0)
acLbl.BackgroundTransparency=1; acLbl.TextColor3=TXT_PRI; acLbl.TextSize=12; acLbl.Font=Enum.Font.Gotham
acLbl.TextXAlignment=Enum.TextXAlignment.Left; acLbl.Text="Accent Color"; acLbl.Parent=acRow
local acPreview=Instance.new("TextButton"); acPreview.Size=UDim2.new(0,28,0,28)
acPreview.Position=UDim2.new(1,-30,0.5,-14); acPreview.BackgroundColor3=ACCENT
acPreview.Text=""; acPreview.BorderSizePixel=0; acPreview.Parent=acRow
Instance.new("UICorner",acPreview).CornerRadius=UDim.new(0,6)
regBG(acPreview)  -- preview square updates with accent

acPreview.MouseButton1Click:Connect(function()
    openColorPicker(acPreview)
end)

-- ── RIGHT: SESSION ──
makeSection(rightScroll,"Session")

-- Username / stable
local sessUser=Instance.new("Frame"); sessUser.Size=UDim2.new(1,0,0,44)
sessUser.BackgroundColor3=BG_CARD; sessUser.BorderSizePixel=0; sessUser.Parent=rightScroll
Instance.new("UICorner",sessUser).CornerRadius=UDim.new(0,7)
local unLbl=Instance.new("TextLabel"); unLbl.Size=UDim2.new(1,0,0.5,0)
unLbl.BackgroundTransparency=1; unLbl.TextColor3=TXT_PRI
unLbl.TextSize=13; unLbl.Font=Enum.Font.GothamBold; unLbl.Text=L.Name; unLbl.Parent=sessUser
local stLbl2=Instance.new("TextLabel"); stLbl2.Size=UDim2.new(1,0,0.5,0)
stLbl2.Position=UDim2.new(0,0,0.5,0); stLbl2.BackgroundTransparency=1
stLbl2.TextSize=10; stLbl2.Font=Enum.Font.Gotham; stLbl2.Text="Stable"; stLbl2.Parent=sessUser
regTxt(stLbl2)

-- Game ID / Place ID
local function makeIDRow(label, value)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,24)
    row.BackgroundTransparency=1; row.Parent=rightScroll
    local ll=Instance.new("TextLabel"); ll.Size=UDim2.new(0.45,0,1,0)
    ll.BackgroundTransparency=1; ll.TextColor3=TXT_MUT; ll.TextSize=10; ll.Font=Enum.Font.Gotham
    ll.TextXAlignment=Enum.TextXAlignment.Left; ll.Text=label; ll.Parent=row
    local vl=Instance.new("TextLabel"); vl.Size=UDim2.new(0.55,0,1,0)
    vl.Position=UDim2.new(0.45,0,0,0); vl.BackgroundTransparency=1
    vl.TextSize=10; vl.Font=Enum.Font.Code
    vl.TextXAlignment=Enum.TextXAlignment.Right; vl.Text=tostring(value); vl.Parent=row
    regTxt(vl)
end
makeIDRow("Game ID", game.GameId)
makeIDRow("Place ID", game.PlaceId)

-- Session buttons
local function makeSessBtn(text, w, xpos, color, cb)
    local b=Instance.new("TextButton"); b.Size=UDim2.new(w,xpos and -3 or 0,0,30)
    if xpos then b.Position=UDim2.new(xpos,3,0,0) end
    b.BackgroundColor3=color or BG_BTN; b.TextColor3=TXT_PRI
    b.TextSize=11; b.Font=Enum.Font.GothamBold; b.Text=text; b.BorderSizePixel=0; b.Parent=rightScroll
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6); b.MouseButton1Click:Connect(cb); return b
end

-- Rejoin + Server Hop (side by side)
local rejoinRow=Instance.new("Frame"); rejoinRow.Size=UDim2.new(1,0,0,32)
rejoinRow.BackgroundTransparency=1; rejoinRow.Parent=rightScroll
local rejoinBtn=Instance.new("TextButton"); rejoinBtn.Size=UDim2.new(0.5,-3,0,28)
rejoinBtn.BackgroundColor3=BG_BTN; rejoinBtn.TextColor3=TXT_PRI
rejoinBtn.TextSize=11; rejoinBtn.Font=Enum.Font.GothamBold; rejoinBtn.Text="Rejoin"
rejoinBtn.BorderSizePixel=0; rejoinBtn.Parent=rejoinRow
Instance.new("UICorner",rejoinBtn).CornerRadius=UDim.new(0,6)
rejoinBtn.MouseButton1Click:Connect(function()
    pcall(function() TeleportService:Teleport(game.PlaceId, L) end)
end)
local srvBtn=Instance.new("TextButton"); srvBtn.Size=UDim2.new(0.5,-3,0,28)
srvBtn.Position=UDim2.new(0.5,3,0,0); srvBtn.BackgroundColor3=BG_BTN; srvBtn.TextColor3=TXT_PRI
srvBtn.TextSize=11; srvBtn.Font=Enum.Font.GothamBold; srvBtn.Text="Server Hop"
srvBtn.BorderSizePixel=0; srvBtn.Parent=rejoinRow
Instance.new("UICorner",srvBtn).CornerRadius=UDim.new(0,6)
srvBtn.MouseButton1Click:Connect(function()
    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, L) end)
end)

-- Rescan
local rescanRow=Instance.new("Frame"); rescanRow.Size=UDim2.new(1,0,0,32)
rescanRow.BackgroundTransparency=1; rescanRow.Parent=rightScroll
local rescanBtn=Instance.new("TextButton"); rescanBtn.Size=UDim2.new(1,0,0,28)
rescanBtn.BackgroundColor3=BG_BTN; rescanBtn.TextColor3=TXT_PRI
rescanBtn.TextSize=11; rescanBtn.Font=Enum.Font.GothamBold; rescanBtn.Text="Rescan"
rescanBtn.BorderSizePixel=0; rescanBtn.Parent=rescanRow
Instance.new("UICorner",rescanBtn).CornerRadius=UDim.new(0,6)
rescanBtn.MouseButton1Click:Connect(function()
    pcall(InitChar); showNotif("Rescan complete",nil)
end)

-- Eject (closes the script)
local ejectRow=Instance.new("Frame"); ejectRow.Size=UDim2.new(1,0,0,32)
ejectRow.BackgroundTransparency=1; ejectRow.Parent=rightScroll
local ejectBtn=Instance.new("TextButton"); ejectBtn.Size=UDim2.new(1,0,0,28)
ejectBtn.BackgroundColor3=Color3.fromRGB(80,14,14); ejectBtn.TextColor3=Color3.fromRGB(255,90,90)
ejectBtn.TextSize=11; ejectBtn.Font=Enum.Font.GothamBold; ejectBtn.Text="Eject"
ejectBtn.BorderSizePixel=0; ejectBtn.Parent=ejectRow
Instance.new("UICorner",ejectBtn).CornerRadius=UDim.new(0,6)
ejectBtn.MouseButton1Click:Connect(function()
    TweenService:Create(uiScale,TweenInfo.new(0.22,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Scale=0}):Play()
    task.wait(0.26); pcall(function()
        hideTraj(); hidePred(); clearAllAimLines()
        for _,bb in pairs(styleBBs) do pcall(function() bb:Destroy() end) end
        trajFolder:Destroy(); aimFolder:Destroy(); predFolder:Destroy()
        applyBlur(false); applyDarkBG(false); applyWatermark(false)
    end)
    screenGui:Destroy(); notifGui:Destroy()
end)

-- ─────────────────── INFO ───────────────────
local infoScroll=makeScrollable(infoPage)
makeSectionCard(infoScroll,"About")
makeInfoRow(infoScroll,"Denzel's Comfort  //  v9.2",TXT_PRI)
makeInfoRow(infoScroll,"discord: denzel.natsuki",ACCENT)
makeInfoRow(infoScroll,"built: Mar 8 2026",TXT_MUT)
makeSectionCard(infoScroll,"Changelog v9.2")
makeInfoRow(infoScroll,"[NEW] Full Matcha Comfort style UI")
makeInfoRow(infoScroll,"[NEW] HSV color picker with drag interaction")
makeInfoRow(infoScroll,"[NEW] Two-column Options page (General/UI/Session)")
makeInfoRow(infoScroll,"[NEW] Session section with real Game ID + Place ID")
makeInfoRow(infoScroll,"[NEW] Rejoin, Server Hop, Rescan, Eject buttons")
makeInfoRow(infoScroll,"[NEW] Bottom credits bar — made by denzel.natsuki")
makeInfoRow(infoScroll,"[NEW] Quick-toggle icon buttons in top bar")
makeInfoRow(infoScroll,"[NEW] Matcha checkbox style toggles for options")
makeInfoRow(infoScroll,"[FIX] Accent registry — ALL elements update instantly")
makeInfoRow(infoScroll,"[FIX] Background opacity min 55% — never invisible")
makeInfoRow(infoScroll,"[FIX] Aim line stable — adornee updated every frame")

selectTab("Dribble")

-- ================================================================
--  KEYBIND OVERLAY
-- ================================================================
local kbOverlay=Instance.new("Frame"); kbOverlay.Name="KBList"
kbOverlay.Size=UDim2.new(0,175,0,0); kbOverlay.Position=UDim2.new(1,-10,0.5,0)
kbOverlay.AnchorPoint=Vector2.new(1,0.5); kbOverlay.BackgroundColor3=BG_PANEL
kbOverlay.BorderSizePixel=0; kbOverlay.AutomaticSize=Enum.AutomaticSize.Y
kbOverlay.Visible=false; kbOverlay.Parent=screenGui
Instance.new("UICorner",kbOverlay).CornerRadius=UDim.new(0,9)
local kbL=Instance.new("UIListLayout"); kbL.FillDirection=Enum.FillDirection.Vertical
kbL.Padding=UDim.new(0,2); kbL.Parent=kbOverlay
local kbP=Instance.new("UIPadding"); kbP.PaddingTop=UDim.new(0,8); kbP.PaddingBottom=UDim.new(0,8)
kbP.PaddingLeft=UDim.new(0,10); kbP.PaddingRight=UDim.new(0,10); kbP.Parent=kbOverlay
local kbHdr=Instance.new("TextLabel"); kbHdr.Size=UDim2.new(1,0,0,20)
kbHdr.BackgroundTransparency=1; kbHdr.TextSize=10; kbHdr.Font=Enum.Font.GothamBold
kbHdr.Text="KEYBIND LIST"; kbHdr.Parent=kbOverlay; regTxt(kbHdr)

local KB_ENTRIES={{"Toggle Menu",function() return KB.ToggleMenu end},
    {"Toggle Dribble",function() return KB.ToggleDribble end},
    {"Keybind List",function() return KB.ToggleKeybind end}}
local kbValueLabels={}
for _,e in ipairs(KB_ENTRIES) do
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,18)
    row.BackgroundTransparency=1; row.Parent=kbOverlay
    local n=Instance.new("TextLabel"); n.Size=UDim2.new(0.6,0,1,0); n.BackgroundTransparency=1
    n.TextColor3=TXT_SEC; n.TextSize=9; n.Font=Enum.Font.Gotham
    n.TextXAlignment=Enum.TextXAlignment.Left; n.Text=e[1]; n.Parent=row
    local k=Instance.new("TextLabel"); k.Size=UDim2.new(0.4,0,1,0); k.Position=UDim2.new(0.6,0,0,0)
    k.BackgroundTransparency=1; k.TextColor3=TXT_PRI; k.TextSize=9; k.Font=Enum.Font.Code
    k.TextXAlignment=Enum.TextXAlignment.Right
    k.Text=tostring(e[2]()):gsub("Enum.KeyCode.",""); k.Parent=row
    table.insert(kbValueLabels,{lbl=k,get=e[2]})
end

local kbOpen=false
local function toggleKbOverlay()
    kbOpen=not kbOpen
    for _,e in ipairs(kbValueLabels) do e.lbl.Text=tostring(e.get()):gsub("Enum.KeyCode.","") end
    kbOverlay.Visible=kbOpen
    if kbOpen then
        kbOverlay.Position=UDim2.new(1,12,0.5,0)
        TweenService:Create(kbOverlay,TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
            Position=UDim2.new(1,-10,0.5,0)
        }):Play()
    end
end

-- ================================================================
--  INPUT
-- ================================================================
local function showGUI()
    GUI_OPEN=true; main.Visible=true
    TweenService:Create(uiScale,TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
end
local function hideGUI()
    GUI_OPEN=false
    TweenService:Create(uiScale,TweenInfo.new(0.20,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Scale=0}):Play()
    task.delay(0.24,function() if not GUI_OPEN then main.Visible=false end end)
end

UserInputService.InputBegan:Connect(function(inp,gp)
    if gp then return end
    if inp.KeyCode==KB.ToggleMenu then if GUI_OPEN then hideGUI() else showGUI() end; return end
    if inp.KeyCode==KB.ToggleKeybind then
        if UI_OPTS.KeybindList then toggleKbOverlay() end; return
    end
    if inp.KeyCode==KB.ToggleDribble then
        if S.EnabledAnim then
            S.EnabledAnim=false; animToggleRef.SetState(false); showNotif("Auto Dribble [Anim] OFF",false)
        elseif S.EnabledNoAnim then
            S.EnabledNoAnim=false; noAnimToggleRef.SetState(false); showNotif("Auto Dribble [Silent] OFF",false)
        end
    end
end)

-- ================================================================
--  INTRO
-- ================================================================
task.spawn(function()
    local snd=Instance.new("Sound"); snd.SoundId="rbxassetid://5982308538"
    snd.Volume=0.45; snd.Parent=L.PlayerGui; task.wait(0.1); snd:Play()
    game:GetService("Debris"):AddItem(snd,4); main.Visible=true
    TweenService:Create(uiScale,TweenInfo.new(0.36,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
    task.wait(0.8); showNotif("Denzel's Comfort v9.2 — discord: denzel.natsuki",nil)
end)

-- ================================================================
--  RENDER LOOP
-- ================================================================
local openTime=tick(); local plRefreshTimer=0
RunService.RenderStepped:Connect(function(dt)
    if not screenGui.Parent then return end
    local e=tick()-openTime
    timeLbl.Text=string.format("%02d:%02d:%02d",math.floor(e/3600),math.floor(e/60)%60,math.floor(e%60))
    fpsLbl.Text=(dt>0 and math.floor(1/dt) or 0).." FPS"
    msLbl.Text=math.floor(GetPing()*1000).." MS"
    -- Update quick icons
    for _,qi in ipairs(quickIcons) do pcall(qi.updIcon) end
    -- Refresh player list occasionally
    plRefreshTimer=plRefreshTimer+dt
    if plRefreshTimer>=3 then plRefreshTimer=0; pcall(refreshPlayerList) end
    -- Visuals
    updateVisuals()
end)

-- Initial player list
task.spawn(refreshPlayerList)

-- created by denzel - owner for help denzel.natsuki on discord
