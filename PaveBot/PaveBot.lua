-- Lua Script to control PaveBot

-- Library of delta's for paved intersection
-- 0,0 is the north west corner of a chunk
-- blockType is the type of block to be placed 
-- If block is null, Assume basalt
intersection = {
  {x = 0, z = 0, blockType = "dirt"},
  {x = 0, z = 1, blockType = "dirt"},
  {x = 0, z = 2, blockType = "dirt"}, 
  {x = 0, z = 6, blockType = "dirt"},
  {x = 0, z = 7, blockType = "log"},
  {x = 0, z = 8, blockType = "log"},
  {x = 0, z = 9, blockType = "dirt"}, 
  {x = 0, z = 13, blockType = "dirt"},
  {x = 0, z = 14, blockType = "dirt"},
  {x = 0, z = 15, blockType = "dirt"},
  
  {x = 1, z = 0, blockType = "dirt"},
  {x = 1, z = 1, blockType = "dirt"},
  {x = 1, z = 2, blockType = "dirt"}, 
  {x = 1, z = 6, blockType = "dirt"},
  {x = 1, z = 7, blockType = "log"},
  {x = 1, z = 8, blockType = "log"},
  {x = 1, z = 9, blockType = "dirt"}, 
  {x = 1, z = 13, blockType = "dirt"},
  {x = 1, z = 14, blockType = "dirt"},
  {x = 1, z = 15, blockType = "dirt"},
  
  {x = 2, z = 0, blockType = "dirt"},
  {x = 2, z = 1, blockType = "dirt"},
  {x = 2, z = 2, blockType = "dirt"}, 
  {x = 2, z = 6, blockType = "dirt"},
  {x = 2, z = 7, blockType = "dirt"},
  {x = 2, z = 8, blockType = "dirt"},
  {x = 2, z = 9, blockType = "dirt"}, 
  {x = 2, z = 13, blockType = "dirt"},
  {x = 2, z = 14, blockType = "dirt"},
  {x = 2, z = 15, blockType = "dirt"},
  
  {x = 6, z = 0, blockType = "dirt"},
  {x = 6, z = 1, blockType = "dirt"},
  {x = 6, z = 2, blockType = "dirt"},
  {x = 6, z = 13, blockType = "dirt"},
  {x = 6, z = 14, blockType = "dirt"},
  {x = 6, z = 15, blockType = "dirt"},
  
  {x = 7, z = 0, blockType = "log"},
  {x = 7, z = 1, blockType = "log"},
  {x = 7, z = 2, blockType = "dirt"},
  {x = 7, z = 13, blockType = "dirt"},
  {x = 7, z = 14, blockType = "log"},
  {x = 7, z = 15, blockType = "log"},
  
  {x = 8, z = 0, blockType = "log"},
  {x = 8, z = 1, blockType = "log"},
  {x = 8, z = 2, blockType = "dirt"},
  {x = 8, z = 13, blockType = "dirt"},
  {x = 8, z = 14, blockType = "log"},
  {x = 8, z = 15, blockType = "log"},
  
  {x = 9, z = 0, blockType = "dirt"},
  {x = 9, z = 1, blockType = "dirt"},
  {x = 9, z = 2, blockType = "dirt"},
  {x = 9, z = 13, blockType = "dirt"},
  {x = 9, z = 14, blockType = "dirt"},
  {x = 9, z = 15, blockType = "dirt"},
  
  {x = 13, z = 0, blockType = "dirt"},
  {x = 13, z = 1, blockType = "dirt"},
  {x = 13, z = 2, blockType = "dirt"}, 
  {x = 13, z = 6, blockType = "dirt"},
  {x = 13, z = 7, blockType = "dirt"},
  {x = 13, z = 8, blockType = "dirt"},
  {x = 13, z = 9, blockType = "dirt"}, 
  {x = 13, z = 13, blockType = "dirt"},
  {x = 13, z = 14, blockType = "dirt"},
  {x = 13, z = 15, blockType = "dirt"},
  
  {x = 14, z = 0, blockType = "dirt"},
  {x = 14, z = 1, blockType = "dirt"},
  {x = 14, z = 2, blockType = "dirt"}, 
  {x = 14, z = 6, blockType = "dirt"},
  {x = 14, z = 7, blockType = "log"},
  {x = 14, z = 8, blockType = "log"},
  {x = 14, z = 9, blockType = "dirt"}, 
  {x = 14, z = 13, blockType = "dirt"},
  {x = 14, z = 14, blockType = "dirt"},
  {x = 14, z = 15, blockType = "dirt"},
  
  {x = 15, z = 0, blockType = "dirt"},
  {x = 15, z = 1, blockType = "dirt"},
  {x = 15, z = 2, blockType = "dirt"}, 
  {x = 15, z = 6, blockType = "dirt"},
  {x = 15, z = 7, blockType = "log"},
  {x = 15, z = 8, blockType = "log"},
  {x = 15, z = 9, blockType = "dirt"}, 
  {x = 15, z = 13, blockType = "dirt"},
  {x = 15, z = 14, blockType = "dirt"},
  {x = 15, z = 15, blockType = "dirt"},
}

--[[Wrapper Function for GPS API to get GPS location
	@return x, y, z 
	]]
function getExactLocation()
	return gps.location(5)
end

--[[Return Block type based on how many block away from the
  north west corner of the chunk
 @x : Integer Based on delta of x blocks
 @z : Integer Based on delta of z block
 @orientation: Pointing direction, "north" or "west"
 ]]
function getPaveBlockFromDelta(x, z, orientation)
	if orientation == "north" then
		z = x
	end
	
	if (z > 2 and z < 5) or (z > 9 and z < 13) then
		return "basalt"
	else if z > 6 and z < 9 then
		return "log"
	else 
		return "dirt"
	end
end

--[[Changes direction of bot to desired direction
 @desiredDirection : Integer Based yaw of robot. Clockwise north to west
	0 to 3 Respectively
		   N
		*  0  *
	 W	3  *  1  E
		*  2  *
		   S
 ]]
function changeDirection(disiredDirection)
	while yaw ~= desiredDiection do 
		if yaw < desiredDirection then
			turtle.turnLeft()
			yaw = yaw - 1
		else
			turtle.turnRight()
			yaw = yaw + 1
		end
	end
end

--TODO Finish this function
function getItemSlot(itemName)
  if itemName == "dirt" then
    return 0
  end
end

--[[******************************************************************
	State Tasks - Functions dependant on State of robot
	******************************************************************]]
--[[ paving state function
	@paveType : "intersection" or "road"
	@orientation : 0 or 1 - North or south]]
function pave(paveType, orientation)
	-- At this point robot will assume that it is at the correct location at the north west corner of the chunk
	-- We will start directly east and work south
	changeDirection(1) -- point east
	for i = 0, 15, 1 do
		for r = 0, 15, 1 do
			if turtle.detectDown() then
				if paveType = "intersection" then
          
				else if paveType = "road" then
        
				end
        
        turtle.compareDown()
			end
		end
	end
	
end
--[[******************************************************************
    END State tasks
	******************************************************************]]
--[[Main]]
yaw = nil -- 0 to 3 North to West respectively clockwise

while true do

  sleep(0.2)
end