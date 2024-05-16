class QuestionsController < ApplicationController

  def index
    @questions = Question.all
    @choices = Choice.all
  end

  def result
    @user = User.find(params[:user_id])
  end
end
