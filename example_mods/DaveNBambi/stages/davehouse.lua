local ofsx = -210
local ofsy = 0
local mult = 1.25
function onCreate()
  makeLuaSprite('sky', 'sky', -600+ofsx, -200+ofsy)
  addLuaSprite('sky')
  setScrollFactor('sky', 0.75, 0.75)

  makeLuaSprite('hills', 'davehouse/hills', -225+ofsx, -125+ofsy)
  addLuaSprite('hills')
  setScrollFactor('hills', 0.8, 0.8)
  scaleObject('hills', 1.25*mult, 1.25*mult)

  makeLuaSprite('gate', 'davehouse/gate', -200+ofsx, -125+ofsy)
  addLuaSprite('gate')
  setScrollFactor('gate', 0.9, 0.9)
  scaleObject('gate', 1.2*mult, 1.2*mult)

  makeLuaSprite('grass', 'davehouse/grass', -225+ofsx, -125+ofsy)
  addLuaSprite('grass')
  scaleObject('grass', 1.2*mult, 1.2*mult)
end
