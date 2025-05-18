-- file: player.lua
local Player = class:extend()

function Player:new(x,y)
    self.size = 24
    self.position = {
        x = x,
        y = y
    }
    self.leg_rotation = 0
    self.torso_rotation = 0
    self.controllable = true
    self.drawable = true
    self.player = true -- not necessarily the controlling player
    self.speed = 100
end

return Player
