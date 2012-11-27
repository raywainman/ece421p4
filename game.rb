require_relative "./connect4"
require_relative "./human_player"
require_relative "./grid"
require_relative "./ai_player"
require_relative "./contracts/game_contracts"
require_relative "./state"

class Game
  include GameContracts
  # Creates a new instance of the game given a GameType and a list of Player objects
  # TODO: UPDATE CONTRACTS FOR VIEW
  def initialize(game_type, players, view)
    initialize_preconditions(game_type, players)
    @game_type = game_type
    @players = players
    # Set the tokens
    @players.each_with_index{ |player, index|
      player.set_token(@game_type.get_player_label(index))
      player.set_winning_token(@game_type.winning_token(index))
    }
    @grid = Grid.new
    @active_player = 0
    @view = view
    @view.initialize_players(@players)
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

  # Makes a move for the current player
  def make_move(column)
    @grid.make_move(@game_type.get_player_label(@active_player), column)
    puts @grid.to_s
    @view.update(State.new(@grid, @players, @active_player))
    if @game_type.evaluate_win(@grid, @game_type.winning_token(@active_player))
      @view.show_win((@active_player + 1).to_s)
    end
    @active_player = (@active_player + 1) % @players.size

    other_players = Hash.new
    (0...@players.size).each { |index|
      if index != @active_player
        other_players[@players[index].token] = @players[index].winning_token
      end
    }
    while @players[@active_player].is_a?(AIPlayer)
      @grid.make_move(@game_type.get_player_label(@active_player), @players[@active_player].do_move(@grid, other_players))
      @view.update(State.new(@grid, @players, @active_player))
      if @game_type.evaluate_win(@grid, @game_type.winning_token(@active_player))
        @view.show_win((@active_player + 1).to_s)
      end
      @active_player = (@active_player + 1) % @players.size
    end
  end

  def play()
    while true
      puts @grid.to_s
      puts "Player " + @active_player.to_s + "'s turn (" + @game_type.get_player_label(@active_player) + ") - " + @players[@active_player].description
      other_players = Hash.new
      (0...@players.size).each { |index|
        if index != @active_player
          other_players[@players[index].token] = @players[index].winning_token
        end
      }
      @grid.make_move(@game_type.get_player_label(@active_player), @players[@active_player].do_move(@grid, other_players))
      if @game_type.evaluate_win(@grid, @game_type.winning_token(@active_player))
        puts "Player " + @active_player.to_s + " has won!"
        reset()
      else
        @active_player = (@active_player + 1) % @players.size
      end
    end
  end
end

#players = [HumanPlayer.new, AIPlayer.new(0.5), AIPlayer.new(0.5)]
#game = Game.new(Connect4.new, players)
#game.play