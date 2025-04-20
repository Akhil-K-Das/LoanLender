class LoanService
    def initialize(loan)
      @loan = loan
      @admin = User.admin.first
    end
  
    def fund!
      @admin.wallet.decrement!(:balance, @loan.amount)
      @loan.user.wallet.increment!(:balance, @loan.amount)
    end
  
    def repay!
      amount_due = @loan.amount
      repayment = [@loan.user.wallet.balance, amount_due].min
      @loan.user.wallet.decrement!(:balance, repayment)
      @admin.wallet.increment!(:balance, repayment)
      @loan.update!(status: "closed")
    end
end
  