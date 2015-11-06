class Caesar

	attr_accessor :input, :offset, :output

	def initialize (input, offset)
		@input = input
		@offset = offset
		@output = shift_code
		output_code(@output)
	end

	def shift_code	
		characters = @input.split("")
		numbers = []
		characters.each do |c|
			code = c.ord
			if c.ord != 32
				code += @offset
			end
			if (code > 90 && code < 97) || code > 122
					code -= 26
			end

			numbers.push(code)
		end
		coded_chars = []
		numbers.each do |n|
			coded_chars.push(n.chr)
		end
		output = coded_chars.join

		return output
	end

	def output_code(output)
		puts output
	end

end

#puts "enter phrase to encode"
#input = gets.chomp
#puts "enter offset"
#offset = gets.chomp.to_i
		
#caesar = Caesar.new(input, offset)