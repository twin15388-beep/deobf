-- [context: Roblox Lua/Luau executor — client-side | OS: Windows / macOS | arch: x86-64]
-- [game: One Piece "Kaitun" | script: Nav v2.1 | author: Lunar]
-- [fixes: F1 travel_to arrival race | F2 rifle buy poll | F3 equip watcher]
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer
local Events = RS:FindFirstChild("Events")
local footstep = Events and Events:FindFirstChild("footstep")
local takestam = Events and Events:FindFirstChild("takestam")
local setspawn = Events and Events:FindFirstChild("SetSpawn")
local DESTINATIONS = { ["Town of Beginners"] = Vector3.new(-552.6748, 5.0750, -3625.3196), ["Sandora"] = Vector3.new(-1543.7411, 3.9750, -3352.3557), ["Shell's Town"] = Vector3.new(-1339.9171, 9.8750, -5098.3813),}
local CHESTS = {Vector3.new(-490.9106, 9.0750, -3453.1069), Vector3.new(-454.3432, 6.7991, -3362.0801), Vector3.new(-504.4183, 77.5221, -3595.9368), Vector3.new(-599.0577, 77.5221, -3596.2874),}
local RIFLE_POSE = Vector3.new(-529.9510, 5.9500, -3449.2815)
local POST_RIFLE_WALK = Vector3.new(1832.2390, 4.0750, -12175.9600)
local POST_RIFLE_TP = Vector3.new(1793.72681, -92.7619934, -12327.4541)
local ORB_DEST = Vector3.new(8004.0854, -2153.8320, -17015.4121)
local SPAWN_SET_POS = Vector3.new(7974.3145, -2152.8320, -17075.0137)
local AFTER_SPAWN_POS = Vector3.new(7819.4009, -2159.8320, -17145.0469)
local RIFLE_NAME = "Rifle"
local RIFLE_COST = 300
local ORB_VERIFY_RADIUS = 60
local ORB_MAX_TRIES = 5
local ORB_RETRY_WAIT = 2.5
local ORB_POST_TP_WAIT = 4.0
local CFG = {max_speed = 40, min_speed = 28, jitter_rate = 0.5, trip_limit = 3, cooldown = 1.2, step_rate = 0.30, stam_rate = 0.20, stam_drain = 0.505, ray_fwd = 3.5, ray_up = 250, clearance = 3, min_wall = 3.0, land_ahead = 1.5, hop_margin = 1.2, hop_fwd = 2.5, debris_height = 0.8, glue_fwd = 1.2, fly_speed = 45, fly_vspeed = 30, fly_stam_rate = 0.20, fly_stam_drain = 0.505, fly_max_time = 90, fly_smooth = 0.45, tp_offset_y = 3, tp_beat_ms = 50, farm_chest_pause = 0.8, farm_e_hold = 0.5, farm_t_hold = 0.4, farm_arrive_eps = 4, chest_seen_eps = 8, water_walk = true, water_offset = 3, chest_claim_tries = 3, chest_claim_eps = 12, fog_end = 100000, fog_start = 0, clock_time = 14, brightness = 2, travel_arrive_eps = 7, rifle_poll_secs = 5, rifle_poll_rate = 0.30, equip_watch_rate = 0.5,}
local mode = "idle"
local target = nil
local root = nil
local cur_spd = CFG.min_speed
local jit_acc = 0
local trip_cnt = 0
local cool_until = 0
local intended = nil
local last_hop = 0
local fly_dir = Vector3.zero
local fly_start = 0
local fly_stam_acc = 0
local farm_on = false
local farm_stage = "idle"
local farm_idx = 1
local farm_rifle_owned = false
local dev_chest_only = false
local failed_chests = {}
local no_fog_on = false
local RAY_PARAMS_GROUND = RaycastParams.new()
RAY_PARAMS_GROUND.FilterType = Enum.RaycastFilterType.Exclude
RAY_PARAMS_GROUND.IgnoreWater = true
local RAY_PARAMS_WATER = RaycastParams.new()
RAY_PARAMS_WATER.FilterType = Enum.RaycastFilterType.Include
RAY_PARAMS_WATER.IgnoreWater = false
local function getRoot()
  local c = LP.Character;
  return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
  local c = LP.Character;
  return c and c:FindFirstChildOfClass("Humanoid")
end
local function find_ocean()
  local env = workspace:FindFirstChild("Env")
  local ws = env and env:FindFirstChild("WaterStuff")
  local ocean = ws and ws:FindFirstChild("Ocean")
  if ocean and ocean:IsA("BasePart") then
    return ocean
  end
  for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and v.Name == "Ocean" then
      return v
    end
  end
  return nil
end
local _ocean = nil
local function ocean()
  if _ocean and _ocean.Parent then
    return _ocean
  end
  _ocean = find_ocean()
  return _ocean
end
local function refresh_filter()
  RAY_PARAMS_GROUND.FilterDescendantsInstances = {LP.Character}
end
local function ray(o, d)
  return workspace:Raycast(o, d, RAY_PARAMS_GROUND)
