require 'yaml'
MESSAGES = YAML.load_file('rps.yml')

# Constants

# Choices for the game 

CHOICES = ['Rock', 'Paper', 'Scissors', 'Lizard', 'Spock']

# Conditions to win the game

WIN_CONDITIONS = {
  
  # Conditions for letter input
  
  'R' => ['S', 'L', 'Scissors', 'Lizard'],
  'P' => ['R', 'Sp', 'Rock', 'Spock'],
  'S' => ['P', 'L', 'Paper', 'Lizard'],
  'L' => ['P', 'Sp', 'Paper', 'Spock'],
  'Sp' => ['R', 'S', 'Rock', 'Scissors'],
  
  # Conditions for full-word input
  
  'Rock' => ['S', 'L', 'Scissors', 'Lizard'],
  'Paper' => ['R', 'Sp', 'Rock', 'Spock'],
  'Scissors' => ['P', 'L', 'Paper', 'Lizard'],
  'Lizard' => ['P', 'Sp', 'Paper', 'Spock'],
  'Spock' => ['R', 'S', 'Rock', 'Scissors']
}


# Creating an Abbreviation Array Method

def abbreviate(choices)
  choices_abbreviations = []
  choices.each {|choice| choices_abbreviations << choice[0] }
  
  choices_abbreviations[4] = "Sp"
  choices_abbreviations
end 

# Validating user_input RENAME to choices_validation

def input_validation(n, choices, choices_abr)
  choices.include?(n) || choices_abr.include?(n) || n == 'Q'
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

# Displaying the User's Choice

def display_user(choice)
  case choice[1]
  when 'p' then prompt(MESSAGES['chose_spock'])
  else
    
    case choice[0]
    when 'R' then prompt(MESSAGES['chose_rock'])
    when 'P' then prompt(MESSAGES['chose_paper'])
    when 'S' then prompt(MESSAGES['chose_scissors'])
    when 'L' then prompt(MESSAGES['chose_lizard'])
    end
    
  end
end 


# Getting the User's Choice

def get_user_choice(choices, choices_abr)
  user_choice = ''
  loop do
    prompt(MESSAGES['user_choice'])
    user_choice = gets.chomp.capitalize

    break if input_validation(user_choice, choices, choices_abr)
    prompt(MESSAGES['user_choice_error'])
  end
  display_user(user_choice)
  user_choice
end

# Displaying the Computer's Choice

def display_comp(choice)
  case choice
  when 'R' then prompt(MESSAGES['comp_rock'])
  when 'P' then prompt(MESSAGES['comp_paper'])
  when 'S' then prompt(MESSAGES['comp_scissors'])
  when 'L' then prompt(MESSAGES['comp_lizard'])
  when 'Sp' then prompt(MESSAGES['comp_spock'])
  end
end

# Getting the Computer's Choice

def get_computer_choice
  choices_array = ['R', 'P', 'S', 'L', 'Sp']
  computer_choice = choices_array.sample

  display_comp(computer_choice)
  computer_choice
end

# Strings Collection for all Win/Loss Conditions

wins_losses_display_collection = {

  # User Wins
  'R_vs_S' => MESSAGES['user_won_rock_vs_scissors'],
  'P_vs_R' => MESSAGES['user_won_paper_vs_rock'],
  'S_vs_P' => MESSAGES['user_won_scissors_vs_paper'],
  'R_vs_L' => MESSAGES['user_won_rock_vs_lizard'],
  'L_vs_Sp' => MESSAGES['user_won_lizard_vs_spock'],
  'Sp_vs_S' => MESSAGES['user_won_spock_vs_scissors'],
  'S_vs_L' => MESSAGES['user_won_scissors_vs_lizard'],
  'L_vs_P' => MESSAGES['user_won_lizard_vs_paper'],
  'P_vs_Sp' => MESSAGES['user_won_paper_vs_spock'],
  'Sp_vs_R' => MESSAGES['user_won_spock_vs_rock'],

  # Computer Wins
  #'R_vs_P' => MESSAGES['comp_won_rock_vs_paper'],
  #'P_vs_S' => MESSAGES['comp_won_paper_vs_scissors'],
  #'S_vs_R' => MESSAGES['comp_won_scissors_vs_rock'],
  #'L_vs_R' => MESSAGES['comp_won_lizard_vs_rock'],
  #'Sp_vs_L' => MESSAGES['comp_won_spock_vs_lizard'],
  #'S_vs_Sp' => MESSAGES['comp_won_scissors_vs_spock'],
  #'L_vs_S' => MESSAGES['comp_won_lizard_vs_scissors'],
  #'P_vs_L' => MESSAGES['comp_won_paper_vs_lizard'],
  #'Sp_vs_P' => MESSAGES['comp_won_spock_vs_paper'],
  #'R_vs_Sp' => MESSAGES['comp_won_rock_vs_spock'],

  # Tie Game
  'R_vs_R' => MESSAGES['tie'],
  'P_vs_P' => MESSAGES['tie'],
  'S_vs_S' => MESSAGES['tie'],
  'L_vs_L' => MESSAGES['tie'],
  'Sp_vs_Sp' => MESSAGES['tie']
}

# Collecting display from the hash 

def return_user_result(hash, user_choice, computer_choice)
	
	if user_choice[1] == 'p'
    return hash["Sp_vs_#{computer_choice}"]
	else 
    return hash["#{user_choice[0]}_vs_#{computer_choice}"]
	end
end
	
	def return_computer_result(hash, user_choice, computer_choice)
	  if user_choice[1] == 'p'
		  return hash["#{computer_choice}_vs_Sp"]
	  else 
		  return hash["#{computer_choice}_vs_#{user_choice[0]}"]
	  end 
	end 

def find_winner(hash, first, second, conditions_hash)
	if conditions_hash[first].include?(second)
		return return_user_result(hash, first, second), "You get a point."
		
	elsif conditions_hash[second].include?(first)
		return return_computer_result(hash, first, second), "Rockbot gets a point."
	else 
		"tied point"	
	end 
end




# Returning the value from the collection
=begin
def return_result(hash, user_choice, computer_choice)
  if user_choice[1] == 'p'
    hash["Sp_vs_#{computer_choice}"]
  else 
    hash["#{user_choice[0]}_vs_#{computer_choice}"]
  end
end
=end 

# Display Win or Loss to the User

def display_win_loss(username, user_points, comp_points)
  prompt("#{username}, #{MESSAGES['win']}") if user_points == 3
  prompt("#{username}, #{MESSAGES['lose']}") if comp_points == 3
end

# Asking the User for a new game

def new_game?(_user_points, _comp_points)
  prompt(MESSAGES['new_game'])
  gets.chomp.upcase
end

# Let's Play

username = get_username
user_points = 0
comp_points = 0

loop do
  user_choice = get_user_choice(CHOICES, abbreviate(CHOICES))

  break if user_choice == 'Q'

  computer_choice = get_computer_choice
  result = find_winner(wins_losses_display_collection, user_choice,
                         computer_choice, WIN_CONDITIONS)

  prompt(result)

  if result[1].include?('You')
    user_points += 1
  elsif result[1].include?('Rockbot')
    comp_points += 1
  end

  prompt(format("You: %s / Rockbot: %s", user_points, comp_points))
  display_win_loss(username, user_points, comp_points)

  if user_points == 3 || comp_points == 3
    answer = new_game?(user_points, comp_points)

    break unless answer.start_with?('Y')
    user_points = 0
    comp_points = 0
  end
end

prompt("#{MESSAGES['thanks']} #{username}!")
