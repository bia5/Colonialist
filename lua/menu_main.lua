
local bkg = Sprite.new(assets:getTexture("menu_background"))
bkg:setX(0)
bkg:setY(0)
local singleplayer = Sprite.new(assets:getTexture("menu_button"))
singleplayer:setX((mya_getWidth()/4))
singleplayer:setY((mya_getHeight()/2))
local multiplayer = Sprite.new(assets:getTexture("menu_button"))
multiplayer:setX((mya_getWidth()/2))
multiplayer:setY((mya_getHeight()/2))
local options = Sprite.new(assets:getTexture("menu_button"))
options:setX((mya_getWidth()/4))
options:setY((mya_getHeight()/4)*3)
local quit = Sprite.new(assets:getTexture("menu_button"))
quit:setX((mya_getWidth()/2))
quit:setY((mya_getHeight()/4)*3)

local t_singleplayer = TextView.new(font, "Singleplayer", (mya_getWidth()/64)*17, (mya_getHeight()/32)*17, mya_getRenderer())
t_singleplayer:setColor(mya_getRenderer(), 15, 15, 15)
local t_multiplayer = TextView.new(font, "Multiplayer", (mya_getWidth()/64)*33, (mya_getHeight()/32)*17, mya_getRenderer())
t_multiplayer:setColor(mya_getRenderer(), 15, 15, 15)
local t_options = TextView.new(font, "Options", (mya_getWidth()/64)*17, (mya_getHeight()/32)*25, mya_getRenderer())
t_options:setColor(mya_getRenderer(), 15, 15, 15)
local t_quit = TextView.new(font, "Quit", (mya_getWidth()/64)*33, (mya_getHeight()/32)*25, mya_getRenderer())
t_quit:setColor(mya_getRenderer(), 15, 15, 15)

function menu_main_mouseup(btn)
	if btn == "left" then
		if singleplayer:isPointColliding(mouseX, mouseY) then
			STATE = STATE_INGAME
		elseif multiplayer:isPointColliding(mouseX, mouseY) then
			print("multiplayer")
		elseif options:isPointColliding(mouseX, mouseY) then
			print("options")
		elseif quit:isPointColliding(mouseX, mouseY) then
			mya_exit()
		end
	end
end

function menu_main_resize(w,h)
	singleplayer:setX((mya_getWidth()/4))
	singleplayer:setY((mya_getHeight()/2))
	multiplayer:setX((mya_getWidth()/2))
	multiplayer:setY((mya_getHeight()/2))
	options:setX((mya_getWidth()/4))
	options:setY((mya_getHeight()/4)*3)
	quit:setX((mya_getWidth()/2))
	quit:setY((mya_getHeight()/4)*3)

	t_singleplayer:setXY((mya_getWidth()/64)*17, (mya_getHeight()/32)*17)
	t_multiplayer:setXY((mya_getWidth()/64)*33, (mya_getHeight()/32)*17)
	t_options:setXY((mya_getWidth()/64)*17, (mya_getHeight()/32)*25)
	t_quit:setXY((mya_getWidth()/64)*33, (mya_getHeight()/32)*25)
end

function menu_main_render()
	bkg:render(mya_getRenderer(), mya_getWidth(), mya_getHeight())
	singleplayer:render(mya_getRenderer(), mya_getWidth()/5, mya_getHeight()/5)
	multiplayer:render(mya_getRenderer(), mya_getWidth()/5, mya_getHeight()/5)
	options:render(mya_getRenderer(), mya_getWidth()/5, mya_getHeight()/5)
	quit:render(mya_getRenderer(), mya_getWidth()/5, mya_getHeight()/5)

	t_singleplayer:renderWH(mya_getRenderer(), mya_getWidth()/6, mya_getHeight()/10)
	t_multiplayer:renderWH(mya_getRenderer(), mya_getWidth()/6, mya_getHeight()/10)
	t_options:renderWH(mya_getRenderer(), mya_getWidth()/6, mya_getHeight()/10)
	t_quit:renderWH(mya_getRenderer(), mya_getWidth()/6, mya_getHeight()/10)
end