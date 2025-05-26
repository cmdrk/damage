-- file: main.lua

-- Global libraries
Class = require("lib.classic")
Tiny = require("lib.tiny")
--bump = require("lib.bump")
Slick = require("lib.slick")
Gamera = require("lib.gamera")

-- Global variables
---- Multiplayer
--enet_client = nil
--client_peer = nil

current_scene = nil

-- debug
--local debug_key = nil
local profiler = false

-- Scaling
MAP_SCALE = 64

-- World params
-- 32 tiles * 64px/tile
WORLD_X = 2048
WORLD_Y = 2048

-- Scenes
local scenes = {
    intro = require("src.scene.intro"),
    connect = require("src.scene.connect"),
    playing = require("src.scene.playing"),
    offline = require("src.scene.offline"),
}

function set_scene(scene)
    if current_scene then
        print("Deactivating scene: ", current_scene)
        if scenes[current_scene].deactivate then
            scenes[current_scene].deactivate()
        end
    end
    print("Changing scene: ", scene)
    current_scene = scene
    if scenes[current_scene].activate then
        scenes[current_scene].activate()
    end
end

function love.load()
    -- initialization
    NormalFont = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 32)
    SmallFont = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 16)
    love.graphics.setFont(NormalFont)

    -- change to intro scene
    set_scene("intro")
end

love.frame = 0
function love.update(dt)
    love.frame = love.frame + 1
    if profiler then
        if love.frame%100 == 0 then
            love.report = love.profiler.report(20)
            love.profiler.reset()
        end
    end
    require("lib.lurker").update()
    if scenes[current_scene].update then
        scenes[current_scene].update(dt)
    end
end

function love.draw()
    if scenes[current_scene].draw then
        scenes[current_scene].draw()
    end
    if profiler then
        love.graphics.setFont(SmallFont)
        love.graphics.print(love.report or "Please wait...")
        love.graphics.setFont(NormalFont)
    end
end


function love.keypressed(key)
    --debug_key = key
    if key == "escape" or key == "q" then
        set_scene("intro")
    end
    if key == "F4" then
        if not profiler then
            love.profiler = require('lib.profile')
            love.profiler.start()
            profiler = not profiler
        elseif profiler then
            love.profiler.stop()
            profiler = not profiler
        end
    end
    if scenes[current_scene].keypressed then
        scenes[current_scene].keypressed(key)
    end
end

function love.mousereleased(x,y, button)
    if scenes[current_scene].mousereleased then
        scenes[current_scene].mousereleased(x,y,button)
    end
end
