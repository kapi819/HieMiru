module LoginSupport
  def line_login
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]

    visit root_path
    click_on 'line_login'
  end
end
 
RSpec.configure do |config|
  config.include LoginSupport, type: :system
end
