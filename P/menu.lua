function menu()
	if menuState == "title" then
		if smile.rectangleMouseButton((love.graphics.getWidth() / 2) - 100,300,64,64) then
			menuState = "levels"
		elseif smile.rectangleMouseButton((love.graphics.getWidth() / 2) + 100,300,64,64) then
			love.filesystem.remove("1 19 3.txt")
			love.filesystem.remove("1 48 1.txt")
			love.filesystem.remove("1 60 4.txt")
		end
	elseif menuState == "levels" then
		if smile.rectangleMouseButton(0,0,64,64) then
			stageOne()
			gamestate = "running"
		end
	end
end
function drawMenu()
	if menuState == "title" then
		love.graphics.setColor(0,50,240)
		love.graphics.rectangle("fill",(love.graphics.getWidth() / 2) - 100,300,64,64)
		love.graphics.print("PLAY",(love.graphics.getWidth() / 2) - 100,370)
		if smile.rectangleMouseArea((love.graphics.getWidth() / 2) - 100,300,64,64) then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",(love.graphics.getWidth() / 2) - 100,300,64,64)
			love.graphics.setColor(0,50,240)
		end
		love.graphics.setColor(255,50,20)
		love.graphics.rectangle("fill",(love.graphics.getWidth() / 2) + 100,300,64,64)
		love.graphics.print("CLEAR PROGRESS",(love.graphics.getWidth() / 2) + 100,370)
		if smile.rectangleMouseArea((love.graphics.getWidth() / 2) + 100,300,64,64) then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",(love.graphics.getWidth() / 2) + 100,300,64,64)
			love.graphics.setColor(0,50,240)
		end
		
	elseif menuState == "levels" then
		if love.filesystem.read("1 19 3.txt") == "true" and love.filesystem.read("1 48 1.txt") == "true" and love.filesystem.read("1 60 4.txt") == "true" then
			love.graphics.setColor(20,210,20)
		else
			love.graphics.setColor(0,50,240)
		end
		love.graphics.rectangle("fill",0,0,64,64)
		love.graphics.print("1",28,70)
		if smile.rectangleMouseArea(0,0,64,64) then
			love.graphics.setColor(0,0,0)
			love.graphics.rectangle("line",0,0,64,64)
			love.graphics.setColor(0,50,240)
		end
	end
end
