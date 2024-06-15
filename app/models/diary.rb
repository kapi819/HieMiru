class Diary < ApplicationRecord
  belongs_to :user

  validates :start_time, presence: true
  validates :body_temperature, :weight, :body_fat, numericality: true, allow_nil: true
  validates :physical_condition, :mental_condition, inclusion: { in: %w(bad normal good) }, allow_nil: true

  enum physical_condition: { physical_bad: 0, physical_normal: 1, physical_good: 2 }
  enum mental_condition: { mental_bad: 0, mental_normal: 1, mental_good: 2 }
end
