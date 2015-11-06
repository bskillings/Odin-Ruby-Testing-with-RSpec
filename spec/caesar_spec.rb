require 'spec_helper'

describe Caesar do 
	
	describe "#shift_code" do
		it "offsets the letters" do
			caesar = Caesar.new("Becky", 1)
			output = caesar.shift_code 
			expect(output). to eq("Cfdlz")
		end
		
	end
end
	

#something is wrong here.  the test won't even run