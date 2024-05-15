class CreateColdSymptoms < ActiveRecord::Migration[7.1]
  def change
    create_table :cold_symptoms do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :symptom_type, null: false
      t.string :symptom_title, null: false
      t.text :symptom_body, null: false
      t.string :solution, null: false
      t.string :image_url, null: false

      t.timestamps
    end
  end
end
