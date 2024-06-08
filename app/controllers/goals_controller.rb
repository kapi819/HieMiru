class GoalsController < ApplicationController
  def show
    @goal = Goal.new
  end
  
  def new
    @goal = current_user.goals.build
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.cold_symptom_id = ColdSymptom.first.id
    @goal.count ||= 0

    if @goal.save
      redirect_to @goal, notice: 'Goal was successfully created.'
    else
      render :new
    end
  end

  def show
    @goal = current_user.goals.find(params[:id])
  end

  def record
    @goal = current_user.goals.find(params[:id])
    @goal.increment!(:count)
    redirect_to @goal, notice: 'Goal was successfully recorded.'
  end

  def edit
  end

  def goal_params
    params.require(:goal).permit(:goal_body)
  end
end
