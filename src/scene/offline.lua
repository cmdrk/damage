-- file: offline.lua
local offline = {}
local world = tiny.world(
                    require("src.system.controller"),
                    require("src.system.physics"),
                    require("src.system.render")
                )

-- TinyECS configuration 
local draw_filter = tiny.requireAll('is_draw_system')
local update_filter = tiny.rejectAny('is_draw_system')


local Player = require("src.entity.player")

function offline.activate()
    local p = Player()
    world:addEntity(p)
    --love.mouse.setRelativeMode(true)
    love.mouse.setGrabbed(true)
end

function offline.update(dt)
    world:update(dt, update_filter)
end

function offline.draw()
    dt = love.timer.getDelta()
    world:update(dt, draw_filter)
end

function offline.keypressed(_key)
end

return offline
