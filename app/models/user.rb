class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]
  
  has_many :answers
  has_many :questions, through: :answers
  has_many :choices, through: :answers
  
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    self.save!
  end

  def diagnose
    a_count = answers.joins(:choice).where(choices: { question_type: 0 }).count
    b_count = answers.joins(:choice).where(choices: { question_type: 1 }).count
    c_count = answers.joins(:choice).where(choices: { question_type: 2 }).count

    diagnosis = if a_count >= b_count && a_count >= c_count
                  ColdSymptom.symptom_types[:peripheral]
                elsif b_count >= a_count && b_count >= c_count
                  ColdSymptom.symptom_types[:lower]
                elsif c_count >= a_count && c_count >= b_count
                  ColdSymptom.symptom_types[:internal]
                else
                  ColdSymptom.symptom_types[:systemic]
                end
    
    if a_count >= 3 && answers.joins(:choice).where(choices: { question_body: "36.2℃より高い" }).exists?
      diagnosis = "全身冷え性"
    end

    diagnosis
  end
end
