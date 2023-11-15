local mult = 1.25
local ofsx = -500
local corny = 175
xx2 = 952.9;
yy2 = 650;
ofs2 = 50
followchars = true;
bfzoom = 1.1
function onCreate()
  skyType = 'sky'
  makeLuaSprite('sky', skyType, -700, -250)
  addLuaSprite('sky')
  setScrollFactor('sky', 0.9, 0.9)

  makeLuaSprite('hills', 'corn/orangey hills', -250+ofsx, 100)
  addLuaSprite('hills')
  setScrollFactor('hills', 0.9, 0.7)
  scaleObject('hills', mult, mult)

  makeLuaSprite('farm', 'corn/funfarmhouse', 150+ofsx, 250)
  addLuaSprite('farm')
  setScrollFactor('farm', 1.1, 0.9)
  scaleObject('farm', mult, mult)

  makeLuaSprite('foreground', 'corn/grass lands', -400+ofsx, 600)
  addLuaSprite('foreground')
  scaleObject('foreground', mult, mult)

  makeLuaSprite('cornset', 'corn/cornys', -350+ofsx, corny)
  addLuaSprite('cornset')
  scaleObject('cornset', mult*mult, mult*mult)

  makeLuaSprite('cornset2', 'corn/cornys', 1050+ofsx, corny)
  addLuaSprite('cornset2')
  scaleObject('cornset2', mult*mult, mult*mult)

  makeLuaSprite('fence', 'corn/crazy fences', -350+ofsx, 460)
  addLuaSprite('fence')
  scaleObject('fence', mult, mult)

  makeLuaSprite('sign', 'corn/sign', -350, 500)
  addLuaSprite('sign')
  scaleObject('sign', mult, mult)
end
function onCreatePost()


  if skyType == 'corn/sky_sunset' then
    color_cool = 'FF8FB2'
  elseif skyType == 'sky_night' then
    color_cool = '0xFF878787'
  end
  if skyType == 'corn/sky_sunset' or skyType == 'sky_night' then
    doTweenColor('awesome1', 'dad', color_cool, 0.5, 'linear')
    doTweenColor('awesome2', 'gf', color_cool, 0.5, 'linear')
    doTweenColor('awesome3', 'boyfriend', color_cool, 0.5, 'linear')
    doTweenColor('awesome4', 'sky', color_cool, 0.5, 'linear')
    doTweenColor('awesome5', 'hills', color_cool, 0.5, 'linear')
    doTweenColor('awesome6', 'farm', color_cool, 0.5, 'linear')
    doTweenColor('awesome7', 'foreground', color_cool, 0.5, 'linear')
    doTweenColor('awesome8', 'cornset', color_cool, 0.5, 'linear')
    doTweenColor('awesome9', 'cornset2', color_cool, 0.5, 'linear')
    doTweenColor('awesome10', 'fence', color_cool, 0.5, 'linear')
    doTweenColor('awesome11', 'sign', color_cool, 0.5, 'linear')
    --doTweenY('floatdown', 'dad', 50, 1, 'cubeInOut')
  end
end
