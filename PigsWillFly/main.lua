require "smile"
require "ChatLib"
function love.load()
	window ={
		width = 1000,
		height = 900,
	}
	fontOne = love.graphics.newFont("UnrealT.ttf",100)
	love.graphics.setFont(fontOne)
	timer = 0
	playerOne = {x = 1,y = 1,width = 100,height = 100,red = 72,green = 174,blue = 100,vel = 500,it = false,timeIt = 0}
	playerTwo = {x = 900,y = 800,width = 100,height = 100,red = 225,green = 0,blue = 0,vel = 500,it = false,timeIt = 0}
	sound = love.audio.newSource("Sound.xm","static")
	soundOn = true
end

local time = 0
function love.update(dt)
	timer = timer + dt
	love.audio.play(sound)
	if playerOne.it == true then
	time = time + dt * 10
		playerOne.red = (math.sin(time) + 1 * 127)
		playerOne.green = 0
		playerOne.blue = 0
		playerOne.timeIt = playerOne.timeIt + 1
		elseif playerOne.it == false then
		playerOne.red = 72
		playerOne.green = 174
		playerOne.blue = 100
	end
	if playerTwo.it == true then
		playerTwo.red = 225
		playerTwo.green = 0
		playerTwo.blue = 0
		playerTwo.timeIt = playerTwo.timeIt + 1
		elseif playerTwo.it == false then
		playerTwo.red = 72
		playerTwo.green = 174
		playerTwo.blue = 100
	end
	if love.keyboard.isDown("w") then
		playerOne.y = playerOne.y - (playerOne.vel * dt)
	end
	if love.keyboard.isDown("s") then
		playerOne.y = playerOne.y + (playerOne.vel * dt)
	end
	if love.keyboard.isDown("a") then
		playerOne.x = playerOne.x - (playerOne.vel * dt)
	end
	if love.keyboard.isDown("d") then
		playerOne.x = playerOne.x + (playerOne.vel * dt)
	end
	if love.keyboard.isDown("up") then
		playerTwo.y = playerTwo.y - (playerTwo.vel * dt)
	end
	if love.keyboard.isDown("down") then
		playerTwo.y = playerTwo.y + (playerTwo.vel * dt)
	end
	if love.keyboard.isDown("left") then
		playerTwo.x = playerTwo.x - (playerTwo.vel * dt)
	end
	if love.keyboard.isDown("right") then
		playerTwo.x = playerTwo.x + (playerTwo.vel * dt)
	end
	if playerOne.x < 0 then
		playerOne.x = 0
		elseif playerOne.x > (window.width - playerOne.width) then
		playerOne.x = (1000 - playerOne.width)
	end
	if playerOne.y < 0 then
		playerOne.y = 0
		elseif playerOne.y > (window.height - playerOne.height) then
		playerOne.y = (1000 - playerOne.height)
	end
	if playerTwo.x < 0 then
		playerTwo.x = 0
		elseif playerTwo.x > (window.width - playerTwo.width) then
		playerTwo.x = (1000 - playerTwo.width)
	end
	if playerTwo.y < 0 then
		playerTwo.y = 0
		elseif playerTwo.y > (window.height - playerTwo.height) then
		playerTwo.y = (1000 - playerTwo.height)
	end
	if playerOne.x > playerTwo.x and playerOne.x < playerTwo.x + playerTwo.width and playerOne.y > playerTwo.y and playerOne.y < playerTwo.y + playerTwo.height or playerOne.x + playerOne.width > playerTwo.x and playerOne.x  + playerOne.width < playerTwo.x + playerTwo.width and playerOne.y + playerOne.height > playerTwo.y and playerOne.y + playerOne.height < playerTwo.y + playerTwo.height then
		if playerOne.it == true then
			playerOne.x = 0
			playerOne.y = 0
			playerTwo.x = 900
			playerTwo.y = 800			
			playerOne.it = false
			playerTwo.it = true
		else 
			playerOne.x = 0
			playerOne.y = 0
			playerTwo.x = 900
			playerTwo.y = 800
			playerOne.it = true
			playerTwo.it = false
		end
	end
end
function love.draw()
	love.graphics.setColor(playerOne.red,playerOne.green,playerOne.blue)
	love.graphics.rectangle("fill",playerOne.x,playerOne.y,playerOne.width,playerOne.height)
	love.graphics.setColor(0,0,0)
	love.graphics.print("1", playerOne.x, playerOne.y)
	love.graphics.setColor(playerTwo.red,playerTwo.green,playerTwo.blue)
	love.graphics.rectangle("fill",playerTwo.x,playerTwo.y,playerTwo.width,playerTwo.height)
	love.graphics.setColor(0,0,0)
	love.graphics.print("2", playerTwo.x, playerTwo.y)
	love.graphics.setColor(255,255,255)
	love.graphics.print(tostring(playerOne.timeIt),400,5)
	love.graphics.print(tostring(playerTwo.timeIt),400,100)
	if love.keyboard.isDown("lshift") then
		emote(playerOne.x,playerOne.y,":","¬",")")
	end
	if love.keyboard.isDown("rshift") then
		emote(playerTwo.x,playerTwo.y,":","¬",")")
	end
		if love.keyboard.isDown("lctrl") then
		emote(playerOne.x,playerOne.y,":","¬","(")
	end
	if love.keyboard.isDown("rctrl") then
		emote(playerTwo.x,playerTwo.y,":","¬","(")
	end
end				
