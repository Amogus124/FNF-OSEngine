funy = true
elapsedtime = 1
new = {}
function onCreatePost()
	table.insert(new,defaultPlayerStrumX3) --fuck lua
	table.insert(new,defaultPlayerStrumX1)
	table.insert(new,defaultPlayerStrumX0)
	table.insert(new,defaultPlayerStrumX2)
end
function onUpdate(elapsed)
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FIVE') then
		funy = not funy
		old = false
	elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FOUR') then
		funy = false
		old = not old
	end
	if not old and funy then
		speeder = 5

		elapsedtime = (getSongPosition()/5000)*(curBpm/60) * (speeder * -1)

		for i=0,3,1 do
			local even = math.fmod(i, 2)
			local thing = even == 0 and 1 or -1
			setPropertyFromGroup('playerStrums', i, 'x', getPropertyFromGroup('playerStrums', i, 'x') + math.sin(elapsedtime) * thing * speeder)
			setPropertyFromGroup('playerStrums', i, 'x', getPropertyFromGroup('playerStrums', i, 'x') - math.sin(elapsedtime) * 1.5 * speeder)
		end

		for i=0,3,1 do
			local even = math.fmod(i, 2)
			local thing = even == 0 and 1 or -1
			setPropertyFromGroup('opponentStrums', i, 'x', getPropertyFromGroup('opponentStrums', i, 'x') - math.sin(elapsedtime) * thing * speeder)
			setPropertyFromGroup('opponentStrums', i, 'x', getPropertyFromGroup('opponentStrums', i, 'x') + math.sin(elapsedtime) * 1.5 * speeder)
		end
	elseif old and not funy then
		setPropertyFromGroup('opponentStrums',0,'x',defaultOpponentStrumX0)
		setPropertyFromGroup('opponentStrums',1,'x',defaultOpponentStrumX1)
		setPropertyFromGroup('opponentStrums',2,'x',defaultOpponentStrumX2)
		setPropertyFromGroup('opponentStrums',3,'x',defaultOpponentStrumX3)
	  for i=0,3,1 do
	    setPropertyFromGroup('playerStrums',i,'x',new[i+1])
	  end
	else
		setPropertyFromGroup('opponentStrums',0,'x',defaultOpponentStrumX0)
		setPropertyFromGroup('opponentStrums',1,'x',defaultOpponentStrumX1)
		setPropertyFromGroup('opponentStrums',2,'x',defaultOpponentStrumX2)
		setPropertyFromGroup('opponentStrums',3,'x',defaultOpponentStrumX3)

		setPropertyFromGroup('playerStrums',0,'x',defaultPlayerStrumX0)
		setPropertyFromGroup('playerStrums',1,'x',defaultPlayerStrumX1)
		setPropertyFromGroup('playerStrums',2,'x',defaultPlayerStrumX2)
		setPropertyFromGroup('playerStrums',3,'x',defaultPlayerStrumX3)
	end

	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SEVEN') then
		setProperty('inCutscene', true);
		loadSong('unfairness', 2)
		return Function_Stop;
	end
end
