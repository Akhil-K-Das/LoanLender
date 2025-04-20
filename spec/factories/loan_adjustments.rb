FactoryBot.define do
  factory :loan_adjustment do
    loan { nil }
    new_amount { "9.99" }
    new_interest_rate { "9.99" }
    made_by { "MyString" }
  end
end
