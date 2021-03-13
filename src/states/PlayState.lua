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

function PlayState:enter(params)
    -- Grab the game state passed in params
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.balls = params.balls
    self.level = params.level
    self.highScores = params.highScores
    self.recoverPoints = params.recoverPoints

    -- Initialize the ball velocity
    self.balls[1].dx = math.random(-200, 200)
    self.balls[1].dy = math.random(-50,-60)

    -- Initialize our powerups table
    self.powerups = {}

    -- Timer and time limit for a powerup to spawn
    self.timer = 0
    self.timeLimit = 5
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

    -- Generates random powerups at a interval of time
    self.timer = self.timer + dt

    if self.timer >= self.timeLimit then
        table.insert(self.powerups, Powerup(math.random(8)))

        self.timer = 0
        self.timeLimit = self.timeLimit + self.timeLimit * dt 
        - math.floor(self.score / self.recoverPoints * dt)
    end

    -- Checks for collision between powerup and paddle and apllies its effect
    for k, powerup in pairs(self.powerups) do
        -- Checks for collision between powerup and paddle
        if powerup:collides(self.paddle) then
            if powerup.type == 1 then
                -- Increase one life
                self.health = math.min(3, self.health + 1)

            elseif powerup.type == 2 then
                -- Inserts five new balls in table
                self:insertBalls(5)

            elseif powerup.type == 3 then
                -- Increase paddle size
                self.paddle:updateSize(1)

            elseif powerup.type == 4 then
                -- 1000 extra points
                self.score = self.score + 1000

            elseif powerup.type == 5 then

            elseif powerup.type == 6 then

            elseif powerup.type == 7 then
                -- Inserts two new balls in table
                self:insertBalls(2)

            elseif powerup.type == 8 then
            end
            gSounds["confirm"]:play()

            table.remove(self.powerups, k)
        end
    end

    -- Updates paddle and ball position
    self.paddle:update(dt)
    for k, ball in pairs(self.balls) do
        ball:update(dt)
    end

    -- Checks collision between ball and paddle
    for k, ball in pairs(self.balls) do
        if ball:collides(self.paddle) then
            --- 
            --- Tweaks angle of collision based on where the ball hits the paddle
            ---

            -- In case the ball goes below the paddle, raise its y position a little
            ball.y = self.paddle.y - 8

            -- Reverse dy, so it bounces off
            ball.dy = -ball.dy

            -- We want to tweak the angle of dx a little, based on where the ball hits the paddle
            -- If we hit the paddle on its left side while moving left...
            if ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.x < 0 then
                ball.dx = -50 + -(2 * (self.paddle.x + self.paddle.width / 2) - ball.x)

            -- If we hit the paddle on its right side while moving right...
            elseif ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.x > 0 then
                ball.dx = 50 + (2 * math.abs(self.paddle.x + self.paddle.width / 2) - ball.x)
            end

            gSounds["paddle-hit"]:play()
        end

        -- Checks all bricks for collision with ball
        for k, brick in pairs(self.bricks) do
            -- Only checks brick if it is in play
            if brick.inPlay and ball:collides(brick) then
                -- Add to score
                self.score = self.score + (brick.tier * 200 + brick.color * 25)

                -- Takes brick out of play
                brick:hit()

                -- If the player has enough points, recover a point of health
                if self.score > self.recoverPoints then
                    -- Can't go above 3 hearts
                    self.health = math.min(3, self.health + 1)

                    -- Increase paddle size when player gets enough points
                    if self.paddle.size < 4 then
                        self.paddle:updateSize(1)
                    end

                    -- Multiply points to recover by 2, with 100.000 limit
                    self.recoverPoints = math.min(100000, self.recoverPoints * 2)

                    gSounds["recover"]:play()
                end

                -- Go to victory screen if the player cleared all the bricks
                if self:checkVictory() then
                    gSounds["victory"]:play()

                    gStateMachine:change("victory", {
                        paddle = self.paddle,
                        bricks = self.bricks,
                        health = self.health,
                        score = self.score,
                        ball = self.balls[1],
                        level = self.level,
                        highScores = self.highScores,
                        recoverPoints = self.recoverPoints
                    })
                end

                -- Collision for bricks
                -- We check to see if the opposite side of our velocity is outside of the brick.
                -- Then we flip it and reset position outside of brick

                -- Left edge; only checks if we're moving right
                if ball.x + 2 < brick.x and ball.dx > 0 then
                    ball.dx = -ball.dx
                    ball.x = brick.x - ball.width

                -- Right edge; only check if we're moving left
                elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                    ball.dx = -ball.dx
                    ball.x = brick.x + brick.width

                -- Top edge; always check
                elseif ball.y < brick.y then
                    ball.dy = -ball.dy
                    ball.y = brick.y - ball.height

                -- Bottom edge; less likely to occur
                else
                    ball.dy = -ball.dy
                    ball.y = brick.y + brick.height
                end

                -- Slightly increases the y velocity to speed up the game
                -- Maximum velocity is +- 150
                if math.abs(ball.dy) < 150 then
                    ball.dy = ball.dy * 1.02
                end

                -- Break so it only allows the ball to collide with one brick at a time
                break
            end
        end
    end

    -- If ball goes below bounds, revert to serve state and decrease health
    if self:checkBalls() then
        self.health = self.health - 1
        gSounds["hurt"]:play()

        -- Decrease paddle size when player loses a life
        self.paddle:updateSize(-1)

        -- If health runs out then game over and if not, serve again
        if self.health == 0 then
            gStateMachine:change("game-over", {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change("serve", {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                level = self.level,
                highScores = self.highScores,
                recoverPoints = self.recoverPoints
            })
        end
    end

    -- For rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    -- For updating powerup position
    for k, powerup in pairs(self.powerups) do
        powerup:update(dt)
    end

    -- Clean powerups that are no longer in play
    self:checkPowerups()

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PlayState:render()
    -- Renders the objects
    self.paddle:render()

    -- Renders all bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- Renders all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    -- Renders powerup
    for k, powerup in pairs(self.powerups) do
        powerup:render()
    end

    -- Renders balls
    for k, ball in pairs(self.balls) do
        ball:render()
    end
    
    -- Renders score and health
    renderScore(self.score)
    renderHealth(self.health)

    -- Pause text
    if self.paused then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, "center")
    end
end

-- Checks if the player cleared all the bricks
function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end
    end

    return true
end

function PlayState:insertBalls(n)
    for i = 1, n do
        -- Inserts two new balls in table
        table.insert(self.balls, Ball(math.random(7)))
        
        -- Gets the size of table with two new balls
        local size = table.getn(self.balls)
        
        -- Sets the extra balls initial positions and random velocity
        self.balls[size].x = self.paddle.x + (self.paddle.width / 2) - 4
        self.balls[size].y = self.paddle.y - 8
        self.balls[size].dx = math.random(-200, 200)
        self.balls[size].dy = math.random(-50,-60)
    end
end

-- Checks if all the balls have gone below the paddle
function PlayState:checkBalls()
    local counter = 0
    local numBalls = table.getn(self.balls)

    for k, ball in pairs(self.balls) do
        if ball.y >= VIRTUAL_HEIGHT then
            counter = counter + 1
            table.remove(self.balls, k)
        end
    end

    if counter == numBalls then
        return true
    else
        return false
    end
end

-- Checks if the powerups have gone below the paddle
function PlayState:checkPowerups()
    for k, powerup in pairs(self.powerups) do
        if powerup.y >= VIRTUAL_HEIGHT then
            table.remove(self.powerups, k)
        end
    end
end