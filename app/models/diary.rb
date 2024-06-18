class Diary < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :body_temperature, :weight, :body_fat, numericality: true, allow_nil: true
  validates :physical_condition, inclusion: { in: %w(physical_bad physical_normal physical_good) }, allow_nil: true
  validates :mental_condition, inclusion: { in: %w(mental_bad mental_normal mental_good) }, allow_nil: true

  enum physical_condition: { physical_bad: 0, physical_normal: 1, physical_good: 2 }, _prefix: true
  enum mental_condition: { mental_bad: 0, mental_normal: 1, mental_good: 2 }, _prefix: true
end
