require 'rails_helper'

RSpec.describe InterestCalculatorJob, type: :job do
  let!(:loan) { create(:loan, amount: 2000, interest_rate: 5, status: :open) }

  it "adds interest to open case" do
    expect {
      described_class.new.perform
  }.to change { loan.reload.amount }.by (100)
  end
end
