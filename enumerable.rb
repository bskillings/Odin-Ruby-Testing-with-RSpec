module Enumerable
	def my_each
		i = 0
		while i < self.size
			yield(self[i])
			i += 1
		end
		self #forgot to put anything here for it to return
	end

	def my_each_with_index
		i = 0
		while i < self.size
			yield(self[i], i)
			i += 1
		end
	end

	def my_select
		results = [] 
		self.my_each do |n|
			if yield(n)
				results.push(n)
			end
		end
		puts results
	end

	def my_all?
		self.my_each do |n|
			if yield(n) == false
				return false
			end
		end
		return true
	end

	def my_any?
		self.my_each do |n|
			if yield(n) == true
				return true
			end
		end
		return false
	end

	def my_none?
		self.my_each do |n|
			if yield(n) == true
				return false
			end
		end
		return true

	end

	def my_count
		total = 0
		if block_given?
			self.my_each do |n|
				if yield(n) == true
					total += 1
				end
			end
		else
			self.my_each do |n|
				total += 1
			end
		end
		total
	end

#NOT WORKING WITH BOTH

#okay a lot of people are doing (proc=nil) as an argument and saying if proc && block_given?

	def my_map(some_proc = nil)
		results = []
		self.my_each do |n|
			if some_proc && block_given?
				results.push(some_proc.call(yield(n)))
			elsif !block_given?
				results.push(some_proc.call(n))
			end
		end
		results
	end

	#okay I'll take that
	

	#This is what it looked like with blocks
	#def my_map
	#	results = []
	#	self.my_each do |n|
	#		results.push(yield(n))
	#	end
	#	results
	#end

	def my_inject#(*start)
		#current_index = 0
		#result = 0
		#if start
		#	result = start 
	#	else
			result = self[0]
			current_index = 1
	#	end
		while current_index < self.size
			result = yield result, self[current_index]
			current_index += 1
		end
		result
		#inject is cumulative over the array.  the first argument is the running result, the second is this element
	end

	def multiply_els
		self.my_inject{|result, element| result * element}
	end

end

class Input

	def initialize
		test_array = [1,3,5,7,9]
		puts "each "
		test_array.each {|n| puts (n*2).to_s}
		puts test_array.each  {|n| n*2}
		puts "my_each "
		test_array.my_each {|n| puts (n*2).to_s}
		puts test_array.my_each  {|n| n*2}
		puts "each_with_index"
		test_array.each_with_index {|n, i| puts "#{n} is at index #{i}"}
		puts "my_each_with_index"
		test_array.my_each_with_index {|n, i| puts "#{n} is at index #{i}"}
		puts "select"
		puts test_array.select {|n| n > 4}
		puts "my_select"
		puts test_array.my_select {|n| n > 4}
		puts "all?"
		puts test_array.all? {|n| n > 5}
		puts "my_all?"
		puts test_array.my_all? {|n| n > 5}
		puts "any?"
		puts test_array.any? {|n| n > 5}
		puts "my_any?"
		puts test_array.my_any? {|n| n > 5}
		puts "none?"
		puts test_array.none? {|n| n > 5}
		puts "my_none?"
		puts test_array.my_none? {|n| n > 5}
		puts "count"
		puts test_array.count.to_s
		puts "my_count"
		puts test_array.my_count.to_s
		puts "count with block"
		puts test_array.count {|n| n > 5}
		puts "my_count with block"
		puts test_array.my_count {|n| n > 5}
		puts "map"
		puts test_array.map {|n| n*2}
		puts "my_map"
		puts test_array.my_map {|n| n*2}
		puts "inject"
		puts test_array.inject { |result, element| result + element}
		puts "my_inject"
		puts test_array.my_inject { |result, element| result + element}
		puts "multiply els"
		multiply_els_array = [2, 4, 5]
		puts multiply_els_array.multiply_els.to_s


		triple = Proc.new do |n|
				n * 3
			end

		puts "testing my_map with proc"
		puts test_array.my_map(triple) 
		puts "testing my_map with proc and block"
		puts test_array.my_map(triple) {|n| n + 1}
	end

end