-- file: offline.lua
local offline = {}

-- Libraries
local mapgen = require("src.util.mapgen")

-- TinyECS configuration 
local draw_filter = Tiny.requireAll('is_draw_system')
local update_filter = Tiny.rejectAny('is_draw_system')

-- Entities
local Player = require("src.entity.player")
local Mob = require("src.entity.mob")
local Projectile = require("src.entity.projectile")

local p

function offline.activate()
    -- Set libraries as global

    -- Setup camera
    local cam = Gamera.new(0,0,WORLD_X,WORLD_Y)
    _G.cam = cam

    -- Setup collision system
    local collision = Slick.newWorld(WORLD_X, WORLD_Y)
    _G.collision = collision

    -- Setup ECS
    local ecs = Tiny.world(
                    require("src.system.controller"),
                    require("src.system.physics"),
                    require("src.system.render"),
                    require("src.system.cleaner")
                )
    _G.ecs = ecs

    -- Generate the map
    local m =mapgen.read_map("map_01")
    print(m)
    mapgen.run(m)

    -- Add the player
    p = Player(2,2)
    ecs:addEntity(p)
    collision:add(p, p.position.x, p.position.y, p.collision_shape)

    for _i = 1, 100 do
        local m = Mob(3,3)
        ecs:addEntity(m)
        collision:add(m, m.position.x, m.position.y, m.collision_shape)
    end
end

function offline.update(dt)
    ecs:update(dt, update_filter)
end

local function render(_l,_t,_w,_h, alpha)
    ecs:update(alpha, draw_filter)
end
function offline.draw(alpha)
    cam:draw(render,alpha)
end

function offline.keypressed(_key)
end

function offline.mousereleased(_x,_y,button)
    if button == 1 then
        -- Create a new projectile
        local px, py = p.position.x, p.position.y
        local vx = math.cos(p.rotation)
        local vy = math.sin(p.rotation)
        local b = Projectile(px, py, vx, vy)
        ecs:addEntity(b)
        collision:add(b, px, py, b.collision_shape)
    end
end

function offline.deactivate()
    Tiny.clearEntities(ecs)
    Tiny.clearSystems(ecs)
    Tiny.refresh(ecs)
end

return offline