end
local function water_surface_y_at(x, z)
  if not CFG.water_walk then
    return nil
  end
  local o = ocean();
  if not o then
    return nil
  end
  local top_y_guess = o.Position.Y + (o.Size.Y / 2) + 5
  RAY_PARAMS_WATER.FilterDescendantsInstances = {o}
  local hit = workspace:Raycast(Vector3.new(x, top_y_guess, z), Vector3.new(0, - (o.Size.Y + 20), 0), RAY_PARAMS_WATER)
  if hit then
    return hit.Position.Y
  end
  return o.Position.Y + (o.Size.Y / 2)
end
local function apply_water_walk(np)
  local wy = water_surface_y_at(np.X, np.Z)
  if not wy then
    return np
  end
  local target_y = wy + CFG.water_offset
  if np.Y < target_y then
    return Vector3.new(np.X, target_y, np.Z)
  end
  return np
end
local function tick_footstep()
  if footstep then
    pcall(function()
      footstep:FireServer()
    end
    )
  end
end
local function tick_stam(drain)
  if not (takestam and root) then
    return
  end
  local p = root.Position
  pcall(function()
    takestam:FireServer(drain or CFG.stam_drain, "dash", CFrame.new(p, p + Vector3.new(0, 0, -1)))
  end
  )
end
local function write_cframe(cf)
  root.CFrame = cf
  root.Velocity = Vector3.zero
  root.AssemblyLinearVelocity = Vector3.zero
  intended = cf.Position
end
local function check_correction()
  if not intended or not root then
    return
  end
  local delta = (root.Position - intended).Magnitude
  if delta > 1.0 then
    trip_cnt = trip_cnt + 1
    if trip_cnt >= CFG.trip_limit then
      trip_cnt = 0;
      cool_until = tick() + CFG.cooldown
      toast("Movement corrected", "warn")
    end
  else
    trip_cnt = math.max(0, trip_cnt - 0.1)
  end
  intended = nil
end
-- ============ TOAST ============
local toast_stack = nil
local toast_count = 0
local function init_toasts()
  local bpg = LP:FindFirstChild("PlayerGui");
  if not bpg then
    return
  end
  local sg = Instance.new("ScreenGui")
  sg.Name = "_nav_toasts";
  sg.ResetOnSpawn = false;
  sg.IgnoreGuiInset = true;
  sg.Parent = bpg
  local frame = Instance.new("Frame")
  frame.BackgroundTransparency = 1
  frame.AnchorPoint = Vector2.new(1, 0)
  frame.Position = UDim2.new(1, -16, 0, 16)
  frame.Size = UDim2.new(0, 280, 1, -32)
  frame.Parent = sg
  local layout = Instance.new("UIListLayout")
  layout.Padding = UDim.new(0, 6)
  layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
  layout.Parent = frame
  toast_stack = frame
end
function toast(msg, kind)
  if not toast_stack then
    init_toasts()
  end
  if not toast_stack then
    return
  end
  toast_count = toast_count + 1
  local color = Color3.fromRGB(45, 55, 70)
  local accent = Color3.fromRGB(90, 170, 255)
  if kind == "ok" then
    accent = Color3.fromRGB(90, 220, 130)
  end
  if kind == "warn" then
    accent = Color3.fromRGB(255, 180, 70)
  end
  if kind == "err" then
    accent = Color3.fromRGB(255, 90, 90)
  end
  if kind == "farm" then
    accent = Color3.fromRGB(180, 140, 255)
  end
  local card = Instance.new("Frame")
  card.BackgroundColor3 = color
  card.BackgroundTransparency = 0.1
  card.Size = UDim2.new(1, 0, 0, 40)
  card.LayoutOrder = toast_count
  card.Parent = toast_stack
  Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
  local bar = Instance.new("Frame")
  bar.BackgroundColor3 = accent;
  bar.BorderSizePixel = 0
  bar.Size = UDim2.new(0, 3, 1, 0);
  bar.Parent = card
  Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 6)
  local label = Instance.new("TextLabel")
  label.BackgroundTransparency = 1
  label.Position = UDim2.new(0, 12, 0, 0)
  label.Size = UDim2.new(1, -18, 1, 0)
  label.Font = Enum.Font.GothamMedium
  label.TextColor3 = Color3.fromRGB(230, 235, 245)
  label.TextSize = 14
  label.TextXAlignment = Enum.TextXAlignment.Left
  label.TextWrapped = true
  label.Text = tostring(msg)
  label.Parent = card
  task.delay(3, function()
    if not card.Parent then
      return
    end
    for i = 10, 0, -1 do
      card.BackgroundTransparency = 1 - i / 10 * 0.9
      label.TextTransparency = 1 - i / 10
      task.wait(0.02)
    end
    if card then
      card:Destroy()
    end
  end
  )
