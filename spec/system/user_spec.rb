require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'Login処理' do
    before do
      Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:line]
    end
    context 'LINEログインボタンを押した場合' do
      it 'ログインができる' do
        visit root_path
        click_on 'line_login'
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content '冷え性を改善するための目標を設定しましょう！'
      end
    end
  end

  describe 'Logout処理' do
    context 'ログアウトボタンを押した場合' do
      it 'ログアウトができる' do
        line_login
        find('.navbar .nav-link', text: 'メニュー').click
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content '健康な毎日は冷え改善から。'
        expect(current_path).to eq root_path
      end
    end
  end
end
