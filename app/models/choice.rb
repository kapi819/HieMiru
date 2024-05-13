class Choice < ApplicationRecord
  belongs_to :question
  has_many :answers
  
  enum question_type: { A: 0, B: 1, C: 2 }
end
