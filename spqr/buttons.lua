buttons = {}


function buttons.play()
  buttonX = love.graphics.getWidth() / 2 - (buttonImg:getWidth() * 5) / 2
  buttonY = 400
  buttonWidth = buttonImg:getWidth() * 5
  buttonHeight = buttonImg:getHeight() * 5
end

function buttons.tortoise()
  buttonX = 0
  buttonY = 400
  buttonWidth = buttonImg:getWidth() * 5
  buttonHeight = buttonImg:getHeight() * 5
end

function buttons.orb()
  buttonX = buttonImg:getWidth() * 5 + 10
  buttonY = 400
  buttonWidth = buttonImg:getWidth() * 5
  buttonHeight = buttonImg:getHeight() * 5
end

function buttons.wedge()
  buttonX = buttonImg:getWidth() * 10 + 20
  buttonY = 400
  buttonWidth = buttonImg:getWidth() * 5
  buttonHeight = buttonImg:getHeight() * 5
end

function buttons.saw()
  buttonX = buttonImg:getWidth() * 15 + 30
  buttonY = 400
  buttonWidth = buttonImg:getWidth() * 5
  buttonHeight = buttonImg:getHeight() * 5
end
