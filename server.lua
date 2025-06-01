Damage = require("damage")

-- Internal libs
local mapgen = require("src.util.mapgen")

-- Setup ECS filters
local update_filter = Tiny.requireAll('is_server_system')

function load_level(mapstr) 
    mapgen.run(mapstr)
end

function update(dt) 
    ecs:update(dt, update_filter)    
end
