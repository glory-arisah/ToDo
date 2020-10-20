FactoryBot.define do
  factory :list do
    title { "My Things" }
    association :user, first_name: 'Will', last_name: 'Iam'
  end
end
