-- file: physics.lua
local physics = Tiny.processingSystem()

physics.filter = Tiny.requireAll("position",
                                 "velocity",
                                 "speed")

-- TODO: Be wary of floating point issues!!!!
local
function bounce(e, normal)
    ---- Calculate normal
    if e.bounciness then
        if e.max_bounces > 0 then
            local vx = e.velocity.x
            local vy = e.velocity.y
            local d = vx * normal.x + vy * normal.y
            local rx = vx - 2 * d * normal.x * e.bounciness
            local ry = vy - 2 * d * normal.y * e.bounciness
            e.velocity.x = rx
            e.velocity.y = ry
            e.bounciness = e.bounciness * e.bounciness
            e.max_bounces = e.max_bounces - 1
        else
            e.dead = true
        end
    end
end

local
function hurt(item,other)
    other.hp = other.hp - item.damage
    if other.hp < 1 then
        other.dead = true
    end
    if item.hp then
        item.hp = item.hp - item.damage
        if item.hp < 1 then
            item.dead = true
        end
    end
end

function physics:process(e, dt)
    local lp = e.last_position
    local p = e.position
    local v = e.velocity
    -- normalize the velocity vector
    local n = math.sqrt(v.x * v.x + v.y * v.y)
    local x,y = p.x, p.y
    -- Calculate the potential x/y
    if n > 0 then
        x = p.x + v.x*dt*e.speed/n
        y = p.y + v.y*dt*e.speed/n
    end

    local filter = function(item, other, _shape, _othershape)
       if other.collision_layer == item.collision_layer then
           if other.anchored then
               return "bounce"
           end
       end
       return "cross"
    end

    local actualX, actualY, collisions, count = collision:move(e, x, y, filter)

    for i=1, count do
       local collision = collisions[i]
       local other = collision.other
       if collision.response == "bounce" then
           bounce(e, collision.normal)
       elseif collision.response == "cross" then
           if e.damage and other.hp then
               hurt(e, other)
           end
       end
    end

    -- Update the new position
    lp.x, lp.y = p.x, p.y
    p.x, p.y = actualX, actualY
end

return physics
