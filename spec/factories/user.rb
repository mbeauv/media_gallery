# This will guess the User class
FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:token) { |n| "token#{n}" }
    admin false
    disabled false
  end
end
