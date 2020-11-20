class Transfer

  attr_reader :sender, :receiver, :amount, :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid? && sender.balance > amount
  end

  def execute_transaction
    if valid? && status == "pending"
      sender.balance -= amount
      receiver.balance += amount
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
    @status = "complete"
  end

  def reverse_transfer
    if status == "complete"
      @status = "pending"
      @amount = -@amount
      execute_transaction
      @status = "reversed"
    end
  end
end
