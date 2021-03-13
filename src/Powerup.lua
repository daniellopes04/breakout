--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Powerup Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    Defines a powerup that the player can get during the game. This powerup should spawn randomly on a timer
    and the effects depend on the type. The powerup will take effect when the paddle collides with it.

    Powerup types:
        1 - 
        2 - 
        3 - Gain extra heart
        4 - 
        5 - 
        6 - 
        7 - 
        8 - 
        9 - Adds two extra balls to the game
        10 - 
]]

Powerup = Class{}

function Powerup:init(type)
    -- Powerup sprite dimensions
    self.width = 16
    self.height = 16

    -- Powerup velocity
    self.dx = 0
    self.dy = 10

    -- Defines the type of the powerup
    self.type = type

    -- Coordinates where the powerup will spawn
    self.x = math.random(0, VIRTUAL_WIDTH - 16)
    self.y = -1

    -- Defines if the powerup is in game or not
    -- self.inPlay = false
end

function Powerup:collides(target)
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

function Powerup:update(dt)
    -- Update powerup position
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    self.dy = self.dy + self.y * dt
end

function Powerup:render()
    love.graphics.draw(gTextures["main"], gFrames["powerups"][self.type], self.x, self.y)
end