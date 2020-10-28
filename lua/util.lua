--https://stackoverflow.com/questions/1426954/split-string-in-lua
function mysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

--myself
function getFirstItem(t)
	for k,v in pairs(t) do
		return v
	end
end

--myself
function removeFromTable(t,ke)
	for k,v in pairs (t) do
		if v==ke then
			t[k]=nil
			break
		end
	end
end

--https://stackoverflow.com/questions/2705793/how-to-get-number-of-entries-in-a-lua-table
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

--https://stackoverflow.com/questions/4880368/how-to-delete-all-elements-in-a-lua-table
function clearTable(t)
	if t ~= nil then
		for k in pairs (t) do
			t [k] = nil
		end
	end
end

--File stuff
function saveTable(file, tablee)
	local test = assert(io.open(file, "w"))
	tablee = json.encode(tablee)
	test:write(tablee)
	test:close()
end

function loadTable(file)
	local test = io.open(file, "r")
	local readjson= test:read("*a")
	result = json.decode(readjson)
	test:close()
	return result
end