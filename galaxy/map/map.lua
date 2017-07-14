local map_colnum,map_rownum=2,2
local preload_limit_x,preload_limit_y=300,200
local map={
                  i,j,x,y,prestate,state,
                  loader,
                  loader_channel_input,
                  loader_channel_output,
                  [1]=nil,[2]=nil,[3]=nil,[4]=nil,
            }
function map:ini(x,y)
      --根据X Y值初始化
      self.x,self.y=x-960,y-540
      self.i,self.j=math.floor(self.x/1920),math.floor(self.y/1080)
      --开一个后台加载地图资源的线程，两条通信通道，一条输入参数，一条输出结果
      self.loader=love.thread.newThread("map/map_loader.lua")
      self.loader_channel_input=love.thread.getChannel("map_loader_channel_input")
      self.loader_channel_output=love.thread.getChannel("map_loader_channel_output")
      self.loader:start(self.i,self.j)
      --[[self[1]=love.image.newImageData("resource/map/testmap"..self.i..self.j..".png")
      self[2]=love.image.newImageData("resource/map/testmap"..(self.i+1)..self.j..".png")
      self[3]=love.image.newImageData("resource/map/testmap"..self.i..(self.j+1)..".png")
      self[4]=love.image.newImageData("resource/map/testmap"..(self.i+1)..(self.j+1)..".png")]]
      for i=1,4 do
            self[i]=self.loader_channel_output:demand()--等待输出结果通道的结果
            self[i]=love.graphics.newImage(self[i])
      end
end
function map:update(x,y)
      self.x,self.y=x-960,y-540
end
function map:draw()
      love.graphics.draw(self[1],0,0,0,1,1,self.x-self.i*1920,self.y-self.j*1080)
      love.graphics.draw(self[2],win_w,0,0,1,1,self.x-self.i*1920,self.y-self.j*1080)
      love.graphics.draw(self[3],0,win_h,0,1,1,self.x-self.i*1920,self.y-self.j*1080)
      love.graphics.draw(self[4],win_w,win_h,0,1,1,self.x-self.i*1920,self.y-self.j*1080)
end
return map




