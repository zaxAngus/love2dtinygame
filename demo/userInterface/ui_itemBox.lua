itemBox={
	      class="itemBox",
	      x=1000,y=0,w=280,h=720,focusID=nil,
	      page=1,
	      lastPage=button:new(1080,660,50,20,"<-",nil,function()
	      end),
	      nextPage=button:new(1150,660,50,20,"  ->",nil,function()
	      end),
	      close=button:new(1110,690,60,20,"    X   ",nil,function()
	      	base.ui.itemBox.activate=false 	-- body
	      end),


	      equip=button:new(110,660,60,20,"  equip ",nil,function ( ... )
	      	-- body
	      end),
	      close1=button:new(110,690,60,20,"    X   ",nil,function()
	      	base.ui.itemBox.activate=false 	-- body
	      end),

	      item={}
        }

function itemBox:new( )
	local newBOX={}
	setmetatable(newBOX,self)
	self.__index=self
	return newBOX
end
function itemBox:ini( obj )

	local i=1
	local j=0
	self.page=1
	self.lastPage.logic=function ( ... )
	   if self.page>1 then
	     self.page=self.page-1
	     end	-- body
	end
	self.nextPage.logic=function ( ... )
	self.page=self.page+1
	end
	self.item={}
	for key,value in pairs(obj) do
		self.item[i]=itemIcon:new(self.x+10,self.y+10+j*80,obj[key])
		j=j+1
		i=i+1
		if j>=8 then
			j=0
		end
	end
end

function itemBox:outCameraUpdate(x,y)
	self.lastPage:outCameraUpdate(x,y)
	self.nextPage:outCameraUpdate(x,y)
	self.close:outCameraUpdate(x,y)
	for i=(self.page-1)*6+1,self.page*6 do
		if self.item[i] then
	   self.item[i]:outCameraUpdate(x,y)
	    end
	end
    
end
function itemBox:draw()
	local r,g,b,a=love.graphics.getColor()	
    love.graphics.setColor(150,100,100,100)
	love.graphics.rectangle("fill",1000,0,280,720)
	love.graphics.rectangle("fill",0,0,280,720)
	love.graphics.setColor(r,g,b,a)
	for i=(self.page-1)*8+1,self.page*8 do
	  if self.item[i] then
	   self.item[i]:draw()
	  end
	end

	self.lastPage:draw()
	self.nextPage:draw()
	self.close:draw()
	self.equip:draw()
	self.close1:draw()
end 

itemIcon={
	       class="itemIcon",
	       item,focus=false,
	       logic=function ()
	       end,
	       x,y,w=260,h=70,
         }
function itemIcon:new(x,y,item)
	local newIcon={x=x,y=y,item=item}
	setmetatable(newIcon,self)
	self.__index=self
	return newIcon
end
function itemIcon:logic()                                                                                                                                                                                                                              
	if self.item.class=="weapon" then
		base.ui.itemBox.activate=false
		base.ui.equipMenu.weapon.activate=true
		base.ui.equipMenu.weapon:setItem(self.item)
	end
	if self.item.class=="fighter" then
	end
end
function itemIcon:outCameraUpdate(x,y)
	local posX=self.x
	local posY=self.y
    if x>posX and x-posX<=self.w and y>posY and y-posY<=self.h then
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
      		self:logic()
      		self.click=0
      	end
      end
   	end
end

function itemIcon:draw()
	love.graphics.draw(self.item.icon,self.x,self.y)
	love.graphics.print(self.item.name,self.x+90,self.y)
	if self.item.class=="weapon" then
		love.graphics.print("ATK: "..self.item.bulletConfig.atk,self.x+90,self.y+15)
		love.graphics.print("CD:  "..self.item.COST,self.x+90,self.y+30)
		love.graphics.print("TYPE:"..self.item.type,self.x+90,self.y+45)
	end
end

equipMenu={

           	class="equipMenu",
	        x=1000,y=0,w=280,h=720,
	        focus={},click={},
	        activate=false,item=nil
           }

function equipMenu:new(type,obj)
	local newEquipMenu={type=nil,equipSlot={}}
	local x
	local y
	if type=="weapon" then
		newEquipMenu.type="weapon"
	   for i=1,#obj.weapon do
	   	    self.focus[i]=false
	   	    self.click[i]=0
	     	x=640+((-obj.weapon[i].x)*math.cos(-math.rad(45))+(-obj.weapon[i].y)*math.sin(-math.rad(45))) or 0
	        y=360+((-obj.weapon[i].x)*math.sin(-math.rad(45))+(-obj.weapon[i].y)*math.cos(-math.rad(45))) or 0
		    newEquipMenu.equipSlot[i]={x=x,y=y}
	   end
    end
    setmetatable(newEquipMenu,self)
    self.__index=self
	return newEquipMenu
end
function equipMenu:setItem(item)
	self.item=item
end
function equipMenu:outCameraUpdate(x,y)
	local posX
	local posY
	for key,value in pairs(self.equipSlot) do
		posX=value.x or 0
		posY=value.y or 0
       if (x-posX)^2+(y-posY)^2<=225 then
   	     self.focus[key]=true
   	   else
   	     self.focus[key]=false
   	     self.click[key]=0
   	   end

   	  if self.focus[key] then
         if self.click[key]==0 then--鼠标按键未在此按键范围内没有过任何操作
   	      if love.mouse.isDown(1)==false then--鼠标左键未按下
   	  	   self.click[key]=1
   	      end
         elseif self.click[key]==1 then
   	      if love.mouse.isDown(1) then--鼠标左键按下
   	  	   self.click[key]=2
   	      end
         elseif self.click[key]==2 then
      	  if love.mouse.isDown(1)==false then
      		self:logic(key)
      		self.click[key]=0
      		break
      	  end
         end
   	  end
   	end
end

function equipMenu:draw( ... )
	for i=1,3 do
 	if self.focus[i] then
 		love.graphics.print("focus"..i,100,120)
 	end
    end
    for i=1,#self.equipSlot do
       love.graphics.print(self.equipSlot[i].x.."  "..self.equipSlot[i].y,150,150+i*30) 	-- body
    end
end


 function equipMenu:logic(key)
 	if self.type=="weapon" then
      base.battleShip:equipWeapon(self.item,key)
      base:loseItem(self.item)
      base.ui.itemBox.box:ini(base.item.weapon)
      base.ui.itemBox.activate=true
    end
 	self.activate=false
 end




