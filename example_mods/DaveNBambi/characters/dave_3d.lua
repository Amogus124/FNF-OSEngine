--ofs = dad
--ofs2 = bf
function onCreatePost()
  --all this shit sets the cpus note skin
  doTweenY('first', 'dad', 50, 0.25, 'cubeInOut')
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
