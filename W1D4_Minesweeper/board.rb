require 'colorize'

class Board
  attr_reader :grid
  
  def initialize(grid = Board.default_grid)
    @grid = grid 
  end 
  
  def self.default_grid
    Array.new(9) { Array.new(9) }
  end
  
  def [](pos)
    x, y = pos
    @grid[x][y]
  end
  
  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end
  
  def populate
    (0..grid.length - 1).each do |i|
      (0..grid.length - 1).each do |j|
        @grid[i][j] = nil
      end 
    end 
  end 
  
  def random_pos 
    x = rand(0..@grid.length - 1)
    y = rand(0..@grid.length - 1)
    
    [x, y]
  end 
  
  def valid_pos?(pos)
    self[pos].nil?
  end 
  
  def place_bombs(num_bombs)
    until num_bombs.zero?
      pos = random_pos
      
      if valid_pos?(pos)
        self[pos] = "X".red
        num_bombs -= 1
      end 
    end
  end 
  
  def render 
    @grid.each do |row|
      row.map! { |el| el == nil ? "O" : el }
      puts row.join(" ")
    end
  end 
end

if __FILE__ == $PROGRAM_NAME 
  new_board = Board.new
  new_board.populate
  new_board.place_bombs(9)
  new_board.render
end