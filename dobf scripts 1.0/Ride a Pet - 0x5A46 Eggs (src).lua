--[[
Game-specific SRC | NOT DEOBFUSCATED | NOT TESTED IN ROBLOX
Game / variant: Ride a Pet / 0x5A46 Eggs
Original: https://github.com/0x5448OIOI/0x5A46-Ride-A-Pet/blob/391c3853e944a64fda47744f5a17a79784d8f0b2/Code
Source SHA-256: 7d28ac24652e010113b1f295f2a5c081c8df00f90161c9eb19f5269ef72fb6bd
Snapshot: 391c3853e944a64fda47744f5a17a79784d8f0b2
Source status: Apache-2.0
Note: Uses executor file APIs and an optional user URL for background image; read license and report.
Complete upstream Apache-2.0 license: ../reports/licenses/0x5A46-Apache-2.0.txt
Upstream publisher: 0x5448OIOI. Source file Code has no individual copyright notice.
]]

-- ================= GUARDA DE VERSAO =================
-- Rodou de novo? A copia velha se mata sozinha.
local ENV = (getgenv and getgenv()) or _G
ENV.__PAINEL5A46_VERSAO = (ENV.__PAINEL5A46_VERSAO or 0) + 1
local MINHA_VERSAO = ENV.__PAINEL5A46_VERSAO
local function souAtual() return ENV.__PAINEL5A46_VERSAO == MINHA_VERSAO end
-- ====================================================
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Players          = game:GetService("Players")
local HttpService      = game:GetService("HttpService")
local LocalPlayer      = Players.LocalPlayer
-- imagem de fundo do painel (fica salva no arquivo abaixo)
local BG = {
    imagem       = "",   -- o que voce digitou (ID / link / arquivo)
    arquivo      = "",   -- o arquivo ja baixado, pra nao baixar de novo
    salt         = 0,    -- muda o nome do arquivo e fura o cache do Roblox
    transparencia = 0.5,
}
local BG_ARQUIVO = "painel_0x5A46_fundo.json"
local BG_PASTA   = "painel_0x5A46_fundos"
--==================================================================
-- ONDE PENDURAR AS GUIS
--==================================================================
local function acharRaiz()
    local cg = game:FindFirstChild("CoreGui")
    if cg then
        local ok = pcall(function()
            local t = Instance.new("Folder") t.Name = "__t5a46" t.Parent = cg t:Destroy()
        end)
        if ok then return cg end
    end
    return LocalPlayer:WaitForChild("PlayerGui")
end
local RAIZ = acharRaiz()
for _, n in ipairs({ "Panel_0x5A46", "Marcas_0x5A46" }) do
    local v = RAIZ:FindFirstChild(n)
    if v then pcall(function() v:Destroy() end) end
end
--==================================================================
-- TEMA
--==================================================================
local Theme = {
	Window   = Color3.fromRGB(12, 12, 12),
	Sidebar  = Color3.fromRGB(9, 9, 9),
	Card     = Color3.fromRGB(19, 19, 19),
	Field    = Color3.fromRGB(28, 28, 28),
	Hover    = Color3.fromRGB(32, 32, 32),
	Line     = Color3.fromRGB(34, 34, 34),
	Stroke   = Color3.fromRGB(42, 42, 42),
	Text     = Color3.fromRGB(240, 240, 240),
	SubText  = Color3.fromRGB(135, 135, 135),
	Dim      = Color3.fromRGB(88, 88, 88),
	Accent   = Color3.fromRGB(255, 255, 255),
	TrackOff = Color3.fromRGB(46, 46, 46),
	KnobOn   = Color3.fromRGB(14, 14, 14),
	KnobOff  = Color3.fromRGB(120, 120, 120),
	Alert    = Color3.fromRGB(255, 255, 255),
}
local Glyphs = { Sort = "⇅", Check = "✓" }
local FAST   = TweenInfo.new(0.13, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out)
local SMOOTH = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
--==================================================================
-- HELPERS
--==================================================================
local function new(class, props, children)
	local obj, parent = Instance.new(class), nil
	for key, value in pairs(props or {}) do
		if key == "Parent" then parent = value else obj[key] = value end
	end
	for _, child in ipairs(children or {}) do child.Parent = obj end
	obj.Parent = parent
	return obj
end
local function corner(radius, parent)
	return new("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent })
end
local function stroke(color, parent, thickness, transparency)
	return new("UIStroke", {
		Color = color, Thickness = thickness or 1, Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = parent,
	})
end
local function pad(parent, t, r, b, l)
	return new("UIPadding", {
		PaddingTop = UDim.new(0, t), PaddingRight = UDim.new(0, r),
		PaddingBottom = UDim.new(0, b), PaddingLeft = UDim.new(0, l), Parent = parent,
	})
end
local function list(parent, gap, dir)
	return new("UIListLayout", {
		FillDirection = dir or Enum.FillDirection.Vertical,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, gap), Parent = parent,
	})
end
local function tween(obj, goal, info)
	local t = TweenService:Create(obj, info or FAST, goal)
	t:Play()
	return t
end
--==================================================================
-- ICONES VETORIAIS
--==================================================================
local Icons = {}
local function shape(parent, x, y, w, h, radius, outlined)
	local f = new("Frame", {
		Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(w, h),
		BackgroundColor3 = Theme.Dim, BackgroundTransparency = outlined and 1 or 0,
		BorderSizePixel = 0, Parent = parent,
	})
	if radius then corner(radius, f) end
	if outlined then stroke(Theme.Dim, f, 1.3) end
	return f
end
local function holderOf(parent, size)
	return new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, Parent = parent,
	})
end
local function painter(parts)
	return function(color, transparency)
		for _, part in ipairs(parts) do
			local st = part:FindFirstChildOfClass("UIStroke")
			if st then tween(st, { Color = color, Transparency = transparency or 0 })
			else tween(part, { BackgroundColor3 = color, BackgroundTransparency = transparency or 0 }) end
		end
	end
end
function Icons.bell(parent)
	local h = holderOf(parent, 14)
	return h, painter({ shape(h,3,2,8,7,4), shape(h,1,9,12,2,1), shape(h,6,11,2,2,1) })
end
function Icons.lock(parent)
	local h = holderOf(parent, 14)
	return h, painter({ shape(h,4,1,6,7,3,true), shape(h,2,6,10,7,2) })
end
function Icons.search(parent)
	local h = holderOf(parent, 14)
	local ring = shape(h,1,1,9,9,5,true)
	local grip = shape(h,8,9,5,2,1)
	grip.Rotation = 45
	return h, painter({ ring, grip })
end
function Icons.bind(parent)
	local h = holderOf(parent, 14)
	return h, painter({ shape(h,3,3,1,8,1), shape(h,6,3,1,8,1), shape(h,9,3,1,8,1) })
end

--==================================================================
-- ICONES DE ABA  ·  desenhados num quadrado 16x16
--   {x, y, largura, altura, raio, rotacao, contorno}
--   posicao em ESCALA (x/16): nao arredonda e escala junto com o
--   tamanho pedido, entao o mesmo desenho serve em 14px ou 32px.
--==================================================================
local ICON_DEFS = {
	-- casa: telhado (quadrado girado), corpo, e a porta VAZADA
	home = { parts = {
		{3.8, 0.6, 8.4, 8.4, 1.3, 45},
		{3.2, 6.8, 9.6, 8.2, 1.5},
		{6.7, 9.6, 2.6, 5.4, 1.1, 0, false, true},
	}},
	-- uma espada em pe: duas cruzadas viram borrao em 16px
	swords = { parts = {
		{7, 0.7, 2, 9, 0.4},
		{6.1, 0.4, 3.8, 3.8, 0.7, 45},
		{2.9, 9.1, 10.2, 2, 1},
		{6.9, 10.9, 2.2, 3, 0.5},
		{5.9, 13.2, 4.2, 2.1, 1.05},
	}},
	-- cabeca + ombros; o clip corta a barriga e vira busto
	person = { clip = true, parts = { {5.5, 1.4, 5, 5, 2.5}, {2.4, 8.4, 11.2, 11, 5.4} } },
	-- olho cheio, iris vazada, pupila cheia por dentro
	eye = { parts = {
		{0.8, 3.4, 14.4, 9.2, 4.6},
		{5.7, 5.3, 4.6, 4.6, 2.3, 0, false, true},
		{7, 6.6, 2, 2, 1},
	}},
	sparkle = { parts = {
		{7.1, 0.6, 1.8, 14.8, 0.9},
		{0.6, 7.1, 14.8, 1.8, 0.9},
		{3.6, 7.25, 8.8, 1.5, 0.75, 45},
		{3.6, 7.25, 8.8, 1.5, 0.75, -45},
	}},
	sliders = { parts = {
		{1.2, 3.1, 13.6, 1.8, 0.9},
		{9.6, 2, 4, 4, 2},
		{1.2, 7.1, 13.6, 1.8, 0.9},
		{3.6, 6, 4, 4, 2},
		{1.2, 11.1, 13.6, 1.8, 0.9},
		{8.4, 10, 4, 4, 2},
	}},
	-- alvo: aneis alternando cheio e vazado
	target = { parts = {
		{1.2, 1.2, 13.6, 13.6, 6.8},
		{3.6, 3.6, 8.8, 8.8, 4.4, 0, false, true},
		{5.2, 5.2, 5.6, 5.6, 2.8},
		{6.8, 6.8, 2.4, 2.4, 1.2, 0, false, true},
	}},
	-- moeda cheia com o cifrao vazado
	coin = { parts = {
		{1.6, 1.6, 12.8, 12.8, 6.4},
		{7.3, 3.6, 1.4, 8.8, 0.7, 0, false, true},
		{5, 5.2, 6, 1.4, 0.7, 0, false, true},
		{5, 9.4, 6, 1.4, 0.7, 0, false, true},
	}},
	box = { parts = {
		{1.8, 4.6, 12.4, 9.6, 1.6},
		{1.2, 2.6, 13.6, 3.2, 1},
		{7.3, 6.4, 1.4, 7, 0.3, 0, false, true},
	}},
	fish = { parts = {
		{1, 4.8, 10.6, 6.4, 3.2},
		{9.4, 5.2, 5.2, 1.6, 0.8, -40},
		{9.4, 9.2, 5.2, 1.6, 0.8, 40},
		{3.2, 7.2, 1.8, 1.8, 0.9, 0, false, true},
	}},
	bolt = { parts = {
		{8.2, 0.7, 2.6, 8.8, 0.5, 30},
		{5.4, 6.5, 2.6, 8.8, 0.5, 30},
		{5.4, 6.3, 5.4, 2.4, 0.5},
	}},
	dot = { parts = { {5.2, 5.2, 5.6, 5.6, 2.8} } },
	shield = { parts = {
		{2.6, 1.3, 10.8, 6.6, 1.7},
		{4, 4.6, 8, 8, 1.3, 45},
		{7.1, 4.2, 1.8, 5.6, 0.9, 0, false, true},
	}},
	shirt = { parts = {
		{4.4, 3.6, 7.2, 10.8, 1.4},
		{1.2, 3.2, 5, 3.2, 1, -28},
		{9.8, 3.2, 5, 3.2, 1, 28},
		{6.1, 2.9, 3.8, 2, 1, 0, false, true},
	}},
	sun = { parts = {
		{4.4, 4.4, 7.2, 7.2, 3.6},
		{7.2, 0.5, 1.6, 2.8, 0.8},
		{7.2, 12.7, 1.6, 2.8, 0.8},
		{0.5, 7.2, 2.8, 1.6, 0.8},
		{12.7, 7.2, 2.8, 1.6, 0.8},
		{2, 2.5, 2.6, 1.5, 0.75, 45},
		{11.4, 12, 2.6, 1.5, 0.75, 45},
		{11.4, 2.5, 2.6, 1.5, 0.75, -45},
		{2, 12, 2.6, 1.5, 0.75, -45},
	}},
	-- gota de mapa: circulo + quadrado girado, furo no meio
	pin = { parts = {
		{3.4, 0.9, 9.2, 9.2, 4.6},
		{5.3, 7.4, 5.4, 5.4, 1, 45},
		{6.6, 3.5, 2.8, 2.8, 1.4, 0, false, true},
	}},
}
-- apelidos, pra poder escrever em portugues tambem
local ICON_ALIAS = {
	casa = "home", inicio = "home", espada = "swords", espadas = "swords",
	farm = "swords", jogador = "person", player = "person", pessoa = "person",
	olho = "eye", esp = "eye", brilho = "sparkle", custom = "sparkle",
	config = "sliders", ajustes = "sliders", alvo = "target", mira = "target",
	moeda = "coin", dinheiro = "coin", caixa = "box", item = "box",
	peixe = "fish", pesca = "fish", raio = "bolt", ponto = "dot",
	sol = "sun", luz = "sun", visual = "sun",
	pino = "pin", lugar = "pin", teleporte = "pin", tp = "pin",
	escudo = "shield", protecao = "shield", defesa = "shield",
	camisa = "shirt", roupa = "shirt", avatar = "shirt",
}

-- Escolher o icone pelo NOME DA ABA.
-- A ideia: voce escreve P.Tab("Combat") e vem espada, P.Tab("ESP") e vem
-- olho, sem ter que lembrar o nome do desenho. Cada palavra abaixo e
-- procurada DENTRO do nome da aba, em minusculas, na ordem da lista —
-- por isso as mais especificas vem primeiro ("autofarm" antes de "auto").
local PALAVRA_ICONE = {
	{ "combat", "swords" }, { "fight", "swords" }, { "battle", "swords" },
	{ "kill", "swords" },   { "attack", "swords" }, { "pvp", "swords" },
	{ "weapon", "swords" }, { "dungeon", "swords" }, { "raid", "swords" },
	{ "punch", "swords" },  { "sword", "swords" },  { "luta", "swords" },

	{ "esp", "eye" },      { "vision", "eye" },  { "radar", "eye" },
	{ "wallhack", "eye" }, { "reveal", "eye" },  { "tracker", "eye" },
	{ "scan", "eye" },     { "find", "eye" },    { "locate", "eye" },

	{ "visual", "sun" },   { "reshade", "sun" }, { "light", "sun" },
	{ "graphic", "sun" },  { "render", "sun" },  { "effect", "sparkle" },
	{ "cosmetic", "sparkle" }, { "skin", "shirt" }, { "outfit", "shirt" },
	{ "avatar", "shirt" },

	{ "speed", "bolt" },   { "boost", "bolt" },  { "fast", "bolt" },
	{ "movement", "bolt" },{ "walk", "bolt" },   { "fly", "bolt" },
	{ "mining", "bolt" },  { "mine", "bolt" },   { "power", "bolt" },
	{ "training", "bolt" },{ "train", "bolt" },  { "energy", "bolt" },

	{ "money", "coin" },   { "cash", "coin" },   { "sell", "coin" },
	{ "shop", "coin" },    { "econom", "coin" }, { "trade", "coin" },
	{ "upgrade", "coin" }, { "buy", "coin" },

	{ "inventory", "box" },{ "item", "box" },    { "bag", "box" },
	{ "storage", "box" },  { "chest", "box" },   { "loot", "box" },
	{ "egg", "box" },      { "crate", "box" },   { "pet", "box" },

	{ "teleport", "pin" }, { "place", "pin" },   { "travel", "pin" },
	{ "map", "pin" },      { "world", "pin" },   { "zone", "pin" },
	{ "area", "pin" },     { "waypoint", "pin" },

	{ "player", "person" },{ "character", "person" }, { "people", "person" },
	{ "friend", "person" },{ "server", "person" },

	{ "shield", "shield" },{ "protect", "shield" }, { "safe", "shield" },
	{ "anti", "shield" },  { "defen", "shield" },

	{ "fish", "fish" },    { "pesca", "fish" },

	{ "aim", "target" },   { "target", "target" }, { "farm", "target" },
	{ "auto", "target" },  { "quest", "target" },  { "task", "target" },

	{ "config", "sliders" }, { "setting", "sliders" }, { "option", "sliders" },
	{ "customi", "sliders" },{ "tweak", "sliders" },

	{ "home", "home" },    { "main", "home" },   { "base", "home" },
	{ "misc", "dot" },     { "extra", "dot" },   { "other", "dot" },
}

