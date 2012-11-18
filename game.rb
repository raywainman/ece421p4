require_relative "./connect4"
require_relative "./player"

class Game

  # grid[row][col]
  def initialize(game_type, players)
    #initalize_preconditions(game_type, players)
    @game_type = game_type
    @players = players
    @grid = Array.new(6) { Array.new(7) }
    #initialize_postconditions()
  end

  def play()
    while true
      @players.each_with_index{ |player, index|
        puts to_s
        make_move(index, player.do_move())
      }
    end
  end

  def make_move(player, column)
    added = false
    (0..6).each{ |row|
      if @grid[6-row-1][column] == nil
        @grid[6-row-1][column] = @game_type.get_player_label(player)
        added = true
        break;
      end
    }
    if !added
      raise "Illegal Move"
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

players = [Player.new, Player.new]
game = Game.new(Connect4.new, players)
game.play