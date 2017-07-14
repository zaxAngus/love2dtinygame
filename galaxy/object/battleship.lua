
-----------------------------------------------------------------------------------------
--游戏玩家可操作对象，战舰的类
local battleship=class(object)
function battleship:ctor()
   --战舰的装备的背包
   self.weapon={}
   self.fighter={}
   self.member={}
   self.cargo={}
   self.x=win_w/2
   self.y=win_h/2
   self.locate_x=1000
   self.locate_y=1000
   self.w=0
   self.h=0
   self.r=0
   self.hp_max=2000
   self.ep_max=2000
   self.spd_max=200
   self.hp=self.hp_max
   self.ep=self.ep_max
   self.spd=self.spd_max
   self.spd=0
   self.turn_l=false
   self.turn_r=false
   self.foward=false
   self.backward=false
   --设置战舰逻辑组件
   local func_logic=function(x,input)
                      if input=="w" then
                         self.forward=not(self.forward)
                         if self.backward then
                           self.backward=not(self.backward)
                         end
                      elseif input=="s" then
                         self.backward=not(self.backward)
                         if self.forward then
                            self.forward=not(self.forward)
                         end
                      elseif input=="a" then
                         self.hp=self.hp-100
                      elseif input=="d" then                  
                      elseif input=="q" then
                         self.turn_l=not(self.turn_l)
                         if self.turn_r then
                            self.turn_r=not(self.turn_r)
                        end
                      elseif input=="e" then
                         self.turn_r=not(self.turn_r)
                         if self.turn_l then
                            self.turn_l=not(self.turn_l)
                         end
                      elseif input=="space" then
                         self.turn_l=false
                         self.turn_r=false
                         self.forward=false
                         self.backward=false
                      end
                    end
   local func_update=function(x)         
      if x.turn_l then
          x.r=x.r-x.spd_max/(2*60)
      elseif x.turn_r then
          x.r=x.r+x.spd_max/(2*60)
      end
      if x.forward then
          if x.spd<x.spd_max then
            x.spd=x.spd+x.spd_max/120
          end
          x.locate_x=x.locate_x+math.sin(math.rad(x.r))*x.spd/60
          x.locate_y=x.locate_y-math.cos(math.rad(x.r))*x.spd/60
      end
      if x.backward then
        if x.spd>-x.spd_max/3 then
            x.spd=x.spd-x.spd_max/120
        end
        x.locate_x=x.locate_x+math.sin(math.rad(x.r))*x.spd/60
        x.locate_y=x.locate_y-math.cos(math.rad(x.r))*x.spd/60
        end  
   end
   local logic_com=logic_component.new(func_logic,func_update,"w","s","a","d","q","e","space")
   self.logic_com=logic_com
   self.logic_com.owner=self
end
local _ships={}
-----------------------------------------------------------------------------------------
--战舰实例
-----------------------------------------------------------------------------------------
--小型战舰
local smallship=class(battleship)
function smallship:ctor()
   self.id=1
   self.name="small ship"
   self.img=love.graphics.newImage("battleship.bmp")
   --战舰的设定值
    self.type="object_battleship_smallship"
    self.name="smallship"
    self.w=60
    self.h=120
   --战舰的基础属性上限
   self.hp_max=2000
   self.ep_max=2000
   self.spd_max=200
   self.hp=self.hp_max
   self.ep=self.ep_max
   self.spd=self.spd_max
   --战舰的各个装备
   self.weapon={
                [1]={x=0,y=0,weapon=nil},
                [2]={x=0,y=30,weapon=nil},
                [3]={x=0,y=-30,weapon=nil},
                }
   --设置战舰绘图组件
   local graphic_com=graphic_component.new(self.img)
   self.graphic_com=graphic_com
   self.graphic_com.owner=self
end
table.insert(_ships,smallship)
-----------------------------------------------------------------------------------------
--大型战舰
local hugeship=class(battleship)
function hugeship:ctor()
   self.id=2
   self.img=love.graphics.newImage("battleship.bmp")
   --战舰的设定值
    self.type="object_battleship_hugeship"
    self.name="hugeship"
    self.w=100
    self.h=240
   --战舰的基础属性
   self.hp_max=5000
   self.ep_max=5000
   self.spd_max=3000
   --战舰的各个装备最大数量
   self.weapon_max=5
   self.fighter_max=5
   self.member_max=5
   --设置战舰绘图组件
   local graphic_com=graphic_component.new(self.img)
   self.graphic_com=graphic_com
   self.graphic_com.owner=self
end
table.insert(_ships,hugeship)
-----------------------------------------------------------------------------------------
return _ships