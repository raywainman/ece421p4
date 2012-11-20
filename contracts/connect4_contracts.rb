require "test/unit"

module Connect4Contracts
  include Test::Unit::Assertions
  def get_player_label_preconditions(player)
    assert player >= 0, "player must be within range"
    assert player < max_players(), "player must be within range"
  end

  def get_player_label_postconditions(result)
    assert result != nil, "result must not be nil"
    assert Connect4::labels.include?(result), "result is not in original array"
  end

  def class_invariant()
    assert Connect4::labels != nil, "labels static array must not be nil"
    assert Connect4::labels.size == 4, "labels static array must not change"
  end
end