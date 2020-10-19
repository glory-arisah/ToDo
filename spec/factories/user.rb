FactoryBot.define do
  factory :user do
    first_name { 'Jayda' }
    last_name { 'Bayes' }
    sequence(:email) { |n| "my-#{n + 1}@email.com" }
    password { 'Password001.' }
  end
end