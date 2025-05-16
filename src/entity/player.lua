-- file: player.lua
local Player = class:extend()

function Player:new()
    self.position = { x = 0, y = 0 }
    self.velocity = { x = 0, y = 0 }
    self.rotation = 0
    self.controllable = true
    self.drawable = true
    self.speed = 100
    self.size = 32
end

return Player
