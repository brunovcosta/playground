local pprint = require('pprint')

board = {}
for i=1,100 do
	board[i]={}
	for j=1,100 do
		board[i][j]=0
	end
end

camera = {
	x = 0,
	y = 0,
	zoom = 10
}

play = true

player = {
	i = 10,
	j = 20,
	speed = .3
}

love.mouse.setVisible(false)


function updateCell(from,to,i,j)
	if(boardGet(from,i,j) == 1) then
		if(neighborsCount(from,i,j)<2) then -- Qualquer célula viva com menos de dois vizinhos vivos morre de solidão
			boardSet(to,i,j,0)
		elseif(neighborsCount(from,i,j)>3) then -- Qualquer célula viva com mais de três vizinhos vivos morre de superpopulação
			boardSet(to,i,j,0)
		else -- Qualquer célula viva com dois ou três vizinhos vivos continua no mesmo estado para a próxima geração
			prev = boardGet(from,i,j)
			boardSet(to,i,j,prev)
		end
	else
		if(neighborsCount(from,i,j)==3) then -- Qualquer célula morta com exatamente três vizinhos vivos se torna uma célula viva
			boardSet(to,i,j,1)
		else
			boardSet(to,i,j,0)
		end
	end
end

function boardGet(board,i,j)
	i = math.floor(i)
	j = math.floor(j)

	if not board[i] then
		return 0
	end
	return board[i][j] or 0
end

function boardSet(board,i,j,value)
	i = math.floor(i)
	j = math.floor(j)

	if not board[i] then
		board[i] = {}
	end
	board[i][j] = value
end

windowSize = 50;
function love.update(dt)
	-- Generation rule
	if(play) then
		nextBoard = board
		for i=player.i-windowSize/2,player.i+windowSize/2 do
			for j=player.j-windowSize/2,player.j+windowSize/2 do
				updateCell(board,nextBoard,i,j)
			end
		end
		board = nextBoard
	end

	-- Mouse input
	mouseI = math.floor((love.mouse.getY()+camera.y)/camera.zoom)
	mouseJ = math.floor((love.mouse.getX()+camera.x)/camera.zoom)
	if(love.mouse.isDown(1)) then
		boardSet(board,mouseI,mouseJ,1)
		play=false
	end
	if(love.mouse.isDown(2)) then
		boardSet(board,mouseI,mouseJ,0)
		play=false
	end
	if love.keyboard.isDown("return") then
		play=true
	end
	
	-- Player motion
	i=math.floor(player.i)
	j=math.floor(player.j)

	if love.keyboard.isDown("w") then
		player.i=player.i-player.speed
	end
	if love.keyboard.isDown("s") then
		player.i=player.i+player.speed
	end
	if love.keyboard.isDown("a") then
		player.j=player.j-player.speed
	end
	if love.keyboard.isDown("d") then
		player.j=player.j+player.speed
	end

	-- Colision detection
	if boardGet(board,math.floor(player.i),math.floor(player.j)) == 1 then
		player.i=10
		player.j=10
	end

	-- Camera motion
	camera.x = camera.zoom*player.j-love.graphics.getWidth()/2
	camera.y = camera.zoom*player.i-love.graphics.getHeight()/2

	-- Camera zoom
	zoomRate = 1.01
	if love.keyboard.isDown("1") then
		camera.zoom = camera.zoom*zoomRate
	end
	if love.keyboard.isDown("2") then
		camera.zoom = camera.zoom/zoomRate
	end
end
board_cell = 20
function love.draw()
	love.graphics.translate(-camera.x, -camera.y )
	love.graphics.scale( camera.zoom, camera.zoom )
	love.graphics.setPointSize(math.ceil(camera.zoom))

	-- Floor
	for i=math.floor(player.i)-windowSize/2,math.floor(player.i)+windowSize/2 do
		for j=math.floor(player.j)-windowSize/2,math.floor(player.j)+windowSize/2 do
			if (math.floor(i/board_cell)+math.floor(j/board_cell))%2==0 then
				love.graphics.setColor(100,100,255,255)
			else
				love.graphics.setColor(120,120,255,255)
			end
			love.graphics.points(j,i)
		end
	end

	-- Cells
	for i,list in pairs(board) do
		for j,value in pairs(list) do
			if(value~=0) then
				love.graphics.setColor(0,0,255,255)
				love.graphics.points(j,i)
			end
		end
	end

	-- Player
	love.graphics.setColor(255, 0, 0, 255 )
	love.graphics.points(player.j,player.i)

	-- Mouse
	love.graphics.setColor(128, 255, 0, 64 )
	love.graphics.points(
		math.floor((love.mouse.getX() + camera.x)/camera.zoom),
		math.floor((love.mouse.getY() + camera.y)/camera.zoom)
	)
	
end

function neighborsCount(board,i,j)
	sum=0
	sum=sum+boardGet(board,i-1,j-1)
	sum=sum+boardGet(board,i-1,j+1)

	sum=sum+boardGet(board,i+1,j-1)
	sum=sum+boardGet(board,i+1,j+1)

	sum=sum+boardGet(board,i-1,j)
	sum=sum+boardGet(board,i+1,j)

	sum=sum+boardGet(board,i,j-1)
	sum=sum+boardGet(board,i,j+1)
	return sum
end
