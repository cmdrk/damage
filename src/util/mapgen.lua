-- file: mapgen.lua
local Tile = require("src.entity.tile")
local mapgen = {}

-- Parse an ASCII diagram into a table of tiles
function mapgen.run(mapfile, world)
    -- Get the map in string representation
    local mapstring = read_map(mapfile)

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
                --print("Adding wall at (" .. x .. "," .. y .. ")")
                e = Tile(x,y,"wall")
            elseif char == "." then
                --print("Adding floor at (" .. x .. "," .. y .. ")")
                e = Tile(x,y,"floor")
            elseif char == "S" then
                e = Tile(x,y, "spawn")
            end
            world:addEntity(e)
        end
    end
end

function read_map(name)
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

return mapgen
