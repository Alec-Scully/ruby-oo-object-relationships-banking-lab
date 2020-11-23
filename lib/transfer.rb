require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  @@transfer_history = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    @sender.valid?
    @receiver.valid?
  end

  def self.transfer_history
    @@transfer_history
  end

  def execute_transaction
    previous_transfer = self.class.transfer_history.each do | history |
      history == self
    end

    if previous_transfer.length > 0
      return
    end


    if @sender.valid? == true && @receiver.valid? == true
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
      self.class.transfer_history << self
    end

    if @sender.valid? == false || @receiver.valid? == false
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    end


  end

  def reverse_transfer
    executed_transfer = self.class.transfer_history.select do | transfer |
      transfer.sender == @sender
      transfer.receiver == @receiver
    end
    executed_transfer.each do | send_rec |
      send_rec.sender.balance += send_rec.amount
      send_rec.receiver.balance -= send_rec.amount
      send_rec.status = "reversed"
    end
  end
end