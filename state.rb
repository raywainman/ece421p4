require_relative "./contracts/state_contracts"

class State
  include StateContracts
  
  attr_reader :grid, :players, :active_player
  def initialize(grid, players, active_player)
    initialize_preconditions(grid, players, active_player)
    @grid = grid
    @players = players
    @active_player = active_player
    initialize_postconditions()
  end
end