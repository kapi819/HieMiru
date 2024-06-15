class DiariesController < ApplicationController
  def index
    @diaries = user_diaries
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to @diary
    else
      render :new
    end
  end

  private

  def user_diaries
    current_user.diaries
  end

  def diary_params
    params.require(:diary).permit(:date, :body_temperature, :weight, :body_fat, :physical_condition, :mental_condition)
  end

end
