require "spec_helper"

describe ConnectFourBackEnd do 

	before(:each) do
		@c4 = ConnectFourBackEnd.new
	end

	context "at the beginning" do
		
		it "makes a game board" do
			expect(@c4.game_board.any?).to eq true
		end

		it "game board has all slots" do
			expect(@c4.game_board.length).to eq 42
		end

		it "has two players" do
			has_players = false
			if @c4.player_x && @c4.player_o
				has_players = true
			end
			expect(has_players).to eq true
		end

	end

	context "during each turn" do
	
		it "creates a board string to display" do
			test_board_string = @c4.produce_game_board_string
			expect(test_board_string.length).to eq 161
		end

		context "while placing a token" do

			it "token falls correctly if column is empty" do
				@c4.current_player = @c4.player_x
				@c4.drop_token(4)
				expect(@c4.game_board["4-6"].owned_by_player).to eq @c4.player_x
			end

			it "token falls correctly if column already has tokens" do
				@c4.current_player = @c4.player_x
				@c4.game_board["4-6"].filled = true
				@c4.drop_token(4)
				expect(@c4.game_board["4-5"].owned_by_player).to eq @c4.player_x
			end

			it "game asks for retry if column is full" do
				@c4.current_player = @c4.player_x
				@c4.game_board["4-6"].filled = true
				@c4.game_board["4-5"].filled = true
				@c4.game_board["4-4"].filled = true
				@c4.game_board["4-3"].filled = true
				@c4.game_board["4-2"].filled = true
				@c4.game_board["4-1"].filled = true
				expect(@c4.drop_token(4)).to eq "That column is full. Please choose another column"
			end

		end

	end

	context "at the end" do

		it "four in a horizontal row triggers a win" do
			@c4.game_board["1-6"].owned_by_player = @c4.player_x
			@c4.game_board["2-6"].owned_by_player = @c4.player_x
			@c4.game_board["3-6"].owned_by_player = @c4.player_x
			@c4.drop_token(4)
			expect(@c4.game_won).to eq true
		end

		#this will pass manually, so I think the test is wrong?
		it "four in a vertical row triggers a win" do
			@c4.game_board["1-6"].owned_by_player = @c4.player_x
			@c4.game_board["1-6"].filled = true
			@c4.game_board["1-5"].owned_by_player = @c4.player_x
			@c4.game_board["1-5"].filled = true
			@c4.game_board["1-4"].owned_by_player = @c4.player_x
			@c4.game_board["1-4"].filled = true
			@c4.drop_token(1)
			expect(@c4.game_won).to eq true
		end

	end
	
end