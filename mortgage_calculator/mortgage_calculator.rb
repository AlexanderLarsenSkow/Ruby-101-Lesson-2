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

def user_check_message(loan_amount, annual_percentage_rate, loan_duration)
  puts %(
<< So, your loan amount is $#{loan_amount}.
<< Your APR is #{annual_percentage_rate}%.
<< And the loan will last for #{loan_duration} years.
<< Is that all correct? Enter (Y/N)
)
end

# Main Calculate Method

def mortgage_calculator
  prompt(MESSAGES['name'])
  name = gets.chomp.capitalize
  prompt("Thanks for stopping by, #{name}. #{MESSAGES['welcome']}")

  # looping over the method so the user can repeat if necessary.
  loop do
    # Getting the user's total amount on the loan.
    loan_amount = ''
    loop do
      prompt(MESSAGES['loan_amount'])
      loan_amount = gets.chomp

      break if valid_number?(loan_amount)
      prompt(MESSAGES['loan_error'])
    end

    prompt("Your total loan is $#{loan_amount}.")

    # Getting the user's APR on the loan.
    annual_percentage_rate = ''
    loop do
      prompt(MESSAGES['apr'])
      annual_percentage_rate = gets.chomp

      break if valid_number?(annual_percentage_rate)
      prompt(MESSAGES['apr_error'])
    end

    prompt("Your APR is #{annual_percentage_rate}%.")

    loan_duration = ''
    loop do
      prompt(MESSAGES['loan_duration'])
      loan_duration = gets.chomp

      break if valid_integer?(loan_duration)
      prompt(MESSAGES['loan_duration_error'])
    end

    monthly_interest_rate = (annual_percentage_rate.to_f / 12) / 100
    months_duration = loan_duration.to_i * 12

    # Checking with the user to see if all the information is correct.
    user_check_message(loan_amount, annual_percentage_rate, loan_duration)
    answer = gets.chomp.upcase

    # Calculating the payment.
    if answer.start_with?('Y')
      prompt(MESSAGES['calculating'])
      monthly_payment = loan_amount.to_f * (monthly_interest_rate / (1 - ((1 + monthly_interest_rate)**(-months_duration))))
      prompt("Got it! Your monthly payment is $#{format('%.2f',monthly_payment)}.")

      prompt(MESSAGES['another_loan?'])
      answer_2 = gets.chomp.upcase

      if answer_2.start_with?('Y')
        prompt("No problem!")
      else
        prompt("Thanks for using the Mortgage Calculator, #{name}!")
        break
      end

    else
      prompt(MESSAGES['start_again'])
    end
  end
end

mortgage_calculator
