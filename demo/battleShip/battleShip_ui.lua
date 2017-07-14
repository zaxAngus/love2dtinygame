--战舰的状态ui注册及消除
function battleShip:stateUiIni()
	self.stateUi.State.HP=stateBar:new(1150,10,100,40,"HP",100,100,0,255,0,100)
	self.stateUi.State.SHI=stateBar:new(1150,60,100,40,"SHI",100,100,0,0,255,100)
	self.stateUi.Button.inTurn=button:new(1220,680,50,20,"Command",nil,
		function ()
			if self.turnPoint>=1 then
			if  gametime.running then
			self:inTurn()
		    end
		    end
		    self:inTurn()
		end)
end
function battleShip:stateUiRegist()
	self.stateUi.State.HP:outCameraRegist()
	self.stateUi.State.SHI:outCameraRegist()
	self.stateUi.Button.inTurn:outCameraRegist()
end
function battleShip:stateUiunRegist()
	self.stateUi.State.HP:outCameraUnRegist()
	self.stateUi.State.SHI:outCameraUnRegist()
    self.stateUi.Button.inTurn:outCameraUnRegist()
end
--战舰战斗ui注册及消除
function battleShip:battleUi_fireIni()
    --玩家回合攻击指令
    self.battleUi.fire[1]=button:new(0,0,50,20,"Weapon",nil,function()
        for key,value in pairs(self.battleUi) do
            if self.battleUi[key][1] then
            self.battleUi[key][1]:inCameraUnRegist()
            end
        end
        for i=1,self.weapon.max do
            self.battleUi.fire[2][i]=button:new(0,0,50,20,self.weapon[i].name or "slot"..i,nil,function()
                for key ,value in pairs(self.battleUi.fire[2]) do
                    self.battleUi.fire[2][key]:inCameraUnRegist()
                end
                if self.weapon[i].class=="weapon" then
                self.battleUi.fire[3][i]:inCameraRegist(self.weapon[i].posx,self.weapon[i].posy)
                end
            end)
            self.battleUi.fire[3][i]=turnTable:new(0,0,50,function()
                self.weapon[i]:fireStart(love.mouse.getX()+camera.x,love.mouse.getY()+camera.y)
                self.battleUi.fire[3][i]:inCameraUnRegist()
                self:endTurn()
            end)
            self.battleUi.fire[2][i]:inCameraRegist(self.x+100,self.y+(i-1)*30)
        end
    end)
end
function battleShip:battleUi_fighterIni()
        self.battleUi.fighter[1]=button:new(0,0,50,20,"Xfighter",nil,
        function()
            --清除第一级菜单
            for key,value in pairs(self.battleUi) do
                if self.battleUi[key][1] then
                   self.battleUi[key][1]:inCameraUnRegist()
                end
            end
            --生成第二级菜单
            self.battleUi.fighter[2][1]=button:new(0,0,50,20,"takeofff",nil,
            function()
                for key ,value in pairs(self.battleUi.fighter[2]) do
                    self.battleUi.fighter[2][key]:inCameraUnRegist()
                end
                self:fighterTakeOff()
                self:endTurn()
            end)
            self.battleUi.fighter[2][2]=button:new(0,0,50,20,"land",nil,
            function()
                for key ,value in pairs(self.battleUi.fighter[2]) do
                    self.battleUi.fighter[2][key]:inCameraUnRegist()
                end
                self:fighterLand()
                self:endTurn()
            end)
            for i=1,2 do
                self.battleUi.fighter[2][i]:inCameraRegist(self.x+100,self.y+(i-1)*30)
            end
        end)
end
function battleShip:battleUi_engineIni()
    self.battleUi.engine[1]=button:new(0,0,50,20,"engine",nil,
    function ( ... )
        --清除第一级菜单
        for key,value in pairs(self.battleUi) do
            if self.battleUi[key][1] then
                self.battleUi[key][1]:inCameraUnRegist()
            end
        end
        --生成第二级菜单
        self.battleUi.engine[2][1]=button:new(0,0,50,20,"activate",nil,
        function()
            for key ,value in pairs(self.battleUi.engine[2]) do
                self.battleUi.engine[2][key]:inCameraUnRegist()
            end
            self.state.forwading=true
            self:endTurn()
        end)
        self.battleUi.engine[2][2]=button:new(0,0,50,20,"stop",nil,
        function()
            for key ,value in pairs(self.battleUi.engine[2]) do
                self.battleUi.engine[2][key]:inCameraUnRegist()
            end
            self.state.forwading=false
            self:endTurn()
        end)
        for i=1,2 do
            self.battleUi.engine[2][i]:inCameraRegist(self.x+100,self.y+(i-1)*30)
        end
    end)
end
function battleShip:battleUi_directIni()
    self.battleUi.direct[1]=button:new(10,10,50,20,"Direct",nil,function()
        for key,value in pairs(self.battleUi) do
            if self.battleUi[key][1] then
            self.battleUi[key][1]:inCameraUnRegist()
            end
        end
        self.battleUi.direct[2]=turnTable:new(0,0,50,function()
            local r=MousePointRad(self.x-camera.x,self.y-camera.y)
            self:setR(r)
            self.battleUi.direct[2]:inCameraUnRegist()
            self:endTurn()      -- body
        end)
            self.battleUi.direct[2]:inCameraRegist(self.x,self.y)
    end)
end
function battleShip:battleUiIni()
    self:battleUi_fireIni()
    self:battleUi_fighterIni()
    self:battleUi_engineIni()
    self:battleUi_directIni()
end
function battleShip:battleUiRegist()
   local i=0
   for key,value in pairs(self.battleUi) do
       if self.battleUi[key][1] then
   	       value[1]:inCameraRegist(self.x+100,self.y+100-i*30)
   	       i=i+1
       end
   end
end

function battleShip:battleUiunRegist()
   for key,value in pairs(self.battleUi) do
       for key1,value in pairs(self.battleUi[key]) do
            if self.battleUi[key][key] then
               self.battleUi[key][key]:inCameraUnRegist()
            end
        end
   end 
end