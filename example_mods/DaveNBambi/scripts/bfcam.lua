camera = true
campointx = 0
campointy = 0
bfturn = false
camMovement = 15
velocity = 1.5

function onCreatePost()
  camera = getProperty('cameraAllowed') --you can set property cameraAllowed on create to disable
  camMovement = getProperty('butGoodCamMovement')
end

function onMoveCamera(focus)
  if camera then
    if focus == 'boyfriend' then
    campointx = getProperty('camFollow.x')
    if boyfriendName == 'bf-fourthwall' then
      campointy = 732
      setProperty('camFollow.y', campointy)
    else
      campointy = getProperty('camFollow.y')
    end
    bfturn = true

    elseif focus == 'dad' then
      campointx = getProperty('camFollow.x')
      campointy = getProperty('camFollow.y')
      --debugPrint(campointx ..', ', campointy)
      bfturn = false
      setProperty('cameraSpeed', 1)
      --debugPrint(campointx, ', ', campointy)
    end
  end
end


function goodNoteHit(id, direction, noteType, isSustainNote)
    if bfturn and camera then
        if direction == 0 then
            setProperty('camFollow.x', campointx - camMovement)
        elseif direction == 1 then
            setProperty('camFollow.y', campointy + camMovement)
        elseif direction == 2 then
            setProperty('camFollow.y', campointy - camMovement)
        elseif direction == 3 then
            setProperty('camFollow.x', campointx + camMovement)
        end
        setProperty('cameraSpeed', velocity)
    end
end

        -- delete this if you dont want the oponent to move the camera
function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not bfturn and camera then
        if direction == 0 then
            setProperty('camFollow.x', campointx - camMovement)
        elseif direction == 1 then
            setProperty('camFollow.y', campointy + camMovement)
        elseif direction == 2 then
            setProperty('camFollow.y', campointy - camMovement)
        elseif direction == 3 then
            setProperty('camFollow.x', campointx + camMovement)
        end
        setProperty('cameraSpeed', velocity)
    end
end
