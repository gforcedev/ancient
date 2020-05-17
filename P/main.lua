require "smile"
require "menu"
require "player"
require "stage"
function love.load()
	love.graphics.setBackgroundColor(255,255,255)
	gamestate = "menu"
	menuState = "title"
	player = {x = 0,y = 100,xvel = 0,yvel = 0,radius = 42,ypos = 1,xpos = 1,jumping = false,jump = 0}
	gravity = 70
	stagePos = 0
	masterSheet = love.graphics.newImage("masterSheet.png")
	tileset = {}
	tileset[1] = love.graphics.newQuad(0,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
	tileset[2] = love.graphics.newQuad(64,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
	tileset[3] = love.graphics.newQuad(128,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
	tileset[4] = love.graphics.newQuad(256,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
	tileset[5] = love.graphics.newQuad(320,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
	tileset[100] = love.graphics.newQuad(192,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
	tileset[101] = love.graphics.newQuad(384,0,64,64,masterSheet:getWidth(),masterSheet:getHeight())
end
function love.update(dt)
	if gamestate == "menu" then
		menu()
	elseif gamestate == "running" then
		updateStagePos()
		playerPos()
		if player.xvel < 0 then
			if stage[player.xpos][player.ypos] ~= 2 then
				player.x = player.x + player.xvel * dt
			end
		elseif player.xvel > 0 then
			if stage[player.xpos][player.ypos] ~=2 then
				player.x = player.x + player.xvel * dt
			end
		end
		if player.yvel < 0 and stage[player.xpos][player.ypos - 1] ~= 2 then
			player.y = player.y + player.yvel * dt
		elseif player.yvel > 0 and stage[player.xpos][player.ypos] ~= 2 then
			player.y = player.y + player.yvel * dt
		end
		if stage[player.xpos][player.ypos] == 2 then
				player.x = player.x - (player.xvel * 2) * dt
				player.y = player.y - 3
		end
		if stage[player.xpos][player.ypos + 1] == 2 then
			player.yvel = 0
		elseif stage[player.xpos][player.ypos] == 3 or stage[player.xpos][player.ypos] == 4 then
			love.load()
		elseif stage[player.xpos][player.ypos] == 101 then
			love.load()
		else
			player.yvel = player.yvel + gravity
		end
		if level == 1 then
			if player.xpos == 19 and player.ypos == 3 then
				if love.filesystem.read("1 19 3.txt") == "false" then
					love.filesystem.write("1 19 3.txt","true")
					stage[19][3] = 1
				end
				
			end
			if player.xpos == 48 and player.ypos == 1 then
				if love.filesystem.read("1 48 1.txt") == "false" then
					love.filesystem.write("1 48 1.txt","true")
					stage[48][1] = 1
				end
				
			end
			if player.xpos == 60 and player.ypos == 4 then
				if love.filesystem.read("1 60 4.txt") == "false" then
					love.filesystem.write("1 60 4.txt","true")
					stage[60][4] = 1
				end
			end
			
		end
	
	
	
	
		movePlayer()
		if love.keyboard.isDown("up") and (stage[player.xpos][player.ypos + 1] == 2 or stage[player.xpos][player.ypos] == 5) then
			player.yvel = -1000
		end
		if player.y > 450 then
			love.load()
		end
		if stagePos > -(64 * (64 - 16)) then
			stagePos = stagePos - (80) * dt
		end
	end
end
function love.draw()
	if gamestate == "menu" then
		drawMenu()
	elseif gamestate == "running" then
		love.graphics.setColor(0,0,0)
		love.graphics.circle("fill",player.x,player.y,player.radius)
		love.graphics.setColor(255,255,255)
		drawStage()
	end
end
