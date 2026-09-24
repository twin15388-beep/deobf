-- NZL Studio — exact Ouroboros behavior recorder
-- Run AFTER original Ouroboros. It records calls and copies them; it does not block or change return values.
local RS=game:GetService("ReplicatedStorage")
local Players=game:GetService("Players")
local LP=Players.LocalPlayer
local logs,started={},os.clock()
local function repr(v,depth)
 depth=depth or 0;if depth>3 then return "{...}"end
 local t=typeof(v)
 if t=="string"then return string.format("%q",v)elseif t=="number"or t=="boolean"or t=="nil"then return tostring(v)
 elseif t=="Instance"then return "INSTANCE("..v:GetFullName()..")"
 elseif t=="Vector3"then return ("Vector3(%.2f,%.2f,%.2f)"):format(v.X,v.Y,v.Z)
 elseif t=="CFrame"then local p=v.Position;return ("CFrame(%.2f,%.2f,%.2f)"):format(p.X,p.Y,p.Z)
 elseif t=="table"then local o,n={"{"},0;for k,x in pairs(v)do n+=1;if n>20 then o[#o+1]="..."break end;o[#o+1]="["..repr(k,depth+1).."]="..repr(x,depth+1)..","end;o[#o+1]="}";return table.concat(o)end
 return t.."("..tostring(v)..")"
end
local function log(kind,...)
 local p=table.pack(...);local o={("[%8.3f] %s"):format(os.clock()-started,kind)}
 for i=1,p.n do o[#o+1]="  A"..i.."="..repr(p[i])end
 logs[#logs+1]=table.concat(o,"\n")
end
local function path(root,... )local x=root;for _,n in ipairs({...})do x=x and x:FindFirstChild(n)end;return x end
local function req(x)local ok,v=pcall(require,x);return ok and v or nil end
local hooked={}
local function wrapTable(tbl,key,label)
 if type(tbl)~="table"or type(tbl[key])~="function"then log("HOOK_MISSING "..label);return end
 local old=tbl[key];tbl[key]=function(... )log(label,...);local r=table.pack(old(...));log(label.." RETURN",table.unpack(r,1,r.n));return table.unpack(r,1,r.n)end
 hooked[#hooked+1]=function()if tbl[key]~=old then tbl[key]=old end end;log("HOOKED "..label)
end
local SignalEvent=req(path(RS,"Communication","ServerAndClient","Signals","SignalEvent"))
local SignalFunction=req(path(RS,"Communication","ServerAndClient","Signals","SignalFunction"))
local InputHandler=req(path(RS,"CAM","Client","Components","Client","InputHandler"))
local SkillController=req(path(RS,"CAM","Client","Controllers","Skill_Controller"))
wrapTable(SignalEvent,"ToServer","SignalEvent.ToServer")
wrapTable(SignalFunction,"ToServer","SignalFunction.ToServer")
wrapTable(InputHandler,"VirtualPress","InputHandler.VirtualPress")
wrapTable(InputHandler,"VirtualRelease","InputHandler.VirtualRelease")
wrapTable(SkillController,"Attempt_Hold","SkillController.Attempt_Hold")
wrapTable(SkillController,"StopHold","SkillController.StopHold")

local api,active={},{}
if type(getgc)=="function"then for _,v in ipairs(getgc(true))do if type(v)=="table"and type(rawget(v,"SetAutoLevel"))=="function"and type(rawget(v,"SetAutoMob"))=="function"then api=v;break end end end
if api then
 for _,name in ipairs({"SetAutoLevel","SetAutoQuest","SetAutoMob","SetAutoBoss","SetAutoBossHunt","SetAutoLoot","SetAutoChest","SetInstantKill","SetAutoSkills","SetAutoSkillTree","SetAutoEquip","SetAutoPotion","TeleportToMob","TeleportToNpc","TeleportToZone"})do
  local featureName=name;local old=rawget(api,featureName)
  if type(old)=="function"then
   api[featureName]=function(... )
    local args=table.pack(...);log("API."..featureName,table.unpack(args,1,args.n))
    if featureName:sub(1,3)=="Set" and type(args[1])=="boolean"then active[featureName]=args[1]end
    local r=table.pack(old(table.unpack(args,1,args.n)));log("API."..featureName.." RETURN",table.unpack(r,1,r.n));return table.unpack(r,1,r.n)
   end
   hooked[#hooked+1]=function()api[featureName]=old end
  end
 end
 log("API_FOUND")
else log("API_NOT_FOUND")end

-- Local movement and interaction sampler. Loot/chest travel often performs no server wrapper call.
local sampling=true;local lastPosition
local function nearby(position)
 local list={}
 for _,object in ipairs(workspace:GetPartBoundsInRadius(position,18))do
  local model=object:FindFirstAncestorOfClass("Model");local candidate=model or object
  local name=candidate.Name
  if not table.find(list,name)then list[#list+1]=name;if #list>=8 then break end end
 end
 return table.concat(list," | ")
end
task.spawn(function()
 while sampling do
  task.wait(.20)
  local character=LP.Character;local root=character and character:FindFirstChild("HumanoidRootPart")
  if root and next(active)then
   local position=root.Position
   if not lastPosition or (position-lastPosition).Magnitude>=6 then
    local enabled={};for name,value in pairs(active)do if value then enabled[#enabled+1]=name end end;table.sort(enabled)
    if #enabled>0 then log("LOCAL_MOVE ["..table.concat(enabled,",").."]",root.CFrame,"NEAR="..nearby(position))end
    lastPosition=position
   end
  else lastPosition=nil end
 end
end)

local gui=Instance.new("ScreenGui");gui.Name="NZL_BehaviorTrace";gui.ResetOnSpawn=false
local parent=(type(gethui)=="function"and gethui())or game:GetService("CoreGui");gui.Parent=parent
local f=Instance.new("Frame");f.Size=UDim2.fromOffset(430,190);f.Position=UDim2.new(.5,-215,.5,-95);f.BackgroundColor3=Color3.fromRGB(14,17,24);f.Parent=gui;Instance.new("UICorner",f).CornerRadius=UDim.new(0,10)
local t=Instance.new("TextLabel");t.Size=UDim2.new(1,-24,0,75);t.Position=UDim2.fromOffset(12,10);t.BackgroundTransparency=1;t.TextColor3=Color3.new(1,1,1);t.Font=Enum.Font.Gotham;t.TextSize=14;t.TextWrapped=true;t.Text="Recorder active. In ORIGINAL Ouroboros toggle one feature at a time: Auto Mob, Quest, Loot, Chest, Skills. Then press COPY TRACE.";t.Parent=f
local b=Instance.new("TextButton");b.Size=UDim2.new(1,-24,0,42);b.Position=UDim2.fromOffset(12,92);b.BackgroundColor3=Color3.fromRGB(55,115,235);b.TextColor3=Color3.new(1,1,1);b.Font=Enum.Font.GothamBold;b.Text="COPY TRACE";b.Parent=f;Instance.new("UICorner",b).CornerRadius=UDim.new(0,8)
local stop=Instance.new("TextButton");stop.Size=UDim2.new(1,-24,0,34);stop.Position=UDim2.fromOffset(12,142);stop.BackgroundColor3=Color3.fromRGB(55,58,68);stop.TextColor3=Color3.new(1,1,1);stop.Font=Enum.Font.Gotham;stop.Text="STOP & RESTORE";stop.Parent=f;Instance.new("UICorner",stop).CornerRadius=UDim.new(0,8)
b.MouseButton1Click:Connect(function()
 local text="OUROBOROS_BEHAVIOR_TRACE_V2\n"..table.concat(logs,"\n\n");local cb=setclipboard or toclipboard
 if type(cb)=="function"then cb(text);t.Text="Copied "..#text.." characters. Send it to me."else t.Text="Clipboard unsupported"end
end)
stop.MouseButton1Click:Connect(function()sampling=false;for i=#hooked,1,-1 do pcall(hooked[i])end;gui:Destroy()end)
