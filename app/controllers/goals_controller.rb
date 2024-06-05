class GoalsController < ApplicationController
  def index
  end

  def new
    @goal = current_user.goals.build
    @goal.save
  end

  def edit
  end
end
