--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Brick Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    Defines a brick that the ball can collide with. Once the ball collides with a brick, 
    the player scores a point and the ball will bounce away. Different colored bricks have 
    different point values. When all the bricks are cleared in the current map, the player 
    should be taken to a new layout of bricks.
]]

Brick = Class{}

function Brick:init(x, y)
    -- Set brick color and tier
    self.tier = 0
    self.color = 1
    
    -- Set brick position and dimensions
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    
    -- Defines if a brick is in play or not, to be rendered
    self.inPlay = true
end

function Brick:hit()
    gSounds["brick-hit-2"]:stop()
    gSounds["brick-hit-2"]:play()

    -- We cycle through the colors when the brick is hit
    -- Once the cycle is complete, we go down a tier
    -- When we reach the lowest tier and lowest color, the brick is removed
    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color - 1
        end
    else
        -- If we're in the first tier and the base color, remove brick
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end

    -- Second layer of sound if the brick is destroyed
    if not self.inPlay then
        gSounds["brick-hit-1"]:stop()
        gSounds["brick-hit-1"]:play()
    end
end

function Brick:render()
    if self.inPlay then
        -- Multiply color by 4 (-1) to get our color offset, then add tier
        -- This is done to draw the correct tier and color brick onto the screen
        love.graphics.draw(gTextures["main"], 
        gFrames["bricks"][1 + ((self.color - 1) * 4) + self.tier], self.x, self.y)
    end
end