require 'spec_helper'

describe Enumerable do 

	describe "#my_each" do

		before(:each) do
			@my_each_test = []
		end

		context "given an array of integers" do
		
			it "returns correctly added integers" do
				[1, 2, 3, 4].my_each {|x| @my_each_test.push(x + 1)}
				expect(@my_each_test). to eq([2, 3, 4, 5])
			end

			it "returns correctly multiplied integers" do
				[1, 2, 3, 4].my_each {|x| @my_each_test.push(x * 2)}
				expect(@my_each_test). to eq([2, 4, 6, 8])
			end

			it "returns correctly divided integers" do
				[2, 4, 6, 8].my_each {|x| @my_each_test.push(x/2)}
				expect(@my_each_test). to eq([1, 2, 3, 4])
			end

			it "does not return floats" do
				[2, 3, 4, 5].my_each {|x| @my_each_test.push(x/2)}
				expect(@my_each_test). to eq([1, 1, 2, 2])
			end

		end

		context "given an array of strings" do

			it "returns concatenated strings" do
				["Hi", "Hello", "Howdy"].my_each {|s| @my_each_test.push(s + ", Becky")}
				expect(@my_each_test). to eq(["Hi, Becky", "Hello, Becky", "Howdy, Becky"])
			end
				
		end

		context "given an empty array" do

			it "returns an empty array" do
				[].my_each {|s| @my_each_test.push(s + ", Becky")}
				expect(@my_each_test). to eq([])
			end
				
		end

	end

	describe "#my_all?" do

		context "given block searching for true" do

			it "returns true if all are true" do
				my_all_test = [true, true, true].my_all?{|x| x == true}
				expect(my_all_test).to eq true
			end

			it "returns false if not all are true" do
				my_all_test = [true, false, true].my_all?{|x| x == true}
				expect(my_all_test).to eq false
			end

			it "returns false if all are false" do
				my_all_test = [false, false, false].my_all?{|x| x == true}
				expect(my_all_test).to eq false
			end

			context "given an empty array" do

				it "returns true" do
					my_all_test = [].my_all?{|x| x == true}
					expect(my_all_test).to eq true
				end

			end

		end

		context "given block searching for false" do

			it "returns true if all are true" do
				my_all_test = [true, true, true].my_all?{|x| x == false}
				expect(my_all_test).to eq false
			end

			it "returns false if not all are true" do
				my_all_test = [true, false, true].my_all?{|x| x == false}
				expect(my_all_test).to eq false
			end

			it "returns false if all are false" do
				my_all_test = [false, false, false].my_all?{|x| x == false}
				expect(my_all_test).to eq true
			end
			context "given an empty array" do

				it "returns true" do
					my_all_test = [].my_all?{|x| x == false}
					expect(my_all_test).to eq true
				end

			end

		end

	end
	
	describe "#my_any?" do

		context "given block searching for true" do

			it "returns true if all are true" do
				my_any_test = [true, true, true].my_any?{|x| x == true}
				expect(my_any_test).to eq true
			end

			it "returns false if not all are true" do
				my_any_test = [true, false, true].my_any?{|x| x == true}
				expect(my_any_test).to eq true
			end

			it "returns false if all are false" do
				my_any_test = [false, false, false].my_any?{|x| x == true}
				expect(my_any_test).to eq false
			end

			context "given an empty array" do

				it "returns true" do
					my_any_test = [].my_any?{|x| x == true}
					expect(my_any_test).to eq false
				end

			end

		end

		context "given block searching for false" do

			it "returns true if all are true" do
				my_any_test = [true, true, true].my_any?{|x| x == false}
				expect(my_any_test).to eq false
			end

			it "returns false if not all are true" do
				my_any_test = [true, false, true].my_any?{|x| x == false}
				expect(my_any_test).to eq true
			end

			it "returns false if all are false" do
				my_any_test = [false, false, false].my_any?{|x| x == false}
				expect(my_any_test).to eq true
			end
			context "given an empty array" do

				it "returns true" do
					my_any_test = [].my_any?{|x| x == false}
					expect(my_any_test).to eq false
				end

			end

		end

	end

	describe "#my_count" do

		context "if block given" do
	
			it "counts things that are true" do
				my_count_test = [true, false, true].my_count{|x| x == true}
				expect(my_count_test). to eq 2
			end

		end

		context "if no block given" do

			it "counts all the things!" do
				my_count_test = [true, false, true].my_count
				expect(my_count_test). to eq 3
			end

		end

	end



	#this test will pass if I enable the my_map that doesn't allow for procs
	#but then of course procs don't work.
	#I think it's likely that I just don't understand my_map
	describe "#my_map" do

		it "correctly maps to each element" do
			my_map_test = [1, 2, 3]
			my_map_output = my_map_test.my_map{|x| x + 1}
			expect(my_map_output).to eq [2, 3, 4]
		end

	end

	describe "#multiply_els" do

		it "multiplies all the elements together" do
			multiply_els_test = [2, 4, 6].multiply_els
			expect(multiply_els_test). to eq 48
		end

	end

end