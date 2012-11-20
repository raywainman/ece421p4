require "test/unit"

module HumanPlayerContracts
  include Test::Unit::Assertions
  def do_move_preconditions(grid)
    assert grid.is_a?(Grid), "invalid grid argument"
  end

  def do_move_postconditions(result)
    assert result >= 0, "move must be a valid column"
    assert result < 7, "move must be a valid column"
  end

  def set_token_preconditions(token)
    assert token != nil, "token must not be nil"
  end

  def set_token_postconditions()
    assert @token != nil, "token must not be nil"
  end

  def class_invariant
    assert @token != nil, "token still not set"
  end

end