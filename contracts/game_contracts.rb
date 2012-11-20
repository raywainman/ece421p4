require "test/unit"

module GameContracts
  include Test::Unit::Assertions
  def initialize_preconditions(game_type, players)
    assert game_type.is_a?(GameType), "game_type argument must be a GameType object"
    assert players.respond_to?("[]"), "players argument must be a container of players"
    assert players.respond_to?("size"), "players argument must have a size function"
    assert players.size >= game_type.min_players, "not enough players for game mode"
    assert players.size <= game_type.max_players, "too many players for game mode"
    players.each{ |player|
      assert player.is_a?(Player), "players argument must be all Player objects"
    }
  end

  def initialize_postconditions()
    assert @grid  != nil, "grid must not be nil"
    assert @players != nil, "players class element cannot be nil"
    assert @game_type != nil, "game_type class element cannot be nil"
    assert @active_player == 0, "active_player must be first player"
  end

  def reset_preconditions()
    # No preconditions for reset
  end

  def reset_postconditions()
    @grid.each{ |row|
      row.each{ |column|
        assert column == nil, "grid element must be nil to start"
      }
    }
    assert @active_player == 0, "active_player must be first player"
  end

  def class_invariant()
    assert @grid.is_a?(Grid), "grid must be a Grid object"
    assert @players != nil, "players class element cannot be nil"
    assert @game_type != nil, "game_type class element cannot be nil"
    assert @active_player >= 0, "active_player must be a positive integer"
    assert @active_player < @players.size, "active_player must be an actual player"
  end
end