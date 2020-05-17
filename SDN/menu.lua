gui = {}

gui.title = {}
gui.title.play = love.graphics.newImage("assets/gui/play.png")
gui.title.playHovered = love.graphics.newImage("assets/gui/playHovered.png")

gui.ko = {}
gui.ko.ko = love.graphics.newImage("assets/gui/ko.png")
function updateMenu()
	if menustate == "title" then
		if smile.rectangleMouseButton((love.graphics.getWidth() / 2) - 100,(love.graphics.getHeight() / 2) - 80,200,160) then
			menustate = "fighting"
			gamestate = "fighting"
		end



	elseif menustate == "ko" then
		if love.keyboard.isDown(" ") then
			love.load()
		end
	end
end




function drawMenu()
	love.graphics.setColor(255,255,255)
	if menustate == "title" then
		if smile.rectangleMouseArea((love.graphics.getWidth() / 2) - 100,(love.graphics.getHeight() / 2) - 80,200,160) then
			love.graphics.draw(gui.title.playHovered,(love.graphics.getWidth() / 2) - 100,(love.graphics.getHeight() / 2) - 80)
		else
			love.graphics.draw(gui.title.play,(love.graphics.getWidth() / 2) - 100,(love.graphics.getHeight() / 2) - 80)
		end


	elseif menustate == "fighting" then
		love.graphics.setColor(255,120,110)
		love.graphics.rectangle("fill",0,0,math.floor(pOne.health),16)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",love.graphics.getWidth() - math.floor(pTwo.health),0,math.floor(pTwo.health),16)
		love.graphics.setColor(30,255,10)
		love.graphics.rectangle("fill",0,16,math.floor(pOne.sprinkles),10)
		love.graphics.rectangle("fill",love.graphics.getWidth() - math.floor(pTwo.sprinkles),16,math.floor(pTwo.sprinkles),10)
	elseif menustate == "ko" then
		love.graphics.draw(gui.ko.ko,200,200)
		love.graphics.draw(winner.sheet,winner.quadTable[winner.quadID],winner.x,winner.y)
		love.graphics.setColor(255,255,255)
		love.graphics.print("space to finish",300,370)
	end
end
