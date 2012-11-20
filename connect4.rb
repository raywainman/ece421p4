require_relative "./game_type"
require_relative "./contracts/connect4_contracts"

class Connect4 < GameType
  include Connect4Contracts

  @@labels = ["B", "R", "G", "Y"]

  def self.labels
    return @@labels
  end

  def initialize
  end

  def get_player_label(player)
    get_player_label_preconditions(player)
    class_invariant()
    result = @@labels[player]
    class_invariant()
    get_player_label_postconditions(result)
    return result
  end

  def max_players()
    return 4
  end

  def min_players()
    return 2
  end

  def game_name()
    return "Connect4"
  end

  # TODO: Write the evaluate win algorithm
  def evaluate_win(grid)
    evaluate_win_preconditions(grid)
    class_invariant()
    raise "Not implemented"
    class_invariant()
    evaluate_win_postconditions(result)
  end
end