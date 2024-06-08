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
  prompt("Welcome to the Mortgage Loan Calculator! What is your name?")
  name = gets.chomp.capitalize
  prompt("Thanks for stopping by, #{name}. Let's calculate your monthly mortgage payment.")

  # looping over the method so the user can repeat if necessary.
  loop do
    # Getting the user's total amount on the loan.
    loan_amount = ''
    loop do
      prompt("Please enter the total amount for your loan.")
      loan_amount = gets.chomp

      break if valid_number?(loan_amount)
      prompt("Error: Please enter a valid number that is greater than 0.")
    end

    prompt("Your total loan is $#{loan_amount}.")

    # Getting the user's APR on the loan.
    annual_percentage_rate = ''
    loop do
      prompt("Now please enter your Annual Percentage Rate (APR) on the mortgage.")
      annual_percentage_rate = gets.chomp

      break if valid_number?(annual_percentage_rate)
      prompt("Error: Please enter a valid number that is greater than 0.")
    end

    prompt("Your APR is #{annual_percentage_rate}%.")

    loan_duration = ''
    loop do
      prompt("Almost there! Lastly, please enter how many years the loan will last.")
      loan_duration = gets.chomp

      break if valid_integer?(loan_duration)
      prompt("Error: Please enter a number with no decimal place that is greater than 0.")
    end

    monthly_interest_rate = (annual_percentage_rate.to_f / 12) / 100
    months_duration = loan_duration.to_i * 12

    # Checking with the user to see if all the information is correct.
    user_check_message(loan_amount, annual_percentage_rate, loan_duration)
    answer = gets.chomp.upcase

    # Calculating the payment.
    if answer.start_with?('Y')
      prompt("Okay! Calculating your monthly payment now...")
      monthly_payment = loan_amount.to_f * (monthly_interest_rate / (1 - ((1 + monthly_interest_rate)**(-months_duration))))
      prompt("Got it! Your monthly payment is $#{format('%.2f',
                                                        monthly_payment)}.")

      prompt("Do you have another loan payment you want to check? Enter (Y/N)")
      answer_2 = gets.chomp.upcase

      if answer_2.start_with?('Y')
        prompt("No problem!")
      else
        prompt("Thanks for using the Mortgage Calculator, #{name}!")
        break
      end

    else
      prompt("Please start again and enter the correct information.")
    end
  end
end

mortgage_calculator
