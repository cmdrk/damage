-- file: physics.lua

local physics = tiny.processingSystem()

physics.filter = tiny.filter("(position&velocity)&!controllable")

function physics:process(e, dt)
    local p = e.position
    local v = e.velocity
    -- normalize the velocity vector
    local normal = math.sqrt(v.x * v.x + v.y * v.y)
    if normal > 0 then
        p.x = p.x + v.x*dt*e.speed/normal
        p.y = p.y + v.y*dt*e.speed/normal
    end
end

return physics
