-- file: physics.lua

local physics = tiny.processingSystem()

physics.filter = tiny.filter("(position&velocity)&!controllable")

function physics:process(e, dt)
    local p = e.position
    local v = e.velocity
    -- normalize the velocity vector
    local normal = math.sqrt(v.x * v.x + v.y * v.y)
    local x,y
    -- Calculate the potential x/y
    if normal > 0 then
        x = p.x + v.x*dt*e.speed/normal
        y = p.y + v.y*dt*e.speed/normal
    end
    p.x, p.y, _len, _cols = collision:move(e, x, y)
end

return physics
