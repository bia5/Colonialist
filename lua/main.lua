--Colonialist - By Alex Cooper 10/26/2020
init = mya_init("Colonialist - By Alex Cooper", 1280, 720)
--mya_setFullscreen(true)

devmode = true

mouseX = 0
mouseY = 0

math.randomseed(os.time()) math.random() math.random() math.random() --setup that random

json = require "json"
require("util") --Requires json
require("assets")
require("popups") --Requires assets
require("collisionbox")
require("world")
require("worldrenderer")

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
	popups_mouseButtonUp(btn)
end

function event_keyDown(key)
	wr_keyDown(key)
end

function event_keyUp(key)
	if key == "D" then
		mya_setFullscreen(not mya_getFullscreen())
	end
	if key == "esc" then
		mya_exit()
	end
	
	popups_keyUp(key)
	wr_keyUp(key)
end

function event_windowResize(w, h)
	assets_updateFonts()
	text_fps = TextView.new(font, "Fps 0", 0, 0, mya_getRenderer())
	text_fps:setColor(mya_getRenderer(), 15, 15, 15)
	popups_windowResize(w, h)
	wr_resize(w,h)
end

function event_update()
	popups_update()
	text_fps:setText("FPS "..mya_getFPS(), mya_getRenderer())
end

function event_render()
	wr_render()
	popups_render()
	if devmode == true then
		text_fps:render(mya_getRenderer())
	end
end

mya_setUPS(60)
function event_tupdate() 
	wr_tupdate()
end

while mya_isRunning() do
	mya_update()
	mya_render()
end