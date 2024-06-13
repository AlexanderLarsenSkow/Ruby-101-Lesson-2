=begin 

Create a method that returns the sum of two integers.

START: start of the program
SET: set the arguments x and y 
CALCULATE: calculate the values.
SET VALUE: set value = to new variable 
PRINT: Display the values
END: End of the program.

=end 

def add(x, y) 
	result = x + y
	"#{x} + #{y} = #{result}!"
end 

puts add(10, 5)

=begin 

Create a method that takes an array of strings, and returns a string that is all those strings concactenated together.

Given a collection of strings
Join the different pieces togetehr in the array.
You must get back 1 whole string that includes each piece from the collection.

=end 

my_collection = ['yabba', ',', ' dabba', ',', ' dooooooooooo', '!']

def the_ultimate_string_maker(array)
	array.join		
end 
	
puts the_ultimate_string_maker(my_collection)

=begin 

Take an array of integers and return a new array that skips every other integer from the original array.

Take a collection of integers. 
Iterate through them.
Based on the index of the array, remove every integer that is indexed to an even number.
return the new array.

=end 

my_integers = [10, 20, 30, 40, 50, 60, 70, 80, 90]


def skip_the_evens(array) 
	x = 0
	new_arr = []
	
	while x <= array.length
		
		new_arr << array[x] if x.even?
		x += 1
	end 
	
	new_arr
end 

puts skip_the_evens(my_integers) # => [10, 30, 50, 70, 90]

=begin 

We want the index of the 3rd occurrence of a given character in a string.
So, we need to use a method to find how many versions of the character there are. 
Then we need to find the 3rd version's index.
Return nil if there's less than 3 versions. 

Things we can use: 

each_char
.index method 

=end 



string_ex = 'axbxcdxex'

def get_the_3rd_iteration_of_char_index(string, char)
	
end 

# I will drop this one for now. Not sure how to translate this into code.



=begin 

Merge two arrays of integers so that the elements in the first array enter at the even indexes of the new array 
and the elements in the second array become the odd elements in the new array.

Given two collections of arrays 
Create a loop where you iterate through both collections. 
Push one number from the first collection into the new array then push a number from the 
second array. The loop should push every number into the new array in the order you specify.

=end 

even_integers = [0, 2, 4]
odd_integers = [1, 3, 5]

def merge(array1, array2) 
	count = 0
	new_arr = []
	
	while count < array1.length 
		new_arr << array1[count] 
		new_arr << array2[count]
		count += 1
	end 
	p new_arr
end


merge(even_integers, odd_integers)
