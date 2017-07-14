--ui管理器
uiManager={inCamera={button={},turnTable={}},
           outCamera={button={},stateBar={}}}
--ui更新
function uiManager:update()
	local x=love.mouse.getX()
	local y=love.mouse.getY()
--inCamera
	if #self.inCamera.button>=1 then
	   for i=1,#self.inCamera.button do
		   if self.inCamera.button[i]then
		        self.inCamera.button[i]:inCameraUpdate(x,y)
	       end
	    end
    end
    if #self.inCamera.turnTable>=1 then
    	for i=1,#self.inCamera.turnTable do
    		if self.inCamera.turnTable[i] then
    			self.inCamera.turnTable[i]:inCameraUpdate(x,y)
    	    end
    	end
    end
--outCamera
	if #self.outCamera.button>=1 then
	    for i=1,#self.outCamera.button do
		    if self.outCamera.button[i]then
		    self.outCamera.button[i]:outCameraUpdate(x,y)
	        end
	    end
    end
end
function uiManager:inCameraDraw()
	if #self.inCamera.button>=1 then
	   for i=1,#self.inCamera.button do
		   if self.inCamera.button[i] then
		      self.inCamera.button[i]:draw()
	       end
	   end
    end
  	if #self.inCamera.turnTable>=1 then
	   for i=1,#self.inCamera.turnTable do
		   if self.inCamera.turnTable[i] then
		      self.inCamera.turnTable[i]:draw()
	       end
	   end
    end  
end
function uiManager:outCameraDraw( ... )
    if #self.outCamera.button>=1 then
	   for i=1,#self.outCamera.button do
		   if self.outCamera.button[i] then
		      self.outCamera.button[i]:draw()
	       end
	   end
	end
	if #self.outCamera.stateBar>=1 then
	   for i=1,#self.outCamera.stateBar do
		   if self.outCamera.stateBar[i] then
		      self.outCamera.stateBar[i]:draw()
	       end
	   end
    end	-- body
end
require('userInterface.ui_button')
require('userInterface.ui_stateBar')
require('userInterface.ui_turnTable')
require('userInterface.ui_itemBox')
