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

-- Color pallete to be used with particle systems
palleteColors = {
    -- Blue
    [1] = {
        ["r"] = 99/255,
        ["g"] = 155/255,
        ["b"] = 1
    },
    -- Green
    [2] = {
        ["r"] = 186/255,
        ["g"] = 190/255,
        ["b"] = 47/255
    },
    -- Red
    [3] = {
        ["r"] = 217/255,
        ["g"] = 87/255,
        ["b"] = 99/255
    },
    -- Purple
    [4] = {
        ["r"] = 215/255,
        ["g"] = 123/255,
        ["b"] = 186/255
    },
    -- Gold
    [5] = {
        ["r"] = 251/255,
        ["g"] = 242/255,
        ["b"] = 54/255
    },
    --Gray
    [6] = {
        ["r"] = 35/255,
        ["g"] = 35/255,
        ["b"] = 35/255
    }
}

function Brick:init(x, y)
    -- Set brick color and tier
    self.tier = 0
    self.color = 1

    -- If the brick is locked
    self.locked = false
    
    -- Set brick position and dimensions
    self.x = x
    self.y = y
    self.width = 32
    self.height = 16
    
    -- Defines if a brick is in play or not, to be rendered
    self.inPlay = true

    -- Defines the brick's particle system, emitted on hit
    self.psystem = love.graphics.newParticleSystem(gTextures["particle"], 64)

    -- Particle system behavior functions
    self.psystem:setParticleLifetime(0.5, 1)            -- lasts between 0.5 and 1 second
    self.psystem:setLinearAcceleration(-15, 0, 15, 80)  -- gives acceleration 
    self.psystem:setEmissionArea("normal", 10, 10, 1, true)        -- spread of particles
end

function Brick:hit(damage)
    -- Over the particle's lifetime, we transition from first to second color
    self.psystem:setColors(
        -- First color is brick color with variyng alpha (brighter for highter tiers)
        palleteColors[self.color].r,
        palleteColors[self.color].g,
        palleteColors[self.color].b,
        0.25 * (self.tier + 1),
        -- Second color is brick color with alpha zero (transparent)
        palleteColors[self.color].r,
        palleteColors[self.color].g,
        palleteColors[self.color].b,
        0
    )

    -- Emits 64 particles
    self.psystem:emit(64)

    -- Sound when hit
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
            self.color = math.max(1, self.color - damage)
        end
    elseif self.color == 6 then
        self.tier = 3
        self.color = math.max(1, self.color - damage)
    else
        -- If we're in the first tier and the base color, remove brick
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = math.max(1, self.color - damage)
        end
    end

    -- Second layer of sound if the brick is destroyed
    if not self.inPlay then
        gSounds["brick-hit-1"]:stop()
        gSounds["brick-hit-1"]:play()
    end
end

function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:render()
    if self.inPlay then
        if self.locked then
            love.graphics.draw(gTextures["main"], gFrames["bricks"][24], self.x, self.y)
        else
            -- Multiply color by 4 (-1) to get our color offset, then add tier
            -- This is done to draw the correct tier and color brick onto the screen
            love.graphics.draw(gTextures["main"], 
            gFrames["bricks"][1 + ((self.color - 1) * 4) + self.tier], self.x, self.y)
        end
    end
end

-- Separate function for the particle system so it is called after all bricks are drawn
-- Otherwise, some bricks would render other bricks' particle systems
function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end