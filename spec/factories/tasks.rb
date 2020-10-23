FactoryBot.define do
  factory :task do
    description { "Wash the dishes" }
    task_check { false }
    association :list
  end
end
