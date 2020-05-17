require "graphics"
require "smile"
require "buttons"

function love.load()
	gamestate = "title"
	LOAD_GRAPHICS()
	math.randomseed(os.time())

	font1 = love.graphics.newFont("ata.ttf",42)
	love.graphics.setFont(font1)

  buttonX = 0
  buttonY = 0
  buttonWidth = 0
  buttonHeight = 0

	romans = {}
	for temp=1,30 do
		table.insert(romans,{x = math.random(0,love.graphics.getWidth() / 2),y = math.random(0,love.graphics.getHeight())})
	end
	formation = "scattered"
	formed = false
	health = 1000
	romanLost = false

	barbarians = {}
	for temp=1,40 do
		table.insert(barbarians,{x = math.random(love.graphics.getWidth() / 2,love.graphics.getWidth()),y = math.random(0,love.graphics.getHeight())})
	end
end


function love.update(dt)
	if gamestate == "title" then
  elseif gamestate == "running" then
		if formed == false and formation ~= "scattered" then
			for temp=1,#romans do
				local xDifference = 100 - romans[temp].x
				romans[temp].x = romans[temp].x + xDifference * dt * 2

				local yDifference = 100 - romans[temp].y
				romans[temp].y = romans[temp].y + yDifference * dt * 2
				if romans[temp].x >= 99 and romans[temp].x >= 101 and romans[temp].y >= 99 and romans[temp].y <= 101 then
					formed = true
					gamestate = "fighting"
				end
			end
		end
	elseif gamestate == "fighting" then
		if health <= 1000 then
			health = health + 20 * dt
		end
		if formation == "tortoise" then
			if #romans < 5 or health <= 0 then
				gamestate = "lost"
			elseif #barbarians < 5 then
				gamestate = "won"
			end
			if love.keyboard.isDown("left") then
				for temp=1,#romans do
					romans[temp].x = romans[temp].x + -300 * dt
				end
			end
			if love.keyboard.isDown("right") then
				for temp=1,#romans do
					romans[temp].x = romans[temp].x + 300 * dt
				end
			end
			if love.keyboard.isDown("up") then
				for temp=1,#romans do
					romans[temp].y = romans[temp].y + -300 * dt
				end
			end
			if love.keyboard.isDown("down") then
				for temp=1,#romans do
					romans[temp].y = romans[temp].y + 300 * dt
				end
			end
			for temp=1,#barbarians do
				barbarians[temp].x = barbarians[temp].x + math.random(-300,-100) * dt
				if barbarians[temp].x < 0 then
					barbarians[temp].x = love.graphics.getWidth()
					barbarians[temp].y = math.random(0,love.graphics.getHeight())
				end
				if barbarians[temp].x + barbarian:getWidth() > romans[1].x and barbarians[temp].x < romans[1].x + formations.tortoise:getWidth() * 5 then
					if barbarians[temp].y + barbarian:getHeight() > romans[1].y and barbarians[temp].y < romans[1].y + formations.tortoise:getWidth() * 5 then
						local random = math.random(1,100)
						if random < 20 then
							health = health - 50
							table.remove(barbarians,temp)
							break
						else
						table.remove(barbarians,temp)
						break
						end
					end
				end
			end
		elseif formation == "orb" then
			if #romans < 5 or health <= 0 then
				gamestate = "lost"
			elseif #barbarians < 5 then
				gamestate = "won"
			end
			if love.keyboard.isDown("left") then
				for temp=1,#romans do
					romans[temp].x = romans[temp].x + -30 * dt
				end
			end
			if love.keyboard.isDown("right") then
				for temp=1,#romans do
					romans[temp].x = romans[temp].x + 30 * dt
				end
			end
			if love.keyboard.isDown("up") then
				for temp=1,#romans do
					romans[temp].y = romans[temp].y + -30 * dt
				end
			end
			if love.keyboard.isDown("down") then
				for temp=1,#romans do
					romans[temp].y = romans[temp].y + 30 * dt
				end
			end

			for temp=1,#barbarians do
				local xDifference = romans[1].x - barbarians[temp].x
				local yDifference = romans[1].y - barbarians[temp].y
				barbarians[temp].x = barbarians[temp].x + xDifference * dt / 4
				barbarians[temp].y = barbarians[temp].y + yDifference * dt / 4

				if barbarians[temp].x + barbarian:getWidth() > romans[1].x and barbarians[temp].x < romans[1].x + formations.orb:getWidth() * 5 then
					if barbarians[temp].y + barbarian:getHeight() > romans[1].y and barbarians[temp].y < romans[1].y + formations.orb:getWidth() * 5 then
						local random = math.random(1,100)
						if random > 40 then
							table.remove(barbarians,temp)
							break
						else
							health = health - 100
							if health <= 0 then
								gamestate = "lost"
							end
						end
					end
				end
			end
		elseif formation == "wedge" then
			if #romans < 5 or health <= 0 then
				gamestate = "lost"
			elseif #barbarians < 5 then
				gamestate = "won"
			end
			if love.keyboard.isDown("left") then
				for temp=1,#romans do
					romans[temp].x = romans[temp].x + math.random(-500,-300) * dt
				end
			end
			if love.keyboard.isDown("right") then
				for temp=1,#romans do
					romans[temp].x = romans[temp].x + math.random(500,300) * dt
				end
			end
			if love.keyboard.isDown("up") then
				for temp=1,#romans do
					romans[temp].y = romans[temp].y + math.random(-500,-300) * dt
				end
			end
			if love.keyboard.isDown("down") then
				for temp=1,#romans do
					romans[temp].y = romans[temp].y + math.random(500,300) * dt
				end
			end

			for temp=1,#barbarians do
				barbarians[temp].x = barbarians[temp].x + math.random(-500,-300) * dt
				barbarians[temp].y = barbarians[temp].y + math.random(-500,500) * dt

				if barbarians[temp].x < 0 then
					barbarians[temp].x = love.graphics.getWidth()
					barbarians[temp].y = math.random(0,love.graphics.getHeight())
				end
				if barbarians[temp].y < 0 then
					barbarians[temp].y = love.graphics.getHeight()
					barbarians[temp].x = math.random(0,love.graphics.getWidth())
				elseif barbarians[temp].y > love.graphics.getHeight() then
					barbarians[temp].y = 0
					barbarians[temp].x = math.random(0,love.graphics.getWidth())
				end

				if barbarians[temp].x + barbarian:getWidth() > romans[1].x and barbarians[temp].x < romans[1].x + formations.wedge:getWidth() * 5 then
					if barbarians[temp].y + barbarian:getHeight() > romans[1].y and barbarians[temp].y < romans[1].y + formations.wedge:getWidth() * 5 then
						local random = math.random(1,100)
						if random > 40 then
							table.remove(barbarians,temp)
							break
						else
							formation = "scattered"
							for t = 1,#romans do
								romans[t].x = math.random(0,love.graphics.getWidth())
								romans[t].y = math.random(0,love.graphics.getHeight())
							end
						end
					end
				end
			end
		elseif formation == "scattered" then
			if #romans < 5 or health <= 0 then
				gamestate = "lost"
			elseif #barbarians < 5 then
				gamestate = "won"
			end
			for temp=1,#romans do
				romans[temp].x = romans[temp].x + math.random(-1000,1000) * dt
				romans[temp].y = romans[temp].y + math.random(-1000,1000) * dt
				if romans[temp].x < 0 then
					romans[temp].x = love.graphics.getWidth()
					romans[temp].y = math.random(0,love.graphics.getHeight())
				elseif romans[temp].x > love.graphics.getWidth() then
					romans[temp].x = 0
					romans[temp].y = math.random(0,love.graphics.getHeight())
				end
				if romans[temp].y < 0 then
					romans[temp].y = love.graphics.getHeight()
					romans[temp].x = math.random(0,love.graphics.getWidth())
				elseif romans[temp].y > love.graphics.getWidth() then
					romans[temp].y = 0
					romans[temp].x = math.random(0,love.graphics.getWidth())
				end

				for t=1,#barbarians do
					if barbarians[t].x + barbarian:getWidth() > romans[temp].x and barbarians[t].x < romans[temp].x + soldier:getWidth() * 5 then
						if barbarians[t].y + barbarian:getHeight() > romans[temp].y and barbarians[t].y < romans[temp].y + soldier:getHeight() * 5 then
							local random = math.random(1,100)
							if random < 70 then
								table.remove(barbarians,t)
								break
							else
								romanLost = true
							end
						end
					end
				end
				if romanLost == true then
					table.remove(romans,temp)
					romanLost = false
					break
				end
				romanLost = false
			end
			for temp=1,#barbarians do
				barbarians[temp].x = barbarians[temp].x + math.random(-1000,1000) * dt
				barbarians[temp].y = barbarians[temp].y + math.random(-1000,1000) * dt
				if barbarians[temp].x < 0 then
					barbarians[temp].x = love.graphics.getWidth()
					barbarians[temp].y = math.random(0,love.graphics.getHeight())
				elseif barbarians[temp].x > love.graphics.getWidth() then
					barbarians[temp].x = 0
					barbarians[temp].y = math.random(0,love.graphics.getHeight())
				end
				if barbarians[temp].y < 0 then
					barbarians[temp].y = love.graphics.getHeight()
					barbarians[temp].x = math.random(0,love.graphics.getHeight())
				elseif barbarians[temp].y > love.graphics.getHeight() then
					barbarians[temp].y = 0
					barbarians[temp].x = math.random(0,love.graphics.getHeight())
				end
			end
		end
	elseif gamestate == "lost" then
		if love.keyboard.isDown("space") then
			love.load()
		end
	elseif gamestate == "won" then
		if love.keyboard.isDown("space") then
			love.load()
		end
	end
