--[[
    Part of "S50's Intro to Game Development"
    Lecture 2
    
    -- Utilities file --
    Made by: Daniel de Sousa
    https://github.com/daniellopes04

    All the utilities of the game are stored here. Mainly used in this case
    to manage the sprite sheets.
]]

-- Receives an "atlas" (a texture with multiple sprites) and the tile dimensions
-- Then, split the texture into all of the quads by dividing it evenly.
function GenerateQuads(atlas, tileWidth, tileHeight)
    local sheetWidth = atlas:getWidth() / tileWidth
    local sheetHeight = atlas:getHeight() / tileHeight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do 
        for x = 0, sheetWidth - 1  do
            spritesheet[sheetCounter] = 
                love.graphics.newQuad(x * tileWidth, y * tileHeight, tileWidth,
                tileHeight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

-- Utility function for slicing tables, a la Python.
-- https://stackoverflow.com/questions/24821045/does-lua-have-something-like-pythons-slice
function table.slice(tbl, first, last, step)
    local sliced = {}
  
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end
  
    return sliced
end

-- Pieces out the paddles from the sprite sheet
function GenerateQuadsPaddles(atlas)
    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        -- Smallest paddle
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1

        -- Medium paddle
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1

        -- Large paddle
        quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions())
        counter = counter + 1

        -- Huge paddle
        quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions())
        counter = counter + 1

        -- Prepare x and y for the next set of paddles
        x = 0
        y = y + 32
    end

    return quads
end

-- Pieces out the balls from the sprite sheet
function GenerateQuadsBalls(atlas)
    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    x = 96
    y = 56

    for i = 0, 2 do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        x = x + 8
        counter = counter + 1
    end

    return quads
end