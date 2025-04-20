class User < ApplicationRecord
  has_many :loans, dependent: :destroy
  has_one :wallet, dependent: :destroy

  after_create :create_wallet_withdefault_balance
  enum :role, { user: 0, admin: 1 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def create_wallet_withdefault_balance
    balance = admin? ? 1000000 : 10000
    Wallet.create!(user: self, balance: balance)
  end
  # def admin?
  #   role == "admin"
  # end
  # def after_initialize
  #   self.role ||= :user
  # end
end
