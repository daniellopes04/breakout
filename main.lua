--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Implementation of mobile game "Flappy Bird" --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
]]

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
        ["paddle-hit"] = love.audio.newSource("sounds/paddle_hit.wav", "static"),
        ["score"] = love.audio.newSource("sounds/score.wav", "static"),
        ["wall-hit"] = love.audio.newSource("sounds/wall_hit.wav", "static"),
        ["confirm"] = love.audio.newSource("sounds/confirm.wav", "static"),
        ["select"] = love.audio.newSource("sounds/select.wav", "static"),
        ["no-select"] = love.audio.newSource("sounds/no-select.wav", "static"),
        ["brick-hit-1"] = love.audio.newSource("sounds/brick-hit-1.wav", "static"),
        ["brick-hit-2"] = love.audio.newSource("sounds/brick-hit-2.wav", "static"),
        ["hurt"] = love.audio.newSource("sounds/hurt.wav", "static"),
        ["victory"] = love.audio.newSource("sounds/victory.wav", "static"),
        ["recover"] = love.audio.newSource("sounds/recover.wav", "static"),
        ["high-score"] = love.audio.newSource("sounds/high_score.wav", "static"),
        ["pause"] = love.audio.newSource("sounds/pause.wav", "static"),

        ["music"] = love.audio.newSource("sounds/music.wav", "static")
    }

    -- Quads that will be generated for all of the textures
    gFrames = {
        ["paddles"] = GenerateQuadsPaddles(gTextures["main"])
    }

    -- Setting up the screen
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- Initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ["start"] = function() return StartState() end,
        ["play"] = function() return PlayState() end
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

-- Renders the game to the screen
function love.draw()
    push:start()

    local brackgroundWidth = gTextures["background"]:getWidth()
    local brackgroundHeight = gTextures["background"]:getHeight()

    -- Scale factors used on x and y axis so it fills the screen
    love.graphics.draw(gTextures["background"], 0, 0, 0, 
        VIRTUAL_WIDTH / (brackgroundWidth - 1), VIRTUAL_HEIGHT / (brackgroundHeight - 1))

    gStateMachine:render()

    displayFPS()

    push:finish()
end

-- Renders the current FPS
function displayFPS()
    love.graphics.setFont(gFonts["small"])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print("FPS: ".. tostring(love.timer.getFPS()), 5, 5)
end
