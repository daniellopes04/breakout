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

-- Creates a brick table with randomized rows and columns. 
function LevelMaker.createMap(level)
    local bricks = {}

    -- Randomly sets the number of rows and cols
    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)

    -- Lay out bricks such that they touch each other and fill the screen
    for y = 1, numRows do
        for x = 1, numCols do
            b = Brick(
                -- x-coordinate
                (x-1)                   -- decrement x by 1 because tables are 1-indexed, coords are 0
                * 32                    -- multiply by 32, the brick width
                + 8                     -- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
                + (13 - numCols) * 16,  -- left-side padding for when there are fewer than 13 columns
                
                -- y-coordinate
                y * 16                  -- just use y * 16, since we need top padding anyway
            )

            table.insert(bricks, b)
        end
    end

    return bricks
end

