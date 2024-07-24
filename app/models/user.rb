# frozen_string_literal: true

# User represents a user in the application.
# Each user can have many goals, answers, and other related models.
# Devise is used for authentication.

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  has_many :answers, dependent: :destroy
  has_many :questions, through: :answers
  has_many :choices, through: :answers
  has_many :goals, dependent: :destroy
  has_many :cold_symptoms, dependent: :destroy
  has_many :diaries, dependent: :destroy

  def social_profile(provider)
    social_profiles.find { |sp| sp.provider == provider.to_s }
  end

  def update_from_omniauth(omniauth)
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']

    credentials = omniauth['credentials']
    info = omniauth['info']

    credentials['refresh_token']
    credentials['secret']
    credentials.to_json
    info['name']
  end

  def update_from_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    save!
  end

  def diagnose
    choice_ids = answers.pluck(:choice_id)
    self.class.diagnose_from_choice_ids(choice_ids)
  end

  def self.diagnose_from_choice_ids(choice_ids)
    choices = Choice.where(id: choice_ids).pluck(:id, :question_type, :question_body)
    Rails.logger.debug { "Choices: #{choices.inspect}" }

    a_count = choices.count { |choice| choice[1] == 'A' }
    b_count = choices.count { |choice| choice[1] == 'B' }
    c_count = choices.count { |choice| choice[1] == 'C' }
    d_count = choices.count { |choice| choice[2] == '36.2℃以下' }

    Rails.logger.debug { "A Count: #{a_count}, B Count: #{b_count}, C Count: #{c_count}, D Count: #{d_count}" }

    if a_count > b_count && a_count > c_count
      d_count.positive? ? ColdSymptom.symptom_types[:systemic] : ColdSymptom.symptom_types[:peripheral]
    elsif b_count > a_count && b_count > c_count
      ColdSymptom.symptom_types[:internal]
    elsif c_count > a_count && c_count > b_count
      ColdSymptom.symptom_types[:lower]
    else
      ColdSymptom.symptom_types[:systemic]
    end
  end
end
