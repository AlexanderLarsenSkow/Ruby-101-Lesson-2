require 'yaml'
MESSAGES = YAML.load_file('mortgage_calc.yml')

# Number Validation Methods

def valid_integer?(integer)
  integer.to_i.to_s == integer && integer.to_i > 0
end

def valid_float?(float)
  float.to_f.to_s == float
end

def valid_number?(number)
  (valid_float?(number) || valid_integer?(number)) && number.to_i > 0
end

# Prompt Input Message

def prompt(message)
  puts "<< #{message}"
end

# Saying hello, retrieving user's name for later.

def intro
    prompt(MESSAGES['name'])
    name = gets.chomp.capitalize
    prompt("Thanks for stopping by, #{name}. #{MESSAGES['welcome']}")
    name
end 

# Getting the user's total amount on the loan.
def get_loan_amount
  loan_amount = ''
    
    loop do
      prompt(MESSAGES['loan_amount'])
      loan_amount = gets.chomp

      break if valid_number?(loan_amount)
      prompt(MESSAGES['loan_error'])
    end
    
    prompt("Your total loan is $#{loan_amount}.")
    loan_amount
end 

# Getting the user's APR on the loan.

def get_annual_percentage_rate
  annual_percentage_rate = ''
    
    loop do
      prompt(MESSAGES['apr'])
      annual_percentage_rate = gets.chomp

      break if valid_number?(annual_percentage_rate)
      prompt(MESSAGES['apr_error'])
    end

    prompt("Your APR is #{annual_percentage_rate}%.")
    annual_percentage_rate
end 

# Getting the length in years for the loan.

def get_loan_duration 
  loan_duration = ''
    
    loop do
      prompt(MESSAGES['loan_duration'])
      loan_duration = gets.chomp

      break if valid_integer?(loan_duration)
      prompt(MESSAGES['loan_duration_error'])
    end 
    loan_duration
end 

# Checking with the user to see if all the information is correct.

def check_user_input(loan_total, apr, loan_time)
  puts %(
<< So, your loan amount is $#{loan_total}.
<< Your APR is #{apr}%.
<< And the loan will last for #{loan_time} years.
<< Is that all correct? Enter (Y/N)
)
  answer = gets.chomp.upcase
end

# Mathing Logic 

def get_calculations(loan_total, apr, loan_time)
  monthly_interest_rate = (apr.to_f / 12) / 100
  months = loan_time.to_i * 12
  monthly_payment = loan_total.to_f * (monthly_interest_rate / (1 - ((1 + monthly_interest_rate)**(-months))))
end

# Displaying user's monthly payment 

def display_result(monthly_payment)
  prompt(MESSAGES['calculating'])
  prompt("Got it! Your monthly payment is $#{format('%.2f',monthly_payment)}.")
end 

# Restarting the loop if the user wants to check a new loan.

def new_loan?(name)
  prompt(MESSAGES['another_loan?'])
  answer_2 = gets.chomp.upcase
  
  if answer_2.start_with?('Y')
    prompt("No problem!")
  else
    prompt("Thanks for using the Mortgage Calculator, #{name}!") 
  end 
  answer_2 
end 

# Main Calculate Method

def mortgage_calculator
  name = intro
  
  loop do
    loan_total = get_loan_amount
    apr = get_annual_percentage_rate
    loan_time = get_loan_duration
  
    correct_data = check_user_input(loan_total, apr, loan_time)

    if correct_data.start_with?('Y')
      monthly_payment = get_calculations(loan_total, apr, loan_time)
      display_result(monthly_payment) 
      answer = new_loan?(name)
      break unless answer.start_with?('Y')
    else
      prompt(MESSAGES['start_again'])    
    end
  end
end

mortgage_calculator
