smile = {draw = {},click = {}}


function smile.draw.button(x,y,width,height)
  if love.mouse.getX() > x and love.mouse.getX() < x + width and love.mouse.getY() > y and love.mouse.getY() < y + height then
    love.graphics.rectangle("line",x - 2,y - 2,width + 4,height + 4)
  end
end

function smile.click.button(mouseX,mouseY,x,y,width,height)
  if mouseX > x and mouseX < x + width and mouseY > y and mouseY < y + height then
    return true
  end
end