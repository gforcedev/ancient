--QUADS---------------------------------------------------------------

local examplesheet = love.graphics.newImage("assets/kits/rayquaza95.png")
quads = {}

quads.still = {love.graphics.newQuad(0,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())}


quads.shootingleft = {love.graphics.newQuad(129,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())}
quads.shootingRight = {love.graphics.newQuad(193,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())}

quads.meleeLeft = {love.graphics.newQuad(0,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())}
quads.meleeRight = {love.graphics.newQuad(65,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())}

quads.runningLeft = {}
quads.runningLeft[1] = love.graphics.newQuad(65,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.runningLeft[2] = love.graphics.newQuad(129,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.runningLeft[3] = love.graphics.newQuad(193,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.runningLeft[4] = love.graphics.newQuad(257,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())

quads.runningRight = {}
quads.runningRight[1] = love.graphics.newQuad(321,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.runningRight[2] = love.graphics.newQuad(385,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.runningRight[3] = love.graphics.newQuad(449,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.runningRight[4] = love.graphics.newQuad(512,0,64,64,examplesheet:getWidth(),examplesheet:getHeight())


quads.rangedLeft = {}
quads.rangedLeft[1] = love.graphics.newQuad(0,129,16,16,examplesheet:getWidth(),examplesheet:getHeight())
quads.rangedLeft[2] = love.graphics.newQuad(17,129,16,16,examplesheet:getWidth(),examplesheet:getHeight())
quads.rangedLeft[3] = love.graphics.newQuad(0,145,16,16,examplesheet:getWidth(),examplesheet:getHeight())
quads.rangedLeft[4] = love.graphics.newQuad(17,145,16,16,examplesheet:getWidth(),examplesheet:getHeight())


quads.rangedRight = {}
quads.rangedRight[1] = love.graphics.newQuad(0,129,16,16,examplesheet:getWidth(),examplesheet:getHeight())
quads.rangedRight[2] = love.graphics.newQuad(17,129,16,16,examplesheet:getWidth(),examplesheet:getHeight())
quads.rangedRight[3] = love.graphics.newQuad(0,145,16,16,examplesheet:getWidth(),examplesheet:getHeight())
quads.rangedRight[4] = love.graphics.newQuad(17,145,16,16,examplesheet:getWidth(),examplesheet:getHeight())

quads.special = {}
quads.special[1] = love.graphics.newQuad(257,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.special[2] = love.graphics.newQuad(321,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.special[3] = love.graphics.newQuad(385,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.special[4] = love.graphics.newQuad(449,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())
quads.special[5] = love.graphics.newQuad(513,65,64,64,examplesheet:getWidth(),examplesheet:getHeight())

quads.specialProjectiles = {}
quads.specialProjectiles[1] = love.graphics.newQuad(65,129,16,16,examplesheet:getWidth(),examplesheet:getHeight())

--KITS------------------------------------------------------------------


function defineKits()
	kits = {}
	
	kits.gforcedev = {gravity = 3000,width = 60,height = 60,sheet = love.graphics.newImage("assets/kits/gforcedev.png"),quadTable = quads.still,maxQuad = 1,quadID = 1,equip = 1,timer = 0,grounded = false,health = 100,ranged = {},armour = 15,meleeDamage = 100,reach = 10,rangedDamage = 300,rangedxvel = 1000,facing = "left",sprinkles = 0,maxSprinkles = 100,specialTimer = 0}
	
	function kits.gforcedev.melee(p,b)
		if p.facing == "left" then
	        	if p.y + p.height > b.y - p.reach and p.y < b.y + b.height + p.reach then
				if p.x + p.width > b.x - p.reach and p.x < b.x + b.width + p.reach and p.x > b.x then --player is facing left (to right of enemy) 
					b.health = b.health - p.meleeDamage / b.armour
				end
			end
			p.quadTable = quads.meleeLeft
			p.maxQuad = 1
			p.quadID = 1
		elseif p.facing == "right" then
	        	if p.y + p.height > b.y - p.reach and p.y < b.y + b.height + p.reach then
				if p.x + p.width > b.x - p.reach and p.x < b.x + b.width + p.reach and p.x < b.x then --player is facing right (to left of enemy) 
					b.health = b.health - p.meleeDamage / b.armour
				end
			end
			p.quadTable = quads.meleeRight
			p.maxQuad = 1
			p.quadID = 1
		end
	end
	function kits.gforcedev.shoot(p)
		if p.facing == "left" then
			table.insert(p.ranged,{x = (p.x + p.width / 2),y = (p.y + p.width / 2) - 8,xvel = -p.rangedxvel,yvel = 0,width = 16,height = 16,quads = quads.rangedLeft,quad = 1})
			p.quadTable = quads.shootingleft
			p.maxQuad = 1
			p.quadID = 1
		elseif p.facing == "right" then
			table.insert(p.ranged,{x = (p.x + p.width / 2),y = (p.y + p.width / 2) - 8,xvel = p.rangedxvel,yvel = 0,width = 16,height = 16,quads = quads.rangedRight,quad = 1})
			p.quadTable = quads.shootingRight
			p.maxQuad = 1
			p.quadID = 1
		end
	end
	function kits.gforcedev.updateRanged(p,b)
		for i=1,#p.ranged do
			p.ranged[i].x = p.ranged[i].x + p.ranged[i].xvel * deltaTime --move
	
				p.ranged[i].quad = p.ranged[i].quad + 1 --change look
				if p.ranged[i].quad > 4 then
					p.ranged[i].quad = 1
				end
	
			if p.ranged[i].x + p.ranged[i].width > b.x and p.ranged[i].x < b.x + b.width then
	        		if p.ranged[i].y + p.ranged[i].height > b.y - 3 and p.ranged[i].y < b.y + b.height + 3 then
					b.health = b.health - math.floor(p.rangedDamage / b.armour) --damage
					table.remove(p.ranged,i)
					break
				end
			end
	
			if p.ranged[i].x > love.graphics.getWidth() then
				table.remove(p.ranged,i)
				break
			elseif p.ranged[i].x < 0 then
				table.remove(p.ranged,i)
				break
			end
		end
	end
	function kits.gforcedev.special(p,b)
		if p.sprinkles > 75 then
			p.sprinkles = p.sprinkles - 75
			
			p.specialTimer = 1
	
			p.quadTable = quads.special
			p.maxQuad = 5
			p.quadID = 1
		end
	end
	function kits.gforcedev.updateSpecial(p,b)
		if p.specialTimer > 0 then
			p.quadTable = quads.special
			p.maxQuad = 5
	    		if p.x + p.width > b.x - 16 and p.x < b.x + b.width + 16 then
	    	 	   	if p.y + p.height > b.y - 3 and p.y < b.y + b.height + 3 then
				    b.health = b.health - 75 * deltaTime
			    	end
	        	end
		end
		p.specialTimer = p.specialTimer - deltaTime
			
	end
	function kits.gforcedev.drawSpecial(p)
		if p.specialTimer > 0 then
			for y=1,math.floor(p.y / 16) + 4 do
				love.graphics.draw(p.sheet,quads.specialProjectiles[1],p.x + 16,(y - 1) * 16)
			end
		end
	end
	
	
	
	
	
	kits.rayquaza95 = {gravity = 3000,width = 60,height = 60,sheet = love.graphics.newImage("assets/kits/rayquaza95.png"),quadTable = quads.still,maxQuad = 1,quadID = 1,equip = 1,timer = 0,grounded = false,health = 100,ranged = {},armour = 10,meleeDamage = 120,reach = 15,rangedDamage = 300,rangedxvel = 700,sprinkles = 0,maxSprinkles = 100}
	
	
	
	
	function kits.rayquaza95.melee(p,b)
		if p.facing == "left" then
	        	if p.y + p.height > b.y - p.reach and p.y < b.y + b.height + p.reach then
				if p.x + p.width > b.x - p.reach and p.x < b.x + b.width + p.reach and p.x > b.x then --player is facing left (to right of enemy) 
					b.health = b.health - p.meleeDamage / b.armour
				end
			end
			p.quadTable = quads.meleeLeft
			p.maxQuad = 1
			p.quadID = 1
		elseif p.facing == "right" then
	        	if p.y + p.height > b.y - p.reach and p.y < b.y + b.height + p.reach then
				if p.x + p.width > b.x - p.reach and p.x < b.x + b.width + p.reach and p.x < b.x then --player is facing right (to left of enemy) 
					b.health = b.health - p.meleeDamage / b.armour
				end
			end
			p.quadTable = quads.meleeRight
			p.maxQuad = 1
			p.quadID = 1
		end
	end
	function kits.rayquaza95.shoot(p)
		if p.facing == "left" then
			table.insert(p.ranged,{x = (p.x + p.width / 2),y = (p.y + p.width / 2) - 8,xvel = -p.rangedxvel,yvel = 0,width = 16,height = 16,quads = quads.rangedLeft,quad = 1})
			p.quadTable = quads.shootingleft
			p.maxQuad = 1
			p.quadID = 1
		elseif p.facing == "right" then
			table.insert(p.ranged,{x = (p.x + p.width / 2),y = (p.y + p.width / 2) - 8,xvel = p.rangedxvel,yvel = 0,width = 16,height = 16,quads = quads.rangedRight,quad = 1})
			p.quadTable = quads.shootingRight
			p.maxQuad = 1
			p.quadID = 1
		end
	end
	function kits.rayquaza95.updateRanged(p,b)
		for i=1,#p.ranged do
			p.ranged[i].x = p.ranged[i].x + p.ranged[i].xvel * deltaTime
	
				p.ranged[i].quad = p.ranged[i].quad + 1
				if p.ranged[i].quad > 4 then
					p.ranged[i].quad = 1
				end
	
			if p.ranged[i].x + p.ranged[i].width > b.x and p.ranged[i].x < b.x + b.width then
	        		if p.ranged[i].y + p.ranged[i].height > b.y - 3 and p.ranged[i].y < b.y + b.height + 3 then
					b.health = b.health - math.floor(p.rangedDamage / b.armour)
					table.remove(p.ranged,i)
					break
				end
			end
			if p.ranged[i].x > love.graphics.getWidth() then
				table.remove(p.ranged,i)
				break
			elseif p.ranged[i].x < 0 then
				table.remove(p.ranged,i)
				break
			end
		end
	end
	function kits.rayquaza95.special(p,b)
		if p.sprinkles > 75 then
			p.sprinkles = p.sprinkles - 75
			p.health = p.health + 50
			if p.health > 100 then
				p.health = 100
			end
			p.quadTable = quads.special
			p.maxQuad = 5
			p.quadID = 1
		end
	end										end
