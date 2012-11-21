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
    return result
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

  def winning_token(player)
    winning_token_preconditions(player)
    str = ""
    str << get_player_label(player)
    2.times {
      str << get_player_label(1-player)
    }
    str << get_player_label(player)
    winning_token_postconditions(str)
    return str
  end
end