-- file: cleaner.lua

local cleaner = tiny.processingSystem()

cleaner.filter = tiny.requireAll("dead")

function cleaner:process(e, _dt)
    if e.dead == true then
        collision:remove(e)
        world:removeEntity(e)
    end
end

return cleaner
