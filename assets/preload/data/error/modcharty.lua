function onUpdate(elapsed)
  if modCharts then
    for i=0,8 do
      addStrumPos(i, 0.25*math.cos(elapsedTime), 0.5*math.sin((elapsedTime * 2) + i))
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
