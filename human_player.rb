require_relative "./player"
require_relative "./contracts/human_player_contracts"

class HumanPlayer < Player
  include HumanPlayerContracts
  def do_move(game)
    do_move_preconditions(game)
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

  def set_token(token)
    set_token_preconditions(token)
    @token = token
    class_invariant()
    set_token_postconditions()
  end
end