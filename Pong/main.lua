require "smile"
function love.load()
	scoreTo = 100
	fontOne = love.graphics.newFont("AldotheApache.ttf",50)
	love.graphics.setFont(fontOne)
	gamestate = "menu"
	playersVel = 600
	playerOne = {x = 10,y = 240,width = 5, height = 100,upKey = "w", downKey = "s",score = 0}
	playerTwo = {x = 585,y = 240,width = 5,height = 100,upKey = "up", downKey = "down",score = 0}
	ball = {x = 295,y = 250,width = 10,height = 10,xvel = 400, yvel = 0,started = false}
end
function love.update(dt)
	if gamestate == "menu" then
		if smile.rectangleMouseButton(0,0,100,100) then
			scoreTo = 1
			gamestate = "running"
		elseif smile.rectangleMouseButton(100,0,100,100) then
			scoreTo = 3
			gamestate = "running"
		elseif smile.rectangleMouseButton(200,0,100,100) then
			scoreTo = 5
			gamestate = "running"
		elseif smile.rectangleMouseButton(300,0,100,100) then
			scoreTo = 7
			gamestate = "running"
		elseif smile.rectangleMouseButton(400,0,100,100) then
			scoreTo = 9
			gamestate = "running"
		elseif smile.rectangleMouseButton(500,0,100,100) then
			scoreTo = 11
			gamestate = "running"
		end
	elseif gamestate == "running" then
		if ball.started == false then
			if love.keyboard.isDown("space") then
				ball.started = true
			end
		elseif ball.started == true then
			if love.keyboard.isDown("p") then
				ball.started = false
			end
		end
		-- move the players and the ball
		if ball.started == true then
			ball.x = ball.x + (ball.xvel * dt)
			ball.y = ball.y + (ball.yvel * dt)
		end
		if love.keyboard.isDown(playerOne.upKey) and playerOne.y > 0 then
			playerOne.y = playerOne.y - (playersVel * dt)
		elseif love.keyboard.isDown(playerOne.downKey) and playerOne.y < (530 - playerOne.height) then
			playerOne.y = playerOne.y + (playersVel * dt)
		end
		if love.keyboard.isDown(playerTwo.upKey) and playerTwo.y > 0 then
			playerTwo.y = playerTwo.y - (playersVel * dt)
		elseif love.keyboard.isDown(playerTwo.downKey) and playerTwo.y < (530 - playerTwo.height) then
			playerTwo.y = playerTwo.y + (playersVel * dt)
		end
		--done
		--ball collisions
		if ball.x > (playerTwo.x) and ball.y > (playerTwo.y - ball.height) and ball.y < (playerTwo.y + playerTwo.height) then
			ball.xvel = ball.xvel * -1
			ball.xvel = ball.xvel - 5
			ball.yvel = ((ball.y - playerTwo.y) - 50) * 7
		elseif ball.x < playerOne.x and ball.y > (playerOne.y - ball.height) and ball.y < (playerOne.y + playerOne.height) then
			ball.xvel = ball.xvel * -1
			ball.xvel = ball.xvel + 5
			ball.yvel = ((ball.y - playerOne.y) - 50) * 7
		elseif ball.x < playerOne.x then
			ball.started = false
			ball.x = 285
			ball.y = 250
			ball.yvel = 0
			playerTwo.score = playerTwo.score + 1
			if playerTwo.score == scoreTo then
				gamestate = "playerTwoWins"
			end
		elseif ball.x > playerTwo.x then
			ball.started = false
			ball.x = 285
			ball.y = 250
			ball.yvel = 0
			playerOne.score = playerOne.score + 1
			if playerOne.score == scoreTo then
				gamestate = "playerOneWins"
			end
		end
		--done
		--ball wall bouncing
		if ball.y < 0 or ball.y > (530 - ball.width) then
			ball.yvel = ball.yvel * -1
		end
		--done
		--scoring
		--done
	elseif gamestate == "playerOneWins" then
		if love.keyboard.isDown("space") then
			love.load()
		end
	elseif gamestate == "playerTwoWins" then
		if love.keyboard.isDown("space") then
			love.load()
		end
	end
end
function love.draw()
	if gamestate == "menu" then
		love.graphics.setColor(0,255,255)
		love.graphics.print("CHOOSE SCORE TO WIN",10,200)
		love.graphics.setColor(0,0,255)
		love.graphics.rectangle("fill",0,0,100,100)
		love.graphics.print("1",0,100)
		love.graphics.setColor(0,255,255)
		love.graphics.rectangle("fill",100,0,100,100)
		love.graphics.print("3",100,100)
		love.graphics.setColor(0,0,255)
		love.graphics.rectangle("fill",200,0,100,100)
		love.graphics.print("5",200,100)
		love.graphics.setColor(0,255,255)
		love.graphics.rectangle("fill",300,0,100,100)
		love.graphics.print("7",300,100)
		love.graphics.setColor(0,0,255)
		love.graphics.rectangle("fill",400,0,100,100)
		love.graphics.print("9",400,100)
		love.graphics.setColor(0,255,255)
		love.graphics.rectangle("fill",500,0,100,100)
		love.graphics.print("11",500,100)
	elseif gamestate == "running" then                                         
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",playerOne.x,playerOne.y,playerOne.width,playerOne.height)
		love.graphics.setColor(255,0,0)
		love.graphics.print(playerOne.score,playerOne.x,0)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",playerTwo.x,playerTwo.y,playerTwo.width,playerTwo.height)
		love.graphics.setColor(255,0,0)
		love.graphics.print(playerTwo.score,(playerTwo.x - 6),0)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",ball.x,ball.y,ball.width,ball.height)
	elseif gamestate == "playerOneWins" then
		love.graphics.print("PLAYER ONE WINS BY " .. (playerOne.score - playerTwo.score),0,250)
		love.graphics.print("SPACE TO RESTART",0,400)
	elseif gamestate == "playerTwoWins" then
		love.graphics.print("PLAYER TWO WINS BY " .. (playerTwo.score - playerOne.score),0,250)
		love.graphics.print("SPACE TO RESTART",0,400)
	end
end
