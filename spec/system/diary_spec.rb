require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  describe '体調の分析' do
    context 'when an analysis is recorded' do
      before do
        line_login
        User.last
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
      end

      it '記録した顔文字がカレンダーに表示される' do
        find('.navbar .nav-link', text: '分析').click
        expect(page).to have_css('.fa.fa-smile-o')
      end
    end
  end
end