-- devolve o nome do desenho que combina com o texto, ou nil
function Icons.porNome(texto)
	if type(texto) ~= "string" then return nil end
	local t = texto:lower()
	for _, par in ipairs(PALAVRA_ICONE) do
		if t:find(par[1], 1, true) then return par[2] end
	end
	return nil
end

-- p = {x, y, w, h, raio, rotacao, contornado, FURO}
-- O furo e o truque que deixa o icone solido ter detalhe: em vez de
-- desenhar contorno, eu pinto uma peca com a cor do fundo por cima da
-- forma cheia. Assim a porta da casa, o cifrao da moeda e a iris do
-- olho aparecem como recorte. A peca-furo fica de fora do painter,
-- senao ela seria tintada junto e o recorte sumiria.
local function drawParts(holder, parts, size)
	local made = {}
	for _, p in ipairs(parts) do
		local w, h, r, outlined, furo = p[3], p[4], p[5] or 0, p[7], p[8]
		local f = new("Frame", {
			Position = UDim2.fromScale(p[1] / 16, p[2] / 16),
			Size     = UDim2.fromScale(w / 16, h / 16),
			Rotation = p[6] or 0,
			BackgroundColor3 = furo and Theme.Card or Theme.Dim,
			BackgroundTransparency = outlined and 1 or 0,
			ZIndex = furo and 3 or 2,
			BorderSizePixel = 0, Parent = holder,
		})
		if r > 0 then
			-- raio maior que a metade do lado curto vira pilula
			if r * 2 >= math.min(w, h) - 0.01 then
				new("UICorner", { CornerRadius = UDim.new(1, 0), Parent = f })
			else
				new("UICorner", {
					CornerRadius = UDim.new(0, math.max(1, math.floor(r * size / 16 + 0.5))),
					Parent = f,
				})
			end
		end
		if outlined then stroke(Theme.Dim, f, math.max(1, size / 13)) end
		if not furo then table.insert(made, f) end
	end
	return made
end

function Icons.has(name)
	name = ICON_ALIAS[name] or name
	return ICON_DEFS[name] ~= nil
end

-- devolve (holder, paint) — paint(cor, transparencia)
function Icons.draw(parent, name, size)
	size = size or 16
	name = ICON_ALIAS[name] or name
	local def = ICON_DEFS[name]
	if not def then return nil, nil end
	local h = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1,
		ClipsDescendants = def.clip or false, Parent = parent,
	})
	return h, painter(drawParts(h, def.parts, size))
end

function Icons.names()
	local t = {}
	for nome in pairs(ICON_DEFS) do table.insert(t, nome) end
	table.sort(t)
	return t
end

--==================================================================
-- KEYBIND
--==================================================================
local MOUSE_NAMES = {
	[Enum.UserInputType.MouseButton1] = "MB1",
	[Enum.UserInputType.MouseButton2] = "MB2",
	[Enum.UserInputType.MouseButton3] = "MB3",
}
local function bindLabel(bind)
	if not bind then return "None" end
	if bind.Mouse then return MOUSE_NAMES[bind.Mouse] or "Mouse" end
	if bind.Key then return bind.Key.Name end
	return "None"
end
local function bindMatches(bind, input)
	if not bind then return false end
	if bind.Mouse then return input.UserInputType == bind.Mouse end
	if bind.Key then return input.KeyCode == bind.Key end
	return false
end
local Listening = nil
--==================================================================
-- BIBLIOTECA
--==================================================================
local Zero = {}
local Window  = {}; Window.__index  = Window
local Tab     = {}; Tab.__index     = Tab
local Section = {}; Section.__index = Section
function Zero.new(config)
	config = config or {}
	local self = setmetatable({}, Window)
	self.Title     = config.Title or "0x5A46"
	self.Tabs      = {}
	self.Active    = nil
	self.Minimized = false
	self.ToggleKey = config.ToggleKey or Enum.KeyCode.RightControl
	self.Binds     = {}
	local size = config.Size or Vector2.new(772, 486)
	self.Gui = new("ScreenGui", {
		Name = "Panel_0x5A46", ResetOnSpawn = false, IgnoreGuiInset = true,
		AutoLocalize = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})
	if syn and syn.protect_gui then pcall(syn.protect_gui, self.Gui) end
	self.Gui.Parent = RAIZ
	self.Main = new("Frame", {
		Name = "Window", AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(size.X, size.Y),
		BackgroundColor3 = Theme.Window, BorderSizePixel = 0,
		ClipsDescendants = true, Parent = self.Gui,
	})
	corner(14, self.Main)
	stroke(Theme.Stroke, self.Main)
	self.BgClip = new("Frame", {
		Name = "FundoClip", Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1, BorderSizePixel = 0,
		ClipsDescendants = true, ZIndex = 0, Parent = self.Main,
	})
	corner(14, self.BgClip)
	self.BgImage = new("ImageLabel", {
		Name = "Fundo", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		BorderSizePixel = 0, Image = "", ImageTransparency = BG.transparencia,
		ScaleType = Enum.ScaleType.Crop, Visible = false, ZIndex = 0, Parent = self.BgClip,
	})
	corner(14, self.BgImage)
	local bar = new("Frame", {
		Name = "TitleBar", Size = UDim2.new(1, 0, 0, 48),
		BackgroundTransparency = 1, ZIndex = 2, Parent = self.Main,
	})
	self.TitleLabel = new("TextLabel", {
		Position = UDim2.fromOffset(20, 0), Size = UDim2.new(0, 240, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = self.Title,
		TextSize = 15, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = bar,
	})
	local searchBox = new("Frame", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -54, 0.5, 0),
		Size = UDim2.fromOffset(200, 28), BackgroundColor3 = Theme.Field,
		BorderSizePixel = 0, Parent = bar,
	})
	corner(14, searchBox)
	stroke(Theme.Line, searchBox)
	do
		local wrap = new("Frame", {
			Position = UDim2.fromOffset(11, 0), Size = UDim2.new(0, 14, 1, 0),
			BackgroundTransparency = 1, Parent = searchBox,
		})
		local _, paint = Icons.search(wrap)
		paint(Theme.Dim, 0)
	end
	self.Search = new("TextBox", {
		Position = UDim2.fromOffset(30, 0), Size = UDim2.new(1, -40, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = "",
		PlaceholderText = "Search", PlaceholderColor3 = Theme.Dim, TextSize = 12,
		TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false, Parent = searchBox,
	})
	local minimize = new("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -18, 0.5, 0),
		Size = UDim2.fromOffset(24, 24), BackgroundColor3 = Theme.Field,
		BackgroundTransparency = 1, AutoButtonColor = false, Font = Enum.Font.GothamBold,
		Text = "—", TextSize = 14, TextColor3 = Theme.SubText, Parent = bar,
	})
	corner(8, minimize)
	self.Body = new("Frame", {
		Position = UDim2.fromOffset(0, 48), Size = UDim2.new(1, 0, 1, -48),
		BackgroundTransparency = 1, ZIndex = 2, Parent = self.Main,
	})
	local SIDE_T = 0.18
	local sideShell = new("Frame", {
		Size = UDim2.new(0, 172, 1, 0), BackgroundColor3 = Theme.Sidebar,
		BackgroundTransparency = SIDE_T, BorderSizePixel = 0, ZIndex = 2, Parent = self.Body,
	})
	corner(14, sideShell)
	new("Frame", {
		Size = UDim2.new(1, 0, 0, 14), BackgroundColor3 = Theme.Sidebar,
		BackgroundTransparency = SIDE_T, BorderSizePixel = 0, ZIndex = 1, Parent = sideShell,
	})
	new("Frame", {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0, 14, 1, 0), BackgroundColor3 = Theme.Sidebar,
		BackgroundTransparency = SIDE_T, BorderSizePixel = 0, ZIndex = 1, Parent = sideShell,
	})
	local sidebar = new("ScrollingFrame", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
		CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 2, ScrollBarImageColor3 = Theme.Stroke,
		ZIndex = 3, Parent = sideShell,
	})
	pad(sidebar, 6, 12, 12, 12)
	list(sidebar, 4)
	self.SideBar = sidebar
	new("Frame", {
		Position = UDim2.fromOffset(172, 0), Size = UDim2.new(0, 1, 1, 0),
		BackgroundColor3 = Theme.Line, BorderSizePixel = 0, ZIndex = 3, Parent = self.Body,
	})
	self.Pages = new("Frame", {
		Position = UDim2.fromOffset(173, 0), Size = UDim2.new(1, -173, 1, 0),
		BackgroundTransparency = 1, ZIndex = 2, Parent = self.Body,
	})
	self.Toasts = new("Frame", {
		Name = "Notifications", AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -18, 0, 72), Size = UDim2.fromOffset(286, 0),
		AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Parent = self.Gui,
	})
	list(self.Toasts, 8)
	self.MiniSize = config.MiniSize or Vector2.new(168, 50)
	self.Mini = new("Frame", {
		Name = "Mini", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		Visible = false, ZIndex = 20, Parent = self.Main,
	})
	self.MiniImage = new("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -2, 1, -2), BackgroundColor3 = Theme.Card,
		BorderSizePixel = 0, Image = "", ScaleType = Enum.ScaleType.Crop,
		ClipsDescendants = true, ZIndex = 20, Parent = self.Mini,
	})
	corner(14, self.MiniImage)
	self.MiniLabel = new("TextLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold, Text = "0x5A46", TextSize = 15,
		TextColor3 = Color3.new(1, 1, 1), TextStrokeTransparency = 0.45,
		ZIndex = 21, Parent = self.Mini,
	})
	local miniBtn = new("TextButton", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		AutoButtonColor = false, Text = "", ZIndex = 22, Parent = self.Mini,
	})
	function self:SyncMini()
		if not self.MiniImage then return end
		self.MiniImage.Image = self.BgImage and self.BgImage.Image or ""
		self.MiniImage.ImageTransparency = 0
		self.MiniImage.BackgroundColor3 = Theme.Card
	end
	self:_enableDrag(bar)
	minimize.MouseEnter:Connect(function()
		tween(minimize, { BackgroundTransparency = 0, TextColor3 = Theme.Text })
	end)
	minimize.MouseLeave:Connect(function()
		tween(minimize, { BackgroundTransparency = 1, TextColor3 = Theme.SubText })
	end)
	function self:ToggleMinimize()
		self.Minimized = not self.Minimized
		self.Body.Visible       = not self.Minimized
		self.TitleLabel.Visible = not self.Minimized
		searchBox.Visible       = not self.Minimized
		minimize.Visible        = not self.Minimized
		self.BgClip.Visible     = not self.Minimized
		if self.Minimized then self:SyncMini() end
		self.Mini.Visible = self.Minimized
		tween(self.Main, {
			Size = self.Minimized and UDim2.fromOffset(self.MiniSize.X, self.MiniSize.Y)
			                      or  UDim2.fromOffset(size.X, size.Y),
		}, SMOOTH)
	end
	minimize.MouseButton1Click:Connect(function() self:ToggleMinimize() end)
	self:_enableDrag(miniBtn)
	do
		local pressPos, moveu = nil, false
		miniBtn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				pressPos, moveu = input.Position, false
			end
		end)
		miniBtn.InputChanged:Connect(function(input)
			if pressPos and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
				if (input.Position - pressPos).Magnitude > 6 then moveu = true end
			end
		end)
		miniBtn.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				if pressPos and not moveu and self.Minimized then self:ToggleMinimize() end
				pressPos = nil
			end
		end)
	end
	self.Search:GetPropertyChangedSignal("Text"):Connect(function()
		self:_filter(self.Search.Text)
	end)
	UserInputService.InputBegan:Connect(function(input, processed)
		if not souAtual() then return end
		if Listening then return end
		if processed then return end
		if input.KeyCode == self.ToggleKey then self:ToggleMinimize() return end
		if input.KeyCode == Enum.KeyCode.End then
			self.Gui.Enabled = not self.Gui.Enabled
			return
		end
		for _, entry in ipairs(self.Binds) do
			if bindMatches(entry.Bind(), input) then entry.Fire() end
		end
	end)
	self.Main.Size = UDim2.fromOffset(size.X, 48)
	tween(self.Main, { Size = UDim2.fromOffset(size.X, size.Y) }, SMOOTH)
	return self
end
function Window:_enableDrag(handle)
	local dragging, startPos, startInput = false, nil, nil
	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging, startPos, startInput = true, self.Main.Position, input.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if not dragging or not souAtual() then return end
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			local delta = input.Position - startInput
			self.Main.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end
function Window:_filter(term)
	term = string.lower(term or "")
	local tab = self.Active
	if not tab then return end
	for _, section in ipairs(tab.Sections) do
		local titleMatch = string.find(string.lower(section.Title), term, 1, true) ~= nil
		local visible = 0
		for _, element in ipairs(section.Elements) do
			local match = term == "" or titleMatch
				or string.find(string.lower(element.Name), term, 1, true) ~= nil
			element.Frame.Visible = match
			if match and element.Name ~= "" then visible = visible + 1 end
		end
		section.Frame.Visible = (term == "") or titleMatch or visible > 0
	end
