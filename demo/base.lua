base={              
       ui={button={},itemBox={activate=false,box},equipMenu={}},
       battleShip=clone(smallShip),
       item={ship={},weapon={[1]=clone(machineGun)},
       fighter={},member={}},
      }
base.ui.button[1]=button:new(400,20,50,50,"Ships  ",nil,
	function()
    base.ui.itemBox.box:ini(base.item.ship)
    base.ui.itemBox.activate=true
    end)
base.ui.button[2]=button:new(480,20,50,50,"Weapons  ",nil,
	function ()
  base.ui.itemBox.box:ini(base.item.weapon)
  base.ui.itemBox.activate=true

	-- body
    end)
base.ui.button[3]=button:new(560,20,50,50,"Fighters  ",nil,
	function( ... )
  base.ui.itemBox.box:ini(base.item.fighter)
  base.ui.itemBox.activate=true
	-- body
    end)
base.ui.button[4]=button:new(650,20,50,50,"Members  ",nil,
  function( ... )
  base.ui.itemBox.box:ini(base.item.member)
  base.ui.itemBox.activate=true
  -- body
    end)
base.ui.button[5]=button:new(730,20,50,50,"BattleTeam  ",nil,
  function( ... )
  -- body
    end)
base.ui.button[6]=button:new(810,20,50,50,"Settings  ",nil,
  function( ... )
  -- body
    end)

base.ui.button[7]=button:new(600,700,80,20," next stage ",nil,
  function( ... )
  base:battleStart()
    end)

base.ui.itemBox.box=itemBox:new()
base.ui.equipMenu.weapon=equipMenu:new("weapon",base.battleShip)

function base:save( ... )
	-- body
end

function base:load( ... )
	-- body
end

function base:update(dt)
	local x=love.mouse.getX()
	local y=love.mouse.getY()
	for key,value in pairs(self.ui.button) do
		value:outCameraUpdate(x,y)
	end
  if self.ui.itemBox.activate then
    self.ui.itemBox.box:outCameraUpdate(x,y)
  end
  if self.ui.equipMenu.weapon.activate then
    self.ui.equipMenu.weapon:outCameraUpdate(x,y)
  end
end

function base:draw()
	for key,value in pairs(self.ui.button) do
		value:draw()
	end
  if self.ui.itemBox.activate then
    self.ui.itemBox.box:draw()
  end
    self.battleShip:baseDraw()

  if base.ui.equipMenu.weapon.activate then
    self.ui.equipMenu.weapon:draw()
    love.graphics.print("menu activate",100,100)
  end
end
inship={}
function base:battleStart()	  
  -------------------------------------------
  --背景生成
  gametime:start()
  --玩家数据设置加载进入战场
  base.battleShip.x=640
  base.battleShip.y=360
  smallShip:create(640,360)


  -------------------------------------------
  --[[战斗机生成然后装备到PLYAER舰上
  testfighter=fighter:new("test",0,5)
  testfighter:setWeaponSlot(-30,0,30,0)
  testfighter:equipWeapon(testweapon1,1)
  testfighter:equipWeapon(testweapon2,2)
  testfighter:loadAi()]]
  -------------------------------------------
  --敌人生成
  enemy1=enemyShip:new()
  enemy1:setData("enemy1",100,100,100,2, "ResourceCharacter/enemy1.bmp")
  enemy1:create()
  gameState=2
end


function base:getItem(item)
   if item.class=="weapon" then
      table.insert(self.itemBox.weapon,item)
   elseif item.class=="fighter"  then
      table.insert(self.itemBox.fighter,item)
   elseif item.class=="member" then
      table.insert(self.itemBox.member,item)
   end
end

function base:loseItem(item)
  for key1,value in pairs(self.item) do
    for key2,value in pairs(self.item[key1]) do
      if self.item[key1][key2]==item then
        table.remove(self.item[key1],key2)
      end
    end
  end
end


