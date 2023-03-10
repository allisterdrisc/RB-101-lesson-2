# ask the user for two numbers
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result
LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("==> #{message}")
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num 
end 

def valid_number?(num)
  integer?(num) || float?(num)
end 

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

prompt(messages('welcome', LANGUAGE))

name = ''
loop do
  name = Kernel.gets.chomp

  if name.empty?
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end

loop do # main loop
  number1 = ''
  loop do
    prompt(messages('number1', LANGUAGE))
    number1 = Kernel.gets.chomp
    if valid_number?(number1)
      break
    else
      prompt(messages('invalid_number', LANGUAGE))
    end
  end

  number2 = ''
  loop do
    prompt(messages('number2', LANGUAGE))
    number2 = Kernel.gets.chomp
    if valid_number?(number2)
      break
    else
      prompt(messages('invalid_number', LANGUAGE))
    end
  end
  
  operator_prompt = (messages('operator', LANGUAGE))

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('invalid_operator', LANGUAGE))
    end
  end

  prompt("#{operation_to_message(operator)}" + messages('operation_on', LANGUAGE))
  result = case operator
           when '1'
             number1.to_i + number2.to_i
           when '2'
             number1.to_i - number2.to_i
           when '3'
             number1.to_i * number2.to_i
           when '4'
             number1.to_f / number2.to_f
           end

  prompt(messages('result', LANGUAGE) + "#{result}")

  prompt(messages('again?', LANGUAGE))
  answer = Kernel.gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(messages('thank_you', LANGUAGE))
