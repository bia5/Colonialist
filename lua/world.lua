
level = {
	undertiles={},
	tiles={},
	entities={}
}

worldsize = 255
chunksize = 15
actualWorldSize = ((worldsize/chunksize)*16)-2

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

function entityDumbAI(e)
	if e ~= nil then
		shouldFlip = math.random(e.refresh)
		if shouldFlip == 1 then
			if e.isBreak == true then
				e.refresh = 100
				e.isBreak = false
			end
			flip = math.random(4)
			if flip == 1 then
				e.up = not e.up
			end
			flip = math.random(4)
			if flip == 1 then
				e.dn = not e.dn
			end
			flip = math.random(4)
			if flip == 1 then
				e.rt = not e.rt
			end
			flip = math.random(4)
			if flip == 1 then
				e.lt = not e.lt
			end
			flip = math.random(10)
			if flip == 1 then
				e.isBreak = true
				e.refresh = 750
				e.up = false
				e.dn = false
				e.rt = false
				e.lt = false
			end
		end
		local aamt = 0
		if e.up then
			aamt=1
		end
		if e.lt then
			aamt=aamt+1
		end
		if e.dn then
			aamt=aamt+1
		end
		if e.rt then
			aamt=aamt+1
		end

		local aplayerSpeed = e.moveSpeed
		if aamt > 1 then
			aplayerSpeed = e.moveSpeed/3*2
		end

		if e.up then
			e.y=e.y-aplayerSpeed
		end
		if e.lt then
			e.x=e.x-aplayerSpeed
		end
		if e.dn then
			e.y=e.y+aplayerSpeed
		end
		if e.rt then
			e.x=e.x+aplayerSpeed
		end
	end
end

function getPlayer()
	for k,v in pairs(level.entities) do
		if v.id == "player" then
			return v
		end
	end
	return nil
end

function addEntity(id,tex,x,y,xoff,yoff,updateCallback,mvSpeed)
	return {id=id,tex=tex,x=x,y=y,xoff=xoff,yoff=yoff,updateCallback=updateCallback,
			up=false,dn=false,lt=false,rt=false,moveSpeed=mvSpeed,refresh=100,isBreak=false}
end

player = addEntity("player","ent_player",0,0,0,2,nil,0.03)
table.insert(level.entities,addEntity("pig","ent_pig", 5.5,5.5,0,1,entityDumbAI,0.03))
table.insert(level.entities,player)

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