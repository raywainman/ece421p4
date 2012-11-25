require "test/unit"

module StateContracts
  include Test::Unit::Assertions
  def initialize_preconditions(grid, players, active_player)
    assert grid.is_a?(Grid), "invalid grid"
    assert players.is_a?(Array), "player list must be an array"
    assert active_player >= 0, "invalid active player"
    assert active_player < players.size, "invalid active player"
  end
  
  def initialize_postconditions()
    assert @grid != nil, "grid must not be nil"
    assert @players != nil, "player list must not be nil"
    assert @active_player != nil, "active_player must not be nil"
  end
end