module TicTacToe
  class Board

    attr_reader :structure, :move

    InvalidRequest = Class.new(StandardError)

    LEFT_DIAGONAL    = [ [0,0], [1,1], [2,2] ]
    RIGHT_DIAGONAL   = [ [2,0], [1,1], [0,2] ]
    INTERVAL         = (0..2)

    def initialize
      @structure =  [ [nil, nil, nil],
                      [nil, nil, nil],
                      [nil, nil, nil] ]
      @move = nil
    end

    def [](row, col)
      @structure.fetch(row).fetch(col)
    rescue IndexError
      raise InvalidRequest, "Out of bounds! Try again!"
    end

    def []=(row, col, sym)
      raise InvalidRequest, "Position is already being used" if self[row, col]
      @structure[row][col] = sym
      @move = [row, col]
    end

    def to_s
      @structure.map{ |row| row.map{ |e| e || " " }.join("|") }.join("\n")
    end

    def covered?
      @structure.flatten.compact.length == 9
    end

    def verify_lines row, col
      [row(row), column(col), left_diagonal, right_diagonal]
    end

    def row idx
      INTERVAL.map { |col| self[idx, col] }
    end

    def column idx
      INTERVAL.map { |row| self[row, idx] }
    end

    def left_diagonal
      LEFT_DIAGONAL.map { |i| self[*i] }
    end

    def right_diagonal
      RIGHT_DIAGONAL.map { |i| self[*i] }
    end

    def get_board
      @free = Array.new
      @structure.each_with_index { |e, i| e.each_with_index { |f, j| @free = [i, j] if f.nil? } }
      @free[0]
    end

  end
end
