--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Paddle Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    Defines a paddle that can move left and right. It deflects the ball in the main game 
    and if the ball passes the paddle, the player loses a heart. The player can select the 
    paddle skin upon starting the game.
]]

Paddle = Class{}

function Paddle:init(skin)
    -- Initializes x and y to place the paddle on the lower middle of screen
    self.x = VIRTUAL_WIDTH / 2 - 32
    self.y = VIRTUAL_HEIGHT - 32

    -- Starts with no velocity
    self.dx = 0

    -- Paddle's dimensions
    self.width = 64
    self.height = 16

    -- Paddle color
    self.skin = skin

    -- Starts with medium paddle size
    self.size = 2
end

function Paddle:update(dt)
    -- Paddle movement
    if love.keyboard.isDown("left") then 
        self.dx = - PADDLE_SPEED
    elseif love.keyboard.isDown("right") then 
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    -- Updates paddle position, ensuring that it stays on screen
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(gTextures["main"], gFrames["paddles"][self.size + 4 * (self.skin - 1)],
        self.x, self.y)
end

function Paddle:updateSize(rate)
    if (rate < 0 and self.size > 1) or (rate >= 1 and self.size < 4) then
        self.size = self.size + rate
        self.width = self.width + 32 * rate

        self.x = self.x - 16 * rate
    end
end