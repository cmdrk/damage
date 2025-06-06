-- file: cleaner.lua

local cleaner = Tiny.processingSystem()
cleaner.is_server_system = true

cleaner.filter = Tiny.requireAll("dead")

function cleaner:process(e, _dt)
    if e.dead == true then
        ecs:removeEntity(e)
        collision:remove(e)
    end
end

return cleaner
