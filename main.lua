local KnightTour = require("src.knight")
local Board = require("src.board")

local board = nil
local currentMove = 1
local solution = nil
local lastUpdate = 0
local moveDelay = 0.5 -- time between moves (in seconds)
local pathPositions = {}

function love.load()
    -- initialize board
    board = Board.new()
    board:init()

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