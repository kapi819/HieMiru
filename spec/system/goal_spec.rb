require 'rails_helper'

RSpec.describe "Goals", type: :system do
  describe '目標設定' do
    context '目標を設定した場合' do
      before do
        line_login
        user = User.last
        create(:cold_symptom, :type_0, user: user)
      end
      it '設定した目標が記録画面に表示される' do
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
        expect(page).to have_content 'ジムに行く'
        expect(current_path).to eq goal_path(Goal.last)
      end
    end
    context '目標を設定しなかった場合' do
      before do
        line_login
        user = User.last
        create(:cold_symptom, :type_0, user: user)
      end
      it '新規作成の画面が表示される' do
        click_on '登録'
        expect(current_path).to eq new_goal_path
      end
    end
  end

  describe '目標記録' do
    context '設定した目標を記録した場合' do
      before do
        line_login
        user = User.last
        create(:cold_symptom, :type_0, user: user)
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
      end
      it '設定した目標が記録画面に表示される' do
        click_on '今日の記録'
        expect(page).to have_content '最初の一歩を踏み出しましたね！この調子で頑張りましょう！'
      end
    end
    context '記録を同日に２度押した場合' do
      before do
        line_login
        user = User.last
        create(:cold_symptom, :type_0, user: user)
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
      end
      it '今日はすでに記録されていると画面に表示される' do
        click_on '今日の記録'
        click_on '今日の記録'
        expect(page).to have_content '今日はすでに記録されています。'
      end
    end
  end

  describe '目標編集' do
    context '設定した目標を編集した場合' do
      before do
        line_login
        user = User.last
        create(:cold_symptom, :type_0, user: user)
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
      end
      it '設定した目標が編集時の画面に表示される' do
        click_on '変更'
        expect(page).to have_content 'ジムに行く'
      end
    end
  end
end