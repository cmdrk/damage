-- file: tile.lua
local Wall = Class:extend()

function Wall:new(x,y)
    print("Adding wall at: ("..x..","..y..")")
    self.debugtype = "wall"
    self.position = { x = x * MAP_SCALE,
                      y = y * MAP_SCALE }
    self.drawable = true
    self.initializing = true
    self.size = MAP_SCALE - 1
    self.shape = "rectangle"
    self.collision_shape = Slick.newRectangleShape(0,0, MAP_SCALE, MAP_SCALE)
    self.collision_layer = 2 -- walls
    self.anchored = true
    self.color = { 0.4, 0.2, 0.8, 0.8 }
end

return Wall
