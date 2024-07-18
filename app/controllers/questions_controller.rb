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

    @cold_symptom_new = ColdSymptom.new(
    user_id: current_user&.id || nil,
    symptom_type: @diagnosis,
    symptom_title: @cold_symptom.symptom_title,
    symptom_body: @cold_symptom.symptom_body,
    solution: @cold_symptom.solution,
    image_url: @cold_symptom.image_url,
    )

  if @cold_symptom_new.save
    Rails.logger.info "ColdSymptom saved successfully: #{@cold_symptom_new.inspect}"
  else
    Rails.logger.error "Failed to save ColdSymptom: #{@cold_symptom_new.errors.full_messages.join(', ')}"
    Rails.logger.error "ColdSymptom object: #{@cold_symptom_new.inspect}"
    @cold_symptom_new.errors.details.each do |attribute, error_details|
      error_details.each do |error_detail|
        Rails.logger.error "Error on attribute #{attribute}: #{error_detail[:error]}"
      end
    end
  end

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
