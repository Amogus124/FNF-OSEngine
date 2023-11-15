local funy = true
function onStartCountdown()
	setProperty('health', 2)
end
function onMoveCamera(focus)
	if focus == 'boyfriend' then
		-- called when the camera focus on boyfriend
	elseif focus == 'dad' then
		setProperty('camFollowPos.y',getProperty('camFollowPos.y') + (math.sin(currentBeat) * 0.6))
	end
	setPropertyFromClass('ClientPrefs', 'ghostTapping', true)
end
function opponentNoteHit(id, direction, noteType, isSustainNote)
	cameraShake(game, 0.015, 0.2)
	cameraSetTarget('dad')
	characterPlayAnim('gf', 'scared', true)
	doTweenZoom('camerazoom','camGame',1.05,0.15,'quadInOut')
end
function goodNoteHit(id, direction, noteType, isSustainNote)
	cameraSetTarget('boyfriend')
end
function noteMiss(direction)
	setProperty('health', getProperty('health') + 0.025)
end
function noteMissPress(direction)
	setProperty('health', getProperty('health') + 0.025)
end
function onUpdate()
	if funy == true then
		songPos = getSongPosition()
		local currentBeat = (songPos/5000)*(curBpm/60)
		noteTweenX(defaultPlayerStrumX0, 4, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + 0) * 300), 0.001)
		noteTweenX(defaultPlayerStrumX1, 5, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + 1) * 300), 0.001)
		noteTweenX(defaultPlayerStrumX2, 6, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + 2) * 300), 0.001)
		noteTweenX(defaultPlayerStrumX3, 7, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + 3) * 300), 0.001)
		noteTweenY('defaultPlayerStrumY0', 4, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + 0) * 300), 0.001)
		noteTweenY('defaultPlayerStrumY1', 5, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + 1) * 300), 0.001)
		noteTweenY('defaultPlayerStrumY2', 6, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + 2) * 300), 0.001)
		noteTweenY('defaultPlayerStrumY3', 7, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + 3) * 300), 0.001)
		noteTweenX('fake1', 0, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + (4) * 2) * 300), 0.001)
		noteTweenX('fake2', 1, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + (5) * 2) * 300), 0.001)
		noteTweenX('fake3', 2, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + (6) * 2) * 300), 0.001)
		noteTweenX('fake4', 3, ((screenWidth / 2) - (157 / 2)) + (math.sin((currentBeat) + (7) * 2) * 300), 0.001)
		noteTweenY('defaultFPlayerStrumY0', 0, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + (4) * 2) * 300), 0.001)
		noteTweenY('defaultFPlayerStrumY1', 1, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + (5) * 2) * 300), 0.001)
		noteTweenY('defaultFPlayerStrumY2', 2, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + (6) * 2) * 300), 0.001)
		noteTweenY('defaultFPlayerStrumY3', 3, ((screenHeight / 2) - (157 / 2)) + (math.cos((currentBeat) + (7) * 2) * 300), 0.001)
	else
		setPropertyFromGroup('opponentStrums',0,'x','-500')
		setPropertyFromGroup('opponentStrums',1,'x','-500')
		setPropertyFromGroup('opponentStrums',2,'x','-500')
		setPropertyFromGroup('opponentStrums',3,'x','-500')

		setPropertyFromGroup('playerStrums',0,'x','412')
		setPropertyFromGroup('playerStrums',1,'x','527')
		setPropertyFromGroup('playerStrums',2,'x','643')
		setPropertyFromGroup('playerStrums',3,'x','761')

		setPropertyFromGroup('playerStrums',0,'y',defaultPlayerStrumY0)
		setPropertyFromGroup('playerStrums',1,'y',defaultPlayerStrumY0)
		setPropertyFromGroup('playerStrums',2,'y',defaultPlayerStrumY0)
		setPropertyFromGroup('playerStrums',3,'y',defaultPlayerStrumY0)
	end
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.FIVE') then
		 if funy == true then
			 funy = false
		 else
			 funy = true
		 end
	end
end
