FactoryBot.define do
  factory :list do
    title { "My Things" }
    association :user, name: 'Will Iam'
  end
end
