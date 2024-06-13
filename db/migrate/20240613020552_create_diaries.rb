class CreateDiaries < ActiveRecord::Migration[7.1]
  def change
    create_table :diaries do |t|
      t.references :user, null: false, foreign_key: true
      t.float :body_temperature
      t.float :weight
      t.float :body_fat
      t.string :physical_condition
      t.string :mental_condition
      t.datetime :start_time

      t.timestamps
    end
  end
end
