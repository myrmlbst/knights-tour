local Board = {}

-- board configs
Board.SIZE = 8
Board.CELL_SIZE = 60
Board.COLORS = {
    light = {1.0, 1.0, 1.0},  -- white cells
    dark = {0.6, 0.8, 0.9},   -- blue cells
    visited = {1.0, 0.8, 0.8}, -- baby pink (visited cells)
    path = {1.0, 0.2, 0.2}    -- red
}

function Board.new()
    local self = {
        offsetX = 0,
        offsetY = 0,
        font = nil,
        showAllNumbers = true
    }
    return setmetatable(self, { __index = Board })
end

function Board:init()
    -- calculate offset to center the board
    self.offsetX = (love.graphics.getWidth() - (Board.SIZE * Board.CELL_SIZE)) / 2
    self.offsetY = (love.graphics.getHeight() - (Board.SIZE * Board.CELL_SIZE)) / 2 + 40
    
    -- set up font
    self.font = love.graphics.newFont(20)
    love.graphics.setFont(self.font)
end

-- draw the board
function Board:draw(solution, currentMove, pathPositions)
    -- display instructions
    love.graphics.setColor(1, 1, 1)  -- White text
    love.graphics.print("Knight's Tour Visualization", self.offsetX, 10)
    love.graphics.print("Press SPACE to restart", self.offsetX, 30)
    love.graphics.print("Press ESC to quit", self.offsetX, 50)
    love.graphics.print("Press N to toggle numbers", self.offsetX, 70)
    
    -- display squares
    for row = 1, Board.SIZE do
        for col = 1, Board.SIZE do
            local x = self.offsetX + (col - 1) * Board.CELL_SIZE
            local y = self.offsetY + (row - 1) * Board.CELL_SIZE
            
            -- alternate btw cell colors
            if solution[row][col] <= currentMove then
                love.graphics.setColor(Board.COLORS.visited)
            else
                if (row + col) % 2 == 0 then
                    love.graphics.setColor(Board.COLORS.light)
                else
                    love.graphics.setColor(Board.COLORS.dark)
                end
            end
            
            -- display cell
            love.graphics.rectangle("fill", x, y, Board.CELL_SIZE, Board.CELL_SIZE)
            
            -- display cell number 
            if self.showAllNumbers or solution[row][col] <= currentMove then
                if (row + col) % 2 == 0 then
                    love.graphics.setColor(0, 0, 0)
                else
                    love.graphics.setColor(1, 1, 1)
                end
                
                local text = tostring(solution[row][col])
                local textWidth = self.font:getWidth(text)
                local textHeight = self.font:getHeight()
                love.graphics.print(text, 
                    x + (Board.CELL_SIZE - textWidth) / 2,
                    y + (Board.CELL_SIZE - textHeight) / 2)
            end
        end
    end
    
    -- path visualization
    love.graphics.setColor(Board.COLORS.path)
    love.graphics.setLineWidth(2)
    for i = 1, currentMove - 1 do
        if pathPositions[i] and pathPositions[i + 1] then
            love.graphics.line(
                pathPositions[i].x, pathPositions[i].y,
                pathPositions[i + 1].x, pathPositions[i + 1].y
            )
        end
    end
    
    -- borders
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("line", self.offsetX, self.offsetY, 
        Board.SIZE * Board.CELL_SIZE, Board.SIZE * Board.CELL_SIZE)
end

-- toggle number visibility
function Board:toggleNumbers()
    self.showAllNumbers = not self.showAllNumbers
end

return Board 