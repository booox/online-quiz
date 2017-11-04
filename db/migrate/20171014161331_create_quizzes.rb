class CreateQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes do |t|
      t.string :title
      t.integer :category_id, index: true
      # t.text :type_ids
      # t.text :question_ids
      t.integer :question_count

      t.timestamps
    end
  end
end
