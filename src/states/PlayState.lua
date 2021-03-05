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
    -- Initialize the paddle sets it as not paused
    self.paddle = Paddle()

    self.paused = false

    -- Initialize the ball and its position, velocity and skin
    self.ball = Ball(math.random(7))

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50,-60)

    self.ball.x = VIRTUAL_WIDTH / 2 - 4
    self.ball.y = VIRTUAL_HEIGHT - 42

    -- Use the createMap function to generate a brick table
    self.bricks = LevelMaker.createMap()
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

    -- Updates paddle and ball position
    self.paddle:update(dt)
    self.ball:update(dt)

    -- Checks collision between ball and paddle
    if self.ball:collides(self.paddle) then
        -- In case the ball goes below the paddle, raise its y position a little
        self.ball.y = self.paddle.y - 8

        -- Reverse dy, so it bounces off
        self.ball.dy = -self.ball.dy

        -- We want to tweak the angle of dx a little, based on where the ball hits the paddle
        -- If we hit the paddle on its left side while moving left...
        if self.ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.x < 0 then
            self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2) - self.ball.x)

        -- If we hit the paddle on its right side while moving right...
        elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.x > 0 then
            self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2) - self.ball.x)
        end

        gSounds["paddle-hit"]:play()
    end

    -- Checks all bricks for collision with ball
    for k, brick in pairs(self.bricks) do
        -- Only checks brick if it is in play
        if brick.inPlay and self.ball:collides(brick) then
            -- Takes brick out of play
            brick:hit()

            -- Collision for bricks
            -- We check to see if the opposite side of our velocity is outside of the brick.
            -- Then we flip it and reset position outside of brick

            -- Left edge; only checks if we're moving right
            if self.ball.x + 2 < brick.x and self.ball.dx > 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - self.ball.width

            -- Right edge; only check if we're moving left
            elseif self.ball.x + 6 > brick.x + brick.width and self.ball.dx < 0 then
                self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + brick.width

            -- Top edge; always check
            elseif self.ball.y < brick.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - self.ball.height

            -- Bottom edge; less likely to occur
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + brick.height
            end

            -- Slightly increases the y velocity to speed up the game
            -- Maximum velocity is +- 150
            if math.abs(self.ball.dy) < 150 then
                self.ball.dy = self.ball.dy * 1.02
            end

            -- Break so it only allows the ball to collide with one brick at a time
            break
        end
    end

    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    end
end

function PlayState:render()
    -- Renders the objects
    self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- Pause text
    if self.paused then
        love.graphics.setFont(gFonts["large"])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH / 2 - 16)
    end
end