function movePlayer()
	if love.keyboard.isDown("left") and player.xvel > -600 then
		player.xvel = player.xvel - 60
	end
	if love.keyboard.isDown("right") and player.xvel < 600 then
		player.xvel = player.xvel + 60
	end
	if not (love.keyboard.isDown("left")) and not (love.keyboard.isDown("right")) then
		if player.xvel < 0 then
			player.xvel = player.xvel + 60
		elseif player.xvel > 0 then
			player.xvel = player.xvel - 60
		end
	end
	if player.x < -64 then
		player.x = 16 * 64
	elseif player.x > 16 * 64 then
		player.x = -64
	end
end
function playerPos()
	if player.y < 64 then
		player.ypos = 1
	elseif player.y < 128 and player.y > 64 then
		player.ypos = 2
	elseif player.y < 192 and player.y > 128 then
		player.ypos = 3
	elseif player.y < 256 and player.y > 192 then
		player.ypos = 4
	elseif player.y < 320 and player.y > 256 then
		player.ypos = 5
	elseif player.y < 384 and player.y > 320 then
		player.ypos = 6
	elseif player.y < 448 and player.y > 384 then
		player.ypos = 7
	elseif player.y < 512 and player.y > 448 then
		player.ypos = 8
	end
	temp = 1
	for temp=1,64 do
		if player.x > stage[temp][9] and player.x < stage[temp + 1][9] then
			player.xpos = temp
		end
	end
end
