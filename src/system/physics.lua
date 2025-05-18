-- file: physics.lua

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
    p.x, p.y, cols, len = collision:move(e, x, y, filter)
    if e.type == "projectile" then
        for _i=1, len do
            local col = cols[1]
            if col.other.type == "wall" then
                if e then
                    e:bounce()
                end
            elseif col.other.type == "mob" then
                if col.other.hurt then
                    col.other:hurt()
                    e.dead = true
                end
            end
        end
    elseif e.type == "mob" then
        for _i=1, len do
            local col = cols[1]
            if col.other.type == "wall" then
                if e then
                    e:bounce()
                end
            end
        end
    end
end

return physics
