FactoryBot.define do
  factory :loan do
    amount { "9.99" }
    interest_rate { "9.99" }
    status { "MyString" }
    user { nil }
    adjusted_by_admin { false }
  end
end
