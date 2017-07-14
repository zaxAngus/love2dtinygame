--状态显示条
stateBar={}
function stateBar:new(x,y,w,h,string,maxData,nowData,r,g,b,a)
	local newStateBar={
	X=x,Y=y,W=w,H=h,S=string,ima=love.graphics.newImage("rawResource/stateBar.BMP"),
	R=r,G=g,B=b,A=a,--Color
	max=maxData,
	now=nowData,
    }
    setmetatable(newStateBar,self)
    self.__index=self
    return newStateBar
end
function stateBar:outCamreaUpdate(d)
	self.now=self.now+d-- body
end
--绘制状态条
function stateBar:draw()
	love.graphics.draw(self.ima,self.X,self.Y)
	local r,g,b,a=love.graphics.getColor()
	love.graphics.setColor(self.R,self.G,self.B,self.A)
	love.graphics.rectangle("fill",self.X+13,self.Y+11,(self.W-20)*self.now/self.max-5,self.H-20-3)
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(self.S..':',self.X-30,self.Y)
	love.graphics.print(self.now..'/'..self.max,self.X-60,self.Y+15)
	love.graphics.setColor(r,g,b,a)
end
--状态条注册
function stateBar:inCameraRegist(x,y)
	if self.id==nil then
	   table.insert(uiManager.inCamera.stateBar,self)
	   self.id=#uiManager.inCamera.stateBar
    else
    	uiManager.inCamera.stateBar[self.id]=self
    end
end
function stateBar:inCameraUnRegist()

	uiManager.inCamera.stateBar[self.id]=nil
end
function stateBar:outCameraRegist(x,y)
	if self.id==nil then
	   table.insert(uiManager.outCamera.stateBar,self)
	   self.id=#uiManager.outCamera.stateBar
    else
    	uiManager.outCamera.stateBar[self.id]=self
    end
end
function stateBar:outCameraUnRegist()

	uiManager.outCamera.stateBar[self.id]=nil
end
