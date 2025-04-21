require 'rails_helper'

RSpec.describe Wallet, type: :model do
  it "belongs to user" do
    wallet = create(:wallet)
    expect(wallet.user).to be_present
  end
end