end

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

function love.draw()
  local x,y = love.mouse.getPosition()
	if gamestate == "title" then
		love.graphics.draw(titleScreenImg,0,0)


    buttons.play() --set local cords to play button
		love.graphics.draw(buttonImg,buttonX,buttonY,0,5)
    love.graphics.print("PLAY",buttonX + 10,buttonY + 10)
    if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
      love.graphics.rectangle("line",buttonX - 2,buttonY - 2,buttonWidth + 4,buttonHeight + 4)
    end


  elseif gamestate == "running" then
    love.graphics.draw(titleScreenImg,0,0)
    love.graphics.print("YOU ARE UNDER ATTACK!",0,0)

		if formed == false then
			for temp=1,#romans do
				love.graphics.draw(soldier,romans[temp].x,romans[temp].y,0,3)
			end
		end
		for temp=1,#barbarians do
			love.graphics.draw(barbarian,barbarians[temp].x,barbarians[temp].y)
		end

    buttons.tortoise()
    love.graphics.draw(buttonImg,buttonX,buttonY,0,5)
    love.graphics.print("Tortoise",buttonX + 2,buttonY + 2)
    if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
        love.graphics.rectangle("line",buttonX - 2,buttonY - 2,buttonWidth + 4,buttonHeight + 4)
    end

		buttons.orb()
    love.graphics.draw(buttonImg,buttonX,buttonY,0,5)
    love.graphics.print("Orb",buttonX + 2,buttonY + 2)
    if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
        love.graphics.rectangle("line",buttonX - 2,buttonY - 2,buttonWidth + 4,buttonHeight + 4)
    end

		buttons.wedge()
    love.graphics.draw(buttonImg,buttonX,buttonY,0,5)
    love.graphics.print("Wedge",buttonX + 2,buttonY + 2)
    if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
        love.graphics.rectangle("line",buttonX - 2,buttonY - 2,buttonWidth + 4,buttonHeight + 4)
    end


    love.graphics.print("Tortoise, Orb, or Wedge formation?",10,30)
	elseif gamestate == "fighting" then
		love.graphics.draw(titleScreenImg,0,0)


		if formation == "tortoise" then
			love.graphics.draw(formations.tortoise,romans[1].x,romans[1].y,0,5)
		elseif formation == "orb" then
			love.graphics.draw(formations.orb,romans[1].x,romans[1].y,0,5)
		elseif formation == "wedge" then
			love.graphics.draw(formations.wedge,romans[1].x,romans[1].y,0,5)
		elseif formation == "scattered" then
			for temp=1,#romans do
				love.graphics.draw(soldier,romans[temp].x,romans[temp].y,0,5)
			end
		end

		for temp=1,#barbarians do
			love.graphics.draw(barbarian,barbarians[temp].x,barbarians[temp].y)
		end

		love.graphics.rectangle("fill",0,0,health,40)
	elseif gamestate == "lost" then
		love.graphics.draw(titleScreenImg,0,0)
		love.graphics.print("YOU LOST\nSPACE TO RESTART",0,0)
	elseif gamestate == "won" then
		love.graphics.draw(titleScreenImg,0,0)
		love.graphics.print("YOU WON!\nSPACE TO RESTART",0,0)
	end
end


function love.mousepressed(x, y, button)
	if gamestate == "title" then
  	buttons.play()
  	if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
    	gamestate = "running"
  	end
	elseif gamestate == "running" then
		buttons.tortoise()
		if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
			formation = "tortoise"
			formed = false
	  end

		buttons.orb()
		if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
			formation = "orb"
			formed = false
	  end

		buttons.wedge()
		if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + buttonHeight then
			formation = "wedge"
			formed = false
	  end

	end
end
