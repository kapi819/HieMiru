class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @choices = Choice.all
  end
end
