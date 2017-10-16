class CreateQuizQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :quiz_questions do |t|
      t.integer :quiz_id, :index => true
      t.integer :question_id, :index => true

      t.timestamps
    end
  end
end
