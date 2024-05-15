class ColdSymptom < ApplicationRecord
  belongs_to :user

  validates :symptom_title, presence: true
  validates :symptom_body, presence: true
  validates :solution, presence: true
  validates :image_url, presence: true
  validates :symptom_type, presence: true, numericality: { only_integer: true }
  enum question_type: { "末端冷え性": 0, "下半身冷え性": 1, "内臓冷え性": 2, "全身冷え性": 3 }
end
