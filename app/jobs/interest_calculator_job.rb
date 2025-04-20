class InterestCalculatorJob < ApplicationJob
  queue_as :default

  def perform
    puts "********* InterestCalculatorJob is running..."

    Loan.open.find_each do |loan|
      interest = (loan.amount * loan.interest_rate / 100.0) # / (365 * 24 * 12)
      puts "Loan ##{loan.id} - Calculated interest: #{interest.round(2)} and balance: #{loan.user.wallet.balance}"
      loan.update!(amount: loan.amount + interest)
      if loan.amount >= loan.user.wallet.balance
        puts "Loan ##{loan.id} - Amount is greater than user's wallet balance. Proceeding to repayment........"
        LoanService.new(loan).repay!
      end
    end
  end
end
