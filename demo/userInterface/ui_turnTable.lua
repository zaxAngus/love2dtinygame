
--角度转盘
turnTable={}
function turnTable:new(x,y,r,func)
	local newTurnTable={
	X=x,Y=y,R=r,logic=func
    }
    setmetatable(newTurnTable,self)
    self.__index=self
    return newTurnTable
end

function turnTable:inCameraUpdate()
    if love.mouse.isDown(1) then
    	self.logic()
    end    
end
function turnTable:draw()
	local r,g,b,a=love.graphics.getColor()	
    love.graphics.setColor(150,100,100,100)
	love.graphics.line(self.X,self.Y,love.mouse.getX()+camera.x,love.mouse.getY()+camera.y)
	love.graphics.circle("line",self.X,self.Y,self.R)
	love.graphics.setColor(r,g,b,a)-- body
end
function turnTable:inCameraRegist(x,y)
	self.X=x
	self.Y=y
	if self.id==nil then
	   table.insert(uiManager.inCamera.turnTable,self)
	   self.id=#uiManager.inCamera.turnTable
    else
    	uiManager.inCamera.turnTable[self.id]=self
    end
end
function turnTable:inCameraUnRegist()
	uiManager.inCamera.turnTable[self.id]=nil	-- body
end

