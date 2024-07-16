# frozen_string_literal: true

# Goal represents a user's goal related to improving or managing their cold sensitivity.
# Each goal is associated with a user and can have various attributes like the goal body, 
# the count of achievements, the last recorded date, and an optional association to a cold symptom.

class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :cold_symptom

  validates :goal_body, presence: true
  validates :count, presence: true
end
