local planet=class(object)
function planet:ctor()
   self.id=0

   self.locate_x=0
   self.locate_y=0
   self.defence_size=0

   

end

function planet:update()
    self.x
end

function planet:draw_onmap()
    love.graphics.draw(self.img_onmap,self.x,self.y,self.size/2,self.size/2)
    love.graphics.draw(self.station_img,self.x+self.station_x,self.station_y,self.station_w/2,self.station_h/2)
end
function planet:draw_inside()
    love.graphics.draw(self.station_img_inside,0,0)
end

