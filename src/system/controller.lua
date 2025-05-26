-- file: controller.lua
-- Player controller

local controller = Tiny.processingSystem()
local kb = love.keyboard
local mouse = love.mouse

controller.filter = Tiny.requireAll("controllable","position","velocity")

local function look_at_cursor(x,y)
    -- Calculate angle from player to mouse and set the rotation
    local mx,my = cam:toWorld(mouse.getPosition())
    local dx = mx - x
    local dy = my - y
    local length = math.sqrt(dx^2 + dy^2)
    if length > 10 then
        dx = dx/length
        dy = dy/length
    end
    return math.atan2(dy, dx)
end

function controller:process(e, _dt)
    -- Get the position
    local p = e.position

    -- Reset the velocity this frame
    local v = e.velocity
    v.x, v.y = 0.0,0.0

    -- Update the camera
    cam:setPosition(p.x,p.y)

    -- Rotate the the player toward the mouse position
    e.rotation = look_at_cursor(p.x, p.y)

    -- If any directionals are held, move in that direction
    local up, down, left, right = kb.isDown("w"),
                                  kb.isDown("s"),
                                  kb.isDown("a"),
                                  kb.isDown("d")
    if up then v.y = -1.0 end
    if down then v.y = 1.0 end
    if left then v.x = -1.0 end
    if right then v.x = 1.0 end
end

return controller
