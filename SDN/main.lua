require "kits"
require "playerMove"
require "menu"
require "smile"


function love.load()



    defineKits()
    love.graphics.setBackgroundColor(20,30,40)
    tilesetImage = love.graphics.newImage("tileset.png")
    tilesetQuads = {}
    for x=1,5 do
        tilesetQuads[x] = love.graphics.newQuad((x-1) * 32,0,32,32,tilesetImage:getWidth(),tilesetImage:getHeight())
    end
    local mapFunction = love.filesystem.load("assets/maps/abstract/foreground.lua")
    mapData = mapFunction()
    mapDataTable = {}
    for x=1,mapData.layers[1].width do
        mapDataTable[x] = {}
        for y=1,mapData.layers[1].height do
            mapDataTable[x][y] = mapData.layers[1].data[(y-1) * mapData.layers[1].width + x]
        end
    end



    deltaTime = 0
    button = "`"
    quadTimer = 0
    gamestate = "menu"
    menustate = "title"


	pOne = kits.gforcedev

	pTwo = kits.rayquaza95
	pOne.x = 200
	pOne.y = 200
	pOne.xvel = 0
	pOne.yvel = 0
	pOne.up = "e"
	pOne.left = "s"
	pOne.right = "f"
	pOne.cycle = "d"
	pOne.attack = "r"


	pTwo = kits.rayquaza95
	pTwo.x = 800
	pTwo.y = 200
	pTwo.xvel = 0
	pTwo.yvel = 0
	pTwo.up = "up"
	pTwo.left = "left"
	pTwo.right = "right"
	pTwo.cycle = "down"
	pTwo.attack = "/"

    stage = 1
end




function love.update(dt)
    if gamestate == "menu" then

	    updateMenu()

    elseif gamestate == "fighting" then
    	deltaTime = dt
    	quadTimer = quadTimer + dt
    	playerMove(pOne,pTwo)
    	playerMove(pTwo,pOne)
    	for x=1,#mapDataTable do
    	    for y=1,#mapDataTable[x] do
    	        if mapDataTable[x][y] ~= 0 then
    	            if collide(pOne,{x = (x-1) * 32,y = (y-1) * 32,width = 32,height = 32}) == false then
    	                pOne.gravity = 3000
    	            end
			 if collide(pTwo,{x = (x-1) * 32,y = (y-1) * 32,width = 32,height = 32}) == false then
	                    pTwo.gravity = 3000
	                end
	            end
	        end
	    end
    	if pOne.health < 0 then
		winner = pTwo
		gamestate = "ko"
		menustate = "ko"
	end
	if pTwo.health < 0 then
		winner = pOne
		gamestate = "ko"
		menustate = "ko"
	end


	    if quadTimer < 0.3 then
		    quadTimer = 0
	    end
    elseif gamestate == "ko" then
	    updateMenu()
    end
end




function love.draw()




    if gamestate == "fighting" then
    	love.graphics.setColor(255,255,255)
    	for x=1,#mapDataTable do
    	    for y=1,#mapDataTable[x] do
    	        if mapDataTable[x][y] ~= 0 then
    	            love.graphics.draw(tilesetImage,tilesetQuads[mapDataTable[x][y]],(x-1) * 32,(y-1) * 32)
    	        end
    	    end
    	end
    	love.graphics.print(pOne.equip,64,64)
    	love.graphics.print(pOne.health,84,64)
    	love.graphics.print(#pOne.ranged,104,64)
	
	    love.graphics.print(pTwo.equip,164,64)
	    love.graphics.print(pTwo.health,184,64)
	    love.graphics.print(#pTwo.ranged,204,64)
	
	    love.graphics.draw(pOne.sheet,pOne.quadTable[pOne.quadID],pOne.x - 2,pOne.y) --draw player
	    for i=1,#pOne.ranged do --draw projectiles
		    love.graphics.draw(pOne.sheet,pOne.ranged[i].quads[pOne.ranged[i].quad],pOne.ranged[i].x,pOne.ranged[i].y)
	    end
	    if pOne.drawSpecial ~= nil then
		    pOne.drawSpecial(pOne)
	    end

	    love.graphics.setColor(255,255,255)
	    	love.graphics.draw(pTwo.sheet,pTwo.quadTable[pTwo.quadID],pTwo.x - 2,pTwo.y)
	    for i=1,#pTwo.ranged do
		    love.graphics.draw(pTwo.sheet,pTwo.ranged[i].quads[pTwo.ranged[i].quad],pTwo.ranged[i].x,pTwo.ranged[i].y)
	    end
    elseif gamestate == "ko" then
	    drawMenu()
    end
    drawMenu()
end

function love.keypressed(key)
	button = key
   if key == "escape" then
      love.event.quit()
   end
   if gamestate == "fighting" then
   	playerKeyPress(pOne,pTwo)
   	playerKeyPress(pTwo,pOne)
   end
end
