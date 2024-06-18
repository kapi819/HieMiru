class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  def index
    @diaries = user_diaries
    @today_diary = current_user.diaries.find_by(start_time: Date.today)
  end

  def show
  end

  def new
    if current_user.diaries.exists?(start_time: Date.today)
      redirect_to diaries_path, alert: '本日の記録は既に作成されています。'
    else
      @diary = Diary.new
    end
  end

  def create
    if current_user.diaries.exists?(start_time: Date.today)
      redirect_to diaries_path, alert: '本日の記録は既に作成されています。'
    else
      @diary = current_user.diaries.new(diary_params)
      if @diary.save
        redirect_to @diary
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
    Rails.logger.debug "Update Parameters: #{diary_params.inspect}"
    if @diary.update(diary_params)
      Rails.logger.debug "Updated Diary: #{@diary.inspect}"
      redirect_to @diary, notice: 'Diary was successfully updated.'
    else
      flash.now[:error] = @diary.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    logger.debug "Destroy action called for Diary ID: #{@diary.id}"
    if @diary.destroy
      logger.debug "Diary ID: #{@diary.id} successfully destroyed."
      redirect_to diaries_url, notice: 'Diary was successfully destroyed.'
    else
      logger.debug "Failed to destroy Diary ID: #{@diary.id}"
      redirect_to diaries_url, alert: 'Failed to destroy the diary.'
    end
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
    Rails.logger.debug "Set Diary for ID: #{@diary.id}"
  end

  def user_diaries
    current_user.diaries
  end

  def diary_params
    params.require(:diary).permit(:start_time, :body_temperature, :weight, :body_fat, :physical_condition, :mental_condition)
  end

end
