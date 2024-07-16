# frozen_string_literal: true

# ApplicationController is the base controller for all controllers in this application.
# It handles common functionalities that are shared across all controllers.
class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(_resource)
    if current_user.goals.any?
      goal_path(current_user.goals.first)
    else
      new_goal_path
    end
  end
end
