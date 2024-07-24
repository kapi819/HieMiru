require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Login処理' do
    before do
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:line]
    end

    context 'when the LINE login button is clicked' do
      it 'ログインができる' do
        visit root_path
        click_on 'line_login'
        expect(page).to have_content 'ログインしました'
      end
    end
  end

  describe 'Logout処理' do
    context 'when the LINE logout button is clicked' do
      it 'ログアウトができる' do
        line_login
        find('.navbar .nav-link', text: 'メニュー').click
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
