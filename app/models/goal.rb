class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :cold_symptom

  validates :goal_body, presence: true
  validates :count, presence: ture
end
