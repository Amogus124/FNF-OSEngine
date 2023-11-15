function onUpdate()
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
		setProperty('inCutscene', true);
		loadSong('cheating', 2)
		return Function_Stop;
	end
end
