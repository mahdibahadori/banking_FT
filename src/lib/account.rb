module Accounts
  def self.account_generator
    arr = []
    12.times do
      digit = rand(1..9)
      arr.push(digit)
    end
    return arr.join.to_s
  end
 
end