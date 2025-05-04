-- file: main.lua

enet_client = nil
client_peer = nil
current_mode = nil
local modes = {
    intro = require("mode.intro"),
    connect = require("mode.connect"),
    playing = require("mode.playing")
}

function set_mode(mode)
    print("Changing mode: ", mode)
    current_mode = mode
    if modes[current_mode].activate then
        modes[current_mode].activate()
    end
end

function love.load()
    -- initialization
    normal_font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 32)
    small_font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 16)
    love.graphics.setFont(normal_font)

    -- change to intro mode
    set_mode("intro")
end

function love.update(dt)
    require("lib.lurker").update()
    if modes[current_mode].update then
        modes[current_mode].update(dt)
    end
end

function love.draw()
    if modes[current_mode].draw then
        modes[current_mode].draw()
    end
end

function love.keypressed(key)
    if modes[current_mode].keypressed then
        modes[current_mode].keypressed(key)
    end
end
