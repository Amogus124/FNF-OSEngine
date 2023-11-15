glitchsprites = {} --dont add anything here!!!
function onCreate()
	makeGlitchSprite('redsky', '3d/cheater', -500, -100, 1.5, false, true);
end

function makeGlitchSprite(name, sprite, xx, yy, scale, antialiasing, autoAdd)
	if autoAdd == nil then
		autoAdd = true
	end
	local antialias = true
	if antialiasing ~= nil then antialias = false end
	debugPrint(antialias)

	makeLuaSprite(name, sprite, xx, yy)
	setProperty(name..'.alpha', 0.25);
	setProperty(name..'.antialiasing', antialias)

	makeLuaSprite(name..'rbg', sprite, xx, yy)
	setProperty(name..'rbg.antialiasing', antialias)
	if autoAdd then
		addLuaSprite(name..'rbg')
		addLuaSprite(name)
	end
	if scale == nil then
		scaler = 1
	else
		scaler = scale
	end
	table.insert(glitchsprites, {name, xx - 50, yy, scaler})
end
fr = 0
function onUpdate(elapsed)
    fr = fr + elapsed;

		if #glitchsprites ~= 0 then
			for i=1,#glitchsprites do
				local sprite = glitchsprites[i][1]
				local cx = glitchsprites[i][2]
				local cy = glitchsprites[i][3]
				local scale = glitchsprites[i][4]
		    setProperty(sprite..'.scale.x', (scale + math.cos(fr) / 4) * 1)
		    setProperty(sprite..'.scale.y', (scale + math.cos(fr + 1) / 4) * 1)

		    setProperty(sprite..'rbg.scale.x', scale + math.cos(fr*3) / 6)
		    setProperty(sprite..'rbg.scale.y', scale + math.cos(fr*3 + 2) / 6)
		    setProperty(sprite..'rbg.angle', math.sin(fr*3) * 8);
		    setProperty(sprite..'rbg.x', cx + math.sin(fr*3) * 200);
		    setProperty(sprite..'rbg.y', cy + math.cos(fr*3) * 200);
			end
		end
end
