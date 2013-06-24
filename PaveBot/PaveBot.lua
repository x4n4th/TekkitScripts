-- Lua Script to control tekkit nuclear reactors

-- Make redstone connections toggleable

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