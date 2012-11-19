require "test/unit"

module OttoContracts
  include Test::Unit::Assertions
  def get_player_label_preconditions(player)
    assert player >= 0, "player must be within range"
    assert player < max_players(), "player must be within range"
  end

  def get_player_label_postconditions(result)
    assert result != nil, "result must not be nil"
    assert @labels.include?(result), "result is not in original array"
  end

  def evaluate_win_preconditions(grid)
    assert grid.respond_to?("[]"), "grid must respond to []"
  end

  def evaluate_win_postconditions(result)
    assert result == -1 || (result >= 0 && result < max_players()), "result out of range"
  end

  def class_invariant()
    assert @@labels != nil, "labels static array must not be nil"
    assert @@labels.size == 2, "labels static array must not change"
  end
end