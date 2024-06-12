class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update]

  def show
  end
  
  def new
    @goal = current_user.goals.build
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.cold_symptom_id ||= ColdSymptom.first&.id
    @goal.count ||= 0

    Rails.logger.debug "Goal params: #{goal_params.inspect}"
    Rails.logger.debug "Goal object before save: #{@goal.inspect}"

    if @goal.save
      Rails.logger.debug "Goal successfully created"
      redirect_to @goal, notice: 'Goal was successfully created.'
    else
      Rails.logger.error "Failed to create goal: #{@goal.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def record
    @goal = Goal.last || Goal.new(count: 0)
    @goal.count += 1

    if @goal.count > 7
      @goal.count = 0
    end

    if @goal.save
      respond_to do |format|
        format.json { render json: { count: @goal.count } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Failed to record goal' }, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: 'Goal was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:goal_body, :cold_symptom_id, :count)
  end
end
