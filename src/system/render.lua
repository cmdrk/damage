-- file: render.lua

local render = tiny.processingSystem()
render.is_draw_system = true

render.filter = tiny.requireAll("drawable","position")

function render:process(e, dt)
    local x,y = math.floor(e.position.x),
                math.floor(e.position.y)
    if e.draw then
        e:draw(x,y)
    end
end

return render
