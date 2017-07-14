local i,j=...
require"love.image"
print("map loader start with "..i.." "..j)
channel_input=love.thread.getChannel("map_loader_channel_input")
channel_output=love.thread.getChannel("map_loader_channel_output")
print("output channel clear,start ini loading")
channel_output:push(love.image.newImageData("resource/map/testmap"..i..j..".png"))
print("preload 1 success")
channel_output:push(love.image.newImageData("resource/map/testmap"..(i+1)..j..".png"))
print("preload 2 success")
channel_output:push(love.image.newImageData("resource/map/testmap"..i..(j+1)..".png"))
print("preload 3 success")
channel_output:push(love.image.newImageData("resource/map/testmap"..(i+1)..(j+1)..".png"))
print("preload 4 success")
local preload_image={}
--[[
while(0) do
    preload_image[-1][-1]=love.image.newImageData("resource/map/testmap"..(i-1)..(j-1)..".png")
    preload_image[-1][0]=love.image.newImageData("resource/map/testmap"..(i-1)..(j)..".png")
    preload_image[-1][1]=love.image.newImageData("resource/map/testmap"..(i-1)..(j+1)..".png")
    preload_image[-1][2]=love.image.newImageData("resource/map/testmap"..(i-1)..(j+2)..".png")

    preload_image[0][-1]=love.image.newImageData("resource/map/testmap"..(i)..(j-1)..".png")
    preload_image[0][2]=love.image.newImageData("resource/map/testmap"..(i)..(j+2)..".png")

    preload_image[1][-1]=love.image.newImageData("resource/map/testmap"..(i+1)..(j-1)..".png")
    preload_image[1][2]=love.image.newImageData("resource/map/testmap"..(i+1)..(j+2)..".png")

    preload_image[2][-1]=love.image.newImageData("resource/map/testmap"..(i+2)..(j-1)..".png")
    preload_image[2][0]=love.image.newImageData("resource/map/testmap"..(i+2)..(j)..".png")
    preload_image[2][1]=love.image.newImageData("resource/map/testmap"..(i+2)..(j+1)..".png")
    preload_image[2][2]=love.image.newImageData("resource/map/testmap"..(i+2)..(j+2)..".png")
    while(0) do
        print("wait for new loading demand")
        local new_i=channel_input:demand()
        local new_j=channel_input:demand()
        local di,dj=new_i-di,new_j-dj
        if di~=0 or dj~=0 then
            channel_output:supply(preload_image[di][dj])



        end
        print("get i j,start pre loading")
    end

    print("")
end
]]