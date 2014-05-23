module TicTacToe

  class Game

    include TicTacToe::Rule

    attr_reader :board, :player, :current_player

    def initialize
      @board    = TicTacToe::Board.new
      analysis_board
      @player   = [:x, :o].cycle
    end

    def play
      catch :finished do
        loop do
          start_new_turn
          render_board
          check_move  { |m| puts m }
          check_win   { |m| puts "Winner #{@current_player}!" }
          check_board { puts "It's a Tie" }
        end
      end
    end

    def start_new_turn
      @current_player = @player.next
    end

    def render_board
      puts @board
    end

    def game_over
      throw :finished
    end

    def make_move
      print "\n>> "
      coord = gets.chomp
      puts
      if coord.match /exit/i
        puts "Bye!"
        throw :finished
      else
        coord.split.map { |z| z.to_i }
      end

    end

  end


end

TicTacToe::Game.new
