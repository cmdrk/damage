-- External Libs
Slick = require("lib.slick")
Class = require("lib.classic")
Tiny = require("lib.tiny")

-- Global constants
require("constants")

-- Setup ECS systems
local ecs = Tiny.world(
                require("src.system.physics"),
                require("src.system.cleaner")
            )
_G.ecs = ecs

-- Setup world for collision system
local collision = Slick.newWorld(WORLD_X, WORLD_Y)
_G.collision = collision
