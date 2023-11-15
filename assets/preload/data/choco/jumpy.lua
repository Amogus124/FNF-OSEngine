function onUpdate(elapsed)
  if modCharts then
    for i=0,8 do
      local why = defaultPlayerStrumY1
      setStrumPos(i, getStrumPos(i).x, (downscroll and -1 or 1) * (math.abs(45*math.cos((elapsedTime * 2) + (i/4)))) + why)
    end
  end
end
function setStrumPos(member, x, y)
  setPropertyFromGroup('strumLineNotes', member, 'x', x)
  setPropertyFromGroup('strumLineNotes', member, 'y', y)
end
function addStrumPos(member, x, y)
  local y = (y ~= nil) and y or 0
  setPropertyFromGroup('strumLineNotes', member, 'x', getPropertyFromGroup('strumLineNotes', member, 'x') + x)
  setPropertyFromGroup('strumLineNotes', member, 'y', getPropertyFromGroup('strumLineNotes', member, 'y') + y)
end
function getStrumPos(member)
  ok = {x = getPropertyFromGroup('strumLineNotes', member, 'x'), y = getPropertyFromGroup('strumLineNotes', member, 'y')}
  return ok
end
