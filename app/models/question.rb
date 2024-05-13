class Question < ApplicationRecord
  has_many :answers
  has_many :choices
end
