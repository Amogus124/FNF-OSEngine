function onCreate()
	makeLuaSprite('redsky', '3d/scarybg', -500, -100);
	setLuaSpriteScrollFactor('redsky', 0.9, 0.9);
	addGlitchEffect('redsky', 2,2)
	addLuaSprite('redsky', false);
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
