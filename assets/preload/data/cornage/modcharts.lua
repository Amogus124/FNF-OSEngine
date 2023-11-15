function onUpdate(elapsed)
  if modCharts then
    for i=0,8 do
      addStrumPos(i, -0.25*math.sin(elapsedTime + (i+1)), -0.25*math.cos(elapsedTime + (i+1)))
      if not (middlescroll and i < 4) then
        setPropertyFromGroup('strumLineNotes', i, 'alpha', (0.6*math.sin((elapsedTime + ((i/2)+1)) * 5)) + 1)
      else
        setPropertyFromGroup('strumLineNotes', i, 'alpha', (0.4*math.sin((elapsedTime + ((i/2)+1)) * 5)) + 0.1)
      end
    end
  end
end
function setStrumPos(strum, member, x, y)
  setPropertyFromGroup(strum, member, 'x', x)
  setPropertyFromGroup(strum, member, 'y', y)
end
function addStrumPos(member, x, y)
  local y = (y ~= nil) and y or 0
  setPropertyFromGroup('strumLineNotes', member, 'x', getPropertyFromGroup('strumLineNotes', member, 'x') + x)
  setPropertyFromGroup('strumLineNotes', member, 'y', getPropertyFromGroup('strumLineNotes', member, 'y') + y)
end
