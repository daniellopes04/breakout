--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Constants file --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    All the constants used throughout the game are initialized here.
]]

-- Real size of window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Window size emulated
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Paddle movement speed
PADDLE_SPEED = 200

-- Seed the random number generator function
love.math.setRandomSeed(os.time())