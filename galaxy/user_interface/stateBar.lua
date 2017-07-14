local stateBar=class()
function stateBar:ctor(id,img_fill,img,w,h)
   self.id=id
   self.w=120
   self.h=40
   self.img=img
   self.img_fill=img_fill
   self.x=nil
   self.y=nil
   self.object=nil
   self.func=nil
   self.num=0
   self.max=10
end
function stateBar:activate(x,y,target,owner)
   self.owner=owner
   self.target=target
   self.x=x
   self.y=y
   if target=="hp" then
      self.max=owner.main_object.hp_max
   elseif target=="mp" then
      self.max=owner.main_object.mp_max
   end
   table.insert(self.owner.ui_object_static,self)
end
      
function stateBar:update()
   if self.target=="hp" then 
      self.num=self.owner.main_object.hp
   elseif self.target=="mp" then
      self.num=self.owner.main_object.mp
   end   
end

function stateBar:draw()
  --[[love.graphics.draw(self.img_fill,self.x,self.y,0,1,self.num/self.max)
  love.graphics.draw(self.img,self.x,self.y)]]
  love.graphics.setShader(_shader.color.yellow)
  love.graphics.rectangle("fill",self.x,self.y,(self.num/self.max)*self.w,self.h)
  love.graphics.setShader()
end
return stateBar