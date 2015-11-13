require 'spec_helper'

describe Game do
	
	it "has players" do
		game = Game.new
		has_players = false
		if game.player_x && game.player_o
			has_players = true
		end
		expect(has_players).to eq true

	end

end

#it's the same problem again, that I need to split everything up into ui and backend