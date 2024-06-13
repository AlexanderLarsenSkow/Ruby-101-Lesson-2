=begin

Build a calculator that
  -asks for 2 numbers
  -asks for the type of operation to perform
  -displays the result

Programming methodology:
-loop
-gets.chomp, puts
-truthiness

=end

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(n)
  n.to_i.to_s == n
end

def valid_float?(n)
  n.to_s.to_f == n
end

def valid_operator?(operation)
  ['add', 'subtract', 'multiply', 'divide'].include?(operation)
end

def operation_to_message(op)
  message = case op
            when "add" then "Adding"
            when "subtract" then "Subtracting"
            when "multiply" then "Multiplying"
            when "divide" then "Dividing"
            end
  p "Almost there..."
  message
end

def result_message(x, y, result, operator)
  case operator
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
    prompt(MESSAGES['welcome'])
    name = gets.chomp.capitalize
    if name.empty?
      prompt(MESSAGES['valid_name'])
    else
      prompt("Hello, #{name}!")
      break
    end
  end

  loop do
    number_one = ''
    loop do
      prompt(MESSAGES['first_number'])
      number_one = gets.chomp

      break if valid_number?(number_one)
      prompt(MESSAGES['number_error'])
    end

    number_two = ''
    loop do
      prompt(MESSAGES['second_number'])
      number_two = gets.chomp

      break if valid_number?(number_two)
      prompt(MESSAGES['number_error'])
    end

    operation = ''
    loop do
      prompt(MESSAGES['operation'])
      prompt(%(
add
subtract
multiply
divide
			))

      operation = gets.chomp.downcase

      break if valid_operator?(operation)
      prompt(MESSAGES['operation_error'])
    end

    prompt("#{operation_to_message(operation)} the two numbers...")

    case operation

    when "add"
      add_result = number_one.to_i + number_two.to_i
      result_message(number_one, number_two, add_result, 'add')

    when "subtract"
      subtract_result = number_one.to_i - number_two.to_i
      result_message(number_one, number_two, subtract_result, 'subtract')

    when "multiply"
      multiply_result = number_one.to_i * number_two.to_i
      result_message(number_one, number_two, multiply_result, 'multiply')

    when "divide"
      divide_result = number_one.to_f / number_two.to_f
      result_message(number_one, number_two, divide_result, 'divide')

    end

    prompt(MESSAGES['try_again'])
    answer = gets.chomp.upcase
    break unless answer.start_with?('Y')
  end

  prompt("Thanks for using the calulator #{name}!")
end

calculator

# Think of how you can refactor using another method and calling it inside the calculator method.
# Can use a method to save lines in the calculator method. more DRY code
