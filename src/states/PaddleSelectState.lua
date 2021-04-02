--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- PaddleSelectState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    The state that allows the player to select which paddle color they want.
]]

PaddleSelectState = Class{__includes = BaseState}

function PaddleSelectState:init()
    -- The paddle we're highlighting
    -- Will be passed to the ServeState
    self.currentPaddle = 1
end

function PaddleSelectState:enter(params)
    -- Grab the game state passed in params
    self.highScores = params.highScores
end

function PaddleSelectState:update(dt)
    -- Switches between paddles
    if love.keyboard.wasPressed("left") then
        if self.currentPaddle == 1 then
            gSounds["no-select"]:play()
        else
            gSounds["select"]:play()
            self.currentPaddle = self.currentPaddle - 1
        end
    elseif love.keyboard.wasPressed("right") then
        if self.currentPaddle == 4 then
            gSounds["no-select"]:play()
        else
            gSounds["select"]:play()
            self.currentPaddle = self.currentPaddle + 1
        end
    end

    -- If enter is pressed, proceeds to another state
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        gStateMachine:change("serve", {
            paddle = Paddle(self.currentPaddle),
            bricks = LevelMaker.createMap(1),
            health = 3,
            score = 0,
            level = 1,
            highScores = self.highScores,
            recoverPoints = 5000,
            lockedInGame = false
        })    
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PaddleSelectState:render()
    -- Instructions
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf("Select your paddle!", 0, VIRTUAL_HEIGHT / 4, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(gFonts["small"])
    love.graphics.printf("Press Enter to confirm.", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, "center")

    -- Renders left arrow normally if current paddle isn't the first
    -- If it's the first, render it a little faded so it shows there's no more to the left
    if self.currentPaddle == 1 then
        -- Tint with a dark grey and half the opacity
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    -- Draws left arrow
    love.graphics.draw(gTextures["arrows"], gFrames["arrows"][1], VIRTUAL_WIDTH / 4 - 24, 
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3)

    -- Resets drawing color
    love.graphics.setColor(1, 1, 1, 1)

    -- Renders right arrow normally if current paddle isn't the last
    -- If it's the last, render it a little faded so it shows there's no more to the right
    if self.currentPaddle == 4 then
        -- Tint with a dark grey and half the opacity
        love.graphics.setColor(40/255, 40/255, 40/255, 128/255)
    end

    -- Draws right arrow
    love.graphics.draw(gTextures["arrows"], gFrames["arrows"][2], VIRTUAL_WIDTH - VIRTUAL_WIDTH / 4, 
        VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3)

    -- Resets drawing color
    love.graphics.setColor(1, 1, 1, 1)

    -- Renders the paddle
    love.graphics.draw(gTextures["main"], gFrames["paddles"][2 + 4 * (self.currentPaddle - 1)], 
    VIRTUAL_WIDTH / 2 - 32, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3)
end