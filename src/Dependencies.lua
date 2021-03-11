--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Dependencies file --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    All the dependencies, including libraries and classes are loaded here.
]]

-- Push library
-- https://github.com/Ulydev/push
push = require "lib/push"

-- Class library
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "lib/class"

-- All the constants centralized
require "src/constants"

-- Game classes
require "src/Util"
require "src/Paddle"
require "src/Ball"
require "src/Brick"
require "src/LevelMaker"

-- State machine and the game states
require "src/StateMachine"
require "src/states/BaseState"
require "src/states/StartState"
require "src/states/PlayState"
require "src/states/ServeState"
require "src/states/GameOverState"
require "src/states/VictoryState"
require "src/states/HighScoresState"
require "src/states/EnterHighScoreState"