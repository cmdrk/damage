-- file: cleaner.lua

local cleaner = tiny.processingSystem()

cleaner.filter = tiny.requireAny("time_left", "dead")

function cleaner:process(e, _dt)
    if e.time_left then
        e.time_left = e.time_left - dt
        if e.time_left < 0 then
            print("Removing entity of type " .. e.type.." (timeout)")
            collision:remove(e)
            world:removeEntity(e)
        end
    end
    if e.dead then
        print("Removing entity of type " .. e.type.." (dead)")
        collision:remove(e)
        world:removeEntity(e)
    end
end

return cleaner
