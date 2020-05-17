--to fix error, edit "yvel + gravity" so that gravity is only added when not colliding.
function collide(a,b)
    if a.x + a.width > b.x and a.x < b.x + b.width then
        if a.y + a.height > b.y and a.y < b.y + b.height then
            if a.y + a.height < b.y + (b.height / 2) then
                a.yvel = 0
                gravity = 0
                a.y = b.y - a.height - 1
                a.grounded = true
                return true
            end
        end
    end
    if a.x + a.width > b.x and a.x < b.x + b.width then
        if a.y + a.height > b.y and a.y < b.y + b.height then
            if a.y > b.y + (b.height / 2) then
                a.yvel = 0
                gravity = 3000
                a.y = b.y + b.height + 1
            end
        end
    end
    if a.x + a.width > b.x and a.x < b.x + b.width then
        if a.y + a.height > b.y and a.y < b.y + b.height then
            if a.x < b.x + (b.width / 2) then
                a.xvel = 0
                a.x = b.x - a.width
            end
        end
    end
    if a.x + a.width > b.x and a.x < b.x + b.width then
        if a.y + a.height > b.y and a.y < b.y + b.height then
            if a.x > b.x + (b.width / 2) then
                a.xvel = 0
                a.x = b.x + b.width
            end
        end
    end



end



function playerMove(p)
    --update
    if p.yvel < 600 then
        p.yvel = p.yvel + gravity * deltaTime
    end
    p.y = p.y + p.yvel * deltaTime
    p.x = p.x + p.xvel * deltaTime

    --move
    if love.keyboard.isDown(p.up) and p.grounded == true then
        p.yvel = -900
        gravity = 3000
        p.grounded = false
    end
    if love.keyboard.isDown(p.left) and p.xvel > -700 then
        p.xvel = p.xvel - 70
        elseif love.keyboard.isDown(p.right) and p.xvel < 700 then
        p.xvel = p.xvel + 70
        elseif not (love.keyboard.isDown(p.left) and love.keyboard.isDown(p.right)) and p.xvel < 0 then
        p.xvel = p.xvel + 70
        elseif not (love.keyboard.isDown(p.left) and love.keyboard.isDown(p.right)) and p.xvel > 0 then
        p.xvel = p.xvel - 70
    end

    --inscreen
    if p.y < 0 then
        p.y = love.graphics.getHeight()
        elseif p.y > love.graphics.getHeight() then
        p.y = 0
    end
    if p.x < 0 then
        p.x = love.graphics.getWidth() - 64
        elseif p.x > love.graphics.getWidth() - 64 then
        p.x = 0
    end

    --melee
    if love.keyboard.isDown(p.melee) then
        p.quad = quads.melee
        p.meleeTimer = 0.3
        p.meleeAttack = true
    end
    if p.meleeAttack == true then
        p.meleeTimer = p.meleeTimer - deltaTime
        if p.meleeTimer < 0 then
            p.meleeAttack = false
            p.quad = quads.still
        end
    end
    gravity = 3000
end
