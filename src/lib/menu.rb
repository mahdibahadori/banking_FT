#gem requirements
require "json"
require 'byebug'

#relative page(s) requirement
require_relative "customer"


module Menu
  extend self
  PROMPT = TTY::Prompt.new



  @count = 0

  @customers = JSON.parse(File.read('../src/public/database.json'))
  

  def write_data
    File.write('../src/public/database.json', JSON.pretty_generate(@customers))
  end

  def welcome_message
    print "Welcome to the banking app. You can open an account, do transactions and view your transaction history;"
    options
  end

  def options
    message = 'what would you like to do?'
    option = PROMPT.select(message) do |menu|
      menu.choice name: 'Open a new account', value: '1'
      menu.choice name: 'Login', value: '2'
      menu.choice name: 'Exit', value: '3'
    end
    option_assessor(option)
  end

  def option_assessor(option)
    loop do
      case option
      when '1'
        puts "What is your name?"
        name = gets.chomp
        @customer = Customer.new(name)
        @customer_details = {
          name: @customer.name,
          account_number: @customer.account_number,
          date: @customer.date,
          deposit: 0,
          balance: 0,
          withdraw: 0
        }
        @customers.push(@customer_details)
        puts "Hello #{name}; your new account number is #{@customer.account_number}. Keep a record of that for further access into your account."
        option_list_1
      when '2'
        verifier
      when '3'
        puts "Thanks for choosing this banking app and we are glad to have you onboard. See you next time."
        exit
      end
    end
  end

  def option_list_1
    message = 'what would you like to do then?'
    new_option = PROMPT.select(message) do |menu|
      menu.choice name: 'Start first transaction', value: '1'
      menu.choice name: 'Exit', value: '2'
    end
    router_1(new_option)
  end

  def router_1(new_option)
    case new_option
    when "1"
      start_transaction
    when "2"
      puts "Thanks for choosing visiting my banking app and I am glad to have you onboard. See you next time."
      write_data
      exit
    end
  end  

  def option_list_2(name, account_number, customers_array)
    name = name
    account_number = account_number
    message = 'what would you like to do?'
    last_option = PROMPT.select(message) do |menu|
      menu.choice name: 'Start a new transaction', value: '1'
      menu.choice name: 'View your previous transactions', value: '2'
      menu.choice name: 'Exit', value: '3'
    end
    router_2(last_option, name, account_number, customers_array)
  end

  def router_2(last_option, name, account_number, customers_array)
    case last_option
    when "1"
      transaction_starter(@customer)
    when "2"
      rows = customers_array.map do |transaction|
        [transaction["name"], transaction["account_number"], transaction["date"], transaction["deposit"], transaction["withdraw"], transaction["balance"]]
      end
      table = Terminal::Table.new headings: [:name, :account_number, :date, :deposit, :withdraw, :balance], rows: rows
      puts table
      print "And now, "
      option_list_2(name, account_number, customers_array)
    when "3"
      write_data
      puts "Thanks for using my banking app. Have a great day."
      exit
    end
  end

  def verifier
    puts "Enter your name:"
    print "> "
    name = gets.chomp.to_s
    puts "Enter your account number:"
    account_number = gets.chomp.to_s
    login_verifier(name, account_number)
  end

  def login_verifier(name, account_number)
    customers_array = @customers.select { |customer| customer["name"] == name && customer["account_number"] == account_number }
    if customers_array.size > 0
      puts "Your details verified successfully!"
      @customer = customers_array.last
      # p @customer
      option_list_2(name, account_number, customers_array)

    else
      puts "Login failed; try again.".colorize(:red)
      @count += 1
      if @count >= 3
        puts "You might need to call our customer service to fix your issue.".colorize(:red)
        options
      else
        verifier
      end
    end
  end

  def start_transaction
    name = @customer.name
    account_number = @customer.account_number
    date = @customer.date
    @transaction = Transaction.new(name, account_number, date, deposit = 0, balance = 0, withdraw = 0)
    @transaction.list
  end

  def transaction_starter(customer)
    name = @customer["name"]
    account_number = @customer["account_number"]
    deposit = @customer["deposit"]
    balance = @customer["balance"]
    withdraw = @customer["withdraw"]
    @transaction = Transaction.new(name, account_number, date = Time.new.to_s, deposit, balance, withdraw)
    @transaction.list
  end

  def account_generator
    arr = []
    6.times do
      digit = rand(1..9)
      arr.push(digit)
    end
    return arr.join.to_s
  end
end
