class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line; basic_action end

  private
  def basic_action
    @omniauth = request.env["omniauth.auth"]
    if @omniauth.present?
      @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
      if @profile.email.blank?
        email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
        @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
      end
      @profile.set_values(@omniauth)
      sign_in(:user, @profile)
    end
    @profile.set_values(@omniauth)
    sign_in(:user, @profile)
    flash[:notice] = "ログインしました"
    after_login
  end

  def after_login
    Rails.logger.debug "Entering after_login method"
    puts "Entering after_login method" # デバッグ用のputsを追加
    if current_user.goals.any?
      redirect_to goal_path(current_user.goals.first)
    else
      redirect_to new_goal_path
    end
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