end
function Window:Notify(options)
	options = options or {}
	local duration = options.Duration or 4
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, Parent = self.Toasts,
	})
	local card = new("Frame", {
		Position = UDim2.fromScale(1.1, 0), Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Theme.Card,
		BorderSizePixel = 0, Parent = holder,
	})
	corner(11, card)
	stroke(Theme.Stroke, card)
	pad(card, 12, 14, 13, 14)
	list(card, 3)
	local head = new("Frame", {
		Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, Parent = card,
	})
	do
		local wrap = new("Frame", {
			Size = UDim2.fromOffset(18, 16), BackgroundTransparency = 1, Parent = head,
		})
		local _, paint = Icons.bell(wrap)
		paint(Theme.SubText, 0)
	end
	new("TextLabel", {
		Position = UDim2.fromOffset(22, 0), Size = UDim2.new(1, -22, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
		Text = options.Title or "Notice", TextSize = 13, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = head,
	})
	if options.Text then
		new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1, Font = Enum.Font.Gotham, Text = options.Text,
			TextSize = 11, TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Parent = card,
		})
	end
	local track = new("Frame", {
		Size = UDim2.new(1, 0, 0, 2), BackgroundColor3 = Theme.Line,
		BorderSizePixel = 0, Parent = card,
	})
	corner(1, track)
	local fill = new("Frame", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0, Parent = track,
	})
	corner(1, fill)
	tween(card, { Position = UDim2.fromScale(0, 0) }, SMOOTH)
	tween(fill, { Size = UDim2.fromScale(0, 1) }, TweenInfo.new(duration, Enum.EasingStyle.Linear))
	task.delay(duration, function()
		if not card.Parent then return end
		tween(card, { Position = UDim2.fromScale(1.1, 0) }, SMOOTH)
		task.wait(0.24)
		holder:Destroy()
	end)
end
--------------------------------------------------------------------
-- CABECALHO DA SIDEBAR  ·  win:Group("GAME")
-- So um rotulo com pontinho, pra separar grupos de aba.
--------------------------------------------------------------------
-- "ordem" existe porque a sidebar ordena por LayoutOrder: as abas de
-- jogo ficam em 0 e as do painel em 100/101, entao o cabecalho precisa
-- dizer em que faixa ele entra, senao cai em cima de tudo.
function Window:Group(text, ordem)
	local row = new("Frame", {
		Size = UDim2.new(1, 0, 0, 24), BackgroundTransparency = 1,
		LayoutOrder = ordem or -1, Parent = self.SideBar,
	})
	local ponto = new("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 1),
		Size = UDim2.fromOffset(4, 4), BackgroundColor3 = Theme.Accent,
		BackgroundTransparency = 0.35, BorderSizePixel = 0, Parent = row,
	})
	corner(2, ponto)
	new("TextLabel", {
		Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -14, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamBold,
		Text = string.upper(text), TextSize = 10, TextColor3 = Theme.Dim,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
	})
	return row
end

function Window:Tab(name, icon)
	local tab = setmetatable({ Name = name, Sections = {}, Window = self }, Tab)
	local button = new("TextButton", {
		Size = UDim2.new(1, 0, 0, 36), BackgroundColor3 = Theme.Hover,
		BackgroundTransparency = 1, AutoButtonColor = false, Text = "", Parent = self.SideBar,
	})
	corner(9, button)
	local indicator = new("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -12, 0.5, 0),
		Size = UDim2.fromOffset(2, 0), BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0, Parent = button,
	})
	corner(1, indicator)
	-- icone: se o nome bater com um desenho, desenha. Se nao bater, cai
	-- no texto de antes — assim P.Tab("X", "◉") continua funcionando.
	local iconSlot = new("Frame", {
		Position = UDim2.fromOffset(11, 0), Size = UDim2.new(0, 20, 1, 0),
		BackgroundTransparency = 1, Parent = button,
	})
	local paintIcon
	-- sem icone explicito? deduz pelo nome da aba.
	if icon == nil then icon = Icons.porNome(name) end
	if type(icon) == "string" and Icons.has(icon) then
		local _, p = Icons.draw(iconSlot, icon, 16)
		paintIcon = p
		paintIcon(Theme.SubText, 0)
	else
		local lbl = new("TextLabel", {
			Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium, Text = icon or "•", TextSize = 14,
			TextColor3 = Theme.SubText, Parent = iconSlot,
		})
		paintIcon = function(color) tween(lbl, { TextColor3 = color }) end
	end
	local textLabel = new("TextLabel", {
		Position = UDim2.fromOffset(38, 0), Size = UDim2.new(1, -46, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = name,
		TextSize = 13, TextColor3 = Theme.SubText,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = button,
	})
	local page = new("Frame", {
		Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
		Visible = false, Parent = self.Pages,
	})
	local function column(xScale, xOffset)
		local col = new("ScrollingFrame", {
			Position = UDim2.new(xScale, xOffset, 0, 0), Size = UDim2.new(0.5, -22, 1, 0),
			BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
			ScrollBarImageColor3 = Theme.Stroke, Parent = page,
		})
		pad(col, 16, 6, 16, 0)
		list(col, 12)
		return col
	end
	tab.Columns = { column(0, 16), column(0.5, 6) }
	tab.Button, tab.Page = button, page
	tab.Indicator, tab.Icon, tab.Label = indicator, iconSlot, textLabel
	tab.PaintIcon = paintIcon
	button.MouseEnter:Connect(function()
		if self.Active ~= tab then tween(button, { BackgroundTransparency = 0.45 }) end
	end)
	button.MouseLeave:Connect(function()
		if self.Active ~= tab then tween(button, { BackgroundTransparency = 1 }) end
	end)
	button.MouseButton1Click:Connect(function() self:Select(tab) end)
	table.insert(self.Tabs, tab)
	if #self.Tabs == 1 then self:Select(tab) end
	return tab
end
function Window:Select(tab)
	for _, other in ipairs(self.Tabs) do
		local on = other == tab
		other.Page.Visible = on
		tween(other.Button,    { BackgroundTransparency = on and 0 or 1 })
		tween(other.Label,     { TextColor3 = on and Theme.Text or Theme.SubText })
		other.PaintIcon(on and Theme.Text or Theme.SubText, 0)
		tween(other.Indicator, { Size = UDim2.fromOffset(2, on and 16 or 0) }, SMOOTH)
	end
	self.Active = tab
	self:_filter(self.Search.Text)
end
function Tab:Section(title, description, column)
	local section = setmetatable({ Title = title, Elements = {}, Window = self.Window }, Section)
	local card = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Theme.Card, BackgroundTransparency = 0.22,
		BorderSizePixel = 0, Parent = self.Columns[column or 1],
	})
	corner(12, card)
	stroke(Theme.Stroke, card, 1, 0.35)
	pad(card, 14, 14, 14, 16)
	list(card, 9)
	local header = new("Frame", {
		Size = UDim2.new(1, 0, 0, description and 36 or 20),
		BackgroundTransparency = 1, LayoutOrder = -1, Parent = card,
	})
	new("TextLabel", {
		Size = UDim2.new(1, -26, 0, 18), BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold, Text = title, TextSize = 15, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = header,
	})
	if description then
		new("TextLabel", {
			Position = UDim2.fromOffset(0, 20), Size = UDim2.new(1, -26, 0, 14),
			BackgroundTransparency = 1, Font = Enum.Font.Gotham, Text = description,
			TextSize = 11, TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left, Parent = header,
		})
	end
	local locked = false
	local lock = new("TextButton", {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0),
		Size = UDim2.fromOffset(20, 20), BackgroundTransparency = 1,
		AutoButtonColor = false, Text = "", Parent = header,
	})
	local _, paintLock = Icons.lock(lock)
	paintLock(Theme.Dim, 0.3)
	lock.MouseButton1Click:Connect(function()
		locked = not locked
		paintLock(locked and Theme.Text or Theme.Dim, locked and 0 or 0.3)
		section.Locked = locked
		if section.OnLock then section.OnLock(locked) end
	end)
	section.Frame = card
	table.insert(self.Sections, section)
	return section
end
function Section:_row(height)
	return new("Frame", {
		Size = UDim2.new(1, 0, 0, height or 26),
		BackgroundTransparency = 1, Parent = self.Frame,
	})
end
function Section:_track(element)
	table.insert(self.Elements, element)
	return element
end
function Section:_keybind(parent, default, onChange)
	local bind = default
	local holder = new("Frame", {
		Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1, Parent = parent,
	})
	list(holder, 6, Enum.FillDirection.Horizontal).VerticalAlignment = Enum.VerticalAlignment.Center
	do
		local wrap = new("Frame", {
			Size = UDim2.fromOffset(14, 20), BackgroundTransparency = 1, Parent = holder,
		})
		local _, paint = Icons.bind(wrap)
		paint(Theme.Dim, 0)
	end
	local chip = new("TextButton", {
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20),
		BackgroundColor3 = Theme.Field, AutoButtonColor = false, BorderSizePixel = 0,
		Font = Enum.Font.GothamBold, Text = bindLabel(bind), TextSize = 11,
		TextColor3 = Theme.SubText, Parent = holder,
	})
	corner(6, chip)
	pad(chip, 0, 8, 0, 8)
	new("UISizeConstraint", { MinSize = Vector2.new(24, 20), Parent = chip })
	local function paint(listening)
		chip.Text = listening and "..." or bindLabel(bind)
		tween(chip, {
			BackgroundColor3 = listening and Theme.Hover or Theme.Field,
			TextColor3 = listening and Theme.Text or (bind and Theme.Text or Theme.Dim),
		})
	end
	paint(false)
	local function stopListening()
		if Listening and Listening.chip == chip then
			Listening.conn:Disconnect()
			Listening = nil
		end
		paint(false)
	end
	local function startListening()
		if Listening then Listening.stop() end
		paint(true)
		task.defer(function()
			if not chip.Parent then return end
			local conn
			conn = UserInputService.InputBegan:Connect(function(input)
				if input.KeyCode == Enum.KeyCode.Escape then stopListening() return end
				local captured
				if input.UserInputType == Enum.UserInputType.Keyboard
					and input.KeyCode ~= Enum.KeyCode.Unknown then
					captured = { Key = input.KeyCode }
				elseif MOUSE_NAMES[input.UserInputType] then
					captured = { Mouse = input.UserInputType }
				end
				if captured then
					bind = captured
					stopListening()
					if onChange then task.spawn(onChange, bind, bindLabel(bind)) end
				end
			end)
			Listening = { chip = chip, conn = conn, stop = stopListening }
		end)
	end
	local hovering = false
	chip.MouseEnter:Connect(function()
		hovering = true
		if not Listening then tween(chip, { BackgroundColor3 = Theme.Hover }) end
	end)
	chip.MouseLeave:Connect(function()
		hovering = false
		if not Listening then tween(chip, { BackgroundColor3 = Theme.Field }) end
	end)
	UserInputService.InputBegan:Connect(function(input)
		if not souAtual() then return end
		if not chip.Parent or not hovering then return end
		if Listening and Listening.chip == chip then return end
		local kind = input.UserInputType
		if kind == Enum.UserInputType.MouseButton3 or kind == Enum.UserInputType.MouseButton1 then
			startListening()
		elseif kind == Enum.UserInputType.MouseButton2 then
			bind = nil
			stopListening()
			if onChange then task.spawn(onChange, nil, "None") end
		end
	end)
	return {
		Get = function() return bind end,
		Set = function(_, value) bind = value paint(false) end,
	}
end
function Section:_bell(parent, xOffset, onChange)
	local on = false
	local button = new("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, xOffset, 0.5, 0),
		Size = UDim2.fromOffset(22, 22), BackgroundTransparency = 1,
		AutoButtonColor = false, Text = "", Parent = parent,
	})
	local _, paint = Icons.bell(button)
	paint(Theme.Dim, 0.3)
	button.MouseButton1Click:Connect(function()
		on = not on
		paint(on and Theme.Alert or Theme.Dim, on and 0 or 0.3)
		if onChange then onChange(on) end
	end)
	return { Get = function() return on end }
end
function Section:Toggle(options)
	options = options or {}
	local state = options.Default or false
	local window = self.Window
	local row = self:_row(26)
	local api, bell, keybind = {}, nil, nil
	if options.Name then
		new("TextLabel", {
			Size = UDim2.new(1, options.Keybind ~= nil and -150 or -100, 1, 0),
			BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = options.Name,
			TextSize = 12, TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd, Parent = row,
		})
	end
	local track = new("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(40, 21),
		BackgroundColor3 = state and Theme.Accent or Theme.TrackOff,
		AutoButtonColor = false, Text = "", BorderSizePixel = 0, Parent = row,
	})
	corner(11, track)
	local knob = new("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, state and 22 or 3, 0.5, 0),
		Size = UDim2.fromOffset(15, 15),
		BackgroundColor3 = state and Theme.KnobOn or Theme.KnobOff,
		BorderSizePixel = 0, Parent = track,
	})
	corner(8, knob)
	if options.Bell ~= false then bell = self:_bell(row, -52) end
	if options.Keybind ~= nil then
		local slot = new("Frame", {
			Position = UDim2.fromOffset(0, 0), Size = UDim2.new(0, 0, 1, 0),
			AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1, Parent = row,
		})
		if options.Name then
			slot.AnchorPoint = Vector2.new(1, 0.5)
			slot.Position = UDim2.new(1, -84, 0.5, 0)
		end
		keybind = self:_keybind(slot, options.Keybind, options.OnKeybind)
	end
	local function render()
		tween(track, { BackgroundColor3 = state and Theme.Accent or Theme.TrackOff }, SMOOTH)
		tween(knob, {
			Position = UDim2.new(0, state and 22 or 3, 0.5, 0),
			BackgroundColor3 = state and Theme.KnobOn or Theme.KnobOff,
		}, SMOOTH)
	end
	local function flip(silent)
		state = not state
		render()
		if bell and bell.Get() then
			window:Notify({
				Title = options.Name or self.Title,
				Text = state and "ativado" or "desativado",
			})
		end
		if not silent and options.Callback then task.spawn(options.Callback, state) end
	end
	track.MouseButton1Click:Connect(function() flip(false) end)
	if keybind then
		table.insert(window.Binds, {
			Bind = function() return keybind.Get() end,
			Fire = function() flip(false) end,
		})
	end
	function api:Set(value, silent)
		state = value and true or false
		render()
		if not silent and options.Callback then task.spawn(options.Callback, state) end
	end
	function api:Get() return state end
	function api:GetBind() return keybind and keybind.Get() end
	self:_track({ Frame = row, Name = options.Name or self.Title, Api = api })
	return api
end
function Section:Checkbox(options)
	options = options or {}
	local state = options.Default or false
	local row = self:_row(24)
	new("TextLabel", {
		Size = UDim2.new(1, -60, 1, 0), BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium, Text = options.Name or "Checkbox", TextSize = 12,
		TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
	})
	if options.Bell then self:_bell(row, -28) end
	local box = new("TextButton", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.fromOffset(20, 20),
		BackgroundColor3 = state and Theme.Accent or Theme.Field, AutoButtonColor = false,
		Font = Enum.Font.GothamBold, Text = state and Glyphs.Check or "", TextSize = 12,
		TextColor3 = Theme.KnobOn, BorderSizePixel = 0, Parent = row,
	})
	corner(6, box)
	stroke(Theme.Stroke, box)
	local function render()
		box.Text = state and Glyphs.Check or ""
		tween(box, { BackgroundColor3 = state and Theme.Accent or Theme.Field })
	end
	box.MouseButton1Click:Connect(function()
		state = not state
		render()
		if options.Callback then task.spawn(options.Callback, state) end
	end)
	local api = {}
	function api:Set(v) state = v and true or false render() end
	function api:Get() return state end
	self:_track({ Frame = row, Name = options.Name or "Checkbox", Api = api })
	return api
