require_relative "./player"
require_relative "./contracts/ai_player_contracts"

class AIPlayer < Player
  include AIPlayerContracts
  # Creates the AI Player with the given difficulty is the probability that
  # the AI makes a random move as opposed to a smart one
  def initialize(difficulty)
    initialize_preconditions(difficulty)
    @difficulty = difficulty
    initialize_postconditions()
  end

  # TODO: Write the AI algorithm with the @difficulty parameter used as a
  # probability that the bot makes a random (stupid) move
  def do_move(grid, other_players)
    do_move_preconditions(grid, other_players)
    class_invariant()
    # random column for now
    random = rand(7)
    while grid.is_column_full?(random)
      random = rand(6)
    end
    class_invariant()
    do_move_postconditions(random)
    return random
  end

  def description()
    "AI"
  end
end