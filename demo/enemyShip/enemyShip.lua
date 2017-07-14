enemyShip={}
function enemyShip:new( ... )
	local newShip={
	class="enemyShip",
	name,HP,DEF,SPD,
	id=nil,
	shape={width=100,height=100},
	vertex={{x,y},{x,y},{x,y},{x,y}},
	image,x=0,y=0,rad=0}
    setmetatable(newShip,self)
	self.__index=self
	return newShip
end

function enemyShip:setData(name,hp,ap,def,spd,imageFile)
	self.name=name
	self.HP=hp
	self.AP=ap
	self.DEF=def
	self.SPD=spd
	self.image=love.graphics.newImage(imageFile)
end

function enemyShip:create(x,y)
	self.x=x or 0
	self.y=y or 0
	updateVertex(self)
	if self.id==nil then
	    table.insert(battleFiled.enemyShip,self)
	    self.id=#battleFiled.enemyShip
	else
		battleFiled.enemyShip[self.id]=self
	end
end

function enemyShip:remove( ... )
	for key,value in pairs(battleFiled.enemyShip) do
		if battleFiled.enemyShip[key]==self then
				table.remove(battleFiled.enemyShip,key)
		end
	end
end

function enemyShip:loadAi( ... )
	--头结点为平行节点
	--分为四分支树，分别控制自身的前进或者漂移，自身的方向，自身武器的方向，自身武器的发射
	-- body
end

--战舰的状态更新
function enemyShip:update(dt)
	--计算四个顶点坐标
	self.vertex[1].x=self.x+((-self.shape.width/2)*math.cos(-math.rad(self.rad))+(-self.shape.height/2)*math.sin(-math.rad(self.rad)))
	self.vertex[1].y=self.y+((self.shape.width/2)*math.sin(-math.rad(self.rad))+(-self.shape.height/2)*math.cos(-math.rad(self.rad)))

	self.vertex[2].x=self.x+((self.shape.width/2)*math.cos(-math.rad(self.rad))+(-self.shape.height/2)*math.sin(-math.rad(self.rad)))
    self.vertex[2].y=self.y+((-self.shape.width/2)*math.sin(-math.rad(self.rad))+(-self.shape.height/2)*math.cos(-math.rad(self.rad)))

    self.vertex[3].x=self.x+((-self.shape.width/2)*math.cos(-math.rad(self.rad))+(self.shape.height/2)*math.sin(-math.rad(self.rad)))
    self.vertex[3].y=self.y+((self.shape.width/2)*math.sin(-math.rad(self.rad))+(self.shape.height/2)*math.cos(-math.rad(self.rad)))

    self.vertex[4].x=self.x+((self.shape.width/2)*math.cos(-math.rad(self.rad))+(self.shape.height/2)*math.sin(-math.rad(self.rad)))
    self.vertex[4].y=self.y+((-self.shape.width/2)*math.sin(-math.rad(self.rad))+(self.shape.height/2)*math.cos(-math.rad(self.rad)))
    if self.HP<=1 then
    	self:remove()
    end
end

function enemyShip:draw()
	love.graphics.draw(self.image,self.x,self.y,math.rad(self.rad),1,1,50,50)
	for i=1,4 do
		love.graphics.circle("fill",self.vertex[i].x,self.vertex[i].y,5)
	end
    love.graphics.print("HP:"..self.HP,self.x,self.y+15)
    love.graphics.print("RAD:"..self.rad,self.x,self.y+30)
end