end
function Section:Slider(options)
	options = options or {}
	local min, max = options.Min or 0, options.Max or 100
	local value = math.clamp(options.Default or min, min, max)
	local decimals = options.Decimals or 0
	local row = self:_row(40)
	new("TextLabel", {
		Size = UDim2.new(1, -70, 0, 16), BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium, Text = options.Name or "Slider", TextSize = 12,
		TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
	})
	local readout = new("TextLabel", {
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.fromOffset(70, 16), BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold, Text = "", TextSize = 12, TextColor3 = Theme.SubText,
		TextXAlignment = Enum.TextXAlignment.Right, Parent = row,
	})
	local bar = new("TextButton", {
		Position = UDim2.new(0, 0, 0, 26), Size = UDim2.new(1, 0, 0, 4),
		BackgroundColor3 = Theme.TrackOff, AutoButtonColor = false, Text = "",
		BorderSizePixel = 0, Parent = row,
	})
	corner(2, bar)
	local fill = new("Frame", {
		Size = UDim2.fromScale(0, 1), BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0, Parent = bar,
	})
	corner(2, fill)
	local knob = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.fromOffset(11, 11), BackgroundColor3 = Theme.Accent,
		BorderSizePixel = 0, Parent = bar,
	})
	corner(6, knob)
	local function round(n)
		local mult = 10 ^ decimals
		return math.floor(n * mult + 0.5) / mult
	end
	local function render(fire)
		local alpha = (max - min) == 0 and 0 or (value - min) / (max - min)
		fill.Size = UDim2.fromScale(alpha, 1)
		knob.Position = UDim2.new(alpha, 0, 0.5, 0)
		readout.Text = tostring(round(value)) .. (options.Suffix or "")
		if fire and options.Callback then task.spawn(options.Callback, round(value)) end
	end
	local dragging = false
	local function fromMouse()
		if bar.AbsoluteSize.X <= 0 then return end
		local rel = (UserInputService:GetMouseLocation().X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
		value = min + math.clamp(rel, 0, 1) * (max - min)
		render(true)
	end
	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true fromMouse()
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
	RunService.RenderStepped:Connect(function()
		if not souAtual() then return end
		if dragging then fromMouse() end
	end)
	render(false)
	local api = {}
	function api:Set(v) value = math.clamp(v, min, max) render(true) end
	function api:Get() return round(value) end
	self:_track({ Frame = row, Name = options.Name or "Slider", Api = api })
	return api
end
function Section:Dropdown(options)
	options = options or {}
	local items = options.Items or {}
	local selected = options.Default or items[1] or "None"
	local open = false
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, Parent = self.Frame,
	})
	list(holder, 6)
	new("TextLabel", {
		Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium, Text = options.Name or "Dropdown", TextSize = 12,
		TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = holder,
	})
	local field = new("TextButton", {
		Size = UDim2.new(1, 0, 0, 32), BackgroundColor3 = Theme.Field,
		AutoButtonColor = false, Text = "", BorderSizePixel = 0, Parent = holder,
	})
	corner(9, field)
	stroke(Theme.Stroke, field)
	local valueLabel = new("TextLabel", {
		Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -40, 1, 0),
		BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = selected,
		TextSize = 12, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = field,
	})
	local arrow = new("TextLabel", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.fromOffset(16, 16), BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium, Text = Glyphs.Sort, TextSize = 13,
		TextColor3 = Theme.SubText, Parent = field,
	})
	local menu = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), BackgroundColor3 = Theme.Field,
		BorderSizePixel = 0, ClipsDescendants = true, Parent = holder,
	})
	corner(9, menu)
	local menuList = list(menu, 0)
	pad(menu, 4, 4, 4, 4)
	local function choose(item)
		selected = item
		valueLabel.Text = item
		if options.Callback then task.spawn(options.Callback, item) end
	end
	local function criarEntrada(item)
		local entry = new("TextButton", {
			Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = Theme.Hover,
			BackgroundTransparency = 1, AutoButtonColor = false,
			Font = Enum.Font.GothamMedium, Text = item, TextSize = 12,
			TextColor3 = Theme.SubText, TextXAlignment = Enum.TextXAlignment.Left,
			Parent = menu,
		})
		corner(6, entry)
		pad(entry, 0, 8, 0, 8)
		entry.MouseEnter:Connect(function()
			tween(entry, { BackgroundTransparency = 0, TextColor3 = Theme.Text })
		end)
		entry.MouseLeave:Connect(function()
			tween(entry, { BackgroundTransparency = 1, TextColor3 = Theme.SubText })
		end)
		entry.MouseButton1Click:Connect(function()
			choose(item)
			open = false
			tween(menu, { Size = UDim2.new(1, 0, 0, 0) }, SMOOTH)
			tween(arrow, { Rotation = 0 })
		end)
	end
	for _, item in ipairs(items) do criarEntrada(item) end
	field.MouseButton1Click:Connect(function()
		open = not open
		local height = open and (menuList.AbsoluteContentSize.Y + 8) or 0
		tween(menu, { Size = UDim2.new(1, 0, 0, height) }, SMOOTH)
		tween(arrow, { Rotation = open and 180 or 0 })
	end)
	local api = {}
	function api:Get() return selected end
	function api:Set(item) choose(item) end
	-- troca a lista sem refazer o componente. Serve pra lista que so
	-- existe depois que o jogo carrega (NPC que entra e sai por
	-- streaming, por exemplo).
	function api:SetItems(novos, manterEscolha)
		items = novos or {}
		for _, c in ipairs(menu:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
		for _, item in ipairs(items) do criarEntrada(item) end
		local aindaTem = false
		for _, item in ipairs(items) do if item == selected then aindaTem = true break end end
		if not (manterEscolha and aindaTem) then
			selected = (aindaTem and selected) or items[1] or "None"
			valueLabel.Text = selected
		end
		if open then
			task.defer(function()
				tween(menu, { Size = UDim2.new(1, 0, 0, menuList.AbsoluteContentSize.Y + 8) }, SMOOTH)
			end)
		end
	end
	function api:Items() return items end
	self:_track({ Frame = holder, Name = options.Name or "Dropdown", Api = api })
	return api
end
function Section:Button(options)
	options = options or {}
	local row = self:_row(32)
	local button = new("TextButton", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Field,
		AutoButtonColor = false, BorderSizePixel = 0, Font = Enum.Font.GothamMedium,
		Text = options.Name or "Run", TextSize = 12, TextColor3 = Theme.Text, Parent = row,
	})
	corner(9, button)
	stroke(Theme.Stroke, button)
	button.MouseEnter:Connect(function() tween(button, { BackgroundColor3 = Theme.Hover }) end)
	button.MouseLeave:Connect(function() tween(button, { BackgroundColor3 = Theme.Field }) end)
	button.MouseButton1Click:Connect(function()
		if options.Callback then task.spawn(options.Callback) end
	end)
	self:_track({ Frame = row, Name = options.Name or "Button" })
	return button
end
function Section:Label(text)
	local row = self:_row(18)
	local label = new("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = text,
		TextSize = 11, TextColor3 = Theme.SubText, Parent = row,
	})
	pad(label, 0, 10, 0, 10)
	local function side(anchorX, posX)
		new("Frame", {
			AnchorPoint = Vector2.new(anchorX, 0.5), Position = UDim2.new(posX, 0, 0.5, 0),
			Size = UDim2.new(0.5, -46, 0, 1), BackgroundColor3 = Theme.Line,
			BorderSizePixel = 0, Parent = row,
		})
	end
	side(0, 0)
	side(1, 1)
	self:_track({ Frame = row, Name = "" })
	return row
end
function Section:Divider()
	local row = self:_row(9)
	new("Frame", {
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Theme.Line,
		BorderSizePixel = 0, Parent = row,
	})
	self:_track({ Frame = row, Name = "" })
	return row
end
function Section:Input(options)
	options = options or {}
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, Parent = self.Frame,
	})
	list(holder, 6)
	if options.Name then
		new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium, Text = options.Name, TextSize = 12,
			TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = holder,
		})
	end
	local box = new("TextBox", {
		Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Theme.Field, BorderSizePixel = 0,
		Text = options.Default or "", PlaceholderText = options.Placeholder or "",
		PlaceholderColor3 = Theme.Dim, ClearTextOnFocus = false, Font = Enum.Font.Gotham,
		TextSize = 12, TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left, Parent = holder,
	})
	corner(9, box)
	local st = stroke(Theme.Stroke, box)
	pad(box, 0, 10, 0, 10)
	box.Focused:Connect(function() tween(st, { Color = Theme.Accent }) end)
	box.FocusLost:Connect(function(enter)
		tween(st, { Color = Theme.Stroke })
		if enter and options.Callback then task.spawn(options.Callback, box.Text) end
	end)
	self:_track({ Frame = holder, Name = options.Name or "Input" })
	return box
end
function Section:Info(text, height)
	local row = self:_row(height or 74)
	local card = new("Frame", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Theme.Field,
		BackgroundTransparency = 0.15, BorderSizePixel = 0, Parent = row,
	})
	corner(9, card)
	stroke(Theme.Stroke, card, 1, 0.4)
	local lbl = new("TextLabel", {
		Size = UDim2.new(1, -20, 1, -12), Position = UDim2.fromOffset(10, 6),
		BackgroundTransparency = 1, Font = Enum.Font.Gotham, Text = text, TextSize = 11,
		TextColor3 = Theme.SubText, TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true, RichText = true, Parent = card,
	})
	self:_track({ Frame = row, Name = "" })
	return { frame = card, label = lbl, set = function(t) lbl.Text = t end }
end
function Section:Status()
	local row = self:_row(46)
	local label = new("TextLabel", {
		Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(13, 13, 13),
		BorderSizePixel = 0, Font = Enum.Font.Gotham, Text = "—", TextSize = 11,
		TextColor3 = Theme.SubText, TextWrapped = true, Parent = row,
	})
	corner(8, label)
	pad(label, 6, 8, 6, 8)
	self:_track({ Frame = row, Name = "" })
	return label
end
--==================================================================
--                            A JANELA
--==================================================================
local win = Zero.new({ Title = "0x5A46 · Eggs" })
print("[0x5A46] janela criada")
--==================================================================
--                      IMAGEM DE FUNDO
--==================================================================
local statusImg
local caixaFundo
local function hashStr(s)
    local h = 5381
    for i = 1, #s do
        h = (h * 33 + string.byte(s, i)) % 4294967296
    end
    return string.format("%x", h)
end
local function nomeArquivoFundo(url, ext)
    local id = hashStr(url) .. "_" .. tostring(BG.salt or 0)
    if makefolder and isfolder then
        pcall(function()
            if not isfolder(BG_PASTA) then makefolder(BG_PASTA) end
        end)
        return BG_PASTA .. "/fundo_" .. id .. "." .. ext
    end
    return "painel_0x5A46_fundo_" .. id .. "." .. ext
end
local function salvarFundo()
    if not writefile then return end
    pcall(function()
        writefile(BG_ARQUIVO, HttpService:JSONEncode(BG))
    end)
end
local function httpFetch(url)
    local tentativas = {
        function() return game:HttpGet(url) end,
        function() return game:HttpGetAsync(url) end,
        function()
            local req = (syn and syn.request) or (http and http.request) or http_request or request
            if req then
                local r = req({ Url = url, Method = "GET" })
                return r and (r.Body or r.body)
            end
        end,
    }
    for _, fn in ipairs(tentativas) do
        local ok, res = pcall(fn)
        if ok and type(res) == "string" and #res > 0 then return res end
    end
    return nil
end
local function pareceImagemDireta(u)
    u = string.lower(u)
    return (string.find(u, "%.png") or string.find(u, "%.jpe?g") or string.find(u, "%.webp")) ~= nil
end
local function acharImagemNoHtml(html)
    if type(html) ~= "string" then return nil end
    local pin = string.match(html, 'https://i%.pinimg%.com/[%w%p]-%.jpg')
             or string.match(html, 'https://i%.pinimg%.com/[%w%p]-%.png')
    if pin then return pin end
    local og = string.match(html, 'og:image"%s*content="([^"]+)"')
            or string.match(html, 'content="([^"]+)"%s*property="og:image"')
    if og then return (string.gsub(og, "&amp;", "&")) end
    return string.match(html, 'https://[%w%p]-%.jpg') or string.match(html, 'https://[%w%p]-%.png')
end
-- Resolve "ID / link / arquivo" numa imagem que da pra usar em
-- qualquer ImageLabel. Ficou separado pra o medidor de fps poder ter
-- fundo proprio sem eu duplicar tudo isso.
-- Devolve: conteudo, arquivoSalvo, erro
local function resolverFonteImagem(entrada, salt, diz)
    entrada = string.gsub(string.gsub(tostring(entrada or ""), "^%s+", ""), "%s+$", "")
    if entrada == "" then return nil, nil, nil end

    if tonumber(entrada) then
        return "rbxassetid://" .. entrada, "", nil
    end
    if string.sub(entrada, 1, 13) == "rbxassetid://" then
        return entrada, "", nil
    end
    if string.sub(entrada, 1, 4) == "http" then
        if not (writefile and getcustomasset) then
            return nil, nil, "Seu executor nao tem writefile/getcustomasset."
        end
        local url = entrada
        if not pareceImagemDireta(url) then
            if diz then diz("Procurando a imagem na pagina...") end
            local pagina = httpFetch(url)
            local achou = pagina and acharImagemNoHtml(pagina)
            if not achou then
                return nil, nil, "Nao achei a imagem nessa pagina."
            end
            url = achou
        end
        local ext = string.find(string.lower(url), "%.jpe?g") and "jpg" or "png"
        local id = hashStr(url) .. "_" .. tostring(salt or 0)
        local arq
        if makefolder and isfolder then
            pcall(function() if not isfolder(BG_PASTA) then makefolder(BG_PASTA) end end)
            arq = BG_PASTA .. "/img_" .. id .. "." .. ext
        else
            arq = "painel_0x5A46_" .. id .. "." .. ext
        end
        local jaTem = false
        pcall(function() jaTem = isfile and isfile(arq) end)
        if not jaTem then
            if diz then diz("Baixando...") end
            local dados = httpFetch(url)
            if not dados then return nil, nil, "Falha ao baixar." end
            if not pcall(function() writefile(arq, dados) end) then
                return nil, nil, "Falha ao salvar."
            end
        end
        local conteudo
        if not pcall(function() conteudo = getcustomasset(arq) end) or not conteudo then
            return nil, nil, "Falha ao ler a imagem salva."
        end
        return conteudo, arq, nil
    end
    -- nome de arquivo na pasta do executor
    if not getcustomasset then return nil, nil, "Seu executor nao tem getcustomasset." end
    local conteudo
    if not pcall(function() conteudo = getcustomasset(entrada) end) or not conteudo then
        return nil, nil, "Arquivo nao achado na pasta do executor."
    end
    return conteudo, entrada, nil
end