end
init_toasts() -- ============ NO FOG ============
local _fog_saved = nil
function apply_no_fog(on)
  no_fog_on = on
  if on then
    if not _fog_saved then
      _fog_saved = {FogEnd = Lighting.FogEnd, FogStart = Lighting.FogStart, ClockTime = Lighting.ClockTime, Brightness = Lighting.Brightness, GlobalShadows = Lighting.GlobalShadows,}
    end
    Lighting.FogEnd = CFG.fog_end
    Lighting.FogStart = CFG.fog_start
    Lighting.ClockTime = CFG.clock_time
    Lighting.Brightness = CFG.brightness
    Lighting.GlobalShadows = false
    toast("No fog: ON", "ok")
  else
    if _fog_saved then
      Lighting.FogEnd = _fog_saved.FogEnd
      Lighting.FogStart = _fog_saved.FogStart
      Lighting.ClockTime = _fog_saved.ClockTime
      Lighting.Brightness = _fog_saved.Brightness
      Lighting.GlobalShadows = _fog_saved.GlobalShadows
      _fog_saved = nil
    end
    toast("No fog: OFF", "warn")
  end
end
-- ============ PELI + RIFLE ============
local function get_peli()
  local folder = RS:FindFirstChild("Stats" .. LP.Name)
  local stats = folder and folder:FindFirstChild("Stats")
  local peli = stats and stats:FindFirstChild("Peli")
  if peli and peli:IsA("ValueBase") then
    return peli.Value
  end
  return 0
end
local function has_rifle()
  local bp = LP:FindFirstChild("Backpack")
  if bp and bp:FindFirstChild(RIFLE_NAME) then
    return true
  end
  if LP.Character and LP.Character:FindFirstChild(RIFLE_NAME .. "Back") then
    return true
  end
  return false
end
-- ============ CHEST ============
local function chest_visible_at(pos)
  local r = getRoot();
  if not r then
    return false
  end
  local origin = r.Position
  local dir = (pos - origin)
  local dist = dir.Magnitude
  if dist < 1 then
    return true
  end
  local hit = ray(origin, dir.Unit * dist)
  if not hit then
    return false
  end
  return (hit.Position - pos).Magnitude <= CFG.chest_seen_eps
end
local function any_chest_visible()
  for i, c in ipairs(CHESTS) do
    if not failed_chests[i] and chest_visible_at(c) then
      return c, i
    end
  end
  return nil
end
-- ============ OBSTACLES / MOVER ============
local function probe_obstacle(here, dir)
  local hit = ray(here, dir * CFG.ray_fwd)
  if not hit or not hit.Instance or not hit.Instance.CanCollide then
    return nil
  end
  local past = hit.Position + dir * 0.4
  local down = ray(past + Vector3.new(0, CFG.ray_up, 0), Vector3.new(0, - (CFG.ray_up * 2), 0))
  if not down or not down.Instance or not down.Instance.CanCollide then
    return nil
  end
  local top_y = down.Position.Y
  local height = top_y - here.Y
  if height < CFG.debris_height then
    local lxz = Vector3.new(hit.Position.X, 0, hit.Position.Z) + dir * CFG.hop_fwd
    return "debris", Vector3.new(lxz.X, top_y + CFG.hop_margin, lxz.Z)
  elseif height < CFG.min_wall then
    local lxz = Vector3.new(hit.Position.X, 0, hit.Position.Z) + dir * CFG.hop_fwd
    return "short", Vector3.new(lxz.X, top_y + CFG.hop_margin, lxz.Z)
  else
    local lxz = Vector3.new(hit.Position.X, 0, hit.Position.Z) + dir * CFG.land_ahead
    return "tall", Vector3.new(lxz.X, top_y + CFG.clearance, lxz.Z)
  end
end
local function step_walk(dt)
  if not target then
    mode = "idle";
    return
  end
  local here = root.Position
  local delta = target - here
  local dist = delta.Magnitude
  local dir = Vector3.new(delta.X, 0, delta.Z)
  if dir.Magnitude > 0.01 then
    dir = dir.Unit
  else
    dir = Vector3.new(0, 0, -1)
  end
  if dist <= 0.5 then
    mode = "idle";
    target = nil;
    return
  end
  local kind, landing = probe_obstacle(here, dir)
  if kind and (tick() - last_hop) > 0.05 then
    last_hop = tick()
    write_cframe(CFrame.new(landing, landing + dir))
    return
  end
  local move = math.min(cur_spd * dt, dist)
  local np = here + dir * move
  local g = ray(np + Vector3.new(0, CFG.clearance, 0), Vector3.new(0, -CFG.ray_up, 0))
  if g and np.Y > g.Position.Y + CFG.clearance then
    np = Vector3.new(np.X, g.Position.Y + CFG.clearance, np.Z)
  end
  np = apply_water_walk(np)
  write_cframe(CFrame.new(np, np + dir))
