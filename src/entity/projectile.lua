-- file: projectile.lua
local Projectile = class:extend()

-- Various constants
local SPEED = 400
local SIZE = 8
local MAX_BOUNCES = 2
local BOUNCINESS = 1
local BOUNCY_DECAY = 0.75
local JITTER = math.random() * 0.2


function Projectile:new(px,py,vx,vy)
    self.type = "projectile"
    self.dead = false
    self.position = { x = px, y = py }
    self.velocity = { x = vx, y = vy }
    self.speed = SPEED
    self.drawable = true
    self.type = "projectile"
    self.size = SIZE
    self.max_bounces = MAX_BOUNCES
    self.bounciness = BOUNCINESS
    collision:add(self,
                  self.position.x,
                  self.position.y,
                  self.size,
                  self.size)
end

function Projectile:draw(x,y)
    local s = self.size
    love.graphics.setColor(0.8,0.2,0.2,0.9)
    love.graphics.rectangle("fill", x, y, s, s)
    love.graphics.setColor(1.0,1.0,1.0,1.0)
end

function Projectile:collide(cols, len)
    for _i=1, len do
        local col = cols[1]
        if col.other.type == "wall" then
            self:bounce()
        elseif col.other.type == "mob" then
            if col.other.hurt then
                col.other:hurt()
                self:die()
            end
        end
    end
end

function Projectile:bounce()
    if self.max_bounces > 0 then
        local x = self.velocity.x
        local y = self.velocity.y
        local vx = -y * self.bounciness + JITTER
        local vy = x * self.bounciness + JITTER

        self.velocity.x = vx
        self.velocity.y = vy
        self.bounciness = self.bounciness * BOUNCY_DECAY
        self.max_bounces = self.max_bounces - 1
    else
        self.dead = true
    end
end

function Projectile:die()
    self.dead = true
end

return Projectile
