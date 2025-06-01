-- file: projectile.lua
local Projectile = Class:extend()

-- Various constants
local SPEED = 400
local SIZE = 4
local MAX_BOUNCES = 4
local BOUNCINESS = 1
local BOUNCY_DECAY = 0.8
local JITTER = math.random()
local HP = 1
local DAMAGE = 1

function Projectile:new(px,py,vx,vy)
    self.type = "projectile"
    self.dead = false
    self.last_position = { x = px, y = py }
    self.position = { x = px, y = py }
    self.last_rotation = 0.0
    self.rotation = 0.0
    self.velocity = { x = vx, y = vy }
    self.speed = SPEED
    self.drawable = true
    self.color = { 0.8, 0.2, 0.2, 0.9 }
    self.shape = "circle"
    self.size = SIZE
    self.collision_layer = 2
    self.collision_shape = Slick.newCircleShape(0,0,2)
    self.max_bounces = MAX_BOUNCES
    self.bounciness = BOUNCINESS
    self.jitter = JITTER
    self.bouncy_decay = BOUNCY_DECAY
    self.hp = HP
    self.damage = DAMAGE
end

return Projectile
