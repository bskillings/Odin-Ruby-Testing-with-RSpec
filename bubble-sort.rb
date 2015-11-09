class BubbleSort

	attr_accessor :sorted

	def initialize(sort_me)
		@sort_me = sort_me
		@sorted = bubble_sort
	end

	def bubble_sort
		j = 0
		sort_again = true
		to_be_sorted = @sort_me
		while (j < to_be_sorted.length - 1) && (sort_again == true)
			i = 0
			sort_again = false
			while i < to_be_sorted.length - 1
				if to_be_sorted[i] > to_be_sorted[i+1]
					to_be_sorted[i], to_be_sorted[i+1] = to_be_sorted[i+1], to_be_sorted[i]
					sort_again = true
				end
				i += 1
			end
		end
		return to_be_sorted
		#puts @to_be_sorted
	end

end

#bubble_sort([4, 3, 78, 2, 0, 2])