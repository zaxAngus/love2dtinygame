battleShip={class="battleShip",
	name,HP,AP,DEF,SPD,SIZE,turnPoint=0,
	shape={width=60,height=120},
	vertex={{x,y},{x,y},{x,y},{x,y}},
	image,logo,x,y,rad=0,targetRad=0,
	lastTime=0,
	member={captain=nil,gunner=nil,engineer=nil},
	state={fowarding=false},
	weapon={max},
	fighter={max=10,takeoffRad=0,takeoffPoint={x,y}},
	stateUi={memberState,skillState,State={},Button={}},
    battleUi={fire={[1]={},[2]={},[3]={}},
              fighter={[1]={},[2]={},[3]={}},
              direct={[1]={},[2]={}},
              engine={[1]={},[2]={}}
             }}
function battleShip:new()
	local newShip={}
    setmetatable(newShip,self)
	self.__index=self
	return newShip-- body 
end
--战舰属性初始化
function battleShip:setData(name,width,height,hp,ap,def,spd,size,imageFile)
	self.name=name
	self.shape.width=width
	self.shape.height=height
	self.HP=hp
	self.AP=ap
	self.DEF=def
	self.SPD=spd
	self.weapon.max=size
	for i=1,size do
		self.weapon[i]={x,y}
	end
	self.image=love.graphics.newImage(imageFile)
	self:stateUiIni()
	self:stateUiRegist()
	self:battleUiIni()
end
--设置武器槽位
function battleShip:setWeaponSlot( ... )
	local j=1
	local num={}
	for i,value in ipairs({...}) do
		num[i]=value
	end
	for i=1,#num,2 do
		if j<=self.weapon.max then
		   self.weapon[j].x=num[i]
		   self.weapon[j].y=num[i+1]
	    end
	    j=j+1
	end
end
--设置战机槽位
function battleShip:setFighterSlot(r,x,y)
	self.fighter.takeoffRad=r
	self.fighter.takeoffPoint.x=x
	self.fighter.takeoffPoint.y=y
end

--战舰存档
--战舰读取
--战舰生成
function battleShip:create(x,y)
	self.x=x or 640
	self.y=y or 360
	updateVertex(self)
	table.insert(battleFiled.battleShip,self)
end

function battleShip:remove( ... )
end


--战舰的状态更新
function battleShip:update(dt)
	--碰撞边界更新
	updateVertex(self)
	------------------
	--武器更新
	for i,value in pairs(self.weapon) do
		if type(self.weapon[i])=="table" then
			if self.weapon[i].class=="weapon" then
			   local x,y
			   x=self.x+((-self.weapon[i].x)*math.cos(-math.rad(self.rad))+(-self.weapon[i].y)*math.sin(-math.rad(self.rad)))
	           y=self.y+((self.weapon[i].x)*math.sin(-math.rad(self.rad))+(-self.weapon[i].y)*math.cos(-math.rad(self.rad)))
		       self.weapon[i]:update(dt,x,y,self.rad)
		    end
	    end
	end
	------------------
	--舰载机更新
	for i,value in pairs(self.fighter) do
		if type(self.fighter[i])=="table" then
		   if self.fighter[i].class=="Fighter" then
			  self.fighter[i]:update(dt,self.x+self.fighter.takeoffPoint.x,self.y-self.fighter.takeoffPoint.y)
		    end
	    end
	end
	------------------
	--前进状态更新
	if self.state.forwading then
		self:move(-self.SPD)
	end
	------------------
	--旋转角度更新
	if  self.rad-self.targetRad>=1 or self.rad-self.targetRad<=-1 then
		if self.targetRad-self.rad>180 or self.targetRad-self.rad<0 and self.targetRad-self.rad>-180 then
			self:turnL(1)
		else
			self:turnR(1)
		end	
	end 

	if love.keyboard.isDown('up') then
		self:move(-self.SPD)
	end
	------------------
	--命令点数更新
	local time=gametime:getTime()
	if time-self.lastTime>500/self.AP then
		self.lastTime=time
		if self.turnPoint<=2 then
		 self.turnPoint=self.turnPoint+1
	    end
	end
end
--战舰绘制
function battleShip:draw()
	love.graphics.draw(self.image,self.x,self.y,math.rad(self.rad),1,1,self.shape.width/2,self.shape.height/2)
	for i=1,4 do
		love.graphics.circle("fill",self.vertex[i].x,self.vertex[i].y,2)
	end

	if self.state.forwading then
       love.graphics.print("moving",self.x,self.y+100)
    else
       love.graphics.print("notmoving",self.x,self.y+100)
    end

    for i,value in ipairs(self.weapon) do
    	if self.weapon[i].class=="weapon" then
    	love.graphics.print(self.weapon[i].name,self.x,self.y+130+i*15)
    	 self.weapon[i]:draw()
    	end
    end

    for i,value in ipairs(self.fighter) do
    	 love.graphics.print(self.fighter[i].name..tostring(self.fighter[i].status.offing)..self.fighter[i].rad,self.x,self.y+130+#self.weapon*15+i*15)
    end
    
    love.graphics.print("HP:"..self.HP,self.x,self.y+115)
    love.graphics.print("RAD:"..self.rad,self.x,self.y+130)

    local x=love.mouse.getX()-self.x+camera.x
    local y=self.y-camera.y-love.mouse.getY()
    local r=math.deg(math.atan(x/y))
    if x>0 and y>0 then
    	r=r
    elseif y<0 then
    	r=180+r
    elseif x<0 and y>0 then
    	r=360+r
    end

end

function battleShip:baseDraw( ... )
	love.graphics.draw(self.image,640,360,math.rad(45),1,1,self.shape.width/2,self.shape.height/2)
	for i,value in ipairs(self.weapon) do
		local x,y
		x=640+((-self.weapon[i].x)*math.cos(-math.rad(45))+(-self.weapon[i].y)*math.sin(-math.rad(45)))
	    y=360+((-self.weapon[i].x)*math.sin(-math.rad(45))+(-self.weapon[i].y)*math.cos(-math.rad(45)))
    	if self.weapon[i].class=="weapon" then
    	 self.weapon[i]:draw(x,y,45)
    	else
    	 	local r,g,b,a=love.graphics.getColor()	
            love.graphics.setColor(150,100,100,100)
    	    love.graphics.circle("line",x,y,15)
    	 	love.graphics.setColor(r,g,b,a)
    	end

    end
	-- body
end

require('battleShip.battleShip_ui')
require('battleShip.battleShip_equippment')
require('battleShip.battleShip_weapon')
require('battleShip.battleShip_movement')
require('battleShip.battleShip_Xfighter')
require('battleShip.ships')
