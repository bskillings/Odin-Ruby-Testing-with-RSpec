class ConnectFourBackEnd

	attr_accessor :game_board, :player_x, :player_o, :current_player, :game_won

	def initialize
		@game_board = create_game_board
		@player_x = ConnectFourPlayer.new("X")
		@player_o = ConnectFourPlayer.new("O")
		@current_player = @player_x
		@game_won = false
	end

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
		@current_player = @current_player == @player_x ? @player_o : @player_x
		return produce_game_board_string
	end

end

class ConnectFourLocation

	attr_accessor :owned_by_player, :filled

	def initialize
		@owned_by_player = nil
		@filled = false
	end
end

class ConnectFourPlayer

	attr_accessor :marker

	def initialize(marker)
		@marker = marker
	end
end

class ConnectFourFrontEnd

	def initialize
		@game = ConnectFourBackEnd.new	
		play_game	
	end

	def play_game
		puts @game.produce_game_board_string
		while @game.game_won == false
			turn_front_end
		end
		announce_winner
	end

	def turn_front_end
		puts "\r\nPlayer #{@game.current_player.marker}, choose a column"
		column = gets.chomp
		while (column.to_i > 7 || column.to_i < 1) || column == ""
			puts "Player #{@game.current_player.marker}, Please choose a column 1-7"
			column = gets.chomp
		end
	
		puts @game.drop_token(column)
	end

	def announce_winner

	end


end


#test_game = ConnectFourFrontEnd.new
#i separated the front end and back end, but should I be using mocks and stubs instead?
#I really don't understand them.