require 'yaml'
MESSAGES = YAML.load_file('rps.yml')

# Validating user_input

def input_validation(n)
  n == 'R' || n == 'P' || n == 'S' || n == 'L' || n == 'SP' || n == 'Q'
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
  case choice
  when 'R' then prompt(MESSAGES['chose_rock'])
  when 'P' then prompt(MESSAGES['chose_paper'])
  when 'S' then prompt(MESSAGES['chose_scissors'])
  when 'L' then prompt (MESSAGES['chose_lizard'])
  when 'SP' then prompt (MESSAGES['chose_spock'])
  end
end

# Getting the User's Choice

def get_user_choice
  user_choice = ''
  loop do
    prompt(MESSAGES['user_choice'])
    user_choice = gets.chomp.upcase

    break if input_validation(user_choice)
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
  when 'SP' then prompt(MESSAGES['comp_spock'])
  end
end

# Getting the Computer's Choice

def get_computer_choice
  choices_array = ['R', 'P', 'S', 'L', 'SP']
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
  'L_vs_SP' => MESSAGES['user_won_lizard_vs_spock'],
  'SP_vs_S' => MESSAGES['user_won_spock_vs_scissors'],
  'S_vs_L' => MESSAGES['user_won_scissors_vs_lizard'],
  'L_vs_P' => MESSAGES['user_won_lizard_vs_paper'],
  'P_vs_SP' => MESSAGES['user_won_paper_vs_spock'],
  'SP_vs_R' => MESSAGES['user_won_spock_vs_rock'],
  
  # Computer Wins
  'R_vs_P' => MESSAGES['comp_won_rock_vs_paper'],
  'P_vs_S' => MESSAGES['comp_won_paper_vs_scissors'],
  'S_vs_R' => MESSAGES['comp_won_scissors_vs_rock'],
  'L_vs_R' => MESSAGES['comp_won_lizard_vs_rock'],
  'SP_vs_L' => MESSAGES['comp_won_spock_vs_lizard'],
  'S_vs_SP' => MESSAGES['comp_won_scissors_vs_spock'],
  'L_vs_S' => MESSAGES['comp_won_lizard_vs_scissors'],
  'P_vs_L' => MESSAGES['comp_won_paper_vs_lizard'],
  'SP_vs_P' => MESSAGES['comp_won_spock_vs_paper'],
  'R_vs_SP' => MESSAGES['comp_won_rock_vs_spock'],
  
  # Tie Game 
  'R_vs_R' => MESSAGES['tie'],
  'P_vs_P' => MESSAGES['tie'],
  'S_vs_S' => MESSAGES['tie'],
  'L_vs_L' => MESSAGES['tie'],
  'SP_vs_SP' => MESSAGES['tie']
}

# Returning the value from the collection

def return_result(hash, user_choice, computer_choice)
  hash["#{user_choice}_vs_#{computer_choice}"]
end

# Display Win or Loss to the User

def display_score(username, user_points, comp_points)
  prompt("#{username}, #{MESSAGES['win']}") if user_points == 3
  prompt("#{username}, #{MESSAGES['lose']}") if comp_points == 3
end

# Asking the User for a new game

def new_game?(user_points, comp_points)
    prompt(MESSAGES['new_game'])
    gets.chomp.upcase
end 

# Let's Play

username = get_username
user_points = 0
comp_points = 0

loop do
  user_choice = get_user_choice
  
  break if user_choice == 'Q'
  
  computer_choice = get_computer_choice
  result = return_result(wins_losses_display_collection, user_choice, computer_choice)
  
  prompt(result)

  if result.include?('you')
    user_points += 1
  elsif result.include?('Rockbot')
    comp_points += 1
  end

  prompt(format("You: %s / Rockbot: %s", user_points, comp_points))
  display_score(username, user_points, comp_points)
  
  if user_points == 3 || comp_points == 3
    answer = new_game?(user_points, comp_points)
  
    break unless answer.start_with?('Y')
    user_points = 0
    comp_points = 0
  end 
end 

prompt("#{MESSAGES['thanks']} #{username}!")