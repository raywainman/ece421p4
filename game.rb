require_relative "./connect4"
require_relative "./human_player"
require_relative "./ai_player"
require_relative "./contracts/game_contracts"

class Game
  include GameContracts
  # grid[row][col]
  # Creates a new instance of the game given a GameType and a list of Player objects
  def initialize(game_type, players)
    initialize_preconditions(game_type, players)
    @game_type = game_type
    @players = players
    # Set the tokens
    @players.each_with_index{ |player, index|
      player.set_token(@game_type.get_player_label(index))
    }
    @grid = Array.new(6) { Array.new(7) }
    @active_player = 0
    class_invariant()
    initialize_postconditions()
  end

  # Resets the game board to the initial state
  def reset()
    reset_preconditions()
    class_invariant()
    @grid.each_index{ |row_i|
      row.each_index{ |col_i|
        @grid[row_i][col_i] = nil
      }
    }
    @active_player = 0
    class_invariant()
    reset_postconditions()
  end

  # Makes a move for the given player on the given column
  # SHOULD BE PRIVATE
  def make_move(player, column)
    make_move_preconditions(player, column)
    added = false
    (0..6).each{ |row|
      if @grid[6-row-1][column] == nil
        @grid[6-row-1][column] = @game_type.get_player_label(player)
        added = true
        break;
      end
    }
    make_move_postconditions(player, column)
  end

  # Checks to see if the given column is full
  def is_column_full?(column)
    is_column_full_preconditions(column)
    result = @grid[0][column] != nil
    is_column_full_postconditions
    return result
  end

  def play()
    while true
      @players.each_with_index{ |player, index|
        puts to_s
        puts "Player " + index.to_s + "'s turn (" + @game_type.get_player_label(index) + ") - " + player.description
        make_move(index, player.do_move(self))
      }
    end
  end

  def to_s
    str = ""
    @grid.each { |row|
      row.each { |element|
        if element == nil
          element = "-"
        end
        str << element + " "
      }
      str << "\n"
    }
    return str
  end
end

players = [HumanPlayer.new, AIPlayer.new]
game = Game.new(Connect4.new, players)
game.play