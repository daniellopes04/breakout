--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- LevelMaker Class --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    Creates randomized levels for our game. Returns a table of bricks to be rendered based 
    on the current game level.
]]

LevelMaker = Class{}

-- Patterns used to make the map a certain shape
NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

-- Row patterns
SOLID = 1       -- All colors are the same
ALTERNATE = 2   -- Colors alternate
SKIP = 3        -- Skip every other block
NONE = 4        -- No blocks

-- Creates a brick table with different possible ways of randomizing rows and columns of bricks
-- Calculates the brick colors and tiers to choose based on the level passed in 
function LevelMaker.createMap(level)
    local bricks = {}

    -- Randomly sets the number of rows and cols
    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)
    
    -- The number os columns must be odd to keep things symmetric
    numCols = numCols % 2 == 0 and (numCols + 1) or numCols

    -- Highest possible spawned brick color on this level
    -- Maximum is 3
    local highestTier = math.min(3, math.floor(level / 5))

    -- Highest color of the highest tier
    local highestColor = math.min(5, level % 5 + 3)

    -- Count the number of bricks
    local counter = 0

    -- Lay out bricks such that they touch each other and fill the screen
    for y = 1, numRows do
        -- Whether we want to enable skipping for this row
        local skipPattern = math.random(1, 2) == 1 and true or false

        -- Wheter we want to enable alternating for this row
        local alternatePattern = math.random(1, 2) == 1 and true or false

        -- Generates the colors to alternate between
        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)

        -- Used when we want to skip a block, for skip pattern
        local skipFlag = math.random(2) == 1 and true or false

        -- Used when we want to alternate a block, for alternatePattern
        local alternateFlag = math.random(2) == 1 and true or false

        -- Solid color if we're not alternating
        local solidColor = math.random(1, highestColor)
        local solidTier = math.random(1, highestTier)

        for x = 1, numCols do
            -- If skipping is on and we're on a skipped block
            if skipPattern and skipFlag then
                -- Turn skipping off for the next iteration
                skipFlag = not skipFlag

                -- Skips this block
                goto continue
            else
                -- Turn skipping on for the next block
                skipFlag = not skipFlag
            end

            b = Brick(
                -- x-coordinate
                (x-1)                   -- decrement x by 1 because tables are 1-indexed, coords are 0
                * 32                    -- multiply by 32, the brick width
                + 8                     -- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
                + (13 - numCols) * 16,  -- left-side padding for when there are fewer than 13 columns
                
                -- y-coordinate
                y * 16                  -- just use y * 16, since we need top padding anyway
            )

            -- If alternating is on, changes the brick color and tier
            -- Turns on/off alternating for the next iteration
            if alternatePattern and alternateFlag then
                b.color = alternateColor1
                b.tier = alternateTier1
                alternateFlag = not alternateFlag
            else
                b.color = alternateColor2
                b.tier = alternateTier2
                alternateFlag = not alternateFlag
            end

            -- If alternating is off, use the solid color and tier
            if not alternatePattern then
                b.color = solidColor
                b.tier = solidTier
            end 

            counter = counter + 1

            table.insert(bricks, b)

            -- Continue the execution
            ::continue::
        end
    end

    -- If we're past a certain level, randomly choose a brick and lock it
    if level > 10 then
        local lockNum = math.random(counter)
        bricks[lockNum].locked = true
    end
    
    return bricks
end

