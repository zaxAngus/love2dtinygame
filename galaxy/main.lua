---------------------------------
require"class"

player=require"player"


_shader=require"shaders"

require"object.object"
_ship=require"object.battleship"
_enemyship=require"object.enemyship"

local game=require"game"
win_h=love.graphics.getHeight()
win_w=love.graphics.getWidth()

function  love.load( ... )
   playing=game.new()
   playing:load()
end

function love.update(dt)
   playing:update(dt)
end

function love.draw()
   playing:draw()
end


function love.mousepressed(x,y,button,istouch)
   playing:update_input("mousepress",x,y,button)
end
function love.mousemoved(x,y,dx,dy,istouch)
   playing:update_input("mousemove",x,y,dx,dy)
end
function love.keypressed(key,scancode,isrepeat)
   playing:update_input("keypressed",key)
end

function love.threaderror(thread, errorstr)
  print("Thread error!\n"..errorstr)
  -- thread:getError() will return the same error string now.
end