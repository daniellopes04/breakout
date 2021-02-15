--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- PlayState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    Represents the main portion of the game in which we are actively playing.
    The player controls the paddle, with the ball bouncing around between the bricks,
    walls and the paddle itself. If the ball goes below the paddle, then the player 
    should lose one point of health and be taken either to the Game Over screen if 
    at 0 health or the Serve screen otherwise.
]]

PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()

    -- If the paddle is paused
    self.paused = false
end

function PlayState:update(dt)
    -- Pause game
    if self.paused then
        if love.keyboard.wasPressed("space") then
            self.paused = false
            gSounds["pause"]:play()
        else
            return
        end
    elseif love.keyboard.wasPressed("space") then
        self.paused = true
        gSounds["pause"]:play()
        return
    end

    -- Updates paddle position
    self.paddle:update(dt)

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PlayState:render()
    self.paddle:render()

    -- Pause text
    if self.paused then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH / 2 - 16)
    end
end