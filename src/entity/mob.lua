-- file: mob.lua
local Mob = class:extend()

-- Constants
local SIZE = 16
local SPEED = 100
local JITTER = math.random() * 0.2

function Mob:new(x,y)
    self.type = "mob"
    self.dead = false
    self.collision = true
    self.drawable = true
    self.size = SIZE
    self.speed = SPEED
    self.position = {
        x = x * MAP_SCALE,
        y = y * MAP_SCALE
    }
    self.velocity = {
        x = math.random(),
        y = math.random()
    }
    self.leg_rotation = 0
    self.torso_rotation = 0

    collision:add(self,
                  self.position.x,
                  self.position.y,
                  self.size,
                  self.size)
end

function Mob:bounce()
    local x = self.velocity.x
    local y = self.velocity.y
    local vx = -y + JITTER
    local vy = x + JITTER

    self.velocity.x = vx
    self.velocity.y = vy
end

function Mob:draw(x,y)
    local s = self.size
    love.graphics.setColor(0.8,0.8,0.7,1.0)
    love.graphics.rectangle("fill", x, y, s, s)
    love.graphics.setColor(1.0,1.0,1.0,1.0)
end

function Mob:hurt()
    self:die()
end

function Mob:collide(cols, len)
    for _i=1, len do
        local col = cols[1]
        if col.other.type == "wall" then
            self:bounce()
        end
    end
end

function Mob:die()
    self.dead = true
end

return Mob
