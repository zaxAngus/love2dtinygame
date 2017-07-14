-local i,j=...
channel_output=love.thread.getChannel("map_loader_channel_output")
channel_output:push(love.image.newImageData("resource/map/testmap"..i..j..".png"))
channel_output:push(love.image.newImageData("resource/map/testmap"..(i+1)..j..".png"))
channel_output:push(love.image.newImageData("resource/map/testmap"..i..(j+1)..".png"))
channel_output:push(love.image.newImageData("resource/map/testmap"..(i+1)..(j+1)..".png"))