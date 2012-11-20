require_relative "./contracts/game_type_contracts"

# Abstract game type class
class GameType
  include GameTypeContracts
  # Gets the label that should be given to the given player number
  def get_player_label(player)
    raise "Not implemented"
  end

  # Returns the maximum number of players that can play in this mode
  def max_players()
    raise "Not implemented"
  end

  # Returns the minimum number of players needed to play in this mode
  def min_players()
    raise "Not implemented"
  end

  # Returns a string representing the game
  def game_name()
    raise "Not implemented"
  end

  # Evaluates the grid and returns the winning player (if there is a win),
  # -1 otherwise
  def evaluate_win(grid, winning_token)
    evaluate_win_preconditions(grid, winning_token)

    expected_length = winning_token.length()
    sentinel = ";"
    null_token = "^"

    matches= evaluate_horizontal_win(grid, sentinel, null_token, expected_length)
    matches+= evaluate_vertical_win(grid, sentinel, null_token, expected_length)
    matches+= evaluate_right_diagonal_win(grid, sentinel, null_token, expected_length)
    matches+= evaluate_left_diagonal_win(grid, sentinel, null_token, expected_length)

    result = /#{winning_token}/.match(matches)

    if(result == nil)
      return false
    else
      return true
    end

    evaluate_win_postconditions()
  end

  private

  def evaluate_horizontal_win(grid, sentinal, null_token, expected_length)
    pre_evaluate_horizontal_win(grid, sentinal, null_token, expected_length)
    
    
    result = "";

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()

    row_length.times { |rowindex|

      col = 0

      while(col + expected_length-1 < col_length)
        string = ""
        col.upto(col+expected_length-1) {|i|
          temp = grid[rowindex,i]

          if(temp == nil)
            string += null_token
          else
            string += temp.to_s
          end

        }

        result += string + sentinal

        col+= 1

      end

    }
    
    post_evaluate_horizontal_win(result)
    result

  end

  def evaluate_vertical_win(grid, sentinal, null_token, expected_length)
    
    pre_evaluate_vertical_win(grid, sentinal, null_token, expected_length)
    result = ""

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()

    col_length.times { |col|
      row = 0

      while(row + expected_length-1 < row_length)
        string = ""
        (row..row+expected_length-1).each {|i|
          temp = grid[i,col]

          if(temp == nil)
            string += null_token
          else
            string += temp.to_s
          end

        }

        result += string + sentinal

        row+= 1
      end

    }
    
    post_evaluate_vertical_win(result)
    result
  end

  def evaluate_right_diagonal_win(grid, sentinal, null_token, expected_length)

    pre_evaluate_right_diagonal_win(grid, sentinal, null_token, expected_length)
    result = ""

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()

    row_length.times { |row|
      col_length.times { |col|

        if([row_length - row, col + 1].min < expected_length)
          next
        end

        column_index = col
        row_index = row
        string = ""

        while(row_index < row_length && column_index >= 0 && string.length <  expected_length)
          temp = grid[row_index,column_index]

          if(temp == nil)
            string += null_token
          else
            string += temp.to_s
          end

          row_index+=1
          column_index-=1
        end

        if(string.length == expected_length)
          result+= string + sentinal
        end

      }
    }
    
    post_evaluate_right_diagonal_win(result)
    result
  end

  def evaluate_left_diagonal_win(grid, sentinal, null_token, expected_length)

    pre_evaluate_left_diagonal_win(grid, sentinal, null_token, expected_length)
    result = ""

    row_length = grid.get_row_length()
    col_length = grid.get_column_length()

    row_length.times { |row|
      col_length.times { |col|

        if([row_length - row, col_length - col].min < 4)
          next
        end

        column_index = col
        row_index = row
        string = ""

        while(row_index < row_length && column_index < col_length && string.length < expected_length)

          temp = grid[row_index,column_index]

          if(temp == nil)
            string += null_token
          else
            string += temp.to_s
          end

          row_index+=1
          column_index+=1
        end

        if(string.length == expected_length)
          result+= string + sentinal
        end

      }
    }

    post_evaluate_left_diagonal_win(result)
    result

  end

end

require_relative "./grid"

grid = Grid.new()

grid[0,0] = "x"
grid[0,1] = "x"
grid[0,3] = "x"
grid[0,4] = "x"
grid[0,5] = "x"
grid[0,6] = "x"

grid[1,1] = "o"
grid[2,1] = "o"

grid[0,0] = "t"
grid[1,0] = "t"
grid[2,0] = "t"
grid[3,0] = "t"

grid[4,3] = "o"
grid[5,3] = "o"
grid[2,3] = "o"
grid[3,4] = "t"
grid[4,5] = "t"
grid[5,6] = "o"

puts grid.to_s

test = GameType.new()
puts "xxxx: "+ test.evaluate_win(grid, "xxxx").to_s
puts "tttt: "+ test.evaluate_win(grid, "tttt").to_s
puts "xoot: "+ test.evaluate_win(grid, "xoot").to_s
puts "otto: "+ test.evaluate_win(grid, "otto").to_s
puts "oooo: "+ test.evaluate_win(grid, "oooo").to_s
puts "xoo : "+ test.evaluate_win(grid, "xoo ").to_s