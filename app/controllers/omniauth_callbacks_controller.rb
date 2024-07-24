# frozen_string_literal: true

# OmniauthCallbacksController handles the callback phase of OmniAuth.
# It processes the authentication data from OmniAuth and performs actions
# like signing in or creating a new user.

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line = basic_action

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth['provider'], uid: @omniauth['uid'])
      if @profile.email.blank?
        email = @omniauth['info']['email'] || "#{@omniauth['uid']}-#{@omniauth['provider']}@example.com"
        @profile = current_user || User.create!(provider: @omniauth['provider'], uid: @omniauth['uid'], email:,
                                                name: @omniauth['info']['name'], password: Devise.friendly_token[0, 20])
      end
      @profile.update_from_omniauth(@omniauth)
      sign_in(:user, @profile)
    end
    @profile.update_from_omniauth(@omniauth)
    sign_in(:user, @profile)
    after_login
  end

  def after_login
    if current_user.goals.present?
      redirect_to goal_path(current_user.goals.first), success: t('omniauth_callbacks.after_login.success')
    else
      redirect_to new_goal_path, success: t('omniauth_callbacks.after_login.success')
    end
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
