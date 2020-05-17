smile = {}
function smile.rectangleMouseButton(buttonX,buttonY,buttonWidth,buttonHeight)
	local x,y = love.mouse.getPosition()
	if x > buttonX and x < (buttonX + buttonWidth) and y > buttonY and y < (buttonY + buttonHeight) then
		if love.mouse.isDown(1) then
			return true
		end
	end
end
