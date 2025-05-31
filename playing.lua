-- file: playing.lua
local overworld = require("lib.overworld")
--local serpent = require("lib.serpent")
local inspect = require("lib.inspect")
local playing = {}

local current_data
local text = ""

function playing.update(_dt)
    if enet_client then
        local event = enet_client:service()
        if event then
            if event.type == "receive" then
                current_data = overworld.receive(event.data)
            end
        end
    end
end

function playing.draw()
    love.graphics.setFont(small_font)
    if current_data then
        t = inspect(current_data["msg"])
        text = text .. '\n' .. t
        current_data = nil
    end
    love.graphics.printf("Received: " .. text, 0, 0, love.graphics.getWidth(), "left")
end

function playing.keypressed(_key)
end

return playing
