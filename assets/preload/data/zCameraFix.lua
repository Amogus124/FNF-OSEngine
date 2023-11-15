--i cant believe it works in this version of pe!!!!
--[[
	It's basically my (raltyro) modchart template that does cool cameras stuff
	but only the cameras
	
	doesnt support shake different axes, sorry, linc_luajit doesnt support haxe enums
	
	IM SORRY BUT IT HAD TO BE AN CUSTOM EVENT SCRIPT
	BECAUSE CUSTOM EVENT SCRIPT COMES LAST TO UPDATE
	xoxo raltyro uwu
--]]

-- if you want to setting the camera stuff like shake. you can do it here
local config = {
	betterShake = true,
	betterShakeHardness = .5, -- from 0 to 1
	betterShakeFadeTime = .15,
	useScrollForShake = true
}


------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
----------------------------------------- NO TOUCH :< ------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
local clock = 0

-- LUA 5.3 FUNCTIONS
function table.find(table,v)
	for i,v2 in next,table do
		if v2 == v then
			return i
		end
	end
end

function table.clear(t)
	while #t ~= 0 do rawset(t, #t, nil) end
end

function math.clamp(x,min,max)return math.max(min,math.min(x,max))end

-- INITIAL FUNCTIONS
local tableCopy
function tableCopy(t,st,copyMeta,x)
	if (copyMeta == nil) then copyMeta = true end
	x = x or 0
	getfenv().things = getfenv().things or {}
	local things = getfenv().things
	if (things[t] ~= nil) then return things[t] end

	st = st or {}
	
	things[t] = st
	
	for i,v in pairs(t) do
		st[i] = type(v) == "table" and tableCopy(v,{},copyMeta,x + 1) or v
	end
	if (x <= 0) then getfenv().things = {} end
	
	if (copyMeta) then
		local meta = getmetatable(t)
		if (type(meta) == "table") then
			setmetatable(st, meta)
		end
	end
	
	return st
end

local function strthing(s,i)
	local str = ""
	for i = 1,i do
		str = str .. s
	end
	return str
end

function mathlerp(from,to,i)return from+(to-from)*i end

local isDead = false
function dead()
	return isDead or getProperty("isDead")
end

-- POINT FUNCTIONS
if (type(point) ~= "table" or point.userdata ~= "point") then
	point = {userdata = "point"}
	point.__index = point

	function point.new(x, y)
		return point.set(setmetatable({}, point), x, y)
	end

	function point.set(p, x, y)
		p.x = x or 0
		p.y = y or 0
		
		return p
	end
	
	function point.add(p, x, y)
		p.x = p.x + (x or 0)
		p.y = p.y + (y or 0)
		
		return p
	end
end

-- MATRIX FUNCTIONS
if (type(matrix) ~= "table" or matrix.userdata ~= "matrix") then
	matrix = {userdata = "matrix"}
	matrix.__index = matrix

	function matrix.new(a, b, c, d, tx, ty)
		return matrix.setTo(setmetatable({}, matrix), a, b, c, d, tx, ty)
	end
	
	function matrix.setTo(mat, a, b, c, d, tx, ty)
		mat.a = a or 1
		mat.b = b or 0
		mat.c = c or 0
		mat.d = d or 1
		mat.tx = tx or 0
		mat.ty = ty or 0
		
		return mat
	end

	function matrix.identity(mat)
		return matrix.setTo(mat)
	end

	function matrix.translate(mat, x, y)
		mat.tx, mat.ty = mat.tx + (x or 0), mat.ty + (y or 0)
		return mat
	end

	function matrix.scale(mat, sx, sy)
		sx = sx or 0
		sy = sy or 0
		
		mat.a = mat.a * sx
		mat.b = mat.b * sy
		mat.c = mat.c * sx
		mat.d = mat.d * sy
		mat.tx = mat.tx * sx
		mat.ty = mat.ty * sy
		
		return mat
	end

	function matrix.concat(mat, a, b, c, d, tx, ty)
		if (type(a) == "table") then
			return matrix.concat(mat, a.a, a.b, a.c, a.d, a.tx, a.ty)
		end
		
		local a1 = mat.a * a + mat.b * c
		mat.b = mat.a * b + mat.b * d
		mat.a = a1

		local c1 = mat.c * a + mat.d * c
		mat.d = mat.c * b + mat.d * d
		mat.c = c1

		local tx1 = mat.tx * a + mat.ty * c + tx
		mat.ty = mat.tx * b + mat.ty * d + ty
		mat.tx = tx1
		
		return mat
	end

	function matrix.rotate(mat, theta)
		local rad = math.rad(theta or 0)
		local rotCos, rotSin = math.cos(rad), math.sin(rad)
		
		local a1 = mat.a * rotCos - mat.b * rotSin
		mat.b = mat.a * rotSin + mat.b * rotCos
		mat.a = a1
		
		local c1 = mat.c * rotCos - mat.d * rotSin
		mat.d = mat.c * rotSin + mat.d * rotCos
		mat.c = c1
		
		local tx1 = mat.tx * rotCos - mat.ty * rotSin
		mat.ty = mat.tx * rotSin + mat.ty * rotCos
		mat.tx = tx1
		
		return mat
	end

	function matrix.skew(mat, x, y)
		local skb, skc = math.tan(math.rad(y or 0)), math.tan(math.rad(x or 0))
		
		mat.b = mat.a * skb + mat.b
		mat.c = mat.c + mat.d * skc
		
		mat.ty = mat.tx * skb + mat.ty
		mat.tx = mat.tx + mat.ty * skc
		
		return mat
	end
