require "test/unit"

module StateContracts
  include Test::Unit::Assertions
  def initialize_preconditions(grid, players, active_player, game_type)
    assert grid.respond_to?("[]"), "grid must respond to []"
    assert grid.size == 6, "grid incorrect size"
    assert grid[0].size == 7, "grid incorrect size"
    assert players.is_a?(Hash), "player list must be a hash of names and tokens"
    assert active_player >= 0, "invalid active player"
    assert active_player < game_type.max_players, "invalid active player"
    assert game_type.is_a?(Class), "game_type must be a valid game type class"
  end
  
  def initialize_postconditions()
    assert @grid != nil, "grid must not be nil"
    assert @players != nil, "player list must not be nil"
    assert @active_player != nil, "active_player must not be nil"
    assert @game_type != nil, "game_type must not be nil"
  end
end