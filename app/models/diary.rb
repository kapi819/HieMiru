class Diary < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :body_temperature, :weight, :body_fat, numericality: true, allow_nil: true
  validates :physical_condition, inclusion: { in: %w(physical_bad physical_normal physical_good) }, allow_nil: true
  validates :mental_condition, inclusion: { in: %w(mental_bad mental_normal mental_good) }, allow_nil: true

  enum physical_condition: { physical_bad: 0, physical_normal: 1, physical_good: 2 }
  enum mental_condition: { mental_bad: 3, mental_normal: 4, mental_good: 5 }
end
