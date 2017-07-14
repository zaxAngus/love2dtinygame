--战舰移动
function battleShip:move()
	local direction=math.rad(self.rad)
	local x=-math.sin(direction)*(-self.SPD)
	local y=math.cos(direction)*(-self.SPD)
	self.x=self.x+x
	self.y=self.y+y
end
-----------------------------------------------------
--战舰转向
function battleShip:setR(r)
	self.targetRad=r
end
function battleShip:turnR(dr)
	if self.rad+dr>=359 then
		self.rad=dr+self.rad-360
	else
	   self.rad=self.rad+dr
	end
end
function battleShip:turnL(dr)
	if self.rad-dr<=0 then
		self.rad=360+self.rad-dr
	else
	   self.rad=self.rad-dr
	end
end
------------------------------------------------------
--战舰进入回合
function battleShip:inTurn()
	self.turnPoint=self.turnPoint-1
	self:battleUiRegist()
	gametime:stop()
end
--战舰回合结束
function battleShip:endTurn()
   gametime:start()
   self:battleUiunRegist()
end
------------------------------------------------------
--战舰舰载机起飞
function battleShip:fighterTakeOff()
	for key,value in ipairs(self.fighter) do
		if self.fighter[key].class then
	        self.fighter[key]:takeOff(self.rad,self.fighter.takeoffRad)
	    end
	end
end
function battleShip:fighterLand()
	for key,value in pairs(self.fighter) do
		if self.fighter[key].class then
	        self.fighter[key]:takeOff(self.rad,self.takeoffRad)
	    end
	end
end
