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

# Displaying to the User's Choice

def display(user_choice)
  case user_choice
  when 1 then prompt(MESSAGES['chose_rock'])
  when 2 then prompt(MESSAGES['chose_paper'])
  when 3 then prompt(MESSAGES['chose_scissors'])
  end
end

# Getting the User's Choice

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

# Defining the Game's Logic with Helper Methods

def tie_game(user_choice, computer_choice)
  if user_choice == computer_choice
    prompt(MESSAGES['tie'])
  end
end

def user_win(user_choice, computer_choice)
  if user_choice == 1 && computer_choice == 3
    prompt(MESSAGES['user_won_rock'])
    true

  elsif user_choice == 2 && computer_choice == 1
    prompt(MESSAGES['user_won_paper'])
    true

  elsif user_choice == 3 && computer_choice == 2
    prompt(MESSAGES['user_won_scissors'])
    true
  end
end

def comp_win(user_choice, computer_choice)
  if user_choice == 1 && computer_choice == 2
    prompt(MESSAGES['comp_won_paper'])
    true

  elsif user_choice == 2 && computer_choice == 3
    prompt(MESSAGES['comp_won_scissors'])
    true

  elsif user_choice == 3 && computer_choice == 1
    prompt(MESSAGES['comp_won_rock'])
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

    prompt(format("You: %s / Rockbot: %s", user_points, comp_points))

    break if user_points == 3
    break if comp_points == 3
  end
  display_win_loss(username, user_points, comp_points)
end

main_game
