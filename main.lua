local KnightTour = require("src.knight")
local Board = require("src.board")

local board = nil
local currentMove = 1
local solution = nil
local lastUpdate = 0
local moveDelay = 0.5 -- time between moves (in seconds)
local pathPositions = {}
local moveSound = nil -- sound effect for knight movement

-- create a movement sound
local function createClickSound()
    local sampleRate = 44100
    local duration = 0.2
    local numSamples = math.floor(sampleRate * duration)
    local soundData = love.sound.newSoundData(numSamples, sampleRate, 16, 1)
    
    for i = 0, numSamples - 1 do
        local t = i / sampleRate
        local amplitude = math.exp(-t * 30)
        local sample = math.sin(2 * math.pi * 160 * t) * amplitude * 1.0
        soundData:setSample(i, sample)
    end
    
    return love.audio.newSource(soundData)
end

function love.load()
    -- initialize audio system
    love.audio.setVolume(1.0)  -- set system volume to max
    
    -- initialize board
    board = Board.new()
    board:init()

    -- create click sound
    moveSound = createClickSound()
    
    -- test sound at startup
    moveSound:play()
    moveSound:setVolume(1.0)  -- ensure source volume is maximum

    -- get initial solution
    solution = KnightTour.solve(1, 1)
    pathPositions = KnightTour.getPathPositions(solution, board.offsetX, board.offsetY, Board.CELL_SIZE)
end

function love.draw()
    board:draw(solution, currentMove, pathPositions)
end

function love.update(dt)
    lastUpdate = lastUpdate + dt
    if lastUpdate >= moveDelay and currentMove < 64 then
        currentMove = currentMove + 1
        lastUpdate = 0
        -- play sound effect when knight moves
        moveSound:stop() -- stop any previous playback
        moveSound:setVolume(1.0)  -- ensure volume is maximum each time
        moveSound:play()
    end
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        -- reset visualization
        currentMove = 1
        lastUpdate = 0
        solution = KnightTour.solve(1, 1)
        pathPositions = KnightTour.getPathPositions(solution, board.offsetX, board.offsetY, Board.CELL_SIZE)
    elseif key == "n" then
        -- toggle showing all numbers
        board:toggleNumbers()
    end
end 
