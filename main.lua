-- file: main.lua

-- Global libraries
Class = require("lib.classic")
Tiny = require("lib.tiny")
Slick = require("lib.slick")
Gamera = require("lib.gamera")

-- Constants
require("constants")

-- Global variables
---- Multiplayer
--enet_client = nil
--client_peer = nil

local current_scene

-- debug
--local debug_key = nil
local profiler = false

-- Scenes
local scenes = {
    intro = require("intro"),
    connect = require("connect"),
    playing = require("playing"),
    offline = require("offline"),
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

function love.run()
    if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

    -- Fixed timestep configuration
    local fixed_dt = 1/20  -- 20 FPS fixed timestep
    local accumulator = 0
    local current_time = love.timer.getTime()

    return function()
        -- Process events
        if love.event then
            love.event.pump()
            for name, a, b, c, d, e, f in love.event.poll() do
                if name == "quit" then
                    if not love.quit or not love.quit() then
                        return a or 0
                    end
                end
                love.handlers[name](a, b, c, d, e, f)
            end
        end

        -- Calculate frame time
        local new_time = love.timer.getTime()
        local frame_time = new_time - current_time
        current_time = new_time

        -- Prevent spiral of death (limit frame time)
        frame_time = math.min(frame_time, 0.04) -- Max 40ms frame time

        -- Add frame time to accumulator
        accumulator = accumulator + frame_time

        -- Update with fixed timestep
        while accumulator >= fixed_dt do
            if love.update then
                love.update(fixed_dt)  -- Always pass fixed timestep
            end
            accumulator = accumulator - fixed_dt
        end

        -- Render with interpolation factor (optional)
        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            if love.draw then
                -- Optional: pass interpolation factor for smooth rendering
                local alpha = accumulator / fixed_dt
                love.draw(alpha)
            end

            love.graphics.present()
        end

        if love.timer then love.timer.sleep(0.001) end
    end
end


function love.draw(alpha)
    if scenes[current_scene].draw then
        scenes[current_scene].draw(alpha)
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
