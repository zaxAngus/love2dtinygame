weapon={}
function weapon:new(cd,cost,w,h,fileName,fileName1,n,t)
	local newWeapon={name=n,
	                 type=t,
                     class="weapon",
	                 CD=cd,CDcount=0,COST=cost,COSTcount=0,x=nil,y=nil,posx=nil,posy=nil,rad=0,width=w,height=h,
	                 fireRad=0,fireTarget={x=nil,y=nil},
	                 bulletCount=0,
	                 spe=func,
	                 bulletConfig={width,height,atk,spd,lifeTime},
	                 img=love.graphics.newImage(fileName),
	                 icon=love.graphics.newImage(fileName1),
	                 firingState={[0]=false,[1]=false,[2]=false,[3]=false},
                     }
	setmetatable(newWeapon,self)
	self.__index=self
	return newWeapon-- body
end

function weapon:setBullet(width,height,atk,spd,lifeTime,bulletCount)
	self.bulletConfig.width=width
	self.bulletConfig.height=height
	self.bulletConfig.atk=atk
	self.bulletConfig.spd=spd
	self.bulletConfig.lifeTime=lifeTime
	self.bulletCount=0
end

function weapon:fireStart(x,y)
	self.fireTarget.x=x
	self.fireTarget.y=y
	if self.firingState[0]==true then
	   self.firingState[1]=true
	end
end
function weapon:fireEnd()
	self.firingState[2]=false 
	self.firingState[3]=true
end
function weapon:fireBullet()
    local newBullet=bullet:new(self.bulletConfig.width,self.bulletConfig.height,
    	                       self.bulletConfig.atk,self.bulletConfig.spd,self.bulletConfig.lifeTime,
    	                       self.fireRad,self.posx,self.posy)
	table.insert(battleFiled.bullet,newBullet)
	self.bulletCount=self.bulletCount+1

end

function weapon:update(dt,x,y,rad)
	self.posx=x
	self.posy=y
	self.rad=rad
	if self.firingState[0]==false then
		self.fireRad=rad
	    self.COSTcount=self.COSTcount+dt
	    if self.COSTcount>=self.COST then
	   	   self.COSTcount=0
	   	   self.firingState[0]=true
	    end
	elseif self.firingState[1] then
		local targetRad=PointPointRad(self.posx,self.posy,self.fireTarget.x,self.fireTarget.y)
		local dr=1
	   	if  self.fireRad-targetRad>=2 or self.fireRad-targetRad<=-2 then
		   if targetRad-self.fireRad>180 or targetRad-self.fireRad<0 and targetRad-self.fireRad>-180 then
	           if self.fireRad-dr<=0 then
		          self.fireRad=360+self.fireRad-dr
	           else
	               self.fireRad=self.fireRad-dr
	           end
		   else
	          if self.fireRad+dr>=359 then
		          self.fireRad=dr+self.fireRad-360
	          else
	              self.fireRad=self.fireRad+dr
	          end
		   end
		else
			  self.firingState[1]=false
			  self.firingState[2]=true
	    end
   elseif self.firingState[2] then
   	    self.fireRad=PointPointRad(self.posx,self.posy,self.fireTarget.x,self.fireTarget.y)
	    self.CDcount=self.CDcount+dt
	    if self.CDcount>=self.CD then
	   	   self.CDcount=0
	   	   self:fireBullet()
	    end
	    if self.bulletCount==100 then
	       self.firingState[2]=false
	       self.firingState[3]=true
	    end
   elseif self.firingState[3] then
		local dr=1
	   	if  self.fireRad-self.rad>=2 or self.fireRad-self.rad<=-2 then
		   if self.rad-self.fireRad>180 or self.rad-self.fireRad<0 and self.rad-self.fireRad>-180 then
	           if self.fireRad-dr<=0 then
		          self.fireRad=360+self.fireRad-dr
	           else
	               self.fireRad=self.fireRad-dr
	           end
		   else
	          if self.fireRad+dr>=359 then
		          self.fireRad=dr+self.fireRad-360
	          else
	              self.fireRad=self.fireRad+dr
	          end
		   end
		else
			self.firingState[3]=false
			self.firingState[0]=false
			self.bulletCount=0
		end
   else
   		self.fireRad=rad
   end
end


function weapon:draw(x,y,r )
	   self.posx=x or self.posx
	   self.posy=y or self.posy
	   self.fireRad=r or self.fireRad
	   if x and y and r then
	   	  love.graphics.draw(self.img,self.posx,self.posy,math.rad(self.fireRad),1,1,self.width/2,self.height/2)
	   	else
	   love.graphics.draw(self.img,self.posx,self.posy,math.rad(self.fireRad),1,1,self.width/2,self.height/2)
       end
end

bullet={}
function bullet:new(w,h,a,s,l,r,x,y,func1,func2,image)
	local  newBullet={
	       class="bullet",
	       img=love.graphics.newImage("ResourceWeapon/bulletTEST.bmp"),
	       shape={width=w,height=h},
	       vertex={{x,y},{x,y},{x,y},{x,y}},
	       atk=a,spd=s,lifeTime=l,rad=r,posX=x,posY=y,id=nil,
	       }
    setmetatable(newBullet,self)
    self.__index=self
    return newBullet
end

function bullet:update(dt)
	self.vertex[1].x=self.posX+((-self.shape.width/2)*math.cos(-math.rad(self.rad))+(-self.shape.height/2)*math.sin(-math.rad(self.rad)))
	self.vertex[1].y=self.posY+((self.shape.width/2)*math.sin(-math.rad(self.rad))+(-self.shape.height/2)*math.cos(-math.rad(self.rad)))

	self.vertex[2].x=self.posX+((self.shape.width/2)*math.cos(-math.rad(self.rad))+(-self.shape.height/2)*math.sin(-math.rad(self.rad)))
    self.vertex[2].y=self.posY+((-self.shape.width/2)*math.sin(-math.rad(self.rad))+(-self.shape.height/2)*math.cos(-math.rad(self.rad)))

    self.vertex[3].x=self.posX+((-self.shape.width/2)*math.cos(-math.rad(self.rad))+(self.shape.height/2)*math.sin(-math.rad(self.rad)))
    self.vertex[3].y=self.posY+((self.shape.width/2)*math.sin(-math.rad(self.rad))+(self.shape.height/2)*math.cos(-math.rad(self.rad)))

    self.vertex[4].x=self.posX+((self.shape.width/2)*math.cos(-math.rad(self.rad))+(self.shape.height/2)*math.sin(-math.rad(self.rad)))
    self.vertex[4].y=self.posY+((-self.shape.width/2)*math.sin(-math.rad(self.rad))+(self.shape.height/2)*math.cos(-math.rad(self.rad)))

	self.lifeTime=self.lifeTime-dt
	if self.lifeTime<=0 then
		for key,value in pairs(battleFiled.bullet) do
			if battleFiled.bullet[key]==self then
				table.remove(battleFiled.bullet,key)
			end
		end
	end
	local direction=math.rad(self.rad)
	self.posX=self.posX+self.spd*math.sin(direction)
	self.posY=self.posY-self.spd*math.cos(direction)
end

function bullet:draw()
	love.graphics.draw(self.img,self.posX,self.posY,math.rad(self.rad),1,1,self.shape.width/2,self.shape.height/2)

end 
function bullet:clear()

	for key,value in pairs(battleFiled.bullet) do
	    if battleFiled.bullet[key]==self then
				table.remove(battleFiled.bullet,key)
			end
		end
end

function bullet:hit(target)
	target.HP=target.HP-1
end

require('battleShip.weapons')