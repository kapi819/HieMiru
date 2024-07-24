require 'rails_helper'

RSpec.describe 'Questions', :js, type: :system do
  describe '診断結果' do
    let(:user_a) { create(:user) }

    before do
      create(:cold_symptom, :type_0, user: user_a)
      create(:cold_symptom, :type_1, user: user_a)
      create(:cold_symptom, :type_2, user: user_a)
      create(:cold_symptom, :type_3, user: user_a)
    end

    context 'when A is selected the most' do
      before do
        create_questions_and_choices
        line_login
        find('.navbar .nav-link', text: '冷え性診断').click
        click_on 'start-questions'
      end

      it '末端冷え性が表示される' do
        answer_with_a_most
        find('label', text: '36.2℃より高い').click
        click_on '結果'
        expect(page).to have_content '手足の末端が冷える典型的なタイプの冷え性'
      end
    end

    context 'when no option is selected' do
      before do
        create_questions_and_choices
        line_login
        find('.navbar .nav-link', text: '冷え性診断').click
        click_on 'start-questions'
      end

      it '選択して下さいと表示される' do
        click_on '次へ'
        expect(page).to have_content '選択してください'
      end
    end
  end

  def answer_with_a_most
    answer_question('手と足が冷える')
    answer_question('汗はあまりかかない')
    answer_question('少なめだと思う')
    answer_question('手足の指先')
    answer_question('頭痛や不眠')
  end

  def answer_question(text)
    find('label', text:).click
    click_on '次へ'
  end
end
