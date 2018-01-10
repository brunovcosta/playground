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
	zoom = 40
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
		if(neighborsCount(from,i,j) == 3) then -- Qualquer célula morta com exatamente três vizinhos vivos se torna uma célula viva
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

function love.load()
	love.graphics.setBackgroundColor(10,10,10)
    love.window.setFullscreen(true, "desktop")
	
	sounds = {
		remove = love.audio.newSource("sounds/remove.wav"),
		create = love.audio.newSource("sounds/create.wav")
	}
end

windowSize = 100;
mouseLastState = {
	primary = false
}
function love.update(dt)
	i1 = player.i-windowSize/2
	i2 = player.i+windowSize/2
	j1 = player.j-windowSize/2
	j2 = player.j+windowSize/2
	--i1 = math.floor(.5+(player.i-windowSize/2)/windowSize)*windowSize
	--i2 = math.floor(.5+(player.i+windowSize/2)/windowSize)*windowSize
	--j1 = math.floor(.5+(player.j-windowSize/2)/windowSize)*windowSize
	--j2 = math.floor(.5+(player.j+windowSize/2)/windowSize)*windowSize
	-- Generation rule
	if(play) then
		nextBoard = {}
		for i=i1,i2 do
			for j=j1,j2 do
				updateCell(board,nextBoard,i,j)
			end
		end
		board = nextBoard
	end

	-- Mouse input
	mouseI = math.floor((love.mouse.getY()+camera.y)/camera.zoom)
	mouseJ = math.floor((love.mouse.getX()+camera.x)/camera.zoom)
	if love.mouse.isDown(1) and not mouseLastState.primary then
		state = boardGet(board,mouseI,mouseJ)
		boardSet(board,mouseI,mouseJ,1-state)
		if state==1 then
			sounds.remove:play()
		else
			sounds.create:play()
		end
		play=false
	end
	mouseLastState.primary = love.mouse.isDown(1)

	-- Help keys
	if love.keyboard.isDown("return") then
		play=true
	end
	if love.keyboard.isDown("delete") then
		board = {}
	end
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	print(neighborsCount(board,mouseI,mouseJ))
	
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

	i1 = player.i-windowSize/2
	i2 = player.i+windowSize/2
	j1 = player.j-windowSize/2
	j2 = player.j+windowSize/2
	--i1 = math.floor(.5+(player.i-windowSize/2)/windowSize)*windowSize
	--i2 = math.floor(.5+(player.i+windowSize/2)/windowSize)*windowSize
	--j1 = math.floor(.5+(player.j-windowSize/2)/windowSize)*windowSize
	--j2 = math.floor(.5+(player.j+windowSize/2)/windowSize)*windowSize
	-- Floor
	love.graphics.setColor(0, 0, 0, 255 )
	love.graphics.rectangle("fill", j1, i1, j2-j1, i2-i1 )

	-- Cells
	love.graphics.setColor(255,255,255,255)
	for i,list in pairs(board) do
		for j,value in pairs(list) do
			if(value~=0) then
				love.graphics.points(j,i)
			end
		end
	end

	-- Mouse
	if play then
		love.graphics.setColor(128, 255, 0, 64 )
	else
		love.graphics.setColor(255, 128, 0, 64 )
	end
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
