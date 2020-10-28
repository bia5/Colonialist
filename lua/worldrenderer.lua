local spr = Sprite.new(nil)
local tilesize = 14
local tilepix = mya_getHeight()/tilesize
offsetx = 0
offsety = 0

function renderSpriteUndertile(x,y)
	local tile = getUndertile(x,y)
	if tile ~= nil then
		spr:setTexture(assets:getTexture(tile.tex))
		spr:setX((tile.x*tilepix)+(mya_getWidth()/2)-offsetx)
		spr:setY((tile.y*tilepix)+(mya_getHeight()/2)-offsety)
		spr:render(mya_getRenderer(), tilepix+1, tilepix+1)
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
			spr:render(mya_getRenderer(), (tilepix*tile.w)+1, (tilepix*tile.h)+1)
		else
			spr:render(mya_getRenderer(), tilepix+1, tilepix+1)
		end
	end
end

function renderEntity(ent)
	if ent ~= nil then
		offsetx = ent.x*tilepix
		offsety = ent.y*tilepix
		spr:setTexture(assets:getTexture(ent.tex))
		spr:setX((ent.x*tilepix)-(tilepix/2)+(mya_getWidth()/2)-offsetx)
		spr:setY((ent.y*tilepix)-(tilepix*2)+(mya_getHeight()/2)-offsety)
		spr:render(mya_getRenderer(), tilepix, tilepix*2)
	end
end

function wr_resize(w,h)
	tilepix = mya_getHeight()/tilesize
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
end

local playerSpeed = .1
local up = false
local dn = false
local lt = false
local rt = false

function wr_update()
	if up then
		player.y=player.y-playerSpeed
	end
	if lt then
		player.x=player.x-playerSpeed
	end
	if dn then
		player.y=player.y+playerSpeed
	end
	if rt then
		player.x=player.x+playerSpeed
	end
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