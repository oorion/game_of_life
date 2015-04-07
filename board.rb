class Board
  attr_reader :board

  SIZE = 25

  def initialize(state)
    @board = create_board(state)
  end

  def create_board(state)
    array = []
    SIZE.times do
      array.push(Array.new(SIZE, "x"))
    end
    state.each do |cell|
      array[cell.position[1]][cell.position[0]] = "o"
    end
    array
  end

  def update_board
    #to implement!
  end

  def to_s
    board.each do |row|
      print row.join() + "\n"
    end
  end
end

class Cell
  attr_reader :position, :x, :y
  attr_accessor :alive

  def initialize(position, alive=false)
    @alive = alive
    @position = position
    @x = position[0]
    @y = position[1]
  end

  def number_of_live_neighbors(board)
    pos1 = board[y-1][x-1]
    pos2 = board[y-1][x]
    pos3 = board[y-1][x+1]
    pos4 = board[y][x+1]
    pos5 = board[y+1][x+1]
    pos6 = board[y+1][x]
    pos7 = board[y+1][x-1]
    pos8 = board[y][x-1]
    surrounding_cells = [pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8]
    surrounding_cells.count {|cell| cell == "o" }
  end
end

cell1 = Cell.new([10,10], true)
cell2 = Cell.new([10,11], true)
cell3 = Cell.new([11,10], true)
cell4 = Cell.new([11,11], true)
state = [cell1, cell2, cell3, cell4]

board = Board.new(state)
board.to_s

while true
  Board.board.each_with_index do |row, y|
    row.each_with_index do |element, x|
      cell = Cell.new([x, y])
      noln = cell.number_of_live_neighbors(Board.board)
      if noln < 2
        Cell.alive = false
      end
    end
  end
  board.update_board
  board.to_s
end
