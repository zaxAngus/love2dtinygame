


require('po/polygon')



playerImg=nil
player={x=100,y=100,length=200,width=50,speed=50,img=nil}
player2={x=0,y=0,length=200,width=50,speed=50,img=nil}

function love.load(arg)
	player.img=love.graphics.newImage('assets/Aircraft_01.png')
	player2.img=love.graphics.newImage('assets/Aircraft_01.png')
end

function love.draw(dt)

	love.graphics.setColor(12, 100, 230)
	love.graphics.polygon('fill', player.x, player.y, player.x-50, player.y+50, player.x,player.y+100,player.x+150, player.y+80,player.x+80,player.y+100,player.x,player.y+100)
	love.graphics.setColor(1005, 1020, 1023)
	love.graphics.rectangle("fill", player2.x, player2.y, player2.length, player2.width)
end

function love.update(dt)
    a=player.x
	b=player.y
	c=player.length
	d=player.width
	a1=player2.x
	b1=player2.y
	c1=player2.length
	d1=player2.width
	v1=polygon{vec(a,b),vec(a-50,b+50),vec(a,b+100),vec(a+150,b+80),vec(a+80,b+100),vec(player.x,player.y+100)}
	v2=polygon{vec(a1,b1),vec(a1,b1+d1),vec(a1+c1,b1+d1),vec(a1+c1,b1)}
    if  sat(v1,v2)then
		print("true")

    end

	if love.keyboard.isDown('escape')then
		love.event.push('quit')
	end

	if love.keyboard.isDown('left')then
	    player.x=player.x-(player.speed*dt)
	end
	if love.keyboard.isDown('right')then

		player.x=player.x+(player.speed*dt)

    end

	if love.keyboard.isDown('up')then
	    player.y=player.y-(player.speed*dt)
	end

	if love.keyboard.isDown('down')then
		 player.y=player.y+(player.speed*dt)

    end


	if love.keyboard.isDown('a')then
	player2.x=player2.x-(player2.speed*dt)

	end

	if love.keyboard.isDown('d')then

		player2.x=player2.x+(player2.speed*dt)
	end

    if love.keyboard.isDown('w')then
	player2.y=player2.y-(player2.speed*dt)
	end
	if love.keyboard.isDown('s')then
		player2.y=player2.y+(player2.speed*dt)
	end






end
















