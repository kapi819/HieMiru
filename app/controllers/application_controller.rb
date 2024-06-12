class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(resource)
    if current_user.goals.any?
      goals_path
    else
      new_goal_path
    end
  end
end
