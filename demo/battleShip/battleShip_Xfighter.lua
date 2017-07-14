fighter={class="Fighter"}
function fighter:new(n,hp,spd)
	local newFighter={name=n,
	                  img=love.graphics.newImage("ResourceFighter/fighter.bmp"),
                      HP=hp,SPD=spd,
                      x,y,rad=0,baseX,baseY,offtime=0.5,
                      shape={width=50,height=50},
                      vertex={[1]={x,y},[2]={x,y},[3]={x,y},[4]={x,y}},
                      weapon={max=2,[1]={x,y},[2]={x,y}},
                      status={offing=false,activate=false},
                      detectRange=200,
                      ai={}
                      }
    setmetatable(newFighter,self)
    self.__index=self
    return newFighter
end

function fighter:move()
	local direction=math.rad(self.rad)
	local x=-math.sin(direction)*self.SPD
	local y=math.cos(direction)*self.SPD
	self.x=self.x-x
	self.y=self.y-y
end
function fighter:takeOff(rad,takeoffrad)
	table.insert(battleFiled.xfighter,self)
	self.status.offing=true
	self.rad=rad+takeoffrad
end
function fighter:loadAi()
  self.ai=BTTree
  self.ai.root=BTNode_sequence:new()
  self.ai.root.children[1]=BTNode_condition_enemyDetect:new()
  self.ai.root.children[2]=BTNode_action_move:new()
  self.ai.root:setOwner(self)
end

function fighter:update(dt,basex,basey)
	updateVertex(self)
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
	----------
    if self.status.offing~=true and self.status.activate~=true then
    	self.x=basex
    	self.y=basey
    end
	if self.status.offing and self.status.activate~=true then
		self.offtime=self.offtime-dt
		self:move()
		if self.offtime<=0 then
			self.status.offing=false
			self.status.activate=true
			self.offtime=0.5
		end
	end
	if self.status.activate then
		self.ai:update()
	end
end
function fighter:draw( ... )
	if self.status.activate or self.status.offing then
	for i,value in ipairs(self.weapon) do
    	love.graphics.print(self.weapon[i].name..self.weapon[i].x.." "..self.weapon[i].y,self.x,self.y+50+i*15)
    	self.weapon[i]:draw()
    end
    love.graphics.print(tostring(self.ai.root.status),self.x,self.y+90)
	for i=1,4 do
		love.graphics.circle("fill",self.vertex[i].x,self.vertex[i].y,2)
	end
	   love.graphics.draw(self.img,self.x,self.y,math.rad(self.rad),0.5,0.5,50,50)
	end


end
--设置武器槽位
function fighter:setWeaponSlot( ... )
	local j=1
	local num=clone({ ... })
	for i=1,#num,2 do
		if j<=self.weapon.max then
		   self.weapon[j].x=num[i]
		   self.weapon[j].y=num[i+1]
	    end
	    j=j+1
	end
end

function fighter:equipWeapon(weapon,slot)
	local temp=clone(weapon)
	temp.x=self.weapon[slot].x
	temp.y=self.weapon[slot].y
    self.weapon[slot]=temp
end

function fighter:unequipWeapon(pos)

end

function fighter:move()
	local direction=math.rad(self.rad)
	local x=-math.sin(direction)*(-self.SPD)
	local y=math.cos(direction)*(-self.SPD)
	self.x=self.x+x
	self.y=self.y+y
end


