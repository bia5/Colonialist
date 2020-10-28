--handles popups :D
--addPopup(true,"Why did the chicken cross the road?", "To get to the other side haha")

local popup_array = {}
local popup_current = {}
local popup_background = Sprite.new(assets:getTexture("text_popup"))
local popup_text_top = TextView.new(font, "", (mya_getWidth()/32)*9, (mya_getHeight()/72)*53, mya_getRenderer())
popup_text_top:setColor(mya_getRenderer(), 0, 0, 0)
local popup_text_bottom = TextView.new(font, "", (mya_getWidth()/32)*9, (mya_getHeight()/36)*56, mya_getRenderer())
popup_text_bottom:setColor(mya_getRenderer(), 0, 0, 0)
popup_text_bottom:setColor(mya_getRenderer(), 0, 0, 0)
local both = false
local generating = false
popup_active = false
local current_letter = 1
local genSpeed_ = 3*60
local genSpeed = 0
local genCount = 0
local yikers = false

function popups_windowResize(w, h)
	popup_text_top:setFont(font)
	popup_text_bottom:setFont(font)
	
	popup_background:setX((mya_getWidth()/16)*4)
	popup_background:setY((mya_getHeight()/9)*6)
	if both == true then
		popup_text_top:setXY((mya_getWidth()/32)*9, (mya_getHeight()/72)*53)
		popup_text_bottom:setXY((mya_getWidth()/32)*9, (mya_getHeight()/72)*56)
	else
		popup_text_top:setXY((mya_getWidth()/32)*9, (mya_getHeight()/72)*53)
	end
end
popups_windowResize(mya_getWidth(), mya_getHeight())

function grabPopup()
	if generating == false then
		if getFirstItem(popup_array) ~= nil then
			popup_current = getFirstItem(popup_array)
			removeFromTable(popup_array, popup_current)
			popup_text_top:setText("", mya_getRenderer())
			popup_text_bottom:setText("", mya_getRenderer())
			both = popup_current[1]
			popups_windowResize(mya_getWidth(), mya_getHeight())
			generating = true
			popup_active = true
			if popup_current[4] ~= nil then
				genSpeed_ = popup_current[4]
			else
				genSpeed_ = 3*60
			end
			if both then
				local letters = popup_current[2]:len()+popup_current[3]:len()
				genSpeed = math.floor(genSpeed_/letters)
			else
				local letters = popup_current[2]:len()
				genSpeed = math.floor(genSpeed_/letters)
			end
			--below is a monument for the hackiest thing I have ever wrote to fix a
			--bug. for the people who cannot fathom what the fuck is happening below
			--let me explain...
			--you devide genSpeed_ and letters, convert the outcome to a string,
			--remove the ".#INF", then convert the outcome to a number.
			--That is what you call art.
			--genSpeed = tonumber(mysplit(tostring(genSpeed_/letters),".#INF")[1])
			current_letter = 1
			if genSpeed == 0 then
				genSpeed = 1
			end
		else
			popup_active = false
			yikers = false
		end
	end
end

function addPopup(both, text, text1, time)
	table.insert(popup_array, {both, text, text1, time})
	if popup_active == false then
		grabPopup()
	end
end

function popups_update()
	if popup_active then
		if generating then
			if genCount > genSpeed then
				genCount = 0
				if popup_text_top:getText():len() ~= popup_current[2]:len() then
					popup_text_top:setText(popup_current[2]:sub(1,current_letter), mya_getRenderer())
					current_letter = current_letter + 1
					if popup_text_top:getText():len() == popup_current[2]:len() then
						current_letter = 1
						if both == false then
							generating = false
						end
					end
				elseif both then
					if popup_text_bottom:getText():len() ~= popup_current[3]:len() then
						popup_text_bottom:setText(popup_current[3]:sub(1,current_letter), mya_getRenderer())
						current_letter = current_letter + 1
						if popup_text_bottom:getText():len() == popup_current[3]:len() then
							generating = false
							current_letter = 1
						end
					end
				end
			end
			genCount = genCount + 1
		end
	end
end

function popups_keyUp(key)
	if popup_active then
		if yikers then
			if generating then
				popup_text_top:setText(popup_current[2], mya_getRenderer())
				if both then
					popup_text_bottom:setText(popup_current[3], mya_getRenderer())
				end
				generating = false
			else
				grabPopup()
			end
		else
			yikers = true
		end
	end
end

function popups_mouseButtonUp(btn)
	if popup_active then
		if yikers then
			if generating then
				popup_text_top:setText(popup_current[2], mya_getRenderer())
				if both then
					popup_text_bottom:setText(popup_current[3], mya_getRenderer())
				end
				generating = false
			else
				grabPopup()
			end
		else
			yikers = true
		end
	end
end

function popups_render()
	if popup_active == true then
		popup_background:render(mya_getRenderer(), (mya_getWidth()/16)*8, (mya_getHeight()/9)*2)
		if popup_text_top:getWidth() > (((mya_getWidth()/32)*22)-((mya_getWidth()/32)*9)) then
			popup_text_top:renderWH(mya_getRenderer(), (((mya_getWidth()/32)*22)-((mya_getWidth()/32)*9)), popup_text_top:getHeight())
		else
			popup_text_top:render(mya_getRenderer())
		end
		if both then
			if popup_text_bottom:getWidth() > (((mya_getWidth()/32)*22)-((mya_getWidth()/32)*9)) then
				popup_text_bottom:renderWH(mya_getRenderer(), (((mya_getWidth()/32)*22)-((mya_getWidth()/32)*9)), popup_text_bottom:getHeight())
			else
				popup_text_bottom:render(mya_getRenderer())
			end
		end
	end
end