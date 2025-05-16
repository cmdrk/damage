-- file: controller.lua
-- Player controller

local control = tiny.processingSystem()
local kb = love.keyboard

control.filter = tiny.requireAll(
                                "controllable",
                                "position",
                                "velocity",
                                "rotation"
                                )

function control:process(e, _dt)
    local up, down, left, right = kb.isDown("w"),
                                  kb.isDown("s"),
                                  kb.isDown("a"),
                                  kb.isDown("d")
    -- Reset velocity for this frame
    local v = e.velocity
    v.x, v.y = 0, 0

    -- Get the position
    local p = e.position

    -- Update the rotation and position if the mouse is outside the minimum
    -- distance radius
    local ex = e.position.x + e.size/2
    local ey = e.position.y + e.size/2
    local mx,my = love.mouse.getPosition()
    local dx = mx - ex
    local dy = my - ey
    local length = math.sqrt(dx^2 + dy^2)
    if length > e.size then
        -- Set the object's rotation to the mouse's rotation
        e.rotation = math.atan2(dy,dx)
        local r = e.rotation 
        -- Apply movement based on input
        if up then
            v.x = v.x + math.cos(r)
            v.y = v.y + math.sin(r)
        elseif down then
            v.x = v.x - math.cos(r)
            v.y = v.y - math.sin(r)
        end
        -- Strafe 
        if left then
            v.x = v.x + math.cos(r + math.pi/2)
            v.y = v.y + math.sin(r + math.pi/2)
        elseif right then
            v.x = v.x - math.cos(r + math.pi/2)
            v.y = v.y - math.sin(r + math.pi/2)
        end

        -- Finally, calculate the new position
        -- normalize the velocity vector
        local normal = math.sqrt(v.x * v.x + v.y * v.y)
        if normal > 0 then
            p.x = p.x + v.x*dt*e.speed/normal
            p.y = p.y + v.y*dt*e.speed/normal
        end
    end
end

function look_at_cursor(x,y)
    -- Calculate angle from player to mouse and set the rotation
    local mx,my = love.mouse.getPosition()
    local dx = mx - x
    local dy = my - y
    local length = math.sqrt(dx^2 + dy^2)
    if length > 10 then
        dx = dx/length
        dy = dy/length
    end
    return math.atan2(dy, dx)
end

function cartesian_to_polar(x,y)
    local r = math.sqrt(x^2 + y^2)
    local theta = math.atan2(y,x)
    return r,theta
end

function polar_to_cartesian(r, th)
    local x = r * math.cos(th)
    local y = r * math.sin(th)
    return x,y
end

-- old control
--    local up, down, left, right = kb.isDown("w"),
--                                  kb.isDown("s"),
--                                  kb.isDown("a"),
--                                  kb.isDown("d")
--    -- Reset velocity for this frame
--    local v = e.velocity
--    local r = e.rotation
--    v.x, v.y = 0, 0
--
--    if kb.isDown("a") or kb.isDown("d") then
--        strafing = true
--    else
--        strafing = false
--    end
--
--    -- Calculate movement direction vectors
--    local forwardX = math.cos(r)
--    local forwardY = math.sin(r)
--    local rightX = math.cos(r + math.pi/2)
--    local rightY = math.sin(r + math.pi/2)
--
--    -- Apply movement based on input
--    if up then
--        v.x = v.x + forwardX
--        v.y = v.y + forwardY
--    elseif down then
--        v.x = v.x - forwardX
--        v.y = v.y - forwardY
--    end
--
--    if left then
--        v.x = v.x - rightX
--        v.y = v.y - rightY
--    elseif right then
--        v.x = v.x + rightX
--        v.y = v.y + rightY
--    end
--
--    -- Normalize velocity if there's any movement
--    local speed = math.sqrt(v.x * v.x + v.y * v.y)
--    if speed > 0 then
--        v.x = v.x / speed
--        v.y = v.y / speed
--    end
--
--    -- Calculate angle from player to mouse and set the rotation
--    local mx,my = love.mouse.getPosition()
--    local px,py,ps = e.position.x, e.position.y, e.size
--    local dx = mx - px - ps / 2
--    local dy = my - py - ps / 2
--    local length = math.sqrt(dx^2 + dy^2)
--    if length > 0 then
--        dx = dx/length
--        dy = dy/length
--    end
--    if not strafing then
--        e.rotation = math.atan2(dy, dx)
--    end

return control
