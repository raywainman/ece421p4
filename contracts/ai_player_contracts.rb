require "test/unit"

module AIPlayerContracts
  include Test::Unit::Assertions
  def initialize_preconditions(difficulty)
    assert difficulty >= 0, "difficulty must be a number between 0 and 1"
    assert difficulty <= 1, "difficulty must be a number between 0 and 1"
  end

  def initialize_postconditions()
    assert @difficulty >= 0, "difficulty must be a number between 0 and 1"
    assert @difficulty <= 1, "difficulty must be a number between 0 and 1"
  end

  def do_move_preconditions(grid, other_players)
    assert grid.is_a?(Grid), "invalid grid argument"
    assert other_players.is_a?(Hash), "other players must be hash"
    assert other_players.size <= 4, "other_players must be less than size 4"
  end

  def do_move_postconditions(result)
    assert result >= 0, "move must be a valid column"
    assert result < 7, "move must be a valid column"
  end

  def class_invariant
    assert @token != nil, "token still not set"
    assert @difficulty >= 0, "difficulty must be a number between 0 and 1"
    assert @difficulty <= 1, "difficulty must be a number between 0 and 1"
  end
end