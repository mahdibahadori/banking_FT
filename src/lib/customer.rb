require_relative "account"

class Customer
  attr_reader :name, :account_number, :date

  def initialize(name)
    @name = name
    @account_number = Accounts::account_generator
    @date = Time.new.to_s    
  end

end