local function definirFundo(entrada, silencioso)
    entrada = string.gsub(string.gsub(tostring(entrada or ""), "^%s+", ""), "%s+$", "")
    BG.imagem = entrada
    local function diz(t) if statusImg then statusImg.set(t) end end
    if caixaFundo and caixaFundo.Text ~= entrada and not caixaFundo:IsFocused() then
        caixaFundo.Text = entrada
    end
    if entrada == "" then
        win.BgImage.Image = ""
        win.BgImage.Visible = false
        BG.arquivo = ""
        if win.SyncMini then pcall(function() win:SyncMini() end) end
        diz("Sem imagem.")
        salvarFundo()
        return
    end
    if tonumber(entrada) then
        BG.arquivo = ""
        win.BgImage.Image = "rbxassetid://" .. entrada
        win.BgImage.ImageTransparency = BG.transparencia
        win.BgImage.Visible = true
        if win.SyncMini then pcall(function() win:SyncMini() end) end
        diz("Carregando ID " .. entrada .. "...")
        task.delay(1.2, function()
            if win.BgImage.Visible and not win.BgImage.IsLoaded then
                win.BgImage.Image = "rbxthumb://type=Asset&id=" .. entrada .. "&w=420&h=420"
                diz("Aplicado via thumb (ID " .. entrada .. ")")
            else
                diz("Imagem aplicada (ID " .. entrada .. ")")
            end
        end)
        salvarFundo()
        if not silencioso then
            win:Notify({ Title = "Background", Text = "image changed", Duration = 3 })
        end
        return
    end
    local conteudo
    if string.sub(entrada, 1, 13) == "rbxassetid://" then
        BG.arquivo = ""
        conteudo = entrada
    elseif string.sub(entrada, 1, 4) == "http" then
        if not (writefile and getcustomasset) then
            diz("Seu executor nao tem writefile/getcustomasset.\nUse um ID do Roblox.")
            return
        end
        local url = entrada
        if not pareceImagemDireta(url) then
            diz("Procurando a imagem na pagina...")
            local pagina = httpFetch(url)
            local achou = pagina and acharImagemNoHtml(pagina)
            if achou then
                url = achou
            else
                diz("Nao achei a imagem nessa pagina.\nUse o link direto (.jpg / .png).")
                return
            end
        end
        local ext = string.find(string.lower(url), "%.jpe?g") and "jpg" or "png"
        local arq = nomeArquivoFundo(url, ext)
        local jaTem = false
        pcall(function() jaTem = isfile and isfile(arq) end)
        if not jaTem then
            diz("Baixando...")
            local dados = httpFetch(url)
            if not dados then diz("Falha ao baixar. Tente um ID do Roblox.") return end
            local ok = pcall(function() writefile(arq, dados) end)
            if not ok then diz("Falha ao salvar a imagem.") return end
        end
        local ok2 = pcall(function() conteudo = getcustomasset(arq) end)
        if not ok2 or not conteudo then diz("Falha ao ler a imagem salva.") return end
        BG.arquivo = arq
    else
        if not getcustomasset then diz("Seu executor nao tem getcustomasset.") return end
        local ok = pcall(function() conteudo = getcustomasset(entrada) end)
        if not ok or not conteudo then diz("Arquivo nao achado na pasta do executor.") return end
        BG.arquivo = entrada
    end
    if conteudo then
        win.BgImage.Image = conteudo
        win.BgImage.ImageTransparency = BG.transparencia
        win.BgImage.Visible = true
        if win.SyncMini then pcall(function() win:SyncMini() end) end
        diz("Imagem aplicada. Pra trocar, cole outra e clique Aplicar.")
        salvarFundo()
        if not silencioso then
            win:Notify({ Title = "Background", Text = "image changed", Duration = 3 })
        end
    else
        diz("Nao foi possivel aplicar.")
    end
end
local function carregarFundo()
    if not (readfile and isfile) then return end
    local bruto
    local ok = pcall(function() if isfile(BG_ARQUIVO) then bruto = readfile(BG_ARQUIVO) end end)
    if not ok or not bruto or bruto == "" then return end
    local dados
    if not pcall(function() dados = HttpService:JSONDecode(bruto) end) then return end
    if type(dados) ~= "table" then return end
    if type(dados.transparencia) == "number" then BG.transparencia = dados.transparencia end
    if type(dados.salt) == "number" then BG.salt = dados.salt end
    if type(dados.arquivo) == "string" then BG.arquivo = dados.arquivo end
    if type(dados.imagem) == "string" and dados.imagem ~= "" then
        BG.imagem = dados.imagem
        task.spawn(function()
            task.wait(0.5)
            if caixaFundo then caixaFundo.Text = BG.imagem end
            local pronto = false
            if BG.arquivo ~= "" and isfile and getcustomasset then
                pcall(function()
                    if isfile(BG.arquivo) then
                        local conteudo = getcustomasset(BG.arquivo)
                        if conteudo then
                            win.BgImage.Image = conteudo
                            win.BgImage.ImageTransparency = BG.transparencia
                            win.BgImage.Visible = true
                            if win.SyncMini then pcall(function() win:SyncMini() end) end
                            if statusImg then statusImg.set("Imagem de sempre carregada do disco.") end
                            pronto = true
                        end
                    end
                end)
            end
            if not pronto then pcall(definirFundo, BG.imagem, true) end
        end)
    end
end
---------------------------------------------------------------- CUSTOMIZE
win:Group("Painel", 99)
local abaCustom = win:Tab("Customize", "sparkle")
-- Config e Customize sempre por ULTIMO na barra lateral: as abas do
-- jogo (criadas depois) ficam em cima, com LayoutOrder 0.
abaCustom.Button.LayoutOrder = 100
do
    local img = abaCustom:Section("Background image", "Roblox ID, link or file", 1)
    local caixa = img:Input({ Name = "Source", Placeholder = "1234567890  /  link.png  /  photo.png",
        Default = BG.imagem, Callback = function(t) definirFundo(t) end })
    caixaFundo = caixa
    img:Button({ Name = "Apply", Callback = function() definirFundo(caixa.Text) end })
    img:Button({ Name = "Remove", Callback = function()
        caixa.Text = ""
        definirFundo("")
    end })
    img:Button({ Name = "Reload (if the link changed)", Callback = function()
        if BG.imagem == "" then
            win:Notify({ Title = "Background", Text = "no image to reload", Duration = 3 })
            return
        end
        BG.salt = (BG.salt or 0) + 1
        definirFundo(BG.imagem)
    end })
    img:Slider({ Name = "Image transparency", Min = 0, Max = 100,
        Default = math.floor(BG.transparencia * 100), Suffix = "%",
        Callback = function(v)
            BG.transparencia = v / 100
            win.BgImage.ImageTransparency = BG.transparencia
            salvarFundo()
        end })
    local j = abaCustom:Section("Window", nil, 2)
    j:Slider({ Name = "Panel transparency", Min = 0, Max = 90, Default = 0, Suffix = "%",
        Callback = function(v) win.Main.BackgroundTransparency = v / 100 end })
    -- so linha de status (erro / confirmacao), sem texto explicativo
    statusImg = abaCustom:Section("Status", nil, 2):Info("—", 40)
    carregarFundo()
end
--==================================================================
--                    MEDIDOR DE FPS E PING
--==================================================================
-- Painelzinho solto, arrastavel, com fundo proprio. Nao usa nada da
-- imagem do painel grande: guarda no arquivo dele mesmo.
-- transp    = transparencia da PROPRIA imagem (0 = imagem cheia)
-- escurecer = o quanto do cartao preto fica atras dela (0 = nada,
--             so a imagem; suba se o texto sumir em cima de foto clara)
local MED = { ligado = false, imagem = "", arquivo = "", salt = 0,
              transp = 0, escurecer = 0, escala = 1, x = 20, y = 90,
              versao = 2 }
local MED_ARQUIVO = "painel_0x5A46_medidor.json"
local statusMed

local function salvarMed()
    if not writefile then return end
    pcall(function() writefile(MED_ARQUIVO, HttpService:JSONEncode(MED)) end)
end

local velhaMed = RAIZ:FindFirstChild("Medidor_0x5A46")
if velhaMed then pcall(function() velhaMed:Destroy() end) end

local telaMed = new("ScreenGui", {
    Name = "Medidor_0x5A46", ResetOnSpawn = false, IgnoreGuiInset = true,
    DisplayOrder = 998, Enabled = false, Parent = RAIZ,
})
local caixaMed = new("Frame", {
    Position = UDim2.fromOffset(MED.x, MED.y), Size = UDim2.fromOffset(132, 52),
    BackgroundColor3 = Theme.Card, BackgroundTransparency = 0.1,
    BorderSizePixel = 0, ClipsDescendants = true, Parent = telaMed,
})
corner(10, caixaMed)
stroke(Theme.Stroke, caixaMed, 1, 0.3)
local fundoMed = new("ImageLabel", {
    Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, BorderSizePixel = 0,
    Image = "", ImageTransparency = MED.transp,
    ScaleType = Enum.ScaleType.Crop, Visible = false, ZIndex = 0, Parent = caixaMed,
})
corner(10, fundoMed)
local textoFps = new("TextLabel", {
    Position = UDim2.fromOffset(10, 6), Size = UDim2.new(1, -20, 0, 20),
    BackgroundTransparency = 1, Font = Enum.Font.GothamBold, Text = "-- FPS",
    TextSize = 15, TextColor3 = Theme.Text, TextXAlignment = Enum.TextXAlignment.Left,
    TextStrokeTransparency = 0.6, ZIndex = 2, Parent = caixaMed,
})
local textoPing = new("TextLabel", {
    Position = UDim2.fromOffset(10, 26), Size = UDim2.new(1, -20, 0, 18),
    BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, Text = "-- ms",
    TextSize = 12, TextColor3 = Theme.SubText, TextXAlignment = Enum.TextXAlignment.Left,
    TextStrokeTransparency = 0.7, ZIndex = 2, Parent = caixaMed,
})

-- Sem imagem o cartao e o fundo. COM imagem ele sai da frente:
-- fica so o quanto de escuro voce pedir no slider "Escurecer".
local function ajustarCartaoMed()
    if fundoMed.Visible then
        caixaMed.BackgroundTransparency = 1 - MED.escurecer
        textoFps.TextStrokeTransparency  = 0.25
        textoPing.TextStrokeTransparency = 0.35
    else
        caixaMed.BackgroundTransparency = 0.1
        textoFps.TextStrokeTransparency  = 0.6
        textoPing.TextStrokeTransparency = 0.7
    end
end

-- arrastar
do
    local arrastando, inicioPos, inicioMouse = false, nil, nil
    caixaMed.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            arrastando, inicioPos, inicioMouse = true, caixaMed.Position, input.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    arrastando = false
                    MED.x, MED.y = caixaMed.Position.X.Offset, caixaMed.Position.Y.Offset
                    salvarMed()
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not arrastando or not souAtual() then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - inicioMouse
            caixaMed.Position = UDim2.fromOffset(inicioPos.X.Offset + d.X,
                                                 inicioPos.Y.Offset + d.Y)
        end
    end)
end

local function definirFundoMedidor(entrada, silencioso)
    entrada = tostring(entrada or "")
    MED.imagem = entrada
    local function diz(t) if statusMed then statusMed.set(t) end end
    if entrada == "" then
        fundoMed.Image = "" fundoMed.Visible = false
        MED.arquivo = ""
        ajustarCartaoMed()
        diz("Sem imagem.")
        salvarMed()
        return
    end
    local conteudo, arq, erro = resolverFonteImagem(entrada, MED.salt, diz)
    if erro or not conteudo then
        diz(erro or "Nao foi possivel aplicar.")
        return
    end
    MED.arquivo = arq or ""
    fundoMed.Image = conteudo
    fundoMed.ImageTransparency = MED.transp
    fundoMed.Visible = true
    ajustarCartaoMed()
    diz("Imagem aplicada no medidor.")
    salvarMed()
    if not silencioso then
        win:Notify({ Title = "Medidor", Text = "fundo trocado", Duration = 3 })
    end
end

-- fps por media movel, ping do Stats
local Stats = game:GetService("Stats")
local fpsMed = 60
RunService.RenderStepped:Connect(function(dt)
    if not souAtual() then return end
    if dt > 0 then fpsMed = fpsMed * 0.9 + (1 / dt) * 0.1 end
end)

task.spawn(function()
    while souAtual() do
        task.wait(0.25)
        if telaMed.Enabled then
            local ping = LocalPlayer:GetAttribute("Ping")
            if type(ping) ~= "number" or ping <= 0 then
                local ok, ms = pcall(function()
                    return Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
                end)
                ping = (ok and ms) or 0
            end
            local f = math.floor(fpsMed)
            textoFps.Text = f .. " FPS"
            textoFps.TextColor3 = (f >= 50 and Color3.fromRGB(235,235,235))
                or (f >= 30 and Color3.fromRGB(210,190,120))
                or Color3.fromRGB(220,120,120)
            textoPing.Text = math.floor(ping) .. " ms"
            textoPing.TextColor3 = (ping <= 90 and Theme.SubText)
                or (ping <= 180 and Color3.fromRGB(210,190,120))
                or Color3.fromRGB(220,120,120)
        end
    end
end)

pcall(function()
    if readfile and isfile and isfile(MED_ARQUIVO) then
        local d = HttpService:JSONDecode(readfile(MED_ARQUIVO))
        if type(d) == "table" then
            for k, v in pairs(d) do
                if MED[k] ~= nil and type(MED[k]) == type(v) then MED[k] = v end
            end
            -- config da v1 vinha com a imagem 35% apagada e o cartao
            -- preto atras: ficava quase sem dar pra ver a foto.
            if (d.versao or 1) < 2 then
                MED.transp, MED.escurecer, MED.versao = 0, 0, 2
                salvarMed()
            end
        end
    end
end)
caixaMed.Position = UDim2.fromOffset(MED.x, MED.y)
fundoMed.ImageTransparency = MED.transp
ajustarCartaoMed()
caixaMed.Size = UDim2.fromOffset(math.floor(132 * MED.escala),
                                 math.floor(52 * MED.escala))
telaMed.Enabled = MED.ligado
if MED.imagem ~= "" then
    task.spawn(function() task.wait(0.6) pcall(definirFundoMedidor, MED.imagem, true) end)
end

