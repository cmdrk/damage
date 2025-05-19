-- file: offline.lua
local offline = {}
local mapgen = require("src.util.mapgen")

-- TinyECS configuration 
local draw_filter = tiny.requireAll('is_draw_system')
local update_filter = tiny.rejectAny('is_draw_system')

local Player = require("src.entity.player")
local Mob = require("src.entity.mob")
local Projectile = require("src.entity.projectile")

local p

function offline.activate()
    p = Player(96,96)
    world = tiny.world(
                    require("src.system.controller"),
                    require("src.system.physics"),
                    require("src.system.render"),
                    require("src.system.cleaner")
                )
    -- Generate the map
    mapgen.run("map_01", world)
    print("Adding player to world")
    world:addEntity(p)
    for _i = 1, 100 do
        m = Mob(math.random(2,32), math.random(2,32))
        world:addEntity(m)
    end
    --love.mouse.setRelativeMode(true)
    --love.mouse.setGrabbed(true)
    -- Set globals
    _G.world = world
end

function offline.update(dt)
    world:update(dt, update_filter)
end

function offline.draw()
    cam:draw(render)
end

function render(_l,_t,_w,_h)
    dt = love.timer.getDelta()
    world:update(dt, draw_filter)
end

function offline.keypressed(_key)
end

function offline.mousereleased(_x,_y,button)
    if button == 1 then
        -- Create a new projectile
        local px, py = p.position.x, p.position.y
        local vx = math.cos(p.torso_rotation)
        local vy = math.sin(p.torso_rotation)
        local b = Projectile(px, py, vx, vy)
        world:addEntity(b)
    end
end

function offline.deactivate()
    tiny.clearEntities(world)
    tiny.clearSystems(world)
    tiny.refresh(world)
end

return offline
