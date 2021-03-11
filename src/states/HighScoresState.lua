--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- HighScoresState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    The state that shows a screen where we can view all high scores previously recorded.
]]

HighScoresState = Class{__includes = BaseState}

function HighScoresState:enter(params)
    -- Grab the game state passed in params
    self.highScores = params.highScores
end

function HighScoresState:update(dt)
    -- Return to start screen
    if love.keyboard.wasPressed("escape") then
        gSounds["wall-hit"]:play()
        
        gStateMachine:change("start", {
            highScores = self.highScores
        })
    end
end

function HighScoresState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("High Scores", 0, 20, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(gFonts["medium"])
    -- Iterate over our high scores table
    for i = 1, 10 do
        local name = self.highScores[i].name or "---"
        local score = self.highScores[i].score or "---"

        -- High score number, name and the score itself
        love.graphics.printf(tostring(i) .. ".", VIRTUAL_WIDTH / 4, 60 + i * 13, 50, "left")
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 60 + i * 13, 50, "right")
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2, 60 + i * 13, 100, "right")
    end

    -- Instructions
    love.graphics.setFont(gFonts["small"])
    love.graphics.printf("Press Escape to return to the main menu.", 0, VIRTUAL_HEIGHT - 18,
        VIRTUAL_WIDTH, "center")
end