end

---------------------------------

local templateCam = {
	zoom = 1,
	
	visible = true,
	
	width = 1280,
	height = 720,
	
	scale = point.new(1, 1),
	
	spriteScale = point.new(1, 1),
	
	x = 0,
	y = 0,
	
	anchorPoint = point.new(.5, .5),
	offset = point.new(),
	
	-- Just incase if you want to mess around
	skew = point.new(),
	clipSkew = point.new(),
	
	transform = matrix.new(),
	_matrix = matrix.new(),
	
	viewOffset = point.new(),
	
	angle = 0,
	
	scrollOffset = point.new(),
	_lastScrollOffset = point.new(),
	
	ignoreScaleMode = false,
	
	fxShakeIntensity = 0,
	fxShakeDuration = -1000,
	fxShakeI = -999999
}

local defaultCams

local cams = {
	isReady = false,
	
	hud = tableCopy(templateCam),
	other = tableCopy(templateCam),
	game = tableCopy(templateCam)
}

function initializeCams()
	local function cam(t, cam, class)
		t.getProperty = type(class) == "string" and function(v)return getPropertyFromClass(class, cam .. "." .. v)end or
			function(v)return getProperty(cam .. "." .. v)end
		t.setProperty = type(class) == "string" and function(v, x)return setPropertyFromClass(class, cam .. "." .. v, x)end or
			function(v, x)return setProperty(cam .. "." .. v, x)end
		local getProperty = t.getProperty
		
		t.class = class
		t.cam = cam
	end
	
	cam(cams.hud, "camHUD")
	cam(cams.other, "camOther")
	cam(cams.game, "camera", "flixel.FlxG")
	
	cams.isReady = true
	
	defaultCams = tableCopy(cams)
end

