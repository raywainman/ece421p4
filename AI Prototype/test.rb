class Test
  def initialize()
    @grid = Array.new(6) { Array.new(7) }

    @grid[1][0] = 1
    @grid[1][1] = 1
    @grid[2][2] = 1
    @grid[3][3] = 1
    @grid[4][4] = 1
    @grid[5][5] = 1
    @grid[4][6] = 1
    @grid[5][6] = 1

    @grid[2][5] = 1

    @grid[0][0] = "2"
    @grid[0][1] = "t"
    @grid[0][2] = "t"

    @grid[0][4] = 1
    @grid[0][5] = 1
    @grid[0][6] = 1

    @grid[1][3] = 1

  end

  def buildRowIndicator()

    row_length = @grid.length()
    col_length = @grid[0].length()

    row_indicator = Array.new(7, row_length)

    col_length.times { |column|
      row_length.times { |row|
        if @grid[row][column] != nil
          row_indicator[column] = row

          if(row == 0)
            row_indicator[column] = -1
          else
            row_indicator[column] = row - 1
          end

          break
        end
      }
    }

    return row_indicator

  end

  def get_best_move(players)
    players = []

    row_length = @grid.length()
    col_length = @grid[0].length()
    score = Array.new(players.length()) { Array.new(col_length) }
    players.each_with_index() { |player, index|
    }

  end

  def horizscore(player_index, win_seq, gridx, rowindicator, score)

    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|

      count, checkcol, checkrow = 0, i, rowindicator[i]
      next unless checkrow >= 0

      string = ""

      #left
      j = 0
      while(checkrow < row_length && checkcol> 0  && j < expected_len - 1)
        checkcol -= 1
        break unless prepend_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << "!"

      #right
      j = 0
      while(checkrow < row_length && checkcol < col_length - 1  && j < expected_len - 1)
        checkcol += 1
        break unless append_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      #get count values
      count = -1#get_fing_func_to_get_value()

      if (count > score[player_index][i])
        score[player_index][i] = count;
      end

      process(win_seq, string, "o", 0, score, i)

      puts string

    }

  end

  def append_unless_nil(result_string, grid, checkrow, checkcol)

    temp = @grid[checkrow][checkcol]

    if(temp == nil)
      result_string << "^"
      return false
    else
      result_string << @grid[checkrow][checkcol].to_s
      return true
    end

  end

  def prepend_unless_nil(result_string, grid, checkrow, checkcol)

    temp = @grid[checkrow][checkcol]

    if(temp == nil)
      result_string.insert(0, "^")
      return false
    else
      result_string.insert(0, @grid[checkrow][checkcol].to_s)
      return true
    end

  end

  def vertscore(player_index, win_seq, grid, rowindicator, score)

    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|

      count, checkrow = 0, rowindicator[i]

      next unless checkrow >= 0

      string = "!"

      j = 0
      while(checkrow < row_length - 1  && j < expected_len - 1)
        checkrow+=1
        break unless append_unless_nil(string, @grid, checkrow, i)
        j+=1
      end

      #get count values
      count = -1#get_fing_func_to_get_value()

      if (count > score[player_index][i])
        score[player_index][i] = count;
      end

      process(win_seq, string, "o", 0, score, i)

      #puts self.to_s
      puts string

    }

  end

  def leftdiagscore(player_index, win_seq, grid, rowindicator, score)

    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|
      count, checkrow, checkcol = 0, rowindicator[i], i
      next unless checkrow >= 0

      string = ""

      j = 0
      while(checkrow > 0 && checkcol > 0 && j < expected_len - 1)
        checkrow-=1
        checkcol-=1
        break unless prepend_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << "!"

      j = 0
      while(checkrow < row_length - 1 && checkcol < col_length - 1 && j < expected_len - 1)
        checkrow+=1
        checkcol+=1
        break unless append_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      #get count values
      count = -1#get_fing_func_to_get_value()

      if (count > score[player_index][i])
        score[player_index][i] = count;
      end

      process(win_seq, string, "o", 0, score, i)

      #puts self.to_s
      puts string
    }
  end

  def rightdiagscore(player_index, win_seq, grid, rowindicator, score)
    row_length = @grid.length()
    col_length = @grid[0].length()
    expected_len = win_seq.length()

    col_length.times{ |i|
      count, checkrow, checkcol = 0, rowindicator[i], i
      next unless checkrow >= 0

      string = ""

      j = 0
      while(checkrow < row_length - 1 && checkcol > 0 && j < expected_len - 1)
        checkrow+=1
        checkcol-=1
        break unless prepend_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      count, checkcol, checkrow = 0, i, rowindicator[i]
      string << "!"

      j = 0
      while(checkrow > 0 && checkcol < col_length - 1 && j < expected_len - 1)
        checkrow-=1
        checkcol+=1
        break unless append_unless_nil(string, @grid, checkrow, checkcol)
        j+=1
      end

      #get count values
      count = -1#get_fing_func_to_get_value()

      if (count > score[player_index][i])
        score[player_index][i] = count;
      end
      process(win_seq, string, "o", 0, score, i)

      #puts self.to_s
      puts string
    }
  end

  def build_value_hash(expected_sequence)
    value_hash = Hash.new(0)
    length = expected_sequence.length()

    length.times { |i|
      temp = expected_sequence[0..i]
      temp_rev = temp.reverse
      value_hash[temp] = temp.length()
      value_hash[temp_rev] = temp.length()
    }
    value_hash
  end

  def process(expected_seq, seq, token, player_index, score, column)

    value_hash = build_value_hash(expected_seq)

    seq_copy = seq.clone
    seq_len = seq.length
    expected_seq_len = expected_seq.length
    sub_sequences = []

    seq_copy.gsub!("!", token)
    seq_copy.gsub!("^", "")
    seq_copy_rev = seq_copy.reverse!()

    puts "seq_P: "+ seq_copy.to_s

    (0..seq_len/2).each{ |i|
      (i..i+expected_seq_len).each {|j|
        break unless j < seq_copy.length()
        sub_sequences << seq_copy_rev[j..i+expected_seq_len]

      }
    }

    puts sub_sequences

    sub_sequences.each {|sub_seq|
      puts sub_seq
      puts value_hash
      value = value_hash[sub_seq]

      if(score[player_index][column] < value.to_i)
        score[player_index][column] = value.to_i
      end

    }

    puts "score: " + score.to_s
  end

  def to_s()
    @grid.each { |r|
      puts r.to_s + "\n"
    }
  end

end

test = Test.new()
puts test.to_s
x = test.buildRowIndicator()
score = Array.new(1) { Array.new(7,0) }

puts "hor"
test.horizscore(0, "otto", nil, x, score)

puts "vert"
test.vertscore(0, "otto", nil, x, score)

puts "leftdiagscore"
test.leftdiagscore(0, "otto", nil, x, score)

puts "rightdiagscore"
test.rightdiagscore(0, "otto", nil, x, score)

puts "---------"
puts x.to_s

puts test.build_value_hash("otto")
