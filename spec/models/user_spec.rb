require 'rails_helper'

RSpec.describe User, type: :model do
  it "create wallet automatically" do
    user = create(:user)
    expect(user.wallet).to be_present
    expect(user.wallet.balance).to eq(10000)
  end
end
