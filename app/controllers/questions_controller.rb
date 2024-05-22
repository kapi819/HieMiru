class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def create
    answers = answers_params
    if current_user
      save_answers_to_db(current_user, answers)
      session.delete(:answers)
      redirect_to result_questions_path
    else
      session[:answers] = answers
      redirect_to result_questions_path
    end
  end

  def result
    if current_user
      @diagnosis = current_user.diagnose
    else
      answers = session[:answers]
      if answers
        @diagnosis = diagnose_from_answers(answers)
      else
        redirect_to root_path, alert: '診断を最初からやり直してください。'
      end
    end

    @cold_symptom = ColdSymptom.find_by(symptom_type: @diagnosis)
    unless @cold_symptom
      redirect_to root_path, alert: '診断結果が見つかりません。最初からやり直してください。'
    end
  end

  private

  def answers_params
    params.require(:answers).permit!.to_h
  end

  def diagnose_from_answers(answers)
    a_count = answers.values.count { |choice_id| Choice.find(choice_id).question_type == "A" }
    b_count = answers.values.count { |choice_id| Choice.find(choice_id).question_type == "B" }
    c_count = answers.values.count { |choice_id| Choice.find(choice_id).question_type == "C" }

    if a_count >= 3 && answers.values.any? { |choice_id| Choice.find(choice_id).question_body == "36.2℃以下" }
      ColdSymptom.symptom_types[:systemic]
    else
      diagnosis = if a_count >= b_count && a_count >= c_count
                    ColdSymptom.symptom_types[:peripheral]
                  elsif b_count >= a_count && b_count >= c_count
                    ColdSymptom.symptom_types[:lower]
                  elsif c_count >= a_count && c_count >= b_count
                    ColdSymptom.symptom_types[:internal]
                  else
                    ColdSymptom.symptom_types[:systemic]
                  end
    end
    diagnosis
    
  end

  def save_answers_to_db(user, answers)
    answers.each do |question_id, choice_id|
      Answer.create(user_id: user.id, question_id: question_id, choice_id: choice_id)
    end
  end
end
