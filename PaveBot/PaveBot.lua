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

--[[Return Block type based on location for intersection
 @x : Integer Based on delta of x blocks
 @z : Integer Based on delta of z block
 @return : return block type at x, y location
 ]]
function getBlockTypeFromDeltas(x, z)
  for i = 1, 84, 1 do
    if intersection[i].x == x and intersection[i].z == z then
      print("X: " .. x .. " Z: " .. z)
      return intersection[i].blockType
    end
  end
  return nil
end

--[[Wrapper Function for GPS API to get GPS location
  @return x, y, z 
  ]]
function getExactLocation()
  return gps.location(5)
end

--[[Return Block type based on how many block away from the
  north west corner of the chunk for the road
 @x : Integer Based on delta of x blocks
 @z : Integer Based on delta of z block
 @orientation: Pointing direction, "north" or "west"
 ]]
function getPaveBlockFromDelta(x, z, orientation)
  if orientation == "east" then
    z = x
  end
  
  if (z > 2 and z < 6) or (z > 9 and z < 13) then
    return "basalt"
  elseif z > 6 and z < 9 then
    return "log"
  else 
    return "dirt"
  end
end

--[[Changes direction of bot to desired direction
 @desiredDirection : Integer Based yaw of robot. Clockwise north to west
  0 to 3 Respectively
         -z
          N
       *  0  *
-x  W  3  *  1  E +x
       *  2  *
          S
         +z
 ]]
function changeDirection(desiredDirection)
  if verbose then
    print ("Changing Direction: " .. desiredDirection)
    print ("Current Yaw: " .. yaw)
  end
  while yaw ~= desiredDiection do 
    if yaw > desiredDirection then
      turtle.turnLeft()
      yaw = yaw - 1
    else
      turtle.turnRight()
      yaw = yaw + 1
    end
    if yaw == desiredDirection then
      break
    end
    print ("Success Yaw: " .. yaw)
  end
end

--[[ Slot locations for each block
  @itemName : String - name of block
  @return : Slot number containing itemName]]
function getItemSlot(itemName)
  if itemName == "dirt" or itemName == "grass" then
    return 1
  elseif itemName == "basalt" or itemName == nil then
    return 2
  elseif itemName == "log" then 
    return 3
  end
  return 4
end

-- temp fuel function
function fuel()
  turtle.select(4)
  turtle.refuel(4)
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
  
  --Chunk Bounds
  x = 0
  
  while x <= 15 do
    for y = 0, 15, 1 do
      if paveType == "intersection" then
        local block = getBlockTypeFromDeltas(x,y)
        local slot = getItemSlot(block)
        if verbose then
          print("For Intersection")
          if block == nil then
            print("Getting Block Type: Basalt")
          else
            print("Getting Block Type: " .. block)
          end
          print("Getting Slot for item " .. slot)
        end
        turtle.select(slot)
        --turtle.select(getItemSlot(getBlockTypeFromDeltas(x,y)))
      elseif paveType == "road" then
        block = getPaveBlockFromDelta(x, y, orientation)
        slot = getItemSlot(block)
        if verbose then
          print("For Road")
          if block == nil then
            print("Getting Block Type: Basalt")
          else
            print("Getting Block Type: " .. block)
          end
          print("Getting Slot for item " .. slot)
        end
        turtle.select(slot)
        -- turtle.select(getItemSlot(getPaveBlockFromDelta(x, y, orientation)))
      end
      
      if turtle.compareDown() then
        if verbose then
          print("Block is already there")
        end
      else
        if verbose then
          print("Replacing Block")
        end
        turtle.digDown()
      end
      turtle.placeDown()
      if y < 15 then
        turtle.forward()
      end
    end
    
    x = x + 1
    
    if x > 15 then 
      break
    end
    
    if yaw == 1 then
      changeDirection(2)
      turtle.forward()
      changeDirection(3)
    elseif yaw == 3 then 
      changeDirection(2)
      turtle.forward()
      changeDirection(1)
    end
  end
end

--[[Path finding state function
    This function is spawn when the bot needs to move from one location the current location
    to an end location
    @x intended target x
    @z intended target z
    @y intended target y]]
function pathFinding(x, y ,z)
  -- main while loops for bot to go to location
  while true do
    moveInDirection(getBestMove(x, y, z))
    eX, eY, eZ = getExactLocation()
    if x == eX and y == eY and z == eZ then
      break
    end
  end
end
--[[******************************************************************
    END State tasks
  ******************************************************************]]
  
--[[******************************************************************
    Path finding Implementation
    Turtle Will favour going in the direction of the target. But it will never track back 
    This implementation will try to avoid obstacles by flying directly up and moving towards the target
    @x intended target x
    @z intended target z
    @y intended target y
    @return returns yaw direction the turtle should move
  ******************************************************************]]

--[[ return the pave type given the chunk location
    @v vector chunk location]]
function getChunkType(v)
  x = v.x
  z = v.y
  
  xO = (x / 16 ) % 4
  zO = (z / 16 ) % 4
  
  if zO == 0 and xO == 0 then
    return "intersection"
  elseif zO == 0 then
    return "east"
  elseif xO == 0 then
    return "north"
  else
    return nil
  end
end
  
--[[ Will get the best move given a target location
  @x, y, z Targeted location]]
function getBestMove(x, y, z)
  --Get previous location so we do not go back.
  local prevX = previousLocation[1].x
  local prevZ = previousLocation[1].z
  
  -- Get Current Location
  currentX, currentZ = getExactLocation()
  --Set new previous location because we will be moving
  setCurrentLocation(currentX, currentZ)
  
  local facedDirection = yaw
  
  local diffX = currentX - x
  local diffZ = currentZ - z
  
  if diffX < 0 then
    return 1
  elseif diffX > 0 then 
    return 3
  end
  
  if diffZ < 0 then
    return 2
  elseif diffZ > 0 then 
    return 0
  end
    
  return -1
end

function setCurrentLocation(x,z)
  previousLocation[1].x = x
  previousLocation[1].z = z
end

--[[ Moves turtle in direction given
  @yaw : direction the turtle will move in]]
function moveInDirection(yaw)
  if yaw == 4 then
    turtle.movedown()
    return
  elseif yaw == 5 then
    turtle.moveUp()
    return
  end
  
  changeDirection(yaw)
  turtle.forward() 
end

--[[******************************************************************
  END path finding Implementation
  ******************************************************************]]
  
--[[Main]]
yaw = 0 -- 0 to 3 North to West respectively clockwise
verbose = true -- causes robot to print out everything it is doing
previousLocation = {
  {x = 0, z = 0}
}

while true do
  fuel()
  pave("road", "north")
end