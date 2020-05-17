function love.load()
	math.randomseed(os.time())
	turtle = {picture = love.graphics.newImage("Turtle.png"),x = 0, y = 0, xvel = 0, yvel = 0, health = 10000}
	barbarians = {}
	for temp=1,3 do
		table.insert(barbarians,{x = math.random(0,love.graphics.getWidth()),y = math.random(0,love.graphics.getHeight())})
	end
	barbarianPic = love.graphics.newImage("barbarian.png")
end
function love.update(dt)
	if love.keyboard.isDown("w") then
		turtle.y = turtle.y - 300 *dt
	end
	if love.keyboard.isDown("s")then
		turtle.y = turtle.y + 300 *dt
	end
	if love.keyboard.isDown("a")then
		turtle.x = turtle.x - 300 *dt
	end
	if love.keyboard.isDown("d")then
		turtle.x = turtle.x + 300 *dt
	end
	for temp=1,#barbarians do
		local xdifference = barbarians[temp].x - turtle.x + turtle.picture:getWidth()
		local ydifference = barbarians[temp].y - turtle.y + turtle.picture:getHeight()
		barbarians[temp].x = barbarians[temp].x - xdifference *dt / 2
		barbarians[temp].y = barbarians[temp].y - ydifference *dt / 2

		if barbarians[temp].x > turtle.x and barbarians[temp].x < turtle.x + turtle.picture:getWidth() * 5 then
			if barbarians[temp].y > turtle.y and barbarians[temp].y < turtle.y + turtle.picture:getHeight() * 5 then
				table.remove(barbarians,temp)
				turtle.health = turtle.health - 20
				break
			end
		end
	end
	local random = math.random(1,50)
	if random == 3 then
		table.insert(barbarians,{x = math.random(0,love.graphics.getWidth()),y = math.random(0,love.graphics.getHeight())})
	end
	if turtle.health <= 0 then
		love.event.quit()
	end
end
function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(turtle.picture, turtle.x, turtle.y,0,5)
	love.graphics.rectangle("line",1,1,love.graphics.getWidth() - 2,love.graphics.getHeight() - 2)
	love.graphics.setColor(0,225,0)
	love.graphics.rectangle("fill",0,0,turtle.health,30)
	love.graphics.setColor(255,255,255)
	for temp=1,#barbarians do
		love.graphics.draw(barbarianPic,barbarians[temp].x,barbarians[temp].y)
	end
end
function love.mousepressed(x,y,button)
	for temp=1,#barbarians do
		if x > barbarians[temp].x and x < barbarians[temp].x + barbarianPic:getWidth() then
			if y > barbarians[temp].y and y < barbarians[temp].y + barbarianPic:getHeight() then
				table.remove(barbarians,temp)
				break
			end
		end
	end
end
