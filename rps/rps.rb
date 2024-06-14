require 'yaml'
MESSAGES = YAML.load_file('rps.yml')

# Validating user_input  

def input_validation(n)
	n == 1 || n == 2 || n == 3
end 

# Prompting the user

def prompt(string) 
	puts "<< #{string}"
end 

# Getting Username 

def get_username
	username = ''
	loop do 
		prompt(MESSAGES['welcome'])
		prompt(MESSAGES['name'])
		username = gets.chomp.capitalize 
		
		break unless username.empty?
		prompt(MESSAGES['username_error'])
	end 
	prompt("#{MESSAGES['username_1']} #{username}, #{MESSAGES['username_2']}")
	username 
end 

# Responding to the User's Choice

def display(user_choice) 
	case user_choice
		when 1 then prompt(MESSAGES['chose_rock'])
		when 2 then prompt(MESSAGES['chose_paper'])
		when 3 then prompt(MESSAGES['chose_scissors'])
	end 
end 

def get_user_choice
	user_choice = 0
	loop do 
		prompt(MESSAGES['user_choice'])
		user_choice = gets.chomp.to_i
		
		break if input_validation(user_choice)
		prompt(MESSAGES['user_choice_error'])
	end 
	display(user_choice)
	user_choice
end 

# Getting the Computer's Choice

def get_computer_choice
	choices_array = [1, 2, 3]
	computer_choice = choices_array.sample
	
	case computer_choice
		when 1 then prompt(MESSAGES['comp_rock']) 
		when 2 then prompt(MESSAGES['comp_paper'])
		when 3 then prompt(MESSAGES['comp_scissors'])
	end 
	computer_choice
end 

# Giving points to the User or Computer

def increment_for_comp(comp_points) 
	comp_points += 1
end 

def increment_for_user(user_points)
	user_points += 1 
end 

# Defining the Game's Logic with Helper Methods

def tie_game(user_choice, computer_choice) 
	if user_choice == computer_choice
			prompt(MESSAGES['tie'])
	end 
end 

def user_win(user_choice, computer_choice, user_won)
	
	if user_choice == 1 && computer_choice == 3
		prompt(MESSAGES['user_won_rock'])
		user_won = true
		
	elsif user_choice == 2 && computer_choice == 1
		prompt(MESSAGES['user_won_paper'])
		user_won = true
		
	elsif user_choice == 3 && computer_choice == 2
		prompt(MESSAGES['user_won_scissors'])
		user_won = true
	end
end 

def comp_win(user_choice, computer_choice, comp_won)
	
	if user_choice == 1 && computer_choice == 2
		prompt(MESSAGES['comp_won_paper'])
		comp_won = true
		
	elsif user_choice == 2 && computer_choice == 3
		prompt(MESSAGES['comp_won_scissors'])
		comp_won = true

	elsif user_choice == 3 && computer_choice == 1
		prompt(MESSAGES['comp_won_rock'])
		comp_won = true
	end 
end 

# Primmary Logic Method

def game_logic(user_choice, computer_choice) 
	user_won = false
	comp_won = false
	
	tie_point = tie_game(user_choice, computer_choice)
	user_won = user_win(user_choice, computer_choice, user_won)
	comp_won = comp_win(user_choice, computer_choice, comp_won)
	
	if user_won == true 
		true 
	elsif comp_won == true
		false 
	end
end 

# Main Game 

def main_game
	username = get_username
	
	user_points = 0
	comp_points = 0
	loop do
		user_choice = get_user_choice
		computer_choice = get_computer_choice
		result = game_logic(user_choice, computer_choice)
		
		if result == true 
			user_points += 1
		elsif result == false 
			comp_points += 1
		end 
		prompt("User: #{user_points} / Rockbot: #{comp_points}")
		
		break if user_points == 10 || break if comp_points == 10
	end 
end 	

main_game