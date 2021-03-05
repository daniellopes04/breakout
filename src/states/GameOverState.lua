--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- GameOverState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    The state in which the player lost all health and gets their score displayed on the
    screen. If the player's score is higher than the stored high score then we proceed
    to EnterHighScoreState, and if not, we go back to StartState.
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    -- Grab the game state passed in params
    self.score = params.score
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("start")
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("GAME OVER", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf("Final Score:" .. tostring(self.score), 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, "center")
    love.graphics.printf("Press Enter!:", 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, "center")
end