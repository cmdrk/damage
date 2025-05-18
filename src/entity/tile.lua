-- file: tile.lua
local Tile = class:extend()

function Tile:new(x,y,type)
    --print("making new tile: " .. x .. "," .. y .. "," .. type)
    self.position = { x = x, y = y }
    self.drawable = true
    self.type = type
    self.initializing = true
    self.size = MAP_SCALE

    if self.type == "wall" then
        -- TODO: Collision mask instead of bool, for different layers?
        print("Adding collidable at: (" .. x .. "," .. y .. ")")
        local px = self.position.x * self.size
        local py = self.position.y * self.size
        collision:add(self,
                      px,
                      py,
                      self.size,
                      self.size)
    end
end

return Tile
