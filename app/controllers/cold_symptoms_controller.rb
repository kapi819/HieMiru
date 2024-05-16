class ColdSymptomsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @cold_symptom = ColdSymptom.find(params[:id])
  end
end