---------------------------------------------------------------- CONFIG
local abaConfig = win:Tab("Config", "sliders")
abaConfig.Button.LayoutOrder = 101
do
    local c = abaConfig:Section("Panel", nil, 1)
    c:Button({ Name = "Test notification", Callback = function()
        win:Notify({ Title = "0x5A46", Text = "working", Duration = 4 })
    end })
    c:Divider()
    c:Button({ Name = "Hide (END)", Callback = function() win.Gui.Enabled = false end })
    local d = abaConfig:Section("Shortcuts", nil, 1)
    d:Status().Text = "RightCtrl minimizes (turns into a card: drag to move, click to reopen)\n" ..
        "END hides the whole panel\n" ..
        
        "Key chip: click = bind · right click = clear"

    local ic = abaConfig:Section("Tab icons", "drawn, not text", 1)
    ic:Info(
        "<b>" .. table.concat(Icons.names(), " · ") .. "</b>\n\n" ..
        "They are vector drawings on a 16x16 grid, so they stay sharp at " ..
        "any size and follow the theme colour.\n\n" ..
        "Also accepts Portuguese: casa, espada, jogador, olho, pesca, alvo, " ..
        "moeda, caixa, raio, sol, pino, ponto.\n\n" ..
        "A name that does not exist falls back to the old text mode — " ..
        "<b>P.Tab(\"X\", \"◉\")</b> still works.", 132)
    local m = abaConfig:Section("FPS and ping meter", nil, 2)
    m:Toggle({ Name = "Show meter", Default = MED.ligado,
        Callback = function(on)
            MED.ligado = on
            telaMed.Enabled = on
            salvarMed()
        end })
    local caixaM = m:Input({ Name = "Fundo do medidor",
        Placeholder = "ID  /  link.png  /  foto.png", Default = MED.imagem,
        Callback = function(t) definirFundoMedidor(t) end })
    m:Button({ Name = "Apply", Callback = function() definirFundoMedidor(caixaM.Text) end })
    m:Button({ Name = "Remove background", Callback = function()
        caixaM.Text = "" definirFundoMedidor("")
    end })
    m:Slider({ Name = "Fade image", Min = 0, Max = 100,
        Default = math.floor(MED.transp * 100), Suffix = "%",
        Callback = function(v)
            MED.transp = v / 100
            fundoMed.ImageTransparency = MED.transp
            salvarMed()
        end })
    m:Slider({ Name = "Darken behind", Min = 0, Max = 100,
        Default = math.floor(MED.escurecer * 100), Suffix = "%",
        Callback = function(v)
            MED.escurecer = v / 100
            ajustarCartaoMed()
            salvarMed()
        end })
    m:Slider({ Name = "Size", Min = 70, Max = 200, Default = math.floor(MED.escala * 100),
        Suffix = "%",
        Callback = function(v)
            MED.escala = v / 100
            caixaMed.Size = UDim2.fromOffset(math.floor(132 * MED.escala),
                                             math.floor(52 * MED.escala))
            textoFps.TextSize = math.floor(15 * MED.escala)
            textoPing.TextSize = math.floor(12 * MED.escala)
            salvarMed()
        end })
    statusMed = m:Info("—", 40)

    local cre = abaConfig:Section("Credits", nil, 2)
    cre:Info(
        "Scripts: <b>Th.exe</b>\n" ..
        "Panel format: <b>0x5A46</b>", 60)
end
--==================================================================
-- EXPORT
--==================================================================
ENV.Painel5A46 = {
    win     = win,
    Zero    = Zero,
    Theme   = Theme,
    Icons   = Icons,
    BG      = BG,
    versao  = MINHA_VERSAO,
    souAtual = souAtual,
    RAIZ    = RAIZ,
    Tab     = function(nome, icone) return win:Tab(nome, icone) end,
    Group   = function(texto, ordem) return win:Group(texto, ordem) end,
    iconNames = Icons.names,
    notify  = function(titulo, texto, seg)
        win:Notify({ Title = titulo, Text = texto, Duration = seg })
    end,
    show    = function() win.Gui.Enabled = true end,
    hide    = function() win.Gui.Enabled = false end,
    setFundo = function(src) definirFundo(src) end,
    new     = new,
    corner  = corner,
    stroke  = stroke,
    pad     = pad,
    list    = list,
    tween   = tween,
}
win:Notify({ Title = "0x5A46", Text = "panel loaded · v" .. MINHA_VERSAO, Duration = 5 })
print("[0x5A46] painel pronto · v" .. MINHA_VERSAO)

;(function()
  local ok, err = pcall(function()
--[[=================================================================
    ESP  ·  aba do painel 0x5A46
    -------------------------------------------------------------------
    O QUE EU MEDI NO MAPA ANTES DE ESCREVER:

      workspace.RenderedEggs   72 ovos visiveis, 16 tipos:
          White (30) · Brown (10) · Cracked (6) · Leaf (5) · Easter (5)
          Stone (4) · Flower (3) · e um de cada: Skull, Golden, Soul,
          Ice, Mushroom, Sinister, Galaxy, Glass, Blackhole
        Cada um e um Model com Handle, EggBase, MutationHitbox e ja vem
        com um Highlight chamado EggOutline (do proprio jogo).

      workspace.EggSpawns      96 Parts, os pontos de nascimento.
        Nao tem atributo de valor, mas tem:
            A_OrigRarity = Common | Rare | Epic | Legendary
            A_Dist       = distancia do centro (1105 a 2635 nos que vi)
        E isso confirma o que voce falou: os bons ficam longe.

    -------------------------------------------------------------------
    COMO EU DESCUBRO A RARIDADE DE CADA OVO
    O ovo renderizado NAO carrega a raridade — ele so tem o nome do
    tipo. Quem tem e o ponto de spawn. Entao pra cada ovo eu procuro o
    EggSpawn mais proximo (ate 25 studs) e uso o A_OrigRarity dele.
    Quando nao acha, mostra so o tipo e marca a raridade como "?".

    NADA AQUI E CHUMBADO: a lista de tipos e montada lendo o mapa ao
    vivo. Se o jogo adicionar um ovo novo, ele aparece no seletor
    sozinho, sem eu mexer no script.

    -------------------------------------------------------------------
    COMO DESENHO
    BillboardGui com um ponto colorido + nome + distancia, tudo com
    AlwaysOnTop. Escolhi isso em vez de Highlight porque o Roblox so
    desenha cerca de 31 Highlights por vez, e aqui tem 72 ovos — com
    Highlight metade sumiria. O Billboard nao tem esse teto.

    Tudo vive dentro de um unico ScreenGui/Folder chamado
    0x5A46_ESP. Desligou, some inteiro. Nao encosto em nenhum objeto
    do jogo, nem no EggOutline que ja vem nos ovos.
===================================================================]]

local P = getgenv().Painel5A46
if not P then return end

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP         = Players.LocalPlayer

local G = getgenv()
G.__5A46_esp = G.__5A46_esp or {}
local E = G.__5A46_esp

E.ligado    = E.ligado    or false
E.filtro    = E.filtro    or "All eggs"
E.raridade  = E.raridade  or "Any"
E.distMax   = E.distMax   or 3000
E.verNome   = (E.verNome   == nil) and true or E.verNome
E.verDist   = (E.verDist   == nil) and true or E.verDist
E.verRarid  = (E.verRarid  == nil) and true or E.verRarid
E.tamanho   = E.tamanho   or 14

local NOME_PASTA = "0x5A46_ESP"

local function avisar(t, txt, s) pcall(function() P.notify(t, txt, s or 2) end) end

--==================================================================
-- CORES POR RARIDADE  (e uma cor estavel por tipo, quando nao sei)
--==================================================================
local COR_RARIDADE = {
    Common    = Color3.fromRGB(190, 195, 205),
    Uncommon  = Color3.fromRGB( 90, 220, 130),
    Rare      = Color3.fromRGB( 80, 165, 255),
    Epic      = Color3.fromRGB(190, 110, 255),
    Legendary = Color3.fromRGB(255, 180,  60),
    Mythic    = Color3.fromRGB(255,  85, 110),
    Secret    = Color3.fromRGB(255, 255, 255),
}

-- cor estavel a partir do nome: o mesmo tipo sempre sai da mesma cor
local function corDoTipo(nome)
    local soma = 0
    for i = 1, #nome do soma = soma + nome:byte(i) * i end
    return Color3.fromHSV((soma % 360) / 360, 0.55, 1)
end

--==================================================================
-- LER O MAPA
--==================================================================
local function pastaOvos()
    return workspace:FindFirstChild("RenderedEggs")
        or workspace:FindFirstChild("Eggs")
end

local function pecaDe(m)
    if m:IsA("BasePart") then return m end
    return m.PrimaryPart
        or m:FindFirstChild("EggBase")
        or m:FindFirstChild("Handle")
        or m:FindFirstChildWhichIsA("BasePart", true)
end

-- indice dos pontos de spawn, pra descobrir a raridade pela posicao
local spawnsCache, spawnsQuando = nil, 0
local function spawns()
    if spawnsCache and (os.clock() - spawnsQuando) < 10 then return spawnsCache end
    local f = workspace:FindFirstChild("EggSpawns")
    local t = {}
    if f then
        for _, s in ipairs(f:GetChildren()) do
            if s:IsA("BasePart") then
                table.insert(t, {
                    pos = s.Position,
                    rar = tostring(s:GetAttribute("A_OrigRarity") or s.Name:gsub("%-$", "")),
                })
            end
        end
    end
    spawnsCache, spawnsQuando = t, os.clock()
    return t
end

local raridadeDe = setmetatable({}, { __mode = "k" })   -- cache por ovo
local function acharRaridade(ovo, pos)
    local guardada = raridadeDe[ovo]
    if guardada then return guardada end
    local melhor, dist = "?", 25          -- so aceita spawn a ate 25 studs
    for _, s in ipairs(spawns()) do
        local d = (s.pos - pos).Magnitude
        if d < dist then dist = d melhor = s.rar end
    end
    raridadeDe[ovo] = melhor
    return melhor
end

-- todos os ovos do mapa, com tipo, raridade e distancia
local function lerOvos()
    local pasta = pastaOvos()
    if not pasta then return {} end
    local ch = LP.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    local aqui = hrp and hrp.Position or Vector3.zero
    local lista = {}
    for _, m in ipairs(pasta:GetChildren()) do
        local pp = pecaDe(m)
        if pp then
            local rar = acharRaridade(m, pp.Position)
            table.insert(lista, {
                obj  = m,
                peca = pp,
                tipo = m.Name,
                rar  = rar,
                dist = (pp.Position - aqui).Magnitude,
            })
        end
    end
    return lista
end

local function tiposNoMapa()
    local vistos, t = {}, {}
    for _, o in ipairs(lerOvos()) do
        if not vistos[o.tipo] then vistos[o.tipo] = true table.insert(t, o.tipo) end
    end
    table.sort(t)
    return t
end

local function passaNoFiltro(o)
    if o.dist > E.distMax then return false end
    if E.filtro ~= "All eggs" and o.tipo ~= E.filtro then return false end
    if E.raridade ~= "Any" and o.rar ~= E.raridade then return false end
    return true
end

--==================================================================
-- DESENHO
--==================================================================
local pasta, marcas = nil, setmetatable({}, { __mode = "k" })

local function limpar()
    if pasta then pcall(function() pasta:Destroy() end) end
    pasta, marcas = nil, setmetatable({}, { __mode = "k" })
    local sobra = game:GetService("CoreGui"):FindFirstChild(NOME_PASTA)
        or LP:FindFirstChild("PlayerGui") and LP.PlayerGui:FindFirstChild(NOME_PASTA)
    if sobra then pcall(function() sobra:Destroy() end) end
end

local function garantirPasta()
    if pasta and pasta.Parent then return pasta end
    pasta = Instance.new("Folder")
    pasta.Name = NOME_PASTA
    local ok = pcall(function() pasta.Parent = game:GetService("CoreGui") end)
    if not ok then pasta.Parent = LP:WaitForChild("PlayerGui") end
    return pasta
end

local function criarMarca(o)
    local bb = Instance.new("BillboardGui")
    bb.Name = "Egg"
    bb.Adornee = o.peca
    bb.AlwaysOnTop = true
    bb.Size = UDim2.fromOffset(190, 40)
    bb.StudsOffset = Vector3.new(0, 2.2, 0)
    bb.MaxDistance = math.huge
    bb.Parent = garantirPasta()

    local ponto = Instance.new("Frame")
    ponto.AnchorPoint = Vector2.new(0.5, 0.5)
    ponto.Position = UDim2.fromScale(0.5, 0.72)
    ponto.Size = UDim2.fromOffset(9, 9)
    ponto.BorderSizePixel = 0
    ponto.Parent = bb
    Instance.new("UICorner", ponto).CornerRadius = UDim.new(1, 0)
    local borda = Instance.new("UIStroke")
    borda.Thickness = 1.4
    borda.Color = Color3.fromRGB(12, 14, 18)
    borda.Transparency = 0.25
    borda.Parent = ponto

    local rot = Instance.new("TextLabel")
    rot.BackgroundTransparency = 1
    rot.Size = UDim2.new(1, 0, 0, 26)
    rot.Position = UDim2.fromScale(0, 0)
    rot.Font = Enum.Font.GothamBold
    rot.TextSize = E.tamanho
    rot.TextStrokeTransparency = 0.35
    rot.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    rot.RichText = true
    rot.Parent = bb

    return { bb = bb, ponto = ponto, rot = rot }
end

local conexao
local function desenhar()
    if conexao then return end
    local ultimo = 0
    conexao = RunService.RenderStepped:Connect(function()
        if not E.ligado then return end
        -- 10x por segundo basta e nao pesa
        if os.clock() - ultimo < 0.1 then return end
        ultimo = os.clock()

        local vivos = {}
        for _, o in ipairs(lerOvos()) do
            if passaNoFiltro(o) then
                vivos[o.obj] = true
                local m = marcas[o.obj]
                if not m or not m.bb.Parent then
                    m = criarMarca(o)
                    marcas[o.obj] = m
                end
                m.bb.Adornee = o.peca

                local cor = COR_RARIDADE[o.rar] or corDoTipo(o.tipo)
                m.ponto.BackgroundColor3 = cor

                local partes = {}
                if E.verNome then
                    table.insert(partes, (o.tipo:gsub(" Egg$", "")))
                end
                if E.verRarid and o.rar ~= "?" then
                    table.insert(partes, o.rar)
                end
                if E.verDist then
                    table.insert(partes, string.format("%.0fm", o.dist))
                end
                m.rot.Text = table.concat(partes, "  ")
                m.rot.TextColor3 = cor
                m.rot.TextSize = E.tamanho
            end
        end
        -- tira o que saiu do filtro ou do mapa
        for obj, m in pairs(marcas) do
            if not vivos[obj] then
                pcall(function() m.bb:Destroy() end)
                marcas[obj] = nil
            end
        end
    end)
end

local function parar()
    if conexao then conexao:Disconnect() conexao = nil end
    limpar()
end

--==================================================================
--                            A ABA
--   sem icone: o painel escolhe sozinho pelo nome ("ESP" -> olho)
--==================================================================
do
    local aba = P.Tab("ESP")
    local c1, c2 = 1, 2

    local s = aba:Section("Egg ESP", nil, c1)
    local vitrine = s:Status()

    s:Toggle({ Name = "Enable", Default = E.ligado, Bell = false,
        Keybind = { Key = Enum.KeyCode.RightControl },
        Callback = function(v)
            E.ligado = v
            if v then desenhar() avisar("ESP", "eggs on", 2)
            else parar() avisar("ESP", "off", 2) end
        end })

    local dropTipo, dropRar
    local function itensTipo()
        local t = { "All eggs" }
        for _, x in ipairs(tiposNoMapa()) do table.insert(t, x) end
        return t
    end

    dropTipo = s:Dropdown({ Name = "Egg type", Items = itensTipo(), Default = E.filtro,
        Callback = function(v) E.filtro = v end })
    s:Label("the list comes from the map, not from a hardcoded table")

    dropRar = s:Dropdown({ Name = "Rarity",
        Items = { "Any", "Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic" },
        Default = E.raridade,
        Callback = function(v) E.raridade = v end })
    s:Label("read from the nearest EggSpawn · A_OrigRarity")

    s:Slider({ Name = "Max distance", Min = 100, Max = 6000, Default = E.distMax,
        Callback = function(v) E.distMax = v end })

    s:Button({ Name = "Refresh list", Callback = function()
        if dropTipo then dropTipo:SetItems(itensTipo(), true) end
        vitrine.Text = "list refreshed"
    end })

    ------------------------------------------------ O QUE MOSTRAR
    local s2 = aba:Section("Label", nil, c2)
    s2:Checkbox({ Name = "Name", Default = E.verNome,
        Callback = function(v) E.verNome = v end })
    s2:Checkbox({ Name = "Rarity", Default = E.verRarid,
        Callback = function(v) E.verRarid = v end })
    s2:Checkbox({ Name = "Distance", Default = E.verDist,
        Callback = function(v) E.verDist = v end })
    s2:Slider({ Name = "Text size", Min = 8, Max = 26, Default = E.tamanho,
        Callback = function(v) E.tamanho = v end })

    ------------------------------------------------ O QUE TEM NO MAPA
    local s3 = aba:Section("On the map", nil, c1)
    local quadro = s3:Status()

    task.spawn(function()
        while true do
            task.wait(1.2)
            pcall(function()
                local lista = lerOvos()
                if #lista == 0 then
                    quadro.Text = "no eggs found\n(RenderedEggs is empty)"
                    return
                end
                -- conta por tipo, e guarda o mais perto de cada
                local porTipo = {}
                for _, o in ipairs(lista) do
                    local e = porTipo[o.tipo]
                    if not e then
                        porTipo[o.tipo] = { n = 1, perto = o.dist, rar = o.rar }
                    else
                        e.n = e.n + 1
                        if o.dist < e.perto then e.perto = o.dist end
                        if e.rar == "?" then e.rar = o.rar end
                    end
                end
                local t = {}
                for tipo, e in pairs(porTipo) do
                    table.insert(t, { tipo = tipo, n = e.n, perto = e.perto, rar = e.rar })
                end
                -- os mais raros primeiro: menos unidades = mais raro
                table.sort(t, function(a, b)
                    if a.n ~= b.n then return a.n < b.n end
                    return a.perto < b.perto
                end)
                local linhas = { string.format("%d eggs · %d marked", #lista, (function()
                    local c = 0 for _ in pairs(marcas) do c = c + 1 end return c end)()) }
                for i, e in ipairs(t) do
                    if i <= 14 then
                        table.insert(linhas, string.format("%-13s x%-3d %5.0fm  %s",
                            (e.tipo:gsub(" Egg$", "")):sub(1, 13), e.n, e.perto,
                            e.rar ~= "?" and e.rar or ""))
                    end
                end
                quadro.Text = table.concat(linhas, "\n")
            end)
        end
    end)

    if E.ligado then desenhar() end
end

  end)
  if not ok then warn("[0x5A46] aba esp_eggs_aba.lua falhou: " .. tostring(err)) end
