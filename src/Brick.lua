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
    gSounds["brick-hit-2"]:play()

    -- If the brick is hit, it should dissapear from screen
    self.inPlay = false
end

function Brick:render()
    if self.inPlay then
        -- Multiply color by 4 (-1) to get our color offset, then add tier
        -- This is done to draw the correct tier and color brick onto the screen
        love.graphics.draw(gTextures["main"], 
        gFrames["bricks"][1 + ((self.color - 1) * 4) + self.tier], self.x, self.y)
    end
end