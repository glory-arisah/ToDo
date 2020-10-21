class Task < ApplicationRecord
  belongs_to :list, dependent: :destroy

  validates :description, presence: true
end
