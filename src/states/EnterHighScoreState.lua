--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- EnterHighScoreState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    The state that shows a screen where the player can input a new high score in the form of three
    characters, like an arcade game.
]]

EnterHighScoreState = Class{__includes = BaseState}

-- Individual chars of our string
local chars = {
    [1] = 65,
    [2] = 65,
    [3] = 65
}

-- Character currently changing
local highlightedChar = 1

function EnterHighScoreState:enter(params)
    -- Grab the game state passed in params
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:update(dt)
    -- Enters new high score and returns to high score screen
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gSounds['confirm']:play()
        
        -- Update our high scores table with new high score
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3])

        -- Go backwards throufh high scores table until this score, shifting scores
        for i = 10, self.scoreIndex, -1 do 
            self.highScores[i + 1] = {
                name = self.highScores[i].name,
                score = self.highScores[i].score
            }
        end

        -- Insert new high score
        self.highScores[self.scoreIndex].name = name
        self.highScores[self.scoreIndex].score = self.score

        -- Write scores to high score file
        local scoresStr = ""

        for i = 1, 10 do
            scoresStr = scoresStr .. self.highScores[i].name .. "\n"
            scoresStr = scoresStr .. tostring(self.highScores[i].score) .. "\n"
        end

        love.filesystem.write("breakout.lst", scoresStr)

        gStateMachine:change("high-scores", {
            highScores = self.highScores
        })
    end

    -- Scroll through character slots
    if love.keyboard.wasPressed("left") and highlightedChar > 1 then
        highlightedChar = highlightedChar - 1
        gSounds["select"]:play()
    elseif love.keyboard.wasPressed("right") and highlightedChar < 3 then
        highlightedChar = highlightedChar + 1
        gSounds["select"]:play()
    end

    -- Scroll through characters
    if love.keyboard.wasPressed("up") then
        chars[highlightedChar] = chars[highlightedChar] + 1
        if chars[highlightedChar] > 90 then
            chars[highlightedChar] = 65
        end
    elseif love.keyboard.wasPressed("down") then
        chars[highlightedChar] = chars[highlightedChar] - 1
        if chars[highlightedChar] < 65 then
            chars[highlightedChar] = 90
        end
    end
end

function EnterHighScoreState:render()
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf("NEW HIGH SCORE!", 0, 30, VIRTUAL_WIDTH, "center")
    love.graphics.printf("Your score: " .. tostring(self.score), 0, 60, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(gFonts["large"])
    -- Renders all three characters
    if highlightedChar == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[1]), VIRTUAL_WIDTH / 2 - 28, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[2]), VIRTUAL_WIDTH / 2 - 6, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 3 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[3]), VIRTUAL_WIDTH / 2 + 16, VIRTUAL_HEIGHT / 2)
    love.graphics.setColor(1, 1, 1, 1)

    -- Instructions
    love.graphics.setFont(gFonts["small"])
    love.graphics.printf("Press Enter to confirm.", 0, VIRTUAL_HEIGHT - 18,
        VIRTUAL_WIDTH, "center")
end