class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @cold_symptom = ColdSymptom.find(params[:id])
  end
end
