--all these values are for the camera shit
xx = 400;
yy = 500;
ofs = 50;
followchars = true;
dadzoom = 0.9

noteTex = '3d/NOTE_assets_3D'
noteChance = 25 --chance to become a 3d note as a percent
function onCreatePost()
  for i=0, getProperty('unspawnNotes.length')-1 do
    if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
      setPropertyFromGroup('unspawnNotes', i, 'texture', noteTex)
      setPropertyFromGroup('unspawnNotes', i, 'antialiasing', false)
    else
      local is3D = getRandomBool(noteChance)
      if is3D then
        setPropertyFromGroup('unspawnNotes', i, 'texture', noteTex)
        setPropertyFromGroup('unspawnNotes', i, 'antialiasing', false)
      end
    end
  end
  for i=0,3 do
    setPropertyFromGroup('opponentStrums', i, 'texture', noteTex)
    setPropertyFromGroup('opponentStrums', i, 'antialiasing', false)
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
