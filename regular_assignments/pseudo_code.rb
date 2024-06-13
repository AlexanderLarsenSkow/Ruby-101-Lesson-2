# Using LS's pseudo code to try and solve a problem.

=begin

START

# Given a collection of integers called "numbers"

SET iterator = 1
SET saved_number = value within numbers collection at space 1

WHILE iterator <= length of numbers
  SET current_number = value within numbers collection at space "iterator"
  IF saved_number >= current_number
    go to the next iteration
  ELSE
    saved_number = current_number

  iterator = iterator + 1

PRINT saved_number

END

=end 

integers = [1, 7, 23, 5, 8, 12]

def find_greatest_number(array) 
	saved_number = array[0] 
	
	array.each do |n| 
		if saved_number > n 
			next 
		else 
			saved_number = n 
		end 
	end 
	saved_number 
end  

puts find_greatest_number(integers)

	