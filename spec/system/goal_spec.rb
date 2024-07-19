require 'rails_helper'

RSpec.describe 'Goals', type: :system do
  let(:user) { User.last }

  before do
    line_login
    create(:cold_symptom, :type_0, user: user)
  end

  describe '目標設定' do
    context '目標を設定した場合' do
      it '設定した目標が記録画面に表示される' do
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
        expect(page).to have_content 'ジムに行く'
        expect(page).to have_content '目標を作成しました'
        expect(current_path).to eq goal_path(Goal.last)
      end
    end

    context '目標を設定しなかった場合' do
      it '新規作成の画面が表示される' do
        click_on '登録'
        expect(page).to have_content '目標の作成に失敗しました'
        expect(current_path).to eq new_goal_path
      end
    end
  end

  describe '目標編集' do
    before do
      fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
      click_on '登録'
    end

    context '設定した目標を編集した場合' do
      it '設定した目標が編集時の画面に表示される' do
        click_on '変更'
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ランニングをする'
        click_on '登録'
        expect(page).to have_content '目標を更新しました'
        expect(page).to have_content 'ランニングをする'
      end
    end
  end
end
