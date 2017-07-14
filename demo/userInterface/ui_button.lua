--按键
button={class="button"}
function button:new(x,y,w,h,string,image,func)
	local  newButton={
	X=x or 0,Y=y or 0,W=w or 0,H=h or 0,
	click=0,focus=false,
	S=string,ima=nil or image,
	logic=func,id=nil}
	setmetatable(newButton,self)
	self.__index=self
	return newButton
end
--按钮检测鼠标点击
function button:inCameraUpdate(x,y)
	local posX=self.X-camera.x
	local posY=self.Y-camera.y
    if x>posX and x-posX<=self.W and y>posY and y-posY<=self.H then
   	  self.focus=true
   	else
   	  self.focus=false
   	  self.click=0
   	end

   	if self.focus then
      if self.click==0 then--鼠标按键未在此按键范围内没有过任何操作
   	    if love.mouse.isDown(1)==false then--鼠标左键未按下
   	  	  self.click=1
   	    end
   	  end
      if self.click==1 then
   	    if love.mouse.isDown(1) then--鼠标左键按下
   	  	  self.click=2
   	    end
      end
      if self.click==2 then
      	if love.mouse.isDown(1)==false then
      		self.logic()
      		self.click=0
      	end
      end
  end
end
function button:outCameraUpdate(x,y)
	local posX=self.X
	local posY=self.Y
    if x>posX and x-posX<=self.W and y>posY and y-posY<=self.H then
   	  self.focus=true
   	else
   	  self.focus=false
   	  self.click=0
   	end

   	if self.focus then
      if self.click==0 then--鼠标按键未在此按键范围内没有过任何操作
   	    if love.mouse.isDown(1)==false then--鼠标左键未按下
   	  	  self.click=1
   	    end
      elseif self.click==1 then
   	    if love.mouse.isDown(1) then--鼠标左键按下
   	  	  self.click=2
   	    end
      elseif self.click==2 then
      	if love.mouse.isDown(1)==false then
      		self.logic()
      		self.click=0
      	end
      end

   	end
end
--按键注册进入ui管理器表中和从管理表中删除(待优化)
function button:inCameraRegist(x,y)
	self.X=x
	self.Y=y
	if self.id==nil then
	   table.insert(uiManager.inCamera.button,self)
	   self.id=#uiManager.inCamera.button
    else
    	uiManager.inCamera.button[self.id]=self
    end
end
function button:inCameraUnRegist()

	uiManager.inCamera.button[self.id]=nil
end
function button:outCameraRegist(x,y)
	self.X=x or self.X
	self.Y=y or self.Y
	if self.id==nil then
	   table.insert(uiManager.outCamera.button,self)
	   self.id=#uiManager.outCamera.button
    else
    	uiManager.outCamera.button[self.id]=self
    end
end
function button:outCameraUnRegist()

	uiManager.outCamera.button[self.id]=nil
end
--绘制按键
function button:draw()
	local r,g,b,a=love.graphics.getColor()	
    love.graphics.setColor(150,100,100,100)
    if self.focus then
    	love.graphics.setColor(0,0,0,0)
    end
	love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
	love.graphics.setColor(255,255,255,255)
	love.graphics.print(self.S,self.X+5,self.Y+5)
	love.graphics.setColor(r,g,b,a)
end
