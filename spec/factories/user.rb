FactoryBot.define do
  factory :user do
    name { 'Abel Tesfaye' }
    sequence(:email) { |n| "my-#{n + 1}@email.com" }
    password { 'Password001.' }
  end
end