-- file: physics.lua

local inspect = require("lib.inspect")
local physics = tiny.processingSystem()

physics.filter = tiny.requireAll("position",
                                 "velocity",
                                 "speed")

function physics:process(e, dt)
    local p = e.position
    local v = e.velocity
    -- normalize the velocity vector
    local normal = math.sqrt(v.x * v.x + v.y * v.y)
    local x,y = p.x, p.y
    -- Calculate the potential x/y
    if normal > 0 then
        x = p.x + v.x*dt*e.speed/normal
        y = p.y + v.y*dt*e.speed/normal
    end

    -- Resolve any collisions and set actual new x/y
    local filter = function(_item, other)
        if other.type == "wall" then return "bounce"
        elseif other.type == "mob" then return "cross" end
        return nil
    end

    new_x, new_y, cols, len = collision:move(e, x, y, filter)
    if e.collide then
        e:collide(cols, len)
    end

    -- Finally, update the new position
    p.x, p.y = new_x, new_y
end

return physics
