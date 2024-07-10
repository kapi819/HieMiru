module QuestionSetup
  def create_questions_and_choices
    question_1 = create(:question, :question_1)
    create(:choice, :choice_1_1, question: question_1)
    create(:choice, :choice_1_2, question: question_1)
    create(:choice, :choice_1_3, question: question_1)

    question_2 = create(:question, :question_2)
    create(:choice, :choice_2_1, question: question_2)
    create(:choice, :choice_2_2, question: question_2)
    create(:choice, :choice_2_3, question: question_2)

    question_3 = create(:question, :question_3)
    create(:choice, :choice_3_1, question: question_3)
    create(:choice, :choice_3_2, question: question_3)
    create(:choice, :choice_3_3, question: question_3)

    question_4 = create(:question, :question_4)
    create(:choice, :choice_4_1, question: question_4)
    create(:choice, :choice_4_2, question: question_4)
    create(:choice, :choice_4_3, question: question_4)

    question_5 = create(:question, :question_5)
    create(:choice, :choice_5_1, question: question_5)
    create(:choice, :choice_5_2, question: question_5)
    create(:choice, :choice_5_3, question: question_5)

    question_6 = create(:question, :question_6)
    create(:choice, :choice_6_1, question: question_6)
    create(:choice, :choice_6_2, question: question_6)
  end
end

RSpec.configure do |config|
  config.include QuestionSetup, type: :system
end
