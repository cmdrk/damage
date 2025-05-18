-- file: render.lua

local render = tiny.processingSystem()
render.is_draw_system = true

render.filter = tiny.requireAll("drawable")

function render:process(e, dt)
    if e.player then
        draw_player(e, dt)
    else 
        draw_entity(e, dt)
    end
end

function draw_entity(e, _dt)
    local x,y = math.floor(e.position.x),
                math.floor(e.position.y)
    local s = MAP_SCALE
    if e.type == "wall" then
        love.graphics.setColor(0.4,0.2,0.8,0.8)
        fill = "fill"
    elseif e.type == "floor" then
        love.graphics.setColor(0.4,0.4,0.8,0.1)
        fill = "line"
    end
    love.graphics.rectangle(fill, x*s, y*s, s, s)
    love.graphics.setColor(1.0,1.0,1.0,1.0)
end

function draw_player(e, _dt)
   -- local x,y = math.floor(e.position.x),
   --             math.floor(e.position.y)
    local x,y = e.position.x, e.position.y
    local r = e.torso_rotation
    local s = e.size
    -- Torso
    draw_arms(x,y,s,r)
    -- Legs
    love.graphics.push()
    love.graphics.translate(x+s/2, y+s/2)
    love.graphics.circle("line", 0, 0, 3*s / 5)
    love.graphics.pop()
end


function draw_arms(x,y,s,r)
    love.graphics.push()
    -- center and rotate
    love.graphics.translate(x+s/2, y+s/2)
    love.graphics.rotate(r)
    -- draw a square in the top left and top right, relatively
    love.graphics.rectangle("line", -s/2,
                                    -s,
                                    s - s/4,
                                    s/4
                                )
    love.graphics.rectangle("line", s/4 + 4,
                                    -s,
                                    s/4+2,
                                    s/4
                                )
    love.graphics.rectangle("line", -s/2,
                                    s-s/4,
                                    s-s/4,
                                    s/4
                                )
    love.graphics.rectangle("line", s/4 + 4,
                                    s - s/4,
                                    s/4+2,
                                    s/4
                                )
    love.graphics.pop()
end

return render
