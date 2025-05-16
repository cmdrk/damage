-- file: render.lua

local render = tiny.processingSystem()
render.is_draw_system = true

render.filter = tiny.requireAll(
                    "drawable",
                    "size",
                    "position",
                    "rotation"
                )

function render:process(e, _dt)
   -- local x,y = math.floor(e.position.x),
   --             math.floor(e.position.y)
    local x,y = e.position.x, e.position.y
    local s = e.size
    local angle = e.rotation
    --print(angle)
    if e.controllable then
        love.graphics.push()
        love.graphics.translate(x+s/2, y+s/2)
        love.graphics.rotate(angle)
        love.graphics.rectangle("fill", -s/2, -s/2, s, s)
        love.graphics.pop()
    else
        love.graphics.circle("line", x, y, s)
    end
    -- print current key
    if debug_key then
        local w,h = love.graphics.getDimensions()
        love.graphics.printf(debug_key, 16, 16, w, "left")
    end
end

return render
