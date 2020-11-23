require 'pry'

class BankAccount
    attr_accessor :balance, :status
    attr_reader :name

    def initialize(name)
        @name = name
        @balance = 1000
        @status = 'open'
    end

    def deposit(amount)
        self.balance += amount
    end

    def display_balance 
        "Your balance is $#{self.balance}."
    end

    def valid?
        if self.status == 'open'
            if self.balance > 0
                true
            else
                false
            end
        else
            false
        end
    end

    def close_account
        self.balance = 0
        self.status = 'closed'
    end
end
