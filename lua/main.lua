--Colonialist - By Alex Cooper 10/26/2020
init = mya_init("Colonialist - By Alex Cooper", 1280, 720)
--mya_setFullscreen(true)

devmode = true

mouseX = 0
mouseY = 0

STATE_INGAME = "ig"
STATE_MAINMENU = "mm"
STATE = STATE_MAINMENU

math.randomseed(os.time()) math.random() math.random() math.random() --setup that random

json = require "json"
require("util") --Requires json
require("assets")
require("popups") --Requires assets
require("collisionbox")
require("world")
require("worldrenderer")

require("menu_main") -- Main menu

generateLevel()

text_fps = TextView.new(font, "Fps 0", 0, 0, mya_getRenderer())
text_fps:setColor(mya_getRenderer(), 15, 15, 15)

function event_mouseMotion(x, y)
	mouseX = x
	mouseY = y
end

function event_mouseButtonDown(btn)
end

function event_mouseButtonUp(btn)
	if STATE == STATE_MAINMENU then
		menu_main_mouseup(btn)
	end
	popups_mouseButtonUp(btn)
end

function event_keyDown(key)
	if STATE == STATE_INGAME then
		wr_keyDown(key)
	end
end

function event_keyUp(key)
	if STATE == STATE_INGAME then
		wr_keyUp(key)
	end

	if key == "D" then
		mya_setFullscreen(not mya_getFullscreen())
	end
	if key == "esc" and devmode == true then
		mya_exit()
	end
	
	popups_keyUp(key)
end

function event_windowResize(w, h)
	assets_updateFonts()
	text_fps = TextView.new(font, "Fps 0", 0, 0, mya_getRenderer())
	text_fps:setColor(mya_getRenderer(), 15, 15, 15)
	popups_windowResize(w, h)
	wr_resize(w,h)
	menu_main_resize(w,h)
end

function event_update()
	popups_update()
	text_fps:setText("FPS "..mya_getFPS(), mya_getRenderer())
end

function event_render()
	if STATE == STATE_MAINMENU then
		menu_main_render()
	elseif STATE == STATE_INGAME then
		wr_render()
	end
	popups_render()
	if devmode == true then
		text_fps:renderWH(mya_getRenderer(), mya_getWidth()/16, mya_getHeight()/32)
	end
end

mya_setUPS(120)
function event_tupdate()
	if STATE == STATE_INGAME then
		wr_tupdate()
	end
end

while mya_isRunning() do
	mya_update()
	mya_render()
end