function collide(a,b)
    if a.x + a.width > b.x and a.x < b.x + b.width then
        if a.y + a.height > b.y - 3 and a.y < b.y + b.height + 3 then


            if a.y + a.height < b.y + (b.height / 2) then -- down
                a.yvel = 0
                gravity = 0
                a.y = b.y - a.height - 3
                a.grounded = true
                return true
            end



        end
    end
    if a.x + a.width > b.x and a.x < b.x + b.width then
        if a.y + a.height > b.y - 3 and a.y < b.y + b.height + 3 then
            
		
	    if a.y > b.y + (b.height / 2) then --up
                a.yvel = 0
                gravity = 3000
                a.y = b.y + b.height + 3
            end



        end
    end
    if a.x + a.width > b.x - 3 and a.x < b.x + b.width + 3 then
        if a.y + a.width > b.y and a.y < b.y + b.width then
            
		
	    if a.x < b.x + (b.width / 2) then --left
		a.quadTable = quads.still
		a.maxQuad = 1
		a.quadID = 1
                a.xvel = 0
                a.x = b.x - a.width - 3
            end



        end
    end
    if a.x + a.width > b.x - 3 and a.x < b.x + b.width + 3 then
        if a.y + a.width > b.y and a.y < b.y + b.width then
            
		
	    if a.x > b.x + (b.width / 2) then --right
		a.quadTable = quads.still
		a.maxQuad = 1
		a.quadID = 1
                a.xvel = 0
                a.x = b.x + b.width + 3
            end



        end
    end
end



function playerMove(p,b)
    --update
    p.y = p.y + p.yvel * deltaTime
    p.x = p.x + p.xvel * deltaTime


    p.timer = p.timer - deltaTime
    if p.timer < 0 then
    	--facing for shoot/drawing
    	if p.xvel < 0 then
	    p.facing = "left"
	    p.quadTable = quads.runningLeft
	    p.maxQuad = 4
    	end
    	if p.xvel > 0 then 
	    p.facing = "right"
	    p.quadTable = quads.runningRight
	    p.maxQuad = 4
    	end
	if p.xvel == 0 then
	    p.quadTable = quads.still
	    p.maxQuad = 1
	    p.quadID = 1
    	end
		
    end
    p.sprinkles = p.sprinkles + deltaTime * 7
    if p.sprinkles > p.maxSprinkles then
	    p.sprinkles = p.maxSprinkles
    end

    --change quad
    	p.quadID = p.quadID + 1
    	if p.quadID > p.maxQuad then
	    p.quadID = 1
    	end

    --player collide
    if p.x + p.width > b.x and p.x < b.x + b.width then
        if p.y + p.height > b.y - 3 and p.y < b.y + b.height + 3 then


            if p.y + p.height < b.y + (b.height / 2) then -- down
		p.grounded = true
                p.y = b.y - p.height - 3
		b.y = p.y + p.height + 3
            end



        end
    end
    if p.x + p.width > b.x and p.x < b.x + b.width then
        if p.y + p.height > b.y - 3 and p.y < b.y + b.height + 3 then
            
		
	    if p.y > b.y + (b.height / 2) then --up
                p.y = b.y + b.height + 3
		b.y = p.y - b.height - 3
            end



        end
    end
    if p.x + p.width > b.x - 3 and p.x < b.x + b.width + 3 then
        if p.y + p.width > b.y and p.y < b.y + b.width then
            
		
	    if p.x < b.x + (b.width / 2) then --left
                p.x = b.x - p.width - 3
		b.x = p.x + b.width + 3		    
		p.xvel = 0
		b.xvel = 0
            end



        end
    end
    if p.x + p.width > b.x - 3 and p.x < b.x + b.width + 3 then
        if p.y + p.width > b.y and p.y < b.y + b.width then
            
		
	    if p.x > b.x + (b.width / 2) then --right
                p.x = b.x + b.width + 3
		b.x = p.x - b.width - 3		    
		p.xvel = 0
		b.xvel = 0
            end



        end
    end


    if p.yvel < 500 then
        p.yvel = p.yvel + p.gravity * deltaTime
    end
    --move
    if love.keyboard.isDown(p.up) and p.grounded == true then
        p.yvel = -900
        gravity = 3000
        p.grounded = false
    end
    if love.keyboard.isDown(p.left) and p.xvel > -500 then
        p.xvel = p.xvel - 50
        elseif love.keyboard.isDown(p.right) and p.xvel < 500 then
        p.xvel = p.xvel + 50
        elseif not (love.keyboard.isDown(p.left) and love.keyboard.isDown(p.right)) and p.xvel < 0 then
        p.xvel = p.xvel + 50
        elseif not (love.keyboard.isDown(p.left) and love.keyboard.isDown(p.right)) and p.xvel > 0 then
        p.xvel = p.xvel - 50
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


    p.updateRanged(p,b)
    if p.updateSpecial ~= nil then
	    p.updateSpecial(p,b)
    end
    if b.specialTimer ~= nil then
	    if b.specialTimer < 0 then
		p.health = math.floor(p.health)
	end
    end

    p.gravity = 3000
end



function playerKeyPress(p,b)
	if button == p.cycle then
		p.equip = p.equip + 1
		if p.equip > 3 then
			p.equip = 1
			end
	elseif button == p.attack then
		if p.timer < 0 then
			if p.equip == 1 then
				p.melee(p,b)
				p.timer = 0.3
			elseif p.equip == 2 then
				p.shoot(p)
				p.timer = 0.3
			elseif p.equip == 3 then
				p.special(p,b)
				p.timer = 0.3
			end
		end
	end
end
