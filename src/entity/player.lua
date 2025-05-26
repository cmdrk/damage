-- file: player.lua
local Player = Class:extend()

-- Constants
local SIZE = 24
local SPEED = 100

function Player:new(x,y)
    self.dead = false
    self.drawable = true
    self.controllable = true
    self.size = SIZE
    self.speed = SPEED
    self.position = {
        x = x * MAP_SCALE,
        y = y * MAP_SCALE
    }
    self.velocity = {
        x = 0.0,
        y = 0.0
    }
    self.rotation = 0

    self.collision_layer = 2
    self.collision_shape = Slick.newCircleShape(0,0, self.size)

    -- Drawing properties
    self.shape = "circle"
    self.arms = true
end

return Player
