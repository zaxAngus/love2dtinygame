
require('someMath')
require('camera')
require('timeLine')
require('userInterface.ui')
require('battleFiled')
require('battleShip.battleShip')
require('enemyShip.enemyShip')
require('behaviorTree.BT_node')
require('base')
math.randomseed(os.time())
math.random()
math.random()
math.random()
function love.load(args)
  gameState=1
    for i = .2, 1, .2 do
     local rectangles = {}  
     for j = 1, math.random(2, 15) do
      table.insert(rectangles, {
        math.random(0, 1600),
        math.random(0, 1600),
        math.random(50, 400),
        math.random(50, 400),
        color = { math.random(0, 255), math.random(0, 255), math.random(0, 255) }
      })
     end   
  camera:newLayer(i, function()
      for _, v in ipairs(rectangles) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle('fill', unpack(v))
        love.graphics.setColor(255, 255, 255)
      end end)
  end
  camera:newLayer(1,function()
    battleFiled:draw()
    uiManager:inCameraDraw()
    end)
  gametime=timeLine:new()
end
 -------------------------------------------

function love.update(dt)
  if gameState==0 then

  elseif gameState==1 then
    base:update()
  elseif gameState==2 then
     camera:update(dt)
     battleFiled:update(dt)
     uiManager:update(dt)
  end
end
 -------------------------------------------
function love.draw()
  if gameState==1 then
     base:draw()
          love.graphics.print("MOUSE:"..love.mouse.getX().." "..love.mouse.getY(),2,45)
  elseif gameState==2 then
     camera:draw()
     uiManager:outCameraDraw()
     --[[
     love.graphics.print("FPS: " .. love.timer.getFPS(), 2, 2)
     love.graphics.print("GT:"..gametime:getTime(),2,15)
     love.graphics.print("POS:"..base.battleShip.x.." "..base.battleShip.y,2,30)]]
     love.graphics.print("MOUSE:"..love.mouse.getX().." "..love.mouse.getY(),2,45)
     --[[love.graphics.print("CAMERA:"..camera.x.." "..camera.y,2,60)
     love.graphics.print("TP:"..base.battleShip.turnPoint,2,90)
     love.graphics.print("BULLET:"..#battleFiled.bullet,2,105)
     love.graphics.print("hit:"..battleFiled.hitcount,2,135)]]
  end
 

end