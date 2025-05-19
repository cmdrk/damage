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
        -- print("Adding collidable at: (" .. x .. "," .. y .. ")")
        local px = self.position.x * self.size
        local py = self.position.y * self.size
        collision:add(self,
                      px,
                      py,
                      self.size,
                      self.size)
    end
end

function Tile:draw(x,y)
    local s = self.size
    if self.type == "wall" then
        love.graphics.setColor(0.4,0.2,0.8,0.8)
        love.graphics.rectangle("fill", x*s, y*s, s, s)
        love.graphics.setColor(1.0,1.0,1.0,1.0)
    elseif self.type == "floor" then
        love.graphics.setColor(0.4,0.4,0.8,0.1)
        love.graphics.rectangle("line", x*s, y*s, s, s)
        love.graphics.setColor(1.0,1.0,1.0,1.0)
    end

end

return Tile
