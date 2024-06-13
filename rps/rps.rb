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
		else 
			prompt(MESSAGES['chose_scissors'])
	end 
	prompt(MESSAGES['commence_battle'])
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

# Main Game 

def main_game
	username = get_username
	user_choice = get_user_choice 
end 	

main_game