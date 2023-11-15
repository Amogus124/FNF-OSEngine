--all these values are for the camera shit
xx = 400;
yy = 500;
ofs = 50;
followchars = true;
dadzoom = 0.9
local twitcher = 10
--ofs = dadd
--ofs2 = bf
function onCreatePost()
  --all this shit sets the cpus note skin
  runTimer('twitchleft', 0.05)
  for i=0,4,1 do
    setPropertyFromGroup('opponentStrums', i, 'texture', '3d/NOTE_assets_3D')
  end
  for i = 0, getProperty('unspawnNotes.length')-1 do
    if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --this checks to see if the notes that are coming are bfs or not
      setPropertyFromGroup('unspawnNotes', i, 'texture', '3d/NOTE_assets_3D'); --Change texture
    end
  end
end
function onBeatHit()
  if curBeat % 2 == 0 then
    haha = math.random(4) --for every note that spawns, a random number between one and four is drawn, if its two, then the note becomes 3d!
  end
end
function onUpdate()

  for i = 0, getProperty('unspawnNotes.length')-1 do
    if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
      if haha == 2 then
        setPropertyFromGroup('unspawnNotes', i, 'texture', '3d/NOTE_assets_3D'); --Change texture
      else
        setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets');
      end
    end
  end
end
--modifed shit from vandalization mod
function opponentNoteHit()
    if followchars == true then
			setProperty('defaultCamZoom', dadzoom)
      if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
          triggerEvent('Camera Follow Pos',xx-ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
          triggerEvent('Camera Follow Pos',xx+ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singUP' then
          triggerEvent('Camera Follow Pos',xx,yy-ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
          triggerEvent('Camera Follow Pos',xx,yy+ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
          triggerEvent('Camera Follow Pos',xx-ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
          triggerEvent('Camera Follow Pos',xx+ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
          triggerEvent('Camera Follow Pos',xx,yy-ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
          triggerEvent('Camera Follow Pos',xx,yy+ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
          triggerEvent('Camera Follow Pos',xx,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'idle' then
          triggerEvent('Camera Follow Pos',xx,yy)
      end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    setProperty('health', getProperty('health') - 0.01)
end
--floaty shit
function onTweenCompleted(tag)
	if tag == 'floatdown' then
		doTweenY('floatup', 'dad', defaultOpponentY-50, 1, 'cubeInOut')
	elseif tag == 'floatup' then
		doTweenY('floatdown', 'dad', defaultOpponentY+50, 1, 'cubeInOut')
		--doTweenY('cameradown', 'cam_Y', -50, 1, 'cubeInOut')
	elseif tag == 'first' then
		doTweenY('floatup', 'dad', defaultOpponentY-50, 1, 'cubeInOut')
		--doTweenY('cameraup', 'cam_Y', -50, 1, 'cubeInOut')
		--setProperty('cameraFollowPos.y', cam_Y)
	end
end
function onTimerCompleted(tag)
  if tag == 'twitchleft' then
    setProperty('dad.x', defaultOpponentX+twitcher)
    setProperty('dad.y', defaultOpponentY-twitcher)
    runTimer('twitchright', 0.05)
  elseif tag == 'twitchright' then
    setProperty('dad.x', defaultOpponentX-twitcher)
    setProperty('dad.y', defaultOpponentY+twitcher)
    runTimer('twitchleft', 0.05)
  end
end
