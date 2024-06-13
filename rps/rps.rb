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
	prompt("#{MESSAGES['username_1']} #{username}. #{MESSAGES['username_2']}")
	username 
end 

# Main Game 

def main_game
	username = get_username
end 	

main_game