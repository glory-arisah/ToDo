FactoryBot.define do
  factory :list do
    title { "My Things" }
    association :user
  end
end
