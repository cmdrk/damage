-- file: mob.lua
local Mob = class:extend()

function Mob:new(x,y)
    self.type = "mob"
    self.collision = true
    self.drawable = true
    self.size = 16
    self.speed = 100
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
    self.dead = false
    self.speed = 300

    collision:add(self,
                  self.position.x,
                  self.position.y,
                  self.size,
                  self.size)
end

function Mob:hurt()
    self.dead = true
end

function Mob:bounce()
    local x = self.velocity.x
    local y = self.velocity.y
    local vx = -y + math.random() * 0.2
    local vy = x + math.random() * 0.2

    self.velocity.x = vx
    self.velocity.y = vy
end


return Mob
