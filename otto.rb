require_relative "./game_type"

class Otto < GameType
  @@labels = ["O", "T"]

  def initialize
  end

  def get_player_label(player)
    get_player_label_preconditions(player)
    class_invariant()
    result = @@labels[player]
    class_invariant()
    get_player_label_postconditions(result)
  end

  def max_players()
    return 2
  end

  def min_players()
    return 2
  end

  def game_name()
    return "OTTO/TOOT"
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