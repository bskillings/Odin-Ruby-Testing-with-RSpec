class GameBackEnd

	attr_accessor :player_won, :swap_player, :current_player

	#Setting up a new game
	def initialize
		@board_status = new_board()
		@player_x = Player.new("X")
		@player_o = Player.new("O")
		@current_player = @player_x
		@swap_player = false
		@win_conditions = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
		@player_won = false
		show_board()
	end

	#Creating a blank board
	def new_board()
		@default_box = " - "
		blank_board = Hash.new
		i = 1
		while i < 10
			blank_board[i] = @default_box
			i += 1
		end
		return blank_board
	end

	#return string that shows board on command line
	def show_board
		i = 1
		game_board_string = "\r\n"
		while i < 10
			game_board_string += @board_status[i]
			if i % 3 == 0
				game_board_string += "\r\n"
			end
			i += 1
		end
		game_board_string += "\r\n"
		return game_board_string
	end

	#perform back end on turn
	def turn_back_end(chosen_box)
		fill_box(chosen_box)
		if check_if_won(@current_player.boxes_filled) == true
			@player_won = true
		else
			@current_player = (@current_player.marker == @player_x.marker ? @player_o : @player_x)
		end
		@swap_player = false

	end

	#check win conditions against player's array of filled boxes
	def check_if_won(player_boxes)
		@win_conditions.each do |row|
			test_row = row.dup
			player_boxes.each do |element| 
				if test_row.include?(element) 
					test_row.delete(element)
				end
			end
			if test_row.empty?
				return true
			end
		end
		return false
	end


	#returning strings to UI, swapping player if okay
	def check_box?(box)
		unless @board_status.keys.include?(box)
			return "please choose a square like this\r\n1 2 3\r\n4 5 6\r\n7 8 9"
		end
		unless @board_status[box] == @default_box
			return "Something is already there"
		end
		@swap_player = true
		return ""
	end

	#put move into gameboard
	def fill_box(box)
		@current_player.boxes_filled.push(box)
		@board_status[box] = " #{@current_player.marker} "
	end

end

class GameUI

	def initialize
		@game = GameBackEnd.new
		play_game
	end

	#game in process
	def play_game
		@turns_taken = 1
		while @turns_taken < 10
			turn_front_end
			@turns_taken += 1
		end
		puts "Filled with no winner! Game over!"
		return
	end

	#get input, show results
	def turn_front_end() 
		puts "turn number #{@turns_taken}"
		if @game.player_won == false
			while @game.swap_player == false 
				puts "#{@game.current_player.marker}, please choose a square (1-9)"
				chosen_box = gets.chomp.to_i
				puts @game.check_box?(chosen_box)
			end
			puts "#{@game.current_player.marker} chose #{chosen_box.to_s}"
			@game.turn_back_end(chosen_box)
			if @game.player_won
				puts "#{@game.current_player.marker} won!"
				@turns_taken = 100
			end
			puts @game.show_board
		end
	end

end

class Player

	attr_accessor :marker 
	attr_accessor :boxes_filled

	def initialize(marker)
		@marker = marker
		@boxes_filled = []
	end

	def make_a_move(box)
		@boxes_filled.push(box)
	end

end

