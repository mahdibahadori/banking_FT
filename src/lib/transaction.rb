require "json"
require "colorize"

require_relative "menu"
require_relative "customer"

class Transaction
  PROMPT = TTY::Prompt.new



  def data_storage
    File.write('../src/public/database.json', JSON.pretty_generate(@transaction_history))
  end


  attr_reader :name, :account_number, :date, :deposit, :balance, :withdraw

  def initialize(name, account_number, date, deposit, balance, withdraw)
    @name = name
    @account_number = account_number
    @date = date
    @transaction_repo = { :name => name, :account_number => account_number, :date => date }
    @transaction_history = JSON.parse(File.read('../src/public/database.json'))
    @deposit
    @withdraw
    @total = balance
    @default_deposit = 0
    @default_withdraw = 0
  end


  def list
    message = 'what would you like to do?'
    option = PROMPT.select(message) do |menu|
      menu.choice name: 'Deposit', value: '1'
      menu.choice name: 'Withdraw', value: '2'
      menu.choice name: 'View balance', value: '3'
      menu.choice name: 'Exit', value: '4'
    end
    assessor(option)
  end

  def assessor(option)
    case option
    when "1"
      deposit
    when "2"
      withdraw
    when "3"
      p @total
      list
    when "4"
      if @deposit == 0 || @deposit.class == NilClass
        @transaction_repo[:deposit] = 0
      else
        @transaction_repo[:deposit] = @deposit
      end

      if @withdraw == 0 || @withdraw.class == NilClass
        @transaction_repo[:withdraw] = 0
      else
        @transaction_repo[:withdraw] = @withdraw
      end
      @transaction_repo[:balance] = @total
      @transaction_history.push(@transaction_repo)
      data_storage
      exit
    end
  end

  def deposit
    puts "How much you would like to deposit".colorize(:green)
    print "> "
    amount = gets.chomp.to_i
    if amount < 0 
      puts "The entered amount is not correct; enter another amount".colorize(:red)
      deposit
    end
    @default_deposit += amount
    @transaction_repo[:deposit] = @default_deposit
    @total += amount
    @transaction_repo[:balance] = @total
    @deposit = @default_deposit 
    list
  end

  def withdraw
    puts "How much you would like to withdraw".colorize(:green)
    print "> "
    amount = gets.chomp.to_i
    if amount < 0
      puts "The entered amount is not correct; enter another amount".colorize(:red)
      withdraw
    elsif amount > @total
      puts "The intended amount is more than your available balance; choose another amount:".colorize(:red)
      puts "Your current balance is $#{@total}"
      withdraw
    else
      @default_withdraw += amount
      @transaction_repo[:withdraw] = @default_withdraw
      @total = @total - amount
      @transaction_repo[:balance] = @total
      @withdraw = @default_withdraw
    end
    list
  end
end
