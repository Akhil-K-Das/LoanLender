class InterestCalculatorJob < ApplicationJob
  queue_as :default

  def perform
    puts "********* InterestCalculatorJob is running..."

    Loan.open.find_each do |loan|
      interest = (loan.amount * loan.interest_rate / 100.0) / (365 * 24 * 12)
      puts "Loan ##{loan.id} - Calculated interest: #{interest.round(2)}"
      loan.update!(amount: loan.amount + interest)
    end
  end
end
