class Sudoku
  attr_accessor :board_arr
  def initialize(board_string)
  	@board_arr = string_to_array(board_string)
  end

  #the big solving brain
  def solved
  	empty, row, col = still_empty?(@board_arr)
  	if (!empty)
  		return true
  	end
  	for num in 1..9
  		if(is_valid_slot?(@board_arr, row, col, num.to_s))
  			@board_arr[row][col] = num.to_s
  			if solved
  				return true
  			else
  				@board_arr[row][col]='0'
  			end
  		end
  	end
  	return false
  end

  #solve! function just to pass rspec test
  def solve!
  	if(solved)
  		return array_to_string(@board_arr)
  	else
  		return 'Uh oh...'
  	end
  end

  #convert string to array to solve
  def string_to_array(string)
  	arr = Array.new(9){Array.new(9)}
  	for i in 0..8
  		for j in 0..8
  			arr[i][j] = string[i*9+j]
  		end
  	end
  	return arr
  end

  #convert board array back to string to print
  def array_to_string(array)
  	str = ""
  	for i in 0..8
  		str += array[i].join("")
  	end
  	return str
  end

  # Returns a string representing the current state of the board
  # Don't spend too much time on this method; flag someone from staff
  # if you are.
  def board
  	print_board = array_to_string(@board_arr)
  	print_board.split("").each_slice(9) do |row|
  		new_row = row.map do |cell|
  			if (cell == '0')
  				cell = '_'
  			else
  				cell = cell
  			end
  		end
  	p new_row.join(" ")
  	end
  	if !solved
  		puts 'No solution'
  	else
  		puts 'Congratulations, your sudoku has now been solved!'
  	end
  end

  #Check if there are still any unallocated empty slots
  def still_empty?(arr)
  	for i in 0..arr.length-1
  		for j in 0..arr[0].length-1
		  	if arr[i][j] == '0'
		  		return true , i, j
		  	end
		end
	end
	return false
  end

  #Compare current cell against its row
  def in_row?(arr,row,value)
  	for j in 0..8
  		if @board_arr[row][j] == value
  			return true
  		end
  	end
  	return false
  end

  #Compare current cell against its column
  def in_col?(arr,col,value)
  	for i in 0..8
  		if @board_arr[i][col] == value
  			return true
  		end
  	end
  	return false
  end

  #Compare current cell against its box
  def in_box?(arr,row,col,value)
  	for i in 0..2
  		for j in 0..2
  			if(arr[row-row%3+i][col-col%3+j] == value)
  				return true
  			end
  		end
  	end
  	return false
  end

  def is_valid_slot?(arr,row,col,value)
  	return !(in_row?(arr,row,value) or in_col?(arr,col,value) or in_box?(arr,row,col,value))
  end

end #Class' end, DO NOT DELETE

# The file has newlines at the end of each line, so we call
# String#chomp to remove them.
board_string = File.readlines('sample_unsolved.txt').first.chomp
game = Sudoku.new(board_string)
game.board
# Remember: this will just fill out all the "logically necessary" cells and not "guess"
start = Time.now
game.solve!
p Time.now - start

# prints the board with nice formatting to the user
game.board

