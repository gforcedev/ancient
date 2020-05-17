function stageOne()
	level = 1
	stage = {}
	temp = 1
	if not love.filesystem.exists("1 19 3.txt") then
		OneNineteenThree = love.filesystem.newFile
		love.filesystem.write("1 19 3.txt","false")
	end
	if not love.filesystem.exists("1 48 1.txt") then
		OneFortyeightOne = love.filesystem.newFile
		love.filesystem.write("1 48 1.txt","false")
	end
	if not love.filesystem.exists("1 60 4.txt") then
		OneSixtyFour = love.filesystem.newFile
		love.filesystem.write("1 60 4.txt","false")
	end
	for temp=1,65 do
		stage[temp] = {3,1,1,1,1,1,1,2,0 + (64 * (temp - 1))}
	end
	stage[5][8] = 4
	stage[5][6] = 2
	stage[6][8] = 4
	stage[6][6] = 2
	stage[7][8] = 4
	stage[7][6] = 2
	stage[18][4] = 2
	stage[19][4] = 2
	stage[20][4] = 2
	if love.filesystem.read("1 19 3.txt") ~= "true" then
		stage[19][3] = 100
	end
	stage[18][1] = 1
	stage[19][1] = 1
	stage[20][1] = 1
	stage[21][1] = 1
	stage[22][1] = 1


	for temp=30,36 do
		stage[temp][6] = 2
		stage[temp][3] = 2
	end
	for temp=1,8 do
		stage[37][temp] = 1
	end
	for temp=32,36 do
		stage[temp][4] = 2
	end
	stage[37][6] = 2
	for temp = 46,50 do
		stage[temp][3] = 2
	end
	if love.filesystem.read("1 48 1.txt") ~= "true" then
		stage[48][1] = 100
	else
		stage[48][1] = 1
	end
	stage[47][1] = 1
	stage[49][1] = 1
	stage[51][4] = 2
	stage[52][5] = 2
	stage[53][6] = 2
	for temp = 51,64 do
		stage[temp][8] = 4
	end
	if love.filesystem.read("1 60 4.txt") ~= "true" then
		stage[60][4] = 100
	end
	stage[60][7] = 5
	stage[64][5] = 101
end
function drawColumn(a,b,c,d,e,f,g,h,x)
	love.graphics.draw(masterSheet,tileset[a],x,0)
	love.graphics.draw(masterSheet,tileset[b],x,64)
	love.graphics.draw(masterSheet,tileset[c],x,128)
	love.graphics.draw(masterSheet,tileset[d],x,192)
	love.graphics.draw(masterSheet,tileset[e],x,256)
	love.graphics.draw(masterSheet,tileset[f],x,320)
	love.graphics.draw(masterSheet,tileset[g],x,384)
	love.graphics.draw(masterSheet,tileset[h],x,448)
end
function drawStage()
	temp = 1
	for temp=1,64 do
		drawColumn(stage[temp][1],stage[temp][2],stage[temp][3],stage[temp][4],stage[temp][5],stage[temp][6],stage[temp][7],stage[temp][8],stagePos + ((temp - 1) * 64))
	end
end
function updateStagePos()
	temp = 1
	for temp=1,64 do
		stage[temp][9] = stagePos + (64 * (temp - 1))
	end
end
