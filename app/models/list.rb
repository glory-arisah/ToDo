class List < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  def percentage_done
    return 0 if tasks.count.zero?
    (tasks.completed.count.to_f / tasks.count.to_f) * 100
  end
end
