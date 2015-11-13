require 'spec_helper'

describe BubbleSort do 

	describe "#bubble_sort" do

		it "sorts an array" do
			bubble = BubbleSort.new([4, 3, 78, 1, 0, 2])
			sorted_values = bubble.sorted
			expect(sorted_values). to eq([0, 1, 2, 3, 4, 78])
		end

		it "keeps duplicate values" do
			bubble = BubbleSort.new([4, 3, 78, 2, 0, 2])
			sorted_values = bubble.sorted
			expect(sorted_values). to eq([0, 2, 2, 3, 4, 78])
		end

		context "given an empty array" do
			it "returns an empty array" do
				bubble = BubbleSort.new([])
				sorted_values = bubble.sorted
				expect(sorted_values). to eq([])
			end
		end

	end
	
end