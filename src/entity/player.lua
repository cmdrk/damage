-- file: player.lua
local Player = class:extend()

function Player:new(x,y)
    self.type = "player"
    self.collision = true
    self.drawable = true
    self.controllable = true
    self.size = 24
    self.speed = 100
    self.position = {
        x = x,
        y = y
    }
    self.velocity = {
        x = 0.0,
        y = 0.0
    }
    self.leg_rotation = 0
    self.torso_rotation = 0
    self.speed = 100

    collision:add(self,
                  self.position.x,
                  self.position.y,
                  self.size,
                  self.size)
end

return Player
