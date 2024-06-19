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

# String Collection for all Game Win/Loss Scenarios

DISPLAY_COLLECTION = {

  'R_vs_S' => MESSAGES['rock_beats_scissors'],
  'P_vs_R' => MESSAGES['paper_beats_rock'],
  'S_vs_P' => MESSAGES['scissors_beats_paper'],
  'R_vs_L' => MESSAGES['rock_beats_lizard'],
  'L_vs_Sp' => MESSAGES['lizard_beats_spock'],
  
  'Sp_vs_S' => MESSAGES['spock_beats_scissors'],
  'S_vs_L' => MESSAGES['scissors_beats_lizard'],
  'L_vs_P' => MESSAGES['lizard_beats_paper'],
  'P_vs_Sp' => MESSAGES['paper_beats_spock'],
  'Sp_vs_R' => MESSAGES['spock_beats_rock'],
}

# Abbreviating the CHOICES Array

def abbreviate(choices)
  choices_abbreviations = []
  choices.each {|choice| choices_abbreviations << choice[0] }
  
  choices_abbreviations[4] = "Sp"
  choices_abbreviations
end 

# Clearing and slowing display output to the terminal 

def clear
  system "clear"
end 

def sleep_for(seconds)
  sleep seconds
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
  sleep_for 3.5
  clear
  
  user_choice = ''
  loop do
    prompt(MESSAGES['user_choice'])
    user_choice = gets.chomp.capitalize

    break if input_validation(user_choice, choices, choices_abr)
    prompt(MESSAGES['user_choice_error'])
  end
  
  display_user(user_choice)
  sleep_for 0.6
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
  sleep_for 0.6
  computer_choice
end

# Collecting Display from Display Collection Based on User/Computer input

def return_user_result(hash, user_choice, computer_choice)
  case user_choice[1]
    when 'p' then hash["Sp_vs_#{computer_choice}"]
	  else 
	    hash["#{user_choice[0]}_vs_#{computer_choice}"]
  end
end 

def return_computer_result(hash, user_choice, computer_choice)
  case user_choice[1]
    when 'p' then hash["#{computer_choice}_vs_Sp"]
    else 
      hash["#{computer_choice}_vs_#{user_choice[0]}"]
  end 
end 
  	  
# Determining the Winner Based on WIN_CONDITIONS 

def find_winner(hash, first, second, conditions_hash)
	if conditions_hash[first].include?(second)
		return return_user_result(hash, first, second), MESSAGES['user_point']
		
	elsif conditions_hash[second].include?(first)
		return return_computer_result(hash, first, second), MESSAGES['comp_point']
	else 
		MESSAGES['tie']
	end 
end

# Displaying values based on return value Class in find_winner

def display_results(results_method)
    sleep_for 0.6
    
    if results_method.is_a?(Array)
      prompt(results_method[0])
      sleep_for 0.6 
      prompt(results_method[1])
    else 
      prompt(results_method)
    end
end 

# Display Win or Loss to the User

def display_win_loss(username, user_points, comp_points)
  sleep_for 1
  prompt("#{username}, #{MESSAGES['win']}") if user_points == 3
  prompt("#{username}, #{MESSAGES['lose']}") if comp_points == 3
end

# Asking the User for a new game

def new_game?(_user_points, _comp_points)
  prompt(MESSAGES['new_game'])
  gets.chomp.upcase
end

clear
# Let's Play

username = get_username
user_points = 0
comp_points = 0

loop do
  user_choice = get_user_choice(CHOICES, abbreviate(CHOICES))

  break if user_choice == 'Q'

  computer_choice = get_computer_choice
  result = find_winner(DISPLAY_COLLECTION, user_choice,
                       computer_choice, WIN_CONDITIONS)
  
  display_results(result)


  if result[1].include?('you')
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
