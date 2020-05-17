function LOAD_GRAPHICS()
	titleScreenImg = love.graphics.newImage("assets/background.png")
	buttonImg = love.graphics.newImage("assets/gui button.png")
	barbarian = love.graphics.newImage("assets/barbarian.png")
	soldier = love.graphics.newImage("assets/soldier.png")

	formations = {}
	formations.tortoise = love.graphics.newImage("assets/roman formation tortoise.png")
	formations.orb = love.graphics.newImage("assets/roman formation orb.png")
	formations.wedge = love.graphics.newImage("assets/roman formation wedge.png")
	formations.saw = love.graphics.newImage("assets/roman formation saw.png")
end
