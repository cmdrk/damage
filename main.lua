-- file: main.lua

-- Global libraries
class = require("lib.classic")
tiny = require("lib.tiny")
bump = require("lib.bump")

-- Global variables
---- Multiplayer
enet_client = nil
client_peer = nil
current_scene = nil

-- debug
debug_key = nil
profiler = false

-- Scaling
MAP_SCALE = 64

-- Camera
local gamera = require("lib.gamera")
cam = gamera.new(0,0,2048,2048) -- 32 tiles * 64px/tile

-- Collision
collision = bump.newWorld(64)

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
    normal_font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 32)
    small_font = love.graphics.newFont("assets/Px437_EagleSpCGA_Alt2-2y.ttf", 16)
    love.graphics.setFont(normal_font)

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
        love.graphics.setFont(small_font)
        love.graphics.print(love.report or "Please wait...")
        love.graphics.setFont(normal_font)
    end
end

function love.keypressed(key)
    debug_key = key
    if key == "escape" or key == "q" then
        set_scene("intro")
    end
    if key == "p" then
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
