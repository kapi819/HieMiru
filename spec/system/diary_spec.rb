require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  describe '体調の分析' do
    context '分析を記録した場合' do
      before do
        line_login
        user = User.last
        visit new_diary_path
        fill_in '体温 (°C)', with: '36'
        fill_in '体重 (Kg)', with: '50'
        fill_in '体脂肪 (%)', with: '30'
        find('.physical-condition-options .fa.fa-smile-o').click
        find('.mental-condition-options .fa.fa-meh-o').click
        click_on '登録'
      end
      it '記録詳細画面に表示される' do
        expect(page).to have_content '本日の記録を作成しました'
        expect(current_path).to eq diary_path(Diary.last)
      end
      it '本日の記録は既に作成されていると表示される' do
        find('.navbar .nav-link', text: '分析').click
        expect(page).to have_content '本日の記録を作成しました'
        expect(page).to have_content '本日の記録は既に作成されています'
        expect(current_path).to eq diaries_path
      end
      it '記録した顔文字がカレンダーに表示される' do
        find('.navbar .nav-link', text: '分析').click
        expect(page).to have_css('.fa.fa-smile-o')
        expect(page).to have_css('.fa.fa-meh-o')
        expect(current_path).to eq diaries_path
      end
    end
  end
end
