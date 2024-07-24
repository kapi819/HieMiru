# frozen_string_literal: true

# Choice represents a selectable option for a question in the diagnostic system.
# Each choice belongs to a specific question and can be selected by users as their answer.

class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers, dependent: :destroy

  validates :question_type, presence: true, numericality: { only_integer: true }
  enum question_type: { A: 0, B: 1, C: 2 }
end