end
-- ============ FLIGHT ============
local function read_input()
  local cam = workspace.CurrentCamera;
  if not cam then
    return Vector3.zero, 0
  end
  local look = cam.CFrame.LookVector
  local right = cam.CFrame.RightVector
  look = Vector3.new(look.X, 0, look.Z)
  right = Vector3.new(right.X, 0, right.Z)
  if look.Magnitude > 0 then
    look = look.Unit
  end
  if right.Magnitude > 0 then
    right = right.Unit
  end
  local h = Vector3.zero
  if UIS:IsKeyDown(Enum.KeyCode.W) then
    h = h + look
  end
  if UIS:IsKeyDown(Enum.KeyCode.S) then
    h = h - look
  end
  if UIS:IsKeyDown(Enum.KeyCode.D) then
    h = h + right
  end
  if UIS:IsKeyDown(Enum.KeyCode.A) then
    h = h - right
  end
  if h.Magnitude > 1 then
    h = h.Unit
  end
  local v = 0
  if UIS:IsKeyDown(Enum.KeyCode.Space) then
    v = v + 1
  end
  if UIS:IsKeyDown(Enum.KeyCode.LeftControl) or UIS:IsKeyDown(Enum.KeyCode.RightControl) then
    v = v - 1
  end
  return h, v
end
local function step_fly(dt)
  if tick() - fly_start > CFG.fly_max_time then
    mode = "idle";
    return
  end
  local here = root.Position
  local horiz, vinput = read_input()
  fly_dir = fly_dir:Lerp(horiz, CFG.fly_smooth)
  if fly_dir.Magnitude < 0.02 then
    fly_dir = Vector3.zero
  end
  local np = here
  if fly_dir.Magnitude > 0 then
    np = np + fly_dir * (CFG.fly_speed * dt)
  end
  if vinput ~= 0 then
    np = np + Vector3.new(0, vinput * CFG.fly_vspeed * dt, 0)
  end
  if (np - here).Magnitude < 0.001 then
    return
  end
  local face = fly_dir.Magnitude > 0.05 and fly_dir or root.CFrame.LookVector
  face = Vector3.new(face.X, 0, face.Z)
  if face.Magnitude > 0 then
    face = face.Unit
  else
    face = Vector3.new(0, 0, -1)
  end
  write_cframe(CFrame.new(np, np + face))
  if fly_dir.Magnitude > 0.05 or vinput ~= 0 then
    fly_stam_acc = fly_stam_acc + dt
    if fly_stam_acc >= CFG.fly_stam_rate then
      fly_stam_acc = 0;
      tick_stam(CFG.fly_stam_drain)
    end
  end
end
-- ============ TP ============
tp = {}
local function resolve_pos(p)
  if typeof(p) == "Vector3" then
    return p
  end
  return Vector3.new(p[1] or p.x or 0, p[2] or p.y or 0, p[3] or p.z or 0)
end
function tp.to(dest)
  dest = resolve_pos(dest)
  local hum, r = getHum(), getRoot()
  if not hum or not r then
    return
  end
  local landing = dest + Vector3.new(0, CFG.tp_offset_y, 0)
  toast("TP -> " .. math.floor(dest.X) .. "," .. math.floor(dest.Z), "ok")
  r.CFrame = CFrame.new(landing)
  r.Velocity = Vector3.zero
  r.AssemblyLinearVelocity = Vector3.zero
  task.wait(CFG.tp_beat_ms / 1000)
  hum.Health = 0
end
function tp.direct(dest)
  dest = resolve_pos(dest)
  local r = getRoot()
  if not r then
    return false
  end
  r.CFrame = CFrame.new(dest)
  r.Velocity = Vector3.zero
  r.AssemblyLinearVelocity = Vector3.zero
  return true
end
-- ============ ORB VERIFICATION ============
local function orb_fired()
  local r = getRoot()
  if not r then
    return false
  end
  return (r.Position - ORB_DEST).Magnitude <= ORB_VERIFY_RADIUS
end
local function nudge_orb(landing_pos)
  local r = getRoot();
  if not r then
    return false
  end
  r.CFrame = CFrame.new(landing_pos + Vector3.new(0, 8, 0))
  r.Velocity = Vector3.new(0, -30, 0)
  r.AssemblyLinearVelocity = Vector3.new(0, -30, 0)
  task.wait(0.15)
  r.CFrame = CFrame.new(landing_pos)
  r.Velocity = Vector3.zero
  r.AssemblyLinearVelocity = Vector3.zero
  task.wait(ORB_RETRY_WAIT)
  return orb_fired()
end
local function retp_to_orb(landing_pos)
  local r = getRoot();
  if not r then
    return false
  end
  r.CFrame = CFrame.new(landing_pos)
  r.Velocity = Vector3.zero
  r.AssemblyLinearVelocity = Vector3.zero
  task.wait(ORB_RETRY_WAIT)
  return orb_fired()
end
local function confirm_orb_fired(landing_pos)
  if orb_fired() then
    return true
  end
  for attempt = 1, ORB_MAX_TRIES do
    toast("Orb retry " .. attempt .. "/" .. ORB_MAX_TRIES, "warn")
    if nudge_orb(landing_pos) then
      return true
    end
    if retp_to_orb(landing_pos) then
      return true
    end
    task.wait(0.4)
  end
  return false
