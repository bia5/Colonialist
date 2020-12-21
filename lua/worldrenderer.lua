local spr = Sprite.new(nil)
local tilesize = 14
local tilepix = math.floor(mya_getHeight()/tilesize)
offsetx = 0
offsety = 0

text_x = TextView.new(font, "X 0", 0, (mya_getHeight()/31), mya_getRenderer())
text_x:setColor(mya_getRenderer(), 15, 15, 15)
text_y = TextView.new(font, "Y 0", 0, (mya_getHeight()/31)*2, mya_getRenderer())
text_y:setColor(mya_getRenderer(), 15, 15, 15)

function renderSpriteUndertile(x,y)
	local tile = getUndertile(x,y)
	if tile ~= nil then
		spr:setTexture(assets:getTexture(tile.tex))
		spr:setX((tile.x*tilepix)+(mya_getWidth()/2)-offsetx)
		spr:setY((tile.y*tilepix)+(mya_getHeight()/2)-offsety)
		spr:render(mya_getRenderer(), tilepix, tilepix)
	end
end

function renderSpriteTile(x,y)
	local tile = getTile(x,y)
	if tile ~= nil then
		spr:setTexture(assets:getTexture(tile.tex))
		if tile.xo and tile.yo then
			spr:setX((tile.x*tilepix)+(mya_getWidth()/2)+(tilepix*tile.xo)-offsetx)
			spr:setY((tile.y*tilepix)+(mya_getHeight()/2)+(tilepix*tile.yo)-offsety)
		else
			spr:setX((tile.x*tilepix)+(mya_getWidth()/2)-offsetx)
			spr:setY((tile.y*tilepix)+(mya_getHeight()/2)-offsety)
		end
		if tile.w and tile.h then
			spr:render(mya_getRenderer(), (tilepix*tile.w), (tilepix*tile.h))
		else
			spr:render(mya_getRenderer(), tilepix, tilepix)
		end
	end
end

function renderEntity(ent)
	if ent ~= nil then
		if ent.id == "player" then
			offsetx = ent.x*tilepix
			offsety = ent.y*tilepix
		end
		spr:setTexture(assets:getTexture(ent.tex))
		spr:setX((ent.x*tilepix)-(tilepix/2)+(mya_getWidth()/2)-offsetx)
		spr:setY((ent.y*tilepix)-(tilepix*ent.yoff)+(mya_getHeight()/2)-offsety)
		spr:render(mya_getRenderer(), tilepix, tilepix*ent.yoff)
	end
end

function wr_resize(w,h)
	tilepix = math.floor(mya_getHeight()/tilesize)

	text_x = TextView.new(font, "X 0", 0, (mya_getHeight()/31), mya_getRenderer())
	text_x:setColor(mya_getRenderer(), 15, 15, 15)
	text_y = TextView.new(font, "Y 0", 0, (mya_getHeight()/31)*2, mya_getRenderer())
	text_y:setColor(mya_getRenderer(), 15, 15, 15)
end

function renderEntityAtY(y)
	for v,e in pairs(level.entities) do
		if math.floor(e.y) == y then
			renderEntity(e)
		end
	end
end

function wr_render()
	xxx = math.floor(player.x)-15
	yyy = math.floor(player.y)-8
	for y = yyy, yyy+16 do
		for x = xxx, xxx+30 do
			renderSpriteUndertile(x,y)
		end
	end

	for y = yyy, yyy+16 do
		renderEntityAtY(y)
		for x = xxx, xxx+30 do
			renderSpriteTile(x,y)
		end
	end

	if devmode == true then
		text_x:renderWH(mya_getRenderer(), mya_getWidth()/32, mya_getHeight()/32)
		text_y:renderWH(mya_getRenderer(), mya_getWidth()/32, mya_getHeight()/32)
	end
end

function wr_tupdate() 
	player = getPlayer()
	local aamt = 0
	if player.up then
		aamt=1
	end
	if player.lt then
		aamt=aamt+1
	end
	if player.dn then
		aamt=aamt+1
	end
	if player.rt then
		aamt=aamt+1
	end

	local aplayerSpeed = player.moveSpeed
	if aamt > 1 then
		aplayerSpeed = player.moveSpeed/3*2
	end

	if player.up then
		player.y=player.y-aplayerSpeed
	end
	if player.lt then
		player.x=player.x-aplayerSpeed
	end
	if player.dn then
		player.y=player.y+aplayerSpeed
	end
	if player.rt then
		player.x=player.x+aplayerSpeed
	end

	for k,v in pairs(level.entities) do
		if v.updateCallback ~= nil then
			v.updateCallback(v)
		end
	end

	text_x:setText("X "..math.floor(player.x), mya_getRenderer())
	text_y:setText("Y "..math.floor(player.y), mya_getRenderer())
end

function wr_keyDown(key)
	player = getPlayer()
	if key == "w" then
		player.up = true
	end
	if key == "a" then
		player.lt = true
	end
	if key == "s" then
		player.dn = true
	end
	if key == "d" then
		player.rt = true
	end
end

function wr_keyUp(key)
	player = getPlayer()
	if key == "w" then
		player.up = false
	end
	if key == "a" then
		player.lt = false
	end
	if key == "s" then
		player.dn = false
	end
	if key == "d" then
		player.rt = false
	end
end