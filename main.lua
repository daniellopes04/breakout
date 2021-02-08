--[[
    Part of "S50's Intro to Game Development"
    Lecture 1
    
    -- Implementation of mobile game "Flappy Bird" --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
]]

-- Push library
-- https://github.com/Ulydev/push
push = require "lib/push"

-- Class library
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require "lib/class"

require "src/Dependencies"

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.window.setTitle("Breakout")

    -- Seed the random number generator function
    love.math.setRandomSeed(os.time())

    -- Loads the fonts used in the game
    gFonts = {
        ["small"] = love.graphics.newFont("fonts/font.ttf", 8),
        ["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
        ["large"] = love.graphics.newFont("fonts/font.ttf", 32)
    }
    love.graphics.setFont(gFonts["small"])

    -- Loads the textures used in the game
    gTextures = {
        ["background"] = love.graphics.newImage("graphics/background.png"),
        ["main"] = love.graphics.newImage("graphics/breakout.png"),
        ["arrows"] = love.graphics.newImage("graphics/arrows.png"),
        ["hearts"] = love.graphics.newImage("graphics/hearts.png"),
        ["particle"] = love.graphics.newImage("graphics/particle.png")
    }

    -- Loads the sounds used in the game
    gSounds = {
        ["paddle-hit"] = love.audio.newSource("sounds/paddle-hit.wav"),
        ["score"] = love.audio.newSource("sounds/score.wav"),
        ["wall-hit"] = love.audio.newSource("sounds/wall-hit.wav"),
        ["confirm"] = love.audio.newSource("sounds/confirm.wav"),
        ["select"] = love.audio.newSource("sounds/select.wav"),
        ["no-select"] = love.audio.newSource("sounds/no-select.wav"),
        ["brick-hit-1"] = love.audio.newSource("sounds/brick-hit-1.wav"),
        ["brick-hit-2"] = love.audio.newSource("sounds/brick-hit-2.wav"),
        ["hurt"] = love.audio.newSource("sounds/hurt.wav"),
        ["victory"] = love.audio.newSource("sounds/victory.wav"),
        ["recover"] = love.audio.newSource("sounds/recover.wav"),
        ["high-score"] = love.audio.newSource("sounds/high-score.wav"),
        ["pause"] = love.audio.newSource("sounds/pause.wav"),

        ["music"] = love.audio.newSource("sounds/music.wav")
    }

    -- Setting up the screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- Initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ["start"] = function() return TitleScreenState() end
    }
    gStateMachine:change("start")

    -- Keeps track of the keys pressed by the user
    love.keyboard.keysPressed = {}
end

-- Called when the screen is resized
function love.resize(w, h)
    push:resize(w, h)
end

-- Keyboard entry handler
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

-- Used to check if a key was pressed in the last frame
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

-- Updates the game state components
function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end


