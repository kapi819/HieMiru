# frozen_string_literal: true

# Question represents a question that can be part of a diagnostic or survey.
# Each question has a title and can have multiple choices associated with it.

class Question < ApplicationRecord
  has_many :answers
  has_many :choices

  validates :question_title, presence: true

  def scores_for_role
    SCORES[question_type.to_sym]
  end
end
