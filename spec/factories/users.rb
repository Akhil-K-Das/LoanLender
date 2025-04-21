FactoryBot.define do
  factory :user do
    email { "test@examble.com" }
    password { "password" }
    role { "user" }

    trait :admin do
      role { "admin" }
    end
  end
end
