--Functions and Callbacks For Mya 1.4 (Codename: Jisoo)

--Functions
mya_getMya() --Returns current mya (Needed for other functions)
mya_close() --Cleans up mya so its safe for program exit (should always be the last thing ran)
mya_exit() --Sets mya_isRunning() to false
mya_getAssets() --Returns the current global's assets (used for textures)
mya_getFPS() --Returns a int for the current amount of fps
mya_getFullscreen() --Returns a bool whether mya's window is in fullscreen mode
mya_getIsServer() --Returns whether mya is in server mode
mya_getRenderer() --Returns current renderer (Needed for other functions)
mya_getVersion() --Returns a string of mya version
mya_init("Window Title", 1280, 720) --Initilizes mya and creates a window (Arg1 is a string of the title, Arg2 is window width, Arg3 is window height)
mya_isRunning() --Returns a bool whether mya should continue functioning.
mya_render() --Renders a frame (Will callback to event_render())
mya_setFullscreen(true) --Will set mya's window to fullscreen, true if fullscreen, false if windowed.
mya_update() --Runs a update loop (Will callback to event_update())
mya_setWindowTitle("Window Title") --Sets mya's window's title.
mya_setWindowIcon("assets\\icon.png") --Will try to set mya's window's icon to the image's path according to "Mya-Yasmine.exe"
mya_showCursor(true) --Sets if the os's cursor will show when hovering over mya's window
mya_getWidth() --Returns an int with mya's window's current width.
mya_getHeight() --Returns an int with mya's window's current height.
mya_setUPS(60) --Sets the update rate per second for event_tupdate() callback.
mya_getUPS() --Returns the ups for event_tupdate callback.
	
texture = Texture.new("assets\\texture.png", mya_getRenderer()) --Generates a new texture. Arg1 is the image's path according to "Mya-Yasmine.exe". Arg2 is current renderer so will almost always be "mya_getRenderer()".
texture:destroy() --Destroys the texture from memory. Only run it when your done using it.
texture:getW() --Returns the texture's pixel width
texture:getH() --Returns the texture's pixel height

font = Font.new("assets\\font.ttf", 0) --Generates a new font. Arg1 is the image's path according to "Mya-Yasmine.exe". (AssetHandler will auto grab the ttf from "assets/font.ttf" if it exists)
font:destroy() --Destroys the font to clear memory.

assets = mya_getAssets() --Grabs the asset handler.
assets:loadTexture("textureName", "assets\\textureName") --Loads a texture into the asset handler. Arg1 is the texture's id. Arg2 is the image's path according to "Mya-Yasmine.exe".
assets:getTexture("textureName") --Returns the texture from the asset handler. Arg1 is the texture's id.
assets:getFont() --Returns a already initilized font.
assets:getTotalAssets() --Returns the amount of assets loaded.

sprite = Sprite.new(texture) --Generates a new sprite. Arg1 is the texture for it to render. (It can be nil but it wont render anything)
sprite:destroy() --Destroys the sprite from memory. Only run it when your done using it.
sprite:update() --Updates the sprite. (Pretty much usless for most cases.)
sprite:render(mya_getRenderer(), 10, 10) --Renders the sprite. Arg1 is mya's renderer. Arg2 is the sprite's width. Arg3 is the sprite's height.
sprite:renderFlip(mya_getRenderer(), 10, 10, true) --Renders the sprite but flipped horizontally. Arg1 is mya's renderer. Arg2 is the sprite's width. Arg3 is the sprite's height. Arg4, if true, will render it flipped horizontally, if false will render normally.
sprite:renderDefault(mya_getRenderer()) --Renders the sprite with the given texture's width and height.
sprite:setX(0) --Sets the sprite's x ccords.
sprite:setY(0) --Sets the sprite's y ccords.
sprite:getX() --Returns a int of the sprite's x coord.
sprite:getY() --Returns a int of the sprite's y coord.
sprite:isColliding(sprite) --Returns a bool whether the arg1 sprite is colliding with the sprite. Arg1 is another sprite.
sprite:isPointColliding(0, 0) --Returns a bool whether the given coords collide with the sprite. Arg1 is the coord's x and Arg2 is the coord's y.
sprite:setRenderOutline(true) --Should the sprite render the overlay colors. true will render, false will not.
sprite:setOutlineColor(255, 255, 255, 255) --Sets the overlay color to the values (rgb with a scale of 0-255 for args 1-3) and arg4 is the alpha.
sprite:setTexture(texture) --Will update the sprite's texture to arg1. (It can be nil but it wont render anything)

--TextView hasn't been tested much and might not work properly
textView = TextView.new(assets:getFont(), "Text", 0, 0, mya_getRenderer()) --Generates a new TextView. Arg1 is the font. Arg2 is the text that is going to be shown. Arg3 is the x coord. Arg4 is the y coord. Arg5 is mya's current renderer.
textView:render(mya_getRenderer()) --Renders the textView with the suggested width and height. Arg1 is mya's current renderer.
textView:renderWH(mya_getRenderer(), 10, 10) --Renders the textView with the given width and height. Arg1 is mya's current renderer. Arg2 is the width. Arg3 is the height.
textView:setXY(0, 0) --Sets the x and y coords. Arg1 is the x coord. Arg2 is the y coord. 
textView:setText("Text", mya_getRenderer()) --Sets textView's text. Arg1 is the text that is going to be shown. Arg2 is mya's current renderer.
textView:getText() --Returns a string of the current text.
textView:setColor(mya_getRenderer(), 255, 255, 255) --Sets the color of the text. Arg1 is mya's current renderer. Args 2-4 are the rgb values on a scale of 0-255.
textView:setFont(assets:getFont(), mya_getRenderer()) --Set a new font
textView:getWidth() --Gets width of the texture
textView:getHeight() --Gets height of the texture

sound = Sound.new("assets/sound.wav") --arg1: asset location
sound:destroy()
sound:play()
sound:setVolume(64) --arg1: volume (0-128)
sound:getVolume() --returns int, which is the volume

music = Music.new("assets/music.wav") --arg1: asset location
music:destroy()
music:play()
music:pause()
music:resume()
music:stop()
music:isPlaying() --returns bool, whether music is playing
music:setVolume(64) --arg1: volume (0-128)
music:getVolume() --returns int, which is the volume



--Callbacks
function event_mouseMotion(x, y) end -- x and y equals the user's mouse's new coords apparent to window.
function event_mouseButtonDown(btn) end --Is called when a mouse button is pressed down. btn equals a string which defines which mouse button was pressed. (mess around using print(btn) to find what each button is defined as)
function event_mouseButtonUp(btn) end --Called when a mouse button is released.
function event_keyDown(key) end --called when a keyboard key is pressed down.
function event_keyUp(key) end --Called when a keyboard key is released.
function event_networkMessage(clientMessage) end --Called when the program recieves a network message.
function event_update() end --called on every update loop.
function event_windowResize(w, h) end --called when window is resized
function event_render() end --called on render loop.
function event_tupdate() end --called on every ups tick
