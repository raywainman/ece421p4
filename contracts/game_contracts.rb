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
    assert @grid.size == 6, "grid incorrect size"
    assert @grid[0].size == 7, "grid incorrect size"
    @grid.each{ |row|
      row.each{ |column|
        assert column == nil, "grid element must be nil to start"
      }
    }
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

  def make_move_preconditions(player, column)
    assert player >= 0, "player must be within range"
    assert player < @players.size, "player must be within range"
    assert column >= 0, "column must be within range"
    assert column < 7, "column must be within range"
    assert @grid[0][column] == nil, "column is full"
  end

  def make_move_postconditions(player, column)
    # Ensure move was actually made
    token = @game_type.get_player_label(player)
    added = false
    (0..6).each{ |row|
      if @grid[row][column] == token
        added = true
        break
      end
    }
    assert added, "move not recorded"
  end

  def is_column_full_preconditions(column)
    assert column >= 0, "column must be within range"
    assert column < 7, "column must be within range"
  end

  def is_column_full_postconditions()
    # No postconditions
  end

  def class_invariant()
    assert @grid.size == 6, "grid incorrect size"
    assert @grid[0].size == 7, "grid incorrect size"
    assert @players != nil, "players class element cannot be nil"
    assert @game_type != nil, "game_type class element cannot be nil"
    assert @active_player >= 0, "active_player must be a positive integer"
    assert @active_player < @players.size, "active_player must be an actual player"
    # Ensure number of tokens from each player is consistent
    count = Hash.new
    count.default = 0
    @grid.each{ |row|
      row.each{ |element|
        if element != nil
          count[element] = count[element] + 1
        end
      }
    }
    max_value = count.values.max
    count.values.each{ |value|
      difference = max_value - value
      assert difference.abs <= 1, "inconsistent number of tokens"
    }
  end
end