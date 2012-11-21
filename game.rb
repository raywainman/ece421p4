require_relative "./connect4"
require_relative "./human_player"
require_relative "./grid"
require_relative "./ai_player"
require_relative "./contracts/game_contracts"

class Game
  include GameContracts
  # Creates a new instance of the game given a GameType and a list of Player objects
  def initialize(game_type, players)
    initialize_preconditions(game_type, players)
    @game_type = game_type
    @players = players
    # Set the tokens
    @players.each_with_index{ |player, index|
      player.set_token(@game_type.get_player_label(index))
    }
    @grid = Grid.new
    @active_player = 0
    class_invariant()
    initialize_postconditions()
  end

  # Resets the game to the initial state
  def reset()
    reset_preconditions()
    class_invariant()
    @grid.reset()
    @active_player = 0
    class_invariant()
    reset_postconditions()
  end

  def play()
    while true
      puts @grid.to_s
      puts "Player " + @active_player.to_s + "'s turn (" + @game_type.get_player_label(@active_player) + ") - " + @players[@active_player].description
      @grid.make_move(@game_type.get_player_label(@active_player), @players[@active_player].do_move(@grid))
      if @game_type.evaluate_win(@grid, @game_type.winning_token(@active_player))
        puts "Player " + @active_player.to_s + " has won!"
        reset()
      else
        @active_player = (@active_player + 1) % @players.size
      end
    end
  end
end

players = [HumanPlayer.new, AIPlayer.new(0.5)]
game = Game.new(Connect4.new, players)
game.play