function updateCam(t, dt)
	if (not cams.isReady) then return end
	
	local scaleModeX = t.ignoreScaleMode and 1 or getPropertyFromClass("flixel.FlxG", "scaleMode.scale.x")
	local scaleModeY = t.ignoreScaleMode and 1 or getPropertyFromClass("flixel.FlxG", "scaleMode.scale.y")
	local initialZoom = t.getProperty("initialZoom")
	
	local x = t.getProperty("x")
	local y = t.getProperty("y")
	
	t.zoom = t.getProperty("zoom")
	t.angle = t.getProperty("angle")
	t.width = t.getProperty("width")
	t.height = t.getProperty("height")
	
	local cool = (config.betterShake and -config.betterShakeFadeTime or 0)
	
	t.fxShakeDuration = t.fxShakeDuration > cool and t.fxShakeDuration - dt or cool
	
	local _fxShakeIntensity = t.getProperty("_fxShakeIntensity")
	local _fxShakeDuration = t.getProperty("_fxShakeDuration")
	if (_fxShakeIntensity > 0 and _fxShakeDuration > 0) then
		t.fxShakeIntensity = _fxShakeIntensity
		t.fxShakeDuration = _fxShakeDuration
		
		t.setProperty("_fxShakeIntensity", 0)
	end
	
	t.scale.x = t.getProperty("scaleX")
	t.scale.y = t.getProperty("scaleY")
	
	t.viewOffset.x = x
	t.viewOffset.y = y
	
	t.skew:set(0, 0)
	
	if (t.fxShakeDuration > cool) then
		local sX = t.fxShakeIntensity * t.width -- uwu~
		local sY = t.fxShakeIntensity * t.height
		
		local rX, rY, rAngle, rSkewX, rSkewY = 0, 0, 0, 0, 0
		if (config.betterShake) then
			local w = (t.fxShakeDuration / -cool) + 1
			local ww = math.clamp(w, 0, 1) * (-config.betterShakeHardness + 1)
			local www = math.clamp(w, 0, 1) * config.betterShakeHardness
			
			t.fxShakeI = t.fxShakeI + (math.clamp((t.fxShakeIntensity * 7) + .75, 0, 10) * dt * math.clamp(w, 0, 1.5))
			rX = math.cos(t.fxShakeI * 97) * sX * ww
			rY = math.sin(t.fxShakeI * 86) * sY * ww
			rAngle = math.sin(t.fxShakeI * 62) * math.clamp(t.fxShakeIntensity * 66, -60, 60) * ww
			rSkewX = math.cos(t.fxShakeI * 54) * math.clamp(t.fxShakeIntensity * 12, -4, 4) * ww
			rSkewY = math.sin(t.fxShakeI * 51) * math.clamp(t.fxShakeIntensity * 12, -1.5, 1.5) * ww
			
			if (config.betterShakeHardness > 0) then
				rX = rX + (math.cos(t.fxShakeI * 165) * sX * www)
				rY = rY + (math.cos(t.fxShakeI * 132) * sY * www)
				rAngle = rAngle + (math.sin(t.fxShakeI * 111) * math.clamp(t.fxShakeIntensity * 66, -60, 60) * www)
				rSkewX = rSkewX + (math.sin(t.fxShakeI * 123) * math.clamp(t.fxShakeIntensity * 12, -4, 4) * www)
				rSkewY = rSkewY + (math.cos(t.fxShakeI * 101) * math.clamp(t.fxShakeIntensity * 12, -1.5, 1.5) * www)
			end
		else
			rX = getRandomFloat(-sX, sX)
			rY = getRandomFloat(-sY, sY)
		end
		
		if (config.useScrollForShake and t == cams.game) then
			t.scrollOffset:set(
				rX,
				rY
			)
		else
			t.viewOffset:add(
				rX * t.zoom,
				rY * t.zoom
			)
		end
		t.angle = t.angle + rAngle
		t.skew:add(rSkewX, rSkewY)
	else
		t.scrollOffset:set(0, 0)
	end
	
	local scaleX = t.scale.x
	local scaleY = t.scale.y
	
	if (type(t.getProperty("canvas.x")) == "number") then
		local width = (t.width * t.spriteScale.x)
		local height = (t.height * t.spriteScale.y)
		
		local ratio = t.width / width
		
		local aW, aH = width*t.anchorPoint.x, height*t.anchorPoint.y
		
		-- TY https://community.openfl.org/t/rotation-around-center/8751/4
		
		-- Setup Matrix
		local mat = t._matrix
		mat:identity()
		
		mat:translate(-aW, -aH) -- AnchorPoint In
		
		mat:scale(scaleX, scaleY) -- Scaling
		
		mat:rotate(t.angle) -- Angle
		
		mat:skew(t.skew.x, t.skew.y)
		
		mat:translate(aW, aH) -- AnchorPoint Out
		
		mat:translate(t.viewOffset.x, t.viewOffset.y) -- Offset
		
		mat:scale(scaleModeX * t.spriteScale.x, scaleModeY * t.spriteScale.y) -- ScaleMode
		
		-- Finals
		t.setProperty("canvas.__transform.a", mat.a)
		t.setProperty("canvas.__transform.b", mat.b)
		t.setProperty("canvas.__transform.c", mat.c)
		t.setProperty("canvas.__transform.d", mat.d)
		t.setProperty("canvas.__transform.tx", mat.tx)
		t.setProperty("canvas.__transform.ty", mat.ty)
	end
	
	t.setProperty("flashSprite.rotation", 0)
	t.setProperty("flashSprite.x", 0)
	t.setProperty("flashSprite.y", 0)
	t.setProperty("_flashOffset.x", (t.width * .5) * scaleModeX * initialZoom - (x * scaleModeX))
	t.setProperty("_flashOffset.y", (t.height * .5) * scaleModeY * initialZoom - (y * scaleModeY))
	
	local x = getProperty("camFollowPos.x")
	if (t == cams.game and type(x) == "number") then
		setProperty("camFollowPos.x", x + t.scrollOffset.x)
		setProperty("camFollowPos.y", getProperty("camFollowPos.y") + t.scrollOffset.x)
	else
		t.setProperty("scroll.x", t.getProperty("scroll.x") + t.scrollOffset.x)
		t.setProperty("scroll.y", t.getProperty("scroll.y") + t.scrollOffset.y)
	end
	t._lastScrollOffset:set(t.scrollOffset.x, t.scrollOffset.y)
end

function updateCamEarly(t, dt)
	if (t == cams.game) then
		setProperty("camFollowPos.x", getProperty("camFollowPos.x") - t._lastScrollOffset.x)
		setProperty("camFollowPos.y", getProperty("camFollowPos.y") - t._lastScrollOffset.y)
	else
		t.setProperty("scroll.x", t.getProperty("scroll.x") - t._lastScrollOffset.x)
		t.setProperty("scroll.y", t.getProperty("scroll.y") - t._lastScrollOffset.y)
	end
end

function updateCamsEarly(dt)
	if (not dead()) then
		updateCamEarly(cams.hud, dt)
		updateCamEarly(cams.other, dt)
	end
	updateCamEarly(cams.game, dt)
end

function updateCams(dt)
	if (not dead()) then
		updateCam(cams.hud, dt)
		updateCam(cams.other, dt)
	end
	updateCam(cams.game, dt)
end

function onGameOverStart()
	isDead = true
end

function onCreate()
	clock = getRandomFloat(-2^12, 0)
	
	initializeCams()
end

function onUpdate(dt)
	clock = clock + dt
	
	updateCamsEarly(dt)
end

function onUpdatePost(dt)
	updateCams(dt)
end