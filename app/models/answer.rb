# frozen_string_literal: true

# The Answer class represents a user's answer to a specific question.
# It belongs to a user and a question, and it also references a specific choice
# made by the user for that question.

class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  belongs_to :choice
end