end
-- ============================================================
-- [F1] TRAVEL_TO — race-free arrival watcher
-- ============================================================
local function travel_to(pos, on_arrive)
  target = pos
  mode = "walk"
  task.spawn(function()
    while farm_on do
      local r = getRoot()
      if r then
        local d = (r.Position - pos).Magnitude
        if d <= CFG.travel_arrive_eps then
          mode = "idle";
          target = nil
          if on_arrive then
            on_arrive()
          end
          return
        end
      end
      if mode ~= "walk" then
        mode = "walk";
        target = pos
      end
      task.wait(0.08)
    end
  end
  )
end
-- ============ AUTOFARM HELPERS ============
autofarm = {}
local function key_hold(key, seconds)
  local hk = game:GetService("VirtualInputManager") hk:SendKeyEvent(true, key, false, game)
  task.wait(seconds) hk:SendKeyEvent(false, key, false, game)
end
local function press_e()
  key_hold(Enum.KeyCode.E, CFG.farm_e_hold)
end
local function press_t()
  key_hold(Enum.KeyCode.T, CFG.farm_t_hold)
end
local function buy_rifle()
  local buyable = workspace:FindFirstChild("BuyableItems")
  if not buyable then
    return false
  end
  local rifle = buyable:FindFirstChild(RIFLE_NAME)
  if not rifle then
    return false
  end
  local shop = Events and Events:FindFirstChild("Shop")
  if not shop then
    return false
  end
  return pcall(function()
    shop:InvokeServer(rifle, 1)
  end
  )
end
local function set_spawn()
  if not setspawn then
    setspawn = Events and Events:FindFirstChild("SetSpawn")
  end
  if not setspawn then
    toast("SetSpawn missing", "err");
    return false
  end
  local ok, err = pcall(function()
    setspawn:FireServer()
  end
  )
  print("[farm] SetSpawn fired:", ok, err)
  return ok
end
local function claim_chest(idx)
  local peli_before = get_peli()
  for attempt = 1, CFG.chest_claim_tries do
    if not farm_on then
      return false
    end
    toast("Claiming chest " .. idx .. " (try " .. attempt .. ")", "farm")
    press_e()
    task.wait(CFG.farm_chest_pause)
    local peli_after = get_peli()
    if peli_after > peli_before then
      toast("Chest " .. idx .. " claimed (+" .. (peli_after - peli_before) .. ")", "ok")
      return true
    end
  end
  return false
