-- file: projectile.lua
local Projectile = class:extend()

function Projectile:new(px,py,vx,vy)
    self.type = "projectile"
    self.position = { x = px, y = py }
    self.velocity = { x = vx, y = vy }
    print("making new projectile: " .. px .. "," .. py .. ")")
    self.speed = 400
    self.drawable = true
    self.type = "projectile"
    self.size = 8
    self.max_bounces = 2
    self.bounciness = 1
    self.dead = false
    collision:add(self,
                  self.position.x,
                  self.position.y,
                  self.size,
                  self.size)
end

function Projectile:bounce()
    if self.max_bounces > 0 then
        local x = self.velocity.x
        local y = self.velocity.y
        local vx = -y * self.bounciness + math.random() * 0.2
        local vy = x * self.bounciness + math.random() * 0.2

        self.velocity.x = vx
        self.velocity.y = vy
        self.bounciness = self.bounciness * .75
        self.max_bounces = self.max_bounces - 1
    else
        self.dead = true
    end
end

return Projectile
