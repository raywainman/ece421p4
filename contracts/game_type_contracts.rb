require "test/unit"

module GameTypeContracts
  include Test::Unit::Assertions
  
  def evaluate_win_preconditions(grid, winning_token)
    assert grid.respond_to?("[]"), "grid must respond to []"
    assert winning_token != nil, "winning token must not be nil"
    assert winning_token.is_a?(String), "winning token must be a string"
  end

  def evaluate_win_postconditions()
    # No postconditions
  end
end