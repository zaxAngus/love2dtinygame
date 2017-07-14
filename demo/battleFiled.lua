battleFiled={battleShip={},enemyShip={},bullet={},enemyBullet={},xfighter={},hitcount=0}
function battleFiled:update(dt)
  local timestate
  timestate=gametime:update(dt)
  if timestate then 

      for key,value in pairs(self.battleShip) do
      	  self.battleShip[key]:update(dt)
      end

      for key,value in pairs(self.bullet) do
      	  self.bullet[key]:update(dt)
      end

      for key,value in pairs(self.enemyShip) do
      	  self.enemyShip[key]:update(dt)
      end
      for key,value in pairs(self.enemyBullet) do
      	  self.enemyBullet[key]:update(dt)
      end
      self:collision()
  end
  if love.keyboard.isDown("escape") then
  	battleFiled:battleEnd()
  end
end

function battleFiled:battleEnd()
	table.remove(self.battleShip)
	for key,value in pairs(self.enemyShip) do
		table.remove(self.enemyShip)
	end
	for key,value in pairs(self.bullet) do
		table.remove(self.bullet)
	end
	for key,value in pairs(self.enemyBullet) do
		table.remove(self.enemyBullet)
	end
	for key,value in pairs(self.xfighter) do
		table.remove(self.xfighter)
	end

	gameState=1
end

function battleFiled:draw()

	if #self.battleShip>0 then
		for i=1,#self.battleShip do
			self.battleShip[i]:draw()
		end
	end
	if #self.enemyShip>0 then
		for i=1,#self.enemyShip do
			self.enemyShip[i]:draw()
		end
	end
	if #self.bullet>0 then
		for i=1,#self.bullet do
			self.bullet[i]:draw()
		end
	end
	if #self.enemyBullet>0 then
		for i=1,#self.enemyBullet do
			self.enemyBullet[i]:draw()
		end
	end
	if #self.xfighter>0 then
		for i=1,#self.xfighter do
			self.xfighter[i]:draw()
		end
	end
	if #self.bullet>0 then
	love.graphics.print(self.bullet[1].vertex[1].x,400,400)
    end
end

function battleFiled:collision()--可优化，考虑四叉树
	if #self.battleShip>=1 then
		if #self.enemyShip>=1 then
			for i=1,#self.battleShip do
				for j=1,#self.enemyShip do
					if self:collisionDetect(self.battleShip[i].vertex,
					                        self.enemyShip[j].vertex) then --检测到战舰和敌方飞船相撞
						self.hitcount=self.hitcount+1
					end
				end
			end
	    end
	if #self.enemyBullet>=1 then
			for i=1,#self.battleShip do
				for j=1,#self.enemyBullet do
					if self:collisionDetect(self.battleShip[i].vertex,
					                        self.enemyBullet[j].vertex) then --检测到战舰被击中

					end
				end
			end
	    end
	end
	for key1,v in ipairs(self.xfighter) do
			for key2, v in ipairs(self.enemyShip) do
				if self:collisionDetect(self.xfighter[key1].vertex,
				                        self.enemyShip[key2].vertex) then --检测到战机撞击敌方飞船
					self.hitcount=self.hitcount+1

				end

			end
	 end
	for key1,v in ipairs(self.bullet) do
			for key2, v in ipairs(self.enemyShip) do
				if self:collisionDetect(self.bullet[key1].vertex,
				                        self.enemyShip[key2].vertex) then --检测到战舰击中敌方飞船
					self.hitcount=self.hitcount+1
					self.bullet[key1]:hit(self.enemyShip[key2])
					self.bullet[key1]:clear()
				end

			end
	 end
end

function battleFiled:collisionDetect(object1,object2)
	local t1=object1
	local t2=object2
	for i=1,2 do
		local dot={x1,x2,x3,x4}
		local max=-1
	    local min=1000
		local k1=(t1[i].y-t1[i+i].y)/(t1[i].x-t1[i+i].x)
		local k2=-1/k1
		local b1=t1[i].y-k1*t1[i].x
		for j=1,4 do
			local b2
			b2=t2[j].y-k2*t2[j].x
			dot[j]=(b2-b1)/(k1-k2)
			if dot[j]>max then
			   max=dot[j]
		    end
		    if dot[j]<min then
			   min=dot[j]
		    end
		end
		if min>t1[i].x and min>t1[i+i].x then
		   return false
		elseif	max<t1[i].x and max<t1[i+i].x then
		   return false
		end
    end
    return true
end 