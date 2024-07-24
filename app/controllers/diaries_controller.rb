# frozen_string_literal: true

# DiariesController handles actions related to the Diary model.
# It allows users to create, update, show, and delete diary entries.
# Additionally, it manages the recording of physical and mental conditions.

class DiariesController < ApplicationController
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    @diaries = user_diaries
    @today_diary = current_user.diaries.find_by(start_time: Time.zone.today)
  end

  def show; end

  def new
    if current_user.diaries.exists?(start_time: Time.zone.today)
      redirect_to diaries_path, alert: t('.alert')
    else
      @diary = Diary.new
    end
  end

  def edit; end

  def create
    if current_user.diaries.exists?(start_time: Time.zone.today)
      redirect_to diaries_path, alert: t('.alert')
    else
      @diary = current_user.diaries.new(diary_params)
      if @diary.save
        redirect_to @diary, success: t('.success')
      else
        flash.now[:danger] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    if @diary.update(diary_params)
      redirect_to @diary, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @diary.destroy
      redirect_to diaries_url, success: t('.success')
    else
      redirect_to diaries_url, failure: t('.failure')
    end
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
    Rails.logger.debug { "Set Diary for ID: #{@diary.id}" }
  end

  def user_diaries
    current_user.diaries.order(:start_time)
  end

  def diary_params
    params.require(:diary).permit(:start_time, :body_temperature, :weight, :body_fat, :physical_condition,
                                  :mental_condition)
  end
end
