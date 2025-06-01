-- file: render.lua

local render = Tiny.processingSystem()
render.is_draw_system = true

render.filter = Tiny.requireAll("drawable",
                                "position",
                                "last_position",
                                "rotation",
                                "last_rotation",
                                "size")

local function get_size(size)
    if type(size) == table then
        return size.x, size.y
    else
        return size, size
    end
end

local function draw_arms(x,y,s,r)
    love.graphics.push()
    -- center and rotate
    love.graphics.translate(x, y)
    love.graphics.rotate(r)
    local shoulder = -s/4
    local width = s/3
    local length = s+s/2
    local left_span = -s-s/2
    local right_span = s+s/2 - width
    -- left arm
    love.graphics.rectangle("line", shoulder,
                                    left_span,
                                    length,
                                    width
                                )
    -- right arm
    love.graphics.rectangle("line", shoulder,
                                    right_span,
                                    length,
                                    width
                                )
    love.graphics.pop()
end

function render:process(e, alpha)
    local function lerp(a,b,t)
        return a + (b - a) * t
    end

    local x,y = lerp(e.last_position.x, e.position.x, alpha),
                lerp(e.last_position.y, e.position.y, alpha)
    local r = lerp(e.last_rotation, e.rotation, alpha)
    local sx, sy = get_size(e.size)

    -- Set the camera position
    if e.controllable then
        cam:setPosition(x,y)
    end

    -- Set color, if defined
    if e.color then
        love.graphics.setColor(unpack(e.color))
    end

    love.graphics.push()
    love.graphics.translate(x,y)
    if e.shape == "circle" then
        love.graphics.ellipse("line", 0, 0, sx, sy)
        if e.arms then
            draw_arms(0,0,sx,r)
        end
    elseif e.shape == "rectangle" then
        love.graphics.rectangle("fill", 0, 0, sx, sy)
    end
    love.graphics.pop()

    -- Reset color
    love.graphics.setColor(1.0,1.0,1.0,1.0)
end

return render
