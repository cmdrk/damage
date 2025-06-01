Damage = require("damage")

local server = {}

-- Internal libs
local mapgen = require("src.util.mapgen")

-- Setup ECS filters
local update_filter = Tiny.requireAll('is_server_system')

function server.load_level(mapstr) 
    mapgen.run(mapstr)
end

function server.update(dt) 
    ecs:update(dt, update_filter)    
end

return server

---- testing
--local Mob = require("src.entity.mob")
--
--local m = Mob(2,2)
--ecs:addEntity(m)
--collision:add(m, m.position.x, m.position.y, m.collision_shape)
--print("mob pos: ("..m.position.x..","..m.position.y..")")
--update(2)
--print("mob pos: ("..m.position.x..","..m.position.y..")")
