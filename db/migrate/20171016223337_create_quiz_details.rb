class CreateQuizDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :quiz_details do |t|
      t.integer :quiz_id, index: true
      t.integer :question_id, index: true
      t.integer :answer_id, index: true
      t.boolean :is_correct, default: false

      t.timestamps
    end
  end
end
