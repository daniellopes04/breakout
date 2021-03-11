--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- VictoryState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    Represents the state that the game is in when we've just completed a level.
    Very similar to the ServeState, except here we increment the level.
]]

VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
    -- Grab the game state passed in params
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.level = params.level
    self.highScores = params.highScores
end

function VictoryState:update(dt)
    -- The ball moves with the paddle, until game starts again
    self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

    -- The player starts the game
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        -- Pass the current state
        gStateMachine:change("serve", {
            paddle = self.paddle,
            bricks = LevelMaker.createMap(self.level + 1),
            health = self.health,
            score = self.score,
            level = self.level + 1,
            highScores = self.highScores
        })
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function VictoryState:render()
    self.ball:render()
    self.paddle:render()

    renderScore(self.score)
    renderHealth(self.health)

    -- Level complete
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("Level " .. tostring(self.level) .. " complete!", 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, "center")

    -- Instructions
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf("Press Enter to next level!", 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, "center")
end