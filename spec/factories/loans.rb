FactoryBot.define do
  factory :loan do
    association :user
    amount { 1000.0 }
    interest_rate { 5.0 }
    status { :requested }

    # Optional trait for different states
    trait :open do
      status { :open }
    end

    trait :approved do
      status { :approved }
    end

    trait :rejected do
      status { :rejected }
    end
  end
end