end
-- ============================================================
function autofarm.start()
  farm_on = true
  farm_idx = 1
  failed_chests = {}
  farm_rifle_owned = has_rifle()
  farm_stage = "check"
  toast("Farm started | rifle: " .. tostring(farm_rifle_owned) .. " | peli: " .. get_peli(), "farm") -- ========================================================
  -- [F3] EQUIP WATCHER
  -- ========================================================
  task.spawn(function()
    while farm_on do
      task.wait(CFG.equip_watch_rate)
      if farm_rifle_owned then
        local char = LP.Character
        if char and not char:FindFirstChild(RIFLE_NAME) then
          local tools_ev = Events and Events:FindFirstChild("Tools")
          if tools_ev then
            pcall(function()
              tools_ev:InvokeServer("equip", RIFLE_NAME)
            end
            )
          end
        end
      end
    end
  end
  ) -- ============================================================
  -- FARM STATE MACHINE
  -- ============================================================
  task.spawn(function()
    while farm_on do
      if farm_stage == "check" then
        root = root or getRoot()
        if dev_chest_only then
          farm_stage = "pick_chest"
        elseif farm_rifle_owned then
          toast("Rifle owned, going to dive point", "ok")
          farm_stage = "post_rifle"
        elseif get_peli() >= RIFLE_COST then
          toast("Peli >= " .. RIFLE_COST .. ", going to rifle", "farm")
          farm_stage = "travel_rifle"
        else
          toast("Farming chests", "farm")
          farm_stage = "pick_chest"
        end
      elseif farm_stage == "pick_chest" then
        local remaining = {}
        for i = 1, #CHESTS do
          if not failed_chests[i] then
            table.insert(remaining, i)
          end
        end
        if #remaining == 0 then
          toast("All chests failed. Stopping.", "warn")
          farm_stage = "done"
        else
          local seen, idx = any_chest_visible()
          if seen then
            farm_idx = idx
            toast("Chest " .. idx .. " in sight", "farm")
          else
            farm_idx = remaining[1]
            toast("Going to chest " .. farm_idx, "farm")
          end
          farm_stage = "travel_chest"
        end
      elseif farm_stage == "travel_chest" then
        if farm_idx > #CHESTS then
          farm_idx = 1
        end
        travel_to(CHESTS[farm_idx], function()
          if farm_on then
            farm_stage = "at_chest"
          end
        end
        )
        while farm_on and farm_stage == "travel_chest" do
          task.wait(0.2)
        end
      elseif farm_stage == "at_chest" then
        local r = getRoot()
        if not r then
          farm_stage = "pick_chest"
        else
          local d = (r.Position - CHESTS[farm_idx]).Magnitude
          if d > CFG.chest_claim_eps then
            toast("Too far from chest " .. farm_idx, "warn")
            failed_chests[farm_idx] = true
            task.wait(0.3);
            farm_stage = "pick_chest"
          else
            local ok = claim_chest(farm_idx)
            if not ok then
              failed_chests[farm_idx] = true
              toast("Chest " .. farm_idx .. " failed", "warn")
            end
            if dev_chest_only then
              task.wait(0.3);
              farm_stage = "pick_chest"
            elseif ok and get_peli() >= RIFLE_COST then
              farm_stage = "travel_rifle"
            else
              task.wait(0.3);
              farm_stage = "pick_chest"
            end
          end
        end
      elseif farm_stage == "travel_rifle" then
        toast("Going to rifle", "farm")
        travel_to(RIFLE_POSE, function()
          if farm_on then
            farm_stage = "prompt_e"
          end
        end
        )
        while farm_on and farm_stage == "travel_rifle" do
          task.wait(0.2)
        end
      elseif farm_stage == "prompt_e" then
        task.wait(0.3)
        toast("Opening rifle dialog", "farm")
        press_e()
        task.wait(0.6)
        farm_stage = "confirm_yes" -- ========================================================
        -- [F2] RIFLE BUY — polling ownership loop
        -- ========================================================
      elseif farm_stage == "confirm_yes" then
        toast("Buying rifle", "farm")
        buy_rifle()
        local t0 = tick()
        local deadline = t0 + CFG.rifle_poll_secs
        farm_rifle_owned = false
        while tick() < deadline and farm_on do
          task.wait(CFG.rifle_poll_rate)
          if has_rifle() then
            farm_rifle_owned = true;
            break
          end
        end
        if farm_rifle_owned then
          toast(string.format("Rifle bought (%.1fs)", tick() - t0), "ok")
          farm_stage = "post_rifle"
        else
          toast("Ownership not confirmed after " .. CFG.rifle_poll_secs .. "s — re-checking", "warn")
          farm_stage = "check"
        end
      elseif farm_stage == "post_rifle" then
        toast("Heading to dive point", "farm")
        travel_to(POST_RIFLE_WALK, function()
          if farm_on then
            farm_stage = "tp_deep"
          end
        end
        )
        while farm_on and farm_stage == "post_rifle" do
          task.wait(0.2)
        end
      elseif farm_stage == "tp_deep" then
        toast("Direct tp to orb", "farm")
        task.wait(0.4)
        tp.direct(POST_RIFLE_TP)
        task.wait(ORB_RETRY_WAIT)
        farm_stage = "verify_orb"
      elseif farm_stage == "verify_orb" then
        if orb_fired() then
          toast("Orb tp confirmed, waiting " .. ORB_POST_TP_WAIT .. "s", "ok")
          task.wait(ORB_POST_TP_WAIT)
          farm_stage = "travel_spawnset"
        else
          toast("Orb did not fire, retrying", "warn")
          if confirm_orb_fired(POST_RIFLE_TP) then
            toast("Orb tp confirmed (retry), waiting " .. ORB_POST_TP_WAIT .. "s", "ok")
            task.wait(ORB_POST_TP_WAIT)
            farm_stage = "travel_spawnset"
          else
            toast("Orb failed after " .. ORB_MAX_TRIES .. " retries. Stopping.", "err")
            farm_on = false
            break
          end
        end
      elseif farm_stage == "travel_spawnset" then
        toast("Traveling to spawn-set point", "farm")
        travel_to(SPAWN_SET_POS, function()
          if farm_on then
            farm_stage = "press_t"
          end
        end
        )
        while farm_on and farm_stage == "travel_spawnset" do
          task.wait(0.2)
        end
      elseif farm_stage == "press_t" then
        task.wait(0.3)
        toast("Pressing T to interact", "farm")
        press_t()
        task.wait(0.6)
        farm_stage = "fire_setspawn"
      elseif farm_stage == "fire_setspawn" then
        toast("Firing SetSpawn", "farm")
        set_spawn()
        task.wait(0.6)
        farm_stage = "travel_after_spawn"
      elseif farm_stage == "travel_after_spawn" then
        toast("Traveling to hold point", "farm")
        travel_to(AFTER_SPAWN_POS, function()
          if farm_on then
            farm_stage = "final"
          end
        end
        )
        while farm_on and farm_stage == "travel_after_spawn" do
          task.wait(0.2)
        end
      elseif farm_stage == "final" then
        toast("Standing still at hold point", "ok")
        mode = "idle";
        target = nil
        farm_on = false
        break
      elseif farm_stage == "done" then
        toast("Farm finished", "ok")
        farm_on = false
        break
      end
      task.wait(0.1)
    end
  end
  )
end
function autofarm.stop()
  farm_on = false
  farm_stage = "idle"
  target = nil
  mode = "idle"
  toast("Farm stopped", "warn")
