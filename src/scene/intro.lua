-- file: intro.lua
local intro = {}

--local center_x = love.graphics.getWidth()/2
local center_y = love.graphics.getHeight()/2

-- menu configuration
local menu = {
    "connect",
    "offline mode",
    "quit",
    }
local selected = 1

function intro.update(_dt)
    -- logic
end

function intro.draw()
    font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf",32)
    love.graphics.setFont(font)
    love.graphics.printf("D A M 4 G E", 0, (center_y -128), love.graphics.getWidth(), "center")
    for i, option in ipairs(menu) do
        if i == selected then
            love.graphics.printf("> " .. option, -16, (center_y - 32) + (i - 1)*32, love.graphics.getWidth(), "center")
        else
            love.graphics.printf(option, 0, (center_y - 32) + (i - 1) * 32, love.graphics.getWidth(), "center")
        end
    end
end

function intro.keypressed(key)
    if key == "up" then
        selected = math.max(1, selected - 1)
    elseif key == "down" then
        selected = math.min(#menu, selected+1)
    elseif key == "return" then
        if menu[selected] == "connect" then
            set_scene("connect")
        elseif menu[selected] == "offline mode" then
            set_scene("offline")
        elseif menu[selected] == "quit" then
            love.event.quit()
        end
    end
end

return intro
