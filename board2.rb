class Cell
  attr_reader :x, :y
  attr_accessor :alive

  def initialize(x, y, alive=false)
    @alive = alive
    @x = x
    @y = y
  end

  def check_neighbors(board)
    b = board.board
    neighbors = [
      b[(y-1) % (board.rows + 1)][(x-1) % (board.cols + 1)],
      b[(y-1) % (board.rows + 1)][x % (board.cols + 1)],
      b[(y-1) % (board.rows + 1)][(x+1) % (board.cols + 1)],
      b[y % (board.rows + 1)][(x-1) % (board.cols + 1)],
      b[y % (board.rows + 1)][(x+1) % (board.cols + 1)],
      b[(y+1) % (board.rows + 1)][(x-1) % (board.cols + 1)],
      b[(y+1) % (board.rows + 1)][x % (board.cols + 1)],
      b[(y+1) % (board.rows + 1)][(x+1) % (board.cols)]
    ]
    neighbors.count { |cell| cell.alive }
  end

  def to_s
    alive ? "o" : "x"
  end
end

class Board
  attr_reader :cells, :rows, :cols
  attr_accessor :board

  def initialize(rows, cols, cells)
    @rows = rows
    @cols = cols
    @cells = cells
    @board = create_board(rows, cols)
  end

  def create_board(rows, cols)
    output = []
    (0..rows).each do |row|
      row_array = []
      (0..cols).each do |col|
        row_array.push(Cell.new(row, col))
      end
      output.push(row_array)
    end
    cells.each do |cell|
      output[cell.y][cell.x] = cell
    end
    output
  end

  def update_board
    alive_cells = board.flatten.select do |cell|
      cell.alive
    end

    dead_cells = board.flatten.reject do |cell|
      cell.alive
    end

    alive_cells.each do |cell|
      live_neighbors = cell.check_neighbors(self)
      if live_neighbors < 2 || live_neighbors > 3
        board[cell.y][cell.x] = Cell.new(cell.x, cell.y, false)
      end
    end

    dead_cells.each do |cell|
      live_neighbors = cell.check_neighbors(self)
      if live_neighbors == 3
        board[cell.y][cell.x] = Cell.new(cell.x, cell.y, true)
      end
    end
  end

  def to_s
    output = ""
    board.each do |row|
      row_string = ""
      row.each do |cell|
        row_string << cell.to_s
      end
      row_string << "\n"
      output << row_string
    end
    puts output + "\n"
  end
end

cell1 = Cell.new(5, 5, true)
cell2 = Cell.new(7, 6, true)
cell3 = Cell.new(6, 5, true)
cell4 = Cell.new(6, 6, true)
cell5 = Cell.new(4, 6, true)

board = Board.new(10, 10, [cell1, cell2, cell3, cell4, cell5])
#board = Board.new(10, 10, [cell1])
board.to_s

while true
  board.update_board
  board.to_s
end
