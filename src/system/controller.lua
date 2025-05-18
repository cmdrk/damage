-- file: controller.lua
-- Player controller

local controller = tiny.processingSystem()
local kb = love.keyboard

controller.filter = tiny.requireAll("controllable")

function controller:process(e, _dt)
    -- Get the position
    local p = e.position

    -- If any directionals are held, move in that direction
    local up, down, left, right = kb.isDown("w"),
                                  kb.isDown("s"),
                                  kb.isDown("a"),
                                  kb.isDown("d")
    if up then
        p.y = p.y - dt*e.speed
    elseif down then
        p.y = p.y + dt*e.speed
    end

    if left then
        p.x = p.x - dt*e.speed
    elseif right then
        p.x = p.x + dt*e.speed
    end

    -- Rotate the top-half of the bot toward the mouse
    e.torso_rotation = look_at_cursor(p.x, p.y)

    -- Update the camera
    cam:setPosition(p.x,p.y)
end

function look_at_cursor(x,y)
    -- Calculate angle from player to mouse and set the rotation
    local mx,my = cam:toWorld(love.mouse.getPosition())
    local dx = mx - x
    local dy = my - y
    local length = math.sqrt(dx^2 + dy^2)
    if length > 10 then
        dx = dx/length
        dy = dy/length
    end
    return math.atan2(dy, dx)
end

return controller
