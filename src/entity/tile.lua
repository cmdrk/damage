-- file: tile.lua
local Tile = class:extend()

function Tile:new(x,y,type)
    self.position = { x = x, y = y }
    self.drawable = true
    self.type = type
end

return Tile
