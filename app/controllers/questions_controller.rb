# frozen_string_literal: true

# QuestionsController handles actions related to the Question model.
# It allows users to create, update, show, and delete questions.
# Additionally, it manages the listing of questions.

class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @questions = Question.all
  end

  def create
    answers = answers_params
    if current_user
      save_answers_to_db(current_user, answers)
      session.delete(:answers)
    else
      session[:answers] = answers
    end
    redirect_to result_questions_path
  end

  def result
    if current_user
      @diagnosis = current_user.diagnose
    else
      answers = session[:answers]
      if answers
        choice_ids = answers.values
        @diagnosis = User.diagnose_from_choice_ids(choice_ids)
      else
        redirect_to root_path, alert: '診断を最初からやり直してください。'
        return
      end
    end

    @cold_symptom = ColdSymptom.find_by(symptom_type: @diagnosis)
    reset_answers_and_clear_user_data(current_user)

    return if @cold_symptom

    redirect_to root_path, alert: '診断結果が見つかりません。最初からやり直してください。'
  end

  private

  def answers_params
    params.require(:answers).permit!.to_h
  end

  def save_answers_to_db(user, answers)
    answers.each do |question_id, choice_id|
      Answer.create(user_id: user.id, question_id:, choice_id:)
    end
  end

  def reset_answers_and_clear_user_data(user)
    user&.answers&.destroy_all
    session.delete(:answers)
  end
end
