-- file: player.lua
local Player = class:extend()

-- Constants
local SIZE = 24
local SPEED = 100

function Player:new(x,y)
    self.type = "player"
    self.collision = true
    self.drawable = true
    self.controllable = true
    self.size = SIZE
    self.speed = SPEED
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

    collision:add(self,
                  self.position.x,
                  self.position.y,
                  self.size,
                  self.size)
end


function Player:draw(x,y)
   -- local x,y = math.floor(e.position.x),
   --             math.floor(e.position.y)
    local r = self.torso_rotation
    local s = self.size
    -- Torso
    draw_arms(x,y,s,r)
    -- Legs
    love.graphics.push()
    love.graphics.translate(x+s/2, y+s/2)
    love.graphics.circle("line", 0, 0, 3*s / 5)
    love.graphics.pop()
end


function draw_arms(x,y,s,r)
    love.graphics.push()
    -- center and rotate
    love.graphics.translate(x+s/2, y+s/2)
    love.graphics.rotate(r)
    -- draw a square in the top left and top right, relatively
    love.graphics.rectangle("line", -s/2,
                                    -s,
                                    s - s/4,
                                    s/4
                                )
    love.graphics.rectangle("line", s/4 + 4,
                                    -s,
                                    s/4+2,
                                    s/4
                                )
    love.graphics.rectangle("line", -s/2,
                                    s-s/4,
                                    s-s/4,
                                    s/4
                                )
    love.graphics.rectangle("line", s/4 + 4,
                                    s - s/4,
                                    s/4+2,
                                    s/4
                                )
    love.graphics.pop()
end

return Player
