local button=class()
function button:ctor(id,w,h,img,img_focus,func)
    self.id=id
    self.w=w
    self.h=h
    self.img=img
    self.img_focus=img_focus
    self.x=nil
    self.y=nil
    self.owner=nil
    self.focus=false
    self.func=func
end
function button:activate(x,y,owner)
   self.x=x
   self.y=y
   self.owner=owner
   table.insert(self.owner.ui_object,self)
end
function button:mousepressed(...)
   local x,y,button=...
   if x>self.x and x<self.x+self.w then
      if y>self.y and y<self.y+self.h then
         self:func()
      end
   end
end
function button:mousemoved(...)
   local x,y,dx,dy=...
   if x>self.x and x<self.x+self.w and y>self.y and y<self.y+self.h then
      self.focus=true
   else
      self.focus=false
   end
end   
function button:keypressed()
end    
function button:draw()
   if self.focus==false then
      love.graphics.draw(self.img,self.x,self.y)
   else
      if self.img_focus then
         love.graphics.draw(self.img_focus,self.x,self.y)
      else
      end
   end
end

return button