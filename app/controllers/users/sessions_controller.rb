# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  after_action :transfer_session_data, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  def transfer_session_data
    if session[:answers] && current_user
      session[:answers].each do |question_id, choice_id|
        Answer.create(user_id: current_user.id,question_id: question_id,choice_id: choice_id)
      end
    session.delete(:answers)
    end
  end
end
