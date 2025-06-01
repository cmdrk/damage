-- file: tile.lua
local Floor = Class:extend()

function Floor:new(x,y)
    self.last_position = { x = x * MAP_SCALE,
                      y = y * MAP_SCALE
                    }
    self.position = { x = x * MAP_SCALE,
                      y = y * MAP_SCALE
                    }
    self.last_rotation = 0
    self.rotation = 0
    self.drawable = true
    self.size = MAP_SCALE - 1
    self.shape = "rectangle"
    self.collision_shape = Slick.newRectangleShape(0,0,MAP_SCALE,MAP_SCALE)
    self.anchored = true
    self.collision_layer = 1
    self.color = { 0.4, 0.4, 0.8, 0.1 }
end

return Floor
