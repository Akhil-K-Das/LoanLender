class LoanApprovalService
  def initialize(loan)
    @loan = loan
    @admin = User.admin.first
  end

  def approve
    puts "INSIDE APPROVAL SERVICE...............#{@admin.wallet.balance} and #{@loan.amount}"
    if @admin.wallet.balance >= @loan.amount
      # @loan.update!(status: 'approved')
      puts "INSIDE APPROVAL SERVICE...............#{@admin.wallet.balance} and #{@loan.amount}"
      true
    else
      puts "not enough funds"
      @loan.errors.add(:base, "Insufficient funds in admin's wallet")
      false
    end
  end
end
  