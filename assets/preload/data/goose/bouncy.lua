strumsX = {92, 204, 316, 428, 732, 844, 956, 1068}
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
function onBeatHit()
  if curBeat % 4 == 0 then
    bounceNote(true)
  elseif curBeat % 4 == 2 then
    bounceNote(false)
  end
end
function onCountdownTick(daTick)
  if daTick % 2 == 0 then
    bounceNote(true)
  else
    bounceNote(false)
  end
end
function bounceNote(which)
  if modCharts then
    if which then
      for i=0,7,2 do
        addStrumPos(i, -35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', -35)
        noteTweenX('yeayea'..i, i, stupidPos(i), crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
      for i=1,8,2 do
        addStrumPos(i, 35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', 35)
        noteTweenX('yeayea'..i, i, stupidPos(i), crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
    else
      for i=0,7,2 do
        addStrumPos(i, 35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', 35)
        noteTweenX('yeayea'..i, i, stupidPos(i), crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
      for i=1,8,2 do
        addStrumPos(i, -35)
        setPropertyFromGroup('strumLineNotes', i, 'angle', -35)
        noteTweenX('yeayea'..i, i, stupidPos(i), crochet*0.002, 'cubeOut')
        noteTweenAngle('okok'..i, i, 0, crochet*0.002, 'cubeOut')
      end
    end
  end
end
function isPlayer(i)
  if i > 3 then
    return true
  end
  return
end
function stupidPos(i)
  local finalPos = strumsX[i+1]
  if middlescroll then
    local finalPos = finalPos - 278
    if not isPlayer(i) then
      finalPos = finalPos + 310
      if i > 1 then
        finalPos = finalPos + screenWidth  / 2 + 25
        return finalPos --man
      end    
      return finalPos --man
    end
    return finalPos --man
  end
  return finalPos --man
end