require 'spec_helper'

describe GameBackEnd do
	
	before(:each) do
		@game = GameBackEnd.new
	end

	context "when game begins" do
		it "has both players" do
			has_players = false
			if @game.player_x && @game.player_o
				has_players = true
			end
			expect(has_players).to eq true
		end

		it "has a game board" do
			expect(@game.board_status.all?).to eq true
		end

		it "board is blank" do
			board_is_blank = true
			@game.board_status.each do |k, v|
				unless v == " - "
					board_is_blank = false
				end
			end
			expect(board_is_blank).to eq true
		end
	end

	context "when player makes a guess" do

		context "when chosen box is blank" do

			it "fills the empty box" do
				@game.fill_box(5)
				expect(@game.board_status[5]).not_to eq " - "
			end

			it "fills with the correct player marker" do
				@game.current_player = @game.player_o
				@game.fill_box(5)
				expect(@game.board_status[5]).to eq " O "
			end
		end

		context "when chosen box is full" do

			it "returns an error message -- box full" do
				@game.fill_box(5)
				expect(@game.check_box(5)).to eq "Something is already there"
			end
		end

		context "when chosen box is not on board" do

			it "returns an error message - box not on board" do
				expect(@game.check_box(20)).to eq "please choose a square like this\r\n1 2 3\r\n4 5 6\r\n7 8 9"
			end

		end

	end

	context "when third box in a row is filled" do

		it "triggers a win if all match" do
			@game.player_x.boxes_filled = [1, 2]
			@game.current_player = @game.player_x
			@game.turn_back_end(3)
			expect(@game.player_won).to eq true
		end

		it "does not trigger a win if all do not match" do
			@game.player_x.boxes_filled = [1, 2]
			@game.current_player = @game.player_o
			@game.turn_back_end(3)
			expect(@game.player_won).to eq false
		end

	end

end



#it's the same problem again, that I need to split everything up into ui and backend