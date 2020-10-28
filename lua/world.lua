
level = {
	undertiles={},
	tiles={},
	entities={}
}

worldsize = 255
chunksize = 15

function newTile(id,tex,x,y,callback,w,h,xo,yo)
	return {id=id,tex=tex,x=x,y=y,callback=callback,w=w,h=h,xo=xo,yo=yo}
end

function getUndertile(x,y)
	if level.undertiles[math.floor(x/chunksize).."-"..math.floor(y/chunksize)] then
		return level.undertiles[math.floor(x/chunksize).."-"..math.floor(y/chunksize)][x.."-"..y]
	end
	return nil
end

function setUndertile(x,y,tile)
	level.undertiles[math.floor(x/chunksize).."-"..math.floor(y/chunksize)][x.."-"..y] = tile
end

function generateChunkUndertiles(xx,yy)
	level.undertiles[xx.."-"..yy] = {}
	for y = 0, chunksize do
		for x = 0, chunksize do
			level.undertiles[xx.."-"..yy][(xx*chunksize)+x.."-"..(yy*chunksize)+y] = newTile("grass","under_grass_0",xx*chunksize+x,yy*chunksize+y,nil)
		end
	end
end

function generateUndertiles()
	print("Generating undertiles")
	for y = 0, worldsize/chunksize do
		for x = 0, worldsize/chunksize do
			generateChunkUndertiles(x,y)
		end
	end
	print("Finished generating undertiles")
end

function getTile(x,y)
	if level.tiles[math.floor(x/chunksize).."-"..math.floor(y/chunksize)] then
		return level.tiles[math.floor(x/chunksize).."-"..math.floor(y/chunksize)][x.."-"..y]
	end
	return nil
end

function setTile(x,y,tile)
	level.tiles[math.floor(x/chunksize).."-"..math.floor(y/chunksize)][x.."-"..y] = tile
end

function generateChunkTiles(xx,yy)
	level.tiles[xx.."-"..yy] = {}
	for y = 0, chunksize do
		for x = 0, chunksize do
			perc = math.random()
			if perc > 0.6 and perc < 0.8 then
				level.tiles[xx.."-"..yy][(xx*chunksize)+x.."-"..(yy*chunksize)+y] = newTile("treeMedium_0","tile_treeMedium_0",xx*chunksize+x,yy*chunksize+y,nil,1,2,0,-1)
			elseif perc > 0.8 and perc < 0.9 then
				level.tiles[xx.."-"..yy][(xx*chunksize)+x.."-"..(yy*chunksize)+y] = newTile("bush_0","tile_bush_0",xx*chunksize+x,yy*chunksize+y,nil)
			elseif perc > 0.95 then
				level.tiles[xx.."-"..yy][(xx*chunksize)+x.."-"..(yy*chunksize)+y] = newTile("rock_0","tile_rock_0",xx*chunksize+x,yy*chunksize+y,nil)
			end
		end
	end
end

function addEntity(id,tex,x,y)
	return {id=id,tex=tex,x=x,y=y}
end

player = addEntity("player","ent_player",0,0)

function generateTiles()
	print("Generating tiles")
	for y = 0, worldsize/chunksize do
		for x = 0, worldsize/chunksize do
			generateChunkTiles(x,y)
		end
	end
	print("Finished generating tiles")
end

function saveLevel(lvlname)
	
end

function loadLevel(lvlname)
	
end

function generateLevel()
	generateUndertiles()
	generateTiles()
end