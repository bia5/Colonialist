function newCollision(x,y,w,h)
	return {x=x,y=y,w=w,h=h}
end

function isPointInCollision(x,y,col1)
	local col = false
	if x > col1.x or x == col1.x then
		if x < col1.x+col1.w or x == col1.x+col1.w then
			if y > col1.y or y == col1.y then
				if y < col1.y+col1.h or y == col1.y+col1.h then
					return true
				end
			end
		end
	end
	return col
end

function isCollision(col1,col2)
	local col = false
	if isPointInCollision(col1.x,col1.y,col2) then
		col = true
	elseif isPointInCollision(col1.x+col1.w,col1.y,col2) then
		col = true
	elseif isPointInCollision(col1.x,col1.y+col1.h,col2) then
		col = true
	elseif isPointInCollision(col1.x+col1.w,col1.y+col1.h,col2) then
		col = true
	elseif isPointInCollision(col2.x,col2.y,col1) then
		col = true
	elseif isPointInCollision(col2.x+col2.w,col2.y,col1) then
		col = true
	elseif isPointInCollision(col2.x,col2.y+col2.h,col1) then
		col = true
	elseif isPointInCollision(col2.x+col2.w,col2.y+col2.h,col1) then
		col = true
	end
	return col
end