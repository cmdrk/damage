-- file: mob.lua
local Mob = Class:extend()

-- Constants
local SIZE = 16
local SPEED = 100

function Mob:new(x,y)
    self.dead = false
    self.drawable = true
    self.size = SIZE
    self.speed = SPEED
    self.last_position = {
        x = x * MAP_SCALE,
        y = y * MAP_SCALE
    }
    self.position = {
        x = x * MAP_SCALE,
        y = y * MAP_SCALE
    }
    self.velocity = {
        x = math.random(),
        y = math.random()
    }
    self.last_rotation = 0.0
    self.rotation = 0.0
    self.shape = "rectangle"
    self.collision_shape = Slick.newRectangleShape(0,0,self.size,self.size)
    self.collision_layer = 2
    self.color = { 0.8, 0.8, 0.7, 1.0 }
    self.bounciness = 1.0
    self.max_bounces = 99999
    self.hp = 1
end

return Mob
