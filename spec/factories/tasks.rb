FactoryBot.define do
  factory :task do
    title { "Wash the dishes" }
    association :list
  end
end