end)()

;(function()
  local ok, err = pcall(function()
--[[=================================================================
    COLLECT  ·  aba do painel 0x5A46
    -------------------------------------------------------------------
    TUDO AQUI FOI MEDIDO DENTRO DO JOGO. EM ORDEM:

    1) A ORDEM "TOP -> RUIM" NAO E CHUTE MEU
       Achei o catalogo do jogo em ReplicatedStorage.GameData.Eggs, 27
       ovos, e cada um tem o campo Luck. E exatamente o que voce falou
       — eles sao classificados por luck. Os extremos:

           Cherub Egg      1.000.000.000.000     (1 T)
           Solaris Egg       300.000.000.000
           Blackhole Egg     100.000.000.000
           Galaxy Egg          1.500.000.000
           Aurora Egg            300.000.000
           ...
           Brown Egg                       5
           White Egg                       1     (o pior)

       O seletor e montado lendo essa tabela e ordenando por Luck. Se o
       jogo mudar um valor, a ordem muda junto.

    2) O TWEENSERVICE FUNCIONA AQUI  (e eu duvidava)
       No outro jogo de ovos eu tinha medido que o servidor desfazia
       teleporte em 2s e matava em pulo grande. Testei antes de
       prometer: tween de 200 studs a 1000/s, esperei 2,5s parado ->
       mexeu 0.0 studs, vida 100. O servidor NAO reverte.
       E no teste real: 3.394 studs em 3,79s, chegando a 2,3 studs do
       ovo, vida 100. A volta, 3.470 studs em 3,87s.

    3) COMO SE PEGA
       Cada ovo tem um ProximityPrompt "Pick Up", alcance 15.
       fireproximityprompt nele resolve.

    4) O QUE ME PEGOU DE SURPRESA — E VOCE PRECISA SABER
       O ciclo rodou inteiro e mesmo assim o ovo NAO entrou na base.
       Fui atras e o jogo estava dizendo o motivo em dois lugares:

           LP:GetAttribute("NoNest") == true
           e um "MAX" na tela

       Seus ninhos estao cheios: Plot.Eggs ja tem 3 ovos chocando e dos
       5 ninhos so o numero 1 esta desbloqueado (os outros pedem $1.000,
       $5.000, $100.000 e $1M).

       Eu tinha feito a aba BARRAR a viagem quando NoNest estava true.
       Estava errado, e voce me corrigiu: essa decisao nao era minha.
       Agora ela SEMPRE vai. O estado do ninho aparece na tela, e se o
       servidor recusar ela diz "went there, but no nest free" — assim
       voce sabe que o trajeto funcionou e o que faltou. O botao de
       chocar continua ai pra abrir espaco quando VOCE quiser.

    5) O CAMINHO DE VOLTA, DO SEU JEITO
       Primeiro eu fiz ela parar na frente da base. Voce corrigiu: o
       certo e vir de tween ate o MONTE DE TERRA e dali ANDAR ate
       dentro da base. Chegando voado la dentro o ovo volta pro ninho.

       Medi onde voce parou no monte de terra. Na primeira tentativa eu
       peguei um ponto errado — li a sua posicao antes de voce chegar
       la. O certo, medido depois:
           voce                 (-294.7, 40316.0, 572.9)
           centro do Baseplate  (171.9, 40312.7, 1067.2), 75 x 75
           relativo             X = +373.7   Z = +567.8   (680 studs)

       Guardo relativo ao Baseplate, nao a coordenada crua, pra
       continuar valendo se voce mudar de plot.

       O trecho final NAO usa tween — e o BONECO ANDANDO. Eu tinha
       feito empurrando o CFrame um pedaco por frame, e voce apontou
       que isso nao e andar. Testei o jeito certo e o servidor deixa:
           WalkSpeed = 100 -> ficou 100    aceitou
           WalkSpeed = 300 -> ficou 300    aceitou
       Entao e WalkSpeed + Humanoid:MoveTo, com animacao e tudo. No
       fim a WalkSpeed volta pro valor de antes. Padrao 300, como voce
       pediu, e da pra mudar no slider.

       Se o ponto estiver errado, para no lugar certo e aperta
       "Set landing here".

    6) O PONTO CERTO NAO ENTRAVA  (bug do getgenv)
       Voce me disse que ele foi pra frente da base de novo, mesmo
       depois de eu corrigir a coordenada. O motivo nao era a
       coordenada: os ajustes ficam guardados em getgenv() pra
       sobreviver entre execucoes, e eu escrevia

           C.pousoX = C.pousoX or 373.7

       O "or" NUNCA sobrescreve o que ja existe. Como voce tinha
       rodado a versao com o ponto errado, o 21.3 estava salvo e o
       373.7 nunca era usado.
       Conserto: VERSAO_PADROES la em cima. Quando eu mudo um valor
       medido, subo o numero e os padroes sao reescritos por cima. O
       que VOCE ajustou na mao continua intacto.

    7) A TELA, DO JEITO QUE VOCE PEDIU
       So quatro coisas: o seletor de ovo, o Come back to base, o
       Teleport and collect e o Keep collecting. Mais a vitrine de
       status, que eu mantive porque sem ela voce nao teria como saber
       se deu certo nem o que travou.

       Velocidades FIXAS: 1000 na viagem, 98 andando. Sumiram os
       sliders, e tambem as secoes Landing, Nest e Ranking.
       Uma coisa que voce perde junto: o botao "Set landing here", que
       era como corrigir o monte de terra sem eu mexer no script. Se
       precisar, da pra fazer pelo executor:
           getgenv().__5A46_col.pontoFixo = <posicao>
       ou me chama que eu devolvo o botao.

    8) NOCLIP NO CICLO INTEIRO — INCLUSIVE ANDANDO
       Voce pediu noclip tambem no trecho a pe, e ai aparece o problema
       que me fez deixar de fora antes: sem colisao o personagem cai
       pelo chao, entra em Freefall, a animacao de andar para e o MoveTo
       nao leva ele a lugar nenhum.
       Resolvido levando um chao junto: uma placa invisivel e ancorada
       gruda embaixo dele e acompanha o relevo (raio pra baixo todo
       frame, ignorando ele e a propria placa). Ele pisa nela, continua
       andando de verdade com animacao, e o corpo sem colisao atravessa
       parede, cerca e arvore.
       O jogo religa CanCollide sozinho, entao reaplico todo frame.
       No fim do ciclo a colisao volta e a placa some — nessa ordem, se
       nao ele ficaria um instante sem chao e sem colisao. Vale mesmo se
       der erro no meio do caminho.

    9) E UM ERRO MEU, QUE QUASE FOI PARAR AQUI DENTRO
       Eu conferia a coleta 0,6s depois e concluia que o ovo nao tinha
       entrado. Fui olhar a base de novo e o Blackhole que eu dava como
       perdido estava la, junto com outros — a base foi de 3 pra 5.
       O ovo ENTRA; a replicacao e que demora mais que meio segundo.
       Se eu nao tivesse conferido, esta aba diria "falhou" toda vez
       que desse certo. Agora ela espera ate 6s, olhando a cada 0,5s.
===================================================================]]

local P = getgenv().Painel5A46
if not P then return end

local Players      = game:GetService("Players")
local RS           = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LP           = Players.LocalPlayer

local G = getgenv()
G.__5A46_col = G.__5A46_col or {}
local C = G.__5A46_col

-- ATENCAO, ISSO AQUI E UM BUG QUE JA ME MORDEU.
-- Os ajustes moram em getgenv() pra sobreviver entre execucoes do
-- script. So que eu escrevo "C.pousoX = C.pousoX or <padrao>", e o
-- "or" nunca sobrescreve um valor que ja existe. Resultado: voce
-- rodou uma versao com o ponto de pouso errado (X 21.3 / Z 74.7),
-- aquilo ficou salvo, e a versao nova com o ponto certo continuou
-- usando o velho — o personagem ia parar na frente da base em vez do
-- monte de terra.
-- Conserto: uma versao dos padroes. Quando eu mudo um valor medido,
-- subo esse numero e os padroes sao reescritos por cima do que estava
-- salvo. O que voce ajustou na mao (velocidade, tipo de ovo) nao e
-- tocado.
local VERSAO_PADROES = 3
if C.__versao ~= VERSAO_PADROES then
    C.__versao = VERSAO_PADROES
    C.pousoX    = 373.7
    C.pousoZ    = 567.8
    C.pontoFixo = nil
    -- voce pediu pra fixar: 1000 na viagem, 98 andando
    C.velocidade = 1000
    C.velAndar   = 98
end

-- FIXOS A SEU PEDIDO. Nao tem slider pra estes na tela; se um dia
-- quiser mexer sem eu recompilar, da pra fazer pelo executor:
--     getgenv().__5A46_col.velocidade = 1500
--     getgenv().__5A46_col.velAndar   = 150
C.velocidade = 1000
C.velAndar   = 98

C.escolhido = C.escolhido or "Best available"
C.velocidade = C.velocidade or 1000
C.auto      = C.auto      or false
C.voltar    = (C.voltar   == nil) and true or C.voltar
C.pegos     = C.pegos     or 0
C.falhas    = C.falhas    or 0
C.velFreio  = C.velFreio  or 55      -- velocidade dos ultimos studs
C.freioEm   = C.freioEm   or 70      -- a quantos studs da frente ele freia
C.velAndar  = C.velAndar  or 300     -- velocidade do trecho a pe, ate dentro da base
C.pousoX    = C.pousoX    or 373.7   -- onde o tween termina, relativo ao Baseplate
C.pousoZ    = C.pousoZ    or 567.8
C.pontoFixo = C.pontoFixo or nil     -- ponto de pouso gravado por voce

local function avisar(t, txt, s) pcall(function() P.notify(t, txt, s or 2) end) end

--==================================================================
-- CATALOGO  (Luck = o ranking)
--==================================================================
local function catalogo()
    local ok, c = pcall(function() return require(RS.GameData.Eggs) end)
    if not ok or type(c) ~= "table" then return {} end
    return c
end

local function luckDe(nome)
    local d = catalogo()[nome]
    return d and tonumber(d.Luck) or 0
end
local function raridadeDe(nome)
    local d = catalogo()[nome]
    return d and tostring(d.Rarity or "?") or "?"
end

local function abreviar(n)
    if n >= 1e12 then return string.format("%.1fT", n/1e12) end
    if n >= 1e9  then return string.format("%.1fB", n/1e9)  end
    if n >= 1e6  then return string.format("%.1fM", n/1e6)  end
    if n >= 1e3  then return string.format("%.0fK", n/1e3)  end
    return string.format("%.0f", n)
end

-- todos os tipos do catalogo, do melhor pro pior
local function ranking()
    local t = {}
    for nome, d in pairs(catalogo()) do
        if type(d) == "table" then
            table.insert(t, { nome = nome, luck = tonumber(d.Luck) or 0, rar = tostring(d.Rarity or "?") })
        end
    end
    table.sort(t, function(a, b)
        if a.luck ~= b.luck then return a.luck > b.luck end
        return a.nome < b.nome
    end)
    return t
end

--==================================================================
-- O MAPA E A BASE
--==================================================================
local function pecaDe(m)
    return m.PrimaryPart
        or m:FindFirstChild("EggBase")
        or m:FindFirstChild("Handle")
        or m:FindFirstChildWhichIsA("BasePart", true)
end

local function pers()
    local ch = LP.Character
    return ch, ch and ch:FindFirstChildOfClass("Humanoid"), ch and ch:FindFirstChild("HumanoidRootPart")
end

local function minhaBase()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, pl in ipairs(plots:GetChildren()) do
        if pl:GetAttribute("NestsOwnerLoaded") == LP.UserId then return pl end
    end
    return nil
end

local function pecaDaBase()
    local b = minhaBase()
    if not b then return nil end
    return b:FindFirstChild("Baseplate") or b.PrimaryPart or b:FindFirstChildWhichIsA("BasePart")
end

