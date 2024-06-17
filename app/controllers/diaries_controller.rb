class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]

  def index
    @diaries = user_diaries
  end

  def show
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.new(diary_params)
    if @diary.save
      redirect_to @diary
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @diary.update(diary_params)
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
    logger.debug "Set Diary for ID: #{@diary.id}"
  end

  def user_diaries
    current_user.diaries
  end

  def diary_params
    params.require(:diary).permit(:start_time, :body_temperature, :weight, :body_fat, :physical_condition, :mental_condition)
  end

end
