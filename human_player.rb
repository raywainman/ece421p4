require_relative "./player"
require_relative "./contracts/human_player_contracts"

class HumanPlayer < Player
  include HumanPlayerContracts
  def do_move(grid, other_players)
    do_move_preconditions(grid, other_players)
    class_invariant()
    print "Add to column> "
    result = gets.to_i
    class_invariant()
    do_move_postconditions(result)
    return result
  end

  def description()
    "Human"
  end
end