class GoalsController < ApplicationController
  def show
    @goal = current_user.goals.find(params[:id])
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

  def record
    @goal = Goal.last || Goal.new(count: 0)
    @goal.count += 1
    if @goal.save
      respond_to do |format|
        # format.html { redirect_to root_path, notice: 'Goal was successfully recorded.' }
        format.json { render json: { count: @goal.count } }
      end
    else
      respond_to do |format|
        # format.html { redirect_to root_path, alert: 'Failed to record goal.' }
        format.json { render json: { error: 'Failed to record goal' }, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def goal_params
    params.require(:goal).permit(:goal_body)
  end
end
