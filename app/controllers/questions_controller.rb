class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @choices = Choice.all
  end

  def calculate
  end

  def result
  end
end
