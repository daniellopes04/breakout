--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- ServeState Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04
    
    The state for when we are waiting to serve the ball.
]]

ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
    -- Grab the game state passed in params
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.level = params.level
    self.highScores = params.highScores
    self.recoverPoints = params.recoverPoints

    -- Initialize new ball with random color
    self.balls = {}
    table.insert(self.balls, Ball(math.random(7)))
end

function ServeState:update(dt)
    -- The ball moves with the paddle, until game starts
    self.paddle:update(dt)
    self.balls[1].x = self.paddle.x + (self.paddle.width / 2) - 4
    self.balls[1].y = self.paddle.y - 8

    -- The player starts the game
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        -- Pass the current state
        gStateMachine:change("play", {
            paddle = self.paddle,
            bricks = self.bricks,
            health = self.health,
            score = self.score,
            balls = self.balls,
            level = self.level,
            highScores = self.highScores,
            recoverPoints = self.recoverPoints
        })
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function ServeState:render()
    self.paddle:render()
    self.balls[1]:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("Level " .. tostring(self.level), 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, "center")
    love.graphics.setFont(gFonts["medium"])
    love.graphics.printf("Press Enter to serve!", 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, "center")
end