class CreateGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cold_symptom, null: false, foreign_key: true
      t.text :goal_body, null: false
      t.datetime :count, null: false

      t.timestamps
    end
  end
end
