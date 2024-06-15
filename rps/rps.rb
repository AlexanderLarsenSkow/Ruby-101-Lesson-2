require 'yaml'
MESSAGES = YAML.load_file('rps.yml')

# Validating user_input

def input_validation(n)
  n == 'R' || n == 'P' || n == 'S' || n == 'L' || n == 'SP'
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

# Displaying to the User's Choice

def display_user(user_choice)
  case user_choice
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

def display_comp(computer_choice)
  case computer_choice
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

# Defining the Game's Logic with Helper Methods

def tie_game(user_choice, computer_choice)
  if user_choice == computer_choice
    prompt(MESSAGES['tie'])
  end
end

def user_win(user_choice, computer_choice)
  if user_choice == 'R' && computer_choice == 'S'
    prompt(MESSAGES['user_won_rock_S'])
    true

  elsif user_choice == 'P' && computer_choice == 'R'
    prompt(MESSAGES['user_won_paper_R'])
    true

  elsif user_choice == 'S' && computer_choice == 'P'
    prompt(MESSAGES['user_won_scissors_P'])
    true
    
   elsif user_choice == 'R' && computer_choice == 'L'
    prompt(MESSAGES['user_won_rock_L'])
    true
   
   elsif user_choice == 'L' && computer_choice == 'SP'
    prompt(MESSAGES['user_won_lizard_SP'])
    true
    
   elsif user_choice == 'SP' && computer_choice == 'S'
    prompt(MESSAGES['user_won_spock_S'])
    true  
    
  elsif user_choice == 'S' && computer_choice == 'L'
    prompt(MESSAGES['user_won_scissors_L'])
    true
    
   elsif user_choice == 'L' && computer_choice == 'P'
    prompt(MESSAGES['user_won_lizard_P'])
    true
    
   elsif user_choice == 'P' && computer_choice == 'SP'
    prompt(MESSAGES['user_won_paper_SP'])
    true
  
   elsif user_choice == 'SP' && computer_choice == 'R'
    prompt(MESSAGES['user_won_rock_R'])
    true  
    
  end
end

def comp_win(user_choice, computer_choice)
  if user_choice == 'R' && computer_choice == 'P'
    prompt(MESSAGES['comp_won_paper_R'])
    true

  elsif user_choice == 'P' && computer_choice == 'S'
    prompt(MESSAGES['comp_won_scissors_P'])
    true

  elsif user_choice == 'S' && computer_choice == 'R'
    prompt(MESSAGES['comp_won_rock_S'])
    true
    
  elsif user_choice == 'L' && computer_choice == 'R'
    prompt(MESSAGES['comp_won_rock_L'])
    true
    
  elsif user_choice == 'SP' && computer_choice == 'L'
    prompt(MESSAGES['comp_won_lizard_SP'])
    true
    
  elsif user_choice == 'S' && computer_choice == 'Sp'
    prompt(MESSAGES['comp_won_spock_S'])
    true
  
  elsif user_choice == 'L' && computer_choice == 'S'
    prompt(MESSAGES['comp_won_scissors_L'])
    true
    
  elsif user_choice == 'P' && computer_choice == 'L'
    prompt(MESSAGES['comp_won_lizard_P'])
    true
    
   elsif user_choice == 'SP' && computer_choice == 'P'
    prompt(MESSAGES['comp_won_paper_SP'])
    true
  
   elsif user_choice == 'R' && computer_choice == 'Sp'
    prompt(MESSAGES['comp_won_spock_R'])
    true  
  end
end

# Primmary Logic Method

def game_logic(user_choice, computer_choice)
  tie_game(user_choice, computer_choice)
  user_won = user_win(user_choice, computer_choice)
  comp_won = comp_win(user_choice, computer_choice)

  if user_won == true
    true
  elsif comp_won == true
    false
  end
end

# Display Win or Loss to the User

def display_win_loss(username, user_points, comp_points)
  prompt("#{username}, #{MESSAGES['win']}") if user_points == 3
  prompt("#{username}, #{MESSAGES['lose']}") if comp_points == 3
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

    case result
    when true then user_points += 1
    when false then comp_points += 1
    end

    break if user_points == 3
    break if comp_points == 3
    
    prompt(format("You: %s / Rockbot: %s", user_points, comp_points))
  end
  display_win_loss(username, user_points, comp_points)
end

main_game
