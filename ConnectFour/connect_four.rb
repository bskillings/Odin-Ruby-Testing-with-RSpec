class ConnectFourBackEnd

	attr_accessor :game_board, :player_x, :player_o, :current_player, :game_won

	def initialize
		@game_board = create_game_board
		@player_x = ConnectFourPlayer.new("X")
		@player_o = ConnectFourPlayer.new("O")
		@current_player = @player_x
		@game_won = false
	end

	#sets up the hash of holes
	def create_game_board
		new_board = {}
		i = 1
		6.times do 
			j = 1
			7.times do
				current_key = "#{j}-#{i}"
				new_board[current_key] = ConnectFourLocation.new
				j += 1
			end
			i += 1
		end
		return new_board
	end

	#uses @game_board to create a string to pass back to the UI to show
	def produce_game_board_string
		game_board_string = " 1  2  3  4  5  6  7 \r\n"
		@game_board.each do |key, hole|
			if hole.owned_by_player == nil
				game_board_string.concat(" - ")
			else
				game_board_string.concat(" #{hole.owned_by_player.marker} ")
			end
			if /7/.match(key)
				game_board_string.concat("\r\n")
			end
		end
		return game_board_string
	end

	#takes the column, performs logic, and returns a string
	def drop_token(column)
		y_coordinate = 6
		hole_to_check = @game_board["#{column}-#{y_coordinate}"]
		while hole_to_check.filled
			y_coordinate = y_coordinate - 1
			if y_coordinate < 1
				return "That column is full. Please choose another column"
			end
			hole_to_check = @game_board["#{column}-#{y_coordinate}"]
		end
		hole_to_check.owned_by_player = @current_player
		hole_to_check.filled = true
		@current_player.holes_owned.push(hole_to_check)
		check_for_winner
		if @game_won == false
			@current_player = @current_player == @player_x ? @player_o : @player_x
		end
		return produce_game_board_string
	end

	#goes holy by hole, triggers checking in lines
	def check_for_winner
		did_player_win = false
		x = 1
		while x < 8
			y = 1
			while y < 7
				current_key = "#{x}-#{y}"
				current_hole = game_board[current_key]
				@x_to_check = x
				@y_to_check = y
				if current_hole.owned_by_player == @current_player
					did_player_win = check_for_line(x, y)
					if did_player_win
						return true
					end
				end
				y += 1
			end
			x += 1
		end
		return false
	end

	#checks for four in a row from given hole
	def check_for_line(original_x, original_y)
		@direction = 1
			@line_count = 1
			if check_next_holes(original_x, original_y)
				return true
			end
		return false
	end

	#recursive, identifying owner and going on if owner is the same
	def check_next_holes(original_x, original_y)
		if @direction == 1
			x = original_x + 1
			y = original_y + 0
		elsif @direction == 2
			x = original_x + 1
			y = original_y + 1
		elsif @direction == 3
			x = original_x + 0
			y = original_y + 1
		elsif @direction == 4
			x = original_x - 1
			y = original_y + 1
		elsif @direction == 5
			x = original_x - 1
			y = original_y + 0
		elsif @direction == 6
			x = original_x - 1
			y = original_y - 1
		elsif @direction == 7
			x = original_x + 0
			y = original_y - 1
		elsif @direction == 8
			x = original_x + 1
			y = original_y - 1
		else
			x = 0
		end
		
		if x > 0 && x < 8 && y > 0 && y < 7 && @game_won == false
			new_key = "#{x}-#{y}"
			if @game_board[new_key].owned_by_player == @current_player
				@line_count += 1
				if @line_count == 4
					@game_won = true
					return true
				else
					return check_next_holes(x, y)
				end
			else
				@direction += 1
				if @direction > 8
					return false
				else
					@line_count = 1
					return check_next_holes(@x_to_check, @y_to_check)
				end
			end
		end
	end

end

class ConnectFourLocation

	#Referred to as holes
	attr_accessor :owned_by_player, :filled

	def initialize
		@owned_by_player = nil
		@filled = false
	end
end

class ConnectFourPlayer

	attr_accessor :marker, :holes_owned

	def initialize(marker)
		@holes_owned = []
		@marker = marker
	end
end

class ConnectFourFrontEnd

	#Separates input/ output from logic
	def initialize
		@game = ConnectFourBackEnd.new	
		play_game	
	end

	#bookends game
	def play_game
		puts @game.produce_game_board_string
		turn_front_end
		announce_winner
	end

	#gets input from player
	def turn_front_end
		while @game.game_won == false
			puts "\r\nPlayer #{@game.current_player.marker}, choose a column"
			column = gets.chomp
			while (column.to_i > 7 || column.to_i < 1) || column == ""
				puts "Player #{@game.current_player.marker}, Please choose a column 1-7"
				column = gets.chomp
			end
		
			puts @game.drop_token(column)
		end
	end

	#outputs winner message
	def announce_winner
		puts "\r\nWe have a winner!"
		puts "#{@game.current_player.marker} won!"
	end


end


#test_game = ConnectFourFrontEnd.new
