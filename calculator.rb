=begin 

Build a calculator that 
	-asks for 2 numbers 
	-asks for the type of operation to perform
	-displays the result

Expected Input: the program will use gets.chomp to ask the user for 2 numbers and for a mathematicaly operation to perform.

Expected Output: The program will output the answers to the math problem the user wanted to answer. Afterwards, it will
ask if they want to start a new math equation, meaning it will loop.

Programming methodology: 
-loop
-gets.chomp, puts 
-truthiness


=end 

def prompt(message)
	puts "=> #{message}"
end 

def valid_number?(n) 
	n.to_i != 0 
end 

def valid_operator?(operation)
	if ['add', 'subtract', 'multiply', 'divide'].include?(operation) 
		true
	else 
		false 
	end 
end 

def operation_to_message(op) 
	case op 
		when "add" then "Adding"
		when "subtract" then "Subtracting"
		when "multiply" then "Multiplying"
		when "divide" then "Dividing"
	end 
end

def result_message(x, y, result, operator)
	
	result = case operator
		when "add"
			puts "#{x} + #{y} = #{result}!"
		
		when "subtract"
			puts "#{x} - #{y} = #{result}!"
			
		when "multiply"
			puts "#{x} x #{y} = #{result}!"
		
		when "divide"
			puts "#{x} / #{y} = #{result}!"
		end 
end 


def calculator 
	 
	name = ''
	loop do 
		prompt("Welcome to the calculator. Enter your name:")
		name = gets.chomp.capitalize
		if name.empty?
			prompt("Make sure to use a valid name.")
		else 
			prompt("Hello, #{name}!")
			break
		end 
	end
		
	loop do
		
		number_one = ''
		loop do
			prompt("Choose your first number.")
			number_one = gets.chomp.to_i 
			
			break if valid_number?(number_one)
			prompt("Input Error: please enter a valid integer greater or less than 0.")
		end 	
	
		number_two = ''
		loop do	
			prompt("What about the second number?")
			number_two = gets.chomp.to_i 
			
			break if valid_number?(number_two)
			prompt("Input Error: please enter a valid integer greater or less than 0.")
		end 
		
		operation = ''
		loop do	
			prompt("What kind of operation would you like to do?")
			prompt(%(
add
subtract
multiply
divide
			))
			
				
			operation = gets.chomp.downcase
	
			break if valid_operator?(operation)
			prompt("Input Error: please enter add, subtract, multiply, or divide.")

		end 
		
		prompt("#{operation_to_message(operation)} the two numbers...")
		
		case operation
		
			when "add"
				add_result = number_one + number_two
				result_message(number_one, number_two, add_result, 'add')
				
			when "subtract"
				subtract_result = number_one - number_two
				result_message(number_one, number_two, subtract_result, 'subtract')

				
			when "multiply"
				multiply_result = number_one * number_two
				result_message(number_one, number_two, multiply_result, 'multiply')

				
			when "divide"
				divide_result = number_one.to_f / number_two.to_f
				result_message(number_one, number_two, divide_result, 'divide')

				
		end 

		prompt("Would you like to try again? (Y / N)")
		answer = gets.chomp.upcase
		break unless answer.start_with?('Y')
		
	end
	
	prompt("Thanks for using the calulator #{name}!")
end 

 calculator

	# Think of how you can refactor using another method and calling it inside the calculator method. 
	# Can use a method to save lines in the calculator method. more DRY code
