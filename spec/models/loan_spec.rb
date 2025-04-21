require 'rails_helper'

RSpec.describe Loan, type: :model do
  it "Calculates interest correctly" do
    loan = create(:loan, amount: 1000, interest_rate: 5, status: :open)
    expect { InterestCalculatorJob.new.perform }.to change { loan.reload.amount }
  end
end
