-- file: cleaner.lua

local cleaner = tiny.processingSystem()

cleaner.filter = tiny.filter("dead")

function cleaner:onAdd(e)
    return nil
end

function cleaner:onRemove(e)
    return nil
end

function cleaner:process(e, _dt)
    collision:remove(e)
end

return cleaner
