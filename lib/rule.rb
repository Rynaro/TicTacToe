module TicTacToe

  module Rule

    def check_move
      row, col = make_move
      board[row, col] = current_player
    rescue TicTacToe::Board::InvalidRequest => e
      yield e.message if block_given?
      retry
    end

    def check_win
      if board.verify_lines(*board.move).any? { |l| l.all? { |c| c == current_player } }
        yield
        puts board
        game_over
      end
    end

    def check_board
      if @board.covered?
        yield
        game_over
      end
    end

  end

end
