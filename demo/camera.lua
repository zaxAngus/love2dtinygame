camera = {}
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.layers={}
function camera:update(dt)
  if love.keyboard.isDown('w') then
    camera:move(0,-10)
  elseif love.keyboard.isDown('s') then
    camera:move(0,10)
  elseif love.keyboard.isDown('a') then
      camera:move(-10,0)
  elseif love.keyboard.isDown('d') then
      camera:move(10,0)
  end
  if love.keyboard.isDown('r') then
 
  end
  -- body
end
function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)--移动镜头
  self.x = self.x + (dx or 0)
  self.y = self.y +  (dy or 0)
end

function camera:rotate(dr)--旋转镜头
  self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)--缩放镜头
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)--
  self.x = x or self.x
  self.y = y or self.y
end

function camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

function camera:mousePosition()
  return love.mouse.getX() * self.scaleX + self.x, love.mouse.getY() * self.scaleY + self.y
end

function camera:newLayer(scale, func)
  table.insert(self.layers, { draw = func, scale = scale })
  table.sort(self.layers, function(a, b) return a.scale < b.scale end)--根据SCALE降序排序
end

function camera:draw()
  local bx, by = self.x, self.y
  
  for _, v in ipairs(self.layers) do
    self.x = bx * v.scale
    self.y = by * v.scale
    camera:set()
    v.draw()
    camera:unset()
  end

  
end