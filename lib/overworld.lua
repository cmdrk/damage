-- This module handles all connection with Overworld via ENet
local overworld = {}

local https = require("https")
local json = require("lib.JSON")
local protoc = require("lib.protoc")
local pb = require("pb")

-- Enet setup
--local enet_client
--local client_peer
local proto_schemas

-- Protobuf setup
local p = protoc.new()

-- Internal functions

local function decode_packet(prefix, data)
  local app = proto_schemas[prefix].app
  local d = pb.decode(app .. "." .. app, data)
  return d
end

function overworld.receive(packet)
  -- Grab the first two bytes to determine the type
  local prefix = tostring(string.byte(packet, 2))
  local rest = string.sub(packet, 3)
  return decode_packet(prefix, rest)
end

function load_protos()
  for _prefix, schema in pairs(proto_schemas) do
    p:load(schema.proto)
  end
end

-- Exported functions
function overworld.cache_schema(url)
  local full_url = url .. "/client"
  local code, body = https.request(full_url)
  if code == 200 then
    local schema = json:decode(body)
    proto_schemas = schema
  end
  load_protos()
end

function overworld.hardcoded_session_request(client_peer)
  if client_peer then
    local handshake = string.char(0, 100, 10, 0)
    client_peer:send(handshake)
  end
end

--function overworld.maybe_receive_data()
--  if enet_client then
--    local event = enet_client:service()
--    if event.type == "connect" then
--      hardcoded_session_request()
--    elseif event.type == "receive" then
--      receive(event.data)
--    end
--  end
--end

--function overworld.setup_enet(url)
--  enet_client = enet.host_create()
--  client_peer = enet_client:connect(url)
--end

function overworld.has_cached_schema()
    if proto_schemas then
        return true
    else
        return false
    end
end

return overworld
