--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- StartState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    The state for when the game starts.
]]

StartState = Class{__includes = BaseState}

-- Indicates if we're highlighting the text for "Start" or "High Scores"
local highlighted = 1

function StartState:update(dt)
    if love.keyboard.wasPressed("up") or love.keyboard.wasPressed("down") then
        highlighted = highlighted == 1 and 2 or 1
        gSounds["paddle-hit"]:play()
    end

    -- If enter is pressed, proceeds to state
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change("serve", {
                paddle = Paddle(1),
                bricks = LevelMaker.createMap(1),
                health = 3,
                score = 0,
                level = 1
            })
        else
            --gStateMachine:change('high-scores')
        end
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts["large"])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")

    love.graphics.setFont(gFonts["medium"])

    -- If 1 is highlighted, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, "center")

    -- Reset color
    love.graphics.setColor(1, 1, 1, 1)

    -- If 1 is highlighted, render that option blue
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, "center")

    -- Reset color
    love.graphics.setColor(1, 1, 1, 1)
end