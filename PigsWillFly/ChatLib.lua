

function emote(x,y,eyes,nose,mouth)
    love.graphics.setColor(255,255,255)
    love.graphics.print(eyes .. nose .. mouth,x,y - 100)
end

function createChatBox(x,y,width,height)
    chatBox ={
        x = x,
        y = y,
        width = width,
        height = height,
    }
end

function chat()
    function love.textinput(t)
        love.graphics.print(t,chatBox.x,chatBox.y)
    end
end