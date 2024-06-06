class GoalsController < ApplicationController
  def show
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.cold_symptom_id = ColdSymptom.first.id
    @goal.count ||= 0

    if @goal.save
      redirect_to @goal, notice: 'Goal was successfully created.'
    else
      render 'users/show'
    end
  end

  def edit
  end

  def goal_params
    params.require(:goal).permit(:goal_body)
  end
end
