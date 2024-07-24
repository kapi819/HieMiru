require 'rails_helper'

RSpec.describe 'Goals', type: :system do
  let(:user) { User.last }

  before do
    line_login
    create(:cold_symptom, :type_0, user:)
  end

  describe '目標設定' do
    context 'when a goal is set' do
      it '設定した目標が記録画面に表示される' do
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
        expect(page).to have_content 'ジムに行く'
      end

      it '目標を作成しましたと表示される' do
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
        click_on '登録'
        expect(page).to have_content '目標を作成しました'
      end
    end

    context 'when a goal is not set' do
      it '目標の作成に失敗しましたと表示される' do
        click_on '登録'
        expect(page).to have_content '目標の作成に失敗しました'
      end
    end
  end

  describe '目標編集' do
    before do
      fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ジムに行く'
      click_on '登録'
    end

    context 'when an existing goal is edited' do
      it '設定した目標が編集時の画面に表示される' do
        click_on '変更'
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ランニングをする'
        click_on '登録'
        expect(page).to have_content 'ランニングをする'
      end

      it '目標を更新しましたと表示される' do
        click_on '変更'
        fill_in '冷え性を改善するための目標を設定しましょう！', with: 'ランニングをする'
        click_on '登録'
        expect(page).to have_content '目標を更新しました'
      end
    end
  end
end
