FactoryBot.define do
  factory :task do
    description { "Wash the dishes" }
    association :list
  end
end
