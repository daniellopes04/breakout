--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Ball Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    Defines a ball that bounces back and forth between the sides of the screen, the player's
    paddle and the bricks laid out above the paddle. The ball will have a skin, which is a 
    color set at random just for visual variety.
]]

Ball = Class{}

function Ball:init(skin)
    -- Ball dimensions
    self.width = 8
    self.height = 8

    -- Ball velocity
    self.dx = 0
    self.dy = 0

    -- Ball color
    self.skin = skin
end

function Ball:collides(target)
    -- Simple AABB collision detection
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end

    -- If the above aren't true, the objects are overlapping
    return true
end

function Ball:resetToPaddle(paddle)
    self.x = paddle.x + (paddle.width / 2) - 4
    self.y = paddle.y - 8
end

function Ball:update(dt)
    -- Update ball position
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- If ball hits the walls, it bounces off
    if self.x <= 0 then
        self.x = 0
        self.dx = -self.dx
        gSounds["wall-hit"]:play()
    end

    if self.x >= VIRTUAL_WIDTH - 8 then
        self.x = VIRTUAL_WIDTH - 8
        self.dx = -self.dx
        gSounds["wall-hit"]:play()
    end

    if self.y <= 0 then
        self.y = 0
        self.dy = -self.dy
        gSounds["wall-hit"]:play()
    end
end

function Ball:render()
    love.graphics.draw(gTextures["main"], gFrames["balls"][self.skin], self.x, self.y)
end
