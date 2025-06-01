-- file: mapgen.lua
local Wall = require("src.entity.wall")
local Floor = require("src.entity.floor")
local mapgen = {}

function mapgen.read_map(name)
    local map = io.open("assets/maps/" .. name)
    if map then
        print("Loaded map")
        local diagram = map:read("*all")
        map:close()
        return diagram
    else
        print("Error loading map: " .. map)
        return ""
    end
end

-- Parse an ASCII diagram into a table of tiles
function mapgen.run(mapstring)
    -- Split the map string into lines
    local lines = {}
    for line in mapstring:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end

    -- Iterate through each character in the map
    for y = 0, #lines - 1 do
        local line = lines[y + 1]
        for x = 0, #line - 1 do
            local char = line:sub(x + 1, x + 1)
            -- Create tiles based on the character
            local e
            if char == "#" then
                e = Wall(x,y)
            else
                e = Floor(x,y)
            end
            ecs:addEntity(e)
            collision:add(e, e.position.x, e.position.y, e.collision_shape)
        end
    end
end

return mapgen
