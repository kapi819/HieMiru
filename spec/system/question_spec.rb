require 'rails_helper'

RSpec.describe 'Questions', type: :system, js: true do
  describe '診断結果' do
    let(:user_a) { create(:user) }

    before do
      create(:cold_symptom, :type_0, user: user_a)
      create(:cold_symptom, :type_1, user: user_a)
      create(:cold_symptom, :type_2, user: user_a)
      create(:cold_symptom, :type_3, user: user_a)
    end

    context 'Aを一番多く選択した場合' do
      before do
        create_questions_and_choices
      end

      it '末端冷え性が表示される' do
        line_login
        find('.navbar .nav-link', text: '冷え性診断').click
        click_on 'start-questions'
        find('label', text: '手と足が冷える').click
        click_on '次へ'
        find('label', text: '汗はあまりかかない').click
        click_on '次へ'
        find('label', text: '少なめだと思う').click
        click_on '次へ'
        find('label', text: '手足の指先').click
        click_on '次へ'
        find('label', text: '頭痛や不眠').click
        click_on '次へ'
        find('label', text: '36.2℃より高い').click
        click_on '結果'
        expect(page).to have_content '手足の末端が冷える典型的なタイプの冷え性'
        expect(current_path).to eq result_questions_path
      end
    end

    context '選択をしない場合' do
      before do
        create_questions_and_choices
      end

      it '選択して下さいと表示される' do
        line_login
        find('.navbar .nav-link', text: '冷え性診断').click
        click_on 'start-questions'
        click_on '次へ'
        expect(page).to have_content '選択してください'
      end
    end
  end
end