end
-- ============ MAIN LOOP ============
local fs_acc, st_acc = 0, 0
RunService.Heartbeat:Connect(function(dt)
  if mode == "idle" then
    check_correction();
    return
  end
  if tick() < cool_until then
    check_correction();
    return
  end
  root = root or getRoot()
  if not root then
    mode = "idle";
    return
  end
  refresh_filter()
  check_correction()
  if mode == "walk" then
    jit_acc = jit_acc + dt
    if jit_acc >= CFG.jitter_rate then
      jit_acc = 0
      cur_spd = CFG.min_speed + math.random() * (CFG.max_speed - CFG.min_speed)
    end
    step_walk(dt)
    fs_acc = fs_acc + dt
    if fs_acc >= CFG.step_rate then
      fs_acc = 0;
      tick_footstep()
    end
    st_acc = st_acc + dt
    if st_acc >= CFG.stam_rate then
      st_acc = 0;
      tick_stam(CFG.stam_drain)
    end
  elseif mode == "fly" then
    step_fly(dt)
    fs_acc = fs_acc + dt
    if fs_acc >= CFG.step_rate then
      fs_acc = 0;
      tick_footstep()
    end
  end
end
) -- ============ UI ============
local Window = Rayfield:CreateWindow({Name = "Nav", LoadingTitle = "Nav", LoadingSubtitle = "by Lunar", ConfigurationSaving = {Enabled = false}, KeySystem = false,}) -- Movement tab
local TabMovement = Window:CreateTab("Movement", nil) TabMovement:CreateSection("Travel")
local travel_selected = nil
local names = {}
for k in pairs(DESTINATIONS) do
  table.insert(names, k)
end
table.sort(names) TabMovement:CreateDropdown({Name = "Destination", Options = names, CurrentOption = {}, Flag = "travel_dest", Callback = function(opt)
  local n = typeof(opt) == "table" and opt[1] or opt
  travel_selected = DESTINATIONS[n]
end
,}) TabMovement:CreateButton({Name = "Start", Callback = function()
  if not travel_selected then
    return
  end
  root = getRoot();
  if not root then
    return
  end
  trip_cnt, cool_until, intended, last_hop = 0, 0, nil, 0
  target = travel_selected;
  mode = "walk"
end
}) TabMovement:CreateButton({Name = "Stop", Callback = function()
  mode = "idle";
  target = nil
  if root then
    root.Velocity = Vector3.zero
    root.AssemblyLinearVelocity = Vector3.zero
  end
end
}) TabMovement:CreateSection("Fly") TabMovement:CreateToggle({Name = "Fly", CurrentValue = false, Flag = "fly_toggle", Callback = function(state)
  if state then
    root = getRoot();
    if not root then
      return
    end
    fly_dir = Vector3.zero;
    fly_start = tick();
    fly_stam_acc = 0;
    mode = "fly"
  else
    mode = "idle"
  end
end
,}) TabMovement:CreateSlider({Name = "Fly Speed", Range = {15, 120}, Increment = 5, Suffix = "studs/s", CurrentValue = CFG.fly_speed, Flag = "fly_speed", Callback = function(v)
  CFG.fly_speed = v
end
,}) TabMovement:CreateSection("TP")
local tp_selected = nil
local tp_names = {}
for k in pairs(DESTINATIONS) do
  table.insert(tp_names, k)
