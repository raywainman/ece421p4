require_relative "./contracts/game_contracts"

class State
  attr_reader :grid, :players, :active_player, :game_type
  def initialize(grid, players, active_player, game_type)
    initialize_preconditions(grid, players, active_player, game_type)
    @grid = grid
    @players = players
    @active_player = active_player
    @game_type = game_type
    initialize_postconditions()
  end
end