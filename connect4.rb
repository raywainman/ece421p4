require_relative "./game_type"

class Connect4 < GameType
  @@labels = ["B", "R", "G", "Y"]

  def initialize
  end
    
  def get_player_label(player)
    return @@labels[player]
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

  def evaluate_win(grid)
    raise "Not implemented"
  end
end