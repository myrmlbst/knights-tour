local KnightTour = {}

-- possible moves for a knight
local moves = {
    {x = 2, y = 1},
    {x = 1, y = 2},
    {x = -1, y = 2},
    {x = -2, y = 1},
    {x = -2, y = -1},
    {x = -1, y = -2},
    {x = 1, y = -2},
    {x = 2, y = -1}
}

-- check if position is valid
local function isValidPosition(x, y, board)
    return x >= 1 and x <= 8 and y >= 1 and y <= 8 and board[y][x] == 0
end

-- count number of valid moves from current position
local function countValidMoves(x, y, board)
    local count = 0
    for _, move in ipairs(moves) do
        local newX = x + move.x
        local newY = y + move.y
        if isValidPosition(newX, newY, board) then
            count = count + 1
        end
    end
    return count
end

-- initialize board
function KnightTour.initializeBoard()
    local board = {}
    for i = 1, 8 do
        board[i] = {}
        for j = 1, 8 do
            board[i][j] = 0
        end
    end
    return board
end

-- find next best move (Warnsdorff's algorithm)
local function findNextMove(x, y, board, moveNumber)
    local minMoves = 9
    local nextX, nextY = nil, nil

    for _, move in ipairs(moves) do
        local newX = x + move.x
        local newY = y + move.y

        if isValidPosition(newX, newY, board) then
            local moves = countValidMoves(newX, newY, board)
            if moves < minMoves then
                minMoves = moves
                nextX = newX
                nextY = newY
            end
        end
    end

    return nextX, nextY
end

-- solve knight's tour
function KnightTour.solve(startX, startY)
    local board = KnightTour.initializeBoard()
    local moveNumber = 1
    local x, y = startX, startY

    -- mark starting position
    board[y][x] = moveNumber

    -- try to make 63 more moves
    while moveNumber < 64 do
        local nextX, nextY = findNextMove(x, y, board, moveNumber)

        if not nextX or not nextY then
            return nil -- no solution
        end

        x, y = nextX, nextY
        moveNumber = moveNumber + 1
        board[y][x] = moveNumber
    end

    return board
end

-- get path positions for visualization
function KnightTour.getPathPositions(solution, offsetX, offsetY, cellSize)
    local positions = {}
    for i = 1, 64 do
        for row = 1, 8 do
            for col = 1, 8 do
                if solution[row][col] == i then
                    positions[i] = {
                        x = offsetX + (col - 1) * cellSize + cellSize/2,
                        y = offsetY + (row - 1) * cellSize + cellSize/2
                    }
                end
            end
        end
    end
    return positions
end

return KnightTour