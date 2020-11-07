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

function wr_render()
	xxx = math.floor(player.x)-15
	yyy = math.floor(player.y)-8
	for y = yyy, yyy+16 do
		for x = xxx, xxx+30 do
			renderSpriteUndertile(x,y)
		end
	end

	for y = yyy, yyy+16 do
		for x = xxx, xxx+30 do
			renderSpriteTile(x,y)
		end
	end

	renderEntity(player)
	renderEntity(pig)

	if devmode == true then
		text_x:renderWH(mya_getRenderer(), mya_getWidth()/32, mya_getHeight()/32)
		text_y:renderWH(mya_getRenderer(), mya_getWidth()/32, mya_getHeight()/32)
	end
end

local playerSpeed = .03
local up = false
local dn = false
local lt = false
local rt = false

function wr_tupdate() 
	local aamt = 0
	if up then
		aamt=1
	end
	if lt then
		aamt=aamt+1
	end
	if dn then
		aamt=aamt+1
	end
	if rt then
		aamt=aamt+1
	end

	local aplayerSpeed = playerSpeed
	if aamt > 1 then
		aplayerSpeed = playerSpeed/3*2
	end

	if up then
		player.y=player.y-aplayerSpeed
	end
	if lt then
		player.x=player.x-aplayerSpeed
	end
	if dn then
		player.y=player.y+aplayerSpeed
	end
	if rt then
		player.x=player.x+aplayerSpeed
	end

	text_x:setText("X "..math.floor(player.x), mya_getRenderer())
	text_y:setText("Y "..math.floor(player.y), mya_getRenderer())
end

function wr_keyDown(key)
	if key == "w" then
		up = true
	end
	if key == "a" then
		lt = true
	end
	if key == "s" then
		dn = true
	end
	if key == "d" then
		rt = true
	end
end

function wr_keyUp(key)
	if key == "w" then
		up = false
	end
	if key == "a" then
		lt = false
	end
	if key == "s" then
		dn = false
	end
	if key == "d" then
		rt = false
	end
end