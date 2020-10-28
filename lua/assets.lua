--handles assets
assets = mya_getAssets()

--Fonts (I make my own font so I have more control over it's size)
font_size = 23
function assets_updateFonts()
	if font ~= nil then
		font:destroy()
	end
	font = Font.new("assets/font.ttf",mya_getHeight()/font_size)
end
assets_updateFonts()

assets:loadTexture("under_grass_0","assets/undertiles/grass_0.png")
assets:loadTexture("under_water_0","assets/undertiles/water_0.png")
assets:loadTexture("under_cobblestone","assets/undertiles/cobblestone.png")

assets:loadTexture("tile_treeMedium_0","assets/tiles/treeMedium_0.png")
assets:loadTexture("tile_bush_0","assets/tiles/bush_0.png")
assets:loadTexture("tile_rock_0","assets/tiles/rock_0.png")

assets:loadTexture("ent_player","assets/entities/player.png")

print("Finished loading "..assets:getTotalAssets().." assets!")