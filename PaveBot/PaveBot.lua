-- Lua Script to control tekkit nuclear reactors

-- Make redstone connections toggleable

-- Library of delta's for paved intersection
-- 0,0 is the north west corner of a chunk
-- blockType is the type of block to be placed 
-- If block is null, Assume basalt
intersection = {
  {x = 0, y = 0, blockType = "dirt"},
  {x = 0, y = 1, blockType = "dirt"},
  {x = 0, y = 2, blockType = "dirt"}, 
  {x = 0, y = 6, blockType = "dirt"},
  {x = 0, y = 7, blockType = "log"},
  {x = 0, y = 8, blockType = "log"},
  {x = 0, y = 9, blockType = "dirt"}, 
  {x = 0, y = 13, blockType = "dirt"},
  {x = 0, y = 14, blockType = "dirt"},
  {x = 0, y = 15, blockType = "dirt"},
  
  {x = 1, y = 0, blockType = "dirt"},
  {x = 1, y = 1, blockType = "dirt"},
  {x = 1, y = 2, blockType = "dirt"}, 
  {x = 1, y = 6, blockType = "dirt"},
  {x = 1, y = 7, blockType = "log"},
  {x = 1, y = 8, blockType = "log"},
  {x = 1, y = 9, blockType = "dirt"}, 
  {x = 1, y = 13, blockType = "dirt"},
  {x = 1, y = 14, blockType = "dirt"},
  {x = 1, y = 15, blockType = "dirt"},
  
  {x = 2, y = 0, blockType = "dirt"},
  {x = 2, y = 1, blockType = "dirt"},
  {x = 2, y = 2, blockType = "dirt"}, 
  {x = 2, y = 6, blockType = "dirt"},
  {x = 2, y = 7, blockType = "dirt"},
  {x = 2, y = 8, blockType = "dirt"},
  {x = 2, y = 9, blockType = "dirt"}, 
  {x = 2, y = 13, blockType = "dirt"},
  {x = 2, y = 14, blockType = "dirt"},
  {x = 2, y = 15, blockType = "dirt"},
  
  {x = 6, y = 0, blockType = "dirt"},
  {x = 6, y = 1, blockType = "dirt"},
  {x = 6, y = 2, blockType = "dirt"},
  {x = 6, y = 13, blockType = "dirt"},
  {x = 6, y = 14, blockType = "dirt"},
  {x = 6, y = 15, blockType = "dirt"},
  
  {x = 7, y = 0, blockType = "log"},
  {x = 7, y = 1, blockType = "log"},
  {x = 7, y = 2, blockType = "dirt"},
  {x = 7, y = 13, blockType = "dirt"},
  {x = 7, y = 14, blockType = "log"},
  {x = 7, y = 15, blockType = "log"},
  
  {x = 8, y = 0, blockType = "log"},
  {x = 8, y = 1, blockType = "log"},
  {x = 8, y = 2, blockType = "dirt"},
  {x = 8, y = 13, blockType = "dirt"},
  {x = 8, y = 14, blockType = "log"},
  {x = 8, y = 15, blockType = "log"},
  
  {x = 9, y = 0, blockType = "dirt"},
  {x = 9, y = 1, blockType = "dirt"},
  {x = 9, y = 2, blockType = "dirt"},
  {x = 9, y = 13, blockType = "dirt"},
  {x = 9, y = 14, blockType = "dirt"},
  {x = 9, y = 15, blockType = "dirt"},
  
  {x = 13, y = 0, blockType = "dirt"},
  {x = 13, y = 1, blockType = "dirt"},
  {x = 13, y = 2, blockType = "dirt"}, 
  {x = 13, y = 6, blockType = "dirt"},
  {x = 13, y = 7, blockType = "dirt"},
  {x = 13, y = 8, blockType = "dirt"},
  {x = 13, y = 9, blockType = "dirt"}, 
  {x = 13, y = 13, blockType = "dirt"},
  {x = 13, y = 14, blockType = "dirt"},
  {x = 13, y = 15, blockType = "dirt"},
  
  {x = 14, y = 0, blockType = "dirt"},
  {x = 14, y = 1, blockType = "dirt"},
  {x = 14, y = 2, blockType = "dirt"}, 
  {x = 14, y = 6, blockType = "dirt"},
  {x = 14, y = 7, blockType = "log"},
  {x = 14, y = 8, blockType = "log"},
  {x = 14, y = 9, blockType = "dirt"}, 
  {x = 14, y = 13, blockType = "dirt"},
  {x = 14, y = 14, blockType = "dirt"},
  {x = 14, y = 15, blockType = "dirt"},
  
  {x = 15, y = 0, blockType = "dirt"},
  {x = 15, y = 1, blockType = "dirt"},
  {x = 15, y = 2, blockType = "dirt"}, 
  {x = 15, y = 6, blockType = "dirt"},
  {x = 15, y = 7, blockType = "log"},
  {x = 15, y = 8, blockType = "log"},
  {x = 15, y = 9, blockType = "dirt"}, 
  {x = 15, y = 13, blockType = "dirt"},
  {x = 15, y = 14, blockType = "dirt"},
  {x = 15, y = 15, blockType = "dirt"},
}