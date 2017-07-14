--游戏对象基类，一个游戏对象可包含三个组件，分别是物理，逻辑，和图像组件
object=class()
function object:ctor(name,posX,posY,width,height,rad)
    self.type="object"
    self.name=name
    self.owner=nil
    self.w=width
    self.h=height
    self.x=posX
    self.y=posY
    self.r=rad
    self.graphic_com=nil
    self.physic_com=nil
    self.logic_com=nil
end

function object:update(dt)
   if self.logic_com then
     self.logic_com:update(dt)
   end
   if self.phsic_com then
     self.physic_com:update(dt)
   end
   if self.graphic_com then
     self.graphic_com:update(self.x,self.y,self.w,self.h,self.r)
   end
end
function object:draw()
   if self.graphic_com then
     self.graphic_com:draw()
   end
end

-----------------------------------------------------------------------------------------
--对象的逻辑组件，有逻辑组件的对象能对某种输入作出响应
logic_component=class()
function logic_component:ctor(func_input,func_update,...)
    self.type="logic_com"
    self.owner=nil
    self.key={...}
    --对键盘的检测函数
    self.test_key=function (key,key_input)
                    if key==key_input then
                        return true
                    end
                  end
    --检测到键盘输入后的逻辑函数，self.KEY有几个值就应该有多少个IFELSE
    self.logic_key=func_input
    self.func_update=func_update
end
function logic_component:update()
   self.func_update(self.owner)
end
function logic_component:draw()
end
function logic_component:keypressed(...) 
    for i=1,#self.key do
       if self.test_key(self.key[i],...) then
          self.logic_key(self,self.key[i])
       end
    end
end
-----------------------------------------------------------------------------------------
--对象的物理组件，有物理组件的对象在地图上进行碰撞检测
--[[physic_component=class()
function physic_component:ctor()
    self.type="physic_com"
    self.owner=nil
    self.vertex={
                  [1]={x=nil,y=nil},
                  [2]={x=nil,y=nil},
                  [3]={x=nil,y=nil},
                  [4]={x=nil,y=nil}
                }
end
function physic_component:updateVertex()--根据owner的宽高角度和坐标计算碰撞边界
    self.vertex[1].x=self.owner.x+((-self.owner.w/2)*math.cos(-math.rad(self.owner.r))+(-self.owner.h/2)*math.sin(-math.rad(self.owner.r)))
    self.vertex[1].y=self.owner.y+((self.owner.w/2)*math.sin(-math.rad(self.owner.r))+(-self.owner.h/2)*math.cos(-math.rad(self.owner.r)))
    self.vertex[2].x=self.owner.x+((self.owner.w/2)*math.cos(-math.rad(self.owner.r))+(-self.owner.h/2)*math.sin(-math.rad(self.owner.r)))
    self.vertex[2].y=self.owner.y+((-self.owner.w/2)*math.sin(-math.rad(self.owner.r))+(-self.owner.h/2)*math.cos(-math.rad(self.owner.r)))
    self.vertex[3].x=self.owner.x+((-self.owner.w/2)*math.cos(-math.rad(self.owner.r))+(self.owner.h/2)*math.sin(-math.rad(self.owner.r)))
    self.vertex[3].y=self.owner.y+((self.owner.w/2)*math.sin(-math.rad(self.owner.r))+(self.owner.h/2)*math.cos(-math.rad(self.owner.r)))
    self.vertex[4].x=self.owner.x+((self.owner.w/2)*math.cos(-math.rad(self.owner.r))+(self.owner.h/2)*math.sin(-math.rad(self.owner.r)))
    self.vertex[4].y=self.owner.y+((-self.owner.w/2)*math.sin(-math.rad(self.owner.r))+(self.owner.h/2)*math.cos(-math.rad(self.owner.r)))
end
function physic_component:update()--更新物理组件
    self:updateVertex()
end
function physic_component:test_draw()
    for i=1,4 do
      love.graphics.circle("fill",self.vertex[i].x,self.vertex[i].y,5)
    end
end]]
-----------------------------------------------------------------------------------------
--对象的图形组件，有图形组件的对象在屏幕上绘图
graphic_component=class()
function graphic_component:ctor(ima,shader)
    self.type="graphic_com"
    self.image=ima
    self.owner=nil
    self.shader=shader
    self.x=0
    self.y=0
    self.r=0
    self.w=0
    self.h=0
end
function graphic_component:update( ... )
   self.x,self.y,self.w,self.h,self.r=...
 
end
function graphic_component:draw()
    love.graphics.draw(self.image,
                       self.x,self.y,math.rad(self.r),
                       1,1,
                       self.w/2,self.h/2)
end
-----------------------------------------------------------------------------------------
