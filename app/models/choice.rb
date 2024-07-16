class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers

  validates :question_type, presence: true, numericality: { only_integer: true }
  enum question_type: { A: 0, B: 1, C: 2 }
end
