class ColdSymptom < ApplicationRecord
  belongs_to :user

  validates :symptom_title, presence: true
  validates :symptom_body, presence: true
  validates :solution, presence: true
  validates :image_url, presence: true
  validates :symptom_type, presence: true, numericality: { only_integer: true }
  enum symptom_type: { peripheral: 0, lower: 1, internal: 2, systemic: 3 }
end