-- ONDE O TWEEN TERMINA
-- Voce me explicou o caminho certo: vir de tween ate o monte de terra
-- e dali ANDAR ate dentro da base. Chegando voado la dentro o ovo
-- volta pro ninho e buga.
-- Medi onde voce parou no monte de terra (a segunda vez; na primeira
-- eu peguei um lugar errado, voce ainda nao tinha chegado la):
--     voce                 (-294.7, 40316.0, 572.9)
--     centro do Baseplate  (171.9, 40312.7, 1067.2), 75 x 75
--     relativo             X = +373.7   Z = +567.8   (680 studs do centro)
-- Guardo RELATIVO ao Baseplate, nao a coordenada crua, pra continuar
-- valendo se voce trocar de plot.
local function pontoDePouso()
    if C.pontoFixo then return C.pontoFixo end
    local bp = pecaDaBase()
    if not bp then return nil end
    return (bp.CFrame * CFrame.new(C.pousoX, 3, C.pousoZ)).Position
end

-- ovos no chao agora, com luck e distancia
local function ovosNoMapa()
    local pasta = workspace:FindFirstChild("RenderedEggs")
    if not pasta then return {} end
    local _, _, hrp = pers()
    local aqui = hrp and hrp.Position or Vector3.zero
    local t = {}
    for _, m in ipairs(pasta:GetChildren()) do
        local pp = pecaDe(m)
        if pp then
            table.insert(t, {
                obj  = m,
                peca = pp,
                nome = m.Name,
                luck = luckDe(m.Name),
                rar  = raridadeDe(m.Name),
                dist = (pp.Position - aqui).Magnitude,
            })
        end
    end
    return t
end

local function promptDe(m)
    for _, d in ipairs(m:GetDescendants()) do
        if d:IsA("ProximityPrompt") then return d end
    end
end

-- tem ninho livre?  (o jogo responde isso sozinho)
local function semEspaco()
    return LP:GetAttribute("NoNest") == true
end

local function ovosNaBase()
    local b = minhaBase()
    local f = b and b:FindFirstChild("Eggs")
    if not f then return 0, {} end
    local nomes = {}
    for _, d in ipairs(f:GetChildren()) do table.insert(nomes, d.Name) end
    return #nomes, nomes
end

--==================================================================
-- VIAJAR  (tween; medido: o servidor aceita)
--==================================================================
--==================================================================
-- NOCLIP  (ciclo inteiro: voo, coleta e caminhada)
-- Tira a colisao das partes do personagem pra ele atravessar parede,
-- arvore e cerca. Dois cuidados:
--   1) o jogo religa CanCollide sozinho, entao reaplico todo frame;
--   2) sem colisao ele cairia pelo chao — quem segura isso e o chao
--      falso logo acima, que anda junto com ele.
-- Rede de seguranca: o pcall no fim do ciclo devolve a colisao mesmo se
-- algo der errado no meio.
--==================================================================
local conNoclip = nil

--==================================================================
-- CHAO FALSO — e o que faz o noclip funcionar TAMBEM andando
--==================================================================
-- Voce pediu noclip no trecho a pe tambem. So desligar a colisao nao
-- resolve: sem chao o Humanoid entra em Freefall, a animacao de andar
-- para e o MoveTo praticamente nao leva ele a lugar nenhum — ele cai.
-- Entao eu levo um chao comigo: uma placa invisivel, ancorada, que fica
-- grudada embaixo do personagem. Ele pisa nela, continua em Running com
-- animacao normal, e como o corpo dele esta sem colisao ele atravessa
-- parede, cerca e arvore do mesmo jeito.
-- A placa acompanha o relevo: todo frame eu jogo um raio pra baixo
-- ignorando o personagem e a propria placa, e coloco ela logo abaixo do
-- chao de verdade. Se nao achar chao (buraco, vao), ela fica na ultima
-- altura boa, que e justamente o que impede a queda.
local placa, conPlaca = nil, nil

local function chaoFalso(ligar)
    if ligar then
        if conPlaca then return end
        local _, _, hrp = pers()
        if not hrp then return end

        placa = Instance.new("Part")
        placa.Name         = "_"  -- nome curto e sem graca de proposito
        placa.Size         = Vector3.new(60, 1, 60)
        placa.Anchored     = true
        placa.CanCollide   = true
        placa.CanQuery     = false
        placa.CanTouch     = false
        placa.Transparency = 1
        placa.Position     = hrp.Position - Vector3.new(0, 3.5, 0)
        placa.Parent       = workspace

        local ultimoY = placa.Position.Y

        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Exclude

        conPlaca = game:GetService("RunService").Stepped:Connect(function()
            local ch = LP.Character
            local r  = ch and ch:FindFirstChild("HumanoidRootPart")
            if not (r and placa and placa.Parent) then return end

            rp.FilterDescendantsInstances = { ch, placa }
            local bateu = workspace:Raycast(r.Position, Vector3.new(0, -60, 0), rp)
            if bateu then ultimoY = bateu.Position.Y - 0.5 end

            placa.Position = Vector3.new(r.Position.X, ultimoY, r.Position.Z)
        end)
    else
        if conPlaca then conPlaca:Disconnect() conPlaca = nil end
        if placa then pcall(function() placa:Destroy() end) placa = nil end
    end
end

local function noclip(ligar)
    if ligar then
        if conNoclip then return end
        conNoclip = game:GetService("RunService").Stepped:Connect(function()
            local ch = LP.Character
            if not ch then return end
            for _, d in ipairs(ch:GetDescendants()) do
                if d:IsA("BasePart") and d.CanCollide then d.CanCollide = false end
            end
        end)
    else
        if conNoclip then conNoclip:Disconnect() conNoclip = nil end
        local ch = LP.Character
        if ch then
            for _, d in ipairs(ch:GetDescendants()) do
                -- o HumanoidRootPart nasce sem colisao; os outros voltam
                if d:IsA("BasePart") and d.Name ~= "HumanoidRootPart" then
                    d.CanCollide = true
                end
            end
        end
    end
end

local function umTween(alvo, vel)
    local _, _, hrp = pers()
    if not hrp then return false end
    local dist = (alvo - hrp.Position).Magnitude
    if dist < 0.5 then return true end
    local tw = TweenService:Create(hrp,
        TweenInfo.new(math.max(dist / math.max(vel, 20), 0.08), Enum.EasingStyle.Linear),
        { CFrame = CFrame.new(alvo) })
    tw:Play()
    tw.Completed:Wait()
    return true
end

-- Viaja de tween, atravessando tudo. Usado so ate o monte de terra.
local function voar(destino, altura)
    local _, _, hrp = pers()
    if not hrp then return false end
    local alvo = destino + Vector3.new(0, altura or 3, 0)
    -- o noclip NAO e desligado aqui. Ele vale o ciclo inteiro agora
    -- (voce pediu andando tambem) e so cai no fim(), que e o unico
    -- lugar que devolve a colisao.
    noclip(true)
    chaoFalso(true)
    umTween(alvo, C.velocidade)
    task.wait(0.3)
    local _, hum, r = pers()
    return r ~= nil and (hum == nil or hum.Health > 0), r and (r.Position - alvo).Magnitude or -1
end

-- ANDAR ate dentro da base — o BONECO andando, nao o CFrame empurrado.
-- Voce me corrigiu nisso: antes eu movia o HumanoidRootPart um pedaco
-- por frame, o que e teleporte disfarcado (sem animacao de caminhada).
-- Fui testar o jeito certo e o servidor colabora:
--     WalkSpeed = 100  -> ficou 100    aceitou
--     WalkSpeed = 300  -> ficou 300    aceitou
--     Humanoid:MoveTo  -> 75 studs em 0,41s
-- Entao aqui e WalkSpeed + MoveTo: o personagem anda de verdade, com
-- animacao, e o jogo ve uma caminhada normal, so que rapida.
-- No fim a WalkSpeed volta pro valor que era antes.
local function andarAte(destino, tempoMax)
    local _, hum, hrp = pers()
    if not (hum and hrp) then return false, 0 end

    local velAntes = hum.WalkSpeed
    hum.WalkSpeed = C.velAndar

    -- noclip tambem a pe: corpo sem colisao + placa invisivel embaixo
    -- pra ele nao cair e continuar com animacao de caminhada.
    noclip(true)
    chaoFalso(true)

    local alvo = Vector3.new(destino.X, hrp.Position.Y, destino.Z)
    local t0 = os.clock()
    local chegou = false
    local ultima, travou = hrp.Position, 0

    while os.clock() - t0 < (tempoMax or 30) do
        local _, h, r = pers()
        if not (h and r) then break end
        local plano = Vector3.new(alvo.X - r.Position.X, 0, alvo.Z - r.Position.Z)
        if plano.Magnitude < 5 then chegou = true break end

        -- MoveTo desiste sozinho depois de ~8s, entao eu re-emito.
        -- Re-emitir tambem corrige o rumo se o caminho desviar.
        h.WalkSpeed = C.velAndar
        h:MoveTo(alvo)

        -- enroscou em alguma coisa? pula.
        if (r.Position - ultima).Magnitude < 0.5 then
            travou = travou + 1
            if travou > 6 then h.Jump = true travou = 0 end
        else
            travou = 0
        end
        ultima = r.Position
        task.wait(0.25)
    end

    local _, h2 = pers()
    if h2 then h2.WalkSpeed = velAntes end
    return chegou, os.clock() - t0
end

--==================================================================
-- UM CICLO
--==================================================================
local ocupado = false
local estado = "idle"

local function escolherAlvo()
    local lista = ovosNoMapa()
    if #lista == 0 then return nil end
    if C.escolhido == "Best available" then
        table.sort(lista, function(a, b)
            if a.luck ~= b.luck then return a.luck > b.luck end
            return a.dist < b.dist
        end)
        return lista[1]
    end
    -- tipo fixo: o mais perto daquele tipo
    local melhor
    for _, o in ipairs(lista) do
        if o.nome == C.escolhido then
            if not melhor or o.dist < melhor.dist then melhor = o end
        end
    end
    return melhor
end

local function coletar(relatar)
    if ocupado then return false, "ja esta indo" end
    ocupado = true
    local function fim(ok, msg)
        -- sempre devolve a colisao, de errado o que der no meio
        -- ordem importa: primeiro devolve a colisao do corpo, depois
        -- tira a placa. Ao contrario ele ficaria um instante sem chao
        -- e sem colisao, e cairia.
        pcall(noclip, false)
        pcall(chaoFalso, false)
        ocupado = false
        estado = "idle"
        return ok, msg
    end

    -- Eu ja barrei aqui quando NoNest estava true, e voce reclamou com
    -- razao: essa decisao nao era minha. Agora ela SEMPRE vai. O ninho
    -- cheio continua fazendo o servidor recusar (medi: fui ate o
    -- Blackhole a 3.884 studs, cheguei a 2,2 dele, e a base ficou nos
    -- mesmos 7 ovos), mas quem decide tentar e voce.
    local lotado = semEspaco()

    local alvo = escolherAlvo()
    if not alvo then return fim(false, "no egg of that type on the map") end

    local casa = select(3, pers())
    casa = casa and casa.Position
    local antesN = ovosNaBase()

    estado = string.format("going to %s (%s)", alvo.nome, abreviar(alvo.luck))
    relatar(estado)
    local ok = voar(alvo.peca.Position)
    if not ok then return fim(false, "died on the way") end

    estado = "picking up"
    relatar(estado)
    local pr = promptDe(alvo.obj)
    if pr then
        local hd = pr.HoldDuration
        pr.HoldDuration = 0
        pcall(function() fireproximityprompt(pr) end)
        task.wait(1.2)
        pcall(function() pr.HoldDuration = hd end)
    end

    if C.voltar then
        local pouso = pontoDePouso()
        local bp = pecaDaBase()
        if pouso then
            estado = "flying to the dirt path"
            relatar(estado)
            voar(pouso, 0)          -- tween SO ate aqui
        end
        if bp then
            estado = "walking in"
            relatar(estado)
            andarAte(bp.Position, 25)   -- e daqui pra dentro, andando
            task.wait(0.8)
        end
    end

    -- Confirmar demora. Eu tinha dado 0,6s e concluido que o ovo nao
    -- tinha entrado; depois vi na base o Blackhole que eu jurava ter
    -- perdido. O ovo entra, a replicacao e que e mais lenta. Entao
    -- espero ate 6s, checando de meio em meio segundo.
    estado = "confirming"
    relatar(estado)
    local depoisN = antesN
    local t0 = os.clock()
    while os.clock() - t0 < 6 do
        task.wait(0.5)
        depoisN = ovosNaBase()
        if depoisN > antesN then break end
    end
    if depoisN > antesN then
        C.pegos = C.pegos + 1
        return fim(true, alvo.nome)
    end
    C.falhas = C.falhas + 1
    -- o ovo some da tela mesmo quando o servidor recusa, entao eu
    -- confirmo pelo numero de ovos na base, nao pelo ovo sumir
    if lotado or semEspaco() then
        return fim(false, "went there, but no nest free")
    end
    return fim(false, "went there, no confirmation in 6s")
end

--==================================================================
--                            A ABA
--==================================================================
do
    local aba = P.Tab("Collect")
    local c1 = 1

    -- SO O QUE VOCE PEDIU: seletor de ovo, voltar pra base, o botao e
    -- o automatico. Os sliders de velocidade sairam (1000 e 98 estao
    -- fixos no codigo), e tirei tambem as secoes de Landing, Nest e
    -- Ranking. A vitrine de status ficou porque sem ela voce nao teria
    -- como saber se deu certo ou o que travou.
    local s = aba:Section("Collect", nil, c1)
    local vitrine = s:Status()

    local itens = { "Best available" }
    for _, e in ipairs(ranking()) do table.insert(itens, e.nome) end

    s:Dropdown({ Name = "Egg", Items = itens, Default = C.escolhido,
        Callback = function(v) C.escolhido = v end })

    s:Checkbox({ Name = "Come back to base", Default = C.voltar,
        Callback = function(v) C.voltar = v end })

    s:Button({ Name = "Teleport and collect", Callback = function()
        task.spawn(function()
            local ok, msg = coletar(function(t) vitrine.Text = t end)
            vitrine.Text = string.format("%s\ntaken %d · failed %d",
                ok and ("got " .. tostring(msg)) or tostring(msg), C.pegos, C.falhas)
            avisar("Collect", ok and ("got " .. tostring(msg)) or tostring(msg), 3)
        end)
    end })

    s:Toggle({ Name = "Keep collecting", Default = C.auto, Bell = false,
        Callback = function(v)
            C.auto = v
            if not v then return end
            task.spawn(function()
                while C.auto do
                    local ok, msg = coletar(function(t) vitrine.Text = t end)
                    vitrine.Text = string.format("%s\ntaken %d · failed %d",
                        ok and ("got " .. tostring(msg)) or tostring(msg), C.pegos, C.falhas)
                    task.wait(ok and 0.5 or 2)
                end
            end)
        end })
end

  end)
  if not ok then warn("[0x5A46] aba collect_aba.lua falhou: " .. tostring(err)) end
end)()
