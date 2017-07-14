--------------------------------
local game=class()

function game:ctor()
   self.state=1
   self.time=0
   self.user=player.new()
   self.map=require"map.map"
   self.interface=require"user_interface.interface"
   self.main_object=nil
   self.side_object={}
   self.ui_object={}--需要响应输入的UI，如按键等
   self.ui_object_static={}--无需响应输入的UI，如状态栏等
   self.background=nil
end
--------------------------------------------------------------------------
function game:load()
   self:create_menu()
end
--------------------------------------------------------------------------
function game:update(dt)--一般更新，处理物理现象和绘图更新
  if self.state==3 then
    ----------
    --更新玩家操作对象
    self.main_object:update()
    -----------
    --更新地图
    local x,y=self.main_object.locate_x,self.main_object.locate_y
    self.map:update(x,y)
    -------------
    --更新静默UI
    for key,value in pairs(self.ui_object_static) do
        value:update(dt)
    end
  end
end
--------------------------------------------------------------------------
function game:update_input(type,...)--输入更新，有输入的时候更新
  if type=="mousepress" then
    for key,value in pairs(self.ui_object) do
        value:mousepressed(...)
    end
  elseif type=="mousemove" then
   for key,value in pairs(self.ui_object) do
        value:mousemoved(...)
   end
  elseif type=="keypressed" then
   for key,value in pairs(self.ui_object) do
        value:keypressed(...)
   end
   if self.state==3 then--如果是出航战斗界面
      self.main_object.logic_com:keypressed(...)
   end
  end
end
--------------------------------------------------------------------------
function game:draw()
    if self.background then
       love.graphics.draw(self.background,0,0)
    end
    ---------------------------------------------------------------
    for key,value in pairs(self.ui_object) do
        value:draw(dt)
    end
    ----------------------------------------------------------------
    if self.state==3 then
        self.map:draw()
        for key,value in pairs(self.side_object) do
            value:draw()
        end
        self.main_object:draw()
        for key,value in pairs(self.ui_object_static) do
            value:draw(dt)
        end
     ----------------------------------------------------------------       
        love.graphics.print("ui object num:"..#self.ui_object,0,0)
        love.graphics.print("Fps:"..love.timer.getFPS(),0,20)
        love.graphics.print("main object:"..self.main_object.name,150,0)
        love.graphics.print((math.floor(self.main_object.locate_x) or "nil").." "
                                ..(math.floor(self.main_object.locate_y) or "nil").." "
                                ..(self.main_object.spd or "nil"),150,20)
        if self.main_object.logic_com then
            love.graphics.print("l com exist",150,40)
        else
            love.graphics.print("l com not exist",150,40)
        end
        if self.main_object.graphic_com then
            love.graphics.print("g com exist "
                                    ..(self.main_object.graphic_com.x or "nil").." "
                                    ..(self.main_object.graphic_com.y or "nil").." "
                                    ..(self.main_object.graphic_com.w or "nil").." "
                                    ..(self.main_object.graphic_com.h or "nil"),150,60)
        else
            love.graphics.print("g com not exist",150,60)
        end
        if self.main_object.physic_com then
            love.graphics.print("p com exist",150,80)
        else
            love.graphics.print("p com not exist",150,80)
        end
        love.graphics.print("turn_l: "..tostring(self.main_object.turn_l),150,100)
        love.graphics.print("turn_r: "..tostring(self.main_object.turn_r),150,120)
        love.graphics.print("forward: "..tostring(self.main_object.forward),150,140)
        love.graphics.print("backward: "..tostring(self.main_object.backward),150,160)
        love.graphics.print("hp"..self.main_object.hp.."/"..self.main_object.hp_max,150,180)
        ----------------------------------------------------------------
    end
       
end
--------------------------------------------------------------------------
function game:create_menu()--生成游戏主菜单界面（开始游戏，继续游戏）,1
   self:clear()
   self.interface[1]:create(self)
end
--------------------------------------------------------------------------
function game:create_base()--生成游戏基地界面(根据玩家PLAYER数据，及该基地的数据),2
   self:clear()
   self.interface[2]:create(self)
end
--------------------------------------------------------------------------
function game:create_world()--生成游戏界面（包括物理世界，战斗时UI),3
    self:clear()
    self.main_object=self.user.ship
    local x,y=self.main_object.locate_x,self.main_object.locate_y
    self.map:ini(x,y)
    self.interface[3]:create(self)
end
--------------------------------------------------------------------------
function game:clear()--清空当前界面
   self.background=nil
   self.main_object={}
   self.ui_object={}
end
--------------------------------------------------------------------------
function game:clear_ui()
   self.ui_object={}
end
--------------------------------------------------------------------------
function game:clear_main_object()
  self.main_object={}
end
--------------------------------------------------------------------------
return game




