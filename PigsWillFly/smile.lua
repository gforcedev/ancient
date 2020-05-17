smile = {mouse = {}}
function smile.mouse.rectangleButton(buttonX,buttonY,buttonWidth,buttonHeight)
	local x,y = love.mouse.getPosition()
	if x > buttonX and x < (buttonX + buttonWidth) and y > buttonY and y < (buttonY + buttonWidth) then
		if love.mouse.isDown("l") then
			return true
		end
	end
end