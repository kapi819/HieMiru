class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question_title, null: false
      t.string :question_body, null: false

      t.timestamps
    end
  end
end
