-- Reference: https://www.tutorialspoint.com/string-sub-function-in-lua

local Deletable = 'LogLeafDoor, LogDoorway, LogWall'

local function findMatchString2(longString, word)
	local i, j = string.find(longString, word)
	if  i == nil then
		print("No match found.")
	else
		print("Found match: In index: from " .. i .. " to " .. j)
		local str = string.sub(longString, i, j)
		print(str)
		
	end
end

findMatchString2(Deletable, "LogWall")
