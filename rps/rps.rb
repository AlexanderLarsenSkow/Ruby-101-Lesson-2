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

def responses(user_choice) 
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
	responses(user_choice)
	user_choice
end 

# Getting the Computer's Choice

def get_computer_choice
	choices_array = [1, 2, 3]
	computer_choice = choices_array.sample
	
	case computer_choice
		when 1 then prompt(MESSAGES['comp_rock']) 
		when 2 then prompt(MESSAGES['comp_paper'])
		when 3 then prompt(MESSAGES['comp_ascissors'])
	end 
	computer_choice
end 

# Defining the Game's Logic 

def game_logic(user_choice, computer_choice) 
	if user_choice == computer_choice 
		prompt(MESSAGES['tie'])
	elsif user_choice == 1 && computer_choice == 2
		prompt(MESSAGES['comp_won_paper'])
	elsif user_choice == 1 && computer_choice == 3
		prompt(MESSAGES['user_won_rock'])
	elsif user_choice == 2 && computer_choice == 1
		prompt(MESSAGES['user_won_paper']) 
	elsif user_choice == 2 && computer_choice == 3
		prompt(MESSAGES['comp_won_scissors']) 
	elsif user_choice == 3 && computer_choice == 1
		prompt(MESSAGES['comp_won_rock'])
	else 
		prompt(MESSAGES['user_won_scissors'])
	end 
end 

# Main Game 

def main_game
	username = get_username

	loop do
		user_choice = get_user_choice
		computer_choice = get_computer_choice
		game_logic(user_choice, computer_choice)
	end 
end 	

main_game