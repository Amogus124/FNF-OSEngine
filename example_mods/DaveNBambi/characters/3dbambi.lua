
twitcher = 10
--ofs = dadd
--ofs2 = bf
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
