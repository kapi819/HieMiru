# frozen_string_literal: true

# GoalsController handles actions related to the Goal model.
# It allows users to create, update, show, and delete goals.
# Additionally, it manages the recording of goal achievements.

class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update check_record record]

  def show; end

  def new
    @goal = current_user.goals.build
    @cold_symptom = current_user.cold_symptoms.first
  end

  def edit
    @cold_symptom = current_user.cold_symptoms.first
  end

  def create
    @goal = current_user.goals.build(goal_params)
    @goal.cold_symptom_id ||= ColdSymptom.first&.id

    if @goal.save
      redirect_to @goal, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def check_record
    @goal.last_recorded_at && @goal.last_recorded_at >= Time.zone.now.beginning_of_day
    redirect_to @goal, success: t('goals.update.success')
    render :show, status: :unprocessable_entity
  end

  def record
    if already_recorded_today?
      render json: { error: 'You can only record once per day.' }, status: :forbidden
      return
    end
    @goal.update(count: @goal.count + 1, last_recorded_at: Time.zone.now)
    reset_goal_count if @goal.count > 7
    respond_to_goal_save
  end

  def update
    if @goal.update(goal_params)
      redirect_to @goal, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_goal
    @goal = current_user.goals.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:goal_body, :cold_symptom_id, :count)
  end

  def already_recorded_today?
    @goal.last_recorded_at && @goal.last_recorded_at >= Time.zone.now.beginning_of_day
  end

  def reset_goal_count
    @goal.update!(count: 0)
  end

  def respond_to_goal_save
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
end
