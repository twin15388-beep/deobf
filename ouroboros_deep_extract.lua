--[[
 NZL Ouroboros deep controller extractor v3
 Run after the embedded/original Ouroboros core is ready.
 Read-only: it does not call setters, remotes, or controller actions.
]]
local methods={
 "SetAutoLevel","SetAutoQuest","SetAutoMob","SetAutoBoss","SetAutoBossHunt",
 "SetAutoLoot","SetAutoChest","SetInstantKill","SetAutoSkills","SetAutoSkillTree",
 "SetAutoEquip","SetAutoPotion","SetNoStun","SetNoRagdoll","SetNoAttackSlowdown",
 "SetNotifyBosses","TeleportToMob","TeleportToNpc","TeleportToZone",
}
local function findAPI()
 if type(getgc)~="function" then return end
 for _,t in ipairs(getgc(true)) do if type(t)=="table" and type(rawget(t,"SetAutoLevel"))=="function" and type(rawget(t,"SetInstantKill"))=="function" then return t end end
end
local api=findAPI(); assert(api,"Ouroboros API not found")
local lines={"-- OUROBOROS DEEP FUNCTION GRAPH v3"}
local ids,set,queue={}, {}, {}
local function fid(f) if not ids[f] then ids[f]=#queue+1;queue[#queue+1]=f end return ids[f] end
for _,name in ipairs(methods) do local f=api[name];if type(f)=="function"then lines[#lines+1]=string.format("ROOT %s = F%d",name,fid(f))end end
local function repr(v)
 local t=typeof(v)
 if t=="string"then return string.format("%q",v)end
 if t=="number"or t=="boolean"or t=="nil"then return tostring(v)end
 if t=="Instance"then local ok,n=pcall(v.GetFullName,v);return ok and("INSTANCE("..n..")")or"INSTANCE"end
 if t=="Vector3"or t=="CFrame"or t=="Color3"or t=="EnumItem"then return tostring(v)end
 return "<"..t..">"
end
local qi=1
while qi<=#queue and qi<=1200 do
 local f=queue[qi]; qi+=1
 if not set[f]then
  set[f]=true;local id=ids[f];local src,line,name="?","?","?";pcall(function()src=debug.info(f,"s");line=debug.info(f,"l");name=debug.info(f,"n")end)
  lines[#lines+1]=string.format("\nFUNCTION F%d source=%s line=%s name=%s",id,tostring(src),tostring(line),tostring(name))
  if type(getconstants)=="function"then local ok,c=pcall(getconstants,f);if ok and type(c)=="table"then local a={}for i,v in pairs(c)do if type(v)=="function"then a[#a+1]=string.format("[%s]=F%d",i,fid(v))else a[#a+1]=string.format("[%s]=%s",i,repr(v))end end;lines[#lines+1]="CONSTANTS "..table.concat(a," | ")end end
  if type(getupvalues)=="function"then local ok,u=pcall(getupvalues,f);if ok and type(u)=="table"then for i,v in pairs(u)do
   if type(v)=="function"then lines[#lines+1]=string.format("UP[%s]=F%d",i,fid(v))
   elseif type(v)=="table"then
    local fields={};local n=0
    for k,x in pairs(v)do n+=1;if n>180 then fields[#fields+1]="...";break end
     if type(x)=="function"then fields[#fields+1]=string.format("%s=F%d",repr(k),fid(x))
     elseif type(x)~="table"then fields[#fields+1]=repr(k).."="..repr(x)end
    end
    table.sort(fields);lines[#lines+1]=string.format("UP[%s]=TABLE{%s}",i,table.concat(fields,","))
   else lines[#lines+1]=string.format("UP[%s]=%s",i,repr(v))end
  end end end
  if type(getprotos)=="function"then local ok,p=pcall(getprotos,f);if ok and type(p)=="table"then local z={}for i,x in pairs(p)do if type(x)=="function"then z[#z+1]=string.format("P%s=F%d",i,fid(x))end end;if#z>0 then lines[#lines+1]="PROTOS "..table.concat(z,", ")end end end
 end
end
lines[#lines+1]=string.format("\n-- functions discovered=%d emitted=%d",#queue,qi-1)
local result=table.concat(lines,"\n");((getgenv and getgenv())or _G).__OURO_DEEP_EXTRACT=result
for _,f in ipairs({setclipboard,toclipboard,set_clipboard})do if type(f)=="function"and pcall(f,result)then break end end
print("[NZL deep extract] bytes="..#result.." functions="..#queue)
return result
