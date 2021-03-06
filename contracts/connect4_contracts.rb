require "test/unit"

# Contracts for the Connect4 class.

# Author:: Dustin Durand (dddurand@ualberta.ca)
# Author:: Kenneth Rodas (krodas@ualberta.ca)
# Author:: Raymond Wainman (wainman@uablerta.ca)
# (ECE 421 - Assignment #4)

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

  def winning_token_preconditions(player)
    assert player >= 0, "player must be within range"
    assert player < max_players(), "player must be within range"
  end
  
  def winning_token_postconditions(result)
    assert result != nil, "winning token must not be nil"
    assert result.is_a?(String), "winning token must be a string"
    assert result.size == 4, "winning token must have size 4"
  end

  def class_invariant()
    assert Connect4::labels != nil, "labels static array must not be nil"
    assert Connect4::labels.size == 4, "labels static array must not change"
  end
end