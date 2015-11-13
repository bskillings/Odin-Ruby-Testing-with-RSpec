require 'spec_helper'

describe Caesar do 
	
	describe "#shift_code" do
		it "offsets the letters" do
			caesar = Caesar.new("becky", 1)
			cipher = caesar.shift_code
			expect(cipher). to eq("cfdlz")
		end
		
		it "keeps spaces" do
			caesar = Caesar.new("becky s", 1)
			cipher = caesar.shift_code
			expect(cipher). to eq("cfdlz t")
		end
	
		it "keeps capitalization" do
			caesar = Caesar.new("Becky S", 1)
			cipher = caesar.shift_code
			expect(cipher). to eq("Cfdlz T")
		end
	
		it "wraps the alphabet" do
			caesar = Caesar.new("Becky S", 10)
			cipher = caesar.shift_code
			expect(cipher). to eq("Lomui C")
		end
	
	end
end
	