end
table.sort(tp_names) TabMovement:CreateDropdown({Name = "TP Destination", Options = tp_names, CurrentOption = {}, Flag = "tp_dest", Callback = function(opt)
  local n = typeof(opt) == "table" and opt[1] or opt
  tp_selected = DESTINATIONS[n]
end
,}) TabMovement:CreateButton({Name = "TP", Callback = function()
  if not tp_selected then
    return
  end
  mode = "idle";
  tp.to(tp_selected)
end
}) -- Misc tab
local TabMisc = Window:CreateTab("Misc", nil) TabMisc:CreateSection("Water Walk") TabMisc:CreateToggle({Name = "Walk on Water", CurrentValue = true, Flag = "water_toggle", Callback = function(state)
  CFG.water_walk = state
  toast("Water walk: " .. tostring(state), state and "ok" or "warn")
end
,}) TabMisc:CreateSlider({Name = "Water Height Offset", Range = {1, 8}, Increment = 1, Suffix = "studs", CurrentValue = CFG.water_offset, Flag = "water_offset", Callback = function(v)
  CFG.water_offset = v
end
,}) TabMisc:CreateSection("Lighting") TabMisc:CreateToggle({Name = "No Fog / Bright", CurrentValue = false, Flag = "nofog_toggle", Callback = function(state)
  apply_no_fog(state)
end
,}) TabMisc:CreateButton({Name = "Reset Lighting", Callback = function()
  if _fog_saved then
    apply_no_fog(false)
  else
    toast("Nothing to reset", "warn")
  end
end
,}) -- Dev tab
local TabDev = Window:CreateTab("Dev", nil) TabDev:CreateSection("Custom Coord Actions")
local dev_x, dev_y, dev_z = 0, 0, 0 TabDev:CreateInput({Name = "X", PlaceholderText = "x coordinate", CurrentValue = "0", RemoveTextAfterFocusLost = false, Callback = function(v)
  dev_x = tonumber(v) or 0
end
,}) TabDev:CreateInput({Name = "Y", PlaceholderText = "y coordinate", CurrentValue = "0", RemoveTextAfterFocusLost = false, Callback = function(v)
  dev_y = tonumber(v) or 0
end
,}) TabDev:CreateInput({Name = "Z", PlaceholderText = "z coordinate", CurrentValue = "0", RemoveTextAfterFocusLost = false, Callback = function(v)
  dev_z = tonumber(v) or 0
end
,}) TabDev:CreateButton({Name = "Walk to Coords", Callback = function()
  local dest = Vector3.new(dev_x, dev_y, dev_z)
  root = getRoot();
  if not root then
    toast("No character", "err");
    return
  end
  trip_cnt, cool_until, intended, last_hop = 0, 0, nil, 0
  target = dest;
  mode = "walk"
  toast("Walking to " .. math.floor(dev_x) .. "," .. math.floor(dev_y) .. "," .. math.floor(dev_z), "farm")
end
,}) TabDev:CreateButton({Name = "TP to Coords (reset)", Callback = function()
  local dest = Vector3.new(dev_x, dev_y, dev_z)
  mode = "idle";
  tp.to(dest)
end
,}) TabDev:CreateButton({Name = "TP to Coords (direct)", Callback = function()
  local dest = Vector3.new(dev_x, dev_y, dev_z)
  mode = "idle";
  tp.direct(dest)
  toast("Direct tp sent", "ok")
end
,}) TabDev:CreateButton({Name = "Print Current Pos", Callback = function()
  local r = getRoot();
  if not r then
    return
  end
  local p = r.Position
  print(string.format("[dev] pos: Vector3.new(%.4f, %.4f, %.4f)", p.X, p.Y, p.Z))
  toast(string.format("pos %.1f, %.1f, %.1f", p.X, p.Y, p.Z), "farm")
end
,}) TabDev:CreateSection("Orb Testing") TabDev:CreateButton({Name = "Test Orb Fire", Callback = function()
  if not farm_on then
    autofarm.start()
  end
  toast("Testing orb, going to dive point", "farm")
  farm_stage = "post_rifle"
end
,}) TabDev:CreateButton({Name = "Check Orb Distance", Callback = function()
  local r = getRoot();
  if not r then
    return
  end
  local d = (r.Position - ORB_DEST).Magnitude
  toast("dist to ORB_DEST: " .. math.floor(d), d <= ORB_VERIFY_RADIUS and "ok" or "warn")
  print("[dev] pos:", r.Position, "ORB_DEST:", ORB_DEST, "dist:", d)
end
,}) TabDev:CreateSection("Chest Testing") TabDev:CreateToggle({Name = "Auto Collect Chests (dev, no buy)", CurrentValue = false, Flag = "dev_chest", Callback = function(state)
  dev_chest_only = state
  if state then
    autofarm.start()
  else
    autofarm.stop()
  end
end
,}) TabDev:CreateButton({Name = "Debug Water", Callback = function()
  local r = getRoot();
  if not r then
    return
  end
  local o = ocean()
  if not o then
    toast("ocean NOT found", "err");
    return
  end
  local top = o.Position.Y + (o.Size.Y / 2)
  local wy = water_surface_y_at(r.Position.X, r.Position.Z)
  print("[dev] ocean top:", top, "| wy:", wy, "| root Y:", r.Position.Y)
end
,}) TabDev:CreateButton({Name = "Refresh Water Cache", Callback = function()
  _ocean = nil;
  ocean();
  toast("Water cache refreshed", "ok")
end
}) TabDev:CreateButton({Name = "Reset Failed Chests", Callback = function()
  failed_chests = {};
  toast("Failed cleared", "ok")
end
}) TabDev:CreateButton({Name = "Test Toast", Callback = function()
  toast("Toast test", "ok")
end
}) TabDev:CreateButton({Name = "Print Chest Distances", Callback = function()
  local r = getRoot();
  if not r then
    return
  end
  for i, c in ipairs(CHESTS) do
    local d = (r.Position - c).Magnitude
    local vis = chest_visible_at(c)
    local fail = failed_chests[i] and "FAILED" or ""
    print(string.format("[dev] chest %d dist=%.1f visible=%s %s", i, d, tostring(vis), fail))
  end
end
,}) -- Farm tab
local TabFarm = Window:CreateTab("Autofarm", nil) TabFarm:CreateSection("Kaitun Lvl Farm") TabFarm:CreateToggle({Name = "Farm Lvl (chests -> rifle)", CurrentValue = false, Flag = "farm_toggle", Callback = function(state)
  if state then
    autofarm.start()
  else
    autofarm.stop()
  end
end
,}) TabFarm:CreateLabel("Peli target: " .. RIFLE_COST) TabFarm:CreateLabel("Chests: " .. #CHESTS) TabFarm:CreateLabel("Orb dest: " .. ORB_DEST.X .. "," .. ORB_DEST.Z)
toast("Nav loaded", "ok")
print("[nav] loaded")
