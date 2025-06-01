local damage = {}

-- Global libs
Class = require("lib.classic")
Tiny = require("lib.tiny")
Slick = require("lib.slick")

-- Constants
WORLD_X = 2048
WORLD_Y = 2048
MAP_SCALE = 64

-- Setup collision system
local collision = Slick.newWorld(WORLD_X, WORLD_Y)
_G.collision = collision

-- Setup ECS
local ecs = Tiny.world(
                require("src.system.controller"),
                require("src.system.physics"),
                require("src.system.render"),
                require("src.system.cleaner")
            )
_G.ecs = ecs

return damage
