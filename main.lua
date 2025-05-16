-- file: main.lua

-- Global libraries
class = require("lib.classic")
tiny = require("lib.tiny")

-- Global variables
---- Multiplayer
enet_client = nil
client_peer = nil
current_scene = nil

-- debug
debug_key = nil

-- Scenes
local scenes = {
    intro = require("src.scene.intro"),
    connect = require("src.scene.connect"),
    playing = require("src.scene.playing"),
    offline = require("src.scene.offline"),
}

function set_scene(scene)
    print("Changing scene: ", scene)
    current_scene = scene
    if scenes[current_scene].activate then
        scenes[current_scene].activate()
    end
end

function love.load()
    -- initialization
    normal_font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 32)
    small_font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 16)
    love.graphics.setFont(normal_font)
    love.window.setVSync(1)

    -- change to intro scene
    set_scene("intro")
end


function love.update(dt)
    require("lib.lurker").update()
    if scenes[current_scene].update then
        scenes[current_scene].update(dt)
    end
end

function love.draw()
    if scenes[current_scene].draw then
        scenes[current_scene].draw()
    end
end

function love.keypressed(key)
    debug_key = key
    if key == "escape" or key == "q" then
        set_scene("intro")
    end
    if scenes[current_scene].keypressed then
        scenes[current_scene].keypressed(key)
    end
end
