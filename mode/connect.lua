-- file: connect.lua
local connect = {}
local enet = require("enet")
local overworld = require("lib.overworld")

local dots = ""
local timer = 0
local interval = 1 -- seconds

-- progress bar stuff
local progress_pct = 0
local progress_text = ""

-- text-drawing stuff
local text = "Connecting "
local function make_dots(dt)
    timer = timer + dt
    if timer >= interval then
        if #dots < 3 then
            dots = dots .. "."
        else
            dots = ""
        end
        timer = 0
    end
    return dots
end

local function text_offset()
    local offset = #dots * 8
    if #dots == 0 then
        return -8
    else
        return offset
    end
end

local function draw_progress(x, y, width, height)
    love.graphics.setFont(small_font)
    love.graphics.printf(progress_text, 0, y + 32, love.graphics.getWidth(), "center")
    love.graphics.setFont(normal_font)

    -- Draw bar background
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("line", x, y, width, height)

    -- Draw the progress
    local current_width = width * progress_pct
    love.graphics.rectangle("fill", x, y + 2, current_width, height - 4)
    love.graphics.setColor(1,1,1)

end

function connect.activate()
    print("Downloading schema")
    print("Loading protobuf schema..")
    progress_text = "Loading protobuf schema.."
    progress_pct = 0.10
    overworld.cache_schema("http://192.168.71.249:4433")
end

function connect.update(dt)
    text = "Connecting " .. make_dots(dt)
    if overworld.has_cached_schema() then
        print("Initializing Overworld connection")
        progress_text = "Initializing Overworld connection"
        progress_pct = 0.5
        if enet_client then
            print("Polling for initial events")
            progress_text = "Polling for initial events"
            progress_pct = 0.8
            local event = enet_client:service()
            if event then
                if event.type == "connect" then
                    if client_peer then
                        print("Sending session request")
                        progress_text = "Sending session request"
                        progress_pct = 0.9
                        overworld.hardcoded_session_request(client_peer)
                        set_mode("playing")
                    end
                end
            end
        else
            enet_client = enet.host_create()
            client_peer = enet_client:connect("192.168.71.249:4483")
            progress_text = "Peer state: " .. client_peer:state()
            print(progress_text)
            progress_pct = 0.7
        end
    end
end

function connect.draw()
    local cy = love.graphics.getHeight()/2
    local cx = love.graphics.getWidth()/2
    love.graphics.printf(text, text_offset(), cy - 32, love.graphics.getWidth(), "center")

    -- draw progress bar
    width = 200
    height = 20
    x = cx - (width/2)
    y = cy + 40
    draw_progress(x, y, width, height)
end

function connect.keypressed(key)
    if key == "escape" then
        current_mode = "intro"
    end
end

return connect
