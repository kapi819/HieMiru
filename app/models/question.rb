class Question < ApplicationRecord
  has_many :answers
  has_many :choices

  validates :question_title, presence: true

  def scores_for_role
    SCORES[question_type.to_sym]
  end
end
