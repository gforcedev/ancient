require "stage"
require "kits"
require "playerMove"
function love.load()
    tilesetImage = love.graphics.newImage("tileset.png")
    tilesetQuads = {}
    for x=1,50 do
        tilesetQuads[x] = love.graphics.newQuad((x-1) * 16,0,16,16,tilesetImage:getWidth(),tilesetImage:getHeight())
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
    love.graphics.rectangle("fill",0,0,10,10)
    deltaTime = 0
    love.graphics.rectangle("fill",0,0,20,10)
    quads = {still = love.graphics.newQuad(0,0,64,64,kits[1].sheet:getWidth(),kits[1].sheet:getHeight()),melee = love.graphics.newQuad(65,0,64,64,kits[1].sheet:getWidth(),kits[1].sheet:getHeight())}
    love.graphics.rectangle("fill",0,0,30,10)
    pOne = {x = 200,y = 200,xvel = 0,yvel = 0,width = 64,height = 64,sheet = kits[1].sheet,quad = quads.still,up = "w",left = "a",right = "d",melee = "s",meleeAttack = false,meleeTimer = 0,grounded = false}
    love.graphics.rectangle("fill",0,0,40,10)
    pTwo = {x = 500,y = 0,xvel = 0,yvel = 0,width = 64,height = 64,sheet = kits[1].sheet,quad = quads.still,up = "w",left = "a",right = "d",melee = "s",meleeAttack = false,meleeTimer = 0,grounded = false}
    love.graphics.rectangle("fill",0,0,50,10)
    gravity = 3000
    love.graphics.rectangle("fill",0,0,60,10)
    gamestate = "title"
    stage = 1
end
function love.update(dt)
    deltaTime = dt
    playerMove(pOne)
    for x=1,#mapDataTable do
        for y=1,#mapDataTable[x] do
            if mapDataTable[x][y] ~= 0 then
                if collide(pOne,{x = (x-1) * 16,y = (y-1) * 16,width = 16,height = 16}) == false then
                    gravity = 3000
                --collide(pOne,{x = x,y = y,width = 16,height = 16})
                end
            end
        end
    end
end
function love.draw()
    love.graphics.draw(pOne.sheet,pOne.quad,pOne.x,pOne.y)
    love.graphics.setColor(255,255,255)
    for x=1,#mapDataTable do
        for y=1,#mapDataTable[x] do
            if mapDataTable[x][y] ~= 0 then
                love.graphics.draw(tilesetImage,tilesetQuads[mapDataTable[x][y]],(x-1) * 16,(y-1) * 16)
            end
        end
    end
end
