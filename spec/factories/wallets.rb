FactoryBot.define do
  factory :wallet do
    balance { 10000 }
    association :user
  end
end
