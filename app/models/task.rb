class Task < ApplicationRecord
  belongs_to :list
  validates :description, presence: true

  scope :completed, -> { where(task_check: true) }
end
